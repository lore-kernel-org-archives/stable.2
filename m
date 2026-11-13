Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794537693;
	b=XXaGhO4g3R94yoczZh53xjUERCKkaTH/tRfCMSe7vj1RLG7gwNNY/zwRO4yvAF+Y1H5V
	 lKr/vYu+KDRh56pA8jD43emEEGPTRYBusQoUGUodzpPSb/eCP4LGzwEm681Bn/R0lZXxJ
	 RwDdJuHb97HqjU4z5sIK3JGjRQk87E5Kdd3VOIRJxd32BmAcgQ/BSrllOW8EVBgOPPeBr
	 unaytDlAhQ41EAW+ae/zftDMiRfu9MbgnJV1KtOvtq0fqb9YmNRwTWaad1yEmblQQQz+a
	 RH208YPtHodUnjk6Wvu5/bBAl/WVUFiITRU14HKSTEr198PCSE+PZ6PwG3JEHeIdC4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794537693;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=l+YEUGKtpd7aHWVPQy+x7Xh8BfSvHo7P8pWOf0o5lWw=;
	b=v1KWWFSAppza8Xs01JCsceZa+eyhMdmmRUUpsTfqWhAkPTjEkxIqkT6iMySrWGRn7JCF
	 ED4f2QVW/YlNsJY2KwOodIfqyZtMSE4H6mP8yKZz8bpus4L57mE6Y4bXWuDGFHZzy0C2p
	 /PjH4sdA1eqF++/pe2Q65NZOiolDpM7hyCXNUrLis04D+jCWGTajsLyl0X7D0ZmBf0vib
	 jMX6BZpy6di7avzYA50W0P6dYrpt2+eWKTZCc6/pDYtTKTkyWECEX0kwF9tBG76LiLMPH
	 H+HrZgWqnwv5sQfdvkSTJayU4v/LMQBfg+0ZurCI2eSwpHjtOkbYQFxVTFNDkLcxZYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Ot/FDGmY";
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312FE60A260E
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 02:41:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 312FE60A260E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ot/FDGmY
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-376a4059061so57459eec.1
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 18:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794537692; x=1795142492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l+YEUGKtpd7aHWVPQy+x7Xh8BfSvHo7P8pWOf0o5lWw=;
        b=Ot/FDGmYOX3fJkau+xRq/sVfSJlsKjLN+XTlP+8V0r6RREnevhSGv+69XCKO0JIEQe
         J9S8Mng770C21K/lp9YDxrEja7pw27r6aIonCdZOkiyFCHaTCwfZiDnHhd4gpWpNt1pk
         n0VJMq2nEWhS0QDmYEFrxyAIfj5dri47oszjn5WYhes2A+JcaA0VQxTUH6Jeh1WLJNUk
         DwH5RsuBAWJXC4q6avEYmf2aSWZBpts7f9DnpIouNYPJcRNnvEJD+F9J8jCzbv1PqJ5e
         ORk8llgBZ5GINCgd2mOic0Y9wG8QrvcyLN4uIFj6uAtXb8MTTIvmG1mGY7HBm+SUxCxO
         i8AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794537692; x=1795142492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l+YEUGKtpd7aHWVPQy+x7Xh8BfSvHo7P8pWOf0o5lWw=;
        b=1MMZ6nlJJ7Ah7F7TUGWxFx31gxkrokY13Z0Nxd2pU+omxWUFlMrhKzM6Sbp5aTvN5H
         +hpqP12ePIDpbEaUxIzHkI7z59gR9pybSe31AJa3qdE+Gqyehj7BBRs12WQ6jY4+1tn6
         qfY3VhA7XpgvonNLvtkt6PZj/i3wlCuves5hFG12eLDBYH8MD4vIVYEK03lBq074iXY/
         dOCWjGiaEl2p8dcXMQ/GSZD8pdDLb5bQygJKFpVRdSxFfdnfAeW8pKPbfH2eX4KKjk3h
         gDtd2Zh6Qmyny6b/5apgGCSCEaXXwgBCCkcm3a2Zb5D6ZHRuRydVy9x4Y/yxPXpwtxUw
         /mYA==
X-Forwarded-Encrypted: i=1; AL+hErES9tN5t4/AtfKZI/4eMIviPhAnQx0OU9hBm7aqnHyDTdnYfcAMSra3Af23m9AZTAgXjHVNP4M=@vger.kernel.org
X-Gm-Message-State: APuU4Z/19TemP7oFn/+w0Fcp4yxWJ2kBvTeWGoiRMivrsCE9vWX9LhS7
	zpADFswaPf9H+Cy4wjnsPSnkpKdwyBeF4eWxa3KRFSvBQ2poEF6tri9b
