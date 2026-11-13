Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606655;
	b=Q2wQyCRrf84YUWErmVhw3fEZ/OWA2l+JorXq+f92nGKWHUqoax/e7Mo0vpKYoxRy3OyT
	 0Ae+33Ub8LHsweCNoBFrWndk80Lpv/Y9BF0jE5zyZP5yZX7XsHqtkApvOhoTMX1GpBsjM
	 GivkZSVeuPLzyWePWw0rD4bd8Zx1YhwF8hi+1JKblLuhfIzLr8SeA1abiPTEUtk/yCWwk
	 jiXco3eV47anOCAX/adWNZt+/p80bfpviYGQ2O51Air/2aL8iTxhDj9bnpori0wocp0Qy
	 /1jogd78e5t1KIYAv2w9wXDmJwEs39QqE3cTdXJcu0EvFXWF3rjoBc/ar6x0cxp/y4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606655;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zoF8wlRvPTLWiUm6fSrKW+JgMTwwdqLVFtnkD+pzhQE=;
	b=iAFQUHoIsNQ2S7dv2bGtNIHrUB4Z7wEqNPThE19E/Bh0af5sRDEUHPMJ1pKm/ac2mjI6
	 aqJ3T+a7sYKbmMzAigr4sP2rlWpke3/5Igt+DScffXaCC9x34BTpnJlsyHU+eYUKKi0kE
	 8sGNkHRes5NA2qt92eFj9DhYENqwhfkA7OwYOqvt2jWGuq2KwCSfuPpBG3TWKPitzs2yF
	 tQI2ErUhdgKa9IhzGvhYEOLqetbd1tLZ5EOdwxnMHqKgYW9AdNazebXXokjVXc/GHdbeH
	 zEDnZT+DppNoEA7tyJ1b9B5DQf5x3sW0eIygT/th3+xXXZWtlwaVl4OMsQe81OztoMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k1Dk9hop;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02A0606A884
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 21:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k1Dk9hop
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D726D1F000C4;
	Fri, 13 Nov 2026 21:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794606655;
	bh=zoF8wlRvPTLWiUm6fSrKW+JgMTwwdqLVFtnkD+pzhQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k1Dk9hophFBUVfNTDZyjsS7ZkHMeKTAAAJc0SoMu6sFrjZ1FZMEYOc0XOeky3Y6Bq
	 PD0RnPkvhEBzpaM1Kx9mrWBkXKNPmPoQ16yzIUvkPS27UyLjyMaFs/P1yTGza9ptwT
	 xPzqKqCyBPSxbpwkCMmw77m+gD3MC/CiPJVFJHiBooiPxP/8UN+ZChHdAhWJef6l1v
	 5n1xyxXhX5EFK07IhjjXtzj97E16wqPy6yhbDHquOXiRW88NiRobqvELyT+R4GOz6R
	 4/L6WFQyoCkK/vX8CV7R2rcJFcNP25NCnyl2AIMEoanhstzEu92zXLwvrhQ6RScPj4
	 OeipT9CWwj+qA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Cong Zhang <cong.zhang@oss.qualcomm.com>,
	Jason Wang <jasowangio@gmail.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] virtio_blk: use synchronous quiesce in virtblk_freeze_priv()
Date: Fri, 13 Nov 2026 16:50:53 -0500
Message-ID: <20261113215035.2715683-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201259-failed-6.6-6c6dec7883f8@kernel.org>
References: <20261109201259-failed-6.6-6c6dec7883f8@kernel.org>
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
[ sashal: adapted the change to virtblk_freeze(), where queue freeze/unfreeze calls do not use memflags ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/virtio_blk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 65a1f1576e55f..1aeb44304f37a 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1628,7 +1628,7 @@ static int virtblk_freeze(struct virtio_device *vdev)
 
 	/* Ensure no requests in virtqueues before deleting vqs. */
 	blk_mq_freeze_queue(q);
-	blk_mq_quiesce_queue_nowait(q);
+	blk_mq_quiesce_queue(q);
 	blk_mq_unfreeze_queue(q);
 
 	/* Ensure we don't receive any more interrupts */
-- 
2.53.0

