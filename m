Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75893390234;
	Wed,  5 Aug 2026 14:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785940869; cv=none; b=Nf6gf3ei9bxdkUUWvtFGeHs643NHJE2/zRsh4Vt7wXweRkeKi74YL7IuMdEV+7c4/Rj0D1gMrMoANXbktU9gP8nQ/Q2wptxbkSuK9Pu0RZpMf/ROuGlhKfonJzD99ZBm2LvgVDCDWMX3oHSAhtPajjd5nU9zKZUEo/wMNgr5YDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785940869; c=relaxed/simple;
	bh=Ys+Bm3HAcptcJY8mztSxc31f658W9MqMu6vD2Ly4muw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SaqdcmFPfAmWViMSUNpeV/fGpFPefObKV0D4R6yRhkch7Y05xOVHFgUd8xV2ivFmLutk/y0thkWluZcVvsnfTcYW/74hu80OupOeT/jfCd6+YJW13H42p4+gJbpPAEW4hrP3MJZAgODgUFCCjBXSVh0LVIfrHcCYOtGRSWYGfWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KPlfamkC; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KPlfamkC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Dd
	KekUZhzSFi+yc5KTHvN42O6H95FUeG1o1RwiMrKj0=; b=KPlfamkCMCNO8LR+JG
	dD2ySy1k70EsQdflkcUtmTw5ZCXT260UXB0fMMvVv24fgEFZf+7UeHb6xGDoJr4D
	FpKa3YUEP9TZrPMvu1LrKTBdenxRdXi7IjjFm1DVjyNxXoiwv+5SIB7F6N2hubSQ
	7us8YKKZVbkZ5bVAMF7TIjSLs=
Received: from localhost (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAnH_81S3NqqC4ULg--.14152S2;
	Wed, 05 Aug 2026 22:39:50 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Su <sh_def@163.com>
Subject: [PATCH] cpufreq: schedutil: Fix rate limit overflow
Date: Wed,  5 Aug 2026 22:39:42 +0800
Message-ID: <20260805143942.805176-1-sh_def@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgAnH_81S3NqqC4ULg--.14152S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar1kXF13uF13uw4rAF1rtFb_yoW8tFy7pF
	Wakay0yr4qq3WUtrs3KF4Dua1UAF1UJ3srKryfC3Z2ywnxJw1Fg34xGF1DXFWxCFn0kw1f
	A3WYqay5ZF18X37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEv38UUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbCwRZXtmpzSzYAkgAA3A

rate_limit_us is unsigned int. On 32-bit systems, multiplying it by
NSEC_PER_USEC is therefore carried out in 32-bit arithmetic before
the result is assigned to freq_update_delay_ns.

For example, writing 4294968 to rate_limit_us wraps the delay from
4294968000 ns to 704 ns. This makes schedutil update far more often
than configured.

Add sugov_update_rate_limit_us() to widen the value to u64 before
converting units. Use it when updating the tunable through sysfs and
when starting the governor, so both paths set the same valid delay.

Fixes: 9bdcb44e391d ("cpufreq: schedutil: New governor based on scheduler utilization data")
Signed-off-by: Hui Su <sh_def@163.com>

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index dff4ee04694c2b90301ed0fa158a509a3423cee1..8bf7a2c34b9f200d8f5776205ea2a7f495e04e69 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -61,6 +61,12 @@ static DEFINE_PER_CPU(struct sugov_cpu, sugov_cpu);
 
 /************************ Governor internals ***********************/
 
+static void sugov_update_rate_limit_us(struct sugov_policy *sg_policy)
+{
+	sg_policy->freq_update_delay_ns =
+		(u64)sg_policy->tunables->rate_limit_us * NSEC_PER_USEC;
+}
+
 static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
 {
 	s64 delta_ns;
@@ -606,7 +612,7 @@ rate_limit_us_store(struct gov_attr_set *attr_set, const char *buf, size_t count
 	tunables->rate_limit_us = rate_limit_us;
 
 	list_for_each_entry(sg_policy, &attr_set->policy_list, tunables_hook)
-		sg_policy->freq_update_delay_ns = rate_limit_us * NSEC_PER_USEC;
+		sugov_update_rate_limit_us(sg_policy);
 
 	return count;
 }
@@ -848,7 +854,7 @@ static int sugov_start(struct cpufreq_policy *policy)
 	void (*uu)(struct update_util_data *data, u64 time, unsigned int flags);
 	unsigned int cpu;
 
-	sg_policy->freq_update_delay_ns	= sg_policy->tunables->rate_limit_us * NSEC_PER_USEC;
+	sugov_update_rate_limit_us(sg_policy);
 	sg_policy->last_freq_update_time	= 0;
 	sg_policy->next_freq			= 0;
 	sg_policy->work_in_progress		= false;
-- 
2.43.0

