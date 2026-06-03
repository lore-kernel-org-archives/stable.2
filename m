Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A1B3955FC;
	Wed,  3 Jun 2026 06:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780469938; cv=none; b=kKez9QkRodhpJLxD7DM2aefojVTq9aclxfThOCsMvfhW0NqHJ/Nt41YsCUXNGC8wFT6i9W3zsufuXgTcwBsd8vI1ctimr5EJIFk/eZLJ4AFNCofQKd841uN0KJjvWPOABgnUrlH53+Ie3zj3RNWMKiz231+GdI4MhT6Jx9VyOrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780469938; c=relaxed/simple;
	bh=OJdQgi5K0uqHlvSWlhh1m+RffYk3s+iID/ZZcHa2Qig=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=AR4jcnsHipufQqvflevqFSAE62athBuYc5Rc/CBzfDPmd1t4yqjmQjqoMOKgoHIXA34nwfbt0zihVcPVaSNiZWNlS1G5GB0rPgcwEldQxECLZCVgOuY8wbkSm5YzUAPJCbJEVO15p8VM997ThZeQP0IYEBbbfYOCr8wUxr8BjdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vIXjNdyk; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vIXjNdyk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1780469937; x=1812005937;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=OJdQgi5K0uqHlvSWlhh1m+RffYk3s+iID/ZZcHa2Qig=;
  b=vIXjNdykgzOJizkdPXKTctAv/SijU/PbRAwSzTa09q8R0gDLHXr2pD96
   IPwANvz6K+8POoEW/2Zo0lEP6HOpdPAHYJBGQYSyKUdOdRd1TBp3uQuPs
   U8TmGAwXuOlxS/j6jN10ojEZhvU9bCJPAIQ9GT/Nuq2qb+roPGWftF73u
   DL/4Mx9pVXowwcs9OZLiCXXrGy22Xw7687UFgVm6+hdP+y0v9Hh1ntXzh
   RVUgu5M0NZYrV1QgcpqjHrebKvfmRq7gg20LDr4BEEJj7+h73rA6LcB6I
   S3zeKc7ByBk9CKxm4JfIZsucBRUADVxB9pGA72hcgDIhzye2jfBmBMx6J
   w==;
X-CSE-ConnectionGUID: V2/zMLj8SO298T7k/EOQZQ==
X-CSE-MsgGUID: B9hCFxwsRQKB25UBc4iGjQ==
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="58510240"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 23:58:51 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Tue, 2 Jun 2026 23:58:50 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 2 Jun 2026 23:58:46 -0700
From: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Subject: [PATCH v6 00/12] media: microchip-isc: fixes and enhancements
Date: Wed, 3 Jun 2026 12:28:43 +0530
Message-ID: <20260603-microchip-isc-fixes-v6-0-8c3d7474a768@microchip.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKTQH2oC/22NSw7CIBCGr9LM2jGIQqMr72G6KNOpzKKlAUM0D
 XcXm+jK5fc/V0gchRNcmhUiZ0kS5gp21wD5fr4zylAZtNJWGW1wEoqBvCwoiXCUJyfsNQ08tnQ
 cLENtLpE3oxZvXWUv6RHiazvJ5qN+99q/e9mgQqeYDs6dzcnx9ZfaU5igK6W8AWUcfiS6AAAA
X-Change-ID: 20260525-microchip-isc-fixes-a2cdef7c3d6e
To: Eugen Hristev <ehristev@kernel.org>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, Hans Verkuil <hverkuil@kernel.org>
CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Kieran Bingham
	<kieran.bingham@ideasonboard.com>, Sakari Ailus
	<sakari.ailus@linux.intel.com>, Balamanikandan Gunasundar
	<balamanikandan.gunasundar@microchip.com>, <stable@vger.kernel.org>,
	<linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Balakrishnan
 Sambath" <balakrishnan.s@microchip.com>
X-Mailer: b4 0.14.3

Bug fixes and feature additions for the Microchip ISC/XISC driver.

Fixes:
 - SBGGR10 Bayer pattern was mapped incorrectly (red/blue swap)
 - WB register fields corrupted by sign extension
 - Race between histogram IRQ and stream stop
 - PM runtime reference leak in AWB work handler

Features:
 - Driver documentation
 - Gamma 1.8/2.4 preset curves
 - Hue/saturation controls for SAMA7G5
 - Grey World AWB with EMA smoothing

Split from v1 per review. Histogram statistics support is being sent
as a separate follow-up series.

Tested on SAMA7G5-EK with IMX219 (RAW10 Bayer capture, AWB, controls
verified across multiple pixel formats and resolutions up to 3264x2464).

Based on v6.19 (e9ec05addd1a).

v1: https://lore.kernel.org/linux-media/20251009155251.102472-1-balamanikandan.gunasundar@microchip.com/
v2: https://lore.kernel.org/linux-media/20260512154339.210444-1-balakrishnan.s@microchip.com/
v3: https://lore.kernel.org/linux-media/20260513071742.97263-1-balakrishnan.s@microchip.com/
v4: https://lore.kernel.org/linux-media/20260518-balki-isc-series1-v4-v4-0-97f189185b7e@microchip.com/
v5: https://lore.kernel.org/linux-media/20260527-microchip-isc-fixes-v5-0-b0ec1bb954be@microchip.com/

