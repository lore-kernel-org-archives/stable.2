Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794607532;
	b=tF7kQv2DFteelZXMJZxONMsNKly/8xx6vYE6fhmyDrmf8JbGtiesOk43ch2I2wZ6n9th
	 gwHL9vpJr9U/gMMh6vC6hwvJmlthO0YsiKAUf4ngZ/637FTEUg8kfhvKouj/EW0uZwsZi
	 QLcZO+wQuGEIZvC970TKBfarOuKPGM12zbO8xz2/5XBbgcIXFATLUu+0AyuIGaJjOKZWK
	 rw3YxdOqpAbHwijgh+XbIhrAzohLE+Ba/2ZZFY7bic9zehAZIUrb0l4IvvMqvssTa3ffH
	 MLCVGWBygQLsZH5Zk2SiNx1w9KSBDqeo3tne236LcsxA5Iy4HqN7NC4iV0rT88jcThQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794607532;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4v4+0vMg/OB8O3Fqwjlh6P4E6FyoenCh9PC44enf88Y=;
	b=zr5Gq4tATh7ONgIy1K3ZWrpoGu6QlopSN6UTuqXtaHzKyGhqb7CNBUcv7FRWeOa69bb0
	 EOKm0SCkHorV+PysAQ8KZc8H+/1lvBY0H2w7QNFnLR7GsKFWrA9STRNooR0UMaEvUgWcb
	 0dDjv2Mzwt1UejPSEl0IP+cVeYBrILf9aW1pY/x/klpLFwGqwBjoPz1f2OF+DA52vUq4W
	 qnBybPErwKJ71mr0Gv7VlwG9+DXua2zXcdOh3Bcbc/qHVwgD+WnyLMRqFNTGWHUf/CL3k
	 ftx34fDTpIA++A2h+SAmDfzzaHDLscXxRJid5l2Znaf0/0BMhfi+PuxuHAAf6AGAApg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IgtmsZ24;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D257606A889
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 22:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IgtmsZ24
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC671F000C4;
	Fri, 13 Nov 2026 22:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794607532;
	bh=4v4+0vMg/OB8O3Fqwjlh6P4E6FyoenCh9PC44enf88Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IgtmsZ24YrpETe/xudnAS3Zb+dl2fApCI9VLND0eujpgDBVJu1hf+eaIojOgUdxtO
	 5rE98+4Z/UoTyZc/uAlos3DO7e1nRdOZ5b4Bw5LITjrjw5kbQsRNMt9E3f4FV6vtZL
	 CWkeXi6bhrt9nx2WtoCiAs0fBgMSy+OSAo+FKQdgQntsu6AQIikxKatl9vE2Mcy3IV
	 K0P5kmtgQli8scy+miY9CNDrh0A/+OgR/YsG8D4dp+xGfYgQ1WAi/GArtAMoEaWUbx
	 XkpgxPZexvhCoDXV45mc02gLJ1lrtmJDdkQ2y0f7Clewyh7tRttqE5v1N64gQMurVI
	 F1xiLEiWhYcfg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Cong Zhang <cong.zhang@oss.qualcomm.com>,
	Jason Wang <jasowangio@gmail.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] virtio_blk: use synchronous quiesce in virtblk_freeze_priv()
Date: Fri, 13 Nov 2026 17:05:30 -0500
Message-ID: <20261113220513.2729882-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201753-failed-6.1-6c6dec7883f8@kernel.org>
References: <20261109201753-failed-6.1-6c6dec7883f8@kernel.org>
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
[ sashal: adjusted context to virtblk_freeze(), where freeze/unfreeze calls do not use memflags ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/virtio_blk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 0ba56caa41eff..4e43de5724108 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1205,7 +1205,7 @@ static int virtblk_freeze(struct virtio_device *vdev)
 
 	/* Ensure no requests in virtqueues before deleting vqs. */
 	blk_mq_freeze_queue(q);
-	blk_mq_quiesce_queue_nowait(q);
+	blk_mq_quiesce_queue(q);
 	blk_mq_unfreeze_queue(q);
 
 	/* Ensure we don't receive any more interrupts */
-- 
2.53.0

