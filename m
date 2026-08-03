Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2E63A8739;
	Mon,  3 Aug 2026 20:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785789348; cv=none; b=A1TtFywF/TZ3uH12h0DVIWarbCclcuR2BEHLPPcyx1zOJcusezixi2PVPUHapeUphqG7zeIGAYjo5erUzifnw1Qh3G/TYznBUzj/o88u086v76224OCUVQ2LmJTNKqbMwG+utfYaHt8/qb3hzzy51oukfnKz47PlQD/A36c2Knk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785789348; c=relaxed/simple;
	bh=ss2foDawKwclPC/rzOYzqYK5nvpCkQy93E99c9mNN6M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IZ06hmAgpBJ++I8TE9eGpRM/acLUvN361yJ75TJs0OlQ8UeGZGBefA5E0WCo6xNONF7qTOAgvPveARzxwE1LI4f1x6iUjHIADCpLTvh0ZqtwpGsskfoZk29ppT6ObrSoqNqefLRs7HUdRcJ3MjiZIZ5zT94v22P9V5pH8VSJ80s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=adTNzQA0; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="adTNzQA0"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBD1B1596;
	Mon,  3 Aug 2026 13:35:41 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.0.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9867C3F632;
	Mon,  3 Aug 2026 13:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785789346; bh=ss2foDawKwclPC/rzOYzqYK5nvpCkQy93E99c9mNN6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=adTNzQA0qv0dLpO4mEJ9dAl5HXBy9vDcMe5wmxEpe0hw81l+agG995Dsxe3wtD2pT
	 e+DGATL0Jj1wbYjWUR4Yhk5apCM7JDV9qKVJQJJMP0XOpXZmBsYECAsIapMIe/QEgS
	 QTW6cRRrkekCBQp+iyUav9suvN1myJGEMcQKCEpk=
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
	Sudeep Holla <sudeep.holla@arm.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	zhongqiu.han@oss.qualcomm.com,
	Christian Loehle <christian.loehle@arm.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/3] ACPI: CPPC: Skip desired_perf read in cppc_get_perf()
Date: Mon,  3 Aug 2026 21:35:30 +0100
Message-Id: <20260803203531.1268651-3-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260803203531.1268651-1-christian.loehle@arm.com>
References: <20260803203531.1268651-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ACPI 6.5 defines _CPC revision 3 and lists Read/Write as the Optional
Attribute of Desired Performance. ACPI 6.6 advances _CPC to revision 4 and
lists only Write. cppc_get_perf() nevertheless reads the register when
initializing performance controls, even though cppc-cpufreq overwrites the
value before using it.

Use the _CPC revision check from cppc_get_desired_perf() and leave
desired_perf zero instead of reading it for _CPC revision 4 or later. Also
exclude the register from PCC read-command detection so it cannot trigger
an otherwise unnecessary read command.

Fixes: 658fa7b1c47a ("ACPI: CPPC: Add cppc_get_perf() API to read performance controls")
Cc: stable@vger.kernel.org
Suggested-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/acpi/cppc_acpi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 42aeb749ebe0..becb7e442b30 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1845,12 +1845,14 @@ int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 	u64 desired_perf = 0, min = 0, max = 0, energy_perf = 0, auto_sel = 0;
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
 	struct cppc_pcc_data *pcc_ss_data = NULL;
+	bool read_desired_perf;
 	int ret = 0, regs_in_pcc = 0;
 
 	if (!cpc_desc) {
 		pr_debug("No CPC descriptor for CPU:%d\n", cpu);
 		return -ENODEV;
 	}
+	read_desired_perf = cppc_desired_perf_readable(cpc_desc);
 
 	if (!perf_ctrls) {
 		pr_debug("Invalid perf_ctrls pointer\n");
@@ -1864,7 +1866,8 @@ int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 	auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
 
 	/* Are any of the regs PCC ?*/
-	if (CPC_IN_PCC(desired_perf_reg) || CPC_IN_PCC(min_perf_reg) ||
+	if ((read_desired_perf && CPC_IN_PCC(desired_perf_reg)) ||
+	    CPC_IN_PCC(min_perf_reg) ||
 	    CPC_IN_PCC(max_perf_reg) || CPC_IN_PCC(energy_perf_reg) ||
 	    CPC_IN_PCC(auto_sel_reg)) {
 		if (pcc_ss_id < 0) {
@@ -1896,7 +1899,7 @@ int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 	}
 	perf_ctrls->min_perf = min;
 
-	if (CPC_SUPPORTED(desired_perf_reg)) {
+	if (read_desired_perf && CPC_SUPPORTED(desired_perf_reg)) {
 		ret = cpc_read(cpu, desired_perf_reg, &desired_perf);
 		if (ret)
 			goto out_err;
-- 
2.34.1

