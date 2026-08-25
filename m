Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87593B4EBC
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 19:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787687297; cv=none; b=ZIG5vQPWuHeqZvIe+UIoQ6sKb372LKib7aZeA1F5nELMGe2uB3ULdok8qIVxFvbLCrw8cVJMWM/AMKVfOqXbCEE8twwPQuVvOskyr7LnqNWXpNDh1mvqXNXPDo4xKimOgx7zOerDeVgWz9aQnY0rJeC5z0Gk8VeuU8Z7zHZ0HHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787687297; c=relaxed/simple;
	bh=38ZekwcNZI2koLbQmzuhUZtiheqEoURsec5Wjk3hkO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g39JZ9ADKiGtyczk5HN6A2D/7VzCBOjBMxiqabynklWLfR/ah03PmUybNc/SUjvirxVvSGgR01AG1DPEYYAcOmcunixqOf/qLhYgNf500yBWdxC+MEy8l/xRZ8qHzV16SUdEhZI/2v1MI0ZRk3uSH8WBqmmi9uJn1ms5ZK3NRVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtEjySU9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtEjySU9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B26E71F00A3D;
	Tue, 25 Aug 2026 19:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787687296;
	bh=kRPv9YLARdUitkDeCyWQQ+DqD7C9okKi3ZW4ReDiJOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NtEjySU97Ob9G61Uk8qKawevkOkK8PNL5dD2zAUqOO6Ce0uVlGaMW95JJruZC5gkZ
	 NdilLxfVJ2m6eLxM5tzQmYEKisv64CD9XFgimBiwHRnPwI310gYirkpi8W2AO5zsW6
	 8mE/xENj0w7GPrV39k07+WzsVATs88TQo/oWtNygprHRvoehCqqIDBC4tdoZAg7nYQ
	 bqgcmYc3kuciDvf7bUrh2ao+zoT33XaaT30Y55WdxGWuozbRXZ1be6cepqzmMISE2D
	 7t3yesgOoTXTUn70QKLfM55A1qkzU6t7qj6JiYoymXTvz0lU8QcY7SjsS/tgxwLjds
	 sMbj58taZMpRg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] io_uring/io-wq: add io_worker.acct pointer
Date: Tue, 25 Aug 2026 15:48:12 -0400
Message-ID: <20260825194814.376625-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082423-fineness-promotion-9ac5@gregkh>
References: <2026082423-fineness-promotion-9ac5@gregkh>
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
index 37725c5031b4c..e99c81453dd53 100644
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
 	struct io_wq_work *next_work;
@@ -80,7 +79,6 @@ struct io_worker {
 struct io_wq_acct {
 	unsigned nr_workers;
 	unsigned max_workers;
-	int index;
 	atomic_t nr_running;
 	raw_spinlock_t lock;
 	struct io_wq_work_list work_list;
@@ -136,7 +134,7 @@ struct io_cb_cancel_data {
 	bool cancel_all;
 };
 
-static bool create_io_worker(struct io_wq *wq, int index);
+static bool create_io_worker(struct io_wq *wq, struct io_wq_acct *acct);
 static void io_wq_dec_running(struct io_worker *worker);
 static bool io_acct_cancel_pending_work(struct io_wq *wq,
 					struct io_wq_acct *acct,
@@ -168,7 +166,7 @@ static inline struct io_wq_acct *io_work_get_acct(struct io_wq *wq,
 
 static inline struct io_wq_acct *io_wq_get_acct(struct io_worker *worker)
 {
-	return io_get_acct(worker->wq, test_bit(IO_WORKER_F_BOUND, &worker->flags));
+	return worker->acct;
 }
 
 static void io_worker_ref_put(struct io_wq *wq)
@@ -324,7 +322,7 @@ static bool io_wq_create_worker(struct io_wq *wq, struct io_wq_acct *acct)
 	raw_spin_unlock(&wq->lock);
 	atomic_inc(&acct->nr_running);
 	atomic_inc(&wq->worker_refs);
-	return create_io_worker(wq, acct->index);
+	return create_io_worker(wq, acct);
 }
 
 static void io_wq_inc_running(struct io_worker *worker)
@@ -344,7 +342,7 @@ static void create_worker_cb(struct callback_head *cb)
 
 	worker = container_of(cb, struct io_worker, create_work);
 	wq = worker->wq;
-	acct = &wq->acct[worker->create_index];
+	acct = worker->acct;
 	raw_spin_lock(&wq->lock);
 
 	if (acct->nr_workers < acct->max_workers) {
@@ -353,7 +351,7 @@ static void create_worker_cb(struct callback_head *cb)
 	}
 	raw_spin_unlock(&wq->lock);
 	if (do_create) {
-		create_io_worker(wq, worker->create_index);
+		create_io_worker(wq, acct);
 	} else {
 		atomic_dec(&acct->nr_running);
 		io_worker_ref_put(wq);
@@ -385,7 +383,6 @@ static bool io_queue_worker_create(struct io_worker *worker,
 
 	atomic_inc(&wq->worker_refs);
 	init_task_work(&worker->create_work, func);
-	worker->create_index = acct->index;
 	if (!task_work_add(wq->task, &worker->create_work, TWA_SIGNAL)) {
 		/*
 		 * EXIT may have been set after checking it above, check after
@@ -835,9 +832,8 @@ static void io_workqueue_create(struct work_struct *work)
 		kfree(worker);
 }
 
-static bool create_io_worker(struct io_wq *wq, int index)
+static bool create_io_worker(struct io_wq *wq, struct io_wq_acct *acct)
 {
-	struct io_wq_acct *acct = &wq->acct[index];
 	struct io_worker *worker;
 	struct task_struct *tsk;
 
@@ -856,12 +852,10 @@ static bool create_io_worker(struct io_wq *wq, int index)
 
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
@@ -1193,7 +1187,6 @@ struct io_wq *io_wq_create(unsigned bounded, struct io_wq_data *data)
 	for (i = 0; i < IO_WQ_ACCT_NR; i++) {
 		struct io_wq_acct *acct = &wq->acct[i];
 
-		acct->index = i;
 		atomic_set(&acct->nr_running, 0);
 		INIT_WQ_LIST(&acct->work_list);
 		raw_spin_lock_init(&acct->lock);
-- 
2.53.0

