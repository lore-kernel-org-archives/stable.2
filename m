Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795542439;
	b=Xw19gWLwsI1ZJfhVgzHsGZ0LUw26EEUBSbOn7CQnwrTwUGbFTjQa7V19ALuttGhBmBmX
	 G+X1sk44Eo949XHMD1ACHBSPpFF/4NVNSmxGhPibKmbDb171Rh2/ipDJz3cxBQq2yVfXF
	 Vz6Epo25AlN9m1SDb9NHlAtQ/kWckkByLlNz+7nd/EgO7JMRubBLYOlLhiZVY33t+7uXR
	 NieWQuK0U0RPKnJOCtO+15xDR/WOz7kkK6UrJHe9Yz5KJaJv/YL5ebWBpQAz56o/bLw1a
	 pwHoUKEz+HEkFA7sEUzmEIriE3SvXOdXGw2ChFyw496cKCzLS9Wr1J0blgIqPMq9xxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795542439;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:Received:From:In-Reply-To:
	 References:MIME-Version:Date:X-Gmail-Original-Message-ID:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=zddTylz8qiVh2ypmdVkH2gu5RcJeF+l5NRl7cFaw7gE=;
	b=dPGDjZ6i+CAjU5aV8umfW9+uG+t2OYsBFKWtwXFSu965uRmZ0GZKdTlOsinqvUxSkM4O
	 vk5XFvGMDnY8wCFno5TSlBGi2bbQtyPhcBwKAjDSxFD6jorAuMWR2JKLUlx1Dy7ThfeD1
	 jkDOJeh9DJ6zJPkbpc/ir1ae0aJ+UMrhfbc70qO1NcdHHNMBrfIz1NgWMAq+ja7AAt+of
	 RZ1bRCPiMXi71lMKWq2sRGzYsBUZhGDjF3CEpaiCajgYtVHjv7mCitIdKQ7A7j/ZCaimn
	 Z5iftU0ySnKRNSioP7bpKM6PwqQdQ4uohOl2t151TDVijLtPgPUGzZqbUTGdGhM6eqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=WXqtd4eb;
	arc=none smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0B2606A32E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 17:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D0B2606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=WXqtd4eb
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c516a574bffso438874266b.3
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 09:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1795542437; x=1796147237; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zddTylz8qiVh2ypmdVkH2gu5RcJeF+l5NRl7cFaw7gE=;
        b=WXqtd4ebrNM8Hnbmi24uztUsWFhHQjEYSym3ymwenK7rLZ5tm7jrunFmraAzTFhypY
         kWi6QBPGTrEG9HkF9lMvF5BmZkzerYCw2KTJYf7piXL1Or/O4omCGMyULJ6s3YXQ7vWO
         yfaSR9D0dkAi7YyM+WQ32El4ijC7I1Fo6eKZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795542437; x=1796147237;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zddTylz8qiVh2ypmdVkH2gu5RcJeF+l5NRl7cFaw7gE=;
        b=mn8gDbDEw1JCXeDcI0cvpMJ3s1fsRz3RPTC1ciIhZP0c/LeTCM/CGX3VjIvXe97dhK
         Ty6LsilgfSDMekcaNe/ljjSm2NgOT4nZ7VphSlQe+isuomzwDMwzgo2jAzRqjwtr6B1J
         /LgnDoPNCJe4fRRUJvCe91pBXl5juxm+Jft0iTgis9cfgXC1FGYd2WCexKkA17fcb4QD
         trK6p3PNSwC6Y5PLinp9cRDPEgz37rZDC64Icz1rZHuxmaGffDZbrkdLXv7JIslGpQZi
         Q3ZvSYB1QRlPYUjdAdWyjmizUvqUmNQkalba+WVIUrbMsxDsPTu5mRu35fcB1VS4Z41M
         Zdaw==
X-Forwarded-Encrypted: i=1; AL+hErHlMdkmxzKgmKTqnSxFp8N7h+glKgV+v8DmzGFvuGzO8ZUqDwhUeT8CDetI51+jJ1bWQAimU6M=@vger.kernel.org
X-Gm-Message-State: APuU4Z9orsTrZj/idjEdfS3/TuAAkmWoLgm4tlCQj/Gvs7grniL00lEF
	5fLgu6KX5z/cmuyoUoxySkBpLWWeClc/nSspsNCoe5UaV4od3ZA6TGltEw4SU/K9gD7CW9flbw1
	4zCSVg9nbhA==
