Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048408;
	b=g6lIgiFkplLzApSlpMTkAvF9p1VksrZ4f/sQWhS1GDoHMt30c3eRFubNSp84wfxzb/N2
	 DI8dBKPta5qINJQB3NkQzi7bWkcCzJYsh7HNdKCPBx4gjpylIML6vz/YfUQgvLGj7sTUL
	 kn0bnuKHU/0KxqUS5HW7/Dy19F6r7sFLCCulctQ2Lqzc0MC2Oet7p3G4X3A1/n0dpqUBI
	 YdQUQrSM9Kd7EDZRGy70QHUdHAjq1NyI2tEc7lfr/xNMyocTK7qdz/mZ7RxtQbRgNeOrp
	 OrPTnEVJ0pTtx89onfgKAqGbaa9dx6YJj8ii4vXAxIYxJJWLzN176ZEP91es1Umhp9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048408;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=1CIBogdu0bqSrRwXt7+ZZOQQ3knkUrRawEnfaCkMh4Q=;
	b=g6Qd6QnzIYP+M6lArsq+w8By2NpKqYPTYtoPPKkgrdmN+hXi5QV+eWous7BdD7Qi79Kr
	 goQvUlC0dESEuW48mUhlUmCR+fYfRrsc2b6C33Q54XoG7uVZ8WXwcQE3DclN+1Tiq++Qg
	 WZQQZj2k1hY93PtSGt+IKHkdhTtOBDq0/m/hnuXVTh2E9QlKzoliCVPEwVhKK/lXVxfyV
	 l/GRPpu1piML1VcCyT1kGjG1d7NNgd3ECmJfoJ7yDBoNFPalUFDsA0S1gyPRDsxUp12NG
	 42eDi8U8dTf8eM/1Gfm/a75mpNgOPA4k50hufgfSH3CuZ/RtCjyh+rgnSQvvGBbmbBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MNeqYG8n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DAA606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MNeqYG8n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F2561F0089F;
	Sat,  7 Nov 2026 10:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048407;
	bh=1CIBogdu0bqSrRwXt7+ZZOQQ3knkUrRawEnfaCkMh4Q=;
	h=From:To:Cc:Subject:Date;
	b=MNeqYG8nVWCpD9PQjXqfj3zD1+9aJ8YXoShxOQYZYeSdc7GDejaOnHUhJj50YDvNf
	 h+q3l8PmlBhCF7GTvF1q8OMsjGRYAyBGw71gL0qO9FT8xBNNuxRUXz8+3M7Jh0p67s
	 aLzTpN3nrkBCjXaDen/BZUFZtqSmNmkcwIXtnzZpo7dj1s8j4ui+pkxGMRujkoh6Zg
	 IUuo9cj25BK6uT63g1OT751RPV++YcfkueINPfvEeygbq0OpyDmfVSGtUqMxgH4yO3
	 wVx/TXbUcmPPD4nIJlxcZwP6C9E4uz/0xloiuRZuSJ+LTwCBLjW3FUUozcWxrs/an4
	 eEr3P84bEbfMg==
From: Sasha Levin <sashal@kernel.org>
To: vulab@iscas.ac.cn,
	jassisinghbrar@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mailbox: mtk-cmdq: Fix runtime PM leak in cmdq_mbox_flush()" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:46:45 -0500
Message-ID: <20261107054645-failed-6.1-18e3e9798267@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 18e3e979826795b62e8916743bec4de660e7cb22
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054645-failed-6.1-18e3e9798267@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




