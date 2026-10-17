Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D01395ADD
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 05:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792214387; cv=none; b=TtLcospfMFTXQkN96j1+iGVOODtc+vfCHdXYIbvTdz8w9QTxFD3w8l5t9C+WNCvIcG8inrAAewcUAnyZB5dUdDdcQHVLRYg/IKXxd2kLP1/wx218GYTxG8hvN1XHT99aQDNjdkU3IGX5P0/4b9PdZuT8zMfPm2C7rPOBOBaNp9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792214387; c=relaxed/simple;
	bh=SWBmXu448zjzxYjCx3pUm9k+IVsTZM+Oeo1N4UfrkmA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VgiKK1O8xyY8XWVar8Hiq6cvufLDaBAsiDZGzL4NA7ltEVFSYsztB5CuzMYhfDHAfYFt2c0v32vUlZ7bCLItnQ9Zts+kK84OAD4jbwZLWOx9k3Opd1DROj+GQkhNTIXgXANS95liT9ACPTRrAvNlJcpOszlUx35GRuxf2TQCGcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I02ItFUu; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I02ItFUu"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a1682bff3cso2497545e9.1
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 22:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792214384; x=1792819184; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/dnusO2vMBZJOXXq/LcKes7+kqYaIPlF1nsGZCt+1mw=;
        b=I02ItFUupSWO3qGt/U1fQo2Y/vHnIePCw+EtE/R5rKNAoK0GDrZmxyfty0HjPeXHL6
         k+TxVm1S1+H4rNz9zSYDFRfCJYxh21nsr79tAaq4jRU2hqj4MluvrHaBG0Fd8ORvPQH6
         GDqM3x32sQF7qD11eHiDTsoJWnQveJAZPWHSWTtlC/wFrfWdwCOiU287Gl6dmzcUz1rn
         HEhHkCqaj/TZTa4OA5x4PkIg4HeALufuIG/WaqyaqtXCvD5hPDIYZ2eodkd3deJhy7fR
         t7x3Tm1fgZy2slneDZmiwrqg/3hHfgzr87gKOzmDbBR9IDszIjpWFQFQNJDst4PvRQy2
         JJlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792214384; x=1792819184;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/dnusO2vMBZJOXXq/LcKes7+kqYaIPlF1nsGZCt+1mw=;
        b=Hu0cqiRwS9rnzaHbHLqVS82GdhvWPZPQ1H7G57ueZzlBnu66SoEOzymgufGI0G+CA6
         /HD8+1PXK7OWue22OwlhvtgpNoRduyYrLgaePF4FAE5pGv96NhtDhsIEbcuwW0ondLvU
         mlOIglxwVTZBYyOL6r7Se3EJVf/UIt0OW3s1lJ6rmF+p5wQyj9D838TkC1oCKDHb6GxB
         /FDS5KYpTVFHwvET57f6KPkf0EfdlJwez+NZZKXho35u+TVdwKyP+zUqXC0lv2hamZrc
         uIrnQ7eknUw37GeUAnyqe5U22/scW+SPn+f3TxsS+zAijWT3nhrWyy2uROSc6QrAbwtM
         zt4g==
X-Forwarded-Encrypted: i=1; AKwUvByBgPdhyVWLMidM+4DHha3nNqsXn2gFY26defMrTuWmeBO81whDuT1NeVc75ElbCMFfe7Vaczg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIWP+vI5N4A7kq12dAfxv27WsWiL2CMm8vH16429kIKXQvo3s5q
	cmN3UjCSG2m2dykW77ReTQgTmGdekI5gwZKUymwdrh/Yd/nivZTtrToo
