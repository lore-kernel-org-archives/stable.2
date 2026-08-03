Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9FC374A0A;
	Mon,  3 Aug 2026 10:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785752461; cv=none; b=f/FoX4Q00LC/RejuBFzJNBZMq0qhkwr3mKBgAlSP53LdkZ0b01s5bH2tqxEz9zDJc8lSmxsSB4lw0RMSK5P02MTAcAkIXeZm6r0l2Dt7bsdkqd05VyPoa85wVrBoor1wLYDNoUbVVk2keEO9i02+McuuMgEaAkjGYzAgWiN4rcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785752461; c=relaxed/simple;
	bh=YHLTsSgBycIo95LkRYRc4Yf6aA1AkFQaeRYrKiSJK50=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=dnTXHHOIXQesAWN1TV41PcYTESQQ56c/p/8bx06v/PgGxstW/ucZ7e9SEfzisfVQ2qwxcdtXUBAmkP1+3AhryBfLHw0zZ/tAaTWdTfkFQZfjDSFbtSQvuz4prh9iOEVTsndXxH4oU8Dikh/oaBq8my6U0ylrdp/G0K8ubt6eldA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=0MpKkkXn; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="0MpKkkXn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1785752460; x=1817288460;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=YHLTsSgBycIo95LkRYRc4Yf6aA1AkFQaeRYrKiSJK50=;
  b=0MpKkkXntTfUM500C84auCXtXxU1viHfoqibc0iXju+n19IVo3Ghc9tt
   nEUr9IdUucnp4HCZdn4GdmSJr0cTOwDlZOD85pdDT2XWdziH9S73ty11C
   jsXNh7Yz5HCDRSgouhkwZyTt5dd7LQsgTOcCI08xR8Sigi0TwcYJ5Dpno
   mdaYhbhUDGkgjCVgcqVHUgx11OzoLhT+V/fRZ8QvL6VCBK/0cLXaNB2Qt
   jC7Q0NLeK3X3raw/8QoKRSky8NY8v/Srh8UQP6Tiwq/U7paGPFSD5X0zR
   Qb+Q8eJajFEMNGaaYraxFz9WVX2fCqmkYYXk/JmEWyOXETtUgsxH8bqxD
   w==;
X-CSE-ConnectionGUID: WXuNkdtESBaPX8K/sxoLvw==
X-CSE-MsgGUID: s2qOamZpShaGBuDNZ2RR/A==
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="228697301"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Aug 2026 03:20:59 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 3 Aug 2026 03:20:58 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 3 Aug 2026 03:20:55 -0700
From: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Date: Mon, 3 Aug 2026 15:50:39 +0530
Subject: [PATCH v4 04/10] media: microchip-isc: disable histogram and flush
 AWB work on teardown
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260803-balki-isc-prefix-fixes-v1-v4-4-f625d6aa0ae1@microchip.com>
References: <20260803-balki-isc-prefix-fixes-v1-v4-0-f625d6aa0ae1@microchip.com>
In-Reply-To: <20260803-balki-isc-prefix-fixes-v1-v4-0-f625d6aa0ae1@microchip.com>
To: Eugen Hristev <ehristev@kernel.org>, Mauro Carvalho Chehab
	<mchehab@kernel.org>
CC: Hans Verkuil <hverkuil@kernel.org>, Sakari Ailus
	<sakari.ailus@linux.intel.com>, <linux-media@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Balakrishnan Sambath
	<balakrishnan.s@microchip.com>, <stable@vger.kernel.org>
X-Mailer: b4 0.14.3

isc_stop_streaming() and the isc_start_streaming() error path dropped the
runtime PM reference with the histogram still enabled. A HISDONE firing
just before the stop, or a failed isc_update_profile() on the start path,
can queue isc_awb_work(), which reads the histogram registers before
taking its own PM reference and faults on the unclocked device.

Disable the histogram, synchronize the IRQ and flush the work before
dropping the PM reference on both paths. synchronize_irq() must come
before cancel_work_sync(), so an in-flight handler cannot re-queue
awb_work after it is cancelled.

Fixes: 93d4a26c3dab ("[media] atmel-isc: add the isc pipeline function")
Cc: stable@vger.kernel.org
Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
---
 drivers/media/platform/microchip/microchip-isc-base.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/media/platform/microchip/microchip-isc-base.c b/drivers/media/platform/microchip/microchip-isc-base.c
index debbc38717de..54f3093e14fc 100644
--- a/drivers/media/platform/microchip/microchip-isc-base.c
+++ b/drivers/media/platform/microchip/microchip-isc-base.c
@@ -382,6 +382,13 @@ static int isc_start_streaming(struct vb2_queue *vq, unsigned int count)
 	return 0;
 
 err_configure:
+	isc_set_histogram(isc, false);
+
+	/* let a running IRQ handler finish before the clock is disabled */
+	synchronize_irq(isc->irq);
+
+	cancel_work_sync(&isc->awb_work);
+
 	pm_runtime_put_sync(isc->dev);
 err_pm_get:
 	v4l2_subdev_call(isc->current_subdev->sd, video, s_stream, 0);
@@ -425,9 +432,13 @@ static void isc_stop_streaming(struct vb2_queue *vq)
 	/* Disable DMA interrupt */
 	regmap_write(isc->regmap, ISC_INTDIS, ISC_INT_DDONE);
 
+	isc_set_histogram(isc, false);
+
 	/* let a running IRQ handler finish before the clock is disabled */
 	synchronize_irq(isc->irq);
 
+	cancel_work_sync(&isc->awb_work);
+
 	pm_runtime_put_sync(isc->dev);
 
 	/* Disable stream on the sub device */

-- 
2.34.1

