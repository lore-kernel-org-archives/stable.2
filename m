Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B44501291
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 17:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790790191; cv=none; b=idtjzWVlXcJ+m2RU8KNSADDuNb9LMk8wZGF90UtFpa8svOqUniFcCGeyL3CzytMx+fMX6tp7kabPyIwagT3vCaqZ+VuVlnhO5WjuTPtFAv0nzsGpSiRhq5C7/ddMAQ0s57SxIqEzVYKY18YI9jGAeooQ7CBXbdHMDtA93+fupU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790790191; c=relaxed/simple;
	bh=7/9yWL/vCrF1RDQj5OaXAqTJCeaG966wirQd+ktxyG8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qNdF9iYGSZ0B2C48Ichrgdl44VrbvabYrUELMxu8toRz0uxsUHQlhRgtnKZn7XM/Rwe5czh/+rd+ytrT95JgFPzzSVACP8O28ahYzVa0A6F4PvIWtFtP7b0Lo4Hbkn1ffVxSRuHSMx/Eb6s9IcjwRJUUmxQ3Xy1TAxtt4t38E6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GkQ9BfsA; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GkQ9BfsA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790790189; x=1822326189;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7/9yWL/vCrF1RDQj5OaXAqTJCeaG966wirQd+ktxyG8=;
  b=GkQ9BfsAtnKtdkO3iOxvhZYywx/j2FbngS8K9UsbreiWpYNMwxTqnmPo
   6ZVHxSrIGcxE6IhIOhK8+bgOzI/JK+aYrSj2PsH+kvlbmErGeWIdc8EOX
   Pyk64Icy4jbFWYiTph3CyUZwdONSWu/fhcak0/PNzGVZjkIoM/LoyO1tR
   8QeDCcrlhd03xQaQ809twG8APptDtnf2oV8v1cXVSBNHYTm9H3+dqV0a4
   6KYjQWctxIaUxHeCaf1LUMicQbu7p/1jM1XfvadbDXlYVWU+55XtGWsVy
   +pXIchuUbKzDhRmLAP6RbLD2biFpmXY308NJEVGLSMMWiSe3ga0D4J6d+
   Q==;
X-CSE-ConnectionGUID: bU5yNf9qTyuur+Ukx+RlnA==
X-CSE-MsgGUID: JrZbOCLVSMGpkyQsT+Z4qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="91633364"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="91633364"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 10:43:00 -0700
X-CSE-ConnectionGUID: wZlnnmoNTWe4/s6bDtCgOw==
X-CSE-MsgGUID: CAcoEbnIQo29W2hXHLXFrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="303684057"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by fmviesa001.fm.intel.com with ESMTP; 30 Sep 2026 10:43:00 -0700
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Davi Chaves Azevedo <davichazbh@gmail.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Lu Wang <wanglu.priv@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	stable@vger.kernel.org,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	stable@kernel.org
Subject: [PATCH 7.2.y 7/7] sched/cache: Refresh LLC capacity across CPU hotplug, to fix capacity underestimation bug
Date: Wed, 30 Sep 2026 10:48:09 -0700
Message-Id: <db3e6401eac9d7779f1fd0987ba9f55696196b12.1790790344.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1790790344.git.tim.c.chen@linux.intel.com>
References: <cover.1790790344.git.tim.c.chen@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Davi Chaves Azevedo <davichazbh@gmail.com>

[ Upstream commit 3cb0243767fd033bdce95f4f1b5882172a2f8119 ]

The scheduler scales LLC capacity by the fraction of cache-sharing CPUs
covered by a domain:

  llc_bytes = cache_size * span_weight / shared_weight

During CPU teardown, sched_cpu_deactivate() rebuilds scheduler domains
before cacheinfo_cpu_pre_down() removes the CPU from shared_cpu_map. The
new domains therefore use the old sharing weight. The later call to
sched_update_llc_bytes() looks up the departing CPU's sd_llc, which has
already been detached, and returns without correcting the surviving CPUs.

On a Ryzen 5 7535U with twelve logical CPUs sharing a 16 MiB LLC,
offlining one SMT sibling left the remaining CPUs with:

  llc_bytes = floor(16777216 * 11 / 12) = 15379114 bytes

The correct capacity is still 16777216 bytes. On systems with active
cache-aware scheduling, an underestimated capacity can cause
exceed_llc_capacity() to reject aggregation for a process whose footprint
would fit. Unchanged cpuset partitions sharing the physical cache can
also retain stale capacity when a CPU comes online in another partition.

Pass the cache-sharing mask already retained by cacheinfo to the
scheduler update. Refresh every surviving CPU using its own LLC domain
so that each partition receives the correct share. This also preserves
the correction needed as cache-sharing maps grow during boot.

Keep the existing CPU-hotplug and scheduler-domain synchronization. The
update remains on the hotplug path; no steady-state scheduling operation
or persistent allocation is added.