X-Gm-Gg: AYBFou0vA1x8FJhxr9xxZ17NUkpZhQZD37vHQh+n2lAqaXUKiUtEtrxo+8L4iLA3uJ/
	B+l5pF5IgErcoYQSfJxyazyrdQJHKrD+b+FSE3Ps6IR5ZOcDp+Kq0mZMk9V1BXX1ebNOhUZm6/O
	kclg5t59F5ZGQdh8oZt+x1S3MNBytR/+NZ66rm8+cmic359O0LddhWXqzDOArbmiRyV33l98g3m
	uCUUO4zCcTRfeV6KN4t99MMCajctGidcOgdmPa35IisSCIHvzUHScPXUFd2wCaH+IPGIPZ544wO
	YzoRbzAKcXo5m4Rl2PoM8ye+cdfsMZbiEp+7qrjJnArsvMPFaSWJbkLOjo6N6eHTchj6NFw6Upp
	ZLcFU3ViScsa6Yp1stExlml+C8JsN41YrO4OM/U8OgvgOHQHzITyek8afM0M4AwnG9a7ErDmoh9
	Jd5IZKf0ZCVjZGc8OK4OcDr3mwtN1SGvrn+gCyDPpkSTIY1Lx7BwOv3KNEyR+fsvgJmbpzx/JSa
	fVfc3tgcmRc4nxzrj/zY/nwXNkGnCMnS7FVErK5YcctDdB6wR42nUISa6mOy2bnhhyh3R44XB/g
	m6rgIlcKoWwviejn4jFSsPm6uOm6kUtqmbhd/oBNHVwI8NFL5URtdt00O7fOm4M06DziwHtmU0Q
	dzSIsZQFh/XBNSFR25plse0N0v1A0G6LsWDu4TlDI/uIyqLeDbE/zFveii67rmFRqiFHjLCse7z
	zxTPw27cs=
X-Received: by 2002:a05:600c:1552:b0:4a1:825a:56fd with SMTP id 5b1f17b1804b1-4a1d762a26bmr37921725e9.32.1792214383959;
        Fri, 16 Oct 2026 22:19:43 -0700 (PDT)
Received: from [10.200.7.52] (109-81-110-105.rct.o2.cz. [109.81.110.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1dc952d63sm16432585e9.2.2026.10.16.22.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 22:19:43 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sat, 17 Oct 2026 07:19:21 +0200
Subject: [PATCH v3 2/2] iio: gyro: mpu3050: add missing trigger cleanup on
 remove()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-mpu3050-fix-v3-2-d6f29f335a2b@gmail.com>
References: <20261017-mpu3050-fix-v3-0-d6f29f335a2b@gmail.com>
In-Reply-To: <20261017-mpu3050-fix-v3-0-d6f29f335a2b@gmail.com>
To: Linus Walleij <linusw@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Dingisoul <dingiso.kernel@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792214381; l=1550;
 i=joshua.crofts1@gmail.com; s=20261015; h=from:subject:message-id;
 bh=SWBmXu448zjzxYjCx3pUm9k+IVsTZM+Oeo1N4UfrkmA=;
 b=Fev/aLp/t11PuIxED9XWHh8KFvT+A+vQaVp18KaBwGEewZtgXbUFr+4wGlDOjtM2p045I2Rxo
 mcfut4HanCTBy+iHu47QabIH0hrPyOukxNqQYLWwPzM2r2m9f1AoDr0
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

The mpu3050_trigger_probe() registers a trigger but
mpu3050_common_remove() and error paths in mpu3050_common_probe() forget
to clean it up, causing a use-after-free bug.

Add the missing calls to the iio_trigger_unregister() function.

Reported-by: Dingisoul <dingiso.kernel@gmail.com>
Closes: https://lore.kernel.org/all/20261010203601.1686148-1-dingiso.kernel@gmail.com/
Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/gyro/mpu3050-core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index 879caf3b729c..9e747836df3e 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -1262,7 +1262,9 @@ int mpu3050_common_probe(struct device *dev,
 	pm_runtime_get_sync(dev);
 	pm_runtime_put_noidle(dev);
 	pm_runtime_disable(dev);
-	if (irq)
+	if (mpu3050->trig)
+		iio_trigger_unregister(mpu3050->trig);
+	if (mpu3050->irq)
 		free_irq(mpu3050->irq, mpu3050->trig);
 err_cleanup_buffer:
 	iio_triggered_buffer_cleanup(indio_dev);
@@ -1281,6 +1283,8 @@ void mpu3050_common_remove(struct device *dev)
 	pm_runtime_get_sync(dev);
 	pm_runtime_put_noidle(dev);
 	pm_runtime_disable(dev);
+	if (mpu3050->trig)
+		iio_trigger_unregister(mpu3050->trig);
 	if (mpu3050->irq)
 		free_irq(mpu3050->irq, mpu3050->trig);
 	iio_triggered_buffer_cleanup(indio_dev);

-- 
2.56.0

