Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B58331A7B;
	Wed,  5 Aug 2026 09:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785920536; cv=none; b=ks7cUu3on9Lo5WEV3z4EViqGupVrdE25/xgh6TJ9Kl0j5uj2nOGrydxVm9Ezr3pDz7klvnjp3RkPG61bmJLk3m1NY37/nXJ73pyYORDTfpHB8mW7BpDm5EnPGXQavl61UwGjFNvCTku5B8j/9cvU7g5IqKwMZZUESJ7EsMcUm+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785920536; c=relaxed/simple;
	bh=7cWOeyhbL+ixHqXvKUiNS07TYxlCM1U5HJUdOi8kTm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UIH5DfqkSvRcGpBiGI42tlU5ZBFXWSHPdFKPBpbGQX6iMB2JCb/Cy95Ju6HlwZ33JmvVFvxmp69m6BsJzn2HO1Zh0RA8I/DN7TfgGEef9Gftm7pQBX+Y3kBVkdhj5USHyNQ2cckCVqAtg4xkhsCzbpq08WnslDuu/yJe+HcMr6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b56l96cJ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b56l96cJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785920535; x=1817456535;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7cWOeyhbL+ixHqXvKUiNS07TYxlCM1U5HJUdOi8kTm4=;
  b=b56l96cJNgdM8/r7DFIrItY8mZVVrsrFQRwPJm8yQSy4RS+w29Dn/GqJ
   w0mrTG/NWWPj2GrtD51gvMAfcaoCIgCs7emIeW+0++PKuQ9BT0SPFmivN
   2jINRFjz7YkHspIcwW27GH9d6+g8hsQX1HNQFCaAlV/XbVRQTRX44Cnhr
   WtoOdR1g4tzoMAlVbPpT3veArIiB76uSD7/Q4Z1IdWavB8BkfQE5hnurF
   TvLcWrv+lDMrX2P0z3ieULe5RqBvyxnd3/cFzv2hJEJcEEAeKzNVXjy0/
   upUN98O1F3FoNDeEEWThuiA9AwUVUUrE9niTE2e52xj0dp/3SHDTE5uXS
   Q==;
X-CSE-ConnectionGUID: PTPOtLsHTC62h0/adKWnNw==
X-CSE-MsgGUID: tx0cAnFhR6a+tLfK7CZl+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="96842706"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="96842706"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 02:02:15 -0700
X-CSE-ConnectionGUID: WRPi6YefTmmpNVrL1uc29A==
X-CSE-MsgGUID: BLo9+XrASRayfB8Rfhr9Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="261813966"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.218])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 02:02:12 -0700
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
Subject: [PATCH 03/17] ASoC: rt298: sort the register default table
Date: Wed,  5 Aug 2026 12:02:26 +0300
Message-ID: <20260805090240.16991-4-peter.ujfalusi@linux.intel.com>
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

Four entries were appended to the end of rt298_reg[] instead of being
inserted at their sorted position and the 0x01470100 entry is listed after
0x01470c00, which leaves 7 of the 39 entries unreachable for the binary
search.  regcache_reg_needs_sync() then cannot compare them against their
default and reports that a sync is needed, so they are written to the
device on every regcache_sync() even when they were never touched.

Sort the table by register address.

Fixes: 6adcafae6ed2 ("ASoC: add rt298 codec driver")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/codecs/rt298.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/rt298.c b/sound/soc/codecs/rt298.c
index 5414a1712b57..09aed08b5b79 100644
--- a/sound/soc/codecs/rt298.c
+++ b/sound/soc/codecs/rt298.c
@@ -78,8 +78,10 @@ static const struct reg_default rt298_reg[] = {
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
@@ -89,16 +91,18 @@ static const struct reg_default rt298_reg[] = {
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
@@ -107,10 +111,6 @@ static const struct reg_default rt298_reg[] = {
 	{ 0x02170700, 0x00000000 },
 	{ 0x02270100, 0x00000000 },
 	{ 0x02370100, 0x00000000 },
-	{ 0x01870700, 0x00000020 },
-	{ 0x00830000, 0x000000c3 },
-	{ 0x00930000, 0x000000c3 },
-	{ 0x01270700, 0x00000000 },
 };
 
 static bool rt298_volatile_register(struct device *dev, unsigned int reg)
-- 
2.55.0