X-Gm-Gg: AZFdTZfFkbL4yEg7NSylXhENJgDZaxCJGwCe4Ipd2Uq8vcUTOUzNIYUjGtCJl2oW82a
	B/woz1kDu8qQdtl4q8k87BwUxAYAW0K+vA9A7B4WU56q9tHTWeU2Y5tfgbCTLL2MdrWUtZtSzpT
	3XWKKSR5K34lBcJ0umf9ybvka8boY5xeiFZX0JAhidZmhM4Yq/0UjxvlfKmojy1AHi6GJVbAVU0
	QpGB1cUXF9224ShteDupVV98dBzZewcPjJXm6rPgT+8e3vML+d94Eg040jBWZmasmuQBVARF24C
	SYRvesHznAnNBKrwnyLUV1HKwBx3tFGtbLwdME3X+0MfaJ/k5ZzxnYzhBb6lZSFs8rse93p/eOS
	iZQjkaKac+SHwKrVRQMxgWh9arjJfYCDlttaKmcMz1zb4dOLIG8w7SqOuEe+USV0LtC4w349RoV
	RGT6BoMpnk95bjalCnDnGoJqEP2oQtpHF5iBjamcNUHduQ3LDShT05KSRFtkHCI4xp9tNiaFM+d
	cw+H+BkPZtPfA1roMNN9goqzk+Lg1HHxS3jOVIvkCGcQRgFd+DUTUThu246ctJHGKZkfJd+tn07
	HCdncT2Ir0B7pHZcgK4+u+lxoiveeGK2FNFbUzY8MphWbPmfg8si60fHADldQuFMtQBnc65xQbq
	XTe4=
X-Received: by 2002:a17:906:f59d:b0:c31:5bb8:4b3b with SMTP id a640c23a62f3a-c513a47d551mr1305003666b.2.1795542437350;
        Tue, 24 Nov 2026 09:47:17 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ad00232sm562939466b.12.2026.11.24.09.47.14
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 09:47:15 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c516a574bffso438858766b.3
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 09:47:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErG+AKxjymD0IAVFPVVkX5kmgKcMdQoz7qSv4L+cIMg8wYfELTH3rmHEelyQ7LU+5xJoFQZa52s=@vger.kernel.org
X-Received: by 2002:a17:907:6091:b0:c3e:f39b:2286 with SMTP id
 a640c23a62f3a-c513a25e36bmr1373884966b.0.1795542434448; Tue, 24 Nov 2026
 09:47:14 -0800 (PST)
Received: from 425495914135 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 24 Nov 2026 11:47:13 -0600
From: Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <CAHk-=wgYc9vFEmyV0Ch_e49j6GOhUCMQMnMV4f1FLLvumZOmRw@mail.gmail.com>
References: <20261122-b4-sched-wait-intr-head-v2-0-4a764b64e8ce@columbia.edu>
 <20261122-b4-sched-wait-intr-head-v2-1-4a764b64e8ce@columbia.edu>
 <CAHk-=wj_eqNh+gNhCQh3exrL5Pmo5hbZBcL0W-4Ah_Nw0Kegzw@mail.gmail.com>
 <awWSwmvaTwBxfU-r@redhat.com> <CAHk-=wj3GCXZohdFWWPAOkC_LHno4X0oQW+0sQFJzRMvjpODUg@mail.gmail.com>
 <CAHk-=wgYc9vFEmyV0Ch_e49j6GOhUCMQMnMV4f1FLLvumZOmRw@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Tue, 24 Nov 2026 11:47:13 -0600
