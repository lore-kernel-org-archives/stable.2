Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795533087;
	b=ENzaVGF7NBOeb+acXSqC53wG/jqvP2rZGDmDubOxtXcfmZL8AGs+s4S4aoTNnYHKUju1
	 l2viq0VhcXk1rlMrRHogwOMiNSb3wkYNxu8WVTRqp4u69XKOjVryA+Btq937oCMB2s7Xq
	 TvlbY1XODiVHiHdxLRLLsI3RF6PW3NoQI17gKfkJ8aBs+rO7DhwRtiHAI+sVdYRXn+AWm
	 n/2FF9Wot9zcSMChH9XduQ5xFCnlM+/Ry/IssYgUNividKr6EECax7r7JkYUMiWyLs7jH
	 uQzF1V8XEqCKm9PPJI9vFtnyN/Va4q+IrHCKqYIP2MnqFA+zDlkXkbDLMz30YgDk4Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795533087;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=SD6pU6DYQavpD+IB/UYZ2o1sMZ65IbmyZCEbq/Z7hLk=;
	b=TUktHByrAT7u4F5qZfnt825oOuH+4H0KEoRyjRKp4orv7/wEVw/sB4THBXN3MfVGQgC1
	 JdBwn6/8E3tu/Pk687jvP1Yku19zTjB+rFQdvE7fZKgXmWJTQbHPnJ9eORBc5sFXo46Ku
	 l6EmTFTQKTRLbXRvdC7p+1EyXs9yoh6cpIRMcSKKWEtzCPmvcBCdz0+6XY0t8Eo8iQxFu
	 B9fom8ragVko/sd+sPdZF3bkrrzfMf68wFhKeK3AmZYMldU0EROaDbreTn3AJQPCJclKb
	 cRv/PLeqS7+hSX6Kf4w2sn86JnPkUJNr62mUE63EIBO4vdftwJ5kmjG2LXNJQHQl64g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=a1GEh2gU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E400B606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=a1GEh2gU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E0E1F000C0;
	Tue, 24 Nov 2026 15:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795533086;
	bh=SD6pU6DYQavpD+IB/UYZ2o1sMZ65IbmyZCEbq/Z7hLk=;
	h=Subject:To:Cc:From:Date;
	b=a1GEh2gUsm7zrblsXnx/XX3ryaMau+1qoIV2blmfgCrjwVKeIrZ3O6YSlsNcnuWrC
	 HwicAmuc4t0gQLo+oNBmgf1e6u4IMEgoYm0WxSCaPyEneCBkdm8JFVXfjLdlHaY2Oy
	 cweaPA/YPwdWCMpQpc6nxxVrNt4ANyyiM1qXz7SY=
Subject: FAILED: patch "[PATCH] mmc: omap: synchronize clock timer before disabling fclk" failed to apply to 5.15-stable tree
To: runyu.xiao@seu.edu.cn,ulfh@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Nov 2026 16:11:30 +0100
Message-ID: <2026112429-handgun-idealist-1f47@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x c931c51681e33b24bc8d65c6df35b70e1827daa2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112429-handgun-idealist-1f47@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c931c51681e33b24bc8d65c6df35b70e1827daa2 Mon Sep 17 00:00:00 2001
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
Date: Tue, 29 Sep 2026 20:45:22 +0800
Subject: [PATCH] mmc: omap: synchronize clock timer before disabling fclk

mmc_omap_select_slot() removes clk_timer with timer_delete() before
switching slots and changing the functional clock state.  timer_delete()
only removes a pending timer and does not wait for a callback that is
already running.

If mmc_omap_clk_timer() is already running, it can therefore call
mmc_omap_fclk_enable() while the request or slot-switch path changes the
same clock state.  During host removal, the same window can overlap the
final clock shutdown.

Use timer_delete_sync() so the callback has completed before slot switching
or changing the functional clock state.  Keep the timer restartable for
normal request handling.

Fixes: 0807a9b5739a ("MMC: OMAP: Lazy clock shutdown")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Signed-off-by: Ulf Hansson <ulfh@kernel.org>

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 527b89a5ed70..02d288e4e9dc 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -214,7 +214,7 @@ static void mmc_omap_select_slot(struct mmc_omap_slot *slot, int claimed)
 	host->mmc = slot->mmc;
 	spin_unlock_irqrestore(&host->slot_lock, flags);
 no_claim:
-	timer_delete(&host->clk_timer);
+	timer_delete_sync(&host->clk_timer);
 	if (host->current_slot != slot || !claimed)
 		mmc_omap_fclk_offdelay(host->current_slot);
 
@@ -273,7 +273,7 @@ static void mmc_omap_release_slot(struct mmc_omap_slot *slot, int clk_enabled)
 		/* Keeps clock running for at least 8 cycles on valid freq */
 		mod_timer(&host->clk_timer, jiffies  + HZ/10);
 	else {
-		timer_delete(&host->clk_timer);
+		timer_delete_sync(&host->clk_timer);
 		mmc_omap_fclk_offdelay(slot);
 		mmc_omap_fclk_enable(host, 0);
 	}

