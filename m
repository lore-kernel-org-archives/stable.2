Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD2F2F5495;
	Thu, 17 Sep 2026 13:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789651508; cv=none; b=U3qXA2S+yYMJXOcOiXPDDYu56nmTVPxVQ5J2AsH0v8j/IP6HDPRlyYr8RzpnaXgnSbvvRSsqwstShLSYHaiWyMScae+Xwz5IRAiTAr7VgfGxVU2ywsklrYQSvZWebaTiNDEIgEWBAbm0gdVNdoiRhBmb/qo7XuXLOTZQeYYfCrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789651508; c=relaxed/simple;
	bh=be1sKeY/yv3CAEgCb1aQ5FOLCGIcJaMj48hSj+jWCD0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M+cPv7V5cJHL0iXJs3pCeZU+Mt91N7NguFnHc29+FQNrz0m18v/4qdVsHRe3dd1UwcdjRA5rVeGH3WJinWPNftjk05IsieC9AIFstmAf5YXkoN0eVugD+rg4lhnymZ7DgCCJZAigFUqcJ1o0J5LJ/czvQ/6MJ/WGqQt+RMlGoas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowACX_zkr6qtqXGiBCA--.3673S2;
	Thu, 17 Sep 2026 21:24:59 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: bharat.kumar.gogada@amd.com
Cc: bhelgaas@google.com,
	kwilczynski@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	mani@kernel.org,
	michal.simek@amd.com,
	robh@kernel.org,
	thippeswamy.havalige@amd.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] PCI: xilinx-xdma: Fix device node reference leak in xilinx_pl_dma_pcie_init_irq_domain()
Date: Thu, 17 Sep 2026 13:24:59 +0000
Message-Id: <20260917132459.2153240-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACX_zkr6qtqXGiBCA--.3673S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tr1DJr1UAr4kAry3WFyUWrg_yoW8tFyfpF
	WUG34a9rZ5tF40gr47CF9Y9a4agFnakrZ7tw4Ik3ZrZr13Jw4UGFyUWFya9ry3KFW8Xr1f
	AF43JF1ruF17AF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPSb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxV
	W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VAI37AI020EjII2zVCS5cI20VAGYxC7M4II
	rI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMx
	AIw28IcVCjz48v1sIEY20_Gr43Wr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r
	43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
	W8Jr0_Cr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_GcCE3sUvcSsGvfC2KfnxnUUI43ZEXa7I
	U55DG7UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgUNA2qrq3bE1wAAsC

xilinx_pl_dma_pcie_init_irq_domain() takes a reference to the PCIe
interrupt-controller child node with of_get_child_by_name(), but the
error paths after the two irq_domain_create_linear() calls and after
xilinx_pl_dma_pcie_init_msi_irq_domain() returns directly without
dropping it.  irq_domain_create_linear() gets its own reference on the
fwnode, so the domains do not consume the caller's one.

Add an err_put_node label that drops the reference before returning.

Fixes: 8d786149d78c ("PCI: xilinx-xdma: Add Xilinx XDMA Root Port driver")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/pci/controller/pcie-xilinx-dma-pl.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-dma-pl.c b/drivers/pci/controller/pcie-xilinx-dma-pl.c
index b037c8f315e4..e18eeecdc8a9 100644
--- a/drivers/pci/controller/pcie-xilinx-dma-pl.c
+++ b/drivers/pci/controller/pcie-xilinx-dma-pl.c
@@ -581,7 +581,7 @@ static int xilinx_pl_dma_pcie_init_irq_domain(struct pl_dma_pcie *port)
 	port->pldma_domain = irq_domain_create_linear(of_fwnode_handle(pcie_intc_node), 32,
 						      &event_domain_ops, port);
 	if (!port->pldma_domain)
-		return -ENOMEM;
+		goto err_put_node;
 
 	irq_domain_update_bus_token(port->pldma_domain, DOMAIN_BUS_NEXUS);
 
@@ -589,7 +589,7 @@ static int xilinx_pl_dma_pcie_init_irq_domain(struct pl_dma_pcie *port)
 						     &intx_domain_ops, port);
 	if (!port->intx_domain) {
 		dev_err(dev, "Failed to get a INTx IRQ domain\n");
-		return -ENOMEM;
+		goto err_put_node;
 	}
 
 	irq_domain_update_bus_token(port->intx_domain, DOMAIN_BUS_WIRED);
@@ -597,13 +597,17 @@ static int xilinx_pl_dma_pcie_init_irq_domain(struct pl_dma_pcie *port)
 	ret = xilinx_pl_dma_pcie_init_msi_irq_domain(port);
 	if (ret != 0) {
 		irq_domain_remove(port->intx_domain);
-		return -ENOMEM;
+		goto err_put_node;
 	}
 
 	of_node_put(pcie_intc_node);
 	raw_spin_lock_init(&port->lock);
 
 	return 0;
+
+err_put_node:
+	of_node_put(pcie_intc_node);
+	return -ENOMEM;
 }
 
 static int xilinx_pl_dma_pcie_setup_irq(struct pl_dma_pcie *port)
-- 
2.34.1

