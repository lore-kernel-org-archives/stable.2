Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273A04EFFB8
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 09:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790070247; cv=none; b=hIvjoiHwFOU74k+r8ZFUT/zELRZdjtMrDu9lx87dP/1biRolwGuEXzkakfPwG3iRfJBFdGAKPDmqUV1InMfkJpWZJNGVguSB3vxOmtuzVAn2OdDg7XjKGxov3Twjp6S+eT+hqTyWpXU7cQe3jSbDBBwA7rGiE2vwdXa9bbTSb+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790070247; c=relaxed/simple;
	bh=bwM16G+udof/EhTKrNgwx0TykAQmi5hrd1Fp2hCII5w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Task5CFo7rcfG1XxuldMSFnOsfErty+E39Pjc9ge91oKw3/oxKybDryb5vJj4I7F8RuEyk7TVWQvPngoD+llu1+YbakZaiqcZfRpstLnu7OWruWptdLuNhZ0qZTbk2POaioXIEy07RccdNfXp3hLRpAwL/sL7S1mIMf7ZxE7JOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wBBeIEPJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wBBeIEPJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127721F000FF;
	Tue, 22 Sep 2026 09:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790070244;
	bh=iKwrMD8b1W1RooHweon41LoOOQ/ipbDksP3qMMhCqFQ=;
	h=Subject:To:Cc:From:Date;
	b=wBBeIEPJTCwtyiZ8HVwre7YPRvZgGLTD9FzlrjBOedg9gG/brpjomvdUfylY4WTyF
	 2kn8nfosiSWUiMssvTju135803FLavK5A6FF3afiFyWyTp9l4NCDX4GVkDPy8Qee/a
	 4niqDm/tdMf0A9jZoQh8RStx/oTK4eFGwXKrT7u0=
Subject: FAILED: patch "[PATCH] IB/hfi1: Resolve the credit-return buffer through the send" failed to apply to 6.1-stable tree
To: jyohuku.alterego@gmail.com,leon@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 11:40:06 +0200
Message-ID: <2026092205-wobble-lusty-9a31@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 975396b9e5a4028e649f4b9a6a5ca5dfb76a824b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092205-wobble-lusty-9a31@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 975396b9e5a4028e649f4b9a6a5ca5dfb76a824b Mon Sep 17 00:00:00 2001
From: Shuhei Takeshita <jyohuku.alterego@gmail.com>
Date: Sun, 9 Aug 2026 12:27:42 +0900
Subject: [PATCH] IB/hfi1: Resolve the credit-return buffer through the send
 context's node

hfi1_file_mmap()'s PIO_CRED case derives this context's credit-return
page offset, and the DMA handle for it, from dd->cr_base[uctxt->numa_id].
uctxt->numa_id is the node of whichever CPU the process happened to be
running on, but the entry itself lives in the credit-return allocation of
the send context's own node:

	sc->hw_free = &sc->dd->cr_base[sc->node].va[gc].cr[index];

and user send contexts are allocated with sc_alloc(dd, SC_USER, ...,
dd->node), the HFI-local node.  On a multi-socket host with the process
running off that node the two allocations differ, so the subtraction
produces an offset into an unrelated buffer and the DMA handle belongs to
the wrong allocation.

Use the send context's own node for all three references.  The
continuation lines are reindented at the same time; they mixed spaces and
tabs.

Fixes: 7724105686e7 ("IB/hfi1: add driver files")
Cc: stable@vger.kernel.org
Signed-off-by: Shuhei Takeshita <jyohuku.alterego@gmail.com>
Link: https://patch.msgid.link/20260809032743.2671579-2-jyohuku.alterego@gmail.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>

diff --git a/drivers/infiniband/hw/hfi1/file_ops.c b/drivers/infiniband/hw/hfi1/file_ops.c
index dc548e6802e2..72c21d7455fd 100644
--- a/drivers/infiniband/hw/hfi1/file_ops.c
+++ b/drivers/infiniband/hw/hfi1/file_ops.c
@@ -382,10 +382,10 @@ static int hfi1_file_mmap(struct file *fp, struct vm_area_struct *vma)
 		 * of enabled contexts > 64 and 128 respectively).
 		 */
 		cr_page_offset = ((u64)uctxt->sc->hw_free -
-			  	     (u64)dd->cr_base[uctxt->numa_id].va) &
-				   PAGE_MASK;
-		memvirt = dd->cr_base[uctxt->numa_id].va + cr_page_offset;
-		memdma = dd->cr_base[uctxt->numa_id].dma + cr_page_offset;
+				  (u64)dd->cr_base[uctxt->sc->node].va) &
+				 PAGE_MASK;
+		memvirt = dd->cr_base[uctxt->sc->node].va + cr_page_offset;
+		memdma = dd->cr_base[uctxt->sc->node].dma + cr_page_offset;
 		memlen = PAGE_SIZE;
 		flags &= ~VM_MAYWRITE;
 		flags |= VM_DONTCOPY | VM_DONTEXPAND;

