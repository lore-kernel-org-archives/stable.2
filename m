Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792747703;
	b=XDM1jV8qg/IIc/vVBBnI0KQ1HbQd9+5vzXuBgjv6EcVWelqXAHt12LooHy4SMdeN2WZ+
	 JaymOa1FrLtKuW9cBV+1MU/tfy5+Ceu2jnPM2FivhPNXhC+8ss6L8v8bnhaAiyk5TkWmg
	 sMAL1ZUkmOolHgiMxlqCLZOTLBrLOSdfa2EW/yB7GsfcPH/sMgRLsbLhRPoD6iXs/VIq5
	 c4O2UG8rQrqaHkcSmUFps//2s/rQI5rKdAbzEffYPj44DaKBGlD+XHFoWYAOtm2tCCb3U
	 dn980qsEbbgH4o+BfRSOXXU2Bth/PpmC4wN1m9vPBQOBBGdM3NPwnZe64iX4kAjRU1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792747703;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=2A5ogykBu6eGEMANLWbebVzz2b4RhwFgjJ7CzCvTt3A=;
	b=Qz/z1i4Q3xWvDUcGNk6KkNWGIBONi9eDFtssWAo/Rex/Q8uG/PuZVTw3sIFY64zw7Iyh
	 jJW7jACP0GKnQSoB+Dh122SOfITMbFVJBF3ySJvX4QJV3eyWZBL9U5dLjjpSzh3Fhr5eG
	 Y7lf9IXyIbtOEF6/7r73MiHyWGavlQeylyRMEFyEh0w9KU3F+duR56zEUpY2B4s3SjyqJ
	 6gw29vx5iasBNEX0GIVnD9NQOAufsBoe8tWCAqpsmxvt1Jxfw6ekNWh9wQ6rmJ1yAD84H
	 lvhs9IfOaUR46tQL4FNA6N1gT7MCJH+YW7L29Lg27BfpvEwB/YXdwvjssirqhsJpslw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=FywRNP61;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49976606A31A;
	Fri, 23 Oct 2026 09:28:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49976606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=FywRNP61
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=2A
	5ogykBu6eGEMANLWbebVzz2b4RhwFgjJ7CzCvTt3A=; b=FywRNP615wR3reVd7c
	m0Fn9lUJyXEVWOEyeBn5qIAzdm4vNnne4u51E7QcKOzPXIGFQJ1V+XsHLgXgAJxa
	W0zgIM1/zctMecnG6l6BDn6IhtNQJzzOtkUZQaIYSgsUJnH0MdrxOOPPFgJbX1ki
	HbgSHtUo6rSfgiR24+K1ZVpho=
Received: from pc.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgD3KHOkKNtqXHGqBQ--.1363S3;
	Fri, 23 Oct 2026 17:28:07 +0800 (CST)
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
Subject: [PATCH v4 1/4] media: wave5: handle remaining decoder runtime resume failures
Date: Fri, 23 Oct 2026 17:28:00 +0800
Message-Id: <20261023092804.673980-2-yaojiale02@163.com>
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
X-CM-TRANSID:PCgvCgD3KHOkKNtqXHGqBQ--.1363S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxAr4xJr1kCF48XFWkZFW7twb_yoW7JF13pr
	y0gFnxKrW8JF48JrWUJr4xZa45uw4kXrWxu3s3Gas7ArWrXrsYqr1jyF15tF4vyrZ3Za1D
	Jr4DX3y7Cr1aqrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jznQUUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzQfE-mrbKKd2iAAA3w

Several decoder callbacks continue into firmware commands after
pm_runtime_resume_and_get() fails. The runtime resume callback can fail
while enabling the VPU clocks, so those commands may access registers
while the device is unavailable. The matching runtime PM puts can also
be issued without a reference.

Check the remaining resume results. Propagate errors from callbacks that
can return them, complete buffers or jobs from void callbacks, and avoid
firmware access and unmatched puts on failure. If runtime resume fails in
device_run(), stop the instance, fail both queues, and return their queued
buffers so the mem2mem scheduler cannot repeatedly run the failed job.

Fixes: 2092b3833487 ("media: chips-media: wave5: Support runtime suspend/resume")
Fixes: cbb9c0d50e47 ("media: chips-media: wave5: Fix SError of kernel panic when closed")
Fixes: a52e6f7923c1 ("media: chips-media: wave5: Resume device before setting EOS flag")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 .../chips-media/wave5/wave5-vpu-dec.c         | 55 +++++++++++++++++--
 1 file changed, 50 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
index 86bc36ee17..0088501f93 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
@@ -829,7 +829,10 @@ static int wave5_vpu_dec_stop(struct vpu_instance *inst)
 		 * accesses VPU registers via send_firmware_command(), so the
 		 * device must be resumed first to avoid an asynchronous SError.
 		 */
