Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8421B472F74
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 13:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785937531; cv=none; b=RChTaO+BOdL3XHTAZDPz93vU2APrIzXmL3jupBh1Qei73n164gbLc9JdNQRYkRGZLxxlzJ/hv6iZCsns8Jd3TYdEu8dAV5KFVIF04+htTShvSt812SDlzsqkm44Erj+5OT9DARm9l5EfBqLgmVRqfKd8A73Vk8OIOp7h//v1/70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785937531; c=relaxed/simple;
	bh=u2Kx0RhAUDnPEcJhKxcV+bWnXBAi5xhAZ3N06mrgyfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NXMzoonuJFW/Bkx+XH/b+M7vJqINEROI/8Gk567b+ZPMPJCbYBJEWK0lOrZLMSfdg3MwmSVotVEguQRc0+82uJZZfEqWRrNL1M0nWeDd7Zlk26pvpQJBwiGsw6AZxn0pCUYDFvU4Al0tCHw1UT8eREGGsbStG0hnGQUWNhoxm2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=X1Zb/gZ8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=beYq8jH3; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="X1Zb/gZ8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="beYq8jH3"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 346817A013F;
	Wed,  5 Aug 2026 09:45:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 05 Aug 2026 09:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1785937525; x=
	1786023925; bh=grefnCB3cp+zyoXZl52l1EW6RlEhnRnn5oKZvwSrZns=; b=X
	1Zb/gZ8OdD9nuyxpphH3e71TxClu/bAf444NXSeULFwYpeqBOjlz/Tf51ODGrHQ1
	WW+0wRChy4yi+05Qhxqg9VxD59i2q5FRGuZ2RJfx31oQxmCx3/MoiosX4WfMX2zr
	huipE1LXHVzwcnNz/DgExyNx+DCY7c5C08OrthBlkcoJuzWTsBrEB1/gjvb8C8pt
	gzOr5ihow06/yduwd/M0QuF2eAW/bO/nvTrSaoaEGwe//RJXgU3nb+S0Ell0UBCO
	9JfUy/l0n0lrPMlV4EgWhMIbZZcGCkoGCyE7DbXQu3QE6/G3ITlHjXn7eQpap+ts
	sXwmlkjxmC39sa21e5+yA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1785937525; x=1786023925; bh=g
	refnCB3cp+zyoXZl52l1EW6RlEhnRnn5oKZvwSrZns=; b=beYq8jH3P6yCpHNKp
	bhM6sm6TZx6mzlZ6wYmhXQLb+kcCCxlureQwi/s0ms0GbKmDr53xVTj8D48CHsdr
	14v/nCclkirlXXwKZXgtmJ6szp4DR2s+abxin+WqWua9JAHGyk4LKzcylG3s+2NF
	asY18AIHwTCAP4iGYO9IUbx9xooz5CjrveHeLGqcw4DvK83wBqN+KlW0ex51hw25
	0sBkLtj0ket2rksF7PxiUbJjp/nhACRdLhOUj8jiA9KmV56zsWHH667Po5fWP1VO
	u3hSs/k+XJF2wfEpy3B1PVQtUkD6WEXvhg8Yz67ewBQhIgGjA5mtewfkAn0Fy76c
	39cIw==
X-ME-Sender: <xms:dD5zaiDxFAXqXzEfOc1bsBFsS8CtRhpny0O5Tz8URg7cEwxEGLC2Hw>
    <xme:dD5zakE6n1r67P84-oD9KhhPIx_Wu2xA0IXMpgPFGvCSY52WAq8IuO_MflSj14RSL
    jwZq2sAAOajffo018VItgmyzhGCN5s6t4BAm7V4wZi92FGqGE332AQ>
X-ME-Received: <xmr:dD5zalM-udCFf_oTQ1rIQSGPackP03vu2Fssj-vIQMu42tebORDqOvn3eM0>
X-ME-Proxy-Cause: dmFkZTGu97oI3pYUVfgfNzZrxwJPnm31USpJCOdyBwkzfqtZM+L3TiAQtP0rjGZJjYLOo4
    xWk0E7hNrOhKUloXiU8avxmSlRI2RGeRD1/gTEgVPaTUC1zaE4cMasb614gbRm8XXQZ50k
    xJgTwN1tyHXL089IzbJD2G8OjM6Gw0/sLqfvD74RKaaTgnpAVfEpa8hs2Cg2CXKf/pEADq
    4dnZB1dJz2axtJ7K25RLDyG5EULynjrVLDHVcyQACiXg2X7iZaun9E9RiUpaaHyarugFxH
    BcSZfbgRifuCSc+ehaiasTAbhZQS9sm29EkhCmls1Um4jDGdwXgfvWukq5LCWU5r4dUPUk
    p/JOmvJmI8gZBbJL058uipMG53iKbT5QtdVq0lblL4R4/kQ3lAMqR8n5KltbHVLqGKIIW0
    AAMItzLjFXTcybDE4kd50l8TYNYWeyAkgHmc6SOWWQt5XX6tei1Hwh/eFp5/qp8GI9420V
    mfvOajj6hASk0w3520qaAg5hipI6O6WL9AzPril/MwGpFyyKNKbPMo1oHhwuuhNZAEiuZ4
    0n58qKMAhCBO82R/vIXwmycid6LBCzrb9VKJaQB5xsNJ9sqyqL9KPRRVPQ7RzZIiVdui8U
    8CAE5IJTn0wrJi+gDBzgmGWqz62tILN7L7wl+r2oVJbiQMexYuy2XGziJYCg
