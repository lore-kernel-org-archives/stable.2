Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9000E29B8D0;
	Fri, 12 Jun 2026 15:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781277394; cv=none; b=hg5ktYbKF8C1kyeY3rfuK++TJHBL7UqJ0M1//vLlIEJMI20IAHEu3/3OLdf97I7e7B4ieC/3ASOZOdQkpmcJh9FYiT4B9I+fRzBKxt/hhGAUO6JeVdKzRuzg7Bw+X9B+DEO8P0wnFhvpB0yDiHfzlKaEBlh+bOskJtm5MMBm798=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781277394; c=relaxed/simple;
	bh=YqdxA8lDwTZ30H8uk3yN+D0ArneX4WyXPA7uWMS+uas=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=e6mSDmKe9z2UI9+otT6xPwBG1N35i1ZfCiaF/MZ+xtq7uKDrTtpSYkEnIIQJWwxlZve24alQx3UR4/vPwiR4RZ6UHV+JcwNBkgzCbia4oJsEX3fIZXVnIQZ/gPtssyZeHHUoCqAk8PR+aJ0uzQz7WBMZy8AIg2zNOc9DUUonZBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=gzXerX05; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="gzXerX05"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=eq+a+KnqGzNi4HyIs0mxE4TbBTE8NXVHXZDMscDgWS0=; b=gzXerX057qpBFVEofLLo2N9TMx
	AdxIRdxLB+aZaMI6JoVrPCb4mZ+1Y0wC8YDS9iEYQBIMQUmxWncem72VsAS1QGgYUg7vwEApCl6a4
	RUzDOMYtlXlbwr6ZRTsPkiMdr/gVaJDwJg8OoZ7k66cDt2iOgcXUgguYyfM0N9WoNcVe6jNZiRz41
	pJyhlhq7Cz/oN3Ejz/ATxVYuVDSWuLTD+uLDMcNHGl/tv4+vGpJ+DNa0BsLO3eRqoPnuxVQv9Xjfm
	7d6xNHDl54TfTk6t/Y5++QzKAWjNb5T5OI2ytZi1XviBvpjcpP8b9M0gRvWzjye/esBFU5LJMX/m0
	Y9SCoCIA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wY3cI-00Ap9I-1u;
	Fri, 12 Jun 2026 15:16:18 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 12 Jun 2026 08:16:07 -0700
Subject: [PATCH v2] mm/kmemleak: avoid soft lockup when scanning task
 stacks
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-kmemleak-stack-resched-v2-1-53240de79e88@debian.org>
X-B4-Tracking: v=1; b=H4sIALYiLGoC/4XNSwqDMBCA4auEWTslCT6Cq96juJia0QypDxKRF
 vHupV6g23/x/QdkTsIZWnVA4l2yLDO0yhYK+kDzyCgeWgVW21rXxmCceHoxRcwb9RET5z6wR23
 YN9ZVjpoBCgVr4kHeF/zoCgVB8rakz/XZza/+JXeDBn1tS0eeq6Gku+en0Hxb0gjdeZ5fCn5UL
 b0AAAA=
X-Change-ID: 20260611-kmemleak-stack-resched-01ed72858a7f
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, lance.yang@linux.dev, 
 Davidlohr Bueso <dave@stgolabs.net>, Oleg Nesterov <oleg@redhat.com>, 
 Qian Cai <cai@lca.pw>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 stable@vger.kernel.org, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3856; i=leitao@debian.org;
 h=from:subject:message-id; bh=YqdxA8lDwTZ30H8uk3yN+D0ArneX4WyXPA7uWMS+uas=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqLCK+KeZhZ/0czOX44dEskonjj0kdt7xN8EkyV
 qM5CBZ/8c2JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaiwivgAKCRA1o5Of/Hh3
 baHnEACPH/Rjrg3dMQQCKefIg8nwHNE9e2mAk+oaWbU1PUyHR2IB9l/4EtJnhylA7yT8FP8JGwO
 JFFIOEEE5bKMzcduTkvVnhDMHzbKN4XzOVOymLStVK6QFqt0JNo1QNe30ArPxrxoU8AVw5T2PgL
 daRYarEOgN2jWGSAOubiNnILqVcBNO8unGk9UZgTM76YiMHZFIfRTDMvEoLj+O84DNa5YGJrYKc
 k5I65y7B7iPwAwSCz/Rsryq9YzIV4Oeg0sUYGIxUM1/BSEir/F3G1PMWhLmVnfNx+0b5NAdRjRy
 h4+vBvABVAhOb8xoThpRDtS8m1nRKUMLZMnzBiVAgSevly4dYAcYW9DXod01Yk4D8KAIZrCTmYy
 bktn9FrdDIXmNy7DpaRZ3fWakbYpI7j7CBMQYhtAH9vlDXk8kc//xEdQo8S5E9VKWN9txjBPpir
 wiVuTkoq3o5aNa5XCG+r2iZm4yJxJJATlWbqju4btTdqreOibO4F6Y9JGiX1a2nPAVruqFm1WrM
 /GtnDyDk5r9AyU+PLjKmgsO+nzRWkhtAs6cn89h738woIY9ShP47rMsYcXve6LislFS/H8OOqUy
 CaPnHAP4AXgY1fv74QaUd3fGdFywIZ9Og0Xcgfl7CePOk1cklS4uJ1pEI2eRKQwx4ORR252cYIm
 7JBXJPF+Ww9U4fw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

