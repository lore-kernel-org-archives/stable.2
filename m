Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1C31D47AC
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 04:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785905038; cv=none; b=Yy+N83tszkU0PLk1RPnEAWs1f1Co7JJrqMmZxvSA0A/Di2VC2L4vI2LYcYWpg9Z0+ln6HaFl4/RNpm4ZWoqqKFwYNagW/i7YYk7KcjLQGmwtqJYCQVZLemC43YfEWW5yd/2pcvbPNWlaLnaOj2yumwHd8spBGgJXAiYcyG0jwIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785905038; c=relaxed/simple;
	bh=iZUryQ1JGcwGzfLzR/LhB0prUQc9/c0XSXjY04aj37w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R64r25GJ6p+IIleEhnB0Q7zURrLnQFHCYhPFqJal2vYH1Ej+7wAf0X/bOOwPczsqUFnQkOBn04k5MQaof+Yqb9g4AdCNEqcgLbkSOQUP0n/3bMG+zy2UdoXFg0SoARxJTIwIMcED+jReBmKIhGklz1FGHAFwcX3neOyozYEE5CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oIQ5WElP; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oIQ5WElP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785905036; x=1817441036;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iZUryQ1JGcwGzfLzR/LhB0prUQc9/c0XSXjY04aj37w=;
  b=oIQ5WElPYirllnqaXQhE8tAAewgIumxPko5QgfVwJ6EzjqUPw8Zbprg3
   dB4GSlU1o46y9y1LTaScuPwsatzPCh47Z+5nLTa4nFu7nmK78cepaRFDE
   5ZXtHVmpUpj/PhTXaI/RzOpP6imsflb9vKBZtJr/ezGg3rGMVmkkjl9jQ
   cKb9Wt5mfU3z4JemOL3ShobN6v6PcQzwSX5tGn3UkCGJw+pGmOekO1K/3
   1qXTfTK+p+t3jElrJ/M0N5LyMDA+qCCKGD7t4MMsCuiP/adcO/ID5Q4bc
   FpsrS7ZFVhDTDo01oqZ5jABXcbtQgYBSyrDzh5aHOGIxb4DnFzv+l0ZOo
   A==;
X-CSE-ConnectionGUID: 2t6rHGjjTvmzvRJniiMeVg==
X-CSE-MsgGUID: sHQY2ZDtRSyXnm6kUXm4RQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="86669076"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="86669076"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 21:43:56 -0700
X-CSE-ConnectionGUID: 85Yomf12RCCQoqACo/OBDg==
X-CSE-MsgGUID: d8iqGzXYQACwsoQWRpew1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="259057014"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 21:43:55 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: [PATCH] drm/pagemap: Fix folio allocation fallback and use-after-put
Date: Tue,  4 Aug 2026 21:43:49 -0700
Message-Id: <20260805044349.3474498-1-matthew.brost@intel.com>
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
 drivers/gpu/drm/drm_pagemap.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
index 892b325fa99b..fb939fda80e8 100644
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
+			for (j = 0; j < nr; j++, i++, addr += PAGE_SIZE) {
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

