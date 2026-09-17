Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920069475
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 01:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789608787; cv=none; b=BV36AEJi/BnfU5c5ZyLT1fpq0jNkX5turKahJeBto3T3Q/KbRh1yom6C+YbqPV8UVn6ZH6g7iG5G/jmPTRgI7GI6OrlwPAYFrBZneh2gHODh25WOKnArTruhwSbA9MpY1PEMXYuFSmMuO4zW28+Sx8rktGEwAat6ljqRzNE6nN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789608787; c=relaxed/simple;
	bh=vv9Qzyt+Wm9CMMZiSqzNR5ncNBuwgoleOf2DIYEJQGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EX10gI4yi84fNIZHZi8YHMmU7hqGEhuNfEMC4h/YnFKuBuk+LyDAz0EzVf5pKyimRowRXVDVfaws27xlIsgJDZQBnYvelwAIBzrslC5V+6Q8c1TixcboQKLF/af7Saw2NcfUm35REMzWkPkpPUXc8NMPV+m31XJzMHyZZt+bnHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDNyU6/a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDNyU6/a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 647341F000FF;
	Thu, 17 Sep 2026 01:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789608786;
	bh=2CZcgk8R4LCtjgyPPcvViUwShuK0zJ82U6HExsrdHqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BDNyU6/a8VS2K8L9tDNhGNWAfy3UT/Ic6tD3xcKCDuxb5SwRw8JL57NDHHXa4qzWb
	 ilRNdFzN8pU4xoTgb7FcvoI018nXMrj1k8OydRsg0Qu+6yzrjb3GOO+IEu2mPBzGZe
	 agyrsc//AOZsBclbha3rDF2Sy0oxhpxvu5oRlsnTFScml2s1tAeDYuzzCCYmxIUyyW
	 ysoTdJW60CPzMvoSUneviC6ViAR6sTFryvcvNX+r8se6qi6HR/BfskRnqXO4t3n5wW
	 RfORv4lUBa5Cgl8QMAjn5ObJgsQkvsXnyDQsgkiHArq5HZxeYvzfT9PtyxAVYnnyeY
	 BhYLkWoKyuuSg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Richter <tmricht@linux.ibm.com>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 1/3] s390/pai: Use PAI PMU index as parameter replacing event
Date: Wed, 16 Sep 2026 21:33:01 -0400
Message-ID: <20260917013303.3594106-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091643-probably-sprinkled-c1c7@gregkh>
References: <2026091643-probably-sprinkled-c1c7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Richter <tmricht@linux.ibm.com>

[ Upstream commit 4eef4ab3aa3a32725e5bc79032c722f9f4a90172 ]

Use PAI PMU index value as function argument instead of pointer
to struct perf_event. Only that index value is used inside
functions pai_alloc_cpu() and pai_event_destroy_cpu().
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
index cdb8006220ca0..7c13f5586c793 100644
--- a/arch/s390/kernel/perf_pai.c
+++ b/arch/s390/kernel/perf_pai.c
@@ -140,16 +140,14 @@ static void pai_free(struct pai_mapptr *mp)
 /* Adjust usage counters and remove allocated memory when all users are
  * gone.
  */
-static void pai_event_destroy_cpu(struct perf_event *event, int cpu)
+static void pai_event_destroy_cpu(int idx, int cpu)
 {
-	int idx = PAI_PMU_IDX(event);
 	struct pai_mapptr *mp = per_cpu_ptr(pai_root[idx].mapptr, cpu);
 	struct pai_map *cpump = mp->mapptr;
 
 	mutex_lock(&pai_reserve_mutex);
-	debug_sprintf_event(paidbg, 5, "%s event %#llx idx %d cpu %d users %d "
-			    "refcnt %u\n", __func__, event->attr.config, idx,
-			    event->cpu, cpump->active_events,
+	debug_sprintf_event(paidbg, 5, "%s users %d refcnt %u\n",
+			    __func__, cpump->active_events,
 			    refcount_read(&cpump->refcnt));
 	if (refcount_dec_and_test(&cpump->refcnt))
 		pai_free(mp);
@@ -159,17 +157,17 @@ static void pai_event_destroy_cpu(struct perf_event *event, int cpu)
 
 static void pai_event_destroy(struct perf_event *event)
 {
-	int cpu;
+	int cpu = 0, idx = PAI_PMU_IDX(event);
 
 	free_page(PAI_SAVE_AREA(event));
 	if (event->cpu == -1) {
 		struct cpumask *mask = PAI_CPU_MASK(event);
 
 		for_each_cpu(cpu, mask)
-			pai_event_destroy_cpu(event, cpu);
+			pai_event_destroy_cpu(idx, cpu);
 		kfree(mask);
 	} else {
-		pai_event_destroy_cpu(event, event->cpu);
+		pai_event_destroy_cpu(idx, event->cpu);
 	}
 }
 
@@ -241,12 +239,12 @@ static u64 paicrypt_getall(struct perf_event *event)
  *
  * Allocate the memory for the event.
  */
-static int pai_alloc_cpu(struct perf_event *event, int cpu)
+static int pai_alloc_cpu(int idx, int cpu)
 {
-	int rc, idx = PAI_PMU_IDX(event);
 	struct pai_map *cpump = NULL;
 	bool need_paiext_cb = false;
 	struct pai_mapptr *mp;
+	int rc;
 
 	mutex_lock(&pai_reserve_mutex);
 	/* Allocate root node */
@@ -318,6 +316,7 @@ static int pai_alloc_cpu(struct perf_event *event, int cpu)
 
 static int pai_alloc(struct perf_event *event)
 {
+	int idx = PAI_PMU_IDX(event);
 	struct cpumask *maskptr;
 	int cpu, rc = -ENOMEM;
 
@@ -326,10 +325,10 @@ static int pai_alloc(struct perf_event *event)
 		goto out;
 
 	for_each_online_cpu(cpu) {
-		rc = pai_alloc_cpu(event, cpu);
+		rc = pai_alloc_cpu(idx, cpu);
 		if (rc) {
 			for_each_cpu(cpu, maskptr)
-				pai_event_destroy_cpu(event, cpu);
+				pai_event_destroy_cpu(idx, cpu);
 			kfree(maskptr);
 			goto out;
 		}
@@ -392,7 +391,7 @@ static int pai_event_init(struct perf_event *event, int idx)
 	}
 
 	if (event->cpu >= 0)
-		rc = pai_alloc_cpu(event, event->cpu);
+		rc = pai_alloc_cpu(idx, event->cpu);
 	else
 		rc = pai_alloc(event);
 	if (rc) {
-- 
2.53.0

