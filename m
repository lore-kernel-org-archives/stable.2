Received: from mta1.migadu.com (out-77.mta1.migadu.com [95.215.58.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EE53B27CF
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 08:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790670002; cv=none; b=n9IKeepBGAUx/dDlT0q5A4xKEPBxhke+bwsRT6cT/KrEJ/+yysVBiihL+OhWOBf/rJTkodK1CAMbJ++SNpJGWVa0uixDgeLfJXrU5jg/+fizKmVGKK0CNcYeZrc67y/soi/O3OHB8Uj8YS945lVRmCeOQuSw2CEU7c4eyh9yQow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790670002; c=relaxed/simple;
	bh=GTNtvhQM0BkduvLf1bxHQQa2gN5nenib1TDzHr3/lk4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PwgTAEHfpc5q4wn54BVDNIPjRlRLE4exzQ90KE+8Ir0HTGQ21+LVY0jfR/M6mJgXg5bT/SyIIWcDOvLsZLrou8nPixd5w+j+NC/qVLpT2NAvfVeE53zQovfeHcjTEInkUkc1pVcR084zx51AjBjL02+nK6MdMvNUmXat7A596DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bCHkS0KB; arc=none smtp.client-ip=95.215.58.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bCHkS0KB"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=GTNtvhQM0BkduvLf1bxHQQa2gN5nenib1TDzHr3/lk4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790669997; v=1; x=1791274797;
 b=bCHkS0KBTqEhdz+P40C/mCNOxPFw545wTpDB1f73Qdn3UUAxchGURPR0qhch6Zf18DfY+W13
 9Iw+LmGRmODyXVVNKWZHRUvGvQ308u8S07IgvY8vZkici3FhTd+vzrQSpMF2te3zp38jE+9X2jV
 Raw0yV5imOXmcP1APBq5YOJg=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 89245958c046eafb;
	Tue, 29 Sep 2026 08:19:57 +0000
X-Mizu-Trace-ID: 89245958c046eafb
X-Migadu-Flow: FLOW_OUT
From: Hao Ge <hao.ge@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>,
	=Kent Overstreet <kent.overstreet@linux.dev>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	Uladzislau Rezki <urezki@gmail.com>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org,
	kasan-dev@googlegroups.com,
	Hao Ge <hao.ge@linux.dev>,
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v11 2/7] mm/vmalloc: undo partial mappings inside the mapping functions
Date: Tue, 29 Sep 2026 16:20:09 +0800
Message-Id: <20260929082014.160587-3-hao.ge@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260929082014.160587-1-hao.ge@linux.dev>
References: <20260929082014.160587-1-hao.ge@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__vmap_pages_range_noflush() and friends can install some PTEs before
failing and leave them mapped, and the kernel callers do not agree on
who cleans them up. For example, pcpu_map_pages() and
kmsan_ioremap_page_range() unmap the leftovers themselves, while
vm_module_tags_populate() and the __GFP_NOFAIL retry loop in
__vmalloc_area_node() relied on the mapping functions cleaning up and
did not call anything like vunmap_range() themselves. When the same
range is mapped again, the attempt hits the leftovers and fails, with
BUG() in vmap_pte_range() for huge mappings.

After discussing with Suren and Ulad, we decided the cleanup belongs
to __vmap_pages_range_noflush() and friends, so the callers no longer
need to unmap the partial mappings themselves. Each function now
undoes the PTEs it installed itself.

The rollback calls the low-level __vunmap_range_noflush(), it just
clears the PTEs of the range it is given, which is all a rollback
needs. It cannot use vunmap_range_noflush() because these mapping
functions also map the KMSAN shadow and origin, and for a metadata
range its hook would look up the metadata of the metadata, get 0
and BUG() on addr >= end. The failed mappings were never accessed,
no TLB flush needed.

Fixes: 9376130c390a ("mm/vmalloc: add support for __GFP_NOFAIL")
Fixes: 0f9b685626da ("alloc_tag: populate memory for module tags as needed")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Hao Ge <hao.ge@linux.dev>
---
 mm/kmsan/shadow.c |  4 ++++
 mm/vmalloc.c      | 31 +++++++++++++++++++++++++++++--
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/mm/kmsan/shadow.c b/mm/kmsan/shadow.c
index 0c88d89bf0d6..2166086d3dc3 100644
--- a/mm/kmsan/shadow.c
+++ b/mm/kmsan/shadow.c
@@ -258,6 +258,10 @@ int kmsan_vmap_pages_range_noflush(unsigned long start, unsigned long end,
 					    o_pages, page_shift);
 	kmsan_leave_runtime();
 	if (mapped) {
+		/* Undo the shadow mapping set up above. */
+		kmsan_enter_runtime();
+		__vunmap_range_noflush(shadow_start, shadow_end);
+		kmsan_leave_runtime();
 		err = mapped;
 		goto ret;
 	}
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 859e6d2d57a3..9bbf75706627 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -349,6 +349,10 @@ static int vmap_range_noflush(unsigned long addr, unsigned long end,
 	if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
 		arch_sync_kernel_mappings(start, end);
 
+	/* Undo the PTEs installed before the failure. */
+	if (err)
+		__vunmap_range_noflush(start, end);
+
 	return err;
 }
 
@@ -363,6 +367,9 @@ int vmap_page_range(unsigned long addr, unsigned long end,
 	if (!err)
 		err = kmsan_ioremap_page_range(addr, end, phys_addr, prot,
 					       ioremap_max_page_shift);
+	if (err)
+		__vunmap_range_noflush(addr, end);
+
 	return err;
 }
 
@@ -667,6 +674,10 @@ static int vmap_small_pages_range_noflush(unsigned long addr, unsigned long end,
 	if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
 		arch_sync_kernel_mappings(start, end);
 
+	/* Undo the PTEs installed before the failure. */
+	if (err)
+		__vunmap_range_noflush(start, end);
+
 	return err;
 }
 
@@ -683,6 +694,7 @@ int __vmap_pages_range_noflush(unsigned long addr, unsigned long end,
 		pgprot_t prot, struct page **pages, unsigned int page_shift)
 {
 	unsigned int i, nr = (end - addr) >> PAGE_SHIFT;
+	unsigned long start = addr;
 
 	WARN_ON(page_shift < PAGE_SHIFT);
 
@@ -696,8 +708,14 @@ int __vmap_pages_range_noflush(unsigned long addr, unsigned long end,
 		err = vmap_range_noflush(addr, addr + (1UL << page_shift),
 					page_to_phys(pages[i]), prot,
 					page_shift);
-		if (err)
+		if (err) {
+			/*
+			 * vmap_range_noflush() undoes its own partial work,
+			 * discard the chunks that already mapped.
+			 */
+			__vunmap_range_noflush(start, addr);
 			return err;
+		}
 
 		addr += 1UL << page_shift;
 	}
@@ -714,7 +732,16 @@ int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
 
 	if (ret)
 		return ret;
-	return __vmap_pages_range_noflush(addr, end, prot, pages, page_shift);
+
+	ret = __vmap_pages_range_noflush(addr, end, prot, pages, page_shift);
+	/*
+	 * The page tables undo themselves on failure. Tear down the
+	 * metadata that was fully set up before the mapping failed.
+	 */
+	if (ret)
+		kmsan_vunmap_range_noflush(addr, end);
+
+	return ret;
 }
 
 static int __vmap_pages_range(unsigned long addr, unsigned long end,
-- 
2.25.1

