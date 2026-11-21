Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795296696;
	b=HtsHlSH8qYfAFakmW+M9Anh0dPYWBTl2FDcFHIMaBqFOgjPeCsCTIrQihQve5QX5+jdZ
	 kopEM6eHMP8SrvoOBe2L7tjT8F/QBmeDtFZ7JmXxVhOEiKpiiEckD1ZSGcN57uVa1ZI6J
	 Molu52Ur/QENNoiNGXEZcKMwNf1+yvhvGC0kHqWVLdR9EbuI6ZS1Bvm9/mPXIj44MTjFN
	 lAn+0dx6bXG/UdPDG9jQKHoQoCEBg/UXJbfhOC6yrFICiFTxXV+GDjmJhWJKifMHWQKtr
	 dmDge9fuFyaYldGG0sgFn9pOXMLhv3myuB84ItMBwim3PssweREZOA0zCI7+rkBVbVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296696;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cgto0Jxc5MFtqJQvmZ9bKi30qu76ezulkSWs5lty+KE=;
	b=dYMEyZhUwbhhHXQgaYlJdnKYbyY2i0GSeYhmr39/CUUDd6ODHpheLF8EuS6rQyq0LIYM
	 f7J2RJnmSA0k6NQdLxqeoT08OvHxV/EHoUzvJKbBz8N8jZG60kV2KqP4ljuSwPAmrTcgH
	 G7kvg3JaphelGmJL9j9t0u/tRFkXmYTm4cimKoptnS30jIuiuDYPDEHE01ydcv/Fk1gZz
	 UCA/+psb38Wq7dOwdiBI8D2oZFkYQKoAQS7slSI6OHUg37fBGib4HJ4NGlNQ2OrOKfSM+
	 Tdd7gWjgsku0j8QbJeH32TEMRXwJmyW2TXe2TPoqtRjN85e0VUPKnBiqMiiQ727YyTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=blfuPE4i;
	arc=none smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E4F606A32C
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:31:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4E4F606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=blfuPE4i
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-85ac281604dso957340a34.0
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795296695; x=1795901495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cgto0Jxc5MFtqJQvmZ9bKi30qu76ezulkSWs5lty+KE=;
        b=blfuPE4insqNPmjrt8AGWPbPmgICsFz/PkmP8GOpWJUsF7b8zqbYLh8gaZ7qGOJq0m
         Ii8oPnMLrNXEo9/mUL+WWVkk9txIKrHJYHcHPc9GKeWTtXRbX1+xcRYYZLtJAV4Z5QwD
         zWpuU3l1mKKVbvbVde2jyufMSgnCeD7Lm/selWDiTj58KxT9beNWN+8G6mYby5fhuHQR
         ANJD0scdkPT2XoHCARUWjrcMcjMiBLvFtPDQdn/H6VwMH4fSliUtJBP6Og0mnLZZuP9H
         d4QMHTR768q9j8qudAZVgMSKeLypojy5EEE2ycKGF68upbHnqi13IQdFKsYU1/mjNMHo
         GXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795296695; x=1795901495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=cgto0Jxc5MFtqJQvmZ9bKi30qu76ezulkSWs5lty+KE=;
        b=YN3jCMs4wZAV8mKmQ5I+UxJk0tdStcWuh/+wRO5w+NCI1+T98EprgaUfI0Kve479Q1
         wrulk8qcDBi7nDra76CHSFvfEspfzHTVZsX33rz/psXkRVliqJZPSTpTcHHr2weTN15w
         xqQVPcg13fxxyRlMssoA25E7qU8aNXhkxv2yTLWRnsZahE1N6ipurxf26lvXhDXh/zNq
         YyRDxp82EagnmOeqoUTSNGynbfLtBtgbu8ybrBuCwlHXmge975mV8XqhGOReVB/U+5dA
         izp1GJW0FArUU5Mo5ODLmL1kg7mZPIOBXrRH/zuRbvFxj51z/Dvuge2mLw3LRGgriPcH
         xakQ==
