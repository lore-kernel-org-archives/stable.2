Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795601622;
	b=Q25SoQCEJ6wMm/A8PnC60G6ZPzt+2VEcMCarm0XNCjNWogWL4EwlbtnURz4Xk58ARuCt
	 R+/M88VF7s07ZGSIaVaT784pYMhg+wX7s+P7AkKoRe6P1NyrATm+WFCs61K3eVNAt1ZRh
	 58A1fzJRCfyz40TcCoIiAlCaC+8OT+LJ1Mt4h/16ADXCY23O28N/iJ601MBZ63W8HbLWV
	 UFxggm4c/JsmNoBrA4gKhZPbNGnDB93f3+u5b4iHP8e+s2ZIeT7Di8oizexdSptaQw6k7
	 7E/qAyOMNnjMupV7wE08lYUdEkZ0yiaZbcn26mpKu0MqhhcNqT8bYl42f95CxOv2ppg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795601622;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=MqYAiq1QpwfNUjta1HBA3wgy3siS2tmIr1mA19HNRb8=;
	b=RNgLky/47tNJOc78jZOZ3vTc6YrYXXbkQVhOehaqIp8SfKSl+RdSopBWAA6HeeIn2jNZ
	 AbF9cOMVUwBssfRHunMcSIq1qt8su60zPI+W2oaoe+c2SWaPNgKUiDhh9gTY4aDoC1WIP
	 02XRImpPrX2IUYWi+CJSo7ntNKBDo4uzgSrOkTECsB9pvyAdH8idDwoddipjaXF8aZyGA
	 LJWPEWn9V1E/i7mTcZuGspGvR+/bLJiu+gr5yxr495vnjHXMc2OCe6q0bPXFrXTryVk/A
	 fprRCShb+xg7s6yW2MQA+TILvdWDWhGxjZJV0LE19p1bPc6shCbztAbUEMv8AJtZHrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=mcW3ELjX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127A5606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=mcW3ELjX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2590F1F000C6;
	Wed, 25 Nov 2026 10:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795601621;
	bh=MqYAiq1QpwfNUjta1HBA3wgy3siS2tmIr1mA19HNRb8=;
	h=Subject:To:Cc:From:Date;
	b=mcW3ELjXkfaaboEk48kQfbwhB5NnkUsuB/Fii5rhQyjjb8rnIlvGpKetKSP3ZJQ9t
	 NvUJ/ljeY4achk1DzofXP9fapLfR3iH1eEuF+9kTzJ3JM3+G/T8Yenx7UZJpmG23Yt
	 GDUYSQhVM+DJNGjtdIqpl+WGB9ixGYOgRuJJ301g=
Subject: FAILED: patch "[PATCH] cpufreq: Fix updates of cached resolved frequency and index" failed to apply to 6.12-stable tree
To: rafael.j.wysocki@intel.com,christian.loehle@arm.com,stable@vger.kernel.org,zhongqiu.han@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:10:38 +0100
Message-ID: <2026112538-unwomanly-unwrapped-9118@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 75120f31aed010c326b28d7c80d22314df34d9a8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112538-unwomanly-unwrapped-9118@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 75120f31aed010c326b28d7c80d22314df34d9a8 Mon Sep 17 00:00:00 2001
From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Date: Fri, 6 Nov 2026 16:05:06 +0100
Subject: [PATCH] cpufreq: Fix updates of cached resolved frequency and index

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

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 6370d0e71331..24319b214d7b 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -477,7 +477,7 @@ EXPORT_SYMBOL_GPL(cpufreq_disable_fast_switch);
 static unsigned int __resolve_freq(struct cpufreq_policy *policy,
 				   unsigned int target_freq,
 				   unsigned int min, unsigned int max,
-				   unsigned int relation)
+				   unsigned int relation, unsigned int *idx_p)
 {
 	unsigned int idx;
 
@@ -487,9 +487,10 @@ static unsigned int __resolve_freq(struct cpufreq_policy *policy,
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
@@ -520,7 +521,10 @@ unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
 	if (unlikely(min > max))
 		min = max;
 
-	return __resolve_freq(policy, target_freq, min, max, CPUFREQ_RELATION_LE);
+	policy->cached_target_freq = __resolve_freq(policy, target_freq, min, max,
+						    CPUFREQ_RELATION_LE,
+						    &policy->cached_resolved_idx);
+	return policy->cached_target_freq;
 }
 EXPORT_SYMBOL_GPL(cpufreq_driver_resolve_freq);
 
@@ -2402,12 +2406,13 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
 			    unsigned int relation)
 {
 	unsigned int old_target_freq = target_freq;
+	unsigned int idx = 0;
 
 	if (cpufreq_disabled())
 		return -ENODEV;
 
 	target_freq = __resolve_freq(policy, target_freq, policy->min,
-				     policy->max, relation);
+				     policy->max, relation, &idx);
 
 	pr_debug("CPU %u: cur %u kHz -> target %u kHz (req %u kHz, rel %u)\n",
 		policy->cpu, policy->cur, target_freq, old_target_freq, relation);
@@ -2437,7 +2442,7 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
 	if (!cpufreq_driver->target_index)
 		return -EINVAL;
 
-	return __target_index(policy, policy->cached_resolved_idx);
+	return __target_index(policy, idx);
 }
 EXPORT_SYMBOL_GPL(__cpufreq_driver_target);
 
@@ -2716,7 +2721,7 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 	 * concurrently by cpufreq_driver_resolve_freq() during the update.
 	 */
 	freq = __resolve_freq(policy, new_data.max, new_data.min, new_data.max,
-			      CPUFREQ_RELATION_H);
+			      CPUFREQ_RELATION_H, NULL);
 	if (freq != policy->max) {
 		WRITE_ONCE(policy->max, freq);
 		if (need_update_limits)
@@ -2724,7 +2729,7 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 	}
 
 	freq = __resolve_freq(policy, new_data.min, new_data.min, new_data.max,
-			      CPUFREQ_RELATION_L);
+			      CPUFREQ_RELATION_L, NULL);
 	freq = min(freq, policy->max);
 	if (freq != policy->min) {
 		WRITE_ONCE(policy->min, freq);
@@ -2736,8 +2741,6 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 
 	cpufreq_update_pressure(policy);
 
-	policy->cached_target_freq = UINT_MAX;
-
 	pr_debug("new min and max freqs are %u - %u kHz\n",
 		 policy->min, policy->max);
 
@@ -2763,6 +2766,12 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
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

