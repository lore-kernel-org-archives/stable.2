Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795296663;
	b=hQA8fRPHH1trw1m5Mq5NIdEZ1nkp4iZzyOr93KX7awRX0NlU236gfoc3MmncPs3Fgx2x
	 IVoA6HGUy7mAASOvTn10KJox+jbo8LNo8NrXrDu8HB/4adumfbdqH3JbofO8SarqHywvY
	 nk5ux5/+BNDHMi4nftQWedQmKqwHUkg82n0C5JJa5Oz/oxlFKPBP0tye3XrjMVhUAm10Z
	 Zfi9pmCvuXc1cWJkesZtnlBQLlEmaFSm1BkUDiNcVMqxce7bLe3U+/eVK/BlMTkKiB4Ds
	 dWAM+kudTdc3oooFoPaMAiT0ly5DKeu4504a2ua0eGknQA3VcuwqTifmD4gSS8wb40A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296663;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sKsYxA/wPfNytQTe+yU3c/FCrB4EXStoHFiSyf1UbcE=;
	b=gLByLZtRl0nk0EtUOR6e1KSK3UzwCQnuDwAFtwClpvj5hbhc+NA4RVsZPoM2hf9pnRIH
	 gOh31IDWTkaKI6jIPAEs8IuA4DKTtD/XS8s0sTDRYx04W/UcCfuSQPsw2C3o0F4RjeaeW
	 sj/x6Xkkv2IcepQSgaByFgJtvmXdW6nj+CKv2flH6bkn7o14/+UApvaJfenM4BfuOymmI
	 4jQz4gk/C9oDYFmF1RmH2UzVsmkVa2zwlyvVHmGWtGx0zM+kZMBpQxn/IxQZHRT1sWZvN
	 4W+YDWznlMUsDdAvoXhA0WmL+NH6f49W/yRmIRB9RKf/0unxe/4BcuDcpdT/NTOW9HQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=Kp7v4UvI;
	arc=none smtp.remote-ip=209.85.210.47
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31924606A330
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:31:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31924606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=Kp7v4UvI
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-8633b750a19so68844a34.2
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795296662; x=1795901462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sKsYxA/wPfNytQTe+yU3c/FCrB4EXStoHFiSyf1UbcE=;
        b=Kp7v4UvI/lZUM2+cE9cqwlyKD2k7mApmbOdnoysykSEJB6DrM+tdMHQWSiIPG/Jsxy
         JDUDFLLfXrqdHaLKwIXKeRXn3hSS9IoxrSVctfy++SiRAFsIoCHHKk1SAMozk18m2I7S
         cuRCWTH3E7qk9eGgzwcHa19/PF+RazyiuuNK5PKbEBf2a6AdPdXVHJmzKODB1jjExgpt
         ssTkDsqunGFYxCHhtpJuRozHXUTCtYt3ZRiLZR3V6H8UvhWjNggh+8JHLcIaHWCfE/4I
         1LoPQXUdvVcqfh5bseHSZI/PUdCACwhLbfncS6nH+3sr8arE7aTNdmd2AGI520RboFxs
         imIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795296662; x=1795901462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=sKsYxA/wPfNytQTe+yU3c/FCrB4EXStoHFiSyf1UbcE=;
        b=IAgfCtBhyWp0OVAvbMFQHUI3/Ln5D9UNmue1dulAYL+uSxyBdaOYkM30Uwe+/Gae9F
         pdDqLKUEzFDTUfQBznwEEiXDgNo4u+EN2RsvsUPVTfF0eAz3CTK5/xB0TC9mywW1wWBW
         CfS+TkSCkHpnJWcG6VCu9/FCKk07m5InN+llFiJUfiUOb4g4Qqd4f+mnWAmnOiWrdaUi
         3/jnRdwwBVSIQujJ+7hupVbv+xLazzGpizP0rWWBj1t/hX7NihvZtU393oKtOWAAIviV
         2eRFaD8W4oQmJKeEfkGkryRMubuT6MojtYo0QdvVz1/96P5ISQbrbGAtvODhnOMwEE/6
         YxLA==
