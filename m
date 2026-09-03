Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC5F4A33E1
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 17:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788457754; cv=none; b=O49I5c8nwGVNuwH/Epn3VHuAP0BXlScW8gbUNJTNRvXX+WWDX0VTUN6t4eJlyiJUtp3FYLWkM89y0JMvNclO8Oh0jin2Ag/3G4xoWY8+GP8vjYxuoq7v90+1wDfD7dLAhqQXOSWZMKMR9zkayduMy0Ezc8AHWFyCwJDZqyQ+wbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788457754; c=relaxed/simple;
	bh=1xDBeA2iYZJQUcJRCa2RlY1bRxHNsFVV7IXhef3mbLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CT4KTzrDiHkDjsPNbYOfqFpyd39++BJwXKCKTB3Xx/5GRt7ms9GlrnmIgmeDB4Xd7qW163OqQb23/qcyT0+p2FKjtoI6BL6cC+7yzZ/4S05bXJ2jcULPvOFD3HqMOhvoOiKaWbb5QiJwYZNUbXEL0L5h+M4dxYb4Mw6UUNRIq/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTMAKyKD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTMAKyKD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282F01F000E9;
	Thu,  3 Sep 2026 17:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788457752;
	bh=JIfN+SE+Rx6dtYA8yTdwHKTwUbm3cvUS/lUBUMR/JKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UTMAKyKD+ebf4GezeYZ6mnsntjIYgx3f6hq8SScw8FVBEclif63flk+KfTuItw8HM
	 /179LQolbZStthqLtVazttcV5Vm8qerC4woT4Qkg5V8V0Weea2nK63hJXxMX1XjiSR
	 XJVhckoskoNO5UlwHn8LSmUIH4/cWEJWQCsBX4Fzw+KtbwVVLPhhVcFQvEzFEv8NPA
	 cqf2DAZMwI2i111VqXYlA0TzYycCurP4RkBl4tUT1g1QNrDitZnpUMz3FEVIAORMz0
	 pu2vMlIeitBAE8rfpRzK3J3xR0sMBHmNSbD2Uakk4clZmD+7oBauGgog+efHzBvf5W
	 KDvo1tpHMhSmw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Lance Yang <lance.yang@linux.dev>,
	Oleg Nesterov <oleg@redhat.com>,
	Qian Cai <cai@lca.pw>,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 1/3] mm/kmemleak: avoid soft lockup when scanning task stacks
Date: Thu,  3 Sep 2026 13:49:06 -0400
Message-ID: <20260903174908.1268466-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090344-tightly-handiwork-36ab@gregkh>
References: <2026090344-tightly-handiwork-36ab@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Breno Leitao <leitao@debian.org>

[ Upstream commit 5d10d4e19e6daa487f0cd0ea6cba472325de92f9 ]

Patch series "mm/kmemleak: avoid soft lockup when scanning task", v3.

kmemleak_scan() scans every task stack under one rcu_read_lock() with no
reschedule point, which can trip the soft lockup watchdog on hosts with
very many threads.

That prints the following message, depending on the workload+host
configuration:

      watchdog: BUG: soft lockup - CPU#35 stuck for 22s! [kmemleak:537]
       scan_block
       kmemleak_scan
       kmemleak_scan_thread
       kthread

Patch 1 walks the tasks with find_ge_pid() so the scan reschedules between
tasks

Patches 2-3 let the scan loops stop early once a scan is interrupted.

This patch (of 3):

kmemleak_scan() walks every thread and scans its kernel stack under a
single rcu_read_lock() with no reschedule point.  On a host with very many
threads -- amplified by KASAN/lockdep in debug builds -- this loop can hog
a CPU long enough to trip the soft lockup watchdog:

  watchdog: BUG: soft lockup - CPU#35 stuck for 22s! [kmemleak:537]
   scan_block
   kmemleak_scan
   kmemleak_scan_thread
   kthread

A cond_resched() cannot be added directly: the loop runs inside an RCU
read-side critical section.

Walk the tasks one PID at a time with find_ge_pid(), taking the RCU read
lock only to look up and pin each task.  The stack is then scanned with no
lock held, so cond_resched() runs between tasks and the scan stops early
on scan_should_stop().  This follows the next_tgid()/task_seq_get_next()
iteration pattern and keeps each RCU critical section short.

Link: https://lore.kernel.org/20260615-kmemleak-stack-resched-v3-0-acecd7d7fd92@debian.org
Link: https://lore.kernel.org/20260615-kmemleak-stack-resched-v3-1-acecd7d7fd92@debian.org
Fixes: c4b28963fd79 ("mm/kmemleak: rely on rcu for task stack scanning")
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Cc: Qian Cai <cai@lca.pw>
Cc: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 3541a2b06ecd ("mm/kmemleak: report RCU-tasks quiescent states during the scan")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/kmemleak.c | 51 ++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 38 insertions(+), 13 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index e196f53f9b462..16b72cead07d2 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1696,6 +1696,42 @@ static void kmemleak_cond_resched(struct kmemleak_object *object)
 	put_object(object);
 }
 
+/*
+ * Scan all task kernel stacks, rescheduling between tasks. Each task is looked
+ * up and pinned within its own RCU read-side section, so no lock is held across
+ * the scan and the walk cannot trip the soft lockup watchdog.
+ */
+static void kmemleak_scan_task_stacks(void)
+{
+	struct pid *pid;
+	int nr = 1;
+
+	do {
+		struct task_struct *p = NULL;
+
+		rcu_read_lock();
+		pid = find_ge_pid(nr, &init_pid_ns);
+		if (pid) {
+			nr = pid_nr(pid) + 1;
+			p = pid_task(pid, PIDTYPE_PID);
+			if (p)
+				get_task_struct(p);
+		}
+		rcu_read_unlock();
+
+		if (p) {
+			void *stack = try_get_task_stack(p);
+
+			if (stack) {
+				scan_block(stack, stack + THREAD_SIZE, NULL);
+				put_task_stack(p);
+			}
+			put_task_struct(p);
+		}
+		cond_resched();
+	} while (pid && !scan_should_stop());
+}
+
 /*
  * Print one leak inline. The hex dump is gated on OBJECT_ALLOCATED so it
  * does not touch user memory that was freed concurrently; the rest of the
@@ -1885,19 +1921,8 @@ static void kmemleak_scan(void)
 	/*
 	 * Scanning the task stacks (may introduce false negatives).
 	 */
-	if (kmemleak_stack_scan) {
-		struct task_struct *p, *g;
-
-		rcu_read_lock();
-		for_each_process_thread(g, p) {
-			void *stack = try_get_task_stack(p);
-			if (stack) {
-				scan_block(stack, stack + THREAD_SIZE, NULL);
-				put_task_stack(p);
-			}
-		}
-		rcu_read_unlock();
-	}
+	if (kmemleak_stack_scan)
+		kmemleak_scan_task_stacks();
 
 	/*
 	 * Scan the objects already referenced from the sections scanned
-- 
2.53.0

