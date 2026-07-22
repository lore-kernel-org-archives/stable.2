Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FDB43CED9;
	Wed, 22 Jul 2026 09:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784713128; cv=none; b=II5hjhDLms3LLVT8aeJtEXmSJPy1g7j04CZEJyMzstlNp33JWu+X7ZIXFhk8P+HOPyhaHwbFHEHvQpekVys+Mwhsaqvs5b0tfo15msl1P6kUoh6JzmiCpRrCmSbheiNHrGomR8WLotfFM/GoW4mRl2eupVgKZhT6V06CMeViZKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784713128; c=relaxed/simple;
	bh=7TcQ6/sCTVQbfNo2SPIc83DpT2QA3jK6hKli7/e3E1c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qqliazHHUBcOoHTFTDx3OT+7T++P/myk6XLw/9r+oGq0klKKb5M8Z6ZhiqFHSwChVlbXyGEyPHCM5LMvPWt/CNdvkVl0DNV656cfBkL0dWR27Mt3vkoK8EP4X/pv41ybtaRxpMCnYpVB95RmysUnCsl1zVQaFylZaYUiX5HM3KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=JHSnI32B; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="JHSnI32B"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D1E7168F;
	Wed, 22 Jul 2026 02:38:42 -0700 (PDT)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.1.39.91])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 323F73F86F;
	Wed, 22 Jul 2026 02:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784713126; bh=7TcQ6/sCTVQbfNo2SPIc83DpT2QA3jK6hKli7/e3E1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JHSnI32BxDq1IhjsqHI+O/H9x2fAHrX75o3oYB0FpK5kOM8LSAw4IlRbT7rEwqlVh
	 GEL73WxH31G8gQVS/OTg1WRIgjccrKsM/n8/Ij408QaOZ/lIqVa/oN5cxBdftgCp9Y
	 H+PfpolgM3Ar4eU+uRapSezEJ9PXPE0DvZNtkiec=
From: Christian Loehle <christian.loehle@arm.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Len Brown <lenb@kernel.org>,
	Jie Zhan <zhanjie9@hisilicon.com>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] ACPI: CPPC: Check all controls for fast switching
Date: Wed, 22 Jul 2026 10:38:24 +0100
Message-Id: <20260722093825.1030594-2-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260722093825.1030594-1-christian.loehle@arm.com>
References: <20260722093825.1030594-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ACPI 6.2, Section 6.2.11.2 permits _CPC registers to use flexible
address spaces. Linux advertises that capability through _OSC and parses
the address space of each _CPC register independently. A directly
accessible DESIRED_PERF combined with PCC-backed limits is therefore a
valid configuration.

cppc_allow_fast_switch() only checks DESIRED_PERF, although the fast-switch
callback passes DESIRED_PERF, MIN_PERF and MAX_PERF to cppc_set_perf(). If
a limit uses PCC, that function can sleep while called from scheduler
context.

Allow fast switching only when every supported control used by the
callback has an address space already accepted for fast access. Check the
complete policy domain, including initialized CPUs that are currently
offline and may later become the policy's managing CPU.

Fixes: 658fa7b1c47a ("ACPI: CPPC: Add cppc_get_perf() API to read performance controls")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/acpi/cppc_acpi.c       | 22 +++++++++++++++++-----
 drivers/cpufreq/cppc_cpufreq.c |  2 +-
 include/acpi/cppc_acpi.h       |  5 +++--
 3 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 9f572f481241..1d3a94100491 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -475,17 +475,29 @@ bool acpi_cpc_valid(void)
 }
 EXPORT_SYMBOL_GPL(acpi_cpc_valid);
 
-bool cppc_allow_fast_switch(void)
+bool cppc_allow_fast_switch(const struct cpumask *cpus)
 {
-	struct cpc_register_resource *desired_reg;
+	struct cpc_register_resource *desired_reg, *min_reg, *max_reg;
 	struct cpc_desc *cpc_ptr;
 	int cpu;
 
-	for_each_online_cpu(cpu) {
+	for_each_cpu(cpu, cpus) {
 		cpc_ptr = per_cpu(cpc_desc_ptr, cpu);
+		if (!cpc_ptr)
+			return false;
 		desired_reg = &cpc_ptr->cpc_regs[DESIRED_PERF];
-		if (!CPC_IN_SYSTEM_MEMORY(desired_reg) &&
-				!CPC_IN_SYSTEM_IO(desired_reg))
+		min_reg = &cpc_ptr->cpc_regs[MIN_PERF];
+		max_reg = &cpc_ptr->cpc_regs[MAX_PERF];
+
+		if (!CPC_SUPPORTED(desired_reg) ||
+		    (!CPC_IN_SYSTEM_MEMORY(desired_reg) &&
+		     !CPC_IN_SYSTEM_IO(desired_reg)) ||
+		    (CPC_SUPPORTED(min_reg) &&
+		     !CPC_IN_SYSTEM_MEMORY(min_reg) &&
+		     !CPC_IN_SYSTEM_IO(min_reg)) ||
+		    (CPC_SUPPORTED(max_reg) &&
+		     !CPC_IN_SYSTEM_MEMORY(max_reg) &&
+		     !CPC_IN_SYSTEM_IO(max_reg)))
 			return false;
 	}
 
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index f6cea0c54dd9..b943bf78d3f5 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -693,7 +693,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		goto out;
 	}
 
-	policy->fast_switch_possible = cppc_allow_fast_switch();
+	policy->fast_switch_possible = cppc_allow_fast_switch(policy->cpus);
 	policy->dvfs_possible_from_any_cpu = true;
 
 	/*
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 8693890a7275..8c191b9ac18f 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -170,7 +170,7 @@ extern u64 cppc_get_dmi_max_khz(void);
 extern unsigned int cppc_perf_to_khz(struct cppc_perf_caps *caps, unsigned int perf);
 extern unsigned int cppc_khz_to_perf(struct cppc_perf_caps *caps, unsigned int freq);
 extern bool acpi_cpc_valid(void);
-extern bool cppc_allow_fast_switch(void);
+bool cppc_allow_fast_switch(const struct cpumask *cpus);
 extern int acpi_get_psd_map(unsigned int cpu, struct cppc_cpudata *cpu_data);
 extern int cppc_get_transition_latency(int cpu);
 extern bool cpc_ffh_supported(void);
@@ -234,7 +234,8 @@ static inline bool acpi_cpc_valid(void)
 {
 	return false;
 }
-static inline bool cppc_allow_fast_switch(void)
+
+static inline bool cppc_allow_fast_switch(const struct cpumask *cpus)
 {
 	return false;
 }
-- 
2.34.1

