Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049599;
	b=4mCgTBTc5ejYu4wZIFNL67kms3NLyiY7cDgwlsTYw4kAQK1IIjuXJbyRaunyZJuMn0Vh
	 4uzKx+uzGFzGkjsoI5ebm7LARLtQWn1vPkn5nc/pp60za2n4hlqHY92CJWMP1W1Fq4RZI
	 PULk+3iX15Rp+rm+dSsaLufN9nj9nCCCLD/i4WQBnnDiuXnVkIknoZygaRBWnd17Nv9H5
	 vYu5ogBoTPw6TBzqHi8o3ix3oMN5bIyGxksCT40hGC9888DFq0yBtDGXK/B+SYrzT7133
	 NqIvjw8fQx5d+r36jVm4lvrO+NFUAc33TDTOjlYtwE/0QKfuZP+T9ahRepbQOX/+gVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049599;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=JzD0eWnEAVF+X8ybtrTkKnEQ/GocLiez1OlSKncbD9w=;
	b=tFm13lvQWDXOLXsrwlPE17FxT1lv8Qe1ZdKdzvo37FKq3QlyEDkLwmucvxDbdCKeRnZ+
	 lkiAkkmvGM2zrRFSfkpESG8qypaWnPq+KTGZXLJjPClYA1kTk9HP1IuEzE6zFKK6TZATR
	 KdRkSYk61cx7CseODNU205ovGc69fco5RKu1b4jhvOFvk07bmCUnZ5PZX1U+MlBfda8cy
	 QtNImcAofMloxXPGxJJDrjIuFXiPqlHR2S3jjf6nmErWwBzjMRLqL5cphoYVLsoQMy62/
	 WZrI9WNOftLSnps2wMCBrVw42nyPlbQ1MS891h1Xy7FoWZT8bdoZ/HGR5FkoBbJEIxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YmXgHigz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03926606A32F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YmXgHigz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC0B1F008A1;
	Sat,  7 Nov 2026 11:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049598;
	bh=JzD0eWnEAVF+X8ybtrTkKnEQ/GocLiez1OlSKncbD9w=;
	h=From:To:Cc:Subject:Date;
	b=YmXgHigzgEfTt5sGvTVOBVelVUJi2xCzsyCyUTQKYHahDpTIQ8HudtACXJnJUNTWT
	 eONhMd2vtvUpC0H+mA9NbsT7xZf7/i70JmzYJ2tw5Y9j3uCb2Ul4+fI6X6cYgKt1l0
	 FTIBJ1Yj5uRM46k2BIaV1Vfv9Ycqv1Ni/eRvtkMoAhd4YAOb909LP/r3kpRIboQInR
	 TXPUvOe2h2a/DZP2iVDCTYwkYWNmi2p7J4JKYizeLJ1Z0cawXmOPcUQ3hijfX+jkc6
	 BNwsKiPqQRPFXLK/Rk2dXhADkkC/IaFEiN4GS3ACjnjhqoj5SnZmGJXC+j1JYLLX0j
	 U6B2JNnvJuIFQ==
From: Sasha Levin <sashal@kernel.org>
To: lilinmao@kylinos.cn,
	manivannan.sadhasivam@oss.qualcomm.com,
	bhelgaas@google.com,
	a-garg7@ti.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] PCI: cadence: Store the core controller in platform drvdata" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:06:37 -0500
Message-ID: <20261107060636-failed-5.15-cfe96ce583c5@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x cfe96ce583c51bf6e034d4038c652a1e8227867c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060636-failed-5.15-cfe96ce583c5@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From cfe96ce583c51bf6e034d4038c652a1e8227867c Mon Sep 17 00:00:00 2001
From: Linmao Li <lilinmao@kylinos.cn>
Date: Tue, 15 Sep 2026 16:28:26 +0800
Subject: [PATCH] PCI: cadence: Store the core controller in platform drvdata

