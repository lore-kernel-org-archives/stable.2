Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795628043;
	b=xYZsv36mVNCIfBI3PzPEn6KYA5sYaNqN51suqAAG96T1z1PusIHZ8gPcfyDe8mMm0H4D
	 tHa2VjQdrIVB1WzoX0UkgJvtevpGaYniX6P7xVvApnNqOoAD+YFJ5TliStNVN3kKaq2pm
	 xdevUWwVws9C8lkyTl/KVDMG82D22RYHPyCkMkRiBWLuTx2gSlOubIl8IDyBSh41UWOV0
	 IaAq1kJJ2BzU4cptipf/Z+XnwuL+p2RnYLVva9CaqA6t5xismdObvbGbtsYSMj0X7z+Qt
	 SoWwHct59XY7B9mVryUgAwe5Ac/Or+ICBB5ytL3hCnj4C0Ah1beWEFrqDdPAPe/WgIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795628043;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Pbwwys5zGvxZZuYYmxJV5wKmTIbSDmB0HZeb7M2icjw=;
	b=ZYDkkrihCJQMXGw4h8kiW7240EVMr9xy21Hk/FXOMVGQdLhb4DbYzJ14/sritb8b2EjC
	 4SK9r+PMWsnPjYpWoS5DX1SVDAHQdF4ZnWHn2g50Rqc3dxDpaoDaPqagwoTC4eLQpu5Tg
	 ly5kqeHJQxP2b4MQJOgFeGdv7riakZCGEJ+qbepNl6e1QDCb6t0Jlq6Ibs3MOeMlktndj
	 xAwIxlSjAm3u/wafmDFMvm1CDC2x6Ex5Yekr4GPQmhqkTWe3bPav/ohf3q3+S5z9SF4Eo
	 nqSwI6+R2If/QEiV20wLGEL9e0JQ+TrzvlBevZlNjFz0GVCBpjoSvx6EBx+thHJS2aA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m6VkdEu8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9219A606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m6VkdEu8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530CC1F000C6;
	Wed, 25 Nov 2026 17:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795628043;
	bh=Pbwwys5zGvxZZuYYmxJV5wKmTIbSDmB0HZeb7M2icjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m6VkdEu8m0mT2TPEAfL39CNsgvC0b5AyyNYPrrlDx7YLoshg5OE8eHomsciFZQFl+
	 xzqxn5WnN54TVie5FfEdrcS51Lpp882fnwHULNw1Mmn08vlHW7oKGdffGyEOGan6lx
	 xii3BwAbHGz6YxV4GpU8mYqHjSjNSjSFt3EfUvmG6BC8WHZx1mLzkO30auAQRaxswb
	 mZZ5HRAqlnNYsisrZjzKDNuzg7RGlFjKecTDrNeTYF9rXjoYxssET+liKE3vGRwOqU
	 FYtkAocPlAM/YvKKYCuBEInbabS8XUgeZKEexG1F1TP28kDKf/4LxKbpjQ8JXFr97l
	 f45fu9Dpvh9vw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] cpufreq: Avoid redundant target() calls for unchanged limits
Date: Wed, 25 Nov 2026 12:33:58 -0500
Message-ID: <20261125173332.948887-2-sashal@kernel.org>
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
index f56958e539b69..e8d4d0ca1fdc5 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2367,9 +2367,13 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
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
@@ -2619,6 +2623,7 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 {
 	struct cpufreq_policy_data new_data;
 	struct cpufreq_governor *old_gov;
+	unsigned int freq;
 	int ret;
 
 	memcpy(&new_data.cpuinfo, &policy->cpuinfo, sizeof(policy->cpuinfo));
@@ -2651,12 +2656,20 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
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
index 1416d3a005430..ade90637c3201 100644
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

