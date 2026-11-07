Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047925;
	b=1FpjDqYrAKr20cy9mwvQE223TcYzJPOtBynb61MclR2p4FfaaKc2SM5oQauhHB9HOead
	 joVAv7JPoWPag4381ZYiHNdHfzswEqpoIRq1JA+o6Xgtxn4LdqRl9X2ihO2BdDGjtkvDb
	 Ad2uvPXktyMrfCEx5qwt9KHHeHG8KmRpncwS3YzHA7u6IdOprxXpiVOyVqW2uiliMtjWz
	 uq0waRG+62Bqd3xflCCLRVzFG8oFEw6gjRe1yFe2VjW4QnpQZRqU1rbmIDc80yye9JFAb
	 HsF48C/U+98JZ89tGuy3PX7ikXzguHMEmZ0axDLOyEqEtrIbKVUv7Zcuz20Owevn7pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047925;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=o7ZftctjGu22DP9qV+crXA5DtucyIGP0L5p6zkBJQAo=;
	b=GNT5nPOPNsIziGLrjlF05Cwd3yswip5OHs+mMOsuRQghGC9WxYCuASZbI/2zjXQCqC1H
	 zFakO8mvOv0FYfy3CAs65X8T/OMpM9XlEECCOp5HYl6OsO1U5isIQmVSJ4s90LU75FtzV
	 SrTVFvn+zk+s7WvKOyargAWYL8Gnam7SqRxcB2t9NijC4GLxaEvpLq3Mso2A4mT5vj6YR
	 t9Yzo+0li8ukfwdxpkSh3drNbYS0y7DS/keKoORfe/LTFUHio71XexrKdim6zibGDweKZ
	 HnWmowcJTPQw1gV14WANIxhrHn15Lf0M5OhdWio6y1ViP1XM1oOuthA5jEyuhL6A7jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h3Fb6Prv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF92606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h3Fb6Prv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC8EF1F0089F;
	Sat,  7 Nov 2026 10:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047924;
	bh=o7ZftctjGu22DP9qV+crXA5DtucyIGP0L5p6zkBJQAo=;
	h=From:To:Cc:Subject:Date;
	b=h3Fb6PrvOUu7YgGmUPfwXLv6Z41IpnfPIfdFoH9lBUMthzIw1l5iJOzRdCbYGUjxd
	 aWvrPKl+x8LQX1ApEdok9gUcsOc0H+Spseex6zu9qTExNxFwDucIBH4YEvKkLy065K
	 ogGSUyAPfijR31OLGwCgg1kuJXm0uWn05jCCuZt5nfLM6Dx/Yf2Ttc5A0jVnJx03sM
	 3ASeGa1ySS2W494kdT+qmDS/OSxpZC0+TUUBpMtAU9zbaYFN08rZrhe/+4GIGMPOuc
	 lQXx6eb6d76XJrK+rHqLWE/pi/syoODEjaFfJWdQJmFRMpeHIXSuPDck6yxzqXQrX/
	 AjuYQaWGOySVA==
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
Subject: FAILED: patch "[PATCH] mm/hugetlb: unmap the page where the other VMA maps it" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:38:41 -0500
Message-ID: <20261107053841-failed-6.6-ae99c503eb36@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x ae99c503eb362b42cd5d24d80bc6cba669acc4c2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053841-failed-6.6-ae99c503eb36@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From ae99c503eb362b42cd5d24d80bc6cba669acc4c2 Mon Sep 17 00:00:00 2001
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 15 Oct 2026 18:07:10 +0200
Subject: [PATCH] mm/hugetlb: unmap the page where the other VMA maps it

If the owner of a MAP_PRIVATE hugetlb mapping fails to allocate a page
for CoW, unmap_ref_private() unmaps the old page from all other private
VMAs that have no reservation of their own.  It finds them by the offset
in the file, but then zaps each of them at the address of the faulting
VMA.  Nothing says that another VMA maps the offset at that address: a
child can have moved its copy of the VMA with mremap(), and a second
mapping of the file is wherever mmap() has put it.

So __unmap_hugepage_range() walks the page tables of the other mm at an
address outside of iter_vma, where i_mmap_rwsem of this file protects
nothing and where anything can be mapped, and the page stays mapped where
it really is.

