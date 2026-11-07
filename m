Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049453;
	b=lfUs+l5Et4kelLdqhwHzYXsmfVPSh1AQUW+s9AQGEXXWshlZZM1/LobVOfDsZJHz8bFT
	 AtwAgXxTrG55IfMANHT4ZwxXmquSE08OWi2t/isaeDsZZFjQ5XTVaZv3y3r5afe7kHA2Y
	 bXM4vD8dlfxxgM+hp81PeRAbVM0BOhFv6500RdPirlDz1Vxn3h8Z8TebwJWKg6QVw+SQM
	 OAGJT2ioU0SnfTqsgU9DucgxynQFjtClx/WV5mftRfFot11sMrG+FafDIidvjNLpzDzyC
	 NOO61QEgWv8ztkdE7gufj217YVGfGDeaVJrU9tU+N/hNiS+4TToTy7WKzVCZAafuUUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049453;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=0Sgs1lbullQ0YAe8ZPLCVRfuAcizdLOGvwmwJFnr3SY=;
	b=ZDBWnlHHczzFuqz1YTjBvl+jaUyRK6kubR5lQLESnKSmO9N3DexD8t0bthZ4hULmxd/f
	 hz2NN4OoZxi44WEe7mJIhq0kfDp7CDDpqx5SEpLjpQ9RaXuNMgBV+A1LD2G4wBQXA9ics
	 uHtU02gGDFQ1cTtSAFr9Mj90eX4hQWhRassZh9ccIkT0146qQkzq92Yz1cac2pM9t0wwo
	 c5G1rwYFUaNC0IoO9XFCs/FbWYBPAu15PeFjQHC27ThxqV13b9HcYpDek8IqyjDQOR1mk
	 vHdSG1VWXQhGW8/UNQKwN7s61QfDTgToneI8eqU+ZhjALVaD/K//URc4oKa7NHYYV6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kgzLDSj5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C328C606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kgzLDSj5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 431161F0089F;
	Sat,  7 Nov 2026 11:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049452;
	bh=0Sgs1lbullQ0YAe8ZPLCVRfuAcizdLOGvwmwJFnr3SY=;
	h=From:To:Cc:Subject:Date;
	b=kgzLDSj5hlEihA17QSs0ypraJG2Yj6dw95JVKWaqKnbyniXM/KNz0gG7DggYNhx2b
	 IM5Vo82PyNDjktswrm4VZ8Gynk9XVqnj0copdbc55o6JYQ6g44FNg7ZaBaFJQ1L3U4
	 fjyctFfvWPg4IiBW18hQrxd/fB8A/f1K5tAQXZHsGkdn8fNKSlqG4gshq0MUuwBVXc
	 nhwof7iyuz7xK+ybN3xrUFhfdqfY7woXoJVI4vKyPLy6J6AtTuAegBH5rFlWujOs3K
	 KrwvsyoM+ONBZUzWumrk4slnxEt/zaKmIvB6wl0Tilp9Zsjw+Rz6rK6RkEV/vjOJGt
	 dvjrEhkPmrKMQ==
From: Sasha Levin <sashal@kernel.org>
To: vulab@iscas.ac.cn,
	jassisinghbrar@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mailbox: mtk-cmdq: Fix runtime PM leak in cmdq_mbox_flush()" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:04:11 -0500
Message-ID: <20261107060410-failed-5.15-18e3e9798267@kernel.org>
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
git cherry-pick -x 18e3e979826795b62e8916743bec4de660e7cb22
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060410-failed-5.15-18e3e9798267@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 18e3e979826795b62e8916743bec4de660e7cb22 Mon Sep 17 00:00:00 2001
From: Wentao Liang <vulab@iscas.ac.cn>
Date: Thu, 17 Sep 2026 09:39:23 +0000
Subject: [PATCH] mailbox: mtk-cmdq: Fix runtime PM leak in cmdq_mbox_flush()

pm_runtime_get_sync() leaves the runtime PM usage counter incremented
even when it fails, but cmdq_mbox_flush() returns the error without
dropping it.  The same happens when the GCE thread does not drain in
time and the function bails out with -EFAULT.

Undo the reference on both error paths.

Fixes: b0524f7c9635 ("mailbox: mediatek: implement flush function")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
---
 drivers/mailbox/mtk-cmdq-mailbox.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index e523c84b48088..96462ca844715 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -565,8 +565,10 @@ static int cmdq_mbox_flush(struct mbox_chan *chan, unsigned long timeout)
 	int ret;
 
 	ret = pm_runtime_get_sync(cmdq->mbox.dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_noidle(cmdq->mbox.dev);
 		return ret;
+	}
 
 	spin_lock_irqsave(&thread->chan->lock, flags);
 	if (list_empty(&thread->task_busy_list))
@@ -603,6 +605,9 @@ static int cmdq_mbox_flush(struct mbox_chan *chan, unsigned long timeout)
 		dev_err(cmdq->mbox.dev, "Fail to wait GCE thread 0x%x done\n",
 			(u32)(thread->base - cmdq->base));
 
+		pm_runtime_mark_last_busy(cmdq->mbox.dev);
+		pm_runtime_put_autosuspend(cmdq->mbox.dev);
+
 		return -EFAULT;
 	}
 	pm_runtime_mark_last_busy(cmdq->mbox.dev);
-- 
2.53.0




