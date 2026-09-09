Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5104938B7D2
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788976564; cv=none; b=dAmtDdIOjuiVI9S9ljUdd7VRLPcrJCK7MK8vqFR9xN39QPdyhpk4Tpg4iGxS5KtlmQecOnvGTz/1LcWRuerFNiZniHV9j994Y6P8JBpm1pq1XrMWMJjgNWxeryh8D/NLF2LK8b13fjMBLu5nO6AV40kTpU4jielOZBYacybao5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788976564; c=relaxed/simple;
	bh=cEimnMv4hoZp2MhSHY/Jxyv3iuPmwq9qNjBAy2Ohm4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JLRjsNK9g5SfEwSwTKK6ZvxP0yVKqyVustrHIS8O4Eg6ZNMsKFdIo1oOK5Q38d9L8Q6rRKHTk6nHUgbdDhbywlG/wfxGOsV0ximlPHMqTfLyJ4tFX4yFP/yGYms7Y5AwolutI3qhrMUV+ugJu3C53R+tDLi8hGE2HPk5TufAN6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGm3Uieg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGm3Uieg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1AD1F00899;
	Wed,  9 Sep 2026 17:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788976563;
	bh=8lKZhvAPukz2f8voiSptmNjJM4v+dywsgSIfBuOVOuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nGm3UiegRXEKXZXxs3o2/4akqayI38kQy2uic10GTopgm0IwY+9RmQ5M1EIiGyPTj
	 k8kQQK+T85rFu+0f4ZRtWPw7WK5/+WEN02vg4FD00NtvV8/lhyhweXmyVSz+ngAFc2
	 5z/oaTIZiPPgbG+VLWuNCuEioo+b+OUhNboG3hOL0FOb+vnXev0k0n4E2+D38dMwFa
	 N8DiUoF5pSQ5E+d7vRKlwivH+PcNU8omH9hFz5rkw0uidvw8SHJbrLLCubxByvIsDC
	 tp4jzQqtpKJdB+YS+FVxluki9IdsuTzK11DO3MkYeC5hLyM91c4EgBkEnrkWUfnDPh
	 ncrEp8YDaHUsg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/4] net: ravb: serialize PTP clock teardown
Date: Wed,  9 Sep 2026 13:55:58 -0400
Message-ID: <20260909175559.3436094-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909175559.3436094-1-sashal@kernel.org>
References: <2026090334-visor-renewed-f29f@gregkh>
 <20260909175559.3436094-1-sashal@kernel.org>
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
[ adapted IRQ synchronization to use only ndev->irq within the existing ravb_ptp_stop(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/renesas/ravb_ptp.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_ptp.c b/drivers/net/ethernet/renesas/ravb_ptp.c
index 66cd690af54b0..bcbcce4a0ee5f 100644
--- a/drivers/net/ethernet/renesas/ravb_ptp.c
+++ b/drivers/net/ethernet/renesas/ravb_ptp.c
@@ -304,16 +304,17 @@ static const struct ptp_clock_info ravb_ptp_info = {
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
@@ -349,7 +350,7 @@ void ravb_ptp_init(struct net_device *ndev, struct platform_device *pdev)
 		clock = NULL;
 	}
 
-	priv->ptp.clock = clock;
+	WRITE_ONCE(priv->ptp.clock, clock);
 	if (clock)
 		WRITE_ONCE(priv->ptp.phc_index, ptp_clock_index(clock));
 }
@@ -357,11 +358,15 @@ void ravb_ptp_init(struct net_device *ndev, struct platform_device *pdev)
 void ravb_ptp_stop(struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
+	struct ptp_clock *clock;
+
+	WRITE_ONCE(priv->ptp.phc_index, -1);
+	clock = xchg(&priv->ptp.clock, NULL);
 
 	ravb_write(ndev, 0, GIC);
 	ravb_write(ndev, 0, GIS);
+	synchronize_irq(ndev->irq);
 
-	WRITE_ONCE(priv->ptp.phc_index, -1);
-	if (priv->ptp.clock)
-		ptp_clock_unregister(priv->ptp.clock);
+	if (clock)
+		ptp_clock_unregister(clock);
 }
-- 
2.53.0

