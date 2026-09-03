Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DC64A99BE
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 12:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439529; cv=none; b=OsbqQdewc4FkbRka37ScRnILDzKrghWPha13HlSW3/gFPyM5MjS3EgMvSxO/1OsUOcRMQrtfhEDQYJw+Wr4ZfL8bQXNqaztsBPEcgLiOYRHRBKKoI72jhgdm0VFOizHZGFpGeVYIDNFMTagHE+WQSzbJgYMhNos+GK1ZP2MLj34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439529; c=relaxed/simple;
	bh=rN5hIukCBSBwkqrJ6yRL5GqU+PuBzT5dHNQJKRv65dg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TAM6pdXi+zB5MX8QW8A9VJ9rrYIJc21+vTWD5jfsRDGgJ/aFxl+Kd85UWIcE9G48j/ECDRovndaQ3Ya8f3CjqwUpmgg9Wb2G/eYI4AcaXzGN7GG9pWAh0FzRVLD1aJU/ATeq3nJrBGUCSMlPoiqMgLEHsWJIl+asMKMxVmGQBdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ugEYhk2M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ugEYhk2M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A8D81F000E9;
	Thu,  3 Sep 2026 12:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788439528;
	bh=K6cI4u8PZYgCdoYr5PaQ//QZR7e2oGR2UxRxxBdlfMg=;
	h=Subject:To:Cc:From:Date;
	b=ugEYhk2MBtWs8CnCncvjYoub1lKRptNQM56MEAQkCYKH0VdOZxgV8xVZN1NcG1B+u
	 DuOZzqY8RfdxwNcNsZ4LD9PVRUbOopmq5tE3Anp10owS4vMoo31RdCMIXQ/nnOdefp
	 NGH8r50GH+U44nlVm2kp2lt0TPruJsA69PkAtMT8=
Subject: FAILED: patch "[PATCH] mm/kmemleak: report RCU-tasks quiescent states during the" failed to apply to 6.6-stable tree
To: leitao@debian.org,akpm@linux-foundation.org,catalin.marinas@arm.com,paulmck@kernel.org,puranjay@kernel.org,sj@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 12:47:45 +0200
Message-ID: <2026090345-kabob-hardcopy-cdf7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 3541a2b06ecd78ba333188df04368dcf97273d6a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090345-kabob-hardcopy-cdf7@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3541a2b06ecd78ba333188df04368dcf97273d6a Mon Sep 17 00:00:00 2001
From: Breno Leitao <leitao@debian.org>
Date: Mon, 20 Jul 2026 06:23:45 -0700
Subject: [PATCH] mm/kmemleak: report RCU-tasks quiescent states during the
 scan

kmemleak_scan() can run for ages on large debug kernels. It was
causing some soft-lockups which I got fixed with commit
3175fcfec8b16baeb ("mm/kmemleak: avoid soft lockup when scanning task
stacks") with our beloved cond_resched().

I've got the fix above deployed in the Meta fleet, and now I am seeing:

  INFO: rcu_tasks detected stalls on tasks:
    task:kmemleak state:R ... nvcsw: 274/274 holdout: 1 idle_cpu: -1/3
     scan_block
     scan_gray_list
     kmemleak_scan

and, worse, blocks the callers waiting on that grace period.  Here a BPF
struct_ops map free, which waits via synchronize_rcu_mult(call_rcu,
call_rcu_tasks), is stuck long enough to also trip the hung task check:

  INFO: task kworker/...:bpf_map_free_deferred blocked for 122 seconds
     __wait_rcu_gp
     bpf_struct_ops_map_free

Then I've learned that cond_resched() is not an RCU-tasks quiescent
state, so, we need to use stronger primitives.

Use cond_resched_tasks_rcu_qs() at the scan reschedule points so the scan
reports an RCU-tasks quiescent state as it proceeds.

Inspired by commit b96285e10aad ("tracing: Have osnoise_main() add a
quiescent state for task rcu").

Link: https://lore.kernel.org/20260720-kmemleak_rcu_task-v1-1-5b460ade777d@debian.org
Fixes: c4b28963fd79 ("mm/kmemleak: rely on rcu for task stack scanning")
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: SJ Park <sj@kernel.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Breno Leitao <leitao@debian.org>
Cc: Puranjay Mohan <puranjay@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index e96e9efd19b0..0a6045c857d6 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1571,7 +1571,7 @@ static int scan_large_block(void *start, void *end)
 		if (scan_block(start, next, NULL))
 			return 1;
 		start = next;
-		cond_resched();
+		cond_resched_tasks_rcu_qs();
 	}
 
 	return 0;
@@ -1608,7 +1608,7 @@ static void scan_object(struct kmemleak_object *object)
 			scan_block(start, end, object);
 
 			raw_spin_unlock_irqrestore(&object->lock, flags);
-			cond_resched();
+			cond_resched_tasks_rcu_qs();
 			raw_spin_lock_irqsave(&object->lock, flags);
 			if (!(object->flags & OBJECT_ALLOCATED))
 				break;
@@ -1630,7 +1630,7 @@ static void scan_object(struct kmemleak_object *object)
 				break;
 
 			raw_spin_unlock_irqrestore(&object->lock, flags);
-			cond_resched();
+			cond_resched_tasks_rcu_qs();
 			raw_spin_lock_irqsave(&object->lock, flags);
 		} while (object->flags & OBJECT_ALLOCATED);
 	} else {
@@ -1658,7 +1658,7 @@ static void scan_gray_list(void)
 	 */
 	object = list_entry(gray_list.next, typeof(*object), gray_list);
 	while (&object->gray_list != &gray_list) {
-		cond_resched();
+		cond_resched_tasks_rcu_qs();
 
 		/* may add new objects to the list */
 		if (!scan_should_stop())
@@ -1693,7 +1693,7 @@ static void kmemleak_cond_resched(struct kmemleak_object *object)
 	raw_spin_unlock_irq(&kmemleak_lock);
 
 	rcu_read_unlock();
-	cond_resched();
+	cond_resched_tasks_rcu_qs();
 	rcu_read_lock();
 
 	raw_spin_lock_irq(&kmemleak_lock);
@@ -1738,7 +1738,7 @@ static void kmemleak_scan_task_stacks(void)
 			}
 			put_task_struct(p);
 		}
-		cond_resched();
+		cond_resched_tasks_rcu_qs();
 	} while (pid && !stop);
 }
 
@@ -1915,7 +1915,7 @@ static void kmemleak_scan(void)
 			struct page *page = pfn_to_online_page(pfn);
 
 			if (!(pfn & 63))
-				cond_resched();
+				cond_resched_tasks_rcu_qs();
 
 			if (!page)
 				continue;

