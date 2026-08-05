Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488B43EF649;
	Wed,  5 Aug 2026 09:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785920552; cv=none; b=iLYNF8Ik+lSNArPtwnvuKCgQWwkcS6NiDSoBD1UQvMFIomHIR5LxAT7KjhHdO5B4VltRDOrKS+FxdSA8F4lWoH90Ieqp2Hu8ofbteQEOmLpTR0WDpdP4kt9EdsWB58VtmxBtMZ+Y9d+bizyh51inUGT8dq2GP8jzFNl8cVmakNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785920552; c=relaxed/simple;
	bh=wNG9mOxx1a4HfxfGqx3xku9NU1zkJ1sHRZAAjyg2yXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XvmDO2uFRbn3rTEDwbORmoQyAKpyaFoLm6kDF6yVxRmFsOCkr9GDgyciTEo8KqSNZxK30FJdl+/iFYBeesfxQYQT4NLmzDlsRQaTvDTK/cvbvCHqPvgZpxA7Fw1AbdAMfJogyIzQCnmMsYmuBk4jMdgbUb7rYkawEurHHFHaNqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WYLqoOSM; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WYLqoOSM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785920550; x=1817456550;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wNG9mOxx1a4HfxfGqx3xku9NU1zkJ1sHRZAAjyg2yXg=;
  b=WYLqoOSMdv8AM8uc4ctwC0WUrKbzp4tedteKUODzVFNx/42u2/idppZI
   p6kNOznxyU4/mupdGxZmAv6IvqqSFbodF9nkZGyBSAjLAzrM/yQg35OPj
   tNaeN6ISq+f32cfa+RSAthEF/I/duD5y53RyhMQNGMZDtsw32ohzsdXvF
   0zpPIYue9WgpTXTERRsWW0v+rBgrcIhmdg+EhaxEuyi77TMl0Mi4GJq8w
   tGcElAXE8A98xr1sRiKJulRoYGL3sOb4wMvKqgnKuCTyok35VET/tmaYv
   jV5BkCg5OlxEJTmNuJJCgib4y0yrN+9/sHZFhkd5arq6VwQkBvmN0MXpZ
   A==;
X-CSE-ConnectionGUID: xNLfry21Su2dc1m5TXqJBw==
X-CSE-MsgGUID: 8HTySWzRSSijjvyaXJHevA==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="96842765"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="96842765"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 02:02:29 -0700
X-CSE-ConnectionGUID: qmCrYS38QlabYBndqp1MgQ==
X-CSE-MsgGUID: d4ORDYKeRnKK6+RVqEvcww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="261814024"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.218])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 02:02:26 -0700
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
Subject: [PATCH 08/17] ASoC: rt712-sdca-dmic: sort the register default table
Date: Wed,  5 Aug 2026 12:02:31 +0300
Message-ID: <20260805090240.16991-9-peter.ujfalusi@linux.intel.com>
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

reg_defaults must be sorted by ascending register address, as
regcache_lookup_reg() locates entries in it with bsearch().  See commit
fd80df352ba1 ("regcache: Add support for sorting defaults arrays").

rt712_sdca_dmic_reg_defaults[] is grouped by SDCA entity instead, so the
binary search does not find 3 of its entries.  regcache_reg_needs_sync()
then cannot compare those against their default and reports that a sync
is needed, so they are written to the device on every regcache_sync()
even when they were never touched.

Sort the table by register address.

Fixes: 63a511284c9e ("ASoC: rt712-sdca: Add RT712 SDCA driver for Mic topology")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/codecs/rt712-sdca-dmic.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt712-sdca-dmic.h b/sound/soc/codecs/rt712-sdca-dmic.h
index 110154e74efe..2f08e58ed519 100644
--- a/sound/soc/codecs/rt712-sdca-dmic.h
+++ b/sound/soc/codecs/rt712-sdca-dmic.h
@@ -36,6 +36,7 @@ struct rt712_sdca_dmic_kctrl_priv {
 #define CH_03	0x03
 #define CH_04	0x04
 
+/* must stay sorted by register address, regcache_lookup_reg() does a bsearch() */
 static const struct reg_default rt712_sdca_dmic_reg_defaults[] = {
 	{ 0x201a, 0x00 },
 	{ 0x201b, 0x00 },
@@ -72,15 +73,16 @@ static const struct reg_default rt712_sdca_dmic_reg_defaults[] = {
 	{ 0x2f59, 0x07 },
 	{ 0x3201, 0x01 },
 	{ 0x320c, 0x00 },
-	{ SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT712_SDCA_ENT_IT26, RT712_SDCA_CTL_VENDOR_DEF, 0), 0x00 },
 	{ SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT712_SDCA_ENT_USER_FU1E, RT712_SDCA_CTL_FU_MUTE, CH_01), 0x01 },
 	{ SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT712_SDCA_ENT_USER_FU1E, RT712_SDCA_CTL_FU_MUTE, CH_02), 0x01 },
 	{ SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT712_SDCA_ENT_USER_FU1E, RT712_SDCA_CTL_FU_MUTE, CH_03), 0x01 },
 	{ SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT712_SDCA_ENT_USER_FU1E, RT712_SDCA_CTL_FU_MUTE, CH_04), 0x01 },
-	{ SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT712_SDCA_ENT_CS1F, RT712_SDCA_CTL_SAMPLE_FREQ_INDEX, 0), 0x09 },
 	{ SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT712_SDCA_ENT_CS1C, RT712_SDCA_CTL_SAMPLE_FREQ_INDEX, 0), 0x09 },
+	{ SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT712_SDCA_ENT_CS1F, RT712_SDCA_CTL_SAMPLE_FREQ_INDEX, 0), 0x09 },
+	{ SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT712_SDCA_ENT_IT26, RT712_SDCA_CTL_VENDOR_DEF, 0), 0x00 },
 };
 
+/* must stay sorted by register address, regcache_lookup_reg() does a bsearch() */
 static const struct reg_default rt712_sdca_dmic_mbq_defaults[] = {
 	{ 0x0590001e, 0x0020 },
 	{ 0x06100000, 0x0010 },
-- 
2.55.0

