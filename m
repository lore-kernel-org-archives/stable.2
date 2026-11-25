Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795624036;
	b=Yj5X/k/EafIVvoOzUajAS383IBvE/A+HyjeNjzUDcMzgU4xak0gkjfBAX66abyUDXlTK
	 Bcy/7saw/RPnRN3xq75UOq6kMTA37Ka9oweXC6Xij3usHmsxinz0mTD22nuNLrQS1Es1r
	 pnlvnkD7Qr2r6rQPRQbdS9UQ6JDHxPJgNAdGaAcVOZ9LzJIj5DP37UF5xOFKSWOq8Antc
	 46RhPEfbYSzYqcv3/me2X4xo59ftACnUkhKr/Gy3ybDjPazJUUqSp3sdNuw9ECrArphwk
	 rEE81elZcKzzjeAXOs7xXwJpKU4PR/E5nVNLHAZb1rni30YtJj6LV730WYXYUtcXrLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624036;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pbvuZLyl6xpTIk1fxLXzPLN56wz8PFOh6CYWxljC/xU=;
	b=tT5ZEMrSA2u+LLwYIHSHBjAnTq0bdCtnyxj9gejZwgHVxqcZQJv2N8VSitX1WvO+bZEF
	 3yG0quxykXyMoTtCOqnzmB+uBzGJBTWwkugPvkGlBr6/oNpm01s+ymfi6FW/DqDf8pIUi
	 GtA5TF9eggbOlSCUkrxx9wA8/3bGE73mrAa29yV36KrcYfiAOmBg1eWA+bOQgPByW5oWn
	 hQSUG3wpY21h3Drs0HSegn6Y0R2ITb5c75iiMCc/bI6h4CtEG2r/UPzEU0BC4hbGuzFX7
	 0zVh7Jq5BXMennMOTXNFgDtdkh1lZvkAXx4Cpwcxv3AomBiOpK2lqTeCFP7Qcbi6p3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K3eFnhCZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B940606A327
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K3eFnhCZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D286A1F000D1;
	Wed, 25 Nov 2026 16:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795624035;
	bh=pbvuZLyl6xpTIk1fxLXzPLN56wz8PFOh6CYWxljC/xU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K3eFnhCZ5ou3Q3KG6joUm4ymwpH0HurQp4CwCraaQL/1dKX6skD8Grr9gfH1Pfjqm
	 HHriOb1PF17s8mdxAbCdI/Wyk/4vxz7IhhSCRcu0xubAi8c1mlRNmTOoFxffMcxpAa
	 Etu1C2cpt/m/lcHncpm/qb0u7Ql+FnLOqBEpwMB+9LtHN8qrKR76s3KALoMQGnMgF+
	 jQ2lwGh4iqa5yu3jGPdnfU2Np5cbzUH7gNrvv1QqOpbLpQ9EtgS4v+Hi3a0KCYnojL
	 xeZ/SiNHMLIOxDTWTMfFTpo03K7ssXE2FBRYLF74TRivnExvsfnTIZXdRu4ONizQ0j
	 1d4etcL+KQPaw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Zak Brighton Knight <zakbrightonknight@gmail.com>,
	Doug Smythies <dsmythies@telus.net>,
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Christian Loehle <christian.loehle@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] cpufreq: Force passing target frequency to driver during resume
Date: Wed, 25 Nov 2026 11:27:12 -0500
Message-ID: <20261125162652.774210-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125162652.774210-1-sashal@kernel.org>
References: <2026112508-whenever-distress-43ae@gregkh>
 <20261125162652.774210-1-sashal@kernel.org>
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

[ Upstream commit 342d3a73c5dbc2f1cd0c5142e2d11bda4dc54cd7 ]

The policy->cur value preserved across a system suspend-resume cycle
may become stale in some cases and it may prevent the CPU performance
scaling logic from being updated due to the target_freq == policy->cur
check in __cpufreq_driver_target() [1].

To address this, adjust the existing mechanism to force the invocation
of the driver .target() callback in __cpufreq_driver_target() and make
cpufreq_resume_policy() use it.

This involves renaming update_limits in struct cpufreq_policy to
force_target and moving the driver CPUFREQ_NEED_UPDATE_LIMITS flag check
from __cpufreq_driver_target() to cpufreq_set_policy(), where it is used
as a condition for setting policy->force_target.

