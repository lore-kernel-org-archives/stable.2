Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CD135F19D;
	Fri, 28 Aug 2026 03:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787886798; cv=none; b=gZq2mu72EzMOr8TpaWR+ZcoyhfqU+eA8O7kP0hgFvHmJShD0u1Pp+3/g0iFyq1z4psIY1rUsbPSkxziex+Nmh1YltNUSI4P/5dv4JXZzr8OtgKOOw7+8yQVnuIBRzKBdhIANh5euvXwdqSg1/dQMDG6tJPyJ0Y1FuRrynCHDsxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787886798; c=relaxed/simple;
	bh=pa+zw+pSaw4M4okFgFMGWjtaUCxmByvOf5guTgaIaI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pzDVLHU5dPF+H3ArmOc7mNGargaIJz/BLw2q5oejKvXYNnF2wBkaELt0dFglMIECPwIXzQooRWVwTXaRRsbY2fPlpKn9QVFK3/RO1Hp5OwLHFby+sI+DgqO94h7LSjioeUQt28azkV/wE2rQ1ybyRE+lM0a+jhyUNEiqpai9t1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9E3F1F000E9;
	Fri, 28 Aug 2026 03:13:14 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	stable@vger.kernel.org,
	Hongliang Wang <wanghongliang@loongson.cn>
Subject: [PATCH V2 4/5] cpufreq: loongson3: Use global physical CPU ID in get/target callbacks
Date: Fri, 28 Aug 2026 11:12:00 +0800
Message-ID: <20260828031201.1500767-5-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260828031201.1500767-1-chenhuacai@loongson.cn>
References: <20260828031201.1500767-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Our server productions (e.g. Loongson-3D6000/3E6000) can have discrete
global physical CPU IDs while the core ID inside the packages are always
continuous. In these cases we should use global physical CPU IDs to get
and set frequencies.

Cc: stable@vger.kernel.org
Fixes: ccf51454145b ("cpufreq: Add Loongson-3 CPUFreq driver support")
Signed-off-by: Hongliang Wang <wanghongliang@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/cpufreq/loongson3_cpufreq.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/loongson3_cpufreq.c b/drivers/cpufreq/loongson3_cpufreq.c
index e3cd78a5ab18..3a5bf970077a 100644
--- a/drivers/cpufreq/loongson3_cpufreq.c
+++ b/drivers/cpufreq/loongson3_cpufreq.c
@@ -16,6 +16,7 @@
 #include <asm/idle.h>
 #include <asm/loongarch.h>
 #include <asm/loongson.h>
+#include <asm/smp.h>
 
 /* Message */
 union smc_message {
@@ -219,38 +219,40 @@ static inline int do_service_request(u32 id, u32 info, u32 cmd, u32 val, u32 ext
 
 static unsigned int loongson3_cpufreq_get(unsigned int cpu)
 {
-	int ret;
+	int ret, core = cpu_logical_map(cpu);
 
-	ret = do_service_request(cpu, FREQ_INFO_TYPE_FREQ, CMD_GET_FREQ_INFO, 0, 0);
+	ret = do_service_request(core, FREQ_INFO_TYPE_FREQ, CMD_GET_FREQ_INFO, 0, 0);
 
-	return ret * KILO;
+	return (ret < 0) ? 0 : ret * KILO;
 }
 
 static int loongson3_cpufreq_target(struct cpufreq_policy *policy, unsigned int index)
 {
-	int ret;
+	int ret, core = cpu_logical_map(policy->cpu);
 
-	ret = do_service_request(cpu_data[policy->cpu].core,
-				 FREQ_INFO_TYPE_LEVEL, CMD_SET_FREQ_INFO, index, 0);
+	ret = do_service_request(core, FREQ_INFO_TYPE_LEVEL, CMD_SET_FREQ_INFO,
+				 index, 0);
 
 	return (ret >= 0) ? 0 : ret;
 }
 
 static int configure_freq_table(int cpu)
 {
-	int i, ret, boost_level, max_level, freq_level;
+	int i, ret, core, boost_level, max_level, freq_level;
 	struct platform_device *pdev = cpufreq_get_driver_data();
 	struct loongson3_freq_data *data;
 
 	if (per_cpu(freq_data, cpu))
 		return 0;
 
-	ret = do_service_request(cpu, 0, CMD_GET_FREQ_LEVEL_NUM, 0, 0);
+	core = cpu_logical_map(cpu);
+
+	ret = do_service_request(core, 0, CMD_GET_FREQ_LEVEL_NUM, 0, 0);
 	if (ret < 0)
 		return ret;
 	max_level = ret;
 
-	ret = do_service_request(cpu, 0, CMD_GET_FREQ_BOOST_LEVEL, 0, 0);
+	ret = do_service_request(core, 0, CMD_GET_FREQ_BOOST_LEVEL, 0, 0);
 	if (ret < 0)
 		return ret;
 	boost_level = ret;
@@ -263,7 +265,7 @@ static int configure_freq_table(int cpu)
 	data->def_freq_level = boost_level - 1;
 
 	for (i = 0; i < freq_level; i++) {
-		ret = do_service_request(cpu, FREQ_INFO_TYPE_FREQ, CMD_GET_FREQ_LEVEL_INFO, i, 0);
+		ret = do_service_request(core, FREQ_INFO_TYPE_FREQ, CMD_GET_FREQ_LEVEL_INFO, i, 0);
 		if (ret < 0) {
 			devm_kfree(&pdev->dev, data);
 			return ret;
-- 
2.52.0