X-Gm-Message-State: APuU4Z9IbUFPxa5XKs4b2iJYi4h0RGb0kUG49i5VORtgF7Ty50NT62CR
	EyN9pUQhhf4uiEmi5VSOf0+i9emdu5gMOrR/tHnJ/8dcGbDvI8cvT865z2RpnKbQa82BY9rrOy2
	fJjWvY7s=
X-Gm-Gg: AZFdTZfJDmRTd5PA4349Q1+GEjpE8JY4y+96qTTjqn54WszE9E9sb9AE3XQXEPaiF9p
	uSPhbi+RZbD0V1lAW2oC/U7E1JrkauasUnpyjf4SCGiF04Rk1f9uj7JoJqJmDFMIhnUtyaTzwXZ
	jtBUNRsFZa5eIn17RH3SOR23wijHlhKjhS92wHwKl6az24eaEAMde+Hbyc0vclOI6lC42vMQ4yS
	rjoO7gHjS/W5PU4yFKo+E1yrvXad1+VmcMAOVFWKsqnm+4UvavQqCsthaLW7nnW08fN4PKuJ2ad
	SF4/Ym1bKJPPOyRpvRlCNh48pSukz3zv+7LEw/7V4F9fVjHautn01HTyeyF+2vp/czj+wx+1jE9
	zNoUC0LioYStIU5Uvm9CWcNoTEcx8lIXk2ImONmRRVFm3OD7ExKcYjO18744CVgcGGJD0JHzT6W
	XEY0mj7gDgqgR8/7I6DQyWlprE2YUbCBloHAc6hO3NzCTiXbQjZ8CQ18SJRGqdIbGano3wtXjfD
	piWv7XlfO8Z3PY/pO1qKqizfHnNgeKMMfHJOb8hdXltw71vKjoy7qo7yytYzwcKLEVbBP9AIY+i
	knkYgOrqs+NbYGYgpfIE+Hk3ahOlKSx6N1hSwNZH3vKSar7xWAPLGR00mqdMrpmjwcAd3ptdTVH
	PefOn/eBwT1fk3BUyosPJZLI2nYngH/MF5SiF
X-Received: by 2002:a05:6830:6816:b0:862:c3f1:634c with SMTP id 46e09a7af769-86315a059cbmr8508546a34.25.1795296694883;
        Sat, 21 Nov 2026 13:31:34 -0800 (PST)
Received: from r7625 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863168f6d33sm4946113a34.18.2026.11.21.13.31.33
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:31:34 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.12.y 9/9] io_uring/io-wq: apply the current cpuset to new workers
Date: Sat, 21 Nov 2026 21:31:21 +0000
Message-ID: <20261121213121.1789042-10-axboe@kernel.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121213121.1789042-1-axboe@kernel.dk>
References: <20261121213121.1789042-1-axboe@kernel.dk>
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

From: Mikhail Malyshev <mike.malyshev@gmail.com>

Commit 0659e44ce739ecd856164c75a5325b7959a2921d upstream.

Since commit 84eacf177faa ("io_uring/io-wq: inherit cpuset of cgroup in
io worker"), io_wq_create() copies the cpuset of the creating task into
wq->cpu_mask, and io_init_new_worker() gives each new worker that copy.
A cpuset change, or a move of the task to another cgroup, updates the
workers that exist but not the copy, so workers started later run on
the CPUs the cgroup had when the io-wq was created, which may since
have been given to other tasks. Workers come and go for the life of the
io-wq, and a worker that cpuset moved is also retired at its next idle
timeout and replaced on the old CPUs.

Keep wq->cpu_mask for the affinity of the io-wq itself, all CPUs or the
mask set with IORING_REGISTER_IOWQ_AFF, and intersect it with the cpuset
of the worker when the worker starts, falling back to the cpuset if the
two do not intersect, as __set_cpus_allowed_ptr() does. Use the same
mask in the idle exit test, and go back to all CPUs when the registered
affinity is removed.

Fixes: 84eacf177faa ("io_uring/io-wq: inherit cpuset of cgroup in io worker")
Cc: stable@vger.kernel.org
Signed-off-by: Mikhail Malyshev <mike.malyshev@gmail.com>
Link: https://patch.msgid.link/20261111162705.1150983-1-mike.malyshev@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/io-wq.c | 44 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
index 181eecdb32c0..91b83751795f 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -687,6 +687,34 @@ static bool io_worker_retire(struct io_wq_acct *acct, struct io_worker *worker)
 	return false;
 }
 
