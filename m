Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274054;
	b=GlrYQTFSKhnW15bueZn8VNW/c2ZKrmW2FxkFd24IjmX+MK998dPM54r70h982wtVSNKY
	 RlSFxSrgC3uRfVCEdMNBTKixmJc9GVZjhrbw0gDtVOOi3YBtFCQm1ziKvMd/R7NbEVaxX
	 mStoT+OjIUIHEWq3Upc2KvMUgYMASe7v1BzGXFJNXwWdBm+tug1w1HvZtpfifG7iVdg53
	 FY2XIRIXs4RWJtWNrx8cDZIHymcnyVfmL0zFxBbsIPyZJTZ+ZACfTiKrdeSboLSWCulcB
	 u/FmCqHk9a6rWQ42Bn4ZtP732ZPQyBO/Kci2Vnl8cANyw3vYJcGj6LM+x0e8SRE7f0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274054;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=VOygTCMd3I64wSP7O+hhLT2vr0suwKjG/qeXflFNtjU=;
	b=E5CF74okh+e3OqL3/rh9KX22rIwKITwZGSjcLY7M2j3qp04N0QOXuWXoFCJxK5HMyXI3
	 cKGdhmNShhpb5eEcc0IYJ0sBPWApJ5Dfa3X0N/hZUSnTfNTzuHA8aKmglw83oIFvJmsfq
	 d+PLGETnXLpkIsz1JSueMSSMC3XnST6fHJEgh7CJQ4k5jZnhV84HKnBKWYbERKuByGCnM
	 JFyvDtCc+q1J1Xg244s5eHT9VRubVjomMKPT4cceXs4+K/6YUnVGxbydW/OSbxp/3jadY
	 bkqHtWtUwFCKPoRgM49dVo48I8K/TIA4XX8hZN73lMTLSTXkZIErxZ7P4bjeXkuuadQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PCTiy+ju;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5C2606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PCTiy+ju
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E9B1F0089F;
	Tue, 10 Nov 2026 01:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794274053;
	bh=VOygTCMd3I64wSP7O+hhLT2vr0suwKjG/qeXflFNtjU=;
	h=From:To:Cc:Subject:Date;
	b=PCTiy+juAGv8mzxA6wlrQuaX23VVvOx6Vo0tpziXhnaXqhqqSGfwn2WdvF4V87tjo
	 xa9ACRl8Bn4DiJUzsZl0Abv8tdpEb9Umb+tWsmg5GNmcNZV5Tg/ZDrAYueeN3kvwUu
	 ElsBuhldmDqKD9SrzqOWCopi1xsCEFOyhwbkSSo4B/RBSK7jNl0Q4iSWzqOi9Mx4kh
	 r/QzKMFFChtIt0kKhB/4lC9hdCXnagvjb36mv6ESPnmwfQWblgaobaf5ZAIjWNLMrK
	 5cRvm/HZRdhRJIOlKUA2Iegu43lQ4MoJqt2wr/Jxg2XH0I2LmjyrqGskXY1ZuB8I0v
	 kT+suBoId5mJg==
From: Sasha Levin <sashal@kernel.org>
To: cong.zhang@oss.qualcomm.com,
	jasowangio@gmail.com,
	stefanha@redhat.com,
	axboe@kernel.dk
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] virtio_blk: use synchronous quiesce in virtblk_freeze_priv()" failed to apply to 5.10-stable tree
Date: Mon,  9 Nov 2026 20:27:31 -0500
Message-ID: <20261109202731-failed-5.10-6c6dec7883f8@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 6c6dec7883f8eb10b326bc9d109a4990c885d949
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202731-failed-5.10-6c6dec7883f8@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




