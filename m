Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CF3368D45
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 03:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786419430; cv=pass; b=QW3po2kiZ2uBYGIaoJxn0XwsQKgy1wECC4eJqZCio3E7ZC3IcAG+84+RrEnFoDqMEaj8h4cmBJCEpGFMv7jrUlM6rYNGmh8yftLU+8QnofH2gdMgAZngWhSd98FweDJDiYhUjYlY7QQNQCmqMC7fi+jtBglmxbMSpWtf+1aJWWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786419430; c=relaxed/simple;
	bh=h7ERLeSsm63NpAkva3LUfyOhZMDa714TtANVGouyQCA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=FzvG/NpU56FUHaEb3nVvNp221vvIzmFd1Z+vPX7LoEA3Ptp3GiS8kUMLc4uLWTcn4WEYq9nWOAWIp3slxRoF6QK0FbXbX3dQqB1TZ8e/pnnHxJIl/gdrMAXKnuVHBTiDVStYVLImGJjNb0RybhXHdHr2+6nE60EBzB9DM6270K0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tIFjvkXS; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tIFjvkXS"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6688dfaed31so4059563d50.3
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 20:37:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786419427; cv=none;
        d=google.com; s=arc-20260327;
        b=gzbTgVkNDlE4avwFZ5bzgFjbprzyBQ3vmrVGLeqe6zbtLy28VABPGozx++Z8zviKBD
         WyzoiWtZ5JlFmIZls+Bl/ErgKfhaplyfA5ZoRRV9zW6tBiThYj/sxN40M3w8DYEap3bd
         gftkRFpT7m1dW6ZrAufTJ/N5xsirbablohXFMd87TasBi8cstq+1uZJbld1szZD8Pfl+
         l+ge4c5BGvqb2LimOf0LCkEFgSHGHhj7AlDipzotY8/xjcXQKpN69uBZRb71wyqHX8I/
         H+e9wR3ogff1K4cV5GEJfcxWEG2cSmIeYUPNbAg7VrpkGMIY7MwZ9DLy3EfuBZfALIto
         +JnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=ZnL4Vz4XyDBv6/wX4o2LTm4p1gW6ZuiqBp9YAgRdnNQ=;
        fh=OFfuHn60GZdbwDk5co9H2dehCDD/bvnYImljv8nl61I=;
        b=OxitVrh9R+VaF/xwYc8WGwo3s+1CVw2yTuRtJAHTj7r53BtHUR97so4pQSQ5u4/WdF
         1xjZxw1x+wvrt7JSGWOt0mNgpcsSSi1SLCAqoiglM6+DKINdtTAvVvIe1lCC2JKE2Q/P
         uzI619ej7PshhQuJF7MD8s/UXiSWxhNk9Z2abIUJ4zhibv0cn+TgQZv2Bh/rU5uMbE5U
         XGzTnWp9Z13aLTmOtUBVUzhKP3ctSapsvHWQKUw4HoUZ5owPfYiMY04mVE4bPGaenr4l
         raArOXDshWdBPchSg8Z0/8w/NSiScpX723cbDYO/BAaZlW+PTD9U562wzyf2HIgvxsxa
         G7gQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786419427; x=1787024227; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZnL4Vz4XyDBv6/wX4o2LTm4p1gW6ZuiqBp9YAgRdnNQ=;
        b=tIFjvkXS75TMPj0qvk2DFdYskEEgyh+KWm6wI+cafhqgvdw8wD2bEwJtqWw0xtiOQR
         tVsD22pcMxgj+GREMy745TLPKcQ3T53OP0P654XLQHHTNoiQUmA6ZAFmEofWZiYMIwga
         Fmpa7hVZvo2XKnrbsVoP0iwqhwocxQokhFN27K96ZOC0Ew17hXSWnK/0uEGKfpol6KVO
         O8WuFdHGbGx79MVAXVVDNJWorzag4gO1nvD30FpFB9IvCdJj/vNspou978ulFK4ssS59
         d6+McnYFfCAAYLpWYqFKlFq957huZN5qQchCEPfUZaNA6UmFEvEcGM4r9RdH9lru6D9A
         EC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786419427; x=1787024227;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZnL4Vz4XyDBv6/wX4o2LTm4p1gW6ZuiqBp9YAgRdnNQ=;
        b=OoAeGnVRg6pMQYJTILdl3EJigC+uX1a2fNtQhsOS6p0Qy+9ZTWn+jVFmmWDWvvhkmx
         FL51f6Fqq2A5uMP1d5JNIlQeaPMO3x9FDMpne3g9ZOlHWk+GUGcDOhUe9t+hhgJ57HQC
         lkVIGW4C3bsIfI935hpqKylBfr3Ij01PrbOdn9fHPKFDpQvN4Be3GOtjCL2luYuI9BEX
         fAC/0rmTpnldg2g+au5Oo+bV7XuMbhsy8T14JOyi4hNp5ggeHNPTQ1IygdIPVnknp/6H
         2PCXDc8ZyntR2vRKB1AsyCRaDQtpCpby/tVqz489octfzfv9BCkBfhB4a1l2knmeZxXv
         rfRg==
