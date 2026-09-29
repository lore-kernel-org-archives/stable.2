Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D61A3B5F5D
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 08:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790670452; cv=none; b=EO7IgbEhi+PnOdLC4cHXRr5JXwKwOMz901Uex+ZjJsS/0jtsFE4fBxLZMM2A1zhpbCZLDyCjHiHLbex/Uvt1tR6vgSPPF6SaupRY/WCawMtUsCzMAQMwdLEwjbKnAVEDuRtJ/mRk+XFQ25kLY9qrSyU8Nbctnx6k+jeLTgTpltc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790670452; c=relaxed/simple;
	bh=T5L4KVwQB2JqP/PLT3hJVegWukgCty2UN9FECCpwjtU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HZxWP67HGivEneMQRxsaB09WDN9AzSoHgHpAuUavrNIvAGfOqiUIYfB7NkZPtx6tbJVZcOJs9noqKG1HVL7/rrSbWZ0BumZUS5CuYoE5SJor1xiiaGQ94EJgDvSLPYez1dAUF0MOsgGofktdL9JrOhw0ADlB5A/kyd/Qwok6BnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Rhvsgr92; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Rhvsgr92"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A061F00893;
	Tue, 29 Sep 2026 08:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790670450;
	bh=jR0lbAoB9o04Qy6o9nT6qxysXeF/DO+qE1NesVmsD08=;
	h=Subject:To:Cc:From:Date;
	b=Rhvsgr92odVbCE7lke/l4CA9Yv4RGhfyx0LZUcKXon4mMHirl/FJP2IV70lcaOR7d
	 h9ij+gxoHYGxGSvQO7RD7zN/kNJ1mDCG0zoqJHwrlhXf0OVe82ne+jN7ai5w8HNqMo
	 9wvssPmIoWBXiBgi7T0XUhWOuS3VO6SxJVJ5qfLo=
Subject: FAILED: patch "[PATCH] mm/hugetlb: preserve mremap address delta when skipping page" failed to apply to 6.6-stable tree
To: jaewook376@gmail.com,akpm@linux-foundation.org,david@kernel.org,johan@kernel.org,muchun.song@linux.dev,osalvador@suse.de,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 10:27:17 +0200
Message-ID: <2026092917-starlit-overlord-5819@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 9bdad082d44bdcf93716973dcba6be77e8a06e7b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092917-starlit-overlord-5819@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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
 

