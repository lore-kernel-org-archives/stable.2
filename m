Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7825517BAB
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872346; cv=none; b=PJ9hgPcBv82fxxQBxLlhiWjfEmmzfb9lgaVV9odq8acg96ovHc3OQH31JqJRW1G92cWQYs0N1maZFAnWcXmMNm6YVKxnxLN8SlGh4OuPbDvjPPFhe8tDaSIvRM5kfkVbSKtHOceI6QOZ/tTOThhuCjVvQKb+8H0uYXa419BcCBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872346; c=relaxed/simple;
	bh=2uSQCgQ1PuKuJL7FTs6OdlMKHoBBcqmLpHTKTqsvWK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l2Q09aMRNAkr2nxh1+RKJ57YsvDWAxjMbWC1TtNZ9mu9HkZb6MY+hIJI1YJefjEe4OuGYRMQ+armBLPaM9bQ+TSg+SKkzxVOQT64gX4ZTkM35mhfsgLkmRiJXUyaKy6GIHXAuh+zxYw6xUO/qyG2mtIGsyMLLF41ODeHmNob2rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Arn8Hnm8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Arn8Hnm8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A063F1F00A3A;
	Tue,  8 Sep 2026 12:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788872339;
	bh=yVZVG7tx3AG7syHzmw9Heyewd8+mzlLGBMMY0/NxMGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Arn8Hnm8yWiPHpkIuEwGTWVvygiIgPzlWQdvnyT57enjUFax/+SS4nnSb7RUx5iiB
	 SS41qH8B053xSgmzaSXDd0ojI04bU0fVrgSdO/rShPtkOtuUk3+22mi0tBcHH4fmIX
	 0meVzkmPumb+u6nJIuRPO19xgmXvTPDdD6CmxmEPsIadmJ5uFV6RtvIuE5LIXZ33MB
	 z15jpAfXuIkjAiiWtRd3G0bq4wbqwG+CWYPZ98hgqNCAMZQDfdiJ+KUMaMRVLm+GIp
	 1ZUAAGPLNF5X4MVmEIY/xLG55OA4ehrCVx8rPzgJjg/sThpHngz39OMo6J4nKdqvrk
	 mtkq2B2oBhXOw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Haoxiang Li <haoxiang_li2024@163.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] cpufreq: apple-soc: Fix OPP table cleanup
Date: Tue,  8 Sep 2026 08:58:56 -0400
Message-ID: <20260908125856.2181771-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090337-angles-glacial-e8d2@gregkh>
References: <2026090337-angles-glacial-e8d2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haoxiang Li <haoxiang_li2024@163.com>

[ Upstream commit d87cb889dc7ab1f2deecadf2a5e9023184bd7900 ]

apple_soc_cpufreq_init() adds OPP tables from firmware, but
some failure paths do not remove them. The driver also uses
dev_pm_opp_remove_all_dynamic(), which is not the right cleanup
helper for OPP tables loaded from firmware.

Use the cpumask OPP helper after the policy CPU mask has been
populated. Pair it with the matching cpumask remove helper on
failure paths and in apple_soc_cpufreq_exit(). This also removes
the separate dev_pm_opp_set_sharing_cpus() call, as the cpumask
helper loads the DT OPP tables for all CPUs in the policy.

Fixes: 6286bbb40576 ("cpufreq: apple-soc: Add new driver to control Apple SoC CPU P-states")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
[ retained kzalloc(sizeof(*priv), GFP_KERNEL) instead of upstream kzalloc_obj(*priv) ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/apple-soc-cpufreq.c | 36 +++++++++++------------------
 1 file changed, 14 insertions(+), 22 deletions(-)

diff --git a/drivers/cpufreq/apple-soc-cpufreq.c b/drivers/cpufreq/apple-soc-cpufreq.c
index b1d29b7af2326..9474988a2a15f 100644
--- a/drivers/cpufreq/apple-soc-cpufreq.c
+++ b/drivers/cpufreq/apple-soc-cpufreq.c
@@ -251,21 +251,19 @@ static int apple_soc_cpufreq_init(struct cpufreq_policy *policy)
 		return -ENODEV;
 	}
 
-	ret = dev_pm_opp_of_add_table(cpu_dev);
-	if (ret < 0) {
-		dev_err(cpu_dev, "%s: failed to add OPP table: %d\n", __func__, ret);
-		return ret;
-	}
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
 
 	ret = apple_soc_cpufreq_find_cluster(policy, &reg_base, &info);
 	if (ret) {
 		dev_err(cpu_dev, "%s: failed to get cluster info: %d\n", __func__, ret);
-		return ret;
+		goto out_free_priv;
 	}
 
-	ret = dev_pm_opp_set_sharing_cpus(cpu_dev, policy->cpus);
-	if (ret) {
-		dev_err(cpu_dev, "%s: failed to mark OPPs as shared: %d\n", __func__, ret);
+	ret = dev_pm_opp_of_cpumask_add_table(policy->cpus);
+	if (ret < 0) {
+		dev_err(cpu_dev, "%s: failed to add OPP table: %d\n", __func__, ret);
 		goto out_iounmap;
 	}
 
@@ -273,19 +271,13 @@ static int apple_soc_cpufreq_init(struct cpufreq_policy *policy)
 	if (ret <= 0) {
 		dev_dbg(cpu_dev, "OPP table is not ready, deferring probe\n");
 		ret = -EPROBE_DEFER;
-		goto out_free_opp;
-	}
-
-	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
-	if (!priv) {
-		ret = -ENOMEM;
-		goto out_free_opp;
+		goto out_free_table;
 	}
 
 	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
 	if (ret) {
 		dev_err(cpu_dev, "failed to init cpufreq table: %d\n", ret);
-		goto out_free_priv;
+		goto out_free_table;
 	}
 
 	/* Get OPP levels (p-state indexes) and stash them in driver_data */
@@ -320,12 +312,12 @@ static int apple_soc_cpufreq_init(struct cpufreq_policy *policy)
 
 out_free_cpufreq_table:
 	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
-out_free_priv:
-	kfree(priv);
-out_free_opp:
-	dev_pm_opp_remove_all_dynamic(cpu_dev);
+out_free_table:
+	dev_pm_opp_of_cpumask_remove_table(policy->cpus);
 out_iounmap:
 	iounmap(reg_base);
+out_free_priv:
+	kfree(priv);
 	return ret;
 }
 
@@ -334,7 +326,7 @@ static void apple_soc_cpufreq_exit(struct cpufreq_policy *policy)
 	struct apple_cpu_priv *priv = policy->driver_data;
 
 	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
-	dev_pm_opp_remove_all_dynamic(priv->cpu_dev);
+	dev_pm_opp_of_cpumask_remove_table(policy->cpus);
 	iounmap(priv->reg_base);
 	kfree(priv);
 }
-- 
2.53.0

