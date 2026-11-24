Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795542395;
	b=WPVjVac5SPSsoPEYYRg687iWyKGKwfan1tQT/Wh3foJlMc3pNOgnqSynj+HKLjiVnl7N
	 rcS917VVcrvYrwBK7pHw44CvVfeT8Pzh9Bf1exQzlW/ILoye2pEKoMsXO5riD0YT6yja9
	 p2lnMMmn3w4JnZWtR9abm4Pgy5s8Y1UHulVQj3+R1CUcOacXVXsOyGNd/UPv4iXdgVn51
	 qqjG7MKFVrYQXlJYOCFSVYB+vhW9zqbidRAmbdDkF4inFbaKFfMaWD5C+4ji6KOtPpPIG
	 ziAIcVhqeamxA5wE+LOwya/pqGfCRCAppAPhmbq58XshmZbLcfKxKLrTB3PHn9oHixg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795542395;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:Received:From:In-Reply-To:
	 References:MIME-Version:Date:X-Gmail-Original-Message-ID:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=SQpKUtDlj4AZ1qDo3gcLs5ROWZFh7sOWq4cTgDCqyUA=;
	b=F2/bK9d7PtK5twzNDLyYQtlkVWvV2/Prd6nsMoJopiuFjpXi9hkOihPv8Ll5ivrCSAMc
	 VyBnpKhT0CfvfCM7zB185UFWDkFNLE2kXjPucbOFPeXM0yrLWVRDZeJlkBOob9Qj3ImTg
	 jDgao5T0SLnxCpesQu3xsa5ITpYkl/fS7YyRKlkl1hYUFhUBnVZEmTBndz8ykln2wv1ix
	 8Yr43bZfvErv6287uak7/LTrJ5V/N1WAkqgYOV9XN5QjP07vZxkm06T9LJuxsNL71v027
	 4+3VKJJYng3VRErpzPcshnoxGJc0SYDKtj2lT2Y4QZD/QBixJ+dLfMwJLtYINmFr3SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=VY3j1U8n;
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9464C606A329
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 17:46:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9464C606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=VY3j1U8n
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c51a02ad3acso74041366b.1
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 09:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1795542394; x=1796147194; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SQpKUtDlj4AZ1qDo3gcLs5ROWZFh7sOWq4cTgDCqyUA=;
        b=VY3j1U8n+qZEJ87j+i85Rht+OSsMOZCPHE9Pj3thiSEgnqgNUScHIdxC3bq2tJeOQR
         T8G0YvCm87zEJfjvDRfrHeRudiRbMghYS9gmBGDKG7Bhd+E4L2wPYE5Kcx35WQY6/tlS
         +KAUs7P0RmT4AvmtMlTSDsjFr1A6Jro2sanXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795542394; x=1796147194;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SQpKUtDlj4AZ1qDo3gcLs5ROWZFh7sOWq4cTgDCqyUA=;
        b=YiYg1c28OH2xROF7NSmCgCmDXtqqAqioj27uE7P2nrgHswdXnYrzH5b0g+bc762+P6
         cjkghmPx3NyHpctcHxECA2egk//OP73MV67jmAjI+9xG9KcrYJMz6aVbtS6KRMDluOkt
         wUgjBtop4bqGYBzn2XVmj/snWV1vr4HNsH2eij/kjX63VOBZ8UEAhnydUU2/L7O6Eh9d
         l+oY/Sjd7pMIbiFMuUYp+pYDW3frrBGqPfNmJRdJCyzUeAwnHOWelSH2/HXecw2WtotC
         y7In+p8ENLXGWkKsFO9ZwtQetmOD/lf8eNQfPOTPuCczT8VlODMTEZSAVYvUdhH6jXZy
         aB/w==
X-Forwarded-Encrypted: i=1; AL+hErHiONHWVrkgsuIValgNlH85ZXKPv1qjrBoZFjT9WDMH/TkcWMLMVWDeiTyYcYK4fNTUVCXHulQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9CaZw7dXuLelnUdUh/pfinzi72PQWc7vI+XP03TD2J/6io/KgX
	9IRlT67zeFewvmRcFlaFmDdr0Z8JriwxMUbLUU6dhmw5vaDIO0Rt5pgNPiN/D8fXE6jjSrrocux
	P0sxqv7VxUA==
