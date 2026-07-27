Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B481427A
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 23:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785195267; cv=none; b=Q02yNl2JS0ggGCOiO6X9EuNxHycSggH2QR5mlCZxr92tG6WMOiVNXzWMd/JimEkOoy5xHcR96ghVwkc7iYYTh6BBqd0fOI0cYxeSr9PRDq4WzPSKkYIDWw4VoB8Tsn9C4hbuDi8W8bu7yL4Zxm9FyzyLb163WpppNHvIPNk6hig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785195267; c=relaxed/simple;
	bh=N0FhVbzXsU5+eduEClIPP/0VLvTdto3gkw2DPwV3WO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EVo9fniJFT9zIEvnoQsVUk8cWw76w18flyiAvrhUH8GlR08z4seGS5YldnfTGzXW/mdOIfFJkNpvPrQKdYXykQmyTRVZQPK9L/K+PCPx+nzzQuNWyYtsN7f7KmbtExeORQmkX0q0yKdpHORFnvb7OoRIDMjU/dJMI8tRAZPv9w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fP55EVTr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fP55EVTr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F0021F00A3D;
	Mon, 27 Jul 2026 23:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785195265;
	bh=9X4kShiEjCYNxCv98B36iT9PIztakZh80YbgKT5HX/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fP55EVTriq7VMtNkOeIOgsekEsvrMlD2FnIKKh0cFBd2/6/x+V7oJto85rWiOMWL2
	 tPb8/paBgZipoDwUmECRg/nXePoo8bV7ZUKhf91yAWSyb9cKv7FpeZKX9DGQxOe5zz
	 MW4LMx7DHHixk5hvi3orocQ8AoOoH0e191WLgbqBW1TIoK2+75ogvHuN2axIuT/D7m
	 kroHjLHAkFFRC4tV4cWHDEOvwWuDMh8s4GZwPl91ZWMlvyWlyHYyeZ6z0oLaMzE+p+
	 zBYvrLKcWIYGTyJjyUWLU3t1NnQPj1ILQ5XaPV7vOeprcdgK7iqOofo627EWLnyl4P
	 ak3BVlYVTUiUQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tony Luck <tony.luck@intel.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/6] x86,fs/resctrl: Rename some L3 specific functions
Date: Mon, 27 Jul 2026 19:34:17 -0400
Message-ID: <20260727233421.2423844-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727233421.2423844-1-sashal@kernel.org>
References: <2026072028-reverence-sandy-7415@gregkh>
 <20260727233421.2423844-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tony Luck <tony.luck@intel.com>

[ Upstream commit 9c214d10c50990c7a61b95887493df9ae713eec5 ]

With the arrival of monitor events tied to new domains associated with a
different resource it would be clearer if the L3 resource specific functions
are more accurately named.

Rename three groups of functions:

Functions that allocate/free architecture per-RMID MBM state information:
arch_domain_mbm_alloc()		-> l3_mon_domain_mbm_alloc()
mon_domain_free()		-> l3_mon_domain_free()

Functions that allocate/free filesystem per-RMID MBM state information:
domain_setup_mon_state()	-> domain_setup_l3_mon_state()
domain_destroy_mon_state()	-> domain_destroy_l3_mon_state()

Initialization/exit:
rdt_get_mon_l3_config()		-> rdt_get_l3_mon_config()
resctrl_mon_resource_init()	-> resctrl_l3_mon_resource_init()
resctrl_mon_resource_exit()	-> resctrl_l3_mon_resource_exit()

Ensure kernel-doc descriptions of these functions' return values are present
and correctly formatted.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/20251217172121.12030-1-tony.luck@intel.com
Stable-dep-of: 52fce648607e ("fs/resctrl: Fix use-after-free during unmount")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/resctrl/core.c     | 20 +++++++++++---------
 arch/x86/kernel/cpu/resctrl/internal.h |  2 +-
 arch/x86/kernel/cpu/resctrl/monitor.c  |  2 +-
 fs/resctrl/internal.h                  |  6 +++---
 fs/resctrl/monitor.c                   |  8 ++++----
 fs/resctrl/rdtgroup.c                  | 24 ++++++++++++------------
 6 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 0942344e2f7f75..f9025779292a84 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -363,7 +363,7 @@ static void ctrl_domain_free(struct rdt_hw_ctrl_domain *hw_dom)
 	kfree(hw_dom);
 }
 
