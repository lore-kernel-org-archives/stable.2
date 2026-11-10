Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272961;
	b=SjJfn/M8kpJwSwWlB993MR4TQzJy6ru6S/YkTC6iHgACAAXns6EDrBPPUQty8r5a0lYf
	 400zOr/HRh2kPBXNtqrjS1oFiSXpffDxgLfj5y3DcnKcLXr4+KgeUnZ0UYeYH9o23iJR6
	 CF2YJmSzgF0EFyyUCGpf2OQtO4i7BJ69JgCXHmQ9LZ0QrJOukBG3FBY/EWplk3caeB0k0
	 ymA2iUN8DeldICdL/T/gfDq+3/LVe0g97LYOOn06EP5gXrzixShMrqga1vrYzJdB/ofrm
	 RaukpRENTzmy1KcxhOLM2C6UZ85Nzl/kqexgJJgA0Q+B2iwkeQZzeFWfzK3xK8rn+aQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272961;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Rq1cfa7ubX+RTkicEK+Gt8MRV4XqgB73uqYzMqLllNc=;
	b=CNduT2cjEcLvoJGdqPBF2HeHYovQ23+BY8FmLOpOJS9cLLn7w1kd5Dxjctr6C6tRGhUx
	 SQ1oZYp+sjqp03QBdRPNDFnFkMnV//E1Zap01VZIbotU5VIK68qv7CkaNu799KDFcW1U7
	 8PDPiWs58sCJM6srLTU2nFouUTNM/4HtHMj+3iyP4pX/Rj9D5TTKnoFcZZy7pAyuQiRcF
	 llTMJEl0xG8G1jCmSm9zchRs3Pv2TVF6WLToHFreqW+qmLmkV+sQWHxq1WjqxVQDW7sH8
	 Nj1zQwyQ2/E/+/6x1ruhV60uTG/oqglcXYfVR1X1eTXxWmxwx4+RY69UpaZUsAktuzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kOlVy65h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3C0606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kOlVy65h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA6711F0089F;
	Tue, 10 Nov 2026 01:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272960;
	bh=Rq1cfa7ubX+RTkicEK+Gt8MRV4XqgB73uqYzMqLllNc=;
	h=From:To:Cc:Subject:Date;
	b=kOlVy65h49YYcOwKSsRdz4IUceqKXfIvTL+lSNJFyckhZqVpHpk2aap4B9MOw0+qe
	 OiVDgkXX9YgO/KNNGpgKPXs+0ikwaoKfSDM/TXLyRP+EZ8qZZyffY6XS4ZCi17L4gx
	 uxmCipkrdCU3mxkKIh6lFJxJCCyEhK58tj8QbMnoWzXdN2GS+o/F1U39q8IxxqdyJ5
	 Sdq5D/CAS8RbstRTkyvgxbgm3utdSlj6XVYs0SZmsXBLY022IELKQxOPyq7HEc08Wi
	 gGzZXcpZ2YT2oK/73q+S+JOYQR+ifb2YDOlV/qsJVq8gzAh6pkvo3GE5FXW5g2hyV/
	 efVryxyfw253g==
From: Sasha Levin <sashal@kernel.org>
To: mason@kernel.org,
	ljs@kernel.org,
	muchun.song@linux.dev,
	usama.anjum@arm.com,
	lance.yang@linux.dev,
	david@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm: fix deadlock of mremap() against UFFDIO_MOVE" failed to apply to 6.12-stable tree
Date: Mon,  9 Nov 2026 20:09:18 -0500
Message-ID: <20261109200918-failed-6.12-d03df42ddae1@kernel.org>
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
git cherry-pick -x d03df42ddae196f20e9cfb775704e60269eb6b44
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200918-failed-6.12-d03df42ddae1@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From d03df42ddae196f20e9cfb775704e60269eb6b44 Mon Sep 17 00:00:00 2001
From: Chris Mason <mason@kernel.org>
Date: Sat, 31 Oct 2026 10:40:07 +0100
Subject: [PATCH] mm: fix deadlock of mremap() against UFFDIO_MOVE

With per-VMA locks, UFFDIO_MOVE can run concurrently with mremap()
on different VMAs in the same mm. Those VMAs can share page tables, so
both operations can acquire the same pair of page-table locks.

UFFDIO_MOVE orders the locks by address, while mremap() takes the source
lock first. These conflicting orders can deadlock; mremap() holding
mmap_lock for writing no longer helps.

Move double_pt_lock() and double_pt_unlock() to mm/internal.h and use
them for all page-table moves in mremap(). Preserve the source entry
checks after acquiring both locks. Remove the comments claiming that
exclusive mmap_lock makes lock ordering irrelevant.

In move_ptes(), make sure to just recheck source and destination PMD
after taking the locks and drop the overly-long comment.

