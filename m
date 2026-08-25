Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0642333B96B
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 16:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787673947; cv=none; b=Fcc4yKvnUiujXg2o43VzKgaASQrf6kwg7csnHP7EJQ4bqvEpNI9hVWSVfvpy0plh7aD6sEI99SJ+AQe1nm4a9xYvTKKfMsotEIFgoVAccj3AaKdhIaQ8LYR1WHEY01gPPevvlTWjgk+Lm4w6x7COTrNwb3kqpFkqi3OHIo0seZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787673947; c=relaxed/simple;
	bh=Qd9BrMerC6PLr9mjoHcT8yQe313Zb34otuW95vUQLcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y39sbj7/z9VQ2AFknEqneliXvDZTq066QJEYKiWl7w1mC4xzaNgrgtR2uQ9hoTwpeYvqGUKAHe9qOS5Vq/AEeNOoqkfUb4inR2fvTilvRRKQxeeioINN/unCd5brJLukygJkAL5RPNWwoljItMC1nXkICbWwqUNrXCX1KOrq2WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1ZFzTdq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1ZFzTdq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 455FD1F000E9;
	Tue, 25 Aug 2026 16:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787673945;
	bh=UKiHHDEcNMU4QXxqVV5F5k61NQwjILNiCQjxItDTFUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B1ZFzTdqN+VNjCh8k7Zf8v+x7e0Arv+EHbLyEvdzMV52gq40/BOGU680TZElRpV2L
	 Ec9KJBEi6RaqJ58T+wwBoddQBVqgP8WgwaenaAzrpDJ9pttVn9AeDihFvKjfK67QFg
	 XLfJxF+71ibU2ZeLax7uJ7xlF7DtZZStDwXNPjxZnx0JNP1TUmC/KGPQAd1oXaeGTR
	 wNRwClV04vgvUgYWB2qaNlmcazZ9Tc+t7adRLZUIRBCDpiCSUiTU3fe0S4U/EkWZpZ
	 fJh74ftJLONdvTMlNbFEjNfvGLedEFFu41bF6/xn7HeGvfCpny/M9IFBuF+ntuoDeq
	 f3vj9hbaGhCSg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] io_uring/io-wq: add io_worker.acct pointer
Date: Tue, 25 Aug 2026 12:05:41 -0400
Message-ID: <20260825160543.4126397-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082422-frivolous-grab-47d6@gregkh>
References: <2026082422-frivolous-grab-47d6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Max Kellermann <max.kellermann@ionos.com>

[ Upstream commit 3d3bafd35fb422eb36cfc5709473cef7400588e7 ]

