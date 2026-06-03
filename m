Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C593FCB2B;
	Wed,  3 Jun 2026 06:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780469946; cv=none; b=dPbdHE9i1JgNbaxR6f2FE33Hvt0wpZ0Gq2xDfBDBiEry1hM+dewqSqJl2l2vWZ0eyu2zrGg4zRjC/04gN6Eyi5lYcq/vogrBRJw3QtWW4YagicmnGZDNVzsX5pJAwOzTbkM/2dUnc4e/4FB1fOS25lTB0AKGGCs3ymWXcsJb55s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780469946; c=relaxed/simple;
	bh=aU0h4iGXClnIzKcybJRuKFUv+3+oLLIWDAVu+DcXYDk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=WLLdLD4Lt9obB3YD07czHnrRlj+RgZbADQf8kzQRgPDnO73JVKrE37TJuVDzV5KV5ThyDMGzgMzBvV8LKgkl+mAohbbCYNy8Ita1vMVGwTnR7Y2cULaPMKtgEAoOBQTa0pdnxY1nYl1AOeHvc5GVf0Y0Jr6UM9zUJLGQdz5iGeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=j728sz3S; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="j728sz3S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1780469945; x=1812005945;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=aU0h4iGXClnIzKcybJRuKFUv+3+oLLIWDAVu+DcXYDk=;
  b=j728sz3SYbbNytzZ8+73oVzzhO/ILNl61a4j/0EO/7JpndKYzMhHxmDf
   aD06xq8y3LfRv8+NvGEBZFdm0x/X2nBnBScc+VPSyUMhYZ0+TRVoa/9u5
   Gs/1gnNC3jvD6aCwJeO4wo5mMHjfGQeIBqP8f1ryJk9RYVB2pT0tLe97c
   MgC55zlofS4M8q+ybppga3yKonCilUbD3hu+wIgQLW40daGReh0H7F2wE
   zajaAa/9S7BY7OCiRm2NFVsCCDcet8AsYv3wSN/MSJOvL1jb5faS5GZzr
   dPiR6/kPjd6PHcJKE/19u2M+Zokt5yzfxgRcfabwLH53ACsJlKf26RLsW
   A==;
X-CSE-ConnectionGUID: TXtYIKP0SHe2bq8fuLfTyA==
X-CSE-MsgGUID: xKJQL4O9Svm/JmUNsDraoQ==
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="58923862"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Jun 2026 23:59:04 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 2 Jun 2026 23:59:04 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 2 Jun 2026 23:59:00 -0700
From: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Date: Wed, 3 Jun 2026 12:28:46 +0530
Subject: [PATCH v6 03/12] media: microchip-isc: fix race condition on
 stream stop
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260603-microchip-isc-fixes-v6-3-8c3d7474a768@microchip.com>
References: <20260603-microchip-isc-fixes-v6-0-8c3d7474a768@microchip.com>
In-Reply-To: <20260603-microchip-isc-fixes-v6-0-8c3d7474a768@microchip.com>
To: Eugen Hristev <ehristev@kernel.org>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, Hans Verkuil <hverkuil@kernel.org>
CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Kieran Bingham
	<kieran.bingham@ideasonboard.com>, Sakari Ailus
	<sakari.ailus@linux.intel.com>, Balamanikandan Gunasundar
	<balamanikandan.gunasundar@microchip.com>, <stable@vger.kernel.org>,
	<linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Balakrishnan
 Sambath" <balakrishnan.s@microchip.com>
X-Mailer: b4 0.14.3

Disable histogram and drain AWB work queue before releasing DMA
buffers to prevent use-after-free if histogram IRQ fires during
stream stop.

Fixes: 91b4e487b0c6 ("media: microchip: add ISC driver as Microchip ISC")
Cc: stable@vger.kernel.org
Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
---
 drivers/media/platform/microchip/microchip-isc-base.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/microchip/microchip-isc-base.c b/drivers/media/platform/microchip/microchip-isc-base.c
index 45b94f1e89d8..b19c5a63b4bd 100644
--- a/drivers/media/platform/microchip/microchip-isc-base.c
+++ b/drivers/media/platform/microchip/microchip-isc-base.c
@@ -427,6 +427,14 @@ static void isc_stop_streaming(struct vb2_queue *vq)
 
 	mutex_unlock(&isc->awb_mutex);
 
+	/*
+	 * Disable the histogram so the ISR stops firing HISREQ, then drain
+	 * any work that was already queued before returning.  This must happen
+	 * after releasing awb_mutex because isc_awb_work also takes it.
+	 */
+	isc_set_histogram(isc, false);
+	cancel_work_sync(&isc->awb_work);
+
 	/* Disable DMA interrupt */
 	regmap_write(isc->regmap, ISC_INTDIS, ISC_INT_DDONE);
 
@@ -1519,10 +1527,17 @@ static int isc_s_awb_ctrl(struct v4l2_ctrl *ctrl)
 		}
 		mutex_unlock(&isc->awb_mutex);
 
-		/* if we have autowhitebalance on, start histogram procedure */
+		/*
+		 * If AWB auto mode is requested and we are streaming RAW,
+		 * start the histogram procedure, but only if it is not
+		 * already running. Repeated enable requests would reset
+		 * hist_id, preventing the 4-channel Bayer cycle from
+		 * completing.
+		 */
 		if (ctrls->awb == ISC_WB_AUTO &&
 		    vb2_is_streaming(&isc->vb2_vidq) &&
-		    ISC_IS_FORMAT_RAW(isc->config.sd_format->mbus_code))
+		    ISC_IS_FORMAT_RAW(isc->config.sd_format->mbus_code) &&
+		    ctrls->hist_stat != HIST_ENABLED)
 			isc_set_histogram(isc, true);
 
 		/*

-- 
2.34.1