X-ME-Proxy: <xmx:dD5zath6FW-J3riOLGHnzgPRVAw_Iy06h7fcmNm07Vu4TaRb1hQUMQ>
    <xmx:dD5zat3l9DtqUpssFOEMi-a3ND3fHF0utIzvBzgTy1EMUYhaVSRYGA>
    <xmx:dD5zaimrDPsBqdeoRD23jSCkckSkym8_ftjAYDoBDkFQCq5B9bqVZg>
    <xmx:dD5zakvS8xPmUugKfKt01Pdwd2wKY5tc98vDfF8c3kuQhL83r_vn5Q>
    <xmx:dT5zam9ozx60iqS7y8K5_lteQZ6iXU3ACZRPmUD_ckqXXbLxwkvNuo_T>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 09:45:24 -0400 (EDT)
From: Kiryl Shutsemau <kirill@shutemov.name>
To: stable@vger.kernel.org
Cc: "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Hao Zhang <zhanghao1@kylinos.cn>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Barry Song <baohua@kernel.org>,
	Dev Jain <dev.jain@arm.com>,
	Lance Yang <lance.yang@linux.dev>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.12.y] mm/huge_memory: unlock i_mmap_rwsem before releasing after-split folios
Date: Wed,  5 Aug 2026 14:45:22 +0100
Message-ID: <20260805134522.2776869-1-kirill@shutemov.name>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026080501-landmark-crabgrass-7664@gregkh>
References: <2026080501-landmark-crabgrass-7664@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>

__folio_split() keeps dereferencing the mapping after the split:
shmem_uncharge(mapping->host) and remap_page() while the folios are still
frozen/locked, and i_mmap_unlock_read(mapping) at the very end, after the
after-split folios have been unlocked and freed.

Nothing holds an inode reference across that.  The split relies on @folio
-- which the beyond-EOF drop loop never removes, as it starts at
folio_next(folio) -- staying locked and in the page cache to hold off
eviction.  But the unlock loop unlocks @folio before i_mmap_unlock_read()
runs.  If the caller's @lock_at is a tail beyond EOF, as memory_failure()
passes when splitting a poisoned tail of a shmem THP that reaches past
i_size during truncation, it too is gone from the page cache; so once
@folio is unlocked no locked, in-cache folio pins the inode, and a
concurrent final iput() can evict and RCU-free it before
i_mmap_unlock_read() touches i_mmap_rwsem:

  BUG: KASAN: slab-use-after-free in __up_read+0x634/0x790
   i_mmap_unlock_read include/linux/fs.h:537 [inline]
   __folio_split+0x732/0x1640 mm/huge_memory.c:4100
   try_to_split_thp_page+0xab/0x390 mm/memory-failure.c:1675
   memory_failure+0x1394/0x26e0 mm/memory-failure.c:2470

  Freed by task 4601:
   shmem_free_in_core_inode+0x54/0xb0 mm/shmem.c:5177
   evict+0x57f/0xac0 fs/inode.c:870

Do every mapping dereference while @folio still pins the inode: drop
i_mmap_rwsem right after remap_page(), before the loop that unlocks and
frees the after-split folios, and clear @mapping so the exit path does not
unlock it again.  shmem_uncharge() and remap_page() already run before
that point, so after this nothing past the unlock loop touches the inode
or the mapping.

This is now a rule the split depends on, alongside keeping @folio frozen
until the page cache is updated: no inode or mapping dereference once the
after-split folios start being unlocked.

Link: https://lore.kernel.org/20260716095424.471052-1-kirill@shutemov.name
Fixes: baa355fd3314 ("thp: file pages support for split_huge_page()")
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reported-by: Hao Zhang <zhanghao1@kylinos.cn>
Closes: https://lore.kernel.org/linux-mm/20260710071344.GA106129@zh-pc
Co-developed-by: Hao Zhang <zhanghao1@kylinos.cn>
Signed-off-by: Hao Zhang <zhanghao1@kylinos.cn>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: Nico Pache <npache@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

(cherry picked from commit e923bd21058ea02fd0dcd3549d151d143fd036e5)
[ kas: adapt to the __split_huge_page()/split_huge_page_to_list_to_order()
  two-function split: pass @mapping into __split_huge_page() and drop it
  there, before the loop that frees the after-split subpages while the
  head is still locked; the caller then skips its own i_mmap unlock ]
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 mm/huge_memory.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index e60c21b92464..b2daa1767d90 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3206,7 +3206,7 @@ static void __split_huge_page_tail(struct folio *folio, int tail,
 }
 
 static void __split_huge_page(struct page *page, struct list_head *list,
-		pgoff_t end, unsigned int new_order)
+		pgoff_t end, unsigned int new_order, struct address_space *mapping)
 {
 	struct folio *folio = page_folio(page);
 	/* Scan poisoned pages when split a poisoned folio to large folios */
@@ -3303,6 +3303,16 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	if (new_order)
 		page = compound_head(page);
 
+	/*
+	 * Drop the mapping while the head page is still locked and thus pins
+	 * the inode. The loop below may free the after-split subpages --
+	 * including the head, when @page is a tail beyond EOF that the split
+	 * dropped from the page cache -- which could otherwise let the inode,
+	 * and @mapping, be freed before this unlock.
+	 */
+	if (mapping)
+		i_mmap_unlock_read(mapping);
+
 	for (i = 0; i < nr; i += new_nr) {
 		struct page *subpage = head + i;
 		struct folio *new_folio = page_folio(subpage);
@@ -3580,7 +3590,9 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 			mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
 			mod_mthp_stat(new_order, MTHP_STAT_NR_ANON, 1 << (order - new_order));
 		}
-		__split_huge_page(page, list, end, new_order);
+		__split_huge_page(page, list, end, new_order, mapping);
+		/* __split_huge_page() dropped the i_mmap lock */
+		mapping = NULL;
 		ret = 0;
 	} else {
 		spin_unlock(&ds_queue->split_queue_lock);
-- 
2.54.0

