Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C7B3B3C1B;
	Mon, 17 Aug 2026 06:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786949543; cv=none; b=rACO3ItPA18aL9fP38Zr341jbt3NFJKDtBfbq9gY885uoKIzVMMenPCfB9l9kNjsJEtPlPPnIyebSQL6hbe5BVxNHZN77pr4lH8D2ibP2NjbVzNYV+d5on21Mh8HRqxhBddjQTj7LhU0Vr45/dNUSaSoVewMagjJoTTE9cJqrvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786949543; c=relaxed/simple;
	bh=JRU2XAxRSOjhBWgRSicm4i31gBEucOZSJGhB6Z1kwDs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=F0FQF99Dzrj7vkk1rKrkGrDDKzDi5TQXfz5EtvONp3fXujZLAjigmJ/ckYLL7rIIKAPVVxeGDRaXQR6L2VcKPrDH3bAWA42/khumUbawChEK4/R1PMoeZ03pkgzV67CfsPrBm3EUOjiW9xcYeTKh4HCPRBSV7RruNa//1VbT/PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=sdERXfIi; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="sdERXfIi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1786949542; x=1818485542;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=JRU2XAxRSOjhBWgRSicm4i31gBEucOZSJGhB6Z1kwDs=;
  b=sdERXfIiW5qY1xyxAweX8587kG5TZmLKEh3IK8eqBLD+gq3IBx8Tbp7a
   ihy9e+PdN4T4RxEIJI+JX3wtn7PXVWbd5FGdDefiixoz4NtTayvZdwcf3
   G0GGpPCC9W83tg0O7tdA9UdL8KYReGNVDtfqvQF2FtaP2pGqOI0DaFxwE
   8kHfBXCbFLX/VN41/U29dTfi9dNtFE7foP/C8V8pBQIBnpZ6LiVTnbWrR
   Ie97t6xoX+0KvuBfbVep2l+GJd7OWxKs7PGkNH5IGNWKTtGnlurIU+vmF
   davpxX32JGfiXy3siOfDha6ZsvCbIG7moHBFAZ8lFXcP2LHh6E94JKxuo
   A==;
X-CSE-ConnectionGUID: 3HJdlEjFQ0SDAbuD/recGA==
X-CSE-MsgGUID: duOs5jr5RZqehxp5QlRZtg==
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="61331926"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2026 23:52:18 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Sun, 16 Aug 2026 23:52:17 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Sun, 16 Aug 2026 23:52:13 -0700
From: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Date: Mon, 17 Aug 2026 12:22:00 +0530
Subject: [PATCH v5 03/10] media: microchip-isc: synchronize the IRQ before
 disabling clocks on stop
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260817-balki-isc-prefix-fixes-v1-v5-3-2514df336c5e@microchip.com>
References: <20260817-balki-isc-prefix-fixes-v1-v5-0-2514df336c5e@microchip.com>
In-Reply-To: <20260817-balki-isc-prefix-fixes-v1-v5-0-2514df336c5e@microchip.com>
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
index 18e1ec0b94fa..5bd109e93a8f 100644
--- a/drivers/media/platform/microchip/microchip-sama5d2-isc.c
+++ b/drivers/media/platform/microchip/microchip-sama5d2-isc.c
@@ -448,6 +448,8 @@ static int microchip_isc_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
+	isc->irq = irq;
+
 	ret = devm_request_irq(dev, irq, microchip_isc_interrupt, 0,
 			       "microchip-sama5d2-isc", isc);
 	if (ret < 0) {
diff --git a/drivers/media/platform/microchip/microchip-sama7g5-isc.c b/drivers/media/platform/microchip/microchip-sama7g5-isc.c
index d0b91a74bb1a..3ebcbc1bb5a5 100644
--- a/drivers/media/platform/microchip/microchip-sama7g5-isc.c
+++ b/drivers/media/platform/microchip/microchip-sama7g5-isc.c
@@ -437,6 +437,8 @@ static int microchip_xisc_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
+	isc->irq = irq;
+
 	ret = devm_request_irq(dev, irq, microchip_isc_interrupt, 0,
 			       "microchip-sama7g5-xisc", isc);
 	if (ret < 0) {

-- 
2.34.1

