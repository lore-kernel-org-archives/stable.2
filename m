Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56F3331A7B;
	Wed,  5 Aug 2026 09:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785920533; cv=none; b=bQdUAhQtg9htN09aaP4pb6ZszeoHGyNrBdwG9b7LqD51RrQ8ecixkmnFinA+82l1UBROi7k2bqG9fYDsXy7ZqdJy6/DJGnvBvHI4AJ3668P3pCHHkG2zFvyzuf12SqvhEzNVpJi7YdFqjH6GXStorR3k9a9fQr8aDo5NU73QanM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785920533; c=relaxed/simple;
	bh=alX23WxJKljSlLrM+Azo7idAxNedamo9gcAXhZx77mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HCPdeUy5bP8KJ3Vmj6Unt2SXbTx5h2qMvk+ldw5JAf/nLFJwkcV8h4g3G5RXmeRi/9ejReMn9API2ZBi3Keccs5KNy7EeINEeGEpCNSVhFL87vHp/yIUFCVcj1Nn3lt63DyMI2r8c9ymgngLYwoA1pCvfRzPk/zs9Ziw07QBKsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BaVRl+kS; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BaVRl+kS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785920532; x=1817456532;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=alX23WxJKljSlLrM+Azo7idAxNedamo9gcAXhZx77mc=;
  b=BaVRl+kS3kQaojSkMu2iE1gkRvBhiT2hYZKxeQ7n0FEDVTYP8N/q+R6p
   CHqKYre+wQMEJerDfyOM0Mf4Tw4JedAABCoK6mb6ZCoTQmukEEVGsFJ0G
   vSvZhT2qMNJVGCyUPWllh4tGju4H3AeCzetiISDF3lL/eOeNgzvBySOhq
   mXPJHRKPDt26S69HwyK9TaD7n7oLYXX5KHpX3KoeAhMwO+XzS2yWePGYz
   eYwvgzJOGT970JW2IKCUvhYvtWK7wqzCZRjn3RXDTDmGIl03HPcQor900
   TTJeZCCh9twJdWAe2WGg84enSc8MnAAy1Z9Ax0ajou7UkjY/HooDxTLiU
   Q==;
X-CSE-ConnectionGUID: EKYB3nBCTtC3NmEeJNdQyg==
X-CSE-MsgGUID: UrSRWleJT0mNKvTT0w4YWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="96842686"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="96842686"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 02:02:12 -0700
X-CSE-ConnectionGUID: VC7gSe4VS3afEoLVA31DCA==
X-CSE-MsgGUID: xRZRjv5FQhyr3EsPUVtvQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="261813956"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.218])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 02:02:09 -0700
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
Subject: [PATCH 02/17] ASoC: rt286: sort the register default table
Date: Wed,  5 Aug 2026 12:02:25 +0300
Message-ID: <20260805090240.16991-3-peter.ujfalusi@linux.intel.com>
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

Four entries were appended to the end of rt286_reg[] instead of being
inserted at their sorted position and the 0x01470100 entry is listed after
0x01470c00, which leaves 7 of the 39 entries unreachable for the binary
search.  regcache_reg_needs_sync() then cannot compare them against their
default and reports that a sync is needed, so they are written to the
device on every regcache_sync() even when they were never touched.

Sort the table by register address.

Fixes: 07cf7cbadb4d ("ASoC: add RT286 CODEC driver")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/codecs/rt286.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index ded0ea332480..4217467904d6 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -77,8 +77,10 @@ static const struct reg_default rt286_reg[] = {
 	{ 0x0023a000, 0x0000007f },
 	{ 0x00270500, 0x00000400 },
 	{ 0x00370500, 0x00000400 },
+	{ 0x00830000, 0x000000c3 },
 	{ 0x00870500, 0x00000400 },
 	{ 0x00920000, 0x00000031 },
+	{ 0x00930000, 0x000000c3 },
 	{ 0x00935000, 0x000000c3 },
 	{ 0x00936000, 0x000000c3 },
 	{ 0x00970500, 0x00000400 },
@@ -88,16 +90,18 @@ static const struct reg_default rt286_reg[] = {
 	{ 0x00c37000, 0x00000000 },
 	{ 0x00c37100, 0x00000080 },
 	{ 0x01270500, 0x00000400 },
+	{ 0x01270700, 0x00000000 },
 	{ 0x01370500, 0x00000400 },
 	{ 0x01371f00, 0x411111f0 },
 	{ 0x01439000, 0x00000080 },
 	{ 0x0143a000, 0x00000080 },
-	{ 0x01470700, 0x00000000 },
+	{ 0x01470100, 0x00000000 },
 	{ 0x01470500, 0x00000400 },
+	{ 0x01470700, 0x00000000 },
 	{ 0x01470c00, 0x00000000 },
-	{ 0x01470100, 0x00000000 },
 	{ 0x01837000, 0x00000000 },
 	{ 0x01870500, 0x00000400 },
+	{ 0x01870700, 0x00000020 },
 	{ 0x02050000, 0x00000000 },
 	{ 0x02139000, 0x00000080 },
 	{ 0x0213a000, 0x00000080 },
@@ -106,10 +110,6 @@ static const struct reg_default rt286_reg[] = {
 	{ 0x02170700, 0x00000000 },
 	{ 0x02270100, 0x00000000 },
 	{ 0x02370100, 0x00000000 },
-	{ 0x01870700, 0x00000020 },
-	{ 0x00830000, 0x000000c3 },
-	{ 0x00930000, 0x000000c3 },
-	{ 0x01270700, 0x00000000 },
 };
 
 static bool rt286_volatile_register(struct device *dev, unsigned int reg)
-- 
2.55.0

