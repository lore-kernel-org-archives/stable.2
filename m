Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E2F3955D2
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 23:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785799579; cv=none; b=BoVghbxIm3jzJYzwk5a33bhJjHwyYK3IaYiYueZubRuILDxFtys7O/Mog/yISSUqe/OMRUOGv6ta/gk6uLEF37WiOGanCNKoDSljxYFehCOgfK8JQOFa4jJTleLXcDqy4hSXv32WLzBJI8Di8jVnQJWu0dCh0SP/gGfiSDrtsck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785799579; c=relaxed/simple;
	bh=MqVsS5S4Kcq0VR/8CXVDhe0JEEimDqGjaM8zlPMPsY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VFEgtBdy4/J82a50dAIcZpDVcF6DSCdRXPTsvcTw9jELz1Z6plCmGuMBqWNupF1ngtQx0d00RmxVwuJcb4WY9+/01aa5gB53d9xW42z0bhTrT8B/0k6dvDm0WiKlJ6JXl5ykbzgAgsMas/Zo+CZHdrW/rS3sMLAHBufL3R/upFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C10rqY5c; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C10rqY5c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785799577; x=1817335577;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MqVsS5S4Kcq0VR/8CXVDhe0JEEimDqGjaM8zlPMPsY0=;
  b=C10rqY5c5WFur5YRWNKMccoxF9jP8t/UXHrVZEutyD0Pfn5OfDcwjnFz
   iYWYa1ANkK92fcu66f4CV9/ZBu3BGIirRlWHj2R7z0+iN/xEKBHxLZq/E
   BWbgymV2yrz9gYjc4Y4UhISi7GRJpCZQgoSAYgqQFCTQbRPs4STWXglth
   ge18YHFv3qcDa9r3wCH5LA70GoVJrJ8G2jcOjQUXntDC95AlkUlr1rkrI
   e+Dl2z+ZZkwUx5kH0sovVB82u7IZIn0RfPB0wv2rG09+T/+jyx7GoPDMy
   eBy7hkLKJtA9j0yeJKbIjHZoWWu/Z/y5xBUyldxDzE9/23GFNmhedBs3c
   w==;
X-CSE-ConnectionGUID: U9DwGlWoRvqMDDRTV/x8zg==
X-CSE-MsgGUID: Iey5fCyySRS2Ui5j6TlqwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="90232416"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="90232416"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 16:26:12 -0700
X-CSE-ConnectionGUID: rLgrFaWvTTSugn/Zka8yDw==
X-CSE-MsgGUID: QAOZDCcIQ0qGNXHWF2s46g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="261932555"
Received: from orsosgc001.jf.intel.com ([10.88.27.185])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 16:26:13 -0700
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.18.y 05/10] drm/xe/rtp: Generalize whitelist_apply_to_hwe
Date: Mon,  3 Aug 2026 16:26:03 -0700
Message-ID: <20260803232608.3276045-6-ashutosh.dixit@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260803232608.3276045-1-ashutosh.dixit@intel.com>
References: <20260803232608.3276045-1-ashutosh.dixit@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit c3ff77d7235ccef7a0883c2fd981f70ef3aafd21 ]

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
index a5658b2df0cc1..cc9f0f598e49c 100644
--- a/drivers/gpu/drm/xe/xe_reg_whitelist.c
+++ b/drivers/gpu/drm/xe/xe_reg_whitelist.c
@@ -92,9 +92,10 @@ static const struct xe_rtp_entry_sr oa_whitelist[] = {
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
@@ -103,7 +104,7 @@ static int whitelist_apply_to_hwe(struct xe_hw_engine *hwe)
 	xe_gt_dbg(hwe->gt, "Add %s whitelist to engine\n", sr->name);
 	p = xe_gt_dbg_printer(hwe->gt);
 
-	slot = 0;
+	slot = first_slot;
 	xa_for_each(&sr->xa, reg, entry) {
 		struct xe_reg_sr_entry hwe_entry = {
 			.reg = RING_FORCE_TO_NONPRIV(hwe->mmio_base, slot),
@@ -120,7 +121,7 @@ static int whitelist_apply_to_hwe(struct xe_hw_engine *hwe)
 		}
 
 		xe_reg_whitelist_print_entry(&p, 0, reg, entry);
-		xe_reg_sr_add(&hwe->reg_sr, &hwe_entry, hwe->gt);
+		xe_reg_sr_add(out, &hwe_entry, hwe->gt);
 
 		slot++;
 	}
@@ -143,7 +144,7 @@ void xe_reg_whitelist_process_engine(struct xe_hw_engine *hwe)
 
 	xe_rtp_process_to_sr(&ctx, register_whitelist, ARRAY_SIZE(register_whitelist),
 			     &hwe->reg_whitelist);
-	first_oa_slot = whitelist_apply_to_hwe(hwe);
+	first_oa_slot = whitelist_apply_to_hwe(hwe, &hwe->reg_whitelist, &hwe->reg_sr, 0);
 
 	xe_rtp_process_to_sr(&ctx, oa_whitelist, ARRAY_SIZE(oa_whitelist),
 			     &hwe->oa_whitelist);
-- 
2.54.0

