Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795179462;
	b=n0KQpkPBaz877AdJxmYzQ5vJGDfDMxs6liRu0XdtHcnr4lBMKhybJsy1UnCLdtPa39Qy
	 fbvWXOz7zll9fWbYqGqawXMJjBC8u5uvl9+q7yyRx5XmQWq8QV0wfkFO9KauNSFN1GANf
	 RHoylsOFnkKQYO27vstUn8j6iNRbs05rN0JRL8vjwb5V5Cpzl62+R2HOgU6EIwPVbopxc
	 QAs1uVf7NITV5c+nM1EsYJPxEJLoiSaoJRZCXcmFwvsCVZzP0yLMZ/pmoLaZzytJ2nO9i
	 TS1u17lbnxfBpd71lWEKD4fPzPUCMmqmZiY2r7HVs11DkaJIFio5XcTxpRIG/iknIQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795179462;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KeRD44dQOO6ZDNI7a8JiTN75jiv8xR1iGSuq9LBDHK0=;
	b=Q1fROQ+aAluCTH7Na8EJEqo2ybUReMFxCNm1XgiqHzw1RBgDpK9fmIufuwxOYhRaFdFJ
	 inhvzSqoaQrc0XhdFNSeMNabvbvv+lQKWII5ul+wo5hfwcPyiszHFGldbeUm9vQde1sn2
	 nwc5F8mvMWJdxe6C7nxVVr3wQFOnNbAvdACDWbY1ctbTmi+ANfkzZosC4Y/JUiIG7cJpv
	 pAvG3so9C6wECKvw3ZpS9L5nlfGcgAMqMW0OpA06RaCrLklMQjRsif6nMo/KuBRU+4Bwr
	 dPLhypAGAxolBhlRQ5xqo5jie9XEPTwSxX97UmiwWv0YEGSbMnhVfdTKPQ/bWkYTtrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="xc+/RY6m";
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820B4606A326
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 12:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 820B4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xc+/RY6m
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3282db206d3so2283987eec.0
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 04:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795179461; x=1795784261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KeRD44dQOO6ZDNI7a8JiTN75jiv8xR1iGSuq9LBDHK0=;
        b=xc+/RY6mE5bOW4O6W5gmg4gOu1k2/kFtnQHpgVLHJtgbPGIRhrKRwoGhJrhblCxn+h
         CzjDJ2yuxJGPeB1SYPdsf3M8s2oRmbU9IFlDdFxssBz3l+8R1vq0JIajfQ+6AIHWny+s
         qijpk6JuGsHJEAjwF0k4VzfTIflN5H3cWa2UvDgOdYW/OteghkBjgq3dkzjjgPIRmyrR
         b7TEvcxwf7cXtTOe5Je90WOZqLekoGgMN5EV7tbjpSVmJn8BcMfdPQd97aIwEQef2A6N
         qPsWgVZNPxkdkZ+bk6HMHggZzp3xEyzgXyHsGhjMBo7MSDddugjn9q4LW3umHiUENL+o
         o7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795179461; x=1795784261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KeRD44dQOO6ZDNI7a8JiTN75jiv8xR1iGSuq9LBDHK0=;
        b=bFoaFtkJA11X88M0wIOpq70DueQIlWPaX0E2ur+UCDMRBGvt9Nx0d52PhsQ7TEO8+B
         1kfcar+N3pVrUVOKCpEQu8yU2akIV9FpX8E3FtGZ+aNjjetVnLMk0y4osnrNmV/+LPY3
         o6R5X7SJAxJ/9alF4mfdBPdY28T/629kjk3o59cudWETJvBUdlnRkBec45sbHhs3CRQP
         O7GR6SronZORaXX7WMCXp3TQavQJdz9J5I44AeZyJel1NeNra99Gf2RjS/ugqNr+IuER
         hdKkxb0b4jx5EUjl9Ob75PPx1tCGXkjJaTFYSEK3Sy6VtqonTtsZW9nmRa5dnJv87en/
         rIVA==
X-Forwarded-Encrypted: i=1; AL+hErF5cKGXQZ4jfF0wPIar6jBQo4quZfOwJJiidmPZERpLENpcoC5T8w40Ojgzefd7U7R2noByu9Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z8zZJtnfhSE0NNCEbrFa8q2+ATINWF3xKR+gRXIVFr4nOncHQxv
	Q8XwzvvMeaZI8YLgN4Di6d0mzcrhXHdmhqj2FDo01YAuG/o6rOagfWTm
