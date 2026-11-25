Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795628045;
	b=caaooJ2NrzpZxuF8Jeu7jsPOwOVj3kDnaTQopk681nEBF9sH48eW81yRA0/c7+pI7MrH
	 U+xbeGh51PpSdJ1zOIqQtzar4D47r3jfS/GAgXgmkY9ocdq+p37n0+8FHLoIatzE6hGk1
	 k0NfXvlLPrNP5p0KhuF+Wfu1SpDFOZx4ZsKzcApv8r171/dTUfAMQF8mV7OaLxzfE52mi
	 mfON96rcJu7BGI1e3p3PtpSsDZdMxp6DT8/pPsvD3YqYXw7fLuPMk683/R7xJnsY4Bgoc
	 MwdKkD9EnPQQ6fRp3Pe6UhuDw2KQELz3TumtrKbKEVUlHwmCT0rDZWYYWPsaZro9KJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795628045;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lU7UAIgI9CyUCZsuIIYmZpPJHaKhZZHl7DYSw6EZjM8=;
	b=c9tt4f4q/Xefv9M3Y3uAUnbFwrJx92Emzg1JP4SUc+VaBwE8zwAiRCR4W1XUPq8GHjB6
	 HEBLCNL3MVGGqoTc/tlA0n7R1/pj3SiKOyre/KZmewnKALQByifPnjlV+83KNB3vl3M3A
	 2u81MnMhiVZcXEJCcz02feb3LG56RzVeIdxnzR8zuyYgmBbmPr7bOdxHgQdsTWrLhSOaP
	 dl42iHDCD0dJxBHyx15ovH+4ZUsJBBpscJUSdlNnabKnTsIJFQhV9UDKsSY5dhUWSUDnA
	 RyGnD3X2RkHz4UyP0kQTJUSeUwMI+IYmjzNpBGLc6nWcdwUVg+/Y8uIwSryO+Z7q+Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GFrR7M9P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4523E606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GFrR7M9P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C48271F000C0;
	Wed, 25 Nov 2026 17:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795628045;
	bh=lU7UAIgI9CyUCZsuIIYmZpPJHaKhZZHl7DYSw6EZjM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GFrR7M9PXofAmQtSV4sGUeIM5dYAcPOKicL+GCNnWoYsSnO4A6pTwMn4P14CbiKes
	 z6qhbjlHn6eSPPdbLIEJF9hFIjAX6imkbR5+k8wroTPIOE0FOi+MIgMZDv1URpLr5S
	 T0nNtcSqi92bZQ4ZeokGSM+c/zydf9TjTVOKzvL0PCHgW0hW5hwavYtf+wRvhiYiWr
	 fHV9uuO6zhaArWHh/wMoU1pjzlQhH+dCGdfyRfzLJLHJ5YjpZiCZu34KzSFSV+TdJI
	 eL0rbP7f4CNGo0CFSD6VjN366JSdWb4ZPT7cA+8DQiH2txJ5MpRH6S0OUyoRTqzicM
	 /PDWFwl7hDPjw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] cpufreq: Fix updates of cached resolved frequency and index
Date: Wed, 25 Nov 2026 12:33:59 -0500
Message-ID: <20261125173332.948887-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125173332.948887-1-sashal@kernel.org>
References: <2026112539-twine-magnify-87fa@gregkh>
 <20261125173332.948887-1-sashal@kernel.org>
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

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit 75120f31aed010c326b28d7c80d22314df34d9a8 ]

The cached resolved frequency and index, cached_target_freq and
cached_resolved_idx, respectively, may be updated concurrently if
cpufreq_driver_resolve_freq() is called by the schedutil governor
while cpufreq_set_policy() is running for the same policy.  Those
concurrent updates are not synchronized in any way and the values
written by cpufreq_set_policy(), if it wins the race, may confuse
drivers using those policy fields [1].

To address this, use the observation that the only place where
cached_target_freq and cached_resolved_idx need to be updated is
cpufreq_driver_resolve_freq() because the only legitimate users of
them are .fast_switch() driver callbacks.  Although cached_resolved_idx
is also used in __cpufreq_driver_target(), that is in fact unnecessary
and it is better to use a local variable for storing the frequency
table index in that function.

Accordingly, rearrange __resolve_freq() and its callers so that
cached_target_freq and cached_resolved_idx are only updated in
cpufreq_driver_resolve_freq().

The cached_target_freq initialization in cpufreq_set_policy() is still
needed, but move it after stopping the old governor and before starting
the new one to avoid racing with cpufreq_driver_resolve_freq().

