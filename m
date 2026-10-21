Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792595775;
	b=D175CIZUlNW7iqA079KwSDQQM08jM7KLGJXYnZUtE/qYFSzaj6Fj4fZ3mAKBHKru8Y7n
	 zZNEylhMiaYqU4WxoARYnI1Ctbi+pdSoOWozJ5Xcvd9HHKSN80lRhbKqrMl2A6rS0uIRB
	 F026YzZh2lg5xacWMcpijgjG2RQ4+wDivIlpa2nMLvf5lh2TQwtcrpeYwawHGCb9dQwal
	 jZa7qnVt9GJe05Fw6mL5YUoNyMfnOUq8No2aDh4G0Dz+CBXUoFc3X/q96yGkpQiN/6zLR
	 CnmRBFu54x+QOQ8GUYuvEFhjhMaeJe17fh3EhHOPgCRWHftH4qEbEdUfbBTOfT87opw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792595775;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=C1L9U7ljAYq4+zlYKmRqdIuPABKm7sH11JLhWe4pnC4=;
	b=MdXjWdAWHkWs/p1B02Jtx4DXWYxYLA+h8OMtuCpOiOeJKHjMxpT7chgpu/j4KVN0qmpW
	 PeD8MlT3CK7EZeT4hzOloQG4G2AtfFeAPsK1lxFB3MIB8o15FRhJ8Fw4SbaqfQ+vdcRXF
	 2gPnIKtbvXsqrNAY30s0N9Tv4y5oSziJwRx1Arf8GW4rN8N5wyeDRwxbSfwWkoZh+hvZL
	 C8icPf/rq+0xid/XglZPaPFklFrnrflFSEVaY6g9LqJcZH09cPQsR0k/FnhpfAGl3XmXP
	 XHodLec5w1pHMKkaseSpZHjOPpk4a+VHo8zF09e15l/Qeguy0E1my1uNyL4o+89zpfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=a4wDDAZd;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6A8606A33B;
	Wed, 21 Oct 2026 15:16:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C6A8606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=a4wDDAZd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=C1
	L9U7ljAYq4+zlYKmRqdIuPABKm7sH11JLhWe4pnC4=; b=a4wDDAZdvgtAilGfMD
	pgbmP/syRLUtn6GN+Lna30VX2a8kU1/LPKQBYJ3RAD0yJ/GBtAl4HXQUDQt8/9xs
	CrgqiQbVGAwpTjZgLTLvoy0PgBgin975lpw6denzkbIERBQhbZRVITNyat93k3Dq
	AFTHcnhsV0dCRYFdDgkBp44s4=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDn93cq19hqoFfvBQ--.50052S6;
	Wed, 21 Oct 2026 23:15:57 +0800 (CST)
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
Subject: [PATCH v3 4/4] media: wave5: handle runtime resume failure when closing
Date: Wed, 21 Oct 2026 23:15:51 +0800
Message-Id: <20261021151552.428590-5-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021151552.428590-1-yaojiale02@163.com>
References: <20261021151552.428590-1-yaojiale02@163.com>
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
X-CM-TRANSID:_____wDn93cq19hqoFfvBQ--.50052S6
X-Coremail-Antispam: 1Uf129KBjvJXoWxCryDCFy3Jw4DCF47Aw1DWrg_yoWrCry5pr
	yrWF1DGrW8Jwn7Kr1ktr4xZ3ZYv3yku3yUu3s7AF9xA345Zr1Yvr4DtFyFvF18JrWvyasI
	qrsrW345CFs7JF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jeOJnUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8A3RDGrY1y1j6AAA3j

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

