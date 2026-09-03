Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D744B2CCD
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788444917; cv=none; b=aBkKyqWEYj4LOPP/KBRuGJuzRxiMqptWNWpiGe352y4t3syKh7PcM2V6tdx0ZeWogY+ZszBt4nYTDAaVP5e1zRK0RxDxejePnGi/uKCx4V0FkSJIh2RNBN4GMtsFN+rHRHpCvOhTi1Hz/tVMtxAJZQiNL5aIQ80zJ1pdR74Jdic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788444917; c=relaxed/simple;
	bh=ngF5YqIe6AEerGciCF+y0U0jebwe8pVOa88XdVR0cOc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HUSmls+Jy3SOzikwfdFyzggu8F9tZbn9KKc2a3xegF6geXq2lI39GFU6B5uxOnorevZ8iqO+YQlZc0uV42K9UCFm1UAzIP0dNQsmkpAuhA8qBC2NrJKwPs8CxCnXU59+sKRWUS0bPQ2Q8O4HG4g00Wzrfe0braxkd1dRBWg5WAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pk74FSaE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pk74FSaE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC431F00ACA;
	Thu,  3 Sep 2026 14:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788444909;
	bh=c1XWQZ/RCEGFJRtRSJrJYLrzKaixjZN8nrBGSl6BruQ=;
	h=Subject:To:Cc:From:Date;
	b=pk74FSaEUbuqY2mz0FQx1bYOGBhaRMMdpPVKPDolVokR7xYXz18clTfySLnVud7HN
	 Fl39C1wUc8Rx5Wa8RH3dLCGusFOGo/9hPXlov76t5QIIiVgeJHSX8w2nu3Pacgbp1e
	 GP+5A6ICH/BPe5RJSsySsSmwpDnx8PWCBjh0ctXs=
Subject: FAILED: patch "[PATCH] cpufreq: apple-soc: Fix OPP table cleanup" failed to apply to 6.18-stable tree
To: haoxiang_li2024@163.com,viresh.kumar@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:53:37 +0200
Message-ID: <2026090337-angles-glacial-e8d2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x d87cb889dc7ab1f2deecadf2a5e9023184bd7900
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090337-angles-glacial-e8d2@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d87cb889dc7ab1f2deecadf2a5e9023184bd7900 Mon Sep 17 00:00:00 2001
From: Haoxiang Li <haoxiang_li2024@163.com>
Date: Fri, 3 Jul 2026 14:20:49 +0800
Subject: [PATCH] cpufreq: apple-soc: Fix OPP table cleanup

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

