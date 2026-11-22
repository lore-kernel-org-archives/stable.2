Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795370712;
	b=oMWGFcYY7aF+6U/fwkf7Aw5NJEYmQ9uHLr2NaOiYOZeKJedq8aCqg2DvuZ27AV51gx5z
	 RPJbJteuomnFOrffE+ycfWDGyPzo/4uDjop3+AcNge6piRtWXor7cQ5BRtG2hYkW3fIGu
	 3ocOM2RAQCbwC6L12/Al5MOJhU6K0CgszwUSXQfGwpsKq81Ypiv2TkrbSI5+4H8f3rGHf
	 QQkyU98vqwFnbKtf6HBUzY2OHTNzIkbkHUiQzG1vwB8denLT3EsAuaxR0g1wMWW3QfF/E
	 vdPQNwcrlqz/fKX325WWof0sKq0oR5Xvz0rStir8Zl5ZPKxe2IW+iSohEjP7GkhZIdg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795370712;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=tBoteG1B5Z54++42pujnb/6truX3e6FwCuA6X2V2eYg=;
	b=N2PINMpei6lngvJ+2GN6AfQjKFz+jGU6nSbAJgvqw+EIufmcVjzgZ3S6fEKnneIPvV9C
	 Axu6DZcgPKzREU+OkaMa7XyoLZDPM+7yBKlH7waGDqqhF6at7QKuQ/5YdQVtMSgDcInTb
	 AqSVUZgsWrY575D7f27c1i1Y2UE8BfeJDPXt7p7FtsYjU83LZjO+pnMqsdLULnQsarR5S
	 CtCu19eMPFnSEtLHHW7sxNovVusIIBnuKmo8kX/MyEKI7Rze5EcqoB75Vt8SmofOjzHMq
	 h7nw95H7EfrZRYhTAmvGtP3N6WbcgYmSFQygA5zcdkHdhPNKBa0fMTrd24KX4DkHukQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n5BEddE5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38CB606A330;
	Sun, 22 Nov 2026 18:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n5BEddE5
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795370712;
	b=sJ9SvNeoWhA23UPxwbLaPDstStliJqHt3avBfjO26YAu9mvhNboUqKHi6Ds/4jIAQdny
	 3899GrP9M7SFXai6tKkq2W2UmnN+dZ5ne61H0WRtoPIMy4OEDb7VaEgwOD47XLD8zNF+u
	 xSkkT0mETntmMTOIBP4uGB9nSMNvAzdXAv5qGgq2HiReNvwCLFO2yZCjipHROpZIuv11C
	 YwFjyy38iOBWWrMTfupOk9Ba09AwlRj6clM/Ny4u68S7tlMiMvV57N+bviioItUIzXnLU
	 n+XMr49mwsqW3Y1kA9D01WBxm/9MfG52dca6ZIreDlgzENd/PUfuIYn7rTYRF8l/r1g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795370712;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=tBoteG1B5Z54++42pujnb/6truX3e6FwCuA6X2V2eYg=;
	b=aDtlU6C9FZxO5QtKI3XKEQ9vfT7E8ef/JilLR0g4liAGD2RROFSKYi2qUj3UU8INoUHQ
	 tuw+9iMHkmGvvSTCBvltsxj3E7fRHHiWTfKzTNHi3rDVp1hZ/ZygZRT8FY3m0NElIEY25
	 M1e367rYCwgOU2iy66L9sxErpNUnjvHbWwUsQfYADo8clm1F+78Zxy5ArP6rS8tcF5sa2
	 cRFoedKp13429naaEysz1Oes6Zz3ODuRRgZ4SM9K0PnjrStwD/rnUp84qQSGF7s8cgjnV
	 eYWJbGGkabUQ6sPz269rFGQ9NlRZjIWrWyurzvK/wH6XDp35b/9IToLrteT1n+hC88Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 416CB1F000D0;
	Sun, 22 Nov 2026 18:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795370712;
	bh=tBoteG1B5Z54++42pujnb/6truX3e6FwCuA6X2V2eYg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=n5BEddE5hSv29+oqv+mYmxzke4pZi/w9TNHx8enFZu8aKQLb9a6WFfuEeLYuKNSt2
	 xgu365aki4TydWsGwasL0f4tunUJ4Ej1hd3DsUnK3kvbKrNSeDJSD85UuzAWDGfGoG
	 98rM1pgfzgMqnozHfzywXiUT/KUxRS/67AJyLh53KHnNx6Jr87u0qAEQ+Re98rnu39
	 VwC/82dIDCwOP1e1DeHhMB0mAmKmdOaC8UpaN719xCtRgOUHe9gBoJOz6fJPlbglCI
	 75pQ57QcMRtjQ2BL/5fE84wt3ew1dN2oo4mIbJPZvepmxPeQIwksZuZ5neX8TM8NUG
	 sHR+LYn80nr4Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C772A4C16E;
	Sun, 22 Nov 2026 18:04:57 +0000 (UTC)
