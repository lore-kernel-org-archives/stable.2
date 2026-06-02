Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB59033A70A;
	Tue,  2 Jun 2026 02:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780369128; cv=none; b=dKLRqxso4qGwG0A1Sb8albG6LzJdhcwaWc8chHiUBWFibZ6YgCObBUGzaakSVpq0FI41gbFDM4Q3K8Ff4x0KMqSwiyGvBbzDXhWaw8YfdfoM2hJ4vK97I1dtLsxFBf5k8epYHEy+E2F1NqEXQGPhtWY+1E8XdUa7xqIlb3k5ZBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780369128; c=relaxed/simple;
	bh=nIWrX8/xjSgQop69xjMm5VGLqbFc7I2snTAO0davVvM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hXKNPT/jmepq1xSxY6t3Q4w9fv2AmbXGLfoJAfFtmLPJMrrnOknFF6IzvCSQ2O6iAAfVf2ROJCzRLWBYwR866XTqVY+80VXuWatVVDwEIg36iITL2jG955+i36X/ofPUQ1y2bn6E4S8g75ttqQS2WWzrp4M/k1JiVeGnmwpsTrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=T2gXAMYt; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="T2gXAMYt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=jW
	cj5KXzVf50Z0Lmy57Di0WeDde7W1hIGhp4tmxTXms=; b=T2gXAMYt3MS1cbIwSg
	P5Dop4it863AXVXRfy7ro+JlZW1C7ANyhZ0AemnU5HZVv+3s1Cpu985KuNAwsUns
	KWhJQu3vNTshFV0AjbJLv6Q4zhBk9VsyrzBtFx4WH4qWKL8m6hfMm/kZFWcokpI5
	SpS3VZTlOgOV2oBS2ftjqcwIs=
Received: from pek-lpg-core5.wrs.com (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3n8nIRh5q+v6CAw--.56991S2;
	Tue, 02 Jun 2026 10:58:17 +0800 (CST)
From: Robert Garcia <rob_garcia@163.com>
To: stable@vger.kernel.org,
	Prathamesh Shete <pshete@nvidia.com>
Cc: Thierry Reding <treding@nvidia.com>,
	Petlozu Pravareshwar <petlozup@nvidia.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Meng Li <Meng.Li@windriver.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Robert Garcia <rob_garcia@163.com>,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.6.y] soc/tegra: pmc: Fix unsafe generic_handle_irq() call
Date: Tue,  2 Jun 2026 10:58:12 +0800
Message-ID: <20260602025812.3535026-1-rob_garcia@163.com>
X-Mailer: git-send-email 2.44.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3n8nIRh5q+v6CAw--.56991S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Wry5KFyruF1fAFWkWr13XFb_yoWxWrWUpa
	y5KFWF9w4UJFWxua15ua10vF13CF18X3yxGr43Aas3J3yUKrnY9FnxXFyYqF48ArZa9F45
	Aay0yryUKw4UXFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRdR65UUUUU=
X-CM-SenderInfo: 5uresw5dufxti6rwjhhfrp/xtbDAgnlUWoeRskKvQAA3z

From: Prathamesh Shete <pshete@nvidia.com>

[ Upstream commit e6d96073af681780820c94079b978474a8a44413 ]

Currently, when resuming from system suspend on Tegra platforms,
the following warning is observed:

WARNING: CPU: 0 PID: 14459 at kernel/irq/irqdesc.c:666
Call trace:
 handle_irq_desc+0x20/0x58 (P)
 tegra186_pmc_wake_syscore_resume+0xe4/0x15c
 syscore_resume+0x3c/0xb8
 suspend_devices_and_enter+0x510/0x540
 pm_suspend+0x16c/0x1d8

The warning occurs because generic_handle_irq() is being called from
a non-interrupt context which is considered as unsafe.

Fix this warning by deferring generic_handle_irq() call to an IRQ work
which gets executed in hard IRQ context where generic_handle_irq()
can be called safely.

When PREEMPT_RT kernels are used, regular IRQ work (initialized with
init_irq_work) is deferred to run in per-CPU kthreads in preemptible
context rather than hard IRQ context. Hence, use the IRQ_WORK_INIT_HARD
variant so that with PREEMPT_RT kernels, the IRQ work is processed in
hardirq context instead of being deferred to a thread which is required
for calling generic_handle_irq().

On non-PREEMPT_RT kernels, both init_irq_work() and IRQ_WORK_INIT_HARD()
execute in IRQ context, so this change has no functional impact for
standard kernel configurations.

Signed-off-by: Petlozu Pravareshwar <petlozup@nvidia.com>
Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
[treding@nvidia.com: miscellaneous cleanups]
Signed-off-by: Thierry Reding <treding@nvidia.com>
[ Deleted tegra186_pmc_process_wake_events() 
which has a bit differences. ]
Signed-off-by: Robert Garcia <rob_garcia@163.com>
---
 drivers/soc/tegra/pmc.c | 109 +++++++++++++++++++++++++++-------------
 1 file changed, 74 insertions(+), 35 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index a9dc15ec8a13..968ea40c17b7 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -28,6 +28,7 @@
 #include <linux/iopoll.h>
 #include <linux/irqdomain.h>
 #include <linux/irq.h>
+#include <linux/irq_work.h>
 #include <linux/kernel.h>
 #include <linux/of_address.h>
 #include <linux/of_clk.h>
