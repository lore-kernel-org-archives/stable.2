Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45B937756E;
	Tue, 16 Jun 2026 11:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781610691; cv=none; b=JTP4BXyhZVBxmKJRBUfTeArsiHnRCyuIR07DPRoJB+e6/bdvHF4UKi9421G75dN7a2BcuDsL7XQSII47L9KmGn9E31gWP5vn9jLpqdicJJLFA7hraQ3xxAZaqbf6RNnkPyAncgIctHv72pHtiSCfWjCzCStsRGY52ObPyO9DOCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781610691; c=relaxed/simple;
	bh=Rj/SqgT6htA5+kZhyMXx2ZAI1H8NS1/vLCjSrrs+I04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=m48LkF+8DlE4KC6vRoByKb2LiQbQ16suQh5nlI2Qcb/8Q4fkynTGA0Zyh31HQwdooC4cSZx9k5Y/tvHjXSCpChshAWHHJfI/3FxOwQ3oneR89xcakypTL01o5QGaSE6CEYF2T3A9DTejs+aPr9xs99ZLfOvZ8oFUulpVpq4+BAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=OahFxoSH; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="OahFxoSH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1781610683; x=1813146683;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Rj/SqgT6htA5+kZhyMXx2ZAI1H8NS1/vLCjSrrs+I04=;
  b=OahFxoSHbdkYXK8U/jCP1E1Qgx0YD3OfNMmtlHvMD6hz0foNPvmr/ikv
   fnGzg4YG1mCPrmlLCxUG2hhHAnZZ8IY1WmWWd8LIeVBIhhhlCgloIGadX
   x7Y0uLf7nyzTWiWykToBtvpK59o1EstHdrOIoqvkyJMQtHUOyMBHBEdqd
   PHU8V3Ho0fdUsMZ67VhxrjC62NpG36acMXnLpQvmSuonwfAoz2ziFUrRm
   sc467m2Z3WvfawY4tKLq+V3hg3jV7u9rdXpH3dL578ZvwozcKYhZb8v/2
   h3BEykNK/KlDlwEm4g+cY+ZvwPvEgmgzo/nkbuMXn64poDivAuYryDWef
   g==;
X-CSE-ConnectionGUID: 6gGvoQaKT9SWlbDa4J+ldA==
X-CSE-MsgGUID: 2Y5v3GX/S++MTx2jhXCpyw==
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="59581927"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 04:51:23 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Tue, 16 Jun 2026 04:51:22 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 16 Jun 2026 04:51:19 -0700
From: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Date: Tue, 16 Jun 2026 17:21:01 +0530
Subject: [PATCH 06/10] media: microchip-isc: do not touch WB registers when
 not streaming
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260616-balki-isc-prefix-fixes-v1-v1-6-b23677fc5ab6@microchip.com>
References: <20260616-balki-isc-prefix-fixes-v1-v1-0-b23677fc5ab6@microchip.com>
In-Reply-To: <20260616-balki-isc-prefix-fixes-v1-v1-0-b23677fc5ab6@microchip.com>
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

Write the registers only while streaming, under awb_lock, and update the
profile there. When not streaming the new gains and offsets stay cached
in the control state and are programmed by isc_configure() at the next
stream start.

Fixes: 91b4e487b0c6 ("media: microchip: add ISC driver as Microchip ISC")
Cc: stable@vger.kernel.org
Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
---
 drivers/media/platform/microchip/microchip-isc-base.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/media/platform/microchip/microchip-isc-base.c b/drivers/media/platform/microchip/microchip-isc-base.c
index f7fbd3cd8edc..2911cfc660a0 100644
--- a/drivers/media/platform/microchip/microchip-isc-base.c
+++ b/drivers/media/platform/microchip/microchip-isc-base.c
@@ -1509,20 +1509,21 @@ static int isc_s_awb_ctrl(struct v4l2_ctrl *ctrl)
 		if (ctrl->cluster[ISC_CTRL_GB_OFF]->is_new)
 			ctrls->offset[ISC_HIS_CFG_MODE_GB] = isc->gb_off_ctrl->val;
 
-		isc_update_awb_ctrls(isc);
-
 		mutex_lock(&isc->awb_mutex);
 		if (vb2_is_streaming(&isc->vb2_vidq)) {
-			/*
-			 * If we are streaming, we can update profile to
-			 * have the new settings in place.
-			 */
+			unsigned long flags;
+
+			/* awb_lock serialises the WB writes against the IRQ */
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

