Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708DD471436;
	Tue, 18 Aug 2026 12:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787056910; cv=none; b=OATGRNBNh72VRMs15W/c8KUlDTOCf1OjMvSo5k7ONSiZuBXRs8pnq5dfDD24ubpUIEtSU2LELGVN36jNDvTeTCZmqeZJ6038i97q/VJDLBiFkUToZBS2yrgpbHdjnvFB2+tTwxWD4xJ0FPpzbOsj/9UZ2dQYIzWG1+NGIFvWz7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787056910; c=relaxed/simple;
	bh=eUKT3CVNml9vN1N9oGnhYjqhTpBsI0FErV7HButheTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VWE/0Wn8Qv0w6oRPq4rAx5EQ/jellWtetyeyhre69o/Bmr1T1Oq6JZL6r0S95A9icaW6JkEbL5G0mpcwUDvoWn0x92aVDDHVVNS4AjNYGj5QOWLxfLC2ql8INvUpJyizmckCsL1E7+3irJQCZEX8S9iQVgJgmIMm0h3oRlooJBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9593F1F000E9;
	Tue, 18 Aug 2026 12:41:43 +0000 (UTC)
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
Subject: [PATCH 4/5] cpufreq: loongson3: Use global physical CPU ID in get/target callbacks
Date: Tue, 18 Aug 2026 20:39:20 +0800
Message-ID: <20260818123921.3600606-5-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260818123921.3600606-1-chenhuacai@loongson.cn>
References: <20260818123921.3600606-1-chenhuacai@loongson.cn>
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
Signed-off-by: Hongliang Wang <wanghongliang@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/cpufreq/loongson3_cpufreq.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/loongson3_cpufreq.c b/drivers/cpufreq/loongson3_cpufreq.c
index e3cd78a5ab18..c75c0e30e881 100644
--- a/drivers/cpufreq/loongson3_cpufreq.c
+++ b/drivers/cpufreq/loongson3_cpufreq.c
@@ -219,38 +219,40 @@ static inline int do_service_request(u32 id, u32 info, u32 cmd, u32 val, u32 ext
 
 static unsigned int loongson3_cpufreq_get(unsigned int cpu)
 {
-	int ret;
+	int ret, core = cpu_logical_map(cpu);
 
-	ret = do_service_request(cpu, FREQ_INFO_TYPE_FREQ, CMD_GET_FREQ_INFO, 0, 0);
+	ret = do_service_request(core, FREQ_INFO_TYPE_FREQ, CMD_GET_FREQ_INFO, 0, 0);
 
 	return ret * KILO;
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

