Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045805;
	b=qMjaUFMDrZGFi6BuvmqqIl+3mm2TAgoQZAatPoJOUoxgX0onFacJ5cxI/t8Q9Hf0L4Aq
	 j9dEUtye5FFtZNDRBpM8TwtrKhley5b4EbSsI6rLFzB0B+XYPsYHtqfhAtA7L9K9bFiUl
	 Q56enxmGykudtVlqsFKfTRRPPt9Yql8o1SiL+x4uUks3ImQHT77lC2W3ND8Rjv6Epi0Rh
	 a4QGB2/XPCIhqSZEFWZBdchNkfHfyU0KO/VgUmayNaGyVKd/Nd0KojUA3PaMjIOy8NzYp
	 II9Tu3np3wjaxPmug8KviwL1uHyQGP3PaNE5PkP+jaeg9lB1BdbjREc9WODINZkPClw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045805;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=UHUWNOVExwTOIC0a4JwScy8jez5sV0HhFMUkEjVLGe0=;
	b=LxReubfrYX51BzOjq8a/BeWgWqdr+BGbaPH+rRf5fn8Dcpd2rsT5yeX7TAtQbq1CvupK
	 5NwPZ/7RBL8YnWYDpR8LHCr3JD1jo8Vn490Vqb/LGsNos5HZYWeGPxOkpONYIs6dprovk
	 2c6OKTgHv2P9DRZgIq31U+cmlUFPh1d7qXUyyzuTVod4AJi1RzhFG8xg/N6m4aPYMaje8
	 JSw4FddSF7GltOUltzX6mqyWqunw0Z52hScH1gmZVOlf4mRpJldMHJv+SsJaL9UtJMtr3
	 9rJa4x5RR5m3nMDWWY2mD2MRB7BcBwHYfv7Be0JAZrropoP/+gwL4v69nk8hxEDc+ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HImFixZB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBF8606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HImFixZB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D851F0089F;
	Sat,  7 Nov 2026 10:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045805;
	bh=UHUWNOVExwTOIC0a4JwScy8jez5sV0HhFMUkEjVLGe0=;
	h=From:To:Cc:Subject:Date;
	b=HImFixZB5NGWHPq4JfTVwGtyWDKvdO5DO5lqzQ6iH5SdtbvRzMJ5h8t5xKNcHakZr
	 huds21a7ztES3QV1Pm5B67EjKMYb3WD3CAxZK5RDjdHODvtT0v6ZS+F6uPmUoNDroD
	 iBJdCZsbo6N+Z/QgCdGEjc9aRWGBzHuLqIKo//ePDzK+efhWoRj35hlgpxS9WUITwm
	 6lvoiWm2NnhzgHOKoDuD597tqnOuEEyiqq/TF70cSPu4Vpoq9WoY+Q9CaMIB0Y4qTU
	 1VknBSmKzL8djFPEs5wMnjFANlejuu6QXbDBI/uMxc59LPT86fc/dA0ocpr8x6tfLb
	 /jQ4Fhn582Cjg==
From: Sasha Levin <sashal@kernel.org>
To: christian.loehle@arm.com,
	sumitg@nvidia.com,
	rafael.j.wysocki@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ACPI: CPPC: Accept requests to retain immutable autonomous selection" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:03:23 -0500
Message-ID: <20261107050323-failed-7.3-4bcc60d326c5@kernel.org>
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

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 4bcc60d326c5acaa28c5913259decb22a33a83a1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050323-failed-7.3-4bcc60d326c5@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

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