X-Gm-Gg: AZFdTZct2TJZMhJZR5PSeqSLqLyKQk+7Nd4TIWa8i5Dbg9hweMMdP9Z7TXFkK4uP8Q4
	m7uen4NUq/7mafWb8RvlK73q4MLbl/Wur512thy8rCu17Sk0IWcBlQbe6dJunuN7AwVUHplPmdb
	Zai6ihEDdNQcbtIg9tJDsECdyFbJKc3cg45ktPfLZXgtNQeM9A0F/WDTlJSGz5icFpww3ha77bk
	tdtlQ9QMS6yMbPjojWKvI1vY4X6tWYAfbqBPoFDSIRolSlCJJQDHy3jJIYEVRRya6LzN6R6aI1D
	XEE6tRBDSHts2y1bjSY5pYNX9vDGKPeot9UJUhsuaKVGO6SWEkym9058hTSeb3pEFx59+WWTcWG
	tI+0m36Kgw68Ep2OH9ObW7btJny1NkoHpZysvQVxRPBkAYCVWUnw5eUg3aM0U9AZ+IUovuugHJC
	DbZIBvVqCdG2HNxNqm3Nm2eM5xQG0Y7hs9vUdSFwfFWkGK/UFOmsKFnQ86V5v11NHcCYhvUUUaE
	cn5W/V+YzsbDnj+JSWFBtDqpNVhj6mkx0JEaLqYhdpcEUJfCAdx14MVbM3v0B3Ju2a9DDarJinH
	1UDlosl1PQgR0uZos3sYeruNFHbmq34AYoRyO6aEXw1BQNqFJPVauopa26yqinX7r6hdtrpYa4d
	utR4=
