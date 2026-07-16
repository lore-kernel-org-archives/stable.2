Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17223DD51F;
	Thu, 16 Jul 2026 08:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784190367; cv=none; b=L7kzk60cksZDLZYF2f1TV45c3MchRusV4x5Yki4xMz/XMvAYdeHK80s01boSqx2a2oPxpz7WMwFPlwd7la1B2H6Zbwyl11Anu96mjb45KMH3ueOFYEZMcPKXS40j2/HRiJEUqERD85h3ZaIrmze90lrXsTYSXlkpK/FvEnYJDjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784190367; c=relaxed/simple;
	bh=BFKDMvrAO5Dq5lrJOKq1Y0usWKQnmmHR+ihRNn1ZnOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZZ4LbJ4Z4qmwvlztXe2GuFvPELUpv/rpc/GxFNqfZ8PoVHyxr7PpXyxrslknf9jpimXmwRukdpRpMYzrGzp7E5KnyAT1SyIUAjgDXG9lvXuePxMZmsc2lAEjyNa0BtrO/AX0L8F5wdqANFHMaiyEDzVnype5KCWMB5vN2fvZW80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f6e83ed880ef11f1aa26b74ffac11d73-20260716
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:564aa6ea-7126-41ce-a8ab-43411b078d6a,IP:15,
	URL:25,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:35
X-CID-INFO: VERSION:1.3.12,REQID:564aa6ea-7126-41ce-a8ab-43411b078d6a,IP:15,UR
	L:25,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:35
X-CID-META: VersionHash:e7bac3a,CLOUDID:0d25f18fabaf7a7729211895d275d9c7,BulkI
	D:260716162555421W5OS2,BulkQuantity:0,Recheck:0,SF:10|38|57|66|78|80|81|82
	|102|123|127|136|841|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:93|82
	|11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1
	,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f6e83ed880ef11f1aa26b74ffac11d73-20260716
X-User: zhaoguohan@kylinos.cn
Received: from zgh-vmware-virtual-platform.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <zhaoguohan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1907087791; Thu, 16 Jul 2026 16:25:55 +0800
From: zhaoguohan@kylinos.cn
To: "Rob Herring (Arm)" <robh@kernel.org>,
	Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	dri-devel@lists.freedesktop.org
Cc: Oded Gabbay <ogabbay@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/3] accel/ethosu: propagate SRAM initialization errors
Date: Thu, 16 Jul 2026 16:25:29 +0800
Message-ID: <20260716082530.1023538-3-zhaoguohan@kylinos.cn>
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

ethosu_sram_init() returns -ENOMEM if allocation from a declared SRAM
pool fails. ethosu_init() ignores the error after recording the pool size.
Probe then registers a device with a nonzero SRAM size and a zero sramphys
address, allowing jobs to program address zero for SRAM.

Propagate the error and synchronously suspend the device before the probe
path releases the scheduler.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260716065219.931088-1-zhaoguohan@kylinos.cn?part=1
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
---
Sashiko report:

> This is a pre-existing issue, but was not introduced by this patch.
>
> In ethosu_sram_init(), if gen_pool_dma_alloc() fails, it returns an
> error. However, ethosu_init() ignores this return value.
>
> Because npu_info.sram_size was already set to gen_pool_size(), it remains
> non-zero while sramphys remains 0.
>
> When a user submits a job requesting sram, the size check passes, and
> ethosu_job_hw_submit() configures the hardware to use physical sram
> address 0x0.
>
> Could this result in a memory corruption regression or an IOMMU fault?

 drivers/accel/ethosu/ethosu_drv.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/ethosu/ethosu_drv.c b/drivers/accel/ethosu/ethosu_drv.c
index d1153b15ca3e..479156f79bc1 100644
--- a/drivers/accel/ethosu/ethosu_drv.c
+++ b/drivers/accel/ethosu/ethosu_drv.c
@@ -320,7 +320,9 @@ static int ethosu_init(struct ethosu_device *ethosudev)
 	ethosudev->npu_info.id = id = readl_relaxed(ethosudev->regs + NPU_REG_ID);
 	ethosudev->npu_info.config = config = readl_relaxed(ethosudev->regs + NPU_REG_CONFIG);
 
-	ethosu_sram_init(ethosudev);
+	ret = ethosu_sram_init(ethosudev);
+	if (ret)
+		goto err_runtime_suspend;
 
 	dev_info(ethosudev->base.dev,
 		 "Ethos-U NPU, arch v%ld.%ld.%ld, rev r%ldp%ld, cmd stream ver%ld, %d MACs, %dKB SRAM\n",
@@ -335,6 +337,10 @@ static int ethosu_init(struct ethosu_device *ethosudev)
 
 	return 0;
 
+err_runtime_suspend:
+	pm_runtime_dont_use_autosuspend(ethosudev->base.dev);
+	pm_runtime_put_sync_suspend(ethosudev->base.dev);
+	return ret;
 err_suspend:
 	pm_runtime_dont_use_autosuspend(ethosudev->base.dev);
 	ethosu_device_suspend(ethosudev->base.dev);
-- 
2.43.0
