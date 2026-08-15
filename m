Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C974195A3;
	Sat, 15 Aug 2026 14:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786805801; cv=none; b=h+JiO/VtMNRs3fJuKQ5kyBTXneGaYEsduxiLvNaoatC5GCCjyMsZlRD0LrhsufFRtQ5tVCro2wrNQvmxRI2lOD+8f8AkjEnFWthroC/DE+cLn9TkBW2XUIIjA8f41jxBVPTdP1/rs//jjsM2JPZtgGX4FrN6opYvUmYDSG1V7bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786805801; c=relaxed/simple;
	bh=Jr8is1Cti6P50cWYYbyd906COEhy8VmjZtYEHUFgX5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dPjhdFlIJ9GSibvRVSl3GWHfOTGw2Jw+8a/wTEd26gzeY1LAADPTRVTnJtywLSNiVHY+a2nsUx+pfUtGXNkc27B7pUdk0K1nJosB/eh7qj1HXWxCYZ6wduuxOHBKVcVJHm3MZiUiCmRqoUWyC0B/ACPCYDKFTBcfP+XdfLL8/5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TucNt55R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TucNt55R"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C4280C2BCF6;
	Sat, 15 Aug 2026 14:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786805800;
	bh=Jr8is1Cti6P50cWYYbyd906COEhy8VmjZtYEHUFgX5I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TucNt55Rwd3xg40KzTHHgyQlcNGDkAG3Z8r3ErecVloGJL7p5VSXp4XHN1bo2CRy0
	 Drdhui+w+/Xp29XbTqFCwQZf7B66ktEaq14+8VJ4r84/sP6iA1zxv/LA+XAJuB2HYU
	 TWgyJ3OiSziW4j/l2nIoYQMYO8hoviiQuKXYH0n47/jLxjS1/IxfkpPgvkstS4zYsN
	 nnDsyocCxCF8etwZgqmTBp4HwQuQST3ufD9JIxCu4dwJ5CqDc/3HoE6rCixOsXMnWu
	 uhFpMM+PNMw+BqQ86YsH1pB85HYbZe5Z8Xwzvht3RASO/f6xn1QYlomAF3MMm/VWTK
	 ysQQ6kk2dPwCQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A367EC5DF67;
	Sat, 15 Aug 2026 14:56:40 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Sat, 15 Aug 2026 22:56:35 +0800
Subject: [PATCH 1/4] media: v4l2-mem2mem: serialize REMOVE_BUFS with job
 execution
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260815-vicodec-fixes-v1-1-12101572eba7@outlook.com>
References: <20260815-vicodec-fixes-v1-0-12101572eba7@outlook.com>
In-Reply-To: <20260815-vicodec-fixes-v1-0-12101572eba7@outlook.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@kernel.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Dafna Hirschfeld <dafna3@gmail.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
 Junrui Luo <moonafterrain@outlook.com>, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5309;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=6krpIkSHmwa+ABnniq+DXrpDxKlpmMs7gAcsjsK/D8g=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrIY6tVVRuvkbzB4+ivjOJrHObdPfyF1+2tvX3Y1lq
 T5Qp2TVs7ajlIVBjItBVkyR5XjBpW8Wvlt0t/hsSYaZw8oEMoSBi1MAJnJwBcM/rZ1hWpt75+wr
 SvZzuKb7sL5b0W6t21aRN5NTWx+6njV+xfC/8qRIYFB9seOVRd+P70lYcvt3j83ak9ss853yvr+
 VU5FhBwDiDE13
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
Reply-To: moonafterrain@outlook.com

From: Junrui Luo <moonafterrain@outlook.com>

VIDIOC_REMOVE_BUFS can free a buffer that an in-flight job is still
decoding from, giving a use-after-free of the reference frame.

For stateless decoders a reference frame sits in VB2_BUF_STATE_DEQUEUED,
which is exactly what REMOVE_BUFS frees: userspace dequeues the decoded
capture buffer and names its timestamp as the reference for the next
frame. device_run() resolves that timestamp with vb2_find_buffer() and
keeps the vb2_plane_vaddr() result for the whole decode without holding a
reference. Nothing serializes the two paths: REMOVE_BUFS runs under
m2m_ctx->q_lock and q->mmap_lock, while the job path holds neither and
reaches device_run() from schedule_work() outside any ioctl lock.

Hold the instance off the job queue and wait for its in-flight job before
removing the buffers. The pause is per-instance rather than device-wide
because the buffers belong to that instance's own queues and the caller
is inside one of its own ioctls, so the context cannot be released while
the wait is in progress. A losing race degrades to vb2_find_buffer()
returning NULL and the job failing with -EINVAL, which is already
handled.

Reproduced on vicodec under KASAN:

  BUG: KASAN: vmalloc-out-of-bounds in add_deltas+0x450/0xcc0
  Read of size 1 at addr ffffc90000a77bc0 by task trigger_bin/71
  Call Trace:
   add_deltas+0x450/0xcc0
   decode_plane+0x1799/0x34b0
   fwht_decode_frame+0x173/0x620
   v4l2_fwht_decode+0x595/0xea0
   device_run+0x6bb/0x1850
   media_request_ioctl+0x2fb/0x450
   __se_sys_ioctl+0xb1/0x110
   do_syscall_64+0x12c/0x360

