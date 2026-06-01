Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D27034403D;
	Mon,  1 Jun 2026 05:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780291508; cv=none; b=kYtgkhpjuhaQ0AlXTDRg35jPWRVE4hlYBO94S0rXU6QPWBUZ7F6f+qsFpsB7DdciXSgqW2RmrEWRuNhv5jsI4x2o5cIvQOfsRqhiyIumi+1ak5ATqnVNVb+35i67HZANS11rb8sPM82CX512vuj5dwFwwq+C4DI4/HS62VUSZ9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780291508; c=relaxed/simple;
	bh=+rXhp5enUiqzUqXZ8+cReVBPFeph94Y1vMCw3pnuRIE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gbftrr6KMLQHNVqmjlqa1n/94oK0GewYIGzkvRcMclIzb3CbAp/ssVW3XaaP6hFIsk8diH7G6JVVmZ+K6eeAk2giqLfgFK//RQDnP09Yrf+g6gKnSFWfv+QGV6rivJztGI29s2O6BDAga7oIJE/RXH67soq4GXqsqdTxTkgLb5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WMXPzYHs; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WMXPzYHs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=vw
	awXOS85N266Kc92qEO6y0kEvBacHRvTjnktzIuO10=; b=WMXPzYHsgFxvRZ0PoK
	DXghH+R+P/bMY/LjfxZvOj15K5WIMQMEMen9eXu6aWpK0aA85ntTAf4VJLNO6ZoG
	nH9WlVm31No2/eyrm6FSHoW5KaiSHIm531FzENn4ggmRXH2GV71IW31+vYOCu61W
	n3jbAmjo42e+7oeoeuzkI4P2c=
Received: from China-163-team (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgBHerB+Fx1qZmXdFw--.291S2;
	Mon, 01 Jun 2026 13:24:25 +0800 (CST)
From: Wenshan Lan <jetlan9@163.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Wenshan Lan <jetlan9@163.com>
Subject: [PATCH 5.15.y] dmaengine: idxd: Fix not releasing workqueue on .release()
Date: Mon,  1 Jun 2026 13:24:12 +0800
Message-ID: <20260601052412.72913-1-jetlan9@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgBHerB+Fx1qZmXdFw--.291S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF1DGF17JF1rCrW5KFyDKFg_yoW5Jr4Dpr
	43JFW5W3s2qr9xG3W7XF18ury5G3WSy3yfurWfWw13uay5Za45X34ftFW29398JrZ5GF42
	qF90q34rXF48tFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEEoG9UUUUU=
X-CM-SenderInfo: xmhwztjqz6il2tof0z/xtbCwwrJkmodF4raPgAA3c

From: Vinicius Costa Gomes <vinicius.gomes@intel.com>

[ Upstream commit 3d33de353b1ff9023d5ec73b9becf80ea87af695 ]

The workqueue associated with an DSA/IAA device is not released when
the object is freed.

Fixes: 47c16ac27d4c ("dmaengine: idxd: fix idxd conf_dev 'struct device' lifetime")
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Link: https://patch.msgid.link/20260121-idxd-fix-flr-on-kernel-queues-v3-v3-7-7ed70658a9d1@intel.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[ Remove destroy_workqueue(idxd->wq) from the function idxd_remove() to
avoid the workqueue is released twice. ]
Signed-off-by: Wenshan Lan <jetlan9@163.com>
---
On 5.15.x, destroy_workqueue(idxd->wq) is still called directly in 
idxd_remove(). Applying the upstream patch as-is would cause a double
destroy: 
once in idxd_remove() and again in idxd_conf_device_release() when 
put_device() triggers the release callback.

Resolution: In addition to adding destroy_workqueue(idxd->wq) to 
idxd_conf_device_release(), the call was removed from idxd_remove(). 
This is safe because idxd_remove() ends with
put_device(idxd_confdev(idxd)) which drops the last reference and 
triggers idxd_conf_device_release(), where the workqueue is now destroyed.

---
 drivers/dma/idxd/init.c  | 1 -
 drivers/dma/idxd/sysfs.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index f2d27c6ec1ce..698387103da7 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -829,7 +829,6 @@ static void idxd_remove(struct pci_dev *pdev)
 	pci_iounmap(pdev, idxd->reg_base);
 	iommu_dev_disable_feature(&pdev->dev, IOMMU_DEV_FEAT_SVA);
 	pci_disable_device(pdev);
-	destroy_workqueue(idxd->wq);
 	perfmon_pmu_remove(idxd);
 	put_device(idxd_confdev(idxd));
 }
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 489a9d885076..ee208dfdd0cb 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1271,6 +1271,7 @@ static void idxd_conf_device_release(struct device *dev)
 {
 	struct idxd_device *idxd = confdev_to_idxd(dev);
 
+	destroy_workqueue(idxd->wq);
 	kfree(idxd->groups);
 	kfree(idxd->wqs);
 	kfree(idxd->engines);
-- 
2.43.0