This replaces the `IO_WORKER_F_BOUND` flag.  All code that checks this
flag is not interested in knowing whether this is a "bound" worker;
all it does with this flag is determine the `io_wq_acct` pointer.  At
the cost of an extra pointer field, we can eliminate some fragile
pointer arithmetic.  In turn, the `create_index` and `index` fields
are not needed anymore.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Link: https://lore.kernel.org/r/20250128133927.3989681-3-max.kellermann@ionos.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: 297b5ccea4ac ("io_uring/io-wq: fix worker accounting when canceling creation callbacks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/io-wq.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
index e02128374837b..f364ab2a66408 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -30,7 +30,6 @@ enum {
 	IO_WORKER_F_UP		= 0,	/* up and active */
 	IO_WORKER_F_RUNNING	= 1,	/* account as running */
 	IO_WORKER_F_FREE	= 2,	/* worker on free list */
-	IO_WORKER_F_BOUND	= 3,	/* is doing bounded work */
 };
 
 enum {
@@ -46,12 +45,12 @@ enum {
  */
 struct io_worker {
 	refcount_t ref;
-	int create_index;
 	unsigned long flags;
 	struct hlist_nulls_node nulls_node;
 	struct list_head all_list;
 	struct task_struct *task;
 	struct io_wq *wq;
+	struct io_wq_acct *acct;
 
 	struct io_wq_work *cur_work;
 	raw_spinlock_t lock;
@@ -79,7 +78,6 @@ struct io_worker {
 struct io_wq_acct {
 	unsigned nr_workers;
 	unsigned max_workers;
-	int index;
 	atomic_t nr_running;
 	raw_spinlock_t lock;
 	struct io_wq_work_list work_list;
@@ -135,7 +133,7 @@ struct io_cb_cancel_data {
 	bool cancel_all;
 };
 
-static bool create_io_worker(struct io_wq *wq, int index);
+static bool create_io_worker(struct io_wq *wq, struct io_wq_acct *acct);
 static void io_wq_dec_running(struct io_worker *worker);
 static bool io_acct_cancel_pending_work(struct io_wq *wq,
 					struct io_wq_acct *acct,
@@ -167,7 +165,7 @@ static inline struct io_wq_acct *io_work_get_acct(struct io_wq *wq,
 
 static inline struct io_wq_acct *io_wq_get_acct(struct io_worker *worker)
 {
-	return io_get_acct(worker->wq, test_bit(IO_WORKER_F_BOUND, &worker->flags));
+	return worker->acct;
 }
 
 static void io_worker_ref_put(struct io_wq *wq)
@@ -323,7 +321,7 @@ static bool io_wq_create_worker(struct io_wq *wq, struct io_wq_acct *acct)
 	raw_spin_unlock(&wq->lock);
 	atomic_inc(&acct->nr_running);
 	atomic_inc(&wq->worker_refs);
-	return create_io_worker(wq, acct->index);
+	return create_io_worker(wq, acct);
 }
 
 static void io_wq_inc_running(struct io_worker *worker)
@@ -343,7 +341,7 @@ static void create_worker_cb(struct callback_head *cb)
 
 	worker = container_of(cb, struct io_worker, create_work);
 	wq = worker->wq;
-	acct = &wq->acct[worker->create_index];
+	acct = worker->acct;
 	raw_spin_lock(&wq->lock);
 
 	if (acct->nr_workers < acct->max_workers) {
@@ -352,7 +350,7 @@ static void create_worker_cb(struct callback_head *cb)
 	}
 	raw_spin_unlock(&wq->lock);
 	if (do_create) {
-		create_io_worker(wq, worker->create_index);
+		create_io_worker(wq, acct);
 	} else {
 		atomic_dec(&acct->nr_running);
 		io_worker_ref_put(wq);
@@ -384,7 +382,6 @@ static bool io_queue_worker_create(struct io_worker *worker,
 
 	atomic_inc(&wq->worker_refs);
 	init_task_work(&worker->create_work, func);
-	worker->create_index = acct->index;
 	if (!task_work_add(wq->task, &worker->create_work, TWA_SIGNAL)) {
 		/*
 		 * EXIT may have been set after checking it above, check after
@@ -834,9 +831,8 @@ static void io_workqueue_create(struct work_struct *work)
 		kfree(worker);
 }
 
-static bool create_io_worker(struct io_wq *wq, int index)
+static bool create_io_worker(struct io_wq *wq, struct io_wq_acct *acct)
 {
-	struct io_wq_acct *acct = &wq->acct[index];
 	struct io_worker *worker;
 	struct task_struct *tsk;
 
@@ -855,12 +851,10 @@ static bool create_io_worker(struct io_wq *wq, int index)
 
 	refcount_set(&worker->ref, 1);
 	worker->wq = wq;
+	worker->acct = acct;
 	raw_spin_lock_init(&worker->lock);
 	init_completion(&worker->ref_done);
 
-	if (index == IO_WQ_ACCT_BOUND)
-		set_bit(IO_WORKER_F_BOUND, &worker->flags);
-
 	tsk = create_io_thread(io_wq_worker, worker, NUMA_NO_NODE);
 	if (!IS_ERR(tsk)) {
 		io_init_new_worker(wq, worker, tsk);
@@ -1191,7 +1185,6 @@ struct io_wq *io_wq_create(unsigned bounded, struct io_wq_data *data)
 	for (i = 0; i < IO_WQ_ACCT_NR; i++) {
 		struct io_wq_acct *acct = &wq->acct[i];
 
-		acct->index = i;
 		atomic_set(&acct->nr_running, 0);
 		INIT_WQ_LIST(&acct->work_list);
 		raw_spin_lock_init(&acct->lock);
-- 
2.53.0

