Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B2C353A86
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 03:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786419726; cv=pass; b=eL3U/Zusitp/s/VTMrHfZNbz3bmKG6/EBK0bo7NJiv8b9T2ieYMtPQCHHRT9LkumW2LwQ5imBTR189emjTZ+eo23jdas1O9InCgOTyGSv4N0bq7PMXTgtfw8UnO0tPi+fBzDMVJTS+OBiEiKUpsHVSoc2YI5+Oz0vZjI7JPZ+Pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786419726; c=relaxed/simple;
	bh=iZB2YHuqY/AHAU9asRRVXZpiAJUeAYjNTurWRgZq72A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=bs1U7lZ/c+MutCh2YS7cio4aoFdVBC9HlF/eHg+/9iq6JGQ5M5QO9398iZo8A9C1wS3q+Q/CDgSxsp4zTbvqY5sSTmImCOewuWYAr9wudVKVOVDZBittq3VPjjN/XeoAzwjpPfllTsAZRXex0mAOwVDT1o6Z6bMH2POcun/y5/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M56JBqCl; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M56JBqCl"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-667bae10ba3so2837442d50.2
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 20:42:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786419724; cv=none;
        d=google.com; s=arc-20260327;
        b=mHCQaKqCrvSIw9ctStgtGo6EtfrmdxHaMuPM81y0r+XlMD5Q5xUMElkVcM79a9As4x
         kBtpd60CLOIbowKoXmfkpAFIWiMssixUMvEiTUYbJqCzM8CzVQxw0EeAlhfjqR8OhPIe
         SXAy3VqXWdz0lCEJu3y2ETGWgjFo/QXVQFA66z+djzH8sBL64kfNvwYC9K3h3KAwtSqv
         MmICkv+hoddz+D1xFRJ30qthSmuHNAzHOtPkeE1P1ycHgD+7/pm5epaskQzCLkhrvPph
         Poq2hzdq7uA3RKeTfTT1HdVO0Ey77GFCyCJW1fM+UdtOlINxzn3gJJQR2StTTciN5vtx
         4RvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=ZnL4Vz4XyDBv6/wX4o2LTm4p1gW6ZuiqBp9YAgRdnNQ=;
        fh=ZnAgAua5lN0/V7IgngTKPRjNbjExllnP4T4k5qTQOx0=;
        b=p4ZOLywrXL1cizibWjivLefmUpx2lf2vsqLh66hqnpf0VccgjgtUX0IwCIceZJ5fht
         O6KRjJ8XU+CWP7q+CnvCrWGV87ad5Jjv1pfs2/UzOjlFpMmfp9t9Eg6ZGxLSgsO4SbkR
         b4hzCJZmh3U9HmgQGT5jMYGBmvp9plE22G19zoNZDoUVv56tflQuGdS4YALzg4oOQU0M
         4U5RQ8aGthhbCmYIrL7b8kyydpSCvFmjYtGS3byw3LAP3qfBgrjVVWiYeM4yS8J2sjx1
         2LagmjTp5UfBZ2bwAUCof8ms6I2Lx2e6YSLgWRublOK09MtihS5TRfEYy5/q2chW9LRf
         Gx5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786419724; x=1787024524; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZnL4Vz4XyDBv6/wX4o2LTm4p1gW6ZuiqBp9YAgRdnNQ=;
        b=M56JBqClpfVX3GWOT3FFC04i5IsT3GsTeyvnJpyEKRdXfyWLfuv/bbk6drpa9Syjbb
         ce5IlvO0yG6VLl4ZW/xvPIgrjkhhXmhzYKR6FGits4UhRsmUqp9J5d4pO07VNjNAyDRc
         feZZk5+p3wCKysocUrNJ/u8hfhEinler742J7H2bIEFQJAeOFqzmLOfHFDRXL12MHJJU
         VtjDkKlbDy7uF+B9r+MicQynM7QO0e32g0M73ttxLywukiIbfTl7/a7HWm47Irsto1gZ
         gK9BkQm1WEyb6+/hbgPE84qQanhVIlspbBERt4gn4AloKB3BwPyH65nCGl/9OKhx2m+3
         D5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786419724; x=1787024524;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZnL4Vz4XyDBv6/wX4o2LTm4p1gW6ZuiqBp9YAgRdnNQ=;
        b=aypad7MMOaHaYdY+/h5hui22MrvFyPrdBiAChdGY+oi0KmDezyq/FKP4xM1IqdsgzV
         xBkWMuFXWWqfPFbAClROH+XjSf6whMzDKSUXQmb1Yb7VNN6Jxq7eYQUqrHfOqnJquFrW
         /T6KMfLsgXVwvKpU4EKi6pa6CV30YYxeqY11rvKjVOZ4++1F1IWbxCufjwnLwUskQo8v
         HfpgzLUEqQ8UL8u/saPVgZ16dsIJbWEhfHHg87duT9ov8OvoKIeBakgOJMHKl4bL9jMg
         Teu9obTkQTRuv2+cayepXbi+sqWWpgasMh76hQ1jkrSiAE6UJk3YrMSaMnrUDBBrXSQZ
         KyLQ==
