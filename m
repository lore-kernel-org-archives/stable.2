Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3746A34AB19;
	Wed,  5 Aug 2026 09:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785920544; cv=none; b=cGIHYy+DMYXTpyMbgWkYdvvEM1w4Zd6lw7kvOLjIY515mipLuwcFtZJfGIJlPalKXKdIqrv7KmSUkzjKb4sgPucXCx2eu4JmUjouIf+L9psH/rLkc9fRUoq4GADlvPuX4n8jlyWegDfSm3cDxbOa9VXU0xrMCaxnAvRvzndVGC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785920544; c=relaxed/simple;
	bh=q9d+dg7h5RcseJl0eXXC4Z0vxN+5pfX4id4o8Du4M9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=elgWxOBKIZCEpgmCB0czxsHi2mq1gDnP+iM7Ek029S3bIRA6qqINO8y87CPGp++NJwyVoWudVLhn1eRHcHRnzy7v1NPr9hse3uIRsLMdA9DeAGHudGDiWRuvu0OAbuSaz2GFnP1+1z//0xQcn3ADLWIMkPyBp+OPKXsJ948dOBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iMygQdqi; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iMygQdqi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785920544; x=1817456544;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q9d+dg7h5RcseJl0eXXC4Z0vxN+5pfX4id4o8Du4M9Q=;
  b=iMygQdqi5vRb5YBpkQUkBaZrdtRO8iDuWHKx/N2aaBglyKQqLjzisx8K
   zGSWHX5nyHSu7UDbQyOjSPvXALiYEfeSA9z0XXLbw2C0ypUUePXWLd5Nh
   qoXGTp67ijoeYuEX56VdoFhExc68OtnGBgDz6PA7mJ4XTk/3vLA4T/+b7
   vx9bLLH58BgpFN1GiIJJzT2yUyXQ5ycP3YSbAC5Idc8HJ12WZUZjZ5n+f
   jm2SSM5bf3as5smH9TPtnT/AXvjd6va65TTOgChdRaXsR2cRGenqrCch2
   68hAgjy6NziA7lQtkE3YmqJYNpcHlb75/k0ZuSwQ05ZRIMajRnYOoDn6Q
   A==;
X-CSE-ConnectionGUID: +/4X3gDXRum2zTs9sa0JHQ==
X-CSE-MsgGUID: zOIrOq3NTj68GATqC7zmLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="96842734"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="96842734"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 02:02:24 -0700
X-CSE-ConnectionGUID: JVcYrQ+oSJWgPh5xNWRutw==
X-CSE-MsgGUID: yS3d8q8lS26yx/1breNiVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="261814010"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.218])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 02:02:21 -0700
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
Subject: [PATCH 06/17] ASoC: rt711: sort the register default table
Date: Wed,  5 Aug 2026 12:02:29 +0300
Message-ID: <20260805090240.16991-7-peter.ujfalusi@linux.intel.com>
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

At the end of rt711_reg_defaults[] the 0x83xx entries are interleaved with
the 0x73xx entries they belong to, which leaves 5 of the 269 entries
unreachable for the binary search.  regcache_reg_needs_sync() then cannot
compare them against their default and reports that a sync is needed, so
they are written to the device on every regcache_sync() even when they were
never touched.

Sort the table by register address.

Fixes: 320b8b0d13b8 ("ASoC: rt711: add rt711 codec driver")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/codecs/rt711-sdw.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt711-sdw.h b/sound/soc/codecs/rt711-sdw.h
index 6acf9858330d..82da0e62d9d7 100644
--- a/sound/soc/codecs/rt711-sdw.h
+++ b/sound/soc/codecs/rt711-sdw.h
@@ -256,16 +256,16 @@ static const struct reg_default rt711_reg_defaults[] = {
 	{ 0x3122, 0x00 },
 	{ 0x3123, 0x00 },
 	{ 0x7303, 0x57 },
-	{ 0x8383, 0x57 },
 	{ 0x7308, 0x97 },
-	{ 0x8388, 0x97 },
 	{ 0x7309, 0x97 },
-	{ 0x8389, 0x97 },
 	{ 0x7312, 0x00 },
-	{ 0x8392, 0x00 },
 	{ 0x7313, 0x00 },
-	{ 0x8393, 0x00 },
 	{ 0x7319, 0x00 },
+	{ 0x8383, 0x57 },
+	{ 0x8388, 0x97 },
+	{ 0x8389, 0x97 },
+	{ 0x8392, 0x00 },
+	{ 0x8393, 0x00 },
 	{ 0x8399, 0x00 },
 	{ 0x752008, 0xa807 },
 	{ 0x752009, 0x1029 },
-- 
2.55.0

