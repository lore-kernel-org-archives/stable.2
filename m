Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82B73FF8AE
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 16:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781283161; cv=none; b=W+ygk9BTe+OKTxTu2oUGFd8ZhtZyFp+7iwwo8Uc254H1rrIyqBdNb42CmEITdMiVKbpY7JKYN1POQYABLFIpeDW4VF+EEy6ZC6fQ8CPvgmFLTaOp40kvCO3dcDGJ7YQJQX0oAG6yr1MOO7bryIaGICcEb1Dze+5lmOJMr0E1VlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781283161; c=relaxed/simple;
	bh=ArAjbD4H9f6sElF2jdjsI4P/dGtK1t/9myBphKCK78M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B57LIf2gNNjMosLXb7In5JEloNLMceObN0lXdb/ErK2fzm0FVICfE4ICTkMSZGEq5mbWmmKFrjEuLfI+msMGxFkTa3LDjgs3M7dL2772bBFWAKNdkOUBU+yxAp7hlhSQbeGCOqi5i92glJ02aEAddWaCiIUS/CRCKYPXPIz89jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BpA+YcXJ; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BpA+YcXJ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781283141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8j59LeUc679PfGBjvaEMUQyi2RrRwSDjgmSKKRYE6xQ=;
	b=BpA+YcXJqpgshFc9SncDeldaMc6lxkT77ySVoMsNh1cOMS3vB9L6N5FkkbQ8TXVCubchDi
	rWkDIV8dBTUJ6llMIyEjtO+CAqFA1Cj4UlCD1B4tF1SqUNMZyJhrny0bvv6gyLl2Oqmt5Q
	1KR3eeXn/ROyMRquAeT5NawQ/oVH9/E=
From: Lance Yang <lance.yang@linux.dev>
To: leitao@debian.org
Cc: catalin.marinas@arm.com,
	akpm@linux-foundation.org,
	lance.yang@linux.dev,
	dave@stgolabs.net,
	oleg@redhat.com,
	cai@lca.pw,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/kmemleak: avoid soft lockup when scanning task stacks
Date: Sat, 13 Jun 2026 00:52:06 +0800
Message-Id: <20260612165206.93126-1-lance.yang@linux.dev>
In-Reply-To: <20260612-kmemleak-stack-resched-v2-1-53240de79e88@debian.org>
References: <20260612-kmemleak-stack-resched-v2-1-53240de79e88@debian.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Fri, Jun 12, 2026 at 08:16:07AM -0700, Breno Leitao wrote:
>kmemleak_scan() walks every thread and scans its kernel stack under a
>single rcu_read_lock() with no reschedule point. On a host with very
>many threads -- amplified by KASAN/lockdep in debug builds -- this loop
>can hog a CPU long enough to trip the soft lockup watchdog:
>
>  watchdog: BUG: soft lockup - CPU#35 stuck for 22s! [kmemleak:537]
>   scan_block
>   kmemleak_scan
>   kmemleak_scan_thread
>   kthread
>
>A cond_resched() cannot be added directly: the loop runs inside an RCU
>read-side critical section.
>
>Borrow the rcu_lock_break() pattern from kernel/hung_task.c: when a
>reschedule is needed, pin the two iteration cursors, drop the RCU read
>lock, cond_resched(), then re-acquire it and continue only if both
>cursors are still hashed.
>
>If a cursor was unhashed while the lock was dropped, the thread list
>cannot be walked further, so the round is aborted. Such a round scans
>only part of the task stacks, which would make live objects look
>unreferenced, so reuse the existing "scan interrupted" path to skip
>reporting; the next full scan reports the real leaks.

TBH, a bit dense to me as written ...

