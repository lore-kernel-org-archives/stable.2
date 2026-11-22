Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795367381;
	b=W896189FATtAE6pC2c9I7s+GMzlzvIPwE8RyadmI/iShwaXWETR95xH27uaXws+VFznQ
	 6rYDacJM8xbVFH1QZ4yFjpBCcZ8KPbJ8HZDmAWGK9PpOQpq1yUnuPwZqcp+WBUasNT4x+
	 VGALkOsXF3upXZCCKcmkZcP+rIzH666o+P2cXteBIMcMjoZ7R00bCt916gR84dCLZCR/v
	 iilwna8EmngVxcNnG0JQ/K7Dx+IvAhrrLWaDPj9VozZ9DWCzSDQ+TXP8FtboIhcof+Fcd
	 RE7JgT9vL0k/Y4btPZlYXQlaiwCKEmEwXVZmoT2ImTlGiItRaQPmCyhDAhGhDc9cxsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795367381;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Scanned-By;
	bh=plrqPPTqLUGXyRtF3yviBr2TBAGHrlZ/HQwc2HJI+og=;
	b=4mKDTbEjFD44V5wpp8Dj8k38Z/32ZTrIiqzKZ+XpzenOKoRkojI5qK5+uTKfVJ+66fgr
	 4d9hc2XgfRCV2g3HQ1sW1vJJ3JXz+MMi+vbXxuObRpB60LWv/56huau7Qn/n9ZxQuC2by
	 lpf+KUf1Yzrfu2VH1n++BIB/EnCrqWoe4tUhr+HIphKIBx3nkgPzdHv3NvXyea7Pom7Nd
	 1JabrmpKygI3/sqQNVb+N96akGIvVwfHBIp79rmTySi5zNm6ezpCCywY2Wo6Oq4GXgARH
	 XHkl1vaizDVwVwAa29do6uB3C7AiLqYllevOYsZbSx4R83abGwSvW9+PUA31z1dkClg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iPqE2vTI;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EC8606A336
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 17:09:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7EC8606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iPqE2vTI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795367379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=plrqPPTqLUGXyRtF3yviBr2TBAGHrlZ/HQwc2HJI+og=;
	b=iPqE2vTIe/bjjhVHfov7ha6YCw7/GY6ob6h4C2DvmSuzDzxAG9TY/XLb9xZcqGYtdkyaRn
	7tYhX3syZpRIJv8TBP+GKOldTbvX0VXAKkKqlMsxiZL7RJzgUlGJN0CN+mABc7d1Uj2haZ
	dOEcnzqbVzRsIdeQ36dOOy2vUuDuKXU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-xbDJYcetNL6n8wUg_nwS_g-1; Sun,
 22 Nov 2026 17:09:32 +0000
X-MC-Unique: xbDJYcetNL6n8wUg_nwS_g-1
X-Mimecast-MFC-AGG-ID: xbDJYcetNL6n8wUg_nwS_g_1795367370
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AFC0F180047B;
	Sun, 22 Nov 2026 17:09:29 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 56774180054C;
	Sun, 22 Nov 2026 17:09:26 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Sun, 22 Nov 2026 18:09:29 +0100 (CET)
Date: Sun, 22 Nov 2026 18:09:24 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>
Cc: Breno Leitao <leitao@debian.org>,
	Christian Brauner <brauner@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	tz2294@columbia.edu, stable@vger.kernel.org,
	Mani Tofigh <mt4022@columbia.edu>
Subject: Re: [PATCH] pipe: keep per-write wakeups for EPOLLEXCLUSIVE consumers
Message-ID: <awMhxEuMHULvk8SA@redhat.com>
References: <avxWKI795DthE8Sb@redhat.com>
 <CAHk-=wjOq+G=6gte4vX_YxOD_VfE1uZh7=+KHs8N0wU75xyHEg@mail.gmail.com>
 <avyODoFhZ_M7YDU5@redhat.com>
 <CAHk-=wgcBSBtHE+3ceKGjq1jyF64OyoEqf5JPpixowAa80GqNQ@mail.gmail.com>
 <avyVwg-5ef-pXZkG@redhat.com>
 <CAHk-=wjJF8uZLfVbbqei9-fhs9K70i2OnVreCV-rQF9EGKAxJg@mail.gmail.com>
 <CAHk-=wjqParwoB8wb9KfGVpbwUwvKvObpLOo=XPM0GGfkn3ibw@mail.gmail.com>
 <av2juQijIISJAgyf@redhat.com>
 <CAHk-=wg4RgBYZcUU+c16XxdZ4UbAaazJkUS=R6=tpN4xUBdDRw@mail.gmail.com>
 <av3SmRMGDLVAwMzK@redhat.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <av3SmRMGDLVAwMzK@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 11/18, Oleg Nesterov wrote:
