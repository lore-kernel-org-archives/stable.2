Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F2836EAA2;
	Mon, 29 Jun 2026 11:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782731406; cv=none; b=nY4lC5lzZNg9gMIk1AQ+2d9AQM+3s8pz1aP5Nlfl3w4TMKG6swsc0CJpzYTMPY6u1XbmBDWgXy5wujF8dSrlaZtlNAWB/4/HnT8asz+omAxwxqDQAnnfck8YOYwVwuWDK5E8RcTt4uyxGsSNtqWm7LABqMJpxY8xtMn42JiM7Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782731406; c=relaxed/simple;
	bh=0CEYSN3tOv1b+wP3879Etl0FWT15ojdlVrF40Chgo1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=JuwrNxqFcOT6dD9U43nYd69NkLxmB9Swy1eropjWDvUIn6VswLJStqlCkcBZJMRMbUvlK18ubO2rcI0qJVtS8oWYxV9rF7ZNpK/0NeggDdjOzhnQdSpl9gkrzMh682UxxLZhyzWNSwUfShOPzYa3MjdR8a5XPVcb+cZUXX9flVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=xw33ypHa; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="xw33ypHa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1782731405; x=1814267405;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=0CEYSN3tOv1b+wP3879Etl0FWT15ojdlVrF40Chgo1k=;
  b=xw33ypHanWjk8x/mxp2CvqjfHvtHHiIUH7FUCe2A/kcKL/omdV/JfBS2
   K+RvMRpX2fTHNIC859bDLmeGBpTq8eXcCIouGDK9nzYFD9BxOO9ylZE1n
   avwsEsGQYg8+PZYM5swuiPYSMd3KdR2bv3k6pzCHpDZJu73IjTCoO6fvw
   S2elq1W2G2JU4NFz7C65b+du9jukBcU1RcLXRkC8nZJbUuoFRvd5kgCiq
   7LwWiEraEjcoYt2KswBsU1Ae10qRSxYWYvsno2ekCDEPU+ruRUAHElmEn
   oxDTlgYjIAwEY+w4kfl1AeDb+LZasl+k+TsrqHpd3lSJX7UloWb5WX5ET
   Q==;
X-CSE-ConnectionGUID: a4V2weGTSTOo02NkD8Asig==
X-CSE-MsgGUID: UVx2TRhJQjOThM/oRILt+A==
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; 
   d="scan'208";a="59817897"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 04:10:04 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.43; Mon, 29 Jun 2026 04:10:04 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 29 Jun 2026 04:10:00 -0700
From: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Date: Mon, 29 Jun 2026 16:39:34 +0530
Subject: [PATCH v2 09/10] media: microchip-isc: fix SBGGR10 Bayer pattern
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260629-balki-isc-prefix-fixes-v1-v2-9-3b120cc3742f@microchip.com>
References: <20260629-balki-isc-prefix-fixes-v1-v2-0-3b120cc3742f@microchip.com>
In-Reply-To: <20260629-balki-isc-prefix-fixes-v1-v2-0-3b120cc3742f@microchip.com>
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

