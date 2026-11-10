Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273182;
	b=xqMG19ve2H8WA2CTe2qLrdwM5OQaBLZC6NSXIBMlEDYzRweDlkAQVwP2962t2HJyY/9X
	 qfPcFyFRvTkLuZl829QRRA/I7fTEsmZOI6chnr/Gz9i40GfhU1Wd42LEoOaLEhFKjQ2Cr
	 o2NcjEQ/NpTOc4clt+ktX3MSxPUIxf92q6DadmEv50N28P6YNyd2jsLGzXPoi565fSLNw
	 R1MrJ1Sjv9xgjcGRE/5qpRfnKSZ1nf5CP8PIBw77tL6qHRG0N8lkZah9Dy3dmG/LqR1Gv
	 cUwIP2DoanQqbBSOzCcipmOgTeutRCm+sTDUu2LkPLwbxnlHqiCfvaGl4Lq/Yfy1xoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273182;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=BQDWwUFPj4ntOJrWrHQRSsQlS3k6jxJsO3YFExOF8I0=;
	b=kQiMV+TTP8m2jOa8fa3yfs+ISXyk+dCxv8Yjarmz0+9c5lI8yvBNlRuT8oJPk9VnLrmS
	 ytCtT4ZZpEqnRNHKkzCTn+6T38uU2smz3pqdLEpXT6a2TpbwIjzUZE0TwNZ+eibE1ySR6
	 c02TAizhqciAvUwA9V5zFbLCcqYX14U6WSbWYC5bwfaNWC55xkQC0DzzITFo1iZ1IE1Tx
	 O9/Z26mEtLfVv0OKapxuNrgQlwW48uYh/cAepZm9jdUA4NVX+oRmtyTLKprrzTCOH1sef
	 T/BzHjre4/gO6+hw3+E15DcLPJbgmYCc0CFqe4TbtRK3OByoX+yl7yBg+hUpRA350DA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LjuoexPG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8AF606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LjuoexPG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD5961F0089F;
	Tue, 10 Nov 2026 01:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273181;
	bh=BQDWwUFPj4ntOJrWrHQRSsQlS3k6jxJsO3YFExOF8I0=;
	h=From:To:Cc:Subject:Date;
	b=LjuoexPGFY/9Zv5wSXOxP8LJoHi0MfmfqlpIRE7XvMQean+JbIr3jTnWmpBzOn/5U
	 g1X1aZQL8fjxxNMgjpZd6yO8tkEli8q1bps/rb61vUCeHaRxaYMY/fEZnZ0Rd09+IN
	 tam9h8YU/QAZi4oOYrWFAI6ClLd8+8To3dVB5POHOQFxJgwc8KhX9MSvne+gE3X/D1
	 EDAkyGgxvufkk5qszAGETQFi2rSU59ho+aBgppAGj06Lsj7g2DeYD5E4ox9WxjQHSV
	 nxJbt2DZY+ubM3rxLA1JHbFd+tVBNHhxpkmPtbjhO5ugjcBe3BOnhMDP2Lu0Fo5Mob
	 EC/e+3jucQ9Xg==
From: Sasha Levin <sashal@kernel.org>
To: cong.zhang@oss.qualcomm.com,
	jasowangio@gmail.com,
	stefanha@redhat.com,
	axboe@kernel.dk
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] virtio_blk: use synchronous quiesce in virtblk_freeze_priv()" failed to apply to 6.6-stable tree
Date: Mon,  9 Nov 2026 20:12:59 -0500
Message-ID: <20261109201259-failed-6.6-6c6dec7883f8@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 6c6dec7883f8eb10b326bc9d109a4990c885d949
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201259-failed-6.6-6c6dec7883f8@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 6c6dec7883f8eb10b326bc9d109a4990c885d949 Mon Sep 17 00:00:00 2001
From: Cong Zhang <cong.zhang@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 18:32:21 +0800
Subject: [PATCH] virtio_blk: use synchronous quiesce in virtblk_freeze_priv()

blk_mq_run_work_fn() can call blk_mq_sched_dispatch_requests() through
blk_mq_run_dispatch_ops(). The dispatcher checks QUEUE_FLAG_QUIESCED
while the flag is clear. It can then be preempted before it gets a
request. At that time, it has no queue usage reference, so
blk_mq_freeze_queue() does not wait for it.

virtblk_freeze_priv() then calls blk_mq_quiesce_queue_nowait() and
blk_mq_unfreeze_queue(). A new request can enter the queue. The old
dispatcher can run again, use its old flag check, get the new request,
and call virtio_queue_rq(). At the same time, virtblk_freeze_priv() can
reset the device, delete the virtqueues, and free vblk->vqs. The old
dispatcher can then use a deleted virtqueue or a NULL vblk->vqs, and the
kernel can crash.

Fix this by using blk_mq_quiesce_queue(), which waits for dispatch code
that was already running. Keep the existing freeze and unfreeze order.
The queue remains quiesced until virtblk_restore_priv() calls
blk_mq_unquiesce_queue().

Fixes: 7678abee0867 ("virtio-blk: don't keep queue frozen during system suspend")
Cc: stable@vger.kernel.org
Acked-by: Jason Wang <jasowangio@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Cong Zhang <cong.zhang@oss.qualcomm.com>
Link: https://lore.kernel.org/20260911-virtblk_sync_quiesce-v1-1-a883f8f31258@oss.qualcomm.com
Link: https://patch.msgid.link/20261103-virtblk_sync_quiesce-v3-1-f40233f9bdd9@oss.qualcomm.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/virtio_blk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index c8bfbf8435ac7..10ba8b0b863b8 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1596,7 +1596,7 @@ static int virtblk_freeze_priv(struct virtio_device *vdev)
 
 	/* Ensure no requests in virtqueues before deleting vqs. */
 	memflags = blk_mq_freeze_queue(q);
-	blk_mq_quiesce_queue_nowait(q);
+	blk_mq_quiesce_queue(q);
 	blk_mq_unfreeze_queue(q, memflags);
 
 	/* Ensure we don't receive any more interrupts */
-- 
2.53.0




