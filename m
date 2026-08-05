Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5283F075E;
	Wed,  5 Aug 2026 09:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785920561; cv=none; b=aJpc1YCKijytpBob438nRrcE80BI/BE9pS3tTK4yp57+dj/9/08St4RNttBPNP6PuNdj4UiK9ADvGVexCBpsZ2EeApoCu3LA8RWgHZmbAZsWStATwSzjVpOYl++/JO/r/oXTps6XCaIjgzZHNSMdpQtuIR4FDowwfQSan5lTHto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785920561; c=relaxed/simple;
	bh=X76vWRjWKf6AepyXhT5s2KyuXQ+gBCHY103GqjeuLh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oUubUxKfBSG64x8x9ZliVDWdY/kctBj6WVrd/bU21x2zOXM3Kb+ggkbRBF7w6IFHM249b91/ufYK1AlcoOVCLLG2x2K4ZGz43u2eE0ElOwJYk/dAHTW7mti6ka2qHohmVfZrw/0+eHoyEuY4P+Ty3gIlO0fWExELXrGfgU7Ceuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oFEgfhWo; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oFEgfhWo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785920559; x=1817456559;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X76vWRjWKf6AepyXhT5s2KyuXQ+gBCHY103GqjeuLh4=;
  b=oFEgfhWoThWFfHVmeBlm9MaQC+1WL9VHyO5uRiUfxFHr0FvG4oJkLgPZ
   iN9Ms/dsHUdbGWxLYwpMLWdB8WpsJ7e0GUm4bFZlVc1OJl2ykF83VGQDM
   9W2KRPoFvhvj/FMn7cOMigPy4V+2S8bD+MvPpSlCzMMJtXdF2RiPek8AG
   JI9K3W1z7FN+mwkXEkb8Iv2Hk0DoH1hQZD/g1xla8WnH3/hXk2JVkRY5A
   q3gQFFl1wV4IemKUwFuGQADhut14GpwD7biyS0q1LGxGm1/toXaGeRsNX
   32xWZQBWa8FZZlvieR3DQn+QyQYy3oC73yrpNf3pR3Pzcl3iN1cHkf9Ol
   w==;
X-CSE-ConnectionGUID: UwmfXikRTzysS8Sj6/DHSg==
X-CSE-MsgGUID: PFKKb8gnQZ623CbYHKJmUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="96842791"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="96842791"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 02:02:38 -0700
X-CSE-ConnectionGUID: t/kQNN4dRRODdwVDNGBd7Q==
X-CSE-MsgGUID: UUv1RH6cSmOWjBIZqzqB6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="261814073"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.218])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 02:02:35 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Oder Chiou <oder_chiou@realtek.com>,
	Shuming Fan <shumingf@realtek.com>,
	Jack Yu <jack.yu@realtek.com>,
	Derek Fang <derek.fang@realtek.com>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 11/17] ASoC: rt715-sdca: drop duplicate reg_default entries
Date: Wed,  5 Aug 2026 12:02:34 +0300
Message-ID: <20260805090240.16991-12-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805090240.16991-1-peter.ujfalusi@linux.intel.com>
References: <20260805090240.16991-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The last two entries of rt715_reg_defaults_sdca[] repeat the ADC7_27 volume
mute controls for CH_01 and CH_02, which are already listed a few lines
above with the same value.

Drop the duplicates.  No functional change, regcache_lookup_reg() only ever
finds one of the two copies.

Fixes: 20d17057f0a8 ("ASoC: rt715-sdca: Add RT715 sdca vendor-specific driver")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/codecs/rt715-sdca-sdw.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/codecs/rt715-sdca-sdw.h b/sound/soc/codecs/rt715-sdca-sdw.h
index 0cbc14844f8c..774762480195 100644
--- a/sound/soc/codecs/rt715-sdca-sdw.h
+++ b/sound/soc/codecs/rt715-sdca-sdw.h
@@ -102,10 +102,6 @@ static const struct reg_default rt715_reg_defaults_sdca[] = {
 		RT715_SDCA_SMPU_TRIG_EN_CTRL, CH_00), 0x02 },
 	{ SDW_SDCA_CTL(FUN_MIC_ARRAY, RT715_SDCA_SMPU_TRIG_ST_EN,
 		RT715_SDCA_SMPU_TRIG_ST_CTRL, CH_00), 0x00 },
-	{ SDW_SDCA_CTL(FUN_MIC_ARRAY, RT715_SDCA_FU_ADC7_27_VOL,
-		RT715_SDCA_FU_MUTE_CTRL, CH_01), 0x01 },
-	{ SDW_SDCA_CTL(FUN_MIC_ARRAY, RT715_SDCA_FU_ADC7_27_VOL,
-		RT715_SDCA_FU_MUTE_CTRL, CH_02), 0x01 },
 };
 
 static const struct reg_default rt715_mbq_reg_defaults_sdca[] = {
-- 
2.55.0

