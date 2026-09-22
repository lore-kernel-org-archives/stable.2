Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23736383C66
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 09:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790070210; cv=none; b=ge//9ObNJi52x2pYlOOvbbV3gFXdANa5kZV+rg8o9m+5VIGb9hi2XefVcGYW+bSichpeL3gkDrtnE6wh4oN99dkpL3ETdMHyitUSKXfb6RjC7YiX5uB5Emmv08CU9TvhzZSfUiJ7RKf8lECRZGuvy0rd36Sj17B35inpcI9iI2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790070210; c=relaxed/simple;
	bh=rCfJZxdDilXvXdbTvZcg8ktWR2iHn7Gp4kOZ/22Pz8Q=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cxA3WTcAxQ7bWjXGCZeuyDOwY4BiCJktxeaj9JmhRjLrePgY7tLl4QrLqGLfP83hh2lcRRjFz8WGqjJ2I9IdDNmPgyPFg1wksY8CsxS+0sWbkJ9CwpmjsJXVoiLELkiyswvbMSFuBaWfw7B9QuIOjXODKBq6xL6ajmc3LjzW3Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BrMVeH5d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BrMVeH5d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 727361F000FF;
	Tue, 22 Sep 2026 09:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790070209;
	bh=Wozghzkwez7BHCWhzxMRhem7+F+0MHlfvlGDek+/GSc=;
	h=Subject:To:Cc:From:Date;
	b=BrMVeH5dPag3XWICUPdINDLgJp+w2znanSD0dnfJ/o0WOCfjq6VuYfDrZphh1H9j5
	 PPVd2I+bI2JFM9sq2xy1RTpoMl4jwfo3lHKX8rAD6+ImjtbfJeU6L7bnBgfRj2+ayE
	 9scVC+PKEvyE+4fYHyIAYg0LQlJ3IxcREgpAIiIE=
Subject: FAILED: patch "[PATCH] mm/vma: correctly unaccount on mmap_prepare() failure" failed to apply to 6.18-stable tree
To: ljs@kernel.org,akpm@linux-foundation.org,jannh@google.com,liam@infradead.org,pfalcato@suse.de,stable@vger.kernel.org,vbabka@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 11:37:35 +0200
Message-ID: <2026092235-visor-glance-dc8e@gregkh>
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
git cherry-pick -x 6cc27d82196385fe06853319f74312a7d8019726
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092235-visor-glance-dc8e@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6cc27d82196385fe06853319f74312a7d8019726 Mon Sep 17 00:00:00 2001
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Wed, 2 Sep 2026 19:08:08 +0100
Subject: [PATCH] mm/vma: correctly unaccount on mmap_prepare() failure

__mmap_setup() accounts memory for relevant mappings via:

security_vm_enough_memory_mm()
  -> __vm_enough_memory()
    -> vm_acct_memory()

If __mmap_setup() fails, this indicates that this accounting did not take
place, and thus it's appropriate for __mmap_region() to jump to
abort_munmap.

However if call_mmap_prepare() fails, it also jumps there and any accounted
memory is not correctly unaccounted.

Fix this by handling each error separately.

Link: https://lore.kernel.org/20260902-fix-unaccount-mmap_prepare-v1-1-ea070189fdfb@kernel.org
Fixes: c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file callback")
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/vma.c b/mm/vma.c
index 35e7a64855fa..f29abb30956b 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -2859,10 +2859,12 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 	map.check_ksm_early = can_set_ksm_flags_early(&map);
 
 	error = __mmap_setup(&map, &desc, uf);
-	if (!error && have_mmap_prepare)
-		error = call_mmap_prepare(&map, &desc);
 	if (error)
 		goto abort_munmap;
+	if (have_mmap_prepare)
+		error = call_mmap_prepare(&map, &desc);
+	if (error)
+		goto unacct_error;
 
 	if (map.check_ksm_early)
 		update_ksm_flags(&map);

