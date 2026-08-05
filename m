Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9981B46C4A3;
	Wed,  5 Aug 2026 12:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785932818; cv=none; b=s04ArjGCRtmO1SrkKkGHaQrJp/lY4c8TcubmhLG475TLqhhg3l+f0H6bhCT0eyrhAO/rV6hxAUqk2KoBMPVnD5mAGLs3NZMB/YMB21zvCIs5YlDozsOurH/3Q6lWtrvz53zOwN5/1UuFxnq6n69NFzsSa2aVRNx1U8G9d6Q2yeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785932818; c=relaxed/simple;
	bh=HJ2QI3q/5ld7C3q7HnHy35phf+nTJpO/vy1yh1mMztU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EIb5VLQ72H8u9186/xokxM4FeEcsWZKFjTjFHBJyNKR8DzFgIgJTDGkJ3tUv176bVmsJkRwHymXpcZgncb29EirRDahW8a2zK+2AR91Y90vttunK+dEPmj2Dpd4UNaF6DFPr6edT+vxtd+nDhFqQZmy6ULCODK9iS/DwaO3NvAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DNlEDmhG; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DNlEDmhG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785932817; x=1817468817;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HJ2QI3q/5ld7C3q7HnHy35phf+nTJpO/vy1yh1mMztU=;
  b=DNlEDmhG8GmWG0Q1Hg0st/ymbW/szYRtmBr0/LwLkmJKiyNJDLzdcYhE
   iiUbq/C4ebXRGU9rjH4nb3JJVg+weYOtVgp62P0i6PreEMPHMMuwypnG2
   K3y0aG9UmvTEjg96djDT/Zry6TMKkp+6lUQ8M2ReNoSAr1ASWC6K25TE1
   iy4fP6LnR9RxspNRh6BpEb5A7HkhPGKa6EsciBBiP53A6Tsg8ATa1/YJz
   ZjJ0uIjAHk0fHEv1itJxIJVShdFYWWuJAEaJ/yAwDQjokLYeXpYKK2zA/
   70wwp5CeaKMa7FwlEjuRvyJS8SJ+zt+hYhcM1O0VLHYrA4/WFShBlo9p1
   Q==;
X-CSE-ConnectionGUID: CJuiO/9+QWKp7baxNVVDyQ==
X-CSE-MsgGUID: HpOtQ19qR3Wb5LANinw4yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="86583168"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="86583168"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 05:26:56 -0700
X-CSE-ConnectionGUID: NBM/4DHyRAGjLOah8A2p7A==
X-CSE-MsgGUID: z8aNROI3SgSY8LIPHofbwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="258460214"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.218])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 05:26:53 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>
Cc: linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] ASoC: sgtl5000: sort the register default table
Date: Wed,  5 Aug 2026 15:27:27 +0300
Message-ID: <20260805122728.12362-2-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805122728.12362-1-peter.ujfalusi@linux.intel.com>
References: <20260805122728.12362-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reg_defaults must be sorted by ascending register address, as
regcache_lookup_reg() locates entries in it with bsearch().  See commit
fd80df352ba1 ("regcache: Add support for sorting defaults arrays").

SGTL5000_CHIP_SHORT_CTRL (0x003c) is listed before
SGTL5000_CHIP_ANA_TEST2 (0x003a), which makes the former unreachable.
regcache_reg_needs_sync() then cannot compare it against its default and
reports that a sync is needed, so it is written to the device on every
regcache_sync() even when it was never touched.

Sort the table by register address.

Fixes: 29aa37cddfb9 ("ASoC: sgtl5000: Fix the cache handling")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/codecs/sgtl5000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 59642673b4cb..35df1a8c4c8c 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -56,8 +56,8 @@ static const struct reg_default sgtl5000_reg_defaults[] = {
 	{ SGTL5000_CHIP_PLL_CTRL,		0x5000 },
 	{ SGTL5000_CHIP_CLK_TOP_CTRL,		0x0000 },
 	{ SGTL5000_CHIP_ANA_STATUS,		0x0000 },
-	{ SGTL5000_CHIP_SHORT_CTRL,		0x0000 },
 	{ SGTL5000_CHIP_ANA_TEST2,		0x0000 },
+	{ SGTL5000_CHIP_SHORT_CTRL,		0x0000 },
 	{ SGTL5000_DAP_CTRL,			0x0000 },
 	{ SGTL5000_DAP_PEQ,			0x0000 },
 	{ SGTL5000_DAP_BASS_ENHANCE,		0x0040 },
-- 
2.55.0