>Fixes: c4b28963fd79 ("mm/kmemleak: rely on rcu for task stack scanning")
>Cc: stable@vger.kernel.org
>Signed-off-by: Breno Leitao <leitao@debian.org>
>---
>Changes in v2:
>- Do not create the nasty array, but use the same pattern as
>  kernel/hung_task.c.
>- Link to v1: https://lore.kernel.org/r/20260611-kmemleak-stack-resched-v1-1-d6248ade5f4a@debian.org
>---
> mm/kmemleak.c | 42 ++++++++++++++++++++++++++++++++++++++++--
> 1 file changed, 40 insertions(+), 2 deletions(-)
>
>diff --git a/mm/kmemleak.c b/mm/kmemleak.c
>index 7c7ba17ce7af0..d88274dc0c605 100644
>--- a/mm/kmemleak.c
>+++ b/mm/kmemleak.c
>@@ -1695,6 +1695,32 @@ static void kmemleak_cond_resched(struct kmemleak_object *object)
> 	put_object(object);
> }
> 
>+/*
>+ * Briefly drop the RCU read lock to reschedule during the task stack scan.
>+ * Both cursors are pinned across the gap; return false if either one was
>+ * unhashed meanwhile, so the caller stops this round instead of walking a
>+ * stale list.
>+ */

Personally, looks a bit clunky to me with "gap" and "unhashed" ...

Maybe:

"
Drop RCU long enough to reschedule during task stack scanning. Keep both
cursors alive while RCU is dropped; return false if either cursor can no
longer continue the walk.
"

>+static bool kmemleak_stack_scan_break(struct task_struct *g,
>+				      struct task_struct *p)
>+{
>+	bool can_cont;
>+
>+	get_task_struct(g);
>+	get_task_struct(p);
>+
>+	rcu_read_unlock();
>+	cond_resched();
>+	rcu_read_lock();
>+
>+	can_cont = pid_alive(g) && pid_alive(p);
>+
>+	put_task_struct(p);
>+	put_task_struct(g);
>+
>+	return can_cont;
>+}
>+
> /*
>  * Print one leak inline. The hex dump is gated on OBJECT_ALLOCATED so it
>  * does not touch user memory that was freed concurrently; the rest of the
>@@ -1804,6 +1830,7 @@ static void kmemleak_scan(void)
> 	int __maybe_unused i;
> 	struct xarray dedup;
> 	int new_leaks = 0;
>+	bool aborted = false;
> 
> 	jiffies_last_scan = jiffies;
> 
>@@ -1890,11 +1917,21 @@ static void kmemleak_scan(void)
> 		rcu_read_lock();
> 		for_each_process_thread(g, p) {
> 			void *stack = try_get_task_stack(p);
>+
> 			if (stack) {
> 				scan_block(stack, stack + THREAD_SIZE, NULL);
> 				put_task_stack(p);
> 			}
>+			/*
>+			 * This is an expensive loop, we must to call the
>+			 * scheduler to avoid lockups
>+			 */

need_resched() plus the helper name already says most of it. Maybe just:

"
Break the RCU read-side section before rescheduling.
"

>+			if (need_resched() && !kmemleak_stack_scan_break(g, p)) {
>+				aborted = true;
>+				goto unlock;
>+			}
> 		}
>+unlock:
> 		rcu_read_unlock();
> 	}
> 
>@@ -1937,9 +1974,10 @@ static void kmemleak_scan(void)
> 	scan_gray_list();
> 
> 	/*
>-	 * If scanning was stopped do not report any new unreferenced objects.
>+	 * If scanning was stopped or a stack scan round was aborted, do not
>+	 * report any new unreferenced objects.
> 	 */

Maybe just say "stack root scan was incomplete" here? That's the actual
reason we skip reporting.

"
If scanning was stopped or the stack root scan was incomplete, do not
report any new unreferenced objects.
"

>-	if (scan_should_stop())
>+	if (scan_should_stop() || aborted)
> 		return;
> 
> 	/*
>
>---

Apart from that, feel free to add:

Acked-by: Lance Yang <lance.yang@linux.dev>