X-Gmail-Original-Message-ID: <CAHk-=wi4z0tv+1KLCec4xmctgzK8TzDOBDfPUo7cm7ixbGzdfA@mail.gmail.com>
X-Gm-Features: Aa3M54qUYvjHET6ZCUFf6jPslA74Mny1q3-g-c-Fn4dOshcSMOv9NPJMWy8y-3k
Message-ID: <CAHk-=wi4z0tv+1KLCec4xmctgzK8TzDOBDfPUo7cm7ixbGzdfA@mail.gmail.com>
Subject: [PATCH 6/7] sched/wait: remove __add_wait_queue_entry_tail()
To: Oleg Nesterov <oleg@redhat.com>
Cc: mt4022@columbia.edu, Jens Axboe <axboe@kernel.dk>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Michal Nazarewicz <mina86@mina86.com>, Wen Yang <wen.yang@linux.dev>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tz2294@columbia.edu, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 23 Nov 2026 16:56:58 -0800
Subject: [PATCH 6/7] sched/wait: remove __add_wait_queue_entry_tail()

__add_wait_queue() and __add_wait_queue_entry_tail() are now the same.

Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 block/blk-iocost.c                   | 2 +-
 drivers/gpu/drm/i915/i915_sw_fence.c | 2 +-
 fs/orangefs/orangefs-bufmap.c        | 2 +-
 include/linux/wait.h                 | 7 +------
 kernel/locking/percpu-rwsem.c        | 2 +-
 kernel/sched/wait.c                  | 8 ++++----
 mm/filemap.c                         | 6 +++---
 7 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 0ffe34bd95b7..f435bb894d71 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2764,7 +2764,7 @@ iocg_handle_over_budget(struct rq_qos *rqos,
struct ioc_gq *iocg,
 	wait->abs_cost = abs_cost;
 	wait->committed = false; /* will be set true by waker */

-	__add_wait_queue_entry_tail(&iocg->waitq, &wait->wait);
+	__add_wait_queue(&iocg->waitq, &wait->wait);
 	iocg_kick_waitq(iocg, ioc_locked, now);
 	return action_wait;
 }
