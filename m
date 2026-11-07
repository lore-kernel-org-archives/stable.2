Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049050;
	b=lKRqcPPSnxJYdvMZN/xZshmDppfh+CKhYxOFyKo3jpY/XLrzm2zLB9lQa9QPiWmlyZN/
	 vLf95RhPdtg3Bn3XhDU4CPCw/kKZzSIcukWwc8Uov2G/9K3cZZ9N/ZBC/yN76gD6RSqQI
	 awxT6dGtB7SCVgFCLe6eKWqLH98WYkFHXGoACbHY47FI2x8r3dFxPNFXj0TglE8j61Ay3
	 vF1j0RAIXjP3jf9T+qWmCHSAv+qaRozdmf+roP8NPxbVfrRuYmH1MIiyism63cHYQSjxo
	 R0PMxrTD1+MU7/Pp2Nzh5H3wHlBDspuICnVN2cOpybCPhSkP0eV4sfGAUB7Piizmgjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049050;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=tUwyKQ9csMctPg29ixa6IZ8i+at6z0Dvfhi9imAhf4k=;
	b=OjwaD4E7YPE/1qZnC/86A9wxYGsmx8gveybk76eOzAZbNqHkWKRHrZt0rG3lwOJ2v2Gc
	 haBYhSUIBY3Wq1fXcc89LVd5gEKqLIIhjbnttbVev4NiG9aailCao7jb+jPuBQWxobk0I
	 OmD18EGTUda+u4OxoewLVz4TmYTbnAGL8ZDwPOQ9ACF5CgERclSYrEPCSYc6aNifsElnc
	 kIJfldlTAA/2MCkPv+2x26vJxyaShFWogbIOmzul7JqMaGQZ5XYRJ6Gs4aLi8CzDDoBq9
	 IMH4s+fYhHcvfc2SoVA6COpgaK3HOx3yeB0ja/UyX8q/jkSokUVqaJ1bSwy5Rdc+RhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cHsIYTXG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6838B606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cHsIYTXG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE57E1F0089F;
	Sat,  7 Nov 2026 10:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049050;
	bh=tUwyKQ9csMctPg29ixa6IZ8i+at6z0Dvfhi9imAhf4k=;
	h=From:To:Cc:Subject:Date;
	b=cHsIYTXGHVN2UIsTD5FwNTZ0kG9NPGtkdez01v2VRr/iZHPANP7lHAR/FyejCAlnP
	 MZGE/m/+6TSUtbhZiCTooteJ34/CYPUoh+02+6ont0ULzY6lTBlqP5iQg4zq8F0ZUF
	 c7JQvHRWB6dO0oPaUM7LLmUIa5bO/NP71Ju8E+oQ4fFR0Tf/uHq69Q3VlpxsxTBWu3
	 R0Tp4m8MsqVf2vhAZ0RWKb8uVW5glwM3z4PRWQ5hQd7WL1NDEQvi1wzi6Zdpt0sa6T
	 h3Mw9bWees3hP7QpMDFNBJD5/9gVUOg4uCws+ieG7RSJjr4Lcwc4/w8hS2bIypo4lS
	 PKCsxLhOFzkOg==
From: Sasha Levin <sashal@kernel.org>
To: fanwu01@zju.edu.cn,
	ming.qian@oss.nxp.com,
	frank.li@nxp.com,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: imx-jpeg: finish the job on device_run() error paths" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 05:57:28 -0500
Message-ID: <20261107055728-failed-5.15-30b35fd2b999@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 30b35fd2b999e1b8c26f8191d974d20c8848d2d6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055728-failed-5.15-30b35fd2b999@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 30b35fd2b999e1b8c26f8191d974d20c8848d2d6 Mon Sep 17 00:00:00 2001
From: Fan Wu <fanwu01@zju.edu.cn>
Date: Wed, 24 Jun 2026 00:32:08 +0000
Subject: [PATCH] media: imx-jpeg: finish the job on device_run() error paths

mxc_jpeg_device_run() returns early through a shared "end" label on several
error paths (no free slot, mxc_jpeg_alloc_slot_data() failure, or missing
buffers or queue data), and none of them calls v4l2_m2m_job_finish().
Since the delayed work is queued only after the hardware is started, those
paths neither finish the job directly nor queue timeout work that could
finish it later. The job is left with TRANS_RUNNING set, so the
wait_event() in v4l2_m2m_cancel_job() (reached from v4l2_m2m_ctx_release()
at close) waits indefinitely and the close hangs.

mxc_jpeg_alloc_slot_data() uses dma_alloc_coherent(), so the failure path
is reachable under memory pressure.

Return the src/dst buffers with VB2_BUF_STATE_ERROR and call
v4l2_m2m_job_finish() on those paths: paths that have buffers use a
"buf_finish" label; the no-buffer path uses "job_finish" directly. This
mirrors the existing jpeg_parse_error path.

This bug was found by static analysis.

Fixes: 2db16c6ed72c ("media: imx-jpeg: Add V4L2 driver for i.MX8 JPEG Encoder/Decoder")
Cc: stable@vger.kernel.org
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Reviewed-by: Ming Qian <ming.qian@oss.nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
---
 .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 21 +++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index ea2fad5dd646d..e170859354352 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -1590,15 +1590,15 @@ static void mxc_jpeg_device_run(void *priv)
 	dst_buf = v4l2_m2m_next_dst_buf(ctx->fh.m2m_ctx);
 	if (!src_buf || !dst_buf) {
 		dev_err(dev, "Null src or dst buf\n");
-		goto end;
+		goto job_finish;
 	}
 
 	q_data_cap = mxc_jpeg_get_q_data(ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE);
 	if (!q_data_cap)
-		goto end;
+		goto buf_finish;
 	q_data_out = mxc_jpeg_get_q_data(ctx, V4L2_BUF_TYPE_VIDEO_OUTPUT);
 	if (!q_data_out)
-		goto end;
+		goto buf_finish;
 	src_buf->sequence = q_data_out->sequence++;
 	dst_buf->sequence = q_data_cap->sequence++;
 
@@ -1636,11 +1636,11 @@ static void mxc_jpeg_device_run(void *priv)
 	ctx->slot = mxc_get_free_slot(&jpeg->slot_data);
 	if (ctx->slot < 0) {
 		dev_err(dev, "No more free slots\n");
-		goto end;
+		goto buf_finish;
 	}
 	if (!mxc_jpeg_alloc_slot_data(jpeg)) {
 		dev_err(dev, "Cannot allocate slot data\n");
-		goto end;
+		goto buf_finish;
 	}
 
 	mxc_jpeg_enable_slot(reg, ctx->slot);
@@ -1660,8 +1660,17 @@ static void mxc_jpeg_device_run(void *priv)
 		mxc_jpeg_dec_mode_go(dev, reg);
 	}
 	schedule_delayed_work(&ctx->task_timer, msecs_to_jiffies(hw_timeout));
-end:
+
 	spin_unlock_irqrestore(&ctx->mxc_jpeg->hw_lock, flags);
+	return;
+buf_finish:
+	v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
+	v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
+	v4l2_m2m_buf_done(src_buf, VB2_BUF_STATE_ERROR);
+	v4l2_m2m_buf_done(dst_buf, VB2_BUF_STATE_ERROR);
+job_finish:
+	spin_unlock_irqrestore(&ctx->mxc_jpeg->hw_lock, flags);
+	v4l2_m2m_job_finish(jpeg->m2m_dev, ctx->fh.m2m_ctx);
 }
 
 static int mxc_jpeg_decoder_cmd(struct file *file, void *priv,
-- 
2.53.0




