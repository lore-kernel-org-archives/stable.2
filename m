Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046869;
	b=b0GLdFY6n/u8GD3CLYBikljfUhZgkVzmaG4uK71AXDH1X1tKXvxruzPuvFwSvxMh+pGV
	 hQH+vHs+vE2at+UiBvH2+u127j8y6HQArY1T65DTcwl/q+v7DaXxny/H0FLxuAT4NWjtR
	 K2elI0Um30ibuPk/v2eLrBodXs/tq7mM4oYZMW+cfE8N8LJNVDr9BKKK8GpJldxNIU+/3
	 mJEDlz4FYFxOCjvlAfQj1nv9jxkA+ibIL/fCFyWDBWDiFCVL253stshjwa9xIdEdNqPL0
	 5DIBBPZ0KOErY+bwxWBAo7vyql8jUTc6E7BYgfeQC83UbDULpoVpjaleLvT5kPyEtBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046869;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=o0dsnmySG/yvfcJTFsKAKBLiIpDnRwd/NJpCsl88VIM=;
	b=ZyfXpcuZ2opqFYX03W5iO/lTqEUMM+7HVIBanTzsFHrpaNY025Q7rz1Ls2TboC2cQ/Qu
	 A7rIj8/kblW1LUQ22h30nqfRyqPtUd00+zDb0ThuIn1h2dACmi90rlT4+wvnitnqMHMGT
	 EYTafGpPu9yK/A3n929Jl1S0cbcSY8qj8ZvbDW/iRnCo+hvF+MR/hd4YsEPPOr7hjOvjW
	 5K0UWV5VemZU+Br9aurZgVtb6iStm6J+ZKn/QeB8j35NkgjDV/mc2DnCLgqU6uwuDEJKz
	 DIxIVd+osuJh3DrNIoN0tzGwYFkQgIK98KmrCUG8yMIx3UQQb4iNNaTku2HlC8swg3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hmCNPr89;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB48606A8FB
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hmCNPr89
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F581F0089F;
	Sat,  7 Nov 2026 10:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046868;
	bh=o0dsnmySG/yvfcJTFsKAKBLiIpDnRwd/NJpCsl88VIM=;
	h=From:To:Cc:Subject:Date;
	b=hmCNPr89ZALv18UhyFfnz0I8M7HxQ+lvZXnBBdXLySdY23PlFoWWNjkUBGy5vs3e5
	 8EtTpDb6gwUlcJTBWExYRBCpWhdwJpyFmsr/f46cXXcFF0dzA2HoWl/mEjnOcObZB9
	 ltlMWf4ZBZYYeQVFuMloSDkfBhgaCx3Dtwo7oACZbstdd6oMLTCTbqBM9+YV8x8IaR
	 Xl2GBqPEhWacbHFS4QsAAZS1ReUCiX6vKQO66uxWFK1YCQf060dTxJgT7KgIb90o1K
	 Q6Wenfst7Ebf9kdpIC5AZtOedIPEvutRVVc69sR0ZMBTu7RGQJlX5w1qcXGW91J7WZ
	 li9a8NU2tJC7w==
From: Sasha Levin <sashal@kernel.org>
To: runyu.xiao@seu.edu.cn,
	jassisinghbrar@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mailbox: altera: shut down RX polling timer on channel teardown" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:21:07 -0500
Message-ID: <20261107052107-failed-6.12-0cf10e65639c@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 0cf10e65639cba32d05994f85e6a8f08dd0ffe08
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052107-failed-6.12-0cf10e65639c@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 0cf10e65639cba32d05994f85e6a8f08dd0ffe08 Mon Sep 17 00:00:00 2001
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
Date: Fri, 4 Sep 2026 14:19:39 +0800
Subject: [PATCH] mailbox: altera: shut down RX polling timer on channel
 teardown

The RX polling callback unconditionally rearms the timer after it
processes mailbox data.  altera_mbox_shutdown() uses
timer_delete_sync(), which waits for a running callback but does not
prevent that callback from rearming the timer after the deletion.

Use timer_shutdown_sync() for the final polling teardown so the timer
cannot be queued again while the mailbox channel is being released.
The timer is reinitialized with timer_setup() on a later channel startup,
so polling mode remains reusable.

Fixes: f62092f6d77d ("mailbox: Add Altera mailbox driver")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
---
 drivers/mailbox/mailbox-altera.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/mailbox-altera.c b/drivers/mailbox/mailbox-altera.c
index 17278c2571d34..7cb91413ef7fc 100644
--- a/drivers/mailbox/mailbox-altera.c
+++ b/drivers/mailbox/mailbox-altera.c
@@ -270,7 +270,7 @@ static void altera_mbox_shutdown(struct mbox_chan *chan)
 		writel_relaxed(~0, mbox->mbox_base + MAILBOX_INTMASK_REG);
 		free_irq(mbox->irq, chan);
 	} else if (!mbox->is_sender) {
-		timer_delete_sync(&mbox->rxpoll_timer);
+		timer_shutdown_sync(&mbox->rxpoll_timer);
 	}
 }
 
-- 
2.53.0




