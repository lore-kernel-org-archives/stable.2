Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795626133;
	b=Yx0I+yz3OqQhOkmoiPt/LZAV95HC7L4FEh0Bc31gXU2r9wDgFQxOlL4NR6kbdpHKKu8X
	 lbozBU7BuqDjsC2WDJ4bahHGShnHsG3JSQJnLygIEN9qsYEluTn2qWV4IrkQETV7HJXZD
	 zA6CDpfNoFM61caaAWLdNVK2VyGX7tpPHQmcltjpwt4zuipUlWWsywA3KwsIFysFS173h
	 x8lodK0LGNilkIiKZre/fUCRbTKL3PrM7MaKXb+gsGeLrWAYdEpXAtqwcb5HkX8H7AFDg
	 h70lRimWP8zRTUgUJH5BcTsS5T3nuoRBMbRvQFPhajXCEaq2QsTg5h7RenUuHTM7xmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626133;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MbRbM7VCQ0E7vm32SQpP2dG6wgESIEg2Ydq6vGVS36U=;
	b=JzQe0+4ojeZ+pPAg1v96Okm+uVNb9vHxlOvNBHVdVfzCEWn3glDbaEg3eMDELfx3zb69
	 vu+IbbzTx/kPAIPGThDp5n4doHWnRvh9GfVz2R8D8UQoofBNQ+TMwleBgSSjzAvgSkKzb
	 GGwyw5qO8E/Ju9H78CtWon+S7oZ5RZM+DT7m6uLUSKVF6C0DKehYFyFH9MoNoblSI35N1
	 qFBfZmYBi/9yzA/nBhNUNpIzUamGkvRLy0T4R5NUNxEZ25LkZ9wut6JNbOZ3Q83XIFDWs
	 NGvn8ykZduPkVuHxIPqUbKfKvDECVoSDFk1FAnJdsIlalKOaYqHsARCcCM0xoOvs7HA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aAr42G0U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9694606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aAr42G0U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A321F000C0;
	Wed, 25 Nov 2026 17:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795626133;
	bh=MbRbM7VCQ0E7vm32SQpP2dG6wgESIEg2Ydq6vGVS36U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aAr42G0UmAA0ndHb0q1xRP8PfzdkFKJGUA+Rtqz3kdafkHNvH6qn9fkE4YpFIJJFh
	 k+kCRZtOFxbMZFSpJHhkSM4wmxGNRyOK69w+UjTPPqRhlXjFTV8uDx3hPIQpUHvbER
	 fq45fzi3utECGNxf/uzNoNcTbN7zWwiKZ0Ktl0gU8FuMlsyhSPi5+b0EkFub6t3+ZJ
	 KOydLr9SE3m3bmEx8wpKdUfQ20+sTN/nWL+KkVG40RzeL+vM8g2ZcQEl1KTZgSoeci
	 6IWoEtZGD3Ymrg2iQsyUFzkyz0mlQzE45CrSktvRYDGdFRfJIsMkztaABBJ6LwHtjs
	 IMX3A6YItrNpw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] cpufreq: Fix updates of cached resolved frequency and index
Date: Wed, 25 Nov 2026 12:02:10 -0500
Message-ID: <20261125170141.823504-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125170141.823504-1-sashal@kernel.org>
References: <2026112538-playset-untold-8b24@gregkh>
 <20261125170141.823504-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/cpufreq.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 9cb44be668dad..32c628385c693 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -498,7 +498,7 @@ EXPORT_SYMBOL_GPL(cpufreq_disable_fast_switch);
 static unsigned int __resolve_freq(struct cpufreq_policy *policy,
 				   unsigned int target_freq,
 				   unsigned int min, unsigned int max,
-				   unsigned int relation)
+				   unsigned int relation, unsigned int *idx_p)
 {
 	unsigned int idx;
 
@@ -508,9 +508,10 @@ static unsigned int __resolve_freq(struct cpufreq_policy *policy,
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
@@ -541,7 +542,10 @@ unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
 	if (unlikely(min > max))
 		min = max;
 
-	return __resolve_freq(policy, target_freq, min, max, CPUFREQ_RELATION_LE);
+	policy->cached_target_freq = __resolve_freq(policy, target_freq, min, max,
+						    CPUFREQ_RELATION_LE,
+						    &policy->cached_resolved_idx);
+	return policy->cached_target_freq;
 }
 EXPORT_SYMBOL_GPL(cpufreq_driver_resolve_freq);
 
@@ -2391,12 +2395,13 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
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
@@ -2429,7 +2434,7 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
 	if (!cpufreq_driver->target_index)
 		return -EINVAL;
 
-	return __target_index(policy, policy->cached_resolved_idx);
+	return __target_index(policy, idx);
 }
 EXPORT_SYMBOL_GPL(__cpufreq_driver_target);
 
@@ -2710,14 +2715,14 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
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
@@ -2728,8 +2733,6 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 
 	cpufreq_update_pressure(policy);
 
-	policy->cached_target_freq = UINT_MAX;
-
 	pr_debug("new min and max freqs are %u - %u kHz\n",
 		 policy->min, policy->max);
 
@@ -2755,6 +2758,12 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
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

