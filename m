Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B81F376A12
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 23:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785195474; cv=none; b=E4y9rpgmXEiDoXIMuYavDqhtMzqVM5q1aWSzMFuolr+gpqP2GZZckIuTeZOJhqjwoDz4ScESooAALqAvqio9sV6vZmiKkOUkdrH+yWVYq7T1Kqgq5GO6XMm5zuApJzcK7wPjxxKZFUvs8HYBVJ6y6KbAg8tF7zU1bJkl65S6opU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785195474; c=relaxed/simple;
	bh=6Qi5hCqYroriuvzUhvjBo0Lz3GcoLWGtITsB38/IDDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MNS9RepgMejjxZLR6ldyy4ak/liGHbUfdohOt9Gltw/pe/3HN8tQ9uiLiZZRpzOsTVprelwg2nGXeNy6LZTg0O8QiflaW9iRYbYIEgLQZKmoQ+qwZi8NZ1lgyDNIVc5sUIdiG7uFK1HvmOqfdClyKGf4GW/niL7/xjIp5j130+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IsJbofqU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IsJbofqU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C4FB1F000E9;
	Mon, 27 Jul 2026 23:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785195472;
	bh=D4L+hu7tCcQBMFGNJnH+cjXfPSxiMy/lqvuZanSD+o8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IsJbofqUqou0Us35Vl+vv+ARRFWlmCemY2bWlL/S/zkWHwt2BnGirydCY5MlkITCf
	 iIVUIeMo7B1K1tMET5NmnJY93lSAmJCJQ01SlMDujvH2pBNfhWfZgRTfba30oFgDMk
	 9poP/9wDv83VdZOQriIda30UagrgSAeaszu+ZiUzHwO6nuFopngk3UVtO7pLm6oo0u
	 68d2qq9uRj6yLenPBdaKCAq3yVpCbVP2sHX7EMl1nmQDkvYw+orgoLy9rI+uQjLCCO
	 wwONDS1skYUc3lKLPvY6xsY//Wuop5PhejERAzFby2dXMytp8BptX2YeQhKxsRR+kS
	 EZdypqtWSYqVQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Allen Pais <allen.lkml@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] workqueue: Factor out init_cpu_worker_pool()
Date: Mon, 27 Jul 2026 19:37:48 -0400
Message-ID: <20260727233750.2439387-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072054-anywhere-moodiness-9087@gregkh>
References: <2026072054-anywhere-moodiness-9087@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tejun Heo <tj@kernel.org>

[ Upstream commit 2fcdb1b44491e08f5334a92c50e8f362e0d46f91 ]

Factor out init_cpu_worker_pool() from workqueue_init_early(). This is pure
reorganization in preparation of BH workqueue support.

Signed-off-by: Tejun Heo <tj@kernel.org>
Tested-by: Allen Pais <allen.lkml@gmail.com>
Stable-dep-of: 50fd6dd755c6 ("tracing/user_events: Fix use-after-free in user_event_mm_dup()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/workqueue.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index b59cc9f86d1595..0c451d6c579a8d 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -6609,6 +6609,22 @@ static void __init restrict_unbound_cpumask(const char *name, const struct cpuma
 	cpumask_and(wq_unbound_cpumask, wq_unbound_cpumask, mask);
 }
 
+static void __init init_cpu_worker_pool(struct worker_pool *pool, int cpu, int nice)
+{
+	BUG_ON(init_worker_pool(pool));
+	pool->cpu = cpu;
+	cpumask_copy(pool->attrs->cpumask, cpumask_of(cpu));
+	cpumask_copy(pool->attrs->__pod_cpumask, cpumask_of(cpu));
+	pool->attrs->nice = nice;
+	pool->attrs->affn_strict = true;
+	pool->node = cpu_to_node(cpu);
+
+	/* alloc pool ID */
+	mutex_lock(&wq_pool_mutex);
+	BUG_ON(worker_pool_assign_id(pool));
+	mutex_unlock(&wq_pool_mutex);
+}
+
 /**
  * workqueue_init_early - early init for workqueue subsystem
  *
@@ -6657,20 +6673,8 @@ void __init workqueue_init_early(void)
 		struct worker_pool *pool;
 
 		i = 0;
-		for_each_cpu_worker_pool(pool, cpu) {
-			BUG_ON(init_worker_pool(pool));
-			pool->cpu = cpu;
-			cpumask_copy(pool->attrs->cpumask, cpumask_of(cpu));
-			cpumask_copy(pool->attrs->__pod_cpumask, cpumask_of(cpu));
-			pool->attrs->nice = std_nice[i++];
-			pool->attrs->affn_strict = true;
-			pool->node = cpu_to_node(cpu);
-
-			/* alloc pool ID */
-			mutex_lock(&wq_pool_mutex);
-			BUG_ON(worker_pool_assign_id(pool));
-			mutex_unlock(&wq_pool_mutex);
-		}
+		for_each_cpu_worker_pool(pool, cpu)
+			init_cpu_worker_pool(pool, cpu, std_nice[i++]);
 	}
 
 	/* create default unbound and ordered wq attrs */
-- 
2.53.0

