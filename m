Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDE031F984
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 00:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790729048; cv=none; b=qSs/ijfmSw4iiMiI6M0AxVjj3AfpV2rkP0u5RIGFp/DdtnRAU/vt7rgsBFQ7L1m9jaWkROqtvEKGSpOkwqico+nqzGRzuzLoSfVePflQ4wZrJsbLVH931AFcsXfBZD3oasim+RnLmd/OdSTH1yFOEHYUtB0ANSpqLTqrVPQHhQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790729048; c=relaxed/simple;
	bh=sKiY9VR5TtEBtH1da539FdjX4wCTJvXqbDY+0J++ulQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K2Nv5eXyg0OLivjsjmCvC7zK4RyTlZMz+fOx/tEpbt9GRSBLeEsluNWMwzRewvu51pxRJ2jhQrph392AkOC6grp+HsmgKeO547FYDeulmysncV99giZh70s5LkOtyd1jM0VC5FNcNjSX66gKQSr6r8hbiH1yi8REqVHI+5XACP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ROzih445; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROzih445"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5FEB1F000FF;
	Wed, 30 Sep 2026 00:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790729046;
	bh=P84dkhS13xOWIrmWMMWQ+6Fh/di6+wYVMvbWtLXLyTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ROzih445UC5V8KZ5k6wPrwkmpXm/WdlETpJaSnaK1qUvjgvXa7Pj7D874RZfhC6Ld
	 qEIZY3vv4GctERcVPFvIFwxvdmlEpMG229b06OQq/mXs6wjR2IeXyqDwWMwgES3ucM
	 mQnyj9IOmIMY47QoKh4/oDp+OxlDa5cuvPg0e1An8ZM1Vi0Kmm1UktZHPjEyCcnmn6
	 5FqfHy62ZRJzIjAonQlU/W4ZtUPPlXML5KgxI3tvadQ/GR+CRrKJn04SLady3Q9z2x
	 h1Nk7TqQD1vArQbdXKi25sPVgk5uAwwqOam4+5LeyLIxdAHC7mxd9ZuaGftiCUI3m9
	 R/EhBeZ7NGrng==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jinjiang Tu <tujinjiang@huawei.com>,
	David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Muchun Song <muchun.song@linux.dev>,
	Nanyong Sun <sunnanyong@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] mm/hugetlb: fix surplus pages in dissolve_free_huge_page()
Date: Tue, 29 Sep 2026 20:44:03 -0400
Message-ID: <20260930004404.2953402-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092905-mystified-upstart-3f7b@gregkh>
References: <2026092905-mystified-upstart-3f7b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jinjiang Tu <tujinjiang@huawei.com>

[ Upstream commit cb402bbdabcaa5a765068c5b8673bbfc1c264242 ]

In dissolve_free_huge_page(), free huge pages are dissolved without
adjusting surplus count. However, free huge pages may be accounted as
surplus pages, and will lead to wrong surplus count.

I reproduce this issue on qemu. The steps are:
1) Node1 is memory-less at first. Hot-add memory to node1 by executing
the two commands in qemu monitor:
  object_add memory-backend-ram,id=mem1,size=1G
  device_add pc-dimm,id=dimm1,memdev=mem1,node=1
2) online one memory block of Node1 with：
  echo online_movable > /sys/devices/system/node/node1/memoryX/state
3) create 64 huge pages for node1
4) run a program to reserve (don't consume) all the huge pages
5) echo 0 > nr_huge_pages for node1. After this step, free huge pages in
Node1 are surplus.
6) create 80 huge pages for node0
7) offline memory of node1, The memory range to offline contains the free
surplus huge pages created in step3) ~ step5)
  echo offline > /sys/devices/system/node/node1/memoryX/state
8) kill the program in step 4)

The result:
           Node0     Node1
total       80        0
free        80        0
surplus     0         61

To fix it, adjust surplus when destroying huge pages if the node has
surplus pages in dissolve_free_hugetlb_folio().

The result with this patch:
           Node0     Node1
total       80        0
free        80        0
surplus     0         0

