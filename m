Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C810E408016
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 15:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538647; cv=none; b=ena1IApOuKoV6mgF89qaFnChnI2JgxFkM012UZybisYHrgb4yEHh0TKf2WANlKHdHG7+Zh27JFbCZaXTC5i3t591KrA9VjnnlCNZNA8yw2FjiRAa0oPFjFxsxSN6ILj9hbGnerLePYFZLrNDyXOa+g3WRrcbtuBuFTanXKX9xFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538647; c=relaxed/simple;
	bh=HoNa4smR6IrlWPYRYiPXMVFkywGGQA/v7hZAXTJ7q64=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GPQYFWPaXBqzlIQRmRWIBXXHpmSqCv6V/IlR+ROq2DreUhxDtK3b5dZ6D+suD+AUYpKMmyBrfyPt5n40h5FH8OI3YMUO7jgJ++A/Ck7w6W9yp7Z5TyuIHkxNmTeBmwd471CdlVQzdMd8+G62svO8GV1EhBITNWJ64jFMiMr5wy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dSWioM1L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dSWioM1L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78FA01F000E9;
	Mon, 15 Jun 2026 15:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781538645;
	bh=7LjpkDmzcd/dkGFO/iVflkCPmDHs8ApBMcNfWeifcL0=;
	h=Subject:To:Cc:From:Date;
	b=dSWioM1LR0WMEC1yvgjklaaxO2lCJTieVchgRhw5bsDFpBuOkVNt2F2/oDD2ar7Sq
	 bj+iH6DEC3h0TVN2wVgv/L3AiL526mquBYEkjuC/V18ESCfBUKGU4TjFY1HMHHBbcR
	 CgGYlAPL5JKq3dLHXaHYcR0L7pvgPqAS5Isz2ZU8=
Subject: FAILED: patch "[PATCH] mm/hugetlb: avoid false positive lockdep assertion" failed to apply to 5.10-stable tree
To: ljs@kernel.org,akpm@linux-foundation.org,david@kernel.org,jannh@google.com,muchun.song@linux.dev,osalvador@suse.de,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 17:41:28 +0200
Message-ID: <2026061528-crouton-limeade-e671@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x b4aea43cd37afad714b5684fe9fdfcb0e78dba26
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061528-crouton-limeade-e671@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b4aea43cd37afad714b5684fe9fdfcb0e78dba26 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <ljs@kernel.org>
Date: Wed, 13 May 2026 09:56:58 +0100
Subject: [PATCH] mm/hugetlb: avoid false positive lockdep assertion

