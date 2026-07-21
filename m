Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A366F4C6F16;
	Tue, 21 Jul 2026 10:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784629757; cv=none; b=nyb8tFXWFcMLxjYmNLgw5RzzIiQEsV75/gbYdaJjhrPj82c7IwJjHv12XrTL9mtje4+48v1H69UbmoDHFwjTvV6Yg3i1sbWmcFtpWnJKCdo6ARhn4kfe/TU/csWKgWkQCp3qku/BoAuKjGWF+zeEuTwXxmb6BLiFxu914jDEzdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784629757; c=relaxed/simple;
	bh=esMQmpoz+9HrMhUVsd3LDBeCJbI/0R/M4IlECi5M2E8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=sYZ+rSLWPmaB6fWVRnE/P1ME+4wU+unWU5bX8Z5xyCNPz4/5zZEMFQk37RWwwNe1qDiLzGg98xuwyWQcfCULzOdxKKhvth366t2GaRt1sRz2m2i4L+emrdLL+5oQUYC+c1z7ftnjQR6esMiA3PtzQgS9uU8hyLSLArC+rJ8DKXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=jS80dxPy; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jS80dxPy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1784629755; x=1816165755;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=esMQmpoz+9HrMhUVsd3LDBeCJbI/0R/M4IlECi5M2E8=;
  b=jS80dxPy01HeAI7iP7HkDGs89yujnHgWPhZs7kbihgris9uUskETuxKI
   r7mXQnCTUJdtVjuHWqnx+Nwg1MHtyJlKlBDF4hXx4PlMt7KFQXCT8FEVt
   kv43F0w6KqJWBkQxf5jc5oiYuPFYlFWAw4hEg+L77oPG/D5d9K5rgNrEd
   NvtMAJ5lVTvDy9TdFkQCZEyl/Ff8o3Bhu1X9fAqE11w0al/JD0taxbNse
   8+VWZdNzWLc6vwVmpTzFb/GqNvsdzCIaq/opSkWaPpJ6z7I6fCyFi45xX
   mPm3mSZSqmuIjwJrxxlVNK1TTCmPnLGduocg0FWnhLXeiRfDXbxMDBgiU
   g==;
X-CSE-ConnectionGUID: 24S+yiX3RuO97D4RBF7AxA==
X-CSE-MsgGUID: MU3U0l5fTOOM/GZfBDnsjg==
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="228086570"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Jul 2026 03:29:15 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 21 Jul 2026 03:29:15 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 21 Jul 2026 03:29:11 -0700
From: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Date: Tue, 21 Jul 2026 15:58:58 +0530
Subject: [PATCH v3 04/10] media: microchip-isc: disable histogram and flush
 AWB work on teardown
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260721-balki-isc-prefix-fixes-v1-v3-4-ffe10640a2d9@microchip.com>
References: <20260721-balki-isc-prefix-fixes-v1-v3-0-ffe10640a2d9@microchip.com>
In-Reply-To: <20260721-balki-isc-prefix-fixes-v1-v3-0-ffe10640a2d9@microchip.com>
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

