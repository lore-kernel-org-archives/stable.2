Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795296712;
	b=4x9J6Gmf6b4OuI+52CclsU4vYJ5de76ZlvG1mtZUBXFUWNKP2Qf6ubuXvi9g/5uDwKf/
	 gWLKkG5gV58psXbaayf+ws/Iz8KYXCQY+hguY2kti/3+Wf5JNlgFciEjNikspOtM5BNfQ
	 FL+UxL1AUvPMvHqoGUAJVzhCZ6WvC23d7HswjUMqQX46ThJiMSua0w89EGu6QP/6KYDdB
	 n9lLo5nCeVFpQX5DVS4sUOXf7N53Akzb17ltGlD/nHxOa+/M7LAog4mCNlK1Az4xMqRv4
	 q/FhgYMe2IIdBby5PaQTbPPAvlTaA20G2SRWN4J59sDvca/riCkn9fSebolbAnnfgnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296712;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SsSRAihF7rV2AchLcWNYmsnwzdG8HHn/bpPv2Vi7cc4=;
	b=fiSkLDTqhRm8mI7O9+zUcVaHEIUdMrtCTa0U8kBNXRnI68OqgywwCbGjLVxHLQxitQ8T
	 GMMNY1y172/83SzzLsH8sFebkERjBcglwUW1kO4CiPXwq+b5kVMTNVE+y5kmHvhVPaqjK
	 zxu6t+L5nWHSXEWN4Vo9ic7a57kD8porQzfutw5/PfdECYpMHN6aSOZo129OAATAlPZS8
	 P29tqHGLb4TcuGO+ZmgQi9ljFr8DciUTqBZa6ozFBBBv+g5d0XDw74E9B4KWZIpXX+CrW
	 /nqlrjgqNtFRsW4v1CgQ6paHeWjbHFDzUMKgg0AvXE/c91tEYqSvVd7NVBWt7of4a3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=WSHJOb+g;
	arc=none smtp.remote-ip=209.85.161.41
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9333606A320
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:31:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9333606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=WSHJOb+g
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6ddef424972so1733433eaf.3
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795296711; x=1795901511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SsSRAihF7rV2AchLcWNYmsnwzdG8HHn/bpPv2Vi7cc4=;
        b=WSHJOb+gvCeZ8Hbwcr7Y9Dzbsc6UqJgKPbv8zmhYAmV6BQwP/Hx04Ydv5hl640AzVN
         BMxQiXj3T21mqlwyScMpD30RagWRAZ18sObCsgrR5czx8TYulJIegrURj3g+jRC74W+v
         MifciG05Devv73GoUvtAAP+debxXMIZ2QrhRLVBfXy9uqxvcr4wzCQgcofbD+epUhew8
         G04QKvOIb8SXqAuviBHuMdz4jE720CLOpmKa3oXJ4AK9bYgVv0Uy+K3bem3q2N4hXDwE
         nTOUj+O9sLSvCFj0pHBC7Rv+lePMH2vcAVJBglgZutShHy5AwfVrQCVlST8v+iewMQpR
         MZ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795296711; x=1795901511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=SsSRAihF7rV2AchLcWNYmsnwzdG8HHn/bpPv2Vi7cc4=;
        b=Wi15rKQ9vgjME03V2F3e8JD7rQVuboE1SNHXcvPSp2cb3hYwbzZjzBacZhho55naeT
         fKVXM+afSWfPNkwIU6lWvCwmgsFE6d6QLIbfi+hUph6P30r9ht0TihLgTz/jWvutKjEs
         lEwbTLRMriSDZaOjcmkNFil0hU7xWpbnfh4HIqpTKuo81yRUqyLh/IKIz39fFCl3vRUE
         FaWEi5lT/+GPbRjA9JKA2YSwVuHyLjVT7nCmqGJpItmeb12GX9xDI3dvWFX7fIzbVLaW
         r6AfQNKWdGg1okTFLAGhmMPJllRsIkJhf0i5MFLlSE3uAh2TevVwNY1AANRMnYBBBEee
         gcig==
X-Gm-Message-State: APuU4Z/nCP3fovGs40X02JJgo67Cwx8rRWhT9LwEV9DL45fQCCUOZB4J
	2BQ398GJdOfo5/pZCdlPakS9jCgByUfl6PYDAJU9JSreJ+PRP6YUzXE2GMCYrNpc6Rs8Y50rFIb
	vEnXkSHs=
