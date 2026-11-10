Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794326896;
	b=OOHiH1PqzpZCo2vANS56G9ARwFfZZ4cc2AfoNRykAbJABFcIm7ma0CdAPSW2Iq3uVBEB
	 XvwV1LL+toNyTynLxRNc9Kk388JtRa/x2nhVj+W+gSRQTJRr8hAbvyqI+2gWW4wXsAflo
	 pkjQNZlhycL0B48xgorpj3D3la7C1IORsLk7nWPNBtm0uEs2zM7NO1yGZ73p7XT1IPfd6
	 YAHWI+A+7t4WJxFN0vzggRQH4TektBIJcVtO81onOhODue1ait4ZZKdW9G8i8UgQH5cRs
	 /vaovrmDwXdqhJXCxs9HtKibPwqiourB30YgOvdN+PdzBZPg7qthdXfwDFPxNtGC1bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794326896;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pCfZ7FC26+7QZ6BLpFEHkI+xxPTfMD/zdZIiqvWALYs=;
	b=eQPr0VntXGm40u2V6UJXpwce0JeGaHhdsTWrPBR4IE0ImCYhwFTiFKKY7fumOEhNKeI5
	 Z/l/5JQ11Jgi5pPn49OqWk4cNgrzR+7+nlGSV0dTo61BwQvQfMrZ4ZHYmFMrYEDXRxO8v
	 bmLk/tXFH4BDQVnWUOo0eAuuFQtgHVG0c0/zyVvrjadQZOhwvV2x5uGnEFaUT54zY+aZ9
	 xWEbOT2g7WQNIzVgRPHN/6CKQ5XF6uvU6lf4nMQNdSbIbW+uF+msG2yzeuSYrDAk8eHCh
	 u/E88KPpD6IfgkJUdPEFVA2HxWWcMz/v6W6r8Rdtypcc+V4grTIf+8sI9CkKF+CsjGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SsXFOs1a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDCA606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SsXFOs1a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3CE01F008A1;
	Tue, 10 Nov 2026 16:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794326895;
	bh=pCfZ7FC26+7QZ6BLpFEHkI+xxPTfMD/zdZIiqvWALYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SsXFOs1aysRymIco0vZS91G7xStyj4bqELa7r6HHaHKOskdBHEDzljLe4n4S8G6DZ
	 gIXmbdySqyq0Me2H3bId/k5izolzECVjsj6fgg8HMfLoJjkbsIfJ9iIzh+qctEwMR2
	 zLJul0Xzajwh5PIOZfyi5VXfMT6Qq63Gj42hNM0Z/dnLokD6iFSof05nHCoCbn52aI
	 9WvSAffixd7Jo77wBMimFNdspNAlxpiEOaXCA880KXoDfIPP2rxm1wnLmNLTsMNi1j
	 tMSlkcmRoP1kvFelfnQYBtRPHBuxSdo01I8tuKY9Es6Wr0YjiAo0YpZa3F6i7vQmXN
	 7fJvWOR+E5p8w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] mailbox: altera: shut down RX polling timer on channel teardown
Date: Tue, 10 Nov 2026 11:08:13 -0500
Message-ID: <20261110160753.2404426-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060413-failed-5.15-0cf10e65639c@kernel.org>
References: <20261107060413-failed-5.15-0cf10e65639c@kernel.org>
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
[ sashal: replaced del_timer_sync() instead of timer_delete_sync() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mailbox/mailbox-altera.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/mailbox-altera.c b/drivers/mailbox/mailbox-altera.c
index 75282666fb06c..2b1be8828440e 100644
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

