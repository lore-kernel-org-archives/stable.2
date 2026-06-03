Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880D0400E07;
	Wed,  3 Jun 2026 06:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780469955; cv=none; b=NpYM+JHXdHH3AWTFqpb8uombG0FVmoMhJ0lMNfyZiZ6s2TGgm2TadnWKG++lbOuCPu7NVsXXu2SNItEQMcSntY4lDxMrvPqZl/Sdk9+RZulQa87mGi3+mmtR23MZ6xbSqQTwnauYsmapCJ7AvkYZRDBZSsOxeyW8U+tycpr512w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780469955; c=relaxed/simple;
	bh=TI1iNEvY1iPC+uZfaJWnSCIviEGgxxp4xuK+4l4OgaY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=GUh3AIsR3SwEa1gajb9eWu+4hUC+vzOS0NjFMDP83c8Sn8NvQHwRrmKr59K5FyF1f2lptIDLv6vHcUu+BlXNTm6IQR1RotqkZLg8bRCXnzlMxSKRKNurxuO+rBWVRMi7njALhuJ+aKbAujxAkfKiWHWM7YH5QjZ21vzTYZrJcJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=BUmS79ll; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="BUmS79ll"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1780469955; x=1812005955;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=TI1iNEvY1iPC+uZfaJWnSCIviEGgxxp4xuK+4l4OgaY=;
  b=BUmS79llVMrHzYxyGehxxBNTeVgQ9qHTFafA5LRW3/zVOU8BlCMODlmz
   EpYEnaYHWg/Fr2kEu6j2Wh4YGdfqBXoRapmb8XbBVGwKK8WUvwHZItIOG
   x4BJgUFPoYcOB/Nn3ynA7wNHXPTVr8sSlwOjyWcvreIQ5v7yyDauI4nvZ
   Xu+YlVP3/l4oIm1VbFg5ei2sA944PlYE/lJck5dTqKirBdGkgNBC7voPd
   alhk/blffEC+gAZZ+V9Lb3Btp/zVQ4zynyiRg1hNiFtbUp39tq2qjXlSG
   HHkQQ6G7faKnSqtgOmbbhokkfeeaF9nQCCnYs3R/KPXDMXw8Ml17SMfox
   A==;
X-CSE-ConnectionGUID: sp1IFumaSs6k0MVWNy9PuQ==
X-CSE-MsgGUID: SmO4lR3KSnGZQTHMmME/ow==
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="58510251"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 23:59:14 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Tue, 2 Jun 2026 23:59:13 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 2 Jun 2026 23:59:09 -0700
From: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Date: Wed, 3 Jun 2026 12:28:48 +0530
Subject: [PATCH v6 05/12] media: microchip-isc: add driver documentation
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260603-microchip-isc-fixes-v6-5-8c3d7474a768@microchip.com>
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

Document the driver topology, supported formats, controls, the AWB
algorithm, the gamma table layout, and the Microchip-specific custom
controls exposed via atmel-isc-media.h.

Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
---
 .../userspace-api/media/drivers/index.rst          |  1 +
 .../userspace-api/media/drivers/microchip-isc.rst  | 69 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 3 files changed, 71 insertions(+)

diff --git a/Documentation/userspace-api/media/drivers/index.rst b/Documentation/userspace-api/media/drivers/index.rst
index 02967c9b18d6..65ef6ba3523e 100644
--- a/Documentation/userspace-api/media/drivers/index.rst
+++ b/Documentation/userspace-api/media/drivers/index.rst
@@ -34,6 +34,7 @@ For more details see the file COPYING in the source distribution of Linux.
 	imx-uapi
 	mali-c55
 	max2175
+	microchip-isc
 	npcm-video
 	omap3isp-uapi
 	thp7312
