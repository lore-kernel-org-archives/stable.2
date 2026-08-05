Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B360472777
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 13:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785937521; cv=none; b=YGYwDwfwFiKyImzZGT312B0aKRPRHMOCkcypLBAF4jF2L7p+GLB5AE4yDHQpVEkrVO7cPE9dUIVMPIQzL8zIgJpcWw+2ceM/Jl3AKRnD7spb/UHg8EOp8isMcEOHYniKrPX/DpKfV1D9XwiNPIWWcwljdqrpsy2aqmyLu4RD/cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785937521; c=relaxed/simple;
	bh=QB1cpRLuXJjqKtRYT47qMTpI9a/LaqdPz0pJEK8tP+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RKOhZ47xY+PAKp961o4AbhaiKgvrk7RtSNeKYzNJfZfhClKVJDiyCpGjZFjh4avpkA6kGOXavoEfB92QDQ4povExpZqMcXMsV5cqvkihWr12T/dR6MrLuL26t+64d+2TPT2aEz8tZfeYkLEi5lPlSnrZhHLAeHRfC1jYoRleUok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=ueLx0ADu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GgRxC7V1; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="ueLx0ADu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GgRxC7V1"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 7C4021D001A0;
	Wed,  5 Aug 2026 09:45:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 05 Aug 2026 09:45:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1785937518; x=
	1786023918; bh=tS7rf/ZTIYL5Zavd9Xgl3dYGyBAVCylw8v2WwOy6LkQ=; b=u
	eLx0ADupPmlxVTNXnExvOoZCGOYbAN23rtfiwNtMTRsGqNOAAgsFniQxxDe+umtq
	tZ6W0/qvaKnYSYPfV/Cke+Pb4eawlOCZ8WfrXguQ5Q5dMd00pXy9JzQJlCh+u4dn
	MVD1abmnYRlHm9A3tMKKhCRLVZxN2usS1H58XVcRoD55mJV8VaQ4uZcyq2d8wSdA
	xCC64FWqmfOEaiW7z9u86zqvXBDRZzzUBYdgBLpzQlw3pIJQdvPUgWKmIGFDtHVn
	ai7Ef+CYGV6/GJ/sGuJHBNqDALBn1UHPW72bDqDU4zKeVrqZBci8edqR4jv9YmvC
	7LTthaeaNY56fVK4OqABw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1785937518; x=1786023918; bh=t
	S7rf/ZTIYL5Zavd9Xgl3dYGyBAVCylw8v2WwOy6LkQ=; b=GgRxC7V1yEAqZutLK
	POjFUUZsrcWok6y924AFgVk0tnDa0zS33UYD4+1Zey83394+sSG9L0OmVDsmS8Q3
	7jZdS/AvhS/FQ7YrKtM9paFHxlEvy0Cwa1ECDO+/dPtJ406HBsLWgXuN3NETC6ES
	IQr7c1Q3RXbYn/nQxpPO+ZaT31C5XuI2tB8GP0mEtJio6+1lKI0l2lKBrVWyEwMg
	DzAgTfOEnMSaOIeH9rJYUUaHigStgh5OzpBj48jreXMtblQ8DcQauvXZhRE6kfcF
	pF9wose4XYKcOB4wpwuctu6B4L4Xyoz90cx9WZWcZzjKgsjcr2HxjYfMoUpIeITY
	XZLEQ==
X-ME-Sender: <xms:bj5zaq2lJvujDJe--gydjl5xEVJWaO0VcBhoHkrnL4SptKCUOguZbA>
    <xme:bj5zakrIW8Att3E-3lbEo1a-r9BY7x-41NNXkQgGwyEMRK4MwxrcO2rwHjH7zziS_
    Ul_BvQXnHjEqLQJqgav0gCzCllDIgt9qvKneW2WEYelM98kXhMd_gk>