-		pm_runtime_resume_and_get(inst->dev->dev);
+		ret = pm_runtime_resume_and_get(inst->dev->dev);
+		if (ret < 0)
+			return ret;
+
 		ret = wave5_vpu_dec_set_eos_on_firmware(inst);
 		pm_runtime_put_autosuspend(inst->dev->dev);
 		if (ret)
@@ -1392,7 +1395,11 @@ static int wave5_vpu_dec_start_streaming(struct vb2_queue *q, unsigned int count
 	int ret = 0;
 
 	dev_dbg(inst->dev->dev, "%s: type: %u\n", __func__, q->type);
-	pm_runtime_resume_and_get(inst->dev->dev);
+	ret = pm_runtime_resume_and_get(inst->dev->dev);
+	if (ret < 0) {
+		wave5_return_bufs(q, VB2_BUF_STATE_QUEUED);
+		return ret;
+	}
 
 	v4l2_m2m_update_start_streaming_state(m2m_ctx, q);
 
@@ -1556,9 +1563,28 @@ static void wave5_vpu_dec_stop_streaming(struct vb2_queue *q)
 	struct vpu_instance *inst = vb2_get_drv_priv(q);
 	struct v4l2_m2m_ctx *m2m_ctx = inst->v4l2_fh.m2m_ctx;
 	unsigned long timeout;
+	int ret;
 
 	dev_dbg(inst->dev->dev, "%s: type: %u\n", __func__, q->type);
-	pm_runtime_resume_and_get(inst->dev->dev);
+	ret = pm_runtime_resume_and_get(inst->dev->dev);
+	if (ret < 0) {
+		if (q->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
+			struct vpu_src_buffer *vpu_buf;
+
+			inst->retry = false;
+			inst->queuing_num = 0;
+			while ((vpu_buf = inst_src_buf_remove(inst)) != NULL)
+				;
+			inst->eos = false;
+		}
+
+		v4l2_m2m_update_stop_streaming_state(m2m_ctx, q);
+		wave5_return_bufs(q, VB2_BUF_STATE_ERROR);
+		inst->empty_queue = false;
+		inst->sent_eos = false;
+		return;
+	}
+
 	inst->empty_queue = true;
 
 	timeout = jiffies + msecs_to_jiffies(VPU_DEC_STOP_TIMEOUT);
@@ -1675,7 +1701,21 @@ static void wave5_vpu_dec_device_run(void *priv)
 	bool cmd_issued = false;
 
 	dev_dbg(inst->dev->dev, "%s: Fill the ring buffer with new bitstream data", __func__);
-	pm_runtime_resume_and_get(inst->dev->dev);
+	ret = pm_runtime_resume_and_get(inst->dev->dev);
+	if (ret < 0) {
+		struct vb2_queue *src_vq = v4l2_m2m_get_src_vq(m2m_ctx);
+		struct vb2_queue *dst_vq = v4l2_m2m_get_dst_vq(m2m_ctx);
+
+		dev_err(inst->dev->dev, "Failed to resume VPU: %d\n", ret);
+		set_instance_state(inst, VPU_INST_STATE_STOP);
+		vb2_queue_error(src_vq);
+		vb2_queue_error(dst_vq);
+		wave5_return_bufs(src_vq, VB2_BUF_STATE_ERROR);
+		wave5_return_bufs(dst_vq, VB2_BUF_STATE_ERROR);
+		v4l2_m2m_job_finish(inst->v4l2_m2m_dev, m2m_ctx);
+		return;
+	}
+
 	if (!inst->retry) {
 		ret = fill_ringbuffer(inst);
 		if (ret < 0) {
@@ -1818,7 +1858,11 @@ static void wave5_vpu_dec_job_abort(void *priv)
 	 * device must be resumed first; otherwise the register access faults
 	 * with an asynchronous SError.
 	 */
-	pm_runtime_resume_and_get(inst->dev->dev);
+	ret = pm_runtime_resume_and_get(inst->dev->dev);
+	if (ret < 0) {
+		dev_warn(inst->dev->dev, "Failed to resume VPU: %d\n", ret);
+		goto finish_job;
+	}
 
 	ret = wave5_vpu_dec_set_eos_on_firmware(inst);
 	if (ret)
@@ -1827,6 +1871,7 @@ static void wave5_vpu_dec_job_abort(void *priv)
 
 	pm_runtime_put_autosuspend(inst->dev->dev);
 
+finish_job:
 	v4l2_m2m_job_finish(inst->v4l2_m2m_dev, m2m_ctx);
 }
 
-- 
2.34.1

