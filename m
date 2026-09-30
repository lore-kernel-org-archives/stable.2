Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327141A268
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 00:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790726642; cv=none; b=CWZ+lJBHOMYlHfZQUT13u42kEvqhTWTWscnR0f8YUJsERpZqgpoiLHLD9FaY6Y5zHKbaw5SrE2DYDGR911buksMukAWcwdJFhr4EtQZJ4FW06/ItfF7RjRTWPeXNAVx+hDsFDjzFKMYso4I3tV1ooSDU+Ow3/U8gZa+Y9FbNBMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790726642; c=relaxed/simple;
	bh=hS4rARMWhhhkbX9PwprRzuXihwx7cNZkypcEw+4Bhcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qX3QhSsRaUW1D0ZzRQLvQSMUCqfjbCXw+cDUt7/ktUC/jbjkv3UzG3RqzvzAS7PCZBJ7OzfnP23ZBefsep60xrwkbKaDLVBCmLG15FiBVYkJZIPnD7TvRK+tmSt6mNlaKbTsUIejLWSOvxkylZWTxZHMaCElS8r69DiqvL7ZLGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMbqLqYC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMbqLqYC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F651F000FF;
	Wed, 30 Sep 2026 00:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790726640;
	bh=k4QKOEZE3uE7+hcy//X5ypJAQ159fNkxD9/I6tWPMVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AMbqLqYClQldUS/Qxj4f2Kd+9rA4lF/D1icjhg9JpWMHpfD0KPytM/GSMYJIQ74VL
	 CMxK+8f3P0NjjW/NowNLuNw9XX/xORWdpKlxhrqz+AeH4iKiQrJO+GEFRqjRyPLVBh
	 09YEQQg5ceiYMLl3Q83QweoVzE1bCXlqZ8H1ghVrtinCtibHvKZZ7mWxmXgj25AvkC
	 JWdAL3m+fgS+2w9WiZlOjeFsE3yqz0ITL7vvNYlxbYyl8b1LY2ALYTLIMwDOsdCX6R
	 F2EQu2NKoTLQns5P/1x3m9NpAUQRqQXS0Xj60Bb+SmxhJheIzVhgWXgnRy1D5c2EIj
	 ZWWPNWcUqWCEA==
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
Subject: [PATCH 6.6.y 1/3] mm/hugetlb: fix surplus pages in dissolve_free_huge_page()
Date: Tue, 29 Sep 2026 20:03:56 -0400
Message-ID: <20260930000358.2861523-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092904-singer-headphone-fefa@gregkh>
References: <2026092904-singer-headphone-fefa@gregkh>
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
Stable-dep-of: a363c62a653c ("mm/hugetlb: do not dissolve gigantic pages without runtime support")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/hugetlb.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index bd8752a5356b7..2b12644e47848 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2303,6 +2303,8 @@ int dissolve_free_huge_page(struct page *page)
 
 	if (!folio_ref_count(folio)) {
 		struct hstate *h = folio_hstate(folio);
+		bool adjust_surplus = false;
+
 		if (!available_huge_pages(h))
 			goto out;
 
@@ -2325,7 +2327,9 @@ int dissolve_free_huge_page(struct page *page)
 			goto retry;
 		}
 
-		remove_hugetlb_folio(h, folio, false);
+		if (h->surplus_huge_pages_node[folio_nid(folio)])
+			adjust_surplus = true;
+		remove_hugetlb_folio(h, folio, adjust_surplus);
 		h->max_huge_pages--;
 		spin_unlock_irq(&hugetlb_lock);
 
@@ -2342,7 +2346,7 @@ int dissolve_free_huge_page(struct page *page)
 			update_and_free_hugetlb_folio(h, folio, false);
 		} else {
 			spin_lock_irq(&hugetlb_lock);
-			add_hugetlb_folio(h, folio, false);
+			add_hugetlb_folio(h, folio, adjust_surplus);
 			h->max_huge_pages++;
 			spin_unlock_irq(&hugetlb_lock);
 		}
-- 
2.53.0

