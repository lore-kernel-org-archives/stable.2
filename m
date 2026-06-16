Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBFC3B7750;
	Tue, 16 Jun 2026 11:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781610677; cv=none; b=rVO3FcjDYtv/uP9ZuTS4NWqYlUwkRaa+NE1caibJ3rQz4lkbd3iMpMVaq66h7/vTG1tqlw02qHfxiKZpsmMRsI4qLW7W33a4krNMznoW7i1FBaZ8RhBzFJU4stA7TFMRI24N1fCPub16MqX18NQ1+HkA5z/smmJPE7TYG4xZx/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781610677; c=relaxed/simple;
	bh=KY7BTIjQSCx4zUbVRCb2iNHs0Kl9Tilx+NsRYxSdoNE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=GihcYM/wCxbCpYoa34syGatGaI3CQfIjhOMgeSMDitb5C+4aV5wOP9peCNHAQsRYNfFdoVrweFiuXIio4ysI9bG9NQx/d4C2G9fFqy3ntpZekym4OC+eY8MBgMVEwZF/SJ5DFrZz3FwYvziz+7hFyFRuVP9/5k9B4e+WvJnJXX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ci/rp2IJ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ci/rp2IJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1781610676; x=1813146676;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=KY7BTIjQSCx4zUbVRCb2iNHs0Kl9Tilx+NsRYxSdoNE=;
  b=ci/rp2IJtqTvvSo86i3VWweZcbLAURYO45tGn4jNPth0El+yrS9JQF4q
   XllBfMgiOO+Aj+0z+Nr7mDDMYkdKDd7FtjGLR33erdlgFxKhZSfc90Tss
   a7MFQGIIcH5dwbnMi+iJ19RpMtLKC86VEX0KFiWjzHVWiuwylRrCUwggF
   VNiSabNSdIihPZAaevLE9y2zn6DW241CamWCN4GIrpRvT+DpiuONI8udJ
   ek/5pMHVKGKR5ZzUeKxgRcd0ScyPhSN/WY35A+vySAyv5uqD7YlcAFoG4
   eYH5u6AacyXI/NjDgytbBuLbQNVTccHMlwQ17C02o9NJUcd2i6wEtcuYB
   g==;
X-CSE-ConnectionGUID: il4hvp40Q/C5obPRbS5f7A==
X-CSE-MsgGUID: DgCcSEBnQBKx+UF2RuBxlA==
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="59581921"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 04:51:16 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Tue, 16 Jun 2026 04:51:15 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 16 Jun 2026 04:51:12 -0700
From: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Date: Tue, 16 Jun 2026 17:20:59 +0530
Subject: [PATCH 04/10] media: microchip-isc: disable histogram and flush
 AWB work on stop
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260616-balki-isc-prefix-fixes-v1-v1-4-b23677fc5ab6@microchip.com>
References: <20260616-balki-isc-prefix-fixes-v1-v1-0-b23677fc5ab6@microchip.com>
In-Reply-To: <20260616-balki-isc-prefix-fixes-v1-v1-0-b23677fc5ab6@microchip.com>
To: Eugen Hristev <ehristev@kernel.org>, Mauro Carvalho Chehab
	<mchehab@kernel.org>
CC: Hans Verkuil <hverkuil@kernel.org>, Sakari Ailus
	<sakari.ailus@linux.intel.com>, <linux-media@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Balakrishnan Sambath
	<balakrishnan.s@microchip.com>, <stable@vger.kernel.org>
X-Mailer: b4 0.14.3

isc_stop_streaming() masked the DMA done interrupt but left the
histogram enabled, so a HISDONE that fired just before the stop could
still queue isc_awb_work() after pm_runtime_put_sync() gated the clocks.
isc_awb_work() reads the histogram registers in isc_hist_count() before
taking its own PM reference, so the access faults on the suspended
device.

Disable the histogram and flush the work before dropping the PM
reference, mirroring the start_streaming error path.

Fixes: 91b4e487b0c6 ("media: microchip: add ISC driver as Microchip ISC")
Cc: stable@vger.kernel.org
Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
---
 drivers/media/platform/microchip/microchip-isc-base.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/platform/microchip/microchip-isc-base.c b/drivers/media/platform/microchip/microchip-isc-base.c
index 3245dd7cb980..8f255a4c4e7a 100644
--- a/drivers/media/platform/microchip/microchip-isc-base.c
+++ b/drivers/media/platform/microchip/microchip-isc-base.c
@@ -425,9 +425,13 @@ static void isc_stop_streaming(struct vb2_queue *vq)
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

