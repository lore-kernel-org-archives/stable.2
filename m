Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC9E3E638C;
	Wed,  5 Aug 2026 08:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785918223; cv=none; b=m0B0M8M2u0h6viFLC8wuksamWAhcUf5sPhpkTSCowgkFBfHvlcjTAKh+ZIRHnnj+oe8C1CiDxIV3RyRkqjPS8XhXQ/FEu1OmURaeyg6oTFhKLWA6PttNO3SuNYTYO6xJNw9wuGaoPX6OvpBSGvTkNOvA1wpG5aweg3JeyTsyLS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785918223; c=relaxed/simple;
	bh=zc5Ob0QaFfHkDLOrWlznpizw3hQC2I+mphJ/TGoH9ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ELISKaqPzZ7wqoEky2+SszWi7/5BDZdNzHHHKRUUpUMbrjAqOOVmpzqxH0hIndS5dbaGtq5SaaD8cBnDk6V7b789cOhLjuZ2NFWsgcAFa+6LRG0hGP/5gDNePdVn0LkFWVfzvV0Yx1ZEXKA8ybSNqRdfDVL4FKGd5BpyZrFSgqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=izGegvXQ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="izGegvXQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785918221; x=1817454221;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zc5Ob0QaFfHkDLOrWlznpizw3hQC2I+mphJ/TGoH9ns=;
  b=izGegvXQPym1HL34oly6FWAmoPSQHzWWxXMWGdv+LBeayfLA41dped9q
   C2Eu0ENSGm6ArSk16SL5AmvIsYe75db1RREA6fcwEilEP/FvzjNCi/5t0
   agYxSCK8slw0vVfsDdUW5FyyOUoKcCf7rdf8x2X9+kdO3lcuoOqkL0dWc
   /dmw5DQa49bAIsgN12wDjKOv7IrbZDetF4sTR8wkV47WEfSWyyJ6zryJT
   PsZ3VXpKqFiH/Kcuxvib77Lx87kdU7Gqy2Xp3egHunuCitur76jrNozfI
   Ia10Vp8EG4FAiRvF8fjwO/Nc/rQt0zLVpf8eHCMmaKPU427c3E4Atvij2
   g==;
X-CSE-ConnectionGUID: JBVRkXkCQr64v4PWW/cAeQ==
X-CSE-MsgGUID: bT1e0zifRWSIxOpbUUKvzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="90299670"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="90299670"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 01:23:41 -0700
X-CSE-ConnectionGUID: dHfFzOx2T16Lb/Yo/gttrA==
X-CSE-MsgGUID: TMdVNllrSY+795f2CcxOgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="258399581"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.218])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 01:23:38 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>,
	Vlad Karpovich <vkarpovi@opensource.cirrus.com>,
	Paul Handrigan <Paul.Handrigan@cirrus.com>,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/3] ASoC: cs35l41: sort the register default table
Date: Wed,  5 Aug 2026 11:24:11 +0300
Message-ID: <20260805082413.26174-2-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805082413.26174-1-peter.ujfalusi@linux.intel.com>
References: <20260805082413.26174-1-peter.ujfalusi@linux.intel.com>
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

cs35l41_reg[] lists CS35L41_BSTCVRT_PEAK_CUR (0x3808) after
CS35L41_BSTCVRT_COEFF (0x3810) and CS35L41_BSTCVRT_SLOPE_LBST (0x3814), so
the binary search does not find those two entries.
regcache_reg_needs_sync() then cannot compare them against their default
and reports that a sync is needed, so they are written to the device on
every regcache_sync() even when they were never touched.

Sort the table by register address.

Fixes: 5f2f539901b0 ("ASoC: cs35l41: Correct handling of some registers in the cache")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/codecs/cs35l41-lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs35l41-lib.c b/sound/soc/codecs/cs35l41-lib.c
index 1702f26049d3..b0fa80705be7 100644
--- a/sound/soc/codecs/cs35l41-lib.c
+++ b/sound/soc/codecs/cs35l41-lib.c
@@ -25,9 +25,9 @@ static const struct reg_default cs35l41_reg[] = {
 	{ CS35L41_GPIO_PAD_CONTROL,		0x00000000 },
 	{ CS35L41_GLOBAL_CLK_CTRL,		0x00000003 },
 	{ CS35L41_TST_FS_MON0,			0x00020016 },
+	{ CS35L41_BSTCVRT_PEAK_CUR,		0x0000004A },
 	{ CS35L41_BSTCVRT_COEFF,		0x00002424 },
 	{ CS35L41_BSTCVRT_SLOPE_LBST,		0x00007500 },
-	{ CS35L41_BSTCVRT_PEAK_CUR,		0x0000004A },
 	{ CS35L41_SP_ENABLES,			0x00000000 },
 	{ CS35L41_SP_RATE_CTRL,			0x00000028 },
 	{ CS35L41_SP_FORMAT,			0x18180200 },
-- 
2.55.0

