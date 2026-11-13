Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794605582;
	b=LT9BNTQg8vkM9tgR5/yGxRK3eXAso1dp8p1zxfsJDRibHjdbfUKdyOh70rQN8AgUHDv9
	 oZsiviX/4mPrkZ4b7fFQbjNIQ565LWg7lqLfv1hyKD9qsXhPwom2XesVA44yEuGdzl9ao
	 7+E7fJ1uzZxx/WyLkWYGh/kewOZGdFfDpvMt1nJ2CrlukhLJD6cBvzcajFClVLNC3ADdD
	 aaghV3hJ7FgdQMV/dqekHluMshAkp0vsX/ww4gFVPN9qB/6VLtV9VwRTBvL1DKh0yGzI+
	 j5/rkUd6ghCLoDy+ayHKBrZ+OYlIZOa3WmUdMPTawkgVY5mw+CT++bQRERyV37qC2Mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794605582;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=iVa0OCDkk47VLOPt6GYeJX1uOGTkrKCBW9S2qUV7nro=;
	b=HB9UqL5FpzCNb2Fc10nj5xhAhIWk3aw1m20frMkqoATBOkEKCUuFQcW+SmgfWZJUOBr9
	 oXcbOiHoUX/8QlFQN0ldBnVxRzlYOLhwU20TtjCgOxWG7a/Fy44qAisj0tK2Fjuut21Yz
	 myKwgx3u09RjJRN8uzJuOd34wkQj8Iu7a2/53bNv27yXaLjMXrYAVWOO6B3ZK8oOthWWD
	 OHmIytkSBq5L6Y1VENk+VVJvoBDX3XbVZkEhg3Dt3ESyrirsn+mX3YdaJ4tBHNrwMdDo6
	 qX8fCA28aM3f9VNVinRY3gWZFz2kUTA9ouMzKtmSpbxZphMIyM1HOeU48lrywXgEo/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PPkJ6RtE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97423606A880
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 21:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PPkJ6RtE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77B081F000C4;
	Fri, 13 Nov 2026 21:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794605582;
	bh=iVa0OCDkk47VLOPt6GYeJX1uOGTkrKCBW9S2qUV7nro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PPkJ6RtE/gfqC0i8g/momgzCmUH59XRiIjBLVCMdqfnKSgS3DfhCickuRRkyTFSf+
	 ilABS7NYsArGylIF6GmNmZI6q1bs3D1TgsCobiZI7W/7GEIz9W6tpNaPC/DUQ3U59r
	 wMr4D/6WI+ac0qIanOZG4XSh634absvf5vFt0dNl6/u6w7Iqq9ixfo3SbhIJJQlA8F
	 snyfzE3/2vi9UES11ZLbaKVLsnvvKr9Kd7VlLW4YC1YKKqAx+42X8Q9+VUBHkUrIv3
	 GKezWijEt/vcx6/knaUJPRasaDo0MnY4U9wo3wBd0A0g8hjBldifQ1l9x6xi5r+340
	 GVoeC0XizChXA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Cong Zhang <cong.zhang@oss.qualcomm.com>,
	Jason Wang <jasowangio@gmail.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] virtio_blk: use synchronous quiesce in virtblk_freeze_priv()
Date: Fri, 13 Nov 2026 16:33:00 -0500
Message-ID: <20261113213243.2680554-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200833-failed-6.12-6c6dec7883f8@kernel.org>
References: <20261109200833-failed-6.12-6c6dec7883f8@kernel.org>
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
[ sashal: Adjusted context from virtblk_freeze_priv() to virtblk_freeze() with older freeze/unfreeze signatures lacking memflags. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/virtio_blk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 789890f3c5ff4..43884773dc3a8 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1590,7 +1590,7 @@ static int virtblk_freeze(struct virtio_device *vdev)
 
 	/* Ensure no requests in virtqueues before deleting vqs. */
 	blk_mq_freeze_queue(q);
-	blk_mq_quiesce_queue_nowait(q);
+	blk_mq_quiesce_queue(q);
 	blk_mq_unfreeze_queue(q);
 
 	/* Ensure we don't receive any more interrupts */
-- 
2.53.0