@@ -500,6 +501,10 @@ struct tegra_pmc {
 	unsigned long *wake_sw_status_map;
 	unsigned long *wake_cntrl_level_map;
 	struct syscore_ops syscore;
+
+	/* Pending wake IRQ processing */
+	struct irq_work wake_work;
+	u32 *wake_status;
 };
 
 static struct tegra_pmc *pmc = &(struct tegra_pmc) {
@@ -1973,6 +1978,50 @@ static int tegra_pmc_parse_dt(struct tegra_pmc *pmc, struct device_node *np)
 	return 0;
 }
 
+/* translate sc7 wake sources back into IRQs to catch edge triggered wakeups */
+static void tegra186_pmc_wake_handler(struct irq_work *work)
+{
+	struct tegra_pmc *pmc = container_of(work, struct tegra_pmc, wake_work);
+	unsigned int i, wake;
+
+	for (i = 0; i < pmc->soc->max_wake_vectors; i++) {
+		unsigned long status = pmc->wake_status[i];
+
+		for_each_set_bit(wake, &status, 32) {
+			irq_hw_number_t hwirq = wake + (i * 32);
+			struct irq_desc *desc;
+			unsigned int irq;
+
+			irq = irq_find_mapping(pmc->domain, hwirq);
+			if (!irq) {
+				dev_warn(pmc->dev,
+					"No IRQ found for WAKE#%lu!\n",
+					hwirq);
+				continue;
+			}
+
+			dev_dbg(pmc->dev,
+				"Resume caused by WAKE#%lu mapped to IRQ#%u\n",
+				hwirq, irq);
+
+			desc = irq_to_desc(irq);
+			if (!desc) {
+				dev_warn(pmc->dev,
+					"No descriptor found for IRQ#%u\n",
+					irq);
+				continue;
+			}
+
+			if (!desc->action || !desc->action->name)
+				continue;
+
+			generic_handle_irq(irq);
+		}
+
+		pmc->wake_status[i] = 0;
+	}
+}
+
 static int tegra_pmc_init(struct tegra_pmc *pmc)
 {
 	if (pmc->soc->max_wake_events > 0) {
@@ -1991,6 +2040,18 @@ static int tegra_pmc_init(struct tegra_pmc *pmc)
 		pmc->wake_cntrl_level_map = bitmap_zalloc(pmc->soc->max_wake_events, GFP_KERNEL);
 		if (!pmc->wake_cntrl_level_map)
 			return -ENOMEM;
+
+		pmc->wake_status = kcalloc(pmc->soc->max_wake_vectors, sizeof(u32), GFP_KERNEL);
+		if (!pmc->wake_status)
+			return -ENOMEM;
+
+		/*
+		 * Initialize IRQ work for processing wake IRQs. Must use
+		 * HARD_IRQ variant to run in hard IRQ context on PREEMPT_RT
+		 * because we call generic_handle_irq() which requires hard
+		 * IRQ context.
+		 */
+		pmc->wake_work = IRQ_WORK_INIT_HARD(tegra186_pmc_wake_handler);
 	}
 
 	if (pmc->soc->init)
@@ -3385,52 +3446,30 @@ static void wke_clear_wake_status(struct tegra_pmc *pmc)
 	}
 }
 
-/* translate sc7 wake sources back into IRQs to catch edge triggered wakeups */
-static void tegra186_pmc_process_wake_events(struct tegra_pmc *pmc, unsigned int index,
-					     unsigned long status)
-{
-	unsigned int wake;
-	unsigned long flags;
-
-	dev_dbg(pmc->dev, "Wake[%d:%d]  status=%#lx\n", (index * 32) + 31, index * 32, status);
-
-	for_each_set_bit(wake, &status, 32) {
-		irq_hw_number_t hwirq = wake + 32 * index;
-		struct irq_desc *desc;
-		unsigned int irq;
-
-		irq = irq_find_mapping(pmc->domain, hwirq);
-
-		desc = irq_to_desc(irq);
-		if (!desc || !desc->action || !desc->action->name) {
-			dev_dbg(pmc->dev, "Resume caused by WAKE%ld, IRQ %d\n", hwirq, irq);
-			continue;
-		}
-
-		dev_dbg(pmc->dev, "Resume caused by WAKE%ld, %s\n", hwirq, desc->action->name);
-		local_irq_save(flags);
-		irq_enter();
-		generic_handle_irq(irq);
-		irq_exit();
-		local_irq_restore(flags);
-	}
-}
-
 static void tegra186_pmc_wake_syscore_resume(void)
 {
-	u32 status, mask;
 	unsigned int i;
+	u32 mask;
 
 	for (i = 0; i < pmc->soc->max_wake_vectors; i++) {
 		mask = readl(pmc->wake + WAKE_AOWAKE_TIER2_ROUTING(i));
-		status = readl(pmc->wake + WAKE_AOWAKE_STATUS_R(i)) & mask;
-
-		tegra186_pmc_process_wake_events(pmc, i, status);
+		pmc->wake_status[i] = readl(pmc->wake + WAKE_AOWAKE_STATUS_R(i)) & mask;
 	}
+
+	/* Schedule IRQ work to process wake IRQs (if any) */
+	irq_work_queue(&pmc->wake_work);
 }
 
 static int tegra186_pmc_wake_syscore_suspend(void)
 {
+	unsigned int i;
+
+	/* Check if there are unhandled wake IRQs */
+	for (i = 0; i < pmc->soc->max_wake_vectors; i++)
+		if (pmc->wake_status[i])
+			dev_warn(pmc->dev,
+				 "Unhandled wake IRQs pending vector[%u]: 0x%x\n",
+				 i, pmc->wake_status[i]);
 	wke_read_sw_wake_status(pmc);
 
 	/* flip the wakeup trigger for dual-edge triggered pads
-- 
2.44.3

