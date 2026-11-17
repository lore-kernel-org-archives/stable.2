Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794912090;
	b=NnwmJy8rB5A/APfNrgiHLPdvlQJKhlZxgQg2V0ONbzbz46l94Q9w50CvMB3e+Fs2wOn7
	 YMucT8F5Yk2wqLEeR/AXzlA8bQykP9K46HYgC0Nq+KhM5Bpk5urWHalrlUJ0JURfitOwf
	 T6+x3G8h8J1hdrh3ubcPsqW3s1nVkm1bNELozQpChrj3HTlJo1ysDwbEUtYEpkmjxd3E3
	 Wh131Osw5Wev13fVnNTlY9DA2aqoS/MsVot8scMwqzGaDWh29LZmEtuhWEm5RR6SvEf4E
	 GYYJVvU6IwZxDfjbfhJaSw1bw8QZb0q1HOwrZGiqWolnqs6XmTLqc2zB8Zx2M+FL38Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794912090;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eaga9iq2xMzHbd5n0lWO/WLBwljw+5hVBVM+gVZj3uk=;
	b=2EIHnfcyERMh6u5BTdq6t8Nug+jh4ViAoheTJi/Bg1JBW+ACm7ZHrmGMXDo76CsYcsd7
	 Yw9jm9MDMguS9iLFOL7eaB48oIXjv/eTR4eqL2bYxaZENHOXt5QkXkEmSWEFuX/eS8S4p
	 yl008hndA2xN7r47OAXl/Do/cxArEImLh7Lz2xP8BbcejpJ3SfkQdwi1VRXOfn8bt2BX4
	 6TUsTWkWYTPXWySAIIgX3Ev41x5ff2tAnmZsVduz/ckvLdAw8ZHtHNj6Ps8K3Au12N8bE
	 fI8rrp3kbt9Eie7Xi95n+9gzkI8bmV1W6gu3GnyoJdJUIzHGWgM59L74aeRxIXj0OwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vzTKbVTa;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4445E606A329
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 10:41:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4445E606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vzTKbVTa
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8a4c72951b8so3394115b3a.3
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 02:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794912089; x=1795516889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eaga9iq2xMzHbd5n0lWO/WLBwljw+5hVBVM+gVZj3uk=;
        b=vzTKbVTaO0mnOjT0wrC9bJuj2U7c8JCBOJXeERXLXjO6BfmdRweqdJxvATO5aSRSHj
         SXb9XVeZEaBHEWOO2LUH8py3vAozCejmhPwtmDUBrZi4zh1Az2YxxawDJJz8Ml7lH5wd
         cnrD9bJqzzgyTEoscy4of5hkrgQDPSLHsjyaApIpOGz/V3CtmNtFnDppf79BVRrpsCzn
         nQUYFA3GFydj38LtNiRADuY95g6sUsnytyW70R+5lCmFfR3lWNafrMTBuzYZgT09nVi6
         vV8qmPYcO67Sg/XsSJIXbi9pwdzhbSr5k1Eq7p3ooNns1OQXih4gPtmlRxyRI3d3p11k
         rEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794912089; x=1795516889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eaga9iq2xMzHbd5n0lWO/WLBwljw+5hVBVM+gVZj3uk=;
        b=PDgnzFmBqY1hbM0UEPUq0Q3juCihpxyBHhUISvHrNphuKCp6OrfJ+DmOaogRYYgVmI
         xI6PFxGF3fjWetSAvgLBAyocuhbBmI9z2kskH7TXHXeRODYHz/YlWMteVoqsYwQMkNkD
         CjYMDiOHZzOcrWqN4u3Bn9u/UeYQMng/3YIw+HfNSSuENXmQ6HgiHiqsWYNYku6TXj3l
         XA4pgJL8fynO+9QCMiARgv0VjNhaaEGsj3Vl2ZPt6Xvxxs2P0jHXcydVDGFHmzfarE9v
         xGkgz9pftKc0IsYDJJDxefdRAAFER3utgjjgxCv6xcDkhCITReXjIss240rcZ63INNAA
         nt8Q==
X-Forwarded-Encrypted: i=1; AL+hErE0YZWG7kVdkdu0y20pnJMKAOrnX9mzQtrKNUuYXiL8iwWxF7CnXNga5R/ooLOcRUrAWFJ82/0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9nxDHocB6c89BilCytD+wrCAfi1Ie4ieZJCrfOgAU1fk4Zys7V
	MLpThIvvMlYuH0zqA9PZrL871Wj3Ha9/uvkYav4wf0CbxsGd7Y8xMcUi