>
> On 11/18, Linus Torvalds wrote:
> >
> > Some duplication - with explicit naming of the locking status for the
> > special cases that are called with the lock already held - is much
> > preferable to dynamically doing the locking
>
> OK, this was my plan B ;) I'll try to make a patch this week.

Damn, I am stipid.

So I wrote the patches, but just before sending them, I realized I was wrong.
Just for the record, see the diff I was going to send at the end.

Yes, __wait_event_interruptible_locked() is buggy, but only in that do_wait_intr*()
use list_add_tail() regardless of WQ_FLAG_EXCLUSIVE.

I missed that fact that do_wait_intr*() always return 0 if they drop wq->lock,
and in this case __wait_event_interruptible_locked() will always recheck the
condition with this lock held. So an exclusive waiter can't miss miss a wakeup.

So we only need to change do_wait_intr*() to check WQ_FLAG_EXCLUSIVE and use
__add_wait_queue() if it is set. It doesn't make sense to refactor this code.

Mani, can you resend your patch? perhaps it also makes sense to turn the
"exclusive" arg into wq_flags like the Linus's commit cea5f91daa3ac does.

Oleg.
---

diff --git a/include/linux/wait.h b/include/linux/wait.h
index b3e94c71cd3e..c30e6b2ee231 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -298,7 +298,6 @@ extern void init_wait_entry(struct wait_queue_entry *wq_entry, int flags);
  * on purpose; we use long where we can return timeout values and int
  * otherwise.
  */
-
 #define ___wait_event(wq_head, condition, state, wq_flag, ret, cmd)		\
 ({										\
 	__label__ __out;							\
@@ -326,6 +325,35 @@ extern void init_wait_entry(struct wait_queue_entry *wq_entry, int flags);
 __out:	__ret;									\
 })
 
+/*
+ * Same as ___wait_event(), but called with wq_head->lock held.
+ * @cmd must release and reacquire this lock around schedule().
+ */
+#define ___wait_event_locked(wq_head, condition, state, wq_flag, ret, cmd)	\
+({										\
+	__label__ __out;							\
+	struct wait_queue_entry __wq_entry;					\
+	long __ret = ret;	/* explicit shadow */				\
+										\
+	init_wait_entry(&__wq_entry, wq_flag);					\
+	for (;;) {								\
+		long __int = prepare_to_wait_event_locked(&wq_head,		\
+							  &__wq_entry, state);	\
+		if (condition)							\
+			break;							\
+										\
+		if (___wait_is_interruptible(state) && __int) {			\
+			__ret = __int;						\
+			goto __out;						\
+		}								\
+										\
+		cmd;								\
+	}									\
+	__set_current_state(TASK_RUNNING);					\
+	__remove_wait_queue(&wq_head, &__wq_entry);				\
+__out:	__ret;									\
+})
+
 #define __wait_event(wq_head, condition)					\
 	(void)__wait_event_state(wq_head, condition, TASK_UNINTERRUPTIBLE)
 
@@ -767,26 +795,16 @@ do {										\
 	__ret;									\
 })
 
-extern int do_wait_intr(wait_queue_head_t *, wait_queue_entry_t *);
-extern int do_wait_intr_irq(wait_queue_head_t *, wait_queue_entry_t *);
-
-#define __wait_event_interruptible_locked(wq, condition, exclusive, fn)		\
-({										\
-	int __ret;								\
-	DEFINE_WAIT(__wait);							\
-	if (exclusive)								\
-		__wait.flags |= WQ_FLAG_EXCLUSIVE;				\
-	do {									\
-		__ret = fn(&(wq), &__wait);					\
-		if (__ret)							\
-			break;							\
-	} while (!(condition));							\
-	__remove_wait_queue(&(wq), &__wait);					\
-	__set_current_state(TASK_RUNNING);					\
-	__ret;									\
-})
+extern void do_wait_intr(wait_queue_head_t *);
+extern void do_wait_intr_irq(wait_queue_head_t *);
 
