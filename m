Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A993EFD25;
	Wed,  5 Aug 2026 09:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785920530; cv=none; b=Pn2QOcLvNMDhulYCfw+bHVqkyQRHvV0RUwM48rE8fRGbjlMkUokXtCxgXhxiVwV1UyUMJSpOZUz7xnIeruX2RrjURpNyTybyIhmkuM8Y1935cvQcZFc//1kU6ivgv4P1BUsEmn1MwEAq66V3LoHzd75l8W2pLNXtmgFZnJEUsKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785920530; c=relaxed/simple;
	bh=IQjEQ3FJD4mKW33N1gRwDUlrGvO0lsFduduTtZaTAGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=udUkEp0wNMtzpMIKH+FUru+1DWXHXeMfLQS0T6CCvh1FE1KdDCkzdReGbRO4EOeZJa9Xn4fMwad1jfiLyxPlu7M/TK/bPhlAHiIU1e0SteM+E2enPFcq7aerwZJnC7HZkyV5NNbueJ7OL9wZhABFrrZVmU3Yi0+Z+4sadu7+unY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DEC1mh3M; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DEC1mh3M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785920529; x=1817456529;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IQjEQ3FJD4mKW33N1gRwDUlrGvO0lsFduduTtZaTAGo=;
  b=DEC1mh3MscCJas6ZTk1YBfacunx9Ff9rbj9Lha79Ih74Iy5gmfzZW9yp
   HNMVGvJ1Qg9fWvG+YcsNpaSbef9HQ5QwhHKRavGGuNbR60Ai3SiYu1GNb
   F1QNkQQyH/1/ftK7KAOO9nzCU9uwwaPeG+/REGCfYdIYjq7AHyw4ClJ/B
   YkKRg23X7aQIPCzUUZDENZd2jfhyTPqWzJ4Uqb4K/yJhf978tg8RI+GQQ
   8+/6r7uvoR5iO7C0/bWtlKu5SqLVa7CGOtb2+xx9gBJqsR6YvCEKN53gq
   XDtJZ3j3gBHsPsh4TsW/HhwmvCJWcVyAB49xv+z9RfuVO8s4kXqOhfv3l
   A==;
X-CSE-ConnectionGUID: lXelozPVR1mAd6vYCIWG6g==
X-CSE-MsgGUID: uvu8ShhMQvSlqTv+YGujRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="96842673"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="96842673"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 02:02:09 -0700
X-CSE-ConnectionGUID: JGY1QwyDR2y+V8nh7fFQ0A==
X-CSE-MsgGUID: 8/w7OnR9RviI5ZeuxC59+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="261813949"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.218])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 02:02:06 -0700
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
Subject: [PATCH 01/17] ASoC: rt274: sort the register default table
Date: Wed,  5 Aug 2026 12:02:24 +0300
Message-ID: <20260805090240.16991-2-peter.ujfalusi@linux.intel.com>
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

Four entries were appended to the end of rt274_reg[] instead of being
inserted at their sorted position, which leaves 7 of the 33 entries
unreachable for the binary search.  regcache_reg_needs_sync() then cannot
compare them against their default and reports that a sync is needed, so
they are written to the device on every regcache_sync() even when they were
never touched.

Sort the table by register address.

Fixes: c7e79b2b2d2d ("ASoC: rt274: add rt274 codec driver")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/codecs/rt274.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt274.c b/sound/soc/codecs/rt274.c
index 63b5fc439773..f8c370106504 100644
--- a/sound/soc/codecs/rt274.c
+++ b/sound/soc/codecs/rt274.c
@@ -184,8 +184,10 @@ static const struct reg_default rt274_reg[] = {
 	{ 0x0023a000, 0x00000057 },
 	{ 0x00270500, 0x00000400 },
 	{ 0x00370500, 0x00000400 },
+	{ 0x00830000, 0x00000097 },
 	{ 0x00870500, 0x00000400 },
 	{ 0x00920000, 0x00000031 },
+	{ 0x00930000, 0x00000097 },
 	{ 0x00935000, 0x00000097 },
 	{ 0x00936000, 0x00000097 },
 	{ 0x00970500, 0x00000400 },
@@ -195,10 +197,12 @@ static const struct reg_default rt274_reg[] = {
 	{ 0x00c37000, 0x00000400 },
 	{ 0x00c37100, 0x00000400 },
 	{ 0x01270500, 0x00000400 },
+	{ 0x01270700, 0x00000000 },
 	{ 0x01370500, 0x00000400 },
 	{ 0x01371f00, 0x411111f0 },
 	{ 0x01937000, 0x00000000 },
 	{ 0x01970500, 0x00000400 },
+	{ 0x01970700, 0x00000020 },
 	{ 0x02050000, 0x0000001b },
 	{ 0x02139000, 0x00000080 },
 	{ 0x0213a000, 0x00000080 },
@@ -207,10 +211,6 @@ static const struct reg_default rt274_reg[] = {
 	{ 0x02170700, 0x00000000 },
 	{ 0x02270100, 0x00000000 },
 	{ 0x02370100, 0x00000000 },
-	{ 0x01970700, 0x00000020 },
-	{ 0x00830000, 0x00000097 },
-	{ 0x00930000, 0x00000097 },
-	{ 0x01270700, 0x00000000 },
 };
 
 static bool rt274_volatile_register(struct device *dev, unsigned int reg)
-- 
2.55.0

