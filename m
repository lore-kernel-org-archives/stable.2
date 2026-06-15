Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5726401A3B
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 15:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781536851; cv=none; b=Jw5ko4U0lXYu5SwIY3JeaShz7XodZaZvf5OePzvx/MgnoxIwOO8OPeaqxa3DfAswb3xy0lJjSvzX1GTUubm8gVxhs2FJTlT/UOYGP/KEd9zezT+mD3zW9HKyiyLe7xJB/9YmiPiTsBm9c9IO7xbrs9313odiA+A+qwBrsxSiFAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781536851; c=relaxed/simple;
	bh=SsVoKSAo8l53XfO0ODz7+AIXmpXTb8YmXeilWEEFMjY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oiE1YSwHB8/O1SBv/z2lHIxauqkU+qWdwmychivJqp9Ihd4hgfuAng/JeuObrbCLRXR5UxHWLq31Voipyaht8iGaAu/pquxoC62LB5xdIrpbRym73hIPPbttKIh9+aoKTw49wV7gyRzloLq+HH9v1r2H9J551PyelZgYM0Vt/RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eb0zMxrX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eb0zMxrX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEDCC1F000E9;
	Mon, 15 Jun 2026 15:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781536850;
	bh=jDLU5ra6NEWPt7DstHb4i5yku0zLwZiqWhoEBUx1EJw=;
	h=Subject:To:Cc:From:Date;
	b=eb0zMxrXziIxVFVf+SVCqfsjjP/fAMT1dNrh1HAqkzBg/w2QPFxvLpq+h2XXGyMZ4
	 h/Vx6J73y7TgqYoorYZ/D/QZck1yy4ppnlzpleu5wi0HjlaT+sx6mZbnESKus9gQh4
	 iajWgEKDJ0jaQF7kX7b/M2KbX5tAd3oX80+oVVxM=
Subject: FAILED: patch "[PATCH] misc: fastrpc: Fix NULL pointer dereference in rpmsg callback" failed to apply to 5.10-stable tree
To: mukesh.ojha@oss.qualcomm.com,andersson@kernel.org,gregkh@linuxfoundation.org,srini@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 16:48:34 +0200
Message-ID: <2026061534-unlikable-frolic-167a@gregkh>
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
git cherry-pick -x 5401fb4fe10fac6134c308495df18ed74aebb9c4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061534-unlikable-frolic-167a@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5401fb4fe10fac6134c308495df18ed74aebb9c4 Mon Sep 17 00:00:00 2001
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Sat, 30 May 2026 21:45:27 +0100
Subject: [PATCH] misc: fastrpc: Fix NULL pointer dereference in rpmsg callback

A NULL pointer dereference was observed on Hawi at boot when the DSP
sends a glink message before fastrpc_rpmsg_probe() has completed
initialization:

  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000178
  pc : _raw_spin_lock_irqsave+0x34/0x8c
  lr : fastrpc_rpmsg_callback+0x3c/0xcc [fastrpc]
  ...
  Call trace:
   _raw_spin_lock_irqsave+0x34/0x8c (P)
   fastrpc_rpmsg_callback+0x3c/0xcc [fastrpc]
   qcom_glink_native_rx+0x538/0x6a4
   qcom_glink_smem_intr+0x14/0x24 [qcom_glink_smem]

The faulting address 0x178 corresponds to the lock variable inside
struct fastrpc_channel_ctx, confirming that cctx is NULL when
fastrpc_rpmsg_callback() attempts to take the spinlock.

There are two issues here. First, dev_set_drvdata() is called before
spin_lock_init() and idr_init(), leaving a window where the callback
can retrieve a valid cctx pointer but operate on an uninitialized
spinlock. Second, the rpmsg channel becomes live as soon as the driver
is bound, so fastrpc_rpmsg_callback() can fire before dev_set_drvdata()
is called at all, resulting in dev_get_drvdata() returning NULL.

Fix both issues by moving all cctx initialization ahead of
dev_set_drvdata() so the structure is fully initialized before it
becomes visible to the callback, and add a NULL check in
fastrpc_rpmsg_callback() as a guard against any remaining window.

Fixes: f6f9279f2bf0 ("misc: fastrpc: Add Qualcomm fastrpc basic driver model")
Cc: stable@vger.kernel.org
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
Link: https://patch.msgid.link/20260530204528.116920-4-srini@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index cca7489605c5..47cf3d21b51d 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2460,7 +2460,6 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 
 	kref_init(&data->refcount);
 
-	dev_set_drvdata(&rpdev->dev, data);
 	rdev->dma_mask = &data->dma_mask;
 	dma_set_mask_and_coherent(rdev, DMA_BIT_MASK(32));
 	INIT_LIST_HEAD(&data->users);
@@ -2469,6 +2468,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	idr_init(&data->ctx_idr);
 	data->domain_id = domain_id;
 	data->rpdev = rpdev;
+	dev_set_drvdata(&rpdev->dev, data);
 
 	err = of_platform_populate(rdev->of_node, NULL, NULL, rdev);
 	if (err)
@@ -2542,6 +2542,9 @@ static int fastrpc_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
 	if (len < sizeof(*rsp))
 		return -EINVAL;
 
+	if (!cctx)
+		return -ENODEV;
+
 	ctxid = ((rsp->ctx & FASTRPC_CTXID_MASK) >> 4);
 
 	spin_lock_irqsave(&cctx->lock, flags);

