Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D2623C4FA
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 22:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783981067; cv=none; b=nh0RbYx7GUFMXda/Zj+mwQJIsr/R1ErYF/nlA2P7eedm3VLRco4Fw/cm5HBMiwBiv4/mRjV7OYiGUAVCJVd2pxC01aupovBSTnThusiWQJrVude3oqGtSGoRFbVcnmeKmdMhnvyL4reXkXnyMCVhYnUrbapP1sfs8XLyB0Bmzww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783981067; c=relaxed/simple;
	bh=t0GHsDLSNShJvqygbOHTPQWtY0ZS7+cQq22zIXlTmaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RjM5iJFWac4l8tT0GuSqVBt8skZWa0Ip9MA1w2cteLEMF7rk/UOBzfE7G71OihsX9ESs8CPUtgyr/eFUlrs4dXlqM1wvIeyVcYYPrDALZIGA8Sq46ExlmveYTIyLJHq53kFQU/CFDmmpZtYwgdfq8iZJyOWEAF1b8KKgfo0UcXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LLLzGMm1; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LLLzGMm1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783981065; x=1815517065;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t0GHsDLSNShJvqygbOHTPQWtY0ZS7+cQq22zIXlTmaM=;
  b=LLLzGMm1i6qizOeDAJmeXlcxe+IAQ5Gl7MdaxlMKnwfAR/oQZ7aEG1dp
   Mznlw+CqyAN+TubEoB5NKKfsBq/ml5fkEW+AjcnFB6UeezCX33SNEwB32
   yIbbr1Od/2oH8h5YObImPto22RkqdOOGTwE3ScgJnJdD3QIIT2x+9kATx
   JJm1sbCN73qA9JeZ+Rag92lB4/h4RYsTOSUQC4A/tE1IpnaZ7EyhAu0MB
   rL1LpMKIbY2Qf60zAFrdk9tzX7nk1k9UoSeKKK2THYDKjQw7JGJ5KF1g6
   7wsxvwrq4M4JwbIiGGcfaFIw0GmcwKFCaG2y1R0WmaNnDw5gycF+lwt6w
   g==;
X-CSE-ConnectionGUID: TH4R3nz2SWOsKVccH5yGtQ==
X-CSE-MsgGUID: ie8gAK01TsmvZueVghcDCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="83717112"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="83717112"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 15:17:44 -0700
X-CSE-ConnectionGUID: S4Baa1sVSROIzgBfEvwc+Q==
X-CSE-MsgGUID: 8oWyIduSQUKGaMxMdNEhAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="254550435"
Received: from rchatre-desk1.jf.intel.com ([10.165.154.99])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 15:17:44 -0700
From: Reinette Chatre <reinette.chatre@intel.com>
To: stable@vger.kernel.org
Cc: bp@alien8.de,
	sashiko-bot@kernel.org,
	stable@kernel.org,
	reinette.chatre@intel.com
Subject: [PATCH 6.18.y] x86,fs/resctrl: Prevent out-of-bounds access while offlining CPU when SNC enabled
Date: Mon, 13 Jul 2026 15:17:37 -0700
Message-ID: <9a207cda45a207e0b38d2b51bf3b818a6983cece.1783980699.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026071356-onboard-immortal-5433@gregkh>
References: <2026071356-onboard-immortal-5433@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit fc16126cc11d9f507130bf84ab137ee0938c900e upstream.

The architecture updates the cpu_mask in a domain's header to track which
online CPUs are associated with the domain. When this mask becomes empty
the architecture initiates offline of the domain that includes calling
on resctrl fs to offline the domain. If it is a monitoring domain in
which LLC occupancy is tracked resctrl fs forces the limbo handler to
clear all busy RMID state associated with the domain.

The limbo handler always reads the current event value associated with a
busy RMID irrespective of it being checked as part of regular "is it still
busy" check or whether it will be forced released anyway. When reading an
RMID on a system with SNC enabled the "logical RMID" is converted to the
"physical RMID" and this conversion requires the NUMA node ID of the
resctrl monitoring domain that is in turn determined by querying the NUMA
node ID of any CPU belonging to the monitoring domain.

When the monitoring domain is going offline its cpu_mask is empty causing
the NUMA node ID query via cpu_to_node() to be done with "nr_cpu_ids" as
argument resulting in an out-of-bounds access.

