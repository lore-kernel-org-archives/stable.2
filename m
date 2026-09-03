Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341C537F01C
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 18:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788460375; cv=none; b=muxeENM5Odv0+HBC2BSwpN7GcxN5TwLoF2Vw0f8o2HnYx3Gn1aP87HJktsHyl4TCWXhR2x1pKhWiVKlQ/eODjoD0atEDMI9gjwXRBHCyAA6c9Zqvv9CLqUFLpBf+xppNYa2GSg13WZYcRTfTi3nkQ5iE+deQO7uYeHwaMd3nz/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788460375; c=relaxed/simple;
	bh=8f963vHarbgt0DsbR/RXLvbJWADsEd9iILFH0oH8wbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VhdmbwR0QYjyXH1jeZm2OL4zbxBRhIWJHa2Bav/Ysz+WeiZ7/vL0FoOrTLxmNlygQwnb8SI7AqF6+sjmgD6BcX2B5drGG+ZAUbbMOEi/M2TAAJLMnQMhZnJyH0+SuGKQWBG0rVmpMb2ITkOWl97QVbW43ElPuYsjqcNXw7sws1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ny+X93UU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ny+X93UU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C336D1F000E9;
	Thu,  3 Sep 2026 18:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788460364;
	bh=RkgsJPoFQrSxUwtaxtN0FrBjM3VVqG2pFb30mk4/EMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ny+X93UUYgqrarfoRvEw/sCTHncyace3t2CyCQMgmvopXIaB1s4+13OZeL7RmPLBk
	 gncRj56on/alK82Ew9+eUJjGZVYPbIIYhkpqYw1d3AB6IDS4NhAM34fKSWtJqf7Um2
	 KsQ++Jo7+r/Bi5TIcpADS7tsWp4U4yj92M4BBgmzvuxdggA13pJLwRr3A8YMNQehmP
	 6e4IQm+8vFjhNzjYni4EuelItAaCMNoCaljPA4CilUv2bxcwf7p32u3C6hBvJ5xglD
	 SGmV+Ob+tZjK/OD22ActRpFSwydzHt0KjQfxMyPZegV0USpvM/J7lrNo+6HabtJB/L
	 GNqt5Yurl65IQ==
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
Subject: [PATCH 6.12.y 1/2] mm/kmemleak: avoid soft lockup when scanning task stacks
Date: Thu,  3 Sep 2026 14:32:41 -0400
Message-ID: <20260903183242.1464421-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090345-doorpost-concur-ba65@gregkh>
References: <2026090345-doorpost-concur-ba65@gregkh>
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
 mm/kmemleak.c | 91 ++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 68 insertions(+), 23 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 4092f38d3fc84..0dcdddb3c33d8 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1499,22 +1499,25 @@ static int scan_should_stop(void)
 
 /*
  * Scan a memory block (exclusive range) for valid pointers and add those
- * found to the gray list.
+ * found to the gray list. Return non-zero if the scan was interrupted.
  */
-static void scan_block(void *_start, void *_end,
-		       struct kmemleak_object *scanned)
+static int scan_block(void *_start, void *_end,
+		      struct kmemleak_object *scanned)
 {
 	unsigned long *ptr;
 	unsigned long *start = PTR_ALIGN(_start, BYTES_PER_POINTER);
 	unsigned long *end = _end - (BYTES_PER_POINTER - 1);
 	unsigned long flags;
+	int stop = 0;
 
 	raw_spin_lock_irqsave(&kmemleak_lock, flags);
 	for (ptr = start; ptr < end; ptr++) {
 		unsigned long pointer;
 
-		if (scan_should_stop())
+		if (scan_should_stop()) {
+			stop = 1;
 			break;
+		}
 
 		kasan_disable_current();
 		pointer = *(unsigned long *)kasan_reset_tag((void *)ptr);
@@ -1524,22 +1527,28 @@ static void scan_block(void *_start, void *_end,
 		pointer_update_refs(scanned, pointer, OBJECT_PERCPU);
 	}
 	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
+
+	return stop;
 }
 
 /*
  * Scan a large memory block in MAX_SCAN_SIZE chunks to reduce the latency.
+ * Return non-zero if the scan was interrupted.
  */
 #ifdef CONFIG_SMP
-static void scan_large_block(void *start, void *end)
+static int scan_large_block(void *start, void *end)
 {
 	void *next;
 
 	while (start < end) {
 		next = min(start + MAX_SCAN_SIZE, end);
-		scan_block(start, next, NULL);
+		if (scan_block(start, next, NULL))
+			return 1;
 		start = next;
 		cond_resched();
 	}
+
+	return 0;
 }
 #endif
 
@@ -1670,6 +1679,43 @@ static void kmemleak_cond_resched(struct kmemleak_object *object)
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
+	int stop = 0;
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
+				stop = scan_block(stack, stack + THREAD_SIZE, NULL);
+				put_task_stack(p);
+			}
+			put_task_struct(p);
+		}
+		cond_resched();
+	} while (pid && !stop);
+}
+
 /*
  * Scan data sections and all the referenced memory blocks allocated via the
  * kernel's standard allocators. This function must be called with the
@@ -1681,6 +1727,7 @@ static void kmemleak_scan(void)
 	struct zone *zone;
 	int __maybe_unused i;
 	int new_leaks = 0;
+	int stop = 0;
 
 	jiffies_last_scan = jiffies;
 
@@ -1724,9 +1771,11 @@ static void kmemleak_scan(void)
 
 #ifdef CONFIG_SMP
 	/* per-cpu sections scanning */
-	for_each_possible_cpu(i)
-		scan_large_block(__per_cpu_start + per_cpu_offset(i),
-				 __per_cpu_end + per_cpu_offset(i));
+	for_each_possible_cpu(i) {
+		if (scan_large_block(__per_cpu_start + per_cpu_offset(i),
+				     __per_cpu_end + per_cpu_offset(i)))
+			goto scan_gray;
+	}
 #endif
 
 	/*
@@ -1753,32 +1802,28 @@ static void kmemleak_scan(void)
 			/* only scan if page is in use */
 			if (page_count(page) == 0)
 				continue;
-			scan_block(page, page + 1, NULL);
+			stop = scan_block(page, page + 1, NULL);
+			if (stop)
+				break;
 		}
+		if (stop)
+			break;
 	}
 	put_online_mems();
+	if (stop)
+		goto scan_gray;
 
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
 	 * above.
 	 */
+scan_gray:
 	scan_gray_list();
 
 	/*
-- 
2.53.0

