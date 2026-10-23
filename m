Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792747705;
	b=Se03+zgQ1e/uNNhp5afmTg9DncCVXufdhlzQRHxvd5kYuffOVTYva8vg+d/FHpqeQiYX
	 ejTlld02D55V16bqJsVDZMjDf5KlrBvnJzvbopRgwgddMKYIGqv8ObE+sSjxiIKEA+lPZ
	 FO0Nm+6BZ5N/6BHmT4djviulujt51mkMPmPl7T5ORune8ZHgqODi9ROrUF6QjwQQvKl5f
	 X+aqlMySeVv3DDqiZoWEW0bu3LRvIRqYaDqFnVuU58psKYyBffHbktxtKwPab+1jQVHIV
	 xOJGYi9qWe4D/ck3jCNUvHUkzm08OtUIgWZcsp3JMhbjC5RGlc2W3ux8hgklOgeKL2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792747705;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=VUwVNBdTmyElFd5++SFMk99jQ0/AW6Li9MfUrUHf72o=;
	b=snv0695ZWHMMfWvlsjg5XJAYi/FRziVYF89WhcfSbFkBI1hai8uHGPInleIAhSZJxDgk
	 XxqkieCq8YJ6LcLuG1YXad67jhm7gAv+FYV+r6VCj41n/BWTS2FXYYtLBZcCU8iqXeQmK
	 U+SmBlCa2GQ2/vKhsVD5lFWP6z3b8qY2yn7IfPLw1YxMXe4dTQQSqumDHFYsYDoaeJ+5E
	 W6jdqMt8PnlJ/6AOmBUOXZHJ8fApX3AZPrG6ZBpUNdOGoMZc9YrxhJXuF4fAPaPyCUee6
	 xnHMgMc9G6uJ1Jqah5sgEk8rEvD0nEJEMV0lBqGqhAJgz07Qq/V9BbJ9EeH7DujppNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=nTawbqEI;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A054606A31D;
	Fri, 23 Oct 2026 09:28:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A054606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=nTawbqEI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=VU
	wVNBdTmyElFd5++SFMk99jQ0/AW6Li9MfUrUHf72o=; b=nTawbqEIqvcfchs0g6
	po/XFWh1PVVRUjbsyKfcz6Gh12ZkCRHzVIsE3kWYOXQSDW0MC7G5eDM2S3vVEXr5
	u3NY6eyZ1E4UQl0itM5P/u0gSwNaBjMrPZeP6JkOTG/JVXWpXq/+J3bZSog0ZTaa
	5qeLEdZTv3EvnihPCJS0jaNV0=
Received: from pc.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgD3KHOkKNtqXHGqBQ--.1363S5;
	Fri, 23 Oct 2026 17:28:09 +0800 (CST)
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
Subject: [PATCH v4 3/4] media: wave5: handle encoder runtime resume failures
Date: Fri, 23 Oct 2026 17:28:02 +0800
Message-Id: <20261023092804.673980-4-yaojiale02@163.com>
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
X-CM-TRANSID:PCgvCgD3KHOkKNtqXHGqBQ--.1363S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF4UKF45uw1kZr4UWw4Durg_yoWrGrWrpr
	yvg3ZIkrWUtw18Xw4xJr4xZF90kws3CrWxCF93Gas7Ary3Jr1qvr12yF1jvF1kCrWkJa98
	Cr4DZ3y7CF42vrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jDKsUUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8AnFAGrbKKlQwwAA3f

The encoder callbacks ignore failures from pm_runtime_resume_and_get()
and continue issuing firmware commands. Runtime resume can fail while
enabling the VPU clocks, leaving the registers inaccessible. The
callbacks can then drop a runtime PM reference that was not acquired.

Runtime PM retains a resume error, so simply finishing the current job
leaves PIC_RUN runnable and causes the mem2mem scheduler to retry the
same failing job. On a resume failure, stop the instance, mark both
queues in error, return their queued buffers as errors, and finish the
job. Also stop the instance in stop_streaming() before attempting the
runtime resume, since the state transition only touches software state.
Propagate the error from start_streaming() and preserve buffer cleanup
without accessing the hardware or issuing an unmatched put.

Fixes: 2092b3833487 ("media: chips-media: wave5: Support runtime suspend/resume")
Cc: stable@vger.kernel.org
Reviewed-by: Jackson Lee <jackson.lee@chipsnmedia.com>
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 .../chips-media/wave5/wave5-vpu-enc.c         | 35 ++++++++++++++++---
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
index f9fcdf4c22..3463b7d7fb 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
@@ -1351,7 +1351,12 @@ static int wave5_vpu_enc_start_streaming(struct vb2_queue *q, unsigned int count
 	struct v4l2_m2m_ctx *m2m_ctx = inst->v4l2_fh.m2m_ctx;
 	int ret = 0;
 
-	pm_runtime_resume_and_get(inst->dev->dev);
+	ret = pm_runtime_resume_and_get(inst->dev->dev);
+	if (ret < 0) {
+		wave5_return_bufs(q, VB2_BUF_STATE_QUEUED);
+		return ret;
+	}
+
 	v4l2_m2m_update_start_streaming_state(m2m_ctx, q);
 
 	if (inst->state == VPU_INST_STATE_NONE && q->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
@@ -1451,6 +1456,7 @@ static void wave5_vpu_enc_stop_streaming(struct vb2_queue *q)
 {
 	struct vpu_instance *inst = vb2_get_drv_priv(q);
 	bool check_cmd = true;
+	int ret;
 
 	/*
 	 * Note that we don't need m2m_ctx->next_buf_last for this driver, so we
@@ -1458,11 +1464,18 @@ static void wave5_vpu_enc_stop_streaming(struct vb2_queue *q)
 	 */
 
 	dev_dbg(inst->dev->dev, "%s: type: %u\n", __func__, q->type);
-	pm_runtime_resume_and_get(inst->dev->dev);
-
 	if (wave5_vpu_both_queues_are_streaming(inst))
 		switch_state(inst, VPU_INST_STATE_STOP);
 
+	ret = pm_runtime_resume_and_get(inst->dev->dev);
+	if (ret < 0) {
+		if (q->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
+			streamoff_output(inst, q);
+		else
+			streamoff_capture(inst, q);
+		return;
+	}
+
 	while (check_cmd) {
 		struct queue_status_info q_status;
 		struct enc_output_info enc_output_info;
@@ -1526,7 +1539,21 @@ static void wave5_vpu_enc_device_run(void *priv)
 	u32 fail_res = 0;
 	int ret = 0;
 
-	pm_runtime_resume_and_get(inst->dev->dev);
+	ret = pm_runtime_resume_and_get(inst->dev->dev);
+	if (ret < 0) {
+		struct vb2_queue *src_vq = v4l2_m2m_get_src_vq(m2m_ctx);
+		struct vb2_queue *dst_vq = v4l2_m2m_get_dst_vq(m2m_ctx);
+
+		dev_err(inst->dev->dev, "Failed to resume VPU: %d\n", ret);
+		switch_state(inst, VPU_INST_STATE_STOP);
+		vb2_queue_error(src_vq);
+		vb2_queue_error(dst_vq);
+		wave5_return_bufs(src_vq, VB2_BUF_STATE_ERROR);
+		wave5_return_bufs(dst_vq, VB2_BUF_STATE_ERROR);
+		v4l2_m2m_job_finish(inst->v4l2_m2m_dev, m2m_ctx);
+		return;
+	}
+
 	switch (inst->state) {
 	case VPU_INST_STATE_PIC_RUN:
 		ret = start_encode(inst, &fail_res);
-- 
2.34.1

