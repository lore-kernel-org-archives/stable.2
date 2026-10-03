Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC2B314A6F
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 13:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791033761; cv=none; b=KmyTTGryxRhESqKvzDabvfOw/DNcinqIvhhNz6SyZ26I5WWSiK3zzsuOP0PgK3b+uj8OHVi97V9ykF1d5qlZy3zMDRZsxToAh5EnnEHZ3B8r3m03ceUJeFDa1Lx9vRqQ5wez7sgXw1+7r9aMaRM0mzFnLPaVv2kMrE9f420njtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791033761; c=relaxed/simple;
	bh=qwHnMH/KOgLLP6/tALby1+xt/mUOuQblJ1/sp+aaVzU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tgMdMnrzSaPBCyLc8hzFGQ9ySgnselTU/4g7qY1hEhUSP7bSp73+m7zMRC8ZeTfpFUKOuEdmeuDCgJFfu8S0CaV6jGwKtT3K7tu3+n0HscV54hq1rHX2Zt45zRPeDEYScxpl8Q8f1M/godtG2NT6wxpHtiFyveRCLwU5btKN91E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eikvcybv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eikvcybv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F411F0089B;
	Sat,  3 Oct 2026 13:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791033760;
	bh=VW6ffuyILEUtTdi8zCwUJwqijNBHDRx3CVAcveGIFMA=;
	h=Subject:To:Cc:From:Date;
	b=eikvcybveQrn9sJHCNnzKFB2OZAKf9SYE+JgZ3lo5rKMyS5geblfG9bi3y5vVkgwE
	 SQJA5CPRyRjrU2k74givbtL9KQP7fpjrlUBS1RXqNj+A/M2HZnwKbDwAxVCG61tNMR
	 FirNue+AzhWds4kRR2JBmHxLY9m2ZdR4JQ23+ALM=
Subject: FAILED: patch "[PATCH] mm/vma: predicate setting mmap_prepare VMA fields on new vma" failed to apply to 6.18-stable tree
To: ljs@kernel.org,akpm@linux-foundation.org,gourry@gourry.net,jannh@google.com,liam@infradead.org,pfalcato@suse.de,stable@vger.kernel.org,surenb@google.com,vbabka@kernel.org,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 03 Oct 2026 15:22:29 +0200
Message-ID: <2026100329-jaws-trash-1c19@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 976d5e0ddac885b0219252f004f6c561c344df9d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100329-jaws-trash-1c19@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 976d5e0ddac885b0219252f004f6c561c344df9d Mon Sep 17 00:00:00 2001
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Wed, 23 Sep 2026 18:45:41 +0100
Subject: [PATCH] mm/vma: predicate setting mmap_prepare VMA fields on new vma
 alloc

It only makes sense to manipulate VMA fields if a new VMA was allocated,
rather than merged.

VMA merging does not compare vm_ops or vm_private_data, so a merged VMA
keeps its own, which is also what the legacy f_op->mmap path does since it
never touches an existing VMA.

Currently, these fields will get overwritten by whatever state is
established in the mmap_prepare hook, and if the VMA was merged,
vm_ops->mapped will not have been called, so this could destructively
clear existing state without replacing it with anything valid.

There is an implicit requirement that vm_private_data and vm_ops are
fungible across VMAs which means that losing the 'new' state is fine.

However in this case the 'old' state is being overwritten by potentially
invalid 'new' state, so this must be rectified.

Additionally constify have_mmap_prepare while here.

All existing in-tree users either derive state from the file or are
unmergeable due to VMA flags, so this has no direct impact.

Link: https://lore.kernel.org/20260923-fix-mmap-prepare-overwrite-v1-1-3b3f1bfcdf5e@kernel.org
Fixes: c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file callback")
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Acked-by: Zi Yan <ziy@nvidia.com>
Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Jann Horn <jannh@google.com>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: <stable@vger.kernel.org>

diff --git a/mm/vma.c b/mm/vma.c
index 9f0a0acf694a..6cde67883fb0 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -2849,7 +2849,7 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma = NULL;
-	bool have_mmap_prepare = file && file->f_op->mmap_prepare;
+	const bool have_mmap_prepare = file && file->f_op->mmap_prepare;
 	VMA_ITERATOR(vmi, mm, addr);
 	const pgoff_t anon_pgoff = addr >> PAGE_SHIFT;
 	MMAP_STATE(map, mm, &vmi, addr, len, pgoff, anon_pgoff, vma_flags, file);
@@ -2892,7 +2892,7 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 		allocated_new = true;
 	}
 
-	if (have_mmap_prepare)
+	if (have_mmap_prepare && allocated_new)
 		set_vma_user_defined_fields(vma, &map);
 
 	__mmap_complete(&map, vma);

