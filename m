Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D07B3DEFFC;
	Thu, 16 Jul 2026 08:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784190367; cv=none; b=DGTevrnaOsNOuYOCNNtSvFMcbOrl70ztobCLgmYkXDmXBQQZTL2PvQOZQKCIDkoMj6+Zb0kMVuRHe+m1fphMFqJc9iOq6HtnEHcgVcoBQnrnbBuzm0Tv4ULencG6VzK4HPXAaTFC9wRoeR8yzIQMEYzLDIQ7xqbrJw6QXEnjD1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784190367; c=relaxed/simple;
	bh=E9HT42qopx9eAGCOiXYL83ZD2PANskp8DP/mmBWF//U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m0d2NqwyAvo0DQaLtSFjH32QcidnmPb+o03V+kFNRJYt5VJw6y/oZurzmJnyt04OIFSXbFFS3svOen1lUEtsarCpWi4R3ao5CfHepVauwWgOgSnDydsYulmaKfif7NQ8i/yMaG7BERIMNuB6I139NTA45oCn55Z37HlIq3c2zF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f67a4e1480ef11f1aa26b74ffac11d73-20260716
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:4720123a-3270-455f-a2f5-a911758aafe1,IP:15,
	URL:25,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:35
X-CID-INFO: VERSION:1.3.12,REQID:4720123a-3270-455f-a2f5-a911758aafe1,IP:15,UR
	L:25,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:35
X-CID-META: VersionHash:e7bac3a,CLOUDID:11420e8b4e8d9b46fd85191da5cc35db,BulkI
	D:260716162555F716U1XW,BulkQuantity:0,Recheck:0,SF:10|38|57|66|78|80|81|82
	|102|123|127|136|841|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:11|93
	|82|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1
	,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f67a4e1480ef11f1aa26b74ffac11d73-20260716
X-User: zhaoguohan@kylinos.cn
Received: from zgh-vmware-virtual-platform.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <zhaoguohan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 943019971; Thu, 16 Jul 2026 16:25:54 +0800
From: zhaoguohan@kylinos.cn
To: "Rob Herring (Arm)" <robh@kernel.org>,
	Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	dri-devel@lists.freedesktop.org
Cc: Oded Gabbay <ogabbay@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/3] accel/ethosu: clean up resources on probe failure
Date: Thu, 16 Jul 2026 16:25:28 +0800
Message-ID: <20260716082530.1023538-2-zhaoguohan@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260716082530.1023538-1-zhaoguohan@kylinos.cn>
References: <20260716082530.1023538-1-zhaoguohan@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: GuoHan Zhao <zhaoguohan@kylinos.cn>

ethosu_job_init() creates a scheduler before ethosu_init() and
drm_dev_register(). Errors from either later step return directly, leaving
the scheduler workqueue allocated. A drm_dev_register() failure also leaves
the optional SRAM allocation behind.

Unwind runtime PM, SRAM, and scheduler state in reverse order on probe
failure. Disable the clocks when runtime PM setup fails as well.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260716065219.931088-1-zhaoguohan@kylinos.cn?part=1
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
---
Sashiko report:

> This is a pre-existing issue, but was not introduced by this patch.
>
> If ethosu_init() or drm_dev_register() fail, the function returns
> directly without calling ethosu_job_fini() or freeing the sram pool.
>
> Because the job scheduler is embedded in the devm-allocated
> ethosu_device, it will be freed when devm cleans up. However, the drm
> scheduler kthreads and timers remain active and will access the freed
> memory.
>
> Can this cause a use-after-free regression leading to a kernel panic?

 drivers/accel/ethosu/ethosu_drv.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/accel/ethosu/ethosu_drv.c b/drivers/accel/ethosu/ethosu_drv.c
index ed9c748a54ad..d1153b15ca3e 100644
--- a/drivers/accel/ethosu/ethosu_drv.c
+++ b/drivers/accel/ethosu/ethosu_drv.c
@@ -293,6 +293,14 @@ static int ethosu_sram_init(struct ethosu_device *ethosudev)
 	return 0;
 }
 
+static void ethosu_sram_fini(struct ethosu_device *ethosudev)
+{
+	if (ethosudev->sram)
+		gen_pool_free(ethosudev->srampool,
+			      (unsigned long)ethosudev->sram,
+			      ethosudev->npu_info.sram_size);
+}
+
 static int ethosu_init(struct ethosu_device *ethosudev)
 {
 	int ret;
@@ -306,7 +314,7 @@ static int ethosu_init(struct ethosu_device *ethosudev)
 	pm_runtime_use_autosuspend(ethosudev->base.dev);
 	ret = devm_pm_runtime_set_active_enabled(ethosudev->base.dev);
 	if (ret)
-		return ret;
+		goto err_suspend;
 	pm_runtime_get_noresume(ethosudev->base.dev);
 
 	ethosudev->npu_info.id = id = readl_relaxed(ethosudev->regs + NPU_REG_ID);
@@ -326,6 +334,11 @@ static int ethosu_init(struct ethosu_device *ethosudev)
 		 ethosudev->npu_info.sram_size / 1024);
 
 	return 0;
+
+err_suspend:
+	pm_runtime_dont_use_autosuspend(ethosudev->base.dev);
+	ethosu_device_suspend(ethosudev->base.dev);
+	return ret;
 }
 
 static int ethosu_probe(struct platform_device *pdev)
@@ -353,13 +366,21 @@ static int ethosu_probe(struct platform_device *pdev)
 
 	ret = ethosu_init(ethosudev);
 	if (ret)
-		return ret;
+		goto err_job_fini;
 
 	ret = drm_dev_register(&ethosudev->base, 0);
 	if (ret)
-		pm_runtime_dont_use_autosuspend(ethosudev->base.dev);
+		goto err_runtime_suspend;
 
 	pm_runtime_put_autosuspend(ethosudev->base.dev);
+	return 0;
+
+err_runtime_suspend:
+	pm_runtime_dont_use_autosuspend(ethosudev->base.dev);
+	pm_runtime_put_sync_suspend(ethosudev->base.dev);
+	ethosu_sram_fini(ethosudev);
+err_job_fini:
+	ethosu_job_fini(ethosudev);
 	return ret;
 }
 
@@ -369,9 +390,7 @@ static void ethosu_remove(struct platform_device *pdev)
 
 	drm_dev_unregister(&ethosudev->base);
 	ethosu_job_fini(ethosudev);
-	if (ethosudev->sram)
-		gen_pool_free(ethosudev->srampool, (unsigned long)ethosudev->sram,
-			      ethosudev->npu_info.sram_size);
+	ethosu_sram_fini(ethosudev);
 }
 
 static const struct of_device_id dt_match[] = {
-- 
2.43.0
