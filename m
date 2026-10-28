Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793186528;
	b=Wyv/UYJqEalbfE4iiU8QQHpsW9rgDRoeuiHN0TS+DUeNZLBaIGeb650BcEUgRo/YqFgL
	 sWhuo5/NisoGXU9mD2616Aj5IWuioaZTUXkgDmeqMqhJWLYExk3WvKCRCVngHeABjgcU8
	 bIpEj+k70P9a4MVEq6sANn0QZDrl/LhDuADY1pNxse/uzbfpybXGX4DhahX8CgEW4qilf
	 0VUIhEcESy1czAkNSrLjRVrsWfKCQc8Thm/ftKWR7hPHvzu1163oK8B2lOrn8dBvRA++O
	 oH82X1Mq4JzZ6bXaOHv/TMnGhBubRT7Ad/qs8dgau+EEtdCR+vo1rZ+rNINQmEMTBcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793186528;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=N8wCDFeaIH13nv1WMwNEX03I4UQOkkD+G2yHtGzR8mA=;
	b=ev43wHy28+l1Da0F4pdMn6AvYxcnCBmykEvB3gvEqzXDwn4fv8uA11cPffZAC9oew1zr
	 lBmhBKOlzF9unQu6EdjXiEm2zDRXOmu2lp6/GDv+4NNItz3/qSElviDfQu9tedXg3u+pR
	 OjrwlIalVAVUcuZ9oMok5nvCI7fmA2C2gYgCM3vwJdll7XKro8SLQ8oKPbUic8h4OhfcC
	 w1UgH2JIOBh5omQ2N3AIeImU+rzjEEX/BXjNwNTDHDx4611y15DLPq+J0f2ZNQGbZFl2E
	 640skyl5s27V+F003s1tM9XiBx8/H/xKz3UPf1A7boCazO3/EDLIZpFNGfld5FeQFTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NsnqZgcn;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FB3606A32D
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 11:22:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6FB3606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NsnqZgcn
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e9deceda30so1037375ad.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 04:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793186527; x=1793791327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N8wCDFeaIH13nv1WMwNEX03I4UQOkkD+G2yHtGzR8mA=;
        b=NsnqZgcnIs/O85VX0kiYvYvBaYhjZHEKVg/xz6C26htcqQnQBX4HlhHBXLudG7DjtF
         cmSRsq68Jx/rAJJ8bHnanrZvyldTe9FlRqSspbThw/fmB4KcT6D3twIwHG5JjO+NPIvm
         eOziSkaKNxKPwbM/gINT8Z5w5zohaw5IAY2YokCnCcv4VsRg5VtjJNimS4S1CNdoaMeh
         aQKlMaV4XmyYIFrPyhfCJJ8q/LQepUIlV5mg+VSQeP8WN4JPZXRo55cvICZJgiiby9aV
         LMYDrHPiZjLvPAuOMXWyqAgJ5ltN4krMtX5JQwIOJHEzHMz49L5JcYm00ibT1w0h1bPP
         0hWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793186527; x=1793791327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=N8wCDFeaIH13nv1WMwNEX03I4UQOkkD+G2yHtGzR8mA=;
        b=C+9uHAG6C9Mf21W1DmpfLmuCaquec6WJ9ZaloIEUiTgBBY4NLnCowiIobZcl5DcEDh
         quehG8nwQGEESI302oxnbLY+OgBcVzXs7TjucVXoIrnsrXurakWDzDeOm+Byn94YqJ92
         cVExQosox94gAisfAsUR6fd+9pAfGWa2eGeXBCfcT0iG2fK4m/pA7iTLecxXZwTTNF1H
         mrkXE3I/Ox2u4dvdfK82CKcA2ducIakPfRku6BO7pw8HHDRvZXAPISMSiP6EeROjHqde
         o1hlDQ2wU9E1DLFWKe/kYM+nB9JRwd4aTvMC2ln5x0TrZShmMYu6b+f6/8ijsGz/jEQY
         HE5Q==
