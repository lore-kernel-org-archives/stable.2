Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005CC3E49EF;
	Wed,  5 Aug 2026 19:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785958547; cv=none; b=gGEV7vIDnNbuZNBQhKFEvXI6k4zG8VK1s6brM7+ltkojwvJVpByC/JxEY6xYYy3v0FC8HhLhKFDrqQ/1S4eHHEdlpDHSBinqg9gKbj49zE6dabLHyK+pKqDTZKEpkt4xS7xKJHUmhVC6bZEhI0k+CIqsZsnTbO8IY9qf67aY1HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785958547; c=relaxed/simple;
	bh=DwXjrp0YOMKqBIa0CyQY66LJvCKzj79JzvSlROjOOxA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=skvmkiJWSRA6zXICYts+H43IjwRhgL1Ze4lJzZG7avpipGuvtFblcJYd81SwofIVr89D7QmoerliDuc9MNl6XZXVWn3BrjIL9Jidfnoqj2B8jXsSx51mkfi6+IrA7QypZdN2Bi1y7/g9kPqasYttqfGWVaqjaA3VDdnz9EWr1lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qk/CHIeV; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qk/CHIeV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785958546; x=1817494546;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DwXjrp0YOMKqBIa0CyQY66LJvCKzj79JzvSlROjOOxA=;
  b=Qk/CHIeVJn38sklPcAFJDamTISxuj/S4tz3BjbcDb4gCH6eTL9DMkene
   Px95NR9oh0XKdNytqH6qDNQDWkkO4lILpFVuA8RxgwW9rs/oHOZNqj55D
   Wmr7cDr3KeL+ONFrpUXoeIKKNDIXHk1YVpfY6CuuPHlY83BbArT+fA75g
   Rbhiq4YJ6twrbF0X02WA2+PUGPrDgIzIQ9jYFXqs+hlfnniqp48o6cEIh
   Q3ArWMioRNPV8aJMEJ2eCMSwVB4VtwNmfpEm/uYqrsqHiuJUFhSSRQZcB
   FgSjcQI8GqTgNTqq5q6AAFhPJ9gi7lAQT7WtKexG0s1kHkrW9zYQJyZC4
   g==;
X-CSE-ConnectionGUID: upvVpFnEQf6as8jJxHrgHg==
X-CSE-MsgGUID: 5gQgvINeQ7eFcYOS0oOeKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="109332954"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="109332954"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 12:35:44 -0700
X-CSE-ConnectionGUID: CujDtT0BQmaBotcPTuJkwA==
X-CSE-MsgGUID: sX6rfqqERo6FgsdinoenMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="285263527"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 12:35:43 -0700
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
Subject: [PATCH v2 3/5] mm/migrate_device: Apply the fault reference to the correct folio
Date: Wed,  5 Aug 2026 12:35:34 -0700
Message-Id: <20260805193536.3756457-4-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260805193536.3756457-1-matthew.brost@intel.com>
References: <20260805193536.3756457-1-matthew.brost@intel.com>
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
Assisted-by: GitHub_Copilot:claude-opus-5
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 mm/migrate_device.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 142920a464d8..4ee09801efe6 100644
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
@@ -1301,13 +1301,25 @@ static void __migrate_device_pages(unsigned long *src_pfns,
 
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

