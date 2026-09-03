Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1ED4C77A8
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447911; cv=none; b=j/AskL8U2QFK9CaIt8FfHcxj1BRdDG+Nk822SAOIHHZ+EnnVoGzQYqjjcoMl11S3SCVhCbbB4UrItZxiccAQoevavYYyJyBQ9VXYUh2X52STPYg4sK5zZK5frxJgLQfZeazIp2ejNNfll3GaNQU20yDogjJDdcezMNzwHw/kRbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447911; c=relaxed/simple;
	bh=tEWx0uabozmqb7pUUS82CwJu8TGjKyVxWxDUymUrCyU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=P2LwQ/MSRn5rdzCxZEMLJJW507xPAzOOlTv4lupgJwJIWv7j1guE8wyNCB4sEtvkNAQOPjYZQs5F19EfqPBGkjXmFpHgpU+eFQ6rGbHugKnT+w63rKPDjRwGRw5xraIkhQyYwfE5jS8AlYrDssettLnsGnxCYURYdn0rvdoeJs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=13oql6JI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="13oql6JI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 259871F000E9;
	Thu,  3 Sep 2026 15:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788447909;
	bh=h2TPkmXxLtLHP0CdVY1AibSBIhbveDqYMo5G/2gnIA8=;
	h=Subject:To:Cc:From:Date;
	b=13oql6JIlaM4lf6rdd75+X4+enTpfuZoN2ZlgMdoWFYZvKFsGi3qR5s2aFIuJl13O
	 l11TECUQDpZxJoJG5aNL9lvwOHZAcSRuCFJV0pY+95Z3kv87Dli9CoSPQSFNxpsWJx
	 +PkAib8NUen7AX4WDlgnu9zKXI1tQAScWzUFzAg8=
Subject: FAILED: patch "[PATCH] iommu/msm: Unwind probe state on registration failure" failed to apply to 5.10-stable tree
To: xiongwm2026@163.com,mukesh.ojha@oss.qualcomm.com,will@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:44:43 +0200
Message-ID: <2026090343-awkward-washcloth-0722@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 535a200220ca2c83bc8bf54bd2cbe045d6ee70c4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090343-awkward-washcloth-0722@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