X-Gm-Message-State: APuU4Z8lAsK6loBHhVXIPwH/tzJbkMQeb8i/0wqAPW4DdOrf7A5jYfwk
	bWs6DRQQDjdYI1RtFEJodFw/RCXnXkZard5cziDqRvaUo+c+48tqcsQ+ZN+W5NU4s1MDyhU9WV4
	ZoAnmhrE=
X-Gm-Gg: AZFdTZe0W87Zx6Wu2IpjI0EiD5CW2Lp8eaUNGWJZe9Tw9hAWa8T6umcigtXXbe+qoH9
	mK2iIPzDXErygmfAlppk0Ubm5JB4L58Z7vImAaU0qT8osooSGbZzR8/+sjz16u0NXv6DkrfXM3N
	ACTh5E4ZPo+kNk2MBDnSFHVW7FLqFCvhdPyMElnCmqnvaFP2TZiOJFGtNaorz0B9yVpi5swAw8n
	i99vXky0VnDHZMeGwNBh4wmmtBQhC4rxtUtikjKeFt3ayLIzxzqYOnk4jV1Bzks0LiZaUL1UJ4M
	IyMM+MGLiqiSjVZjjkd3WSmSZptVZKT16PIz/qKJzufhbhLVWxyO+Mz+jk76Nf3B6Di8hwdn0Oz
	tLxhrWIpeKfQvtcdj2o305S+lIK8dXMWIqisP0H15KLym6CMYp7V9Z/CnPUXoANC8rvJ8VXrfgw
	ykisq5f45eNB6pOpqt4duG/j+NM0keAUoGFyFaVNw387OUnaCs81MTpST0ZpdewD/ykxnrw+uB6
	/MBGcJYOiy18O4nYdotNOXZdyOJNW3qoSmc5RpEuKLVXn2cvoOkii7ldcz1iSkQhSPGsZC6dFu7
	yg+KuvARooNT2IpOlQGn6OLQWs8PFQS4JWmLb3qMWwlNzZbaA7qLTfTHuZ5ZzOeaf0yFCkJDcJM
	3aSQdFVCW8kH0VTOa48Xx1ZfDkwbGBQbbnQr7
X-Received: by 2002:a05:6820:627:b0:71b:410a:37ec with SMTP id 006d021491bc7-71b410a3f67mr4236166eaf.21.1795296661952;
        Sat, 21 Nov 2026 13:31:01 -0800 (PST)
Received: from r7625 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b38015c46sm4469155eaf.4.2026.11.21.13.31.00
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:31:01 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.6.y 08/19] io_uring/sqpoll: manage task_work privately
Date: Sat, 21 Nov 2026 21:30:38 +0000
Message-ID: <20261121213049.1788332-9-axboe@kernel.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121213049.1788332-1-axboe@kernel.dk>
References: <20261121213049.1788332-1-axboe@kernel.dk>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit af5d68f8892f8ee8f137648b79ceb2abc153a19b upstream.

Decouple from task_work running, and cap the number of entries we process
at the time. If we exceed that number, push remaining entries to a retry
list that we'll process first next time.

We cap the number of entries to process at 8, which is fairly random.
We just want to get enough per-ctx batching here, while not processing
endlessly.

Since we manually run PF_IO_WORKER related task_work anyway as the task
never exits to userspace, with this we no longer need to add an actual
task_work item to the per-process list.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
[axboe: 6.6 runs normal task_work in LIFO order, so don't reverse the
list in tctx_task_work_run(), and its trace_io_uring_task_work_run()
still takes the 'loops' argument. Run the retry_list in io_sq_thread()
before the IO_SQ_THREAD_EXITING marking that 6.6 has]

---
 io_uring/io_uring.c | 42 +++++++++++++++++++++++++++++++++---------
 io_uring/io_uring.h | 24 ++++++++++++++++++------
 io_uring/sqpoll.c   | 29 ++++++++++++++++++++++++++++-
 3 files changed, 79 insertions(+), 16 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index ddae460e06c0..3fd27002f4f7 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1197,7 +1197,14 @@ static void ctx_flush_and_put(struct io_ring_ctx *ctx, struct io_tw_state *ts)
 	percpu_ref_put(&ctx->refs);
 }
 
