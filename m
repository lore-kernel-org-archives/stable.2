Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795542474;
	b=uBoeij9C/y/4Su6BllW/3597BCAlhK94ColSja5dx+8NkoBRPyCc7uLT7tpVDmd4zWSt
	 YaN+G2xBCnxoV0xPl2HeExBiUGeyWSKu6hfLuCfU6fwWWGDG3Np/BFxZdU6qsJARrkqkO
	 YT4EAc7vdMUeSOPDwotkQk8Jw7SguZIYEbV9vhP1b9dYsg1d7/6/qcFxIU+/jxJkYT9JG
	 Jxaxjw1gKvzbL8y/ps6hsp/dmf8fOfF82bpBlx7Or3Lflg9QJUWN9GJ+8Pw4scjR8xMo0
	 2ZjjB75K7bOtADQyl+/M1Ia+lB3V58uUjoER+5ZVpGHF92ydStBAcok2N5nfSVfCbmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795542474;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:Received:From:In-Reply-To:
	 References:MIME-Version:Date:X-Gmail-Original-Message-ID:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=H7ztE50hZokGuEnZu7uhKJFIAPGf1iIgqAITsfIe0uA=;
	b=EX3XpfdcQn4ve+ZNnK61sTdxGMlCscjgjDQPPU1WAXYyHI4bMhcI0kYYNJOfdPX/2Hlo
	 Zx1hDtfbCnkCx43z2T4DN5VfvTuLcESx6hshk+iECqSA5PDC9XSGdeW0jzSAYnuClGOzW
	 iam4noHuLiUS2ArN+UzXUtHgv9zgKTfKt6VJVlI3mBK7ZglnrYy19bs6b3o3p1kLyzoPh
	 bEVHIY8DqaWiteOMWzV62BuDdAkDdnHuYZHVJ+dNCNU4axQuKS/EUZzK2+Weju+mAv26P
	 RSGHlAedyBbZxjpwz91Fz3ovTIT1ynPo2irxVauHORj64SEN/bQa92wreD9GqR0+GMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=BItKy6yl;
	arc=none smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DE1606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 17:47:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90DE1606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=BItKy6yl
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6baa6f27904so3605037a12.0
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 09:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1795542472; x=1796147272; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H7ztE50hZokGuEnZu7uhKJFIAPGf1iIgqAITsfIe0uA=;
        b=BItKy6ylqxo/WGtHCOnn+vsM/6jVBxwZRbHtjPi8BCdVu0Adc1SaGbQoZSTwCEu07l
         U4ujjG6s/0/fuseoaS3Ko4ZeHlRy9A3sfQrYyj1YQx+8IcFQHy+if5ETXoHgM1qv4B/2
         A0qtYbZ8J8VR+nxAHDhwPiiwEuhToGrWe2t7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795542472; x=1796147272;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H7ztE50hZokGuEnZu7uhKJFIAPGf1iIgqAITsfIe0uA=;
        b=GY3W5x9FQv2aT3C5iuAJsnJQ/G2OsU0FqLwaljmOxngPTKxi4VpLIS6m7BnNBjC+Fd
         xGzETsDxcaKVoKHJ9SCD1zrxUi8nzJftHUISP3j7rZ+GOQzdiph4xLGSigAUD/vQDezZ
         Z43i4uHWymgZg+d/eROLjlnDhANj/RSWDIkLOGW/acvMZFXBOBRpvwhjpettKugxUOPt
         FnGZlF7d61Ctro0t+/cVto5ctAusjJUl9+Sh6onTptCgZz5o90BJfoaRm8iQ5DFAqCKP
         0UMcUdmbI4VxXn5OBF4PabLunxDW65B+LSVAMUffqTxWJl+ezlqT3Oj+m9h/QwO9quIn
         f/dw==
X-Forwarded-Encrypted: i=1; AL+hErGuSIiqo9+H3+l6BGX4C3C7V5frXKUpeZ2WMAnn+Eg70yyMFZzJju1oBf4uuUk64chpo8MhqTY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8oqbLvk6LuoAPqg95DLkfPEBKE6YNAJiqLUZn4BobM+W2ikv9J
	yDSxUUKpbTNI5cEpoescVqsHRvSIh0dYXbuCOzngPAmfOiFQ8pYBL0cEdqDqVOw6P5On5ndYSUa
	A7FpZL5PSvA==
