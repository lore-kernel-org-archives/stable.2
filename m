Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261A22F30;
	Thu,  6 Aug 2026 14:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786026263; cv=none; b=VrOZ96I6MqlFkMvanKridLxhjQriH1d7W0syxopaXH26o5t02KxuvsyYG94Nb3SEa2X4LaXzxlQ4+9CehvjaruSoRSD9iShQRsLozL8JqOcGzVa+g8693AltaawRaxKI6eaizvVUU5FhD8a0r8y6VDHJjKJFurUW7dI6PJZ56Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786026263; c=relaxed/simple;
	bh=rPzBobGjahlQxhs2KnLi8bN9L5wDTX2pwajw9BaYypA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rli0Ef9MyhSjKSVyu4vyfpS0gF+6cOyxI94qaBXCMlYdykXQfOw3f2p79HDSMqlmTR+U9cot8UskEtos9vP7FYODIhHxM/oU1tF7CScz55yFwVAw0Hys6n+quamuyCSFsoKTolSAOBpMUisrTIQK83emIXW2VlHrT7u6OetJcwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jq7HXznk; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jq7HXznk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=hk
	Tg6mHF8DBpPRWMwU8ltRJwRzU0JFRz4+Z+nAy7ZO4=; b=jq7HXznkoRpRdNVNKA
	8A5pgKG3zrruf1Hf3/FpPVEYZh6owK8cFhblL+/DK6IKWLN1SDiCrtyButfOxwa2
	qk9pcC+GGBj+nZ3Jw57pqwGxn4ryks5YOZJ6v02zVioo/9bXdAN9v/cplkrJ+v3z
	i9U0ORpcYj37valxSc2AtnBpY=
Received: from localhost (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDX0+jSmHRqis_NKw--.47030S2;
	Thu, 06 Aug 2026 22:23:15 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	zhongqiu.han@oss.qualcomm.com,
	Hui Su <sh_def@163.com>
Subject: [PATCH v3] cpufreq: schedutil: Fix rate limit overflow
Date: Thu,  6 Aug 2026 22:23:04 +0800
Message-ID: <20260806142304.1761454-1-sh_def@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgDX0+jSmHRqis_NKw--.47030S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZw4xXFy5urWUAF1DtF15XFb_yoW5Zr45pF
	ZIk3y0yr40qry7trs3C3ZruF15uF48J39rKryfCa1vywn8Kw1Fg34Iyrs0ga47AF9Ykr4f
	A3WYqFW5ur18A37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piHq2tUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbCwRQTcmp0mNSmLQAA3t

rate_limit_us is an unsigned int, while NSEC_PER_USEC is defined as
1000L. On 32-bit systems, the multiplication is therefore performed
using 32-bit unsigned arithmetic before the result is assigned to
freq_update_delay_ns.

For example, writing 4294968 to rate_limit_us wraps the delay from
4294968000 ns to 704 ns. This makes schedutil update far more often
than configured.

Add sugov_update_rate_limit_us() to widen rate_limit_us to s64 before
converting it to nanoseconds. Use the helper when updating the tunable
through sysfs and when starting the governor, so both paths perform the
conversion without overflow.

Fixes: 9bdcb44e391d ("cpufreq: schedutil: New governor based on scheduler utilization data")
Cc: stable@vger.kernel.org
Signed-off-by: Hui Su <sh_def@163.com>
Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
---
Changes in v3:
- Add a comment explaining why rate_limit_us must be cast before
  multiplication.

v2: https://lore.kernel.org/r/20260806072656.1386351-1-sh_def@163.com

Changes in v2:
- Clarify why the multiplication uses 32-bit unsigned arithmetic on
  32-bit systems.
- Cast rate_limit_us to s64 to match freq_update_delay_ns.
- Add Zhongqiu's Reviewed-by tag.

v1: https://lore.kernel.org/r/20260805143942.805176-1-sh_def@163.com

 kernel/sched/cpufreq_schedutil.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index dff4ee04694c..614ff0d33c01 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -61,6 +61,17 @@ static DEFINE_PER_CPU(struct sugov_cpu, sugov_cpu);
 
 /************************ Governor internals ***********************/
 
+static void sugov_update_rate_limit_us(struct sugov_policy *sg_policy)
+{
+	/*
+	 * Cast rate_limit_us before multiplication to force 64-bit arithmetic.
+	 * Otherwise, on 32-bit platforms, both operands are converted to
+	 * 32-bit unsigned long and the multiplication may overflow.
+	 */
+	sg_policy->freq_update_delay_ns =
+		(s64)sg_policy->tunables->rate_limit_us * NSEC_PER_USEC;
+}
+
 static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
 {
 	s64 delta_ns;
@@ -606,7 +617,7 @@ rate_limit_us_store(struct gov_attr_set *attr_set, const char *buf, size_t count
 	tunables->rate_limit_us = rate_limit_us;
 
 	list_for_each_entry(sg_policy, &attr_set->policy_list, tunables_hook)
-		sg_policy->freq_update_delay_ns = rate_limit_us * NSEC_PER_USEC;
+		sugov_update_rate_limit_us(sg_policy);
 
 	return count;
 }
@@ -848,7 +859,7 @@ static int sugov_start(struct cpufreq_policy *policy)
 	void (*uu)(struct update_util_data *data, u64 time, unsigned int flags);
 	unsigned int cpu;
 
-	sg_policy->freq_update_delay_ns	= sg_policy->tunables->rate_limit_us * NSEC_PER_USEC;
+	sugov_update_rate_limit_us(sg_policy);
 	sg_policy->last_freq_update_time	= 0;
 	sg_policy->next_freq			= 0;
 	sg_policy->work_in_progress		= false;
-- 
2.43.0

