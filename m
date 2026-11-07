Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047615;
	b=n0bjtI5dJTQwVZvl/arlK1GwI8dCLlM226KXVE+Ep5oh+j60UMAQnPwSlCpW7grurbcm
	 RTmuQ6TZMkvrlVa9Sc6XQ45/Rde1F+e/HWMQBF1cbafvT9Z7lbmm/mhX+P+2fdB3YDoHY
	 hskcFGc4fxs5gi2/FtaysfWjHvPZNfXNjnRsRT+f7gbszzwdxgdoOff7uldBRijDMyxf9
	 2v4uYoVPV4NvikJLXxjIdWmB4l1RD3R3KTSKDxUPHNr9RtgbjjExuNIoz/cdWsjEZ/Yok
	 pZR+rsDSqcbdQUocSG3n+5AdRsuwyJN5qzpc0NJ84DlXJ25xLHD7CK0SUAyie4+WORQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047615;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=W0fLuKR5S5whJtYKuapNaz+J1R175rR5pi2fBhqz2Eo=;
	b=p0FV/YN4avwAg2Jp99IGrlbOCgTxWfCtuOIu0i8ktIFoh2ggQjRClaistQgcBHTo3+Sb
	 SzGOVFuhdWBxW9yZ5Hsql3owWyMEO63vbfJNOs5w4sKqpQoz+wCSrGpVyeMLYsmB28gqK
	 iVfa3yu8W7oQODm/XoTL6Yh0mvNwA3iF9ZoN/BBID2G2Fyhb00jgf6BqIPjZnBVdLnYZH
	 ozekSgBrMTUWjOopMtIQnPCTTZ5eNrW46O4u+e8zC7I2NpBprDVCzyDP1B8JU8404LTAJ
	 rmIoQEGAer1XxiPVzkc1n5fHhUP/7ax+4CM100sj4kZlmVHEw1qT1Gta28JKeZZAlqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JEH96y2n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C2B606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JEH96y2n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66BBE1F0089F;
	Sat,  7 Nov 2026 10:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047614;
	bh=W0fLuKR5S5whJtYKuapNaz+J1R175rR5pi2fBhqz2Eo=;
	h=From:To:Cc:Subject:Date;
	b=JEH96y2nXmg8OnEVp8ASENBOnd4rpz7BP0nW5XiiIQ3GJwbH5KVOEid6Z7kPaQAvl
	 w+xavla47R3bc4FdE5zmY8fjvkFushlnXGdV+vri5oU8IuIk2hMydxyauzxSZuIQTb
	 fAypFKbCmrVHbatDGZEoV9xe6TNUVG9ivqd3R1ipeBdVYYYQCKRuN27VWV5FamOCPw
	 bB1k20+/O/EcNajzRJx3AAcfifRQ0p/MJlAuco7IhzkTOjn9n/tcHWX5EoCLWut2fo
	 3Ys/Uhs+ai6BIHs4Mq/9iAKEYrOD9Ww4gTGOCZtNhdEm3X84IGX3IseVjZ1Kl6Sdt3
	 wkbmZVdnZIjWQ==
From: Sasha Levin <sashal@kernel.org>
To: runyu.xiao@seu.edu.cn,
	jassisinghbrar@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mailbox: altera: shut down RX polling timer on channel teardown" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:33:33 -0500
Message-ID: <20261107053333-failed-6.6-0cf10e65639c@kernel.org>
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
git cherry-pick -x 0cf10e65639cba32d05994f85e6a8f08dd0ffe08
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053333-failed-6.6-0cf10e65639c@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




