Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046639;
	b=smM4fgRSOEGcn/JBmmb7JwzHILbqK7Hh+57YsgYv9zkFUNY73YT8bE2+ybVMIUoeuBwt
	 tOaQRP0IjWht7cV+pA5fuuFKd+qJklp4/F1r5AhEO84ptMd6XIsMAy0h3EcxSCnqf16LU
	 dP4uTbNs29UwsQPMPRTyWTTNc6p8B2QVgh4/XTRPAsxj/7hlsPSH5nmbclF311h0z5P+M
	 ZLtcGwRtdeHJoXKur3q8h2zbomkGdC+7f31JH0mHrxVIMhQ2ABKK9kLEYTA8yZjHaEMwC
	 eWc4u5h8MZXElLqw8W2bNvCyUVQ43Ch860JQ22vFi6vJtaVWaToR0PUKPrF/7ragSCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046639;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=pVYlmcCQm2g16fvB959Vee6mQ8yltBMvT38NJEwDTDw=;
	b=CmSvAp0yC5lw2Mw4U8GPe5msi1GO3cvaIZYh2DuHo+LaCj8o1gQCFsCevfNhK0y8pIAP
	 l47sET9112FuEGJW2ONq6u3Nui+gW2cO/9BYcx8Ow+OTeNKAKDFLEmCKUf31pcq17IM5D
	 Rd9hJ0VTU+WgKpLfSKLQz4t0Vrgcz20DrrRZjWqYfFPF8Rc7qSRBX36fh+8VDvuDjCn+c
	 c3McumO1/59aPMsJQEJGTugPkUWa6aIltVx4FUT05SwrbtQpcMWe45S2RcB7mO3SSbWa/
	 DGIu/qSpjXf+H9EQxZurmErISvpdSDYpEZwBkx0D85u8cO/lwlBLcLMuO13xGfJPtVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z7TCIORB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39FD60A5BC1
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z7TCIORB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C314B1F008AB;
	Sat,  7 Nov 2026 10:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046638;
	bh=pVYlmcCQm2g16fvB959Vee6mQ8yltBMvT38NJEwDTDw=;
	h=From:To:Cc:Subject:Date;
	b=Z7TCIORBzOPyzvoktehYO0JmuoYHfkYlH536FzS9kwq1BNwQ1FzOLBk9xKGQ0bCD1
	 tAWEjOvWppt3rCcdDUrkxMb7gRTthEhPRBu8H+40xncEoZwll8xys69DlcOx1hmxRu
	 UYQ4w4PRHjHwm7Gfz7X6r1OMOy0VscdcqXkdsv3zMmLWdzI+9gsDVgBVvN1rqIorLA
	 lNlY45DPJAtl5sF2sb5PSFmuQ8vhEmeGleomB/kGl//WBpjKvhujnHFqtsv2KYFNl0
	 4NOa98eU5c6UK2pUOgoqk1mnXqPPWGMiDt2z9dScD30Cha8wN1x2IH758kT/rp8x1R
	 fKJrr2hVC5gKw==
From: Sasha Levin <sashal@kernel.org>
To: christian.loehle@arm.com,
	sumitg@nvidia.com,
	rafael.j.wysocki@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ACPI: CPPC: Accept requests to retain immutable autonomous selection" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:17:16 -0500
Message-ID: <20261107051716-failed-6.12-4bcc60d326c5@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 4bcc60d326c5acaa28c5913259decb22a33a83a1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051716-failed-6.12-4bcc60d326c5@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 4bcc60d326c5acaa28c5913259decb22a33a83a1 Mon Sep 17 00:00:00 2001
From: Christian Loehle <christian.loehle@arm.com>
Date: Wed, 16 Sep 2026 17:28:03 +0100
Subject: [PATCH] ACPI: CPPC: Accept requests to retain immutable autonomous
 selection

ACPI permits Autonomous Selection Enable to be Integer 1 when the platform
always selects performance autonomously. cppc_get_auto_sel() returns that
value, but cppc_set_auto_sel() rejects the Integer even when asked to keep
autonomous selection enabled. AMD shared-memory initialization consequently
fails in active or guided mode after successfully reading the capability.

Accept a request to keep this immutable field enabled without issuing a
register access. Expose the immutable encoding to callers, separately from
the current value of a writable register.

Before an AMD shared-memory transition to passive mode, reject immutable
autonomous selection on any present CPU. Otherwise a guided-to-passive
transition ignores the failed disable and reports the wrong mode, while
active-to-passive unregisters the working driver before passive policy
initialization fails. Check under the driver mode lock before invoking
either transition, including known offline CPUs.

