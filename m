Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D237D246784;
	Wed,  5 Aug 2026 08:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785918226; cv=none; b=WQUcYDlpVJEQa1dZaEZZVemF/T6YuW9k/8nJ+S+8HYo/Lj97VNiV2dp6/U9tTtUrv7jBQc3JTxj+ujm9x4R5pCuJH+9cYhgCtqUn1qSxxos2trMRx1n0+1Sc0YuMiGQ9+djeDno6/ZA7fMVHVc2fYLaoupSSzNIPFdECFpTTKbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785918226; c=relaxed/simple;
	bh=JyV1NvFuwkWfBKZtOmp3nUp+w5JFvRk5Hvd2VoJN5kA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VqGTt26XEFfn3g3JfA4CZeg7ferl8ZZCSqoWFvZdcxiPK6WFI9uvVu7uyFu+pWNC3aFfT+Uiz1tBn6p24Lxinq2rA+c4HhHP0Xosss28aZoYPXdnTEO8tXI2zPpkvEk0Y6t8qWOSqHwgEfflyxI5jeuUBNLeMx3RssUrbsSBDlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HtzNJvIK; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HtzNJvIK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785918225; x=1817454225;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JyV1NvFuwkWfBKZtOmp3nUp+w5JFvRk5Hvd2VoJN5kA=;
  b=HtzNJvIKgrzkFSmlGSWbMJeaaHW4ij9XoYJKEb2YN4Nt5iFCye3XfVuI
   JVr0Avr5pI7GGDSAE7PbWLML1GEoN1m3LzPVjrSrjjc6eBP0K4Q5rMzo2
   uqweWEfThK1+H5/Whkb4Il9i5Nf4rSXkiyvm6rGeJfi/QkVkKtazGf81f
   wYskviazQW9lp2D2yKhoXsgyXIVtVdIQKLzqoeJxnrLES964MJygklbLv
   et5euBziaM/HQyxPv6Vr92OQbeFn+8FklC0hVmKZpcqhelKFNeNB9LLyz
   8YDSbW2O/w2r/wHONRi14yOpb6CUGWVx/XJZ3s4C6U+QpUah5DDiJe/Oh
   g==;
X-CSE-ConnectionGUID: YhZ8myUDTm+queCVIsyA0w==
X-CSE-MsgGUID: YmnHhIlNRvSxjJA0TpxXOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="90299686"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="90299686"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 01:23:44 -0700
X-CSE-ConnectionGUID: VQJJULXhRAK5FSQWCd5ENA==
X-CSE-MsgGUID: irE6ZXmESRyN7VqkvoOwGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="258399587"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.218])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 01:23:41 -0700
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
Subject: [PATCH 2/3] ASoC: cs35l45: sort the register default table
Date: Wed,  5 Aug 2026 11:24:12 +0300
Message-ID: <20260805082413.26174-3-peter.ujfalusi@linux.intel.com>
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

cs35l45_defaults[] lists the DSP1_RX*_RATE and DSP1_TX*_RATE registers
(0x02b80080 - 0x02b802b8) in the middle of the table, ahead of entries with
much lower addresses, so the binary search does not find 36 of its 73
entries.  regcache_reg_needs_sync() then cannot compare those against their
default and reports that a sync is needed, so they are written to the
device on every regcache_sync() even when they were never touched.

Sort the table by register address.

Fixes: 74b14e2850a3 ("ASoC: cs35l45: DSP Support")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/codecs/cs35l45-tables.c | 32 +++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/cs35l45-tables.c b/sound/soc/codecs/cs35l45-tables.c
index d2ecc7b3f619..764dbaa35042 100644
--- a/sound/soc/codecs/cs35l45-tables.c
+++ b/sound/soc/codecs/cs35l45-tables.c
@@ -66,22 +66,6 @@ static const struct reg_default cs35l45_defaults[] = {
 	{ CS35L45_ASPTX3_INPUT,			0x00000020 },
 	{ CS35L45_ASPTX4_INPUT,			0x00000028 },
 	{ CS35L45_ASPTX5_INPUT,			0x00000048 },
-	{ CS35L45_DSP1_RX1_RATE,		0x00000001 },
-	{ CS35L45_DSP1_RX2_RATE,		0x00000001 },
-	{ CS35L45_DSP1_RX3_RATE,		0x00000001 },
-	{ CS35L45_DSP1_RX4_RATE,		0x00000001 },
-	{ CS35L45_DSP1_RX5_RATE,		0x00000001 },
-	{ CS35L45_DSP1_RX6_RATE,		0x00000001 },
-	{ CS35L45_DSP1_RX7_RATE,		0x00000001 },
-	{ CS35L45_DSP1_RX8_RATE,		0x00000001 },
-	{ CS35L45_DSP1_TX1_RATE,		0x00000001 },
-	{ CS35L45_DSP1_TX2_RATE,		0x00000001 },
-	{ CS35L45_DSP1_TX3_RATE,		0x00000001 },
-	{ CS35L45_DSP1_TX4_RATE,		0x00000001 },
-	{ CS35L45_DSP1_TX5_RATE,		0x00000001 },
-	{ CS35L45_DSP1_TX6_RATE,		0x00000001 },
-	{ CS35L45_DSP1_TX7_RATE,		0x00000001 },
-	{ CS35L45_DSP1_TX8_RATE,		0x00000001 },
 	{ CS35L45_DSP1RX1_INPUT,		0x00000008 },
 	{ CS35L45_DSP1RX2_INPUT,		0x00000009 },
 	{ CS35L45_DSP1RX3_INPUT,		0x00000018 },
@@ -114,6 +98,22 @@ static const struct reg_default cs35l45_defaults[] = {
 	{ CS35L45_GPIO1_CTRL1,			0x81000001 },
 	{ CS35L45_GPIO2_CTRL1,			0x81000001 },
 	{ CS35L45_GPIO3_CTRL1,			0x81000001 },
+	{ CS35L45_DSP1_RX1_RATE,		0x00000001 },
+	{ CS35L45_DSP1_RX2_RATE,		0x00000001 },
+	{ CS35L45_DSP1_RX3_RATE,		0x00000001 },
+	{ CS35L45_DSP1_RX4_RATE,		0x00000001 },
+	{ CS35L45_DSP1_RX5_RATE,		0x00000001 },
+	{ CS35L45_DSP1_RX6_RATE,		0x00000001 },
+	{ CS35L45_DSP1_RX7_RATE,		0x00000001 },
+	{ CS35L45_DSP1_RX8_RATE,		0x00000001 },
+	{ CS35L45_DSP1_TX1_RATE,		0x00000001 },
+	{ CS35L45_DSP1_TX2_RATE,		0x00000001 },
+	{ CS35L45_DSP1_TX3_RATE,		0x00000001 },
+	{ CS35L45_DSP1_TX4_RATE,		0x00000001 },
+	{ CS35L45_DSP1_TX5_RATE,		0x00000001 },
+	{ CS35L45_DSP1_TX6_RATE,		0x00000001 },
+	{ CS35L45_DSP1_TX7_RATE,		0x00000001 },
+	{ CS35L45_DSP1_TX8_RATE,		0x00000001 },
 };
 
 static bool cs35l45_readable_reg(struct device *dev, unsigned int reg)
-- 
2.55.0

