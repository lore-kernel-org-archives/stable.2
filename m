Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823485A79B
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 05:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785907072; cv=none; b=MuXOOBceTKijgiRDdDmEVoc2jiasCBRTMzvgBNUxtatDr1gQq7LFV/SNQW3l7B7D9l7l+uRNKPtNSDk44tRcZwnK5dXpvyvd+rOGus1phKBNZXgYiGLiLsfGwiIkvV9fZdr5nQujrg0iF/juPiBiGkTaoHmvPCXLohWV3lQuSH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785907072; c=relaxed/simple;
	bh=W/ecDD4htkPcjGn64ic0sUrFqDFnZ/YrJcFgEjaR8mA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NDauO9xAuq5UT5/8mKiwp5yrbyvcXGglxg8dLWjdExwXVd5HqP91CkOsIilOR6kdjO5mIUqfRxvmIM9yx5fCIMH5DhArXq85FBT9EUvCmx3HVtOmTaYi3exk6kx8/xA2JE+lsiA30WDLOLy/h/TedTMrWH7nOqWzSWC7tv27y6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HBe2WWSO; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HBe2WWSO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785907070; x=1817443070;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=W/ecDD4htkPcjGn64ic0sUrFqDFnZ/YrJcFgEjaR8mA=;
  b=HBe2WWSOxkRUyqTk8eMgZ9HJAZETWKHqvHacGEalAPS6uma9waxW8OJ8
   ztgH10o8rmFWiK102Q5boMH7tnWK86TwIKJEYbpcLj17hDs2HGKbeDYqn
   3VcGiyedinvdHr/1NBgZR8dqWG6zUoyFBGLs124xtkw8owemdKNNyaRop
   Yruoy4TBKEIGxZwcJc+x2BWvAQZD3/oV1rCKUFnzI07yaEncLMOjinfFs
   2g5TtmaEFm0lRGXj2e6D5uMHfGyFrP1tvsMVnY7Uz0s7/5iKgfe2ZkF1K
   21iTZIhXjJNltjxywv+ZCmyTGL6eF6mWGYUHCeZaOZsxjg27+DGE8oM3t
   g==;
X-CSE-ConnectionGUID: nLWmlRRmRQeggRlphFhSGw==
X-CSE-MsgGUID: jWPIF7Z9TSWqM6Q7YxgrNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="86549202"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="86549202"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 22:17:50 -0700
X-CSE-ConnectionGUID: unl4cj4eR+ePR015rb8/hw==
X-CSE-MsgGUID: 4MNgWfgQR2er3SMpgo5aIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="263687336"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 22:17:50 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2] drm/pagemap: Fix folio allocation fallback and use-after-put
Date: Tue,  4 Aug 2026 22:17:44 -0700
Message-Id: <20260805051744.3481873-1-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drm_pagemap_migrate_populate_ram_pfn() had two issues when populating
RAM PFNs with higher-order folios:

1. The higher-order vma_alloc_folio()/folio_alloc() calls did not pass
   __GFP_NOWARN, so a THP allocation failure under memory pressure
   would spam the kernel log, and there was no fallback path despite a
   TODO comment stating one was needed. Add __GFP_NOWARN to the
   higher-order allocation and, on failure, fall back to order-0
   allocations for the entire range originally covered by the failed
   higher-order allocation, leaving MIGRATE_PFN_COMPOUND unset for
   those PFNs.

2. In the free_pages error path, order was computed via
   folio_order(page_folio(page)) *after* put_page(page) had already
   dropped the reference, resulting in a use-after-free/put when that
   was the last reference on the page. Compute order before releasing
   the page.

Fixes: ddeda6136038 ("drm/pagemap: Allocate folios when possible")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Matthew Brost <matthew.brost@intel.com>

---
v2:
 - Bound order-0 by num_pages (Sashiko)
---
 drivers/gpu/drm/drm_pagemap.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
index 892b325fa99b..923f96d5c40e 100644
--- a/drivers/gpu/drm/drm_pagemap.c
+++ b/drivers/gpu/drm/drm_pagemap.c
@@ -891,11 +891,34 @@ static int drm_pagemap_migrate_populate_ram_pfn(struct vm_area_struct *vas,
 
 		order = folio_order(page_folio(src_page));
 
-		/* TODO: Support fallback to single pages if THP allocation fails */
 		if (vas)
-			folio = vma_alloc_folio(GFP_HIGHUSER, order, vas, addr);
+			folio = vma_alloc_folio(GFP_HIGHUSER | __GFP_NOWARN, order, vas, addr);
 		else
-			folio = folio_alloc(GFP_HIGHUSER, order);
+			folio = folio_alloc(GFP_HIGHUSER | __GFP_NOWARN, order);
+
+		if (!folio && order) {
+			/*
+			 * Higher-order allocation failed, fall back to
+			 * order-0 allocations for the entire range covered
+			 * by the original higher-order allocation, without
+			 * setting MIGRATE_PFN_COMPOUND, until we move past
+			 * that range.
+			 */
+			unsigned long nr = NR_PAGES(order);
+			unsigned long j;
+
+			for (j = 0; j < nr && i < npages; j++, i++, addr += PAGE_SIZE) {
+				folio = vas ?
+					vma_alloc_folio(GFP_HIGHUSER, 0, vas, addr) :
+					folio_alloc(GFP_HIGHUSER, 0);
+				if (!folio)
+					goto free_pages;
+
+				page = folio_page(folio, 0);
+				mpfn[i] = migrate_pfn(page_to_pfn(page));
+			}
+			continue;
+		}
 
 		if (!folio)
 			goto free_pages;
@@ -940,11 +963,11 @@ static int drm_pagemap_migrate_populate_ram_pfn(struct vm_area_struct *vas,
 		if (!page)
 			goto next_put;
 
+		order = folio_order(page_folio(page));
+
 		put_page(page);
 		mpfn[i] = 0;
 
-		order = folio_order(page_folio(page));
-
 next_put:
 		i += NR_PAGES(order);
 	}
-- 
2.34.1

