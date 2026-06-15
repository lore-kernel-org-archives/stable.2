Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ACB402438
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 15:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781537665; cv=none; b=Tb2hbOKGrITIGEeF+d5GtxDu/7JANw4TfTdIvxPa1zu7EUnHE5eQqPIIximD/n8cjRtIAnIY8AoCLw7g8SW76g3PGrInsKcsB860JBnJ9bz+8MDlquKoet+pY+JAE0t9cigm+69fSoNyxD2OhCCShKUrqNFXvP/McMsI3a3SHZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781537665; c=relaxed/simple;
	bh=u4oSeovYu/yVCaaOtrmdnWBeVJRPvcPHt45wMnUEY5U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Lc/o8MUcfunimIkHdpgqvspOmyr4p/WNqAc/kwBJrCQ/pa6FQaFqo7oG0mfiyjsS2JemAg4Mcnw+Os1rQX1aNibrx5CzEzd/dQ5ONsdrxfkYCFc27dBYoPL/yd0W6igHm+2IaltMZxSGab+pkMh2vOfTgtu/YEEdURF9liQ/xfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CtXHC/0B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CtXHC/0B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0901F000E9;
	Mon, 15 Jun 2026 15:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781537664;
	bh=8i7eSPpEpIzyI0Ak44RoZ7iMh4yga+a59dh5nrvqrdw=;
	h=Subject:To:Cc:From:Date;
	b=CtXHC/0BKiT3CBEPBt/VsT4KFGeFmS6HAUGyVryEqXaA+F11ospzIdtCpUkCy6XNT
	 EjKJ7hQqysspd9oa+pxVe4Y7+B36LBzCKrfXZBB1lDCqypqIWLaTHudB5XoVN9GBfK
	 t6AMXZJeS4uIMFu0T+6DLWmGGtzBTW1V15prX+ZI=
Subject: FAILED: patch "[PATCH] misc: fastrpc: fix DMA address corruption due to find_vma" failed to apply to 5.10-stable tree
To: moonafterrain@outlook.com,danisjiang@gmail.com,dmitry.baryshkov@oss.qualcomm.com,gregkh@linuxfoundation.org,srini@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 16:59:42 +0200
Message-ID: <2026061542-daybreak-anemic-ed9c@gregkh>
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
git cherry-pick -x 464c6ad2aa16e1e1df9d559289199356493d1e00
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061542-daybreak-anemic-ed9c@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 464c6ad2aa16e1e1df9d559289199356493d1e00 Mon Sep 17 00:00:00 2001
From: Junrui Luo <moonafterrain@outlook.com>
Date: Sat, 30 May 2026 21:45:26 +0100
Subject: [PATCH] misc: fastrpc: fix DMA address corruption due to find_vma
 misuse

fastrpc_get_args() uses find_vma() to look up the VMA for a user-provided
pointer and compute a DMA address offset. When the address falls in a gap
before the returned VMA, (ptr & PAGE_MASK) - vma->vm_start underflows,
corrupting the DMA address sent to the DSP.

Replace find_vma() with vma_lookup(), which returns NULL when the address
is not contained within any VMA.

Cc: stable@vger.kernel.org
Fixes: 80f3afd72bd4 ("misc: fastrpc: consider address offset before sending to DSP")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
Link: https://patch.msgid.link/20260530204528.116920-3-srini@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 48f8262af539..cca7489605c5 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1090,7 +1090,7 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 			pages[i].addr = ctx->maps[i]->dma_addr;
 
 			mmap_read_lock(current->mm);
-			vma = find_vma(current->mm, ctx->args[i].ptr);
+			vma = vma_lookup(current->mm, ctx->args[i].ptr);
 			if (vma)
 				pages[i].addr += (ctx->args[i].ptr & PAGE_MASK) -
 						 vma->vm_start;