Fix generated by an LLM and sent by Chris Mason in private.

[ david: use new helpers consistently; simplify description and comments;
         move_ptes() fixup ]

Fixes: 867a43a34ff8 ("userfaultfd: use per-vma locks in userfaultfd operations")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Acked-by: Muchun Song <muchun.song@linux.dev>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Link: https://patch.msgid.link/20261031-fixes_core-v3-38-d6437171ecc3@kernel.org
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/linux/userfaultfd_k.h |  2 -
 mm/huge_memory.c              | 19 +++-----
 mm/hugetlb.c                  | 14 ++----
 mm/internal.h                 | 28 +++++++++++
 mm/mremap.c                   | 87 ++++++++++++++---------------------
 mm/userfaultfd.c              | 27 -----------
 6 files changed, 72 insertions(+), 105 deletions(-)

diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index a14b8a9ffb7b1..565e98f342dc8 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -153,8 +153,6 @@ extern int mrwprotect_range(struct userfaultfd_ctx *ctx, unsigned long start,
 			    unsigned long len, bool enable_rwp);
 
 /* move_pages */
-void double_pt_lock(spinlock_t *ptl1, spinlock_t *ptl2);
-void double_pt_unlock(spinlock_t *ptl1, spinlock_t *ptl2);
 int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd, pmd_t dst_pmdval,
 			struct vm_area_struct *dst_vma,
 			struct vm_area_struct *src_vma,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 75b09a06edb2f..f10a199548d8f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2646,15 +2646,11 @@ bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 		return false;
 	}
 
