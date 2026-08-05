Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B03F45FFCF;
	Wed,  5 Aug 2026 12:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785932820; cv=none; b=vAS7GoH1F3QqDPYiQ2Aqfpo3mkSVsQ87HlOoACWjNwB21H81DFoCsyEvSbshL6YcjYUqmOGwCzoY4f47d708WTkfhcz8OLPK6lW0rw0QznO1ks2IVyGAli4074AWegFYYLx/Y7AAF5R7QgJfke8NV77tQlwi4xPtPFiswvVxPlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785932820; c=relaxed/simple;
	bh=UAMcOZR9LPX7gM1i5ZNzS0hh1JBdgmaBl4xPG2XuqyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l7cWw2ARfTVg0T422XboxNjXxQCpSK1Rm7J95ZwF/Y9PqDE1aiohjVTM67ar26ZIcILB31kBaBSvIcvLXL3jMjHTxPZfo9k9qCIubQ1U+3EUewwRzl2A73xCHIDCLoOkdsew53gTU3e3FIEWIglmKHSce4jH0mkst1X0lE2OzGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UETchp3a; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UETchp3a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785932819; x=1817468819;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UAMcOZR9LPX7gM1i5ZNzS0hh1JBdgmaBl4xPG2XuqyE=;
  b=UETchp3at4Kd1eJxuk4OJ1DCIqDXaY1xC/VFFycXMV2AFNLjk19JYw3e
   oZwv8MfcDHNnk6p0zCKYltpyujZfdZrh9Z/i07O+WeJLCL6TLI8z6tb/1
   ngtYHnuJsJ36jFkruVwj9tCacUPvFRRHoyV7FXAY2D6wA/OZEbtBxYT5d
   PFLJWI1K/R/2WoP7IPYrjueR7DBeVtr7jYBQcilYnUg2UEcWSgpDfvXvu
   OXt6+P1zCBLvCdfNxpWB/hBfZNj/v6JPKFEW+CGauGPF7UzIHjfO4H0TU
   bXBoJN16RpwzA/f35DpFiVLu+oCwn1sGQdRk/OP3zC4uC9ctdFRn3Xaa7
   g==;
X-CSE-ConnectionGUID: v2FIz9c3QC6Z7JvJbEWliQ==
X-CSE-MsgGUID: qPuTeCG7T/Km517PLRYGsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="86583184"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="86583184"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 05:26:58 -0700
X-CSE-ConnectionGUID: BANLRrE7T7WEmVRMF3D6XA==
X-CSE-MsgGUID: fRaHkH/5SuCiEQABBSk3fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="258460224"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.218])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 05:26:56 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>
Cc: linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] ASoC: fsl_easrc: sort the register default table
Date: Wed,  5 Aug 2026 15:27:28 +0300
Message-ID: <20260805122728.12362-3-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805122728.12362-1-peter.ujfalusi@linux.intel.com>
References: <20260805122728.12362-1-peter.ujfalusi@linux.intel.com>
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

The four REG_EASRC_RRL() entries are listed as a block before the four
REG_EASRC_RRH() ones, but the two registers of a context alternate in
the address map (RRL(n) at 0x110 + 8 * n, RRH(n) at 0x114 + 8 * n).
This leaves REG_EASRC_RRL(1), REG_EASRC_RRL(2) and REG_EASRC_RRL(3)
unreachable.  regcache_reg_needs_sync() then cannot compare them against
their default and reports that a sync is needed, so they are written to
the device on every regcache_sync() even when they were never touched.

Sort the table by register address.

Fixes: 955ac624058f ("ASoC: fsl_easrc: Add EASRC ASoC CPU DAI drivers")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/fsl/fsl_easrc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
index 8535ef844ce0..6ccba3706b58 100644
--- a/sound/soc/fsl/fsl_easrc.c
+++ b/sound/soc/fsl/fsl_easrc.c
@@ -1711,12 +1711,12 @@ static const struct reg_default fsl_easrc_reg_defaults[] = {
 	{REG_EASRC_SFS(2),	0x00000000},
 	{REG_EASRC_SFS(3),	0x00000000},
 	{REG_EASRC_RRL(0),	0x00000000},
-	{REG_EASRC_RRL(1),	0x00000000},
-	{REG_EASRC_RRL(2),	0x00000000},
-	{REG_EASRC_RRL(3),	0x00000000},
 	{REG_EASRC_RRH(0),	0x00000000},
+	{REG_EASRC_RRL(1),	0x00000000},
 	{REG_EASRC_RRH(1),	0x00000000},
+	{REG_EASRC_RRL(2),	0x00000000},
 	{REG_EASRC_RRH(2),	0x00000000},
+	{REG_EASRC_RRL(3),	0x00000000},
 	{REG_EASRC_RRH(3),	0x00000000},
 	{REG_EASRC_RUC(0),	0x00000000},
 	{REG_EASRC_RUC(1),	0x00000000},
-- 
2.55.0

