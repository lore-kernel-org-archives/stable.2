Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9A63EFFCC;
	Wed,  5 Aug 2026 09:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785920567; cv=none; b=kDNwVgh7XW54NBmpAy6F0IF/2xh+fDmdhzX55XnjTp+tEuZqYFetnXyyLG+ZFutSxclZCGCjKQsYmV8jca2il4B5Wsm0Gx7TUggEVJiqKBrRDk7FhaFwmZh5gBF9hIqqQ0lMlyy9TGvMNu8M+gc+9SJHBmBrvyQnV+qWSY/NL10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785920567; c=relaxed/simple;
	bh=L9RZUqFxGQLOM2A/VGowGZbbhyqWdbB3EAhnnGLEPGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iOp3c9/K4XRWEXeQk5SIYfGslNdOQvpM2TcQsRGBslYuAshxLRRH2bfiDjmuWG1YmfC1zcNklCEpdKi6AXWna2+cTwWqb3rj5aTOB6JzdnzGzXHHNemd55p7+AqABHAJkbIiLfDMIjHbnlNJqapHxPb606ayr0V0NZEsbTlAWog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QEdo0Hmq; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QEdo0Hmq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785920565; x=1817456565;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L9RZUqFxGQLOM2A/VGowGZbbhyqWdbB3EAhnnGLEPGI=;
  b=QEdo0Hmq6fwBo9TES+5BfJINI1WKOgLEK1/cobFQAm7NzWBsfSMgpn+Q
   qfoB7miCe2US4+TugW/zvZolPUEscb0J3Nu9KjTyS2zm28CyWcdFlKBF+
   qXZNEcmbdJB4e5Zbsu94LC7rfPaT22RRo8wsD+8yBSomXwlfzpArRo9/S
   fIGoiEvsJ4eN6S+Pl0/DAWNxE8gEFi5jJKS7xeTzOkIfaZNoNo9/zeAFs
   Ns/2KHc6cP1dUEhRdNe+YA/jqcUFvycr3u8kpxtowi/ZqR5OLRbAXhA/a
   gk8FLwqlnHLZwmEqJDkqKDqBWpj2UYhr1kpC8GmqBGvWEBcfZKZ8H3/hP
   Q==;
X-CSE-ConnectionGUID: F8tkmWTgRvi53Gpamuhosg==
X-CSE-MsgGUID: 8w8SJN+CQ+qPV9Jz6uXNsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="96842807"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="96842807"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 02:02:44 -0700
X-CSE-ConnectionGUID: AadP9oO7SCu7LbhmoYeZtQ==
X-CSE-MsgGUID: cB7fWs3FT1Sv6El1QhGGiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="261814107"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.218])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 02:02:41 -0700
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
Subject: [PATCH 13/17] ASoC: rt721-sdca-sdw: sort the register default table
Date: Wed,  5 Aug 2026 12:02:36 +0300
Message-ID: <20260805090240.16991-14-peter.ujfalusi@linux.intel.com>
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

rt721_sdca_reg_defaults[] is grouped by SDCA function instead, so the
binary search does not find 12 of its entries.  regcache_reg_needs_sync()
then cannot compare those against their default and reports that a sync
is needed, so they are written to the device on every regcache_sync()
even when they were never touched.

Sort the table by register address.

Fixes: 86ce355c1f9a ("ASoC: rt721-sdca: Add RT721 SDCA driver")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/codecs/rt721-sdca-sdw.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/rt721-sdca-sdw.h b/sound/soc/codecs/rt721-sdca-sdw.h
index 214b31b82583..13d6227f3392 100644
--- a/sound/soc/codecs/rt721-sdca-sdw.h
+++ b/sound/soc/codecs/rt721-sdca-sdw.h
@@ -29,14 +29,6 @@ static const struct reg_default rt721_sdca_reg_defaults[] = {
 	{ 0x2f5b, 0x07 },
 	{ 0x2f5c, 0x27 },
 	{ 0x2f5d, 0x07 },
-	{ SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT721_SDCA_ENT_CS01,
-		RT721_SDCA_CTL_SAMPLE_FREQ_INDEX, 0), 0x09 },
-	{ SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT721_SDCA_ENT_CS11,
-		RT721_SDCA_CTL_SAMPLE_FREQ_INDEX, 0), 0x09 },
-	{ SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT721_SDCA_ENT_PDE12,
-		RT721_SDCA_CTL_REQ_POWER_STATE, 0), 0x03 },
-	{ SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT721_SDCA_ENT_PDE40,
-		RT721_SDCA_CTL_REQ_POWER_STATE, 0), 0x03 },
 	{ SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT721_SDCA_ENT_USER_FU05,
 		RT721_SDCA_CTL_FU_MUTE, CH_L), 0x01 },
 	{ SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT721_SDCA_ENT_USER_FU05,
@@ -45,6 +37,14 @@ static const struct reg_default rt721_sdca_reg_defaults[] = {
 		RT721_SDCA_CTL_FU_MUTE, CH_L), 0x01 },
 	{ SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT721_SDCA_ENT_USER_FU0F,
 		RT721_SDCA_CTL_FU_MUTE, CH_R), 0x01 },
