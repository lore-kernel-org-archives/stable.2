Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.224
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794361998;
	b=zMF6NBmyp5uXXjAxxhZJva9/t+PAN3kIGkuMdSpipXefIpW1a3ER70RnVhtbe1mt1pX/
	 kKPfW9jLaFJH6l1Mx7ab8lB4HDjnz7WTm2KycjrXXphvyMoA9381cDE0ObGxsSWDpVbQ3
	 8uPgGTKZkgObFkOeVmys5di4hUt0L67NYzW+E60J1GUsgRYY/+w3jkif57wxylAY1Rg2W
	 WjUNmZMNVKbZxLvSl9YgdFTBSI3C83PtBqfQzipo/GrmczUOTZwoRKg9n7DSN3J7OgjCd
	 U1AZcxZjIe+CvpLYqrG+b2ObLrQJ6T+armbTo5a1Gjb+hPAPQMXmEyaou9YyGT5tgqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794361998;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=xt2+ynV2kO2k4hVadIUYpDDpvvqZrunIUfTT0Mvogzg=;
	b=u7ykiux7VzeVlgglm/ari+yWKl0/yUHJpuF7/owrQq3nAYaytO38oviZbvvmrvjiilQ7
	 IQ1UqrAgN6r3UBITOEM/dsYJdFcN7dS6HCY1mre/Zerw0j8HQVsyV/MaRYhqdBXw0LyXR
	 JUPJn2gVtV/TssV2tR/wYEq+CTQxL1+F+DeQz/QD+svM/0hWqR28bO00ZvsO+DaTHrXBx
	 aYA30cikLlMUczyiQx6tGQ6OZMXupMD1lVZv3b8EJXAE5qvFlEziZQ/V+Eoo71jypoWGR
	 ch+gktNeeqAhjYlCRO3dUpUbFYSYK7D5a+1t2D5301717c73Z1FzdZVdH1GjQGJQHcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=FdRFPWPk;
	arc=none smtp.remote-ip=113.46.200.224
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB62D606A334;
	Wed, 11 Nov 2026 01:53:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB62D606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=FdRFPWPk
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=xt2+ynV2kO2k4hVadIUYpDDpvvqZrunIUfTT0Mvogzg=;
	b=FdRFPWPkgVFYh8w+jeEZeAlWSa9HDIrxskl1ET0o3PrJfOL4MhZJNtu9VRrWRBgApRQnyJFjS
	F7AeB9iYKcK/sx//99EghOfTf8jFNXSz0INkTmxJs/ROvUiIloiCg5sb4iO8jifIVO597DnV61t
	kMtjQ4ZaUiPq3haVhc9doCg=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4jPRP769kfz1cys1;
	Wed, 11 Nov 2026 09:52:59 +0800 (CST)
Received: from dggpemr500006.china.huawei.com (unknown [7.185.36.185])
	by mail.maildlp.com (Postfix) with ESMTPS id 306DB40586;
	Wed, 11 Nov 2026 09:53:15 +0800 (CST)
Received: from localhost.localdomain (10.50.85.180) by
 dggpemr500006.china.huawei.com (7.185.36.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 11 Nov 2026 09:53:14 +0800
From: Yao Kai <yaokai34@huawei.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>, Vinod Koul
	<vkoul@kernel.org>
CC: Dave Jiang <dave.jiang@intel.com>, Frank Li <Frank.Li@kernel.org>,
	<linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
	<liuyongqiang13@huawei.com>, Yao Kai <yaokai34@huawei.com>,
	<stable@vger.kernel.org>
Subject: [PATCH] dmaengine: idxd: Avoid destroying the device workqueue twice
Date: Wed, 11 Nov 2026 10:10:26 +0800
Message-ID: <20261111021026.3354620-1-yaokai34@huawei.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemr500006.china.huawei.com (7.185.36.185)

If idxd_probe() fails after idxd_setup_internals() succeeds,
idxd_cleanup_internals() destroys idxd->wq. The PCI probe error path
then calls idxd_free(), whose put_device() invokes
idxd_conf_device_release() and destroys the same workqueue again.
The err_evl path in idxd_setup_internals() has the same problem.
This can corrupt the workqueue list or access freed memory.

Clear idxd->wq after both error-path destroy_workqueue() calls and
only destroy a non-NULL workqueue in the release callback. The NULL
check also handles failures before the workqueue is created, while
preserving its destruction on normal device removal.

Fixes: 3d33de353b1f ("dmaengine: idxd: Fix not releasing workqueue on .release()")
Cc: stable@vger.kernel.org
Signed-off-by: Yao Kai <yaokai34@huawei.com>
---
 drivers/dma/idxd/init.c  | 2 ++
 drivers/dma/idxd/sysfs.c | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 4b827a329756..ffbc5a74be6e 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -389,6 +389,7 @@ static void idxd_cleanup_internals(struct idxd_device *idxd)
 	idxd_clean_engines(idxd);
 	idxd_clean_wqs(idxd);
 	destroy_workqueue(idxd->wq);
+	idxd->wq = NULL;
 }
 
 static int idxd_init_evl(struct idxd_device *idxd)
@@ -460,6 +461,7 @@ static int idxd_setup_internals(struct idxd_device *idxd)
 
  err_evl:
 	destroy_workqueue(idxd->wq);
+	idxd->wq = NULL;
  err_wkq_create:
 	idxd_clean_groups(idxd);
  err_group:
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 6d251095c350..d5ffc641c856 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1836,7 +1836,8 @@ static void idxd_conf_device_release(struct device *dev)
 {
 	struct idxd_device *idxd = confdev_to_idxd(dev);
 
-	destroy_workqueue(idxd->wq);
+	if (idxd->wq)
+		destroy_workqueue(idxd->wq);
 	kfree(idxd->groups);
 	bitmap_free(idxd->wq_enable_map);
 	kfree(idxd->wqs);
-- 
2.43.0

