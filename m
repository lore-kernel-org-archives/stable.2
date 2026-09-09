Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258B15505C8
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788955101; cv=none; b=bH+vxLDfwP76RKOLzdzsuK/6fF6ISfgunO/KwHcdDM2zPzfK+OykuFsiSz/WQzQ3UqcTg8g05QHiJwPTQTbGNuPSFk5Af8oFkwRxoZjajNQQe0eOyQJWL0tjbtij5Baw8scOFwI6qtmK8WXbgbOZoKSeIQx3yjV25loLBmNwYOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788955101; c=relaxed/simple;
	bh=+VpvCzAKiC4EIhT/3bc8IiAfgFr7uus9US1C07fy1BY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qc6coHYaNQaooMrF756V4U/Q4S6+EzIeUpeOnYL0dMSfa+Cp0fqTvwnW1oCyXIbvpvYanQEgch9BeuFm1Yy6IbL2vI0ZGdTrsA/I0iYur6F4Vc/MIhso6QsLXnYGpYqlJJ9/xf0JAzDhdQSOk6U4W43Y/8tYtO3dH5DC+bOoZVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=acxPAaKw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="acxPAaKw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C94E1F00ACA;
	Wed,  9 Sep 2026 11:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788955100;
	bh=N6qPMD21i0qertAnb9kF4S1yZJM6Vo5IbMs9PDTlJKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=acxPAaKw4+jg2TsV2pNV6SvDgjAoUJfBan3pTi8YG6N943X4/ys6J/RdWiIUJ9dUc
	 UwzKxwhViG/xHoDuxfe+sAubiZU2xKikbl5txqYGk1+yJAXMQwGKJrJuxYxzOcM0QS
	 WiE2xBpANn/p6kVvy3k+Yg73GiR8xVLkOcsQbEQYqDI9Br39GDnd8vwgbUrT70nsHl
	 8n7r5qXjW68yzEv9hVZn61LTtfWGxyqfSQm6rG73A0hlKd+t1ZvcUh9cM+Q3TYdNpu
	 NlU7TcB8gbpowoHa9by8YYqyppDgTtoB051fPBcrDfBWWelsPkzRfqvb8zUHNU1IK5
	 R/Fq6IZnBd+JA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Weimin Xiong <xiongwm2026@163.com>,
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] iommu/msm: Unwind probe state on registration failure
Date: Wed,  9 Sep 2026 07:58:16 -0400
Message-ID: <20260909115816.2182309-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909115816.2182309-1-sashal@kernel.org>
References: <2026090341-makeover-snout-3650@gregkh>
 <20260909115816.2182309-1-sashal@kernel.org>
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
index 2769e4544038c..71c1f4240aa6c 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -784,19 +784,25 @@ static int msm_iommu_probe(struct platform_device *pdev)
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