+	{ SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT721_SDCA_ENT_PDE12,
+		RT721_SDCA_CTL_REQ_POWER_STATE, 0), 0x03 },
+	{ SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT721_SDCA_ENT_CS01,
+		RT721_SDCA_CTL_SAMPLE_FREQ_INDEX, 0), 0x09 },
+	{ SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT721_SDCA_ENT_CS11,
+		RT721_SDCA_CTL_SAMPLE_FREQ_INDEX, 0), 0x09 },
+	{ SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT721_SDCA_ENT_PDE40,
+		RT721_SDCA_CTL_REQ_POWER_STATE, 0), 0x03 },
 	{ SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT721_SDCA_ENT_USER_FU1E,
 		RT721_SDCA_CTL_FU_MUTE, CH_01), 0x01 },
 	{ SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT721_SDCA_ENT_USER_FU1E,
@@ -53,30 +53,30 @@ static const struct reg_default rt721_sdca_reg_defaults[] = {
 		RT721_SDCA_CTL_FU_MUTE, CH_03), 0x01 },
 	{ SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT721_SDCA_ENT_USER_FU1E,
 		RT721_SDCA_CTL_FU_MUTE, CH_04), 0x01 },
+	{ SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT721_SDCA_ENT_PDE2A,
+		RT721_SDCA_CTL_REQ_POWER_STATE, 0), 0x03 },
 	{ SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT721_SDCA_ENT_CS1F,
 		RT721_SDCA_CTL_SAMPLE_FREQ_INDEX, 0), 0x09 },
 	{ SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT721_SDCA_ENT_IT26,
 		RT721_SDCA_CTL_VENDOR_DEF, 0), 0x00 },
-	{ SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT721_SDCA_ENT_PDE2A,
-		RT721_SDCA_CTL_REQ_POWER_STATE, 0), 0x03 },
-	{ SDW_SDCA_CTL(FUNC_NUM_AMP, RT721_SDCA_ENT_CS31,
-		RT721_SDCA_CTL_SAMPLE_FREQ_INDEX, 0), 0x09 },
 	{ SDW_SDCA_CTL(FUNC_NUM_AMP, RT721_SDCA_ENT_USER_FU06,
 		RT721_SDCA_CTL_FU_MUTE, CH_L), 0x01 },
 	{ SDW_SDCA_CTL(FUNC_NUM_AMP, RT721_SDCA_ENT_USER_FU06,
 		RT721_SDCA_CTL_FU_MUTE, CH_R), 0x01 },
 	{ SDW_SDCA_CTL(FUNC_NUM_AMP, RT721_SDCA_ENT_PDE23,
 		RT721_SDCA_CTL_REQ_POWER_STATE, 0), 0x03 },
-	{ SDW_SDCA_CTL(FUNC_NUM_AMP, RT721_SDCA_ENT_OT23,
-		RT721_SDCA_CTL_VENDOR_DEF, 0), 0x00 },
 	{ SDW_SDCA_CTL(FUNC_NUM_AMP, RT721_SDCA_ENT_PDE23,
 		RT721_SDCA_CTL_FU_MUTE, CH_01), 0x01 },
 	{ SDW_SDCA_CTL(FUNC_NUM_AMP, RT721_SDCA_ENT_PDE23,
 		RT721_SDCA_CTL_FU_MUTE, CH_02), 0x01 },
+	{ SDW_SDCA_CTL(FUNC_NUM_AMP, RT721_SDCA_ENT_CS31,
+		RT721_SDCA_CTL_SAMPLE_FREQ_INDEX, 0), 0x09 },
 	{ SDW_SDCA_CTL(FUNC_NUM_AMP, RT721_SDCA_ENT_FU55,
 		RT721_SDCA_CTL_FU_MUTE, CH_01), 0x01 },
 	{ SDW_SDCA_CTL(FUNC_NUM_AMP, RT721_SDCA_ENT_FU55,
 		RT721_SDCA_CTL_FU_MUTE, CH_02), 0x01 },
+	{ SDW_SDCA_CTL(FUNC_NUM_AMP, RT721_SDCA_ENT_OT23,
+		RT721_SDCA_CTL_VENDOR_DEF, 0), 0x00 },
 };
 
 static const struct reg_default rt721_sdca_mbq_defaults[] = {
-- 
2.55.0

