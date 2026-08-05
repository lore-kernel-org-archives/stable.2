Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8F13E6DD0;
	Wed,  5 Aug 2026 08:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785918229; cv=none; b=rdqkbW67bSKqHoF8kxHhkHSpWVz4lIcewOJvBeBJzuPtnDTDEEtdBXgdboA/7dxQxxjYJUPCM6Z5WmP9Uq0QChjE6RPiEhjM7q4YGHCaSSdTWbV/AYzIq+BrSe2wFpZD4A+XiwFMrKLgRxC6VBxHktImD/ocWxOzBW3mLGdvJ7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785918229; c=relaxed/simple;
	bh=hQ3cw4emNnteLE19TOThWujLZvo5ond+8EBwoMyl/3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bZ3HqmRLzkhFGko+bKx03xtmJS1MhDxsnJoTqA+IAEsBT8h+9likXY0++DlUzVOkzMlvL1R65aXxDHBCwqx+xzJC5KpexERE6ADpG+M+otXU6buvkK6AnDJuyo5I0M27hJl8lfuhmy3IDQP9wn4iYc31s1PsNPNZbMhD+PRlKs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g6jBbByC; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g6jBbByC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785918227; x=1817454227;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hQ3cw4emNnteLE19TOThWujLZvo5ond+8EBwoMyl/3g=;
  b=g6jBbByCiRCcnjrsO/i6XM+8L0gb/bJ3Al1bOmPFQ07VjSmo+ZnrxXUe
   qtmOC7Lm8wW4GaSapeT2APoLUiuPqKLqWR1Mib3usvHtXTzushFtNOrS/
   QFUdIoOO0IhfyBMyGHBSaTTJxO4TkZwfH71cV8mV+TasqpmHwKqS72Fdm
   Qylb5I3x2s4VSWEUExAir6XHsrYdwC6omeMXLOClzts2Ongrsba5b+18R
   NeBiI847gvw8GVFhcMTm9p5+J+t7iKipRIXEYuaQFPMmH5b0Z3SUJnzE/
   sSJbxPfkEAyETSLpTNl6ysIDb+oT503e+zQBz9x8ajEQxTl8pqZr3beGX
   w==;
X-CSE-ConnectionGUID: 2IsMJ1p7T/eyoVSZt8uJ2w==
X-CSE-MsgGUID: kCdcBQ0HQ5+weeHD3gna3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="90299700"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="90299700"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 01:23:47 -0700
X-CSE-ConnectionGUID: vQ2jNeSGR4GvLv8hlon+Sg==
X-CSE-MsgGUID: Dytvy/29TFCzRX5oQE4QiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="258399590"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.218])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 01:23:44 -0700
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
Subject: [PATCH 3/3] ASoC: cs4265: sort the register default table
Date: Wed,  5 Aug 2026 11:24:13 +0300
Message-ID: <20260805082413.26174-4-peter.ujfalusi@linux.intel.com>
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

cs4265_reg_defaults[] lists CS4265_INT_MASK (0x0e),
CS4265_STATUS_MODE_MSB (0x0f) and CS4265_STATUS_MODE_LSB (0x10) after
CS4265_SPDIF_CTL1 (0x11) and CS4265_SPDIF_CTL2 (0x12), so the binary search
does not find those three entries.  regcache_reg_needs_sync() then cannot
compare them against their default and reports that a sync is needed, so
they are written to the device on every regcache_sync() even when they were
never touched.

Sort the table by register address.

Fixes: fb6f806967f6 ("ASoC: Add support for the CS4265 CODEC")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/codecs/cs4265.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs4265.c b/sound/soc/codecs/cs4265.c
index 286d5ca29854..0b7d6826f4e9 100644
--- a/sound/soc/codecs/cs4265.c
+++ b/sound/soc/codecs/cs4265.c
@@ -46,11 +46,11 @@ static const struct reg_default cs4265_reg_defaults[] = {
 	{ CS4265_DAC_CHA_VOL, 0x00 },
 	{ CS4265_DAC_CHB_VOL, 0x00 },
 	{ CS4265_DAC_CTL2, 0xC0 },
-	{ CS4265_SPDIF_CTL1, 0x00 },
-	{ CS4265_SPDIF_CTL2, 0x00 },
 	{ CS4265_INT_MASK, 0x00 },
 	{ CS4265_STATUS_MODE_MSB, 0x00 },
 	{ CS4265_STATUS_MODE_LSB, 0x00 },
+	{ CS4265_SPDIF_CTL1, 0x00 },
+	{ CS4265_SPDIF_CTL2, 0x00 },
 };
 
 static bool cs4265_readable_register(struct device *dev, unsigned int reg)
-- 
2.55.0

