Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795626132;
	b=wWfO2aM8QoZgWDujHv84FOTcPFCm0NLnoiuf9oPoGEcOUG+pHeviYqimuj9sb/JqEdgZ
	 QiFFWJBMuuTSta3B9Y4JMNvsjjyrmixcVOEWxft8FpnhgmgB6SmRvaFyBYFsnQvSFiIEy
	 ESgv2k4irAe3Hd/kYEj/Eo/zilwo71r392VdUFJnJyhKKTZMvZPOPCncGTfiPPJ658vkx
	 6WFMJ8vLx3qld/UQFf3Fp6e4WWYD0ULzYMLWNObZCJLIMjvSCE1JuZe0iB6Y7nhpQGzbN
	 xh0JxGIkP/w/H7h9iOwLYONtOy3YVAlQbW/FgRmK5DeUR20aZQMyGDXx0HaxVyDTrJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626132;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+1uwiCgNjBLPMwrTquNxvBYSXcy6SJk7XcqCHgPcclg=;
	b=G16aoJHcDdJKqSYMUK0phmDF3rYjAkkA4jy3l7Z2CUFJ1Clj0ZTncWnvk9JYbRwupHFU
	 wznA/z6fmikU1uzF3RLj9tqKYCeMJgCvkptGPrfExzTQRdVSgQNe17/AUJ4Wup6BrBSnB
	 0n3FtiLfALwgNn7xuG69SOvbuTzR+GMjBQFHOjJ+OdyR85moru0Mz7YTCJrr1uomDWGFo
	 qX+KImurccnqu53amj9M42uuxA+WOnc7/LkPM5wGIiM9ml90LldLkjLUJX0WCPfqtbQdg
	 o6HVi0n/srKYDEmHf2Yqng+PnFZ1QAAvleYuxtWgtBIWipJRo+MbKMVxuPJqIDiFAlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NRYrAFYN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD4F606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NRYrAFYN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C02E81F000C0;
	Wed, 25 Nov 2026 17:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795626132;
	bh=+1uwiCgNjBLPMwrTquNxvBYSXcy6SJk7XcqCHgPcclg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NRYrAFYNEcdiijVXLHNxMAG66PIAa1keZ0AIU8CHlFpli+yblkDBAM1WQkPztSo2S
	 IUWb9WQ1QGVQidhRfFAcQMQ7/CqouzXcnnVEBAPAWAcHuTki999VOx1p0wmlb1Qqd5
	 EKXPILfICQ2yaOVaOUUET9vwkgOzPfTGl4nGYUgP3w+JQJ0ZQ+HHOvyRlETvUbMUOe
	 R6+Gn/M7bsdoI12XtdFU5dwde2cJSWaQ2WHIegOEebEa6vL+KhstDVP2qvLdIVthrh
	 b4fkjthfZjeqZN/ba+nVtmRAWBGf3TJtMWa+AhYb91C0cIGZ8gRv86EOyZQktqGXDD
	 LAlTP6EHfmT0g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] cpufreq: Avoid redundant target() calls for unchanged limits
Date: Wed, 25 Nov 2026 12:02:09 -0500
Message-ID: <20261125170141.823504-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112538-playset-untold-8b24@gregkh>
References: <2026112538-playset-untold-8b24@gregkh>
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

From: Viresh Kumar <viresh.kumar@linaro.org>

[ Upstream commit 9801be8bef65dbcbc40c1a9c2f03d70ed67a5d30 ]

Drivers setting CPUFREQ_NEED_UPDATE_LIMITS expect target() to be
invoked even if the target frequency remains unchanged, so they can
update their internal policy limits state.

Currently the core invokes target() unconditionally whenever the
requested frequency matches policy->cur for such drivers, even if
policy->min and policy->max haven't changed since the previous update.

Track pending policy limit updates explicitly and skip redundant
target() invocations when neither the target frequency nor the
effective limits changed.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Lifeng Zheng <zhenglifeng1@huawei.com>
Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Link: https://patch.msgid.link/d0107c364b709abca21acf88072220bc05478594.1779423281.git.viresh.kumar@linaro.org
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

[ Backport note: also mark the limits as pending when a governor is initialized, so
a driver that depends on the governor's strict_target flag is still called
once after the switch even if the target frequency is unchanged. ]

Stable-dep-of: 75120f31aed0 ("cpufreq: Fix updates of cached resolved frequency and index")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/cpufreq.c | 34 +++++++++++++++++++++++++---------
 include/linux/cpufreq.h   |  3 +++
 2 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 962faa2463db6..9cb44be668dad 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2407,9 +2407,13 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
 	 * exactly same freq is called again and so we can save on few function
 	 * calls.
 	 */
-	if (target_freq == policy->cur &&
-	    !(cpufreq_driver->flags & CPUFREQ_NEED_UPDATE_LIMITS))
-		return 0;
+	if (target_freq == policy->cur) {
+		if (!(cpufreq_driver->flags & CPUFREQ_NEED_UPDATE_LIMITS) ||
+		    !policy->update_limits)
+			return 0;
+
+		policy->update_limits = false;
+	}
 
 	if (cpufreq_driver->target) {
 		/*
@@ -2492,6 +2496,9 @@ static int cpufreq_init_governor(struct cpufreq_policy *policy)
 
 	policy->strict_target = !!(policy->governor->flags & CPUFREQ_GOV_STRICT_TARGET);
 
+	/* strict_target may have changed; the driver must see the limits again. */
+	policy->update_limits = true;
+
 	return 0;
 }
 
@@ -2669,6 +2676,7 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 {
 	struct cpufreq_policy_data new_data;
 	struct cpufreq_governor *old_gov;
+	unsigned int freq;
 	int ret;
 
 	memcpy(&new_data.cpuinfo, &policy->cpuinfo, sizeof(policy->cpuinfo));
@@ -2701,12 +2709,20 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 	 * compiler optimizations around them because they may be accessed
 	 * concurrently by cpufreq_driver_resolve_freq() during the update.
 	 */
-	WRITE_ONCE(policy->max, __resolve_freq(policy, new_data.max,
-					       new_data.min, new_data.max,
-					       CPUFREQ_RELATION_H));
-	new_data.min = __resolve_freq(policy, new_data.min, new_data.min,
-				      new_data.max, CPUFREQ_RELATION_L);
-	WRITE_ONCE(policy->min, new_data.min > policy->max ? policy->max : new_data.min);
+	freq = __resolve_freq(policy, new_data.max, new_data.min, new_data.max,
+			      CPUFREQ_RELATION_H);
+	if (freq != policy->max) {
+		WRITE_ONCE(policy->max, freq);
+		policy->update_limits = true;
+	}
+
+	freq = __resolve_freq(policy, new_data.min, new_data.min, new_data.max,
+			      CPUFREQ_RELATION_L);
+	freq = min(freq, policy->max);
+	if (freq != policy->min) {
+		WRITE_ONCE(policy->min, freq);
+		policy->update_limits = true;
+	}
 
 	trace_cpu_frequency_limits(policy);
 
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 69034172a7558..696184149f6ed 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -148,6 +148,9 @@ struct cpufreq_policy {
 	/* The policy has been suspended. */
 	bool			suspended;
 
+	/* Pending policy->min/max update for the driver */
+	bool			update_limits;
+
 	 /* Cached frequency lookup from cpufreq_driver_resolve_freq. */
 	unsigned int cached_target_freq;
 	unsigned int cached_resolved_idx;
-- 
2.53.0