-static void mon_domain_free(struct rdt_hw_l3_mon_domain *hw_dom)
+static void l3_mon_domain_free(struct rdt_hw_l3_mon_domain *hw_dom)
 {
 	int idx;
 
@@ -396,11 +396,13 @@ static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_ctrl_domain *
 }
 
 /**
- * arch_domain_mbm_alloc() - Allocate arch private storage for the MBM counters
+ * l3_mon_domain_mbm_alloc() - Allocate arch private storage for the MBM counters
  * @num_rmid:	The size of the MBM counter array
  * @hw_dom:	The domain that owns the allocated arrays
+ *
+ * Return:	0 for success, or -ENOMEM.
  */
-static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_l3_mon_domain *hw_dom)
+static int l3_mon_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_l3_mon_domain *hw_dom)
 {
 	size_t tsize = sizeof(*hw_dom->arch_mbm_states[0]);
 	enum resctrl_event_id eventid;
@@ -536,7 +538,7 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
 	ci = get_cpu_cacheinfo_level(cpu, RESCTRL_L3_CACHE);
 	if (!ci) {
 		pr_warn_once("Can't find L3 cache for CPU:%d resource %s\n", cpu, r->name);
-		mon_domain_free(hw_dom);
+		l3_mon_domain_free(hw_dom);
 		return;
 	}
 	d->ci_id = ci->id;
@@ -548,8 +550,8 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
 
 	arch_mon_domain_online(r, d);
 
-	if (arch_domain_mbm_alloc(r->mon.num_rmid, hw_dom)) {
-		mon_domain_free(hw_dom);
+	if (l3_mon_domain_mbm_alloc(r->mon.num_rmid, hw_dom)) {
+		l3_mon_domain_free(hw_dom);
 		return;
 	}
 
@@ -559,7 +561,7 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
 	if (err) {
 		list_del_rcu(&d->hdr.list);
 		synchronize_rcu();
-		mon_domain_free(hw_dom);
+		l3_mon_domain_free(hw_dom);
 	}
 }
 
@@ -650,7 +652,7 @@ static void domain_remove_cpu_mon(int cpu, struct rdt_resource *r)
 		resctrl_offline_mon_domain(r, d);
 		list_del_rcu(&d->hdr.list);
 		synchronize_rcu();
-		mon_domain_free(hw_dom);
+		l3_mon_domain_free(hw_dom);
 
 		return;
 	}
@@ -897,7 +899,7 @@ static __init bool get_rdt_mon_resources(void)
 	if (!ret)
 		return false;
 
-	return !rdt_get_mon_l3_config(r);
+	return !rdt_get_l3_mon_config(r);
 }
 
 static __init void __check_quirks_intel(void)
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 5b3ccebdd39c9b..6c9e75440c10eb 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -211,7 +211,7 @@ union l3_qos_abmc_cfg {
 
 void rdt_ctrl_update(void *arg);
 
-int rdt_get_mon_l3_config(struct rdt_resource *r);
+int rdt_get_l3_mon_config(struct rdt_resource *r);
 
 bool rdt_cpu_has(int flag);
 
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index d917a61b4e4d2f..9fc3adb4b232ca 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -423,7 +423,7 @@ static __init int snc_get_config(void)
 	return ret;
 }
 
-int __init rdt_get_mon_l3_config(struct rdt_resource *r)
+int __init rdt_get_l3_mon_config(struct rdt_resource *r)
 {
 	unsigned int mbm_offset = boot_cpu_data.x86_cache_mbm_width_offset;
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 73cc4e9d5e810d..2b7be96d3db84f 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -355,7 +355,9 @@ int alloc_rmid(u32 closid);
 
 void free_rmid(u32 closid, u32 rmid);
 
-void resctrl_mon_resource_exit(void);
+int resctrl_l3_mon_resource_init(void);
+
+void resctrl_l3_mon_resource_exit(void);
 
 void mon_event_count(void *info);
 
@@ -365,8 +367,6 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 		    struct rdt_l3_mon_domain *d, struct rdtgroup *rdtgrp,
 		    cpumask_t *cpumask, int evtid, int first);
 
