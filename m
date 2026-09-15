Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16931402BAB;
	Tue, 15 Sep 2026 04:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789446847; cv=none; b=nuun5VOyuChgVq1NYp1oGlz/LeMXy+AmFPvC7fB+1l/ZHXAU0DJkchmDqLPpxYPB1SX7NDytSRszRItgJ4P5RWLvHRIDKrcxKyY7iqBx4jB+V3KgyWYzMbkBsDoVunk2Wie01UfrsafLBRBzr4g/1J/73Ls0UXgRGkDStLLyZ1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789446847; c=relaxed/simple;
	bh=WX56qMn4+EREe8Li2P0a0K0EmdihwgyzEk6/Kd3LgN4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L7mtDZ8FEr+4rP+az6v8J4AAQ939eA75ic8tPfGBg/WwrvVKct0anZwxIVhm2oBBdoRAVXdElMwcTSVeLDhlf+dlwzZf2BSIrXiF3W4euQfDXE18/N8whBDkybsHAxtVCc+3KzCOWstuKm9C5DKz5k0z8AhOXYXwXEcuUbqTw48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowAD3y++3yqhqvLkICA--.50170S2;
	Tue, 15 Sep 2026 12:33:59 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Yuantian.Tang@nxp.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael@kernel.org,
	scottwood@nxp.com,
	viresh.kumar@linaro.org,
	lkml@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH 4/6] cpufreq: qoriq: Fix clock reference leak in set_affected_cpus()
Date: Tue, 15 Sep 2026 04:33:30 +0000
Message-Id: <20260915043330.1725887-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAD3y++3yqhqvLkICA--.50170S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKr4kur4ruF1UArWkuw17KFg_yoWktrg_uw
	n5W3srWr48C3ZFyF1kKr4rA3sFy3ZrZFn2yF10y39xA34UA34Yv34rZF98uw47u3yagrZx
	Jw1vva13uw47JjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VU1go2U
	UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgYLA2qowR0lYQAAsS

cpu_to_clk() returns a consumer clock obtained with of_clk_get(), but
set_affected_cpus() never releases it.  The reference is only used for
a clk_is_match() comparison, and each iteration of the
for_each_present_cpu() loop overwrites the 'clk' pointer with a newly
obtained reference, leaking all but the last one (which is leaked too,
once the loop ends).

Put the clock back with clk_put() once the comparison is done.
clk_put() also tolerates the NULL clock that cpu_to_clk() returns for
a CPU without a clock node.

Fixes: b1e9a64972bf ("cpufreq: qoriq: Don't look at clock implementation details")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/cpufreq/qoriq-cpufreq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
index 13d3333e68d8..7a004782ff62 100644
--- a/drivers/cpufreq/qoriq-cpufreq.c
+++ b/drivers/cpufreq/qoriq-cpufreq.c
@@ -98,6 +98,8 @@ static void set_affected_cpus(struct cpufreq_policy *policy)
 
 		if (clk_is_match(policy->clk, clk))
 			cpumask_set_cpu(i, dstp);
+
+		clk_put(clk);
 	}
 }
 
-- 
2.34.1

