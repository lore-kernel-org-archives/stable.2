Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B86F35C687
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 23:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785798112; cv=none; b=uQmEYTb38RIYvuJjAUo+eAZIrsi9nLATH7x4V8bL8+Bhz915tHdna0hE+Th+sM4K6yHheyQJuFi52M06VQ4Csf8+6dZwOUhM02zXugDOJUffBm1e5VIkDh+OP3kJAyOIRyjzqIi012Arkoxp0mpADvXmgu7ck9H1i1IpD6FcIxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785798112; c=relaxed/simple;
	bh=2JtmC1jvWxQH71r6ttj0xQAd0/NLTTubG0qrQ0yKhwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pQa5CFWMEHzrLcqQ3iZLJJO+YyPqqr0Og9ETULmx2758NHaJlh1CxDeivxHh8iEfKP7KJ7t6iQkPEfNZLJoRJVy9QZ0SnPaQdpj8889rQLEOs45l+syyrEU3hScv61HIKc1rl1GqSmKlAOR+rAvUd0/t3GWQBQC3qcpPHASHdSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l7XRoDmR; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l7XRoDmR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785798110; x=1817334110;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2JtmC1jvWxQH71r6ttj0xQAd0/NLTTubG0qrQ0yKhwY=;
  b=l7XRoDmRUOFaVBF9P/QfEuy0J1M33UGOg0ZWehjD4smLPjJpJ3oiRAFi
   YTjLOZFvtMcL9NcoZmsZ5SGN1rf7mssPOj8KdN25t+ApaRhdF6bk5twRu
   Z4bZVpKgF/nN/ZWKhWr6LwUoD7elMC9RmZ2QOqteutXgy7Lj0Dvmt9EIl
   7nzgIl/bBAJtxo8j30n9kTf4QksRXntNh2GnR96wUlILDeMcZulBx+bk5
   CroEp4V06YTnIFrniGj8ci6Ad8QgfOvkYwa+0+avrR582k+ddwOsop9YS
   pDFPUA113IzLSkx/bdLx+1hrSky2oXkWQABsVBugLnv1oc9iC3oKaSoZ7
   g==;
X-CSE-ConnectionGUID: soGSl5J4RCazsoFUjO0qcg==
X-CSE-MsgGUID: BdNcJLp2QgG+QR9GKo2gUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="88871291"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="88871291"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 16:01:45 -0700
X-CSE-ConnectionGUID: MlQMpc63RpeJxCTjTA5DBw==
X-CSE-MsgGUID: t8RWdCDbQbWnwQdJGmX4jQ==
X-ExtLoop1: 1
Received: from orsosgc001.jf.intel.com ([10.88.27.185])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 16:01:45 -0700
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 7.1.y 3/8] drm/xe/rtp: Generalize whitelist_apply_to_hwe
Date: Mon,  3 Aug 2026 16:01:31 -0700
Message-ID: <20260803230136.3270230-4-ashutosh.dixit@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260803230136.3270230-1-ashutosh.dixit@intel.com>
References: <20260803230136.3270230-1-ashutosh.dixit@intel.com>
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

