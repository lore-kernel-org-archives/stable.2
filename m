Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349754334DE;
	Wed,  5 Aug 2026 11:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785929631; cv=none; b=T5SOC+Lz25aftyOtKEIPeFygclzCh6e8TVAeNR7ceedbgm8DeBygKbK9aij0KXNS/VnuXYoIm1fsf1gPSZaQc76XdMSaJMCEF10wtnWqrsMtWFpsWhKNAKYtmD/SHimu3gSi3REhjSi3QvuGnnvHmbXuZ57dmYylCsQiAW/a1UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785929631; c=relaxed/simple;
	bh=ZxPU7quEySN5Hl4qRC5WeOO+MTXBZUcrGg6kx4/kNtY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IGLwA2unxGKqXyqpFOa0DMu/Z0Uy63yAVidEn9zOmWWIO6ShpFO3kzI55ZWD0euT5g6wzufAHUqcJHaMAqmm2BQHSs8HFk4YBHQF442e2zDsDb0QcAlyLo9onQG5TVyfvxSzPBfFKOt6HhWPx7FE424fUMPaYJbHxtfoCuyl88o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FKf4ul02; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FKf4ul02"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785929628; x=1817465628;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZxPU7quEySN5Hl4qRC5WeOO+MTXBZUcrGg6kx4/kNtY=;
  b=FKf4ul02vvW6VTUWVqY1ohHMgpS97f8YoRI5VWA5V+/LsIjQ73hbaV8D
   bHNJFM/7NI10FPMEnH3Q1zJgU6scxeFuMmKyR4uZLJ/xj96ULWz+g7+F8
   bkTwr1sPBlaYo82FUuSXcnvbFm7Db+LKQmdIo2Y+oqpXvrmk9CEzlRuod
   zDSwAcHQsklXFJw0eTA7jyKINj7OWafBJKtrVh/n/nSeSWPelEv3/sDdx
   R1bv5pNvLKcIt/oM90kLC1v5Y5pXQ3bMBQLr5jgTJKVgZLCWcvNVTkhsd
   AK4QaZ38lj5FKdWbzVoVSfsGWCXsaVSM9TTO3+DVdUKMrtHZA8S8jGagY
   A==;
X-CSE-ConnectionGUID: 0EerXESCSw+a/uNj8FeiQQ==
X-CSE-MsgGUID: 4bCi1D0jSKSSnJ3xGBPuvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="86358188"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="86358188"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 04:33:45 -0700
X-CSE-ConnectionGUID: TlTSTTbZQ92hntgr1WOfMQ==
X-CSE-MsgGUID: X+D8wfZAS76OZrI13c7G0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="265289747"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 04:33:45 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <liam@infradead.org>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Balbir Singh <balbirs@nvidia.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Francois Dugast <francois.dugast@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/4] mm/migrate_device: Apply the fault reference to the correct folio
Date: Wed,  5 Aug 2026 04:33:36 -0700
Message-Id: <20260805113338.3742178-3-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260805113338.3742178-1-matthew.brost@intel.com>
References: <20260805113338.3742178-1-matthew.brost@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

__migrate_device_pages() computed extra_cnt once, from the head page of
the source folio, and then passed the same value to
folio_migrate_mapping() for every one of the @nr sub-folios produced by
migrate_vma_split_unmapped_folio().

The extra reference the CPU fault holds only exists on the single folio
that ends up containing the fault page. Claiming it for all of them
makes folio_migrate_mapping() expect one reference too many on every
other sub-folio, so it returns -EAGAIN and MIGRATE_PFN_MIGRATE is
cleared for them. Only the fault page would migrate; the remaining
HPAGE_PMD_NR - 1 pages would be restored to device memory, and the
faulting access would immediately fault again.

Compute extra_cnt per sub-folio instead, comparing against the source
page for that entry.

While at it, use the sub-folio's own mapping rather than the mapping
that was read from the pre-split folio.

This has been latent so far because the split it depends on could never
succeed while the fault reference was held.

Fixes: 4265d67e405a ("mm/migrate_device: add THP splitting during migration")
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Nico Pache <nico.pache@linux.dev>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: Usama Arif <usama.arif@linux.dev>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Rakie Kim <rakie.kim@sk.com>
Cc: Byungchul Park <byungchul@sk.com>
Cc: Gregory Price <gourry@gourry.net>
Cc: Ying Huang <ying.huang@linux.alibaba.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Balbir Singh <balbirs@nvidia.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Francois Dugast <francois.dugast@intel.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Assisted-by: GitHub Copilot:claude-opus-5
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 mm/migrate_device.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index d1d81bbbf795..65a6a15dba4d 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -1191,7 +1191,7 @@ static void __migrate_device_pages(unsigned long *src_pfns,
 		struct page *page = migrate_pfn_to_page(src_pfns[i]);
 		struct address_space *mapping;
 		struct folio *newfolio, *folio;
-		int r, extra_cnt = 0;
+		int r;
 		unsigned long nr = 1;
 
 		if (!newpage) {
@@ -1296,13 +1296,25 @@ static void __migrate_device_pages(unsigned long *src_pfns,
 
 		BUG_ON(folio_test_writeback(folio));
 
-		if (migrate && migrate->fault_page == page)
-			extra_cnt = 1;
 		for (j = 0; j < nr && i + j < npages; j++) {
-			folio = page_folio(migrate_pfn_to_page(src_pfns[i+j]));
+			struct page *src_page = migrate_pfn_to_page(src_pfns[i+j]);
+			int extra_cnt = 0;
+
+			folio = page_folio(src_page);
 			newfolio = page_folio(migrate_pfn_to_page(dst_pfns[i+j]));
 
-			r = folio_migrate_mapping(mapping, newfolio, folio, extra_cnt);
+			/*
+			 * The CPU fault holds an extra reference on the folio
+			 * containing the fault page. @folio may have been
+			 * split above, so the fault page only accounts for an
+			 * extra reference on the folio it actually ended up
+			 * in, not on every folio of the original THP.
+			 */
+			if (migrate && migrate->fault_page == src_page)
+				extra_cnt = 1;
+
+			r = folio_migrate_mapping(folio_mapping(folio), newfolio,
+						  folio, extra_cnt);
 			if (r)
 				src_pfns[i+j] &= ~MIGRATE_PFN_MIGRATE;
 			else
-- 
2.34.1

