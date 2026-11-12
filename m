Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794472223;
	b=dheMQEhUXm8prvi0JXC+8Bh+/kP6keeEL5S00kzZqhxduMmbO+XTWUJlcsY+cdCwzh0s
	 9rovdVWkIXMcH28CRbIVJbEwAWaJto5FtjoWoaaRmACxjXNLLR7EJq+DKJbQ7SHLp0A/j
	 AYsTrYZmH3EBAUzTGW5TABlk/hxMyzOePDE/udWPG+e0xmmEZjF+VEhIQ7TjMxhwOu+ta
	 +J7Zr73h98EiLoMKxNX6k27NH7H6P2CXBSzZ97HQ6Nt6ozJfB+eXmsAwgV61MChK0mJgs
	 XJ/oHK/JB9VXp7XYdVv0yPsqW9FJXUb4Q41KomH4wohEUbdh4Wul3TJuHnEDWL8Asdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472223;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=OSTNIrY+8IxXt3dhZzOm6LY8pqoJLknza8v+XFe9PhQ=;
	b=FMt2Djcq6xH/DR4u4qrtKvQ2Qih16ERB7FPEZbQd7zaH2/JzhHkE0koUoHxNc8XZO6fY
	 3J4SMwjWg0f24OdzjLH4rrD+Pa5dOmYzi6FPuA3DQFKIHnNZzkWgN2zbN5+9UvuLiQQS9
	 PyhqUVb11s5P+F3u++Rn33pXkxRTDgfOiF9cVK60d1CxnihQmX/ZuwwpCdhO5VDAWtxtY
	 U0J9T14mC59UsIDYP4cIlrqpJhRFhAcN0rM1QIxjvfEsd0LZ/tqI0zWtfkeUjIqooax8I
	 KzhhWQzbBJfOhe7Bv0qNmwz5RpcydX7PV6Y+YM7dTGlYcTjzz28cbUSKJyqA+qyJ1Bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RHTeWUTr;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27977606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 08:30:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27977606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RHTeWUTr
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a599e9110eso3925495e9.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 00:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794472221; x=1795077021; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OSTNIrY+8IxXt3dhZzOm6LY8pqoJLknza8v+XFe9PhQ=;
        b=RHTeWUTr6PwUarzw1NfUR/IPAOcDcPU6FYcYlKu3hg0r3NN08zFW7/BhzjGtrgwfVV
         0//Zf6U4LyFlcw7sGI5fsGwJpJcS+Y7V9t3kPkG2BtvjTASeQihBJsLckBBG/DpbweLW
         A4EkzTKSLowoJQ/alPSwdXRHhnbswDB1JJHveY5RMmuK33Ztq7IRF45/xjIZwrmeCjXH
         AGg0Zaeut1fKMqXKwBr8zd7BjVnSkZSt31cHe8c7OX2LvuOAEx/vc9h4Wmec1gRgwEda
         kC6yBkIGPXNq4xkSloyXqZ3THAuoZSGwBE1TPB/OCc78XqBhmvkCgd9eBC7VxhGIFRFt
         0CSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794472221; x=1795077021;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OSTNIrY+8IxXt3dhZzOm6LY8pqoJLknza8v+XFe9PhQ=;
        b=dGTx7jqRjHJTqEQxVG9g0B1zV60PnuwQdAscov+GU6VKp0TurB1A5AKIJm6mMwLrNz
         vGs/suTQ9nqkfZVjIT130kcIwkPUkLliCWYdAYeBNNxpYyQLGmzH1RO1DNDL7oKNnF3J
         OT7bc5keJu6MLPja/H5+5Fbi1YXt1W3OeL4y9BCpCKLnMA+l3eoBGYhcYKdAWFGueYGF
         VuLakjGSryvpOk34p63cnYAUoOLd7IdqtxMR0y3iR7Of94Fabdn7rmLaufexUODDmfXD
         ArzjfbbIIk7FtuL2QwHYujCgT6lWFgh2CcLYcGzsrmqKjOgTJfPAk6r2Xfe6MXeWwNaQ
         0Zmw==
X-Gm-Message-State: APuU4Z8qfD4Fx605O+186D1Aw7CwNm0B1NKQ5kWbxKa5wxA0CZwOWnIg
	6yF4SkEoGdNMTxf01DL7Cg+nccTSdGWOJV7bfAwDDhcY0TJ6Je3RvMO95zjsgw==
