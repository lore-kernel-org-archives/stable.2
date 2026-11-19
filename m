Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795105302;
	b=XQrUjD3hNq/GzPgO9w5AlcJO/nupxECqatn/uJrfTMkydLtRO0REcuQVHCReKfWvsHMq
	 6y6C5S102yrwgqU9Nmojj/In9jZ3yBZFKc2oX7Nec707k4S51ZKKVTJ4sBM8iJzp+B01J
	 gli8ihWNeGuHHubGMv3aXwgl6v/+aO1oPE/IuKxzVBlpHolToek5XG38WpkatWnN7yYgd
	 AIDkDChU6w0WSLg+chQpDk87DQUlfBUW78cdaQR7T+92IiGadepYOjBJCNOBvllI22LOd
	 vfPjW/g7bFr38U8pR6mLBf1G4IDKZP6Z16YuDXU7ktNPkltyQmplC0vr9JjoV/NakXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795105302;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YUpRYsuuZ9zTOzlFogFq/lthSpzrXEJar3Q39+/3IbQ=;
	b=BYEyTiFCyytpfAuYAjE23PJh2nq6NsHMdwvy9LigG08fhA8gQ+q2JOCKAnlRB18DiiyW
	 iyrrtNF9CZIg+uTcrUaqe7w7GBmr1Sdq241uUGxbUprY9SdyGwG/F40pT+8Zvjv5/FoIg
	 zdGpmb6bASIzJ922W+beUPLRq8NnU9PArlbWU9XOSspzNs8tUwsZL8FSzUkW/yOJaOwOv
	 Xk1KHvYTf4yDCEHm1uhEEXqpk4LJe0dx8vwR5c8BVo/PsF77eZOJFi/YouC7AYrbzA0wm
	 QhmTcNJaHJ6nVOAgjCXToPO+b+3qTlcxTH5e7Zs/66VzsGy+ljsikuIYMgv4GiWcO1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=ccqCjSmi;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D13D60A2612;
	Thu, 19 Nov 2026 16:21:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D13D60A2612
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=ccqCjSmi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1795105301;
	bh=YUpRYsuuZ9zTOzlFogFq/lthSpzrXEJar3Q39+/3IbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ccqCjSmiUTYRBtlf3YUYHVeC5wXz8HBLgbmz8C9Z5iYvUqZapFz+HLVxBwBDr8b2D
	 Byvf3w0oFA966agPhiNo2hmYicRButzyyOxlgPqTbZUJbCYz5L0NGM3cMbcQqmboHv
	 qDf4Fh9RUQzcMplnLYQOuDdQ6Wuls9l5oy22EYdTb20V/3g2o4A2mCHpHoFxLmz0d2
	 LPd8+RVh05pIJBN9DAYKkFTWUWZsG11XXhipJF5u44L24o6ZiQ65sgymwHov4mjWZU
	 Iec0e/d8EkSSA/o4HvyHC3YwE9pEAfbpfJAhtxSNt+riGS1dpmcovIfAQ/AgpCf4ic
	 5gQ7t4SegvRKw==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jVkHm71smzRqT;
	Thu, 19 Nov 2026 11:21:40 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: 
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 09/17] sched/deadline: Reset the deadline and the runtime with the parameters
Date: Thu, 19 Nov 2026 11:21:30 -0500
Message-Id: <07a810645c5ab919a52ffe2cc4b63074a84751fb.1795103339.git.mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795103339.git.mathieu.desnoyers@efficios.com>
References: <cover.1795103339.git.mathieu.desnoyers@efficios.com>
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

A task that leaves SCHED_DEADLINE keeps its parameters until its 0-lag
time, so that leaving and coming back gains nothing. Commit 209a0cbda7a0
("sched/deadline: Improve the tracking of active utilization") moved
their reset to that time. Before it, the replenishment timer did the
reset at the deadline. So a task back after the reset found its
deadline passed, and started a new period. But __dl_clear_params()
resets neither the deadline nor the runtime.

Now a task back after its 0-lag time can be enqueued on its old
deadline and runtime. With runtime left, its 0-lag time comes before
its deadline. Back before that deadline, it would first spend the runtime
of the reservation it gave back. Back after it, a constrained task
would be throttled until its old period ends. "sched/deadline: Do not
lose a throttled task switched out and back" moves the deadline of a
throttled task on. This widens the window before the deadline to about
a period.

A task with no parameters of its own, boosted by a deadline waiter,
keeps the donor's deadline and runtime after its deboost. If it then
enters SCHED_DEADLINE before that deadline, it runs on the donor's
runtime. On v7.4-rc2, a task of 10ms per 100ms ran 40ms of its first
period.

Fix this by resetting the deadline and the runtime in
__dl_clear_params(), and in switched_from_dl() at the deboost of a task
with no parameters. The next enqueue then starts a new period.

The Sashiko AI review of this series found the first case and the
deboost. The deboost_resets_period case of deadline_bw_test, added later
in this series, tests the deboost.

Fixes: 209a0cbda7a0 ("sched/deadline: Improve the tracking of active utilization")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Cc: stable@vger.kernel.org
---
 kernel/sched/deadline.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 71b1c155c242..d6d2657dcddd 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -3569,6 +3569,16 @@ static void switched_from_dl(struct rq *rq, struct task_struct *p)
 	if (task_on_rq_queued(p) && p->dl.dl_runtime)
 		task_non_contending(&p->dl, false);
 
+	/*
+	 * A task with no parameters of its own was boosted into the class.
+	 * Its deadline and runtime are the donor's. Reset them, so that its
+	 * next entry into the class starts a new period.
+	 */
+	if (!p->dl.dl_runtime) {
+		p->dl.deadline = 0;
+		p->dl.runtime = 0;
+	}
+
 	/*
 	 * In case a task is setscheduled out from SCHED_DEADLINE we need to
 	 * keep track of that on its cpuset (for correct bandwidth tracking).
@@ -3984,7 +3994,8 @@ bool __checkparam_dl(const struct sched_attr *attr)
 }
 
 /*
- * This function clears the sched_dl_entity static params.
+ * Clear the static parameters of @dl_se. Also reset its deadline and its
+ * runtime, so that its next enqueue starts a new period.
  */
 static void __dl_clear_params(struct sched_dl_entity *dl_se)
 {
@@ -3995,6 +4006,9 @@ static void __dl_clear_params(struct sched_dl_entity *dl_se)
 	dl_se->dl_bw			= 0;
 	dl_se->dl_density		= 0;
 
+	dl_se->deadline			= 0;
+	dl_se->runtime			= 0;
+
 	dl_se->dl_throttled		= 0;
 	dl_se->dl_yielded		= 0;
 	dl_se->dl_non_contending	= 0;
-- 
2.47.3

