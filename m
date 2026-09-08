Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8434353A8BE
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788870529; cv=none; b=mS+AregHsTMa+Zp8WmMa2t54Z3NruGj6uXslICvzv51DfeqrvcarB6wcCNydUSuYegiJa4FzAfuUQX+BElTINWS5yFwcEBFikrhYgQ6tBVPhngiilF7yUrJr0j2n4YRtG9Hv6aRotJWxFr5J2DC44hQODOKkq1fOH5QGsPLX4M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788870529; c=relaxed/simple;
	bh=XZvB0Pq2aNkp+7CMzCyqKeCftuhCL7mGCNUrTypyU0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XlQKGG12zcoSCd3aH1vj5trzux5RZn8T0bzApD3BNzyoZ2DMdDqYgqo1eDPDzliILbY4w9wOHD+LRD479TY5sG+qhO0f5zMAgOiBQWR1dq5WZkk15RVYrlEoqVwvA11zERxNfDpXWgzi14cWxExfrpnVizxiJHQCv1+7aMxUSUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E2F11F00A3A;
	Tue,  8 Sep 2026 12:28:46 +0000 (UTC)
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Loehle <christian.loehle@arm.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ACPI: CPPC: Reject desired_perf reads on _CPC revision 4+
Date: Tue,  8 Sep 2026 08:28:44 -0400
Message-ID: <20260908122844.2091884-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090308-padlock-setting-e1ac@gregkh>
References: <2026090308-padlock-setting-e1ac@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Loehle <christian.loehle@arm.com>

[ Upstream commit df5a1d4a8cdfda20eb2581a85e81c7d436866534 ]

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
Link: https://patch.msgid.link/20260803203531.1268651-2-christian.loehle@arm.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
[ preserved the original CPPC revision while parsing only the supported v3 prefix and retaining cppc_get_perf() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/cppc_acpi.c       | 13 +++++++++++--
 drivers/cpufreq/cppc_cpufreq.c |  2 +-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 33b3e6dd17c58..c9ae5ea408a04 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -764,7 +764,6 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 	}
 	if (cpc_rev > CPPC_V3_REV) {
 		num_ent = CPPC_V3_NUM_ENT;
-		cpc_rev = CPPC_V3_REV;
 	}
 
 	cpc_ptr->num_entries = num_ent;
@@ -1222,10 +1221,20 @@ static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
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
+	if (cpc_desc->version > CPPC_V3_REV)
+		return -EOPNOTSUPP;
+
 	return cppc_get_perf(cpunum, DESIRED_PERF, desired_perf);
 }
 EXPORT_SYMBOL_GPL(cppc_get_desired_perf);
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 4d96eed64fe0c..5a5832a2f9b2a 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -813,7 +813,7 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
 	 * value first as some platforms may update the actual delivered perf
 	 * there; if failed, resort to the cached desired perf.
 	 */
-	if (cppc_get_desired_perf(cpu, &delivered_perf))
+	if (cppc_get_desired_perf(cpu, &delivered_perf) || !delivered_perf)
 		delivered_perf = cpu_data->perf_ctrls.desired_perf;
 
 	return cppc_perf_to_khz(&cpu_data->perf_caps, delivered_perf);
-- 
2.53.0

