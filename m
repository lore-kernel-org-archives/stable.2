Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C7644839C
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 11:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784115852; cv=none; b=thNwgLFjKNcXqPKW43Zny+COCbi3PGVxaPiPDFf9L51/L7wQepAul45iVKTZjZGoMN6+TEABDbzsvlyUk4MSjkf4bwoHA1L6Xatgg2RXjZ51jQmqyT5knLOAIxlijCtxWwy164xFEggSeDU9vYA4ci/YTtXcLYm3YrGkiKGSXCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784115852; c=relaxed/simple;
	bh=TiWHPeDGaPVeBlBGHKihLG/CZfpC4vuLM0PYqJWSqJ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=juL3/iyeerxghhkKxreMYRq7+44DI5OxUfHloo3oC/j/DXd1624J+jtPtPJOv+JQk4RKvzdF2sqQDGNqktShxEjDdbeEIC+x96cpbJzdaaxM6aUvUD98WpYzvr5tRFOjQSaHex2938zOHD8yJJ2vl72yUzRZ8Sp0HTQ7DY3S9Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=Vi1o2TyR; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="Vi1o2TyR"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47d70879764so3615600f8f.2
        for <stable@vger.kernel.org>; Wed, 15 Jul 2026 04:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1784115849; x=1784720649; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RvLfYd+pvOrvfxKIqJXK3E0FFOSlNO+LlwCAOW1ExY0=;
        b=Vi1o2TyRXB3P/F/zsiNIhDq9FHeLY6vHkvmCZTUINf1iBBFth3nDL8WGpQW4fcodyo
         2+miF+04CTFz6PbVzMoPYyzVLsma2Tw+e88tsve1w/2aI3b0eM4tfqj1qdAuNl2SoBNv
         g+FcJ3HClQuL5TBPlhmH16DUgMMzMTgXW1GjThnDpd5r7gkF2/tgJF+mxubGZ8MbcZ9a
         3TS4q66JAR0IGnnt9kZg8qNNR3hWlL3BvwbB0Or113/4Jo6H/CJnYr8z1D8JauFzJoVb
         blhXa0Xx4Au/m0sVFsnos+oVJt0VB5rb0ppvBa7Q60ZPgFsOKyMaeb8Vy7V5mwlKssbl
         Ofxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784115849; x=1784720649;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RvLfYd+pvOrvfxKIqJXK3E0FFOSlNO+LlwCAOW1ExY0=;
        b=g0a63ke/shlPSuhtvOewXCs1UsLOO+areycTZmUCBdITDB7vqfrjXiNzHkhjXh7AhP
         2J+qdMIgGR5DYANsTgxaXTN9/ZI2BM/SD5UxNepcvJ6xyPs7GBKzCpliITAKjRYnGS3H
         yZvUPnhw9Q9NOBVaFe1sVmMCZKw2mxRHgLkneMZgVT4Mua0Lwqemm/M7q5S111A9IrBZ
         jEoah/XmEt8H03Dryz0x/00ZeGCFEGbOGpJDB0uFMZ25NM9XzIATjmeH1YRDOjB7PJHC
         tvxFPdoG8S2bYwv2POQSFFXFbjvi0ZAeqxhIMWPMwQhKiZ02DU2k5bx97irwVl0mhBxX
         g2Cw==
X-Forwarded-Encrypted: i=1; AHgh+RrUeSMZbY8GeYlZWSMESYZDPJNDBqJtTRYffE6KdQvHde+A9230h4B759Tw/JPVIdMOLC1S5CU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB7+sB6SzGyc4CZWgQLffpKdmyfWNLpqlb0aFTOC7dlEOfyGsa
	BitZII8tBLHC6dhP98eFwqwQsGwJ8A77BpWOtUNjUAjRn+Xe6z2FA6G1oeaSlqCCPCw=
X-Gm-Gg: AfdE7ckLy5B/U+yeX27PleoyZSe23klLc5Itlj7DRMunNgy4TTsgeV+EXVIBs4k7nRo
	YOomZ7PMJiCjWVH378diTf3iXEUMgulP/ZSkNs3jEA9S/5b4tmdhp9zxRRVncgkEkx9HvXRnudx
	RW46tn5vV20SZHMO/d3AuQSy1BzjpkFJkU7U96xmqKkvCfluNO/gpNNAQ/svY1zLOrI8mceoRvM
	avMO8VQ/Cdb5pGJ+KuIGg4AcOYiVfShUOB7lF77BcztiKP5GEklbxxWQDNoltEKEMprJe5I8hQs
	a7ySKnG2UDzr7eG6WbZTOYXTlW96a+H5BBuVgu37Ds2MC5GbPA1659ZKUnf0dVzGZcPv6Qod9kg
	mgizLXkDRu8uHmtOvMhjg0yDevwpo73NY0TaKdnXO1aJKSEu6B8c1CkkFR9vP/eNuLlJGN3V5gO
	NcZPfjQ5LwlerTAx+zSVLLl7ZedN9Cgb0JqW2Vu7ZvwHOlP2Be7oa9jZiV2vqL2NO9
X-Received: by 2002:a05:6000:612:b0:478:9d9a:d4e1 with SMTP id ffacd0b85a97d-47f4fce484emr2623565f8f.30.1784115849048;
        Wed, 15 Jul 2026 04:44:09 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-47f4829896asm14005425f8f.23.2026.07.15.04.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 04:44:08 -0700 (PDT)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Wed, 15 Jul 2026 12:43:14 +0100
Subject: [PATCH v4 01/21] media: imx355: Avoid calling imx355_power_off
 twice in error path
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-media-imx355-v4-1-f7f966fb9ffd@raspberrypi.com>
References: <20260715-media-imx355-v4-0-f7f966fb9ffd@raspberrypi.com>
In-Reply-To: <20260715-media-imx355-v4-0-f7f966fb9ffd@raspberrypi.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Richard Acayan <mailingradian@gmail.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Heidelberg <david@ixit.cz>, 
 Jacopo Mondi <jacopo.mondi@ideasonboard.com>, devicetree@vger.kernel.org, 
 stable@vger.kernel.org, Dave Stevenson <dave.stevenson@raspberrypi.com>
X-Mailer: b4 0.14.1

If v4l2_async_register_subdev_sensor failed, then the sensor had
already been powered down by pm_runtime_idle, but the error path
then also explicitly called imx355_power_off as well. That left
an imbalance in the regulator and clock calls.

Call pm_runtime_idle only after v4l2_async_register_subdev_sensor
succeeds to avoid this.

Fixes: efa5fe19c0a9 ("media: imx355: Enable runtime PM before registering async sub-device")
Cc: stable@vger.kernel.org
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 drivers/media/i2c/imx355.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/imx355.c b/drivers/media/i2c/imx355.c
index 27a5c212a527..ac59908f57aa 100644
--- a/drivers/media/i2c/imx355.c
+++ b/drivers/media/i2c/imx355.c
@@ -1822,12 +1822,13 @@ static int imx355_probe(struct i2c_client *client)
 	 */
 	pm_runtime_set_active(imx355->dev);
 	pm_runtime_enable(imx355->dev);
-	pm_runtime_idle(imx355->dev);
 
 	ret = v4l2_async_register_subdev_sensor(&imx355->sd);
 	if (ret < 0)
 		goto error_media_entity_runtime_pm;
 
+	pm_runtime_idle(imx355->dev);
+
 	return 0;
 
 error_media_entity_runtime_pm:

-- 
2.34.1

