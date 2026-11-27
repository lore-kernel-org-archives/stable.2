Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795811200;
	b=mWIS+l1h9FEIUH2Ojf/i0i2uf50CbKbe/zridtt9dpgM8hUYnVmfFMs9pSu/d34WzVUI
	 HBsZ0+FWaLIr8Ph8X4NLltc0U4xivvitLndbLb5cbvIyUnnn2qCvIYWhT3/QdDiuFlPD1
	 +YZVzD6lZrpLpBjtfXEWhwXrAz3zo0rcrGDB/O/LEjwB5uTKrrYJqGqnhI/6hLh65QZev
	 5Tmd836DBKMFtJ2FCNxQiV3UDvXpCqhsxsC/bn6HrJDrIau5c+eLH/fsrjjCuoj975tiU
	 7A4tYWV1+aIYUUTcWU50Aa4Nb2Ilz5oEFBo1Z2B1PsYZejpTkaZsN3lW96DWETrPMIw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795811200;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=s97kJpO1s7I+hEd7fxdKinbUIRsweSi7QikdvI0u8u8=;
	b=1sRWhM7ZrtzdfpuFjB6qDRrpf6w8PCypx6E/cnMjmQPIC9FO0lzxkeBkthwPABecUePF
	 uGkO7GcRjILnw7rHjZTytNrSogKIiERbAyV6mPi0wZSIWzRnsTo/X7+GJmb/AGg1fshQc
	 d4ha1aqI4y6cged1E5/BLY72M1x5maH8aJp2Mm0I/kUjMTSmDJpWUXWFzi+tnwpHvYdHL
	 kGzuabdXEZK12WDOxG2H9jE0o69UkJ54Lk/8JYh724nF0jP9rq54aGQXC2FV0AjQKShbU
	 SQAotR2GFtAm2z8QxyCQiTdtLiG35FhIoPR3CNI18Q5TairwvhhVB1pM3aD4sCpgigw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aV4snfyj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D26606A33F;
	Fri, 27 Nov 2026 20:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aV4snfyj
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795811200;
	b=um+zglEH1brSQolj/OHLW1ZlxqY4JOlbitZ1X0SMeq4aE6nR9QtB9eRgVu7A4kZszs8G
	 yg/QjD3LVDZ9bWrtwRTRJW0fBdOWjZhbQJMt7qJsB7AxM8lFtj71HsfKPXOdkbez4UUUg
	 8zpzKlLyMa0Zb7XGLYataaKdvm6B6rp6W2Fv7xhI1GgdJLAV8as/N7RsN2//oRo077nMH
	 vq1bvn4UbetCAkBI3X1LZCnxbOKV6a8HWxMj1Bo6KaO6HWi8W3mOxPQ7fzr2da4u6yVjq
	 hw6wxFypGAALVkCx1Q2WyOrd9HiP9elH8Nxe/ZjyBL2MUli7TbraKBLRXNIXuOIybAQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795811200;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=s97kJpO1s7I+hEd7fxdKinbUIRsweSi7QikdvI0u8u8=;
	b=MYzR+a5UrdSkJ20NoM/kc5clpEuSKJY9r/HzWgpYh1eDHdtz75fWS2P//sc5CkdKv5ri
	 K3pHJrc4n3XXsZOJkIGdaDpo+iVI78HWdzoJlSGiPaAiZvKtsnB1MAh5mTiuC30l1baOh
	 gpuxUQXJeuOm2l0Mi0fOt3KGlqc/I329f63GdptE5rifW6ozj8U3ymR+zkQZg7RgMQbxn
	 3kUETQfaNZ2x+AXV7e2Njq9SppbOmdYFSiwA4tH9CNXIQd4Ro1ahELAL5O2MImcNBM8/N
	 Wdek7EGe77gepqcHV+XhZr884svR9H5YJppfvGJuaXaQP+Mm3EAT0SK3hOB6u0rjQdg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id F2F2E1F00899;
	Fri, 27 Nov 2026 20:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795811200;
	bh=s97kJpO1s7I+hEd7fxdKinbUIRsweSi7QikdvI0u8u8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=aV4snfyjFEhnMjqBOT/lEYXekoIII0+cJCJaNgl/7fUZGzr/lxxhMt8RoYgbUt8/M
	 eMySBbecxYEqOn+Elj9qIhdTqh5TOljfSU67IBR8pBx96p0OiRwtfD7ooDfqQZt42F
	 QsN1YyY4qWgO5hZV5XKvSbsVHeT+SlAJw2SKjA+ZdqAg2WipzElPPG8QP6KBjmelHG
	 MY/6iiJDjT/Hc24iNJxL54I/2dgZlzCuTRxJSHpLKrO6qnmsix4l8s2MQMbYvxcOly
	 ZRHdi7vatk09MC6x+EMXp8CeN1qWHNuXerNbZLgyFS1jgPYdkwHPCFYlOT2MTWg1pl
	 3dnSLxQESweVg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 847CC4DDAD;
	Fri, 27 Nov 2026 20:26:24 +0000 (UTC)
