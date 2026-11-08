Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794137238;
	b=RIpqBxu2oDA5t/76IxCEKumO4hyLjijCJjEyX6bLziXb8z9JMbFCeDvPwcNIi27A+z+q
	 77HLob9WbrJ4gq4XbEZachwSmj6Ori1n+DuisL6pyAXUmfVYADVoFeEAIN7P3/HABf6mX
	 N6C6J/o5n5NrMqg27jXtxCc3eP+YoWoN9zB5eeSXGNquS1dOMzQS24B9moEecVrYgKtGV
	 nQ0AUoZfgOHvDE5cBm0SnwBqvsilhy0WlEDvwItmqXUqyQQsDvc948lOTx476fweQ09Cs
	 B6aQgZW96LnMs+Lx2Ef6GtoAcIqMUPPfo1aBiF5pJ+Bj+dYMfZQnqCuH7AbgKDDEmpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794137238;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/a/DE+6mgrIspXCxo16xwfVoC5t3C/c83jKCn4fNpRw=;
	b=WZv3W5oSoO24eKU3/+0ztjVb0Y9/DF7EIZ7Kr57asLnmg1A5LOFshoMqhHJu/itIL4iW
	 AoBkkfUE5XRejybiFC/mQfVD8PfJyGtNLCi/VWBqtZEi+D1euWi14hNfXYEFmCSAC5069
	 ti77Ed0GrYMs0Q+YdTuMHeeBPasVO5HSxlEXxAGYrdQSy7uUj0UTifPgvYwNPDLBAPA6v
	 cVK9upplQXPKJwoYUpunhaRwYqMewLMmnRkXScnX0mUnEUExnPN6XbGobCUnrOJf/TCuX
	 lZ0ki+4n2wbAyZhuYNNTbq+447f5N4CmrS6ZWqtR7FRPS4i6Rj0vcaEvnArWAorZaDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=mgJpLc1B;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9835F606A31C
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 11:27:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9835F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=mgJpLc1B
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03D9E176B;
	Sun,  8 Nov 2026 03:27:14 -0800 (PST)
Received: from e127648.arm.com (unknown [10.57.14.94])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 09EDD3F632;
	Sun,  8 Nov 2026 03:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794137237; bh=NBdSC2Vjf/6y0SHOaH74CDNl6VlVIoQw2w8UNcFiFYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mgJpLc1BCl/FSpTPbwoPlabozVPT5YZh9wWz5URSMAUiieVmqoWYG68QJgUH6Z2WQ
	 hH+4YARAp27yXa+OBUPsZDOdgjeWcvNAKOgkhFC8VXGYt2ssGxY5k3xODYH1M6GmM5
	 yJpafH2K1Cd/bn0Pv2z6hN38i1A1UIz8oPF1PTvw=
From: Christian Loehle <christian.loehle@arm.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	rafael.j.wysocki@intel.com,
	sumitg@nvidia.com
Subject: [PATCH 6.6 3/3] ACPI: CPPC: Accept requests to retain immutable autonomous selection
Date: Sun,  8 Nov 2026 11:26:48 +0000
Message-Id: <20261108112648.2565681-4-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261108112648.2565681-1-christian.loehle@arm.com>
References: <20261108112648.2565681-1-christian.loehle@arm.com>
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
 drivers/cpufreq/amd-pstate.c | 23 ++++++++++++++---
 include/acpi/cppc_acpi.h     |  6 +++++
 3 files changed, 71 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 53d68220f72c..c4184619c76c 100644
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
@@ -94,6 +95,16 @@ static DEFINE_PER_CPU(int, cpu_pcc_subspace_idx);
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
 #define GET_PCC_VADDR(offs, pcc_ss_id) (pcc_data[pcc_ss_id]->pcc_comm_addr + \
 						0x8 + (offs))
@@ -896,12 +907,12 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
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
@@ -955,6 +966,8 @@ void acpi_cppc_processor_exit(struct acpi_processor *pr)
 	if (!cpc_ptr)
 		return;
 
+	cpc_set_desc(pr->id, NULL);
+
 	/* Free all the mapped sys mem areas for this CPU */
 	for (i = 2; i < cpc_ptr->num_entries; i++) {
 		addr = cpc_ptr->cpc_regs[i-2].sys_mem_vaddr;
@@ -1589,6 +1602,32 @@ int cppc_get_auto_sel_caps(int cpunum, struct cppc_perf_caps *perf_caps)
 }
 EXPORT_SYMBOL_GPL(cppc_get_auto_sel_caps);
 
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
@@ -1609,6 +1648,11 @@ int cppc_set_auto_sel(int cpu, bool enable)
 
 	auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
 
+	/* Integer 1 describes autonomous selection that is always enabled. */
+	if (auto_sel_reg->type == ACPI_TYPE_INTEGER &&
+	    auto_sel_reg->cpc_entry.int_value == 1)
+		return enable ? 0 : -EOPNOTSUPP;
+
 	if (CPC_IN_PCC(auto_sel_reg)) {
 		if (pcc_ss_id < 0) {
 			pr_debug("Invalid pcc_ss_id\n");
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 664bd617a2d6..d16e626155a2 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1157,7 +1157,7 @@ static ssize_t amd_pstate_show_status(char *buf)
 
 static int amd_pstate_update_status(const char *buf, size_t size)
 {
-	int mode_idx;
+	int cpu, mode_idx, ret = 0;
 
 	if (size > strlen("passive") || size < strlen("active"))
 		return -EINVAL;
@@ -1167,10 +1167,25 @@ static int amd_pstate_update_status(const char *buf, size_t size)
 	if (mode_idx < 0 || mode_idx >= AMD_PSTATE_MAX)
 		return -EINVAL;
 
-	if (mode_state_machine[cppc_state][mode_idx])
-		return mode_state_machine[cppc_state][mode_idx](mode_idx);
+	if (!mode_state_machine[cppc_state][mode_idx])
+		return 0;
 
-	return 0;
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
+	}
+
+	return mode_state_machine[cppc_state][mode_idx](mode_idx);
 }
 
 static ssize_t status_show(struct device *dev,
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index a451ca4c207b..26f50cb250c2 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -160,6 +160,7 @@ extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
 extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
 extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable);
 extern int cppc_get_auto_sel_caps(int cpunum, struct cppc_perf_caps *perf_caps);
+bool cppc_auto_sel_is_immutable(int cpu);
 extern int cppc_set_auto_sel(int cpu, bool enable);
 #else /* !CONFIG_ACPI_CPPC_LIB */
 static inline int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
@@ -226,6 +227,11 @@ static inline int cppc_get_epp_perf(int cpunum, u64 *epp_perf)
 {
 	return -ENOTSUPP;
 }
+static inline bool cppc_auto_sel_is_immutable(int cpu)
+{
+	return false;
+}
+
 static inline int cppc_set_auto_sel(int cpu, bool enable)
 {
 	return -ENOTSUPP;