-static void handle_tw_list(struct llist_node *node, unsigned int *count)
+/*
+ * Run queued task_work, returning the number of entries processed in *count.
+ * If more entries than max_entries are available, stop processing once this
+ * is reached and return the rest of the list.
+ */
+struct llist_node *io_handle_tw_list(struct llist_node *node,
+				     unsigned int *count,
+				     unsigned int max_entries)
 {
 	struct io_ring_ctx *ctx = NULL;
 	struct io_tw_state ts = { };
@@ -1226,9 +1233,10 @@ static void handle_tw_list(struct llist_node *node, unsigned int *count)
 			ctx = NULL;
 			cond_resched();
 		}
-	} while (node);
+	} while (node && *count < max_entries);
 
 	ctx_flush_and_put(ctx, &ts);
+	return node;
 }
 
 /**
@@ -1274,27 +1282,39 @@ static __cold void io_fallback_tw(struct io_uring_task *tctx, bool sync)
 	}
 }
 
-void tctx_task_work(struct callback_head *cb)
+struct llist_node *tctx_task_work_run(struct io_uring_task *tctx,
+				      unsigned int max_entries,
+				      unsigned int *count)
 {
-	struct io_uring_task *tctx = container_of(cb, struct io_uring_task,
-						  task_work);
 	struct llist_node *node;
-	unsigned int count = 0;
 
 	if (unlikely(current->flags & PF_EXITING)) {
 		io_fallback_tw(tctx, true);
-		return;
+		return NULL;
 	}
 
 	node = llist_del_all(&tctx->task_list);
 	if (node)
-		handle_tw_list(node, &count);
+		node = io_handle_tw_list(node, count, max_entries);
 
 	/* relaxed read is enough as only the task itself sets ->in_cancel */
 	if (unlikely(atomic_read(&tctx->in_cancel)))
 		io_uring_drop_tctx_refs(current);
 
-	trace_io_uring_task_work_run(tctx, count, 1);
+	trace_io_uring_task_work_run(tctx, *count, 1);
+	return node;
+}
+
+void tctx_task_work(struct callback_head *cb)
+{
+	struct io_uring_task *tctx;
+	struct llist_node *ret;
+	unsigned int count = 0;
+
+	tctx = container_of(cb, struct io_uring_task, task_work);
+	ret = tctx_task_work_run(tctx, UINT_MAX, &count);
+	/* can't happen */
+	WARN_ON_ONCE(ret);
 }
 
 static void io_poll_wq_wake_rcu(struct rcu_head *rcu)
@@ -1388,6 +1408,10 @@ static void io_req_normal_work_add(struct io_kiocb *req)
 	if (ctx->flags & IORING_SETUP_TASKRUN_FLAG)
 		atomic_or(IORING_SQ_TASKRUN, &ctx->rings->sq_flags);
 
+	/* SQPOLL doesn't need the task_work added, it'll run it itself */
+	if (ctx->flags & IORING_SETUP_SQPOLL)
+		return;
+
 	if (likely(!task_work_add(req->task, &tctx->task_work, ctx->notify_method)))
 		return;
 
diff --git a/io_uring/io_uring.h b/io_uring/io_uring.h
index a3c97ffb4d14..0d749588ab21 100644
--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -77,6 +77,8 @@ void io_req_task_queue(struct io_kiocb *req);
 void io_req_task_complete(struct io_kiocb *req, struct io_tw_state *ts);
 void io_req_task_queue_fail(struct io_kiocb *req, int ret);
 void io_req_task_submit(struct io_kiocb *req, struct io_tw_state *ts);
