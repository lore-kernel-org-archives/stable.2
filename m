Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76E337C93F;
	Fri,  7 Aug 2026 21:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786136545; cv=none; b=mUpmG9O0BfR6WWirhUJyv1QheLQeCTtKF2J8YMUrSBB8mb844jNTAufb8ve3H48WuHCUNLDHvMdIpp4UqwIfKufmYqbs9bKbwhXwMrgw8pZssp9KCzRZqsNxd0SBt0fQLvhs6ZsQwJT4TolOajTr0e/gZRRwj1wPQXjhkencJFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786136545; c=relaxed/simple;
	bh=7gnbitBv+8D29/VHYRV4KX3pT6K08KKOPPYRNi46mIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KDXMpSSiX8cTY+UvVJkc4Idl4kG6P1JuW9Rm28i6vzbtRkhz4RIeWzK8RCg6vZY2ckXj055VW1AsBLkpuND5mUfPt2uofL1eJJC8idHaJ9gebjuReCJ6JI3o4N2SRj/ZqvtXmiH0pC1IWZ6W0nRNCUov6b6WBgj11GbcHUKNJ44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YtqbV5DR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YtqbV5DR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E7F1F00A3A;
	Fri,  7 Aug 2026 21:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786136543;
	bh=v8SAuY6hVsOZeGwaD7MPATne1cZ+yypvaqtDlAFCieI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YtqbV5DRF0cA0iQD1zBd2QT8e60FltvTq5ijSH3GOKwRFtj0sLHYePJ3npRpAQccr
	 TftUga/kWHnEK69TwqHHNMB8IZUQi5hGxFLaXZy/D0fIRmXtIusJqjnOXcd2IWuzyS
	 LIdzW2Wzo5DWdI08hMEa9tsZ8YNbR85Ym/7/KhJtwuOEE9eeMnKCWwaGavWMXdbwxb
	 QUIAzR+Q47oQxum7K21P+P1e2XYCl1yruKvwi5lVqWjqDJwRCk49e7Zzxp2t9jxCDM
	 2rhL/zF87qUxPHHYNQuBGoNVYQuqfYRrNsJr2Kjg4FisjtnLKVmAhVBl224VIHxVV8
	 45xbgRola/lMQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	Peter Zijlstra <peterz@infradead.org>,
	ElXreno <elxreno@gmail.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/6] sched/core: Handle pick_task() releasing the rq lock
Date: Fri,  7 Aug 2026 11:02:16 -1000
Message-ID: <20260807210221.232543-2-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807210221.232543-1-tj@kernel.org>
References: <20260807210221.232543-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Core scheduling's pick_next_task() breaks when a ->pick_task()
implementation can release the rq lock. The selection state derived on entry
is only valid while the lock is held continuously. Once a pick can drop the
lock, an interleaving selection can invalidate all of it: the single-CPU
fast path can commit an uncookied pick although the core went cookied during
the release, and forceidle committed by the interleaving selection skews the
restarted pass's accounting.

Fix it by restarting the whole selection when a pick returns RETRY_TASK
after releasing the lock: a single restart point above the state derivation
replaces the per-loop restart labels, so a retry picks up state committed by
interleaving selections and accounts and resets forceidle like a fresh
selection would.

need_sync and fi_before latch across retries. Clock validity can't be
re-derived - there is no program-ordered way to tell whether the own and
core rq clocks are still updated after the lock was released, as other
lockers' pin cycles may or may not have invalidated them. When restarting,
clear core_clock_updated so that the sibling loop re-updates the core rq,
and update the own rq clock if invalidated.

Fixes: 4c95380701f5 ("sched/ext: Fold balance_scx() into pick_task_scx()")
Cc: stable@vger.kernel.org # v6.19+
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/core.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3cc6fb1d2054..84ef83316562 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6217,7 +6217,7 @@ pick_next_task(struct rq *rq, struct rq_flags *rf)
 	unsigned long cookie;
 	int i, cpu, occ = 0;
 	struct rq *rq_i;
-	bool need_sync;
+	bool need_sync = false;
 
 	if (!sched_core_enabled(rq))
 		return __pick_next_task(rq, rf);
@@ -6260,7 +6260,9 @@ pick_next_task(struct rq *rq, struct rq_flags *rf)
 	prev_balance(rq, rf);
 
 	smt_mask = cpu_smt_mask(cpu);
-	need_sync = !!rq->core->core_cookie;
+
+restart:
+	need_sync |= !!rq->core->core_cookie;
 
 	/* reset state */
 	rq->core->core_cookie = 0UL;
@@ -6295,10 +6297,15 @@ pick_next_task(struct rq *rq, struct rq_flags *rf)
 	 * and there are no cookied tasks running on siblings.
 	 */
 	if (!need_sync) {
-restart_single:
 		next = pick_task(rq, rf);
-		if (unlikely(next == RETRY_TASK))
-			goto restart_single;
+		if (unlikely(next == RETRY_TASK)) {
+			/* rq lock may have been dropped, clocks invalidated */
+			core_clock_updated = false;
+			if (!(rq->clock_update_flags & RQCF_UPDATED))
+				update_rq_clock(rq);
+			goto restart;
+		}
+
 		if (!next->core_cookie) {
 			rq->core_pick = NULL;
 			rq->core_dl_server = NULL;
@@ -6318,7 +6325,6 @@ pick_next_task(struct rq *rq, struct rq_flags *rf)
 	 *
 	 * Tie-break prio towards the current CPU
 	 */
-restart_multi:
 	max = NULL;
 	for_each_cpu_wrap(i, smt_mask, cpu) {
 		rq_i = cpu_rq(i);
@@ -6332,8 +6338,13 @@ pick_next_task(struct rq *rq, struct rq_flags *rf)
 			update_rq_clock(rq_i);
 
 		p = pick_task(rq_i, rf);
-		if (unlikely(p == RETRY_TASK))
-			goto restart_multi;
+		if (unlikely(p == RETRY_TASK)) {
+			/* rq lock may have been dropped, clocks invalidated */
+			core_clock_updated = false;
+			if (!(rq->clock_update_flags & RQCF_UPDATED))
+				update_rq_clock(rq);
+			goto restart;
+		}
 
 		rq_i->core_pick = p;
 		rq_i->core_dl_server = rq_i->dl_server;
-- 
2.55.0

