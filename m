Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703D2314D1F;
	Mon, 21 Sep 2026 12:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789992544; cv=none; b=e9qARyTYf92uGpKK8TaZEDimFsosKaMmnX+8hva4VCPAK5MMYCKx9paGIhJ3sF5WFIsE8MruswSIbq5J1qwltb/tRBpk4xcZGKrHP8U3Tltyr7U+gdDj/eDx+++Cm8L+Diad6+AtyRMkiGkpVIYJIhbF7QUblQW9qwBcFVDm5kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789992544; c=relaxed/simple;
	bh=/qErVVwKhalJ2lwNOPfynyqL2Cb5IjjXJfMGfjh0ceo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vlhr/QhcgLax6jbQf7Uc989rm97NHX1Vl0bCKtamt8tOF2Ip6rFKLu2JNdDGXDH5fgdBENnyAERq+YaCwdkFLRMC46s0M4kjj/Du0OdjLyCvjrkmBy3B240Ree0GS7tZGtSC1lt3WcXhnVwMdwR7tKPOE9R7bTl4CssjYB6w0yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=kkX5vbfW; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="kkX5vbfW"
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4e943032e;
	Mon, 21 Sep 2026 20:08:55 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	KyongHo Cho <pullip.cho@samsung.com>,
	Kukjin Kim <kgene.kim@samsung.com>,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH] iommu/exynos: quiesce SysMMU before requesting IRQ
Date: Mon, 21 Sep 2026 20:08:48 +0800
Message-Id: <20260921120848.96215-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0c3de84a303a1kunmd735d0fb4b6a8
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDTEpIVh5NSBgYSh5OS0kYHVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0
	NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=kkX5vbfWyv/gdMl7tC4ESPW32ilC7asfeLcN8S0K4dlX9J52PSfLUAZhNgD0iJ/2yJbIB9oEfHDb3kWslE2fMoAAz9gfICmC1gnOWetfT7Emq2GM89rBjfsd0eBhExmyYCSXliRpYgZPb/B8zbdKlOLH2FAPNMiY1vE2AvdSq/0=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=NyenvGwZgtQ1ti3SGghMMEphkksMnte6MvYyknQsOfs=;
	h=date:mime-version:subject:message-id:from;

exynos_sysmmu_probe() registers the IRQ before obtaining clocks and
detecting the SysMMU variant. A pending IRQ during this window can enter
exynos_sysmmu_irq(), which takes data->lock and then dereferences
clk_master and variant before they are initialized.

Obtain the clock resources and initialize the software state before
requesting the IRQ. Detect the variant and quiesce the hardware by
disabling the SysMMU and clearing its configuration while the clocks are
enabled. This leaves the block inactive when the handler is published.

Also ignore interrupts observed while the SysMMU is inactive, so a
spurious interrupt cannot access inactive fault state.

The race is theoretical; no runtime occurrence has been observed.

Fixes: 2a96536e77b4 ("iommu/exynos: Add iommu driver for EXYNOS Platforms")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20260901130527.3289245-1-runyu.xiao@seu.edu.cn/
Assisted-by: LLM Codex
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/iommu/exynos-iommu.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 874d05f4b3969..8081bd93c67cb 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -571,9 +571,12 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 	struct sysmmu_fault fault;
 	int ret = -ENOSYS;
 
-	WARN_ON(!data->active);
-
 	spin_lock(&data->lock);
+	if (!data->active) {
+		spin_unlock(&data->lock);
+		return IRQ_NONE;
+	}
+
 	clk_enable(data->clk_master);
 
 	itype = __ffs(readl(SYSMMU_REG(data, int_status)));
@@ -744,13 +747,6 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 	if (irq <= 0)
 		return irq;
 
-	ret = devm_request_irq(dev, irq, exynos_sysmmu_irq, 0,
-				dev_name(dev), data);
-	if (ret) {
-		dev_err(dev, "Unable to register handler of irq %d\n", irq);
-		return ret;
-	}
-
 	data->clk = devm_clk_get_optional(dev, "sysmmu");
 	if (IS_ERR(data->clk))
 		return PTR_ERR(data->clk);
@@ -777,6 +773,19 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 
 	__sysmmu_get_version(data);
 
+	/* Keep the hardware quiesced before publishing the IRQ handler. */
+	__sysmmu_enable_clocks(data);
+	writel(CTRL_DISABLE, data->sfrbase + REG_MMU_CTRL);
+	writel(0, data->sfrbase + REG_MMU_CFG);
+	__sysmmu_disable_clocks(data);
+
+	ret = devm_request_irq(dev, irq, exynos_sysmmu_irq, 0,
+			       dev_name(dev), data);
+	if (ret) {
+		dev_err(dev, "Unable to register handler of irq %d\n", irq);
+		return ret;
+	}
+
 	ret = iommu_device_sysfs_add(&data->iommu, &pdev->dev, NULL,
 				     dev_name(data->sysmmu));
 	if (ret)
-- 
2.34.1

