Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26C1369D6D;
	Fri,  3 Jul 2026 06:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783059722; cv=none; b=Ts694MU3G3a1fNDW6g4M3m1x8ZwAo05UNXQ9wfy6aarENtLzOpEmFHLevj/96HTOLLXoVu73d9V3aPbfgjJz2PC8Jbv0n/cUWtSTdiAaNtWIqxk8xdKM2MCbJuFKUP7oxYzsdmP4QFQM3MZGRfsWcjQUwMRMIGGRRYh25w4kupc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783059722; c=relaxed/simple;
	bh=NJhGiAFsDN15in5OETBvEzBUccCQZDM83X07uR3IuwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nYhUyDZxe7bWTpU06lEU3IZrQGcSYsOyyWegRooav8HFQC3O4QrCfgwKpwhWhZgGl1v8VrlePNKPEOuwQeEBVeH3bWD2UnQzVReziJj+e7/6XXqG965vGhmIopvzPMWcInYUtOMnGBq2Uzm1WBU+N1NuHBFuxDxZckNVbySCuJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DfKyCIWW; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DfKyCIWW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ce
	5xDFXpby+V5V73K8roz6+RbThLVkSsONzOsCEDrhU=; b=DfKyCIWWay1NPfCwCr
	SSLWQlYzMGqHp2YD2vy+XejkjwViXE2JiUefRFSDIxXuQxVir8q7ploNkIqtCJCH
	6J8wYHRw7UC26L0O75miFAFp3T7dMZJhVxYRgWs4c1y8VCmOJIHqBCCa7+HZt9gX
	0GIjMZr59OfUmb/5oj/xB6QS8=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDXvwnDVEdqd70GFw--.62912S2;
	Fri, 03 Jul 2026 14:20:53 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: sven@kernel.org,
	j@jannau.net,
	neal@gompa.dev,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	marcan@marcan.st,
	maz@kernel.org
Cc: asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] cpufreq: apple-soc: Fix OPP table cleanup
Date: Fri,  3 Jul 2026 14:20:49 +0800
Message-Id: <20260703062049.1459175-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDXvwnDVEdqd70GFw--.62912S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXw47trykWrWDKw4UJF48tFb_yoWrJr45pF
	W5WFW5Kr95GFn7tw45JF4j93W7tw4DJ3yUK3y7Gw1Svw17ZF1vg3W8GFyUuF95CF95JFy3
	AryUtay7uay8JaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUUhL8UUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbCxgayIWpHVMZSzgAA3w

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
---
Changes in v2:
 - Remove unnecessary cleanup calls.
 - Remove OPP table from apple_soc_cpufreq_exit(). Thanks, Viresh!
Changes in v3:
 - Add Fixes and Cc stable tags.
 - Use cpumask OPP helpers.
 - Reorder init and failure cleanup. Thanks, Viresh!
---
 drivers/cpufreq/apple-soc-cpufreq.c | 36 +++++++++++------------------
 1 file changed, 14 insertions(+), 22 deletions(-)

diff --git a/drivers/cpufreq/apple-soc-cpufreq.c b/drivers/cpufreq/apple-soc-cpufreq.c
index 638e5bf72185..3f64f266e695 100644
--- a/drivers/cpufreq/apple-soc-cpufreq.c
+++ b/drivers/cpufreq/apple-soc-cpufreq.c
@@ -249,21 +249,19 @@ static int apple_soc_cpufreq_init(struct cpufreq_policy *policy)
 		return -ENODEV;
 	}
 
-	ret = dev_pm_opp_of_add_table(cpu_dev);
-	if (ret < 0) {
-		dev_err(cpu_dev, "%s: failed to add OPP table: %d\n", __func__, ret);
-		return ret;
-	}
+	priv = kzalloc_obj(*priv);
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
 
@@ -271,19 +269,13 @@ static int apple_soc_cpufreq_init(struct cpufreq_policy *policy)
 	if (ret <= 0) {
 		dev_dbg(cpu_dev, "OPP table is not ready, deferring probe\n");
 		ret = -EPROBE_DEFER;
-		goto out_free_opp;
-	}
-
-	priv = kzalloc_obj(*priv);
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
@@ -318,12 +310,12 @@ static int apple_soc_cpufreq_init(struct cpufreq_policy *policy)
 
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
 
@@ -332,7 +324,7 @@ static void apple_soc_cpufreq_exit(struct cpufreq_policy *policy)
 	struct apple_cpu_priv *priv = policy->driver_data;
 
 	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
-	dev_pm_opp_remove_all_dynamic(priv->cpu_dev);
+	dev_pm_opp_of_cpumask_remove_table(policy->cpus);
 	iounmap(priv->reg_base);
 	kfree(priv);
 }
-- 
2.25.1

