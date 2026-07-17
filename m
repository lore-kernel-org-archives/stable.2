Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A474E3ACF17;
	Fri, 17 Jul 2026 07:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784275054; cv=none; b=dyhP5+3n8Kw4IrMcmHpaSRCDa5GYNLrA12aMkRXe13pysD/E2JMsayEPfC+UDW3CKB7kGFZJh3HfgXMQmn7zNyTZce2HwYwvGruMOliy8NFgpJ5qYnd8FDHp1WJXSPEOXCqVcqXK2Op6aAek37+C5sDIzC4LxnbfWavuVWz7cXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784275054; c=relaxed/simple;
	bh=c9Z6ZrHEYriG6gG9sf7H1/tHmv5K0/tRp2Qm2oVEj20=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R8J57gUfufcB7swE1tgJ9OLcMk0icFT7qamAoYI+xCBfWuS+HUIIpNhLgqV+su2TeAKz3892/kLbO6ruFth5UrxjJcxxrCAMTY01efp/3tc9pg/Rd8tbaLQzvs29qJpzNs3BGjSUQEuk4CjyZcnNYJuFHSZaXlY1Qf+OyYH/ZJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2348cc2a81b511f1aa26b74ffac11d73-20260717
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:c2559770-bef1-4ec2-9b45-43df99297e51,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:79a0ed7f2a628db40f25b7ddf52455b0,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898,TC:nil,Content:0|15|
	50,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2348cc2a81b511f1aa26b74ffac11d73-20260717
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1314255756; Fri, 17 Jul 2026 15:57:20 +0800
From: Linmao Li <lilinmao@kylinos.cn>
To: Nas Chung <nas.chung@chipsnmedia.com>,
	Jackson Lee <jackson.lee@chipsnmedia.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Sebastian Fricke <sebastian.fricke@collabora.com>,
	Hans Verkuil <hverkuil@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linmao Li <lilinmao@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] media: chips-media: wave5: Balance runtime PM on encoder close errors
Date: Fri, 17 Jul 2026 15:57:14 +0800
Message-Id: <20260717075714.1508938-1-lilinmao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wave5_vpu_enc_close() resumes the device before taking the hardware lock.
Its three error paths call pm_runtime_resume_and_get() again instead of
dropping that reference.  Each failure therefore increments the runtime PM
usage count twice and can prevent the device from suspending afterward.

Replace the extra resume calls with pm_runtime_put_sync() to balance the
reference acquired on entry, matching the successful close path.  This
aligns wave5_vpu_enc_close() with wave5_vpu_dec_close(), which already
releases the reference on its error paths.

Fixes: 2092b3833487 ("media: chips-media: wave5: Support runtime suspend/resume")
Cc: stable@vger.kernel.org
Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
---
 .../platform/chips-media/wave5/wave5-vpuapi.c     | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
index f77abd5e122a..4c1842f02c88 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
@@ -754,7 +754,7 @@ int wave5_vpu_enc_close(struct vpu_instance *inst, u32 *fail_res)
 
 	ret = mutex_lock_interruptible(&vpu_dev->hw_lock);
 	if (ret) {
-		pm_runtime_resume_and_get(inst->dev->dev);
+		pm_runtime_put_sync(inst->dev->dev);
 		return ret;
 	}
 
@@ -762,16 +762,13 @@ int wave5_vpu_enc_close(struct vpu_instance *inst, u32 *fail_res)
 		ret = wave5_vpu_enc_finish_seq(inst, fail_res);
 		if (ret < 0 && *fail_res != WAVE5_SYSERR_VPU_STILL_RUNNING) {
 			dev_warn(inst->dev->dev, "enc_finish_seq timed out\n");
-			pm_runtime_resume_and_get(inst->dev->dev);
-			mutex_unlock(&vpu_dev->hw_lock);
-			return ret;
+			goto unlock_and_return;
 		}
 
 		if (*fail_res == WAVE5_SYSERR_VPU_STILL_RUNNING &&
 		    retry++ >= MAX_FIRMWARE_CALL_RETRY) {
-			pm_runtime_resume_and_get(inst->dev->dev);
-			mutex_unlock(&vpu_dev->hw_lock);
-			return -ETIMEDOUT;
+			ret = -ETIMEDOUT;
+			goto unlock_and_return;
 		}
 	} while (ret != 0);
 
@@ -787,10 +784,12 @@ int wave5_vpu_enc_close(struct vpu_instance *inst, u32 *fail_res)
 	}
 
 	wave5_vdi_free_dma_memory(vpu_dev, &p_enc_info->vb_task);
+
+unlock_and_return:
 	mutex_unlock(&vpu_dev->hw_lock);
 	pm_runtime_put_sync(inst->dev->dev);
 
-	return 0;
+	return ret;
 }
 
 int wave5_vpu_enc_register_frame_buffer(struct vpu_instance *inst, unsigned int num,
-- 
2.25.1

