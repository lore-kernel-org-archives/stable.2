Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F595221C3;
	Thu, 17 Sep 2026 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789651232; cv=none; b=iEEn6YRy5ndqmOvxOnEz9ofqH6BXqy9qUNZ8jU0R41KoDR259YcqR/452iwC1uOX+80G5lE3VNaOGuL+JaZ+UDUIhFYIa+9wxSqtoMEWrKorIVogXNx100xalmpxUPFms/b0kCxm/HBCVMLZoSgmNxhDhT8M/w+9XCPXNCIOJPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789651232; c=relaxed/simple;
	bh=wdpwlxaTpsxYLHO+M0yFmrOPTjXA0NQRfQSuIak286M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pbnf7RPqtnQ3RDLzbPur0iE+7QUwR/orW/GdTzrR+tdrhSY+E3ZU5KzCGjiUvttwoXubb7TTPHsWoDVehKQXxR0HOM54Fowrqj3nyW2DxluBJOOo/mG8yhiQhsdExOE0fV+hrggfebwAr19gh8ybbFt6CKcMLBEES6WR6gH1/eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowABXwz0X6atq3lWBCA--.44628S2;
	Thu, 17 Sep 2026 21:20:23 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: a-verma1@ti.com
Cc: bhelgaas@google.com,
	jan.kiszka@siemens.com,
	kwilczynski@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	s-vadapalli@ti.com,
	vigneshr@ti.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] PCI: keystone: Fix host bridge device leak in ks_pcie_quirk()
Date: Thu, 17 Sep 2026 13:20:22 +0000
Message-Id: <20260917132022.2153069-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABXwz0X6atq3lWBCA--.44628S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr15Aw45Ww1xXr1DuF1fCrg_yoW8ur43pF
	sIqa4YyFW8Jr45Ww4xZ3WY9FyYyFnayayrC3ykK34I9r15KFyYqF9rGFyFqw4fAFWkJryU
	Jr1Utw18Jw1kJaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPab7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6r4j6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWxJr0_GcWlOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq62Iq12xI8VA0II8E6IAqYI8I648v4I1lFIxG
	xcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l42
	xK82IY6x8ErcxFaVAv8VW8GFyrJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	4UJVWxJr1lIxAIcVC2z280aVCY1x0267AKxVW0oVCq3bIYCTnIWIevJa73UjIFyTuYvjxU
	DSfODUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgINA2qrq3bB3gAAsJ

ks_pcie_quirk() obtains a reference to the host bridge device with
pci_get_host_bridge_device() but never releases it.  Every early exit
from the AM654 PG1.0 workaround leaks the reference: when the bridge
device or its parent is missing, when the parent has no driver data,
and when the RTL revision is not AM6_PCI_PG1_RTL_VER.  The quirk runs
for every downstream PCI device, so the reference count grows without
bound.

Add a common out label that drops the reference with
pci_put_host_bridge_device() before returning.

Fixes: 86f271f22bbb ("PCI: keystone: Add workaround for Errata #i2037 (AM65x SR 1.0)")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/pci/controller/dwc/pci-keystone.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 278d2dba1db0..cc6739edd434 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -528,7 +528,7 @@ static void ks_pcie_quirk(struct pci_dev *dev)
 {
 	struct pci_bus *bus = dev->bus;
 	struct keystone_pcie *ks_pcie;
-	struct device *bridge_dev;
+	struct device *bridge_dev = NULL;
 	struct pci_dev *bridge;
 	u32 val;
 
@@ -582,23 +582,27 @@ static void ks_pcie_quirk(struct pci_dev *dev)
 	if (pci_match_id(am6_pci_devids, bridge)) {
 		bridge_dev = pci_get_host_bridge_device(dev);
 		if (!bridge_dev || !bridge_dev->parent)
-			return;
+			goto out;
 
 		ks_pcie = dev_get_drvdata(bridge_dev->parent);
 		if (!ks_pcie)
-			return;
+			goto out;
 
 		val = ks_pcie_app_readl(ks_pcie, PID);
 		val &= RTL;
 		val >>= RTL_SHIFT;
 		if (val != AM6_PCI_PG1_RTL_VER)
-			return;
+			goto out;
 
 		if (pcie_get_readrq(dev) > 128) {
 			dev_info(&dev->dev, "limiting MRRS to 128 bytes\n");
 			pcie_set_readrq(dev, 128);
 		}
 	}
+
+out:
+	if (bridge_dev)
+		pci_put_host_bridge_device(bridge_dev);
 }
 DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, ks_pcie_quirk);
 
-- 
2.34.1

