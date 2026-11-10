Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794326737;
	b=XDmIpPPpGheEbqNjAyGkX3y5W+1FbqrWZiupKvtuMdazS0VRCsV5t1J9dSRkbaODYbGs
	 Z5G+JZY7XCTAJ/PsTlLGPXlciU1FLMChOX5E0APz1sQ1ibajCtmhPQ5ApdrZaOHoBp/Se
	 nFMsPKC8CRCfgO206p6T0I6zuskZgk+NB6aWHDzuR0adpNCQH6qxWm83pFh2Y4CQi8rBX
	 x5peN6q6STDCEgYsSL9p1Lw6Vqr5ekeNW8/5WXkV+jeULKkq2uX0HMl5yEQBBxuBXZAGJ
	 M3JfKT4OtIPklcbmauqcjVM2quBxLcqPXWWxiaY6lfc9Y1qOs8m9V1F/wm51wb+cIDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794326737;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=sSAR7Czzwx1XfmUF9Dh8g72t3qn8YZFcmDOG3Qz821A=;
	b=JAH/pW1sCdF2wAObJkfi+TXn1LNQHFLjlRn+MzvQ1lG2PIyeW07fehQ8TWLO24lv1KIv
	 vRXxgPbXhhpG6I4iwql/JKBGnrx4zjo/RU5EoUxqxUM77ZPhh/TVRxFAp73t6REtyoiFi
	 vuROM4BBQF4w8QeQY1DsbT5stDhQ2Y0GLXi4wgjhaAWc09g40RD44B9hY2jTQwTyDoVqt
	 mdEBgDuzBfDUE58HDhvlRuhsZ0hIdh3t/w2qoDOR7bsdX/VqAjJHQBWouyUyhX6JVl9hb
	 LIB1WIe0DT4O/M+bRdAP0nit86co1g/HlGBFSksOCrPF3+HQGEibRGm4MXP1EHi9MjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="lOWIp/dp";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB76A606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lOWIp/dp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C0A31F0089F;
	Tue, 10 Nov 2026 16:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794326736;
	bh=sSAR7Czzwx1XfmUF9Dh8g72t3qn8YZFcmDOG3Qz821A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lOWIp/dpZ3P1gZ+x/bWIly99/mIjHgLOxbGYlHBJkyID69tg70M6z/H84PfRk1qDj
	 4l3e9ADnCwlcpe8s+IHdDm1ls9DQkaHdi3GwGV5ZX+ruArlEl2vP75Ot7HugeE6ZeS
	 9B9TDkJst/n0fWT/TN97ee5wUh0T5vOfIRo3mLFa0OqKDe1AoOWexgjxlTXARrHvE7
	 nyAZq6G2BoXgcdXylROow2GHwYi1xLBKIIJF5oyLDqL64narz8pdNBm+qyGq0Grrgo
	 tITAyaNt8PXtFWsh17clRjMYRtvvU0mpA5iGOJlcia4oHBQaWrV30xsu6cXGx7I5qk
	 u3MOEczIyNk/A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mailbox: altera: shut down RX polling timer on channel teardown
Date: Tue, 10 Nov 2026 11:05:34 -0500
Message-ID: <20261110160517.2394982-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054642-failed-6.1-0cf10e65639c@kernel.org>
References: <20261107054642-failed-6.1-0cf10e65639c@kernel.org>
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

From: Runyu Xiao <runyu.xiao@seu.edu.cn>

[ Upstream commit 0cf10e65639cba32d05994f85e6a8f08dd0ffe08 ]

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
[ sashal: replaced del_timer_sync() instead of timer_delete_sync() with timer_shutdown_sync() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mailbox/mailbox-altera.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/mailbox-altera.c b/drivers/mailbox/mailbox-altera.c
index afb320e9d69ce..e81c8bac651af 100644
--- a/drivers/mailbox/mailbox-altera.c
+++ b/drivers/mailbox/mailbox-altera.c
@@ -270,7 +270,7 @@ static void altera_mbox_shutdown(struct mbox_chan *chan)
 		writel_relaxed(~0, mbox->mbox_base + MAILBOX_INTMASK_REG);
 		free_irq(mbox->irq, chan);
 	} else if (!mbox->is_sender) {
-		del_timer_sync(&mbox->rxpoll_timer);
+		timer_shutdown_sync(&mbox->rxpoll_timer);
 	}
 }
 
-- 
2.53.0