From: Robert Ijtsma via B4 Relay <devnull+robertijtsma.gmail.com@kernel.org>
Date: Fri, 27 Nov 2026 21:26:26 +0100
Subject: [PATCH 3/5] media: qcom: camss: vfe: call vb2_buffer_done()
 outside output_lock
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261127-camss-titan17x-fixes-v1-3-541ab39e5889@gmail.com>
References: <20261127-camss-titan17x-fixes-v1-0-541ab39e5889@gmail.com>
In-Reply-To: <20261127-camss-titan17x-fixes-v1-0-541ab39e5889@gmail.com>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 Loic Poulain <loic.poulain@oss.qualcomm.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Robert Foss <rfoss@kernel.org>, 
 Hans Verkuil <hverkuil@kernel.org>, 
 Andrey Konovalov <andrey.konovalov@linaro.org>, 
 Atanas Filipov <atanas.filipov@oss.qualcomm.com>, 
 Milen Mitkov <quic_mmitkov@quicinc.com>, 
 Gjorgji Rosikopulos <quic_grosikop@quicinc.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Robert Ijtsma <robertijtsma@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795811183; l=3255;
 i=robertijtsma@gmail.com; s=20261122; h=from:subject:message-id;
 bh=JHsklOJs0XN6Ha8eYoDzxlDGyKqFWMC+hYh/5EQBjw4=;
 b=gB/RF/E6kqv9LkHBwQGonuPUaGR2NVRrWtSedwy41llPcg9fXGbtPTVm5S1S/1p9s5LUyDyjz
 wusERQloLuvA7ypweyNasxf2cOC1Stt7PfURdPkcFmiZLhO56/sgU7F
X-Developer-Key: i=robertijtsma@gmail.com; a=ed25519;
 pk=qiDyKVqFicxFIR5sB5m+p9SWPKL2/+mMoiQnUx0C9P0=
X-Endpoint-Received: by B4 Relay for robertijtsma@gmail.com/20261122 with
 auth_id=1604
X-Original-From: Robert Ijtsma <robertijtsma@gmail.com>
Reply-To: robertijtsma@gmail.com
Content-Transfer-Encoding: 7bit

From: Robert Ijtsma <robertijtsma@gmail.com>

vfe_flush_buffers() currently invokes vb2_buffer_done() while holding
vfe->output_lock, unlike vfe_buf_done(). Returning buffers to vb2 can
re-enter driver callbacks or run user hooks under an IRQ-safe spinlock.

Splice pending_bufs into a local list, detach active buffer pointers and
reset gen2.active_num under output_lock, and complete the buffers after
releasing output_lock. Also drop the now-unused vfe_buf_flush_pending()
helper.

Fixes: ff11faad8a9e ("media: qcom: camss: vfe: Clear active buffer pointers after flushing")
Cc: stable@vger.kernel.org
Signed-off-by: Robert Ijtsma <robertijtsma@gmail.com>
---
 drivers/media/platform/qcom/camss/camss-vfe.c | 56 +++++++++++++--------------
 1 file changed, 26 insertions(+), 30 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index b5a8196c9145163dfa3ee1af549a4684901e2fa7..b01c7c919de459bdb6581dba81c15a176e551208 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -757,23 +757,6 @@ void vfe_buf_add_pending(struct vfe_output *output,
 	list_add_tail(&buffer->queue, &output->pending_bufs);
 }
 
-/*
- * vfe_buf_flush_pending - Flush all pending buffers.
- * @output: VFE output
- * @state: vb2 buffer state
- */
-static void vfe_buf_flush_pending(struct vfe_output *output,
-				  enum vb2_buffer_state state)
-{
-	struct camss_buffer *buf;
-	struct camss_buffer *t;
-
-	list_for_each_entry_safe(buf, t, &output->pending_bufs, queue) {
-		vb2_buffer_done(&buf->vb.vb2_buf, state);
-		list_del(&buf->queue);
-	}
-}
-
 int vfe_put_output(struct vfe_line *line)
 {
 	struct vfe_device *vfe = to_vfe(line);
@@ -1215,31 +1198,44 @@ int vfe_flush_buffers(struct camss_video *vid,
 	struct vfe_line *line = container_of(vid, struct vfe_line, video_out);
 	struct vfe_device *vfe = to_vfe(line);
 	struct vfe_output *output;
+	struct camss_buffer *buf, *t;
+	struct camss_buffer *b0, *b1, *blast;
+	LIST_HEAD(local_pending);
 	unsigned long flags;
 
 	output = &line->output;
 
 	spin_lock_irqsave(&vfe->output_lock, flags);
 
-	vfe_buf_flush_pending(output, state);
+	list_splice_init(&output->pending_bufs, &local_pending);
 
-	if (output->buf[0]) {
-		vb2_buffer_done(&output->buf[0]->vb.vb2_buf, state);
-		output->buf[0] = NULL;
-	}
+	b0 = output->buf[0];
+	output->buf[0] = NULL;
 
-	if (output->buf[1]) {
-		vb2_buffer_done(&output->buf[1]->vb.vb2_buf, state);
-		output->buf[1] = NULL;
-	}
+	b1 = output->buf[1];
+	output->buf[1] = NULL;
 
-	if (output->last_buffer) {
-		vb2_buffer_done(&output->last_buffer->vb.vb2_buf, state);
-		output->last_buffer = NULL;
-	}
+	blast = output->last_buffer;
+	output->last_buffer = NULL;
+
+	output->gen2.active_num = 0;
 
 	spin_unlock_irqrestore(&vfe->output_lock, flags);
 
+	list_for_each_entry_safe(buf, t, &local_pending, queue) {
+		list_del(&buf->queue);
+		vb2_buffer_done(&buf->vb.vb2_buf, state);
+	}
+
+	if (b0)
+		vb2_buffer_done(&b0->vb.vb2_buf, state);
+
+	if (b1)
+		vb2_buffer_done(&b1->vb.vb2_buf, state);
+
+	if (blast)
+		vb2_buffer_done(&blast->vb.vb2_buf, state);
+
 	return 0;
 }
 

-- 
2.47.3


