Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533BF47042D
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 09:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788947280; cv=none; b=lNrVZUaPbjaSrmUb6DM3HOJpPFR4VzyvdNR/5YJ59p8i137B0kPXHtmmrb28FB0aBB0pPiVoaYHgUJ5OFxSUkaR/kZmkS1RrjbeqoCwm3c2UD3Hej1ukHTXB0tUpR0ecRoUX9lVr3S9/YoSricF6bR0ts3Cwgm804Hj6gB8C9ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788947280; c=relaxed/simple;
	bh=W01Y8tPGkoCZZ21QyNkWx1ZN7JrfA0WYYLN7QbM33Hs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=t8N/bWLoF/jHjW2UmR7OlxwBEUzNyKi9TjqAnTDYSAUGHQHq1Wy7ZYZKl6Hi0hTXSRMpYbpYKOiW4bnkX5puabpHuwKYxyACDVVm11igxCtAaxJ0OpwzdI3m78w9LkS+oLGjnJADWcCxpVlB9/pO/s5DQdpxklPUiFZ+5oYNG4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JqiR8b4f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JqiR8b4f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6179B1F00A3A;
	Wed,  9 Sep 2026 09:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788947278;
	bh=FindGEiFOb7Jqycs4ztxRv7lLJiWytKUk9tOETkbU6M=;
	h=Subject:To:Cc:From:Date;
	b=JqiR8b4f9ALmtbOPquF0atbI+Of7DpS8qBMFVnoHrlP/yfmXIx4QNPFD2B4s/BgiE
	 C9ArfV/46EWe5m3CqCLjJ3gxs2hrgvmiqZlLLJEa1bupiF2bzFbAZuxulURLrcP0qh
	 LoRBWyGxdZq+dzdjqDua8tHxu33jO99cP9ETBQe0=
Subject: FAILED: patch "[PATCH] mm/mremap: reset unfaulted VMA page offset for" failed to apply to 5.15-stable tree
To: ljs@kernel.org,akpm@linux-foundation.org,jannh@google.com,kunwu.chan@gmail.com,liam@infradead.org,lixinhai.lxh@gmail.com,pfalcato@suse.de,stable@vger.kernel.org,vbabka@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 11:45:58 +0200
Message-ID: <2026090958-bonelike-alkaline-4d33@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 35b0fb391b0df57383bc15985bb769f4555c97ba
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090958-bonelike-alkaline-4d33@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

