Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6A3349CF0
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 09:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791882154; cv=none; b=L5e+eY1JYhcZ0ow2Cj/YJbt+WYd3DVoAEuIanrJbOyZBTEn3bITSzq9bMe/F0Sr8Dbazn+2BX1wRlGqlJcdHNNJk591EZgqJJyp3toi2RLaV5cp9dZmSWXmL0hUdTNsHIS4ADtYuUkvjpBv8B3YDq54BB5iHovN5+/k0Z+os7eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791882154; c=relaxed/simple;
	bh=BvEydwlc8/td6/sy8cQ8BY25Jx9eOqFIF3aXqYyOBCo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SSzRrJJMR5TwZq9J14KnU/ZRuH9NRji0XpCdJW1nZ1r2Wc8nH5l7GvyWii8PDQYdZieM4D2rir2GQjn3lVLXsnN+CWJ06gAX/jsJBQ32ObLOyEOSz03yo6eK2iBkDfQvz2NqCiRVPAaATbtL4rIs1JJ0LnIDQHvbzvY0jyODnng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SH2xzQuu; arc=none smtp.client-ip=209.85.221.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SH2xzQuu"
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48c415561aaso1655650f8f.1
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 02:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791882151; x=1792486951; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6XndXt4WnkjBG+HEbSkFWOOVRpYsu25e8KIZ/tWatG4=;
        b=SH2xzQuugfDzjZ2G0w/vz+E0Mj0tCTCwkfun+4wyilGLUM3k2LNSvIxWKvR82oFHGx
         fv5zuLUaEqOH+QMaWQMyCgUGiEF6al2/Icw4CPVUwAUaA9xeULwsmPtdS6XGMc6Exrqr
         nH6saBWFU+BmrXl2pspOer8/3AxKhaX2YIP4Gx1Ws5Mf6cgQYHBbbEbG32tZDqP2S/G3
         mMCTRD4/FShOdAeDK9ImkJHGgQMY/kY0z8rqV4OE4To2DDJ/hmAkv0D0EcnVfCGUrGau
         61kSf/sNj1vGUf2JSdJduN8jNWG0Am/kcxRCZ4VTlRWiiEw2yZcE4uQduLXPgpJLgwjK
         al0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791882151; x=1792486951;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6XndXt4WnkjBG+HEbSkFWOOVRpYsu25e8KIZ/tWatG4=;
        b=FsAZwneG6QnmgkuRtqwAqY6qlYaz/wqVVl1di5w24ZELlv266AS3oYM5Wypf3N3MJX
         Uo4ekGywjFJiOchIWwCGf9Nx6Gej4W4igFbyWv3I+WLjNWOn7TynmBe7qhRHKv8GxRXu
         lQL/dKeCseAnXsgd+zs6G7+ytoNEJrWGQhrFIsJw9m7FqVixaUm7N3QRy2PG+RwB/5uL
         Hxte0Z9o4ubEGgT3geS6zExLiZz80zNFkn5Ldr/6L5WC+q1dnpC1HBX53p5y+r/jbP2r
         ZQ7CCoINOBG8FtLLjh/0OO5HPP7O/UWXkgfXzozWpr/aAfvkPoAxIzqgZAsb+oF7oHY7
         q7Lg==
X-Gm-Message-State: AFq9FYKwE9rzyH5aZmq9iVDTkW4cwYpYTrxiDgE4sHLbErfuscZs/7Fa
	RxxsC0ZLHuCGQ19qzD1E2yV3jmy4190NRwQrB/huzkfVZol6riT9P/W27ugiDCq/dv6SI0ZQHEx
	Yv1/HsDMcH5Rny2OTIFE62H5VKS5gAT4V+yK7vdcqefWzwhayPGB1uIC1PJvDr0QdfaD4FKA96h
	Zwny4zAWNHf+/CLlLzzb72TqgPEaQUtitUC3SV/pF2l/VWS8M=
X-Received: from wmbgz6.prod.google.com ([2002:a05:600c:8886:b0:4a1:96ee:9879])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3e07:b0:4a1:a009:9724 with SMTP id 5b1f17b1804b1-4a1a00997f1mr85035105e9.7.1791882150446;
 Tue, 13 Oct 2026 02:02:30 -0700 (PDT)
Date: Tue, 13 Oct 2026 09:02:24 +0000
In-Reply-To: <2026101233-atlantic-thwarting-31cc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2026101233-atlantic-thwarting-31cc@gregkh>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013090229.3584603-1-jpiecuch@google.com>
Subject: [PATCH 7.2.y] sched_ext: Call ops.dequeue() when a task arrives on a
 remote local DSQ
From: Kuba Piecuch <jpiecuch@google.com>
To: stable@vger.kernel.org
Cc: Kuba Piecuch <jpiecuch@google.com>, Andrea Righi <arighi@nvidia.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"

When a task in the BPF scheduler's custody is moved to another CPU's
local DSQ, ops.dequeue() is only called once the task is picked for
execution, from set_next_task_scx() with SCX_DEQ_CORE_SCHED_EXEC, even
though no core-sched pick took place. It should instead be called
without flags when the task is inserted into the destination DSQ, as it
is for same-rq dispatches.

move_remote_task_to_local_dsq() sets p->scx.sticky_cpu across the
migration so that deactivate_task() on the source rq doesn't end custody.
Since commit b75aaea24c9f ("sched_ext: Properly mark SCX-internal
migrations via sticky_cpu"), enqueue_task_scx() only clears it after
inserting the task, so task_leave_custody() still sees the migration in
progress and skips the custody exit.

Clear p->scx.sticky_cpu as soon as enqueue_task_scx() has read it, as
was done before that commit. The source side is unaffected.

Fixes: ebf1ccff79c4 ("sched_ext: Fix ops.dequeue() semantics")
Cc: stable@vger.kernel.org # 7.1.x: 18d62044cda7: sched_ext: Preserve rq tracking across local DSQ dispatch
Cc: stable@vger.kernel.org # 7.1.x
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Assisted-by: Claude:claude-opus-5.5
Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
(cherry picked from commit af701b8d3238b9eb7cd450b0491300452c700bf5)
[ jpiecuch: resolved context conflict, 7.2.y still names the function
  do_enqueue_task() rather than scx_do_enqueue_task() ]
Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
---
 kernel/sched/ext/ext.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index cd7cbd1c99a2..0a6002cdfe08 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2044,6 +2044,13 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int core_enq_
 	int sticky_cpu = p->scx.sticky_cpu;
 	u64 enq_flags = core_enq_flags | rq->scx.extra_enq_flags;
 
+	/*
+	 * An SCX-internal migration ends on arrival. Clear sticky_cpu so @p can
+	 * leave custody when inserted into the destination DSQ.
+	 */
+	if (sticky_cpu >= 0)
+		p->scx.sticky_cpu = -1;
+
 	/*
 	 * SCX_RQ_IN_WAKEUP promises a task_woken_scx() call once this enqueue
 	 * returns. Only the core's wakeup path delivers one. The flags stashed
@@ -2082,9 +2089,6 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int core_enq_
 		dl_server_start(&rq->ext_server);
 
 	do_enqueue_task(rq, p, enq_flags, sticky_cpu);
-
-	if (sticky_cpu >= 0)
-		p->scx.sticky_cpu = -1;
 out:
 	rq->scx.flags &= ~SCX_RQ_IN_WAKEUP;
 
-- 
2.56.0.385.gd3acb90ef8-goog

