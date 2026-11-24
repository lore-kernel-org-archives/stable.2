Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795533068;
	b=gJGl6rWhZc5cdZ4luG/HhRbSktSbOutL4o0yuaj6V+psVmgXzI0m0saSIzEkKNtRPJzR
	 YDGXSWxuwGy0GlR1yrvn7sFmkCeQQ+BC5O6xnkv4s09Dgbj11G8w+TWTR2uRvnMuk4Xry
	 XdO9tkmA2xulhEeora/OS3h7k7tVg+oa63gQ3gR9H0uv/9X0sUOqRCa+EaMRbqIc4/R3C
	 gzUsxPeYoD5YtAGaGpWtu1CBDR9s2y8b8uTG5QAibK0vyKy9F2veVOVWIWvpTwU3Awa2E
	 SqDYmgFlD4FEgW+F70mxUljULG9YqGbmleiJkagnIKuzR3QoAhjpOAWTxXDWAkJf59g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795533068;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=+kKF467m9GtT8kP3Mv9jVUHq04Tqfqk4uC6CC+ky3Yg=;
	b=M+6aTz1Ln1GKB9dmvpQtksWw6C5t30eZni4r+b5KtRL4eT2/Adux43UN8XODDoPu1YcR
	 3bkqEOL9W77T5RHWEjwQizuUS9dAoP2ECj8HTRONru+0dVPuaTLp4A/b/0r2DOmFwtodY
	 t8VNgOeHSmkiKzXSlEXLGg87NV2fei5OitauahMT63NA+GJlgsBr3sfO0nwjrRgL7NLkJ
	 xNS4+bhHac6CWvLOhQhNNGRNtaAXzs4qsB/8qAvqsiOtl4WeTSK052S2BD8Zwkzk/URUY
	 +FDHprQ9nvj69DqaZtBX5nIx7SyTNkEJ5XqkoAtVqJ8faJqF/ZScKcfrPxzOuCpn+Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Yb6RckEK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C070A606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Yb6RckEK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A10E11F000D0;
	Tue, 24 Nov 2026 15:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795533068;
	bh=+kKF467m9GtT8kP3Mv9jVUHq04Tqfqk4uC6CC+ky3Yg=;
	h=Subject:To:Cc:From:Date;
	b=Yb6RckEKtvVV+ReoI2LJT1FnkAHpadRfKahlk/NdSieZ2aBB99Z7pY+jOmfQ0JzMs
	 8NmWEW8xxg/qY5kQH9Mra0ePt94DeHfGUvpei7RTgWsHMt0NLABkr//GCGia2seaFp
	 9SQ+dvdiMEditYp+LDZmo35pCAFFDeFMg72PHza4=
Subject: FAILED: patch "[PATCH] mmc: omap: synchronize clock timer before disabling fclk" failed to apply to 6.12-stable tree
To: runyu.xiao@seu.edu.cn,ulfh@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Nov 2026 16:11:28 +0100
Message-ID: <2026112428-nullify-reactive-9011@gregkh>
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


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x c931c51681e33b24bc8d65c6df35b70e1827daa2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112428-nullify-reactive-9011@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

