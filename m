Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795296729;
	b=MUfKw7i+7/vg9ksKiybOXI5HxgQwpt0Lm56/Eao/FuU7tqJkxWIq9gj43gVRPiGHI9DE
	 R7XtVJbBCYoz3rKhcRyj4Pv73GKI85dcI2DdRYK7jgXhnXWeCOsyO7KyvpqS5RnXX5C+y
	 jVHIBGdiIH/AsjwifYmHmfFlguUWNdMF+lROIsD4bvtK9sAn2IDyMxOajao0Iea6f9SDv
	 EhzDlEO3dHFAt1d223ssVj4/Wfjbb/6m4ozGZsOGQc8QTHq8YCWPpSYCm+q/9gTuH447M
	 OE3VP3pVA8SCt3qnfkvGrj4AdwMTpb5HGydfX+GxiZoeDIjQ3maWJWx5s7w6V/ORh2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296729;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0KahLApZFCTBrdJcQn/eaEyqFQ7TxYFmelySxzNm0tk=;
	b=FFgA90J7ePWTPS3/Mj/ppcHNdpu3lSns3Yw0uS2NOtqSaleCfQpKpXaxWdD16J1vHsFG
	 KYe0DObxuGLBqUr/UTrXJ/ld7XecnPlxWJHDKzfJKP8EXaujiZ9wq7XiO6+5RA2/TsZ6R
	 eSi622eQLt+0EGrtQOVbaSxNIveSdUfJsXpSonjetr6OvQOE+eMOD293imNb90BTrZk6z
	 m6SBouvngOjyhNo88VYKgr8kYnQUOhpEp5/j1fXI4L3Di7TPozMDmJ3xn5+IAZF13T4kR
	 mng36cqx9qF9gzIJY/grJUZrRluC2iR6vDdiCpcisADGt5WKSAAWSMFdCB4wd5uul2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=GMGL2Swl;
	arc=none smtp.remote-ip=209.85.160.49
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC598606A33D
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:32:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC598606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=GMGL2Swl
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-4a76f0cce5fso981354fac.2
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795296728; x=1795901528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0KahLApZFCTBrdJcQn/eaEyqFQ7TxYFmelySxzNm0tk=;
        b=GMGL2SwlMcvL0XJ5lFMpNX6qWUqls2Yj0c/a/BL9vIVF2psDCZKJUXSHORxfMje4fj
         1oRMj5qwVmIUERJuPFcy34pBMshiAcUxLTYheVNxsi/yukmwWzafNMMfyOMEvO7h0G7z
         9Y118HKI2Fh2ngygxuLYRlAJMXQkOpUwigsdbrQKGFrzDrF96PDDuRPtsFHy6FLXnY85
         v9VTVLkws4KgEz4GYOBdbYsVKE1bobZ0tPtOMnd0S5H80GSGco5SmsSlUh3TOsxRnFNe
         JMLxv4+iqzM/NiS2zInDrNq+atNenLauZ/glLlrRTdJatXDGuWaFrERfyMrp6pcG2O3T
         lmoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795296728; x=1795901528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=0KahLApZFCTBrdJcQn/eaEyqFQ7TxYFmelySxzNm0tk=;
        b=1iAm86XcS05FHRrmaqvBjISXphYaZebujrVG3z+tRTLJMgQ2hPqiUzMBBHWTYAF9iQ
         IVsq5TyuPvbwnXdOpdtGuR5BXYqornxzDB/sKiNd8w6fYudDrNulNlKtQidAZuVgI1OW
         eEh4H/Pq/55SHaw0eGlE4f+r0DIAO9bBfA49iS/emNuL9Y928Sk7Fz9lkRUJMVHj9WWB
         IQHYXZ9179wbBNLVgIjrz4MAGH59qBlrqeQD+cvUT8l0ykeFxeQ0IFVAx/bK3d/eZJ/K
         No9NiswuKraLiRZjpIaGPNmOWIwb8PFlRhpij/k3WcuzGkhVG5u71nUjNF4bzllSN04s
         m3GQ==
X-Gm-Message-State: APuU4Z8YNM6JKEwhXP+WwHV0UYynkN/yXUwfpt2cF3MQnnzlVSGXtRPD
	q3zTf7x73G9PFXQTQjBrGuZzL4ULQsLZHn4RoHo1VqSIfLKdMXAYwriVIgesPxYLmZzEWcfC3u5
	ROkZbBIM=
