Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C1E374A0A;
	Mon,  3 Aug 2026 10:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785752457; cv=none; b=sSHDJ7a7KC+ZbORLu/oBbDmQxi4Ptt03GFIRfvK72jLQ3vJi6jpJnauHlo8cpV8Hq49zPSa/riZD07muqofOOiNgFZ90Qsf9ZoQ1d0xXAkDRZJ4ABfDcTStcEkZhdmDtoJ+GnH4hMbzeD2BLrvuYlEZaLSZTtdIVO2Dg9otykVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785752457; c=relaxed/simple;
	bh=0BF/dXdsYiEC/Tt8lDMrV8hwXEYF4zGOCWToRvpxPwI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=HowSez+47sbcmFbq0g5G0fPzd+nYmf2gIBk7zDApxKLu2AcubhoohKUZaNBIzxQA+kOk5fiBOIoDIC3JEcd493Z52B21fY2cVZurWqfJwrB/B8IoXH9gubxf2ODqh8uIcmuj3upRcUxtLc2wfUju6TuBuT3nWR2IVKmt1B0oDME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=tPpTfcup; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="tPpTfcup"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1785752455; x=1817288455;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=0BF/dXdsYiEC/Tt8lDMrV8hwXEYF4zGOCWToRvpxPwI=;
  b=tPpTfcupP1pNIUGcGH+ffP/+gAtxgQZmoaYeG86nv/MJvUKOjs3v116N
   eZVY5i73xMClDLthVwwQXGxmXwvSCtazs0y8XmNYyO54qiWwBJeYEDo69
   uzMdheVJ2WUX/jh5Yx1s6ZgCQa8axQhWxA2S143R4U5/ahdIuU8anlvLj
   pu9o81qnpN5RrpUN5gA+KcLspX/2zOCuiBElK5KuSIK5R72ERv6C/syvc
   naUbJ6iOxgxQqYMY9SJex7ApOimTJiUdeY21ytjMKPAdMbqUY5/Z4YFlx
   EIlK9TMEil21c/avmJxA+TJn1kmYk0NcQLmCWlacJRUmfZlJ2a1a18FPt
   Q==;
X-CSE-ConnectionGUID: JsRevXirQgyX+aMFRqyb4g==
X-CSE-MsgGUID: tPX0I/gCQ2KXyRH6NImDAQ==
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="71118324"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Aug 2026 03:20:54 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 3 Aug 2026 03:20:54 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 3 Aug 2026 03:20:49 -0700
From: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Date: Mon, 3 Aug 2026 15:50:38 +0530
Subject: [PATCH v4 03/10] media: microchip-isc: synchronize the IRQ before
 disabling clocks on stop
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260803-balki-isc-prefix-fixes-v1-v4-3-f625d6aa0ae1@microchip.com>
References: <20260803-balki-isc-prefix-fixes-v1-v4-0-f625d6aa0ae1@microchip.com>
In-Reply-To: <20260803-balki-isc-prefix-fixes-v1-v4-0-f625d6aa0ae1@microchip.com>
To: Eugen Hristev <ehristev@kernel.org>, Mauro Carvalho Chehab
	<mchehab@kernel.org>
CC: Hans Verkuil <hverkuil@kernel.org>, Sakari Ailus
	<sakari.ailus@linux.intel.com>, <linux-media@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Balakrishnan Sambath
	<balakrishnan.s@microchip.com>, <stable@vger.kernel.org>
X-Mailer: b4 0.14.3

isc_stop_streaming() masks the DMA interrupt and then drops the runtime
PM reference, which disables the ISC clocks. microchip_isc_interrupt()
may still be executing on another CPU at that point; it reads ISC_INTSR
over regmap, and touching the unclocked registers triggers an external
abort.

Store the IRQ number at probe and call synchronize_irq() after masking
the interrupt, before dropping the PM reference.

Fixes: 106267444f12 ("[media] atmel-isc: add the Image Sensor Controller code")
Cc: stable@vger.kernel.org
Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Reviewed-by: Eugen Hristev <ehristev@kernel.org>
---
 drivers/media/platform/microchip/microchip-isc-base.c    | 3 +++
 drivers/media/platform/microchip/microchip-isc.h         | 1 +
 drivers/media/platform/microchip/microchip-sama5d2-isc.c | 2 ++
 drivers/media/platform/microchip/microchip-sama7g5-isc.c | 2 ++
 4 files changed, 8 insertions(+)

diff --git a/drivers/media/platform/microchip/microchip-isc-base.c b/drivers/media/platform/microchip/microchip-isc-base.c
index ca4f3b5f58aa..debbc38717de 100644
--- a/drivers/media/platform/microchip/microchip-isc-base.c
+++ b/drivers/media/platform/microchip/microchip-isc-base.c
@@ -425,6 +425,9 @@ static void isc_stop_streaming(struct vb2_queue *vq)
 	/* Disable DMA interrupt */
 	regmap_write(isc->regmap, ISC_INTDIS, ISC_INT_DDONE);
 
+	/* let a running IRQ handler finish before the clock is disabled */
+	synchronize_irq(isc->irq);
+
 	pm_runtime_put_sync(isc->dev);
 
 	/* Disable stream on the sub device */
diff --git a/drivers/media/platform/microchip/microchip-isc.h b/drivers/media/platform/microchip/microchip-isc.h
index ad4e98a1dd8f..f5e322c2e36b 100644
--- a/drivers/media/platform/microchip/microchip-isc.h
+++ b/drivers/media/platform/microchip/microchip-isc.h
@@ -287,6 +287,7 @@ struct isc_device {
 	u32			dcfg;
 
 	struct device		*dev;
+	int			irq;
 	struct v4l2_device	v4l2_dev;
 	struct video_device	video_dev;
 
diff --git a/drivers/media/platform/microchip/microchip-sama5d2-isc.c b/drivers/media/platform/microchip/microchip-sama5d2-isc.c
index 532f2b50e2ea..fa06b272b25d 100644
--- a/drivers/media/platform/microchip/microchip-sama5d2-isc.c
+++ b/drivers/media/platform/microchip/microchip-sama5d2-isc.c
@@ -447,6 +447,8 @@ static int microchip_isc_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
+	isc->irq = irq;
+
 	ret = devm_request_irq(dev, irq, microchip_isc_interrupt, 0,
 			       "microchip-sama5d2-isc", isc);
 	if (ret < 0) {
diff --git a/drivers/media/platform/microchip/microchip-sama7g5-isc.c b/drivers/media/platform/microchip/microchip-sama7g5-isc.c
index 0b72a61b51ee..eef4d0f4c520 100644
--- a/drivers/media/platform/microchip/microchip-sama7g5-isc.c
+++ b/drivers/media/platform/microchip/microchip-sama7g5-isc.c
@@ -436,6 +436,8 @@ static int microchip_xisc_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
+	isc->irq = irq;
+
 	ret = devm_request_irq(dev, irq, microchip_isc_interrupt, 0,
 			       "microchip-sama7g5-xisc", isc);
 	if (ret < 0) {

-- 
2.34.1

