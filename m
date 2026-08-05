Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66B523D7DF
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 02:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785897986; cv=none; b=h+O6k/CCu+0r1scwSKLZdFwbl+FKS41g11XYsCi3Xkqh9T9yFf+rB6yYjvho2v9RsPXsHz+u7ZQHQpqqNBKJR7bC6ZBKzqFOqzooeGL6t0faUHKFpP9895lWcowA9xpZSVzQdoXiI8mI0oJMwGpYOJBm56/iM3MzplJpjNkIQ1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785897986; c=relaxed/simple;
	bh=/j89vNY75gaIa9JwYwxKRiLjbX9smKevZWApMO8ToXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5bTjxZQWWk89JyY1aGjc3hpOI8EkYTcrdRYBR9r0sHODGv+3O6Ljwe59v8Z/YwjJRfauY4/ZaSev5/qKKd0QRBk5GaxA0Ls1R/DuHi8jEBbMRWN4/vGLE5NfTfC5cviPyaf/BYdPltTl9DzmONwYfl8ofmsHrf4HuTUksIC4Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y+KCG+Nc; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y+KCG+Nc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785897985; x=1817433985;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/j89vNY75gaIa9JwYwxKRiLjbX9smKevZWApMO8ToXM=;
  b=Y+KCG+NckWVou81MKboetwzsPHQ0eEeOnwIDfEKyewc159fuYgLtJLCJ
   gE5OENaK7ikBh+m04M51m+QHb+K28F6WWuZ1Bj3r/blVtd/U+06A+hI3g
   swbaZ625QZApXaxRL0KkPNgw5osUAZh4ZtcAm8hKkE0wukXA/yx1Js0jP
   WiU+lMxbhhA0LQyFaMHMNKuzMPhi48mZXY3XWrDHPUzurwTEsog1AQmEt
   xoAy+/YCBuU11T/RR/hIIOnOD+3KsIR2Wrl5/dw2u8q9Mz9QYwV9Tdgv5
   p/S/uAntcMvd86H64PrSkus1IrNak6qUq8o+a+FQN0KJjimhuxTijU/dm
   A==;
X-CSE-ConnectionGUID: AFjnTh8iRoG2xYFklCueuA==
X-CSE-MsgGUID: xFMKuV4vSbKxwQWrLbUlBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="85586051"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="85586051"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:46:21 -0700
X-CSE-ConnectionGUID: eol67h3gQhSaFMM1JutWJg==
X-CSE-MsgGUID: t5dJhjOLT9ycxsDXVi3iRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="265925515"
Received: from orsosgc001.jf.intel.com ([10.88.27.185])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:46:20 -0700
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y v2 05/10] drm/xe/rtp: Generalize whitelist_apply_to_hwe
Date: Tue,  4 Aug 2026 19:46:09 -0700
Message-ID: <20260805024614.3406679-6-ashutosh.dixit@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805024614.3406679-1-ashutosh.dixit@intel.com>
References: <20260805024614.3406679-1-ashutosh.dixit@intel.com>
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

