Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773543E3D9E;
	Wed,  5 Aug 2026 08:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785918221; cv=none; b=XA25Ct2Gdum1k1VuHd8tzZ0v+gB+W0QA1h59KT9tbCQxIsDF8ZgBT/u0I+t0RVPX4N24zbXgDHFS5KPUaeL8AKkoqbTY5mK0wgV3q7ZmIenSPOJvVU1ozpx5H0jlT8g5zK/W++m941ua+GlgxZcoVLw3oe+hO8fYD3D9BVwtPHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785918221; c=relaxed/simple;
	bh=ut59ojZDKcMKrcVSEGAbZiGjPEGmBCKwwseICYSsykw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J52RDYErO2evc/LNEcJfLl8AIfqUXnHyNMs3v2vL7b97iqaRFgc3YbbEe4Y/tHzH/Z76Mz8kSxFMiJdzKV88Fmh0ff9c0SDRwymjk8E1nfjPDZO6FDGlnhSI8yx1rgQIN+sy2zgjG3Ia8wQc1KUTm6UEaRWgsN1My/pd7hBdO/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N9g2N4/g; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N9g2N4/g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785918218; x=1817454218;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ut59ojZDKcMKrcVSEGAbZiGjPEGmBCKwwseICYSsykw=;
  b=N9g2N4/g8Bbsden2+bpf4bCDxFfVw0M9cRkbVOsR/7xzKRaPBEPMAd+C
   qdb61pU5pJI8j/RNCKgTMCb2ul9M/OOhP+ZW/Gy7tVtEawCS67WkZsU3P
   6PxVFk4nIcnXGgp2kTAxUj9hvHfUU82YRcaszDjaTCyugXHPW2FrStIRf
   e8LAymndW9Ok1yRl0ImXLD75qffFUEbRkB0fOBTkuvJ4OCpYQHA2PhYBt
   nlm0dwHncVfiqj7qNoi9oXPHaenlGKYfU2t0K7IURnt5amCsXhUSGRKJd
   gU1gvX+mxU+Bo6nAJwZzMqi5KsN4Kla+Hn26BPDOWd+FNYsKm56xb7N5C
   A==;
X-CSE-ConnectionGUID: vMTPil+/QduWCGFA/ZupLw==
X-CSE-MsgGUID: ocexnr9NTS+hyRnzoxw+EQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="90299661"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="90299661"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 01:23:38 -0700
X-CSE-ConnectionGUID: OY1prbhdSxyGARjzrvdwMA==
X-CSE-MsgGUID: /4fPWiUFTe2oxG+/zARYmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="258399579"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.218])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 01:23:35 -0700
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
Subject: [PATCH 0/3] ASoC: cs35l41/cs35l45/cs4265: sort the reg_defaults tables
Date: Wed,  5 Aug 2026 11:24:10 +0300
Message-ID: <20260805082413.26174-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

reg_defaults must be sorted by ascending register address as
regcache_lookup_reg() locates the entries in it with bsearch(), see commit
fd80df352ba1 ("regcache: Add support for sorting defaults arrays").

These three tables have entries which are out of order, so the binary search
does not find part of them.  For those registers regcache_reg_needs_sync()
cannot compare the cached value against the default and reports that a sync
is needed, so they are written to the device on every regcache_sync() even
when they were never touched.

The patches only reorder the existing entries, the text of every entry is
kept verbatim and no default value is changed.  Each table was verified by
evaluating the register addresses and replaying lib/bsearch.c on them.

Entries not reachable by the binary search, per table:

  cs35l41_reg           2 (of 47)
  cs35l45_defaults     36 (of 73)
  cs4265_reg_defaults   3 (of 16)

For cs35l45 this is nearly half of the table: the DSP1_RX*_RATE and
DSP1_TX*_RATE registers sit in the middle of it while their addresses are
far above everything else, which cuts the search off from the whole
0x4c40 - 0xf010 range.

Found by an audit of all reg_defaults tables under sound/, the SoundWire
codec drivers are fixed by a separate series.

Regards,
Peter

Peter Ujfalusi (3):
  ASoC: cs35l41: sort the register default table
  ASoC: cs35l45: sort the register default table
  ASoC: cs4265: sort the register default table

 sound/soc/codecs/cs35l41-lib.c    |  2 +-
 sound/soc/codecs/cs35l45-tables.c | 32 +++++++++++++++----------------
 sound/soc/codecs/cs4265.c         |  4 ++--
 3 files changed, 19 insertions(+), 19 deletions(-)


base-commit: 05eebef3c7b2e8595fdd1bd46912aac9c1de8587
-- 
2.55.0

