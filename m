Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49A130E85B
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 06:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788330919; cv=none; b=BllDAkFuvBOoQNE7S3MMCpSBN4r38hYd8fqin4uU7bZ2/0gKQijF391E10LlYpqNMnLYczTFmX0lu5gZ2tWpcx9uL5vGa39fKInaQcukK0qD2mM+td9tzT6H3I5Rz4tBdv2F8IahFv8RJtK+nJKdKNlY99iFiCEbdxXapxoZ1Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788330919; c=relaxed/simple;
	bh=lNCFnULda7y20jlWm548neep+gsO6Aa4LjN7gZx2jdo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ybxx+gzBR5MnbltjdH89TXkAHLxsePgzIBmeek3OgaBvH7yhkBhjWrTcGRp7hs58/kOgjuxXwnINh3I+diaMpdhCX9pqCp5ZBHcVQNvLK2IEoH0+ZrrCxPdJ34kPBBERy3OAfBWQExz0NG8DdW06BeMvqUCgYYswVRUqQf1PFNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BH72O8N3; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BH72O8N3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788330918; x=1819866918;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lNCFnULda7y20jlWm548neep+gsO6Aa4LjN7gZx2jdo=;
  b=BH72O8N38NFcHxS0aO7WLaVpTuiFas7SvJ7fS16bSyENjM2xxr/l+ZVu
   fYTkDavECwUc/geWQVsyiauKUPUhgxgNMEWSWq+kPccntQTFNh7Ura9aG
   al/Rcu+uw4CDAhs5rVQEYfbby+zWOKDRPE77Nd84xkIlJogeVDAfpsAD+
   SUPOjkAKJdB9afqaoWM6wAWWa/id3x/luCd7G4PW2nVjAcqcfMu+RooUp
   F/TVfLgRTHizHVbPNzh/xpkh9awXzYK9SYdpLUL4tgkvclcnC9AKqWXFG
   eqhBpnOeaQWmAL76VYQw+1o7pOk6Ig1Tn2OPTtvuzCrYP0Bc3lMY0lIwE
   A==;
X-CSE-ConnectionGUID: 9GXynxLHQzKFIzJBh8dIMg==
X-CSE-MsgGUID: UHEtvwwITJuuZzW0CF6ucw==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="92598984"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="92598984"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 23:35:11 -0700
X-CSE-ConnectionGUID: aaada9ONRxSfjaAc7A2RuQ==
X-CSE-MsgGUID: VLCGhok/S++dSh/xbqhcEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="268775531"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 23:35:10 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org,
	Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Subject: [PATCH v4 2/2] drm/pagemap: Fix folio allocation fallback and use-after-put
Date: Tue,  1 Sep 2026 23:35:04 -0700
Message-Id: <20260902063504.3024362-2-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902063504.3024362-1-matthew.brost@intel.com>
References: <20260902063504.3024362-1-matthew.brost@intel.com>
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

Introducing the fallback in 1. also requires the source page array
handed to ->copy_to_ram() to be built differently. Both callers only
populated the entry at the head of each source folio, relying on the
copy callback to derive the rest of the folio from the order recorded
in the matching drm_pagemap_addr. Once the destination has been demoted
to order-0 folios the drm_pagemap_addr entries are per-page, so a source
page is needed for every one of them; leaving them NULL makes the copy
callback stop after the first page and the remainder of the range is
never copied.

The source folio is only split later, by migrate_vma_pages() /
migrate_device_pages(), so its order cannot be used to detect the
demotion - test the destination for MIGRATE_PFN_COMPOUND instead. Factor
the array population out into drm_pagemap_migrate_populate_src_pages()
and use it from both drm_pagemap_evict_to_ram() and
__drm_pagemap_migrate_to_ram().

Fixes: ddeda6136038 ("drm/pagemap: Allocate folios when possible")
Cc: stable@vger.kernel.org
Assisted-by: GitHub_Copilot:claude-opus-5
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
---
 drivers/gpu/drm/drm_pagemap.c | 128 +++++++++++++++++++++++++++-------
 1 file changed, 103 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
index 6aa745682270..a0546955d0b9 100644
--- a/drivers/gpu/drm/drm_pagemap.c
+++ b/drivers/gpu/drm/drm_pagemap.c
@@ -383,6 +383,58 @@ drm_pagemap_migrate_map_system_pages(struct device *dev,
 	return 0;
 }
 
