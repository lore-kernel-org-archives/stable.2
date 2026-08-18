Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0229846C83B;
	Tue, 18 Aug 2026 12:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787056884; cv=none; b=aYuT0ztVKu4rGk1kJuak/jKj7vEiTJmUWu1PS0lxH7FPfWVIXAmkQcFzBzgedeHb2PClZhaTCBDpycRBAJbcBAKsw/w/cayNFwzuWK2zkuckV4XtmEueA6C3CsR9wEz/D5WWKicAWMBvJYeie5MPQZjfuFXx12FVTs2/E1RchPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787056884; c=relaxed/simple;
	bh=rLcSt2kfYOBdgaMB6RoZ+1ArusdKM3QJC841FuKNZYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=stt5FyHU0nXExbM4mrzht/+jNRwtQ7u2Mevw4O0w8Wx8CUw04G3Y1F7twGCCM8octKPlE7nE+AialVVaXwm/R/4FzMCYVIq8Lcn2irnJKqh9qPLOfn/vxNCRPtcsyu0v7iueh8851Lytnv1tUZERLMbxfAiriS1XPUP0fi1tLdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C611F000E9;
	Tue, 18 Aug 2026 12:41:18 +0000 (UTC)
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
Subject: [PATCH 3/5] cpufreq: loongson3: Replace per-package mutex with per-node
Date: Tue, 18 Aug 2026 20:39:19 +0800
Message-ID: <20260818123921.3600606-4-chenhuacai@loongson.cn>
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

Our server productions (e.g. Loongson-3D6000/3E6000) can have multiple
nodes in one package and SMC mailboxes are also per-node. So replace the
per-package mutex with per-node one.

Cc: stable@vger.kernel.org
Signed-off-by: Hongliang Wang <wanghongliang@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/cpufreq/loongson3_cpufreq.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/loongson3_cpufreq.c b/drivers/cpufreq/loongson3_cpufreq.c
index 630f679aa739..e3cd78a5ab18 100644
--- a/drivers/cpufreq/loongson3_cpufreq.c
+++ b/drivers/cpufreq/loongson3_cpufreq.c
@@ -169,7 +169,7 @@ struct loongson3_freq_data {
 	struct cpufreq_frequency_table table[];
 };
 
-static struct mutex cpufreq_mutex[MAX_PACKAGES];
+static struct mutex cpufreq_mutex[MAX_NUMNODES];
 static struct cpufreq_driver loongson3_cpufreq_driver;
 static DEFINE_PER_CPU(struct loongson3_freq_data *, freq_data);
 
@@ -177,14 +177,14 @@ static inline int do_service_request(u32 id, u32 info, u32 cmd, u32 val, u32 ext
 {
 	int retries;
 	unsigned int cpu = raw_smp_processor_id();
-	unsigned int package = cpu_data[cpu].package;
+	unsigned int nid = cpu_to_node(cpu);
 	union smc_message msg, last;
 
-	mutex_lock(&cpufreq_mutex[package]);
+	mutex_lock(&cpufreq_mutex[nid]);
 
 	last.value = iocsr_read32(LOONGARCH_IOCSR_SMCMBX);
 	if (!last.complete) {
-		mutex_unlock(&cpufreq_mutex[package]);
+		mutex_unlock(&cpufreq_mutex[nid]);
 		return -EPERM;
 	}
 
@@ -208,11 +208,11 @@ static inline int do_service_request(u32 id, u32 info, u32 cmd, u32 val, u32 ext
 	}
 
 	if (!msg.complete || msg.cmd != CMD_OK) {
-		mutex_unlock(&cpufreq_mutex[package]);
+		mutex_unlock(&cpufreq_mutex[nid]);
 		return -EPERM;
 	}
 
-	mutex_unlock(&cpufreq_mutex[package]);
+	mutex_unlock(&cpufreq_mutex[nid]);
 
 	return msg.val;
 }
@@ -337,7 +337,7 @@ static int loongson3_cpufreq_probe(struct platform_device *pdev)
 {
 	int i, ret;
 
-	for (i = 0; i < MAX_PACKAGES; i++) {
+	for (i = 0; i < MAX_NUMNODES; i++) {
 		ret = devm_mutex_init(&pdev->dev, &cpufreq_mutex[i]);
 		if (ret)
 			return ret;
-- 
2.52.0

