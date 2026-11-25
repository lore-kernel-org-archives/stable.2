Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795626572;
	b=vQ746sIFy73AqinLmaYHNCCLOdloLRHLZL78zAhqV2X2iVkun+kOHUFbd0JeOKqT+VYO
	 KhkswfW3ImjIzU3d8fOcunvmhgYJkJQ88ocGMEW69rKkqRBsCAODhyrAcS2S2tyJF9XbL
	 ij4GIDK42MfM/5Lta+sMFDxDylFfxayRfLCnXlc7YFaSIoq0KBWQCeBWlBQ/T9taZpizW
	 1ATI+yyZmoLVfRc7iI282c5i8+lhMOSKJBV9rmZS+qxeXqHtpXkULbgWUueuFoGeR4CAx
	 3S01RwkSWLVZEg2f8vOjsc4Q145YPRlkn1Pdze8VGafuh4kUU6D8XcBC0VY2oY4XEog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626572;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mfDGxiWXdncMJR8FftwC7EZXhHFkYZtV/wEhPTFJe3o=;
	b=UehSSLpVn3hYVAcoyR2yaJNrBY4O2Q4qpkJyu0m6Rsee/dAv0jiT8KAhWl9XBYc47m5/
	 89ZSlIItr4usa+Y3YXYu54p9CtNBvh11U2mJOaIFVltYkSvlsOsuWPmOYwLa6Pce1z+GK
	 jmnoRiUHBSzMMzBlzTfVLAMJRxpzif6rboEvLPebHOg9ttKAMQrLwhXftjiBHy4rFl6GH
	 q9cmpPclg+t3eqkQbVeqnJ+NvNVnV0cHU8gCtvdGvuOJYYt0Q0LaSWkYUNRQyL8tlicFX
	 7BhlRmJLjNYsGG3e1TkcK1dAJQmznYse8/j8JSyQ20PAiSya/RpkcC7ARV7ny3IljTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g2CdJtxD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3887E606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g2CdJtxD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE1E1F000D4;
	Wed, 25 Nov 2026 17:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795626571;
	bh=mfDGxiWXdncMJR8FftwC7EZXhHFkYZtV/wEhPTFJe3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g2CdJtxDCcVL59xOQUb6Br6FeqnpiNQxQDIz+5qBgfDbmUHUtm0RymeyGb50uAli0
	 FFTaqnet1cTIFkNvLEZQ72tmqxWCjzBC+0U4wQEUvqrEkzGEn2/k3OK26op7B0J+6a
	 /T1SK/iJvYBan2qyoeiDLA+EqOGbkn2vP3dRF7qLXIwRyniURpLpASv31Jwpw7oakX
	 LQWb1rKOSg412KQtctGvsIoiSQ5Q+QpEz/lrNvl16WIUM8aG2VSleVDZfkh9QI2Muc
	 nPQB8glg43z4aOo3ldtZGsuy7wPPk8I1yoZ8Fgs64uH032yon6aWEOklcRbRH8EtfU
	 /IWnbvgadkufQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] cpufreq: Fix updates of cached resolved frequency and index
Date: Wed, 25 Nov 2026 12:09:27 -0500
Message-ID: <20261125170915.923901-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125170915.923901-1-sashal@kernel.org>
References: <2026112538-unwomanly-unwrapped-9118@gregkh>
 <20261125170915.923901-1-sashal@kernel.org>
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
index 7b3023fca6183..04549c7f1f0b4 100644
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
 
@@ -2339,12 +2343,13 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
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
@@ -2377,7 +2382,7 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
 	if (!cpufreq_driver->target_index)
 		return -EINVAL;
 
-	return __target_index(policy, policy->cached_resolved_idx);
+	return __target_index(policy, idx);
 }
 EXPORT_SYMBOL_GPL(__cpufreq_driver_target);
 
@@ -2682,14 +2687,14 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
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
@@ -2700,8 +2705,6 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 
 	cpufreq_update_pressure(policy);
 
-	policy->cached_target_freq = UINT_MAX;
-
 	pr_debug("new min and max freqs are %u - %u kHz\n",
 		 policy->min, policy->max);
 
@@ -2727,6 +2730,12 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
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