diff --git a/drivers/gpu/drm/i915/i915_sw_fence.c
b/drivers/gpu/drm/i915/i915_sw_fence.c
index f24f616e23ee..e107ba9d4c24 100644
--- a/drivers/gpu/drm/i915/i915_sw_fence.c
+++ b/drivers/gpu/drm/i915/i915_sw_fence.c
@@ -382,7 +382,7 @@ static int __i915_sw_fence_await_sw_fence(struct
i915_sw_fence *fence,

 	spin_lock_irqsave(&signaler->wait.lock, flags);
 	if (likely(!i915_sw_fence_done(signaler))) {
-		__add_wait_queue_entry_tail(&signaler->wait, wq);
+		__add_wait_queue(&signaler->wait, wq);
 		pending = 1;
 	} else {
 		i915_sw_fence_wake(wq, 0, signaler->error, NULL);
diff --git a/fs/orangefs/orangefs-bufmap.c b/fs/orangefs/orangefs-bufmap.c
index a557e1cf7436..34195f2cd845 100644
--- a/fs/orangefs/orangefs-bufmap.c
+++ b/fs/orangefs/orangefs-bufmap.c
@@ -48,7 +48,7 @@ static void run_down(struct slot_map *m)
 	if (m->c != -1) {
 		for (;;) {
 			if (likely(list_empty(&wait.entry)))
-				__add_wait_queue_entry_tail(&m->q, &wait);
+				__add_wait_queue(&m->q, &wait);
 			set_current_state(TASK_UNINTERRUPTIBLE);

 			if (m->c == -1)
diff --git a/include/linux/wait.h b/include/linux/wait.h
index bf0a3713ed0f..4f87ad870f51 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -184,16 +184,11 @@ __add_wait_queue_exclusive(struct
wait_queue_head *wq_head, struct wait_queue_en
 	list_add(&wq_entry->entry, &wq_head->head);
 }

-static inline void __add_wait_queue_entry_tail(struct wait_queue_head
*wq_head, struct wait_queue_entry *wq_entry)
-{
-	list_add_tail(&wq_entry->entry, &wq_head->head);
-}
-
 static inline void
 __add_wait_queue_entry_tail_exclusive(struct wait_queue_head
*wq_head, struct wait_queue_entry *wq_entry)
 {
 	wq_entry->flags |= WQ_FLAG_EXCLUSIVE;
-	__add_wait_queue_entry_tail(wq_head, wq_entry);
+	__add_wait_queue(wq_head, wq_entry);
 }

 static inline void
diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
index 6c78961fe753..0e1b6e3210a2 100644
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -152,7 +152,7 @@ static void percpu_rwsem_wait(struct
percpu_rw_semaphore *sem, bool reader,
 	wait = !__percpu_rwsem_trylock(sem, reader);
 	if (wait) {
 		wq_entry.flags |= WQ_FLAG_EXCLUSIVE | reader * WQ_FLAG_CUSTOM;
-		__add_wait_queue_entry_tail(&sem->waiters, &wq_entry);
+		__add_wait_queue(&sem->waiters, &wq_entry);
 	}
 	spin_unlock_irq(&sem->waiters.lock);

diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index a14e14202279..c77f104ae2fb 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -33,7 +33,7 @@ void add_wait_queue_exclusive(struct wait_queue_head
*wq_head, struct wait_queue

 	wq_entry->flags |= WQ_FLAG_EXCLUSIVE;
 	spin_lock_irqsave(&wq_head->lock, flags);
-	__add_wait_queue_entry_tail(wq_head, wq_entry);
+	__add_wait_queue(wq_head, wq_entry);
 	spin_unlock_irqrestore(&wq_head->lock, flags);
 }
 EXPORT_SYMBOL(add_wait_queue_exclusive);
@@ -276,7 +276,7 @@ prepare_to_wait_exclusive(struct wait_queue_head
*wq_head, struct wait_queue_ent
 	spin_lock_irqsave(&wq_head->lock, flags);
 	if (list_empty(&wq_entry->entry)) {
 		was_empty = list_empty(&wq_head->head);
-		__add_wait_queue_entry_tail(wq_head, wq_entry);
+		__add_wait_queue(wq_head, wq_entry);
 	}
 	set_current_state(state);
 	spin_unlock_irqrestore(&wq_head->lock, flags);
@@ -335,7 +335,7 @@ EXPORT_SYMBOL(prepare_to_wait_event);
 int do_wait_intr(wait_queue_head_t *wq, wait_queue_entry_t *wait)
 {
 	if (likely(list_empty(&wait->entry)))
-		__add_wait_queue_entry_tail(wq, wait);
+		__add_wait_queue(wq, wait);

 	set_current_state(TASK_INTERRUPTIBLE);
 	if (signal_pending(current))
@@ -352,7 +352,7 @@ EXPORT_SYMBOL(do_wait_intr);
 int do_wait_intr_irq(wait_queue_head_t *wq, wait_queue_entry_t *wait)
 {
 	if (likely(list_empty(&wait->entry)))
-		__add_wait_queue_entry_tail(wq, wait);
+		__add_wait_queue(wq, wait);

 	set_current_state(TASK_INTERRUPTIBLE);
 	if (signal_pending(current))
diff --git a/mm/filemap.c b/mm/filemap.c
index a1b2ca5b933c..126f5b9849f4 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1293,7 +1293,7 @@ static inline int folio_wait_bit_common(struct
folio *folio, int bit_nr,
 	spin_lock_irq(&q->lock);
 	folio_set_waiters(folio);
 	if (!folio_trylock_flag(folio, bit_nr, wait))
-		__add_wait_queue_entry_tail(q, wait);
+		__add_wait_queue(q, wait);
 	spin_unlock_irq(&q->lock);

 	/*
@@ -1439,7 +1439,7 @@ void softleaf_entry_wait_on_locked(softleaf_t
entry, spinlock_t *ptl)
 	spin_lock_irq(&q->lock);
 	folio_set_waiters(folio);
 	if (!folio_trylock_flag(folio, PG_locked, wait))
-		__add_wait_queue_entry_tail(q, wait);
+		__add_wait_queue(q, wait);
 	spin_unlock_irq(&q->lock);

 	/*
@@ -1757,7 +1757,7 @@ static int __folio_lock_async(struct folio
*folio, struct wait_page_queue *wait)
 	wait->bit_nr = PG_locked;

 	spin_lock_irq(&q->lock);
-	__add_wait_queue_entry_tail(q, &wait->wait);
+	__add_wait_queue(q, &wait->wait);
 	folio_set_waiters(folio);
 	ret = !folio_trylock(folio);
 	/*
-- 
2.56.0.313.g975a75ca90