X-Gm-Gg: AZFdTZc82nsRYSvkgEr7LZkx/cPmCWRPAzxqL30Qu57tBmMvN1GOeY8sTOpptqaBUmq
	LfabCuPe1pgtLUkMuVIqIkHQxarr2J4r9gWFjst6QuHlUYDWLpDei8U85TJDxVx/MpUZXvakZA8
	wxCGnS21QDZkBHzCWUgyd/1nRLPWGFXQAB+0RZ4iXk2W8o3zRpJaZJqVuYdAKq56EpFxyFNW4F9
	zlaZQiXEAFP1W0o92BNHQyepto5fncchOdMSXLEanwciNSCVF2P4ISBCmHYrqvpEGlScif+lu3g
	Hft1fWozRoTWtaMpDmIOyV7xnIk5JO2IHiIQswAuxtIzYy9AN3ucgbfswnx5qFD7DxRyE+L2oYf
	42QhUtFgGQdF6aSM9AHvzmdjUBAkOZvccogAUu/K+B10SPw1E3fge2/U+EEIiUFMNKZn7TWipy5
	qfAOO7Kxfxf/+GCmD/OZAXWEM1GziYjOnviDewML6NmuYT7bjpiax3lfPZRZw/s9IKEgmOwUy12
	5hlnX4fdVHQRwPKHL10JomF7ki57tmJ/LvfGow2guCktXv2Nknu2TIOHAveqrh2KmbIFXJVYeTh
	4uSO/6ORepnTRRkUCkXOcV3+R0NLdBqbgX3FYS2bY5V+8H0IucRv0lf0f23zdzJ9eFVcRztKr05
	mBgAYSVflK2W+Y8FXhrhFMsMjR8a1k0mEh0fG
X-Received: by 2002:a05:6820:60a:b0:714:b1a7:fc04 with SMTP id 006d021491bc7-71b395b43b2mr6038615eaf.86.1795296710669;
        Sat, 21 Nov 2026 13:31:50 -0800 (PST)
Received: from r7625 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b380e4a6dsm4669694eaf.13.2026.11.21.13.31.49
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:31:49 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.18.y 8/8] io_uring/io-wq: apply the current cpuset to new workers
Date: Sat, 21 Nov 2026 21:31:37 +0000
Message-ID: <20261121213137.1789687-9-axboe@kernel.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121213137.1789687-1-axboe@kernel.dk>
References: <20261121213137.1789687-1-axboe@kernel.dk>
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
index fd53297af26e..0d74e365d54a 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -731,6 +731,34 @@ static bool io_worker_retire(struct io_wq_acct *acct, struct io_worker *worker)
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
@@ -809,8 +837,7 @@ static int io_wq_worker(void *data)
 		}
 		if (!ret) {
 			last_timeout = true;
-			exit_mask = !cpumask_test_cpu(raw_smp_processor_id(),
-							wq->cpu_mask);
+			exit_mask = io_wq_worker_off_cpus(wq);
 		}
 	}
 
@@ -860,9 +887,16 @@ void io_wq_worker_sleeping(struct task_struct *tsk)
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
@@ -1361,7 +1395,7 @@ struct io_wq *io_wq_create(unsigned bounded, struct io_wq_data *data)
 
 	if (!alloc_cpumask_var(&wq->cpu_mask, GFP_KERNEL))
 		goto err;
-	cpuset_cpus_allowed(data->task, wq->cpu_mask);
+	cpumask_copy(wq->cpu_mask, cpu_possible_mask);
 	wq->acct[IO_WQ_ACCT_BOUND].max_workers = bounded;
 	wq->acct[IO_WQ_ACCT_UNBOUND].max_workers =
 				task_rlimit(current, RLIMIT_NPROC);
@@ -1545,7 +1579,7 @@ int io_wq_cpu_affinity(struct io_uring_task *tctx, cpumask_var_t mask)
 		else
 			ret = -EINVAL;
 	} else {
-		cpumask_copy(tctx->io_wq->cpu_mask, allowed_mask);
+		cpumask_copy(tctx->io_wq->cpu_mask, cpu_possible_mask);
 	}
 	rcu_read_unlock();
 
-- 
2.55.0