From: Hang Zhengyang via B4 Relay <devnull+hang.zhengyang1010.gmail.com@kernel.org>
Date: Mon, 23 Nov 2026 02:04:55 +0800
Subject: [PATCH sched_ext/for-7.4-fixes 2/2] sched_ext: Start ext_server on
 every enqueue
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261123-scx-dlsrv-v1-2-87c342d8246e@gmail.com>
References: <20261123-scx-dlsrv-v1-0-87c342d8246e@gmail.com>
In-Reply-To: <20261123-scx-dlsrv-v1-0-87c342d8246e@gmail.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, sched-ext@lists.linux.dev, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Hang Zhengyang <hang.zhengyang1010@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795370696; l=2788;
 i=hang.zhengyang1010@gmail.com; s=20261008; h=from:subject:message-id;
 bh=IN+RzU0ozG0gu9jpgj8RQX7xnqAmt1p/9Ryev7xZsHs=;
 b=PBlzI9W8mu3TSEauajkWdQrAzd1AqzlaCENqlVjkb4t0v+4rFy34xdXGM5gfws4X31CEenbmz
 J5mBQnzaSbJDb/CHHWnwHEP9oZMXC+/uynAZfLq+Dk6hzmBLX9Vi1OS
X-Developer-Key: i=hang.zhengyang1010@gmail.com; a=ed25519;
 pk=5drRny3PqRPLhKVB0YIQXN5YyD8miKCpXWhnEPvafAI=
X-Endpoint-Received: by B4 Relay for hang.zhengyang1010@gmail.com/20261008
 with auth_id=1133
X-Original-From: Hang Zhengyang <hang.zhengyang1010@gmail.com>
Reply-To: hang.zhengyang1010@gmail.com
Content-Transfer-Encoding: 7bit

From: Hang Zhengyang <hang.zhengyang1010@gmail.com>

Since commit a3a70caf7906 ("sched/deadline: Fix dl_server behaviour"),
ext_server stops when a pick finds no task, and a later wakeup starts
it again. But enqueue_task_scx() starts it only when
rq->scx.nr_running goes from 0 to 1.

For sched_ext, a pick can find no task while tasks are still counted on
the rq. During a disable, scx_claim_exit() sets sch->aborting. After
that, scx_consume_dispatch_q() no longer takes tasks from the
scheduler's DSQs. nr_running stays above 0, so no enqueue restarts the
server. An RT task that keeps the CPU then starves the sched_ext tasks
there.

A stress test hit this on a debug kernel. While CPU hotplug was
disabling scx_simple, the server on CPU 0 stopped with 3 tasks counted.
A SCHED_FIFO spinner then took the CPU with 15 tasks behind it. One of
them was the RCU grace-period kthread:

  rcu: rcu_preempt kthread starved for 65011 jiffies! ... ->state=R ->cpu=0

The disable was waiting for a reader of scx_fork_rwsem and never
finished.

Call dl_server_start() on every enqueue. On a running server, it only
clears dl_defer_idle. On a stopped server that ran in this period, it
restarts the server at once and reschedules the CPU, even under an RT
task. So while picks find nothing, each enqueue costs one extra pick.
This lasts at most one server period (1 s by default).

Peter Zijlstra asked whether the server should start only when a task
reaches the local DSQ [1]. That is not enough. A task often gets to the
local DSQ only through this CPU's own pick, and that pick needs the
server to run.

This doesn't cover a task that another CPU dispatches to this CPU's
local DSQ.

Link: https://lore.kernel.org/all/20260202195035.GG1282955@noisy.programming.kicks-ass.net/ [1]
Fixes: cd959a356205 ("sched_ext: Add a DL server for sched_ext tasks")
Cc: stable@vger.kernel.org # v7.0+
Signed-off-by: Hang Zhengyang <hang.zhengyang1010@gmail.com>
---
 kernel/sched/ext/ext.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 23294897dd6e..1031267508fd 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2501,9 +2501,11 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int core_enq_
 	if (SCX_HAS_OP(sch, runnable) && !task_on_rq_migrating(p))
 		SCX_CALL_OP_TASK(sch, runnable, rq, p, enq_flags);
 
-	/* Start dl_server if this is the first task being enqueued */
-	if (rq->scx.nr_running == 1)
-		dl_server_start(&rq->ext_server);
+	/*
+	 * Start on every enqueue: a pick can stop the server while tasks
+	 * counted here are out of its reach.
+	 */
+	dl_server_start(&rq->ext_server);
 
 	scx_do_enqueue_task(rq, p, enq_flags, sticky_cpu);
 out:

-- 
2.53.0


