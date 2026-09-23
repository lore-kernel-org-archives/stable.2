Received: from mta1.migadu.com (out-203.mta1.migadu.com [95.215.58.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E34A491581
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 15:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790177006; cv=none; b=P5iaSwVkISEjCC83M6Hi5+dbSQTDEZCbBJJ/8726QRntv3Z9OOddrF2FMsoFaU94RaZ35GvNbThok37WgRLyImf3KDavQfU58k4iWxKsnmI9TUyOVXrdTxMzS0yNH7kB8Vk9HE5f67j+mddbIiy9sYXqjs/WRzQW3eGBDljU9Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790177006; c=relaxed/simple;
	bh=xnL9xErcyYKS/9j7WIkNTeykzegxGlsehi7RhfMw50g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t6QFLIu1MJMzGjnvkZPjzLG/+qk8IoDYvePwOhLaNSOLldqoFUs/OWHV/lF+bVlzZKmPSk93JyNvWiO48loF/SIQGbCmcWfx9VkU9IeLpL2b8NYQvqhB6uJCx6UXEVoOTlrVxhhuUY6Kk7dFe1KhWYDX+ZrSstY4eaN911wlP2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akao.au; spf=pass smtp.mailfrom=akao.au; dkim=pass (2048-bit key) header.d=akao.au header.i=@akao.au header.b=GznM3n26; arc=none smtp.client-ip=95.215.58.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akao.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akao.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akao.au header.i=@akao.au header.b="GznM3n26"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=xnL9xErcyYKS/9j7WIkNTeykzegxGlsehi7RhfMw50g=;
 c=simple/simple; d=akao.au;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790177001; v=1; x=1790781801;
 b=GznM3n269ubzH2IO5HubRfwhmB9pqBhdq8FOkU3QDmLw+aUkVuiVwwwTC4dKvCPIpmhghpME
 s4DwPvKoNg9QRBTXpluMo90QgW8AetggbvHQlBlWTYvE0bfZyTYk4AHu7ObyOvfBfoGnR3BZVm0
 0R9Apy+J7ADP0Z6zhTTzXOtYLeCS0rXaxw7sAwmYTyapVWYMx5ASb2tKGodhvrKxe7kxTdypyNt
 3s69RkQZIVEMgtlpMuQWmKtBdikl7gBq+p/bkVqpZmRaU1UHS+tiVoZMX5luzn1ueZIzxLD2AfL
 ufKXnIdwNHZB/J52FbxV+yrgDnPkZlmhT65UnNk94op1g==
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 50fdd6125a7fb788;
	Wed, 23 Sep 2026 15:23:21 +0000
X-Mizu-Trace-ID: 50fdd6125a7fb788
X-Migadu-Flow: FLOW_OUT
From: Charlie Garner <charlie@akao.au>
To: Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>
Cc: Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Dhruva Gole <d-gole@ti.com>,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Charlie Garner <charlie@akao.au>,
	stable@vger.kernel.org
Subject: [PATCH] firmware: arm_scmi: perf: ignore an implausible sustained frequency
Date: Thu, 24 Sep 2026 00:52:45 +0930
Message-ID: <20260923152245.44624-1-charlie@akao.au>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On a Dell Inspiron 14 Plus 7441 (Snapdragon X Plus X1P64100, soc_id 615)
the SCMI firmware reports a sustained frequency below the lowest available
OPP for performance domains NCC1 and NCC2. It reports zero for both
sustained_freq_khz and sustained_perf_level there, while NCC0 reports
3417600 kHz at level 12. All three domains use level indexing mode, so
mult_factor is fixed at 1000 and the OPP frequencies come from
indicative_freq; this is not a units or mult_factor problem.

scmi_dvfs_device_opps_add() then flags every OPP in NCC1 and NCC2 as turbo:

	data.turbo = freq > dom->sustained_freq_khz * 1000UL;

cpufreq_frequency_table_cpuinfo() skips boost-flagged entries and fails
when none are left:

	if ((!cpufreq_boost_enabled() || !policy->boost_enabled)
	    && (pos->flags & CPUFREQ_BOOST_FREQ))
		continue;
	...
	if (min_freq == ~0)
		return -EINVAL;

cpufreq_policy_online() drops the policy on that error without logging
anything. Only one of the three performance domains ends up with a policy.
The part has 10 cores (the x1e80100 DT describes 12, CPUs 7 and 11 fail to
boot): 4 of them can scale, the other 6 get no policy, no governor, and no
cpufreq cooling device.

This cannot be worked around by enabling boost. policy->boost_enabled is
still 0 during that validation, and both places that set it -
boost_supported in cpufreq_table_validate_and_sort(), boost_enabled in
cpufreq_online() - run after the call that already returned -EINVAL. A
domain whose OPPs are all flagged turbo can therefore never get a policy.

Confirmed by probing dev_pm_opp_add_dynamic() on the affected machine: all
13 OPPs are added with turbo=0 for domain NCC0 and turbo=1 for every CPU in
NCC1 and NCC2, across an identical 710400-3417600 kHz table. The raw domain
attributes above were read the same way, with a kprobe on
scmi_dvfs_device_opps_add() fetching the perf_dom_info fields.

A sustained frequency below the lowest OPP carries no information - it
cannot separate sustained levels from boost levels. Treat it as "this
domain has no turbo levels" instead of letting it disable the domain
entirely, and say so once with a FW_BUG warning, since the failure is
otherwise silent. A sustained frequency equal to the lowest OPP is left
alone, it already leaves that OPP non-turbo.

Fixes: a897575e79d7 ("firmware: arm_scmi: Add support for marking certain frequencies as turbo")
Cc: stable@vger.kernel.org
Signed-off-by: Charlie Garner <charlie@akao.au>
---

Notes:
    The SCMI quirks framework (quirks.c) would also work here, and this
    platform already has two quirks enabled. I went with a generic check
    because a sustained frequency below every OPP is meaningless on any
    platform, and the check is a no-op for firmware that reports a sane value.
    Happy to turn it into a quirk if you'd prefer that.

 drivers/firmware/arm_scmi/perf.c | 34 ++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 4583d02bee1c..94f644996f9d 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -861,11 +861,20 @@ static void scmi_perf_domain_init_fc(const struct scmi_protocol_handle *ph,
 	dom->fc_info = fc;
 }
 
+static unsigned long scmi_perf_opp_freq(const struct perf_dom_info *dom,
+					int idx)
+{
+	if (!dom->level_indexing_mode)
+		return dom->opp[idx].perf * dom->mult_factor;
+
+	return dom->opp[idx].indicative_freq * dom->mult_factor;
+}
+
 static int scmi_dvfs_device_opps_add(const struct scmi_protocol_handle *ph,
 				     struct device *dev, u32 domain)
 {
 	int idx, ret;
-	unsigned long freq;
+	unsigned long freq, sustained_hz, lowest_hz = ULONG_MAX;
 	struct dev_pm_opp_data data = {};
 	struct perf_dom_info *dom;
 
@@ -873,14 +882,27 @@ static int scmi_dvfs_device_opps_add(const struct scmi_protocol_handle *ph,
 	if (IS_ERR(dom))
 		return PTR_ERR(dom);
 
+	for (idx = 0; idx < dom->opp_count; idx++)
+		lowest_hz = min(lowest_hz, scmi_perf_opp_freq(dom, idx));
+
+	/*
+	 * A sustained frequency below every OPP would mark all of them as
+	 * turbo. Such a value cannot separate sustained levels from boost
+	 * levels, so ignore it and treat the domain as having no turbo OPPs.
+	 */
+	sustained_hz = dom->sustained_freq_khz * 1000UL;
+	if (dom->opp_count && sustained_hz < lowest_hz) {
+		dev_warn_once(dev, FW_BUG
+			      "[%d][%s]: sustained freq %lu Hz below lowest OPP %lu Hz, ignored\n",
+			      domain, dom->info.name, sustained_hz, lowest_hz);
+		sustained_hz = ULONG_MAX;
+	}
+
 	for (idx = 0; idx < dom->opp_count; idx++) {
-		if (!dom->level_indexing_mode)
-			freq = dom->opp[idx].perf * dom->mult_factor;
-		else
-			freq = dom->opp[idx].indicative_freq * dom->mult_factor;
+		freq = scmi_perf_opp_freq(dom, idx);
 
 		/* All OPPs above the sustained frequency are treated as turbo */
-		data.turbo = freq > dom->sustained_freq_khz * 1000UL;
+		data.turbo = freq > sustained_hz;
 
 		data.level = dom->opp[idx].perf;
 		data.freq = freq;

base-commit: 60a89ec8d8f56dcd99611cb054fbf7d0e864cf4e
-- 
2.55.0

