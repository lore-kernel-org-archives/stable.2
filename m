Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51CC4CA285;
	Tue, 21 Jul 2026 10:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784629776; cv=none; b=u1dJnwx7v+nQMqY8HxbQ0BK1jj7EsLofSkWYdFd52VPMuJWKZ4V6TFR3I0JxNfGkqlzsSvZYPdQwg0AFoOXnCEIw7zr+eBQdxOw04M5RRFLeOE3suuvn03tyH0HtKe4VaQAg1d5KwD6XxCCsFemEGm3jYPWwtU9uv/c70DqWnAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784629776; c=relaxed/simple;
	bh=0CEYSN3tOv1b+wP3879Etl0FWT15ojdlVrF40Chgo1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=paxPoJMm/xSkyAP2iUK5i1wyHFTYS7mDFBNJRzG8AZxhYfUWS4FmK3Zw1flBqXTTREjGFapIOEt7zZ5yVinkpyGJVZrDMYjOxHnlj/3fcknTrIAmhHb5nhW/pZtnVslXaf+vm8jkPi12gSn1WATsGow4+l3Kk66/7VVOE60lVsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=IzNn2/56; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="IzNn2/56"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1784629774; x=1816165774;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=0CEYSN3tOv1b+wP3879Etl0FWT15ojdlVrF40Chgo1k=;
  b=IzNn2/56KkuUwQQSbqTNhmvTNfXI3M/nd3xv94IEoUab4ByUFqjQkje6
   t4OE23s6HRiOXK3kaLpIbuROqX+0bemlURrV3eTQB2pF9QDZpdJ5rZrB+
   RcYkEDUCUJO9TckZ4FDxBt65BHHbOb5TdZyvrizPbdQhlk6d1Lr3hw0lC
   xENFNPHAsbUNhS1m0qMZ2+k6hOqKUYeu7V/T0WCku1j+eOtEBLUi4AoUD
   o7ZThqo+bV11AIfDqmtI/jLPDEo2Jlf0WY0HWUyFsZ9kXIZbm9HIVG3P7
   l0AR3F0ohoWL/ZYYA1Gv7qroOFgBhrrPMM87invd5Iv53jk9NhAODahck
   Q==;
X-CSE-ConnectionGUID: Cbii2dOCRxWiBZ2KAIw4Tg==
X-CSE-MsgGUID: F3FVZ1pvQ/qO1X1/txstFQ==
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="228086577"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 03:29:34 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.43; Tue, 21 Jul 2026 03:29:33 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 21 Jul 2026 03:29:30 -0700
From: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Date: Tue, 21 Jul 2026 15:59:03 +0530
Subject: [PATCH v3 09/10] media: microchip-isc: fix SBGGR10 Bayer pattern
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260721-balki-isc-prefix-fixes-v1-v3-9-ffe10640a2d9@microchip.com>
References: <20260721-balki-isc-prefix-fixes-v1-v3-0-ffe10640a2d9@microchip.com>
In-Reply-To: <20260721-balki-isc-prefix-fixes-v1-v3-0-ffe10640a2d9@microchip.com>
To: Eugen Hristev <ehristev@kernel.org>, Mauro Carvalho Chehab
	<mchehab@kernel.org>
CC: Hans Verkuil <hverkuil@kernel.org>, Sakari Ailus
	<sakari.ailus@linux.intel.com>, <linux-media@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Balakrishnan Sambath
	<balakrishnan.s@microchip.com>, <stable@vger.kernel.org>
X-Mailer: b4 0.14.3

SBGGR10 was mapped to ISC_BAY_CFG_RGRG instead of ISC_BAY_CFG_BGBG,
causing red/blue channel swap.

Fixes: 91b4e487b0c6 ("media: microchip: add ISC driver as Microchip ISC")
Cc: stable@vger.kernel.org
Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Reviewed-by: Eugen Hristev <ehristev@kernel.org>
---
 drivers/media/platform/microchip/microchip-sama5d2-isc.c | 2 +-
 drivers/media/platform/microchip/microchip-sama7g5-isc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/microchip/microchip-sama5d2-isc.c b/drivers/media/platform/microchip/microchip-sama5d2-isc.c
index 5c59a692b30e..99fda1968a32 100644
--- a/drivers/media/platform/microchip/microchip-sama5d2-isc.c
+++ b/drivers/media/platform/microchip/microchip-sama5d2-isc.c
@@ -147,7 +147,7 @@ static struct isc_format sama5d2_formats_list[] = {
 		.fourcc		= V4L2_PIX_FMT_SBGGR10,
 		.mbus_code	= MEDIA_BUS_FMT_SBGGR10_1X10,
 		.pfe_cfg0_bps	= ISC_PFE_CFG0_BPS_TEN,
-		.cfa_baycfg	= ISC_BAY_CFG_RGRG,
+		.cfa_baycfg	= ISC_BAY_CFG_BGBG,
 	},
 	{
 		.fourcc		= V4L2_PIX_FMT_SGBRG10,
diff --git a/drivers/media/platform/microchip/microchip-sama7g5-isc.c b/drivers/media/platform/microchip/microchip-sama7g5-isc.c
index 5c7a10c9a2a5..4e1fbb83bc97 100644
--- a/drivers/media/platform/microchip/microchip-sama7g5-isc.c
+++ b/drivers/media/platform/microchip/microchip-sama7g5-isc.c
@@ -156,7 +156,7 @@ static struct isc_format sama7g5_formats_list[] = {
 		.fourcc		= V4L2_PIX_FMT_SBGGR10,
 		.mbus_code	= MEDIA_BUS_FMT_SBGGR10_1X10,
 		.pfe_cfg0_bps	= ISC_PFE_CFG0_BPS_TEN,
-		.cfa_baycfg	= ISC_BAY_CFG_RGRG,
+		.cfa_baycfg	= ISC_BAY_CFG_BGBG,
 	},
 	{
 		.fourcc		= V4L2_PIX_FMT_SGBRG10,

-- 
2.34.1

