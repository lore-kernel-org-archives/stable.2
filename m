Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047617;
	b=nMQCxXwtJsaGWYE6i8blrhgaZH1x70oKJQKyeGbQJJRR41hMWoSa9dtd2Kn3CqI7DsCm
	 QOpMNu6BzSlw1OQE9/eK5eXI4SbH3CrQZQbQ/f04oot9eFue4ecDiHL7xY1A+ECwMRnKm
	 zTyoA4JfhxeU5U82s8ftia1JHh33OGf5rdDJtdLcUoXip72TZpKanuDnSeS1mOFI0ZvMA
	 YltrnVap20fr87QT4EDyZAnU77jg9k+cwv2u46Bh3zkSehloPp2wwvsIAjCX0ov2Hytel
	 CtL0h4tnGj3U6w5hJiUyLEGnyfB1nBJT3HwWmvpuhEVCzxlXC3L7gF0RY3YovLLVBhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047617;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=qExnHh5r+bk+FJaal2Rgl0fw4g+zZQOi24NO4sbUp44=;
	b=OfQd9l+ZpRvadb/SkhLGwPPljfO4GJkjQDQA4LFP8kijvDJOCdo2zTgd3aIhATtwizJH
	 r6PHP1MWg6esjGNJDtDqFoiI/G67tVGmveJJdFamY3GXIiY6GmFqXQK6+EPa+Tc2kuFnp
	 4W34GtNx44/A4umZjIX6d53Dr9hxDEHZTHKlCQfSbGWAfPVvle8hGnpx53pPsh1ydm8YQ
	 PAiLUhqyc+iLEizRr0dYIjjMlt/6CQlpH4SSkILC5Jw+/XGFi2xvuN+JkL1KEUdZRHWhd
	 hx21C/5X8pqPjW55b1wmDdsBFmWulXYYIBg9nQRB7arEdkkfSn5MEdbnidgcZi7hrVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RUCN05p1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AA6606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RUCN05p1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852831F0089F;
	Sat,  7 Nov 2026 10:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047616;
	bh=qExnHh5r+bk+FJaal2Rgl0fw4g+zZQOi24NO4sbUp44=;
	h=From:To:Cc:Subject:Date;
	b=RUCN05p1sq0HgPg325gk7kdkCzl9N5/nOO6uY7Gdzd4811kXmrdGu8G66G+V0oDYq
	 fIESpz4SiZqnSp+2P/j+ihcXToTKbNHK8/DAT3B7moO/BD1nFwdo9WlpZvHNdddKoI
	 f3RrWNUXHb/QNO1RNudXaURNiIYfg0BoZX+vAJtrTWSptVZPOlShIyUyL1IiFXGOA9
	 a94XyV1RbQaGXL1U+gOYcxQ+F+yHmn0uK2zB4LeBbonAhC+MIcY1tDhbfRFKGxmIYi
	 fpO+i8Bo1DCONlRznujqHJxjScZeriC24zNpuEVbF6fkX2s+JOFAeG1sQFQhIg6B6o
	 +v3plW4Z4iavA==
From: Sasha Levin <sashal@kernel.org>
To: vulab@iscas.ac.cn,
	jassisinghbrar@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mailbox: mtk-cmdq: Fix runtime PM leak in cmdq_mbox_flush()" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:33:35 -0500
Message-ID: <20261107053335-failed-6.6-18e3e9798267@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 18e3e979826795b62e8916743bec4de660e7cb22
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053335-failed-6.6-18e3e9798267@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




