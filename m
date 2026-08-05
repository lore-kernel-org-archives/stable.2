Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C3945D1A4;
	Wed,  5 Aug 2026 12:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785932928; cv=none; b=DgLmbPTmVK17LTmj9UO4EHotvo1VD+zKrQDmMXf5p93UnLJtzIq29mGD0N9ZhXJLRoVVsc/J1jyF0I2ETjIxWNt/7TNlgM54M6BEDAs1fUpYrUEIVCNIYW1OuXaEw20nH0Pe2Nhsz9b5yZ1LIHZoa7XF4QxiKMh5RnncIl03k2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785932928; c=relaxed/simple;
	bh=v+uBOimTn88grbHFlbmU6EvrL4/2zvy8wCqj/6CJSw4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b4U5sQook29SijHVGEWASrzbLFgKE9qB9AoZq8lICOhQRb6D/R7r0f1IUD9GJc9KVhS0yI19VFPV8/QfNwu68f3HJKcE6vrck3z/YT/jdtNOCqOKJ+NMO2iahFLeuRe2mq+WeLtnZVFOXdOVSKlWaQK/HiWrX7Xj2hsEURL3XWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lgdujYsd; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lgdujYsd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785932928; x=1817468928;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=v+uBOimTn88grbHFlbmU6EvrL4/2zvy8wCqj/6CJSw4=;
  b=lgdujYsdqq2iUJSdR86KGLLurFOJyp4GbEG1ggCWIzPG3MzTXNqJrRiY
   oE1lt39kGQMpUjse+PFYh2aAVH+DKKeYjw9dJxyVHuqZwaQGU0HkH8dWe
   53RvBR2dMFeViz2qs3t7R0LMbuEUedjbMG5I9/UW+M5Uj9p1ZeIRF3COz
   pBtR1cP4pL29B6s2NbqIqTN2gXOZLAxGCE1Np4cd1qRY5Vp4ME8IvhEQA
   BSNsfyGxf2uZoSFal7V5W/hRdQBCw4+gYoHEtn/yvgEZno9jD1QbyGMqE
   Kp3kVuV98IPYpEK/jXNT8iRQ+iO7ULc7osRGmKnVkIlZxDkSpWrPXQYpX
   g==;
X-CSE-ConnectionGUID: ey1L1Rc5T+ig1z1f9+VMyg==
X-CSE-MsgGUID: ZpsY64OaREeh3xVkk0M9Tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="86706841"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="86706841"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 05:27:39 -0700
X-CSE-ConnectionGUID: WlWzlKC+QkaK1niUM1a7Nw==
X-CSE-MsgGUID: EtFzIGJAS/G9OUJ0eqC7tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="285165308"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.218])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 05:27:34 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 0/4] ASoC: codec drivers: sort the reg_defaults tables
Date: Wed,  5 Aug 2026 15:28:07 +0300
Message-ID: <20260805122811.13713-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


reg_defaults must be sorted by ascending register address, since
regcache_lookup_reg() locates entries in it with bsearch().  When a table is
not sorted, bsearch() cannot find the entries which follow a descending step,
so regcache_reg_needs_sync() falls back to reporting that a sync is needed for
them.  Those registers are then written to the device on every regcache_sync()
even when they were never touched.

See commit fd80df352ba1 ("regcache: Add support for sorting defaults arrays")
for the same problem in a different context.

The series is based on broonie/for-linus (05eebef3c7b2).

Affected tables:
  ml26124_reg                1 of 79 entries unreachable
  cx2072x_reg_defaults      75 of 132 entries unreachable
  max9860_reg_defaults       1 of 14 entries unreachable
  stih407_sas_reg_defaults   1 of 2 entries unreachable

Peter Ujfalusi (4):
  ASoC: ml26124: sort the register default table
  ASoC: cx2072x: sort the register default table
  ASoC: max9860: sort the register default table
  ASoC: sti-sas: sort the register default table

 sound/soc/codecs/cx2072x.c | 122 ++++++++++++++++++-------------------
 sound/soc/codecs/max9860.c |   2 +-
 sound/soc/codecs/ml26124.c |   4 +-
 sound/soc/codecs/sti-sas.c |   2 +-
 4 files changed, 66 insertions(+), 64 deletions(-)

-- 
2.55.0

