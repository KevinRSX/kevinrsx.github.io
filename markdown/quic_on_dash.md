---
title: Quic on DASH
---



# QUIC on DASH

*Date of creation: 2019-10-28*



This post illustrates the idea of streaming MPEG-DASH videos over QUIC. It requires basic understanding of network protocols and adaptive bitrate streaming.



## Introduction

QUIC, Quick UDP Internet Connection, is a transport protocol recently [developed by Google](https://www.chromium.org/quic) and [standardized by IETF](https://tools.ietf.org/html/draft-ietf-quic-http-23). This protocol is established over UDP and it integrates TLS. HTTP/3, the application layer protocol of next generation, will use QUIC as its underlying transport layer protocol.

DASH is an HTTP-based adaptive bitrate streaming (ABR) implementation. MPEG is a video codec that uses a `manifest.mpd` file to store the location of chunks of different bitrates.

Streaming MPEG-DASH videos over QUIC is an important testbed for many measurements. For example, efficiency of video streaming over QUIC and performance of any specific part in QUIC protocol stack with video streaming as the application.



## System Design Choice

### Client

We use [dash.js] (https://github.com/Dash-Industry-Forum/dash.js/wiki) as the client of this test. `dash.js` is a Javascript implementation of MPEG-DASH. It implements different ABR algorithms that requests video chunks of different bitrates based on information such as throughput and buffer size. An interface of video player is provided by `dash.js`  to faciliate video streaming.

`dash.js` can be easily used in html by adding a few tags and making a few function calls. To really make the request (calling `dash.js`'s ABR algorithm), we need google chrome, which supports QUIC and is able to call Javascript functions. In summary, we use chrome to request `index.html` that uses the functions of `dash.js`.



### Server

Requirements of server are much simpler:

- Server needs to support QUIC whose version is compatible with latest google chrome's QUIC's version
- Server should serve a folder that has `index.html` and Javscript files of `dash.js` mentioned in last section

Our choice is the [toy quic server](https://www.chromium.org/quic/playing-with-quic) provided by chromium project.



## Server's Setup

*Note: All the following tests are performed on Ubuntu 18.04*

### Running Examples

1. [Checkout the chromium source](https://www.chromium.org/developers/how-tos/get-the-code)

2. Follow the steps in [playing with quic](https://www.chromium.org/quic/playing-with-quic) to test whether your toy client and server work fine. Note that you should generate certificates after preparing test data. Since this is QUIC requires a root CA certificate, use the following command to trust the generated certificate. If you encounter any certificate problem, add `--disable_certificate_verification` flag on client side.

   ```bash
   certutil -d sql:$HOME/.pki/nssdb -A -t "C,," -n <certificate nickname> \ 
   -i <certificate filename>
   ```



### Importance of Having Correct Headers

The above steps are just tests for whether `quic_server` is good enough for our server. We will gradually change the content to be served to our files. One important thing is that `quic_server` is actually a proxy server. This means the server requires some elements to be cached in each files, otherwise it cannot process the files properly. In our case it should be the HTTP headers. In the example of using `www.example.org`, the headers are:

```
HTTP/1.1 200 OK
Accept-Ranges: bytes
Cache-Control: max-age=604800
Content-Type: text/html; charset=UTF-8
Date: Mon, 28 Oct 2019 08:33:19 GMT
Etag: "3147526947"
Expires: Mon, 04 Nov 2019 08:33:19 GMT
Last-Modified: Thu, 17 Oct 2019 07:18:26 GMT
Server: ECS (oxr/831E)
Vary: Accept-Encoding
X-Cache: HIT
X-Original-Url: https://www.example.org/
Content-Length: 1256
```

We must add `X-Original-Url` to match with clients request:

```bash
./out/Debug/quic_client --host=127.0.0.1 --port=6121 https://www.example.org/
```

Server identifies this request, match the file that has `X-Original-Url` of the same name, and returns corresponding files.



### Generate Headers

At this point, we know that all videos, `index.html`,  `dash.js`, `manifest.mpd` and all video files should be associate with appropriate headers. We can arrange our folder to be served, say `www.quictest.com` like this:

```
www.quictest.com/
|----index.html
|----dash.all.min.js
|----video/
     |----Manifest.mpd
     |----video1/
     |----video2/
     |----video3/
     |----video4/
     |----video5/
     |----video6/
```

To associate headers to files, we need to actually serve it with other web server (could be without QUIC support but does not `X-Original-Url`) first. Here we choose [Caddy web server](https://caddyserver.com/v1/). After serving the same folder, we can write a script to download all the files in the folder and add `X-Original-Url` to them.



### Using the Server

As soon as the headers are correct, we can fire up the server:

```
./out/Debug/quic_server \
  --quic_response_cache_dir=/tmp/quic-data/www.quictest.com \
  --certificate_file=net/tools/quic/certs/out/leaf_cert.pem \
  --key_file=net/tools/quic/certs/out/leaf_cert.pkcs8
```

Note that here the name of `quic_response_cache_dir` is `www.quictest.com`. You need to let the browser trust this host name. Therefore, before using the server, you should re-generate the certificate by adding

```
DNS.4 = www.quictest.com
```

to `[other_hosts]` section in `net/tools/quic/certs/leaf.cnf`. To have a clearer look at how the server is running, use `--v=1` at server side to enable verbose.



## Client's Setup

Actually you only need to open google chrome to let client work. First close the current google chrome browser you are running, then

```bash
google-chrome-stable \
  --no-proxy-server \
  --enable-quic \
  --origin-to-force-quic-on=www.quictest.com:443 \
  --host-resolver-rules='MAP www.quictest.com:443 127.0.0.1:6121' \
  https://www.quictest.com
```

Note that these flags map every request to `www.quictest.com:443` to your `quic_server`.



## References

- [Playing with quic](https://www.chromium.org/quic/playing-with-quic)
- [Linux certificate management](https://chromium.googlesource.com/chromium/src/+/master/docs/linux_cert_management.md)
- [Streaming via quic](https://groups.google.com/a/chromium.org/forum/#!topic/proto-quic/2nyLYC6JTBo)
- [Get the Code: Checkout, Build, & Run Chromium](https://www.chromium.org/developers/how-tos/get-the-code)
- The documentation of more specific process of getting the whole thing done by Yuhao. Currently in a private repository
- Yuhao's efficient script