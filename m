Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050453;
	b=FCzb23hWKsQ6hL6fG9e28o+oiQLpaR8BuD/v8Fc0L2NzxjsHUCBxKLOxAYztzFspmkDV
	 Qw1hI8WWJ/SdNzg90avET8SQrlsbjchldi58q/4CQmSgRH9BZPbx6bNiZVbRWqr1m+JuE
	 6UWu0S9sNDby/cKFYlOhTN3gftiA4XgHHfJVRJPBfxlVFyNGCa5Vi99GzUV6EHrp+/sl5
	 fBh2DMxNe6koBeJiVfXdhJehYfRz33XsA1oxjEssAQgb5lhBZQrIaQDGs1BoU8rUm8CnV
	 c6CAdURcohNiNhcBAf5I/jGk+9egjKkxM1ru0hfHc8L6f669ceBdk7AvFdQViGDVgsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050453;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=VvVoZPnm6Qq7UFQECwb0ypAHdL4hV8JQgl5um2KYNQE=;
	b=kpgVNfgCvXA5cmzNH9z9mUm5RrCGTre/NF73hyN+gqZEVdM8tn56uvZ8UpEIYBvmV8vY
	 GPpBWOscwX815TBL5efnharIHS7MNaCVBP13CZ/Tb+hZ/8zqgIHfpS6gatCgzjRm7CeYS
	 ZDypOr6ZajsDS8PnJSTk7HU4wWWiI0SZQkschyWC68zmiCksNRi5k5DhrNS82VG3f3Raa
	 50cjAvBAr+sJ6MJuof0N58/ldMmBhIlv8x0Am6ESMccFIJJ4iTkdRhbSE1zYrmBEWAZNH
	 U+lLETZtJjOtRAFPMvKhLHp5Yqhk8w4J3jhZ4zHoSR0XWqqmCFGg05GnIwqXpAHNfqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ojlNWZGZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53588606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ojlNWZGZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31E01F0089F;
	Sat,  7 Nov 2026 11:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050453;
	bh=VvVoZPnm6Qq7UFQECwb0ypAHdL4hV8JQgl5um2KYNQE=;
	h=From:To:Cc:Subject:Date;
	b=ojlNWZGZdJdQTHzJrpIjE8uIcwpb4zIIPT6MTnl+/MWooPotgUIVVTv3+1W0RHpOr
	 n5l0XWKaUpbAWFHues4pB789cVLeP7gTNWiVB8UqLYANfXKWzBP58fE3xHTXzonGnV
	 OTQ3y71cgxlQ3txG2uvMazdL6RhEQwIpsNYapHJnMHF3awebEAFnrDd3oqmyKluRWU
	 JOQPn9mhmBizfgXzDCl0pFdF/wOYOrn7q9iBePoJIQaL1X5tgw+S8fsxR+OVlwIlWV
	 XuYdvpEJs8lxZqOuncr3eXE9gOQBXhZr2QHk3XQ64N/9ZOzUmptXyE6CPdQVJQGqle
	 /fqpC8dpbW4Hw==
From: Sasha Levin <sashal@kernel.org>
To: runyu.xiao@seu.edu.cn,
	jassisinghbrar@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mailbox: altera: shut down RX polling timer on channel teardown" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:20:51 -0500
Message-ID: <20261107062051-failed-5.10-0cf10e65639c@kernel.org>
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
git cherry-pick -x 0cf10e65639cba32d05994f85e6a8f08dd0ffe08
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062051-failed-5.10-0cf10e65639c@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




