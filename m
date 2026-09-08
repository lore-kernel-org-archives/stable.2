Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D07F53A882
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788870017; cv=none; b=jYcwHMaxRbyUof1xBOUnDSamcUm/NVYcwAx9iP2LiS6tFW24CGfzvbYPH1LWuRJvFlXDhFirnDi1RaMThJtQSrxqJQnDAikuPx3VLJbtkH+G1PSYmdcL0PtknLA4DlA3arWHtpsHflLgcZIF831eqHecad4Gi9CfWHkfnYUMOzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788870017; c=relaxed/simple;
	bh=3xyJkBPqVxToXiej64L9cVGW+3IjUrgfT016bV/Ay9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tGHQeGTxE8yUCb6t5dEjmLHIUvnUIKmkeIocQUvb5/ekZc4uaQG5nIlnzJnBl0+DDjPyDbhbeAO6KP6sq1vqayFaWomRqBFNP3iq5PdBvxJuA3Fw39Aowy+ViIgTXrBr4wsDMRwN9k7fk+opm9zNORW7SyRRhis2VvjDCDSz6NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYweoMJP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYweoMJP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5CE1F00A3E;
	Tue,  8 Sep 2026 12:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788870013;
	bh=vAqGmMzM2EIkZH4tLfE/ib3U+og72dTzQ0OvvP8GMvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iYweoMJPnF/010FudS6bgCpY0qcAW3I+0FswpI4Df2FZVPt7VT2EGb4LSikMF/vnD
	 g4Z6qQnm2yJLYObrORGgwwdGYPtXvm6Gio1kJt25KSdHjFeHJXWQX1WyEhdjv+iCxz
	 XhbMYnv3xkzSYilxe+E9vWs2en/0/n9mS7F7DseU0KIdz3k8FrOLOfEihkieMyepK9
	 BxVvn4+GClunnwgwtwIyIJVNtX8eC/6Ll2OCk0KscLDlcQVWRv/cNsNB8czJnZGlbF
	 gpqQBRk9UUy8CwRZcMFuG83O8TVaO1yGzRKKJ5RLjURZD84dDCO+7iwFKsik3mfO4E
	 +AzLsSZHv5UmA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Loehle <christian.loehle@arm.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ACPI: CPPC: Reject desired_perf reads on _CPC revision 4+
Date: Tue,  8 Sep 2026 08:20:09 -0400
Message-ID: <20260908122009.2049812-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090308-suffocate-napkin-a71b@gregkh>
References: <2026090308-suffocate-napkin-a71b@gregkh>
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
index fd6a83e3d4301..2f504034f321a 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -764,7 +764,6 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 	}
 	if (cpc_rev > CPPC_V3_REV) {
 		num_ent = CPPC_V3_NUM_ENT;
-		cpc_rev = CPPC_V3_REV;
 	}
 
 	cpc_ptr->num_entries = num_ent;
@@ -1220,10 +1219,20 @@ static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
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
index 1abedcae50b26..d49753e88c79c 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -807,7 +807,7 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
 	 * value first as some platforms may update the actual delivered perf
 	 * there; if failed, resort to the cached desired perf.
 	 */
-	if (cppc_get_desired_perf(cpu, &delivered_perf))
+	if (cppc_get_desired_perf(cpu, &delivered_perf) || !delivered_perf)
 		delivered_perf = cpu_data->perf_ctrls.desired_perf;
 
 	return cppc_perf_to_khz(&cpu_data->perf_caps, delivered_perf);
-- 
2.53.0

