Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047932;
	b=pmhUWzASv55EqkZ8KqY9stAz84b65F3TkQJjn5QfN+WffYIxDxASG4na1o+oEQR9+4jV
	 pkjTf5K0NCGMWTFtpiVpWn20RjqIyRnYPy98KVYzHntHPp/sIT3x72pCR0pXkWSeA6rW9
	 xmPJFs1bEddloI/liy2/wJyC2YC4M1Yqr0zpdj411PjezDgLJHugfbVHeL3EBAKqJrM8j
	 hEymHEf7jOk1lEeF8l5LkG0ajoh0PiltS071bbO0DlVKkDzhzQNmUoq+p4VXxbZBPtPAu
	 pTSQZDm6LWPvf6BwXUJH3wvJ9F5Hy+RjSLQqIWq9lcQsZQ+v40X1B8VIRlcAp3mPKNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047932;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=B6Brg59Umn1EC3dAAj7LdDF/a7TnI/Xwxr2deIVme+A=;
	b=MJ+BhRXoQJVr1jzAxzPpVHXTT1RQYLddX5sfmpzBSLBsIvtBb/73syTxUKX6gGijFo9b
	 ywPd4YoUfC38h/xUGWxIXOw3fm5eOCa9geJHqUEV7/Nmf8xmFz2lZ+X5agjfZaR2mkky/
	 TSMwkPOI+WQzlO5MU+qUzIPArZP2xY53gBWnn0MQktnaGXfgrL4MHsbnS2mDZ94f+RDxt
	 qIBprAgjulh2mD9tf18PG35mPy6IPq3tsJT2bX2Dy1mf049FnzyEoDHOHshvuBgRBSlhn
	 eXa43eDE3EXjJ10qEVulVfhZjjtU2gINsts47Esn7l4YXspF4anmoEde58GnVF9kO/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iMFF2qE9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB53606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iMFF2qE9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F9B1F0089F;
	Sat,  7 Nov 2026 10:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047932;
	bh=B6Brg59Umn1EC3dAAj7LdDF/a7TnI/Xwxr2deIVme+A=;
	h=From:To:Cc:Subject:Date;
	b=iMFF2qE9wgKiguLFtOPs7X1oO0ZJkjhW8pgGrjHAz9RB2XxBRkLLcK76IgruIZm+g
	 Mbz0pWTGCG+SZnXK6wDCvxjvxdmgIT7hhRn7ue0DOlXUh8uU/kpa2d28GtA4l4nbSD
	 2RSfEwpZKNQJfPs7Es0ihKnzgR7JhRxso80x9Ujgm9lyu1wwNInKImSTDW7/TxGkNP
	 D/l+kAMrtEgGxqG4v8K23pMMAub2i+4cd4wJQI8TgQtnGwm4axeG/T49nvhLTFVwUk
	 Pu8xXIl1LCcmg/u3+MMXGcRU/kEkEXUljo6EnJB31pWeEu8rANOOon3dxYo6u56nLC
	 aQ+E56F3b9RUg==
From: Sasha Levin <sashal@kernel.org>
To: josef@toxicpanda.com,
	david@kernel.org,
	rppt@kernel.org,
	akpm@linux-foundation.org,
	mason@kernel.org,
	ljs@kernel.org,
	lance.yang@linux.dev,
	liam@infradead.org,
	vbabka@kernel.org,
	jannh@google.com,
	pfalcato@suse.de,
	muchun.song@linux.dev,
	osalvador@suse.de,
	linmiaohe@huawei.com,
	nao.horiguchi@gmail.com,
	agl@us.ibm.com,
	mgorman@techsingularity.net,
	riel@surriel.com,
	peterx@redhat.com,
	kas@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/hugetlb: fix endless write fault on a leftover uffd bit" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:38:48 -0500
Message-ID: <20261107053848-failed-6.6-f61e1cf15fb4@kernel.org>
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
git cherry-pick -x f61e1cf15fb44f9cf89d43d8ef01f926322bb1c4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053848-failed-6.6-f61e1cf15fb4@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From f61e1cf15fb44f9cf89d43d8ef01f926322bb1c4 Mon Sep 17 00:00:00 2001
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 15 Oct 2026 18:07:12 +0200
Subject: [PATCH] mm/hugetlb: fix endless write fault on a leftover uffd bit

hugetlb_fault() resolves the uffd bit on a write fault only if the VMA is
registered for userfaultfd write protection, and hugetlb_wp() bails out
for any entry with the uffd bit set assuming hugetlb_fault() has already
resolved it.

When a read-only hugetlb entry with the uffd bit set is mapped in a VMA
that is not registered for uffd-wp, a write fault to it never makes
progress. If the access comes from the kernel, e.g. read(2) from
/dev/zero into such page, the task spins in the page fault handler,
ignores SIGKILL and keeps holding the locks taken by the system call.

Such entries should not exist, but an unprivileged user can create them,
for example with MADV_DONTNEED of a page protected with UFFDIO_RWPROTECT
or with UFFDIO_COPY in MODE_WP racing with UFFDIO_UNREGISTER.

Clear the uffd bit when the VMA is not registered for uffd-wp and let the
fault proceed to hugetlb_wp(), like do_wp_page() does for regular pages.

Note that a FOLL_FORCE write to a page protected with UFFDIO_RWPROTECT in
a private VMA that was made PROT_NONE now drops the RWP protection of
that page.

Original fix generated by an LLM and sent in private by Josef.

[rppt@kernel.org: massage commit message]
[david@kernel.org: convert comment into a TODO]
Link: https://lore.kernel.org/20261015-urgent_fixes-v1-6-42796911043b@kernel.org
Fixes: 60d5b473d61b ("mm/hugetlb: fix uffd wr-protection for CoW optimization path")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Chris Mason <mason@kernel.org>
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: Adam Litke <agl@us.ibm.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Rik van Riel <riel@surriel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Kiryl Shutsemau <kas@kernel.org>
Cc: <stable@vger.kernel.org>
---
 mm/hugetlb.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4a7c52802cde5..d3adafbea160b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6226,15 +6226,19 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		goto out_ptl;
 
 	/* Handle userfault-wp first, before trying to lock more pages */
-	if (userfaultfd_wp(vma) && huge_pte_uffd(huge_ptep_get(mm, vmf.address, vmf.pte)) &&
+	if (huge_pte_uffd(huge_ptep_get(mm, vmf.address, vmf.pte)) &&
 	    (flags & FAULT_FLAG_WRITE) && !huge_pte_write(vmf.orig_pte)) {
-		if (!userfaultfd_wp_async(vma)) {
+		if (userfaultfd_wp(vma) && !userfaultfd_wp_async(vma)) {
 			spin_unlock(vmf.ptl);
 			hugetlb_vma_unlock_read(vma);
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 			return handle_userfault(&vmf, VM_UFFD_WP);
 		}
 
+		/*
+		 * TODO: fix all cases where uffd PTE bits remain in VMAs that
+		 * are no longer registered with uffd.
+		 */
 		vmf.orig_pte = huge_pte_clear_uffd(vmf.orig_pte);
 		set_huge_pte_at(mm, vmf.address, vmf.pte, vmf.orig_pte,
 				huge_page_size(hstate_vma(vma)));
-- 
2.53.0




