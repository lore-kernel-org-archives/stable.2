Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7934B1B3D
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 18:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788460026; cv=none; b=Rf/JrCoKj/CkTdCBseuQgPgIxfsYDzAbQxpOCMLc/dd/slhWjHV1DrwVilCxSD5aUvjSq5+565394FbVyDDWlZSKy3/4WU5AzcuG6U3Vyo/ij3JMw048pqOs2Kp3PZtL77jMWS5k3nNONT4Ho46nN/RhAQ+k6SKwaB9Nd7yMQhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788460026; c=relaxed/simple;
	bh=LJat/t/fPE8aC+azoEyEZPUrrSfmrmHDnBamhvIjqSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oIHupO3X4Wn1ry9JP9T9FAmKOu/vhwPDcUVrUBCT/Bjnl+wQYYdloY9yNC6iR1VLg+zJF/ccvoUlMW1e91BG1KqerLVslACzSDOBIt/MLjqFYK2xC6RGndmPeI6jEaXUArL2/tZvxXgq3YDUdyPBQ8HC5k4fW9jxqJQoiEEk/nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbTFCYt6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbTFCYt6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844781F00A3E;
	Thu,  3 Sep 2026 18:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788460020;
	bh=htcEWFbFmWPCLq1zKbNwVsJYH8c7DyvbszRGWfo+R8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dbTFCYt63PV+YV4o/UBxkJV38L2tJYtj8LeJTrvLtDIJCZ2p1W5Yyr3XNBhn+WUSV
	 C7Xp8MOdR6Bb3+TeHngWykYSZNK2sg9zGZSH4OSDA97zxihwH9lw4M8DY/6D6zPPbO
	 xmD6mvg5A3s7QeDqsA7FjhHdWfeafYDlPJDONhH812oLt9V79zJDpgSrNkLuO6wP5m
	 Ah697xnGrXP3rNOWci+zTIS77WamZbKh5DnPGqL6HTo4DHYCIyTN9WjGpXgh1+nwnI
	 TxHJ15glgI6CHJ++5ptWkxeeKteG0AEOG3cw2eOQurKKuFPtOj/iKDcMr/TZZdU/6c
	 3XAVWmsdsMO1Q==
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
Subject: [PATCH 6.18.y 1/2] mm/kmemleak: avoid soft lockup when scanning task stacks
Date: Thu,  3 Sep 2026 14:26:57 -0400
Message-ID: <20260903182658.1452185-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090344-parted-gnarly-5282@gregkh>
References: <2026090344-parted-gnarly-5282@gregkh>
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
index 415b154fdf38e..5109a9f84ea50 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1518,22 +1518,25 @@ static int scan_should_stop(void)
 
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
@@ -1543,22 +1546,28 @@ static void scan_block(void *_start, void *_end,
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
 
@@ -1689,6 +1698,43 @@ static void kmemleak_cond_resched(struct kmemleak_object *object)
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
@@ -1700,6 +1746,7 @@ static void kmemleak_scan(void)
 	struct zone *zone;
 	int __maybe_unused i;
 	int new_leaks = 0;
+	int stop = 0;
 
 	jiffies_last_scan = jiffies;
 
@@ -1743,9 +1790,11 @@ static void kmemleak_scan(void)
 
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
@@ -1772,32 +1821,28 @@ static void kmemleak_scan(void)
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

