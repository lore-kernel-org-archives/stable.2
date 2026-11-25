Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795601597;
	b=REtdXhwuSbh2TkWFVDrYnxuCD0XDpJhy4D4lgi8IclXlhsdQpMaK8UJGjJmBsM1L4Hm6
	 KD335wvL09YbAUJDwqZ7gzypmmFRMhtXd+L/sBlrm7ANfDbq+GULXrR/ZRx84XjPg7a+A
	 Q0q+yoAJfnSbRjHeaLxdH2LTDNamcjc4a7zjH/y+tTaaLR77BqJqgWWN9gWbOk7G9PbSa
	 hFXmi5rcRn7iGkBdoowQ7yVwx9QyeH4ILSLE647Bm5payuy5Amcpdm8p8cqecJK8zvrk7
	 9CA1+4+QmgURPNF3+5dWmf0cj3NCT0wUpuKnSlagYlYAno9dGihCpCBEFnCgh5isiYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795601597;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=TjS/owhfccDa9sXno9802WJQ9iPIJ1+mYVZIw1ozhFU=;
	b=Aj0d2MGSdMmMIg5IVeogxSptmUH5Jm23dAzE4675nzo6J4cAol+A8RX1GJFrP1V+j+pN
	 soazDOpwFvVFYCDi1nb1cFGKMV47AqjkWMyYqE/bfCYlsuB30c47Ugd2Hzd7WCmSuPq2O
	 9SQmehfBRQwIH3BzuYJujgCV3kY2CO7e7nrmTyChcSMvrRQbgk9BfPLNwTvivw9ROTE/1
	 UFUq+EVBC95nbDZ/VMPn7xZurllH9D8gmcvBywxeuNB8P13oL8EKaIZmDcs+2F3ne7Fyg
	 NKpzkDyzPWYwdYI6B6dAKO13sx0nt1WRcs5KIsMEz70yqSP3lmdpcz+gHr0T4hLJBbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=VZ9sVhrz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8B2606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=VZ9sVhrz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7396E1F000C0;
	Wed, 25 Nov 2026 10:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795601597;
	bh=TjS/owhfccDa9sXno9802WJQ9iPIJ1+mYVZIw1ozhFU=;
	h=Subject:To:Cc:From:Date;
	b=VZ9sVhrzQLoOmWV6gSLkPm3/Qlro6TIfDu+LU6OSXZDwRyLSph36mGyCAo3KMyaGZ
	 JKdjbsIMu8ypwH2A6QHuByAZzly/cnGMe1oVkyf/pPuB9trQWIVbJkwF5G5m1VIgkM
	 CVYpa0e3tH6sZUWDz0RexVPrVBWYNMBYJDIgmNZY=
Subject: FAILED: patch "[PATCH] cpufreq: intel_pstate: Clear last written P-state value on" failed to apply to 5.10-stable tree
To: rafael.j.wysocki@intel.com,christian.loehle@arm.com,dsmythies@telus.net,stable@vger.kernel.org,viresh.kumar@linaro.org,zakbrightonknight@gmail.com,zhongqiu.han@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:09:50 +0100
Message-ID: <2026112549-wobble-pastor-7c26@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 02e77af824d5be3a94fdd885835a352f90d24c5c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112549-wobble-pastor-7c26@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 02e77af824d5be3a94fdd885835a352f90d24c5c Mon Sep 17 00:00:00 2001
From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Date: Tue, 3 Nov 2026 20:49:06 +0100
Subject: [PATCH] cpufreq: intel_pstate: Clear last written P-state value on
 suspend

Preserving cpu->pstate.current_pstate across system suspend-resume
cycles, when running in the passive mode with HWP disabled, is a mistake
because its value from before system suspend may become stale after the
subsequent system resume and in some cases it prevents MSR_IA32_PERF_CTL
from being updated properly after system resume [1].

Address this by clearing cpu->pstate.current_pstate after the governor
has been stopped during system suspend.

Fixes: 001c76f05b01 ("cpufreq: intel_pstate: Generic governors support")
Fixes: 4adcf2e5829f ("cpufreq: intel_pstate: Add ->offline and ->online callbacks")
Link: https://lore.kernel.org/linux-pm/20261027143725.3763827-1-zakbrightonknight@gmail.com/ [1]
Reported-by: Zak Brighton Knight <zakbrightonknight@gmail.com>
Reported-by: Doug Smythies <dsmythies@telus.net>
Cc: All applicable <stable@vger.kernel.org> # 342d3a73c5db cpufreq: Force passing target frequency to driver during resume
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Zak Brighton Knight <zakbrightonknight@gmail.com>
Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Tested-by: Doug Smythies <dsmythies@telus.net>
Tested-by: Christian Loehle <christian.loehle@arm.com>
Link: https://patch.msgid.link/14150222.uLZWGnKmhe@rafael.j.wysocki
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 0e6ae4cdda5d..dd1bca5e27f1 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -3389,10 +3389,11 @@ static void intel_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 
 static int intel_cpufreq_suspend(struct cpufreq_policy *policy)
 {
+	struct cpudata *cpu = all_cpu_data[policy->cpu];
+
 	intel_pstate_suspend(policy);
 
 	if (hwp_active) {
-		struct cpudata *cpu = all_cpu_data[policy->cpu];
 		u64 value = READ_ONCE(cpu->hwp_req_cached);
 
 		/*
@@ -3403,6 +3404,17 @@ static int intel_cpufreq_suspend(struct cpufreq_policy *policy)
 		value &= ~HWP_DESIRED_PERF(~0L);
 		wrmsrq_on_cpu(cpu->cpu, MSR_HWP_REQUEST, value);
 		WRITE_ONCE(cpu->hwp_req_cached, value);
+	} else {
+		/*
+		 * Invalidate the cached P-state value that may be stale when
+		 * the governor is started again during resume and may prevent
+		 * MSR_IA32_PERF_CTL from being updated.
+		 *
+		 * This does not require synchronization because the core
+		 * prevents frequency updates for suspended policies from
+		 * occurring.
+		 */
+		cpu->pstate.current_pstate = 0;
 	}
 
 	return 0;

