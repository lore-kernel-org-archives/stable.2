Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694F3394EB7
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 23:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785800041; cv=none; b=UEpw9tgF6fEXEiJjGQTcXRTqJGxO7XN8lIDEjQL5bLDgemxZhxoM+l2sdCHJ0Wv+nXrjhHhLt/3KMI1xbv72CklL30iUta0kd3//wMXxngK8674NlxVAMWMprtnE1Paf0YxLJj8UIDHGJ7m5eHbDouZdKvNkUNrhRh79hzMZi3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785800041; c=relaxed/simple;
	bh=m4ZQPxYvBbxYNITJ7cXuhW12XlqcfeEBk20r4fVbHbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LexmneZziN7LahcbElRnQ20gW9osEc7pZvg6eDQ4RCzLf7/RiZO70pFsr3x18GypnDEPVrkmpEbHTqhKPO9FaUkD9T3Qzd8fdosoFRT2s0r3l/CwyPVtrYp2wDC46Aweag2a1pDacQGhjuGc0WzpRonY57W1EFRBrnMTv2idz3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=miuKHOmJ; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="miuKHOmJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785800039; x=1817336039;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m4ZQPxYvBbxYNITJ7cXuhW12XlqcfeEBk20r4fVbHbU=;
  b=miuKHOmJk1AxO6RMZECecjr+0HWL1R2bNy6Y3R/qJSLRUM1nhe4jIuGO
   8vKY+DLgC4g8+/AFmW4P5EuuVWL0uDiWtf66vb85oS2AVSKDERBZtzl45
   fnf1rgGPEGGMCUheNnydWmnShYj9m1xdoZCTHEAJWVtaw1QpOj6QZZwUe
   1LBGi46gpkYt8s4g7EAZokzYP6m6EPhNgL2eaR+h1sL2WzFGZ3wIsfXnI
   VSgrV51k3QuGvFV2OR1D2famx4uZYS2elCDaxsdrWkCcYF+Ng0Br948Go
   H98FqNgjh6b2HHDGD9/Q4QLlmf3VZ51Ot9Z8gTomp4dlLn/riIDp9JEoM
   Q==;
X-CSE-ConnectionGUID: QNluMJ5XSZS8qc4fgo6Sng==
X-CSE-MsgGUID: SvoJzEaXTg6FWOpQgBClfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86112917"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="86112917"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 16:33:54 -0700
X-CSE-ConnectionGUID: gDfIBOJsQ46N19lgHRqp4A==
X-CSE-MsgGUID: vTaWXiwFStWReUspxK9Ciw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="264838286"
Received: from orsosgc001.jf.intel.com ([10.88.27.185])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 16:33:53 -0700
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.12.y 07/12] drm/xe/rtp: Generalize whitelist_apply_to_hwe
Date: Mon,  3 Aug 2026 16:33:41 -0700
Message-ID: <20260803233346.3277427-8-ashutosh.dixit@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260803233346.3277427-1-ashutosh.dixit@intel.com>
References: <20260803233346.3277427-1-ashutosh.dixit@intel.com>
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
index 12d12d8f0e99c..47beb473f6a29 100644
--- a/drivers/gpu/drm/xe/xe_reg_whitelist.c
+++ b/drivers/gpu/drm/xe/xe_reg_whitelist.c
@@ -94,9 +94,10 @@ static const struct xe_rtp_entry_sr oa_whitelist[] = {
 	{}
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
@@ -105,7 +106,7 @@ static int whitelist_apply_to_hwe(struct xe_hw_engine *hwe)
 	xe_gt_dbg(hwe->gt, "Add %s whitelist to engine\n", sr->name);
 	p = xe_gt_dbg_printer(hwe->gt);
 
-	slot = 0;
+	slot = first_slot;
 	xa_for_each(&sr->xa, reg, entry) {
 		struct xe_reg_sr_entry hwe_entry = {
 			.reg = RING_FORCE_TO_NONPRIV(hwe->mmio_base, slot),
@@ -122,7 +123,7 @@ static int whitelist_apply_to_hwe(struct xe_hw_engine *hwe)
 		}
 
 		xe_reg_whitelist_print_entry(&p, 0, reg, entry);
-		xe_reg_sr_add(&hwe->reg_sr, &hwe_entry, hwe->gt);
+		xe_reg_sr_add(out, &hwe_entry, hwe->gt);
 
 		slot++;
 	}
@@ -144,7 +145,7 @@ void xe_reg_whitelist_process_engine(struct xe_hw_engine *hwe)
 	int first_oa_slot;
 
 	xe_rtp_process_to_sr(&ctx, register_whitelist, &hwe->reg_whitelist);
-	first_oa_slot = whitelist_apply_to_hwe(hwe);
+	first_oa_slot = whitelist_apply_to_hwe(hwe, &hwe->reg_whitelist, &hwe->reg_sr, 0);
 
 	xe_rtp_process_to_sr(&ctx, oa_whitelist, &hwe->oa_whitelist);
 }
-- 
2.54.0

