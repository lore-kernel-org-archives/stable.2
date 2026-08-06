Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3704E3D567E;
	Thu,  6 Aug 2026 07:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786001312; cv=none; b=IhXHT5E7ZItvMuLm10an2MnTV+BIbGCTV4dWjJ7G5Jg5TXrjVZvKcLuD6AYe3brz41T021yU9S+52h0yH8ZqsMVUoPP+5g72jc2qNRhLgRP8y/UnKAVfkjbG4s1PW+ArrjQS8WgjHMVHzRt9oNrc+RoUHnRa8erZSCOUXSCkz1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786001312; c=relaxed/simple;
	bh=0ho9WJRC+azqwWSgJ82Ldgo0yZn9VWLw1zSayaxUa78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DJ3SjOPeLZ/O53AW2QhueDwflbCQQV4kMjF+knHS9evm5wUdxH2gf/CiHbsoD8SZKOd9NRhFSSz1EASvuW9X2zUMJ20KdZLVITIWZWfcpSbePuyiIk3nlIMm8BH258zOQCWW+ZOwDm8mVvj1XJoCZDDqgOWhILP/N5rZ9M67oCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=SZVrV3Yr; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SZVrV3Yr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=32
	hPE4s9FxkFRc/nrSoP2PIQsD8ssRPOOkOEYXu240o=; b=SZVrV3YrI6IXvEzsx/
	GxxfRWdWPGena4BgaV8ujsrpAQZiy90+MQ8mY70ktP7yxvTjXkcYiBxHqdE8zRf1
	yncB+NTjb3j/MdaG18bfMvNi5mSL0xNElRxF9z9P+cqrP53IHbcmK+aLEZXaYDEM
	gvZptfF7OkNEwOdKhhQMAcJk8=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wA3oJJjN3RquJoEMg--.8293S2;
	Thu, 06 Aug 2026 15:27:31 +0800 (CST)
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
Subject: [PATCH v2] cpufreq: schedutil: Fix rate limit overflow
Date: Thu,  6 Aug 2026 15:26:56 +0800
Message-ID: <20260806072656.1386351-1-sh_def@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3oJJjN3RquJoEMg--.8293S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZw4xXFykWFyUXrWUGFy8Krg_yoW5Xw1UpF
	Wakay0yr40qF1Utr4Sk3Wkua15uF1UA39rKryfCa1kAwnxtw1Fg34xtrs0qay7CFn0kr1f
	A3WYqay5ur18A37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piH7KxUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbCwgWe-Wp0N2XJ8gAA3T

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
Changes in v2:
- Clarify why the multiplication uses 32-bit unsigned arithmetic on
  32-bit systems.
- Cast rate_limit_us to s64 to match freq_update_delay_ns.
- Add Zhongqiu's Reviewed-by tag.

v1: https://lore.kernel.org/r/20260805143942.805176-1-sh_def@163.com

 kernel/sched/cpufreq_schedutil.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index dff4ee04694c..51910b30c8da 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -61,6 +61,12 @@ static DEFINE_PER_CPU(struct sugov_cpu, sugov_cpu);
 
 /************************ Governor internals ***********************/
 
+static void sugov_update_rate_limit_us(struct sugov_policy *sg_policy)
+{
+	sg_policy->freq_update_delay_ns =
+		(s64)sg_policy->tunables->rate_limit_us * NSEC_PER_USEC;
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

