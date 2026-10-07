Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AE42673AA;
	Wed,  7 Oct 2026 17:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791393618; cv=none; b=WiEOx+F9dbtyFSldJDK7zQCwTntkRWiaO7cr+wIr3Wi/Mympt82qa4716Li65gzOZ7uamM20ILgztNowUWwe48H4fbuu/sLguVbcJW9/G/uF6ZKJvCVnOhLAfFovil98addof8PnZByXJPubImTkBFuVTKjcebimp7uh3D+Isn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791393618; c=relaxed/simple;
	bh=kqZVCWDHCL3wYn2PokaC9zYWyDD0jEm3l4gAd3MC55M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Fgs6Nb4+gOdOVZbyBH2o2htEsZI/3v+1lnIsb3qeLIVm2gw9c7+hrV72p0q5JekF1HwUeOu4JEsDssASIaHQm59NaN0IbDm0zxLv0Mv6OVZHxKRyUNhMrL0EaSW7Gwc1Mtq9Xo+Ddx+E2/9M8W0e2NBc0AzeQKCnxCaAoSKyy9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n406jqL3; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n406jqL3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791393616; x=1822929616;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kqZVCWDHCL3wYn2PokaC9zYWyDD0jEm3l4gAd3MC55M=;
  b=n406jqL3Pq2bZoiXw8t5hZ5QvJ8SdN9y7+VdI7zFnPJcgk94GkFFD5uj
   hwiwXxlKBVWkpFkCwwMbXQQVa3kbAFXPWvdtBIt9br2u7XmNQf6h/APyO
   3YMbjnVLLOqPPQipKwcgmIc9jwsFG7XKeAKL/+FJPW0wIz3RhXsFEU+mr
   5lV5ih5JT5RVqnP/ykEqzvWbiYsZGa43TYzijb1NVQDUQLA8X3Jrrewfx
   e0pJHQCX1a18HzVsuA7BaVYDh29167mk751OWNsaMv3JGyMJw4jPF+xk6
   EeoAYgx6RY6rr+z6+fyUQ4/vQjrsfyzG6apRPVQDib/8GxWAEboVkN26O
   w==;
X-CSE-ConnectionGUID: 3hG2QbSbR5mk7V92AstK0A==
X-CSE-MsgGUID: WS3AVdLtRqmrwEmFhniN0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="167995"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="167995"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 10:20:15 -0700
X-CSE-ConnectionGUID: 7dfyj4O+Seufqb6M4prOpw==
X-CSE-MsgGUID: p5imSpg5Ti2ZQiv8bAyk+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="285584557"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by fmviesa005.fm.intel.com with ESMTP; 07 Oct 2026 10:20:14 -0700
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Vishal Badole <Vishal.Badole@amd.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	platform-driver-x86@vger.kernel.org,
	K Prateek Nayak <KPrateek.Nayak@amd.com>,
	Ricardo Neri <ricardo.neri@intel.com>,
	Kayra Cizmeci <kayracizmeci@gmail.com>,
	stable@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Klaus Kusche <klaus.kusche@computerix.info>
Subject: [PATCH v3] sched/cache: Honor asym packing over cache aware scheduling on hybrid systems
Date: Wed,  7 Oct 2026 10:25:30 -0700
Message-Id: <b29badede27bb6bfb4a759e06754cb19657f0778.1791308631.git.tim.c.chen@linux.intel.com>
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
(8 MB vs 16 MB), so pinning such a task to the little-core LLC
hurts twice, and full-LTO builds slow down dramatically compared to
pre-cache-aware-scheduling kernels.

Asym packing and cache aware scheduling express conflicting placement
strategies. Asym packing wants a task to run on the highest priority CPU,
whereas cache aware scheduling wants to co-locate the tasks of a process
on one LLC regardless of the priority of CPUs in that LLC.

When asym packing tries to migrate task to an idle core that has higher
priority than source cpu, let asym packing win.  Moving tasks to a higher
performing idle core will buy more performance than cache co-location.

Prioritize asym packing over LLC balancing for regular and active load
balancing.

Fixes: 23b2b5ccc45c ("sched/cache: Introduce helper functions to enforce LLC migration policy")
Reported-by: Klaus Kusche <klaus.kusche@computerix.info>
Closes: https://lore.kernel.org/lkml/2180ea5a-eb28-4152-8d4d-cd00b0c24b2e@computerix.info/
Suggested-by: Kayra Cizmeci <kayracizmeci@gmail.com>
Reviewed-by: Kayra Cizmeci <kayracizmeci@gmail.com>
Tested-by: Klaus Kusche <klaus.kusche@computerix.info>
Tested-by: Ricardo Neri <ricardo.neri@intel.com>
Tested-by: Chen Yu <yu.c.chen@intel.com>
Cc: stable@vger.kernel.org # 7.2.x
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---

Notes:
    v3: Remove redundant SD_ASYM_PACKING check in llc_balance() (Kayra Cizmeci).
    Add Tested-by tag from Chen Yu and Reviewed-by tag from Kayra Cizmeci.
    Link v2:
    https://lore.kernel.org/lkml/77ceef1e51b895760dc5f6c9cde985a1679545b5.1791224900.git.tim.c.chen@linux.intel.com/

 kernel/sched/fair.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 57360f5cdde4f..e4906486a4fe9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10934,6 +10934,8 @@ static inline bool task_misfits_asym_cpu(struct lb_env *env, struct task_struct
 	return false;
 }
 
+static inline bool sched_asym(struct sched_domain *sd, int dst_cpu, int src_cpu);
+
 /*
  * Check if task p can migrate from source LLC to
  * destination LLC in terms of cache aware load balance.
@@ -10958,6 +10960,10 @@ static enum llc_mig can_migrate_llc_task(struct lb_env *env,
 	if (cpu < 0 || cpus_share_cache(src_cpu, dst_cpu))
 		return mig_unrestricted;
 
+	/* Prioritize asym packing to idle core over cache awareness */
+	if (env->idle && sched_asym(env->sd, dst_cpu, src_cpu))
+		return mig_unrestricted;
+
 	/* skip cache aware load balance for too many threads */
 	if (invalid_llc_nr(grp, p, dst_cpu) ||
 	    exceed_llc_capacity(grp, dst_cpu)) {
@@ -12154,6 +12160,14 @@ static inline bool llc_balance(struct lb_env *env, struct sg_lb_stats *sgs,
 	    sgs->group_misfit_task_load)
 		return false;
 
+	/*
+	 * On asym packing domains, if the destination CPU
+	 * has higher priority than all CPUs in the source group,
+	 * prioritize asym packing.
+	 */
+	if (sgs->group_asym_packing)
+		return false;
+
 	/*
 	 * Skip cache aware tagging if nr_balanced_failed is sufficiently high.
 	 * Threshold of cache_nice_tries is set to 1 higher than nr_balance_failed
@@ -13569,12 +13583,12 @@ static int need_active_balance(struct lb_env *env)
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

