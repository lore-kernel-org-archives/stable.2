Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795624034;
	b=k7xnx+QRmuZjD1OXfmzMwY7HKy+Q7R8mxhwBJGjZ25Ta58abrQeaQiJOs03LxkKTaJrt
	 UYuBIwXqtvCFzIhKTKP1bPi6rpFP5Sh7oc+rjcg/Xbp2ddPLYHFlky3uEgTKA6iTzpJ7H
	 D6dAygFKprPhWtKh2Eunm92kepSipnhSc0p5bddDC9KfgJlIRjtKI4IPKm1ud1Wd5++Ln
	 gTsPX6r0NI0sVQvJW8VCqInECDe1C3ieKzTJAnHrDNk3XmkMoE5quFmQHfo8My96vXenh
	 hehrkKGhQfRPCb97MD1wpLFFVpEXeEV9O5Lt+I5KeplVAxkI+RMe6bFtJb4BUPqtAVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624034;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YCvUO4/178AvEnXYzVKRrhXwJvlH1+af7djF6DrQ+Hk=;
	b=HnyW4D6nhkkoD622SJofSRBmG1SmVgEjFgVx4VpCpndO2YXaKUdY1BHzjVEqvJtOPZzc
	 ERFBE9bySTU9nfyxWnAaAxnmuJNnvJQGhc9xijcbemHz8o2eH4CPXOq74XpdldBcbHzzP
	 p+kat1jY23Mv6IVshJfdwSbgKxA1IsrRrD5EyciX7qryFyBCa723yuqRAqIQ2ozgshT0O
	 ke0FgTBWg+DRbGvhl4MQV6lRTofDu0RGbU49FJAIBZQdRwYjOxQhh3zbOt7nCidCRqO/e
	 bTbD8Q/aB7WGXICbQNAbuuO6SedF50tOHKps/I4eeQBPulFpC/GJeDvo5VAUKKhdk7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DSPkGOG7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE84606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DSPkGOG7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB781F000E6;
	Wed, 25 Nov 2026 16:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795624034;
	bh=YCvUO4/178AvEnXYzVKRrhXwJvlH1+af7djF6DrQ+Hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DSPkGOG7IsRmhRC44IzSgaXq3yGWUdFBMYEt89jpHgTe33NDXnzsj7kvju2fT9378
	 YWliu07v7jtnvhndFLt7DkxH/gco4H4hhHXOp2D1b6gNx6RjmPRQai/ecAkLjyvwMx
	 R70SCMIaDIt3aApIJ+2FhfhrIjMBvJnO7jElw9sjwIZG1K+id8Gep8Pg6icyFx02/D
	 vM2/d67TUEGB+/pnCx63i9VXP0xt6NJYryK90dzmBBzKfgxxJ3fwHPD1H4QJ3vNHbg
	 F9YgccDb2si0SkvioqewRjCFSmV5LQpdwczTKdvw8G3R2bdp3+QGNosgvYxNbDqoaC
	 q+Vb85BUpZUTw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] cpufreq: Avoid redundant target() calls for unchanged limits
Date: Wed, 25 Nov 2026 11:27:11 -0500
Message-ID: <20261125162652.774210-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112508-whenever-distress-43ae@gregkh>
References: <2026112508-whenever-distress-43ae@gregkh>
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
Stable-dep-of: 342d3a73c5db ("cpufreq: Force passing target frequency to driver during resume")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/cpufreq.c | 31 ++++++++++++++++++++++---------
 include/linux/cpufreq.h   |  3 +++
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 962faa2463db6..94f611512cfc8 100644
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
@@ -2669,6 +2673,7 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 {
 	struct cpufreq_policy_data new_data;
 	struct cpufreq_governor *old_gov;
+	unsigned int freq;
 	int ret;
 
 	memcpy(&new_data.cpuinfo, &policy->cpuinfo, sizeof(policy->cpuinfo));
@@ -2701,12 +2706,20 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
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
index 69034172a7558..fa5d92d408a8c 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -145,6 +145,9 @@ struct cpufreq_policy {
 	/* Per policy boost supported flag. */
 	bool			boost_supported;
 
+	/* Pending policy->min/max update for the driver */
+	bool			update_limits;
+
 	/* The policy has been suspended. */
 	bool			suspended;
 
-- 
2.53.0

