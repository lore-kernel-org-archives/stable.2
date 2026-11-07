Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045810;
	b=pzvB5Z9O4vjS+gVfLblO+/SCZvsOcqBbdtVsPcgBQ4+kEi7XPrdffMJxqwvfJ4VKSBaT
	 ebzTW5ZignYBjSRLlfAYh/4DpZj8qVovsumg5lAaT3vyz3eblG6pya+K42SZ0HGGG9iZj
	 5Fw1139OPhGIvo9Tu76YN93oLLp1AoKVdXNYy4timR6czN7cwIR3jmjul6LJdGs6PjCM1
	 g5ngNAAyAbIgzmAoU/3MXIAYvVX0b3bCRfXBZf8/9OT4+FKxBNpmrsVbRrUMlUXLs1xVH
	 yO5IyXKht0AkouawxrtkaKSXKITplbA+tr9Jk9IghXxRGMgcAEtlSCfj/u7mF/rGr5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045810;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=tYuvXerWjoulZ4fzjpVAu3T1gb5Z38TErwn7Zp+/VQ8=;
	b=KsM/Rw+GcaubQ9d+vLO867L3Kc2tMTyGoX+Y5Osda38/HFpXmHcsrI6pbos9r2dpE1Lv
	 dQcK+bUrYzK6CWXRsUeMXmPJVfFNauXNI295b+7vfaZRDfuqdFTAQJaCclLEsahahzr7t
	 uUdZ6ihBDOZPWtND36iCiOxLZTWIV2MiownZgSyO3Ra5YN4TzCNCNk3EY+Ka6r6Eqo4gw
	 w8SoHxxNVt3Xjxpa98EXCu1VxTpsRitcGkBFlKgc8FQB0WfYWPQv+nRYvCPE+DSbD7xxw
	 qVgyiPd6ofcDAGyzlL26JwXyXaKs/eub6IWQ4oiI/+l4fzfMdhxOKOKvPXRQkfHUFOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lk3soqQH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE80606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lk3soqQH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F68B1F0089F;
	Sat,  7 Nov 2026 10:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045809;
	bh=tYuvXerWjoulZ4fzjpVAu3T1gb5Z38TErwn7Zp+/VQ8=;
	h=From:To:Cc:Subject:Date;
	b=Lk3soqQH0yLF+2f5hHPH/4m3ZF8uGXWj8dH3O2156o0/NJh1lDPNjiWhUhmqObQnA
	 xfJDjJbcaVm8JqfbPCmhEWIz7Yw4JdFqSE0mp291WjRtIOJOgcHgonV99vJLc1scfQ
	 ihaNvuZuwlfWegmQmIB/lvpgg11n2GwTdQpG+zRBP3XYNv6hXnglGav3vMJtaDUmzF
	 p81A5jW7iiXiaTfnBCIfEvh49bdmxEFu5Bwy4UWzfRCfYmCcpJcdE7W8HO//oT33GG
	 Z1fXg8ICF8QPiGLbBVyImmY2jQlAF9OADn7ysytHVeiTbx8EoOGYTw811o/MgWbwGF
	 8qoAA4vUnxTJQ==
From: Sasha Levin <sashal@kernel.org>
To: christian.loehle@arm.com,
	sumitg@nvidia.com,
	rafael.j.wysocki@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] cpufreq: CPPC: Select the frequency-invariance callback per CPU" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:03:28 -0500
Message-ID: <20261107050328-failed-7.3-21e018235d99@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 21e018235d99bc86249b034c06646df8757b2852
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050328-failed-7.3-21e018235d99@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 21e018235d99bc86249b034c06646df8757b2852 Mon Sep 17 00:00:00 2001
From: Christian Loehle <christian.loehle@arm.com>
Date: Wed, 16 Sep 2026 17:28:04 +0100
Subject: [PATCH] cpufreq: CPPC: Select the frequency-invariance callback per
 CPU

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
---
 drivers/cpufreq/cppc_cpufreq.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 9dde24d3e6455..c0fa9073e4d3e 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -150,7 +150,7 @@ static struct scale_freq_data cppc_sftd_pcc = {
 
 static void cppc_cpufreq_cpu_fie_init(struct cpufreq_policy *policy)
 {
-	struct scale_freq_data *sftd = &cppc_sftd;
+	struct scale_freq_data *sftd;
 	struct cppc_freq_invariance *cppc_fi;
 	int cpu, ret;
 
@@ -165,7 +165,6 @@ static void cppc_cpufreq_cpu_fie_init(struct cpufreq_policy *policy)
 			kthread_init_work(&cppc_fi->work, cppc_scale_freq_workfn);
 			init_irq_work(&cppc_fi->irq_work, cppc_irq_work);
 			cppc_fi->pcc_work_initialized = true;
-			sftd = &cppc_sftd_pcc;
 		}
 
 		ret = cppc_get_perf_ctrs(cpu, &cppc_fi->prev_perf_fb_ctrs);
@@ -181,8 +180,15 @@ static void cppc_cpufreq_cpu_fie_init(struct cpufreq_policy *policy)
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
-- 
2.53.0




