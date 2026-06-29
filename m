Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602223FF8BA;
	Mon, 29 Jun 2026 11:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782731387; cv=none; b=QTY2I7KOFmVodubuQ+P2w//6tYldXMF1V8gyWh7TXjkW0cjbbp1PR+TeG58pyiaZYj/ia//R71BZZ2axy+ho7nCajscz0tXPVxWQ6rsB7QKeX9bZHxazgRS3jowW81ceFRYBCswMcMmNYVJnEpv/kYr4uThhYMVbLXwS6jcXHq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782731387; c=relaxed/simple;
	bh=esMQmpoz+9HrMhUVsd3LDBeCJbI/0R/M4IlECi5M2E8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=CPT/9Q3k/6JtuaA3BMe+fExUtzBFgX7SO+gmBqbOS0rXN6k3NPmGrkwGrAZCApjJxL+4VObfS95mmS2q3naM9SLUIKZjByO97f1iY6bi95WPSKXDWk4CKI6QnL83hstgwX7VkJUUCaM80rQ8Pfw4xomNW33vCe/EBxXxVOMETLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=SOePt+Hf; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="SOePt+Hf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1782731386; x=1814267386;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=esMQmpoz+9HrMhUVsd3LDBeCJbI/0R/M4IlECi5M2E8=;
  b=SOePt+HfwDSRs5zz9Vo/U0ADrOy4emtmPxhM+Xn7kT2w9B1RATZh2rGv
   2fLc1n4ZeFjmRudVDfyrUJ1TsMN0JcjS89t4JjCMp+Y1itriB73yD4TQc
   tFeNVorgPOX8mwrOCYU6mLu7JZ8V87d/gVXZ15AopwY0akI1rUde1FR8v
   nj80yxVNSUAVlmQLGlbmwHZER1AK7hwpe0ECtNhHE08MzJ7ZXNQ7AYs0Z
   ppI6d74crD4jhMI+XjjV82HXga9KHnrmzdtMHSEwxI38RQcpbJyU4aQsu
   sjjNhTqv368ITdgpMomrd+o9qw2LSY8WiTOoEBnHpKH9vQuOZ1NazUB5a
   Q==;
X-CSE-ConnectionGUID: xpRtWzXAQoqSN5vPvxSE6g==
X-CSE-MsgGUID: VNgoy6gQR6Sy/MIR9bDurA==
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; 
   d="scan'208";a="226994161"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 04:09:45 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.43; Mon, 29 Jun 2026 04:09:45 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 29 Jun 2026 04:09:42 -0700
From: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Date: Mon, 29 Jun 2026 16:39:29 +0530
Subject: [PATCH v2 04/10] media: microchip-isc: disable histogram and flush
 AWB work on teardown
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260629-balki-isc-prefix-fixes-v1-v2-4-3b120cc3742f@microchip.com>
References: <20260629-balki-isc-prefix-fixes-v1-v2-0-3b120cc3742f@microchip.com>
In-Reply-To: <20260629-balki-isc-prefix-fixes-v1-v2-0-3b120cc3742f@microchip.com>
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

Fixes: 91b4e487b0c6 ("media: microchip: add ISC driver as Microchip ISC")
Cc: stable@vger.kernel.org
Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
---
 drivers/media/platform/microchip/microchip-isc-base.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/media/platform/microchip/microchip-isc-base.c b/drivers/media/platform/microchip/microchip-isc-base.c
index 3245dd7cb980..f7fbd3cd8edc 100644
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

