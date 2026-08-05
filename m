Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CF73E557D;
	Wed,  5 Aug 2026 09:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785920568; cv=none; b=XBmrHl6hA7gkwrMI9WWbBM5Wzb+vtnkAf3BWU8/9eSY8IEmJ8r0KmEs1GJEEnxS3SFJf3P3XMfqnvJQIyDQN1NysTRI/fvTb5ZE5LkFcI0k1K+MzBeK6i4k3QeN7iQElvi/s9W1N7JuWekm7tbzcQtGv2PSDQFLeXBvXUCZnkkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785920568; c=relaxed/simple;
	bh=BNgHacWEYrq0N0YAek9CS6osa0xBbAG4Enr34S4EMes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jP5Mqlip2moB/VrEzXLhZ+Sf8+b1Llft/HYA+9z8RbKaFXhL0hw58ql0ZYTMNmPWEXlDeeRXpO1d6cQQSX6feVKkhpBRJMuefjAbYQmnbpOXqS12BT8zPre8nQnGhrg35Tchw1Pu7Ng8z8GhYuZWnvhpaDHHQm9e9A57kUov0gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C32KGH7c; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C32KGH7c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785920568; x=1817456568;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BNgHacWEYrq0N0YAek9CS6osa0xBbAG4Enr34S4EMes=;
  b=C32KGH7c5ff3CZpyLaY16vxcQLDarduc7kd2ZrUEPvRVm6En+9RaQX98
   1rBSB48xj4BEde2KFTJnGcXKAkMvWqHUDK2aB1OUZw560CGkjfT2G+4ET
   SNyDd0lJj40iUlnnVGZ1EhGLhEXzmr8uLCZAcdUb9SbuXt5OhERtbBThg
   FXO7DCVUtxZNlBG0zIBlDW50Vkna9cqL7jsIrwBaiDoUcPgko8unq0FjN
   qMtvOX628ELxcfMesMw7qa2bY0CEnGSLFudi6yYTNpMUXvDN+s03cXsZy
   r23oqm5M2z6zwwFp/M5prg656sH7pQIwfmnJIsAdC9CZDn+M5iiiXP8aU
   Q==;
X-CSE-ConnectionGUID: h7YvoUgFT6ODtR35Xt0PYQ==
X-CSE-MsgGUID: C25zm4SSToClxvbzF2cP/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="96842824"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="96842824"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 02:02:47 -0700
X-CSE-ConnectionGUID: sCaeFRgDRxmEN/fg5Ih8Ag==
X-CSE-MsgGUID: AbOGBn77ROuPbFJiPKyRlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="261814126"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.218])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 02:02:44 -0700
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
Subject: [PATCH 14/17] ASoC: rt1017-sdca-sdw: sort the register default table
Date: Wed,  5 Aug 2026 12:02:37 +0300
Message-ID: <20260805090240.16991-15-peter.ujfalusi@linux.intel.com>
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

rt1017_sdca_reg_defaults[] places the SDCA controls before the lower
vendor registers instead, so the binary search does not find 4 of its
entries.  regcache_reg_needs_sync() then cannot compare those against
their default and reports that a sync is needed, so they are written to
the device on every regcache_sync() even when they were never touched.

Sort the table by register address.

Fixes: 2b7aecd58528 ("ASoC: rt1017: Add RT1017 SDCA amplifier driver")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/codecs/rt1017-sdca-sdw.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt1017-sdca-sdw.h b/sound/soc/codecs/rt1017-sdca-sdw.h
index 4932b5dbe3c0..1604e1cfd85e 100644
--- a/sound/soc/codecs/rt1017-sdca-sdw.h
+++ b/sound/soc/codecs/rt1017-sdca-sdw.h
@@ -165,19 +165,19 @@ static const struct reg_default rt1017_sdca_reg_defaults[] = {
 	{ 0xdb09, 0x0f },
 	{ 0xdb0a, 0xff },
 	{ 0xdb14, 0x00 },
-
-	{ SDW_SDCA_CTL(FUNC_NUM_SMART_AMP, RT1017_SDCA_ENT_UDMPU21,
-			RT1017_SDCA_CTL_UDMPU_CLUSTER, 0), 0x00 },
 	{ SDW_SDCA_CTL(FUNC_NUM_SMART_AMP, RT1017_SDCA_ENT_FU,
 			RT1017_SDCA_CTL_FU_MUTE, 0x01), 0x01 },
 	{ SDW_SDCA_CTL(FUNC_NUM_SMART_AMP, RT1017_SDCA_ENT_XU22,
 			RT1017_SDCA_CTL_BYPASS, 0), 0x01 },
-	{ SDW_SDCA_CTL(FUNC_NUM_SMART_AMP, RT1017_SDCA_ENT_CS21,
-			RT1017_SDCA_CTL_FS_INDEX, 0), 0x09 },
 	{ SDW_SDCA_CTL(FUNC_NUM_SMART_AMP, RT1017_SDCA_ENT_PDE23,
 			RT1017_SDCA_CTL_REQ_POWER_STATE, 0), 0x03 },
 	{ SDW_SDCA_CTL(FUNC_NUM_SMART_AMP, RT1017_SDCA_ENT_PDE22,
 			RT1017_SDCA_CTL_REQ_POWER_STATE, 0), 0x03 },
+
+	{ SDW_SDCA_CTL(FUNC_NUM_SMART_AMP, RT1017_SDCA_ENT_UDMPU21,
+			RT1017_SDCA_CTL_UDMPU_CLUSTER, 0), 0x00 },
+	{ SDW_SDCA_CTL(FUNC_NUM_SMART_AMP, RT1017_SDCA_ENT_CS21,
+			RT1017_SDCA_CTL_FS_INDEX, 0), 0x09 },
 };
 
 #endif /* __RT1017_SDW_H__ */
-- 
2.55.0

