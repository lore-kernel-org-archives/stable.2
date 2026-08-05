Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1F345D1A4;
	Wed,  5 Aug 2026 12:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785932816; cv=none; b=FpUpov2kmm2S7nP4KtpaejdKshjzA5U2bjgML/rHqcxeQP8npIZe7vO0uN1UOLx3WQfXbFnO17uqdIF5rSg0nRwVAoXntePZekxiG5Bxo9qCkrl28he8/QQ/XB8kSRtI3o2TxrKPa2HL+6QSPb6SW32V/IGlr4pJYaxRjO0vYTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785932816; c=relaxed/simple;
	bh=htpzpon18WeiEBFp6iHxjlhYa9chJGsaqn5wibjn60w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k2tUy692WunniPCX90gz6XdGVAyeaNy6xMu+dBXyDI51VV9o3UPpkktLwZZzXwCtP+g85nGAppE1h1mCfgwnF0OXnh8Fi85ZhCZBlj8Zi4mhJEKM7qY1EX8KDL7U4eUABBg6JygN3wmWeb/w33EmWZkvA/zcE6u3WhhkEiDLWWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SAfKGpHC; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SAfKGpHC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785932814; x=1817468814;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=htpzpon18WeiEBFp6iHxjlhYa9chJGsaqn5wibjn60w=;
  b=SAfKGpHChaM3o3z1FoESAJKSsBjcbExrPWz2zsAn5HI9TliUC491xQ+I
   VHT67V1Fi/cE9eajE1DLatOMTMdm82cDQRA0lXrUnRlMHVFIm3B9SFxdN
   bKMU4CrIvFQUBAj4zALjXerg7puUMiN3Vmv4yjPTb8XZ4bJT3MhoHRYMK
   3joEWkDXuMA7+7JqvkUAlIDI3A+1xThh4LWvR5dHfnzyArYzgepwghTTf
   Ru/2woCDZ7+x8o/KeEY82T51Wbj7764ahOHknMOA1Cw8fsWHratMV/fYO
   ESYRQbecfz9C/rkJhAMT1OQM5oWTZrZeQ/m7frR3oo/Aj2BbNAIkKGu8i
   g==;
X-CSE-ConnectionGUID: rUjvzPh8Q22rFnGnf0fRew==
X-CSE-MsgGUID: YTWYdgUuQpKQKnb3hxLqmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="86583162"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="86583162"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 05:26:53 -0700
X-CSE-ConnectionGUID: xxvm/On6RBaFy4F4zsaw7Q==
X-CSE-MsgGUID: WJXIZmG0SieRKTrfKjrDXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="258460211"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.218])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 05:26:50 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>
Cc: linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 0/2] ASoC: NXP/Freescale: sort the reg_defaults tables
Date: Wed,  5 Aug 2026 15:27:26 +0300
Message-ID: <20260805122728.12362-1-peter.ujfalusi@linux.intel.com>
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
  sgtl5000_reg_defaults    1 of 35 entries unreachable
  fsl_easrc_reg_defaults   3 of 120 entries unreachable

Peter Ujfalusi (2):
  ASoC: sgtl5000: sort the register default table
  ASoC: fsl_easrc: sort the register default table

 sound/soc/codecs/sgtl5000.c | 2 +-
 sound/soc/fsl/fsl_easrc.c   | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.55.0