+struct llist_node *io_handle_tw_list(struct llist_node *node, unsigned int *count, unsigned int max_entries);
+struct llist_node *tctx_task_work_run(struct io_uring_task *tctx, unsigned int max_entries, unsigned int *count);
 void tctx_task_work(struct callback_head *cb);
 __cold void io_uring_cancel_generic(bool cancel_all, struct io_sq_data *sqd);
 int io_uring_alloc_task_context(struct task_struct *task,
@@ -338,6 +340,8 @@ static inline unsigned int io_sqring_entries(struct io_ring_ctx *ctx)
 
 static inline int io_run_task_work(void)
 {
+	bool ret = false;
+
 	/*
 	 * Always check-and-clear the task_work notification signal. With how
 	 * signaling works for task_work, we can find it set with nothing to
@@ -349,18 +353,26 @@ static inline int io_run_task_work(void)
 	 * PF_IO_WORKER never returns to userspace, so check here if we have
 	 * notify work that needs processing.
 	 */
-	if (current->flags & PF_IO_WORKER &&
-	    test_thread_flag(TIF_NOTIFY_RESUME)) {
-		__set_current_state(TASK_RUNNING);
-		resume_user_mode_work(NULL);
+	if (current->flags & PF_IO_WORKER) {
+		if (test_thread_flag(TIF_NOTIFY_RESUME)) {
+			__set_current_state(TASK_RUNNING);
+			resume_user_mode_work(NULL);
+		}
+		if (current->io_uring) {
+			unsigned int count = 0;
+
+			tctx_task_work_run(current->io_uring, UINT_MAX, &count);
+			if (count)
+				ret = true;
+		}
 	}
 	if (task_work_pending(current)) {
 		__set_current_state(TASK_RUNNING);
 		task_work_run();
-		return 1;
+		ret = true;
 	}
 
-	return 0;
+	return ret;
 }
 
 static inline bool io_task_work_pending(struct io_ring_ctx *ctx)
diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index 75065de8d7d3..716cb3cc7e2c 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -19,6 +19,7 @@
 #include "sqpoll.h"
 
 #define IORING_SQPOLL_CAP_ENTRIES_VALUE 8
+#define IORING_TW_CAP_ENTRIES_VALUE	8
 
 enum {
 	IO_SQ_THREAD_SHOULD_STOP = 0,
@@ -238,8 +239,31 @@ static bool io_sqd_handle_event(struct io_sq_data *sqd)
 	return did_sig || test_bit(IO_SQ_THREAD_SHOULD_STOP, &sqd->state);
 }
 
+/*
+ * Run task_work, processing the retry_list first. The retry_list holds
+ * entries that we passed on in the previous run, if we had more task_work
+ * than we were asked to process. Newly queued task_work isn't run until the
+ * retry list has been fully processed.
+ */
+static unsigned int io_sq_tw(struct llist_node **retry_list, int max_entries)
+{
+	struct io_uring_task *tctx = current->io_uring;
+	unsigned int count = 0;
+
+	if (*retry_list) {
+		*retry_list = io_handle_tw_list(*retry_list, &count, max_entries);
+		if (count >= max_entries)
+			return count;
+		max_entries -= count;
+	}
+
+	*retry_list = tctx_task_work_run(tctx, max_entries, &count);
+	return count;
+}
+
 static int io_sq_thread(void *data)
 {
+	struct llist_node *retry_list = NULL;
 	struct io_sq_data *sqd = data;
 	struct io_ring_ctx *ctx;
 	unsigned long timeout = 0;
@@ -284,7 +308,7 @@ static int io_sq_thread(void *data)
 			if (!sqt_spin && (ret > 0 || !wq_list_empty(&ctx->iopoll_list)))
 				sqt_spin = true;
 		}
-		if (io_run_task_work())
+		if (io_sq_tw(&retry_list, IORING_TW_CAP_ENTRIES_VALUE))
 			sqt_spin = true;
 
 		if (sqt_spin || !time_after(jiffies, timeout)) {
@@ -346,6 +370,9 @@ static int io_sq_thread(void *data)
 		timeout = jiffies + sqd->sq_thread_idle;
 	}
 
+	if (retry_list)
+		io_sq_tw(&retry_list, UINT_MAX);
+
 	/*
 	 * Cancelation drops sqd->lock while it waits, and a ring could attach
 	 * to a thread that is on its way out. A fatal signal doesn't set the
-- 
2.55.0