X-Forwarded-Encrypted: i=1; AKwUvBz3pJP+jzeJcMHWgP3UYo3yEdsEbCBS3knY2P9vB8Nl6mtYMgGVclhO0rW1JV+DRrgw27tlbas=@vger.kernel.org
X-Gm-Message-State: AFq9FYKsEkhP0g163T2bN3P2xt+gxVzggplu7MfLjNHtgOU69QNE3zeF
	xPqEpooPRLTCV+bmtoHfjA2a5ddjo1iQLOIBIvXYb8P+dp1xLHcKZk8c
X-Gm-Gg: AYBFou3Wju3bMt/GuesdU1d76yHO8+zEu1CeKdBQs+V8bOKi4jqM7PK/1dqg1Q66fAW
	SZo9B4bWkN+X4/J8T64pONwUqWvRBa6uKE3j0noUm3IylGdfoNvpvNVL2S9q61SenUH4mW/x8r3
	xDB2MyfHGNSWeYCMKxhQ2SUjEkv7MH+rF6RT+DyHbvkTZd4AMzS8mwCXC2PIOOjATkNjufvv5si
	bF4wAH5nDyn2I1JJJ+YixvgIOqCNIFekbVieOsrIq3VV5zq9mDUmDLHEA6MGB83JnBk58Xt4QoO
	cgjzdGNubQluB3uPWqyztnP6lraTaY86FGlEtF7fG+2/Yjkg3ihMyQkzc9kXmoz8V90e/3FisbT
	ao+4cbLkOW6Mx2FaSD/krM88/3biJHOUG/klE3sKMd+8UwRnpRoPcFHBL1DNjVwrYkf0HyRrV1N
	mtUHfNq//xzHNjwhefB3dXAR4igeBGFo+iqCXko0mErlcyY72yr/O1drbVMdtMJb1LSklgnPRS6
	R+nCDlQnoWSptNlSBzsbvgGLXvzqoQBJDDg10vW+ZT0br6U8rMZk3eUoShP+pgTTLFmKX/Mi5Aj
	TOc7AfOunKpBrsk+p5B17K4GmqVe+CxkmYk4Y/C/MVGOW40JWXacSuA+oipNboI8qswrRA7AEWE
	dL0n/3+wL1+KqMOfEdJEFoJmbxT2kr9SdSZJ/iYmdyOsQqKpXcZ1HVMd7VNTNUlX1L60WrL6nDT
	iyGMznWTAanhJq7YkvNQE=
X-Received: by 2002:a17:903:244a:b0:2e9:d00d:1307 with SMTP id d9443c01a7336-2eb003ba0b5mr32081025ad.3.1793186527150;
        Wed, 28 Oct 2026 04:22:07 -0700 (PDT)