+/*
+ * The CPUs a worker of @wq runs on: those of the io-wq affinity that the
+ * worker's cpuset allows, or the cpuset if they have none in common, as the
+ * scheduler does with a task's requested affinity when its cpuset changes.
+ * Read the cpuset each time: it can change while the io-wq exists.
+ */
+static void io_wq_worker_cpus(struct io_wq *wq, struct task_struct *tsk,
+			      struct cpumask *cpus)
+{
+	cpuset_cpus_allowed(tsk, cpus);
+	if (cpumask_intersects(cpus, wq->cpu_mask))
+		cpumask_and(cpus, cpus, wq->cpu_mask);
+}
+
+/* Is the current worker on a CPU that a new worker would not get? */
+static bool io_wq_worker_off_cpus(struct io_wq *wq)
+{
+	cpumask_var_t cpus;
+	bool off;
+
+	if (!alloc_cpumask_var(&cpus, GFP_KERNEL))
+		return false;
+	io_wq_worker_cpus(wq, current, cpus);
+	off = !cpumask_test_cpu(raw_smp_processor_id(), cpus);
+	free_cpumask_var(cpus);
+	return off;
+}
+
 static int io_wq_worker(void *data)
 {
 	struct io_worker *worker = data;
@@ -748,8 +776,7 @@ static int io_wq_worker(void *data)
 		}
 		if (!ret) {
 			last_timeout = true;
-			exit_mask = !cpumask_test_cpu(raw_smp_processor_id(),
-							wq->cpu_mask);
+			exit_mask = io_wq_worker_off_cpus(wq);
 		}
 	}
 
@@ -799,9 +826,16 @@ void io_wq_worker_sleeping(struct task_struct *tsk)
 static void io_init_new_worker(struct io_wq *wq, struct io_worker *worker,
 			       struct task_struct *tsk)
 {
+	cpumask_var_t cpus;
+
 	tsk->worker_private = worker;
 	worker->task = tsk;
-	set_cpus_allowed_ptr(tsk, wq->cpu_mask);
+	/* Without a mask, the worker keeps its creator's CPUs. */
+	if (alloc_cpumask_var(&cpus, GFP_KERNEL)) {
+		io_wq_worker_cpus(wq, tsk, cpus);
+		set_cpus_allowed_ptr(tsk, cpus);
+		free_cpumask_var(cpus);
+	}
 
 	raw_spin_lock(&wq->lock);
 	hlist_nulls_add_head_rcu(&worker->nulls_node, &wq->free_list);
@@ -1269,7 +1303,7 @@ struct io_wq *io_wq_create(unsigned bounded, struct io_wq_data *data)
 
 	if (!alloc_cpumask_var(&wq->cpu_mask, GFP_KERNEL))
 		goto err;
-	cpuset_cpus_allowed(data->task, wq->cpu_mask);
+	cpumask_copy(wq->cpu_mask, cpu_possible_mask);
 	wq->acct[IO_WQ_ACCT_BOUND].max_workers = bounded;
 	wq->acct[IO_WQ_ACCT_UNBOUND].max_workers =
 				task_rlimit(current, RLIMIT_NPROC);
@@ -1453,7 +1487,7 @@ int io_wq_cpu_affinity(struct io_uring_task *tctx, cpumask_var_t mask)
 		else
 			ret = -EINVAL;
 	} else {
-		cpumask_copy(tctx->io_wq->cpu_mask, allowed_mask);
+		cpumask_copy(tctx->io_wq->cpu_mask, cpu_possible_mask);
 	}
 	rcu_read_unlock();
 
-- 
2.55.0