+/**
+ * drm_pagemap_migrate_populate_src_pages() - Populate the source page array
+ * @pages: Array of source pages to populate
+ * @src_mpfn: Source array of migrate PFNs
+ * @dst_mpfn: Destination array of migrate PFNs
+ * @npages: Number of pages in the arrays
+ *
+ * Populate @pages with the device pages the copy callback is to read from.
+ *
+ * Entries are normally only populated at the head of each source folio, with
+ * the copy callback deriving the rest of the folio from the order recorded in
+ * the corresponding drm_pagemap_addr. That does not work where
+ * drm_pagemap_migrate_populate_ram_pfn() had to demote a higher-order source
+ * folio to order-0 destination folios: the drm_pagemap_addr entries are then
+ * per-page, and the copy callback needs a source page for each of them.
+ * Populate every entry for those ranges.
+ *
+ * Note that the source folio itself is only split later, by
+ * migrate_vma_pages() / migrate_device_pages(), so its order cannot be used to
+ * detect the demotion - the destination has to be inspected instead.
+ */
+static void drm_pagemap_migrate_populate_src_pages(struct page **pages,
+						   unsigned long *src_mpfn,
+						   unsigned long *dst_mpfn,
+						   unsigned long npages)
+{
+	unsigned long i;
+
+	for (i = 0; i < npages;) {
+		struct page *page = migrate_pfn_to_page(src_mpfn[i]);
+		unsigned int order = 0;
+		unsigned long j, nr;
+
+		if (!page) {
+			i++;
+			continue;
+		}
+
+		order = folio_order(page_folio(page));
+		nr = NR_PAGES(order);
+
+		if (order && !(dst_mpfn[i] & MIGRATE_PFN_COMPOUND)) {
+			for (j = 0; j < nr && i + j < npages; j++)
+				pages[i + j] = folio_page(page_folio(page), j);
+		} else {
+			pages[i] = page;
+		}
+
+		i += nr;
+	}
+}
+
 /**
  * drm_pagemap_migrate_unmap_pages() - Unmap pages previously mapped for GPU SVM migration
  * @dev: The device for which the pages were mapped
@@ -875,6 +927,7 @@ static int drm_pagemap_migrate_populate_ram_pfn(struct vm_area_struct *vas,
 		struct page *page = NULL, *src_page;
 		struct folio *folio;
 		unsigned int order = 0;
+		gfp_t gfp = GFP_HIGHUSER;
 
 		if (!(src_mpfn[i] & MIGRATE_PFN_MIGRATE))
 			goto next;
@@ -891,11 +944,51 @@ static int drm_pagemap_migrate_populate_ram_pfn(struct vm_area_struct *vas,
 
 		order = folio_order(page_folio(src_page));
 
-		/* TODO: Support fallback to single pages if THP allocation fails */
+		/*
+		 * A large source folio is always collected whole, at its head
+		 * page, PMD aligned and flagged MIGRATE_PFN_COMPOUND: anything
+		 * else is split before it reaches us, either by
+		 * migrate_vma_collect_pmd() or, for the eviction path, by
+		 * migrate_device_pfns(). Both the order-0 fallback below and
+		 * drm_pagemap_migrate_populate_src_pages() rely on that, as
+		 * they index the folio from @i.
+		 */
+		WARN_ON_ONCE(order &&
+			     (src_page != folio_page(page_folio(src_page), 0) ||
+			      !(src_mpfn[i] & MIGRATE_PFN_COMPOUND)));
+
+		if (order)
+			gfp |= __GFP_NOWARN;
+
 		if (vas)
-			folio = vma_alloc_folio(GFP_HIGHUSER, order, vas, addr);
+			folio = vma_alloc_folio(gfp, order, vas, addr);
 		else
-			folio = folio_alloc(GFP_HIGHUSER, order);
+			folio = folio_alloc(gfp, order);
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
+			gfp &= ~__GFP_NOWARN;
+			for (j = 0; j < nr && i < npages; j++, i++, addr += PAGE_SIZE) {
+				folio = vas ?
+					vma_alloc_folio(gfp, 0, vas, addr) :
+					folio_alloc(gfp, 0);
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
@@ -940,11 +1033,11 @@ static int drm_pagemap_migrate_populate_ram_pfn(struct vm_area_struct *vas,
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
@@ -1225,7 +1318,7 @@ int drm_pagemap_evict_to_ram(struct drm_pagemap_devmem *devmem_allocation)
 	unsigned long *src, *dst;
 	struct drm_pagemap_addr *pagemap_addr;
 	void *buf;
-	int i, err = 0;
+	int err = 0;
 	unsigned int retry_count = 2;
 
 	npages = devmem_allocation->size >> PAGE_SHIFT;
@@ -1268,15 +1361,7 @@ int drm_pagemap_evict_to_ram(struct drm_pagemap_devmem *devmem_allocation)
 	if (err)
 		goto err_finalize;
 
-	for (i = 0; i < npages;) {
-		unsigned int order = 0;
-
-		pages[i] = migrate_pfn_to_page(src[i]);
-		if (pages[i])
-			order = folio_order(page_folio(pages[i]));
-
-		i += NR_PAGES(order);
-	}
+	drm_pagemap_migrate_populate_src_pages(pages, src, dst, npages);
 
 	err = ops->copy_to_ram(pages, pagemap_addr, npages, NULL);
 	if (err)
@@ -1344,7 +1429,7 @@ static int __drm_pagemap_migrate_to_ram(struct vm_area_struct *vas,
 	struct drm_pagemap_addr *pagemap_addr;
 	unsigned long start, end;
 	void *buf;
-	int i, err = 0;
+	int err = 0;
 
 	zdd = drm_pagemap_page_zone_device_data(page);
 	if (time_before64(get_jiffies_64(), zdd->devmem_allocation->timeslice_expiration))
@@ -1401,15 +1486,8 @@ static int __drm_pagemap_migrate_to_ram(struct vm_area_struct *vas,
 	if (err)
 		goto err_finalize;
 
-	for (i = 0; i < npages;) {
-		unsigned int order = 0;
-
-		pages[i] = migrate_pfn_to_page(migrate.src[i]);
-		if (pages[i])
-			order = folio_order(page_folio(pages[i]));
-
-		i += NR_PAGES(order);
-	}
+	drm_pagemap_migrate_populate_src_pages(pages, migrate.src, migrate.dst,
+					       npages);
 
 	err = ops->copy_to_ram(pages, pagemap_addr, npages, NULL);
 	if (err)
-- 
2.34.1

