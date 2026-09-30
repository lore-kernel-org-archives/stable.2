Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E573655E7
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 02:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790735130; cv=none; b=cKMLvLh52p6OSmM3boZS89qn/UiH0NWctmx0vmTBYdsrbW7s3Fiu0SahfN5oHTROzq84IhLFfEipCNDuGFg2mW7qT28IO5XKmt6m1HK/LTWHxqBgOyxzbqlK78uBTYBIx0pojY5fOooHTjHN9MG36x5xfIshgLvhGjr3lMWoo2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790735130; c=relaxed/simple;
	bh=jmooeCkqEuANGiE0fqtGqtwQBvnjwF25GFtj+6cOXao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X3/9d6XCmTZRmmuXsUyovB9BYUysYuL+cqj5NBSSX/kVLFclHjQqmxMAC+3F/mOcnMClvCePLz8ksGhb57/ySU6IBDPubsQ0VK9JwWhR8Vw2dOYJO1tWSbxG2rENvQKLPZLaCdQIPWXa/ed+GdJtCrfsoF2njwVZK3I+XiPLB94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOgn768R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOgn768R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39C401F00898;
	Wed, 30 Sep 2026 02:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790735128;
	bh=uE9YqmacAy8SIhTnWCl7/041uY7XMdfdib+2x6ZddXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kOgn768R+Q3c4qY7aEy9qBa+pEukpvN45Zpg4IgCbvWIcHEvyMwInxkcOKk1jRHz0
	 rGNebGwcGVT8zH4ghlc9BjFKhPBU+SnI/bkSmIebESs3uMzBpolaJBsgZQ0eqrJTyX
	 K86pxCYc7+rA85k+vF1aFbjtkseHM3Z1mfY+jqbQeJ1yNJkrTDSoFky2XlmNp13Yv8
	 kvpsAmJ3Jp93bf+Xt1ZRm66t+fxGU8Jx9+tB/1brdheurjb0Nm4R78pQRvfN3V9qvM
	 j0FWaiEUwVsA+qXOTMClm7LGONb5yG7UbH1SqnghKE1FVzSFLZhLtH9Wuzg+MVVYKc
	 9gXHnmRBICKDg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Yifan Wu <wuyifan50@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] perf/core: Fix NULL pmu_ctx passed to pmu->sched_task()
Date: Tue, 29 Sep 2026 22:25:26 -0400
Message-ID: <20260930022526.3389821-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930022526.3389821-1-sashal@kernel.org>
References: <2026092945-acts-annex-739f@gregkh>
 <20260930022526.3389821-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Puranjay Mohan <puranjay@kernel.org>

[ Upstream commit 36bb85cf36cab15fb611cb44b78a5df06e4e69a2 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7cb8cb1f0f68e..c9ec3d08940e1 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3679,7 +3679,7 @@ static void __perf_pmu_sched_task(struct perf_cpu_pmu_context *cpc,
 	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
 	perf_pmu_disable(pmu);
 
-	pmu->sched_task(cpc->task_epc, task, sched_in);
+	pmu->sched_task(&cpc->epc, task, sched_in);
 
 	perf_pmu_enable(pmu);
 	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
-- 
2.53.0