X-Received: by 2002:a17:906:b342:b0:c4d:2895:e492 with SMTP id a640c23a62f3a-c513a829d7emr928839766b.21.1795542393830;
        Tue, 24 Nov 2026 09:46:33 -0800 (PST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ad00d2asm564657266b.3.2026.11.24.09.46.31
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 09:46:33 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c51a02ad3acso74032366b.1
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 09:46:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErE81IIi/jKFTTxsdF4+p+l/l3G+K8UWH0zzpS+u3vCPcd6XYEsYdsh4T/IWdVkl/Bmn6XQwZZo=@vger.kernel.org
X-Received: by 2002:a17:907:3ccb:b0:c3f:84aa:af0d with SMTP id
 a640c23a62f3a-c513a811d6amr1255078566b.18.1795542391340; Tue, 24 Nov 2026
 09:46:31 -0800 (PST)
Received: from 425495914135 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 24 Nov 2026 12:46:30 -0500
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
Date: Tue, 24 Nov 2026 12:46:30 -0500
X-Gmail-Original-Message-ID: <CAHk-=wgNZfCN5qW-0pOK_TFBscqTu6an7fK5pEkxewg-Aif1Fg@mail.gmail.com>
X-Gm-Features: Aa3M54p8plLWbVY6iSjVP3DnYsEIL6S32qEa4KRav48BblCo7RxKY_YSzzQDIJA
Message-ID: <CAHk-=wgNZfCN5qW-0pOK_TFBscqTu6an7fK5pEkxewg-Aif1Fg@mail.gmail.com>
Subject: [PATCH 5/7] sched/wait: always queue new waiters at the tail
To: Oleg Nesterov <oleg@redhat.com>
Cc: mt4022@columbia.edu, Jens Axboe <axboe@kernel.dk>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Michal Nazarewicz <mina86@mina86.com>, Wen Yang <wen.yang@linux.dev>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tz2294@columbia.edu, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 23 Nov 2026 16:48:44 -0800
Subject: [PATCH 5/7] sched/wait: always queue new waiters at the tail

Non-exclusive waiters have been added at the head and exclusive ones at
the tail, so that an exclusive wakeup stopping early still woke every
non-exclusive waiter.

That only matters for waiters that mix both kinds on one queue like
read() and poll() on a pipe - and even then it doesn't actually buy
anything but complexity and fragility of the code.

An exclusive reader consumes the event, the poller had nothing to see,
so there's no real point in keeping the two ordered.

The pointless ordering results in a special rule for everybody adding
themselves to the wait queue, and that rule has not been consistently
followed anyway (see for example do_wait_intr() and do_wait_intr_irq())

So just queue everyone in FIFO order.  LIFO might be better for
throughput, but every time we've ever tried that optimization in real
life, it has caused fairness issues, so let's just do the obvious thing
and add new waiters at the end of the list.

Priority entries (used by the hypervisor code - questionable special
case) are still placed at the head by add_wait_queue_priority*().

And because epoll is a pile of stinking manure that I am afraid to touch
this leaves __add_wait_queue_exclusive() alone and it adds its entry at
the head for epoll's ep->wq so its own wakeup order doesn't change.

Now that it isn't a "real" exclusive wake event, its ordering thankfully
doesn't actually matter for anybody else.  It should be fixed, but it's
now basically just an internal epoll thing (and that will be made more
obvious in following patches).

Cc: Christian Brauner <brauner@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 include/linux/wait.h | 14 +++-----------
 kernel/sched/wait.c  | 29 ++++++++++++++++-------------
 2 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 09518f8ff10c..bf0a3713ed0f 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -171,25 +171,17 @@ extern void remove_wait_queue(struct
wait_queue_head *wq_head, struct wait_queue

 static inline void __add_wait_queue(struct wait_queue_head *wq_head,
struct wait_queue_entry *wq_entry)
 {
-	struct list_head *head = &wq_head->head;
-	struct wait_queue_entry *wq;
-
-	list_for_each_entry(wq, &wq_head->head, entry) {
-		if (!(wq->flags & WQ_FLAG_PRIORITY))
-			break;
-		head = &wq->entry;
-	}
-	list_add(&wq_entry->entry, head);
+	list_add_tail(&wq_entry->entry, &wq_head->head);
 }

 /*
- * Used for wake-one threads:
+ * Adds at the head, for epoll's LIFO wakeup of its epoll_wait()ers.
  */
 static inline void
 __add_wait_queue_exclusive(struct wait_queue_head *wq_head, struct
wait_queue_entry *wq_entry)
 {
 	wq_entry->flags |= WQ_FLAG_EXCLUSIVE;
-	__add_wait_queue(wq_head, wq_entry);
+	list_add(&wq_entry->entry, &wq_head->head);
 }

 static inline void __add_wait_queue_entry_tail(struct wait_queue_head
*wq_head, struct wait_queue_entry *wq_entry)
diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index 9f126cc5c338..a14e14202279 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -40,11 +40,18 @@ EXPORT_SYMBOL(add_wait_queue_exclusive);

 void add_wait_queue_priority(struct wait_queue_head *wq_head, struct
wait_queue_entry *wq_entry)
 {
+	struct list_head *head = &wq_head->head;
+	struct wait_queue_entry *wq;
 	unsigned long flags;

 	wq_entry->flags |= WQ_FLAG_PRIORITY;
 	spin_lock_irqsave(&wq_head->lock, flags);
-	__add_wait_queue(wq_head, wq_entry);
+	list_for_each_entry(wq, &wq_head->head, entry) {
+		if (!(wq->flags & WQ_FLAG_PRIORITY))
+			break;
+		head = &wq->entry;
+	}
+	list_add(&wq_entry->entry, head);
 	spin_unlock_irqrestore(&wq_head->lock, flags);
 }
 EXPORT_SYMBOL_GPL(add_wait_queue_priority);
@@ -78,12 +85,12 @@ EXPORT_SYMBOL(remove_wait_queue);

 /*
  * The core wakeup function. Non-exclusive wakeups (nr_exclusive == 0) just
- * wake everything up. If it's an exclusive wakeup (nr_exclusive == small +ve
- * number) then we wake that number of exclusive tasks, and potentially all
- * the non-exclusive tasks. Normally, exclusive tasks will be at the end of
- * the list and any non-exclusive tasks will be woken first. A priority task
- * may be at the head of the list, and can consume the event without any other
- * tasks being woken if it's also an exclusive task.
+ * wake everything up. Otherwise the walk stops once nr_exclusive exclusive
+ * tasks have been woken. Waiters are queued in FIFO order, so non-exclusive
+ * waiters queued behind that point are not woken: the exclusive waiters will
+ * consume the event. A priority task may be at the head of the list, and can
+ * consume the event without any other tasks being woken if it's also an
+ * exclusive task.
  *
  * An exclusive waiter that returns >0 promises to handle the event. Pollers
  * (EPOLLEXCLUSIVE) can't promise that, since userspace may never consume it.
@@ -308,12 +315,8 @@ long prepare_to_wait_event(struct wait_queue_head
*wq_head, struct wait_queue_en
 		list_del_init(&wq_entry->entry);
 		ret = -ERESTARTSYS;
 	} else {
-		if (list_empty(&wq_entry->entry)) {
-			if (wq_entry->flags & WQ_FLAG_EXCLUSIVE)
-				__add_wait_queue_entry_tail(wq_head, wq_entry);
-			else
-				__add_wait_queue(wq_head, wq_entry);
-		}
+		if (list_empty(&wq_entry->entry))
+			__add_wait_queue(wq_head, wq_entry);
 		set_current_state(state);
 	}
 	spin_unlock_irqrestore(&wq_head->lock, flags);
-- 
2.56.0.313.g975a75ca90
