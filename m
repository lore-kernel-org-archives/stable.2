Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9DD53ECFB;
	Thu, 15 Oct 2026 16:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792080484; cv=none; b=H7jPtn1RbaxXLbgbYQFBr1gEoI2x4AbY5jrqSmhBAm0jZ/RwpOykPC8ZSEagsPDY00aA36cwt8Pxf3xEbFM/sIZa4mv719ZeUMOD7mUBPzanc6Tdou1hDvdQyOsMYqyzo3vjRYMhmqYAHSIaWr8WzfWGbVMFHbdrc0t9mp6Zbb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792080484; c=relaxed/simple;
	bh=79SeBC4+XmuWTh61NJmw5Joul9l+RNS4U0+XJ/nMcHE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DL7ySaj+X9TpGeYF/qfBsOM62UIzjNkxvxs1V6+2p21lAKfZ7nWPTSPvywXsSjfZpvVDFbmZBg9CeagfFuPZF6eL34R0DNxstYJQzzRwI5YWDUods17HD7BB4Zh1MRxi/+IzkdIb268skj5njQzH0Yg0B10/fL2zEZmZDszLagc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jszaSfE6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jszaSfE6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52151F000C4;
	Thu, 15 Oct 2026 16:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792080467;
	bh=tTPYoMFTTDcUOlKvocFSekvL0GWvlMdCBCB0mVspP+0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jszaSfE6JAU7Q5ThVr7+FWwpwsAeeGIgE3q35qW4nu2TEhjPyeR0W92lkSjFmaJ4c
	 a+jFyOA5hVkGt9ZtlWTG4XYFJYvwrpyUM/Nn7f5ODZFagN+iiWe4lET1tgiBZBlvxh
	 zFARwZn5eIqZPmLbUQsoerde49acYIs5NFaBQzTALwkqIwOuF8wXKJu8G41XZECrpd
	 tyTnxQ6hxd+yap1SbXQYxqesFTEVO2uXiQvDx3SJlzrKT9xlduh4gZcyS0rvwjvIBI
	 dhhPsfYYi2BM02toCPKkpqZkaKJTpfh0LxTilM2q3kQiaru3Lt87uHNuqog3xO2EL4
	 RJKVKsOpgYpeQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 15 Oct 2026 18:07:10 +0200
Subject: [PATCH 04/10] mm/hugetlb: unmap the page where the other VMA maps
 it
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-urgent_fixes-v1-4-42796911043b@kernel.org>
References: <20261015-urgent_fixes-v1-0-42796911043b@kernel.org>
In-Reply-To: <20261015-urgent_fixes-v1-0-42796911043b@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Muchun Song <muchun.song@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>, Miaohe Lin <linmiaohe@huawei.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, Adam Litke <agl@us.ibm.com>, 
 Mel Gorman <mel@csn.ul.ie>, Rik van Riel <riel@surriel.com>, 
 Peter Xu <peterx@redhat.com>, "Kiryl Shutsemau (Meta)" <kas@kernel.org>, 
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Josef Bacik <josef@toxicpanda.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>, 
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5795; i=david@kernel.org;
 h=from:subject:message-id; bh=9QOVq0s2+CpnNKu9MuupRapnouHfqvMDPJ5hA3vXoiA=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIu/DKOuipbV7jY5bdE4XK5Dy1RP+e9+pOccpLZSvGJk
 kxGi6xQRykLgxgHg6yYIktQ8H2Dly/X1Va78THDzGFlAhnCwMUpABMJ2sHIsLyIP0Bxws2PJuXp
 P3J/rJQ6PYvl1jKmPXzhb3/zsVmHJzEyvK885ns54BzX4/eFndN5vsj1i6TPv8ohvdLFfPvdhX5
 fWAE=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Josef Bacik <josef@toxicpanda.com>

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

Fixes: 04f2cbe35699 ("hugetlb: guarantee that COW faults for a process that called mmap(MAP_PRIVATE) on hugetlbfs will succeed")
Reported-by: Chris Mason <mason@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[ david: switch to vma_filebacked_address, add VM_WARN_ON_ONCE, refine comments]
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/hugetlb.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 86928d76ef12d..86fafd0782987 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5440,6 +5440,8 @@ static void unmap_ref_private(struct mm_struct *mm, struct vm_area_struct *vma,
 	struct address_space *mapping;
 	pgoff_t pgoff;
 
+	VM_WARN_ON_ONCE(!folio_test_anon(folio));
+
 	/*
 	 * vm_pgoff is in PAGE_SIZE units, hence the different calculation
 	 * from page cache lookup which is in HPAGE_SIZE units.
@@ -5474,10 +5476,17 @@ static void unmap_ref_private(struct mm_struct *mm, struct vm_area_struct *vma,
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
2.43.0

