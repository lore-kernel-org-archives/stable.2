Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794613479;
	b=ZXFrWZlR+3exZEu9iEXqPbkYhQV0Zi4T0Pxj+LfgCX/Fe7Zz5H1V6VnCg3L5Up39+FFl
	 HJqOqbEp+n5bsI0MzHBs0ed9PONOn01f2OfFA0ty/MOYQSxy0M2A+YE0n9PFwB+MMGc4w
	 ulCUxFp6aJZLphCdvTp0SiVsY06A+ZPLpFgprCzWRzOsEt6V9vMi8eS9luVxWlhri+Bxu
	 u1DwrNJWBdhfv/mUaCzNeTjAOTb21rbl6B5rP/M8axz4hz270EpNkYOvsQCGevuv/uFVf
	 7RgiFtSdIQBefNcnCYp2cKCnEHLQHNBPhiJNSQRHQAY0756cvd0D3AXd0O7fHO67jWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794613479;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lwafMVnGn4+CHGZ+qJokPqF3JvaxclO1YTpiVICKnNk=;
	b=vayNhD6UMl3/jmU4PcsswR5tNopysyCOrkVoH+7UWvsmYLevgvNazsSiMiIr0TF8IE02
	 LCSMM+j7J9/n9G8nAjCWiTdITC+tLTNMfV/eQfKuaDTvy2AvBWcu5xmgLAR4NLSHI36jO
	 F3NyD4R12TvQSnd3fbGEqhb06zrdmHsWWJVtmJjxRX24B9whgo5omUOMI4GFk1J3r+vnR
	 jkLHb6ywX+7IWJfzKXiB2Rw4nlIberq5rxaqInuHErTLbOPJeriuHfvU1u+UtEYUuyZkk
	 +LIRqp2zKYwl7KVIKoUOSL5kh739x/IQFmaW7ou9uSWVKNZsXVwBBnlaXeOZ584YDwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OzVT7M6Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214BD606A331
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 23:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OzVT7M6Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1CC1F000C4;
	Fri, 13 Nov 2026 23:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794613478;
	bh=lwafMVnGn4+CHGZ+qJokPqF3JvaxclO1YTpiVICKnNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OzVT7M6QZs5FJTUHZ6GsWMsUbhq2jLzusdGzSeBtOfglYl9KMlCqZY6EMmYnb/9vq
	 /gtB64dxonBbOncHDRD4jfGK0ZueLdJnlbM/2tXUPO/tUEpz6C0yQTc8LzcAYPBGdk
	 QJc415m9OLozm0vFH+b+ByBQYIluC36S8hOgiCXjLqZj5otjtxRAq87VM848Su/zgw
	 RB894SoFwZngeITyv4uu+YbYdgsnPHnDwjh+H3qt3ImGVllhW++p+nElcJxHqmOIMY
	 0CnMTSXzz2vZkh5R8sQ+SF/qko6IdQKI3bzCZ3S/9Y+q91gbOYHAskzB5kJchDGb/3
	 vyvhOxnV75dlw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Cong Zhang <cong.zhang@oss.qualcomm.com>,
	Jason Wang <jasowangio@gmail.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] virtio_blk: use synchronous quiesce in virtblk_freeze_priv()
Date: Fri, 13 Nov 2026 18:44:36 -0500
Message-ID: <20261113234420.2749142-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202731-failed-5.10-6c6dec7883f8@kernel.org>
References: <20261109202731-failed-5.10-6c6dec7883f8@kernel.org>
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
[ sashal: adjusted context to virtblk_freeze(), which uses queue freeze and unfreeze calls without memflags ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/virtio_blk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index c87c6a4eb3b33..8a492dd94fa11 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -955,7 +955,7 @@ static int virtblk_freeze(struct virtio_device *vdev)
 
 	/* Ensure no requests in virtqueues before deleting vqs. */
 	blk_mq_freeze_queue(q);
-	blk_mq_quiesce_queue_nowait(q);
+	blk_mq_quiesce_queue(q);
 	blk_mq_unfreeze_queue(q);
 
 	/* Ensure we don't receive any more interrupts */
-- 
2.53.0

