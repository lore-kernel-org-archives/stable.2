Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795533083;
	b=RxPg3sQoPNdLjQM2euF+LwZoSocXVKSc3uRA6semnMpp97wQD6aX2XoSxs6JEMu4hxWY
	 zYEs4EDyv/NeV72fK9CoQeKhG118I/v472LUd4VCcvWz8jKeoHMb46QPP91avHueYamWi
	 6easwGHF6IidoJC475soALDz55eSiTJW5oQWZxyHQLBUyqzkL6TngqkCux+AXOGsKy7Nb
	 RwnuDnXdRMTU/kLek9iBaHZJgy+932gRvEllt3nM/++nJfwiIAabV662R2z6kVO+jhfpO
	 ImCQzdDs5WWVUUS1cPz+jauC7UPlxkz2YiKRupPGJD69E895VdzIc2ArAmxE/DGNBpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795533083;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=FoCt5litKUHrdNrtlJDySp7WXZzqnATGrPBjgi9yCsI=;
	b=psEQygUuI0KQSwZaJ5jSHnQxrWNWcAI172N8AcDbuDyqJDo7LDP98aiD2Rq5PUD+V75y
	 bHqSU9/U7Y/1bdfKUHrLT5SxF61hs6siceTLUXJumFurx8z1HV7Wz6HdQN69NrcQ/W2NC
	 Qn8cKWn5EpZd35ybdezm5Bn7RekkTWma9YUsFSMIyvpD9e+uJXV3d1nyGIhXwRbiGdu36
	 KwizwgOkKbiHTpfSE2ZYORP1dLkLlvfp3pIwUJlQetokplFJEy7kH2610P1VVQ33sPCnl
	 RkGtXXkW5AFMnUKP0z6iGswBrSwrEK5NJiexNxMqusD3vdGdLS0XqJUzuZxzkKTCJww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="h/9aJyth";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B51606A329
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=h/9aJyth
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B71221F000C0;
	Tue, 24 Nov 2026 15:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795533083;
	bh=FoCt5litKUHrdNrtlJDySp7WXZzqnATGrPBjgi9yCsI=;
	h=Subject:To:Cc:From:Date;
	b=h/9aJythaxcPFXHR2Z24dzaGXQg3CsaIrVJLLBI2OhFHIAqErrR0MtgOY5Wv4P8rX
	 wysZk57B4harAyl0DdiARhYRbGyUjWLbh9gY9D9dNDhluucIgycvSwo3n0llcSMCjs
	 DARMIXU7og+3qz1cwGTSSYSAPLS4etSDUNE9s+6I=
Subject: FAILED: patch "[PATCH] mmc: omap: synchronize clock timer before disabling fclk" failed to apply to 5.10-stable tree
To: runyu.xiao@seu.edu.cn,ulfh@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Nov 2026 16:11:30 +0100
Message-ID: <2026112430-lemon-ranging-6009@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x c931c51681e33b24bc8d65c6df35b70e1827daa2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112430-lemon-ranging-6009@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

