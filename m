Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370E348094A;
	Tue, 21 Jul 2026 10:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784629753; cv=none; b=JNPhJ5+JFC7Sb9+1YT9JMIwFUWO7nyxQmwYnqQaoVRMhMzc1qKLwDzb6zYsirPkQrrX6M4PR+3ODuRDXDR5ma3y/IAwOZB5VaNcJfAZSQidScIcK6ZOGwmO8BaodwniJbMOMrvZhu80IS82R/GWlUfMH4YBsdHi2WqIVugf7ceQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784629753; c=relaxed/simple;
	bh=QjMhShKxO3OGwWri1KKz/lfCQ4br/t2CuT6xsbob8cw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=HOYSXAU6cSeQd6cVIlSu7V3xc42eoXgEfD1VVRCJn+dn68v1darDC7FUQYbRiOhPLskbGZmHUBH+WOIv65qrAW9KC+T8QxPlcCc4A7wmL93zYwsBA2az+hZJ0NRipuf3Mt9rxLcbR3bmM6TtFQ0MKDwt95I9YHCgndGbNABrA00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=JAXQhJcL; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="JAXQhJcL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1784629754; x=1816165754;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=QjMhShKxO3OGwWri1KKz/lfCQ4br/t2CuT6xsbob8cw=;
  b=JAXQhJcLhmn6IGQUN8RxgA+TCN3MspjNQnvLvyGMspwm8awaLwdxz5yZ
   Ze17p6eSXg2cvTTtQVVW3TpEklIqJ6eKDQpZmbFZmoMdqJbVh/MoK3STE
   k71VsKM/FD59SMD4ENHmATUQIfqb6EvjNGfgPCzYFuNDLixvZj+lHjFfX
   O1ZcIAWSOmfwvhZtfBR2j1He1hqtaeVCVME2Wo5yFHVP9d9famAi93GY9
   smNGYGkiYZ/mulXGI6vcBEAsq0Np8zisqOR14XG93jOR8MOLMrR26n3/O
   XIKJFFIf9c7y0fQnHW+Fjyy7DCGHC056PDFeL2LgDLCD1KoAV875jwPac
   g==;
X-CSE-ConnectionGUID: /K1VPm7KQJy0aVhXlOXhzA==
X-CSE-MsgGUID: xCacKeDEQ/aCSNRIhayFVQ==
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="61253554"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 03:29:14 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.43; Tue, 21 Jul 2026 03:29:11 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 21 Jul 2026 03:29:07 -0700
From: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Date: Tue, 21 Jul 2026 15:58:57 +0530
Subject: [PATCH v3 03/10] media: microchip-isc: synchronize the IRQ before
 disabling clocks on stop
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260721-balki-isc-prefix-fixes-v1-v3-3-ffe10640a2d9@microchip.com>
References: <20260721-balki-isc-prefix-fixes-v1-v3-0-ffe10640a2d9@microchip.com>
In-Reply-To: <20260721-balki-isc-prefix-fixes-v1-v3-0-ffe10640a2d9@microchip.com>
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

Fixes: 91b4e487b0c6 ("media: microchip: add ISC driver as Microchip ISC")
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
index 4079c79cb668..3245dd7cb980 100644
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
index 97752eca6d6b..5d49b9d48f57 100644
--- a/drivers/media/platform/microchip/microchip-sama5d2-isc.c
+++ b/drivers/media/platform/microchip/microchip-sama5d2-isc.c
@@ -438,6 +438,8 @@ static int microchip_isc_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
+	isc->irq = irq;
+
 	ret = devm_request_irq(dev, irq, microchip_isc_interrupt, 0,
 			       "microchip-sama5d2-isc", isc);
 	if (ret < 0) {
diff --git a/drivers/media/platform/microchip/microchip-sama7g5-isc.c b/drivers/media/platform/microchip/microchip-sama7g5-isc.c
index 1f5debb74f18..4f9e9a5ed4d1 100644
--- a/drivers/media/platform/microchip/microchip-sama7g5-isc.c
+++ b/drivers/media/platform/microchip/microchip-sama7g5-isc.c
@@ -427,6 +427,8 @@ static int microchip_xisc_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
+	isc->irq = irq;
+
 	ret = devm_request_irq(dev, irq, microchip_isc_interrupt, 0,
 			       "microchip-sama7g5-xisc", isc);
 	if (ret < 0) {

-- 
2.34.1