Serialize this capability query with descriptor publication and removal.
ACPI processor removal drops the descriptor before taking the CPU hotplug
write lock, so the caller's cpus_read_lock() alone cannot protect the
lookup. Unpublish under the same mutex before releasing a descriptor,
including when adding its kobject fails.

The cppc-cpufreq auto_select attribute can also request one while
autonomous selection is already enabled. If the subsequent bounds update
fails, its rollback requests zero and clears the cached mode regardless
of the previous state. For an immutable field the disable request fails,
leaving the cached mode wrong. Save and restore the previous mode instead.
This also avoids disabling an already-enabled writable control on that
error path.

Fixes: c984f5d5d45b ("ACPI: CPPC: Add auto select register read/write support")
Fixes: ea3db45ae476 ("cpufreq: cppc: Update MIN_PERF/MAX_PERF in target callbacks")
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
Tested-by: Sumit Gupta <sumitg@nvidia.com>
Link: https://patch.msgid.link/20260916162805.1039247-19-christian.loehle@arm.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/cppc_acpi.c       | 42 +++++++++++++++++++++++++++++++---
 drivers/cpufreq/amd-pstate.c   | 21 +++++++++++++----
 drivers/cpufreq/cppc_cpufreq.c |  5 ++--
 include/acpi/cppc_acpi.h       |  7 ++++++
 4 files changed, 65 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 96a94df242312..80e2e6b32ce35 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -100,6 +100,15 @@ static DEFINE_PER_CPU(int, cpu_pcc_subspace_idx);
  */
 static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
 
+/* Protect immutable capability queries against descriptor removal. */
+static DEFINE_MUTEX(cpc_desc_lock);
+
+static void cpc_set_desc(unsigned int cpu, struct cpc_desc *desc)
+{
+	guard(mutex)(&cpc_desc_lock);
+	per_cpu(cpc_desc_ptr, cpu) = desc;
+}
+
 struct cpc_sysmem_node {
 	struct rb_node rb;
 	u64 subtree_last;
@@ -2314,12 +2323,12 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 	}
 
 	/* Plug PSD data into this CPU's CPC descriptor. */
-	per_cpu(cpc_desc_ptr, pr->id) = cpc_ptr;
+	cpc_set_desc(pr->id, cpc_ptr);
 
 	ret = kobject_init_and_add(&cpc_ptr->kobj, &cppc_ktype, &cpu_dev->kobj,
 			"acpi_cppc");
 	if (ret) {
-		per_cpu(cpc_desc_ptr, pr->id) = NULL;
+		cpc_set_desc(pr->id, NULL);
 		cpc_unregister_non_mmio_desc(cpc_ptr);
 		cpc_unregister_sysmem_desc(cpc_ptr);
 		kobject_put(&cpc_ptr->kobj);
@@ -2363,7 +2372,7 @@ void acpi_cppc_processor_exit(struct acpi_processor *pr)
 	}
 
 	pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, pr->id);
-	per_cpu(cpc_desc_ptr, pr->id) = NULL;
+	cpc_set_desc(pr->id, NULL);
 	kobject_del(&cpc_ptr->kobj);
 	cpc_unregister_non_mmio_desc(cpc_ptr);
 	cpc_unregister_sysmem_desc(cpc_ptr);
@@ -2766,6 +2775,11 @@ static int cppc_set_reg_val(int cpu, enum cppc_regs reg_idx, u64 val)
 
 	reg = &cpc_desc->cpc_regs[reg_idx];
 
+	/* Integer 1 describes autonomous selection that is always enabled. */
+	if (reg_idx == AUTO_SEL_ENABLE && reg->type == ACPI_TYPE_INTEGER &&
+	    reg->cpc_entry.int_value == 1)
+		return val == 1 ? 0 : -EOPNOTSUPP;
+
 	/* if a register is writeable, it must be a buffer and not null */
 	if (!cpc_is_writable(reg)) {
 		pr_debug("CPC register is not supported\n");
@@ -3310,6 +3324,28 @@ int cppc_get_auto_sel(int cpu, bool *enable)
 }
 EXPORT_SYMBOL_GPL(cppc_get_auto_sel);
 