All of the following was seen on v7.3-rc6+ (g6c377d19d4a5) in KVM guests,
as a user without any privilege.  It takes a pool of 2 MiB pages with no
free page that is not reserved, so that the allocation fails: the user
can take or reserve what is free itself.

 - The child moves its VMA away.  The page is never unmapped, the
   mapcount stays 2, and the owner goes round retry_avoidcopy in
   hugetlb_wp() until the child is gone or a page becomes free.  SIGKILL
   to the owner does not end it.  5 of 5 runs.

 - The owner's mm has a second private mapping of the offset, made with
   MAP_NORESERVE.  The owner zaps its own entry and reads zeroes where
   its data was.  5 of 5 runs.

 - The child moves its VMA away and maps a 1 GiB hugetlb page at the old
   address, so this one takes a pool with a 1 GiB page as well.
   huge_pte_offset() for the 2 MiB size steps through the PUD
   leaf, so the "PMD table" is the 1 GiB page itself and its "page table
   lock" is folio->private of that page, which holds 2.  Kernels with
   lock debugging oops in __unmap_hugepage_range(), 7 of 7 runs.  Others
   spin on that word for ever with preemption disabled, 5 of 5 runs:

     watchdog: BUG: soft lockup - CPU#0 stuck for 26s! [u_det3:130]
     RIP: 0010:queued_spin_lock_slowpath+0x8a/0x290
     RAX: 0000000000000002 RBX: ffffea0001000028
     Call Trace:
      __unmap_hugepage_range+0x154/0x6d0
      unmap_hugepage_range+0xc1/0x140
      hugetlb_wp+0x55c/0x700
      hugetlb_fault+0x5f3/0x8f0

   RCU stalls follow, and killing all tasks of the user changes nothing.
   Four such owners, whose children share a single 1 GiB page, took down
   the whole guest with its four CPUs, 2 of 2 runs: one reported soft
   lockups on all four, the other gave no sign of life any more.

   i_mmap_rwsem stays write locked.  With a MAP_PRIVATE mapping of a
   hugetlbfs file that belongs to another user, and that the attacker
   can only read, the next mmap() of that file by its owner sleeps
   uninterruptibly in __mmap_region(), 4 of 4 runs.

Compute the address from the offset for each VMA.  The tree walk returns
only VMAs that cover pgoff, and vm_start, vm_end and vm_pgoff of a hugetlb
VMA are aligned to the huge page size, as pgoff is, so the whole range
lies inside iter_vma.  Its page tables can not go away there, since the
VMA is unlinked from the file under i_mmap_rwsem first.

With the right address the page is unmapped from all VMAs but the
owner's, so the retry in hugetlb_wp() finds a mapcount of 1 and reuses the
page.

A child that has moved its copy of the VMA now loses the page, and gets
SIGBUS when it faults on a missing page of that VMA.  That is what the
comment above the function has always promised to those who do not own
the reservation, and what already happens to a child that has left the
VMA in place.

The address has been wrong from the start, and the second case needs
only mmap() and fork().  mremap() of hugetlb VMAs, which the other cases
use, came with commit 550a7d60bd5e ("mm, hugepages: add mremap() support
for hugepage backed vma") in v5.16.

Original fix generated by an LLM and sent in private by Josef.

[david@kernel.org: switch to vma_filebacked_address, add VM_WARN_ON_ONCE, refine comments]
Link: https://lore.kernel.org/20261015-urgent_fixes-v1-4-42796911043b@kernel.org
Fixes: 04f2cbe35699 ("hugetlb: guarantee that COW faults for a process that called mmap(MAP_PRIVATE) on hugetlbfs will succeed")
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
 mm/hugetlb.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 5db64fa984041..4fca859bbd7ea 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5482,6 +5482,8 @@ static void unmap_ref_private(struct mm_struct *mm, struct vm_area_struct *vma,
 	struct address_space *mapping;
 	pgoff_t pgoff;
 
+	VM_WARN_ON_ONCE(!folio_test_anon(folio));
+
 	/*
 	 * vm_pgoff is in PAGE_SIZE units, hence the different calculation
 	 * from page cache lookup which is in HPAGE_SIZE units.
@@ -5516,10 +5518,17 @@ static void unmap_ref_private(struct mm_struct *mm, struct vm_area_struct *vma,
 		 * could insert a zeroed page instead of the data existing
 		 * from the time of fork. This would look like data corruption
 		 */
-		if (!is_vma_resv_set(iter_vma, HPAGE_RESV_OWNER))
-			unmap_hugepage_range(iter_vma, address,
-					     address + huge_page_size(h),
-					     folio, 0);
+		if (is_vma_resv_set(iter_vma, HPAGE_RESV_OWNER))
+			continue;
+
+		/*
+		 * The address in other VMAs can differ. Even though our old
+		 * folio is anon, we always operate on the underlying hugetlb
+		 * file.
+		 */
+		address = vma_filebacked_address(iter_vma, pgoff, 1);
+		unmap_hugepage_range(iter_vma, address,
+				     address + huge_page_size(h), folio, 0);
 	}
 	i_mmap_unlock_write(mapping);
 }
-- 
2.53.0




