Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBB63B42E4;
	Mon, 17 Aug 2026 06:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786949550; cv=none; b=BHd7T436XRx+Eo9U1TozA43gFS/T0m0seE29eCIbxzcUJDMjsHPWdJkes9eOMY/S6NG8h6w5FWOIMyLfPEIVzpxLX4/xKX3GsxtHB6IzTje4ghf7jWx0EraDgghRN+FbuRQ/bfA87ziyUsF7Y1SnQHZlz0KkC/7u0Fmr/ax6WDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786949550; c=relaxed/simple;
	bh=xPOJ35HOfzyopP4m6pfdsZoc8SwK0XCdF18/M26yKm4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=RPDoYG07rWmYw6KtsPRSWXsVW24ujWnt+VSgqzgiTx2TT1Qj7N1doPdG2UxVm8vX2v4U1cjcFI2/kL5xxmeMo8NvR0siI/qmpj34X9noD245gkmKG/enRru264vkb730W90ycldh+AzR8op98NMLcqh+oTDw+baG67wslSrUJsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=lPiP59ls; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lPiP59ls"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1786949549; x=1818485549;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=xPOJ35HOfzyopP4m6pfdsZoc8SwK0XCdF18/M26yKm4=;
  b=lPiP59lsp97F1hEiBxeSJi1Zr4c+8qivJPG+ab08Ki8xO1EOvmhn61q2
   cwyRlTqyGyIVbnLM6259WodjqNeCMpY9vIl1F01RZJEiIfPJkh8JAuXCk
   bhkg//8m9zAG82YdT6nzKPSGgRNq778+Pww3ybv17jHund76wJF63TeFm
   Wq/NOEQOHsgygvzqpv9EKCF3IdjoIpcgYRFcNwmuM6MsEkohJsE541XW/
   CoaDe5AwT8s2Kd4g3aopYSK5Bbhl5M4yEFkaIGWx2N0JBiEZ0Jq+ojNBj
   a1dMhNPM9vj4KbvuzCQw4bdJV+nAn6ftYhgyltvuplfsKyKQxFIYgRfQf
   w==;
X-CSE-ConnectionGUID: 37ADSmV4QoSKSlZDKhr2QA==
X-CSE-MsgGUID: LMN6aFpCSQWvWLv8JwgSlQ==
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="62229705"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2026 23:52:29 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Sun, 16 Aug 2026 23:52:27 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Sun, 16 Aug 2026 23:52:23 -0700
From: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Date: Mon, 17 Aug 2026 12:22:02 +0530
Subject: [PATCH v5 05/10] media: microchip-isc: do not touch WB registers
 when not streaming
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260817-balki-isc-prefix-fixes-v1-v5-5-2514df336c5e@microchip.com>
References: <20260817-balki-isc-prefix-fixes-v1-v5-0-2514df336c5e@microchip.com>
In-Reply-To: <20260817-balki-isc-prefix-fixes-v1-v5-0-2514df336c5e@microchip.com>
To: Eugen Hristev <ehristev@kernel.org>, Mauro Carvalho Chehab
	<mchehab@kernel.org>
CC: Hans Verkuil <hverkuil@kernel.org>, Sakari Ailus
	<sakari.ailus@linux.intel.com>, <linux-media@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Balakrishnan Sambath
	<balakrishnan.s@microchip.com>, <stable@vger.kernel.org>
X-Mailer: b4 0.14.3

isc_s_awb_ctrl() called isc_update_awb_ctrls() unconditionally, writing
the white balance registers even when the device is runtime suspended;
on many ARM platforms accessing the unclocked registers is an external
abort. The write was also done without awb_lock, racing isc_awb_work(),
which holds it so the DMA done IRQ cannot latch a half-updated pipeline.

Write the registers only while streaming and not stopping, under
awb_lock, and update the profile there. The isc->stop check covers the
window where isc_stop_streaming() has gated the clocks but vb2 still
reports streaming. Otherwise the new values stay cached and
isc_configure() programs them at the next stream start.

Fixes: 4e52889f48fe ("media: atmel: atmel-isc-base: expose white balance as v4l2 controls")
Cc: stable@vger.kernel.org
Reviewed-by: Eugen Hristev <ehristev@kernel.org>
Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
---
 .../media/platform/microchip/microchip-isc-base.c    | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/microchip/microchip-isc-base.c b/drivers/media/platform/microchip/microchip-isc-base.c
index 0f486dd5bd82..cf4611443fd1 100644
--- a/drivers/media/platform/microchip/microchip-isc-base.c
+++ b/drivers/media/platform/microchip/microchip-isc-base.c
@@ -1511,20 +1511,24 @@ static int isc_s_awb_ctrl(struct v4l2_ctrl *ctrl)
 		if (ctrl->cluster[ISC_CTRL_GB_OFF]->is_new)
 			ctrls->offset[ISC_HIS_CFG_MODE_GB] = isc->gb_off_ctrl->val;
 
-		isc_update_awb_ctrls(isc);
-
 		mutex_lock(&isc->awb_mutex);
-		if (vb2_is_streaming(&isc->vb2_vidq)) {
+		if (vb2_is_streaming(&isc->vb2_vidq) && !isc->stop) {
+			unsigned long flags;
+
 			/*
-			 * If we are streaming, we can update profile to
-			 * have the new settings in place.
+			 * awb_lock keeps the DMA done IRQ from latching a
+			 * partially written WB pipeline.
 			 */
+			spin_lock_irqsave(&isc->awb_lock, flags);
+			isc_update_awb_ctrls(isc);
+			spin_unlock_irqrestore(&isc->awb_lock, flags);
+
 			isc_update_profile(isc);
 		} else {
 			/*
-			 * The auto cluster will activate automatically this
-			 * control. This has to be deactivated when not
-			 * streaming.
+			 * Not streaming: keep the cached values for the next
+			 * stream start and deactivate the cluster-activated
+			 * do_white_balance button.
 			 */
 			v4l2_ctrl_activate(isc->do_wb_ctrl, false);
 		}

-- 
2.34.1

