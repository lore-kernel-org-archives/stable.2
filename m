Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752F636308D
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 02:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785898169; cv=none; b=P/4MBi4aJHLiyOAO8oaWf37C+n9SpIeW0E63uGDSS23GP9Eeta1OwWAkZeLzN8nJzwHb0Op9uifVcMOL2G62KgtFURK3oM2Xo/rCuyuv9f73j/TYhxFzAXFPK7U8CNBT9bJWUGQluykaGVKNn2n91FPILM65gMGLU2RlEZclNDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785898169; c=relaxed/simple;
	bh=57AWT60PyhCC2GNK12tJ4kGhDhrNBn5JVQTr4MNP0Dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nrYN++ZyerdTOZsbFv86YMYO1vM6zxbGaUvOYSpg6aaV0fy51T5ufCTZjb7q65vOklW1hMiNPguvtCx9knEP42dts0maU+WJR3ZxzNVR0hnEzx5o236xJ00UuMSmhrpj7+PPSxeAkwQUhEiuEYkN+23jLs0DYyNjrxtTQk9RMak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UTKqRK+M; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UTKqRK+M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785898168; x=1817434168;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=57AWT60PyhCC2GNK12tJ4kGhDhrNBn5JVQTr4MNP0Dk=;
  b=UTKqRK+MiRRu3cB3LKJbabSeK8f+RMREoNHzJiracI8RmxcYYZJ5124v
   PL5WWPt9yCU6eS/odar2+4H6drpftAPvVYs7fQaOmKPr5DaJbOrTXKemg
   b5gyQnhDrkEQXERgmEsLB5GpPM4Iy2623Unot1dzVPd446+Jf+Mthl7SO
   P8ity38cuOKnegtEJL4BoroQKJXwr1fu7h7/IcmG+CRpnzlcGZjWzbEbh
   8HR324nf0HqYg/w00EuRZN5tjAU78KI7qd0zXecFJbUH5Xe/qhGeQegv4
   41sD5LQMvy71X75c1aGX443HPBqgVssbjAPqeKEaLOQGzVPu7iSwTduxG
   w==;
X-CSE-ConnectionGUID: vk7kxvqoSN2cEHk0GPhu4w==
X-CSE-MsgGUID: gQyta62YToWhITE3gko57Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="97826134"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="97826134"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:49:22 -0700
X-CSE-ConnectionGUID: fdNB/siTStiGgaJmBHTH6g==
X-CSE-MsgGUID: 8bLZn3WiS32MG3JUhamhxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="259911795"
Received: from orsosgc001.jf.intel.com ([10.88.27.185])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:49:22 -0700
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y v2 07/12] drm/xe/rtp: Generalize whitelist_apply_to_hwe
Date: Tue,  4 Aug 2026 19:49:10 -0700
Message-ID: <20260805024915.3407033-8-ashutosh.dixit@intel.com>
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