kmemleak_scan() walks every thread and scans its kernel stack under a
single rcu_read_lock() with no reschedule point. On a host with very
many threads -- amplified by KASAN/lockdep in debug builds -- this loop
can hog a CPU long enough to trip the soft lockup watchdog:

  watchdog: BUG: soft lockup - CPU#35 stuck for 22s! [kmemleak:537]
   scan_block
   kmemleak_scan
   kmemleak_scan_thread
   kthread

A cond_resched() cannot be added directly: the loop runs inside an RCU
read-side critical section.

Borrow the rcu_lock_break() pattern from kernel/hung_task.c: when a
reschedule is needed, pin the two iteration cursors, drop the RCU read
lock, cond_resched(), then re-acquire it and continue only if both
cursors are still hashed.

If a cursor was unhashed while the lock was dropped, the thread list
cannot be walked further, so the round is aborted. Such a round scans
only part of the task stacks, which would make live objects look
unreferenced, so reuse the existing "scan interrupted" path to skip
reporting; the next full scan reports the real leaks.

Fixes: c4b28963fd79 ("mm/kmemleak: rely on rcu for task stack scanning")
Cc: stable@vger.kernel.org
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- Do not create the nasty array, but use the same pattern as
  kernel/hung_task.c.
- Link to v1: https://lore.kernel.org/r/20260611-kmemleak-stack-resched-v1-1-d6248ade5f4a@debian.org
---
 mm/kmemleak.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 7c7ba17ce7af0..d88274dc0c605 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1695,6 +1695,32 @@ static void kmemleak_cond_resched(struct kmemleak_object *object)
 	put_object(object);
 }
 
+/*
+ * Briefly drop the RCU read lock to reschedule during the task stack scan.
+ * Both cursors are pinned across the gap; return false if either one was
+ * unhashed meanwhile, so the caller stops this round instead of walking a
+ * stale list.
+ */
+static bool kmemleak_stack_scan_break(struct task_struct *g,
+				      struct task_struct *p)
+{
+	bool can_cont;
+
+	get_task_struct(g);
+	get_task_struct(p);
+
+	rcu_read_unlock();
+	cond_resched();
+	rcu_read_lock();
+
+	can_cont = pid_alive(g) && pid_alive(p);
+
+	put_task_struct(p);
+	put_task_struct(g);
+
+	return can_cont;
+}
+
 /*
  * Print one leak inline. The hex dump is gated on OBJECT_ALLOCATED so it
  * does not touch user memory that was freed concurrently; the rest of the
@@ -1804,6 +1830,7 @@ static void kmemleak_scan(void)
 	int __maybe_unused i;
 	struct xarray dedup;
 	int new_leaks = 0;
+	bool aborted = false;
 
 	jiffies_last_scan = jiffies;
 
@@ -1890,11 +1917,21 @@ static void kmemleak_scan(void)
 		rcu_read_lock();
 		for_each_process_thread(g, p) {
 			void *stack = try_get_task_stack(p);
+
 			if (stack) {
 				scan_block(stack, stack + THREAD_SIZE, NULL);
 				put_task_stack(p);
 			}
+			/*
+			 * This is an expensive loop, we must to call the
+			 * scheduler to avoid lockups
+			 */
+			if (need_resched() && !kmemleak_stack_scan_break(g, p)) {
+				aborted = true;
+				goto unlock;
+			}
 		}
+unlock:
 		rcu_read_unlock();
 	}
 
@@ -1937,9 +1974,10 @@ static void kmemleak_scan(void)
 	scan_gray_list();
 
 	/*
-	 * If scanning was stopped do not report any new unreferenced objects.
+	 * If scanning was stopped or a stack scan round was aborted, do not
+	 * report any new unreferenced objects.
 	 */
-	if (scan_should_stop())
+	if (scan_should_stop() || aborted)
 		return;
 
 	/*

---
base-commit: abe651837cb394f76d738a7a747322fca3bf17ba
change-id: 20260611-kmemleak-stack-resched-01ed72858a7f

Best regards,
-- 
Breno Leitao <leitao@debian.org>

