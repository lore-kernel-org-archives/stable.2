Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794583932;
	b=sq35VWK6vZV1RxYoa6UTfGf3F9y9pXVk4+R9/nvJX0EQmGdcI2/g9v3VjuS09+KZQiHB
	 kkyMZ2kxMzH+R+8cv07fHQ9Yf7pqBpKzsFq+uH8qzoMtTL8V6w/TKFxccErRT+6WDN3Nx
	 cGTQ20b87mAuySKYxf7CbjGJbi1iJEeyzNz0jQpp2VUdViPjJPyqrhhBDCrYTG5TBMSgG
	 XimYQP5Ojca/RGeo6uSxnosAta6mTqFM6y08bcteeQWWjorqFpB0VcXU0gcl8xTq2gJZm
	 7OK0XSvwZV1LKXqPTOpJCAJ2Fp/7IfLJ54BWvwFNaqMh8o98gP84au4j4WeJhVZP4RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794583932;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=byaNFIxDc0yLJvvnyiohGpWdHajmmEbHEB8uy0kYt/U=;
	b=dlhtTCtuTgIHJmT8gL2egSU8KUCQNPKUfnUbqFohVTRas3I7f3CF4wcTKCP83gEeW5+s
	 Ns/aA9F4bqsyl7HK6zLr0kpCW/dNsmV6/ogPq9zXz4NjOSDUHhlTu7+wI45tj3xv2t3r4
	 XJChySUPV625KVYSr0cYSBbpSCTzY9Mp3kqlIPH0UkeJcj42sP/OD6e4lykID1SJdJR+i
	 kxM4u95ysL81h9i1WI9vSVyBs23aVDbAVf67AQGzUD8G/qz+prX3FrflQ9ua5kXM4gCgg
	 g2AxasjYLb067RmaooBcewIROOBpywG0A6Gi27esSsM5XmbSTtCW25q0DmZgPR4n+RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UAXzIBmR;
	arc=none smtp.remote-ip=95.215.58.13
Received: from mta1.migadu.com (out-13.mta1.migadu.com [95.215.58.13])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01941606A880
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 15:32:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01941606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UAXzIBmR
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=AeYslwx9sLnwOjyRTt6ZQKqeeZkxb6StbsiOnwsNjmw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794583930; v=1; x=1795188730;
 b=UAXzIBmRAIwCCzbP4RFPF6z47iTcnkOqH0yE98/fEFMBe59YJlWIibX9LSrCWxu+IrK8WEXB
 nfq8reIWkijx+DrOUOp7AYfLqQaPKQ8a3zj39g1RFSjV2RhYKiaTjsOZhFqg+sYu1hbHYZqI2uc
 l3BIIIODVtJmFvKnxXzqrV7U=
X-Envelope-To: stable@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 6d7785ec3fceb58b;
	Fri, 13 Nov 2026 15:32:09 +0000
X-Mizu-Trace-ID: 6d7785ec3fceb58b
X-Migadu-Flow: FLOW_OUT
From: Usama Arif <usama.arif@linux.dev>
To: peterz@infradead.org,
	mingo@redhat.com,
	vincent.guittot@linaro.org,
	kprateek.nayak@amd.com,
	arighi@nvidia.com,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	samuelcrossley@gmail.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	kas@kernel.org,
	riel@surriel.com
Cc: Usama Arif <usama.arif@linux.dev>,
	Arnav Aghav <aghav@meta.com>
Subject: [PATCH] Revert "sched/fair: Add SIS_UTIL support to select_idle_capacity()"
Date: Fri, 13 Nov 2026 07:31:57 -0800
Message-ID: <20261113153157.2495664-1-usama.arif@linux.dev>
X-Mailer: git-send-email 2.53.1
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

This reverts commit 61ea17a63719 ("sched/fair: Add SIS_UTIL support to
select_idle_capacity()").

That commit applied the SIS_UTIL scan budget to select_idle_capacity().
The early checks in select_idle_sibling() consider a few specific
candidates: the target, previous and recently used CPUs. If none is
selected, the asymmetric path calls select_idle_capacity() to search
the allowed domain. With SIS_UTIL enabled, a zero scan budget makes it
return -1 before that search. The caller then returns the selected
target, even if an unexamined CPU in the domain is idle and fits the
task.

The budget is derived from aggregate CFS utilization. High aggregate
utilization can coexist with idle CPUs when a task wakes.

On a 72-CPU NVIDIA grace arm64 server, small reported capacity differences
(1013-1024) within the single LLC activate asymmetric selection. Both
the reference and affected kernels were observed with a zero scan
hint. The reference kernel ignored it and still searched the domain.
A latency-sensitive, wakeup-heavy production workload saw its reported
minute p50 latencies average 129 ms on the reference kernel and 223 ms
on the affected kernel.

Disabling SIS_UTIL reduced the aggregate involuntary context switch
rate of worker main threads from 71.6k/s to 13.3k/s; re-enabling it
raised the rate to 73.7k/s. A five-minute disabled run also reduced
kernel CPU time per request by 10.9%. The available minute p50 samples
averaged 149 ms, compared with 241 ms before the trial.

These measurements come from disabling SIS_UTIL on the installed
kernel. The feature toggle also disables the symmetric scan limit and
shared scan-hint updates.

Restore the search of the allowed domain, retaining the capacity,
uclamp and SMT selection rules and their early returns. Domains with
no suitable idle CPU can again require a full scan, potentially increasing
scan CPU cost.

Reported-by: Arnav Aghav <aghav@meta.com>
Fixes: 61ea17a63719 ("sched/fair: Add SIS_UTIL support to select_idle_capacity()")
Cc: stable@vger.kernel.org
Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 kernel/sched/fair.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d4cc0caee6265..def5cda2e6bad 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9091,7 +9091,6 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 	int fits, best_fits = ASYM_IDLE_THREAD_MISFIT;
 	int cpu, best_cpu = -1;
 	struct cpumask *cpus;
-	int nr = INT_MAX;
 
 	cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
 	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
@@ -9100,28 +9099,10 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 	util_min = uclamp_eff_value(p, UCLAMP_MIN);
 	util_max = uclamp_eff_value(p, UCLAMP_MAX);
 
-	if (sched_feat(SIS_UTIL) && sd->shared) {
-		/*
-		 * Same nr_idle_scan hint as select_idle_cpu(), nr only limits
-		 * the scan when not preferring an idle core.
-		 */
-		nr = READ_ONCE(sd->shared->nr_idle_scan) + 1;
-		/* overloaded domain is unlikely to have idle cpu/core */
-		if (nr == 1)
-			return -1;
-	}
-
 	for_each_cpu_wrap(cpu, cpus, target) {
 		bool preferred_core = !has_idle_core || is_core_idle(cpu);
 		unsigned long cpu_cap = capacity_of(cpu);
 
-		/*
-		 * Stop when the nr_idle_scan is exhausted (mirrors
-		 * select_idle_cpu() logic).
-		 */
-		if (!has_idle_core && --nr <= 0)
-			return best_cpu;
-
 		if (!choose_idle_cpu(cpu, p))
 			continue;
 
-- 
2.53.1-Meta

