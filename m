Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A549EED8
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 00:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790726648; cv=none; b=KaM+ZkMc5lz05j/lfkWyO9z0/g30Z+uCTkDq72cc67H4JkiOD3nksaTMfCKi34NjHJCq+XRDFnRWZOxF3yP1OEXdDjcZ4q3a52+Er2WYcNxcG78V7h26W/ITSsJ9P3r1cQc69wb06pW6IJ2uI3VzLLbKuwt7nxdwByFg6RcsPkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790726648; c=relaxed/simple;
	bh=tsMsw+Ypp8t6sGhAzVMKDKppI9Ku1zI2ceSJYhlPDBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gxoLvGp7Eb0eMopI7Zu3G6CQp7zRnzjDz+/+atrd7njyGWA59IAt7gbg0wrQhlPcyfy2frj9U5Ys34uAysJVmp0mDZ64n9FtrErjh596wALpsIoS5yrgmUulsqf4yGR6S/0bQ5mX8iedem81/Woq9R0wSA0LeCxyEupkJCVFnr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NybU3Ldt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NybU3Ldt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E2C1F000FF;
	Wed, 30 Sep 2026 00:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790726647;
	bh=otVSox73nbRJbmZ856zR+YoJLZO6XJz867f6CjMX+j0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NybU3LdtDdMBgBNVnjNN5JipwF4qY2rB1uyEhXUQDxCMMtT7IsIL6TnGEFE0DxY5h
	 /V4n4xJdFkeNDpCdSQu9mQtBr9QCoOpnwdYKXeQFsPQV23OrLIIaKmbU/UASbo7uBZ
	 8Uv34oQBnE8QokrwXLNtQItnCZ4GRhxWLZJVmAIHaOubJKCioxGI6f5LIZxF4YuR37
	 vG2am1rUoSYH2XODf2//t+HK3l7odl9QfdNpExj9X/QqOdv3E9JsCDjOOPeFLqIMsB
	 ELT6cHpMPuxw7RZJoGL/SDfjYkRq63h0/zgcs7CMPLewpUa+4Icg10xbHF9plbLiWI
	 fNihJuZQXwTKQ==
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
Subject: [PATCH 6.1.y 1/3] mm/hugetlb: fix surplus pages in dissolve_free_huge_page()
Date: Tue, 29 Sep 2026 20:04:02 -0400
Message-ID: <20260930000404.2861901-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092905-greeter-coke-d3db@gregkh>
References: <2026092905-greeter-coke-d3db@gregkh>
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

Backport adaptation for Linux 6.1:

Keep the existing page-based dissolution and vmemmap-restore control flow.
Use the node surplus count to select adjust_surplus, and pass that same
value to remove_hugetlb_page() and add_hugetlb_page() so a failed vmemmap
restore reverses the surplus-accounting change as well.

Obtain the existing head page through page_folio() and use folio_hstate()
to provide the declaration context expected by a363c62a653c ("mm/hugetlb:
do not dissolve gigantic pages without runtime support"). Provide its
hstate_is_gigantic_no_runtime predicate as a local macro with the same
expression already used by the page helpers. This lets the target apply
unchanged without adding functions or importing the wider folio conversion.

Stable-dep-of: a363c62a653c ("mm/hugetlb: do not dissolve gigantic pages without runtime support")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/hugetlb.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index bfcb936084e85..497e975b28254 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -47,6 +47,9 @@
 #include "internal.h"
 #include "hugetlb_vmemmap.h"
 
+#define hstate_is_gigantic_no_runtime(h) \
+	(hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
+
 int hugetlb_max_hstate __read_mostly;
 unsigned int default_hstate_idx;
 struct hstate hstates[HUGE_MAX_HSTATE];
@@ -2355,8 +2358,11 @@ int dissolve_free_huge_page(struct page *page)
 	}
 
 	if (!page_count(page)) {
-		struct page *head = compound_head(page);
-		struct hstate *h = page_hstate(head);
+		struct folio *folio = page_folio(page);
+		struct page *head = &folio->page;
+		struct hstate *h = folio_hstate(folio);
+		bool adjust_surplus = false;
+
 		if (!available_huge_pages(h))
 			goto out;
 
@@ -2379,7 +2385,9 @@ int dissolve_free_huge_page(struct page *page)
 			goto retry;
 		}
 
-		remove_hugetlb_page(h, head, false);
+		if (h->surplus_huge_pages_node[page_to_nid(head)])
+			adjust_surplus = true;
+		remove_hugetlb_page(h, head, adjust_surplus);
 		h->max_huge_pages--;
 		spin_unlock_irq(&hugetlb_lock);
 
@@ -2396,7 +2404,7 @@ int dissolve_free_huge_page(struct page *page)
 			update_and_free_page(h, head, false);
 		} else {
 			spin_lock_irq(&hugetlb_lock);
-			add_hugetlb_page(h, head, false);
+			add_hugetlb_page(h, head, adjust_surplus);
 			h->max_huge_pages++;
 			spin_unlock_irq(&hugetlb_lock);
 		}
-- 
2.53.0

