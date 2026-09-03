Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666534BB813
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447902; cv=none; b=t0RVw/u4xPlqGt/AY/qPJiZ4B+qZS0byuYlC0B6obaSSkXK/UbQI0FqkPkYwRI/223MraiElAtuCfbQxkxxl1O3wtYfYswD23JsQNtyzPWYJ9+IUkQRFmKeldUKlUevB5gW1+T692ekUQyuWl07xhVK4IAv8HH55aUspHntQOvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447902; c=relaxed/simple;
	bh=Sm9SF9w71ovajNl70YRMun2Fl/pBnXOlxCTypUS/RXU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Mj1nOtiZ7seWoPRPDPaOlmtgNb0t5rkMLWS0QZPPHDoAbSHxw2SLM2M0oJlEJ6wDRJ/LxSWE0rpmVIYy6NuquJtZ9poL1R0DZYHaNk1UzCIuUf9Hy0gWjHwfo4iv6XJTZyYuTHgp1AtJZwk9DYXsu8v92xrCYY65iArs9i/ojyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m8a0cn93; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m8a0cn93"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1FC81F000E9;
	Thu,  3 Sep 2026 15:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788447901;
	bh=KubualAfJPHX+jIczxv7vqFnqMhFLuiFtz71rCzqkbw=;
	h=Subject:To:Cc:From:Date;
	b=m8a0cn93D1pmcpF5u/OCBIxysxOk4WAj5JfJJmy8FVRvqrfFaghZJA/KuM4O4zWA3
	 Gds9u6RqvuoHkWQP+AcLb6w4l+s0L+XL28ZpqHkiKXGZ0jjtki/t9fi9hlt3EmlE6E
	 jsHlxB13OgKvnDYWSszIeHhe/Zloap2pLplLFrPw=
Subject: FAILED: patch "[PATCH] iommu/msm: Unwind probe state on registration failure" failed to apply to 6.12-stable tree
To: xiongwm2026@163.com,mukesh.ojha@oss.qualcomm.com,will@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:44:41 +0200
Message-ID: <2026090341-makeover-snout-3650@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 535a200220ca2c83bc8bf54bd2cbe045d6ee70c4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090341-makeover-snout-3650@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

