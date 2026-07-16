Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29F82D238F
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 17:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784223960; cv=none; b=JQH9aJ+UZssqpv2hYdpnOjtpi2ILI9mYu9eEakR+0rUri64g2DW1z4zsxNzp++BYT6wie0+PWbNEUFi6S56GY80L9EDThHvlGtu25nUtumgYT7BLQQoa5yNR5T8ENgL33eBCuvVRX3olx8Q9RiUEjyZ+9eB84bTUqQTBfpO8upc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784223960; c=relaxed/simple;
	bh=pDrDneIboDWych9AFkAX3NfjWmrjxI7CYSQdv3nu5bY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KcvGO6X8NHinXhoZUvWUbaaFsTVB6Y9s0i+snJiczwMRPaip5TOZTs3Jnwoya7evVh+ebqou9N5dkGnwwrmXeE2K7pBEaXA5+FSINQQc8JUuMIZgmUHQLgr9bJLUtIw76gfy+T90SKxsRgZFoGU0XXNsaUAKVhFbHKLUO8Vi2qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rd90fKPa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rd90fKPa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE95D1F000E9;
	Thu, 16 Jul 2026 17:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784223959;
	bh=6a7LLZu8+s+b/2xea13pSHQ8+3upEq/TbWxIL6UBo34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Rd90fKPaxJLZdKQGCNhrNaOTuwqpLXE2kajRIsADFLLNQ7pD9H+7+4lI++c5plbI0
	 /qFN09K/uNbfwcBWrFc3XZNoDnZF319UumwrpFzwLV2bwybvqG71J9+Qo/mn/jPSnl
	 ZZF9f3rPbeXpzDz7mV9iAyZ2yC0QZiDf+ggcFeUIhu38y13yQ9OpFj+daDs7B7G5tS
	 rutwlNGH9WdBm2JRL+9ewf1k+qDZ0J0Cs81Mj3P3RhqCZ+kAEJfVhqZMMPNIpco/sU
	 XZqtD8GaqDaPerCKXhvHm/vp229E4YCPeYHO09R7aVte5iZz2CVqpduZ45pqkn1j/z
	 r7fhodfkrag2w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] cpufreq: qcom-cpufreq-hw: Fix possible double free
Date: Thu, 16 Jul 2026 13:45:55 -0400
Message-ID: <20260716174555.787913-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716174555.787913-1-sashal@kernel.org>
References: <2026071413-devious-clay-8609@gregkh>
 <20260716174555.787913-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guangshuo Li <lgs201920130244@gmail.com>

[ Upstream commit bcb8889c4981fdde42d4fd2c29a77d510fe21da2 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 0daf442aedd4b0..692673447a2e10 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -583,7 +583,6 @@ static void qcom_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
 	dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
 	qcom_cpufreq_hw_lmh_exit(data);
 	kfree(policy->freq_table);
-	kfree(data);
 }
 
 static void qcom_cpufreq_ready(struct cpufreq_policy *policy)
-- 
2.53.0