-int resctrl_mon_resource_init(void);
-
 void mbm_setup_overflow_handler(struct rdt_l3_mon_domain *dom,
 				unsigned long delay_ms,
 				int exclude_cpu);
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 9f0a863abc0d2d..fcc155eb5cac32 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -1758,7 +1758,7 @@ ssize_t mbm_L3_assignments_write(struct kernfs_open_file *of, char *buf,
 }
 
 /**
- * resctrl_mon_resource_init() - Initialise global monitoring structures.
+ * resctrl_l3_mon_resource_init() - Initialise global monitoring structures.
  *
  * Allocate and initialise global monitor resources that do not belong to a
  * specific domain. i.e. the rmid_ptrs[] used for the limbo and free lists.
@@ -1767,9 +1767,9 @@ ssize_t mbm_L3_assignments_write(struct kernfs_open_file *of, char *buf,
  * Resctrl's cpuhp callbacks may be called before this point to bring a domain
  * online.
  *
- * Returns 0 for success, or -ENOMEM.
+ * Return: 0 for success, or -ENOMEM.
  */
-int resctrl_mon_resource_init(void)
+int resctrl_l3_mon_resource_init(void)
 {
 	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
 	int ret;
@@ -1819,7 +1819,7 @@ int resctrl_mon_resource_init(void)
 	return 0;
 }
 
-void resctrl_mon_resource_exit(void)
+void resctrl_l3_mon_resource_exit(void)
 {
 	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
 
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 207139a9072ed4..e9dcfda6f67fc9 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -4170,7 +4170,7 @@ static void rdtgroup_setup_default(void)
 	mutex_unlock(&rdtgroup_mutex);
 }
 
-static void domain_destroy_mon_state(struct rdt_l3_mon_domain *d)
+static void domain_destroy_l3_mon_state(struct rdt_l3_mon_domain *d)
 {
 	int idx;
 
@@ -4218,13 +4218,13 @@ void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_l3_mon_domain
 		cancel_delayed_work(&d->cqm_limbo);
 	}
 
-	domain_destroy_mon_state(d);
+	domain_destroy_l3_mon_state(d);
 
 	mutex_unlock(&rdtgroup_mutex);
 }
 
 /**
- * domain_setup_mon_state() -  Initialise domain monitoring structures.
+ * domain_setup_l3_mon_state() -  Initialise domain monitoring structures.
  * @r:	The resource for the newly online domain.
  * @d:	The newly online domain.
  *
@@ -4232,11 +4232,11 @@ void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_l3_mon_domain
  * Called when the first CPU of a domain comes online, regardless of whether
  * the filesystem is mounted.
  * During boot this may be called before global allocations have been made by
- * resctrl_mon_resource_init().
+ * resctrl_l3_mon_resource_init().
  *
- * Returns 0 for success, or -ENOMEM.
+ * Return: 0 for success, or -ENOMEM.
  */
-static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_l3_mon_domain *d)
+static int domain_setup_l3_mon_state(struct rdt_resource *r, struct rdt_l3_mon_domain *d)
 {
 	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
 	size_t tsize = sizeof(*d->mbm_states[0]);
@@ -4298,7 +4298,7 @@ int resctrl_online_mon_domain(struct rdt_resource *r, struct rdt_l3_mon_domain *
 
 	mutex_lock(&rdtgroup_mutex);
 
-	err = domain_setup_mon_state(r, d);
+	err = domain_setup_l3_mon_state(r, d);
 	if (err)
 		goto out_unlock;
 
@@ -4413,13 +4413,13 @@ int resctrl_init(void)
 
 	thread_throttle_mode_init();
 
-	ret = resctrl_mon_resource_init();
+	ret = resctrl_l3_mon_resource_init();
 	if (ret)
 		return ret;
 
 	ret = sysfs_create_mount_point(fs_kobj, "resctrl");
 	if (ret) {
-		resctrl_mon_resource_exit();
+		resctrl_l3_mon_resource_exit();
 		return ret;
 	}
 
@@ -4454,7 +4454,7 @@ int resctrl_init(void)
 
 cleanup_mountpoint:
 	sysfs_remove_mount_point(fs_kobj, "resctrl");
-	resctrl_mon_resource_exit();
+	resctrl_l3_mon_resource_exit();
 
 	return ret;
 }
@@ -4490,7 +4490,7 @@ static bool resctrl_online_domains_exist(void)
  * When called by the architecture code, all CPUs and resctrl domains must be
  * offline. This ensures the limbo and overflow handlers are not scheduled to
  * run, meaning the data structures they access can be freed by
- * resctrl_mon_resource_exit().
+ * resctrl_l3_mon_resource_exit().
  *
  * After resctrl_exit() returns, the architecture code should return an
  * error from all resctrl_arch_ functions that can do this.
@@ -4517,5 +4517,5 @@ void resctrl_exit(void)
 	 * it can be used to umount resctrl.
 	 */
 
-	resctrl_mon_resource_exit();
+	resctrl_l3_mon_resource_exit();
 }
-- 
2.53.0