Received: from esteban.tail1178e6.ts.net (132.20.31.150.dy.iij4u.or.jp. [150.31.20.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eafcdb52e6sm10157945ad.74.2026.10.28.04.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 04:22:06 -0700 (PDT)
From: Antoine Pichot <antoine.pichot@gmail.com>
To: linux-media@vger.kernel.org
Cc: sakari.ailus@linux.intel.com,
	mchehab@kernel.org,
	hansg@kernel.org,
	andriy.shevchenko@linux.intel.com,
	dan.scally@ideasonboard.com,
	djrscally@gmail.com,
	dmanresa@gmail.com,
	dave.stevenson@raspberrypi.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 3/9] media: i2c: ov7251: Report the pixel array rate for both link frequencies
Date: Wed, 28 Oct 2026 20:21:48 +0900
Message-ID: <20261028112154.855185-4-antoine.pichot@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028112154.855185-1-antoine.pichot@gmail.com>
References: <20261028112154.855185-1-antoine.pichot@gmail.com>
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

pixel_rates[] gives V4L2_CID_PIXEL_RATE 48 MHz for the 240 MHz link and
63.84 MHz for the 319.2 MHz link, which is the CSI-2 bus rate of each
link (one lane, 10 bits per pixel). The control is the pixel array rate,
and Documentation/driver-api/media/tx-rx.rst says the bus rate "is not
the same thing as the pixel rate on the camera sensor's pixel array
which is indicated by the V4L2_CID_PIXEL_RATE control".

The pixel array runs from PLL2's 48 MHz system clock at both link
frequencies: the PLL2 registers are the same in both tables, and the
measured frame rate is 48000000 / (928 x VTS) with either link. On a
Surface Book 2 at 319.2 MHz, VTS 1724 gives 30.0 fps; 63.84 MHz would
give 39.9 fps. A Surface Pro 7+ measures 30.01, 60.16 and 90.45 fps at
VTS 1724, 860 and 572, the same 48 MHz. Dave Stevenson saw the same on
a Raspberry Pi with a 24 MHz clock, where libcamera asked for 100 fps
and got 75, the ratio of the two rates.

Report 48 MHz for both link frequencies and drop the table.

Fixes: ed9566ce1946 ("media: i2c: Add support for new frequencies to ov7251")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/linux-media/CAPY8ntBFJJPg3y46gC=bNq_55QifC7mKmeq8+pAEDVN42fGUXw@mail.gmail.com/
Signed-off-by: Antoine Pichot <antoine.pichot@gmail.com>
---
 drivers/media/i2c/ov7251.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/media/i2c/ov7251.c b/drivers/media/i2c/ov7251.c
index 1f30a01c85b3..2db6c28a6e34 100644
--- a/drivers/media/i2c/ov7251.c
+++ b/drivers/media/i2c/ov7251.c
@@ -22,6 +22,9 @@
 #include <media/v4l2-fwnode.h>
 #include <media/v4l2-subdev.h>
 
+/* PLL2 sys_clk: the pixel array clock at both link frequencies */
+#define OV7251_PIXEL_CLOCK 48000000
+
 #define OV7251_SC_MODE_SELECT		0x0100
 #define OV7251_SC_MODE_SELECT_SW_STANDBY	0x0
 #define OV7251_SC_MODE_SELECT_STREAMING		0x1
@@ -633,11 +636,6 @@ static const s64 link_freq[] = {
 	[OV7251_LINK_FREQ_319_2_MHZ] = 319200000,
 };
 
-static const s64 pixel_rates[] = {
-	[OV7251_LINK_FREQ_240_MHZ] = 48000000,
-	[OV7251_LINK_FREQ_319_2_MHZ] = 63840000,
-};
-
 static const struct ov7251_mode_info ov7251_mode_info_data[] = {
 	{
 		.width = 640,
@@ -1567,7 +1565,6 @@ static int ov7251_detect_chip(struct ov7251 *ov7251)
 static int ov7251_init_ctrls(struct ov7251 *ov7251)
 {
 	int vblank_max, vblank_def;
-	s64 pixel_rate;
 	int hblank;
 
 	v4l2_ctrl_handler_init(&ov7251->ctrls, 7);
@@ -1586,12 +1583,12 @@ static int ov7251_init_ctrls(struct ov7251 *ov7251)
 				     ARRAY_SIZE(ov7251_test_pattern_menu) - 1,
 				     0, 0, ov7251_test_pattern_menu);
 
-	pixel_rate = pixel_rates[ov7251->link_freq_idx];
 	ov7251->pixel_clock = v4l2_ctrl_new_std(&ov7251->ctrls,
 						&ov7251_ctrl_ops,
 						V4L2_CID_PIXEL_RATE,
-						pixel_rate, INT_MAX,
-						pixel_rate, pixel_rate);
+						OV7251_PIXEL_CLOCK, INT_MAX,
+						OV7251_PIXEL_CLOCK,
+						OV7251_PIXEL_CLOCK);
 	ov7251->link_freq = v4l2_ctrl_new_int_menu(&ov7251->ctrls,
 						   &ov7251_ctrl_ops,
 						   V4L2_CID_LINK_FREQ,
-- 
2.56.0

