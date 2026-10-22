Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685713;
	b=DxbnkReTZXdma3lGxlhjngURIQduNuiLIxZKYFQ7CiOm72Sm+t6r+VMrDcmFpbdGvdTk
	 VVYYbIcjJ0iTepKFGjbCHMbZ3WQZHZqKCm7F2itA8vbLnQ8nmKZOlwKhXe335PWP7gtX+
	 NOcbRU8UZ37WDvJw/SOSWtOZiNFM1nxeeSLxYJAvcTR5rJH6gs+Lk7bYa6OdMlZQWSrHt
	 mJKHtt0OS2yGTKJG35rtL6V05GHhC8KRFZroX8kRLK1ST/5mxEvwB9cWAuBSMpodTK9OY
	 11149q+O8ISJFjw3jhDfvQHADQ/6lQpXNkL6/PDdJ8vGVNP8xv1oEj9us2PteXONhTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685713;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=bJcT1O7IsTL3cxrXL7IEvmiEM4yHTncFBA3zQG5t+QI=;
	b=HKzXmDqcaDhkfON6rcVRnC0wqOyfggCVN/vEtAeAiCF/KBy49ojuhkMftWKteokW58jS
	 XVttIo/8kJAiASypFSfXi2S+RcBNSvhP+tF8RyK0sMjnZntmJVACXsTyETpeGH63HU6Io
	 c6pW242pPY22TBgEhJhmQI+o4zdYaW/4WX5AxEgAWIWdcV+V8nk+0Y0J4l7i13OS7Q3Q9
	 G+6jSY48YA32cxphXYMYnAwi5dePa8c0/4KD9NkQgeHo2YrACCigK+0bl+gyzkraFr8Ou
	 AXOHsavQRpeW9SVXeC/xT9Nv6BtpdxO5AA8JXj7Y4DyTARrx0AgRI0FcDAv/KglROyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MASlztzI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8432606A321
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 16:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MASlztzI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295B51F01825;
	Thu, 22 Oct 2026 16:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792685712;
	bh=bJcT1O7IsTL3cxrXL7IEvmiEM4yHTncFBA3zQG5t+QI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MASlztzIIylF/VrtSzEmZXGbFsde6G/tCRRvDjcpU1mt7PlzLaZurN4O7p0+niPot
	 lmBUjf+sOxYpHMfvsWhp4gvECRlq4Ga22kyvHyD1lD7iw7e4C1G1jr3kSnzLkTS3Eb
	 XRlSSWkPHmFFoj2i6S6X9i3rGpcXaSzWUG5BnCW/76WHX3yxS2zvvPbylyLW0RRQPq
	 GgB8cW/1kfxRnFWG14VIQIirPPjiSlu3nd1p5EO11NXf+idnP8TD8CsmIXBLLVpwnQ
	 aZxjEFz95cQndqir9unvdTA6qK8oaWPG3dO25m0vyVItWve+3lmklJTXZiwgs8BOWz
	 CJUVcgJysyhXA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] workqueue: release pwq pools by pool type
Date: Thu, 22 Oct 2026 12:15:08 -0400
Message-ID: <20261022161457.1728158-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102148-unadorned-icon-a748@gregkh>
References: <2026102148-unadorned-icon-a748@gregkh>
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

Use a single-evaluation macro for is_percpu_pool() so the predicate
conversion does not add a function. Keep the existing watchdog stall
accounting; only its pool-type check needs to change. This preserves
the release-path context needed by the pending-pwq lifetime fix.

Stable-dep-of: cf9c8aaea0d4 ("workqueue: Fix unbound pool lifetime for pending pwqs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/workqueue.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 329394830c40f..14a3d1775c2ff 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1559,6 +1559,8 @@ work_func_t wq_worker_last_func(struct task_struct *task)
 	return worker->last_func;
 }
 
+#define is_percpu_pool(pool) ((pool)->cpu >= 0)
+
 /**
  * wq_node_nr_active - Determine wq_node_nr_active to use
  * @wq: workqueue of interest
@@ -2683,7 +2685,7 @@ static struct worker *alloc_worker(int node)
 
 static cpumask_t *pool_allowed_cpus(struct worker_pool *pool)
 {
-	if (pool->cpu < 0 && pool->attrs->affn_strict)
+	if (!is_percpu_pool(pool) && pool->attrs->affn_strict)
 		return pool->attrs->__pod_cpumask;
 	else
 		return pool->attrs->cpumask;
@@ -4969,7 +4971,7 @@ static void put_unbound_pool(struct worker_pool *pool)
 		return;
 
 	/* sanity checks */
-	if (WARN_ON(!(pool->cpu < 0)) ||
+	if (WARN_ON(is_percpu_pool(pool)) ||
 	    WARN_ON(!list_empty(&pool->worklist)))
 		return;
 
@@ -5121,7 +5123,7 @@ static void pwq_release_workfn(struct kthread_work *work)
 		mutex_unlock(&wq->mutex);
 	}
 
-	if (wq->flags & WQ_UNBOUND) {
+	if (!is_percpu_pool(pool)) {
 		mutex_lock(&wq_pool_mutex);
 		put_unbound_pool(pool);
 		mutex_unlock(&wq_pool_mutex);
@@ -7639,7 +7641,7 @@ static void wq_watchdog_timer_fn(struct timer_list *unused)
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

