Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD38371868;
	Mon, 29 Jun 2026 11:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782731378; cv=none; b=laNFThlok3bQwhgBfr0f0y3+BWvsEl8URgnoYjdh4o21RgPEvjFrbaLzxFeCMBCyAKfbCdtQuiaCiIp4XBzrcXJ+zHdcyBu7lrP7swvFdGrtdHvYqWii+ruGAIysqiytW00ylowtREKyH56w6Tbl1edi9yOGXQTpHLtQ9FHuKo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782731378; c=relaxed/simple;
	bh=g4MZFeRIsdXmq53xL65Of9fLdUKURQ2MLAcCpPMLbYQ=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=eBZUmyCRLGep/F8EUx1muzhZMgwJKWC7/8jCS/g3t+WUb4SQbcMu1EDb5O7PCwcRQi54jDBMexsDOHz8b64aGbbRbcnSIeaqAB36oxDiniLQztruIqY1tzPPSy+Cr2gryJcJwFrctvHtuihYSI7w8tfSJmzmBiKUe7wWjzQGOG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vSrCubT1; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vSrCubT1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1782731377; x=1814267377;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=g4MZFeRIsdXmq53xL65Of9fLdUKURQ2MLAcCpPMLbYQ=;
  b=vSrCubT1hWAjbUc/rsp/MgN6X6THVJ6lGgAhETUSBYf1F8pfOq3X+HMJ
   p7dAHIeB/ZPBMzpR59s8a4ucGN7m+T8/XrrU4K8wZ7Ax3UrNMo0HoI+J0
   Bo32QZadyzX8l2i+uWcwSm8DIE3mPA+lJ+io1V0QjHsSskC58GWdCPK31
   CItJEy1983JC3coBB9FiqClRnwLH0CFNL6E8awY6vd6M4zJW5+Mo68097
   nr0nX52ytR1iN0aMN5e5NbsLTHId+J8nECVjoQLK3itVoiHg0Dw5r5Z0q
   tl37O7q28rbwqlrgTmU90zbA5/2S3oIejyWciyVpNYWoGO5l5cS0RMsFj
   w==;
X-CSE-ConnectionGUID: yxjgZf8QQ/GK0ozFQF27Sw==
X-CSE-MsgGUID: C0fFnSEfQqCmqGQiaraL6g==
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; 
   d="scan'208";a="69038411"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jun 2026 04:09:31 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 29 Jun 2026 04:09:30 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 29 Jun 2026 04:09:27 -0700
From: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Subject: [PATCH v2 00/10] media: microchip-isc: AWB, stream-stop and
 endpoint-ref fixes
Date: Mon, 29 Jun 2026 16:39:25 +0530
Message-ID: <20260629-balki-isc-prefix-fixes-v1-v2-0-3b120cc3742f@microchip.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGVSQmoC/32NwQ6CMAyGX4X0bA2bMIwn3sNw2OqQRmFkNURD9
 u5OjFeT/oevzf91BfGRvcCpWCH6hYXDlEHvCqDBTlePfMkMutSmNKpGZ+83RhbCOfqen5jjBRe
 FdKSq0roiaxXk/ve+uc9d5oHlEeJre7Woz/ZnNX+seUp0+mCapqfaOtOOTDHQwPOewghdSukNC
 naKeMYAAAA=
X-Change-ID: 20260615-balki-isc-prefix-fixes-v1-c8c44224caa1
To: Eugen Hristev <ehristev@kernel.org>, Mauro Carvalho Chehab
	<mchehab@kernel.org>
CC: Hans Verkuil <hverkuil@kernel.org>, Sakari Ailus
	<sakari.ailus@linux.intel.com>, <linux-media@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Balakrishnan Sambath
	<balakrishnan.s@microchip.com>, <stable@vger.kernel.org>
X-Mailer: b4 0.14.3

This series has a few fixes for the Microchip ISC/XISC driver, found
while testing and from the feedback on the combined series [1].

Fixes only, sent ahead of the enhancements so they can reach stable.
The SBGGR10, WB masking and PM leak fixes are unchanged from [1] (the
SBGGR10 and PM leak ones keep their Reviewed-by).

All but the two pfe_cfg0_bps cleanups carry a Fixes tag and Cc: stable.

[1] https://lore.kernel.org/r/20260603-microchip-isc-fixes-v6-0-8c3d7474a768@microchip.com

Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
---
Changes in v2:
- Squash the stop and start-error histogram/AWB-flush patches into one (Eugen).
- Store pfe_cfg0_bps unshifted, apply with FIELD_PREP() at the write (Eugen).
- Skip the WB register writes during the stop window too (isc->stop check).
- New patch: fix the ISC_PFG_CFG0_BPS macro name typo.
- Add Eugen's Reviewed-by on the IRQ-sync patch.
- Link to v1: https://lore.kernel.org/r/20260616-balki-isc-prefix-fixes-v1-v1-0-b23677fc5ab6@microchip.com

---
Balakrishnan Sambath (10):
      media: microchip-isc: fix awb_mutex and lock lifecycle
      media: microchip-isc: take a reference on the parsed endpoints
      media: microchip-isc: synchronize the IRQ before disabling clocks on stop
      media: microchip-isc: disable histogram and flush AWB work on teardown
      media: microchip-isc: do not touch WB registers when not streaming
      media: microchip-isc: store the unshifted PFE_CFG0 BPS value
      media: microchip-isc: fix ISC_PFG_CFG0_BPS macro name typo
      media: microchip-isc: fix PM runtime leak in AWB work handler
      media: microchip-isc: fix SBGGR10 Bayer pattern
      media: microchip-isc: fix WB offset and gain register field masking

 .../media/platform/microchip/microchip-isc-base.c  | 78 +++++++++++++++-------
 .../media/platform/microchip/microchip-isc-regs.h  | 10 +--
 drivers/media/platform/microchip/microchip-isc.h   |  5 +-
 .../platform/microchip/microchip-sama5d2-isc.c     | 40 ++++++-----
 .../platform/microchip/microchip-sama7g5-isc.c     | 40 ++++++-----
 5 files changed, 112 insertions(+), 61 deletions(-)
---
base-commit: 05f7e89ab9731565d8a62e3b5d1ec206485eeb0b
change-id: 20260615-balki-isc-prefix-fixes-v1-c8c44224caa1

Best regards,
-- 
Balakrishnan Sambath <balakrishnan.s@microchip.com>

