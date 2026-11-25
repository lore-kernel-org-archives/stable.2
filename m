Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795624709;
	b=LoZLXjr/Q/mYQL6EjoqUdx4m2Auio/tQnW3z7W29W3d3+0fXd/RZoCOq6/dOuPfQb0mE
	 xdwas50t2ZUjGRvQIBMuSjt9Vq9QEnrOws8wvvzgS9PtGIPvkB69V7xwYcFe9RpVCEhpS
	 KdPomx2n2YScqBHpKI0SM8adUwW+xtfTmAvUY7sNc/2Oupq0QLuWuMTEtEXuqnzczt+qi
	 0ijDK3aI2NmUY9Lp05bYL2QvgVAAt336FKwndteiNoPJqANA9J3L/V2I0j8DSvTpRTlhU
	 UPm+BWsaiQ/n5ycRNocnvXj/sXbJmi+oMRWP6LgXt2FfeIrZudvGLqPnaBRqd+XdKTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624709;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=j6H1Wsa6fvuonAX8PxIpDtjvY3seVVvgqRGJnBVNAFU=;
	b=08Lv1gM7/siOSXOkRbVPd0WN+6w+0CY1NwTsEFocAN4bnCaZuwBSVDJQ7TJkgK0IJL0R
	 SJ6b4OoSJsJPXDIthx/kspZAOYkg8JxCgn+aWjFytnRgOusK3PLnVAmElNZKqQLa3gXHQ
	 4LqIPIBRE9msPrjO1Eikik4aVWhweGZw9nRoC3f+B7UDewgJenRfgGFFXn0ii4sAm7sSm
	 wS7+hk0XJw4Nfj89jtKFL3rET4XNLQbtESteizA34OLdktVOMc2cXo0o7KKrA9Jp7gO4z
	 jVbeK3qvVaVJ1flqWkigH9weL9eJdRdja9vLUkUBKUFxwW1pHJiDN+YlmeS0Aymw+Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LrxFNI0K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7439606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LrxFNI0K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08D21F000D0;
	Wed, 25 Nov 2026 16:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795624709;
	bh=j6H1Wsa6fvuonAX8PxIpDtjvY3seVVvgqRGJnBVNAFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LrxFNI0KnI2ZBcI/HP29B9MWXm0lRecwQgbLhd3R9P6M3Y8NEX72NzAV8d1ZIMe/O
	 b4y+YCi4STz1bqbNmdQ6jD91F+isLbKqtF9Q/VpzwUGLpgCwNdPq0HSVl2RxrFVxYZ
	 vp7WkVVfSOSAXjZUOZhLaZyqhzncptDhWV3G8hldc95CjtdMB+c1uBLi8KTWmFc+j+
	 JiXiKvjut9rG6ZwtPCmPNlggAoq2ZEOK2WuXoe/LVjGJIvIMnqoS8kwf8aNWV/GsiG
	 mrpx6M+cb/394w0EvH2htzEZx4B2WZILjGqP5scmvIAwOzX5RSt+Uut2kSoq9NceaB
	 ytMu1BTzK79tw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/4] cpufreq: Reuse cpufreq_driver_resolve_freq() in __cpufreq_driver_target()
Date: Wed, 25 Nov 2026 11:38:23 -0500
Message-ID: <20261125163734.823203-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125163734.823203-1-sashal@kernel.org>
References: <2026112528-unscrew-recall-9dd7@gregkh>
 <20261125163734.823203-1-sashal@kernel.org>
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

[ Upstream commit f9ccdec24d91ffddf1c6f4173b0e191fc08c7d14 ]

__cpufreq_driver_target() open codes cpufreq_driver_resolve_freq(), lets
make the former reuse the later.

Separate out __resolve_freq() to accept relation as well as an argument
and use it at both the locations.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Stable-dep-of: 166207cac451 ("cpufreq: Cache post-resolution target frequency in __resolve_freq()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/cpufreq.c | 42 ++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 69b7cd1146bbb..20df0efcfdc59 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -529,19 +529,8 @@ void cpufreq_disable_fast_switch(struct cpufreq_policy *policy)
 }
 EXPORT_SYMBOL_GPL(cpufreq_disable_fast_switch);
 
-/**
- * cpufreq_driver_resolve_freq - Map a target frequency to a driver-supported
- * one.
- * @policy: associated policy to interrogate
- * @target_freq: target frequency to resolve.
- *
- * The target to driver frequency mapping is cached in the policy.
- *
- * Return: Lowest driver-supported frequency greater than or equal to the
- * given target_freq, subject to policy (min/max) and driver limitations.
- */
-unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
-					 unsigned int target_freq)
+static unsigned int __resolve_freq(struct cpufreq_policy *policy,
+		unsigned int target_freq, unsigned int relation)
 {
 	target_freq = clamp_val(target_freq, policy->min, policy->max);
 	policy->cached_target_freq = target_freq;
@@ -550,7 +539,7 @@ unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
 		unsigned int idx;
 
 		idx = cpufreq_frequency_table_target(policy, target_freq,
-						     CPUFREQ_RELATION_L);
+						     relation);
 		policy->cached_resolved_idx = idx;
 		return policy->freq_table[idx].frequency;
 	}
@@ -560,6 +549,23 @@ unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
 
 	return target_freq;
 }
+
+/**
+ * cpufreq_driver_resolve_freq - Map a target frequency to a driver-supported
+ * one.
+ * @policy: associated policy to interrogate
+ * @target_freq: target frequency to resolve.
+ *
+ * The target to driver frequency mapping is cached in the policy.
+ *
+ * Return: Lowest driver-supported frequency greater than or equal to the
+ * given target_freq, subject to policy (min/max) and driver limitations.
+ */
+unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
+					 unsigned int target_freq)
+{
+	return __resolve_freq(policy, target_freq, CPUFREQ_RELATION_L);
+}
 EXPORT_SYMBOL_GPL(cpufreq_driver_resolve_freq);
 
 unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy)
@@ -2257,13 +2263,11 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
 			    unsigned int relation)
 {
 	unsigned int old_target_freq = target_freq;
-	int index;
 
 	if (cpufreq_disabled())
 		return -ENODEV;
 
-	/* Make sure that target_freq is within supported range */
-	target_freq = clamp_val(target_freq, policy->min, policy->max);
+	target_freq = __resolve_freq(policy, target_freq, relation);
 
 	pr_debug("target for CPU %u: %u kHz, relation %u, requested %u kHz\n",
 		 policy->cpu, target_freq, relation, old_target_freq);
@@ -2287,9 +2291,7 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
 	if (!cpufreq_driver->target_index)
 		return -EINVAL;
 
-	index = cpufreq_frequency_table_target(policy, target_freq, relation);
-
-	return __target_index(policy, index);
+	return __target_index(policy, policy->cached_resolved_idx);
 }
 EXPORT_SYMBOL_GPL(__cpufreq_driver_target);
 
-- 
2.53.0

