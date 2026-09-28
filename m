Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1183890E4;
	Mon, 28 Sep 2026 18:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620318; cv=none; b=she65QaEW8u4b8pJo0Cw5prLDLi4VHR/1+cyV8wFlYr0mRIKl+6Fzj2OVLzSTXAeffFNlZ3gDA9MO3SbTcwZbw0ihrPx1uMsK/OTOapePjNcIHfiP11RLCLu4Ku0/MWJvCkFBdd4sDly+s1/8HPhFt5DMtZOMm6gfFkD7cWcqvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620318; c=relaxed/simple;
	bh=JVypUUxs+lUsBPm6X6PBDEgxX0p1RR7e6NozMRHP/lM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p4uVG7I27yMVQrkskbAY+zXjAMfWOrV8hkSBFaSM4Uv4RmTGr4KsFnX7kp+13aYrG2z8u+NKY1VHHmb9sTCDDTgUor5iUpFTyuBAuH5MPJnRjUbLRx47dgYhqHVMmt5EzAPguoX5s4ArqwfhO3pHnTheI1DcBMhB6nzuKWQkVcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G/oyLUAz; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G/oyLUAz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790620317; x=1822156317;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JVypUUxs+lUsBPm6X6PBDEgxX0p1RR7e6NozMRHP/lM=;
  b=G/oyLUAzOMf158aCJNBPbwKIol0Btdidi4iN5R6ORL+B7WhTLF3pN75A
   sJ60FGIGsqEolYQmIYT3vrFo1H9IgBDOz4ytGEZQ/nlxZ9eJRNwNlADS/
   JnofTJ1VyHZc7YjzkhF4TwhSrvf2tS9puLfdISMIezF24lRlUVCQ8JPLS
   DGdPrke/gVgMoKhhUmcw5Tv6vSgRQBT53DFY9S7v0AcLr+MgzVQIritaO
   6+vili77vlyRDH3ELhyzw+c06u0fLoHmJIxOAhTxocs/xm8wPxiaTif4b
   noUYJIoAGpHLoyrX8M9ZferaihNDXCbRcUX6q4khBRnCOz2rkCmbnMSkh
   g==;
X-CSE-ConnectionGUID: BhLoiCtSSp+GZC+QrDmbnw==
X-CSE-MsgGUID: dBsSHsZSR2WWtZ+C4siVaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="91348543"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="91348543"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 11:31:55 -0700
X-CSE-ConnectionGUID: z6NjJOy1SM+zSr3mPEeXcw==
X-CSE-MsgGUID: XQg3q6BZSKmkTthDusIUnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="304631589"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by orviesa002.jf.intel.com with ESMTP; 28 Sep 2026 11:31:54 -0700
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Badole,
	Vishal <Vishal.Badole@amd.com>,
	linux-kernel@vger.kernel.org,
	"maintainer : X86 ARCHITECTURE" <x86@kernel.org>,
	platform-driver-x86@vger.kernel.org,
	K Prateek Nayak <KPrateek.Nayak@amd.com>,
	Ricardo Neri <ricardo.neri@intel.com>,
	stable@vger.kernel.org,
	Klaus Kusche <klaus.kusche@computerix.info>
Subject: [PATCH] sched/cache: Honor asym packing over cache aware scheduling on hybrid system
Date: Mon, 28 Sep 2026 11:37:08 -0700
Message-Id: <221f8b0345328c4b26b65daff4d3eec56a32b06d.1790617047.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A regression was reported on an AMD Ryzen AI HX 370 running a cache
intensive Clang full-LTO link. The little cores run at a much lower
frequency (3.3 GHz vs 5.1 GHz) and have only half of the L3 cache
(8 MB vs 16 MB), so pinning such a task to the little-core LLC hurts
twice, and full-LTO builds slow down dramatically compared to
pre-cache-aware-scheduling kernels.

Asym packing and cache aware scheduling express conflicting placement
strategy. Asym packing wants a task to run on the highest priority CPU,
whereas cache aware scheduling wants to co-locate the tasks of a process
on one LLC regardless of the priority of CPUs in that LLC.

When asym packing tries to migrate task to an empty
core that has higher priority than source cpu, let asym packing win.
Moving tasks to a higher performing idle core will buy more
performance than cache co-location.

Fixes: 23b2b5ccc45c ("sched/cache: Introduce helper functions to enforce LLC migration policy")
Reported-by: Klaus Kusche <klaus.kusche@computerix.info>
Closes: https://lore.kernel.org/lkml/2180ea5a-eb28-4152-8d4d-cd00b0c24b2e@computerix.info/
Tested-by: Klaus Kusche <klaus.kusche@computerix.info>
Tested-by: Ricardo Neri <ricardo.neri@intel.com>
Cc: stable@vger.kernel.org # 7.2.x
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/fair.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f265de8721dbd..31eb45efd063b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10823,6 +10823,8 @@ static inline bool task_misfits_asym_cpu(struct lb_env *env, struct task_struct
 	return false;
 }
 
+static inline bool sched_asym(struct sched_domain *sd, int dst_cpu, int src_cpu);
+
 /*
  * Check if task p can migrate from source LLC to
  * destination LLC in terms of cache aware load balance.
@@ -10847,6 +10849,10 @@ static enum llc_mig can_migrate_llc_task(struct lb_env *env,
 	if (cpu < 0 || cpus_share_cache(src_cpu, dst_cpu))
 		return mig_unrestricted;
 
+	/* Prioritize asym packing over cache awareness */
+	if (sched_asym(env->sd, dst_cpu, src_cpu))
+		return mig_unrestricted;
+
 	/* skip cache aware load balance for too many threads */
 	if (invalid_llc_nr(grp, p, dst_cpu) ||
 	    exceed_llc_capacity(grp, dst_cpu)) {
@@ -12043,6 +12049,15 @@ static inline bool llc_balance(struct lb_env *env, struct sg_lb_stats *sgs,
 	    sgs->group_misfit_task_load)
 		return false;
 
+	/*
+	 * On asym packing domains, if the destination CPU
+	 * has higher priority than all CPUs in the source group,
+	 * prioritize asym packing.
+	 */
+	if ((env->sd->flags & SD_ASYM_PACKING) &&
+	    sgs->group_asym_packing)
+		return false;
+
 	/*
 	 * Skip cache aware tagging if nr_balanced_failed is sufficiently high.
 	 * Threshold of cache_nice_tries is set to 1 higher than nr_balance_failed
@@ -13458,12 +13473,12 @@ static int need_active_balance(struct lb_env *env)
 {
 	struct sched_domain *sd = env->sd;
 
-	if (alb_break_llc(env))
-		return 0;
-
 	if (asym_active_balance(env))
 		return 1;
 
+	if (alb_break_llc(env))
+		return 0;
+
 	if (imbalanced_active_balance(env))
 		return 1;
 
-- 
2.32.0

