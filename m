Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523063EEAD0;
	Wed,  5 Aug 2026 09:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785920559; cv=none; b=ORby/YjHn4XfsACgR9dw5uJ7zZtvDI4u28onTJaqW0E6WZtJnTVNRkuVLYOcVhdH6xmrvzgIYqnvUoGQrOlMZzCMFs0rCChn+a/2NvV9O99NCSlJiPqXBxNHM6RNPuAmN8BR80VS7ghjoltRU6HL8aGrHizskNVpUVaHlHvlVxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785920559; c=relaxed/simple;
	bh=cPN8Qz3KOFs5mdsyT8q0l/4vH+QkMluN86LjoILSoS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kggnQ2E0VvxgOBdETB8+QjUTAzpAbHiGZDYvRgiwXBDmWPDmSM4pxe5FodEsx+G4ncZ/xeQOAH9frP2z6C4euyzF6i+qXkkgTPpe3e9sKzhoFBlblwWkpJ6+7Pq8cCRd33CoFBPW29hoC3RHtFh35h9S++gwil/W0G3w+rk8mh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S+6BE+4o; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S+6BE+4o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785920557; x=1817456557;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cPN8Qz3KOFs5mdsyT8q0l/4vH+QkMluN86LjoILSoS8=;
  b=S+6BE+4oLTHMVBq2gBkglNjiDajXzZxkd/09S7TRHznIuCiEzX2KGyZt
   ik5wfk98LXpcfdSgJ52psAUw0l/WLEZzgwJn4ak57iuEEB6JDcPw9a6iK
   vp8Q0RQjSxD38e+vTvPRWGfkHJ/UjrptjYjulgCRDYr8tm2UP1+qaCuyX
   wXliqzo3k/hV2hbO3cnXHInZRe1ovMoiG/ZK/wV4OOJQT+2G+HfcmZjeE
   trxIx+Fjr5v547WR4YEW0OvTT3GQl/fxDpWaFfzVP+v8y9W9xZIICDO1O
   A+LTgb3NBLCjj3c2W92eekvCz3ihaHeHyRAExExUoKrYZsYkXW4A9KuAo
   w==;
X-CSE-ConnectionGUID: rufM9YtxTHOGUZ44BUqHJA==
X-CSE-MsgGUID: 2JZqecueRRm4ZVQkHmMq8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="96842781"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="96842781"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 02:02:35 -0700
X-CSE-ConnectionGUID: 0I5mG4qZSgWRu69eEWW2tg==
X-CSE-MsgGUID: tDRmJM4TTFanKuxw94Fw6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="261814061"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.218])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 02:02:32 -0700
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
Subject: [PATCH 10/17] ASoC: rt715: sort the register default table
Date: Wed,  5 Aug 2026 12:02:33 +0300
Message-ID: <20260805090240.16991-11-peter.ujfalusi@linux.intel.com>
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

At the end of rt715_reg_defaults[] the 0x82xx and 0x83xx entries are
interleaved with the 0x72xx and 0x73xx entries they belong to, and 0x385e
is listed before 0x3859.  This leaves 25 of the 323 entries unreachable for
the binary search.  regcache_reg_needs_sync() then cannot compare them
against their default and reports that a sync is needed, so they are
written to the device on every regcache_sync() even when they were never
touched.

Sort the table by register address.

Fixes: d1ede0641b05 ("ASoC: rt715: add RT715 codec driver")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/codecs/rt715-sdw.h | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/rt715-sdw.h b/sound/soc/codecs/rt715-sdw.h
index 5d7661e335ae..f19fafb913f0 100644
--- a/sound/soc/codecs/rt715-sdw.h
+++ b/sound/soc/codecs/rt715-sdw.h
@@ -281,8 +281,8 @@ static const struct reg_default rt715_reg_defaults[] = {
 	{ 0x371b, 0x00 },
 	{ 0x371d, 0x00 },
 	{ 0x3729, 0x00 },
-	{ 0x385e, 0x00 },
 	{ 0x3859, 0x00 },
+	{ 0x385e, 0x00 },
 	{ 0x4c12, 0x411111f0 },
 	{ 0x4c13, 0x411111f0 },
 	{ 0x4c1d, 0x411111f0 },
@@ -300,36 +300,36 @@ static const struct reg_default rt715_reg_defaults[] = {
 	{ 0x4f1d, 0x411111f0 },
 	{ 0x4f29, 0x411111f0 },
 	{ 0x7207, 0x00 },
-	{ 0x8287, 0x00 },
 	{ 0x7208, 0x00 },
-	{ 0x8288, 0x00 },
 	{ 0x7209, 0x00 },
-	{ 0x8289, 0x00 },
 	{ 0x7227, 0x00 },
-	{ 0x82a7, 0x00 },
 	{ 0x7307, 0x97 },
-	{ 0x8387, 0x97 },
 	{ 0x7308, 0x97 },
-	{ 0x8388, 0x97 },
 	{ 0x7309, 0x97 },
-	{ 0x8389, 0x97 },
 	{ 0x7312, 0x00 },
-	{ 0x8392, 0x00 },
 	{ 0x7313, 0x00 },
-	{ 0x8393, 0x00 },
 	{ 0x7318, 0x00 },
-	{ 0x8398, 0x00 },
 	{ 0x7319, 0x00 },
-	{ 0x8399, 0x00 },
 	{ 0x731a, 0x00 },
-	{ 0x839a, 0x00 },
 	{ 0x731b, 0x00 },
-	{ 0x839b, 0x00 },
 	{ 0x731d, 0x00 },
-	{ 0x839d, 0x00 },
 	{ 0x7327, 0x97 },
-	{ 0x83a7, 0x97 },
 	{ 0x7329, 0x00 },
+	{ 0x8287, 0x00 },
+	{ 0x8288, 0x00 },
+	{ 0x8289, 0x00 },
+	{ 0x82a7, 0x00 },
+	{ 0x8387, 0x97 },
+	{ 0x8388, 0x97 },
+	{ 0x8389, 0x97 },
+	{ 0x8392, 0x00 },
+	{ 0x8393, 0x00 },
+	{ 0x8398, 0x00 },
+	{ 0x8399, 0x00 },
+	{ 0x839a, 0x00 },
+	{ 0x839b, 0x00 },
+	{ 0x839d, 0x00 },
+	{ 0x83a7, 0x97 },
 	{ 0x83a9, 0x00 },
 	{ 0x752039, 0xa500 },
 };
-- 
2.55.0

