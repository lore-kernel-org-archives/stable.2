Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792747704;
	b=aHtpGDNodgGzVOQZzEJyp4feFxwoAjNL4BNIkLVHPqCx2+7pny2oc56iIuDlidrQDpNn
	 YG2QMOUpX6Qf1Mzhk7loXG16g7RG8dE7eW6Y3Hp5lza5/nIufLVmc6J7UVnrln3m1+0Ec
	 630weD9VA4mCc1ddOrH2z/QRZaO1Wxnh9DdbgUadB15M81xLi55U0Hfy+IbFwNYC2h+AE
	 qbRim2R3S9fyOoHol80XW+eKUvNMgcONXQPcORw7bO3epSolIT+RUxTaCp3FME6yloCGy
	 yUgJGTxjgOWytfjyS5NSXwkTR1mYkx73LW4ZNbT/9MMQT3hPVyJdz9QwQb/uHwTtinQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792747704;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=eNyYfQptoFTD47cQRauaaNxOsHqwoQB1alZ+QnmtoL8=;
	b=xcNzHJ3ApqHUnHzbRmTfch6CMiBaZaocZUL8/jj1YayAXaFWA0wscZ626wEhC2BL/36L
	 G422X80DAbwOzTAQlbPtOI7hI9HZD3oALBeChCuxZTItm1MQm+4mGMVl1XrHqNfpGNzPd
	 V63FXKS7yDVAgx4sX82ktUocbyU6CM/n+U3SyTxvjT3h16bNkeEbdxFqxCBih36bS1dsT
	 VJMo0qu4aXHDX82sYMEePGc3uIGtZp45APIQ6b8aHdQXZ0gWtsqlNaFjoKTH0MY2ulJVi
	 tKXIx5MkqAxPphV8aDvCLyTA36avCAY8Jke7fzTWvRQHv0AyWPWYAYLkBt/URtRDWvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b="DD/yOzcF";
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6464F606A31E;
	Fri, 23 Oct 2026 09:28:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6464F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=DD/yOzcF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=eN
	yYfQptoFTD47cQRauaaNxOsHqwoQB1alZ+QnmtoL8=; b=DD/yOzcFkrdW1sNGs5
	OSUR5Z6bTkiyyplm2zoZ1TraO9Ieq8m0p+BEHyXkqtZCooSccPXZKMEamWcpoA23
	58DTWQQCWJHEJcuptEw/USAUk+b6cvMjzfPfCk+XD8RRPKujnh0Q+PR6f+jxYaGq
	ln6/uwQBtV8Ar5+sNfcdYNzBc=
Received: from pc.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgD3KHOkKNtqXHGqBQ--.1363S6;
	Fri, 23 Oct 2026 17:28:10 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Nas Chung <nas.chung@chipsnmedia.com>,
	Jackson Lee <jackson.lee@chipsnmedia.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Sebastian Fricke <sebastian.fricke@collabora.com>,
	Hans Verkuil <hverkuil@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v4 4/4] media: wave5: handle runtime resume failure when closing
Date: Fri, 23 Oct 2026 17:28:03 +0800
Message-Id: <20261023092804.673980-5-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023092804.673980-1-yaojiale02@163.com>
References: <20261023092804.673980-1-yaojiale02@163.com>
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
X-CM-TRANSID:PCgvCgD3KHOkKNtqXHGqBQ--.1363S6
X-Coremail-Antispam: 1Uf129KBjvJXoWxCryDCFy3Jw4DCF47Aw1DWrg_yoWrCFWrpr
	yrWF4DGrW8Jwn7Kr1ktr4xZ3ZY93yku3yUu3s7AFy3A345Xr1Yvr4DtFyFvF18JrWvyasI
	qrsrW34rCFs7JF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnkucUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7wrFAGrbKKrJ2AAA3C

The decoder and encoder close paths ignore runtime resume failures and
proceed to firmware commands. If enabling the VPU clocks failed, those
commands access unavailable registers, and the paths later drop a
runtime PM reference that was not acquired.

Returning the resume error directly also prevents release_device() from
calling wave5_cleanup_instance(). The instance has already been removed
from the device list and its mem2mem context released, so its host-side
resources leak.

On a resume failure, skip the firmware command and hardware lock, free
the close-path resources, and return -EIO. Use a decoder cleanup helper
so auxiliary-buffer cleanup cannot overwrite the resume failure status.
This lets release_device() continue with its common instance cleanup
without unlocking an unheld mutex or issuing an unmatched runtime PM put.