X-Gm-Gg: AZFdTZcAxTZ82sJ22WeL8F9m56dXasie96TP6TouJ7ASpp/mqcnhtBH5R50RfsguFja
	xUJnz225/nIyagzal0iAPTq3TTf4ZscFqi3dMBwzP+1+s0IbpiP3oMgjVZlBhvfzhq6lC2SxLBl
	PmMqKc00Di/AbnaU11/udmMT3zBMWcjtY5D99Iaif5qrJyGFOwSJl0HxmpNjKLrE8M8TsYDqi2q
	tRWgTh4FPIxqmsMlrkvuQDT3l0pcOSHMJhEovT7bVnpBsQINCIZbx7DGwycnQK5UtEVHWv0BrY4
	JL3tMDPxZVGDZhasKuL75pUmcoe4QcnlZhLMxzZwUWsb0QVp0WSsvv4DH7TOvHOKyiSs29mnesJ
	pUJFLWIFrDx07tL1vTAX8Znj776axgX4i1wC+oRV6LEmw9Af0joZ/+pvXDqNuh0Y3fFtYUCJBM4
	rduNpNWQqWnaWmIr92n6VPe0IP6T2ioCeKexA6i5dSYsu55fHKv9UHAFX0sONcNHFjsSQaE49ZQ
	AgU4N790mVAPYDneQeJwXhSy3lmOslOgFxJqm9XtAhRF8Si2CZpJIZslldR+pRDexbDEh4VjJ+o
	c3nKFi7Jq6xDg/oH5qCdf2ZQohBrRulGtdcANq2nJQInAZMvTc2eGApARS3g8uTkEYnvTIkfN50
	/x2ma
X-Received: by 2002:a05:6402:42c8:b0:6ba:a216:fe0b with SMTP id 4fb4d7f45d1cf-6baa21701bcmr6700589a12.42.1795542471787;
        Tue, 24 Nov 2026 09:47:51 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba370fc020sm7057900a12.25.2026.11.24.09.47.51
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 09:47:51 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c516a1623d0so427765866b.2
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 09:47:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErF5gKkBMJoEOv2NlMFkEgOL6k5wPbHYAOQzmFps6DLEqveTYqw5ZzHQXJRUgGXqAj47g0JL/PM=@vger.kernel.org
X-Received: by 2002:a17:907:940a:b0:c50:94be:22ab with SMTP id
 a640c23a62f3a-c513a805245mr1446646966b.18.1795542470849; Tue, 24 Nov 2026
 09:47:50 -0800 (PST)
Received: from 425495914135 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 24 Nov 2026 09:47:48 -0800
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
Date: Tue, 24 Nov 2026 09:47:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgvd5odMS8560FgZUnVLKmSwfBZRbX074S1a3xr02RBGQ@mail.gmail.com>
X-Gm-Features: Aa3M54qOt4-7HBDAcgu5xUlq8oQzhcFZHk2EabxzMar5L5v32hBVGAZZneRFhHM
Message-ID: <CAHk-=wgvd5odMS8560FgZUnVLKmSwfBZRbX074S1a3xr02RBGQ@mail.gmail.com>
Subject: [PATCH 7/7] sched/wait: remove the __add_wait_queue_*exclusive() helpers
To: Oleg Nesterov <oleg@redhat.com>
Cc: mt4022@columbia.edu, Jens Axboe <axboe@kernel.dk>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Michal Nazarewicz <mina86@mina86.com>, Wen Yang <wen.yang@linux.dev>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tz2294@columbia.edu, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 23 Nov 2026 17:04:33 -0800
Subject: [PATCH 7/7] sched/wait: remove the __add_wait_queue_*exclusive()
 helpers

Each has one or two special-case users.  Open-code them there: set
WQ_FLAG_EXCLUSIVE and queue the entry directly, with a note on why the
caller doesn't use add_wait_queue_exclusive().

