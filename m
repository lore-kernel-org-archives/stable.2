Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD4C3955FF
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 18:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788460028; cv=none; b=krNkS0EzcpPwKazl7qygCTHRZTBaFdPSRoa+4wSlR4Fi7qWVxRKEG9+U2TDaHRCYKwmr+epMTkz5bSqhyC3m3Gq6mmOpxTAONwL1saxAz4N4zYZiJ0b4AiFkoqFnjY66nD7aJBF3J3cNVtDhj0FGBLzHu+JZJXVpDsz6gFWESdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788460028; c=relaxed/simple;
	bh=fp8PVJld42kEIOP9kwG5WGfSPK24k3mgfP+SAjpHtwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dKK6WAEIW/mEnBJ6bEl136pdK9iZb2jXe4OUYZEBqpfUzAt57f5W54S4cDb6ARmz9gO0oVU8340flcs9a8bwAADeNr18rI2NUbY1X8lCXlV5skS1YbzF/YzTH6Bhb5pWctmbagXoDye+kLGNDd4BB+EOheF1FLR7etyZB7KhWgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFUw+d9f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFUw+d9f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7AD1F00ACF;
	Thu,  3 Sep 2026 18:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788460021;
	bh=2pgoGUu8YthfU+kaufNg4EhN3jcejJX2TjkSP7w0b9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OFUw+d9fARxd2FH6jYUay78LsdTzglzMOY+exSVaxiXxymi1+gCf33Zp3w33vjn/N
	 AfNRO6lWdIjpJ/lfuWaFbYzAy3xcsArvPlSVl+ypWNGVeblb484HjqH4vIeJLuXc7m
	 esiA0pJQdSojI67cSQBVpl1RHKXV7YEvchCjFQRy+DphDESxg35l8Wck7dt3mYglfO
	 ++pxT+KCzyQofSH+ej/JIZPWQQMPVKtjESs5yTaq+AZkGliv5cZioHQx/or7GZclfI
	 J8H8idmHUqCb13kIdkOT6BRiEvYm5W2Y5QMt0BgAw9ryBp0vmPIfSfKus36X8ZyFbo
	 3oDQ+tmDzf+ug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	SJ Park <sj@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] mm/kmemleak: report RCU-tasks quiescent states during the scan
Date: Thu,  3 Sep 2026 14:26:58 -0400
Message-ID: <20260903182658.1452185-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903182658.1452185-1-sashal@kernel.org>
References: <2026090344-parted-gnarly-5282@gregkh>
 <20260903182658.1452185-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Breno Leitao <leitao@debian.org>

[ Upstream commit 3541a2b06ecd78ba333188df04368dcf97273d6a ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/kmemleak.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 5109a9f84ea50..b4a7ed2116353 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1564,7 +1564,7 @@ static int scan_large_block(void *start, void *end)
 		if (scan_block(start, next, NULL))
 			return 1;
 		start = next;
-		cond_resched();
+		cond_resched_tasks_rcu_qs();
 	}
 
 	return 0;
@@ -1601,7 +1601,7 @@ static void scan_object(struct kmemleak_object *object)
 			scan_block(start, end, object);
 
 			raw_spin_unlock_irqrestore(&object->lock, flags);
-			cond_resched();
+			cond_resched_tasks_rcu_qs();
 			raw_spin_lock_irqsave(&object->lock, flags);
 			if (!(object->flags & OBJECT_ALLOCATED))
 				break;
@@ -1623,7 +1623,7 @@ static void scan_object(struct kmemleak_object *object)
 				break;
 
 			raw_spin_unlock_irqrestore(&object->lock, flags);
-			cond_resched();
+			cond_resched_tasks_rcu_qs();
 			raw_spin_lock_irqsave(&object->lock, flags);
 		} while (object->flags & OBJECT_ALLOCATED);
 	} else {
@@ -1651,7 +1651,7 @@ static void scan_gray_list(void)
 	 */
 	object = list_entry(gray_list.next, typeof(*object), gray_list);
 	while (&object->gray_list != &gray_list) {
-		cond_resched();
+		cond_resched_tasks_rcu_qs();
 
 		/* may add new objects to the list */
 		if (!scan_should_stop())
@@ -1686,7 +1686,7 @@ static void kmemleak_cond_resched(struct kmemleak_object *object)
 	raw_spin_unlock_irq(&kmemleak_lock);
 
 	rcu_read_unlock();
-	cond_resched();
+	cond_resched_tasks_rcu_qs();
 	rcu_read_lock();
 
 	raw_spin_lock_irq(&kmemleak_lock);
@@ -1731,7 +1731,7 @@ static void kmemleak_scan_task_stacks(void)
 			}
 			put_task_struct(p);
 		}
-		cond_resched();
+		cond_resched_tasks_rcu_qs();
 	} while (pid && !stop);
 }
 
@@ -1810,7 +1810,7 @@ static void kmemleak_scan(void)
 			struct page *page = pfn_to_online_page(pfn);
 
 			if (!(pfn & 63))
-				cond_resched();
+				cond_resched_tasks_rcu_qs();
 
 			if (!page)
 				continue;
-- 
2.53.0

