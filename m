Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7527935CB81
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 11:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790681692; cv=none; b=t9lknDhknwy0pP5W4ucTs3EzZ0K2Xn2ZL4tZuSD5PM/9rtlFV7ArQ4dVt9ZtEphZd/UTtEtj1U1LpBX9VBcGeLxGKVgFL965GPzwN+GrE8CH5R7pvAnwh4BIyJydIXFZSKxBz4QuYsWFDAYrE2nl13fjxTUL2SyB7T0v24BP7H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790681692; c=relaxed/simple;
	bh=bWMeU6Ev5eL8OY7DRFhdO4X8dGOVHrwMlmJEEibgkpA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=P2jDjrtp855R4O/2ne7m0BP8s9g9AyCjSPxW+rdoNIjG2c9hdSpEcR8cZCODzz1yTu1c8gQ6gtYndmRUzyn06bZSTJFEbDIJfXANWVQiesUa9Jb693do9bPQnPfNSf/beJcZXbgIT8i5d5JR6i0A81Jfv/gTVT3aP15tXo+u604=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ep8xjAdg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ep8xjAdg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE6A1F000FF;
	Tue, 29 Sep 2026 11:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790681691;
	bh=GPdxiIUgz6NJJ1/XpZJupyJQcSMKPNK57uBQQhq6kEQ=;
	h=Subject:To:Cc:From:Date;
	b=ep8xjAdgFVkcaQ2XiwR1lV/hBvI3TveAUkajAv9st2RMixVjpVsbhQCGuUBr8FvGe
	 93n1CKK83db/ndixePK5zPd3sKa54TgLD6dF4LT79fABCCnZMrEDLoEl3rlWlVUGLC
	 tsBspHucfH6XNJrgf8w+RFfOiqy8ObYuRq4vWCAQ=
Subject: FAILED: patch "[PATCH] perf/core: Fix NULL pmu_ctx passed to pmu->sched_task()" failed to apply to 6.6-stable tree
To: puranjay@kernel.org,peterz@infradead.org,wuyifan50@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 13:34:45 +0200
Message-ID: <2026092945-acts-annex-739f@gregkh>
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
git cherry-pick -x 36bb85cf36cab15fb611cb44b78a5df06e4e69a2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092945-acts-annex-739f@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 36bb85cf36cab15fb611cb44b78a5df06e4e69a2 Mon Sep 17 00:00:00 2001
From: Puranjay Mohan <puranjay@kernel.org>
Date: Mon, 10 Aug 2026 06:35:34 -0700
Subject: [PATCH] perf/core: Fix NULL pmu_ctx passed to pmu->sched_task()

perf_pmu_sched_task() returns early when cpuctx->task_ctx is set, and
cpc->task_epc is only non-NULL while a task context is scheduled in on
this CPU. __perf_pmu_sched_task() therefore always passes NULL:

  Unable to handle kernel NULL pointer dereference at virtual address 00
  pc : armv8pmu_sched_task+0x14/0x50
  Call trace:
   armv8pmu_sched_task+0x14/0x50 (P)
   perf_pmu_sched_task+0xac/0x108
   __perf_event_task_sched_out+0x6c/0xe0

Pass &cpc->epc instead, the CPU-wide context for this PMU, which the
function already dereferences a few lines up to find pmu.

armv8pmu_sched_task() is the only in-tree implementation that
dereferences the argument, and it only reads ->pmu, so the oops needs
BRBE, added in v6.17.

Fixes: bd2756811766 ("perf: Rewrite core context handling")
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Yifan Wu <wuyifan50@huawei.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260810133540.1947118-2-puranjay@kernel.org

diff --git a/kernel/events/core.c b/kernel/events/core.c
index e180134bad5e..7ce72f366f6c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3914,7 +3914,7 @@ static void __perf_pmu_sched_task(struct perf_cpu_pmu_context *cpc,
 	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
 	perf_pmu_disable(pmu);
 
-	pmu->sched_task(cpc->task_epc, task, sched_in);
+	pmu->sched_task(&cpc->epc, task, sched_in);
 
 	perf_pmu_enable(pmu);
 	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);