+/**
+ * cppc_auto_sel_is_immutable - Check for always-enabled autonomous selection.
+ * @cpu: CPU whose _CPC descriptor to check.
+ *
+ * Context: Process context.
+ * Return: true for Integer 1, false for a register or an absent descriptor.
+ */
+bool cppc_auto_sel_is_immutable(int cpu)
+{
+	struct cpc_desc *cpc_desc;
+	struct cpc_register_resource *reg;
+
+	guard(mutex)(&cpc_desc_lock);
+	cpc_desc = per_cpu(cpc_desc_ptr, cpu);
+	if (!cpc_desc)
+		return false;
+
+	reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
+	return reg->type == ACPI_TYPE_INTEGER && reg->cpc_entry.int_value == 1;
+}
+EXPORT_SYMBOL_GPL(cppc_auto_sel_is_immutable);
+
 /**
  * cppc_set_auto_sel - Write autonomous selection register.
  * @cpu    : CPU to which to write register.
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 6ee2d43b7b952..0a8b1aaa26600 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1794,7 +1794,7 @@ EXPORT_SYMBOL_FOR_PSTATE_UT(amd_pstate_get_status);
 
 int amd_pstate_update_status(const char *buf, size_t size)
 {
-	int mode_idx;
+	int cpu, mode_idx;
 
 	if (size > strlen("passive") || size < strlen("active"))
 		return -EINVAL;
@@ -1803,12 +1803,23 @@ int amd_pstate_update_status(const char *buf, size_t size)
 	if (mode_idx < 0)
 		return mode_idx;
 
-	if (mode_state_machine[cppc_state][mode_idx]) {
-		guard(mutex)(&amd_pstate_driver_lock);
-		return mode_state_machine[cppc_state][mode_idx](mode_idx);
+	guard(mutex)(&amd_pstate_driver_lock);
+
+	if (!mode_state_machine[cppc_state][mode_idx])
+		return 0;
+
+	if (mode_idx == AMD_PSTATE_PASSIVE &&
+	    !cpu_feature_enabled(X86_FEATURE_CPPC)) {
+		guard(cpus_read_lock)();
+
+		/* Check offline CPUs too, before changing or removing the driver. */
+		for_each_present_cpu(cpu) {
+			if (cppc_auto_sel_is_immutable(cpu))
+				return -EOPNOTSUPP;
+		}
 	}
 
-	return 0;
+	return mode_state_machine[cppc_state][mode_idx](mode_idx);
 }
 EXPORT_SYMBOL_FOR_PSTATE_UT(amd_pstate_update_status);
 
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index af46f913e907a..9dde24d3e6455 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -882,6 +882,7 @@ static ssize_t store_auto_select(struct cpufreq_policy *policy,
 				 const char *buf, size_t count)
 {
 	struct cppc_cpudata *cpu_data = policy->driver_data;
+	bool old_auto_sel = cpu_data->perf_ctrls.auto_sel;
 	bool val;
 	int ret;
 
@@ -910,8 +911,8 @@ static ssize_t store_auto_select(struct cpufreq_policy *policy,
 		if (ret) {
 			cpu_data->perf_ctrls.min_perf = old_min_perf;
 			cpu_data->perf_ctrls.max_perf = old_max_perf;
-			cppc_set_auto_sel(policy->cpu, false);
-			cpu_data->perf_ctrls.auto_sel = false;
+			cppc_set_auto_sel(policy->cpu, old_auto_sel);
+			cpu_data->perf_ctrls.auto_sel = old_auto_sel;
 			return ret;
 		}
 	}
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 4b5d94f853dc7..3f0005abac648 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -197,6 +197,7 @@ extern int cppc_set_epp(int cpu, u64 epp_val);
 extern int cppc_get_auto_act_window(int cpu, u64 *auto_act_window);
 extern int cppc_set_auto_act_window(int cpu, u64 auto_act_window);
 extern int cppc_get_auto_sel(int cpu, bool *enable);
+bool cppc_auto_sel_is_immutable(int cpu);
 extern int cppc_set_auto_sel(int cpu, bool enable);
 extern int cppc_get_perf_limited(int cpu, u64 *perf_limited);
 extern int cppc_set_perf_limited(int cpu, u64 bits_to_clear);
@@ -298,6 +299,12 @@ static inline int cppc_get_auto_sel(int cpu, bool *enable)
 {
 	return -EOPNOTSUPP;
 }
+
+static inline bool cppc_auto_sel_is_immutable(int cpu)
+{
+	return false;
+}
+
 static inline int cppc_set_auto_sel(int cpu, bool enable)
 {
 	return -EOPNOTSUPP;
-- 
2.53.0