-	/*
-	 * We don't have to worry about the ordering of src and dst
-	 * ptlocks because exclusive mmap_lock prevents deadlock.
-	 */
-	old_ptl = __pmd_trans_huge_lock(old_pmd, vma);
-	if (old_ptl) {
-		new_ptl = pmd_lockptr(mm, new_pmd);
-		if (new_ptl != old_ptl)
-			spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
+	old_ptl = pmd_lockptr(mm, old_pmd);
+	new_ptl = pmd_lockptr(mm, new_pmd);
+
+	double_pt_lock(old_ptl, new_ptl);
+	if (likely(pmd_is_huge(*old_pmd))) {
 		pmd = pmdp_huge_get_and_clear(mm, old_addr, old_pmd);
 		if (pmd_present(pmd))
 			force_flush = true;
@@ -2683,11 +2679,10 @@ bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 		set_pmd_at(mm, new_addr, new_pmd, pmd);
 		if (force_flush)
 			flush_pmd_tlb_range(vma, old_addr, old_addr + PMD_SIZE);
-		if (new_ptl != old_ptl)
-			spin_unlock(new_ptl);
-		spin_unlock(old_ptl);
+		double_pt_unlock(old_ptl, new_ptl);
 		return true;
 	}
+	double_pt_unlock(old_ptl, new_ptl);
 	return false;
 }
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index da5d04edf7c10..84141527fe73d 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5153,15 +5153,9 @@ static void move_huge_pte(struct vm_area_struct *vma, unsigned long old_addr,
 	spinlock_t *src_ptl, *dst_ptl;
 	pte_t pte;
 
-	dst_ptl = huge_pte_lock(h, mm, dst_pte);
+	dst_ptl = huge_pte_lockptr(h, mm, dst_pte);
 	src_ptl = huge_pte_lockptr(h, mm, src_pte);
-
-	/*
-	 * We don't have to worry about the ordering of src and dst ptlocks
-	 * because exclusive mmap_lock (or the i_mmap_lock) prevents deadlock.
-	 */
-	if (src_ptl != dst_ptl)
-		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
+	double_pt_lock(dst_ptl, src_ptl);
 
 	pte = huge_ptep_get_and_clear(mm, old_addr, src_pte, sz);
 
@@ -5190,9 +5184,7 @@ static void move_huge_pte(struct vm_area_struct *vma, unsigned long old_addr,
 		set_huge_pte_at(mm, new_addr, dst_pte, pte, sz);
 	}
 
-	if (src_ptl != dst_ptl)
-		spin_unlock(src_ptl);
-	spin_unlock(dst_ptl);
+	double_pt_unlock(dst_ptl, src_ptl);
 }
 
 int move_hugetlb_page_tables(struct vm_area_struct *vma,
diff --git a/mm/internal.h b/mm/internal.h
index 566cbd2dce485..824c2919a37fd 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -624,6 +624,34 @@ static inline void force_page_cache_readahead(struct address_space *mapping,
 	force_page_cache_ra(&ractl, nr_to_read);
 }
 
+/*
+ * Take two page table locks at the same level in address order such that
+ * we cannot deadlock.
+ */
+static inline void double_pt_lock(spinlock_t *ptl1, spinlock_t *ptl2)
+	__acquires(ptl1)
+	__acquires(ptl2)
+{
+	if (ptl1 > ptl2)
+		swap(ptl1, ptl2);
+	spin_lock(ptl1);
+	if (ptl1 != ptl2)
+		spin_lock_nested(ptl2, SINGLE_DEPTH_NESTING);
+	else
+		__acquire(ptl2);
+}
+
+static inline void double_pt_unlock(spinlock_t *ptl1, spinlock_t *ptl2)
+	__releases(ptl1)
+	__releases(ptl2)
+{
+	spin_unlock(ptl1);
+	if (ptl1 != ptl2)
+		spin_unlock(ptl2);
+	else
+		__release(ptl2);
+}
+
 unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start,
 		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices);
 unsigned find_get_entries(struct address_space *mapping, pgoff_t *start,
diff --git a/mm/mremap.c b/mm/mremap.c
index 1237718848f5c..70b7264aa6bf5 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -202,7 +202,7 @@ static int move_ptes(struct pagetable_move_control *pmc,
 	struct mm_struct *mm = vma->vm_mm;
 	pte_t *old_ptep, *new_ptep;
 	pte_t old_pte, pte;
-	pmd_t dummy_pmdval;
+	pmd_t old_pmdval, new_pmdval;
 	spinlock_t *old_ptl, *new_ptl;
 	bool force_flush = false;
 	unsigned long old_addr = pmc->old_addr;
@@ -234,31 +234,30 @@ static int move_ptes(struct pagetable_move_control *pmc,
 	if (pmc->need_rmap_locks)
 		take_rmap_locks(vma);
 
-	/*
-	 * We don't have to worry about the ordering of src and dst
-	 * pte locks because exclusive mmap_lock prevents deadlock.
-	 */
-	old_ptep = pte_offset_map_lock(mm, old_pmd, old_addr, &old_ptl);
+	old_ptep = pte_offset_map_rw_nolock(mm, old_pmd, old_addr, &old_pmdval,
+					    &old_ptl);
 	if (!old_ptep) {
 		err = -EAGAIN;
 		goto out;
 	}
-	/*
-	 * Now new_pte is none, so collapse_scan_file() path can not find
-	 * this by traversing file->f_mapping, so there is no concurrency with
-	 * retract_page_tables(). In addition, we already hold the exclusive
-	 * mmap_lock, so this new_pte page is stable, so there is no need to get
-	 * pmdval and do pmd_same() check.
-	 */
-	new_ptep = pte_offset_map_rw_nolock(mm, new_pmd, new_addr, &dummy_pmdval,
-					   &new_ptl);
+	new_ptep = pte_offset_map_rw_nolock(mm, new_pmd, new_addr, &new_pmdval,
+					    &new_ptl);
 	if (!new_ptep) {
-		pte_unmap_unlock(old_ptep, old_ptl);
+		pte_unmap(old_ptep);
+		err = -EAGAIN;
+		goto out;
+	}
+
+	double_pt_lock(old_ptl, new_ptl);
+	if (unlikely(!pmd_same(old_pmdval, pmdp_get_lockless(old_pmd)) ||
+		     !pmd_same(new_pmdval, pmdp_get_lockless(new_pmd)))) {
+		double_pt_unlock(old_ptl, new_ptl);
+		pte_unmap(new_ptep);
+		pte_unmap(old_ptep);
 		err = -EAGAIN;
 		goto out;
 	}
-	if (new_ptl != old_ptl)
-		spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
+
 	flush_tlb_batched_pending(vma->vm_mm);
 	lazy_mmu_mode_enable();
 
@@ -317,10 +316,9 @@ static int move_ptes(struct pagetable_move_control *pmc,
 	lazy_mmu_mode_disable();
 	if (force_flush)
 		flush_tlb_range(vma, old_end - len, old_end);
-	if (new_ptl != old_ptl)
-		spin_unlock(new_ptl);
+	double_pt_unlock(old_ptl, new_ptl);
 	pte_unmap(new_ptep - 1);
-	pte_unmap_unlock(old_ptep - 1, old_ptl);
+	pte_unmap(old_ptep - 1);
 out:
 	if (pmc->need_rmap_locks)
 		drop_rmap_locks(vma);
@@ -395,14 +393,9 @@ static bool move_normal_pmd(struct pagetable_move_control *pmc,
 	if (WARN_ON_ONCE(!pmd_none(*new_pmd)))
 		return false;
 
-	/*
-	 * We don't have to worry about the ordering of src and dst
-	 * ptlocks because exclusive mmap_lock prevents deadlock.
-	 */
-	old_ptl = pmd_lock(mm, old_pmd);
+	old_ptl = pmd_lockptr(mm, old_pmd);
 	new_ptl = pmd_lockptr(mm, new_pmd);
-	if (new_ptl != old_ptl)
-		spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
+	double_pt_lock(old_ptl, new_ptl);
 
 	pmd = *old_pmd;
 
@@ -418,9 +411,7 @@ static bool move_normal_pmd(struct pagetable_move_control *pmc,
 	pmd_populate(mm, new_pmd, pmd_pgtable(pmd));
 	flush_tlb_range(vma, pmc->old_addr, pmc->old_addr + PMD_SIZE);
 out_unlock:
-	if (new_ptl != old_ptl)
-		spin_unlock(new_ptl);
-	spin_unlock(old_ptl);
+	double_pt_unlock(old_ptl, new_ptl);
 
 	return res;
 }
@@ -452,14 +443,10 @@ static bool move_normal_pud(struct pagetable_move_control *pmc,
 	if (WARN_ON_ONCE(!pud_none(*new_pud)))
 		return false;
 
-	/*
-	 * We don't have to worry about the ordering of src and dst
-	 * ptlocks because exclusive mmap_lock prevents deadlock.
-	 */
-	old_ptl = pud_lock(mm, old_pud);
+	old_ptl = pud_lockptr(mm, old_pud);
 	new_ptl = pud_lockptr(mm, new_pud);
-	if (new_ptl != old_ptl)
-		spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
+
+	double_pt_lock(old_ptl, new_ptl);
 
 	pud = *old_pud;
 	if (unlikely(pud_none(pud)))
@@ -473,9 +460,7 @@ static bool move_normal_pud(struct pagetable_move_control *pmc,
 	pud_populate(mm, new_pud, pud_pgtable(pud));
 	flush_tlb_range(vma, pmc->old_addr, pmc->old_addr + PUD_SIZE);
 out_unlock:
-	if (new_ptl != old_ptl)
-		spin_unlock(new_ptl);
-	spin_unlock(old_ptl);
+	double_pt_unlock(old_ptl, new_ptl);
 
 	return true;
 }
@@ -503,16 +488,14 @@ static bool move_huge_pud(struct pagetable_move_control *pmc,
 	if (WARN_ON_ONCE(!pud_none(*new_pud)))
 		return false;
 
-	/*
-	 * We don't have to worry about the ordering of src and dst
-	 * ptlocks because exclusive mmap_lock prevents deadlock.
-	 */
-	old_ptl = __pud_trans_huge_lock(old_pud, vma);
-	if (unlikely(!old_ptl))
-		return false;
+	old_ptl = pud_lockptr(mm, old_pud);
 	new_ptl = pud_lockptr(mm, new_pud);
-	if (new_ptl != old_ptl)
-		spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
+
+	double_pt_lock(old_ptl, new_ptl);
+	if (unlikely(!pud_trans_huge(*old_pud))) {
+		double_pt_unlock(old_ptl, new_ptl);
+		return false;
+	}
 
 	/* Clear the pud */
 	pud = pudp_huge_get_and_clear(mm, pmc->old_addr, old_pud);
@@ -523,9 +506,7 @@ static bool move_huge_pud(struct pagetable_move_control *pmc,
 	/* mark soft_ditry when we add pud level soft dirty support */
 	set_pud_at(mm, pmc->new_addr, new_pud, pud);
 	flush_pud_tlb_range(vma, pmc->old_addr, pmc->old_addr + HPAGE_PUD_SIZE);
-	if (new_ptl != old_ptl)
-		spin_unlock(new_ptl);
-	spin_unlock(old_ptl);
+	double_pt_unlock(old_ptl, new_ptl);
 
 	return true;
 }
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index dac696bda19f0..169f681f9849b 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1206,33 +1206,6 @@ int mrwprotect_range(struct userfaultfd_ctx *ctx, unsigned long start,
 	return 0;
 }
 
-void double_pt_lock(spinlock_t *ptl1,
-		    spinlock_t *ptl2)
-	__acquires(ptl1)
-	__acquires(ptl2)
-{
-	if (ptl1 > ptl2)
-		swap(ptl1, ptl2);
-	/* lock in virtual address order to avoid lock inversion */
-	spin_lock(ptl1);
-	if (ptl1 != ptl2)
-		spin_lock_nested(ptl2, SINGLE_DEPTH_NESTING);
-	else
-		__acquire(ptl2);
-}
-
-void double_pt_unlock(spinlock_t *ptl1,
-		      spinlock_t *ptl2)
-	__releases(ptl1)
-	__releases(ptl2)
-{
-	spin_unlock(ptl1);
-	if (ptl1 != ptl2)
-		spin_unlock(ptl2);
-	else
-		__release(ptl2);
-}
-
 static inline bool is_pte_pages_stable(pte_t *dst_pte, pte_t *src_pte,
 				       pte_t orig_dst_pte, pte_t orig_src_pte,
 				       pmd_t *dst_pmd, pmd_t dst_pmdval)
-- 
2.53.0