X-Gm-Gg: AYBFou0I/oiM29DXOSiht95vB9aqD3hsgjgTn5gyMjExfiMkcr+jTLhr4owDEwbjPoN
	3pK+EdbSE1tUXVa4mmQZtTSvyVjtTMbPzxWQmC8i9aR085NBUpUvFpHc5DMrWbEQamISwIqZqm8
	OxIJ5Q+o5CUMMrc6ByDogb+F3zO1uHMbB/mtatIgsucEXJ4R9VQR6BP+NY/RbT5iThmRPwm5HzB
	90RV3O68NA/KYTpUhwwMFQDmy+sPrgMK7kvTT4mGdC91KTM9pf33erHK+C6HxTM9ji3QU/ZDqSl
	JIuiwtnYONWdaNQtvPaVkYQ3B2Na70/x6bMTtXtQ3OBPrPDfIMj6Mqd/080+vu77ovLf35Swm5u
	48it3cD2VXQjnPbcEHzYfMaH4NVKoITzSAQoXcyCOMa5pu+9+Th+z22f+ujvweKi05gOWtNeGkl
	OTStd++Gfivr0weLmQ1WkNUZ+cpQhTH9jz8lxdddMYe9C3dujGZVCS2VcLK6zs6ZyHYJOUJ7PWn
	HPE2qUQivd+qOnXseOSUqJB9VC5RgQGy0d4IwQ4z60ZIvVu39xMFFtDeCprDa45rkOPVTVmsltb
	4Ggr8OJNjzU99t3AlZzOS8+sEkr8onBq0FpGhmgzwcStUIa2RnnPoYR40DM/k1bhJV1fbi+v9PP
	DcANqi6Q8KQ0ALbyg6uHmde6s7M4ggk3kXuVbkOaI5rvjpBZjt1kMAMqQmA00Qrfqq4A3rEasC0
	M/+hTwM+BPkQ==
X-Received: by 2002:a05:7300:7481:b0:36d:cd5d:d809 with SMTP id 5a478bee46e88-37964ff2d6emr1982567eec.1.1794537692295;
        Thu, 12 Nov 2026 18:41:32 -0800 (PST)
Received: from esteban.tail1178e6.ts.net ([240b:c020:623:52c6::44d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379565d07b3sm2334704eec.22.2026.11.12.18.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 18:41:31 -0800 (PST)
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
Subject: [PATCH v3 3/9] media: i2c: ov7251: Report the pixel array rate for both link frequencies
Date: Fri, 13 Nov 2026 11:40:53 +0900
Message-ID: <20261113024059.1087031-4-antoine.pichot@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261113024059.1087031-1-antoine.pichot@gmail.com>
References: <20261113024059.1087031-1-antoine.pichot@gmail.com>
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
VTS 1724, 860 and 572, the same 48 MHz. Dave Stevenson reported the
same on a Raspberry Pi with a 24 MHz clock, where libcamera asked for
100 fps and got 75, the ratio of the two rates.

Report 48 MHz for both link frequencies and drop the table.

Fixes: ed9566ce1946 ("media: i2c: Add support for new frequencies to ov7251")
Cc: stable@vger.kernel.org
Reported-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Closes: https://lore.kernel.org/linux-media/CAPY8ntBFJJPg3y46gC=bNq_55QifC7mKmeq8+pAEDVN42fGUXw@mail.gmail.com/
Signed-off-by: Antoine Pichot <antoine.pichot@gmail.com>
---
 drivers/media/i2c/ov7251.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/media/i2c/ov7251.c b/drivers/media/i2c/ov7251.c
index 1f30a01c85b3..65f3fc2d5889 100644
--- a/drivers/media/i2c/ov7251.c
+++ b/drivers/media/i2c/ov7251.c
@@ -18,10 +18,14 @@
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/types.h>
+#include <linux/units.h>
 #include <media/v4l2-ctrls.h>
 #include <media/v4l2-fwnode.h>
 #include <media/v4l2-subdev.h>
 
+/* PLL2 sys_clk: the pixel array clock at both link frequencies */
+#define OV7251_PIXEL_CLOCK_HZ	(48 * HZ_PER_MHZ)
+
 #define OV7251_SC_MODE_SELECT		0x0100
 #define OV7251_SC_MODE_SELECT_SW_STANDBY	0x0
 #define OV7251_SC_MODE_SELECT_STREAMING		0x1
@@ -633,11 +637,6 @@ static const s64 link_freq[] = {
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
@@ -1567,7 +1566,6 @@ static int ov7251_detect_chip(struct ov7251 *ov7251)
 static int ov7251_init_ctrls(struct ov7251 *ov7251)
 {
 	int vblank_max, vblank_def;
-	s64 pixel_rate;
 	int hblank;
 
 	v4l2_ctrl_handler_init(&ov7251->ctrls, 7);
@@ -1586,12 +1584,12 @@ static int ov7251_init_ctrls(struct ov7251 *ov7251)
 				     ARRAY_SIZE(ov7251_test_pattern_menu) - 1,
 				     0, 0, ov7251_test_pattern_menu);
 
-	pixel_rate = pixel_rates[ov7251->link_freq_idx];
 	ov7251->pixel_clock = v4l2_ctrl_new_std(&ov7251->ctrls,
 						&ov7251_ctrl_ops,
 						V4L2_CID_PIXEL_RATE,
-						pixel_rate, INT_MAX,
-						pixel_rate, pixel_rate);
+						OV7251_PIXEL_CLOCK_HZ, INT_MAX,
+						OV7251_PIXEL_CLOCK_HZ,
+						OV7251_PIXEL_CLOCK_HZ);
 	ov7251->link_freq = v4l2_ctrl_new_int_menu(&ov7251->ctrls,
 						   &ov7251_ctrl_ops,
 						   V4L2_CID_LINK_FREQ,
-- 
2.56.0

