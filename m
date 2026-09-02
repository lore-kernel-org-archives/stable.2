Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D87C1DE4EF;
	Wed,  2 Sep 2026 04:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788322792; cv=none; b=emwabclZ6j5JLmVMbebYvRgmLiCR1v71sTkaqNEMi2i8vPId11q7X5Q4KR4x25X2L0AXXiGBxTuIsRcccI019e9rmqOyQ9VQQcRTpz3BRrshWJzMvF3Q9EZvn969T5u5TxTarpWlf8aDLur7M7VFrZ+HxwyCeQPEIU6d2eKiVvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788322792; c=relaxed/simple;
	bh=vTPYNFKV9KbRTjpEy4wwve68i1PriU1bKEMxFUdKTUY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XUfNCfIqp1RBx3MW1RYldJHWzjthpMwwTH4cXGbkaYLWYl/6C/h5FXUzAFuzGidocHhG1ZtA30M+0cUowYkMU46f5fUvg4Uehwfv+CtCoRQygKwXaYYq/V9XSZ41ZbqNuQ7TsrN/Cekl/lvvhN+/WpVsiC/X47OMpK8IarUsjmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=IB1YS0jX; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="IB1YS0jX"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4c34c922d;
	Wed, 2 Sep 2026 12:19:42 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH v3] cpufreq: initialize policy rwsem before sysfs publication
Date: Wed,  2 Sep 2026 12:19:15 +0800
Message-Id: <20260902041915.3453421-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <83f87db8-fa13-41d0-ae52-544d22e228e6@oss.qualcomm.com>
References: <83f87db8-fa13-41d0-ae52-544d22e228e6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa060581d2803a1kunmeb2db26a191a6d
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaSE5IVkJNHhgYTkMeQ0pMSVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUJCSU
	5LVUpLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=IB1YS0jX7D4TDee58Te8AF11UNAwiFfSFuMc4ZogWxYrthY2nda4v6jenakT1fq25+vfmDUyXcSRryenvAMMjqs0Or9REiqCWfqD9yCIYzqsMyPN3fAYQqf7HGjeyihQXvywFt47ECksrat2jVWOk4oucHJ58Gv7ajsW3NwYolQ=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=mf47wGt84H1mj9CoPeEHRTrNjah42y7EPNMo8LIaxBI=;
	h=date:mime-version:subject:message-id:from;

cpufreq_policy_alloc() initializes policy->rwsem after
kobject_init_and_add() has created the policy sysfs directory and its
default attributes. A sysfs access can therefore reach a policy callback
before the semaphore has been initialized.

Initialize policy->rwsem before publishing the policy kobject so sysfs
callbacks always see an initialized semaphore.

Fixes: 2fc3384dc75b ("cpufreq: Initialize policy->kobj while allocating policy")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20260830155301.2713780-1-runyu.xiao@seu.edu.cn/
Assisted-by: Codex:GPT-5
Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>

---
v3:
- Move Signed-off-by to the end of the trailer block and add Zhongqiu Han's
  Reviewed-by tag.

v2:
- Correct the Fixes tag to the commit that introduced policy kobject publication.
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