X-Gm-Gg: AZFdTZcY6j3v+YhCfKI93moFylE72mF8RaZ8mP+VnqRlc9RN7tn06B8tAWkku80wNHW
	LZcAD1Vnr0x9THoq/6FOjhOPD1nlA78H4xo42SNo1T8rR2Qaw2HMOMMoYMQ83KjIdBAdseNcwBA
	kgeqb5s7JViXZciIgLaaRyuTKHj+nhxDzRHw0ODtV4aA5j+DvNm4ai3UO+nmmNFdllKDE3CavAr
	j8GIDaCa0uxz0aTsXqhBp9mPO5n+3XYYIU1GT82SOO75lttYiZhEKen3TB+0t2IFEvFeEwyKeQ6
	ABQIr+DDimXHi8mKdVHAR5gzcAujdg/siGvQ1zLV60Z57Ee7b2fs60Baifk2xQJc9n9whiqBZ46
	UmPLy7jPgcq3jNuF0c5/9ywAe7JBehiBErYSfZNKSpB0J4ctKIpeiN8oWsJbUFLTnnVzzRET8Re
	qx37LOWrITe9J0QDLYl1nmar1/R5zix+vyCXofOsyTMR/rhT7pL9Mf+aXF7QmuSeW3EAiTwt+C9
	4Q/9+eTRCeqz9sSxgKRUdfCXVjSTUfpmoHXrZ6piSt6DVNVaU3xRT41WM0BumMIQXi4HwqtCNgM
	6y2lstnUpiDPdYmvaomxr7NDmtFImpX7IyvEd8GNnsn5rNTKECzdjBnaD7hMJlx3INdc+c1aqm+
	ZS9Kt60iycxqfa+itv/lTo5TaRdC9LFcnQJNoarEHUm/KSNZThZj0gwDj6w==
X-Received: by 2002:a05:6871:54a:b0:498:f70a:b54e with SMTP id 586e51a60fabf-4bc8434fa39mr6704032fac.43.1795296727622;
        Sat, 21 Nov 2026 13:32:07 -0800 (PST)
Received: from r7625 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc55895b9csm6204636fac.0.2026.11.21.13.32.06
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:32:07 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 7.3.y 9/9] io_uring/io-wq: apply the current cpuset to new workers
Date: Sat, 21 Nov 2026 21:31:54 +0000
Message-ID: <20261121213154.1790334-10-axboe@kernel.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121213154.1790334-1-axboe@kernel.dk>
References: <20261121213154.1790334-1-axboe@kernel.dk>
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
index 358f32888a85..d2ef08d65ec8 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -738,6 +738,34 @@ static bool io_worker_retire(struct io_wq_acct *acct, struct io_worker *worker)
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
@@ -816,8 +844,7 @@ static int io_wq_worker(void *data)
 		}
 		if (!ret) {
 			last_timeout = true;
-			exit_mask = !cpumask_test_cpu(raw_smp_processor_id(),
-							wq->cpu_mask);
+			exit_mask = io_wq_worker_off_cpus(wq);
 		}
 	}
 
@@ -867,9 +894,16 @@ void io_wq_worker_sleeping(struct task_struct *tsk)
 static void io_init_new_worker(struct io_wq *wq, struct io_wq_acct *acct, struct io_worker *worker,
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
 
 	raw_spin_lock(&acct->workers_lock);
 	hlist_nulls_add_head_rcu(&worker->nulls_node, &acct->free_list);
@@ -1366,7 +1400,7 @@ struct io_wq *io_wq_create(unsigned bounded, struct io_wq_data *data)
 
 	if (!alloc_cpumask_var(&wq->cpu_mask, GFP_KERNEL))
 		goto err;
-	cpuset_cpus_allowed(data->task, wq->cpu_mask);
+	cpumask_copy(wq->cpu_mask, cpu_possible_mask);
 	wq->acct[IO_WQ_ACCT_BOUND].max_workers = bounded;
 	wq->acct[IO_WQ_ACCT_UNBOUND].max_workers =
 				task_rlimit(current, RLIMIT_NPROC);
@@ -1588,7 +1622,7 @@ int io_wq_cpu_affinity(struct io_uring_task *tctx, cpumask_var_t mask)
 		else
 			ret = -EINVAL;
 	} else {
-		cpumask_copy(tctx->io_wq->cpu_mask, allowed_mask);
+		cpumask_copy(tctx->io_wq->cpu_mask, cpu_possible_mask);
 	}
 	rcu_read_unlock();
 
-- 
2.55.0

