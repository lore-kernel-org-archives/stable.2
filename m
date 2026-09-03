Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D8E4FC8EA
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 17:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788457719; cv=none; b=PSDo3kbz+l3mkGTHUVUy8xRVy++iw08z/tY3CxY3p3JQ3WkI3svWP3mR/Bttu51XLJbZvIPLR5zZ57uquYLkK4It40VQVM8Woe8dT8COeOZkVLZMqeXEap8x1K8QNE12AH6xvrvXPlyfs8DGinRlyli5sbG7lwrsx/WyUrDlrtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788457719; c=relaxed/simple;
	bh=ezwppTi9JZzvckfv0sxDBpw+aTrhjrvdsRhXb/+FWuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mnWVdl/wtBaNuhaA2EgeP0yB66tPM8WGO34DjLH2xBJ8Of37ll8iuOg50ZUMlSgcaCkja7fwtqOP0Z1mCb8b2jwwcMnbPB/LbVUKpOXA7Ewodg7FY3EKLzpWWnnPJITVOZbUvAKDRjR1NW5X3aNrP2YlwcyZx+SBDw4OoYvx96A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4jtl4fF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4jtl4fF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF3DC1F000E9;
	Thu,  3 Sep 2026 17:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788457717;
	bh=U5HTzNvoIyFFe7xC8j9AsPyVTFfGzVkgbOw2InUv8Fs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k4jtl4fFQRV4El3nEsiyyN1NftqEV3VXcqQNIXKvoh2U/oPJFlqLscQbdBM3WSd/J
	 +vbtLgA7flA2o9Gkmk45yx7tkhfdbr70TZ/T5RigOW455wPCWTWmqZIVVMKY/ObqLm
	 x2wHz3qlcTxIYZwZBvdfsxHep9LfFNbnNlKsdJYr3jv70MAu14VChH2ko5RfODO2NF
	 w3uDVeR1W8mLSkIc8INuixzf2pHaa9435KG5FLt2rNosfl+ouStu8GqUgrtYhEBMNK
	 1MY2k41XgQWbPM9eOe0FhttqE1rEtR9annwkEiswsYzKxFP92VWXg/kjWozje/GCx0
	 E6Enw7V8Vf/0A==
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
Subject: [PATCH 6.1.y 4/4] mm/kmemleak: avoid soft lockup when scanning task stacks
Date: Thu,  3 Sep 2026 13:48:32 -0400
Message-ID: <20260903174832.1263842-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903174832.1263842-1-sashal@kernel.org>
References: <2026090332-elliptic-contort-6cb3@gregkh>
 <20260903174832.1263842-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/kmemleak.c | 51 ++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 38 insertions(+), 13 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 904b5d396e124..79f5565bb9b92 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1486,6 +1486,42 @@ static void kmemleak_cond_resched(struct kmemleak_object *object)
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
  * Scan data sections and all the referenced memory blocks allocated via the
  * kernel's standard allocators. This function must be called with the
@@ -1576,19 +1612,8 @@ static void kmemleak_scan(void)
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