Link: https://lkml.kernel.org/r/20250304132106.2872754-1-tujinjiang@huawei.com
Fixes: c8721bbbdd36 ("mm: memory-hotplug: enable memory hotplug to handle hugepage")
Signed-off-by: Jinjiang Tu <tujinjiang@huawei.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Oscar Salvador <osalvador@suse.de>
Cc: Jinjiang Tu <tujinjiang@huawei.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Nanyong Sun <sunnanyong@huawei.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Backport notes for Linux 5.15:
- Use compound_head(), page_to_nid(), remove_hugetlb_page(), and
  add_hugetlb_page() for surplus accounting. Preserve the existing vmemmap
  restoration and raw hardware-poison handling.
- Keep max_huge_pages unchanged when removing or restoring a surplus
  page, as fixed upstream by 267bede12d3b ("mm/hugetlb: keep max_huge_pages
  when dissolving surplus folios"). This avoids corrupting or underflowing
  the persistent pool target.
- Define available_huge_pages() and hstate_is_gigantic_no_runtime() as
  local expression macros using the existing 5.15 operations. Reuse the
  latter in the existing runtime-support checks. These prepare the
  context and predicate needed for a clean cherry-pick of a363c62a653c
  without adding functions or importing the folio conversion.

Stable-dep-of: a363c62a653c ("mm/hugetlb: do not dissolve gigantic pages without runtime support")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/hugetlb.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e0908e491065d..f4b296c3f6d3b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -44,6 +44,10 @@
 #include "internal.h"
 #include "hugetlb_vmemmap.h"
 
+#define available_huge_pages(h) ((h)->free_huge_pages - (h)->resv_huge_pages)
+#define hstate_is_gigantic_no_runtime(h) \
+	(hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
+
 int hugetlb_max_hstate __read_mostly;
 unsigned int default_hstate_idx;
 struct hstate hstates[HUGE_MAX_HSTATE];
@@ -1368,7 +1372,7 @@ static void remove_hugetlb_page(struct hstate *h, struct page *page,
 	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page_rsvd(page), page);
 
 	lockdep_assert_held(&hugetlb_lock);
-	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
+	if (hstate_is_gigantic_no_runtime(h))
 		return;
 
 	list_del(&page->lru);
@@ -1456,7 +1460,7 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
 	int i;
 	struct page *subpage = page;
 
-	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
+	if (hstate_is_gigantic_no_runtime(h))
 		return;
 
 	if (alloc_huge_page_vmemmap(h, page)) {
@@ -1969,7 +1973,9 @@ int dissolve_free_huge_page(struct page *page)
 	if (!page_count(page)) {
 		struct page *head = compound_head(page);
 		struct hstate *h = page_hstate(head);
-		if (h->free_huge_pages - h->resv_huge_pages == 0)
+		bool adjust_surplus = false;
+
+		if (!available_huge_pages(h))
 			goto out;
 
 		/*
@@ -1991,8 +1997,11 @@ int dissolve_free_huge_page(struct page *page)
 			goto retry;
 		}
 
-		remove_hugetlb_page(h, head, false);
-		h->max_huge_pages--;
+		if (h->surplus_huge_pages_node[page_to_nid(head)])
+			adjust_surplus = true;
+		remove_hugetlb_page(h, head, adjust_surplus);
+		if (!adjust_surplus)
+			h->max_huge_pages--;
 		spin_unlock_irq(&hugetlb_lock);
 
 		/*
@@ -2017,8 +2026,9 @@ int dissolve_free_huge_page(struct page *page)
 			update_and_free_page(h, head, false);
 		} else {
 			spin_lock_irq(&hugetlb_lock);
-			add_hugetlb_page(h, head, false);
-			h->max_huge_pages++;
+			add_hugetlb_page(h, head, adjust_surplus);
+			if (!adjust_surplus)
+				h->max_huge_pages++;
 			spin_unlock_irq(&hugetlb_lock);
 		}
 
@@ -3285,7 +3295,7 @@ static ssize_t __nr_hugepages_store_common(bool obey_mempolicy,
 	int err;
 	nodemask_t nodes_allowed, *n_mask;
 
-	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
+	if (hstate_is_gigantic_no_runtime(h))
 		return -EINVAL;
 
 	if (nid == NUMA_NO_NODE) {
-- 
2.53.0