I think all cases (eventpoll, orangefs and ubifs) are unnecessary and
could just use the regular ordering, but I'll leave that to those
maintainers to sort out.

Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>	# eventpoll
Cc: Christian Brauner <brauner@kernel.org>	# eventpoll
Cc: Jan Kara <jack@suse.cz>			# eventpoll
Cc: Mike Marshall <hubcap@omnibond.com>		# orangefs
Cc: Richard Weinberger <richard@nod.at>		# ubifs
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 fs/eventpoll.c                |  7 +++++--
 fs/orangefs/orangefs-bufmap.c |  7 +++++--
 fs/ubifs/journal.c            |  4 +++-
 include/linux/wait.h          | 17 -----------------
 4 files changed, 13 insertions(+), 22 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 58c0cb845dc7..14095cd5f7cf 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2351,8 +2351,11 @@ static int ep_poll(struct eventpoll *ep, struct
epoll_event __user *events,
 		 * important.
 		 */
 		eavail = ep_events_available(ep);
-		if (!eavail)
-			__add_wait_queue_exclusive(&ep->wq, &wait);
+		if (!eavail) {
+			/* Head, for LIFO wakeups; ep->lock serializes ep->wq */
+			wait.flags |= WQ_FLAG_EXCLUSIVE;
+			list_add(&wait.entry, &ep->wq.head);
+		}

 		spin_unlock_irq(&ep->lock);

diff --git a/fs/orangefs/orangefs-bufmap.c b/fs/orangefs/orangefs-bufmap.c
index 34195f2cd845..bc0abc050934 100644
--- a/fs/orangefs/orangefs-bufmap.c
+++ b/fs/orangefs/orangefs-bufmap.c
@@ -85,8 +85,11 @@ static int wait_for_free(struct slot_map *m)

 	do {
 		long n = left, t;
-		if (likely(list_empty(&wait.entry)))
-			__add_wait_queue_entry_tail_exclusive(&m->q, &wait);
+		if (likely(list_empty(&wait.entry))) {
+			/* m->q.lock is held */
+			wait.flags |= WQ_FLAG_EXCLUSIVE;
+			__add_wait_queue(&m->q, &wait);
+		}
 		set_current_state(TASK_INTERRUPTIBLE);

 		if (m->c > 0)
diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
index 40a95a2fad50..a8a6c9b01b9b 100644
--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -303,7 +303,9 @@ static void __queue_and_wait(struct ubifs_info *c)
 {
 	DEFINE_WAIT(wait);

-	__add_wait_queue_entry_tail_exclusive(&c->reserve_space_wq, &wait);
+	/* c->reserve_space_wq.lock is held */
+	wait.flags |= WQ_FLAG_EXCLUSIVE;
+	__add_wait_queue(&c->reserve_space_wq, &wait);
 	set_current_state(TASK_UNINTERRUPTIBLE);
 	spin_unlock(&c->reserve_space_wq.lock);

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 4f87ad870f51..bc2ad10a00b2 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -174,23 +174,6 @@ static inline void __add_wait_queue(struct
wait_queue_head *wq_head, struct wait
 	list_add_tail(&wq_entry->entry, &wq_head->head);
 }

-/*
- * Adds at the head, for epoll's LIFO wakeup of its epoll_wait()ers.
- */
-static inline void
-__add_wait_queue_exclusive(struct wait_queue_head *wq_head, struct
wait_queue_entry *wq_entry)
-{
-	wq_entry->flags |= WQ_FLAG_EXCLUSIVE;
-	list_add(&wq_entry->entry, &wq_head->head);
-}
-
-static inline void
-__add_wait_queue_entry_tail_exclusive(struct wait_queue_head
*wq_head, struct wait_queue_entry *wq_entry)
-{
-	wq_entry->flags |= WQ_FLAG_EXCLUSIVE;
-	__add_wait_queue(wq_head, wq_entry);
-}
-
 static inline void
 __remove_wait_queue(struct wait_queue_head *wq_head, struct
wait_queue_entry *wq_entry)
 {
-- 
2.56.0.313.g975a75ca90