X-Gm-Gg: AYBFou1tQqhFwQkby5toyQXzUh1aZA6Wm1NcT//QeoF8fVi7fJ3c3uXc2O/CqTMfr1P
	x/Qn9GiRHl6ZrDHFv6ALh6GW8tc/WIIDCy5ZSqRMGtr3aBtQxR66npS9AHl8lEWH49xDpuQInyu
	sl0tSZxD6lBRIbkTk0nck52rBHrWZ73DSLR3rRMPyw6yZrEcx1sU11s8UWj2UwnAjRHbS+BdkNc
	6ckUONBe6KL7KkUYikDr5rXfGWlkgXMzrxLoQmq4jY7AoMWLivGa2CMim0fxHr4Lf6IaaEZwl44
	VPRESA3ZQM8eIkD5OWfRRCSOJ5ekS2aBX8mPUxY36RA/6d3yH9FzcmwC4HfRMreUcVyrAYK+emp
	NCgrbC0qUjt8X0M9XTL7F9mFIiI5DzJg3OJq0FOK43WaVgAF8orropXEfAFt8VWanP74TXgm6rX
	FG7sp8tZUHS49Y2sy7iTu1rhI+INYjn9H3oDo+g5gOxpnfabN1HC4mdIoTbmd3AUfxAfX8GQam8
	m/zegRSiD4vDN4w/2qAbNgk1PqHJ9kZd3VZDZfX0jXyiPPdCr9kLnuPjfdc/GxnJ7r7Vt38vw/q
	hQz6QTCjL48qfbmXd1cdE5i0kn1AaacxW3tZAxojgIprYLyA9MHlPiJJ/b2sTQQuW4cM27syZVq
	fKYDFjA==
X-Received: by 2002:a05:600c:1986:b0:4a1:7dcf:be1f with SMTP id 5b1f17b1804b1-4ba0934e57cmr82091045e9.1.1794472220223;
        Thu, 12 Nov 2026 00:30:20 -0800 (PST)
Received: from [127.0.0.1] (ip-109-193-028-127.um39.pools.vodafone-ip.de. [109.193.28.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0950f3casm74154915e9.3.2026.11.12.00.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 00:30:19 -0800 (PST)
From: Marek Czernohous <mczernohous@gmail.com>
To: stable@vger.kernel.org
Cc: Lyude Paul <lyude@redhat.com>
Subject: [PATCH 6.6.y] drm/nouveau: disable the fence uevent work instead of
 just cancelling it
Date: Thu, 12 Nov 2026 09:30:02 +0100
Message-ID: <179447220252.849346.18231918170218281434@gmail.com>
In-Reply-To: <20261107052816-failed-6.6-827eb9328eae@kernel.org>
References: <20261107052816-failed-6.6-827eb9328eae@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

From: Marek Czernohous <marek@czernohous.de>

commit 827eb9328eaed831d7cc426ac2705038a40835b6 upstream.

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
[ Backport note: linux-6.6.y carries the uevent work (commit
  39126abc5e20 reached 6.6.18) but not disable_work_sync(), which
  arrived in v6.10 with commit 86898fa6b8cd ("workqueue: Implement
  disable/enable for (delayed) work items").  As described above, drain
  the work a second time after nvif_event_dtor() instead: once
  nvkm_event_ntfy_remove() has returned, no handler can start or still
  be running, so nothing can re-queue the work past that point.  The
  first drain is left in place. ]
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Marek Czernohous <marek@czernohous.de>
---
Sorry for the late reply.

As announced in the upstream commit message, this is the second-drain
variant for 6.6.y, which lacks disable_work_sync(). Compile- and
link-tested on 6.6.162 (nouveau.o, W=1): no warnings in nouveau_fence.c.
Not runtime tested: the race window cannot be hit on demand.

 drivers/gpu/drm/nouveau/nouveau_fence.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_fence.c b/drivers/gpu/drm/nouveau/nouveau_fence.c
index ee43a36f17..eb017bb8ea 100644
--- a/drivers/gpu/drm/nouveau/nouveau_fence.c
+++ b/drivers/gpu/drm/nouveau/nouveau_fence.c
@@ -106,6 +106,12 @@ nouveau_fence_context_del(struct nouveau_fence_chan *fctx)
 	cancel_work_sync(&fctx->uevent_work);
 	nouveau_fence_context_kill(fctx, 0);
 	nvif_event_dtor(&fctx->event);
+	/*
+	 * The event handler can re-queue uevent_work after the drain above.
+	 * nvif_event_dtor() has waited out any running handler and no new
+	 * one can start, so drain once more before the context goes away.
+	 */
+	cancel_work_sync(&fctx->uevent_work);
 	fctx->dead = 1;
 
 	/*
-- 
2.56.1

