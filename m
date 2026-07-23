Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DC834029E
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 14:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784816366; cv=none; b=T2YNcMwe+t/GG7pDdAE+Z5VsNLeXAZajmQlqLjI9l1v2E+rZG5m7U9asG2ZJ83KPfOiHuj6lf8PgV2Ph9SzzgSezePZtkr1shZp5rse/8KKWn+M93x8eJim8QBPmrDjOXWEVLtkG8Bw44DD9E0gjWdjwPy4+CtWG504xgW2XjmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784816366; c=relaxed/simple;
	bh=FHQkHwJgeeMckE4F9Luveb5dPJRM3yBxCeG+zT714iA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g/MrotRg6MddWzJPAqblWBlq1u7J9dwpJPhG1Cu7QDItuB/Ax91Fb0mw7iI7XZ619rHyVqWzPw+i9hjxejsJKqjXl1v8JfuHUuSQVzg7Rl6fktdZTKmm9/h3QdhYXDTUrBc2WgboU0Wdje1HJ02gLwjDjW8NwPD3v/h0m6R7xiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C391F00A3E;
	Thu, 23 Jul 2026 14:19:22 +0000 (UTC)
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Richter <tmricht@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/5] s390/cpum_cf: remove in-kernel counting facility interface
Date: Thu, 23 Jul 2026 10:19:02 -0400
Message-ID: <20260723141904.3218096-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723141904.3218096-1-sashal@kernel.org>
References: <2026072026-chess-imitate-9c14@gregkh>
 <20260723141904.3218096-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Richter <tmricht@linux.ibm.com>

[ Upstream commit ea53e6995f45e857fd34e4fbfbd436b5457da5f7 ]

Commit 17bebcc68eee ("s390/cpum_cf: Add minimal in-kernel interface for
counter measurements") introduced a small in-kernel interface for CPU
Measurement counter facility.
There are no users of this interface, therefore remove it.

The following functions are removed:
 kernel_cpumcf_alert(),
 kernel_cpumcf_begin(),
 kernel_cpumcf_end(),
 kernel_cpumcf_avail()
there is no need for them anymore.
With the removal of function kernel_cpumcf_alert(), also remove
member alert in struct cpu_cf_events. Its purpose was to counter
measurement alert interrupts for the in-kernel interface.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Stable-dep-of: 49145bce5391 ("s390/perf_cpum_cf: Add missing array_index_nospec() to __hw_perf_event_init()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/include/asm/cpu_mcf.h        | 17 -----------------
 arch/s390/kernel/perf_cpum_cf.c        |  2 +-
 arch/s390/kernel/perf_cpum_cf_common.c | 24 ------------------------
 3 files changed, 1 insertion(+), 42 deletions(-)

diff --git a/arch/s390/include/asm/cpu_mcf.h b/arch/s390/include/asm/cpu_mcf.h
index 4b29c31c0e0435..88fc115ebfbe9e 100644
--- a/arch/s390/include/asm/cpu_mcf.h
+++ b/arch/s390/include/asm/cpu_mcf.h
@@ -67,7 +67,6 @@ static inline int ctr_stcctm(enum cpumf_ctr_set set, u64 range, u64 *dest)
 struct cpu_cf_events {
 	struct cpumf_ctr_info	info;
 	atomic_t		ctr_set[CPUMF_CTR_SET_MAX];
-	atomic64_t		alert;
 	u64			state;		/* For perf_event_open SVC */
 	u64			dev_state;	/* For /dev/hwctr */
 	unsigned int		flags;
@@ -80,25 +79,9 @@ struct cpu_cf_events {
 };
 DECLARE_PER_CPU(struct cpu_cf_events, cpu_cf_events);
 
-bool kernel_cpumcf_avail(void);
 int __kernel_cpumcf_begin(void);
-unsigned long kernel_cpumcf_alert(int clear);
 void __kernel_cpumcf_end(void);
 
-static inline int kernel_cpumcf_begin(void)
-{
-	if (!cpum_cf_avail())
-		return -ENODEV;
-
-	preempt_disable();
-	return __kernel_cpumcf_begin();
-}
-static inline void kernel_cpumcf_end(void)
-{
-	__kernel_cpumcf_end();
-	preempt_enable();
-}
-
 int cfset_online_cpu(unsigned int cpu);
 int cfset_offline_cpu(unsigned int cpu);
 #endif /* _ASM_S390_CPU_MCF_H */
diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index 3e6c46d9cd0851..fd9d07b3ee12e0 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -832,7 +832,7 @@ static int __init cpumf_pmu_init(void)
 {
 	int rc;
 
-	if (!kernel_cpumcf_avail())
+	if (!cpum_cf_avail())
 		return -ENODEV;
 
 	/* Setup s390dbf facility */
diff --git a/arch/s390/kernel/perf_cpum_cf_common.c b/arch/s390/kernel/perf_cpum_cf_common.c
index 4824e3461b5b3b..99523dc3fc8bb8 100644
--- a/arch/s390/kernel/perf_cpum_cf_common.c
+++ b/arch/s390/kernel/perf_cpum_cf_common.c
@@ -27,7 +27,6 @@ DEFINE_PER_CPU(struct cpu_cf_events, cpu_cf_events) = {
 		[CPUMF_CTR_SET_EXT]	= ATOMIC_INIT(0),
 		[CPUMF_CTR_SET_MT_DIAG] = ATOMIC_INIT(0),
 	},
-	.alert = ATOMIC64_INIT(0),
 	.state = 0,
 	.dev_state = 0,
 	.flags = 0,
@@ -67,9 +66,6 @@ static void cpumf_measurement_alert(struct ext_code ext_code,
 	if (alert & CPU_MF_INT_CF_MTDA)
 		pr_warn("CPU[%i] MT counter data was lost\n",
 			smp_processor_id());
-
-	/* store alert for special handling by in-kernel users */
-	atomic64_or(alert, &cpuhw->alert);
 }
 
 #define PMC_INIT      0
@@ -94,12 +90,6 @@ static void cpum_cf_setup_cpu(void *flags)
 	lcctl(0);
 }
 
-bool kernel_cpumcf_avail(void)
-{
-	return cpum_cf_initalized;
-}
-EXPORT_SYMBOL(kernel_cpumcf_avail);
-
 /* Initialize the CPU-measurement counter facility */
 int __kernel_cpumcf_begin(void)
 {
@@ -112,20 +102,6 @@ int __kernel_cpumcf_begin(void)
 }
 EXPORT_SYMBOL(__kernel_cpumcf_begin);
 
-/* Obtain the CPU-measurement alerts for the counter facility */
-unsigned long kernel_cpumcf_alert(int clear)
-{
-	struct cpu_cf_events *cpuhw = this_cpu_ptr(&cpu_cf_events);
-	unsigned long alert;
-
-	alert = atomic64_read(&cpuhw->alert);
-	if (clear)
-		atomic64_set(&cpuhw->alert, 0);
-
-	return alert;
-}
-EXPORT_SYMBOL(kernel_cpumcf_alert);
-
 /* Release the CPU-measurement counter facility */
 void __kernel_cpumcf_end(void)
 {
-- 
2.53.0

