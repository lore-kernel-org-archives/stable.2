Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1178A576EC4
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 14:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963280; cv=none; b=Xg0lZAiOgeYVfxTcpW+YURvM2VJmZ2Pqp7Hv0ERtFTIeC0V/qkq836j85DZURSfT0aD6aX8TLrL/kCKynueiMAP27RpfQrsBaV4ChZTF4gnP8Lny8y360Ttwv1X2S5AXkRB4QruiYNbzri48u0HNPy97LpAvD1VsM/R9ewnVa24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963280; c=relaxed/simple;
	bh=IGzJXTflSrI3NrZcRhJM4e3Y+TcKnhpOEFr5IGBaRRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N0HZzIiqmboXaRzRvBMBhJdI4zQEJN/H/uGjonowaPSUnUHLicbSPrmSk6h2WlTvbErzcRNzsdStulCzz47Dl9E9VMPY+llLXRURnxO2QP75YZHOINUs1qpVfUkfyE715KJx/ggD23n2bSLtzdJJwHNr4XiFi4wo2z7k3pyitSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VpwaqkqJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VpwaqkqJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA331F00AC4;
	Wed,  9 Sep 2026 14:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788963279;
	bh=SwC1eIbUhc8QQh+lLZgWwL1fhKiQZN9W00jWdcgJZxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VpwaqkqJG+giAME7k+EImCJdXUnfMnaLsiIitMOYEB/RIbZ5UZPgt5UbsWXGefNyg
	 ouMC2wW4uAZnAJr4Ce0jmWQHw7Llpxv+8B+1YxwLV3n9pT+oam3AG5Pyt+FJX/dvv+
	 aZxmd21iHNX+qxGDzP3ZBk67prW8XHWtoI+siRZ/a5PvtfU6u6glu/hobhIKniTkPX
	 cZi8VFBIDbXoJ6l+q6kHLiA16nyzMD+6h6u2K9GYE9dlwphCdQMvzxECjGqbvl4f+B
	 UG5RRIN8cJ8vKfwXLf6IxKR+T6UmRKXgsUCiqX7v/D6IlAa3MCf8AmRL+pDBMpmj4+
	 JnzMgCg3OcjUQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Weimin Xiong <xiongwm2026@163.com>,
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] iommu/msm: Unwind probe state on registration failure
Date: Wed,  9 Sep 2026 10:14:36 -0400
Message-ID: <20260909141436.2391480-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909141436.2391480-1-sashal@kernel.org>
References: <2026090342-cost-opposing-2086@gregkh>
 <20260909141436.2391480-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weimin Xiong <xiongwm2026@163.com>

[ Upstream commit 535a200220ca2c83bc8bf54bd2cbe045d6ee70c4 ]

msm_iommu_probe() adds its devm-managed IOMMU object to
qcom_iommu_devices before adding the IOMMU sysfs device and registering
it with the IOMMU core.

If iommu_device_sysfs_add() fails, probe returns with the object still on
qcom_iommu_devices. The driver core then releases the devm allocation,
leaving a dangling list entry that later list walks may dereference.

If iommu_device_register() fails, the same dangling list entry remains
and the sysfs device is left registered as well.

Unwind the sysfs device and global list entry in reverse setup order on
the corresponding failure paths.

Fixes: 42df43b36163 ("iommu/msm: Make use of iommu_device_register interface")
Cc: stable@vger.kernel.org
Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Signed-off-by: Weimin Xiong <xiongwm2026@163.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/msm_iommu.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index d6526908f1504..ae22776c15c04 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -771,19 +771,25 @@ static int msm_iommu_probe(struct platform_device *pdev)
 				     "msm-smmu.%pa", &ioaddr);
 	if (ret) {
 		pr_err("Could not add msm-smmu at %pa to sysfs\n", &ioaddr);
-		return ret;
+		goto err_remove_list;
 	}
 
 	ret = iommu_device_register(&iommu->iommu, &msm_iommu_ops, &pdev->dev);
 	if (ret) {
 		pr_err("Could not register msm-smmu at %pa\n", &ioaddr);
-		return ret;
+		goto err_remove_sysfs;
 	}
 
 	pr_info("device mapped at %p, irq %d with %d ctx banks\n",
 		iommu->base, iommu->irq, iommu->ncb);
 
 	return ret;
+
+err_remove_sysfs:
+	iommu_device_sysfs_remove(&iommu->iommu);
+err_remove_list:
+	list_del(&iommu->dev_node);
+	return ret;
 }
 
 static const struct of_device_id msm_iommu_dt_match[] = {
-- 
2.53.0

