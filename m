Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046902;
	b=rAoyw4sLkk+DJ9efAaIRJsYh0M6JrNBsDgHndQOrybqTLlJRUJwl532POFCMx6wp8jGF
	 TLfq2KJn/q7xwZoga6q2vuzZsNr4zulyykgtJrIxIa7exWcAgkS3s2PTWRJKzofpmommD
	 3b+E1WjG2Y4R4x3xQ2uo9LyUxqfPiZ8kTOyQgZuBTjcVMkJ/dc6QpkjvthGF0iz83UylN
	 M/txv/FdYwfsd0lvMWtcIW/I1CGH7xuOnvzD5p+rzEDEwbbrd99AWeyPMDGcaTPRUq+e1
	 EBlzTzrjyd+k71P72C1xFLfOPXkTXSNSmuCt0wRspAvgxfASEVfs3VUCqE0v+f07P/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046902;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=tc9FRbvO0fngoVrORwgSaE7vc5FJvcgyA6MxV1RRdEk=;
	b=nCXXsMOCNBSH9Oi1yuMTm4ogbm3tIQbZIYS4tAVR02pjVArjTIaVLhHoEqzP/YH9qQMQ
	 hDm5g3ksJQd9v0Amjxox2T6dZR1TkCYtACYhfPDOTyraSCBk4cbNQF0XZ2g3dmmQclAZL
	 nEmoelBFXRapuC0dvQmkfugF+FU0aqBtUKVOnSw5GPb8IsgBevrcBO9XJiZXM1SvENvbc
	 emxUaYFmfSFsU8gWyahFYLhuhxDluw0G5x3lAghBX+BRpDkt2xXk/A+c6TiuWpm0Qd2+o
	 7F7rZ7JAC4vXKtxHt2tgo3tmNzcvBwXEjwdem1jsIl5SrVOg13v2mE4ex+tQM0UIjqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aFDFaPQx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94832606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aFDFaPQx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08BE1F008A1;
	Sat,  7 Nov 2026 10:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046902;
	bh=tc9FRbvO0fngoVrORwgSaE7vc5FJvcgyA6MxV1RRdEk=;
	h=From:To:Cc:Subject:Date;
	b=aFDFaPQxgTVaxgkKsr+4Cw3lm/qcG34uFTZBx8aqidRdYUL1qSny2CJA1HDkbAPed
	 JHL/8Htq02M+MXSHIeszNl0pY7law1D5BomHr3J7O7Nc41+sbTJHCCmAzubooYpMQs
	 4veuqFlMGEz2sBVa4S+AZJjiqnC8wf2/JarKH5lQvxHICMA3/dOMWBRgRkgpB3tLaD
	 MPZsm/cIh8TZc+8R1Ql0cpZ4NceRWrAN2L3AQbnVJxTEPWGM5R4kRNe2yzkr5aeWQp
	 9bgn4ImD3cg5CujGvmAQnjEXYhvLCeQnoOHopMxRiT9x3x8gJOd3I8WVq9AUnGek0D
	 i/as8b2GCcGRg==
From: Sasha Levin <sashal@kernel.org>
To: gourry@gourry.net,
	akpm@linux-foundation.org,
	sashiko-bot@kernel.org,
	david@kernel.org,
	jannh@google.com,
	jgg@ziepe.ca,
	liam@infradead.org,
	ljs@kernel.org,
	pfalcato@suse.de,
	peterx@redhat.com,
	vbabka@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] proc/task_mmu: handle special PMDs in clear_refs and pagemap" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:21:39 -0500
Message-ID: <20261107052139-failed-6.12-d350956d829f@kernel.org>
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
git cherry-pick -x d350956d829f4b620faf294c86116de640f1518c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052139-failed-6.12-d350956d829f@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From d350956d829f4b620faf294c86116de640f1518c Mon Sep 17 00:00:00 2001
From: Gregory Price <gourry@gourry.net>
Date: Sat, 12 Sep 2026 08:28:22 -0400
Subject: [PATCH] proc/task_mmu: handle special PMDs in clear_refs and pagemap

mshv_vtl_low can install a special PMD from a PFN supplied in the mmap file
offset.  That PFN need not have a memmap entry.  Reading /proc/PID/pagemap
or writing /proc/PID/clear_refs for such a mapping oopses the kernel.

With a test driver mapping the PFN at the 1 TiB mark:

  echo 1 > /proc/self/clear_refs

  BUG: unable to handle page fault for address: fffffb5b80000008
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  RIP: 0010:clear_refs_pte_range+0xb1/0x1e0
  Call Trace:
   walk_pgd_range+0x50a/0xad0
   __walk_page_range+0x6a/0x1d0
   walk_page_range_mm_unsafe+0x193/0x230
   clear_refs_write+0x18e/0x3f0

  pread(pagemap_fd, buf, 512 * 8, addr / PAGE_SIZE * 8)

  BUG: unable to handle page fault for address: fffff57840000008
  RIP: 0010:pagemap_pmd_range+0x3cf/0x6b0
  Call Trace:
   walk_pgd_range+0x50a/0xad0
   __walk_page_range+0x6a/0x1d0
   walk_page_range_mm_unsafe+0x193/0x230
   pagemap_read+0x1dc/0x350

clear_refs_pte_range() passes the PMD to pmd_folio(), while
pagemap_pmd_range_thp() uses pmd_page() followed by page_folio().

Both paths assume the PFN has a struct page and dereference bad address.

Use vm_normal_folio_pmd() and vm_normal_page_pmd() so clear_refs skips
folio operations and pagemap skips folio-derived flags for special PMDs.
This matches the PTE paths, which already use vm_normal_folio() and
vm_normal_page().

User-facing notes:
 - Pagemap still reports PM_PRESENT and the PFN to a CAP_SYS_ADMIN reader.

 - For a special PMD backed by a valid memmap entry and for the huge
   zero PMD, PM_FILE changes from set to clear.

 - PM_MMAP_EXCLUSIVE is already clear in both cases.

 - The output for an anonymous THP is unchanged.

Tested in QEMU with the test driver on broken and fixed kernels.  Both proc
operations oops before the fix and return 0 after it.

This is technically reachable via mshv_vtl_low, so I tagged it stable.

Link: https://lore.kernel.org/20260912122822.3348978-1-gourry@gourry.net
Fixes: 3c8e44c9b369 ("mm: mark special bits for huge pfn mappings when inject")
Signed-off-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260912034833.2952750-1-gourry%40gourry.net
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Assisted-by: LLM
Cc: Jann Horn <jannh@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: Peter Xu <peterx@redhat.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: <stable@vger.kernel.org> # v6.19+
---
 fs/proc/task_mmu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index e671b4fd8dedd..78e00c6d4e2df 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1704,7 +1704,9 @@ static int clear_refs_pte_range(pmd_t *pmd, unsigned long addr,
 		if (!pmd_present(*pmd))
 			goto out;
 
-		folio = pmd_folio(*pmd);
+		folio = vm_normal_folio_pmd(vma, addr, *pmd);
+		if (!folio)
+			goto out;
 
 		/* Clear accessed and referenced bits. */
 		pmdp_test_and_clear_young(vma, addr, pmd);
@@ -2024,7 +2026,7 @@ static int pagemap_pmd_range_thp(pmd_t *pmdp, unsigned long addr,
 		goto populate_pagemap;
 
 	if (pmd_present(pmd)) {
-		page = pmd_page(pmd);
+		page = vm_normal_page_pmd(vma, addr, pmd);
 
 		flags |= PM_PRESENT;
 		if (pmd_soft_dirty(pmd))
-- 
2.53.0




