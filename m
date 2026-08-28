Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A5B381EA3;
	Fri, 28 Aug 2026 03:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787886810; cv=none; b=mSgDgJfeBBj9RsL6aTj83BgXH4b95DpwwMIsuuMxoyIXC0wW46ngGTtINblzDF5rm42V6M4bw2/9aca6yuJB+ojsWOu436yqXrXglX7/eJev6uA/8Jv7NfjQVtTzl7f+oZS2EWldJkqHM8E240e1vFDfRWXF8pmTHwMfJI2TBgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787886810; c=relaxed/simple;
	bh=ZsF9BHMV8HOeRUybQmeX5BLLV0crMaLcBiNlhT8/+zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O9wvyDMX5cpKW8ZlU/p0l4DehaZ+R2ZcAG5k1du5HBxI/dzIFboeaQKPY2d9H2dmgcDoPfoeK83S/oEubmTKtr2oMBC8XBY3oMpKyap1KpRtsy9MgVbE+rdO7AkEEDZeATsXvqAUtKBK4qO2AZMD8yXDsq84CIHXxll+UJv8XB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 410DA1F000E9;
	Fri, 28 Aug 2026 03:13:24 +0000 (UTC)
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
	Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH V2 5/5] cpufreq: loongson3: Replace IOCSR read/write with MMIO ones
Date: Fri, 28 Aug 2026 11:12:01 +0800
Message-ID: <20260828031201.1500767-6-chenhuacai@loongson.cn>
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

Our server productions (e.g. Loongson-3D6000/3E6000) can have multiple
nodes in one package and SMC mailboxes are also per-node. However, IOCSR
read/write can only perform on the current node, while sometimes we want
to perform on other nodes (e.g. when switch governor, the get and target
callbacks are not run on target core). So replace IOCSR read/write with
MMIO ones.

Cc: stable@vger.kernel.org
Fixes: ccf51454145b ("cpufreq: Add Loongson-3 CPUFreq driver support")
Tested-by: Xi Ruoyao <xry111@xry111.site>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/cpufreq/loongson3_cpufreq.c | 34 +++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/loongson3_cpufreq.c b/drivers/cpufreq/loongson3_cpufreq.c
index 3a5bf970077a..dcb6c70c0def 100644
--- a/drivers/cpufreq/loongson3_cpufreq.c
+++ b/drivers/cpufreq/loongson3_cpufreq.c
@@ -16,6 +16,7 @@
 #include <asm/loongarch.h>
 #include <asm/loongson.h>
 #include <asm/smp.h>
+#include <asm/numa.h>
 
 /* Message */
 union smc_message {
@@ -164,6 +165,12 @@ union smc_message {
 
 #define FREQ_MAX_LEVEL			16
 
+#define MMIO_SMCMBX(node) \
+	((void __iomem *)(nid_to_addrbase(node) | IO_BASE | LOONGSON_REG_BASE | LOONGARCH_IOCSR_SMCMBX))
+
+#define MMIO_MISC_FUNC(node) \
+	((void __iomem *)(nid_to_addrbase(node) | IO_BASE | LOONGSON_REG_BASE | LOONGARCH_IOCSR_MISC_FUNC))
+
 struct loongson3_freq_data {
 	unsigned int def_freq_level;
 	struct cpufreq_frequency_table table[];
@@ -176,13 +183,27 @@ static DEFINE_PER_CPU(struct loongson3_freq_data *, freq_data);
 static inline int do_service_request(u32 id, u32 info, u32 cmd, u32 val, u32 extra)
 {
 	int retries;
-	unsigned int cpu = raw_smp_processor_id();
-	unsigned int nid = cpu_to_node(cpu);
+	unsigned int cpu = 0, nid;
 	union smc_message msg, last;
 
+#ifdef CONFIG_SMP
+	switch (cmd) {
+	case CMD_GET_FREQ_INFO:
+	case CMD_SET_FREQ_INFO:
+	case CMD_GET_FREQ_LEVEL_NUM:
+	case CMD_GET_FREQ_LEVEL_INFO:
+	case CMD_GET_FREQ_BOOST_LEVEL:
+		cpu = cpu_number_map(id);
+		break;
+	default:
+		cpu = raw_smp_processor_id();
+	}
+#endif
+	nid = cpu_to_node(cpu);
+
 	mutex_lock(&cpufreq_mutex[nid]);
 
-	last.value = iocsr_read32(LOONGARCH_IOCSR_SMCMBX);
+	last.value = readl(MMIO_SMCMBX(nid));
 	if (!last.complete) {
 		mutex_unlock(&cpufreq_mutex[nid]);
 		return -EPERM;
@@ -195,12 +216,11 @@ static inline int do_service_request(u32 id, u32 info, u32 cmd, u32 val, u32 ext
 	msg.extra	= extra;
 	msg.complete	= 0;
 
-	iocsr_write32(msg.value, LOONGARCH_IOCSR_SMCMBX);
-	iocsr_write32(iocsr_read32(LOONGARCH_IOCSR_MISC_FUNC) | IOCSR_MISC_FUNC_SOFT_INT,
-		      LOONGARCH_IOCSR_MISC_FUNC);
+	writel(msg.value, MMIO_SMCMBX(nid));
+	writel(readl(MMIO_MISC_FUNC(nid)) | IOCSR_MISC_FUNC_SOFT_INT, MMIO_MISC_FUNC(nid));
 
 	for (retries = 0; retries < 10000; retries++) {
-		msg.value = iocsr_read32(LOONGARCH_IOCSR_SMCMBX);
+		msg.value = readl(MMIO_SMCMBX(nid));
 		if (msg.complete)
 			break;
 
-- 
2.52.0

