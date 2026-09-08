Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855D91DDFE
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 01:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788831528; cv=none; b=kgZKlQhAQOTndzzEzBYO5/n+UvojmLjhy10df1uVK2JCBy/Wlp83Kxl3n3G2EeuZfufsVex41EE4mPmjQv84p5OAdbmIK+NY+BSsZY/KB61g8j8EyR3Oh4lPYkbq7KIQyw7tTcDxxfeqZkfgMV05qxSLyIzxja36bht+1m6fhj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788831528; c=relaxed/simple;
	bh=qk1O0RApGco72entdCdBPQgFOKmDjK0QINsjkTSkZjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aIw73QxGZRyVTTknPFuHjdASWAHGSBZzC0pMUI/H/q4O3loweMdAOcTkf81zh00v5WhzihnGER1NnaDzdocMTxPDPHE6B+ohOhoG7APGGAby4iacg0jDpawv2moHrN4woMlqp430SI+rg5fvMp3mcpCzIIc/TVe80zHgKNDcYbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ExkJk/hu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ExkJk/hu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 913AB1F00A3A;
	Tue,  8 Sep 2026 01:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788831527;
	bh=4DR/BR85M4a3jtJ7A8aBy3ii6k2D/fLbCqGYB/iGZ6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ExkJk/huwDQ7scxSqSFn2VWV8n2gGhufG4iPdPnOEvO1DgoR2D2USM26HlvrkWiDb
	 a0xBEzC27Bypmo7kE20yfK7K7ZUqJYEon+rC7EsbqhbiqpTlvgw62uibc3LmV6SrCb
	 sBHVCJ+jDZanfUjbSt3oHAYgTwXLUB5pa+jrpDApSlEiSeiS9qyGtMeYVBx1brbH3d
	 40uhBSzoeBnPmLxRATLUFH0TQW13ejqKPF3IfpYbaSYSBrc7F7FO3ZClvyxpF+d2Gz
	 OlZ6TQFmqqsHBlZ401Bf4zDgSJI+1+NKMSXWbEdF/htFFYEhtHgnmyy82g/EhWDY13
	 JITf+RdnxKftA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Loehle <christian.loehle@arm.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] ACPI: CPPC: Reject desired_perf reads on _CPC revision 4+
Date: Mon,  7 Sep 2026 21:38:44 -0400
Message-ID: <20260908013844.1788726-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090309-negation-laboring-bb8a@gregkh>
References: <2026090309-negation-laboring-bb8a@gregkh>
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
[ preserved the raw firmware revision while limiting parsing to the v3-sized register prefix ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/cppc_acpi.c       | 13 +++++++++++--
 drivers/cpufreq/cppc_cpufreq.c |  2 +-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 60d2548f0eea4..531777557b47c 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -768,7 +768,6 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 	}
 	if (cpc_rev > CPPC_V3_REV) {
 		num_ent = CPPC_V3_NUM_ENT;
-		cpc_rev = CPPC_V3_REV;
 	}
 
 	cpc_ptr->num_entries = num_ent;
@@ -1289,10 +1288,20 @@ static int cppc_set_reg_val(int cpu, enum cppc_regs reg_idx, u64 val)
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
 	return cppc_get_reg_val(cpunum, DESIRED_PERF, desired_perf);
 }
 EXPORT_SYMBOL_GPL(cppc_get_desired_perf);
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index e23d9abea1359..0330bc25fbe1a 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -766,7 +766,7 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
 	 * value first as some platforms may update the actual delivered perf
 	 * there; if failed, resort to the cached desired perf.
 	 */
-	if (cppc_get_desired_perf(cpu, &delivered_perf))
+	if (cppc_get_desired_perf(cpu, &delivered_perf) || !delivered_perf)
 		delivered_perf = cpu_data->perf_ctrls.desired_perf;
 
 	return cppc_perf_to_khz(&cpu_data->perf_caps, delivered_perf);
-- 
2.53.0

