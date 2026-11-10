Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794326337;
	b=YNCJqgbio2jifatw9lzyewski8haxxnLspyIRDQKW11VBbYI2+BgDjkjbhRBtnyVeDX9
	 XK6BJC8wKzvciaWEKR754JYNtj/aWxg8vmSb8cfbyiaFe8kHGsIHsRqE+d5WAriwwIkme
	 69versf81RKkv3lPHC+0NKa5FpQijewB9ED8iJHrtgAFqk1I1gIIhP9n1NHuNlFArgTbS
	 s31qLh0fB8+MB0T4iw+sAhA3H0xwf8k+mVh3FA150bMyOWodKmEVLWGjqGG/400PTKex5
	 aHg8sCgbfONRGueKV7h1NwKtLwK+FUunV9cHIjEU6K6JsyXuFERqcNvz4vrJpT/ylDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794326337;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=thSK09LTo/K6dYWTpPKx/zyRUFtY/zQdEX/rrc1zqlo=;
	b=lQaZmAAtIVU4RJ/3qTbHraEzvq5PUWF5jrWp+RcRO2HKUfrhrJhc/P1nB9YmXVGlse1h
	 IXdDc0NC4PMvwf3NjUlde7A9k1zj20ETXapkJb9BJ3YJnUq1hwJWL1RA84BSTQiiufITH
	 a2Di3nRtRIql5tq2Te+d5MZKPjYLlObqDvWwu3sq7+WOY8IS7PSdsLe6DRcuQE72sDr18
	 Bq4xXmFzUi+JV4brD5nWuk4XsiVIKvxVyPHL/paYidW7mzN7MFDtCdcthaAw+nCxWItzL
	 fDXxtxi3wlvu/yUdlnLtmb3WYKx757ZjhXj35Sjk6nr/1krbb+2m+OpP+YF2ocewWwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XyhMgWK3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA6A606A32E
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XyhMgWK3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692CA1F008A4;
	Tue, 10 Nov 2026 15:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794326336;
	bh=thSK09LTo/K6dYWTpPKx/zyRUFtY/zQdEX/rrc1zqlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XyhMgWK3u0T/MM2nEydyPj7zklDrh02+L9eSHKpDZOrTPuDqqfG+C+ugFmmU77oEw
	 Bhqu8XwaC7kvS09Ni6du1CuVucKGfqgl3URiI/Hz1LA2uaBF/+oD13U4gB4mB2ZbK3
	 pC+kM3VsqFx8j8RkY5W7NaJsOeETWRlaq0K/VX0xg9vYtaPrsTvUT3xAPFqACWgPYI
	 uFrH2uZOQoF/qqta1bxtT59K5xYF0sw9B9BXn4KEVeQAXrv7AVDDqKmgip1+b2X+pw
	 SMpvMFNDZEFJoaeu/NiiGnCfLSXCvCQs1YwgTfgOZste/p7TZ9UcRFC49TvGN4raq8
	 qfveltrlY3dyQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mailbox: altera: shut down RX polling timer on channel teardown
Date: Tue, 10 Nov 2026 10:58:55 -0500
Message-ID: <20261110155835.2357221-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052107-failed-6.12-0cf10e65639c@kernel.org>
References: <20261107052107-failed-6.12-0cf10e65639c@kernel.org>
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
[ sashal: adjusted the patch to replace del_timer_sync() where upstream replaces timer_delete_sync() ]
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

