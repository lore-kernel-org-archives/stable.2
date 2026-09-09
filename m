Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039E436F8EE
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788974273; cv=none; b=NuIiCkzU5uUOJeMKHB0Km1c0c+W7gj04bD/M6kLAy1puSd4qjull0yDT068mq4UUOkSACzsp5qDL47VuMTxSeT90/8Z6+Fot8Es8AhNbKg+I0U+a1IR2zOMwB202ZjT5oaEMGS35qjF13Gf965eNIiXVgJL4UPuMB0rKlH5ng68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788974273; c=relaxed/simple;
	bh=Eb1l9F0SvVw+KBGJDx+IYOyZ0DOMQHZcWuKh63Dr/Lg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JdHLrZhbhh/F/uTA2lmLNYXVruBfaq3rSWL3bcf84BUrkIdLh/lBwGPJDCg8N8ln7MDV04YOZPVMjuIpBbLtr/6Q+OuZ2FeVIUB3IRA1nE+1BW0a/hPbHPyrSGOCHrLB2CTQRi1RCyb4yLT1QHZtttakBcjg+eLx+UyQrPHr+2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qh9F5QVQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qh9F5QVQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65A931F00899;
	Wed,  9 Sep 2026 17:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788974271;
	bh=17miC5GJeILcCfAMLn5QkOzCud5soMJ01GtKXccM3u0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qh9F5QVQJZDfW6uExJL/+6jmqEoj+6guBGKF3D91pkFhL+vQL2TGm+U8I4813hga0
	 NsR8qzEPnW1tzgSxAmomVARcKnXRDsW+9KPeKlrqRrIPZdk7/xRUGQOR56/AFi1jCh
	 NoNjJ8aSNC9SIf4t4uxLFW/7g6F05CPrgBANARJA9XUF5CIi4YiToxr2MTWkm4/auL
	 uo0dkNMgNu10JC12Vjut3RtxX+yzZir0TR5Nz4+SJHVBsHqP+VwxBWcORLDUNeCjiH
	 2SHTfncYsnjZGH4UsMYhkiw0i+pkRIFgGsm7OcoTYm24z94XbxuKT+TmEKx+0HrgNs
	 ZCjeYdQSVFi/g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 7/7] net: ravb: serialize PTP clock teardown
Date: Wed,  9 Sep 2026 13:17:43 -0400
Message-ID: <20260909171743.3248398-7-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909171743.3248398-1-sashal@kernel.org>
References: <2026090333-magnolia-munchkin-24b0@gregkh>
 <20260909171743.3248398-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

[ Upstream commit 1cb9663789c5b7a12fcd419fcca6d6254c398252 ]

ravb_ptp_interrupt() can race with ravb_ptp_stop() and pass the clock to
ptp_clock_event() while ptp_clock_unregister() is freeing it. This can
lead to a use-after-free.

Use READ_ONCE() and WRITE_ONCE() for lockless access to the clock pointer.
Atomically detach it with xchg() before disabling PTP interrupts, then
synchronize all IRQs which can invoke ravb_ptp_interrupt() before
unregistering the detached clock.

A handler which read the old pointer completes before the clock is
unregistered, while later handlers read NULL and skip the event.