X-Gm-Gg: AYBFou2Wk5aVaI4hV9fk5XzLTD3JjjcMPGzhRmCe8Gi/1oxs6mF3GbpxA4aVIdA+bZl
	HEZ1W2SGowuj/BhuYC/2+IWDgiwsTgyA/HqE5ywGtQ21qULx1j4H9FMLrV58h5SW1iPOB0lRXgN
	3UbDOzdofFppKDEplB3rBBDBIaUnaRS6qrA9p3XinBa7INvMDIbNwFx1DN6gNZA96yV+yDKH73B
	KcHTniT3u7alWs4IEeGD32axLBTIb2wCo5HLKw/T2m1jTLPdX27eCa/lpLdL2hykH+7lep89kry
	/ypsVZc2NT0rBRQSH4Swz21f+HFG0ZbAEFNGnoq4xkFs+tk20ld/nYdKbuTVdb0mcqvnf9iwXal
	JV+GLZlq+yBRJjiZ1W6h90E43FU7zTY4KVtRhmgUk0iVqln3IFCx9R0KUwJOJdpCDEAXDwcqLLm
	cfsziZwmyvmxQoBgoXCttjQWBygvFDvd7NU7HFVWqWLnmA7aazn3VMZHogCYxNeMJ5/j+CNXypi
	HIfY3NL12RCl3hpvfMnwjpnGsunUJ2tKIUNtsOIT3RCfmi9H/rmpBODBm4quiBdNyj/K4XgwH5x
	voQ3YpFEP6Q97tRKyaVpWjCCYpZKIsT1z43GrBy7azPEeXdX
X-Received: by 2002:a05:6a00:2350:b0:8b3:15b4:45f2 with SMTP id d2e1a72fcca58-8beb6b6baffmr12020475b3a.25.1794912089476;
        Tue, 17 Nov 2026 02:41:29 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed2829dcdsm4900102b3a.48.2026.11.17.02.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 02:41:29 -0800 (PST)
From: Hyunjung Ko <hj351016@gmail.com>
To: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: Mary Strodl <mstrodl@csh.rit.edu>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH] gpio: mpsse: reject bulk-in endpoints smaller than 3 bytes
Date: Tue, 17 Nov 2026 19:41:10 +0900
Message-ID: <20261117104110.240112-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mpsse_read() reads min(len + 2, wMaxPacketSize) bytes and then copies
len_actual - 2 bytes to the caller. A device that declares a bulk-in
endpoint with wMaxPacketSize 1 completes the read with len_actual 1, so
the copy length becomes -1 and memcpy() runs far past the one byte
buffer on the caller's stack and past bulk_in_buf:

  memcpy: detected buffer overflow: 18446744073709551615 byte write of buffer size 1
  WARNING: lib/string_helpers.c:1036 at __fortify_report+0x6e/0xc0
  Call Trace:
   __fortify_panic+0xd/0x10
   gpio_mpsse_get_multiple+0x767/0x780
   gpio_mpsse_gpio_get+0xa2/0xf0
   gpiod_get_raw_value_commit+0xf8/0x1f0
   gpiod_get_value_cansleep+0x1e/0xa0
   value_show+0x42/0x90

Reproduced with dummy_hcd and raw-gadget. A read needs room for the two
status bytes plus at least one data byte, so refuse to bind otherwise.

Fixes: c46a74ff05c0 ("gpio: add support for FTDI's MPSSE as GPIO")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/gpio/gpio-mpsse.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpio/gpio-mpsse.c b/drivers/gpio/gpio-mpsse.c
index 61c5ca96314b..3ad7048f009f 100644
--- a/drivers/gpio/gpio-mpsse.c
+++ b/drivers/gpio/gpio-mpsse.c
@@ -676,6 +676,10 @@ static int gpio_mpsse_probe(struct usb_interface *interface,
 	if (err)
 		return err;
 
+	/* Every read carries two status bytes ahead of the data */
+	if (usb_endpoint_maxp(priv->bulk_in) < 3)
+		return -EINVAL;
+
 	priv->bulk_in_buf = devm_kmalloc(dev, usb_endpoint_maxp(priv->bulk_in),
 					 GFP_KERNEL);
 	if (!priv->bulk_in_buf)
-- 
2.43.0

