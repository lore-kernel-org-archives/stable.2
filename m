Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC29286D60
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 01:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789608788; cv=none; b=jWkXs5JuxAWgArFsP/KtdImoUOMq86N9Lf2RiPUDTcTEKzaGwY2vuBzxFjM1V9m6M7JdVsNXQ1fESMcH4Kfey6TtOiFpH35kl0Q+LRm8Mmt3zB9DEIzXC9dOF40ruQySRd1PizgVyrpZqORb+SCqT60IG7Use+VykQD11tszbCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789608788; c=relaxed/simple;
	bh=BwCmCrPescqKCwrmyW6yiTElIlSVxhSzQkAtNdZsffk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mhu8RRwubycXDMCng7A89+UJN4H3yVBbQcuxK3Lr+e87VDLxPw+yXgTIfgor4kC9cgAf97sKHOJU880wZoCIbod6mIdkhFUKHflyhaBx8cW16o0aBwrgRJu52GO8kIPQMEa3niY6DJnEnQx2s5DF0pWBoFSkWIL9O2CPcUFyIds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6/hJv3S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6/hJv3S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49FE61F00893;
	Thu, 17 Sep 2026 01:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789608786;
	bh=OA9xM8YA3GUwd1zp+jH07qipOuNsrl0tcEmr4BGgkEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i6/hJv3SNTAcz++s9GHPQ2HiAn0m3D9PX0h/jyqdGaFnNR4D2mKr1KoXwWyygc4h0
	 cUrFgDfBC6P7ITB9Tf6BjF+epY3uu4eJwomZHZ1rNXJrSFpEfq0XBcVeM12U+kDpYV
	 wGE+T/Ojgcd3EnETM/YI2NT4l8e6QvspaTg0imWZkQEn6yKQLJ9/Ox+5WfNn1F+URs
	 z6lULpchayTvROWsAvsB8rmOLTICUBvTN+RG+hlQDiKQoxXrOxxqLKskFVQ8/libJc
	 VXPOuApTNQ46Wi5PF0pZ/Fmd3wtCpAFG0VV1IYulbNNxAXVqenf+TaWwF7iSTWtJNk
	 WiqNMXrqx1zmQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Richter <tmricht@linux.ibm.com>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 2/3] s390/pai: Move locking to event init and delete
Date: Wed, 16 Sep 2026 21:33:02 -0400
Message-ID: <20260917013303.3594106-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917013303.3594106-1-sashal@kernel.org>
References: <2026091643-probably-sprinkled-c1c7@gregkh>
 <20260917013303.3594106-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Richter <tmricht@linux.ibm.com>

[ Upstream commit e8df39dacb7d98d2b2aea431ca652d9fadf5efa3 ]

Move mutex locking from per CPU allocation to event allocation.
No functional change.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Stable-dep-of: 9ecc4d033879 ("s390/pai: Support CPU hotplug for PMU PAI")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/perf_pai.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/arch/s390/kernel/perf_pai.c b/arch/s390/kernel/perf_pai.c
index 7c13f5586c793..52d9f654346a2 100644
--- a/arch/s390/kernel/perf_pai.c
+++ b/arch/s390/kernel/perf_pai.c
@@ -138,21 +138,19 @@ static void pai_free(struct pai_mapptr *mp)
 }
 
 /* Adjust usage counters and remove allocated memory when all users are
- * gone.
+ * gone. Called under mutex_lock.
  */
 static void pai_event_destroy_cpu(int idx, int cpu)
 {
 	struct pai_mapptr *mp = per_cpu_ptr(pai_root[idx].mapptr, cpu);
 	struct pai_map *cpump = mp->mapptr;
 
-	mutex_lock(&pai_reserve_mutex);
 	debug_sprintf_event(paidbg, 5, "%s users %d refcnt %u\n",
 			    __func__, cpump->active_events,
 			    refcount_read(&cpump->refcnt));
 	if (refcount_dec_and_test(&cpump->refcnt))
 		pai_free(mp);
 	pai_root_free(idx);
-	mutex_unlock(&pai_reserve_mutex);
 }
 
 static void pai_event_destroy(struct perf_event *event)
@@ -160,6 +158,7 @@ static void pai_event_destroy(struct perf_event *event)
 	int cpu = 0, idx = PAI_PMU_IDX(event);
 
 	free_page(PAI_SAVE_AREA(event));
+	mutex_lock(&pai_reserve_mutex);
 	if (event->cpu == -1) {
 		struct cpumask *mask = PAI_CPU_MASK(event);
 
@@ -169,6 +168,7 @@ static void pai_event_destroy(struct perf_event *event)
 	} else {
 		pai_event_destroy_cpu(idx, event->cpu);
 	}
+	mutex_unlock(&pai_reserve_mutex);
 }
 
 static void paicrypt_event_destroy(struct perf_event *event)
@@ -232,12 +232,10 @@ static u64 paicrypt_getall(struct perf_event *event)
 	return sum;
 }
 
-/* Check concurrent access of counting and sampling for crypto events.
- * This function is called in process context and it is save to block.
- * When the event initialization functions fails, no other call back will
- * be invoked.
- *
- * Allocate the memory for the event.
+/* Allocate all per-CPU data structures. This function is called in
+ * process context and can block. In case of error all partly allocated
+ * memory is released and the reference counters adjusted correctly.
+ * Called under mutex_lock.
  */
 static int pai_alloc_cpu(int idx, int cpu)
 {
@@ -246,11 +244,10 @@ static int pai_alloc_cpu(int idx, int cpu)
 	struct pai_mapptr *mp;
 	int rc;
 
-	mutex_lock(&pai_reserve_mutex);
 	/* Allocate root node */
 	rc = pai_root_alloc(idx);
 	if (rc)
-		goto unlock;
+		goto out;
 
 	/* Allocate node for this event */
 	mp = per_cpu_ptr(pai_root[idx].mapptr, cpu);
@@ -308,12 +305,12 @@ static int pai_alloc_cpu(int idx, int cpu)
 		 */
 		pai_root_free(idx);
 	}
-unlock:
-	mutex_unlock(&pai_reserve_mutex);
+out:
 	/* If rc is non-zero, no increment of counter/sampler was done. */
 	return rc;
 }
 
+/* Called under mutex_lock */
 static int pai_alloc(struct perf_event *event)
 {
 	int idx = PAI_PMU_IDX(event);
@@ -390,10 +387,12 @@ static int pai_event_init(struct perf_event *event, int idx)
 		}
 	}
 
+	mutex_lock(&pai_reserve_mutex);
 	if (event->cpu >= 0)
 		rc = pai_alloc_cpu(idx, event->cpu);
 	else
 		rc = pai_alloc(event);
+	mutex_unlock(&pai_reserve_mutex);
 	if (rc) {
 		free_page(PAI_SAVE_AREA(event));
 		goto out;
-- 
2.53.0

