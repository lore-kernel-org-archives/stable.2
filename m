Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795095666;
	b=c14NHKNkl8D5PpRp5HNjiBfE8OdpunmVLZZ1fwEQvugrEWo8LznylLTTJI0tavktz1eV
	 0TgN0HztTg45VGkUouOcxIi8ThMRGf0rwINN/F5nAynsd0VRmum8LFuUrtRg54jMAl7/D
	 1cp7IIRTJT2iM9D6jJvyJjOHv0XznkgOwDu5nG6y+l9ffYz4sHPaf8WnAYUBku7CzItfc
	 b8HkYBr5SX8SXbewpYz73gNwuGzjI601i3lbLVnrGTFRSQK8Up9Y52RkXjdU0P4Q69lov
	 oTPYXOa2coD83rvDN2ImdGc6iwe+Fa3ZIsqOyZ7ISEMqDYfRNsWEEx+J3W5pKpRpqNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795095666;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=mhjd7qCe3jh9JBU7wRsKPF670mA/VW55TzY1RTvEnYI=;
	b=la3k49zS2vI/mrU4qScrilu0tpuP+NEtGeskPU8nRjBbRs4ki8pXRVk7o7IGVT6G/XL8
	 x2bHoMIrVn1iTupxsLq6wa/xUMTZfcFFQY1bBXQCMG0I2QtvEcT0vgwOf00l4jCzFFRvK
	 +68oiDN+mQI7fEj9rmpoSA0PzukDqdCgHVMRA0nvbn3/cqs9HoNTRjr+Fc9jc+ASzleo6
	 nmo+X1FQIZREpbrld+r6GRGXmNk9j6wggYTjgXOdvk3JuGW2Gv8KaOYuIRZhUdORMSxAH
	 LomnZi8rUry0xyqXXQdRS0wva1gEue5HMEwTkunGQQsyrzXb/Kb3BXQ26f3n1JLL9mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="e/U05xbt";
	arc=none smtp.remote-ip=209.85.222.51
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1EF606A33F
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 13:41:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED1EF606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e/U05xbt
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-99ac154431bso442569241.0
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 05:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795095663; x=1795700463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mhjd7qCe3jh9JBU7wRsKPF670mA/VW55TzY1RTvEnYI=;
        b=e/U05xbtSd5otnBRhSiLYb+iTFeJTRE5BGOH6JDpCrPI1tCFJwmhSxgCrWtid+bsCt
         SoVcOibC0+QUBOfu4+XtDZ2Dj7UMPUmNjiv+zlAsddzHWkM1+U+qv79x896tQdrqO2Xz
         AfW6HKqDmotgN1VrKLRA1u3udVKhLw+fMsrri8JnN/AnmfGhtmcH97/ED6DGjsEyHWUn
         rGEo71AaZyzQ4bBbusDudUZ1VpTsl22I7vE9QVxWRd6uGfHbVcjRyZ6Nixc/OO0xCA3d
         /0tjfc8h2I9/xz0a104M7JuH9h2jQFE0+psja0IrLv5w6o45VywGiOukFkvDn9XBovKG
         DjRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795095663; x=1795700463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mhjd7qCe3jh9JBU7wRsKPF670mA/VW55TzY1RTvEnYI=;
        b=QSyhigEdEfNdkPdGZYVFHitHljHT6G7Ys+RXaavDjDjLbk2YhBXOCzjwyN9pM/ViHa
         joRUY6ZLg3e8u9cUvT9XdkPl4pqvCtjOfEVW6FMlQQ9UWfS8bxbxUn8P5GpVTkVNaSNf
         y1/o1qKuKojop9Iq0OoS4oifELUvrT8KVqM+vWFDXn/GGEAZGcSKdGVSLRBOc/GTdlBK
         X7HL2lPdcnloQHmMycxRiM/mAFlrZRdjcB50egAQJHcSQdBjDb2amTICY1m7e/TP2s2A
         +Ta6w1qFBPUcz51YBcPzYzOD9tjlsNll/tBxFavhWHvQ25S8VeTkV4s4NwPUCmpjqIpr
         Up9w==
X-Forwarded-Encrypted: i=1; AL+hErGVYUvXnO8Gxdn4pJ9E6aXdTc7/IBGwP44KKUAn4VXdUQc/9QI3w9LiY9+AjeXfTLVqKbYELjg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/PVyuIJq2jnznOs7oYe+xCzgKoZDgahcYxa91DqQ17yFT92LEJ
	W1BGV9U15U2vcWA2HNdv0xPwTwdB9Mi260/+z86Fr2RSqoT/dFpRcBSZ