Fixes: 2092b3833487 ("media: chips-media: wave5: Support runtime suspend/resume")
Cc: stable@vger.kernel.org
Reviewed-by: Jackson Lee <jackson.lee@chipsnmedia.com>
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 .../platform/chips-media/wave5/wave5-vpuapi.c | 47 ++++++++++++-------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
index 4c1842f02c..31be2581ae 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
@@ -206,13 +206,26 @@ static int reset_auxiliary_buffers(struct vpu_instance *inst, unsigned int index
 	return 0;
 }
 
-int wave5_vpu_dec_close(struct vpu_instance *inst, u32 *fail_res)
+static void wave5_vpu_dec_free_resources(struct vpu_instance *inst)
 {
 	struct dec_info *p_dec_info = &inst->codec_info->dec_info;
+	int i;
+
+	wave5_vdi_free_dma_memory(inst->dev, &p_dec_info->vb_work);
+
+	for (i = 0; i < MAX_REG_FRAME; i++)
+		if (reset_auxiliary_buffers(inst, i))
+			break;
+
+	wave5_vdi_free_dma_memory(inst->dev, &p_dec_info->vb_task);
+	mutex_destroy(&inst->feed_lock);
+}
+
+int wave5_vpu_dec_close(struct vpu_instance *inst, u32 *fail_res)
+{
 	int ret;
 	int retry = 0;
 	struct vpu_device *vpu_dev = inst->dev;
-	int i;
 	struct dec_output_info dec_info;
 	int ret_mutex;
 
@@ -220,7 +233,11 @@ int wave5_vpu_dec_close(struct vpu_instance *inst, u32 *fail_res)
 	if (!inst->codec_info)
 		return -EINVAL;
 
-	pm_runtime_resume_and_get(inst->dev->dev);
+	ret = pm_runtime_resume_and_get(inst->dev->dev);
+	if (ret < 0) {
+		wave5_vpu_dec_free_resources(inst);
+		return -EIO;
+	}
 
 	ret_mutex = mutex_lock_interruptible(&vpu_dev->hw_lock);
 	if (ret_mutex) {
@@ -258,20 +275,7 @@ int wave5_vpu_dec_close(struct vpu_instance *inst, u32 *fail_res)
 	} while (ret != 0);
 
 	dev_dbg(inst->dev->dev, "%s: dec_finish_seq complete\n", __func__);
-
-	wave5_vdi_free_dma_memory(vpu_dev, &p_dec_info->vb_work);
-
-	for (i = 0 ; i < MAX_REG_FRAME; i++) {
-		ret = reset_auxiliary_buffers(inst, i);
-		if (ret) {
-			ret = 0;
-			break;
-		}
-	}
-
-	wave5_vdi_free_dma_memory(vpu_dev, &p_dec_info->vb_task);
-
-	mutex_destroy(&inst->feed_lock);
+	wave5_vpu_dec_free_resources(inst);
 
 unlock_and_return:
 	mutex_unlock(&vpu_dev->hw_lock);
@@ -750,7 +754,11 @@ int wave5_vpu_enc_close(struct vpu_instance *inst, u32 *fail_res)
 	if (!inst->codec_info)
 		return -EINVAL;
 
-	pm_runtime_resume_and_get(inst->dev->dev);
+	ret = pm_runtime_resume_and_get(inst->dev->dev);
+	if (ret < 0) {
+		ret = -EIO;
+		goto free_resources;
+	}
 
 	ret = mutex_lock_interruptible(&vpu_dev->hw_lock);
 	if (ret) {
@@ -774,6 +782,7 @@ int wave5_vpu_enc_close(struct vpu_instance *inst, u32 *fail_res)
 
 	dev_dbg(inst->dev->dev, "%s: enc_finish_seq complete\n", __func__);
 
+free_resources:
 	wave5_vdi_free_dma_memory(vpu_dev, &p_enc_info->vb_work);
 
 	if (inst->std == W_HEVC_ENC || inst->std == W_AVC_ENC) {
@@ -784,6 +793,8 @@ int wave5_vpu_enc_close(struct vpu_instance *inst, u32 *fail_res)
 	}
 
 	wave5_vdi_free_dma_memory(vpu_dev, &p_enc_info->vb_task);
+	if (ret == -EIO)
+		return ret;
 
 unlock_and_return:
 	mutex_unlock(&vpu_dev->hw_lock);
-- 
2.34.1

