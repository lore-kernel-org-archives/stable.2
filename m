Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F895437E3
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 12:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788955895; cv=none; b=lUwt6OoQDsVbI+ZSeRdtHKwrdI6aMr9gwjZE8VwGUfWAj9qcTtRMJ2fQ1gtYD1YeBXz2kr5jBqE3b2xPwLyvcUODFguSmRmbluh52nY8j2WUs1Wor9rF65+beLBIdi2bCb5xdIKZ0JNHwe6Sw6XrA28JwcW4aGh1+VvRh4MTkRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788955895; c=relaxed/simple;
	bh=soR/0S6t8FhYGd9qSBkCB5HwmOZTEir3eZnpWGs31io=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=U+L5UjDMFmCVzzuaDSWNuw2Vn3JU/YUGwOSkOjsuX8+GEwBfEEwgsSTkWmhsCOUcbsNKdR68ihtruEETMq+YO8CJ2D2w0UxK0Wcn7y4fZfgtI3CGHfvBGvrvKuIG5wdWOM4YgGEPtTu/eo2oRFO97kIEj97SqRUDxw59sOIxUWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pcelULVY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pcelULVY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0680D1F00A3A;
	Wed,  9 Sep 2026 12:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788955894;
	bh=kweT72867cwCaxTeHXRcF0/rcsmVwkzzoob1MYl2Qms=;
	h=Subject:To:Cc:From:Date;
	b=pcelULVYXHSWlyo/oKY1f8umBUfrRlGobbcs4eZ71BvbOGcDu21FHE+SOhLwsRHLr
	 9mm9q901l0sySxaJwoz8PDxRiHaXJoLkwPADE442DA+Uf2xh1owrNt9gvOTHe8kPmu
	 kN2Z8aTVuIYeb1DJEK8r0d2oERn/SuXHzeh5R2QU=
Subject: FAILED: patch "[PATCH] drm/nouveau: unsubscribe the channel-kill event before the" failed to apply to 6.6-stable tree
To: marek@czernohous.de,lyude@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 14:08:31 +0200
Message-ID: <2026090931-importer-stinging-410c@gregkh>
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
git cherry-pick -x 511585987d27d8cb668acebd399fc4deda23404c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090931-importer-stinging-410c@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