Refactor the limbo handler to skip reading the RMID when the RMID will
just be forced to no longer be dirty in the domain anyway. Add a safety
check to the architecture's RMID reader to protect against this scenario.

Fixes: e13db55b5a0d ("x86/resctrl: Introduce snc_nodes_per_l3_cache")
Closes: https://sashiko.dev/#/patchset/cover.1780456704.git.reinette.chatre%40intel.com?part=9
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: <stable@kernel.org>
Link: https://patch.msgid.link/16137433df42f85013b2f7a53626795cbd6637b9.1781029125.git.reinette.chatre@intel.com
---
 arch/x86/kernel/cpu/resctrl/monitor.c |  8 +++++-
 fs/resctrl/monitor.c                  | 39 +++++++++++++++------------
 2 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index fe1a2aa53c16..4b2b539ddff9 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -243,14 +243,20 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
 			   u64 *val, void *ignored)
 {
 	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
-	int cpu = cpumask_any(&d->hdr.cpu_mask);
 	struct arch_mbm_state *am;
 	u64 msr_val;
 	u32 prmid;
+	int cpu;
 	int ret;
 
 	resctrl_arch_rmid_read_context_check();
 
+	if (cpumask_empty(&d->hdr.cpu_mask)) {
+		pr_warn_once("Domain %d has no CPUs\n", d->hdr.id);
+		return -EINVAL;
+	}
+
+	cpu = cpumask_any(&d->hdr.cpu_mask);
 	prmid = logical_rmid_to_physical_rmid(cpu, rmid);
 	ret = __rmid_read_phys(prmid, eventid, &msr_val);
 
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 572a9925bd6c..7012a75814ac 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -135,9 +135,9 @@ void __check_limbo(struct rdt_mon_domain *d, bool force_free)
 	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
 	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
 	struct rmid_entry *entry;
+	bool rmid_dirty = true;
 	u32 idx, cur_idx = 1;
 	void *arch_mon_ctx;
-	bool rmid_dirty;
 	u64 val = 0;
 
 	arch_mon_ctx = resctrl_arch_mon_ctx_alloc(r, QOS_L3_OCCUP_EVENT_ID);
@@ -159,22 +159,27 @@ void __check_limbo(struct rdt_mon_domain *d, bool force_free)
 			break;
 
 		entry = __rmid_entry(idx);
-		if (resctrl_arch_rmid_read(r, d, entry->closid, entry->rmid,
-					   QOS_L3_OCCUP_EVENT_ID, &val,
-					   arch_mon_ctx)) {
-			rmid_dirty = true;
-		} else {
-			rmid_dirty = (val >= resctrl_rmid_realloc_threshold);
-
-			/*
-			 * x86's CLOSID and RMID are independent numbers, so the entry's
-			 * CLOSID is an empty CLOSID (X86_RESCTRL_EMPTY_CLOSID). On Arm the
-			 * RMID (PMG) extends the CLOSID (PARTID) space with bits that aren't
-			 * used to select the configuration. It is thus necessary to track both
-			 * CLOSID and RMID because there may be dependencies between them
-			 * on some architectures.
-			 */
-			trace_mon_llc_occupancy_limbo(entry->closid, entry->rmid, d->hdr.id, val);
+		if (!force_free) {
+			if (resctrl_arch_rmid_read(r, d, entry->closid,
+						   entry->rmid, QOS_L3_OCCUP_EVENT_ID,
+						   &val, arch_mon_ctx)) {
+				rmid_dirty = true;
+			} else {
+				rmid_dirty = (val >= resctrl_rmid_realloc_threshold);
+
+				/*
+				 * x86's CLOSID and RMID are independent numbers,
+				 * so the entry's CLOSID is an empty CLOSID
+				 * (X86_RESCTRL_EMPTY_CLOSID). On Arm the RMID
+				 * (PMG) extends the CLOSID (PARTID) space with
+				 * bits that aren't used to select the configuration.
+				 * It is thus necessary to track both CLOSID and
+				 * RMID because there may be dependencies between
+				 * them on some architectures.
+				 */
+				trace_mon_llc_occupancy_limbo(entry->closid, entry->rmid,
+							      d->hdr.id, val);
+			}
 		}
 
 		if (force_free || !rmid_dirty) {
-- 
2.54.0

