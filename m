Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB935335B3
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 14:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965620; cv=none; b=AP8y/YAkWRKoJ1+UuJ+oOBM0oVDk2rXIhwKeEyGS3RG4ipRghnfjF8bQcJmm1s/r+KGP3BNWCz6uMrbp0HdilA/BOfLwrtW2nhlw5FpibQXsT4yn+99OwCPh29LVriJU1ecJYLPsqFzIgy3TCC5wF9tiWEIIVj2sC0HodmfCleg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965620; c=relaxed/simple;
	bh=cEoJa2pVvq6ETEbtmNeHO29WaHDi2q8csBNP5BaSP3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jRQ4NvjuolYBooleeqPZlSnfdOegC9E8Az6DliKMZ1yTDLoYuCOGX9oNTChMk3F2rEg0vQwcHdSZ5adQWKD4yjr35niTWooUUa8qBcWzmiAVvoUG22D/ctIqst5tGTHxfWypMYsIDigrkwRxfA1eR7P/ZLQ7BjRJFLA+/A8Qs3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPvtv9yc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPvtv9yc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0A51F00A3F;
	Wed,  9 Sep 2026 14:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788965619;
	bh=Q3N7zTFiNguqEpGLOn00siM/mcFhDI3rlHBf90Jnuow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SPvtv9ycpf0WMkW6+cO+8ye7WoNmeTj7QwyRAVk+iM/gP2lkarP2iafTHgQE1xmiy
	 HMlwzTMTMskRv5jSR921wSHWKTOP9+iY1JqR82S1lw2hfru3L1vWQHtTEbrmFkB5rF
	 DF0Su2cwlgv/aZ9y/bf9zzCI2jXAgp4fLTSpszU+E7kcH2/AO8dAC36yE6hvh7z7Jf
	 Fpjd7LITiI+rFWOEy0QVIJpFQK4mLnGsLEt0IEO33Gy+EgRnlJaBPSngXq7SackIJR
	 aXuEOmRN3unk7fow+n2v7mXfJwGmdUMmzNnRUcPLdhVP4fQoz/PtJGqIO03XsWGDxe
	 OXkBreDuGKMaA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Weimin Xiong <xiongwm2026@163.com>,
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] iommu/msm: Unwind probe state on registration failure
Date: Wed,  9 Sep 2026 10:53:36 -0400
Message-ID: <20260909145336.2697541-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909145336.2697541-1-sashal@kernel.org>
References: <2026090343-premises-stoning-828d@gregkh>
 <20260909145336.2697541-1-sashal@kernel.org>
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
index 87663e7302da4..d9e6167826f21 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -773,13 +773,13 @@ static int msm_iommu_probe(struct platform_device *pdev)
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
 
 	bus_set_iommu(&platform_bus_type, &msm_iommu_ops);
@@ -788,6 +788,12 @@ static int msm_iommu_probe(struct platform_device *pdev)
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

