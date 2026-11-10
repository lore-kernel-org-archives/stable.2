Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272915;
	b=SbZeXtrZf1706ue3tSrMhoQ+s20PR5hxOoLYlXWLY8eW68O4jPb8Su6VWML6oYAmE5Ji
	 T+gI7jdeQ3L+4iFHVnhTCK4WPQiNNu3yb0+SIOl3b//8qwidbCcd1PlVF2sOCUaxHBcbe
	 IRvMEWR//u1beik01RzbgGpAzDgLRnhYcpxItIvoz1nVaA7tGChgJGCaRwfdGfoZo1xVZ
	 5QW0lTdwl10lp/37Hn/qzo7K8M6SCTh+RR7trJQatp3uxcugatCMIMRugXpWqKenbAdCq
	 hiSBs3LnWagPbScAfdO7oah+BtzGf5d+v3LNbJSGW7dkfomx893vU2VWyB2VluVAdbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272915;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=qa8Wj29FZ3Q12gaKxTYYOry6zyVJCnFUG6kwARgxyxA=;
	b=yP2DJI9zgXbuhpKWMPAKayrmes8q/HnXu0V8a/CB8V/aMGZFStqiC3I1aURAZl5FqQJ/
	 hLDu9u6IyLt3ji++68aA+L5CC36qaE+uvjsoiDgaRqLrD1wyfnPGyw5LZEOsBm6guoVda
	 e12tI6u+HSYUrkX2bjTGKwQQpSNtIsyLQAi3UH/PfgX0OmoSqufhyTRBi1DI4P9NcF9Yr
	 sG22a4kfqCRhFO7ylcA9nhXN6Q+NzM1i4ZDl15nIvsF5pb0g6YY8VXaHstK/gRn7KHQGH
	 C8WsgjKA9sMCXbcAIHMv+Zct3bKtG2jUI7N4nFGPHR6keJH+iblZiY2jSAY+AHy0eyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lAHUrhup;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857C9606A32A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lAHUrhup
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D501F0089F;
	Tue, 10 Nov 2026 01:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272915;
	bh=qa8Wj29FZ3Q12gaKxTYYOry6zyVJCnFUG6kwARgxyxA=;
	h=From:To:Cc:Subject:Date;
	b=lAHUrhupbYmzfcWosNEFV0sANHsdPA83VKwq00zyyJutOltVdmU1Bfcb38P3JGtkb
	 k6+JoRdzwQsYrnw4eX3irvWAy/RM2n8I3k1uP+YCV0WB10UXeSY9kZmsK2cb80VkWW
	 oCI8zHCa/ijNCKjo1m1+4LDjw/f3pUV7ukuTdnLnMvXB/sfrI5quwJlCM+Q4kJrSf9
	 2pH0J5GQ10MgaEb0bNy7BR0NheG/aU3PfuGwHbQbxZEaPcq6AJVbAvSnC6kasSfg3M
	 tQB/1YhJJWCv9uYcF2hb4iUsDyP/e81jHhGD/BPUg1IuknLTalkBY66YNSs+9Mre2G
	 td1KJLyzKl6vg==
From: Sasha Levin <sashal@kernel.org>
To: cong.zhang@oss.qualcomm.com,
	jasowangio@gmail.com,
	stefanha@redhat.com,
	axboe@kernel.dk
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] virtio_blk: use synchronous quiesce in virtblk_freeze_priv()" failed to apply to 6.12-stable tree
Date: Mon,  9 Nov 2026 20:08:33 -0500
Message-ID: <20261109200833-failed-6.12-6c6dec7883f8@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 6c6dec7883f8eb10b326bc9d109a4990c885d949
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200833-failed-6.12-6c6dec7883f8@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