+#define __wait_event_interruptible_locked(wq_head, condition, cmd)		\
+	___wait_event_locked(wq_head, condition, TASK_INTERRUPTIBLE,		\
+			     0, 0, cmd(&wq_head))
 
+#define __wait_event_interruptible_exclusive_locked(wq_head, condition, cmd)	\
+	___wait_event_locked(wq_head, condition, TASK_INTERRUPTIBLE,		\
+			     WQ_FLAG_EXCLUSIVE, 0, cmd(&wq_head))
 /**
  * wait_event_interruptible_locked - sleep until a condition gets true
  * @wq: the waitqueue to wait on
@@ -810,9 +828,14 @@ extern int do_wait_intr_irq(wait_queue_head_t *, wait_queue_entry_t *);
  * The function will return -ERESTARTSYS if it was interrupted by a
  * signal and 0 if @condition evaluated to true.
  */
-#define wait_event_interruptible_locked(wq, condition)				\
-	((condition)								\
-	 ? 0 : __wait_event_interruptible_locked(wq, condition, 0, do_wait_intr))
+#define wait_event_interruptible_locked(wq_head, condition)			\
+({										\
+	int __ret = 0;								\
+	if (!(condition))							\
+		__ret = __wait_event_interruptible_locked(wq_head, condition,	\
+					     		  do_wait_intr);	\
+	__ret;									\
+})
 
 /**
  * wait_event_interruptible_locked_irq - sleep until a condition gets true
@@ -837,9 +860,14 @@ extern int do_wait_intr_irq(wait_queue_head_t *, wait_queue_entry_t *);
  * The function will return -ERESTARTSYS if it was interrupted by a
  * signal and 0 if @condition evaluated to true.
  */
-#define wait_event_interruptible_locked_irq(wq, condition)			\
-	((condition)								\
-	 ? 0 : __wait_event_interruptible_locked(wq, condition, 0, do_wait_intr_irq))
+#define wait_event_interruptible_locked_irq(wq_head, condition)			\
+({										\
+	int __ret = 0;								\
+	if (!(condition))							\
+		__ret = __wait_event_interruptible_locked(wq_head, condition,	\
+					     		  do_wait_intr_irq);	\
+	__ret;									\
+})
 
 /**
  * wait_event_interruptible_exclusive_locked - sleep exclusively until a condition gets true
@@ -868,9 +896,14 @@ extern int do_wait_intr_irq(wait_queue_head_t *, wait_queue_entry_t *);
  * The function will return -ERESTARTSYS if it was interrupted by a
  * signal and 0 if @condition evaluated to true.
  */
-#define wait_event_interruptible_exclusive_locked(wq, condition)		\
-	((condition)								\
-	 ? 0 : __wait_event_interruptible_locked(wq, condition, 1, do_wait_intr))
+#define wait_event_interruptible_exclusive_locked(wq_head, condition)			\
+({											\
+	int __ret = 0;									\
+	if (!(condition))								\
+		__ret = __wait_event_interruptible_exclusive_locked(wq_head, condition,	\
+					     			    do_wait_intr);	\
+	__ret;										\
+})
 
 /**
  * wait_event_interruptible_exclusive_locked_irq - sleep until a condition gets true
@@ -899,10 +932,14 @@ extern int do_wait_intr_irq(wait_queue_head_t *, wait_queue_entry_t *);
  * The function will return -ERESTARTSYS if it was interrupted by a
  * signal and 0 if @condition evaluated to true.
  */
-#define wait_event_interruptible_exclusive_locked_irq(wq, condition)		\
-	((condition)								\
-	 ? 0 : __wait_event_interruptible_locked(wq, condition, 1, do_wait_intr_irq))
-
+#define wait_event_interruptible_exclusive_locked_irq(wq_head, condition)		\
+({											\
+	int __ret = 0;									\
+	if (!(condition))								\
+		__ret = __wait_event_interruptible_exclusive_locked(wq_head, condition,	\
+					     			    do_wait_intr_irq);	\
+	__ret;										\
+})
 
 #define __wait_event_killable(wq, condition)					\
 	__wait_event_state(wq, condition, TASK_KILLABLE)
