Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE07B188CC9
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 09:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788947285; cv=none; b=CfwMT1oNnefx7XpbQjT8OvAGcyKi1L9is4EUuYC7bRwwg/eyIPHJwZqda/sLT9nqEmizgmtB4w4lvq3qSMtlah1FlZZLjwv7kXj9+ZJSYiH5tMczLRJjWNZ6BEijcEj6ekQivE+I7L/DLtixfub674gM0S6dAFYcgdr77YbJ4vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788947285; c=relaxed/simple;
	bh=9YnSkGV5xot8x/9vsT+M0pfZ4f1n7pX1cnSiwpb6HIo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XrqYjp27k3MxGd0ywcIwHITcqAY7TuEGKBN/q3EPb3XIO33Fa39QIx/LqIeN7apAmW8Uirfl3k8wMspvkChR6BzgUKJsKCt7knFNe7NWyhdJ4y+j1tpQ+E6df5PyyeUxzsFlNsJl4/j0LNtO+9g6tj3lYr09QwLBvTauLAWTFJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2eF8s5dZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2eF8s5dZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14DDD1F00A3A;
	Wed,  9 Sep 2026 09:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788947284;
	bh=tKpSxCf0T8pcOi3WggLVUaj7mnQ5ZX1OAa8GDlzAdhY=;
	h=Subject:To:Cc:From:Date;
	b=2eF8s5dZBOTOXUgJMqfXoz/QxCTSWGigHFFqHmRYpYmXXprxxTbwcC37TE1G2ll0V
	 lQdi99ru71sJVphdCC39CHDBllgs1YCa7sGPIiX9RM5oWGTJu2w6tNciMvQcBh9tjy
	 1m0B6DKlv4ElVH0YviDsfWa5f3L9K0iIX5i+j+zo=
Subject: FAILED: patch "[PATCH] mm/mremap: reset unfaulted VMA page offset for" failed to apply to 5.10-stable tree
To: ljs@kernel.org,akpm@linux-foundation.org,jannh@google.com,kunwu.chan@gmail.com,liam@infradead.org,lixinhai.lxh@gmail.com,pfalcato@suse.de,stable@vger.kernel.org,vbabka@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 11:45:59 +0200
Message-ID: <2026090959-reuse-exhume-d04a@gregkh>
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
git cherry-pick -x 35b0fb391b0df57383bc15985bb769f4555c97ba
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090959-reuse-exhume-d04a@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 35b0fb391b0df57383bc15985bb769f4555c97ba Mon Sep 17 00:00:00 2001
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Tue, 25 Aug 2026 08:55:26 +0100
Subject: [PATCH] mm/mremap: reset unfaulted VMA page offset for
 MREMAP_DONTUNMAP

Uniquely an mremap() invocation using the MREMAP_DONTUNMAP flag can reset
a faulted VMA into an unfaulted one.

It does so after the page tables have been moved to the copied VMA with
MREMAP_DONTUNMAP leaving the old VMA in place which is naturally unfaulted
as the page tables it had are no longer present.

However, in doing so, it violates the invariant that the anonymous page
offset of an unfaulted VMA is vma->vm_start >> PAGE_SHIFT.

This is because a VMA may have been faulted in, mremap()'d (causing a
delta between its page offset and vma->vm_start >> PAGE_SHIFT), and then
mremap()'d again with MREMAP_DONTUNMAP resulting in the unfaulting.

This condition is a violation of a fundamental assumption in mm, but now
also triggers an assert in assert_sane_pgoff() which explicitly checks for
this condition.

Correct it by resetting the VMA's page offset at the point of completing
the MREMAP_DONTUNMAP operation.

Link: https://lore.kernel.org/20260825-fix-mremap-dontunmap-pgoff-v1-1-39a40b2c98b3@kernel.org
Fixes: 1583aa278f5f ("mm: mremap: unlink anon_vmas when mremap with MREMAP_DONTUNMAP success")
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reported-by: syzbot+f12658786a4153df5113@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6a87853b.ae6ddae5.3da009.0023.GAE@google.com/
Tested-by: syzbot+f12658786a4153df5113@syzkaller.appspotmail.com
Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Cc: Jann Horn <jannh@google.com>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Li Xinhai <lixinhai.lxh@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/mremap.c b/mm/mremap.c
index e8df5cdb0ac9..2b4b523a86b8 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1331,18 +1331,30 @@ static void dontunmap_complete(struct vma_remap_struct *vrm,
 {
 	unsigned long start = vrm->addr;
 	unsigned long end = vrm->addr + vrm->old_len;
-	unsigned long old_start = vrm->vma->vm_start;
-	unsigned long old_end = vrm->vma->vm_end;
+	struct vm_area_struct *vma = vrm->vma;
+	unsigned long old_start = vma->vm_start;
+	unsigned long old_end = vma->vm_end;
 
 	/* We always clear VMA_LOCKED[ONFAULT]_BIT on the old VMA. */
-	vma_clear_flags_mask(vrm->vma, VMA_LOCKED_MASK);
+	vma_clear_flags_mask(vma, VMA_LOCKED_MASK);
 
 	/*
 	 * anon_vma links of the old vma is no longer needed after its page
 	 * table has been moved.
 	 */
-	if (new_vma != vrm->vma && start == old_start && end == old_end)
-		unlink_anon_vmas(vrm->vma);
+	if (new_vma != vma && start == old_start && end == old_end) {
+		const pgoff_t pgoff_unfaulted = vma->vm_start >> PAGE_SHIFT;
+
+		unlink_anon_vmas(vma);
+		/*
+		 * The VMA is now unfaulted and it is an invariant that
+		 * unfaulted anonymous VMAs have page offset equal to
+		 * vma->vm_start >> PAGE_SHIFT.
+		 */
+		vma_set_anon_pgoff(vma, pgoff_unfaulted);
+		if (vma_is_anonymous(vma) && !vma->vm_file)
+			vma_set_pgoff(vma, pgoff_unfaulted);
+	}
 
 	/* Because we won't unmap we don't need to touch locked_vm. */
 }

