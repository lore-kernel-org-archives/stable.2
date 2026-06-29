Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0E3370AC1;
	Mon, 29 Jun 2026 11:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782731409; cv=none; b=ZGoFrk7Zy7zDUzRnnBBRbrFDtNbVIP70qT+OJoPIIQ6TxLJWJJbX5BPRJW3xADxZ+Hif1h8suqjEPX7/qt/YsJTpzWPlEgdcplkqbQtTB7LClkdq5df0ebQ0Yw/DDLWX9jW8REWDUf/qTJaATRCmHoc4vrxK9CtD/aob6VvgTRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782731409; c=relaxed/simple;
	bh=97gjSRFLW+WV1vqO3pAl6R/Yqwn4HK36ZjcyuF/eGIs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=UZEcVqkmq4P7EugN2tw+EaCKyCZ+jDKE/2+kTdpfrywIPSU+0o2pU4s2UyLDKbHeBGQKNNw3ltKlS7WuDufe7YKhZOvgYY7Mr8MiArbk2G2m3Tvrx3Bwro15lMpuSHuDT0jVCfBd8NGTbS2+8fE0xfW2Is9RbUpu3ySJmcxxe10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ptIJPe3N; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ptIJPe3N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1782731408; x=1814267408;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=97gjSRFLW+WV1vqO3pAl6R/Yqwn4HK36ZjcyuF/eGIs=;
  b=ptIJPe3NWn0Pzpx68q34omW/x9RfqZ4r0wPLywskfUq8H3DmYV51jSYR
   D02efT8tq+mFgKtgVGwUA/+bFNRtXyY3TXeJWwd6/phS2HgxUTcm6va+j
   Tuyw1/yK3sVFMpI+3i4/WUkXY80PiZ/dWJ6h4truJHFnpDU0n9UHoTw1y
   nVKSlNwwD0oHG4p5sldVcincec7MFU9D6e+mPI7RcFNO/F2T4TcrKp+qu
   tvuwEYjnxeP4X1u07rGv09Lw7ekHDIbdcan5PqlosUpv8BSWl9dO03CYH
   ORGbOoZEixH+hoFxQnHQ5iha2X91nMc542CjRKkcC4786Ew4bNL9QpLWc
   g==;
X-CSE-ConnectionGUID: 2R1XcyI6SfWTmVxjRinPxg==
X-CSE-MsgGUID: Iw9tvSUFSICFBVjbD84e0Q==
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; 
   d="scan'208";a="59817901"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jun 2026 04:10:08 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 29 Jun 2026 04:10:07 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 29 Jun 2026 04:10:04 -0700
From: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Date: Mon, 29 Jun 2026 16:39:35 +0530
Subject: [PATCH v2 10/10] media: microchip-isc: fix WB offset and gain
 register field masking
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260629-balki-isc-prefix-fixes-v1-v2-10-3b120cc3742f@microchip.com>
References: <20260629-balki-isc-prefix-fixes-v1-v2-0-3b120cc3742f@microchip.com>
In-Reply-To: <20260629-balki-isc-prefix-fixes-v1-v2-0-3b120cc3742f@microchip.com>
To: Eugen Hristev <ehristev@kernel.org>, Mauro Carvalho Chehab
	<mchehab@kernel.org>
CC: Hans Verkuil <hverkuil@kernel.org>, Sakari Ailus
	<sakari.ailus@linux.intel.com>, <linux-media@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Balakrishnan Sambath
	<balakrishnan.s@microchip.com>, <stable@vger.kernel.org>
X-Mailer: b4 0.14.3

ISC_WB_O_* and ISC_WB_G_* pack two 13-bit fields per register. Sign
extension from negative offsets corrupts the upper field. Mask both
fields to 13 bits before packing.

Fixes: 91b4e487b0c6 ("media: microchip: add ISC driver as Microchip ISC")
Cc: stable@vger.kernel.org
Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
---
 .../media/platform/microchip/microchip-isc-base.c  | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/microchip/microchip-isc-base.c b/drivers/media/platform/microchip/microchip-isc-base.c
index 1a9b97edfa32..79a58efb6333 100644
--- a/drivers/media/platform/microchip/microchip-isc-base.c
+++ b/drivers/media/platform/microchip/microchip-isc-base.c
@@ -62,18 +62,24 @@ static inline void isc_update_awb_ctrls(struct isc_device *isc)
 
 	/* In here we set our actual hw pipeline config */
 
+	/*
+	 * Offsets are 13-bit signed fields [12:0] and [28:16]. Cast to
+	 * u32 and mask to 13 bits so sign extension of a negative value
+	 * cannot corrupt the adjacent field.
+	 */
 	regmap_write(isc->regmap, ISC_WB_O_RGR,
-		     ((ctrls->offset[ISC_HIS_CFG_MODE_R])) |
-		     ((ctrls->offset[ISC_HIS_CFG_MODE_GR]) << 16));
+		     ((u32)ctrls->offset[ISC_HIS_CFG_MODE_R] & GENMASK(12, 0)) |
+		     (((u32)ctrls->offset[ISC_HIS_CFG_MODE_GR] & GENMASK(12, 0)) << 16));
 	regmap_write(isc->regmap, ISC_WB_O_BGB,
-		     ((ctrls->offset[ISC_HIS_CFG_MODE_B])) |
-		     ((ctrls->offset[ISC_HIS_CFG_MODE_GB]) << 16));
+		     ((u32)ctrls->offset[ISC_HIS_CFG_MODE_B] & GENMASK(12, 0)) |
+		     (((u32)ctrls->offset[ISC_HIS_CFG_MODE_GB] & GENMASK(12, 0)) << 16));
+	/* Gains are 13-bit unsigned fields [12:0] and [28:16] */
 	regmap_write(isc->regmap, ISC_WB_G_RGR,
-		     ctrls->gain[ISC_HIS_CFG_MODE_R] |
-		     (ctrls->gain[ISC_HIS_CFG_MODE_GR] << 16));
+		     (ctrls->gain[ISC_HIS_CFG_MODE_R] & GENMASK(12, 0)) |
+		     ((ctrls->gain[ISC_HIS_CFG_MODE_GR] & GENMASK(12, 0)) << 16));
 	regmap_write(isc->regmap, ISC_WB_G_BGB,
-		     ctrls->gain[ISC_HIS_CFG_MODE_B] |
-		     (ctrls->gain[ISC_HIS_CFG_MODE_GB] << 16));
+		     (ctrls->gain[ISC_HIS_CFG_MODE_B] & GENMASK(12, 0)) |
+		     ((ctrls->gain[ISC_HIS_CFG_MODE_GB] & GENMASK(12, 0)) << 16));
 }
 
 static inline void isc_reset_awb_ctrls(struct isc_device *isc)

-- 
2.34.1

