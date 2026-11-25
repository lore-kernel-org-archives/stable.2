Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795626571;
	b=e5hpwfA3OuukErXClo58QnCQGPn4hXuL1RcFGN9RTn5BhWAnBFbAKRXYQNGMC+a4gDAq
	 EiebCOSU6bpQOn0QgyKznsxi4fAsVJnRoJfinLy7TEVawmQQN+tFClHaQ+zOvQOi9MLwL
	 /jSEDfPjrxGUL0bppVjCSkCRaAbGwBLRsWM9lEdjI/TTpFsCeJrgAhUyq+XoNOEpwy3Up
	 4l5IhN8CqWi/LnlS33PXnCqPmbjfDeJdPu2Q4CHk1gixK9TwSxyc3ARPoFDOC4LgsW8sW
	 qhjRVTgznOgEvN24b71SdAPb6SW9bAFgZMwcN80BTI+vRX3WbmhbFqV5i3H39dNJVAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626571;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3AwEe7+TasRUXz9FIlHIz2/gUKT2V8DVIX8InV8OhMY=;
	b=KmxTqAZp0gaJcoupDplOK1nRercOEMGDTnNiaBy+nDTmqidhnBzyJTNcUadm7jIFDcMv
	 0gQrceGZQZbJYMCq6a7FagscQu53GN+IMY3iHXZOfUTraC3ogk4Z44ul4ho71IX8W8NzK
	 HV2ktZL24YaYIj0OUNz3OYxaVaZVxZTe3zk9NNuZte3YtQNNOgpdEnyX8Vvea9NcGZpp+
	 xqzcJZTKYXkXVwPNslutmAobUVYx5QIgth6zhITN+yloqhryVx177/tJjbqyQecmM8Xf4
	 TsgY9sMvjiZYsIHFQaOudHGS90JWNMNVfJBLvJYoG/DJ8/CgpsTCrgmEPXehnt6yMkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gbhRw0qy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099B9606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gbhRw0qy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22FE01F000D1;
	Wed, 25 Nov 2026 17:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795626570;
	bh=3AwEe7+TasRUXz9FIlHIz2/gUKT2V8DVIX8InV8OhMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gbhRw0qyqUqMd59Op+ewrtipI4XYnJA1mF6bd7U4n7coUwuVTNoqzkRaosD3xbx7Q
	 UJUdidCE72Vuc9AtLYpyFqqunwa9PqFr44ri9K43hIEQimiAY6C+ICYHhSesC1cSy+
	 Pa0ptqUaaXvTIk2ei3ULjnXff9DjoETzPjTaO1opnn8Li0d49/+YioaDHxmjCy1y0j
	 8fc0/3fAwQOtTLHtHqCxagEC+5f0nl4Z+YI0IF4G9Y3ma5cP3cTuJTGL5krXexui8k
	 R3wcQHqvCCI4B0WZJNVkLI2Vj1u7EMdJ2YWo3UZigtJHAGMgh9ppZWQrv6tGS5Ai9C
	 JJvfiumhjtRhA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] cpufreq: Avoid redundant target() calls for unchanged limits
Date: Wed, 25 Nov 2026 12:09:26 -0500
Message-ID: <20261125170915.923901-2-sashal@kernel.org>
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
Stable-dep-of: 75120f31aed0 ("cpufreq: Fix updates of cached resolved frequency and index")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/cpufreq.c | 31 ++++++++++++++++++++++---------
 include/linux/cpufreq.h   |  3 +++
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index aee7e081b6c64..7b3023fca6183 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2355,9 +2355,13 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
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
@@ -2644,6 +2648,7 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 {
 	struct cpufreq_policy_data new_data;
 	struct cpufreq_governor *old_gov;
+	unsigned int freq;
 	int ret;
 
 	memcpy(&new_data.cpuinfo, &policy->cpuinfo, sizeof(policy->cpuinfo));
@@ -2676,12 +2681,20 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
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
index 3ad7964711cb2..08031e20cf416 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -150,6 +150,9 @@ struct cpufreq_policy {
 	/* Per policy boost supported flag. */
 	bool			boost_supported;
 
+	/* Pending policy->min/max update for the driver */
+	bool			update_limits;
+
 	 /* Cached frequency lookup from cpufreq_driver_resolve_freq. */
 	unsigned int cached_target_freq;
 	unsigned int cached_resolved_idx;
-- 
2.53.0

