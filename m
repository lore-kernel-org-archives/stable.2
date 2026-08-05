Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523383C2B8D
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 11:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785930531; cv=none; b=qHGVpQo1JaVkfNIKcowUwbGQ0/IhJdvmewK4zC15fTer3nuOZw2itkd9rHcJkuGzmBU1O0dP73m5X1xOdTZtYzQv3nbOq2h5N9BtCbKMnKDuiLOvI8Xh5qIbu7mZcP/7Jwktn5ZQcTxDKqTyrqxcQzuNWAXsScUaKrBVsLWWoLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785930531; c=relaxed/simple;
	bh=fwQig3CHw+LW7DjLLAE0lXEBBqpwUuY2/9MMPV1jySs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SZufaJylp8yZUp7Pc6Ny/PoHSfGWabB6rM5lnb0lE4zjBN4aOw3wlcdCYNwky85R17IfQ1Ti6vASBhakjm9vx4i+Mv/CuoQ+gm/HNZ8c30CpNlo+qv0KtpOUu33hzFGotAs05swiqGL7yBS7BWzYRx50oQ5+KYF+a5RsjnAbz7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NHAIB0l8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NHAIB0l8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66ED71F000E9;
	Wed,  5 Aug 2026 11:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785930529;
	bh=W0bqptKYRFtWuv6rQQqNqHtZnAW+DqBpx4R9XJgwVq0=;
	h=Subject:To:Cc:From:Date;
	b=NHAIB0l8AV9H5Pz3pknd2gMJr16IkDfM05l+ECOgrFT4/gDBJ1XN3zLkJmFNCmquj
	 /LDMikFUO10DzdgdRdyhX/vQl/4ceZyhRDKn9eoARNwx6yJZwS2GIc4IeIrECBKwom
	 XNaTprxYFqdaH9R79RiOGRTn8WTV1TqgXDii0KXI=
Subject: FAILED: patch "[PATCH] mm/huge_memory: unlock i_mmap_rwsem before releasing" failed to apply to 5.15-stable tree
To: kas@kernel.org,akpm@linux-foundation.org,baohua@kernel.org,baolin.wang@linux.alibaba.com,david@kernel.org,dev.jain@arm.com,lance.yang@linux.dev,liam@infradead.org,linmiaohe@huawei.com,ljs@kernel.org,nao.horiguchi@gmail.com,npache@redhat.com,ryan.roberts@arm.com,stable@vger.kernel.org,zhanghao1@kylinos.cn,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 13:47:03 +0200
Message-ID: <2026080503-upbeat-facility-22c2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x e923bd21058ea02fd0dcd3549d151d143fd036e5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080503-upbeat-facility-22c2@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e923bd21058ea02fd0dcd3549d151d143fd036e5 Mon Sep 17 00:00:00 2001
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Date: Thu, 16 Jul 2026 10:54:24 +0100
Subject: [PATCH] mm/huge_memory: unlock i_mmap_rwsem before releasing
 after-split folios

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

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 032702a4637b..58cabe6af33d 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4113,6 +4113,18 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 
 	remap_page(folio, 1 << old_order, ttu_flags);
 
+	/*
+	 * Drop the mapping while the inode is still pinned. @folio stays
+	 * locked and present in the page cache until the loop below, so
+	 * eviction cannot free the inode yet; @lock_at is not enough, it may
+	 * be a tail beyond EOF that the split already dropped from the page
+	 * cache. Nothing past this point may touch the inode or the mapping.
+	 */
+	if (mapping) {
+		i_mmap_unlock_read(mapping);
+		mapping = NULL;
+	}
+
 	/*
 	 * Unlock all after-split folios except the one containing
 	 * @lock_at page. If @folio is not split, it will be kept locked.

