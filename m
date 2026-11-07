Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050456;
	b=n6KZWiEdwQpd/OvZMhbuwxegHgdNpVRprR12jzyraOjdDJ4xolnHy+69UINg8EE3b/IN
	 pi0jtMexJgCfNarN4uClpzaaimkCCPildp3CndtdvpFoaTX3dQqAwnNUjGHfoAYqh7kmP
	 pj4TmyYJDbCgmY1/6eZinwkWLJHyhpDCb51SKS9rUjVEGcjaMaEkLsgVVBKJvEXxt+Hyb
	 ZIdDKNvCAlsNTDg7ypqe1JXgwavhh5I4QqDd4raq8TPqmEY1otCiy79ktMCHC0VnTKyRQ
	 vK1vtdgs4CtCS3sq+ZaKbsoRCtlxxWth1hmcRBsD8uncAc8D0QlYzsxtVVLImBpJfhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050456;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=slZL36i/S53VUXB2hBABm8pYK9tv8Ly1uB0YNsyPTko=;
	b=vOgMUESG67ii2wro1wphiSGlZ3SAO0bstZ3xA1TA+yyXBegr9yeFSJ04Ut4SCHs/4ZGZ
	 4j2sVtdsiPJ/HXSF0KQRC2XpP7TE2QuzCzAIW7LHaKXFe88mtth1k6zVRlDb/895amH+1
	 2z6MuuOCvRcpX+CpcMDjVjV1PjbDJDBx5hQ3jA0rHB3NanFW5NPgso14Ef6bh+2E9rhz3
	 gSxO97Pc+wHG3140hGmDNTAq8SexBlPdrDjqepSSNO7wDZHAtxyiliSN2+yngzgj+eKUy
	 aXAsSi/BZWH1Fj3bMat+A5H4oHhFrHfAvbxzAyUtzi5SiUdtg1erbC7KO8yCQXdKyOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KILVlAcR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBA0606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KILVlAcR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF761F0089F;
	Sat,  7 Nov 2026 11:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050456;
	bh=slZL36i/S53VUXB2hBABm8pYK9tv8Ly1uB0YNsyPTko=;
	h=From:To:Cc:Subject:Date;
	b=KILVlAcRvVDtz0FBwX6UrjYqCGHVmACtapOK2c5iJsozJHrHT1lX0+5TTPYfPVRQ4
	 E+rsCBa4OgXiIEf4VK5eqNmH5qyitQDXwGl8TKbpIO5JfAK41WmRIddySZfhShyp04
	 ANfHvrH36cn+pJkieM1gLymTz2Fi8kLUrrdyPsvUfpIvivo9h8gFt08Lo8si5zgioP
	 1bLzbtHrWKz5t3Frz6SD9Zlcqw7y4O65lzR61JFqOY0u+iA8doonZcADsuqHncCpsv
	 7cUHq5J4724bnSr4ncjBqkXvIKEI3sf+pdVzGh2GnDbnPUhzKXfPqxTengjNjW2gxw
	 bIp3FJm4N5eQA==
From: Sasha Levin <sashal@kernel.org>
To: vulab@iscas.ac.cn,
	jassisinghbrar@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mailbox: mtk-cmdq: Fix runtime PM leak in cmdq_mbox_flush()" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:20:54 -0500
Message-ID: <20261107062054-failed-5.10-18e3e9798267@kernel.org>
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
git cherry-pick -x 18e3e979826795b62e8916743bec4de660e7cb22
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062054-failed-5.10-18e3e9798267@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