X-Forwarded-Encrypted: i=1; AHgh+RoRsLPZNwpDcYXi0GODRGJHy8ElhMO/f2pLPbZw4l+vikwRQAGtwt4grxhMtJWLO459IFkns8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YynqLRBnRLSNB67JbT7Hvip1n2QSjspmRe2Ki6bYuZJ+WMqxCGt
	b8puBjLgup1+nHowbxcVp+8W0wJhBjv8np8BTkQphgADikcYmBBYmx5UQrKGT8/80IgtD/44hnu
	JhvPds2dhPOAWXcniOVxt9X92aoQT3gA=
X-Gm-Gg: AR+sD13yV0NuU3CMMSvHWZp06dQ+ZYgpGQsrQDs9k4LUu+o1LfUFIPGCK2Jmz/pZyrb
	sLlZMCzFsOKASGBL+TdOV/h7g5MSkMdTfStcOGY0VrzJYstDOhG9Wx7p2571lG46i5uqAadi6q8
	73GScYVGSwH74KJGZJJMnYQWMO1w6wMk4T6xMu4AWIw6HAirhrlABvgcwuQU4tQKPtrNkGnC2sI
	8B6H34iwTh48wQ/L54MBZ5B+sc4UzBso2e9FmkIFFm0FWQiPtCGnrumfiqEXjmg/VyAPN6QO/3Y
	kCePPOg4zbiRHR7JS/YuhnhnRoeQoXnhKGd9zlJrfHWO50/IvIl1QPNjOnTlannSMFY5MnoynZo
	9m/tqAnLNCLl5cYTUKu2z3iwfc9o+fAJW9r3EwAbSAz3D3l0UDKjjAyIbsIAWY7GYGc/gJ6ZH17
	IjxuQhoHBww35q
X-Received: by 2002:a53:ec42:0:b0:664:eb8c:9e3c with SMTP id
 956f58d0204a3-66b2328386amr61049d50.46.1786419723806; Mon, 10 Aug 2026
 20:42:03 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 10 Aug 2026 20:42:03 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 10 Aug 2026 20:41:09 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jason Colapietro <jasoncola1@gmail.com>
Date: Mon, 10 Aug 2026 20:42:03 -0700
X-Gm-Features: AUfX_myHsQ52VwnmjRH9a2gnffH86lXLWJczz7oJFqrKYV2cOsVXJTR8qzJz9KI
Message-ID: <CA+Z0x2KotE5hgrFn-vzR+XNF_H_vEbZcE_nXmpVz5F2q1vxE6w@mail.gmail.com>
Subject: [PATCH v2 RESEND] usbip: make remote list honor parsable output
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

-	printf("Exportable USB devices\n");
-	printf("======================\n");
-	printf(" - %s\n", host);
+	if (!parsable) {
+		printf("Exportable USB devices\n");
+		printf("======================\n");
+		printf(" - %s\n", host);
+	}

 	for (i = 0; i < reply.ndev; i++) {
 		memset(&udev, 0, sizeof(udev));
@@ -98,9 +100,14 @@ static int get_exported_devices(char *host, int sockfd)
 		usbip_names_get_class(class_name, sizeof(class_name),
 				      udev.bDeviceClass, udev.bDeviceSubClass,
 				      udev.bDeviceProtocol);
-		printf("%11s: %s\n", udev.busid, product_name);
-		printf("%11s: %s\n", "", udev.path);
-		printf("%11s: %s\n", "", class_name);
+		if (parsable) {
+			printf("busid=%s#usbid=%04x:%04x#\n", udev.busid,
+			       udev.idVendor, udev.idProduct);
+		} else {
+			printf("%11s: %s\n", udev.busid, product_name);
+			printf("%11s: %s\n", "", udev.path);
+			printf("%11s: %s\n", "", class_name);
+		}

 		for (j = 0; j < udev.bNumInterfaces; j++) {
 			rc = usbip_net_recv(sockfd, &uintf, sizeof(uintf));
@@ -116,16 +123,18 @@ static int get_exported_devices(char *host, int sockfd)
 					uintf.bInterfaceClass,
 					uintf.bInterfaceSubClass,
 					uintf.bInterfaceProtocol);
-			printf("%11s: %2d - %s\n", "", j, class_name);
+			if (!parsable)
+				printf("%11s: %2d - %s\n", "", j, class_name);
 		}

-		printf("\n");
+		if (!parsable)
+			printf("\n");
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

-	rc = get_exported_devices(host, sockfd);
+	rc = get_exported_devices(host, sockfd, parsable);
 	if (rc < 0) {
 		err("failed to get device list from %s", host);
 		return -1;
@@ -351,7 +360,7 @@ int usbip_list(int argc, char *argv[])
 			parsable = true;
 			break;
 		case 'r':
-			ret = list_exported_devices(optarg);
+			ret = list_exported_devices(optarg, parsable);
 			goto out;
 		case 'l':
 			ret = list_devices(parsable);
-- 
2.50.1 (Apple Git-155)