v6:
 - Picked up Eugen's Reviewed-by on the SBGGR10 fix
 - Rename isc_format_has_chroma() to isc_format_is_yuv() and
   isc_update_cbc_ctrl_activity() to isc_update_cbhs_ctrls()
 - Store the CBHS control pointers in struct isc_device and use them
   instead of v4l2_ctrl_find()
 - Drop a stale comment in isc_s_ctrl()
 - Fold gain_smooth[] back into gain[]
 - Drop DPC_DPCENABLE from the SAMA7G5 pipeline mask, no format sets it
 - Fix the DPC black level BPS comment
 - Fix the documented pipeline order (CSC before CBHS) and contrast
   default

v5:
 - Picked up Eugen's Reviewed-by on the PM runtime leak fix.
   The SBGGR10 fix is extended to SAMA5D2 in v5, so dropped his
   Reviewed-by from that patch pending re-review.
 - Fix SAMA7G5 pipeline mask: CBHS_ENABLE, not CBC_ENABLE
 - Per-platform gamma_default. v4 used 1 for both SoCs, which picks
   the wrong curve on SAMA5D2 (1/2.2 is at index 2 there, index 1
   on SAMA7G5)
 - Fix V4L2_CID_SATURATION range to 0..127 (Q4); update docs to match
 - Initialise hue/saturation at probe to avoid a grayscale first frame
 - Reset histogram stats and gain_smooth in isc_reset_awb_ctrls() so
   AWB does not consume stale state from a previous stream
 - Reword WB masking subject; expand commit bodies on the feature
   patches

v4:
 - Drop gamma LUT controls and CC matrix V4L2 controls patches (move
   to parameter buffer follow-up per Sakari's review)
 - Drop AWB enable pipeline reset patch (cleanup for the dropped
   controls, will return with the follow-up series)
 - Update documentation patch to remove references to dropped controls
 - Rebase on v6.19

v3:
 - Fix bisect failures (regmap declaration, gamma LUT macro ordering)
 - Fix Fixes: tag (use mainline commit, not staging)
 - Add Co-developed-by trailers for Balamanikandan Gunasundar

v2:
 - Split series (histogram stats moved to a separate follow-up series)
 - Reorder: bug fixes first, then features
 - Commit message cleanups
 - Rebase on v6.19-rc8

Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>

---
Changes in v6:
- Picked up Eugen's Reviewed-by on the SBGGR10 fix
- Rename isc_format_has_chroma() to isc_format_is_yuv() and
  isc_update_cbc_ctrl_activity() to isc_update_cbhs_ctrls()
- Store the CBHS control pointers in struct isc_device, use them
  instead of v4l2_ctrl_find()
- Drop a stale comment in isc_s_ctrl()
- Fold gain_smooth[] back into gain[]
- Drop DPC_DPCENABLE from the SAMA7G5 pipeline mask, no format sets it
- Fix the DPC black level BPS comment
- Fix the documented pipeline order (CSC before CBHS) and contrast default
- Link to v5: https://lore.kernel.org/r/20260527-microchip-isc-fixes-v5-0-b0ec1bb954be@microchip.com

---
Balakrishnan Sambath (12):
      media: microchip-isc: fix SBGGR10 Bayer pattern
      media: microchip-isc: fix WB offset and gain register field masking
      media: microchip-isc: fix race condition on stream stop
      media: microchip-isc: fix PM runtime leak in AWB work handler
      media: microchip-isc: add driver documentation
      media: microchip-isc: set SAM9X7 maximum resolution to 2560x1920
      media: microchip-isc: configure DPC and pipeline for SAMA7G5
      media: microchip-isc: add gamma 1.8 and 2.4 correction curves
      media: microchip-isc: add SAMA7G5 hue and saturation controls
      media: microchip-isc: use weighted averages for Grey World AWB
      media: microchip-isc: smooth AWB gains with EMA filter
      media: microchip-isc: scale DPC black level to sensor bit depth

 .../userspace-api/media/drivers/index.rst          |   1 +
 .../userspace-api/media/drivers/microchip-isc.rst  |  69 +++++
 MAINTAINERS                                        |   1 +
 .../media/platform/microchip/microchip-isc-base.c  | 319 ++++++++++++++++-----
 .../media/platform/microchip/microchip-isc-regs.h  |  11 +-
 drivers/media/platform/microchip/microchip-isc.h   |  12 +-
 .../platform/microchip/microchip-sama5d2-isc.c     |   9 +-
 .../platform/microchip/microchip-sama7g5-isc.c     | 105 +++++--
 8 files changed, 424 insertions(+), 103 deletions(-)
---
base-commit: 05f7e89ab9731565d8a62e3b5d1ec206485eeb0b
change-id: 20260525-microchip-isc-fixes-a2cdef7c3d6e

Best regards,
-- 
Balakrishnan Sambath <balakrishnan.s@microchip.com>

