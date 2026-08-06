Received: from jowisz.hostline.pl (jowisz.hostline.pl [46.248.187.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895893EDACB;
	Thu,  6 Aug 2026 08:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.248.187.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786004254; cv=none; b=OlcbezNkbthS+J5uHsh1hRv2D7l2fzYihTVaWicfImKzeEO/z04Yv5JgEMwpxreQWSW5uxFuqMz8OewgfwPohIlUfT9tySyfXjtdmOgVbAH+nVKm9OWKOipyGq3it7KICDgDsEYf8FpXJEIkQU7NJMATI6TJQd92knRlq4SjdfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786004254; c=relaxed/simple;
	bh=uL4xgBFenzMYKHAWZp3NGEbqHXryahR/V5uZ9wh29Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PLsVDZEXvK/QNZBP9aPU8NJe4GoPjqwHywatLz5Gs0E8do376PWWzETfbZGMR/8LqWThkfwoPSYHhsigrclTfr50s0p9gKhKbRTZucQOqa0Y28nSJEtK5RlrxM/OCjfBL7fS7w1cggMpDjxPdnTTu5mvtKeS5N8Lz1tnGDd8qXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=krystianslowik.com; spf=pass smtp.mailfrom=krystianslowik.com; dkim=pass (2048-bit key) header.d=krystianslowik.com header.i=@krystianslowik.com header.b=2OU7ShNz; arc=none smtp.client-ip=46.248.187.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=krystianslowik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krystianslowik.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krystianslowik.com header.i=@krystianslowik.com header.b="2OU7ShNz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=krystianslowik.com; s=x; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=q3WkrCVD/31rgbvcNaWg0ZfXr+nKp6uv7jHQHoe89XM=; b=2OU7ShNzhot+JbbAWR2HtbdcGe
	J/xAB5doBTU7dZSdsmt4EioCpMgiqogzF3RFpNR3Gq5+9nB1vmrRU6XTRC7cMfAzYkkSLM/szrr+C
	SOt+xH/lwhXYv6DNxjuDMzINMXbKFcwdJ2GHdgp2w6VvJMWvcQ1Qu39qOo5c8kynWvZ0eFSx0Hjn3
	BVYEORY5VZLoDjN+stgzL7kp3iGI01zYttBSD5X117oLafJJRWDy35/EmzPoxJPGNwNI7c512I6K3
	7CGA1vyIgFqy1HRRYDfoE45QKJ5pHcsZ4lHO3BU1onp5DQt1rowaGL+kqndyOKWu7f0HO6tO5pxWk
	BzuxiQNw==;
Received: from dynamic-002-214-159-214.2.214.pool.telefonica.de ([2.214.159.214] helo=localhost.localdomain)
	by jowisz.hostline.pl with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <me@krystianslowik.com>)
	id 1wrsMo-0000000DqNt-2FzD;
	Thu, 06 Aug 2026 09:18:13 +0200
From: Krystian Slowik <me@krystianslowik.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	linux-kernel@vger.kernel.org,
	Krystian Slowik <me@krystianslowik.com>,
	stable@vger.kernel.org
Subject: [PATCH] sched/core: Don't pin the idle task in migrate_disable_switch()
Date: Thu,  6 Aug 2026 09:17:40 +0200
Message-ID: <20260806071740.83931-1-me@krystianslowik.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: me@krystianslowik.com

Since commit 650952d3fb38 ("sched: Make __do_set_cpus_allowed() use the
sched_change pattern"), do_set_cpus_allowed() dequeues and re-enqueues
the target task through the sched_change guard whenever it is queued.

The idle task counts as queued: init_idle() sets
idle->on_rq = TASK_ON_RQ_QUEUED. But the idle sched class implements no
real dequeue_task() (only the "bad: scheduling from the idle thread!"
debug stub, which even drops and re-takes the rq lock in the middle of
the guarded section) and no enqueue_task() at all, so running the guard
on the idle task jumps through a NULL pointer in sched_change_end():

  bad: scheduling from the idle thread!
  CPU: 3 UID: 0 PID: 0 Comm: swapper/3 Kdump: loaded Not tainted 7.0.0-28-generic #28-Ubuntu PREEMPT(lazy)
  Call Trace:
   dequeue_task_idle+0x29/0x50
   dequeue_task+0xfb/0x300
   sched_change_begin+0x1ff/0x240
   migrate_disable_switch.isra.0+0xf8/0x190
   __schedule+0xdd/0x650
   schedule_idle+0x22/0x40
  BUG: kernel NULL pointer dereference, address: 0000000000000000
  #PF: supervisor instruction fetch in kernel mode
  RIP: 0010:0x0
  Call Trace:
   enqueue_task+0x89/0x1d0
   sched_change_end+0x18e/0x1d0
   migrate_disable_switch.isra.0+0x11e/0x190
   __schedule+0xdd/0x650
   schedule_idle+0x22/0x40
   do_idle+0xb6/0xf0
   cpu_startup_entry+0x29/0x30
   start_secondary+0x125/0x180

The path is reachable since commit 942b8db96500 ("sched: Fix
migrate_disable_switch() locking") moved migrate_disable_switch() to
the top of __schedule(), where it runs on every schedule out of the
idle loop rather than only on an actual context switch: any
migrate_disable() taken in the idle loop (e.g. from a tracing or BPF
callback) that is still held when the idle task schedules triggers the
pinning path.

Pinning the idle task is meaningless to begin with: it is a per-CPU
task that can never migrate. Skip it. This also keeps
___migrate_enable() unreachable for the idle task, since its cpus_ptr
is never repointed.

The check uses p == rq->idle rather than is_idle_task(), because the
latter also matches idle-injection threads (PF_IDLE), which are
ordinary queueable tasks.

Observed in production on two separate x86-64 machines running the
Ubuntu 7.0.0-28 kernel, both panicking from the idle loop with the
oops above.

Fixes: 650952d3fb38 ("sched: Make __do_set_cpus_allowed() use the sched_change pattern")
Cc: <stable@vger.kernel.org> # v7.0+
Signed-off-by: Krystian Slowik <me@krystianslowik.com>
---
 kernel/sched/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9622670..823af64 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2461,6 +2461,10 @@ static void migrate_disable_switch(struct rq *rq, struct task_struct *p)
 	if (p->cpus_ptr != &p->cpus_mask)
 		return;
 
+	/* The per-CPU idle task never migrates, there is nothing to pin. */
+	if (p == rq->idle)
+		return;
+
 	scoped_guard (task_rq_lock, p)
 		do_set_cpus_allowed(p, &ac);
 }
-- 
2.54.0

