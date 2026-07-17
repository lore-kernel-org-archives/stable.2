Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8386A3BD225;
	Fri, 17 Jul 2026 07:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784272410; cv=none; b=UZyONGbEsKaTrX7oxQZELWZBxjSuXGHfXVrt70wzoG/34sHdWqLJBdxv6GPstdBS7bgmwaB3oMoJX/NRtVI8x9BHM0Zqoty+qttr+lPP0uMGwE80HMCsKwDgRZu4mWIPvxq10B3bapg1+bX6pOQe8PBUlbYzAfRq+Eh/2RGqVfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784272410; c=relaxed/simple;
	bh=/GRBTVCBnNMhdTmgROYtCEFwoe4XtBNJQfBS3w9bKhg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mNFtd9HzEFp38jo59OzyV7rjm/8F45IV1ChUTRhzBSPxaTcI61egbFwqLzaNAlpnZwxMlPlQaY6rT324fmPOkVYpf3k/AzP3xqlk4paP3xLgCoxD9bk/k/lPbqe4T/Dw2h07UP76ZDUWZyYTFgJpecvnEnr1wVaOhwSv7sjg8YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: fd4f9fa481ae11f1aa26b74ffac11d73-20260717
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:2d2486ae-ce1c-4cc2-ba41-e3ebc4a8d99d,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:e7bac3a,CLOUDID:781a12360464066d5a466714afb83265,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898,TC:nil,Content:0|15|
	50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: fd4f9fa481ae11f1aa26b74ffac11d73-20260717
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1548124036; Fri, 17 Jul 2026 15:13:19 +0800
From: Linmao Li <lilinmao@kylinos.cn>
To: Nas Chung <nas.chung@chipsnmedia.com>,
	Jackson Lee <jackson.lee@chipsnmedia.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linmao Li <lilinmao@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] media: chips-media: wave5: Handle polling IRQ thread failure
Date: Fri, 17 Jul 2026 15:13:15 +0800
Message-Id: <20260717071315.1485454-1-lilinmao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When falling back to polling mode, wave5_vpu_probe() does not check the
return value of kthread_run().  On failure, dev->irq_thread holds an
error pointer instead of a valid task pointer.

Both the probe error path and the remove path only check
dev->irq_thread against NULL before calling kthread_stop() on it, so an
error pointer passes the check and kthread_stop() crashes on it.

Check the kthread_run() result, clear dev->irq_thread and unwind the
probe on failure.

Fixes: e66ff2b08e4e ("media: chips-media: wave5: Fix Null reference while testing fluster")
Cc: stable@vger.kernel.org
Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
---
 drivers/media/platform/chips-media/wave5/wave5-vpu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
index 76d57c6b636a..37df270b5f99 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
@@ -340,6 +340,13 @@ static int wave5_vpu_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "failed to get irq resource, falling back to polling\n");
 		sema_init(&dev->irq_sem, 1);
 		dev->irq_thread = kthread_run(irq_thread, dev, "irq thread");
+		if (IS_ERR(dev->irq_thread)) {
+			ret = PTR_ERR(dev->irq_thread);
+			dev_err(&pdev->dev, "failed to create irq thread\n");
+			dev->irq_thread = NULL;
+			goto err_vdi_release;
+		}
+
 		hrtimer_setup(&dev->hrtimer, &wave5_vpu_timer_callback, CLOCK_MONOTONIC,
 			      HRTIMER_MODE_REL_PINNED);
 		dev->worker = kthread_run_worker(0, "vpu_irq_thread");
-- 
2.25.1