@@ -1218,6 +1255,7 @@ do {										\
  */
 void prepare_to_wait(struct wait_queue_head *wq_head, struct wait_queue_entry *wq_entry, int state);
 bool prepare_to_wait_exclusive(struct wait_queue_head *wq_head, struct wait_queue_entry *wq_entry, int state);
+long prepare_to_wait_event_locked(struct wait_queue_head *wq_head, struct wait_queue_entry *wq_entry, int state);
 long prepare_to_wait_event(struct wait_queue_head *wq_head, struct wait_queue_entry *wq_entry, int state);
 void finish_wait(struct wait_queue_head *wq_head, struct wait_queue_entry *wq_entry);
 long wait_woken(struct wait_queue_entry *wq_entry, unsigned mode, long timeout);
diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index d0521b54eeb3..b7d03ceb80cd 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -269,12 +269,13 @@ void init_wait_entry(struct wait_queue_entry *wq_entry, int flags)
 }
 EXPORT_SYMBOL(init_wait_entry);
 
-long prepare_to_wait_event(struct wait_queue_head *wq_head, struct wait_queue_entry *wq_entry, int state)
+long prepare_to_wait_event_locked(struct wait_queue_head *wq_head,
+				  struct wait_queue_entry *wq_entry, int state)
 {
-	unsigned long flags;
 	long ret = 0;
 
-	spin_lock_irqsave(&wq_head->lock, flags);
+	lockdep_assert_held(&wq_head->lock);
+
 	if (signal_pending_state(state, current)) {
 		/*
 		 * Exclusive waiter must not fail if it was selected by wakeup,
@@ -299,50 +300,37 @@ long prepare_to_wait_event(struct wait_queue_head *wq_head, struct wait_queue_en
 		}
 		set_current_state(state);
 	}
-	spin_unlock_irqrestore(&wq_head->lock, flags);
 
 	return ret;
 }
+EXPORT_SYMBOL(prepare_to_wait_event_locked);
+
+long prepare_to_wait_event(struct wait_queue_head *wq_head,
+			   struct wait_queue_entry *wq_entry, int state)
+{
+	guard(spinlock_irqsave)(&wq_head->lock);
+
+	return prepare_to_wait_event_locked(wq_head, wq_entry, state);
+}
 EXPORT_SYMBOL(prepare_to_wait_event);
 
 /*
- * Note! These two wait functions are entered with the
- * wait-queue lock held (and interrupts off in the _irq
- * case), so there is no race with testing the wakeup
- * condition in the caller before they add the wait
- * entry to the wake queue.
+ * Note! These two wait functions are entered with the wait-queue
+ * lock held (and interrupts off in the _irq case).
  */
-int do_wait_intr(wait_queue_head_t *wq, wait_queue_entry_t *wait)
+void do_wait_intr(wait_queue_head_t *wq)
 {
-	if (likely(list_empty(&wait->entry)))
-		__add_wait_queue_entry_tail(wq, wait);
-
-	set_current_state(TASK_INTERRUPTIBLE);
-	if (signal_pending(current))
-		return -ERESTARTSYS;
-
 	spin_unlock(&wq->lock);
 	schedule();
 	spin_lock(&wq->lock);
-
-	return 0;
 }
 EXPORT_SYMBOL(do_wait_intr);
 
-int do_wait_intr_irq(wait_queue_head_t *wq, wait_queue_entry_t *wait)
+void do_wait_intr_irq(wait_queue_head_t *wq)
 {
-	if (likely(list_empty(&wait->entry)))
-		__add_wait_queue_entry_tail(wq, wait);
-
-	set_current_state(TASK_INTERRUPTIBLE);
-	if (signal_pending(current))
-		return -ERESTARTSYS;
-
 	spin_unlock_irq(&wq->lock);
 	schedule();
 	spin_lock_irq(&wq->lock);
-
-	return 0;
 }
 EXPORT_SYMBOL(do_wait_intr_irq);
 