Commit 081056dc00a2 ("mm/hugetlb: unshare page tables during VMA split,
not before") changed the locking model around hugetlbfs PMD unsharing on
VMA split, but did not update the function which asserts the locks,
hugetlb_vma_assert_locked().

This function asserts that either the hugetlb VMA lock is held (if a
shared mapping) or that the reservation map lock is held (if private).

If you get an unfortunate race between something which results in one of
these locks being released and a hugetlb VMA split and you have
CONFIG_LOCKDEP enabled, you can therefore see a false positive assertion
arise when there is in fact no issue.

Since this change introduced a new take_locks parameter to
hugetlb_unshare_pmds(), which, when set to false, indicates that locking
is sufficient, simply pass this to the unsharing logic and predicate the
lock assertions on this.

This is safe, as we already asserted the file rmap lock and the VMA write
lock prior to this (implying exclusive mmap write lock), so we cannot be
raced by either rmap or page fault page table walkers which the asserted
locks are intended to protect against (we don't mind GUP-fast).

Separate out huge_pmd_unshare() into __huge_pmd_unshare() to add a
check_locks parameter, and update hugetlb_unshare_pmds() to pass this
parameter to it.

This leaves all other callers of huge_pmd_unshare() still correctly
asserting the locks.

The below reproducer will trigger the assert in a kernel with
CONFIG_LOCKDEP enabled by racing process teardown (which will release the
hugetlb lock) against a hugetlb split.

void execute_one(void)
{
	void *ptr;
	pid_t pid;

	/*
	 * Create a hugetlb mapping spanning a PUD entry.
	 *
	 * We force the hugetlb page allocation with populate and
	 * noreserve.
	 *
	 * |---------------------|
	 * |                     |
	 * |---------------------|
	 * 0                 PUD boundary
	 */
	ptr = mmap(0, PUD_SIZE, PROT_READ | PROT_WRITE,
		   MAP_FIXED | MAP_SHARED | MAP_ANON |
		   MAP_NORESERVE | MAP_HUGETLB | MAP_POPULATE,
		   -1, 0);
	if (ptr == MAP_FAILED) {
		perror("mmap");
		exit(EXIT_FAILURE);
	}

	/*
	 * Fork but with a bogus stack pointer so we try to execute code in
	 * a non-VM_EXEC VMA, causing segfault + teardown via exit_mmap().
	 *
	 * The clone will cause PMD page table sharing between the
	 * processes first via:
	 * copy_process() -> ... -> huge_pte_alloc() -> huge_pmd_share()
	 *
	 * Then tear down and release the hugetlb 'VMA' lock via:
	 * exit_mmap() -> ... -> vma_close() -> hugetlb_vma_lock_free()
	 */
	pid = syscall(__NR_clone, 0, 2 * PMD_SIZE, 0, 0, 0);
	if (pid < 0) {
		perror("clone");
		exit(EXIT_FAILURE);
	} if (pid == 0) {
		/* Pop stack... */
		return;
	}

	/*
	 * We are the parent process.
	 *
	 * Race the child process's teardown with a PMD unshare.
	 *
	 * We do this by triggering:
	 *
	 * __split_vma() -> hugetlb_split() -> hugetlb_unshare_pmds()
	 *
	 * Which, importantly, doesn't hold the hugetlb VMA lock (nor can
	 * it), meaning we assert in hugetlb_vma_assert_locked().
	 *
	 *            .
	 * |----------.----------|
	 * |          .          |
	 * |----------.----------|
	 * 0          .     PUD boundary
	 */
	mmap(0, PUD_SIZE / 2, PROT_READ | PROT_WRITE,
	     MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
}

int main(void)
{
	int i;

	/* Kick off fork children. */
	for (i = 0; i < NUM_FORKS; i++) {
		pid_t pid = fork();

		if (pid < 0) {
			perror("fork");
			exit(EXIT_FAILURE);
		}

		/* Fork children do their work and exit. */
		if (!pid) {
			int j;

			for (j = 0; j < NUM_ITERS; j++)
				execute_one();
			return EXIT_SUCCESS;
		}
	}

	/* If we succeeded, wait on children. */
	for (i = 0; i < NUM_FORKS; i++)
		wait(NULL);

	return EXIT_SUCCESS;
}

[ljs@kernel.org: account for the !CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING case]
  Link: https://lore.kernel.org/agWZsPGYid08uU6O@lucifer
Link: https://lore.kernel.org/20260513085658.45264-1-ljs@kernel.org
Fixes: 081056dc00a2 ("mm/hugetlb: unshare page tables during VMA split, not before")
Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: Oscar Salvador <osalvador@suse.de>
Cc: Jann Horn <jannh@google.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4b80b167cc9c..ece86d9339ce 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -118,6 +118,9 @@ static int hugetlb_acct_memory(struct hstate *h, long delta);
 static void hugetlb_vma_lock_free(struct vm_area_struct *vma);
 static void hugetlb_vma_lock_alloc(struct vm_area_struct *vma);
 static void __hugetlb_vma_unlock_write_free(struct vm_area_struct *vma);
+static int __huge_pmd_unshare(struct mmu_gather *tlb,
+		struct vm_area_struct *vma, unsigned long addr, pte_t *ptep,
+		bool check_locks);
 static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
 		unsigned long start, unsigned long end, bool take_locks);
 static struct resv_map *vma_resv_map(struct vm_area_struct *vma);
@@ -6891,6 +6894,31 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 	return pte;
 }
 
+static int __huge_pmd_unshare(struct mmu_gather *tlb,
+		struct vm_area_struct *vma, unsigned long addr, pte_t *ptep,
+		bool check_locks)
+{
+	unsigned long sz = huge_page_size(hstate_vma(vma));
+	struct mm_struct *mm = vma->vm_mm;
+	pgd_t *pgd = pgd_offset(mm, addr);
+	p4d_t *p4d = p4d_offset(pgd, addr);
+	pud_t *pud = pud_offset(p4d, addr);
+
+	if (sz != PMD_SIZE)
+		return 0;
+	if (!ptdesc_pmd_is_shared(virt_to_ptdesc(ptep)))
+		return 0;
+	i_mmap_assert_write_locked(vma->vm_file->f_mapping);
+	if (check_locks)
+		hugetlb_vma_assert_locked(vma);
+	pud_clear(pud);
+
+	tlb_unshare_pmd_ptdesc(tlb, virt_to_ptdesc(ptep), addr);
+
+	mm_dec_nr_pmds(mm);
+	return 1;
+}
+
 /**
  * huge_pmd_unshare - Unmap a pmd table if it is shared by multiple users
  * @tlb: the current mmu_gather.
@@ -6910,24 +6938,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 int huge_pmd_unshare(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		unsigned long addr, pte_t *ptep)
 {
-	unsigned long sz = huge_page_size(hstate_vma(vma));
-	struct mm_struct *mm = vma->vm_mm;
-	pgd_t *pgd = pgd_offset(mm, addr);
-	p4d_t *p4d = p4d_offset(pgd, addr);
-	pud_t *pud = pud_offset(p4d, addr);
-
-	if (sz != PMD_SIZE)
-		return 0;
-	if (!ptdesc_pmd_is_shared(virt_to_ptdesc(ptep)))
-		return 0;
-	i_mmap_assert_write_locked(vma->vm_file->f_mapping);
-	hugetlb_vma_assert_locked(vma);
-	pud_clear(pud);
-
-	tlb_unshare_pmd_ptdesc(tlb, virt_to_ptdesc(ptep), addr);
-
-	mm_dec_nr_pmds(mm);
-	return 1;
+	return __huge_pmd_unshare(tlb, vma, addr, ptep, /*check_locks=*/true);
 }
 
 /*
@@ -6961,6 +6972,13 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 	return NULL;
 }
 
+static int __huge_pmd_unshare(struct mmu_gather *tlb,
+		struct vm_area_struct *vma, unsigned long addr, pte_t *ptep,
+		bool check_locks)
+{
+	return 0;
+}
+
 int huge_pmd_unshare(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		unsigned long addr, pte_t *ptep)
 {
@@ -7269,7 +7287,7 @@ static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
 		if (!ptep)
 			continue;
 		ptl = huge_pte_lock(h, mm, ptep);
-		huge_pmd_unshare(&tlb, vma, address, ptep);
+		__huge_pmd_unshare(&tlb, vma, address, ptep, take_locks);
 		spin_unlock(ptl);
 	}
 	huge_pmd_unshare_flush(&tlb, vma);

