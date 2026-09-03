Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EF92EEE9D;
	Thu,  3 Sep 2026 01:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788400494; cv=none; b=H8DE4nM3ndTLw1+b2URuJaGFt7xmCyoY2j3xgxEzXvdyoYoy/0A0cUr0oOWzVAHD2r5DYeb7a7rrGwbz6PoldxtvRlUo9smsR59Qf4wriRayQ6hcnhrTDKqjBssvk6/A6nGf/xpPoahxk+a0wgF3CjyGmnpHP0NyVEqJVV8ioKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788400494; c=relaxed/simple;
	bh=aLHhpEQdgO7uQWT/JcOunt2mxBPonGQ15ua7MBOAAM0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hko55H6Os/eEj6xAAl8pl697+0kNxT8sLITRNl9mh6dJFghUpeVFmOT3qCu9ZEXizEKK0Mj3m0NM9ij90yrE3rTD83rmlAYKErt9uBBlqobkKteI3zjbUxlwX4O2Otw6UbTSDdoj7/JFp5pDQxfemKwz+eB2/7NzOvWJfj0dMck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=yeawN7Gy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="yeawN7Gy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02EF1F000E9;
	Thu,  3 Sep 2026 01:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1788400492;
	bh=gHmtDEPfgNa8T8L87oSiVhjCoLBlb5om5vFe4YPpkQE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=yeawN7GyCWIsCaemmopXXvBAdCqRnHWmFWKvAp5QnCCQl6S6aD4DGWTYn2s0jrkl/
	 ZCt/+Et3K2+sLkhjDH2EOIVDnvL/ITKYlNtpy/RhUPPtcdv/2I7iHcxADslp9KZbSn
	 +ZRykQwCtAxPRZAwGvwwo7P8CEv3g83mPlN2SDoA=
Date: Wed, 2 Sep 2026 18:54:51 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: syzbot <syzbot+f12658786a4153df5113@syzkaller.appspotmail.com>
Cc: jannh@google.com, kunwu.chan@gmail.com, kunwu.chan@linux.dev,
 liam@infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lixinhai.lxh@gmail.com, ljs@kernel.org, pfalcato@suse.de,
 stable@vger.kernel.org, syzkaller-bugs@googlegroups.com, vbabka@kernel.org
Subject: Re: [syzbot] [mm?] WARNING in vma_set_pgoff
Message-Id: <20260902185451.5ba1a829a15bb2799d121bd1@linux-foundation.org>
In-Reply-To: <6a9896aa.e163c37b.143a1.000d.GAE@google.com>
References: <6a87853b.ae6ddae5.3da009.0023.GAE@google.com>
	<6a9896aa.e163c37b.143a1.000d.GAE@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 02 Sep 2026 14:35:38 -0700 syzbot <syzbot+f12658786a4153df5113@syzkaller.appspotmail.com> wrote:

> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    89a312991dc6 Merge tag 'cifs-fixes-7.3-rc2' of https://git..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=101ab0f9580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5e4e3a0e188a497e
> dashboard link: https://syzkaller.appspot.com/bug?extid=f12658786a4153df5113
> compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
> userspace arch: i386
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=151ec39e580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1761ef79580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/9e57f69218a4/disk-89a31299.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/c6ae7c71d018/vmlinux-89a31299.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/82fb8eee8abf/bzImage-89a31299.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+f12658786a4153df5113@syzkaller.appspotmail.com

Thanks.

> ------------[ cut here ]------------
> pgoff != vma->vm_start >> 12
> WARNING: mm/vma.h:277 at assert_sane_pgoff mm/vma.h:277 [inline], CPU#1: syz.0.17/5876
> WARNING: mm/vma.h:277 at vma_set_pgoff+0x246/0x2d0 mm/vma.h:283, CPU#1: syz.0.17/5876

AI tells me Lorenzo already fixed this with "mm/mremap: reset unfaulted
VMA page offset for MREMAP_DONTUNMAP".  This is presently in
mm-hotfixes-unstable so I'll send it in to Linus next week.

Err, make that this week.


#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Subject: mm/mremap: reset unfaulted VMA page offset for MREMAP_DONTUNMAP
Date: Tue, 25 Aug 2026 08:55:26 +0100

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
Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Cc: Jann Horn <jannh@google.com>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Li Xinhai <lixinhai.lxh@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/mremap.c |   22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

--- a/mm/mremap.c~mm-mremap-reset-unfaulted-vma-page-offset-for-mremap_dontunmap
+++ a/mm/mremap.c
@@ -1331,18 +1331,30 @@ static void dontunmap_complete(struct vm
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
_

