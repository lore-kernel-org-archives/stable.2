Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5129B568FB9
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 14:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788964540; cv=none; b=K/KsxGHOeNZWtyNOfN9B9swp2zYxsokwCSexn/7jhfgLy8tuyv/vDZtlLT08euGdBqrjxRz24MDfJVcd0uFjMA44AO9ZPE6irspXQHLzhzBEchfyBuEypAfdVrb+P8y5EFd7y6ONv9ElVfv9hvSyHvpezfzk/nnBEpf4t5qOXQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788964540; c=relaxed/simple;
	bh=d0IXjGOhMnxyzxoWNj62qm1/xiDRv6+5wNBbON9eVRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GD3umIR4nlJLOs0YnkNvhnu92/b7Dj1KLc6DdyJR/565I+wo+T/rVVhEfCQ4kt0Nfbs9GyplBI2ci/bahpzFYUeh7uwr2jlD2IZWsDtu5beZjxVmFWqYdMtXh0Lony1OJq2Ajq6l1YJRco9DaIyDpbZDzyxtIqvVbV6Zm7C2tns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPWyMI4N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPWyMI4N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 715521F00A3A;
	Wed,  9 Sep 2026 14:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788964539;
	bh=VRny8wZfujdp+tLjw+AZ+dPTWokhbR+5nJQsyXBqOO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mPWyMI4N03yegkWuBbdhxX0sWu5pBMaLMavP4sSXQ/XnOlhlN776jHbAZjfh2tjDZ
	 d5epKfAEjENjjQ5vlul0et15AORoW3SaYXkm/8REygqKjOEgmebpxsiQcOIn/PHmyR
	 lw//kfUZzTThJOnvaxipuEuOEeuKaqHW8mxw0WyUVvTdcJFjQyCG8jJ6HApHcA2RmT
	 ontCSiKMYftutYRAyfYdAgrs2FW24x4mQgDTR6NvKFS5gwN0HVfXluj4g5RVYPqZ2L
	 5VNPcdhuzwyuEkBOZJF8iAEHKxHAyfmlup/iY2+gitPB+pcfhcq2RIiUrMYMJpQRED
	 V2Oex8vs3DyJw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Weimin Xiong <xiongwm2026@163.com>,
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] iommu/msm: Unwind probe state on registration failure
Date: Wed,  9 Sep 2026 10:35:35 -0400
Message-ID: <20260909143535.2525461-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909143535.2525461-1-sashal@kernel.org>
References: <2026090342-rising-affidavit-4103@gregkh>
 <20260909143535.2525461-1-sashal@kernel.org>
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
index 90c7cbabaace3..9e37dce5bf114 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -767,19 +767,25 @@ static int msm_iommu_probe(struct platform_device *pdev)
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

