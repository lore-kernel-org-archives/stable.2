Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794137259;
	b=Q5BzFRHs/zgrvJYPGEDrSFatxMEXUFfFufYvJfm9awzBaYPAAieJOCIiO8if7quU4NeZ
	 Y1WvwaKAVMoHXEuyy5wWz34jV1Ds7zdUlFNVWcsXmNLz/SA0Amy3RPF3SmYJdyk8Ga0C+
	 I/XwhHa0oQ6CoCJOGChMaz6W97nrA8r0gks9+4FhY0Vq4aaCgHN3cYFcCPshHW0R/YkTY
	 7QErJnjCE1Ohjj4wfE37jy41uHZSSrTVUD5YcA0NVGpuLOUCGzsecj3oybJzGCNG5WKl7
	 vsvH55/uzQ1rum5Kui1srA8IgxllEzWaJkJsu9MKx28kghzXneYsY60pgrILPNnIFrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794137259;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ib1ItjkKeCcgoxMCwhFuZIlbtsTSraaOmlZa3ViZOq4=;
	b=b+yAn7H3SmAJFmjCoTkbcEdjJfsFurl82QIWNZTH7RERJd3vMiwlU9SNS14x9DxqjIxu
	 OgPwDszA6Gx4KiKRCDuzO6lpB3hdUn4I2/xa10ut+6qYjvIydMw9XApkprjY9bTTfahtf
	 xZS+3Db9UgeO/126aOoqpVdiCbQvzCs6ldoy8lR8xggiIJdHb3xcRl1s0qzH8e+u/GmCt
	 DwE4TTiu6sfFLGzs+JZ1T1DYmjlyqpS3iw9I7syo2mhXSBHce3qwxv8uoCPma96GnbOjq
	 N+sJoAzKFK1yOM5YM3HokTemNLTq9ybHnn+qzZhzzDxGr2gmwhbwOUqepk/4I//g02Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=LMgz7gcB;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83548606A326
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 11:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83548606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=LMgz7gcB
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 125A6176B;
	Sun,  8 Nov 2026 03:27:35 -0800 (PST)
Received: from e127648.arm.com (unknown [10.57.14.94])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 18CB33F632;
	Sun,  8 Nov 2026 03:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794137258; bh=528o8ZKVijieJ/zjZdE1PEM8yfiacqC7WPmP6LoYR18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LMgz7gcBuH/pNYUWnQJ1FryA1/9z4DClX4+ydj+bg0iEucFjiWTnE5/m6wEtkRCDi
	 laNT12K8KO2n9qZKCFGPLdvdWrcAwTltabpN/x2F0DFxIkPz8ewTOzA+DcX5zY2Cge
	 Y6V/wjIshrkgFEM90jQLbhNi/nH9mzJ2E8fSx+Aw=
From: Christian Loehle <christian.loehle@arm.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	rafael.j.wysocki@intel.com,
	sumitg@nvidia.com
Subject: [PATCH 6.18 3/3] ACPI: CPPC: Accept requests to retain immutable autonomous selection
Date: Sun,  8 Nov 2026 11:27:28 +0000
Message-Id: <20261108112728.2565950-4-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261108112728.2565950-1-christian.loehle@arm.com>
References: <20261108112728.2565950-1-christian.loehle@arm.com>
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

commit 4bcc60d326c5acaa28c5913259decb22a33a83a1 upstream.

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
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/acpi/cppc_acpi.c     | 48 ++++++++++++++++++++++++++++++++++--
 drivers/cpufreq/amd-pstate.c | 25 +++++++++++++++----
 include/acpi/cppc_acpi.h     |  6 +++++
 3 files changed, 72 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index a3984e061ce0..2668004e89ec 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -36,6 +36,7 @@
 #include <linux/delay.h>
 #include <linux/iopoll.h>
 #include <linux/ktime.h>
+#include <linux/mutex.h>
 #include <linux/rwsem.h>
 #include <linux/wait.h>
 #include <linux/topology.h>
@@ -93,6 +94,16 @@ static DEFINE_PER_CPU(int, cpu_pcc_subspace_idx);
  */
 static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
 
+/* Protect immutable capability queries against descriptor removal. */
+static DEFINE_MUTEX(cpc_desc_lock);
+
+static void cpc_set_desc(unsigned int cpu, struct cpc_desc *desc)
+{
+	mutex_lock(&cpc_desc_lock);
+	per_cpu(cpc_desc_ptr, cpu) = desc;
+	mutex_unlock(&cpc_desc_lock);
+}
+
 /* pcc mapped address + header size + offset within PCC subspace */
 #define GET_PCC_VADDR(offs, pcc_ss_id) (pcc_data[pcc_ss_id]->pcc_channel->shmem + \
 						0x8 + (offs))