X-Forwarded-Encrypted: i=1; AHgh+RqLb1IpkhyVNyN6c+GLopPyIeb57eEiMF3e49FRoC0Dq0HHlpPvTg52Vc/TGoTPBYk7OCmTYj8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy37r4mlRgAZCvmoEJgVMNEXwHn/keIAPVib4DUGouc/0zasoaQ
	qtVzz/I3aDskXkKnbu3fKsz0kZeBzNoANa5JAPYZrUY6mkuKl8DPaap0mZvJLYNB8ls7nHSSRNB
	ymfU5KlrWP3qjYuiO862w8Mxmq8+TS/k=
X-Gm-Gg: AR+sD115DjgYF4zbo49Sx4Qvr4BIjMOSCUZBjKBnWCJlZLnBvRTkQ6dan/64QJj1FSR
	m44c2afPNJZF/TuLB3upnbrhMyg5vP304Q1GFNjSFjzdbN2agbK2LKJtQLuWcx/ghr8QkPYp37D
	ICikhzN+/E0mtAaiyqruHukuaGFI+uuKWTt9mor0dSUaniMM49zO7P2nQnFbX9OPK/HplOReOaQ
	0+3i0s9FOzbswGkPw4Q1PraAq3P6T089A7a5LmK+KI8vTIqW162y3/f/ZOTn/SyONO/ufL7FWGq
	bLpB/khh27Hqz4gqRiOJ3Ce6P7uBn9mj6CG7WGPw7oaN09tPsa+sHv5mWOTJz+ZEJvOLQLeXCd/
	WHo0ibAUatJMNNheQ8tXoAI8rNyuR2BYjSkjT/Sw6cxyjmHeR1jM3ZWhrIVAmSfV8L7gXwcek69
	/fRRaIhPj7qfg2
X-Received: by 2002:a05:690e:4292:20b0:666:39a8:fb82 with SMTP id
 956f58d0204a3-66b22d9f964mr102664d50.14.1786419427395; Mon, 10 Aug 2026
 20:37:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jason Colapietro <jasoncola1@gmail.com>
Date: Mon, 10 Aug 2026 23:36:56 -0400
X-Gm-Features: AUfX_mzF21M26wbAtf2AnhCVFZnA26kG-PD1qMX1SfK5ylkY4TSVFQwLsLDopRk
Message-ID: <CA+Z0x2J-kxsCBJbDP0DbfEHYQxz_Zg_YAHA8t8nrFM7aNnytSQ@mail.gmail.com>
Subject: [PATCH v2] usbip: make remote list honor parsable output
To: Valentina Manea <valentina.manea.m@gmail.com>, Shuah Khan <shuah@kernel.org>
Cc: Hongren Zheng <i@zenithal.me>, Greg KH <greg@kroah.com>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The -p option only affects local devices and gadgets. Remote lists still
print their human-readable headings and details, so scripts cannot parse
them using the documented option.