X-ME-Received: <xmr:bj5zaijO6Ucm-h19E0vS77tB1-xdLjsE9Pv248i7b044DewkPAPYCCUY93E>
X-ME-Proxy-Cause: dmFkZTG1WIpnwM6A2sPO3HW6iewaMW0/4+TIO4pPW2/uwk56ZS/KPGy+yCjQkbNgzwh7Dp
    HrFVyO8q+vRyzbuXZLx4ZRNdZlygKdksCAnT2d5WtZfp1EGqKHqXXY68pfaGDxhE3dklMX
    TAItLC6QVDs7gHnCdninbx2GUIg9faOUQgcAyVlYeb3GL2FkhRp9zdX5+sJFUzDKsIUexX
    d/fBcZz4muK+gxc/eqNUsc8j9ithciCVa/syXRp5lhqb1XYp7wY+9gTs5ep+/4gS/N+UE9
    oY9owczXJOYyfWKvy8k+p8Txt2Q9mTdynEji7MrCnD75ivAmp9W4kvVpwWuKOO6Oog1Ajl
    lbv0Tq8hpAVbjec2u4q+JthySK4ZqmY7VUYjz+oP19d2T2QPVZfiPxjqe4opaIYSY7SFCP
    u5BzNSk7MNJOEB3QOL9YSmhKkihRtAHJz8e6Uj3aOAJtEBBH79QqVN6TvCULJW9Dqm5Ar8
    sbz/wUuGs5AhBQCR9FEWHD2tUg6XLIzkFDA5oxv77vRHVoXZuWlT68gt56bnfBJDiYmh6Y
    JO1d9vybVH+w/i+DF0i6bRlQXHdzpn7x2oQlFxOIiy4a/wA42MGkofnr32IzNmMUDpWGlM
    0sjEU+ZqQmqUpYBirHmH4IUiJ1c03EZB+kigpxr56ZeUfBdray0pxaXdrjHA
X-ME-Proxy: <xmx:bj5zaokWWB4Of1pvxMQOMQNxfrBzsRD6IjRrxS8wRTMQ6zTIvRF6zQ>
    <xmx:bj5zajo2Xrieqhk7ZEtrCFlyaNO0o54J13rMmT_SAvMAQXnY_BwY6A>
    <xmx:bj5zasJw000V_NzTZVL63y46F250vF-DGdO3qvk5SV0eN-hhSXVVxg>
    <xmx:bj5zanBqKb_-WK8CDg_BKnPEsO6gOFBEdKv0PncqtoMigN-J3rDKAQ>
    <xmx:bj5zaiyy8Cjs43jVfNOolONPydTa5sW7BwiCcOeZEHJVdIEh2H2-Rt8R>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 09:45:17 -0400 (EDT)
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
Subject: [PATCH 6.1.y] mm/huge_memory: unlock i_mmap_rwsem before releasing after-split folios
Date: Wed,  5 Aug 2026 14:45:16 +0100
Message-ID: <20260805134516.2776849-1-kirill@shutemov.name>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026080503-fender-retold-01fb@gregkh>
References: <2026080503-fender-retold-01fb@gregkh>
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
[ kas: adapt to the __split_huge_page()/split_huge_page_to_list()
  two-function split: pass @mapping into __split_huge_page() and drop it
  there, before the loop that frees the after-split subpages while the
  head is still locked; the caller then skips its own i_mmap unlock ]
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 mm/huge_memory.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 7023bdf48960..153f06e42866 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2516,7 +2516,7 @@ static void __split_huge_page_tail(struct page *head, int tail,
 }
 
 static void __split_huge_page(struct page *page, struct list_head *list,
-		pgoff_t end)
+		pgoff_t end, struct address_space *mapping)
 {
 	struct folio *folio = page_folio(page);
 	struct page *head = &folio->page;
@@ -2594,6 +2594,16 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 		split_swap_cluster(entry);
 	}
 
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
 	for (i = 0; i < nr; i++) {
 		struct page *subpage = head + i;
 		if (subpage == page)
@@ -2774,7 +2784,9 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 			}
 		}
 
-		__split_huge_page(page, list, end);
+		__split_huge_page(page, list, end, mapping);
+		/* __split_huge_page() dropped the i_mmap lock */
+		mapping = NULL;
 		ret = 0;
 	} else {
 		spin_unlock(&ds_queue->split_queue_lock);
-- 
2.54.0