diff --git a/Documentation/userspace-api/media/drivers/microchip-isc.rst b/Documentation/userspace-api/media/drivers/microchip-isc.rst
new file mode 100644
index 000000000000..69c7672e122a
--- /dev/null
+++ b/Documentation/userspace-api/media/drivers/microchip-isc.rst
@@ -0,0 +1,69 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Microchip ISC/XISC Driver
+=========================
+
+The Image Sensor Controller (ISC) on SAMA5D2 and eXtended ISC (XISC) on
+SAMA7G5/SAM9X7 provide camera capture with hardware image processing.
+
+Supported Hardware
+------------------
+
+==========  ==========  ==============  ================  ===============
+SoC         Controller  Max Resolution  Interface         Hue/Saturation
+==========  ==========  ==============  ================  ===============
+SAMA5D2     ISC         2592x1944       12-bit parallel   No
+SAMA7G5     XISC        3264x2464       12-bit + CSI-2    Yes
+SAM9X7      XISC        2560x1920       12-bit + CSI-2    Yes
+==========  ==========  ==============  ================  ===============
+
+SAM9X7 shares the XISC pipeline with SAMA7G5 but has a smaller internal
+line buffer, limiting horizontal resolution to 2560 pixels.
+
+Controls
+--------
+
+Standard V4L2 controls:
+
+* ``V4L2_CID_BRIGHTNESS``: -1024..1023, default 0
+* ``V4L2_CID_CONTRAST``: -2048..2047. Default differs per SoC:
+  SAMA7G5/SAM9X7 use 16, SAMA5D2 uses 256.
+* ``V4L2_CID_GAMMA``: 0..2 selects a preset curve. Indices differ
+  per SoC: SAMA7G5/SAM9X7 use 0=1/2.4, 1=1/2.2 (default), 2=1/1.8;
+  SAMA5D2 uses 0=1/1.8, 1=1/2.0, 2=1/2.2 (default).
+* ``V4L2_CID_AUTO_WHITE_BALANCE``: Enable kernel Grey World AWB
+* ``V4L2_CID_DO_WHITE_BALANCE``: Trigger one-shot AWB
+
+SAMA7G5/SAM9X7 add:
+
+* ``V4L2_CID_HUE``: -180..180 degrees
+* ``V4L2_CID_SATURATION``: 0..127, default 16 (Q4 fixed-point, 16 = 1.0x)
+
+Custom controls (defined in ``atmel-isc-media.h``):
+
+* ``ISC_CID_R_GAIN``, ``ISC_CID_B_GAIN``, ``ISC_CID_GR_GAIN``,
+  ``ISC_CID_GB_GAIN``: WB gains, 0..8191, Q2.9 (512 = 1.0x)
+* ``ISC_CID_R_OFFSET``, ``ISC_CID_B_OFFSET``, ``ISC_CID_GR_OFFSET``,
+  ``ISC_CID_GB_OFFSET``: WB offsets, -4096..4095
+
+Pipeline
+--------
+
+Pipeline modules: DPC -> WB -> CFA -> CC -> GAM -> CSC -> CBHS/CBC -> SUB
+
+* DPC: Defective Pixel Correction (XISC only), black level subtraction
+  to sensor bit depth, green disparity correction
+* WB: White Balance gains/offsets
+* CFA: Color Filter Array interpolation (demosaic)
+* CC: Color Correction matrix
+* GAM: Gamma correction (preset)
+* CSC: Color Space Conversion (RGB to YCbCr)
+* CBHS: Contrast/Brightness/Hue/Saturation (XISC only), operates on YCbCr
+* CBC: Contrast/Brightness (ISC only), operates on YCbCr
+* SUB: Chroma subsampling (4:2:2, 4:2:0)
+
+Pipeline usage depends on input and output formats:
+
+* Raw Bayer input, RGB output: DPC, WB, CFA, CC, GAM
+* Raw Bayer input, YUV output: Full pipeline including CSC, CBHS/CBC, SUB
+* Non-RAW input (YUV/RGB sensor): Pipeline bypassed
diff --git a/MAINTAINERS b/MAINTAINERS
index e08767323763..d4aa7e86e2bd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17057,6 +17057,7 @@ L:	linux-media@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/media/atmel,isc.yaml
 F:	Documentation/devicetree/bindings/media/microchip,xisc.yaml
+F:	Documentation/userspace-api/media/drivers/microchip-isc.rst
 F:	drivers/media/platform/microchip/microchip-isc*
 F:	drivers/media/platform/microchip/microchip-sama*-isc*
 F:	drivers/staging/media/deprecated/atmel/atmel-isc*

-- 
2.34.1

