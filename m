Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DCE846A;
	Mon,  3 Aug 2026 10:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785752479; cv=none; b=WS99IdtZghfuSjPWMK2Et9StGSzENTAuht/7IShr5QmHgMCOgOkglk2i+vKY3ksfMIWniErUVHMVXlFZnTY51B8bqrWmc6EG4rEcf1hkFcMU0GjuxKaJ4ce0hcWYDVJPa0OdJJ1u1u10zkFXdkYG8TtcmwrXZ0RCvbq3gjMbIqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785752479; c=relaxed/simple;
	bh=OPezfn5YShVyTnEObk1zNUq7MuAsqpUlF369mab+WZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=SduyesEFeek47L5UISJB+dkGprFo1fHQCQ6gnYyme+yphBR0asGvhvyqNr3KkQCwkH5VO3kFCWmhVVLGg21bhqxcqW7Mne3Ntr/rX30EUBPrQCs/kjbpTvZ1NXYHyYt+q7LwiLVF0aP10HOrykktwOWNIj8fgY67g3mDGsbRirI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=NF2CjsdZ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="NF2CjsdZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1785752480; x=1817288480;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=OPezfn5YShVyTnEObk1zNUq7MuAsqpUlF369mab+WZY=;
  b=NF2CjsdZ130UFbph6ZFrcfr+xMD/KFmbhaywvVRupeFYNzpSrkWwBhLt
   4bmsywJ9BP68edxFWnbWjW0u1XDnu3jE66l8KMiwgAryMhkR5z4UC0Xf5
   wRcmzEXwLNLGDhdh06dxUWIgO/ni0nlXVhF0Q8Agbp5rwDToKWPd72WM6
   7hrXQylNiX2V3aEA7fLS67Y6UBoXob+uYRWNYNLfmgfggoSPG74YsTPxz
   Bhiy2PFZh55nfSF7tsXzq2ObIe7nm8EZH4I+QZyNrQifM4p/W1PUDuB2e
   0kwiIQRUzFOHwXy2qevbVDOOzrSxeP5EZZTZ/m1mXyRyFY9iZJS2EGh8e
   w==;
X-CSE-ConnectionGUID: r60qxmzsSpW94AYcWONJCg==
X-CSE-MsgGUID: nrTXT0CUSVezpOfGQuVnOQ==
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="61870873"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Aug 2026 03:21:20 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 3 Aug 2026 03:21:16 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 3 Aug 2026 03:21:11 -0700
From: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Date: Mon, 3 Aug 2026 15:50:43 +0530
Subject: [PATCH v4 08/10] media: microchip-isc: fix PM runtime leak in AWB
 work handler
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260803-balki-isc-prefix-fixes-v1-v4-8-f625d6aa0ae1@microchip.com>
References: <20260803-balki-isc-prefix-fixes-v1-v4-0-f625d6aa0ae1@microchip.com>
In-Reply-To: <20260803-balki-isc-prefix-fixes-v1-v4-0-f625d6aa0ae1@microchip.com>
To: Eugen Hristev <ehristev@kernel.org>, Mauro Carvalho Chehab
	<mchehab@kernel.org>
CC: Hans Verkuil <hverkuil@kernel.org>, Sakari Ailus
	<sakari.ailus@linux.intel.com>, <linux-media@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Balakrishnan Sambath
	<balakrishnan.s@microchip.com>, <stable@vger.kernel.org>
X-Mailer: b4 0.14.3

Early return when streaming stops skips pm_runtime_put_sync(),
leaking the reference and preventing runtime suspend.

Fixes: 314c96e5203d ("media: atmel: atmel-isc-base: use mutex to lock awb workq from streaming")
Cc: stable@vger.kernel.org
Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Reviewed-by: Eugen Hristev <ehristev@kernel.org>
---
 drivers/media/platform/microchip/microchip-isc-base.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/microchip/microchip-isc-base.c b/drivers/media/platform/microchip/microchip-isc-base.c
index 466f15922c43..9e06b1e0d9d2 100644
--- a/drivers/media/platform/microchip/microchip-isc-base.c
+++ b/drivers/media/platform/microchip/microchip-isc-base.c
@@ -1432,7 +1432,7 @@ static void isc_awb_work(struct work_struct *w)
 	/* streaming is not active anymore */
 	if (isc->stop) {
 		mutex_unlock(&isc->awb_mutex);
-		return;
+		goto out_pm_put;
 	}
 
 	isc_update_profile(isc);
@@ -1443,6 +1443,7 @@ static void isc_awb_work(struct work_struct *w)
 	if (ctrls->awb)
 		regmap_write(regmap, ISC_CTRLEN, ISC_CTRL_HISREQ);
 
+out_pm_put:
 	pm_runtime_put_sync(isc->dev);
 }
 

-- 
2.34.1

