Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049456;
	b=Ykr8F9qujzvzJI6bIHaf2MCqTqBWUg9joUpoj3qwmDIRrvU8XRu/7igiQDOU2Ve+Yfu9
	 np/Tsdn1vmDmo2uls/UpqYRuH6gFNzNrtgZRlszLpDxkjAtn0mkwfDUKZBH1Smtcr/kMu
	 Ib4aPNzltIu2fSs24c93snd0OsvttG2jTzPQAGKJG++/Z1ukp+mXcwPk729qlT01kYlUg
	 jPxbGHozRg/xIXdyiC3Uk5Hg81j5YV+VwooABpFUjvAnmV3FJ4t5B0OIGp9rfkR6dJ/Lz
	 SLe+uw9kF/T5H1SRKvt6iio/whriyUsHHxEVex+dZzlPSMIle75spN4llwl7n0VzbUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049456;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Lb8lbGIm+Ja89vVRryn8Gh+rq9m+AUvl2FAYZst8r2A=;
	b=thP1cU59y9mnGRsamZfkPkV1lYXK0SD1trbvcvyGoVme/Z7IdHePmDON2bGdECWvxUn2
	 Cl05k91dlAd7Kgu0n2QhFONgBpRf1aGRdxETBiqkMSdg7PGXh7FbJVkvQs8rn2vSFfxj9
	 5DCKgmtvS/ToK+1Dg2k8trd80ZaEgJ2YjidbykQE7bDtDBUhzq8RHL1AjscoDUhRirvI3
	 EjdzUxSrxKVIvuVICPwpv3FgmksE34Ty0u5WsyPOZr2H2/ZtKxbjLCCnzSC1+Bv0o4FU9
	 ouVedQWkvI3lkMng8Xt9qWQ2LzVWeX5S50SlxswPkdFIiPRqz2itR2nhRJXf6vzNXOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JO4xFFwk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29017606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JO4xFFwk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E1E1F0089F;
	Sat,  7 Nov 2026 11:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049455;
	bh=Lb8lbGIm+Ja89vVRryn8Gh+rq9m+AUvl2FAYZst8r2A=;
	h=From:To:Cc:Subject:Date;
	b=JO4xFFwkRbhsO4MqxRTZVlQsmsfaCPmTp8GWwyMILjJH9raQI3UQd6NSR7mht0Iqa
	 UT0npOM1mJYT2zvfydRjC4UtgzuCLCzkb0tQG/p/ho7PzASNXb+/h/8qewADsHx1nV
	 srRpnZ6IXfKboI//UzuU8KpdnqRkytO2uS8oEkg0hhjR4KY1xe+0x2xqtCuxJhFwlJ
	 0sDvwyHbDTKyaw9iGCoG3yvfq1oJkCLeggLdEKTQln9S9eyVn/7lLX1vNFqHj+JXgh
	 Cyg+MURE6Nyg7P0QUfCoCW0l7DmYMKdIIwEe3+AvEa+QyBN0jLy2huDpWIL7rLjlsW
	 uPrnCDUeIOiYw==
From: Sasha Levin <sashal@kernel.org>
To: runyu.xiao@seu.edu.cn,
	jassisinghbrar@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mailbox: altera: shut down RX polling timer on channel teardown" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:04:14 -0500
Message-ID: <20261107060413-failed-5.15-0cf10e65639c@kernel.org>
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
git cherry-pick -x 0cf10e65639cba32d05994f85e6a8f08dd0ffe08
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060413-failed-5.15-0cf10e65639c@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