Fixes: a0d2f20650e8 ("Renesas Ethernet AVB PTP clock driver")
Cc: stable@vger.kernel.org
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Link: https://patch.msgid.link/20260811103733.62599-3-xuanqiang.luo@linux.dev
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/renesas/ravb.h      |  2 ++
 drivers/net/ethernet/renesas/ravb_main.c |  6 ++--
 drivers/net/ethernet/renesas/ravb_ptp.c  | 37 +++++++++++++++++++-----
 3 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index 8bd94180113d2..866c769929d46 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -1090,6 +1090,8 @@ struct ravb_private {
 	int msg_enable;
 	int speed;
 	int emac_irq;
+	int err_irq;
+	int mgmt_irq;
 
 	unsigned no_avb_link:1;
 	unsigned avb_link_active_low:1;
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index faba6bf94a757..e8eba5d61d9ad 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2650,11 +2650,13 @@ static int ravb_setup_irqs(struct ravb_private *priv)
 		return error;
 
 	if (info->err_mgmt_irqs) {
-		error = ravb_setup_irq(priv, "err_a", "err_a", NULL, ravb_multi_interrupt);
+		error = ravb_setup_irq(priv, "err_a", "err_a", &priv->err_irq,
+				       ravb_multi_interrupt);
 		if (error)
 			return error;
 
-		error = ravb_setup_irq(priv, "mgmt_a", "mgmt_a", NULL, ravb_multi_interrupt);
+		error = ravb_setup_irq(priv, "mgmt_a", "mgmt_a", &priv->mgmt_irq,
+				       ravb_multi_interrupt);
 		if (error)
 			return error;
 	}
diff --git a/drivers/net/ethernet/renesas/ravb_ptp.c b/drivers/net/ethernet/renesas/ravb_ptp.c
index 97267a0c45a6b..948bfc2ec6a98 100644
--- a/drivers/net/ethernet/renesas/ravb_ptp.c
+++ b/drivers/net/ethernet/renesas/ravb_ptp.c
@@ -306,16 +306,17 @@ static const struct ptp_clock_info ravb_ptp_info = {
 void ravb_ptp_interrupt(struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
+	struct ptp_clock *clock = READ_ONCE(priv->ptp.clock);
 	u32 gis = ravb_read(ndev, GIS);
 
 	gis &= ravb_read(ndev, GIC);
-	if (gis & GIS_PTCF) {
+	if ((gis & GIS_PTCF) && clock) {
 		struct ptp_clock_event event;
 
 		event.type = PTP_CLOCK_EXTTS;
 		event.index = 0;
 		event.timestamp = ravb_read(ndev, GCPT);
-		ptp_clock_event(priv->ptp.clock, &event);
+		ptp_clock_event(clock, &event);
 	}
 	if (gis & GIS_PTMF) {
 		struct ravb_ptp_perout *perout = priv->ptp.perout;
@@ -351,19 +352,39 @@ void ravb_ptp_init(struct net_device *ndev, struct platform_device *pdev)
 		clock = NULL;
 	}
 
-	priv->ptp.clock = clock;
+	WRITE_ONCE(priv->ptp.clock, clock);
 	if (clock)
 		WRITE_ONCE(priv->ptp.phc_index, ptp_clock_index(clock));
 }
 
-void ravb_ptp_stop(struct net_device *ndev)
+static void ravb_ptp_disable(struct net_device *ndev)
 {
-	struct ravb_private *priv = netdev_priv(ndev);
-
 	ravb_write(ndev, 0, GIC);
 	ravb_write(ndev, 0, GIS);
+}
+
+static void ravb_ptp_sync_irqs(struct net_device *ndev)
+{
+	struct ravb_private *priv = netdev_priv(ndev);
+
+	synchronize_irq(ndev->irq);
+	if (priv->info->err_mgmt_irqs) {
+		synchronize_irq(priv->err_irq);
+		synchronize_irq(priv->mgmt_irq);
+	}
+}
+
+void ravb_ptp_stop(struct net_device *ndev)
+{
+	struct ravb_private *priv = netdev_priv(ndev);
+	struct ptp_clock *clock;
 
 	WRITE_ONCE(priv->ptp.phc_index, -1);
-	if (priv->ptp.clock)
-		ptp_clock_unregister(priv->ptp.clock);
+	clock = xchg(&priv->ptp.clock, NULL);
+
+	ravb_ptp_disable(ndev);
+	ravb_ptp_sync_irqs(ndev);
+
+	if (clock)
+		ptp_clock_unregister(clock);
 }
-- 
2.53.0

