Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795628726;
	b=JGuuLO5FwrJnXPMOM+GwAEp5DMtxxjx0oiaCOLgjVKWX2du7GI98JwrWcyyApLwU2uIp
	 FooRSHYqq3VvWkC3pREoRrqBGmMJ0FSvQaFY6y7lns5x8tnQAkYGFpLOFr7GWonTxALXx
	 gahKJGlK2r+hRmJ9NhRLJmMgAVvWBUxFgoRxMcAhHXwd1tERvLqnS7eXQrm8woiz/s5vC
	 R/9B8unpXv1ZMB/ImwvWnV92bY901tKNDSTZX+gzrNQO9dX702VZ+RGpiZ/u9jmj6a40G
	 4QuHpjZNbXUyu7KXMctJ21rrsgRy38tI90c7MsqdxfDcWpnX2VVB7lx8nzKx8FEkLDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795628726;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Mbs2CDYdpvIwC7iZe5bWjKLeMBBCsiRoWbhpe2c2z4w=;
	b=hnLs3iVvUHwGm7FYRQ3gqRzpMRA9dlAH1JXMeCBjA2PjESKvM/sipM9DShlkoNi/Q1DE
	 PxX8Rg9bTOO4GYDCcf1T0VXWpoBtS0MI2N+COLkRfACTZi0NXe0w9jgpuSRYThiuu+GWI
	 HvXmEF9S7Rl+guq1E8/zVpgU5pDRmPR4RCo1siXnIbUjHjiPdfUoBjVKJbBP+9xIunZ5/
	 tbdpCF6z86kuZ4Tpgrk0O1VcF4RCUuu/OsYJO+Jn2TCtGUYNBuG1g8HZk8xDKLazfYgJX
	 ytcX+JLRxlSZC9Rh4e1l+bnvOzHSaXicQ3IUbpoPS/kN2r0wp7Ilf8Go7TWQz0H/kkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ybni0wnf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BB0606A33D
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ybni0wnf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 395D31F000C6;
	Wed, 25 Nov 2026 17:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795628725;
	bh=Mbs2CDYdpvIwC7iZe5bWjKLeMBBCsiRoWbhpe2c2z4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ybni0wnfsAeKDEARhRhD6oLiS8I30CYBvJdNz4Neq5uFvOXb29v7Cw52V3ITEHPI+
	 7c/1CGNC8i7bO/UG6/xVZlXHfdmqQswaQwpa3Q9UDkNxvwhN1bZsYhdSw/OG239/41
	 KmknN4w03398yxCE154FvgS1b/6H2+KGYP2f2JHnhJDuUW87gsKOcMv3+y9cqfh6dN
	 Tw0wbjAppFwAdATYIydhZ3PjnUel/hidOQ8zKWJK5fKtmQ1+tCuqIvteTJrFa6nV8R
	 DPJLoS22BHF6YwlabFaOnZYjJrfVboR94oDWFPEmn6rp1qYofKE2+DkbvrPc9+1MRQ
	 8DkthuwjYfvuA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] cpufreq: Fix updates of cached resolved frequency and index
Date: Wed, 25 Nov 2026 12:45:23 -0500
Message-ID: <20261125174510.1022036-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112540-waviness-hybrid-1428@gregkh>
References: <2026112540-waviness-hybrid-1428@gregkh>
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
[ sashal: adapted __resolve_freq() to the older signature by adding an index out-parameter and moving the cache updates into cpufreq_driver_resolve_freq(), without the min/max and force_target rework. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/cpufreq.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index fcddf5c41814b..ebda3cf938246 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -530,7 +530,8 @@ void cpufreq_disable_fast_switch(struct cpufreq_policy *policy)
 EXPORT_SYMBOL_GPL(cpufreq_disable_fast_switch);
 
 static unsigned int __resolve_freq(struct cpufreq_policy *policy,
-		unsigned int target_freq, unsigned int relation)
+		unsigned int target_freq, unsigned int relation,
+		unsigned int *idx_p)
 {
 	unsigned int idx;
 
@@ -540,9 +541,10 @@ static unsigned int __resolve_freq(struct cpufreq_policy *policy,
 		return target_freq;
 
 	idx = cpufreq_frequency_table_target(policy, target_freq, relation);
-	policy->cached_resolved_idx = idx;
-	policy->cached_target_freq = policy->freq_table[idx].frequency;
-	return policy->cached_target_freq;
+	if (idx_p)
+		*idx_p = idx;
+
+	return policy->freq_table[idx].frequency;
 }
 
 /**
@@ -559,7 +561,10 @@ static unsigned int __resolve_freq(struct cpufreq_policy *policy,
 unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
 					 unsigned int target_freq)
 {
-	return __resolve_freq(policy, target_freq, CPUFREQ_RELATION_L);
+	policy->cached_target_freq = __resolve_freq(policy, target_freq,
+						    CPUFREQ_RELATION_L,
+						    &policy->cached_resolved_idx);
+	return policy->cached_target_freq;
 }
 EXPORT_SYMBOL_GPL(cpufreq_driver_resolve_freq);
 
@@ -2318,11 +2323,12 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
 			    unsigned int relation)
 {
 	unsigned int old_target_freq = target_freq;
+	unsigned int idx = 0;
 
 	if (cpufreq_disabled())
 		return -ENODEV;
 
-	target_freq = __resolve_freq(policy, target_freq, relation);
+	target_freq = __resolve_freq(policy, target_freq, relation, &idx);
 
 	pr_debug("target for CPU %u: %u kHz, relation %u, requested %u kHz\n",
 		 policy->cpu, target_freq, relation, old_target_freq);
@@ -2343,7 +2349,7 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
 	if (!cpufreq_driver->target_index)
 		return -EINVAL;
 
-	return __target_index(policy, policy->cached_resolved_idx);
+	return __target_index(policy, idx);
 }
 EXPORT_SYMBOL_GPL(__cpufreq_driver_target);
 
@@ -2607,12 +2613,10 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 	 */
 	policy->min = new_data.min;
 	policy->max = new_data.max;
-	policy->min = __resolve_freq(policy, policy->min, CPUFREQ_RELATION_L);
-	policy->max = __resolve_freq(policy, policy->max, CPUFREQ_RELATION_H);
+	policy->min = __resolve_freq(policy, policy->min, CPUFREQ_RELATION_L, NULL);
+	policy->max = __resolve_freq(policy, policy->max, CPUFREQ_RELATION_H, NULL);
 	trace_cpu_frequency_limits(policy);
 
-	policy->cached_target_freq = UINT_MAX;
-
 	pr_debug("new min and max freqs are %u - %u kHz\n",
 		 policy->min, policy->max);
 
@@ -2638,6 +2642,12 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
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

