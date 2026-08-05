Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837E938F636
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 02:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785898170; cv=none; b=UujTQVQM/vLJ8sQTrgDaLB3b+3oZfCqzaDTOBELO8+ou73bHVwbZVV8agSLacvrwutBuS5ppzovQqmzAFt9OqA383aIbP5IqOYrvIVwAIRYZsZfI36bZl4RrvPLSjKnMxKA6c6Aq4F3HSpghoU1j3GBwIef1bkVc2AUGqgu/dis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785898170; c=relaxed/simple;
	bh=JA4NJuiUSy4UXER4k6MvOddXQcsz8Bg8yNcV1pXFDgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wr+IO1Kz4gNdNgygXcB+4BwznsEsSivUkBu82hugx/KASbFR09dtMcinGV2FeYxUKEcsPsge8wc/AdRFDzZehwlZcbONN4fkCpYyx8qxUaiK7krOPBejP9mdyQT/9qVRoUWm0Tx7yegAEhXmyD3UwTBPycizMSOfYD5fjFrzORU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GVWOnL27; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GVWOnL27"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785898168; x=1817434168;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JA4NJuiUSy4UXER4k6MvOddXQcsz8Bg8yNcV1pXFDgs=;
  b=GVWOnL27tfXAQQjY3OgrSJHAEGskMCWmBphFkJDdtW0WCq73IkCa6VC/
   eojX0iBbpG6GqZXn1E50DQ7q/447vKrm52hRXqda5HTMxr2VuUm4zz+ss
   KLsBkhn8z/MNs+XAQj6LnaeeH/U+oKA7Y89hI0L9rU1ICNeVJsOFbmFjU
   CQSkBvD77FysJJnr3dksjQ0O3CB/s/ZEMVb4p4EejC4Hl7zuNBjO1wN9r
   oRbiUJHLfwSHF0+8rK764ixfDGH70Re9C9tdM9Bnri4Nh7YujJizZIJ1O
   QJO7kiUiWlwZe/Zr+yS+7Tp4+632NolQrijVv4WjsuDSntTsREu6lMRIM
   Q==;
X-CSE-ConnectionGUID: fsFtDetmQBuTA2n9rDjVnQ==
X-CSE-MsgGUID: TjH/iUu5Spe3/iIiVmprYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="97826136"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="97826136"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:49:22 -0700
X-CSE-ConnectionGUID: +O9ndMzhTsmhl/aUCAtPSA==
X-CSE-MsgGUID: WmU7TRIETCWYAQ8Fui3Wpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="259911797"
Received: from orsosgc001.jf.intel.com ([10.88.27.185])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:49:22 -0700
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y v2 08/12] drm/xe/rtp: Save OA nonpriv registers to register save/restore lists
Date: Tue,  4 Aug 2026 19:49:11 -0700
Message-ID: <20260805024915.3407033-9-ashutosh.dixit@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805024915.3407033-1-ashutosh.dixit@intel.com>
References: <20260805024915.3407033-1-ashutosh.dixit@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit a19a83721a28ccaddace846da70da5c53d7dd052 ]

Now we can save OA whitelisting nonpriv registers to register save/restore
lists. OA nonpriv registers are saved to both hwe->oa_sr as well as
hwe->reg_sr.

During probe, resume and gt-reset flows KMD will apply hwe->reg_sr,
ensuring OA registers are de-whitelisted after these events. For
engine-reset, hwe->reg_sr is registered with GuC and GuC will apply these
registers, ensuring OA registers are de-whitelisted after engine resets.

hwe->oa_sr is used for whitelisting or de-whitelisting OA registers during
OA operation, by toggling the 'deny' bit on oa stream open/close.

Fixes: 828a8eaf37c3 ("drm/xe/oa: Add MMIO trigger support")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
Reviewed-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Link: https://patch.msgid.link/20260615224227.34880-6-ashutosh.dixit@intel.com
---
 drivers/gpu/drm/xe/xe_reg_whitelist.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_reg_whitelist.c b/drivers/gpu/drm/xe/xe_reg_whitelist.c
index 47beb473f6a29..a3a45f470faa1 100644
--- a/drivers/gpu/drm/xe/xe_reg_whitelist.c
+++ b/drivers/gpu/drm/xe/xe_reg_whitelist.c
@@ -148,6 +148,18 @@ void xe_reg_whitelist_process_engine(struct xe_hw_engine *hwe)
 	first_oa_slot = whitelist_apply_to_hwe(hwe, &hwe->reg_whitelist, &hwe->reg_sr, 0);
 
 	xe_rtp_process_to_sr(&ctx, oa_whitelist, &hwe->oa_whitelist);
+
+	/*
+	 * Save oa nonpriv registers to hwe->oa_sr, from which oa registers are whitelisted
+	 * or de-whitelisted, by toggling the 'deny' bit on oa stream open/close
+	 */
+	whitelist_apply_to_hwe(hwe, &hwe->oa_whitelist, &hwe->oa_sr, first_oa_slot);
+
+	/*
+	 * Also save oa nonpriv registers to hwe->reg_sr, to ensure oa registers are not
+	 * whitelisted by default after probe, gt reset, resume and engine reset
+	 */
+	whitelist_apply_to_hwe(hwe, &hwe->oa_whitelist, &hwe->reg_sr, first_oa_slot);
 }
 
 /**
-- 
2.54.0

