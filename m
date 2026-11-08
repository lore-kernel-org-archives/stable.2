Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794137269;
	b=GQmjTjnTbV/r/aP0tm7wbG/0n+OEdH46+C5gQTtNvD5loqSLUJ11LzPS4jQbN/PRNBqL
	 sFcKZWsJs/QBHqgU0PU+Oym00JfhNOptKWEMpAu2azM6SHashhFfF/lJtvo1Yg8vLZhEv
	 Yh3NvGNC5oDyMuOZFGcmPG/FraELRumlcs/FEGAZalQpOMDMZQPaHvqnp02oG9NZ6NJ83
	 KYFjW/sVzKfRxRJJxju7+rha7ML7BGsbtJRnExedSFjRZBwwqBIQRFpv+GhPdvhF98249
	 PB6EmFqHPQg+KocaYoivJksejhCWePhvEuWekn92xlrVHZdyAiMb7PnphgHgzMwUo1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794137269;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sRgWEx1xkEG7bha6pneo+OgacbkO7m3k5pehHpNg07Y=;
	b=Mw51v/PmGmrFIvfh75BnBIuJzwxmePGjOkEryJxqZqfwX+ysVrDcsqKb7XCJoHc0zajd
	 fHyL6Xlgtm+QxzZYP4MQ6qaSZ3GCNvu58dPg8BVWUzPh5s+M2AM8t0lJFgTmwyGh71Ch7
	 540XNgrWu22ZsrElIRniNojkUMKEtBpdSXt+XOcaWdL1BG+s/tF2djQmA51qAuL1yN7EQ
	 yqm279YBn+ioOL1McPe41ZNj/OrQnAx/54PvF/YF2dWVkFdYG4qubEqT7Smvi8ecPx7Eu
	 ijl+oK/T468/UusOVZL61I6leuK9vVVXtIjkTAEUSxsxtHO8fz7tke3heysIRrwXcRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=eL0NSCNL;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7897A606A322
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 11:27:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7897A606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=eL0NSCNL
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEB6F15A1;
	Sun,  8 Nov 2026 03:27:44 -0800 (PST)
Received: from e127648.arm.com (unknown [10.57.14.94])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C04803F632;
	Sun,  8 Nov 2026 03:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794137267; bh=osYmgxXel9KZqBOJ0zuJ2xH/Kcv2famMkufOihk/Kkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eL0NSCNLmKKbdjbuxXQL06kK06ESrG0xrbIVDjxcv0f+ooVURw/2fFyzmm+pE4xHR
	 li2s/WdhoTIyfZ2OzX4V2i8komQM0B5DeTBBOiK5lthnNl5H4o5wdbw639nB8JuB6g
	 2NI98zDY2mB8UN6+/mTZztGdl6zqEeCO6rLndq3M=
From: Christian Loehle <christian.loehle@arm.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	rafael.j.wysocki@intel.com,
	sumitg@nvidia.com
Subject: [PATCH 7.3 2/3] cpufreq: CPPC: Select the frequency-invariance callback per CPU
Date: Sun,  8 Nov 2026 11:27:37 +0000
Message-Id: <20261108112738.2566137-3-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261108112738.2566137-1-christian.loehle@arm.com>
References: <20261108112738.2566137-1-christian.loehle@arm.com>
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

commit 21e018235d99bc86249b034c06646df8757b2852 upstream.

cppc_cpufreq_cpu_fie_init() initializes deferred work only for CPUs whose
feedback counters use PCC. However, if any CPU in a shared policy uses PCC,
it installs the PCC tick callback for the entire policy. With FIE enabled,
a non-PCC CPU then queues an uninitialized irq_work and can call a NULL
function pointer when that work runs.

Choose the frequency-invariance callback separately for each CPU using
the recorded work-initialization state. Processor removal can unpublish
the CPC descriptor before callback registration, so querying its counter
transport again can incorrectly select direct reads for a PCC CPU.

Register the callbacks after all counter initialization has completed, so
a failed initial read for an online CPU cannot leave a partially
registered policy. PCC CPUs use their initialized deferred work, while
non-PCC CPUs read their own counters directly from the tick.