X-Gm-Gg: AYBFou2L+IKyFUoG99/uThCB0fumLcU7Saf/my0WKC51EgClPaB4nP9tkfejBXalPTn
	yweLO1pI13IrQj1g34xius1rc1nKmKD9zDylw1obJz0RuhPhOIVgInm+8hB24hUcYXRXEVjbBi1
	6MxlwVcKttVFZoxr0ytwiSROVgVJMlt7HXZwVOgFcgqUKUN3Lc7wpRpHfv8GBz1UqO0syUEBgfD
	NMdKZyMLKYGN4V25VoEenocF6LeO0eUODNk2TnAOGX8vzwu95wVHDBKYqUpCVQlPbY9Oz06OTXj
	woGAzL49uLMMnAMnk9k21nbOHAWwfzvvYP+8b7C+B1B3yI9+8MZ+cfu7VQCqpFhJjIY6kC2LQrK
	fpRea8TynvkPwZegAxP+z3mfjgbFKKmSjuw0oclwuf9bvqT6hGZmQvnyGNUYKlNsvMr0Rt3CvP9
	M3YWxTZ4yWVURhv4sBNz7ih/QSP6hSVcR1RUWgIV6TlJyI0OT9DHZzKuuZYTj7F9PfxZJqmRQMV
	lu9x5OG+rjpF/wiGkQX5MEDOv4NakEu5BbqjMGQuyUEsqAHosu7avLmwloY+/V+jDsCbzvZ3V2E
	2Q2LgU7QTd/B7eheCH680h470lmnGfSjgcrHk7Xp8JcSNppbIMjuC32m52uuDj5lvcTXJ4/bKBW
	wCa05/TDbwH9TdE8e5PA=
X-Received: by 2002:a05:6102:54a8:b0:7d0:6db8:dc3d with SMTP id ada2fe7eead31-7d6ba191168mr2215348137.5.1795095662707;
        Thu, 19 Nov 2026 05:41:02 -0800 (PST)
Received: from fabio-X870-EAGLE-WIFI7.tail2bb604.ts.net ([2804:1b3:a803:a13e:f40:91:660f:4d51])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e4a240ac5sm4134862241.7.2026.11.19.05.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 05:41:02 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: lee@kernel.org
Cc: maz@kernel.org,
	andy@kernel.org,
	jic23@kernel.org,
	dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-iio@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	crofts@kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	Fabio Estevam <festevam@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 2/4] iio: adc: mxs-lradc: Fix trigger use-after-free on removal
Date: Thu, 19 Nov 2026 10:40:39 -0300
Message-ID: <20261119134041.16611-2-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119134041.16611-1-festevam@gmail.com>
References: <20261119134041.16611-1-festevam@gmail.com>
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

The LRADC trigger is devm-allocated against the IIO device, but it is
manually unregistered after iio_device_unregister(). The latter deletes
the IIO device and releases its managed resources, freeing the trigger
before mxs_lradc_adc_trigger_remove() accesses it.

Since commit 699fb50d9903 ("drivers: base: Free devm resources when
unregistering a device"), device_del() releases managed resources.
Consequently, iio_device_unregister() drops the trigger's allocation
reference before the driver unregisters it.

On an i.MX28 EVK with KASAN enabled, unbinding the LRADC parent with:

  echo 80050000.lradc > /sys/bus/platform/drivers/mxs-lradc/unbind

reports a slab-use-after-free in device_release_driver_internal().

Allocate the managed trigger against the platform device instead. This
matches the trigger device's parent and keeps the allocation alive until
the platform driver's remove callback has unregistered the trigger.

Cc: stable@vger.kernel.org
Fixes: 699fb50d9903 ("drivers: base: Free devm resources when unregistering a device")
Signed-off-by: Fabio Estevam <festevam@gmail.com>
Reviewed-by: Joshua Crofts <crofts@kernel.org>
---
Changes since v4:
- None. Only collected Joshua's tag.

 drivers/iio/adc/mxs-lradc-adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
index dda5182a5076..64dd3a9995ff 100644
--- a/drivers/iio/adc/mxs-lradc-adc.c
+++ b/drivers/iio/adc/mxs-lradc-adc.c
@@ -454,7 +454,7 @@ static int mxs_lradc_adc_trigger_init(struct iio_dev *iio)
 	struct iio_trigger *trig;
 	struct mxs_lradc_adc *adc = iio_priv(iio);
 
-	trig = devm_iio_trigger_alloc(&iio->dev, "%s-dev%i", iio->name,
+	trig = devm_iio_trigger_alloc(adc->dev, "%s-dev%i", iio->name,
 				      iio_device_id(iio));
 	if (!trig)
 		return -ENOMEM;
-- 
2.43.0

