Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C67E3E557D;
	Wed,  5 Aug 2026 09:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785920542; cv=none; b=Em0RgpNpdI3YhaM/yUlhXlIZJfb0DslrhyuGbYA1e445d0HH6oTakNxYnP2XwrodYDo8GMtisvmywT2/upwrxZNUPOjwhBKx52y8OwI8oNiYoUCxqDLog/9ngSCOtOP3X4USXmm95z02BZk/dfxBo+0ET6izdADWwhfoA4xnNkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785920542; c=relaxed/simple;
	bh=RfqzY5z6NH3yhNr7QKjh4/BHIxNCOf+rRUqAZpBiFhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ez3W07SykwnHo0OBQMmUjBI9taZxihNFxqHNb0DCE68FTyQmnQl6BWnDCcJbBKux27XGPvLSl292bbQzWeW59fSqHzfFUN+BCSqg93CdHuMCLdTpKUwQ4t5rBI5+/EfvePZMg+hAyUwU44EQAkatn4X9ISKEfY7lHWKt4qlyNko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BXPP0w4e; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BXPP0w4e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785920541; x=1817456541;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RfqzY5z6NH3yhNr7QKjh4/BHIxNCOf+rRUqAZpBiFhI=;
  b=BXPP0w4efjKNTYAVlmXNg+ClDydpvn194rSrCzYcFYS4ethQAChBfmkT
   0ic561Q47d1ajfHfrRsg+kJ+UulA+GUIUJHSkig0GevtBjnLWvnMjmHU1
   cgf3fKT6o821TmKW0KqGKwTaFqQ/N0dGrH6nTv/q94rFjemPfGb43hDPj
   AB5djyFTivdgL/gc4d7Wk8etrQySHZZKrtS2xE4r+40MsTnTmQpt7b+E1
   rvHH6NSB5eWtIdyXIdAqMqlNHUFeSqNhUEEc8bxN3aM2t+FlMnRr75Zbc
   M+xkP0vUaVBoYLTFMSoiUF6MJXerYF0AdcqHloDNyryavP8vQmjMAdc3v
   w==;
X-CSE-ConnectionGUID: mBeitScwQdCLZDuY3/awEQ==
X-CSE-MsgGUID: Vp/p+iEtR3iTy2s3ahWtmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="96842726"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="96842726"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 02:02:21 -0700
X-CSE-ConnectionGUID: 3Mvd5P/9TAi2B4o1a4FjFQ==
X-CSE-MsgGUID: ksWHglgTQk2gg5p7FqeABQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="261813996"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.218])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 02:02:18 -0700
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
Subject: [PATCH 05/17] ASoC: rt700: sort the register default table
Date: Wed,  5 Aug 2026 12:02:28 +0300
Message-ID: <20260805090240.16991-6-peter.ujfalusi@linux.intel.com>
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

At the end of rt700_reg_defaults[] the 0x83xx entries are interleaved with
the 0x73xx entries they belong to, which leaves 6 of the entries
unreachable for the binary search.  regcache_reg_needs_sync() then cannot
compare them against their default and reports that a sync is needed, so
they are written to the device on every regcache_sync() even when they were
never touched.

Sort the table by register address.

Fixes: 7d2a5f9ae41e ("ASoC: rt700: add rt700 codec driver")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/codecs/rt700-sdw.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt700-sdw.h b/sound/soc/codecs/rt700-sdw.h
index d2e7381d03b8..002f94493b01 100644
--- a/sound/soc/codecs/rt700-sdw.h
+++ b/sound/soc/codecs/rt700-sdw.h
@@ -313,16 +313,16 @@ static const struct reg_default rt700_reg_defaults[] = {
 	{ 0x3122, 0x0000 },
 	{ 0x3123, 0x0000 },
 	{ 0x7303, 0x0057 },
-	{ 0x8383, 0x0057 },
 	{ 0x7308, 0x0097 },
-	{ 0x8388, 0x0097 },
 	{ 0x7309, 0x0097 },
-	{ 0x8389, 0x0097 },
 	{ 0x7312, 0x0000 },
-	{ 0x8392, 0x0000 },
 	{ 0x7313, 0x0000 },
-	{ 0x8393, 0x0000 },
 	{ 0x7319, 0x0000 },
+	{ 0x8383, 0x0057 },
+	{ 0x8388, 0x0097 },
+	{ 0x8389, 0x0097 },
+	{ 0x8392, 0x0000 },
+	{ 0x8393, 0x0000 },
 	{ 0x8399, 0x0000 },
 	{ 0x75201a, 0x8003 },
 	{ 0x752045, 0x5289 },
-- 
2.55.0