X-Gm-Gg: AZFdTZca/3yhRGAGsIMeguMWcKsZuCQNN9otg8IHsENDZ03xzfBPbz7QfT7qv3rBxr5
	2eB+3T2gwaIMVbzSnFU+z8ssxA7n0uZbxnt5YeocBx2SOB5Zu+UExNn1fh5hv0ei4rYY6BfrDsj
	MaFoBA3+l9SaM3wm7awQ8SPp5/DHIUPhuX9UuhtmkWB+Af6ucbvJDA4PQPahQDYvvl/KyTDt+RE
	uKfcoRAiGhvhobaqRZfuqFp2YZZMptlp5zKExX1Pousotde31Y3tE7Y/f5oTLRBMV6r2xOuAgpi
	dWiyLxqH2hlJB8ziRv0sH4PiUmkCC8m0YN7BUcdSOPz8l99LlEnR+RTr2zGEhKM72TUg3hpx/fB
	4O6P8aPHYwhuFeZRQKTJnrx8Yi8zLooPnVI0ScE3GoJUTZb3No9/2UEDp31VWQ98WDRKxfjVuCg
	Iw1aV1ScM2BWdLlHnhjW0+LAkbmDbj7mGMPLiEv8n2IKC+TuoeKXTifFNcdWuhgs34rLAN12c6J
	YTsliM3QRUANpjWrJCOekvm6zY3/eDvKuqVYW3obagkRosGvR4qhYuRHmR++7grPDZT0gi/lLt9
	+qRLdFH1xwNZgA5NWRfzqloJ9s7x3Dw/WON/0xZueHzboj9Y1RJ6eN9ucTjtjLRA04GgGjZg
X-Received: by 2002:a05:7301:182f:b0:385:cf42:9b9b with SMTP id 5a478bee46e88-385cf429e7amr1916243eec.8.1795179460450;
        Fri, 20 Nov 2026 04:57:40 -0800 (PST)
Received: from akhil ([61.0.85.44])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385665f21aesm10672548eec.4.2026.11.20.04.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 04:57:39 -0800 (PST)
From: Akhil Arul <akhilarul324@gmail.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: shenghao-ding@ti.com,
	baojun.xu@ti.com,
	Carmel@aperio.ai,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Akhil Arul <akhilarul324@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: hda/tas2781-spi: Set tas_hda->dev in probe
Date: Fri, 20 Nov 2026 18:27:29 +0530
Message-ID: <20261120125729.135171-1-akhilarul324@gmail.com>
X-Mailer: git-send-email 2.56.1
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

tas2781_hda_remove() is shared by the I2C and SPI drivers and uses
tas_hda->dev for component_del() and for the runtime PM calls.  The I2C
probe sets that field, the SPI probe does not, so for SPI it stays NULL
from the devm_kzalloc().  Unbinding the device through sysfs then warns
in component_del() and crashes on the NULL device in pm_runtime_get_sync():

  WARNING: drivers/base/component.c:839 at component_del+0x149/0x170
  Call Trace:
   tas2781_hda_remove+0x16/0x60 [snd_hda_scodec_tas2781]
   device_release_driver_internal+0x19e/0x200
   unbind_store+0xa4/0xb0
  Oops: general protection fault, kernel NULL pointer dereference 0x1d1
  RIP: 0010:__pm_runtime_resume+0x1a/0x90
   tas2781_hda_remove+0x23/0x60 [snd_hda_scodec_tas2781]

The same path runs from the driver remove callback and from the
component_add() failure path in tas2781_hda_spi_probe().

Before the common library was introduced, the SPI driver had its own
remove function that used tas_priv->dev.  Set tas_hda->dev in
tas2781_hda_spi_probe(), as the I2C driver does.

Tested the probe/unbind path with KASAN and lockdep enabled: without this
change, unbinding the device gives the warning and oops above; with it,
unbind, bind and unbind again complete without any splat.

Fixes: 28a09d9e42c5 ("ALSA: hda/tas2781: Create an independent lib to save the shared parts for both SPI and I2C driver")
Reported-by: Carmel Okun <Carmel@aperio.ai>
Closes: https://lore.kernel.org/linux-sound/AS2PR02MB10038DB2CE8CAE659D35B9F1AC8792@AS2PR02MB10038.eurprd02.prod.outlook.com/
Cc: stable@vger.kernel.org
Signed-off-by: Akhil Arul <akhilarul324@gmail.com>
---
 sound/hda/codecs/side-codecs/tas2781_hda_spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/side-codecs/tas2781_hda_spi.c b/sound/hda/codecs/side-codecs/tas2781_hda_spi.c
index da71b57a26e..4bcee8362b6 100644
--- a/sound/hda/codecs/side-codecs/tas2781_hda_spi.c
+++ b/sound/hda/codecs/side-codecs/tas2781_hda_spi.c
@@ -781,6 +781,7 @@ static int tas2781_hda_spi_probe(struct spi_device *spi)
 	if (!hda_priv)
 		return -ENOMEM;
 
+	tas_hda->dev = &spi->dev;
 	tas_hda->hda_priv = hda_priv;
 	spi->max_speed_hz = TAS2781_SPI_MAX_FREQ;
 
-- 
2.56.1

