Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795533080;
	b=Wde0VphbQS/Rtvjj/XMVNoMfM/K2Yi5E9KbZ2+/TcqwWgAAWgq7a7d2qG7c0rTMB83K8
	 Sst7oaer7cUCn43IphKrX/tAxXY8A9I2U54W5lgRgBCwRMwRsUBRVjEmCE5SH2NJKz0ZD
	 Kn9zg9wnjjHNx58ElIjKz25AFXYieIxv3n4e25Q8GET859tqN9hqnXZew65B5yWg+kir0
	 D+8i4py2uzvc6Lk/jbU/3V7aln43VV2XA0DAEZ2YosSAXQHer5cH7XbhSzZzg1iHhIoV3
	 zEAVsA/VVZ0np06Mq+K/t2xki103eb9gzpQaBxsqbOpwzXJBNDC/EdR3msU9Vv9fXtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795533080;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=97taPdwtcGTFso+thWzmkE/zvQdEsxoxQD885MBFgQs=;
	b=RUPMiCmcDLJkJqqtpJNJtdix7mE6pIwV2xuP9BVeYBK3xiAXUMAkZ4uxHtKDX+EhioDT
	 D4zbv2GxpxjdyCSIDbct6CvxUQ5tlU41vzRTwoshaisy+OMVMXV/wNjDS0TA/J8SOzNjk
	 eRO926FPC0HheAiUN0GnU14fme0a5B2btmPCVzd14Hj6dWpRVi+HheKSCSwQ/4zJz8eD1
	 0nU0cg8pnmdYHkRdYVEPfoZdgGy2o+WFJliVftP227p/lJRs6L0G2pAgi7i2tQpEJjGHO
	 HQ+i9anG/+xbzQmn4u+/J/B805BuZIZf5OdQA1OOuymHpXRty5BLcoJ+mNYVFEj5z7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=wS9uX9dd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A8C606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=wS9uX9dd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FBC61F000F2;
	Tue, 24 Nov 2026 15:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795533079;
	bh=97taPdwtcGTFso+thWzmkE/zvQdEsxoxQD885MBFgQs=;
	h=Subject:To:Cc:From:Date;
	b=wS9uX9ddrzHii39I6Wzz2MyLsQe+NuWxrhtYpo+nBujfFdV0MOdp6yZ4rdWJgUPjI
	 Uy/6cXr9KchkZy1VrqBdafMoWQy3ykwg23TGL1zxku4HYZUgdpbaEuG8VfVbwHMbAg
	 Z6mMuXGw7nUQL2oAyLOkiWeUBt59YF4y0lmvfVgs=
Subject: FAILED: patch "[PATCH] mmc: omap: synchronize clock timer before disabling fclk" failed to apply to 6.6-stable tree
To: runyu.xiao@seu.edu.cn,ulfh@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Nov 2026 16:11:29 +0100
Message-ID: <2026112429-daintily-sanding-7cf9@gregkh>
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


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x c931c51681e33b24bc8d65c6df35b70e1827daa2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112429-daintily-sanding-7cf9@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

