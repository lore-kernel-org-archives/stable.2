Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047298;
	b=w4s5BXFQjivWsZcsNAO3S3dZsULzeDBaA+3lrb/sMufL/ZwpnY9rzWKllnsQeDnPhUrA
	 lRwOloybjYUaZYLl8aBQmtI5ZBiT+kYxWc3pXMyDl94zt0msAeR7/J7n1CyEf4/CO7kkk
	 NNX29VNFE+otXuWl1VolD1rErOuMcmn8Hpk+F0sHLH/0pm7JaAnqVgky6In0Nk8hmznGo
	 Tw3uLbQSH9rHdOR85zXVXIYaSN0t567FrOrymhI6PC6s2d8kch8DMlQi80didZDIqvlRk
	 ep/nLBQtE3sJm8KTpWSWXfdOcM8DmTx6I9ZH8Y5iJ5qDQwtGVUy9EVHY98j+ANyiPiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047298;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=mPtNUB/gEOOYGiUuOhiglK4g8RPrMf8UlgKMA5cc1w4=;
	b=JoEOg3JaApiJRRZw4KtP/zyWJtxJRHRb3OHRYl8MyZkOibAtVQQkHf9vFS09B+mzn767
	 U3GtWiy9dwodNLJnUiIEFbGkjeDl0bMcyY3M+4rbRQXOtVLke2OKZa4tY/u/NUDTkiORj
	 ESpos76CCEJZT1Z8jMM+xDFw7oEiM+hnuBP2x4S3NuaHihrrjvWysS0nDfyOCt6sV8c0p
	 AXxmS1QWeIZ22Q4sjsSRm0FfrRD21HmKKMO1Vy76Iul6NhxaviUL0K36zHfP1IsymiWQj
	 jcLb49hwfPFezIdmnJ2Q5k/qc/YwbCmG4Ls/MviDTg/PRPssOAnbnl0OTbvDqnVBmjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c3zzSKDi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313C9606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c3zzSKDi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BCFE1F0089F;
	Sat,  7 Nov 2026 10:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047298;
	bh=mPtNUB/gEOOYGiUuOhiglK4g8RPrMf8UlgKMA5cc1w4=;
	h=From:To:Cc:Subject:Date;
	b=c3zzSKDiMpxC2yrIYo6md9Ph4GlngQhR9pPafu8xsvfiGZHKwhn7Hx1BCBrPNse3c
	 GF3fOePtRL20UdUHD+UWqA7wF378yUWnRGfW5NhZFdVkLCICRZs7R9577qoc3sjQ0j
	 dl+W7sWe8o1AiUwYX857iTjMNh5ywAUmDYuhfL1On4l0FZ++umvC4g2kUZA4sDrhFp
	 b6TTpKen7YW4P6e3QtNZdnMX//827r837p6O9l2CNtbnzv9t0GEn/4f1WY/qKLL5c6
	 OSjmxW0KiA6EKhp00N9ZO+E9AqC64bzjA888yhXAtPzoNZpoUUJMXEdBHOoFniuPZ2
	 8Kjr6vennmxDQ==
From: Sasha Levin <sashal@kernel.org>
To: marek@czernohous.de,
	sashiko-bot@kernel.org,
	lyude@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/nouveau: disable the fence uevent work instead of just cancelling it" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:28:16 -0500
Message-ID: <20261107052816-failed-6.6-827eb9328eae@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 827eb9328eaed831d7cc426ac2705038a40835b6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052816-failed-6.6-827eb9328eae@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 827eb9328eaed831d7cc426ac2705038a40835b6 Mon Sep 17 00:00:00 2001
From: Marek Czernohous <marek@czernohous.de>
Date: Sun, 16 Aug 2026 14:58:52 +0200
Subject: [PATCH] drm/nouveau: disable the fence uevent work instead of just
 cancelling it

nouveau_fence_context_del() drains the uevent work while the event that
feeds it is still armed:

	cancel_work_sync(&fctx->uevent_work);
	nouveau_fence_context_kill(fctx, 0);
	nvif_event_dtor(&fctx->event);

nouveau_fence_wait_uevent_handler() queues the work unconditionally:

	schedule_work(&fctx->uevent_work);
	return NVIF_EVENT_KEEP;