Pass the parsable flag through the remote listing path. Emit the same busid
and usbid record used for local devices while continuing to consume every
interface record from the server.

Fixes: e9837bbb3e69 ("staging: usbip: userspace tools v1.0.0")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219502
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5
Signed-off-by: Jason Colapietro <jasoncola1@gmail.com>
---
Changes in v2:
- Make the email From header match Signed-off-by.
- Add Cc: stable@vger.kernel.org.

 tools/usb/usbip/src/usbip_list.c | 33 ++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/tools/usb/usbip/src/usbip_list.c b/tools/usb/usbip/src/usbip_list.c
index 3d810bcca02..b9d60b87e47 100644
--- a/tools/usb/usbip/src/usbip_list.c
+++ b/tools/usb/usbip/src/usbip_list.c
@@ -41,7 +41,7 @@ void usbip_list_usage(void)
        printf("usage: %s", usbip_list_usage_string);
 }

-static int get_exported_devices(char *host, int sockfd)
+static int get_exported_devices(char *host, int sockfd, bool parsable)
 {
        char product_name[100];
        char class_name[100];
@@ -80,9 +80,11 @@ static int get_exported_devices(char *host, int sockfd)
                return 0;
        }

-       printf("Exportable USB devices\n");
-       printf("======================\n");
-       printf(" - %s\n", host);
+       if (!parsable) {
+               printf("Exportable USB devices\n");
+               printf("======================\n");
+               printf(" - %s\n", host);
+       }

        for (i = 0; i < reply.ndev; i++) {
                memset(&udev, 0, sizeof(udev));
@@ -98,9 +100,14 @@ static int get_exported_devices(char *host, int sockfd)
                usbip_names_get_class(class_name, sizeof(class_name),
                                      udev.bDeviceClass, udev.bDeviceSubClass,
                                      udev.bDeviceProtocol);
-               printf("%11s: %s\n", udev.busid, product_name);
-               printf("%11s: %s\n", "", udev.path);
-               printf("%11s: %s\n", "", class_name);
+               if (parsable) {
+                       printf("busid=%s#usbid=%04x:%04x#\n", udev.busid,
+                              udev.idVendor, udev.idProduct);
+               } else {
+                       printf("%11s: %s\n", udev.busid, product_name);
+                       printf("%11s: %s\n", "", udev.path);
+                       printf("%11s: %s\n", "", class_name);
+               }

                for (j = 0; j < udev.bNumInterfaces; j++) {
                        rc = usbip_net_recv(sockfd, &uintf, sizeof(uintf));
@@ -116,16 +123,18 @@ static int get_exported_devices(char *host, int sockfd)
                                        uintf.bInterfaceClass,
                                        uintf.bInterfaceSubClass,
                                        uintf.bInterfaceProtocol);
-                       printf("%11s: %2d - %s\n", "", j, class_name);
+                       if (!parsable)
+                               printf("%11s: %2d - %s\n", "", j, class_name);
                }

-               printf("\n");
+               if (!parsable)
+                       printf("\n");
        }

        return 0;
 }

-static int list_exported_devices(char *host)
+static int list_exported_devices(char *host, bool parsable)
 {
        int rc;
        int sockfd;
@@ -138,7 +147,7 @@ static int list_exported_devices(char *host)
        }
        dbg("connected to %s:%s", host, usbip_port_string);

-       rc = get_exported_devices(host, sockfd);
+       rc = get_exported_devices(host, sockfd, parsable);
        if (rc < 0) {
                err("failed to get device list from %s", host);
                return -1;
@@ -351,7 +360,7 @@ int usbip_list(int argc, char *argv[])
                        parsable = true;
                        break;
                case 'r':
-                       ret = list_exported_devices(optarg);
+                       ret = list_exported_devices(optarg, parsable);
                        goto out;
                case 'l':
                        ret = list_devices(parsable);
--
2.50.1 (Apple Git-155)
