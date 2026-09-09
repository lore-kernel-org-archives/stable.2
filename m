Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C39E54B1D4
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 12:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788955898; cv=none; b=qzCF7kpmSkI5Qs7ALTc1KSKlcHqA1+kMFrXL0Q6HmafY6tseI7bJw3neMb6KFYpRHP2CNiK9e9FgGqcO5R6oV8EOV53jT9/sVKOIzYsve2jR4l3uH4ZDHcVdK85IdLnDiEA89NEmNEP2KkMS886IdXpdKFimZDwGFRkYOoYoXhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788955898; c=relaxed/simple;
	bh=6jY0VN0hu8tp1VZ22cGfXjXcW4WeqXQLLNQ9VEmTOuU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=M6qONwmjmj09qUxNynT5weogIbOmU7wFVHh9nEny+ie73r37p3YACX2ETJ4Tar6XVL+gDttl5pNJNyr7gELLO7U9l8uZv4mU0V7ROQ/Q6aLB2xdOHo0OYjWCAtLmiWkQfQ/AwJp2IrMQ5DnAFPqNSo9Pee1kHiAWlzUTGRNH6nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zYmmN4P9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zYmmN4P9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2ED61F00A3A;
	Wed,  9 Sep 2026 12:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788955897;
	bh=Eu3TItCm7vRQo3mPHydrhfvJwSsIrL//Y9TYzA+OJz4=;
	h=Subject:To:Cc:From:Date;
	b=zYmmN4P9l2rODAKzEoMZMN8y3yk9jqS7uKTdFhMFHmT8rymICky8TeHRb+kC6Aubf
	 psIbSbCpXWJXbbPeUUTQC5NuXAg4M7YPxGbzD1+gUQa+TMSY7bFBlB8qmdkun2hYKJ
	 /8QdM96XolgDEXEjqi0CTAwqhNSXNZUY7qft2oy0=
Subject: FAILED: patch "[PATCH] drm/nouveau: unsubscribe the channel-kill event before the" failed to apply to 5.10-stable tree
To: marek@czernohous.de,lyude@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 14:08:32 +0200
Message-ID: <2026090932-swab-frostlike-a716@gregkh>
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
git cherry-pick -x 511585987d27d8cb668acebd399fc4deda23404c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090932-swab-frostlike-a716@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 511585987d27d8cb668acebd399fc4deda23404c Mon Sep 17 00:00:00 2001
From: Marek Czernohous <marek@czernohous.de>
Date: Thu, 13 Aug 2026 01:13:27 +0200
Subject: [PATCH] drm/nouveau: unsubscribe the channel-kill event before the
 fence context

nouveau_channel_del() tears the fence context down first and only drops
the channel-kill subscription later, in the middle of the nvif object
teardown:

	if (chan->fence)
		nouveau_fence(chan->cli->drm)->context_del(chan);
	...
	nvif_object_dtor(&chan->vram);
	nvif_event_dtor(&chan->kill);

The subscribed handler is nouveau_channel_killed(), which calls
nouveau_channel_kill() and from there nouveau_fence_context_kill() on
chan->fence. A kill event delivered in that window takes fctx->lock and
walks fctx->pending on a fence context that context_del() has already
freed.

Nothing reaches this below Fermi today, because the subscription is
gated on FERMI_CHANNEL_GPFIFO and nothing kills a channel there. On
Fermi and newer the window is real but narrow, since a kill has to land
exactly while the channel is being destroyed. That is reason enough on
its own, which is why this carries a Fixes: tag. The last patch in this
series subscribes Tesla channels as well; nothing kills those today, so
it does not widen the exposure now, but it is the groundwork for a
recovery path that would, and the ordering is better fixed before that
lands than alongside it.

Drop the subscription before anything it depends on is torn down.

Fixes: ea13e5abf807 ("drm/nouveau: signal pending fences when channel has been killed")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Marek Czernohous <marek@czernohous.de>
Fixes: ea13e5abf807 ("drm/nouveau: signal pending fences when channel has been killed")
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
Link: https://patch.msgid.link/20260812231330.705425-2-mczernohous@gmail.com

diff --git a/drivers/gpu/drm/nouveau/nouveau_chan.c b/drivers/gpu/drm/nouveau/nouveau_chan.c
index 598513f60449..f142f6310596 100644
--- a/drivers/gpu/drm/nouveau/nouveau_chan.c
+++ b/drivers/gpu/drm/nouveau/nouveau_chan.c
@@ -90,6 +90,14 @@ nouveau_channel_del(struct nouveau_channel **pchan)
 {
 	struct nouveau_channel *chan = *pchan;
 	if (chan) {
+		/*
+		 * Drop the kill-event subscription first.  Its handler
+		 * dereferences chan->fence, which the fence context teardown
+		 * below frees, so leaving it armed across the teardown leaves
+		 * a window for a use-after-free.
+		 */
+		nvif_event_dtor(&chan->kill);
+
 		if (chan->fence)
 			nouveau_fence(chan->cli->drm)->context_del(chan);
 
@@ -100,7 +108,6 @@ nouveau_channel_del(struct nouveau_channel **pchan)
 		nvif_object_dtor(&chan->nvsw);
 		nvif_object_dtor(&chan->gart);
 		nvif_object_dtor(&chan->vram);
-		nvif_event_dtor(&chan->kill);
 		nvif_object_dtor(&chan->user);
 		nvif_mem_dtor(&chan->mem_userd);
 		nouveau_vma_del(&chan->sema.vma);

