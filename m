Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276EE5540B7;
	Thu, 15 Oct 2026 16:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792080501; cv=none; b=mYQte+sFjEt92aHO6Acu2TYqQrb9p3nMmR3qph0b6QwWS2PzVb7Yhvbetsf5ywc13Uzs/57jqlluRVIY+6GtqKYB5A6wncdoaLhWXmPAllviXc0OdtdcL4F5Kqf/CJDMlyOWcvJSJ/69YiGHM3SW1jxkDKNtcfPTq9lEJQOSLJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792080501; c=relaxed/simple;
	bh=36AusLO0pDxFRhzbhmkowXF4Cn8pQw3SfS8AJ1zFeOo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eHL0ZTzP7kWD/AKF/7BYBrD+E5hNPoitDQytaeWEeYckkKSyUYZIqD2PHh1BappV2zHmvdOMTf0CXNa5OCVflICtcKSfJtw2cjNR4vUwJRgbH3b+kbqMHSeerejgf6RCsxjZlBHL3KAXjpqaBc5nwHAUJzRzHIxZoOMdKXsdJYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CD2obr0a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CD2obr0a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842D01F000C7;
	Thu, 15 Oct 2026 16:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792080480;
	bh=8Ud2Znr5W7y/xLuHTpF4M1rYyTf9+FphnA6xGQ/z7Ks=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CD2obr0axs8FhpRcUB5Ocn0+jnAceHNutIpXQgX+lSym4HnRx2yPgZyvSrb/fiQ4s
	 DysmRMSYtytGwsRc1DJdO5XDM7WHDnaNK6rytI7+mEpSSR/ywEZD7uM3eCyoIYlinT
	 skNZAcTxHH9+eWiX9YdttVL5qE8jCFMh4IhrW9S3y6NnTXK5feC1M+YDjR83WWaiWW
	 X9mKhmkzNjXunDWgbzHSri4+hf3NPCYy7h/1Z6Ig0E+89D/Lg9YNsZtw4B3qRCKgJt
	 xPJYt0q+/wGDIOXag8ZGUeyx6T7IlRJnC3H9Y6rXVS5BV3KWq4eYIKiThS7fYPep2u
	 UDfpWoLOVbwpg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 15 Oct 2026 18:07:12 +0200
Subject: [PATCH 06/10] mm/hugetlb: fix endless write fault on a leftover
 uffd bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-urgent_fixes-v1-6-42796911043b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2767; i=david@kernel.org;
 h=from:subject:message-id; bh=vsY/j7SLFL5BWtxtbqOGInAFZOdZ8OaRvzchTAd21uY=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIu/DKeF/jzQWTX4YzuQz8Xil02n/wjZcXlhVut+S89n
 9Oh+malY0cpC4MYB4OsmCJLUPB9g5cv19VWu/Exw8xhZQIZwsDFKQAT+VnK8M/s4oWsK5uvTn7K
 dtH4e7XSXJH89fb5QTkO2ZtrLIx9jxow/BURPXnt9LfKPHvunq9MxTWG5+QncrFset3XoD77JuP
 St8wA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Josef Bacik <josef@toxicpanda.com>

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

Fixes: 60d5b473d61b ("mm/hugetlb: fix uffd wr-protection for CoW optimization path")
Reported-by: Chris Mason <mason@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[rppt: massage commit message]
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
[ david: convert comment into a TODO ]
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/hugetlb.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f8ad2efd472cb..c3823f1958568 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6184,15 +6184,19 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
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
2.43.0

