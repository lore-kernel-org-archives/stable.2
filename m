Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2E83E5598;
	Wed,  5 Aug 2026 09:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785920577; cv=none; b=UAqjiNBS8JQR4L8qs/zXlGONGKWeTDqxMDST8pnqIs6iNMUN9GeIcxrxG8qbAWKyBugM38upCltYV0bOSyN5qKs+zQnde/cNvIh2mGmAa4stxkPJmOFuJwupv/sqmc7XkHm2xNXts7k0JgUKRYi8jimXPEX9iJenu3DIFYt84CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785920577; c=relaxed/simple;
	bh=J93qoHXjBjc74cgTqVgXjQlZDmcrPY0aj6COdz/tNgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kyLNynL9GX0SrJ+WQ6tKcVpRBYFZX3qxnCGW3t2cwp6V1HvpS6rNXHOzcdTQkQvqIxTSycjLNblO8G8MlszWNGt//pJzy1mE2ceCQo/x91oriW6wvPqzsP8lbZX4bILHOcQzsw0D+9vpteWsR4rhbbKHLl6+JDkLREiBDHnMGuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MZOpOuay; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MZOpOuay"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785920576; x=1817456576;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J93qoHXjBjc74cgTqVgXjQlZDmcrPY0aj6COdz/tNgM=;
  b=MZOpOuayIEzN1UlJQ++r/ByeNgX4HP6UF5QPoLYymYQi/GIl2UrD9FTM
   mNGjZOriSEMV/YdJv4IZAtcyyK30Y9AJYXVspfBcCwB0/OeqkujCjLfyf
   cLXp1m2YECvlRSNTAodzp5aIXZT8X38tMqQfU7YP6P5O6yVApexLgh81s
   icU6/R6qj6XcZxmrt33Euh40tUZaLmhBh9nKtmai8B1xEAxiNHJ5FoUIv
   MIRnBS4Id6vSRnAAUrsWmbEkNpLaRahat63vk9Zkg9WLrAJK3WP28ItT7
   rjCvApv4ZqBfKcXhgcL8L4zYQVwnK1ulTC/6r/WD50yySxCInUE0dzih6
   Q==;
X-CSE-ConnectionGUID: jhUAgq0BRFSc/2ZHmDejIg==
X-CSE-MsgGUID: R7kdTtd2TVimtUnh2CbHzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="96842862"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="96842862"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 02:02:56 -0700
X-CSE-ConnectionGUID: KefTCzMiRBqQ1DCnoVh7FQ==
X-CSE-MsgGUID: gcokNtTrTfSuPfhL9jqfxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="261814176"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.218])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 02:02:53 -0700
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
Subject: [PATCH 17/17] ASoC: rt1318-sdw: sort the register default table
Date: Wed,  5 Aug 2026 12:02:40 +0300
Message-ID: <20260805090240.16991-18-peter.ujfalusi@linux.intel.com>
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

rt1318_reg_defaults[] is not in address order, so the binary search does
not find 3 of its entries.  regcache_reg_needs_sync() then cannot compare
those against their default and reports that a sync is needed, so they
are written to the device on every regcache_sync() even when they were
never touched.

Sort the table by register address.

Fixes: 6ad73a2b42ea ("ASoC: rt1318: Add RT1318 SDCA vendor-specific driver")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/codecs/rt1318-sdw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt1318-sdw.c b/sound/soc/codecs/rt1318-sdw.c
index c038ac0e3b76..2f1a776585fc 100644
--- a/sound/soc/codecs/rt1318-sdw.c
+++ b/sound/soc/codecs/rt1318-sdw.c
@@ -235,10 +235,10 @@ static const struct reg_default rt1318_reg_defaults[] = {
 	{ 0xf805, 0x00 },
 	{ 0xf806, 0x07 },
 	{ 0xf807, 0xff },
-	{ SDW_SDCA_CTL(FUNC_NUM_SMART_AMP, RT1318_SDCA_ENT_UDMPU21, RT1318_SDCA_CTL_UDMPU_CLUSTER, 0), 0x00 },
 	{ SDW_SDCA_CTL(FUNC_NUM_SMART_AMP, RT1318_SDCA_ENT_FU21, RT1318_SDCA_CTL_FU_MUTE, CH_L), 0x01 },
 	{ SDW_SDCA_CTL(FUNC_NUM_SMART_AMP, RT1318_SDCA_ENT_FU21, RT1318_SDCA_CTL_FU_MUTE, CH_R), 0x01 },
 	{ SDW_SDCA_CTL(FUNC_NUM_SMART_AMP, RT1318_SDCA_ENT_PDE23, RT1318_SDCA_CTL_REQ_POWER_STATE, 0), 0x03 },
+	{ SDW_SDCA_CTL(FUNC_NUM_SMART_AMP, RT1318_SDCA_ENT_UDMPU21, RT1318_SDCA_CTL_UDMPU_CLUSTER, 0), 0x00 },
 	{ SDW_SDCA_CTL(FUNC_NUM_SMART_AMP, RT1318_SDCA_ENT_CS21, RT1318_SDCA_CTL_SAMPLE_FREQ_INDEX, 0), 0x09 },
 };
 
-- 
2.55.0

