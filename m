Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795624711;
	b=SbcGJddx6hTmBMtejtvqQUmLW90WVOwwmZA8eBpGDPREUcZjSRzdLyW9rK9+hyOSS7ua
	 tIlV704CUUMerR2xFDd6M8fK7xlOEIj512ZWkhtauMJTAU5jLsC/OrBbBqyVfvFYkezFA
	 UvwBz+s2LzkNnfCimOUBa9bEkxCXYVlW5QFkM/aMSMQFnql5jkEAbp3tNNiwFzFZFwL4y
	 mTzCL3c3Xl+t7BXIzR2P/rMIhkiIM3/y50ghyiymUBvAk2sQ9b8ww1Hc5H/7yrAg4yvqI
	 A1AtdUQiZMjUL5onIxm4B/9WKqUNg3nknCXA0Vo+nlu+Z6hq0E4CgtnNgLd/5nUCPIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624711;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=7e/1J7uj8eAyr3tf249h5vDc7X+OtDAp33PQh3PtrY4=;
	b=dYKOx9iDyXanZps6Ym3HCqKh1+M0XVmo+P2fuZJG66ELDNo9QJNVT7fcLvIjs7u2f/hW
	 xcaBK8SqnXpLruhkBsk+OuMGrsr+YjSxs2vMopPy0KNYhcN7uoq2BPgfz1DZBw2LlzcPk
	 q1MzRpDbDD/XK3QmuJX2tUlvyEGkmdJCkpsDQSUxgjaFWnEcnwnh8h7gM1qlEfM5j/nIy
	 mruGlQ5OjXs14HpAwWrpejom/jXiayP5+C8UUKDbGfrQZwtGufrM43BBswilEl0JXLaUB
	 Z+TMFpK4RxnVwOqvajUzix2NQw6tMFKBPgOLY5Q89NVdL3Oz6Ww7dSCJwozmheVdSXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WDYMs2ry;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0532E606A33C
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WDYMs2ry
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60D31F000C0;
	Wed, 25 Nov 2026 16:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795624710;
	bh=7e/1J7uj8eAyr3tf249h5vDc7X+OtDAp33PQh3PtrY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WDYMs2ry/HgIwK4XpH5ERr/vKve4ZHiGFVuKM/jp9EPCL3CiOLldDG/7nWigO9yDT
	 dELCb4GAW6ZTlV3j1MtzGu04pC7yGrqfDB1z5RcRn9FSXZO+VKtz2sVaykJ/4h3Dou
	 B8DddMADefyu1BSmuDAtRlZlsQyK4b5CTGEwUdtl1PW/iZMEjhCHrlwrvTj/Hv9E4r
	 gr4L3uLGW8L19AJqajJYJIN2GxbFU5Ll4RX4Tatk8JqmnM+oG9YC1n2WRp8zPIB6T0
	 CTo0eVS6b55QvNys4Tsy3k3cTjhldPLbqdF1jwLWk988OovZmyGoZHeA0J3hzhXa/o
	 TTXAYerq37g4g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/4] cpufreq: Remove ->resolve_freq()
Date: Wed, 25 Nov 2026 11:38:24 -0500
Message-ID: <20261125163734.823203-3-sashal@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Viresh Kumar <viresh.kumar@linaro.org>

[ Upstream commit b3beca76181681fce9cf72f37d19c3030e3353c0 ]

Commit e3c062360870 ("cpufreq: add cpufreq_driver_resolve_freq()")
introduced this callback, back in 2016, for drivers that provide the
->target() callback.

The kernel hasn't seen a single user of it in the past 5 years and
it is not likely to be used any time soon.

Remove it for now.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
[ rjw: Changelog edits ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Stable-dep-of: 166207cac451 ("cpufreq: Cache post-resolution target frequency in __resolve_freq()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/cpu-freq/cpu-drivers.rst        |  3 ---
 .../zh_CN/cpu-freq/cpu-drivers.rst            |  2 --
 drivers/cpufreq/cpufreq.c                     | 21 +++++++------------
 include/linux/cpufreq.h                       |  9 --------
 4 files changed, 8 insertions(+), 27 deletions(-)

diff --git a/Documentation/cpu-freq/cpu-drivers.rst b/Documentation/cpu-freq/cpu-drivers.rst
index a697278ce1903..5ee49820d48ad 100644
--- a/Documentation/cpu-freq/cpu-drivers.rst
+++ b/Documentation/cpu-freq/cpu-drivers.rst
@@ -58,9 +58,6 @@ And optionally
 
  .driver_data - cpufreq driver specific data.
 
- .resolve_freq - Returns the most appropriate frequency for a target
- frequency. Doesn't change the frequency though.
-
  .get_intermediate and target_intermediate - Used to switch to stable
  frequency while changing CPU frequency.
 
diff --git a/Documentation/translations/zh_CN/cpu-freq/cpu-drivers.rst b/Documentation/translations/zh_CN/cpu-freq/cpu-drivers.rst
index 0ca2cb6466660..f906a4e5a3ac3 100644
--- a/Documentation/translations/zh_CN/cpu-freq/cpu-drivers.rst
+++ b/Documentation/translations/zh_CN/cpu-freq/cpu-drivers.rst
@@ -64,8 +64,6 @@ CPUfreq核心层注册一个cpufreq_driver结构体。
 
  .driver_data - cpufreq驱动程序的特定数据。
 
- .resolve_freq - 返回最适合目标频率的频率。不过并不能改变频率。
-
  .get_intermediate 和 target_intermediate - 用于在改变CPU频率时切换到稳定
  的频率。
 
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 20df0efcfdc59..134e42091e677 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -532,22 +532,17 @@ EXPORT_SYMBOL_GPL(cpufreq_disable_fast_switch);
 static unsigned int __resolve_freq(struct cpufreq_policy *policy,
 		unsigned int target_freq, unsigned int relation)
 {
-	target_freq = clamp_val(target_freq, policy->min, policy->max);
-	policy->cached_target_freq = target_freq;
+	unsigned int idx;
 
-	if (cpufreq_driver->target_index) {
-		unsigned int idx;
-
-		idx = cpufreq_frequency_table_target(policy, target_freq,
-						     relation);
-		policy->cached_resolved_idx = idx;
-		return policy->freq_table[idx].frequency;
-	}
+	target_freq = clamp_val(target_freq, policy->min, policy->max);
 
-	if (cpufreq_driver->resolve_freq)
-		return cpufreq_driver->resolve_freq(policy, target_freq);
+	if (!cpufreq_driver->target_index)
+		return target_freq;
 
-	return target_freq;
+	idx = cpufreq_frequency_table_target(policy, target_freq, relation);
+	policy->cached_resolved_idx = idx;
+	policy->cached_target_freq = target_freq;
+	return policy->freq_table[idx].frequency;
 }
 
 /**
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 6e7f611c5e197..4e1c553ad25a0 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -329,15 +329,6 @@ struct cpufreq_driver {
 	unsigned int	(*fast_switch)(struct cpufreq_policy *policy,
 				       unsigned int target_freq);
 
-	/*
-	 * Caches and returns the lowest driver-supported frequency greater than
-	 * or equal to the target frequency, subject to any driver limitations.
-	 * Does not set the frequency. Only to be implemented for drivers with
-	 * target().
-	 */
-	unsigned int	(*resolve_freq)(struct cpufreq_policy *policy,
-					unsigned int target_freq);
-
 	/*
 	 * Only for drivers with target_index() and CPUFREQ_ASYNC_NOTIFICATION
 	 * unset.
-- 
2.53.0

