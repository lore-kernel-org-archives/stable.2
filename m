Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD33A2E738F;
	Thu, 16 Jul 2026 08:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784192043; cv=none; b=hsmRRqKOE6Xg6wwzQ4JmjMXnK4ySnsRRlfbXZZsDGXE2QfVuhMtje81GacniYWIlXX+NChfPAP3xdyfGUNGrXUQN5V2hK57lTH2bE9iIPCgJ/7UCzfbLrkd+HOO7K6I/nrvVdZn6onRjFAbUADrgmdxhMBOtdJjd4tj4pHqY+dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784192043; c=relaxed/simple;
	bh=kMR8NIzajtWQFwhUYgzdGr+Ajd3kQ1pJ8pfsuDVwc+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lGZGyuB2nD5ZrHVIGJrqcx7vExrdNxvXrH2ynVxPe55Hmyx/KFIyD5bweiT7IkHOPprYE0WLvIkWBBncmTmItT0EoKt2A7yw3034lsPnXbVz2mvbzztE2zrYRwu522vXVbIjAkbBq1ehd31YaUsPIm8c2k1VuThRQsJioMcCrS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=h1OghJ4o; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="h1OghJ4o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Pa
	gnMdLTxdPZ3VTSKDDLFfBMbfc8AaC+chKNmgfLf2w=; b=h1OghJ4oFmSa9fYmqd
	BxkvLpGcxfNXxZv6mHhxx8K11zqCHeiVZQ0YhNIv0UjsSwQFubvbnoC6fD8cw7nj
	aRNBB+kM2q0xLci7pKnBE/39+OEZRoll/SKRCaiNZBmp4vRGBrVcpHQyhpxUXriP
	q0kacaKbXkPm8XQR7+gMppSDw=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDnRs7zm1hqNOsPIA--.46301S2;
	Thu, 16 Jul 2026 16:53:07 +0800 (CST)
From: Weimin Xiong <xiongwm2026@163.com>
To: xiongwm2026@163.com
Cc: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	robin.clark@oss.qualcomm.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	linux-arm-msm@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3] iommu/msm: Fix dangling list entry on probe failure
Date: Thu, 16 Jul 2026 16:53:12 +0800
Message-ID: <20260716085313.207069-1-xiongwm2026@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260716013229.91014-1-xiongwm2026@163.com>
References: <20260716013229.91014-1-xiongwm2026@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDnRs7zm1hqNOsPIA--.46301S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KrW3Gr4fJw1fJryUAw4UXFb_yoW8ArWfpF
	yUWFZ8KrWUG3WxKF4UAa1Uur92vrsFya4FvF4rJayq9w45ZrW8Jas2ya48tr1rArZ5Ga17
	ta4ftr4v9r4rJr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U85r7UUUUU=
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbC7xPTY2pYm-MmZAAA3U

Move the list_add() call to the end of msm_iommu_probe() instead of
adding cleanup paths, which avoids the dangling list entry problem
entirely (suggested by Mukesh Ojha).

This approach simplifies the code by ensuring the iommu device is
never added to the global list until after all potential failure
points have passed.

Changes in v3:
- Move list_add() to the end instead of adding cleanup labels
  (suggested by Mukesh Ojha)

Changes in v2:
- Resend the former patch 4/4 independently; patches 1-3 from v1
  are dropped.
- Explain the dangling list entry and stale sysfs device consequences.
- Add Fixes and stable tags.
- No code changes.

Fixes: 42df43b36163 ("iommu/msm: Make use of iommu_device_register interface")
Cc: stable@vger.kernel.org
Signed-off-by: Weimin Xiong <xiongwm2026@163.com>
---
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 0ad5ff431..9da650a82 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -778,8 +778,6 @@ static int msm_iommu_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	list_add(&iommu->dev_node, &qcom_iommu_devices);
-
 	ret = iommu_device_sysfs_add(&iommu->iommu, iommu->dev, NULL,
 				     "msm-smmu.%pa", &ioaddr);
 	if (ret) {
@@ -790,9 +788,12 @@ static int msm_iommu_probe(struct platform_device *pdev)
 	ret = iommu_device_register(&iommu->iommu, &msm_iommu_ops, &pdev->dev);
 	if (ret) {
 		pr_err("Could not register msm-smmu at %pa\n", &ioaddr);
+		iommu_device_sysfs_remove(&iommu->iommu);
 		return ret;
 	}
 
+	list_add(&iommu->dev_node, &qcom_iommu_devices);
+
 	pr_info("device mapped at %p, irq %d with %d ctx banks\n",
 		iommu->base, iommu->irq, iommu->ncb);
 
-- 
2.34.1