@@ -899,12 +910,12 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 	}
 
 	/* Plug PSD data into this CPU's CPC descriptor. */
-	per_cpu(cpc_desc_ptr, pr->id) = cpc_ptr;
+	cpc_set_desc(pr->id, cpc_ptr);
 
 	ret = kobject_init_and_add(&cpc_ptr->kobj, &cppc_ktype, &cpu_dev->kobj,
 			"acpi_cppc");
 	if (ret) {
-		per_cpu(cpc_desc_ptr, pr->id) = NULL;
+		cpc_set_desc(pr->id, NULL);
 		kobject_put(&cpc_ptr->kobj);
 		goto out_free;
 	}
@@ -956,6 +967,8 @@ void acpi_cppc_processor_exit(struct acpi_processor *pr)
 	if (!cpc_ptr)
 		return;
 
+	cpc_set_desc(pr->id, NULL);
+
 	/* Free all the mapped sys mem areas for this CPU */
 	for (i = 2; i < cpc_ptr->num_entries; i++) {
 		addr = cpc_ptr->cpc_regs[i-2].sys_mem_vaddr;
@@ -1273,6 +1286,11 @@ static int cppc_set_reg_val(int cpu, enum cppc_regs reg_idx, u64 val)
 
 	reg = &cpc_desc->cpc_regs[reg_idx];
 
+	/* Integer 1 describes autonomous selection that is always enabled. */
+	if (reg_idx == AUTO_SEL_ENABLE && reg->type == ACPI_TYPE_INTEGER &&
+	    reg->cpc_entry.int_value == 1)
+		return val == 1 ? 0 : -EOPNOTSUPP;
+
 	/* if a register is writeable, it must be a buffer and not null */
 	if ((reg->type != ACPI_TYPE_BUFFER) || IS_NULL_REG(&reg->cpc_entry.reg)) {
 		pr_debug("CPC register is not supported\n");
@@ -1722,6 +1740,32 @@ int cppc_get_auto_sel(int cpu, bool *enable)
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
+	bool immutable = false;
+
+	mutex_lock(&cpc_desc_lock);
+	cpc_desc = per_cpu(cpc_desc_ptr, cpu);
+	if (cpc_desc) {
+		reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
+		immutable = reg->type == ACPI_TYPE_INTEGER &&
+			    reg->cpc_entry.int_value == 1;
+	}
+	mutex_unlock(&cpc_desc_lock);
+
+	return immutable;
+}
+EXPORT_SYMBOL_GPL(cppc_auto_sel_is_immutable);
+
 /**
  * cppc_set_auto_sel - Write autonomous selection register.
  * @cpu    : CPU to which to write register.
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index b1a200531628..b2221d83be45 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1651,7 +1651,7 @@ EXPORT_SYMBOL_GPL(amd_pstate_get_status);
 
 int amd_pstate_update_status(const char *buf, size_t size)
 {
-	int mode_idx;
+	int cpu, mode_idx, ret = 0;
 
 	if (size > strlen("passive") || size < strlen("active"))
 		return -EINVAL;
@@ -1661,12 +1661,27 @@ int amd_pstate_update_status(const char *buf, size_t size)
 	if (mode_idx < 0 || mode_idx >= AMD_PSTATE_MAX)
 		return -EINVAL;
 
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
+		cpus_read_lock();
+		/* Check offline CPUs too, before changing or removing the driver. */
+		for_each_present_cpu(cpu) {
+			if (cppc_auto_sel_is_immutable(cpu)) {
+				ret = -EOPNOTSUPP;
+				break;
+			}
+		}
+		cpus_read_unlock();
+		if (ret)
+			return ret;
 	}
 
-	return 0;
+	return mode_state_machine[cppc_state][mode_idx](mode_idx);
 }
 EXPORT_SYMBOL_GPL(amd_pstate_update_status);
 
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 13fa81504844..382a74430e74 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -171,6 +171,7 @@ extern int cppc_set_epp(int cpu, u64 epp_val);
 extern int cppc_get_auto_act_window(int cpu, u64 *auto_act_window);
 extern int cppc_set_auto_act_window(int cpu, u64 auto_act_window);
 extern int cppc_get_auto_sel(int cpu, bool *enable);
+bool cppc_auto_sel_is_immutable(int cpu);
 extern int cppc_set_auto_sel(int cpu, bool enable);
 extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
 extern int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator);
@@ -256,6 +257,11 @@ static inline int cppc_get_auto_sel(int cpu, bool *enable)
 {
 	return -EOPNOTSUPP;
 }
+static inline bool cppc_auto_sel_is_immutable(int cpu)
+{
+	return false;
+}
+
 static inline int cppc_set_auto_sel(int cpu, bool enable)
 {
 	return -EOPNOTSUPP;
