Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048405;
	b=ArYCnqpE7ldNoo+fseCJmTlDuhWU/N5EsIgxsKMWNZlIs/b5qrThMpIgiE1nRXTM1FtO
	 ZslVzm09iP1/re1TNTx5TrNg5ytAS8JyJxWSH1xU91P4OF9p1lEUDz8GzuWRoaeGu8GQ1
	 0TLIkJrC4M9nhMKdA40za8CYc/gFB1EB2Qyd8iwqVDQGDVSfeyCEBtf56GUlT07BuW61y
	 M7vJ7Ud+FZxeAQi1l2aaIGzKLWoh5SYgiEFG/M7KPESbYG4GWiH+EgP23MugLrbBOipDk
	 pDr8ieL69U3paeOGx/w/V8nUmfby6EMuFUpT8LHVGvRj6/icXrGX/lOtLTZrw3PJc4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048405;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=WXwuCYZiNSa1Z366a4NG5Tt7ZCIs482cJbVQMf5/UyA=;
	b=oUSEPp/q2/dvNUwl7/0J7pWAv5/fSCQvWq5cm1SlbwcX1ZKNcHulSO0zWMKyMfrb5LkD
	 mAVJqLAEZsKVjQ+3xuPaR/4XwFw/P97y6D2Txii/fM/pLYq7iozUULbIrr85si8wCdD9j
	 Os0ADYgS9d2sCm4k7rFbXXFH0w74I2WrwYoAbG4CVD+xJShjG/gEO0uaIJ9ms71mjMTyV
	 CFp8LZ7c1XOIursMhtuBpgJxsqAEQLb+hoyUO2od8yhxlD4yXrv4Qh5QOOiJDTi4d4OkY
	 iVhNui2+aFj+5b4lBJ0TC2fUybThPro+ltCYTnyp+1Y3G4uWJ/oAdgxtGSzLlp9aYRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bxm1SPpK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31AC606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bxm1SPpK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EEC21F0089F;
	Sat,  7 Nov 2026 10:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048404;
	bh=WXwuCYZiNSa1Z366a4NG5Tt7ZCIs482cJbVQMf5/UyA=;
	h=From:To:Cc:Subject:Date;
	b=bxm1SPpKTLNhsn/Nb+YBZp3CKxoFCuLFNYvt1c5+1QPFfGg2mrhVmxaU5SV3IprAh
	 tZNPdXkICMWMtuLInxLSLQ0WXx5ohI8QMFNSpwD1y9GsqGmBmG//f4HbwBGbBxEYlV
	 y3jOv0+Z+61ZUIOIZEBSOu9z6WzMvKECJ48hO+2j7tw81F7T0p3GDTHBRez2KXoKz4
	 Htfk9xf76Axa9yDjSFqTPO1hR14xWzhdLgRWJmdwMHda0z+tCXtAqCRPzWpWJig3/r
	 5uWG3nJJC7cNawwEgbSDZF3P3HHMtY983jgg9/1MhIawtJLv4SKbhPjabXZ1+cOGlA
	 75suYOB/3VMFg==
From: Sasha Levin <sashal@kernel.org>
To: runyu.xiao@seu.edu.cn,
	jassisinghbrar@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mailbox: altera: shut down RX polling timer on channel teardown" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:46:42 -0500
Message-ID: <20261107054642-failed-6.1-0cf10e65639c@kernel.org>
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
git cherry-pick -x 0cf10e65639cba32d05994f85e6a8f08dd0ffe08
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054642-failed-6.1-0cf10e65639c@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




