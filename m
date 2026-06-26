Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F03A3E3D93;
	Fri, 26 Jun 2026 15:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782488903; cv=none; b=hoyrurlibRVFK5XGo/4Pa+Rh1w3PJL21tRBVr7huFvrLxqdZNWmftrOrPEpBmwdkRJ0fHa1q4f4qFR+2Cqc/OhZOS4r/5iVB/NIvYUPf1HLpHLz4dD5L4jqFTpyL+KJluZxqjSt/GC1fsgv1rzWSuXZ7epnPK/k1r+vFOM/4BGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782488903; c=relaxed/simple;
	bh=zoeDgfUPvtY3sUBygUBp4EC0mMNsqeldZJWqBdb1LU4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lbduXmH+7f809bD31csQfrIsCtEDtmkdOcvfJX9tNeiv+2RRlvJOt0alu8jsHMKsYh+2vJmThnIuclpC8chNFOxNdRFSYAJRiVD8GBELm/LOLIwBTp2XcypSBFnf2ioVfHhKQRCp6LHb51YmpUI3aRAidApfNbRgP4emDzTSPgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-01 (Coremail) with SMTP id qwCowAAHoMg6nz5qQt1sAw--.17003S2;
	Fri, 26 Jun 2026 23:48:11 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-pci@vger.kernel.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] fix: PCI: dra7xx: dra7xx_pcie_probe: fix missing device_link_del on phy   error paths
Date: Fri, 26 Jun 2026 23:48:09 +0800
Message-Id: <20260626154809.53770-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAHoMg6nz5qQt1sAw--.17003S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFy8AFW8tw1fWw1xWFW5GFg_yoW8Zr4UpF
	W7tFW8tFyrXF4fXa43W3W5u3WYqF4DAa4UKws7C3WfuFy3ArWqvrWrJryIq3WftFZ5uFy3
	tan8t3W7CFs8ZwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_
	Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x0JUJuc
	_UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwcKA2o+ikU3EgAAs3

In dra7xx_pcie_probe(), when devm_phy_get() fails for a later phy device
  (i > 0), the function directly returns PTR_ERR(phy[i]) without calling
  device_link_del() on previously added device links. Similarly, when
  dra7xx_pcie_enable_phy() fails, all phy_count device links are leaked as
  the function returns directly without cleanup.

Change the error paths to jump to the existing err_link label which
  properly iterates through link[0..i) and calls device_link_del() for
  each.

Cc: stable@vger.kernel.org
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/pci/controller/dwc/pci-dra7xx.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index cd904659c321..153ee6f7dbfc 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -743,8 +743,10 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
 	for (i = 0; i < phy_count; i++) {
 		snprintf(name, sizeof(name), "pcie-phy%d", i);
 		phy[i] = devm_phy_get(dev, name);
-		if (IS_ERR(phy[i]))
-			return PTR_ERR(phy[i]);
+		if (IS_ERR(phy[i])) {
+			ret = PTR_ERR(phy[i]);
+			goto err_link;
+		}
 
 		link[i] = device_link_add(dev, &phy[i]->dev, DL_FLAG_STATELESS);
 		if (!link[i]) {
@@ -767,7 +769,8 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
 	ret = dra7xx_pcie_enable_phy(dra7xx);
 	if (ret) {
 		dev_err(dev, "failed to enable phy\n");
-		return ret;
+		dra7xx_pcie_disable_phy(dra7xx);
+		goto err_link;
 	}
 
 	platform_set_drvdata(pdev, dra7xx);
@@ -910,7 +913,8 @@ static int dra7xx_pcie_resume_noirq(struct device *dev)
 	ret = dra7xx_pcie_enable_phy(dra7xx);
 	if (ret) {
 		dev_err(dev, "failed to enable phy\n");
-		return ret;
+		dra7xx_pcie_disable_phy(dra7xx);
+		goto err_link;
 	}
 
 	return 0;
-- 
2.39.5 (Apple Git-154)

