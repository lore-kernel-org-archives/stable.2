Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EA0382F0C;
	Wed,  5 Aug 2026 09:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785920572; cv=none; b=uTN23g44CjS8keUrQ0i6Z1FVMznUJgj77QfSSdU8xdQAms7AcKmIMtO9jEXHLbONaPygCTYIQ8fVb05wM0rOGgMd+EKskjLgGEEpA3qyRs8tUBMuBmmX9geTuDGtwNeIhRSKJNJP67yyiiiqmEPrsM8Yvr5kXcxihcYPxmliTjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785920572; c=relaxed/simple;
	bh=rag3IHjmM48e4lcHCcvjbID8rBZPU3Yxplfig+EEkz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UW3deFb/XV0Ip7LLMZgLv3s7KF0C1ney8uPcFwXYXqcfCNm8agAxR7Ud2l1qrGuzBVfMyN6IKGpabADw76NL/gDy2F9NKG0aqYu5RfV+JtBrzhE+m3BjC6nyukqM7ZPiyNWQChwsB2FAOUTAxVJTNNyb7K82AaxzBh2dDKCN4F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U9IFyZF7; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U9IFyZF7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785920572; x=1817456572;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rag3IHjmM48e4lcHCcvjbID8rBZPU3Yxplfig+EEkz8=;
  b=U9IFyZF7ab+58V8CZkkvZ2KXHtJ8DHbT8fw3qgQ/bYEBRFhQfe4H0Eje
   YqtUNU+eYJwTVWQYpZ5N5jXa/U+nhhQJId35jblkYxSqLkGezbh7gPIIE
   Mg6SJqFhKW8qv6nBgR8tDKcf4mY1Amqms5Z30AfK9T1qgi73yqps1T13e
   jGw7NRodQ1QY8/d3V2tgNBIQJQAEQYsNcAasLTBYd8l1eeLNaVkDsmiJp
   IwoOIjSLvEb8DRR1y8Y1SHNUfuXXL8tvsNaiRof2UsWyynYZVuPNKm0Mx
   Hedj6ARSlK/xzK2DCQcPT0FFlkfc3TMJ15UQYclzZvU8+lCFKEWUrjF+I
   Q==;
X-CSE-ConnectionGUID: q9oplZ42T9CA9a8PwrXdIw==
X-CSE-MsgGUID: DuQ6puEMS16AGa5+g4cJzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="96842838"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="96842838"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 02:02:50 -0700
X-CSE-ConnectionGUID: fBAgLRg4QMmkFN8WQ7apvQ==
X-CSE-MsgGUID: 17ZU8pqwSrObzTjq5bxBWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="261814148"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.218])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 02:02:47 -0700
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
Subject: [PATCH 15/17] ASoC: rt1316-sdw: sort the register default table
Date: Wed,  5 Aug 2026 12:02:38 +0300
Message-ID: <20260805090240.16991-16-peter.ujfalusi@linux.intel.com>
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

rt1316_reg_defaults[] is not in address order, so the binary search does
not find one of its entries.  regcache_reg_needs_sync() then cannot
compare it against its default and reports that a sync is needed, so it
is written to the device on every regcache_sync() even when it was never
touched.

Sort the table by register address.

Fixes: 2b719fd20f32 ("ASoC: rt1316: Add RT1316 SDCA vendor-specific driver")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/codecs/rt1316-sdw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt1316-sdw.c b/sound/soc/codecs/rt1316-sdw.c
index ca318dbd946e..0f6fc36e50f0 100644
--- a/sound/soc/codecs/rt1316-sdw.c
+++ b/sound/soc/codecs/rt1316-sdw.c
@@ -59,13 +59,13 @@ static const struct reg_default rt1316_reg_defaults[] = {
 	{ 0xd101, 0x00 },
 	{ 0xd102, 0x30 },
 	{ 0xd103, 0x00 },
-	{ SDW_SDCA_CTL(FUNC_NUM_SMART_AMP, RT1316_SDCA_ENT_UDMPU21, RT1316_SDCA_CTL_UDMPU_CLUSTER, 0), 0x00 },
 	{ SDW_SDCA_CTL(FUNC_NUM_SMART_AMP, RT1316_SDCA_ENT_FU21, RT1316_SDCA_CTL_FU_MUTE, CH_L), 0x01 },
 	{ SDW_SDCA_CTL(FUNC_NUM_SMART_AMP, RT1316_SDCA_ENT_FU21, RT1316_SDCA_CTL_FU_MUTE, CH_R), 0x01 },
 	{ SDW_SDCA_CTL(FUNC_NUM_SMART_AMP, RT1316_SDCA_ENT_XU24, RT1316_SDCA_CTL_BYPASS, 0), 0x01 },
 	{ SDW_SDCA_CTL(FUNC_NUM_SMART_AMP, RT1316_SDCA_ENT_PDE23, RT1316_SDCA_CTL_REQ_POWER_STATE, 0), 0x03 },
 	{ SDW_SDCA_CTL(FUNC_NUM_SMART_AMP, RT1316_SDCA_ENT_PDE22, RT1316_SDCA_CTL_REQ_POWER_STATE, 0), 0x03 },
 	{ SDW_SDCA_CTL(FUNC_NUM_SMART_AMP, RT1316_SDCA_ENT_PDE24, RT1316_SDCA_CTL_REQ_POWER_STATE, 0), 0x03 },
+	{ SDW_SDCA_CTL(FUNC_NUM_SMART_AMP, RT1316_SDCA_ENT_UDMPU21, RT1316_SDCA_CTL_UDMPU_CLUSTER, 0), 0x00 },
 };
 
 static const struct reg_sequence rt1316_blind_write[] = {
-- 
2.55.0

