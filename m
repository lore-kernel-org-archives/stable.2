Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C254C77A8
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447908; cv=none; b=G6WBLP/b/OgvzecHsIkw9oX4WJDJ2vNUOWLOC8t7UEve+yjwahkwGpjPh5pvxuVVN/q44ADCfdmz5m9onwk8d/bUVHdLWdnIHssrTiPjLWKBRfnwL/fYHyoIpHaFPzjs0iXVRt2C88UttM3ku/MDFOVawLQT7apCdiY8ZGu6Kj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447908; c=relaxed/simple;
	bh=DncjMOcNlATcMyRjXtr6oTL1txQXgqqcLlNl+Z+f6/w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GLMQq16ywDD6hdEuZfhbVAp0ygAT+MFCa0UuGifcmuAGtBPQx4UbhOuzNWK79uFmcfCvhoS8DxMub1ZVGzyGtaDQnySCUYintki5rFR3e8sAkdgJcEhQzB7WEvg3kP2HCH9d/Z7pmIP0nnB0ZNA8w5QbFCs1rNlL4eZSxJl7gYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yn6gAxpz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yn6gAxpz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 454411F000E9;
	Thu,  3 Sep 2026 15:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788447906;
	bh=UXI89nxrw/3JaSENP7loSX3BfNAlh1lC8f4NK34IyNs=;
	h=Subject:To:Cc:From:Date;
	b=yn6gAxpz1aRXTaAPnkfWJd5c4dBcqNQk0DZwoaCWIcjv/TF405XdoJ2hNnqhjxw9W
	 LhroNwbQY46W7eGGtIU1YtDipuSUbHoA4nB7y+ZrR7tZarLMjwsOcQhsqQOm0Wt2lm
	 klqIcDSIaKjzQNiy4oi+yyq3xSZGCbs8N3hpj9tM=
Subject: FAILED: patch "[PATCH] iommu/msm: Unwind probe state on registration failure" failed to apply to 6.6-stable tree
To: xiongwm2026@163.com,mukesh.ojha@oss.qualcomm.com,will@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:44:42 +0200
Message-ID: <2026090342-cost-opposing-2086@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 535a200220ca2c83bc8bf54bd2cbe045d6ee70c4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090342-cost-opposing-2086@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 535a200220ca2c83bc8bf54bd2cbe045d6ee70c4 Mon Sep 17 00:00:00 2001
From: Weimin Xiong <xiongwm2026@163.com>
Date: Thu, 16 Jul 2026 09:32:29 +0800
Subject: [PATCH] iommu/msm: Unwind probe state on registration failure

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

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 038f6ed797ea..4ef1e8c8244b 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -787,19 +787,25 @@ static int msm_iommu_probe(struct platform_device *pdev)
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

