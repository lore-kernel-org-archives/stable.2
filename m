Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6F1583AA3
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 14:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965911; cv=none; b=WHcu5AONpQxbbWzTXpA9Uc0WEWekkLROUhl4pbb68wB6ztsNxwbDW7uuPT9deir8YCm3npMmH0v6x3eLhVSzw2i7kQqSaes63u/YnYgwxUQJDzF8DOMMicU6DaqCS53fqnA3bLaxXmOcDAJOI5uTvhiHphPepsGIjotvJI2knEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965911; c=relaxed/simple;
	bh=eC1l7raljLKJlugc2nT+55efuPr/AFQdF1LPH08RwB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bu+rdWde0NwuVA5WAXHxBbRbDSzsB9p8lT/xJtYngkexrAElxw8lQYx5RB3JD+kYo4VlXg2hXWmgIPdpJIJcfIsURmj1GixtzJ05Wz6hN1E5SXbNOGxALDZWzmkv8zEqH7NhrKqT/N8su84xFqajQLWZqJ1djtP6qOH56c6Enzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTgu4SIG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTgu4SIG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE8C1F00A3D;
	Wed,  9 Sep 2026 14:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788965909;
	bh=NcAKmz0Qr7Kh5gubqlOF+GJY8/YOk37K02TMt6mAK7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LTgu4SIG28VlC1Nwcl64BqHBiggHmqwdlkYASWNFVR9PQUB3KtWdJQ91H2HeiK6zz
	 Rl309nNum+Db5Vc2QWhVFLr9HR6+Oluu5vj/9SUdYjG/lcNf4PX9jPQ4awfKitTMwZ
	 074bgpjAyRQjnrjU1f2ciFR2t9AA54nTKWg9c6dQE4IcU+O5qBr2ilwZVciL2MTXxw
	 7fZPWxgk1H+8d81pwtPH7cI5eAAEJf29i+cht8BNn6BrejYFyH7u2VoQVx5zGmbgsJ
	 UPnflHX+PspC8JScu1NjnS6mXybPY+EO11ZZQdrdSihpywLyJsBUZxxb5mr6vUUcgQ
	 lAW34c68xe9tg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Weimin Xiong <xiongwm2026@163.com>,
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] iommu/msm: Unwind probe state on registration failure
Date: Wed,  9 Sep 2026 10:58:26 -0400
Message-ID: <20260909145826.2742978-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909145826.2742978-1-sashal@kernel.org>
References: <2026090343-awkward-washcloth-0722@gregkh>
 <20260909145826.2742978-1-sashal@kernel.org>
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
index 5c83cebbf49a7..508497c9bdd44 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -773,7 +773,7 @@ static int msm_iommu_probe(struct platform_device *pdev)
 				     "msm-smmu.%pa", &ioaddr);
 	if (ret) {
 		pr_err("Could not add msm-smmu at %pa to sysfs\n", &ioaddr);
-		return ret;
+		goto err_remove_list;
 	}
 
 	iommu_device_set_ops(&iommu->iommu, &msm_iommu_ops);
@@ -782,7 +782,7 @@ static int msm_iommu_probe(struct platform_device *pdev)
 	ret = iommu_device_register(&iommu->iommu);
 	if (ret) {
 		pr_err("Could not register msm-smmu at %pa\n", &ioaddr);
-		return ret;
+		goto err_remove_sysfs;
 	}
 
 	bus_set_iommu(&platform_bus_type, &msm_iommu_ops);
@@ -791,6 +791,12 @@ static int msm_iommu_probe(struct platform_device *pdev)
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

