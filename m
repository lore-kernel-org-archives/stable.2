Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FA64C77D9;
	Mon,  5 Oct 2026 18:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791224681; cv=none; b=uSuVZyaI6frWOFTq8Lkp3PNU7Pui3MtJGYADCsLUvmvb3BE6nvmg2NUcC1zOqaKeJw0wdAy824JulfHqtBRHGogBdMy9nLmxL6Xb+pP22E4HnpAog4grltYxv/M+mcg/karUiQ7g/oM5OyPkwrdinRV+X+dAGJbqkXMSVQnRcd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791224681; c=relaxed/simple;
	bh=/ZkIzXTZ/U3WUVpARaPAN9lkE2XuhDzDEuewuc8p0YQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JI2+/3vc+gFP9s6bg8xC1hlNyjqzMcXKOAuo2jhCXiZV4GpeXATFhPrFst8Ca1KLKpLuTZ7Apk/T8/F1f+kFV881Uv5JWjWUbB7ZVY3NWrxw+fWb/q0JIbebMrT+F5TLZ5TDW3jQt0OWs/jQ8u/4SCUfXcielbRy8u4xNPbvFGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YdpRQqnW; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YdpRQqnW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791224680; x=1822760680;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/ZkIzXTZ/U3WUVpARaPAN9lkE2XuhDzDEuewuc8p0YQ=;
  b=YdpRQqnWaVZMQpy4lBuwDZZy7unQlryxPxVhNmBeQBColgeHOYa3Bz6L
   7LSWZC1tQqcORfe+rmGgqUGSvz8F7m3p2NZvlXhpWW6HIZoe1LAH+7Yw6
   VtYe/6vEsYWlmhg+YV18GlANSoul63FWw3QKK3dgYJ9v8R3AO02gM9ouL
   s/L9puJKoSdTVOHuFSNODNTPuiOlGj3VGvACqkCjFKlG67eQ9YHsbiBQR
   Gn2zWo7Icw7YTEecN1TPg07zmqcIkC6hDAk3Wo72GWnC3O9KbfR3d5d3G
   SJqyddb08g/DAr/jaPj0IkpGrPzp5/WoNLViM9vyQuHIoo8NDdrPQ3gfl
   g==;
X-CSE-ConnectionGUID: X+IFxWdnTXaybkxjcr3niw==
X-CSE-MsgGUID: uyCa1shCRo2ueU1JhZmHWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="91928474"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="91928474"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 11:24:39 -0700
X-CSE-ConnectionGUID: WtzCAZR/R6esydTDTcl3Wg==
X-CSE-MsgGUID: 7Iy8r0ZrQgyacTGiT4nrkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="284785264"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by fmviesa003.fm.intel.com with ESMTP; 05 Oct 2026 11:24:38 -0700
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
Subject: [PATCH v2] sched/cache: Honor asym packing over cache aware scheduling on hybrid systems
Date: Mon,  5 Oct 2026 11:29:53 -0700
Message-Id: <77ceef1e51b895760dc5f6c9cde985a1679545b5.1791224900.git.tim.c.chen@linux.intel.com>
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
Tested-by: Klaus Kusche <klaus.kusche@computerix.info>
Tested-by: Ricardo Neri <ricardo.neri@intel.com>
Cc: stable@vger.kernel.org # 7.2.x
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---

Notes:
    v2: Ensure asym packing condition of idle CPU is fulfilled in
    can_migrate_llc_task() when bypassing LLC check (Kayra Cizmeci).
    v2 tested by Ricardo and Klaus offline.
    v1 link: https://lore.kernel.org/lkml/221f8b0345328c4b26b65daff4d3eec56a32b06d.1790617047.git.tim.c.chen@linux.intel.com/

 kernel/sched/fair.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 57360f5cdde4f..0301e27be35f5 100644
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
@@ -12154,6 +12160,15 @@ static inline bool llc_balance(struct lb_env *env, struct sg_lb_stats *sgs,
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
@@ -13569,12 +13584,12 @@ static int need_active_balance(struct lb_env *env)
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

