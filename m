Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80233B7B70
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 02:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785897795; cv=none; b=AaZLv7nf26ihGmnU69xBy//82ezUw709gscARisP+95P69BLnf4+SyediGhimcNIoQlfw3KVmv/zCldrorHoPwxbX2xnjs2Ecy5N8vEfDW7Iz2SMZ4v86qB0ZRbfBxS3ZGPZJotdj+H4OuK+O2xkbm7ezQyzQ2qQcxHKqCPEECo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785897795; c=relaxed/simple;
	bh=ySkx5KLcL456inMxiEGZ+GfhrS9EhxyniNeNn702chg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dns7LtjuCjvcExbEZyGgzOkJBkNU8ssiWVGHz5DRGFIwL9Q9vRZ85wSBDQCdNixRgVRO2IS07ZDq1SIOfvR87vLryPQC7+dX2ESg9CloZrjlTANFJB7dZQNz2OQu+aQ2DDULsoaHD7gf2FEJfLcMC+Aqb8Fu3sUV0NDEwzs/Ruk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C5/ZJLiR; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C5/ZJLiR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785897792; x=1817433792;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ySkx5KLcL456inMxiEGZ+GfhrS9EhxyniNeNn702chg=;
  b=C5/ZJLiRpgIi6QYj1c8eiq2egacsT7jWKehJik+IxcdJm3Nr36jvlf6E
   5DtC5fkfpvXWkv44HzFj1+X2j+ed3sIp/+1xMORNrHrAq6Qty0gdtMvWE
   cffPG07ebWwJrp5dQcv/p46NjwEEMJZOpz4NTk6pi4FurCtXQqVy7xytO
   fAS6AQklMVhxakMeQv88d61/+i82FG3+1kksoGv3uMz9ZoDgT0RebxzaZ
   eV6IQvm0peU4MBfJN9eQHSaRzE9kF0zkcyuKRfvCd+NTzveWpCUKLDcgP
   mu72sx1TvJbu/OuAdKFE2I+yQ1IRuKOH8ZZukDPQD1rtYIfP4BcdorjWd
   w==;
X-CSE-ConnectionGUID: PPPdnCpdRfaJIRffb5fEPQ==
X-CSE-MsgGUID: eNSFe/VnSmWRLagxjebGyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="85585776"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="85585776"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:43:06 -0700
X-CSE-ConnectionGUID: VvPD/VdmQfi57w/OvXPRPg==
X-CSE-MsgGUID: tQVcK5tQRa6I4ia9OqkZXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="291612677"
Received: from orsosgc001.jf.intel.com ([10.88.27.185])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:43:05 -0700
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y v2 3/8] drm/xe/rtp: Generalize whitelist_apply_to_hwe
Date: Tue,  4 Aug 2026 19:42:55 -0700
Message-ID: <20260805024300.3406307-4-ashutosh.dixit@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805024300.3406307-1-ashutosh.dixit@intel.com>
References: <20260805024300.3406307-1-ashutosh.dixit@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 4fe2844b0f0c7cdc45ca4c4c62ca56b7f26c514c ]

Generalize whitelist_apply_to_hwe to construct both non-OA and OA
whitelist nonpriv registers.

Fixes: 828a8eaf37c3 ("drm/xe/oa: Add MMIO trigger support")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
Reviewed-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Link: https://patch.msgid.link/20260615224227.34880-5-ashutosh.dixit@intel.com
---
 drivers/gpu/drm/xe/xe_reg_whitelist.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_reg_whitelist.c b/drivers/gpu/drm/xe/xe_reg_whitelist.c
index 00f00002afcef..1a7d69ef4fe82 100644
--- a/drivers/gpu/drm/xe/xe_reg_whitelist.c
+++ b/drivers/gpu/drm/xe/xe_reg_whitelist.c
@@ -147,9 +147,10 @@ static const struct xe_rtp_entry_sr oa_whitelist[] = {
 	},
 };
 
-static int whitelist_apply_to_hwe(struct xe_hw_engine *hwe)
+static int whitelist_apply_to_hwe(struct xe_hw_engine *hwe, struct xe_reg_sr *in,
+				  struct xe_reg_sr *out, int first_slot)
 {
-	struct xe_reg_sr *sr = &hwe->reg_whitelist;
+	struct xe_reg_sr *sr = in;
 	struct xe_reg_sr_entry *entry;
 	struct drm_printer p;
 	unsigned long reg;
@@ -158,7 +159,7 @@ static int whitelist_apply_to_hwe(struct xe_hw_engine *hwe)
 	xe_gt_dbg(hwe->gt, "Add %s whitelist to engine\n", sr->name);
 	p = xe_gt_dbg_printer(hwe->gt);
 
-	slot = 0;
+	slot = first_slot;
 	xa_for_each(&sr->xa, reg, entry) {
 		struct xe_reg_sr_entry hwe_entry = {
 			.reg = RING_FORCE_TO_NONPRIV(hwe->mmio_base, slot),
@@ -175,7 +176,7 @@ static int whitelist_apply_to_hwe(struct xe_hw_engine *hwe)
 		}
 
 		xe_reg_whitelist_print_entry(&p, 0, reg, entry);
-		xe_reg_sr_add(&hwe->reg_sr, &hwe_entry, hwe->gt);
+		xe_reg_sr_add(out, &hwe_entry, hwe->gt);
 
 		slot++;
 	}
@@ -198,7 +199,7 @@ void xe_reg_whitelist_process_engine(struct xe_hw_engine *hwe)
 
 	xe_rtp_process_to_sr(&ctx, register_whitelist, ARRAY_SIZE(register_whitelist),
 			     &hwe->reg_whitelist, false);
-	first_oa_slot = whitelist_apply_to_hwe(hwe);
+	first_oa_slot = whitelist_apply_to_hwe(hwe, &hwe->reg_whitelist, &hwe->reg_sr, 0);
 
 	xe_rtp_process_to_sr(&ctx, oa_whitelist, ARRAY_SIZE(oa_whitelist),
 			     &hwe->oa_whitelist, false);
-- 
2.54.0

