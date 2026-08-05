Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E2D45DF58;
	Wed,  5 Aug 2026 12:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785932859; cv=none; b=OcO7Cgw6iZFrg7vlVYppYF0P0MdQwltCrzgmamHSxJs7g6q2dhXFuUnq+utHjgtb+oE+UDIpvYzw3dHdGhKARWfHzx0B0ZOzW56aNsS7FLGTfJq0s8G627vtgz58aQjI6ZZZ4RDfDFCM1LXw/BQr9VRMuaiG/ucNiUv09axtq9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785932859; c=relaxed/simple;
	bh=TgV6Sd/Xt7gsopbkDCisgz+6Bz4kiirJ+1VVOOaV3E8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AESCxqHXz7S79ncttMi1+qc+hW/DateqnmmSeaVMMZzwGOJY/1N89TcUklVcA9pJkymAe4FrOi8tqoE6cfL6K+iR6bBk0/+8vSEcJDAU4emxP+Z4PLjRstqG3tRdYdbBkJakjNTv/go6zZ7aizBe/Y8RfO7ETd+wu2BsqT4cWGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SKnFjC6D; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SKnFjC6D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785932858; x=1817468858;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TgV6Sd/Xt7gsopbkDCisgz+6Bz4kiirJ+1VVOOaV3E8=;
  b=SKnFjC6D4e6ZscMUuphqJdMZ1JVwhGhuMh3kwhqwjCelJiE5bJ4RXYID
   vgWaIrSyrrIZK9RUCk8Q5s/j4XrSc+m2rIobKD32I029le+QLTG9K3W2N
   xI8j2/tPsBPc8H47Mgz5YvVRoyIpU5ctGO4mI96nie5APvwqx78P6i05x
   fEvAhUMiIwRqdOCWrjgnC78F8off2nNBdZTN+9a1VSpG16VyhVQ6UGyNp
   FvVXVbCL8IIn1LpuxgffjKdD/0ghFoYWOKl+wyVcWsQyWMKLFwN0uidkI
   kGEsHLgcmgxadFYUYcMNEPcFhRUOf5PSQkIsYqtMkqa7fMWQ2WxZ1Pryi
   g==;
X-CSE-ConnectionGUID: Z6OzzQR1SFyq9ljbvqOKnA==
X-CSE-MsgGUID: daDTWW7bQnibLus+yNae4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="97098734"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="97098734"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 05:27:15 -0700
X-CSE-ConnectionGUID: 9dpUKhqXSGy9JQBl+oAnZA==
X-CSE-MsgGUID: G4F05PzyS3SCLLWw9daZ4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="265296075"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.218])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 05:27:14 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sheetal <sheetal@nvidia.com>
Cc: linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/3] ASoC: tegra210_i2s: sort the register default table
Date: Wed,  5 Aug 2026 15:27:46 +0300
Message-ID: <20260805122748.13090-2-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805122748.13090-1-peter.ujfalusi@linux.intel.com>
References: <20260805122748.13090-1-peter.ujfalusi@linux.intel.com>
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

TEGRA210_I2S_ENABLE (0x80) is listed after TEGRA210_I2S_CG (0x88) and
TEGRA210_I2S_TIMING (0xa4), so both it and TEGRA210_I2S_TIMING are
unreachable.  regcache_reg_needs_sync() then cannot compare them against
their default and reports that a sync is needed, so they are written to
the device on every regcache_sync() even when they were never touched.

Sort the table by register address.

Fixes: c0bfa98349d1 ("ASoC: tegra: Add Tegra210 based I2S driver")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/tegra/tegra210_i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/tegra/tegra210_i2s.c b/sound/soc/tegra/tegra210_i2s.c
index ff8c72fc38c5..fd49d2d6ee49 100644
--- a/sound/soc/tegra/tegra210_i2s.c
+++ b/sound/soc/tegra/tegra210_i2s.c
@@ -23,9 +23,9 @@ static const struct reg_default tegra210_i2s_reg_defaults[] = {
 	{ TEGRA210_I2S_RX_CIF_CTRL, 0x00007700 },
 	{ TEGRA210_I2S_TX_INT_MASK, 0x00000003 },
 	{ TEGRA210_I2S_TX_CIF_CTRL, 0x00007700 },
+	{ TEGRA210_I2S_ENABLE, 0x1 },
 	{ TEGRA210_I2S_CG, 0x1 },
 	{ TEGRA210_I2S_TIMING, 0x0000001f },
-	{ TEGRA210_I2S_ENABLE, 0x1 },
 	/*
 	 * Below update does not have any effect on Tegra186 and Tegra194.
 	 * On Tegra210, I2S4 has "i2s4a" and "i2s4b" pins and below update
-- 
2.55.0

