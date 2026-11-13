Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794610326;
	b=kAfYK8BHZscP+sC5Fgv9K9/tYGRBDM6df+hjzkXM7X0EUUSjiN0bJ24a4Y5JPugcPIlb
	 Vo7Zt9yErJfFMNsrwYI2+ibvZUu8PfXkUPdZ5bPr6G9qIAdkLWC2UrZADyC4l/Hypzc4w
	 H3eh1cPc+piMu4Y6vHh060CwmfobMUCL3lhn1Nw78n3HdDk7Ho5qGIS9UCczM7VBeXJdq
	 2y1GvHdX2tX0pUITgw7FTD44Job1rE7UIheBUytLL9p6CAggoLnCTxNdoB+4YkQ3KZ9oS
	 q6mw276MegLYQSIhOMSUTaKs3BtR0NJedVyzlsOJp2o0H0wqcotIm+FG4OBq/yYWtNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794610326;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=cJqEH+ns02BeOaEB/4cs6HLckhxebidwLf8B0x34ghM=;
	b=OLvC2t58MUAo7NhrZovZkGruUhtPCPHw7SbL8w+FgWX8Jl4uEQrGh4nL3uE/npFefoWs
	 SWbIv4Bb4J974b3N57CimaNP8zn5z1uPnchc2itURK0mSq4El2o0iUDnHReVblBXTAXlX
	 QH8hQ65PWpQfH3TnYz9+1hLSUIUsSH5EjIezdtESSgxd3yGpCuwP6XYgsLiJAnHWuLYXK
	 8j5oODzCgGB4NjJrKaU+oExhVxuw8cliRBjNPqX6OihbH0K7YI1YwIOqd2savlbe+S5Of
	 67yIqJ1ElvvXUuBmVgnf071WATVf9Uzo2twudR/My4so33ETPAWRXZMwTbDc4Wy0wBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EecKVlRF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A5A606A331
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 22:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EecKVlRF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C741F000C4;
	Fri, 13 Nov 2026 22:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794610325;
	bh=cJqEH+ns02BeOaEB/4cs6HLckhxebidwLf8B0x34ghM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EecKVlRFYqb8rQGUl9MdQuC3mQy1xQz+ai3Wf4oJqsQJ1LzxAbd41DV36S+jnkjVL
	 U+fjzckpUJjSj8thMG1+MnoOKRKFd9wJKqSM7HqeFXDZjjTclVM7y2VKLfnYVaLEkP
	 pNOiXF4mI9ZTgqQYrIYfD2qJAiF94n/0s2zxemMHvP1PhKuPHfA68rr0RASmnVUwam
	 ttnOy8UiK4VeyvQUWWZq51QWNIK3v0MeEjtmB/A58epBKS4avYcVMrJHRJU5gC+jYq
	 jLP3V8pWH+x+do0x4zpBg4xGcsJzYyZYTqvd5/U8C5EOEwFUgR1UEb8LXswqN8DJEx
	 Z2cN2MKFBfjog==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Cong Zhang <cong.zhang@oss.qualcomm.com>,
	Jason Wang <jasowangio@gmail.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] virtio_blk: use synchronous quiesce in virtblk_freeze_priv()
Date: Fri, 13 Nov 2026 17:52:03 -0500
Message-ID: <20261113225145.2734747-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202250-failed-5.15-6c6dec7883f8@kernel.org>
References: <20261109202250-failed-5.15-6c6dec7883f8@kernel.org>
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

From: Cong Zhang <cong.zhang@oss.qualcomm.com>

[ Upstream commit 6c6dec7883f8eb10b326bc9d109a4990c885d949 ]

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
[ sashal: adjusted context to virtblk_freeze() with queue freeze/unfreeze calls that do not use memflags ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/virtio_blk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index c1087dfa332e6..9fb35af3f9fc9 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -992,7 +992,7 @@ static int virtblk_freeze(struct virtio_device *vdev)
 
 	/* Ensure no requests in virtqueues before deleting vqs. */
 	blk_mq_freeze_queue(q);
-	blk_mq_quiesce_queue_nowait(q);
+	blk_mq_quiesce_queue(q);
 	blk_mq_unfreeze_queue(q);
 
 	/* Ensure we don't receive any more interrupts */
-- 
2.53.0

