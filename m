Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043A34E235B
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788449869; cv=none; b=Ij5Q7sk6+XNv9F7MEgvtjLjfpc7blU/LcmyZRXqr7Ar+HUU9A4cUuE0PaRwXsi/fXf2PmnCTffYCeqvxiYJYWNBCSW13Bn7Ej+V/GOoQBKIs6j9X3jtNSCt3MHT2LEWvwghBcWiBpO5tgADHvF485QgRlI0AoBW4OPOoYHcEfcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788449869; c=relaxed/simple;
	bh=K6LYi1OO6UM31V3wGtRGZvlY9YRpXour6Wim8/FDWz4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ttbo/wTuWrWWdHD4YdsfgbEBxyx1J3+HYxRsf6MFFI3X9OOdOsrZGqrEbrcD+UPoEqwHKKLEcquQRL94fnf7ThFSFYQt5PTnr+1jzjoelbmj/xU7nAMJ++wO457xIK6ArzJc3PcMXJyJjMKHKHPRULiJyFMXXEBB4R7pBUGePII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2kXKaNR+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2kXKaNR+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 604E21F000E9;
	Thu,  3 Sep 2026 15:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788449867;
	bh=x/PzZcQ9gSUQlxzJh8uxyajAHTkl1+4PsM6XYaKQU9M=;
	h=Subject:To:Cc:From:Date;
	b=2kXKaNR+cLjSdWFUXNuvcBeLjsNuncF1PslHoUMfjUReOh3DPkHMIYLmPBRq+9S8r
	 8qPoAb7PN1lm+214lc5o+ALh3xszBhcgCT4swnZbp0TN+DCWo083IYz7pQD8zEDOCl
	 7iBVjp8uaFOGkZDtFSd25YKtP2qelwiczKocT/ew=
Subject: FAILED: patch "[PATCH] net: ravb: avoid dereferencing an invalid PTP clock" failed to apply to 5.15-stable tree
To: luoxuanqiang@kylinos.cn,kuba@kernel.org,vadim.fedorenko@linux.dev
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 17:07:22 +0200
Message-ID: <2026090322-boss-emu-7014@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x 1f77af0aaf277413ff32f6ff8c2c4282bd64c897
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090322-boss-emu-7014@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1f77af0aaf277413ff32f6ff8c2c4282bd64c897 Mon Sep 17 00:00:00 2001
From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Date: Tue, 11 Aug 2026 18:37:32 +0800
Subject: [PATCH] net: ravb: avoid dereferencing an invalid PTP clock

The PTP clock is unavailable before the first open, so querying its
index can dereference a NULL pointer. Registration failures can also
leave an error pointer in priv->ptp.clock.

Cache the PHC index separately and report -1 while no clock is
registered. Normalize registration errors to NULL and preserve the
static timestamping capabilities.

Fixes: a0d2f20650e8 ("Renesas Ethernet AVB PTP clock driver")
Cc: stable@vger.kernel.org
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Link: https://patch.msgid.link/20260811103733.62599-2-xuanqiang.luo@linux.dev
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index 5e56ec9b1013..2a4fcb12a63c 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -1028,6 +1028,7 @@ struct ravb_ptp_perout {
 struct ravb_ptp {
 	struct ptp_clock *clock;
 	struct ptp_clock_info info;
+	int phc_index;
 	u32 default_addend;
 	u32 current_addend;
 	int extts[N_EXT_TS];
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 5f88733094d0..db0229e00849 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1779,7 +1779,7 @@ static int ravb_get_ts_info(struct net_device *ndev,
 			(1 << HWTSTAMP_FILTER_NONE) |
 			(1 << HWTSTAMP_FILTER_PTP_V2_L2_EVENT) |
 			(1 << HWTSTAMP_FILTER_ALL);
-		info->phc_index = ptp_clock_index(priv->ptp.clock);
+		info->phc_index = READ_ONCE(priv->ptp.phc_index);
 	}
 
 	return 0;
@@ -2953,6 +2953,7 @@ static int ravb_probe(struct platform_device *pdev)
 	priv->rstc = rstc;
 	priv->ndev = ndev;
 	priv->pdev = pdev;
+	priv->ptp.phc_index = -1;
 	priv->num_tx_ring[RAVB_BE] = BE_TX_RING_SIZE;
 	priv->num_rx_ring[RAVB_BE] = BE_RX_RING_SIZE;
 	if (info->nc_queues) {
diff --git a/drivers/net/ethernet/renesas/ravb_ptp.c b/drivers/net/ethernet/renesas/ravb_ptp.c
index 226c6c0ab945..cbec7c057d71 100644
--- a/drivers/net/ethernet/renesas/ravb_ptp.c
+++ b/drivers/net/ethernet/renesas/ravb_ptp.c
@@ -315,6 +315,7 @@ void ravb_ptp_interrupt(struct net_device *ndev)
 void ravb_ptp_init(struct net_device *ndev, struct platform_device *pdev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
+	struct ptp_clock *clock;
 	unsigned long flags;
 
 	priv->ptp.info = ravb_ptp_info;
@@ -327,7 +328,15 @@ void ravb_ptp_init(struct net_device *ndev, struct platform_device *pdev)
 	ravb_modify(ndev, GCCR, GCCR_TCSS, GCCR_TCSS_ADJGPTP);
 	spin_unlock_irqrestore(&priv->lock, flags);
 
-	priv->ptp.clock = ptp_clock_register(&priv->ptp.info, &pdev->dev);
+	clock = ptp_clock_register(&priv->ptp.info, &pdev->dev);
+	if (IS_ERR(clock)) {
+		netdev_err(ndev, "failed to register PTP clock: %pe\n", clock);
+		clock = NULL;
+	}
+
+	priv->ptp.clock = clock;
+	if (clock)
+		WRITE_ONCE(priv->ptp.phc_index, ptp_clock_index(clock));
 }
 
 void ravb_ptp_stop(struct net_device *ndev)
@@ -337,5 +346,7 @@ void ravb_ptp_stop(struct net_device *ndev)
 	ravb_write(ndev, 0, GIC);
 	ravb_write(ndev, 0, GIS);
 
-	ptp_clock_unregister(priv->ptp.clock);
+	WRITE_ONCE(priv->ptp.phc_index, -1);
+	if (priv->ptp.clock)
+		ptp_clock_unregister(priv->ptp.clock);
 }

