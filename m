Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794326558;
	b=sIOk+VtTVVnCkh2u1YKboL6H+Ak3zpiomv3kjKwNbLDdr1PfpLmN+JiqbDSTp9twUnQN
	 OagDMw8LXTbkv/Oa9ImeQFXG5XzPUXjT40HNJq23wMs9R6Xt1Na+YIPPTy7DHwlhy/tze
	 qxIjRG0roqUi4+nVSok/XUKRH+Cm5+N9YzJozh+ddIA+qG/Xgu1DS/axeiMDBg/nMFInw
	 nGU0hJQLfPIekoY9Nrl0gTvy+w+ySzNkUL1JkyMFHtLe5B6AiPg6YSmn1AD0+KnqMdTdD
	 iHQPPOI8Ifv+k78OjlNIQf/j+VB8QPuqX17T4kKIoqyTy6eKOHDV6J8ku0lWi+Ntp0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794326558;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=VLHBmO7s/xOwojd6Exy/6PvbLeZpbUNFO2OUxvYqbW0=;
	b=UTXgX1SYbcvoDuHPEekjTnhcIzHrK3JOECNoqYLI9mjWoPhUPH4kJaUib0nskpxjH6/v
	 BrKO5Q9u3dfxjSPGdYcwvi1aRDJO+1MFltRtVM7nGTz1qhTbghO45cuOcPARYwFAFOTWK
	 yQMdmvL6wflu8yYdvWelqZFr2NCSb7ixludo7iIcGSFOUKwr7w1T3x8GUVDWyzYouVsQn
	 8d2GYB0He1pr+WI637oqiJ+40IQDJbhIDNfNyT5/p10QyY6RhbvC0Xn/tJYHOWhaRZI1d
	 Yrva59+50AKKu/XbIKdlMtsZdxqGXVYUjBv5jtE1T5Rcu3yH8hZ6+VIsnRfrRNw1QFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="nqNC9/jA";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779FD606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nqNC9/jA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9E6A1F008A5;
	Tue, 10 Nov 2026 16:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794326558;
	bh=VLHBmO7s/xOwojd6Exy/6PvbLeZpbUNFO2OUxvYqbW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nqNC9/jA2H/HnlLxot05f1wVGI7Tf2QWAuOtpn6R6VYbi+0/vPVqxGvF//4+EO4Z2
	 9vFv3TuzbiHd3bCUOUXJm1EOYX8t/WJ+cA4hH/hj1orgMijrrH7tlHYkhlnBEDBxCA
	 E8jkbP1pBjIljUPbpFmQuh05WZdUumGWQuDWzGXKHkHcVDdd0HAdxZz8z8Rz+fxUkR
	 S+Sk/aA45ts/vGv6ATODkfDOSuqGIBr6aoEIRXP83qJNXyIHYzmD4BtoTnmwemz7fL
	 yuTlrtoc2X20ydKJGHbCCK5qWcLP0f/i285m6bu72LNxLR/z5eVVGw/TLsd6snx7of
	 idiDMfuUnjU2Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mailbox: altera: shut down RX polling timer on channel teardown
Date: Tue, 10 Nov 2026 11:02:36 -0500
Message-ID: <20261110160212.2387620-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053333-failed-6.6-0cf10e65639c@kernel.org>
References: <20261107053333-failed-6.6-0cf10e65639c@kernel.org>
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
[ sashal: adapted the timer replacement to del_timer_sync() instead of timer_delete_sync() ]
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

