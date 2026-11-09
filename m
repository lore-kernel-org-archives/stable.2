Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794213158;
	b=AMt16POj+MPFtrHxiZnBxTk3NHLIE7lT9Vby2v7hwo09LISlp8mRgYk0/pJqHV/BFW5W
	 TqEEb8a7d4S6wyFntDHfeBfuISW+paN4RQDc3gQAdI8MuD89j/vAuf3S4qUUUSx5dN1ML
	 eU7nX9HXBT1LyJVWNcwPk2bh4SgCg2PLKZPb0c7OP8sQXj3NhOctdBBffxIPWeFbKxTYg
	 baZnxpMhmSksoTVBsS5SqPoaTH9qHy7dFuwAuYwS7LcHQB5k8ioAWE2BEBV8qu0wmbOUx
	 zIuAPEvIz5+E/k+ygEkp27JPyHQUMKstxzfblg7CkSNvif2z+GHVy7SK7XQYk7fVPFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794213158;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=c7CjIHvf1cJr1jaGpt/oWodR55TiSE1nWeBz4SGW22w=;
	b=F0KK5SW+iuhEUMd/mGlpx8HeNp1J7H+GIJqektVrrKa9ouT2P+B0pe6pU8hYmAEkYiTu
	 WnmLHXl/RSnSQ6pu9zAxCP/LZ7dHH3Io7Q+ua8BMDbQP1839zsYyPdV9WNaoerSLgXsDe
	 ZK0kNGhCL0C67m5sXQQfAgsoB6p2dvHPH5PCFGfxbZygScTSBNk8tQxtMsC6ddvNmPMii
	 aLdNoo3rMtp5MHF2gozR8FXH7R71eXaD7lyvSdysiyoPI9Q2Ue+r2iFPfpq8g5KMdyiFZ
	 tOTFF/JAS6s76YnT2rwrXQ280G8ZCB7ofjvf9lnEubpLfZF7emXfApz6kBLT26P6zqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=L8HW20Mr;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DE8606D81F
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 08:32:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26DE8606D81F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=L8HW20Mr
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C1DC1576;
	Mon,  9 Nov 2026 00:32:32 -0800 (PST)
Received: from [10.57.17.30] (unknown [10.57.17.30])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4766B3F632;
	Mon,  9 Nov 2026 00:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794213155; bh=u52UFqsuhgL5l2l0/al2u45IfbzFF9VJuVxXERF6xJ0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L8HW20MrgZenHOLkYupCgB+Pd7n7KZhLyrXT96gkliIVf1KAGHC718hL7Opufr+Pk
	 AwDLc4CnxQDjzfCiy7CamWMzviQ26AtA7CuoM99r3tcbpu3wEar60vMBV4HfKXU6ST
	 Mmb5nul6BIxBye+7gSUJjKX17BLhVjm2ZKSWbQyE=
Message-ID: <55e7eec2-1ccc-4645-9785-ed0b42421e01@arm.com>
Date: Mon, 9 Nov 2026 08:32:32 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 7.3] cpufreq: CPPC: Select the frequency-invariance callback,
 per CPU
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, rafael.j.wysocki@intel.com, sumitg@nvidia.com
References: <20261108112738.2566137-3-christian.loehle@arm.com>
 <2026-11-08-1-daily-reply-0007-cppc-7-3-p2@kernel.org>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <2026-11-08-1-daily-reply-0007-cppc-7-3-p2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

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
Rebased on 89b37c05e36a (upstream 995e7d468070) and the queued patches.
Includes the work-state and NULL-descriptor prerequisites from 27954e29d7de.

 drivers/acpi/cppc_acpi.c       |  3 +++
 drivers/cpufreq/cppc_cpufreq.c | 21 +++++++++++++++------
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 9079ddf2ead1..8aa0ce556863 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1633,6 +1633,9 @@ bool cppc_perf_ctrs_in_pcc_cpu(unsigned int cpu)
 {
 	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
 
+	if (!cpc_desc)
+		return false;
+
 	return CPC_IN_PCC(&cpc_desc->cpc_regs[DELIVERED_CTR]) ||
 		CPC_IN_PCC(&cpc_desc->cpc_regs[REFERENCE_CTR]) ||
 		CPC_IN_PCC(&cpc_desc->cpc_regs[CTR_WRAP_TIME]);
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 951db2a6afb5..782b97acf5dc 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -42,6 +42,7 @@ MODULE_PARM_DESC(fie_disabled, "Disable Frequency Invariance Engine (FIE)");
 /* Frequency invariance support */
 struct cppc_freq_invariance {
 	int cpu;
+	bool pcc_work_initialized;
 	struct irq_work irq_work;
 	struct kthread_work work;
 	struct cppc_perf_fb_ctrs prev_perf_fb_ctrs;
@@ -152,7 +153,7 @@ static struct scale_freq_data cppc_sftd_pcc = {
 
 static void cppc_cpufreq_cpu_fie_init(struct cpufreq_policy *policy)
 {
-	struct scale_freq_data *sftd = &cppc_sftd;
+	struct scale_freq_data *sftd;
 	struct cppc_freq_invariance *cppc_fi;
 	int cpu, ret;
 
@@ -169,7 +170,7 @@ static void cppc_cpufreq_cpu_fie_init(struct cpufreq_policy *policy)
 
 			kthread_init_work(&cppc_fi->work, cppc_scale_freq_workfn);
 			init_irq_work(&cppc_fi->irq_work, cppc_irq_work);
-			sftd = &cppc_sftd_pcc;
+			cppc_fi->pcc_work_initialized = true;
 		}
 
 		ret = cppc_get_perf_ctrs(cpu, &cppc_fi->prev_perf_fb_ctrs);
@@ -185,8 +186,15 @@ static void cppc_cpufreq_cpu_fie_init(struct cpufreq_policy *policy)
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
@@ -209,11 +217,12 @@ static void cppc_cpufreq_cpu_fie_exit(struct cpufreq_policy *policy)
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
 
-- 
2.34.1