cdns_plat_pcie_probe() stores a struct cdns_plat_pcie pointer with
platform_set_drvdata(). cdns_plat_pcie_shutdown() and the callbacks in
cdns_pcie_pm_ops retrieve the same pointer with dev_get_drvdata() but use
it as a struct cdns_pcie pointer. This makes them read phy_count and phy
beyond the wrapper.

struct cdns_plat_pcie only contains a pointer to struct cdns_pcie. Drop
the redundant wrapper and store the struct cdns_pcie pointer directly.

Fixes: bd22885aa188 ("PCI: cadence: Refactor driver to use as a core library")
Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Aksh Garg <a-garg7@ti.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260915082826.4135665-1-lilinmao@kylinos.cn
---
 .../controller/cadence/pcie-cadence-plat.c    | 27 ++++++-------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers/pci/controller/cadence/pcie-cadence-plat.c
index 13edc6be21f59..4a24302cc5b2c 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
@@ -14,14 +14,6 @@
 
 #define CDNS_PLAT_CPU_TO_BUS_ADDR	0x0FFFFFFF
 
-/**
- * struct cdns_plat_pcie - private data for this PCIe platform driver
- * @pcie: Cadence PCIe controller
- */
-struct cdns_plat_pcie {
-	struct cdns_pcie        *pcie;
-};
-
 static const struct of_device_id cdns_plat_pcie_of_match[];
 
 static u64 cdns_plat_cpu_addr_fixup(struct cdns_pcie *pcie, u64 cpu_addr)
@@ -36,9 +28,9 @@ static const struct cdns_pcie_ops cdns_plat_ops = {
 static int cdns_plat_pcie_probe(struct platform_device *pdev)
 {
 	const struct cdns_plat_pcie_of_data *data;
-	struct cdns_plat_pcie *cdns_plat_pcie;
 	struct device *dev = &pdev->dev;
 	struct pci_host_bridge *bridge;
+	struct cdns_pcie *pcie;
 	struct cdns_pcie_ep *ep;
 	struct cdns_pcie_rc *rc;
 	bool is_rc;
@@ -51,11 +43,6 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
 	is_rc = data->is_rc;
 
 	pr_debug(" Started %s with is_rc: %d\n", __func__, is_rc);
-	cdns_plat_pcie = devm_kzalloc(dev, sizeof(*cdns_plat_pcie), GFP_KERNEL);
-	if (!cdns_plat_pcie)
-		return -ENOMEM;
-
-	platform_set_drvdata(pdev, cdns_plat_pcie);
 	if (is_rc) {
 		if (!IS_ENABLED(CONFIG_PCIE_CADENCE_PLAT_HOST))
 			return -ENODEV;
@@ -67,9 +54,9 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
 		rc = pci_host_bridge_priv(bridge);
 		rc->pcie.dev = dev;
 		rc->pcie.ops = &cdns_plat_ops;
-		cdns_plat_pcie->pcie = &rc->pcie;
+		pcie = &rc->pcie;
 
-		ret = cdns_pcie_init_phy(dev, cdns_plat_pcie->pcie);
+		ret = cdns_pcie_init_phy(dev, pcie);
 		if (ret) {
 			dev_err(dev, "failed to init phy\n");
 			return ret;
@@ -94,9 +81,9 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
 
 		ep->pcie.dev = dev;
 		ep->pcie.ops = &cdns_plat_ops;
-		cdns_plat_pcie->pcie = &ep->pcie;
+		pcie = &ep->pcie;
 
-		ret = cdns_pcie_init_phy(dev, cdns_plat_pcie->pcie);
+		ret = cdns_pcie_init_phy(dev, pcie);
 		if (ret) {
 			dev_err(dev, "failed to init phy\n");
 			return ret;
@@ -114,13 +101,15 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
 			goto err_init;
 	}
 
+	platform_set_drvdata(pdev, pcie);
+
 	return 0;
 
  err_init:
  err_get_sync:
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
-	cdns_pcie_disable_phy(cdns_plat_pcie->pcie);
+	cdns_pcie_disable_phy(pcie);
 
 	return ret;
 }
-- 
2.53.0