Fixes: 7030513a0877 ("sched/cache: Calculate the LLC size and store it in sched_domain")
Signed-off-by: Davi Chaves Azevedo <davichazbh@gmail.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Chen Yu <yu.c.chen@intel.com>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: Chen Yu <yu.c.chen@intel.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: <stable@kernel.org> # v7.2.x
Link: https://patch.msgid.link/6751d93e15889e624796c74db0bfe66603d60b1b.1790035273.git.tim.c.chen@linux.intel.com
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 drivers/base/cacheinfo.c       | 11 ++++++-----
 include/linux/sched/topology.h |  4 ++--
 kernel/sched/topology.c        | 22 +++++++++++++---------
 3 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 9f9c72727a059..7a47a392568a0 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -1040,9 +1040,10 @@ static int cacheinfo_cpu_online(unsigned int cpu)
 	rc = cache_add_dev(cpu);
 	if (rc)
 		goto err;
-	if (cpu_map_shared_cache(true, cpu, &cpu_map))
+	if (cpu_map_shared_cache(true, cpu, &cpu_map)) {
 		update_per_cpu_data_slice_size(true, cpu, cpu_map);
-	sched_update_llc_bytes(cpu);
+		sched_update_llc_bytes(cpu_map);
+	}
 	return 0;
 err:
 	free_cache_attributes(cpu);
@@ -1059,10 +1060,10 @@ static int cacheinfo_cpu_pre_down(unsigned int cpu)
 		cpu_cache_sysfs_exit(cpu);
 
 	free_cache_attributes(cpu);
-	if (nr_shared > 1)
+	if (nr_shared > 1) {
 		update_per_cpu_data_slice_size(false, cpu, cpu_map);
-
-	sched_update_llc_bytes(cpu);
+		sched_update_llc_bytes(cpu_map);
+	}
 
 	return 0;
 }
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index b5d9d7c2b8add..f96812d71c515 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -281,9 +281,9 @@ static inline int task_node(const struct task_struct *p)
 }
 
 #ifdef CONFIG_SCHED_CACHE
-extern void sched_update_llc_bytes(unsigned int cpu);
+extern void sched_update_llc_bytes(const struct cpumask *cpus);
 #else
-static inline void sched_update_llc_bytes(unsigned int cpu) { }
+static inline void sched_update_llc_bytes(const struct cpumask *cpus) { }
 #endif
 
 #endif /* _LINUX_SCHED_TOPOLOGY_H */
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 622e2e01974c4..70b63224a230d 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -985,8 +985,8 @@ void sched_cache_active_set(void)
 }
 
 /*
- * Update the bottom sched_domain's llc_bytes for @cpu and all its
- * LLC siblings. Called from cacheinfo_cpu_online() or
+ * Update the bottom sched_domain's llc_bytes for @cpus sharing a physical
+ * LLC. Called from cacheinfo_cpu_online() or
  * cacheinfo_cpu_pre_down() with cpu hotplug lock held.
  *
  * Note: get_effective_llc_bytes() returns 0 on PowerPC.
@@ -996,17 +996,13 @@ void sched_cache_active_set(void)
  * and does not populates the per-CPU struct cpu_cacheinfo array
  * that get_cpu_cacheinfo_llc() reads.
  */
-void sched_update_llc_bytes(unsigned int cpu)
+void sched_update_llc_bytes(const struct cpumask *cpus)
 {
 	struct sched_domain *sd, *sdp;
 	unsigned int i;
 
 	sched_domains_mutex_lock();
 
-	sdp = rcu_dereference_sched_domain(per_cpu(sd_llc, cpu));
-	if (!sdp)
-		goto unlock;
-
 	/*
 	 * ci->shared_cpu_map is built incrementally as CPUs come
 	 * online, so the first CPU in an LLC initially sees
@@ -1014,14 +1010,22 @@ void sched_update_llc_bytes(unsigned int cpu)
 	 * get_effective_llc_bytes().  Re-evaluating every LLC
 	 * sibling on each online event corrects this once the full
 	 * shared_cpu_map is known.
+	 *
+	 * The departing CPU's domains have already been detached when
+	 * cacheinfo removes it. Use the surviving cache siblings instead.
+	 * They may belong to different cpuset partitions, so use each CPU's
+	 * own LLC domain to scale its share of the physical cache.
 	 */
-	for_each_cpu(i, sched_domain_span(sdp)) {
+	for_each_cpu(i, cpus) {
+		sdp = rcu_dereference_sched_domain(per_cpu(sd_llc, i));
+		if (!sdp)
+			continue;
+
 		sd = rcu_dereference_sched_domain(cpu_rq(i)->sd);
 		if (sd)
 			sd->llc_bytes = get_effective_llc_bytes(i, sdp);
 	}
 
-unlock:
 	sched_domains_mutex_unlock();
 }
 
-- 
2.32.0

