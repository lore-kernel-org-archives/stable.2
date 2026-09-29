Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDB43C73C9
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 08:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790670446; cv=none; b=U2zQaA730RRicBWBG2p0reFoDweRwPSeNEg64+zfDKufuHgrHMtTjlFdnuhfTI9mtLVJ/RtPZr+whdBnRxNY7efkxogFMOpSM/+BO4mi+m2aZzXyI0NdRQOVCumlvLzyhBS2+UENJOYcQcFKvfYQ8kdfCsK+Q+8NDwSZoKBUZLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790670446; c=relaxed/simple;
	bh=Aibox98VG7l0euRVcEe2/nrambv+Bu6B3ZfksqID3x0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oFVrCVALtK4fi77QJPxBF+OWF3z+DrpzgS4OxRrY2VmOubU4T5QZwqGnNWloyP+LVs7hZo0ITXFuBMvepURsmf7C/qOMFJdnHALcqKWDa54ycnErMBWJ7Kjy+oOnAZqUIkHHjaKciVC5Jnjnr793jueyvpCm3OKAXx7bT14sFNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jRLhNUuu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jRLhNUuu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A10C1F000FF;
	Tue, 29 Sep 2026 08:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790670445;
	bh=G2cIiCIc8wRwtgadoBp2mu9rlp+RxAeyio06Y6mwnPA=;
	h=Subject:To:Cc:From:Date;
	b=jRLhNUuuhbm7cSUTq/DW3nQPIW2OUnrhoI9NEEUeHMCs6tVBHV2KRQx7X/1l7Xrbk
	 TfBnPi2U1A5E7Eo0ZumYZF8ZPP8h5elf4dRf5DbjCf7gXQHScLlcubi4Cc6jvdgPkC
	 8fS3981Cppy5MaWgTgFmDqjSnAkodiP/s0O/HQvI=
Subject: FAILED: patch "[PATCH] mm/hugetlb: preserve mremap address delta when skipping page" failed to apply to 6.12-stable tree
To: jaewook376@gmail.com,akpm@linux-foundation.org,david@kernel.org,johan@kernel.org,muchun.song@linux.dev,osalvador@suse.de,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 10:27:16 +0200
Message-ID: <2026092916-rubber-foe-5410@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 9bdad082d44bdcf93716973dcba6be77e8a06e7b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092916-rubber-foe-5410@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9bdad082d44bdcf93716973dcba6be77e8a06e7b Mon Sep 17 00:00:00 2001
From: Jaewook You <jaewook376@gmail.com>
Date: Mon, 14 Sep 2026 22:23:52 +0900
Subject: [PATCH] mm/hugetlb: preserve mremap address delta when skipping page
 tables

move_hugetlb_page_tables() optimizes mremap() by advancing to the last
entry in the page table when the source page table does not exist, either
initially or after unsharing a PMD table.  The common loop increment then
steps to the first entry in the next page table.

However, the code advances both the source and destination addresses to
the last entries in their respective page tables, which is wrong.  The
destination address must be advanced only by the same amount as the source
address.

If the source and destination offsets within their page tables differ, the
destination address can be advanced too far, causing follow-up issues.
Fix this by advancing the destination address by the source advance
distance.

With a reproducer, we were able to trigger a kernel panic on x86-64.  With
this fix in place, we can no longer reproduce the issue.

Link: https://lore.kernel.org/20260914132352.472-1-jaewook376@gmail.com
Fixes: e95a9851787b ("hugetlb: skip to end of PT page mapping when pte not present")
Fixes: 4ddb4d91b82f ("hugetlb: do not update address in huge_pmd_unshare")
Signed-off-by: Jaewook You <jaewook376@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: <stable@vger.kernel.org>
Assisted-by: LLM

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d28972cd33f5..cea25773a6c9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5170,18 +5170,21 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 	hugetlb_vma_lock_write(vma);
 	i_mmap_lock_write(mapping);
 	for (; old_addr < old_end; old_addr += sz, new_addr += sz) {
+		const unsigned long offset_to_last_entry =
+			(old_addr | last_addr_mask) - old_addr;
+
 		src_pte = hugetlb_walk(vma, old_addr, sz);
 		if (!src_pte) {
-			old_addr |= last_addr_mask;
-			new_addr |= last_addr_mask;
+			old_addr += offset_to_last_entry;
+			new_addr += offset_to_last_entry;
 			continue;
 		}
 		if (huge_pte_none(huge_ptep_get(mm, old_addr, src_pte)))
 			continue;
 
 		if (huge_pmd_unshare(&tlb, vma, old_addr, src_pte)) {
-			old_addr |= last_addr_mask;
-			new_addr |= last_addr_mask;
+			old_addr += offset_to_last_entry;
+			new_addr += offset_to_last_entry;
 			continue;
 		}
 