Fixes: f9ccdec24d91 ("cpufreq: Reuse cpufreq_driver_resolve_freq() in __cpufreq_driver_target()")
Fixes: 151717690694 ("cpufreq: Make policy min/max hard requirements")
Reported-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Closes: https://lore.kernel.org/linux-pm/20261105140357.1331894-1-zhongqiu.han@oss.qualcomm.com/ [1]
Co-developed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Christian Loehle <christian.loehle@arm.com>
Tested-by: Christian Loehle <christian.loehle@arm.com>
Cc: All applicable <stable@vger.kernel.org> # 342d3a73c5db cpufreq: Force passing target frequency to driver during resume
Cc: All applicable <stable@vger.kernel.org> # 166207cac451 cpufreq: Cache post-resolution target frequency in __resolve_freq()
Link: https://patch.msgid.link/3472677.aeNJFYEL58@rafael.j.wysocki
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
[ sashal: Dropped the missing cpufreq_update_pressure() context line from the cpufreq_set_policy() hunk, so only the early cached_target_freq = UINT_MAX removal remains. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/cpufreq.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index e8d4d0ca1fdc5..d6284f9e02cff 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -537,7 +537,7 @@ EXPORT_SYMBOL_GPL(cpufreq_disable_fast_switch);
 static unsigned int __resolve_freq(struct cpufreq_policy *policy,
 				   unsigned int target_freq,
 				   unsigned int min, unsigned int max,
-				   unsigned int relation)
+				   unsigned int relation, unsigned int *idx_p)
 {
 	unsigned int idx;
 
@@ -547,9 +547,10 @@ static unsigned int __resolve_freq(struct cpufreq_policy *policy,
 		return target_freq;
 
 	idx = cpufreq_frequency_table_target(policy, target_freq, min, max, relation);
-	policy->cached_resolved_idx = idx;
-	policy->cached_target_freq = policy->freq_table[idx].frequency;
-	return policy->cached_target_freq;
+	if (idx_p)
+		*idx_p = idx;
+
+	return policy->freq_table[idx].frequency;
 }
 
 /**
@@ -580,7 +581,10 @@ unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
 	if (unlikely(min > max))
 		min = max;
 
-	return __resolve_freq(policy, target_freq, min, max, CPUFREQ_RELATION_LE);
+	policy->cached_target_freq = __resolve_freq(policy, target_freq, min, max,
+						    CPUFREQ_RELATION_LE,
+						    &policy->cached_resolved_idx);
+	return policy->cached_target_freq;
 }
 EXPORT_SYMBOL_GPL(cpufreq_driver_resolve_freq);
 
@@ -2351,12 +2355,13 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
 			    unsigned int relation)
 {
 	unsigned int old_target_freq = target_freq;
+	unsigned int idx = 0;
 
 	if (cpufreq_disabled())
 		return -ENODEV;
 
 	target_freq = __resolve_freq(policy, target_freq, policy->min,
-				     policy->max, relation);
+				     policy->max, relation, &idx);
 
 	pr_debug("target for CPU %u: %u kHz, relation %u, requested %u kHz\n",
 		 policy->cpu, target_freq, relation, old_target_freq);
@@ -2389,7 +2394,7 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
 	if (!cpufreq_driver->target_index)
 		return -EINVAL;
 
-	return __target_index(policy, policy->cached_resolved_idx);
+	return __target_index(policy, idx);
 }
 EXPORT_SYMBOL_GPL(__cpufreq_driver_target);
 
@@ -2657,14 +2662,14 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 	 * concurrently by cpufreq_driver_resolve_freq() during the update.
 	 */
 	freq = __resolve_freq(policy, new_data.max, new_data.min, new_data.max,
-			      CPUFREQ_RELATION_H);
+			      CPUFREQ_RELATION_H, NULL);
 	if (freq != policy->max) {
 		WRITE_ONCE(policy->max, freq);
 		policy->update_limits = true;
 	}
 
 	freq = __resolve_freq(policy, new_data.min, new_data.min, new_data.max,
-			      CPUFREQ_RELATION_L);
+			      CPUFREQ_RELATION_L, NULL);
 	freq = min(freq, policy->max);
 	if (freq != policy->min) {
 		WRITE_ONCE(policy->min, freq);
@@ -2673,8 +2678,6 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 
 	trace_cpu_frequency_limits(policy);
 
-	policy->cached_target_freq = UINT_MAX;
-
 	pr_debug("new min and max freqs are %u - %u kHz\n",
 		 policy->min, policy->max);
 
@@ -2700,6 +2703,12 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 		cpufreq_exit_governor(policy);
 	}
 
+	/*
+	 * Initialize cached_target_freq while no governor is running to avoid
+	 * racing with cpufreq_driver_resolve_freq(), which updates it.
+	 */
+	policy->cached_target_freq = UINT_MAX;
+
 	/* start new governor */
 	policy->governor = new_gov;
 	ret = cpufreq_init_governor(policy);
-- 
2.53.0

