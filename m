Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9FE39A4DC;
	Tue,  1 Sep 2026 13:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788267943; cv=none; b=FOdImxxdIqawH97q4CPn/NqMr+PcZ0mebfy9Bjku5M3uPGcLX08YRqkAc3jtBQoBrzaktJiRUoSX0pyBz2c8t2yRRdB6kKH78dnO2xWEkY1EAHuxpr8waKMFEOB75sPHUQnKVBlJk42a1ZofP5WvJyS0vD/03j34TeBShlcmHiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788267943; c=relaxed/simple;
	bh=5uvSyPqYCtbnZfV5lhvBwzVleX03dnMpFSh6P5iyWAk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jeyVky6S9FbvEIPFTPO+nQpjpW88R9Av0prBDscBbRu+CW8ggVz41G12P0VCu8FjmHwOPq8hr6D0tpNqme/xuPwdgOSL06eG0oBQOLz304JIabK/kgs5WhM9HSxO/aPiGNWprNDitUmcAhSdpUuYxBbZLpLGlWXGNrwpWL6sOWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=EOgFoxRw; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="EOgFoxRw"
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4c1f46417;
	Tue, 1 Sep 2026 21:05:33 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	KyongHo Cho <pullip.cho@samsung.com>,
	Kukjin Kim <kgene.kim@samsung.com>,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH] iommu/exynos: Initialize lock before requesting IRQ
Date: Tue,  1 Sep 2026 21:05:27 +0800
Message-Id: <20260901130527.3289245-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa05d132e6603a1kunm445721fa16f246
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCTBkdVkhOTkIdTxhJSUhNGFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=EOgFoxRwxzQxfvlYFYg841s7jzQqgANec6RRRQkmlaoB0ROYTaT/yN4FOZfSa+n3LZVnlZLSXJ+hqRca9EvEaOInR1CpEExYk86+iLZIK8/H5C65FPTD6U5qRg+X+VQUPW3UE8rrNXtusalywWgPJPGlfs2DQMthhffCQBXkmH4=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=LQLxe3McHBmGULMFD/4NkaDRFU0WQZ/I3unsR12nsDs=;
	h=date:mime-version:subject:message-id:from;

The SysMMU interrupt handler can run as soon as devm_request_irq() is
called. Initialize the driver lock before registering the handler so an
early interrupt cannot use an uninitialized lock.

Fixes: 2a96536e77b4 ("iommu/exynos: Add iommu driver for EXYNOS Platforms")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Assisted-by: Codex:GPT-5
---
 drivers/iommu/exynos-iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 874d05f4b..e9feb83b3 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -735,6 +735,8 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
+	spin_lock_init(&data->lock);
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	data->sfrbase = devm_ioremap_resource(dev, res);
 	if (IS_ERR(data->sfrbase))
@@ -773,7 +775,6 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 		return PTR_ERR(data->clk_master);
 
 	data->sysmmu = dev;
-	spin_lock_init(&data->lock);
 
 	__sysmmu_get_version(data);
 
-- 
2.34.1
