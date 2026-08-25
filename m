Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA9D3B5314
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 19:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787687299; cv=none; b=LG4Gz97kzcc7gN5rTVXJTgJpHtWR1eX+d1kWs7fcLduBQ/Abl0upAvFkU/3uvV51mrWh4ecTBbqg7kJWlY0pMb3qP4jw9gcLqhuVGQtyXW+1qqtTrT60VaEPdK7EfQSgSWq2jQ9S63AqFRB9dWoEMw8kvlV7FeByuMUqQgdrYWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787687299; c=relaxed/simple;
	bh=NBkRrazRKISHUJuV2sq9jTlPlnIgZehr3sCDAKAnBi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EDOfuolzPRaeN7tSpk1wi4oEvOMCUDT3pwoE6ETpPnEzASJQph/qUzCvsROyGHfeISdg9Of/4BXclkUr0TslMCf20bhN4k7KBru9bnLnRm/6etnb7fJS8ZilGW224vBWrWWRJBSaxlt3VuC5dAbEUyG0eBekfRzPr/3C0hsY2Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=inuG59gD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="inuG59gD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E231F00A3E;
	Tue, 25 Aug 2026 19:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787687297;
	bh=tiPP7aqK4BgvDGXZ8pgr2Lx+XPXpomOnQOracam8ZwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=inuG59gDFF1ymY7JV2+y46/dfS3213qSdSTB6bO7TqcFlyJ44EH3o+s0yx24JXi+q
	 P9DrFjFxEry8OF6loKdM9jlN9b7uCdoQBfV6uuVmyCRoGaK+t7oJECYq0Tj9kGDMMH
	 Fwsu1uN2+3Ex9pf+dw64FYQKE7EXBqX2p2TM9ebkBuepByVkNMwf+5BqHgPMdUy2tF
	 8v2yy7MTwrHIVhesbU4qWWHrQMMlImOwLrio9xzyZgKM39IUPovRTbcY0Bdk9aMybt
	 2YxaKychfXdgli9D3dvzNr5PvfAgJIRZJ2K2A9dq5P0Nw3zs81an/DYYKpoloiCLN3
	 vgPjoslAh/3eg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] io_uring/io-wq: move worker lists to struct io_wq_acct
Date: Tue, 25 Aug 2026 15:48:13 -0400
Message-ID: <20260825194814.376625-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825194814.376625-1-sashal@kernel.org>
References: <2026082423-fineness-promotion-9ac5@gregkh>
 <20260825194814.376625-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Max Kellermann <max.kellermann@ionos.com>

[ Upstream commit 751eedc4b4b79332ecf1a78c0dbeb47d573a8f59 ]

Have separate linked lists for bounded and unbounded workers.  This
way, io_acct_activate_free_worker() sees only workers relevant to it
and doesn't need to skip irrelevant ones.  This speeds up the
linked list traversal (under acct->lock).

The `io_wq.lock` field is moved to `io_wq_acct.workers_lock`.  It did
not actually protect "access to elements below", that is, not all of
them; it only protected access to the worker lists.  By having two
locks instead of one, contention on this lock is reduced.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Link: https://lore.kernel.org/r/20250128133927.3989681-4-max.kellermann@ionos.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: 297b5ccea4ac ("io_uring/io-wq: fix worker accounting when canceling creation callbacks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/io-wq.c | 162 ++++++++++++++++++++++++++++-------------------
 1 file changed, 96 insertions(+), 66 deletions(-)

diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
index e99c81453dd53..775c55e377922 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -77,9 +77,27 @@ struct io_worker {
 #define IO_WQ_NR_HASH_BUCKETS	(1u << IO_WQ_HASH_ORDER)
 
 struct io_wq_acct {
+	/**
+	 * Protects access to the worker lists.
+	 */
+	raw_spinlock_t workers_lock;
+
 	unsigned nr_workers;
 	unsigned max_workers;
 	atomic_t nr_running;
+
+	/**
+	 * The list of free workers.  Protected by #workers_lock
+	 * (write) and RCU (read).
+	 */
+	struct hlist_nulls_head free_list;
+
+	/**
+	 * The list of all workers.  Protected by #workers_lock
+	 * (write) and RCU (read).
+	 */
+	struct list_head all_list;
+
 	raw_spinlock_t lock;
 	struct io_wq_work_list work_list;
 	unsigned long flags;
@@ -111,12 +129,6 @@ struct io_wq {
 
 	struct io_wq_acct acct[IO_WQ_ACCT_NR];
 
-	/* lock protects access to elements below */
-	raw_spinlock_t lock;
-
-	struct hlist_nulls_head free_list;
-	struct list_head all_list;
-
 	struct wait_queue_entry wait;
 
 	struct io_wq_work *hash_tail[IO_WQ_NR_HASH_BUCKETS];
@@ -191,9 +203,9 @@ static void io_worker_cancel_cb(struct io_worker *worker)
 	struct io_wq *wq = worker->wq;
 
 	atomic_dec(&acct->nr_running);
-	raw_spin_lock(&wq->lock);
+	raw_spin_lock(&acct->workers_lock);
 	acct->nr_workers--;
-	raw_spin_unlock(&wq->lock);
+	raw_spin_unlock(&acct->workers_lock);
 	io_worker_ref_put(wq);
 	clear_bit_unlock(0, &worker->create_state);
 	io_worker_release(worker);
@@ -212,6 +224,7 @@ static bool io_task_worker_match(struct callback_head *cb, void *data)
 static void io_worker_exit(struct io_worker *worker)
 {
 	struct io_wq *wq = worker->wq;
+	struct io_wq_acct *acct = io_wq_get_acct(worker);
 
 	while (1) {
 		struct callback_head *cb = task_work_cancel_match(wq->task,
@@ -225,11 +238,11 @@ static void io_worker_exit(struct io_worker *worker)
 	io_worker_release(worker);
 	wait_for_completion(&worker->ref_done);
 
-	raw_spin_lock(&wq->lock);
+	raw_spin_lock(&acct->workers_lock);
 	if (test_bit(IO_WORKER_F_FREE, &worker->flags))
 		hlist_nulls_del_rcu(&worker->nulls_node);
 	list_del_rcu(&worker->all_list);
-	raw_spin_unlock(&wq->lock);
+	raw_spin_unlock(&acct->workers_lock);
 	io_wq_dec_running(worker);
 	/*
 	 * this worker is a goner, clear ->worker_private to avoid any
@@ -268,8 +281,7 @@ static inline bool io_acct_run_queue(struct io_wq_acct *acct)
  * Check head of free list for an available worker. If one isn't available,
  * caller must create one.
  */
-static bool io_wq_activate_free_worker(struct io_wq *wq,
-					struct io_wq_acct *acct)
+static bool io_acct_activate_free_worker(struct io_wq_acct *acct)
 	__must_hold(RCU)
 {
 	struct hlist_nulls_node *n;
@@ -280,13 +292,9 @@ static bool io_wq_activate_free_worker(struct io_wq *wq,
 	 * activate. If a given worker is on the free_list but in the process
 	 * of exiting, keep trying.
 	 */
-	hlist_nulls_for_each_entry_rcu(worker, n, &wq->free_list, nulls_node) {
+	hlist_nulls_for_each_entry_rcu(worker, n, &acct->free_list, nulls_node) {
 		if (!io_worker_get(worker))
 			continue;
-		if (io_wq_get_acct(worker) != acct) {
-			io_worker_release(worker);
-			continue;
-		}
 		/*
 		 * If the worker is already running, it's either already
 		 * starting work or finishing work. In either case, if it does
@@ -313,13 +321,13 @@ static bool io_wq_create_worker(struct io_wq *wq, struct io_wq_acct *acct)
 	if (unlikely(!acct->max_workers))
 		pr_warn_once("io-wq is not configured for unbound workers");
 
-	raw_spin_lock(&wq->lock);
+	raw_spin_lock(&acct->workers_lock);
 	if (acct->nr_workers >= acct->max_workers) {
-		raw_spin_unlock(&wq->lock);
+		raw_spin_unlock(&acct->workers_lock);
 		return true;
 	}
 	acct->nr_workers++;
-	raw_spin_unlock(&wq->lock);
+	raw_spin_unlock(&acct->workers_lock);
 	atomic_inc(&acct->nr_running);
 	atomic_inc(&wq->worker_refs);
 	return create_io_worker(wq, acct);
@@ -343,13 +351,13 @@ static void create_worker_cb(struct callback_head *cb)
 	worker = container_of(cb, struct io_worker, create_work);
 	wq = worker->wq;
 	acct = worker->acct;
-	raw_spin_lock(&wq->lock);
+	raw_spin_lock(&acct->workers_lock);
 
 	if (acct->nr_workers < acct->max_workers) {
 		acct->nr_workers++;
 		do_create = true;
 	}
-	raw_spin_unlock(&wq->lock);
+	raw_spin_unlock(&acct->workers_lock);
 	if (do_create) {
 		create_io_worker(wq, acct);
 	} else {
@@ -428,25 +436,25 @@ static void io_wq_dec_running(struct io_worker *worker)
  * Worker will start processing some work. Move it to the busy list, if
  * it's currently on the freelist
  */
-static void __io_worker_busy(struct io_wq *wq, struct io_worker *worker)
+static void __io_worker_busy(struct io_wq_acct *acct, struct io_worker *worker)
 {
 	if (test_bit(IO_WORKER_F_FREE, &worker->flags)) {
 		clear_bit(IO_WORKER_F_FREE, &worker->flags);
-		raw_spin_lock(&wq->lock);
+		raw_spin_lock(&acct->workers_lock);
 		hlist_nulls_del_init_rcu(&worker->nulls_node);
-		raw_spin_unlock(&wq->lock);
+		raw_spin_unlock(&acct->workers_lock);
 	}
 }
 
 /*
  * No work, worker going to sleep. Move to freelist.
  */
-static void __io_worker_idle(struct io_wq *wq, struct io_worker *worker)
-	__must_hold(wq->lock)
+static void __io_worker_idle(struct io_wq_acct *acct, struct io_worker *worker)
+	__must_hold(acct->workers_lock)
 {
 	if (!test_bit(IO_WORKER_F_FREE, &worker->flags)) {
 		set_bit(IO_WORKER_F_FREE, &worker->flags);
-		hlist_nulls_add_head_rcu(&worker->nulls_node, &wq->free_list);
+		hlist_nulls_add_head_rcu(&worker->nulls_node, &acct->free_list);
 	}
 }
 
@@ -581,7 +589,7 @@ static void io_worker_handle_work(struct io_wq_acct *acct,
 		if (!work)
 			break;
 
-		__io_worker_busy(wq, worker);
+		__io_worker_busy(acct, worker);
 
 		io_assign_current_work(worker, work);
 		__set_current_state(TASK_RUNNING);
@@ -652,20 +660,20 @@ static int io_wq_worker(void *data)
 		while (io_acct_run_queue(acct))
 			io_worker_handle_work(acct, worker);
 
-		raw_spin_lock(&wq->lock);
+		raw_spin_lock(&acct->workers_lock);
 		/*
 		 * Last sleep timed out. Exit if we're not the last worker,
 		 * or if someone modified our affinity.
 		 */
 		if (last_timeout && (exit_mask || acct->nr_workers > 1)) {
 			acct->nr_workers--;
-			raw_spin_unlock(&wq->lock);
+			raw_spin_unlock(&acct->workers_lock);
 			__set_current_state(TASK_RUNNING);
 			break;
 		}
 		last_timeout = false;
-		__io_worker_idle(wq, worker);
-		raw_spin_unlock(&wq->lock);
+		__io_worker_idle(acct, worker);
+		raw_spin_unlock(&acct->workers_lock);
 		if (io_run_task_work())
 			continue;
 		ret = schedule_timeout(WORKER_IDLE_TIMEOUT);
@@ -726,18 +734,18 @@ void io_wq_worker_sleeping(struct task_struct *tsk)
 	io_wq_dec_running(worker);
 }
 
-static void io_init_new_worker(struct io_wq *wq, struct io_worker *worker,
+static void io_init_new_worker(struct io_wq *wq, struct io_wq_acct *acct, struct io_worker *worker,
 			       struct task_struct *tsk)
 {
 	tsk->worker_private = worker;
 	worker->task = tsk;
 	set_cpus_allowed_ptr(tsk, wq->cpu_mask);
 
-	raw_spin_lock(&wq->lock);
-	hlist_nulls_add_head_rcu(&worker->nulls_node, &wq->free_list);
-	list_add_tail_rcu(&worker->all_list, &wq->all_list);
+	raw_spin_lock(&acct->workers_lock);
+	hlist_nulls_add_head_rcu(&worker->nulls_node, &acct->free_list);
+	list_add_tail_rcu(&worker->all_list, &acct->all_list);
 	set_bit(IO_WORKER_F_FREE, &worker->flags);
-	raw_spin_unlock(&wq->lock);
+	raw_spin_unlock(&acct->workers_lock);
 	wake_up_new_task(tsk);
 }
 
@@ -785,20 +793,20 @@ static void create_worker_cont(struct callback_head *cb)
 	struct io_worker *worker;
 	struct task_struct *tsk;
 	struct io_wq *wq;
+	struct io_wq_acct *acct;
 
 	worker = container_of(cb, struct io_worker, create_work);
 	clear_bit_unlock(0, &worker->create_state);
 	wq = worker->wq;
+	acct = io_wq_get_acct(worker);
 	tsk = create_io_thread(io_wq_worker, worker, NUMA_NO_NODE);
 	if (!IS_ERR(tsk)) {
-		io_init_new_worker(wq, worker, tsk);
+		io_init_new_worker(wq, acct, worker, tsk);
 		io_worker_release(worker);
 		return;
 	} else if (!io_should_retry_thread(worker, PTR_ERR(tsk))) {
-		struct io_wq_acct *acct = io_wq_get_acct(worker);
-
 		atomic_dec(&acct->nr_running);
-		raw_spin_lock(&wq->lock);
+		raw_spin_lock(&acct->workers_lock);
 		acct->nr_workers--;
 		if (!acct->nr_workers) {
 			struct io_cb_cancel_data match = {
@@ -806,11 +814,11 @@ static void create_worker_cont(struct callback_head *cb)
 				.cancel_all	= true,
 			};
 
-			raw_spin_unlock(&wq->lock);
+			raw_spin_unlock(&acct->workers_lock);
 			while (io_acct_cancel_pending_work(wq, acct, &match))
 				;
 		} else {
-			raw_spin_unlock(&wq->lock);
+			raw_spin_unlock(&acct->workers_lock);
 		}
 		io_worker_ref_put(wq);
 		kfree(worker);
@@ -843,9 +851,9 @@ static bool create_io_worker(struct io_wq *wq, struct io_wq_acct *acct)
 	if (!worker) {
 fail:
 		atomic_dec(&acct->nr_running);
-		raw_spin_lock(&wq->lock);
+		raw_spin_lock(&acct->workers_lock);
 		acct->nr_workers--;
-		raw_spin_unlock(&wq->lock);
+		raw_spin_unlock(&acct->workers_lock);
 		io_worker_ref_put(wq);
 		return false;
 	}
@@ -858,7 +866,7 @@ static bool create_io_worker(struct io_wq *wq, struct io_wq_acct *acct)
 
 	tsk = create_io_thread(io_wq_worker, worker, NUMA_NO_NODE);
 	if (!IS_ERR(tsk)) {
-		io_init_new_worker(wq, worker, tsk);
+		io_init_new_worker(wq, acct, worker, tsk);
 	} else if (!io_should_retry_thread(worker, PTR_ERR(tsk))) {
 		kfree(worker);
 		goto fail;
@@ -874,14 +882,14 @@ static bool create_io_worker(struct io_wq *wq, struct io_wq_acct *acct)
  * Iterate the passed in list and call the specific function for each
  * worker that isn't exiting
  */
-static bool io_wq_for_each_worker(struct io_wq *wq,
-				  bool (*func)(struct io_worker *, void *),
-				  void *data)
+static bool io_acct_for_each_worker(struct io_wq_acct *acct,
+				    bool (*func)(struct io_worker *, void *),
+				    void *data)
 {
 	struct io_worker *worker;
 	bool ret = false;
 
-	list_for_each_entry_rcu(worker, &wq->all_list, all_list) {
+	list_for_each_entry_rcu(worker, &acct->all_list, all_list) {
 		if (io_worker_get(worker)) {
 			/* no task if node is/was offline */
 			if (worker->task)
@@ -895,6 +903,18 @@ static bool io_wq_for_each_worker(struct io_wq *wq,
 	return ret;
 }
 
+static bool io_wq_for_each_worker(struct io_wq *wq,
+				  bool (*func)(struct io_worker *, void *),
+				  void *data)
+{
+	for (int i = 0; i < IO_WQ_ACCT_NR; i++) {
+		if (!io_acct_for_each_worker(&wq->acct[i], func, data))
+			return false;
+	}
+
+	return true;
+}
+
 static bool io_wq_worker_wake(struct io_worker *worker, void *data)
 {
 	__set_notify_signal(worker->task);
@@ -964,7 +984,7 @@ void io_wq_enqueue(struct io_wq *wq, struct io_wq_work *work)
 	raw_spin_unlock(&acct->lock);
 
 	rcu_read_lock();
-	do_create = !io_wq_activate_free_worker(wq, acct);
+	do_create = !io_acct_activate_free_worker(acct);
 	rcu_read_unlock();
 
 	if (do_create && ((work_flags & IO_WQ_WORK_CONCURRENT) ||
@@ -975,12 +995,12 @@ void io_wq_enqueue(struct io_wq *wq, struct io_wq_work *work)
 		if (likely(did_create))
 			return;
 
-		raw_spin_lock(&wq->lock);
+		raw_spin_lock(&acct->workers_lock);
 		if (acct->nr_workers) {
-			raw_spin_unlock(&wq->lock);
+			raw_spin_unlock(&acct->workers_lock);
 			return;
 		}
-		raw_spin_unlock(&wq->lock);
+		raw_spin_unlock(&acct->workers_lock);
 
 		/* fatal condition, failed to create the first worker */
 		io_acct_cancel_pending_work(wq, acct, &match);
@@ -1089,11 +1109,22 @@ static void io_wq_cancel_pending_work(struct io_wq *wq,
 	}
 }
 
+static void io_acct_cancel_running_work(struct io_wq_acct *acct,
+					struct io_cb_cancel_data *match)
+{
+	raw_spin_lock(&acct->workers_lock);
+	io_acct_for_each_worker(acct, io_wq_worker_cancel, match);
+	raw_spin_unlock(&acct->workers_lock);
+}
+
 static void io_wq_cancel_running_work(struct io_wq *wq,
 				       struct io_cb_cancel_data *match)
 {
 	rcu_read_lock();
-	io_wq_for_each_worker(wq, io_wq_worker_cancel, match);
+
+	for (int i = 0; i < IO_WQ_ACCT_NR; i++)
+		io_acct_cancel_running_work(&wq->acct[i], match);
+
 	rcu_read_unlock();
 }
 
@@ -1116,16 +1147,14 @@ enum io_wq_cancel io_wq_cancel_cb(struct io_wq *wq, work_cancel_fn *cancel,
 	 * as an indication that we attempt to signal cancellation. The
 	 * completion will run normally in this case.
 	 *
-	 * Do both of these while holding the wq->lock, to ensure that
+	 * Do both of these while holding the acct->workers_lock, to ensure that
 	 * we'll find a work item regardless of state.
 	 */
 	io_wq_cancel_pending_work(wq, &match);
 	if (match.nr_pending && !match.cancel_all)
 		return IO_WQ_CANCEL_OK;
 
-	raw_spin_lock(&wq->lock);
 	io_wq_cancel_running_work(wq, &match);
-	raw_spin_unlock(&wq->lock);
 	if (match.nr_running && !match.cancel_all)
 		return IO_WQ_CANCEL_RUNNING;
 
@@ -1149,7 +1178,7 @@ static int io_wq_hash_wake(struct wait_queue_entry *wait, unsigned mode,
 		struct io_wq_acct *acct = &wq->acct[i];
 
 		if (test_and_clear_bit(IO_ACCT_STALLED_BIT, &acct->flags))
-			io_wq_activate_free_worker(wq, acct);
+			io_acct_activate_free_worker(acct);
 	}
 	rcu_read_unlock();
 	return 1;
@@ -1188,14 +1217,15 @@ struct io_wq *io_wq_create(unsigned bounded, struct io_wq_data *data)
 		struct io_wq_acct *acct = &wq->acct[i];
 
 		atomic_set(&acct->nr_running, 0);
+
+		raw_spin_lock_init(&acct->workers_lock);
+		INIT_HLIST_NULLS_HEAD(&acct->free_list, 0);
+		INIT_LIST_HEAD(&acct->all_list);
+
 		INIT_WQ_LIST(&acct->work_list);
 		raw_spin_lock_init(&acct->lock);
 	}
 
-	raw_spin_lock_init(&wq->lock);
-	INIT_HLIST_NULLS_HEAD(&wq->free_list, 0);
-	INIT_LIST_HEAD(&wq->all_list);
-
 	wq->task = get_task_struct(data->task);
 	atomic_set(&wq->worker_refs, 1);
 	init_completion(&wq->worker_done);
@@ -1383,14 +1413,14 @@ int io_wq_max_workers(struct io_wq *wq, int *new_count)
 
 	rcu_read_lock();
 
-	raw_spin_lock(&wq->lock);
 	for (i = 0; i < IO_WQ_ACCT_NR; i++) {
 		acct = &wq->acct[i];
+		raw_spin_lock(&acct->workers_lock);
 		prev[i] = max_t(int, acct->max_workers, prev[i]);
 		if (new_count[i])
 			acct->max_workers = new_count[i];
+		raw_spin_unlock(&acct->workers_lock);
 	}
-	raw_spin_unlock(&wq->lock);
 	rcu_read_unlock();
 
 	for (i = 0; i < IO_WQ_ACCT_NR; i++)
-- 
2.53.0

