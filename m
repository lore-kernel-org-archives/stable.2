Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0801A6834;
	Mon,  3 Aug 2026 20:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785789346; cv=none; b=lU3h0NygsMldZMdqSQAQfgmMBQtBHywH2/3/ny6nh69ojskQ9k1L7XVhRV3GlVzY+B/JzVKCCfiEQzEIxwIHn/BitvxnQZQdps3HVr8Kt2N4B6gLjdLkAABv3L2mciVRikbaO3opyWJpxypUu+HJiTpzJ1VpKauebk6khGADlhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785789346; c=relaxed/simple;
	bh=cAmFF5z2bCn5RIMRTn7iLSXF6TmUSyMhjFNGIkV1spU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Va0OW5JjvXDYVc+AHvlvqky+lInNwXnVHLxApBK0yj6GhO/QeVSg1MaI2AMNfGG34slN+fVcc1gi9i2tsM4wjekAi37iDCN6GgVGAexh7HxC5UPGPiJdDykv9bJNmD7TKCZWGk+hmJHnZAyxdpAvncyT5aLnDO8bBBbUTxPbNHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=XlmQ85EF; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="XlmQ85EF"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33B3C1476;
	Mon,  3 Aug 2026 13:35:39 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.0.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DA83A3F632;
	Mon,  3 Aug 2026 13:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785789343; bh=cAmFF5z2bCn5RIMRTn7iLSXF6TmUSyMhjFNGIkV1spU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XlmQ85EF9kd78pIOJgG5f6JGTZJ6aQ8GrlfbzFLJoCaLH1S6DKr8aWPT1TYCrbYVc
	 52Ek3lm4+dKV/tC03ikYb6RqbcaHLN64aCZXHdsjk1N8uXGv3JdD0M3/IhpkNoOKnO
	 tUNEuDa29HeqcUslBw/4bbbJgJI12JFB0zlp+AYw=
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
Subject: [PATCH 1/3] ACPI: CPPC: Reject desired_perf reads on _CPC revision 4+
Date: Mon,  3 Aug 2026 21:35:29 +0100
Message-Id: <20260803203531.1268651-2-christian.loehle@arm.com>
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

When CPPC feedback counters cannot provide a usable sample, cppc-cpufreq
calls cppc_get_desired_perf() because some platforms repurpose Desired
Performance to report actual delivered performance.

ACPI 6.5 defines _CPC revision 3 and lists Read/Write as the Optional
Attribute of Desired Performance. ACPI 6.6 advances _CPC to revision 4 and
lists only Write, so invoking that workaround for revision 4 or later would
require a register read that the interface no longer specifies.

Make cppc_get_desired_perf() return -EOPNOTSUPP for _CPC revision 4 or
later. Use the revision retained in the per-CPU CPC descriptor rather than
the platform-wide FADT revision.

The _CPC revision may still not accurately describe the implemented
register semantics. If a nominally revision 3 platform implements a
non-readable Desired Performance register, a read may return zero and make
cppc_cpufreq_get_rate() report 0 kHz. Treat a zero read as unusable and
fall back to the cached OSPM request, just as for a failed read.

Fixes: c47195631960 ("cppc_cpufreq: Use desired perf if feedback ctrs are 0 or unchanged")
Cc: stable@vger.kernel.org
Suggested-by: Sumit Gupta <sumitg@nvidia.com>
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/acpi/cppc_acpi.c       | 17 ++++++++++++++++-
 drivers/cpufreq/cppc_cpufreq.c |  2 +-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 53d09ca98f06..42aeb749ebe0 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1316,15 +1316,30 @@ static int cppc_set_reg_val(int cpu, enum cppc_regs reg_idx, u64 val)
 	return cpc_write(cpu, reg, val);
 }
 
+static bool cppc_desired_perf_readable(const struct cpc_desc *cpc_desc)
+{
+	return cpc_desc->version < CPPC_V4_REV;
+}
+
 /**
  * cppc_get_desired_perf - Get the desired performance register value.
  * @cpunum: CPU from which to get desired performance.
  * @desired_perf: Return address.
  *
- * Return: 0 for success, -EIO otherwise.
+ * Return: 0 for success, -EOPNOTSUPP for _CPC revision 4 or later, and a
+ * negative errno otherwise.
  */
 int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
 {
+	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
+
+	if (!cpc_desc)
+		return -ENODEV;
+
+	/* _CPC revision 4 no longer specifies Desired Performance as readable. */
+	if (!cppc_desired_perf_readable(cpc_desc))
+		return -EOPNOTSUPP;
+
 	return cppc_get_reg_val(cpunum, DESIRED_PERF, desired_perf);
 }
 EXPORT_SYMBOL_GPL(cppc_get_desired_perf);
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 6fe0e972952a..80893844353c 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -836,7 +836,7 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
 	 * value first as some platforms may update the actual delivered perf
 	 * there; if failed, resort to the cached desired perf.
 	 */
-	if (cppc_get_desired_perf(cpu, &delivered_perf))
+	if (cppc_get_desired_perf(cpu, &delivered_perf) || !delivered_perf)
 		delivered_perf = cpu_data->perf_ctrls.desired_perf;
 
 	return cppc_perf_to_khz(&cpu_data->perf_caps, delivered_perf);
-- 
2.34.1