so a non-stall interrupt arriving after cancel_work_sync() has returned
re-arms the work that was just drained.  The window closes in two steps,
neither of which is the drain.  The kill blocks the event when the last
fence holding a notify_ref is signalled, which reaches
atomic_xchg(&ntfy->allowed, 0) (nvkm/core/event.c:104), and
nvkm_event_ntfy() skips a ntfy that is not allowed (:183).  That stops
further handlers from starting, but not one that is already inside
nvkm_event_ntfy(): the event is created with wait = false
(nouveau_fence.c:201), so nvkm_event_ntfy_block_() leaves it on the list
and never takes event->list_lock.  Only nvif_event_dtor() waits that one
out: nvkm_event_ntfy_del() (:141) goes through nvkm_event_ntfy_remove(),
which takes write_lock_irq() on that same list_lock (:84).

Either way the re-arm happens after the drain, and the caller drops its
reference immediately afterwards, for example nv84_fence_context_del():

	nouveau_fence_context_del(&fctx->base);
	chan->fence = NULL;
	nouveau_fence_context_free(&fctx->base);

That is a kref_put() on fctx->fence_ref, so the context outlives the
teardown only while emitted fences still hold a reference of their own.
That is no safety net: whenever none do, the count reaches zero right
there and nouveau_fence_context_put() kfree()s fctx while the work is
still queued.  &fctx->uevent_work is embedded in that allocation, so the
workqueue already dereferences freed memory when it picks the item up,
and nouveau_fence_uevent_work() can then take fctx->lock on it.  With
CONFIG_DEBUG_OBJECTS_WORK and CONFIG_DEBUG_OBJECTS_FREE, kfree() of a
still-queued work item is reported as the free of an active object.

On live memory the re-armed work has nothing left to do:
nouveau_fence_context_kill() empties fctx->pending and sets fctx->killed
under fctx->lock, nouveau_fence_emit() then returns -ENODEV rather than
queueing anything new, and nouveau_fence_update() only reaches
nvif_event_block() if it signalled something off that list.  The defect
is the access to freed memory, not what the work would have found.

Only chips from G84 on can reach this at all: nouveau_fence_context_new()
returns before nvif_event_ctor() when priv->uevent is clear, and
nv84_fence_create() is the only place that sets it.
nv84_fence_context_del() is the context_del for all of those, because
nvc0_fence_create() and gv100_fence_create() build on nv84_fence_create()
and override only context_new.

Use disable_work_sync() instead.  It drains the work exactly like
cancel_work_sync() does, and additionally increments the work item's
disable count, after which "any attempt to queue @work will fail and
return %false" (kernel/workqueue.c, disable_work()).  The handler's
schedule_work() then has nothing to re-arm, and the teardown order stays
as it is.

Draining a second time after nvif_event_dtor() would close the window as
well, and without the newer API: once nvkm_event_ntfy_remove() has
returned, no handler can start or still be running, so nothing re-arms
the work past that point.  disable_work_sync() is preferred here because
it needs one synchronisation point instead of two, it keeps the work
from being queued at all rather than cleaning up after it, and it is
what drm has settled on for this (drm/xe, drm/panthor, drm_pagemap).
Blocking the event rather than the work is not an option: fctx->event is
created with wait = false, so a handler already inside nvkm_event_ntfy()
can still queue the work.

Note for backports: disable_work_sync() arrived in v6.10 with
commit 86898fa6b8cd ("workqueue: Implement disable/enable for (delayed)
work items"), while the fix being corrected here reached 6.6.18 and
6.7.6.  linux-6.6.y therefore carries this bug without the API, and this
patch would apply there and then fail to build.  A 6.6.y backport wants
the second drain described above instead, as its own patch.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260812233022.159301F000E9@smtp.kernel.org/
Fixes: 39126abc5e20 ("nouveau: offload fence uevents work to workqueue")
Cc: <stable@vger.kernel.org> # 6.10.x
Assisted-by: Claude:claude-opus-5
Signed-off-by: Marek Czernohous <marek@czernohous.de>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
Link: https://patch.msgid.link/178688513268.513871.3468844663561639695@gmail.com
---
 drivers/gpu/drm/nouveau/nouveau_fence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_fence.c b/drivers/gpu/drm/nouveau/nouveau_fence.c
index edbe9e08ba0fd..11e95c37ce506 100644
--- a/drivers/gpu/drm/nouveau/nouveau_fence.c
+++ b/drivers/gpu/drm/nouveau/nouveau_fence.c
@@ -96,7 +96,7 @@ nouveau_fence_context_kill(struct nouveau_fence_chan *fctx, int error)
 void
 nouveau_fence_context_del(struct nouveau_fence_chan *fctx)
 {
-	cancel_work_sync(&fctx->uevent_work);
+	disable_work_sync(&fctx->uevent_work);
 	nouveau_fence_context_kill(fctx, 0);
 	nvif_event_dtor(&fctx->event);
 	fctx->dead = 1;
-- 
2.53.0




