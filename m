Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795628379;
	b=2tbypkRWEtuU1NTIBGKxsU+c66NLKJ9zqVfo7rdiVx00Siqq/irFnv6w8MD4ih0RgwZK
	 i4hRd/FkR0is7EBGZt+1uRDEvuJ2+vSSoGNRKPpMmn99dlnshftSUC/9KYNb92PSwCWa+
	 oeiZUdX3cVYIfLGAYDwn5wVEL13vPos2O7fvto3Kk0OQyA/Y4q3/GGS0XbuGCXnliQgXr
	 /3bvvX8ek9pdn6VhElrHJuNoKZQUysOAJbkHkZ4TSoS/jM+Gc/og82KBx7vTp4sMHhnZF
	 mqqCBMLyBSgZEOO1K/VYvC2CtwdGfL61RAtpNaQPy1GJcGkl8QdrtRonts5HdDo8V4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795628379;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=jyGS8E25ZjreaX3rLt7CoqCeneEQW/yTcsrvEZeQ0O4=;
	b=43wkDA4MXBjq1hKxqFV6BvX0RJHvZjLcDdm2csXQtanRYFApkXwhM87I/Ufcs8a7FTmC
	 O3yLq9KSpS4tFCH8XoqmQ0V8qngvyAG3YHynlf+I3JsKrq6+iV1m+sEOtyL8bLnEmsVbK
	 82yib2c2jb9kWfDx9MGLhe/MdXeHH98R2DBpJW1uC9loABxF1OdJ0bYcSj+yqJy7nOKVk
	 YlP2qVarHo3ip1zcr3qrMKPR5WD+9zQJIBqa3YPWeS3xMKFf03ZBHmGKkfmZ7br/lgPDW
	 T2jfeAtnwm+6gYVgk6aYRyFEi6ZP3H0ug3MAPbd5EN6lBQRhx0uOumTqKZK3v1unrWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XCJNzPyd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471AE606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XCJNzPyd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E5CE1F000D1;
	Wed, 25 Nov 2026 17:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795628379;
	bh=jyGS8E25ZjreaX3rLt7CoqCeneEQW/yTcsrvEZeQ0O4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XCJNzPydiJbXSRasudU1Ixme+h9xZoXIHS1oiHXUcT9Qk3VWXxAAH9/Kwq6Qbmoh1
	 75f0SJkBLO8sTuF0ukzmAfKwdDE+MdcC3KQC9ebepxxfDdJBB+kat/E+KGgWak4tVo
	 dxGiRzjEk58qZJnJChg+zTq7lKFzi0zX0x2XzP8acFLnK0QoKjwXLJu6+o/k00bBXv
	 nPjcxyRV+xhFBJ83PYn4vXjhEsrvnTYkSx3i9RjF/Kpkk1m0Wt1LvNvuWiiSSZ3dFs
	 BOOBxwbx+sGAhfq2dqM9ky3QyMxWvZUuVgnsvVnBXMH9pltsv+tL/xCubZEIJ8AY09
	 nsCxcX0egVmnQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] cpufreq: Fix updates of cached resolved frequency and index
Date: Wed, 25 Nov 2026 12:39:36 -0500
Message-ID: <20261125173924.996091-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112539-unusable-huff-d3fe@gregkh>
References: <2026112539-unusable-huff-d3fe@gregkh>
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
[ sashal: adjusted cpufreq_set_policy() to keep the older WRITE_ONCE min/max resolution, adding only the NULL idx argument and removing the early cached_target_freq = UINT_MAX, since force_target/pressure code is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/cpufreq.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 2c06fc7451663..dfd9fb2bfbc32 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -532,7 +532,7 @@ EXPORT_SYMBOL_GPL(cpufreq_disable_fast_switch);
 static unsigned int __resolve_freq(struct cpufreq_policy *policy,
 				   unsigned int target_freq,
 				   unsigned int min, unsigned int max,
-				   unsigned int relation)
+				   unsigned int relation, unsigned int *idx_p)
 {
 	unsigned int idx;
 
@@ -542,9 +542,10 @@ static unsigned int __resolve_freq(struct cpufreq_policy *policy,
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
@@ -575,7 +576,10 @@ unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
 	if (unlikely(min > max))
 		min = max;
 
-	return __resolve_freq(policy, target_freq, min, max, CPUFREQ_RELATION_LE);
+	policy->cached_target_freq = __resolve_freq(policy, target_freq, min, max,
+						    CPUFREQ_RELATION_LE,
+						    &policy->cached_resolved_idx);
+	return policy->cached_target_freq;
 }
 EXPORT_SYMBOL_GPL(cpufreq_driver_resolve_freq);
 
@@ -2345,12 +2349,13 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
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
@@ -2379,7 +2384,7 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
 	if (!cpufreq_driver->target_index)
 		return -EINVAL;
 
-	return __target_index(policy, policy->cached_resolved_idx);
+	return __target_index(policy, idx);
 }
 EXPORT_SYMBOL_GPL(__cpufreq_driver_target);
 
@@ -2647,15 +2652,13 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 	 */
 	WRITE_ONCE(policy->max, __resolve_freq(policy, new_data.max,
 					       new_data.min, new_data.max,
-					       CPUFREQ_RELATION_H));
+					       CPUFREQ_RELATION_H, NULL));
 	new_data.min = __resolve_freq(policy, new_data.min, new_data.min,
-				      new_data.max, CPUFREQ_RELATION_L);
+				      new_data.max, CPUFREQ_RELATION_L, NULL);
 	WRITE_ONCE(policy->min, new_data.min > policy->max ? policy->max : new_data.min);
 
 	trace_cpu_frequency_limits(policy);
 
-	policy->cached_target_freq = UINT_MAX;
-
 	pr_debug("new min and max freqs are %u - %u kHz\n",
 		 policy->min, policy->max);
 
@@ -2681,6 +2684,12 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
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