Fixes: 2f2419502f69 ("media: v4l2: Add mem2mem helpers for REMOVE_BUFS ioctl")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/media/v4l2-core/v4l2-mem2mem.c | 60 +++++++++++++++++++++++++++++++---
 1 file changed, 56 insertions(+), 4 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
index a65cbb124cfe..10a0a74f782c 100644
--- a/drivers/media/v4l2-core/v4l2-mem2mem.c
+++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
@@ -41,6 +41,8 @@ module_param(debug, bool, 0644);
 #define TRANS_RUNNING		(1 << 1)
 /* Instance is currently aborting */
 #define TRANS_ABORT		(1 << 2)
+/* Instance must not be scheduled while its buffers are being removed */
+#define TRANS_PAUSED		(1 << 3)
 
 
 /* The job queue is not running new jobs */
@@ -309,9 +311,9 @@ static void __v4l2_m2m_try_queue(struct v4l2_m2m_dev *m2m_dev,
 
 	spin_lock_irqsave(&m2m_dev->job_spinlock, flags_job);
 
-	/* If the context is aborted then don't schedule it */
-	if (m2m_ctx->job_flags & TRANS_ABORT) {
-		dprintk("Aborted context\n");
+	/* If the context is aborted or paused then don't schedule it */
+	if (m2m_ctx->job_flags & (TRANS_ABORT | TRANS_PAUSED)) {
+		dprintk("Aborted or paused context\n");
 		goto job_unlock;
 	}
 
@@ -1388,16 +1390,66 @@ int v4l2_m2m_ioctl_create_bufs(struct file *file, void *priv,
 }
 EXPORT_SYMBOL_GPL(v4l2_m2m_ioctl_create_bufs);
 
+/*
+ * Keep @m2m_ctx off the job queue and wait for its in-flight job, if any.
+ *
+ * Only this instance is held back: the buffers about to be removed belong to
+ * its own queues, so no other instance can be reading them. Waiting on this
+ * instance is also what makes the wait safe -- the caller is inside one of its
+ * ioctls, so v4l2_m2m_ctx_release() cannot free it here.
+ */
+static void v4l2_m2m_pause_ctx(struct v4l2_m2m_ctx *m2m_ctx)
+{
+	struct v4l2_m2m_dev *m2m_dev = m2m_ctx->m2m_dev;
+	unsigned long flags;
+
+	spin_lock_irqsave(&m2m_dev->job_spinlock, flags);
+	m2m_ctx->job_flags |= TRANS_PAUSED;
+	if (m2m_ctx->job_flags & TRANS_RUNNING) {
+		spin_unlock_irqrestore(&m2m_dev->job_spinlock, flags);
+		wait_event(m2m_ctx->finished,
+			   !(m2m_ctx->job_flags & TRANS_RUNNING));
+		return;
+	}
+	if (m2m_ctx->job_flags & TRANS_QUEUED) {
+		list_del(&m2m_ctx->queue);
+		m2m_ctx->job_flags &= ~TRANS_QUEUED;
+	}
+	spin_unlock_irqrestore(&m2m_dev->job_spinlock, flags);
+}
+
+static void v4l2_m2m_resume_ctx(struct v4l2_m2m_ctx *m2m_ctx)
+{
+	struct v4l2_m2m_dev *m2m_dev = m2m_ctx->m2m_dev;
+	unsigned long flags;
+
+	spin_lock_irqsave(&m2m_dev->job_spinlock, flags);
+	m2m_ctx->job_flags &= ~TRANS_PAUSED;
+	spin_unlock_irqrestore(&m2m_dev->job_spinlock, flags);
+
+	v4l2_m2m_try_schedule(m2m_ctx);
+}
+
 int v4l2_m2m_ioctl_remove_bufs(struct file *file, void *priv,
 			       struct v4l2_remove_buffers *remove)
 {
 	struct v4l2_fh *fh = file_to_v4l2_fh(file);
 	struct vb2_queue *q = v4l2_m2m_get_vq(fh->m2m_ctx, remove->type);
+	int ret;
 
 	if (q->type != remove->type)
 		return -EINVAL;
 
-	return vb2_core_remove_bufs(q, remove->index, remove->count);
+	/*
+	 * Removal is only allowed for DEQUEUED buffers, but that is exactly
+	 * the state a stateless decoder's reference frame is in while a job
+	 * resolves it by timestamp and reads its memory.
+	 */
+	v4l2_m2m_pause_ctx(fh->m2m_ctx);
+	ret = vb2_core_remove_bufs(q, remove->index, remove->count);
+	v4l2_m2m_resume_ctx(fh->m2m_ctx);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(v4l2_m2m_ioctl_remove_bufs);
 

-- 
2.51.2