Fixes: 997c021abc6e ("cpufreq: CPPC: Update FIE arch_freq_scale in ticks for non-PCC regs")
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
Tested-by: Sumit Gupta <sumitg@nvidia.com>
Link: https://patch.msgid.link/20260916162805.1039247-20-christian.loehle@arm.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
Includes work-state tracking and the NULL-descriptor check from
27954e29d7de66e65ef1be4ce5a50505066c9bb6. Apply before patch 3.

 drivers/acpi/cppc_acpi.c       |  3 +++
 drivers/cpufreq/cppc_cpufreq.c | 21 +++++++++++++++------
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index dc9e1c1fb071..8283db4ee6fa 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1615,6 +1615,9 @@ bool cppc_perf_ctrs_in_pcc_cpu(unsigned int cpu)
 {
 	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
 
+	if (!cpc_desc)
+		return false;
+
 	return CPC_IN_PCC(&cpc_desc->cpc_regs[DELIVERED_CTR]) ||
 		CPC_IN_PCC(&cpc_desc->cpc_regs[REFERENCE_CTR]) ||
 		CPC_IN_PCC(&cpc_desc->cpc_regs[CTR_WRAP_TIME]);
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 80893844353c..ad4bf1656f65 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -41,6 +41,7 @@ MODULE_PARM_DESC(fie_disabled, "Disable Frequency Invariance Engine (FIE)");
 /* Frequency invariance support */
 struct cppc_freq_invariance {
 	int cpu;
+	bool pcc_work_initialized;
 	struct irq_work irq_work;
 	struct kthread_work work;
 	struct cppc_perf_fb_ctrs prev_perf_fb_ctrs;
@@ -149,7 +150,7 @@ static struct scale_freq_data cppc_sftd_pcc = {
 
 static void cppc_cpufreq_cpu_fie_init(struct cpufreq_policy *policy)
 {
-	struct scale_freq_data *sftd = &cppc_sftd;
+	struct scale_freq_data *sftd;
 	struct cppc_freq_invariance *cppc_fi;
 	int cpu, ret;
 
@@ -163,7 +164,7 @@ static void cppc_cpufreq_cpu_fie_init(struct cpufreq_policy *policy)
 		if (cppc_perf_ctrs_in_pcc_cpu(cpu)) {
 			kthread_init_work(&cppc_fi->work, cppc_scale_freq_workfn);
 			init_irq_work(&cppc_fi->irq_work, cppc_irq_work);
-			sftd = &cppc_sftd_pcc;
+			cppc_fi->pcc_work_initialized = true;
 		}
 
 		ret = cppc_get_perf_ctrs(cpu, &cppc_fi->prev_perf_fb_ctrs);
@@ -179,8 +180,15 @@ static void cppc_cpufreq_cpu_fie_init(struct cpufreq_policy *policy)
 		}
 	}
 
-	/* Register for freq-invariance */
-	topology_set_scale_freq_source(sftd, policy->cpus);
+	/* A shared policy may contain both PCC and non-PCC counters. */
+	for_each_cpu(cpu, policy->cpus) {
+		cppc_fi = &per_cpu(cppc_freq_inv, cpu);
+		if (cppc_fi->pcc_work_initialized)
+			sftd = &cppc_sftd_pcc;
+		else
+			sftd = &cppc_sftd;
+		topology_set_scale_freq_source(sftd, cpumask_of(cpu));
+	}
 }
 
 /*
@@ -203,11 +211,12 @@ static void cppc_cpufreq_cpu_fie_exit(struct cpufreq_policy *policy)
 	topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_CPPC, policy->related_cpus);
 
 	for_each_cpu(cpu, policy->related_cpus) {
-		if (!cppc_perf_ctrs_in_pcc_cpu(cpu))
-			continue;
 		cppc_fi = &per_cpu(cppc_freq_inv, cpu);
+		if (!cppc_fi->pcc_work_initialized)
+			continue;
 		irq_work_sync(&cppc_fi->irq_work);
 		kthread_cancel_work_sync(&cppc_fi->work);
+		cppc_fi->pcc_work_initialized = false;
 	}
 }
 
