Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792682058;
	b=EpGgPrYY31yr2vOJFziD6SMSInEYtMF/M1L+Rjo3nWMdI5+RarkVWm0JDXQQYtlG8SbY
	 xk9jAVeU+18Be0gYkrukC5Q2P0stroiIYBrJJ/Cw9JZncL6xbU0FPPwD+IWE7gvePI0e2
	 AYozzzQU8jByVj4fq6xGQfnHM1BMK+atom8DfF6Inlpywjarj5IgnsoLmD8fBQWEZGbKN
	 mrYLctXGNngfk1l6wdfynXqVXL+Hd4Ao7XqHcro2cArWd934LlH+F1CiSTa5HqaRY69aK
	 x1uI15WAXMClrLrDJxjXrtt9f56IbiQo6fB5fPwPXZUmpZ9QGi1odou7ktSdvaGo0ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792682058;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PAgUGMUWsv1fwJz77VcXAeZqrjR0vs5IB+Vwz01JLrM=;
	b=I1dfKvQBTuVhvYup+fmwcdHvFYuZJj2boo2Ue4CpQFH1zmptz50A387X/xh5StZ9IJWv
	 ZoM/YCv1hflrr/rg4yQUsVaSYxV+mhDeM+QHpend3mqhY2vWR/VS5Ca+r2dUR9D++3Ekf
	 4z3Z7ACTpXl1BAP3Jesul/p+V1wLzPEWV1PyahteF6RClzUyQJIhAlVd7vfQZi3e8IMfc
	 ktVUUtF3Hs+RLICd6i6R0YGnqbwAzpiJbEyyNQ4Is78GmahN7S2wa+SNK5UgA5YsRAhz1
	 gZJgg5MvMOmMp0efhG6asREn6NunoP6GC8XGd6WhEUfpxfK+vqsxT/o/fziYk+jCz3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K9H4Ftfw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BACD606ACD5
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 15:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K9H4Ftfw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC9B1F01825;
	Thu, 22 Oct 2026 15:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792682057;
	bh=PAgUGMUWsv1fwJz77VcXAeZqrjR0vs5IB+Vwz01JLrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K9H4Ftfw7M30OKXeKXCjTo8aYDx6ixUbV7e5VFCAuB8sxcSirTFt90/5uk1EQiO8x
	 VOoLEbcCKVsdM2kNLCkIga/tRCbfQjhbn2N5HGjjSPHpAUAWLc8txAncPPjCBR5O2D
	 zNrelJ+VpQnVjKgu5oQ50vuOWb/LWZxtdqlgeP6x+0d5WkzI3TwYoUgE/Pan3JFdGa
	 cEUiqBdGqYpdL0R1bkOBqiRe5DEh83cNOIgIq7oZ6vRSkzsm+QJsZf5wprUB71UFLg
	 3pS2pEcoIhMq3LqdBMCNIN9LoVBzYu3b5gxw9pCTtDvQN5h9JUFOHsUyx8FXDnuN79
	 Kr/A+Ym0d5qqA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] workqueue: release pwq pools by pool type
Date: Thu, 22 Oct 2026 11:14:14 -0400
Message-ID: <20261022150730.1630145-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102148-outpour-epilogue-a40f@gregkh>
References: <2026102148-outpour-epilogue-a40f@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Breno Leitao <leitao@debian.org>

[ Upstream commit 3180ee71b676845603274c66f6bb5528939cf470 ]

Add is_percpu_pool() and test the pool directly for per cpu. Convert the
other open-coded pool->cpu checks -- in put_unbound_pool(),
pool_allowed_cpus() and the workqueue watchdog -- to the same helper.

No functional change.

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Tejun Heo <tj@kernel.org>

Use a single-evaluation macro for the pool predicate. Keep the existing
watchdog timestamp and reporting behavior, converting only its pool-type
test; the newer stall-duration accounting is absent.

Stable-dep-of: cf9c8aaea0d4 ("workqueue: Fix unbound pool lifetime for pending pwqs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/workqueue.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index fff53beae69b1..b7b09a618d047 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1562,6 +1562,9 @@ work_func_t wq_worker_last_func(struct task_struct *task)
 	return worker->last_func;
 }
 
+/* True if @pool is a static per-cpu pool rather than an unbound one. */
+#define is_percpu_pool(pool) ((pool)->cpu >= 0)
+
 /**
  * wq_node_nr_active - Determine wq_node_nr_active to use
  * @wq: workqueue of interest
@@ -2689,7 +2692,7 @@ static struct worker *alloc_worker(int node)
 
 static cpumask_t *pool_allowed_cpus(struct worker_pool *pool)
 {
-	if (pool->cpu < 0 && pool->attrs->affn_strict)
+	if (!is_percpu_pool(pool) && pool->attrs->affn_strict)
 		return pool->attrs->__pod_cpumask;
 	else
 		return pool->attrs->cpumask;
@@ -5030,7 +5033,7 @@ static void put_unbound_pool(struct worker_pool *pool)
 		return;
 
 	/* sanity checks */
-	if (WARN_ON(!(pool->cpu < 0)) ||
+	if (WARN_ON(is_percpu_pool(pool)) ||
 	    WARN_ON(!list_empty(&pool->worklist)))
 		return;
 
@@ -5182,7 +5185,7 @@ static void pwq_release_workfn(struct kthread_work *work)
 		mutex_unlock(&wq->mutex);
 	}
 
-	if (wq->flags & WQ_UNBOUND) {
+	if (!is_percpu_pool(pool)) {
 		mutex_lock(&wq_pool_mutex);
 		put_unbound_pool(pool);
 		mutex_unlock(&wq_pool_mutex);
@@ -7720,7 +7723,7 @@ static void wq_watchdog_timer_fn(struct timer_list *unused)
 		/* did we stall? */
 		if (time_after(now, ts + thresh)) {
 			lockup_detected = true;
-			if (pool->cpu >= 0 && !(pool->flags & POOL_BH)) {
+			if (is_percpu_pool(pool) && !(pool->flags & POOL_BH)) {
 				pool->cpu_stall = true;
 				cpu_pool_stall = true;
 			}
-- 
2.53.0

