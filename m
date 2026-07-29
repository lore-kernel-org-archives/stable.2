Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CDE414A0E;
	Wed, 29 Jul 2026 10:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785319381; cv=none; b=k1GmlCqdj84Wm4l9FBL+27Ky6Hw9jy68fD1w8Q2pfCzYzJ48S1IlOUfADvcRzasKI+OfZ0NKWNQXU3mgzUwIbt6+v8MND/1Hs5QfyUs/L4/uR6+Z1rfa2OL269EtZpU2gRtJgIZdNO9yEQK5LkQL2dgg1WLdB3ZE8B0la3fgWa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785319381; c=relaxed/simple;
	bh=c9MkMuTlt6FTGa8l5x8XnwyrQZTBduHCOMXxcsxPSvU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c1Svqy+fV42HX6lY4qTCsihHFFJ5dFk0V3+22kGK36ZTM0qk5EqNJ5Fi4kFbjTY4mkPg8ZD7ZA3ZugaKqIiS/1pNvTFv0HU4xJGxxOLNHlYW9nw3lEHPvP2V+pmMUiaQLpJUq+VLX4CCzLsr+dqLz5pF17wjrrmzCWK74aoJn4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=EbUzXc1h; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="EbUzXc1h"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4428F168F;
	Wed, 29 Jul 2026 03:02:55 -0700 (PDT)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.1.39.91])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 004453F86F;
	Wed, 29 Jul 2026 03:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785319379; bh=c9MkMuTlt6FTGa8l5x8XnwyrQZTBduHCOMXxcsxPSvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EbUzXc1hHERS+QC5K9INN5+qgOlY3Ty7HkfwjbSfR9jxNHC1LkPj6eApf1LWOBVYi
	 vEcJR4T1GlLnjo+XdwFgED4aA/RgY7MBSX+dGo2Ny6cO6QLhtLx7I6kAXRy95ckbcZ
	 b/kWfDlaOzNZbQaN/2nLAZglckNRLzpjwE5NN9A0=
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
Subject: [PATCHv2 1/3] ACPI: CPPC: Reject desired_perf reads on ACPI 6.6+
Date: Wed, 29 Jul 2026 11:02:43 +0100
Message-Id: <20260729100245.2628302-2-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260729100245.2628302-1-christian.loehle@arm.com>
References: <20260729100245.2628302-1-christian.loehle@arm.com>
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

The fallback was added for platforms on which Desired Performance reflects
delivered performance. ACPI 6.6 defines the register as write-only, so
invoking that workaround on an ACPI 6.6 or later platform would require an
invalid register read.

Make cppc_get_desired_perf() return -EOPNOTSUPP in that case. Its caller
already handles an error by using the cached desired-performance value.
When checking the FADT minor revision, mask off its upper errata-generation
bits and compare only the specification minor version.

Fixes: c47195631960 ("cppc_cpufreq: Use desired perf if feedback ctrs are 0 or unchanged")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/acpi/cppc_acpi.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 53d09ca98f06..6e5381f8de38 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1316,15 +1316,28 @@ static int cppc_set_reg_val(int cpu, enum cppc_regs reg_idx, u64 val)
 	return cpc_write(cpu, reg, val);
 }
 
+static bool cppc_desired_perf_readable(void)
+{
+	u8 minor_revision = acpi_gbl_FADT.minor_revision & 0x0f;
+
+	return acpi_gbl_FADT.header.revision < 6 ||
+	       (acpi_gbl_FADT.header.revision == 6 && minor_revision < 6);
+}
+
 /**
  * cppc_get_desired_perf - Get the desired performance register value.
  * @cpunum: CPU from which to get desired performance.
  * @desired_perf: Return address.
  *
- * Return: 0 for success, -EIO otherwise.
+ * Return: 0 for success, -EOPNOTSUPP for ACPI 6.6 or later, and a negative
+ * errno otherwise.
  */
 int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
 {
+	/* ACPI 6.6 no longer specifies Desired Performance as readable. */
+	if (!cppc_desired_perf_readable())
+		return -EOPNOTSUPP;
+
 	return cppc_get_reg_val(cpunum, DESIRED_PERF, desired_perf);
 }
 EXPORT_SYMBOL_GPL(cppc_get_desired_perf);
-- 
2.34.1

