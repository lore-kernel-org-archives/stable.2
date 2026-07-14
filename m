Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5116481A84
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 14:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784040650; cv=none; b=ajxTUF29X7AUITN85Sr+71FoPfpub9bdKUumE36Aymzeot9Z/OxIForfQX5CqgZDENN3hAzFIFrPQs+iENocHrR3EOuPr7dQfpKglwLgt/86a04zdXLLUk/xw5V0mBU+/S6XIUR1clyPtmtR4/M81SzY7+jiUM1wK5w/sMGJc78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784040650; c=relaxed/simple;
	bh=EzUwO/iPPzqZrc9ciN54B+2U3phBVFM3HC8dfVc1ODo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mA/IWDXcnlvt/5w6Elnj/9Qb8hEuNKHDaMu3oCuNWyinjV/YO1I3jBJVcd4YNYj2uMehVlxAu+kN9jIjuAYw2Uo6zyO7nVbakOUgzCUY1QJNPHSrkmTUGhzyZMKnB6PrjJrUSSFcl5XUCKt6SLW09zHlKw7zewZweee/TikES7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pspvqgIe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pspvqgIe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 229421F00A3A;
	Tue, 14 Jul 2026 14:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784040638;
	bh=tZ8Gx8B5cChTe5KmTfwoNzeuc8Kt/nWMT4TRI5ALqtM=;
	h=Subject:To:Cc:From:Date;
	b=pspvqgIeWrUzdMu/KOq4ZoHpEPDgzA+OpTpql0gnWDF6l+wtu0kwB07DN0AJz+0sm
	 9kRH3uZ2UDLwQBNoCetPttPjVtQYp99Q8YG49yk10QYe3508g8kDAlLFWdrJ+X0cE3
	 pCWHECFun9UAwMkNwlTjDtDvKgjkEEjHEpxLv/PA=
Subject: FAILED: patch "[PATCH] cpufreq: qcom-cpufreq-hw: Fix possible double free" failed to apply to 6.6-stable tree
To: lgs201920130244@gmail.com,viresh.kumar@linaro.org,zhongqiu.han@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 16:49:13 +0200
Message-ID: <2026071413-devious-clay-8609@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x bcb8889c4981fdde42d4fd2c29a77d510fe21da2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071413-devious-clay-8609@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bcb8889c4981fdde42d4fd2c29a77d510fe21da2 Mon Sep 17 00:00:00 2001
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Sat, 2 May 2026 03:00:05 +0800
Subject: [PATCH] cpufreq: qcom-cpufreq-hw: Fix possible double free

qcom_cpufreq.data is allocated with devm_kzalloc() in probe() as an
array of per-domain data. qcom_cpufreq_hw_cpu_init() stores a pointer to
one element of this array in policy->driver_data.

qcom_cpufreq_hw_cpu_exit() currently calls kfree() on policy->driver_data.
This is not valid because the memory is devm-managed. For the first
domain, this can free the devm-managed allocation while the devres entry
is still active, leading to a possible double free when the platform
device is later detached. For other domains, the pointer may refer to an
element inside the array rather than the allocation base.

Remove the kfree(data) call and let devres release qcom_cpufreq.data.

This issue was found by a static analysis tool I am developing.

Fixes: 054a3ef683a1 ("cpufreq: qcom-hw: Allocate qcom_cpufreq_data during probe")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index ea9a20d27b8f..ef19faedbfec 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -578,7 +578,6 @@ static void qcom_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
 	dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
 	qcom_cpufreq_hw_lmh_exit(data);
 	kfree(policy->freq_table);
-	kfree(data);
 }
 
 static void qcom_cpufreq_ready(struct cpufreq_policy *policy)