In cpufreq_resume_policy(), policy->force_target is set for drivers that
implement the .target() callback, but don't implement the .get() one,
which is the case when the driver callback needs to run if policy->cur
becomes stale while suspended.

Fixes: 2f0aea936360 ("cpufreq: suspend governors on system suspend/hibernate")
Link: https://lore.kernel.org/linux-pm/20261027143725.3763827-1-zakbrightonknight@gmail.com/ [1]
Reported-by: Zak Brighton Knight <zakbrightonknight@gmail.com>
Reported-by: Doug Smythies <dsmythies@telus.net>
Cc: All applicable <stable@vger.kernel.org> # eee2a44e4e2b cpufreq: Improve suspend-resume synchronization
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Zak Brighton Knight <zakbrightonknight@gmail.com>
Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Tested-by: Doug Smythies <dsmythies@telus.net>
Tested-by: Christian Loehle <christian.loehle@arm.com>
Link: https://patch.msgid.link/1995295.tdWV9SEqCh@rafael.j.wysocki
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/cpufreq.c | 33 +++++++++++++++++++++------------
 include/linux/cpufreq.h   |  4 ++--
 2 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 94f611512cfc8..cd2eb696548b7 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2029,6 +2029,15 @@ static void cpufreq_resume_policy(struct cpufreq_policy *policy, bool start)
 	if (!start)
 		return;
 
+	/*
+	 * Force executing the driver .target() callback, if present, in the
+	 * next invocation of __cpufreq_driver_target() in case policy->cur has
+	 * become stale while suspended, but do it only for drivers without a
+	 * .get() callback for which cpufreq_verify_current_freq() is a NOP.
+	 */
+	if (cpufreq_driver->target && !cpufreq_driver->get)
+		policy->force_target = true;
+
 	if (cpufreq_start_governor(policy))
 		pr_err("%s: Failed to start governor for CPU%u's policy\n",
 		       __func__, policy->cpu);
@@ -2402,17 +2411,14 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
 		 policy->cpu, target_freq, relation, old_target_freq);
 
 	/*
-	 * This might look like a redundant call as we are checking it again
-	 * after finding index. But it is left intentionally for cases where
-	 * exactly same freq is called again and so we can save on few function
-	 * calls.
+	 * Unless invoking the target callback is forced, skip the update if the
+	 * frequency is not really changing.
 	 */
-	if (target_freq == policy->cur) {
-		if (!(cpufreq_driver->flags & CPUFREQ_NEED_UPDATE_LIMITS) ||
-		    !policy->update_limits)
-			return 0;
-
-		policy->update_limits = false;
+	if (policy->force_target) {
+		/* Avoid forcing the driver callback unnecessarily next time. */
+		policy->force_target = false;
+	} else if (target_freq == policy->cur) {
+		return 0;
 	}
 
 	if (cpufreq_driver->target) {
@@ -2671,6 +2677,7 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 			      struct cpufreq_governor *new_gov,
 			      unsigned int new_pol)
 {
+	bool need_update_limits = cpufreq_driver->flags & CPUFREQ_NEED_UPDATE_LIMITS;
 	struct cpufreq_policy_data new_data;
 	struct cpufreq_governor *old_gov;
 	unsigned int freq;
@@ -2710,7 +2717,8 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 			      CPUFREQ_RELATION_H);
 	if (freq != policy->max) {
 		WRITE_ONCE(policy->max, freq);
-		policy->update_limits = true;
+		if (need_update_limits)
+			policy->force_target = true;
 	}
 
 	freq = __resolve_freq(policy, new_data.min, new_data.min, new_data.max,
@@ -2718,7 +2726,8 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 	freq = min(freq, policy->max);
 	if (freq != policy->min) {
 		WRITE_ONCE(policy->min, freq);
-		policy->update_limits = true;
+		if (need_update_limits)
+			policy->force_target = true;
 	}
 
 	trace_cpu_frequency_limits(policy);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index fa5d92d408a8c..2b896d30c35d8 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -145,8 +145,8 @@ struct cpufreq_policy {
 	/* Per policy boost supported flag. */
 	bool			boost_supported;
 
-	/* Pending policy->min/max update for the driver */
-	bool			update_limits;
+	/* Force passing target frequency to the driver. */
+	bool			force_target;
 
 	/* The policy has been suspended. */
 	bool			suspended;
-- 
2.53.0

