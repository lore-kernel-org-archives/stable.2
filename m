Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047158;
	b=O5xY6wKDfia64YDOhdwVQ2R2Qs4DLYjTvGGWVMS1ZKJWJ7bw6kmdirnE7+Nr/Tojjcla
	 lXejetwfGYKbUpyP2go7dl7e75HNknMkuJo3lnFjo1JgcfQHtmfRSGecByvUJ87kh2ow3
	 Nep4QGg9gJIrRQfrOLLiVNKsN3RBrM8qzJGI6XMVTa5dWZ4LdaZ84A70z6jgK2vUbM0rR
	 5iJmb6e6vqBaAOV3cClGSqAEBZwSQ9pu95GMS2tQ1igLyl7DJfhv8uSBK70WGhZfacYYx
	 Cq/PGGcyqSfijWKCcRSkvrF3K2L6KZ4fxrVVQM9M0Lo8VgiV28+hVR+C85cOJU3Kg3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047158;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=wCJQ0Mz96yAQiuQJ9MqRXo/5A16qvYJmFgsYRToqwO8=;
	b=CUQhU8FX3S1Go+wab75DjwJY6NPmHyTovGu74asZzhrc8BQww0KKQfW85fKhGFFbz6zi
	 7I/yJG6hAxNT2QYmQBQnmF4VyHLCgulSJC5GaNL0/cdyMZLHRHt98morEWa3uWb64pqbC
	 6CpdfDBVvyyrDFe9KlYuk0kxP1GyYdM4M7BP60T07RmpKJ3Hqa876XbqeKdHuKD2oealF
	 vOyU06jz60fA7f5HaN3yOgrjJxHuXbosCAgRA+dpDpdNsGe7yo2xt1psOm6WGp5yAkziV
	 DXoHukHhp6FCR1W1N50jmz0T5eoggnMjUlnH89jZ51s3YtYNwtOI11MPTT78xdsYiDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mN11Df6Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0B0606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mN11Df6Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F1681F008A1;
	Sat,  7 Nov 2026 10:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047158;
	bh=wCJQ0Mz96yAQiuQJ9MqRXo/5A16qvYJmFgsYRToqwO8=;
	h=From:To:Cc:Subject:Date;
	b=mN11Df6Z8O5XZj/ohMFHbif/OkR5jLp0zQnuuNeRt7kZcL5ZT0N177mX4O/E0xjO6
	 uafOmhqJskgDIA+sz8HT+OOsbs23vKGY1dwMADhsSJlXptjLmiMnbxsNiZWOQYy0Vl
	 KqMAq8dSJ2d7EIWEja+1DJXxBPYhlppih3vbyjKf7S1srmSuFvEZqHQOOlGmf92qgA
	 eG50xMItHaVrpS9BrP5LKrFZERBiHzoKT7xf6E9P/pV4mxu99k8xtaFVHl+Kgj6n49
	 l/Ea1nRQYr1dhPs/CalXIB1+29TgtSlKc/gtST9f3BcC6aBbH8bjD7JZfSTrKyNh6x
	 xSoiUinWLvvbA==
From: Sasha Levin <sashal@kernel.org>
To: josef@toxicpanda.com,
	david@kernel.org,
	akpm@linux-foundation.org,
	mason@kernel.org,
	ljs@kernel.org,
	muchun.song@linux.dev,
	lance.yang@linux.dev,
	liam@infradead.org,
	vbabka@kernel.org,
	jannh@google.com,
	pfalcato@suse.de,
	osalvador@suse.de,
	linmiaohe@huawei.com,
	nao.horiguchi@gmail.com,
	agl@us.ibm.com,
	mgorman@techsingularity.net,
	riel@surriel.com,
	peterx@redhat.com,
	kas@kernel.org,
	rppt@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/hugetlb: don't clear the resv_map of a VMA whose lock is held" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:25:55 -0500
Message-ID: <20261107052555-failed-6.12-d42032c0fe3c@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x d42032c0fe3ca007986c1229128775af0340fbec
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052555-failed-6.12-d42032c0fe3c@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From d42032c0fe3ca007986c1229128775af0340fbec Mon Sep 17 00:00:00 2001
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 15 Oct 2026 18:07:11 +0200
Subject: [PATCH] mm/hugetlb: don't clear the resv_map of a VMA whose lock is
 held

Since commit bf4916922c60 ("hugetlbfs: extend hugetlb_vma_lock to private
VMAs") the lock of a private hugetlb VMA that owns a reservation is the
rw_sema of its resv_map.  The hugetlb_vma_*lock*() helpers find it through
vma->vm_private_data, anew for every lock and every unlock.

At the end of mremap() the old VMA has to let go of the resv_map, which
now belongs to the new VMA: clear_vma_resv_huge_pages() stores NULL into
vm_private_data.  mremap() holds mmap_lock for writing and has write
locked the VMA, which keeps away everybody who comes through the mm.  It
does not keep away those who find the VMA through the file.  For hole
punch and truncation hugetlb_vmdelete_list() does

	hugetlb_vma_trylock_write(vma);		locks resv_map->rw_sema
	unmap_hugepage_range(vma, ...);
						vm_private_data = NULL
	hugetlb_vma_unlock_write(vma);		no resv_map: does nothing

and the rw_sema stays write locked for ever:

  WARNING: lock held when returning to user space!
  mremap_punch/116 is leaving the kernel with locks still held!
  locks held by mremap_punch/116: 1, last CPU#1:
   #0: (&resv_map->rw_sema){+.+.}-{4:4}, at:
                                       hugetlb_vmdelete_list+0x46/0x160

The next fault in the new VMA sleeps in hugetlb_vma_lock_read(),
uninterruptibly, and it holds its entry of hugetlb_fault_mutex_table[].
That table is global, so a fault of any other process on a page that
hashes to the same entry sleeps uninterruptibly as well.

All those who take the lock of a private VMA without taking the mmap/vma
lock are affected: rmap walks. So hold i_mmap_rwsem around the clearing
of the resv_map.

No change of behaviour, other than that mremap() of a hugetlb VMA takes
i_mmap_rwsem once more.

Original fix generated by an LLM and sent in private by Josef.

[david: avoid local variable, move and refine comment, description cleanups+simplifications]
Link: https://lore.kernel.org/20261015-urgent_fixes-v1-5-42796911043b@kernel.org
Fixes: bf4916922c60 ("hugetlbfs: extend hugetlb_vma_lock to private VMAs")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Chris Mason <mason@kernel.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Acked-by: Muchun Song <muchun.song@linux.dev>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: Adam Litke <agl@us.ibm.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Rik van Riel <riel@surriel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Kiryl Shutsemau <kas@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: <stable@vger.kernel.org>
---
 mm/hugetlb.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4fca859bbd7ea..4a7c52802cde5 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7509,6 +7509,15 @@ void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
  */
 void fixup_hugetlb_reservations(struct vm_area_struct *vma)
 {
-	if (is_vm_hugetlb_page(vma))
-		clear_vma_resv_huge_pages(vma);
+	if (!is_vm_hugetlb_page(vma))
+		return;
+
+	/*
+	 * Rmap walks might still find this VMA and take the lock
+	 * inside the reservation map for __vma_private_lock(). Don't clear
+	 * the reservation map while that is possible.
+	 */
+	i_mmap_lock_write(vma->vm_file->f_mapping);
+	clear_vma_resv_huge_pages(vma);
+	i_mmap_unlock_write(vma->vm_file->f_mapping);
 }
-- 
2.53.0




