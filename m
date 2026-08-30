Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C4D3B47E2;
	Sun, 30 Aug 2026 15:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788105197; cv=none; b=RQtafWSVMCJmH9uk/hAIBtKyNoruDDPChkY2Og5kZBGPRalsnciOyIyW9RX1Is4ZKUCgcSflGwB+It7AZ9gvvcmfWtofRAdUVgM83zzF/jEEqQ436RjrHVZ64HmFmKJBs87R+uTaOCv/reLmVhiVg8WnNGDv8A/dFEND/cUWkHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788105197; c=relaxed/simple;
	bh=hsHuiUwutCvr/VtqLCTRbYQGHmAMqfRe2iNL4QOD4xo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U/KBHWr82P5yimf9PjgRUZb4SGhRXGlMJDOl3M03eUKGYj7EQQ78hVMdi5cIfx4lHOATr/13twbFMpNXR/041iCcx+r7EUT1LlEba/+CJv6amTtBt3M3s5QQFpM012VrhovGWZoB/qEsDHXI5aHxZgAqXVXE2nsv9xfms4sbQYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=E8Kctk2N; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="E8Kctk2N"
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4bd7a2162;
	Sun, 30 Aug 2026 23:53:09 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: rafael@kernel.org
Cc: viresh.kumar@linaro.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	runyu.xiao@seu.edu.cn,
	jianhao.xu@seu.edu.cn,
	stable@vger.kernel.org
Subject: [PATCH] cpufreq: initialize policy rwsem before sysfs publication
Date: Sun, 30 Aug 2026 23:53:01 +0800
Message-Id: <20260830155301.2713780-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0535fe8da03a1kunmaea15bf5106482
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZQ0NJVkpJHkpNGk9PTE1DSVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=E8Kctk2N4fPhiBUGezpJ1H4W4CYV9HIAk+U7Qkhkp9GGz/COGbjZJ6FrSoJ7sEY1DrPAwXnrCZYB47pb7knLJufHO0/DceapwT2u8SLgsQSAGjhpv+qnofnCfLD+vhdH4cQmFWt66HFC7EG8OosdqLZ477LJVgh/KaTfHWLK+fE=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=s+bmwNUs1VXUmIRihvb79HKjQN710jIbHZEnpTHONHs=;
	h=date:mime-version:subject:message-id:from;

cpufreq_policy_alloc() initializes policy->rwsem after
kobject_init_and_add() has created the policy sysfs directory and its
default attributes. A sysfs access can therefore reach a policy callback
before the semaphore has been initialized.

Initialize policy->rwsem before publishing the policy kobject so sysfs
callbacks always see an initialized semaphore.

Fixes: ad7722dab729 ("cpufreq: create per policy rwsem instead of per CPU cpu_policy_rwsem")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/cpufreq/cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 0d0df986f..9efbf5b17 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1258,6 +1258,8 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 	if (!zalloc_cpumask_var(&policy->real_cpus, GFP_KERNEL))
 		goto err_free_rcpumask;
 
+	init_rwsem(&policy->rwsem);
+
 	init_completion(&policy->kobj_unregister);
 	ret = kobject_init_and_add(&policy->kobj, &ktype_cpufreq,
 				   cpufreq_global_kobject, "policy%u", cpu);
@@ -1272,8 +1274,6 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 		goto err_free_real_cpus;
 	}
 
-	init_rwsem(&policy->rwsem);
-
 	freq_constraints_init(&policy->constraints);
 
 	policy->nb_min.notifier_call = cpufreq_notifier_min;
-- 
2.34.1

