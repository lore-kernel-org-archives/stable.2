Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FED43F0A9;
	Thu, 16 Jul 2026 01:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784165586; cv=none; b=DwKoif83zcAN1fEqdw+iYn1Tfi/mZJoflSluqe1OnkEKJT35eU26ZMRg6dB+KTi929lmEyL0fbqX3+434ghTHZoAu6IcgZHITenQEWtJw0iS9Re7ETvCaCBdQCd6tA2/Y8FLnac8ji3quzHPuv2C0SBVorwqcDOrW5xBtOZ6CO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784165586; c=relaxed/simple;
	bh=MoUiGA8lZFM8779lGKcGXkGFvzzd8jwTgTIQQe2JRXU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gsvK/ozOdeBGneesd99lu+WIhkjVu8q5wRDuyUMfJwbx1ZRoC8J+ulKBZb8Jk/2EHHuLs0D/j0UT9IqteQiVnojOZia6Npi3mt6cwAv5dxJZ8jqZQxApKafOp+LNxhI1UGCFOQG4Cj/tGv7alg2mbM7+5lJ8cSgYt5PZmHJjb7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jMr03f2H; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jMr03f2H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=YT
	9Try4G2bN+d1xevRCFOkvBPYlxDLC9/j5TFdr7Wi8=; b=jMr03f2HdWVKfBpDLk
	bJgMdNXFq8oAuZicEUul+BOqtBWPkFIVkkezToMz1q7cEgl5Rzgv5TAT/MIRqW0A
	QDKBVoFngvC+qi3wrnc7vj+iZiOP6t2PhGG7psxH9V/U5aoOsrey7To4UEz8Z4C+
	8JYr8JKwsQW59zWeRt5Ql3bqg=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDX6H+pNFhqb+8yJw--.4732S2;
	Thu, 16 Jul 2026 09:32:25 +0800 (CST)
From: Weimin Xiong <xiongwm2026@163.com>
To: robin.clark@oss.qualcomm.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com
Cc: linux-arm-msm@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Weimin Xiong <xiongwm2026@163.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] iommu/msm: unwind probe state on registration failure
Date: Thu, 16 Jul 2026 09:32:29 +0800
Message-ID: <20260716013229.91014-1-xiongwm2026@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDX6H+pNFhqb+8yJw--.4732S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr45Kry5CrWkWFykuryDJrb_yoW8urWkpF
	WUWFWYgrykK3WxGF47A3W7uF9Yk3yqya4rur4rG39F9r15ArW5Ar93tFW0qr15JrWkGF47
	ta4fJrsYkF45Cr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U17KsUUUUU=
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbCzgrnd2pYNKq0WgAA3W

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
Signed-off-by: Weimin Xiong <xiongwm2026@163.com>
---
Changes in v2:
- Resend the former patch 4/4 independently; patches 1-3 from v1 are
  dropped.
- Explain the dangling list entry and stale sysfs device consequences.
- Add Fixes and stable tags.
- No code changes.

v1: https://lore.kernel.org/r/20260714060930.220277-5-xiongwm2026@163.com

 drivers/iommu/msm_iommu.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 0ad5ff431..d0d926be7 100644
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

