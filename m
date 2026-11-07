Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047009;
	b=NYtgDQeM9oHanicL8XdcwO9GmwVYiK30YyOEQCKA4DxNQYhoj/IEWpfpG1pbJSQ6Eg5X
	 xu082Q74NrYaAzfADBSAsMy6sgr9bAeN3qoqkYR1tfksTOrSb49zYHan2ALBMA/hxH9kg
	 1viM/EidbmGvW3zk8Mamsewol2Ig/adoX+D5HE9bYK9Iohs5yRmApmXlJ/MPQ7tUG3+Xk
	 O2RN3YCVNY8zzceIztOsqmcFCxFckSa//mb7zSCpp4S1+0Hd67Ya6By65Y+QpJTj/+Je0
	 foZJhVMvoYFA0EUG6/PmObCeg1oKXj8JDPh8aaK1GJHBbvGsqP0RVUCBTMoPwEpEl7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047009;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=X5MqvYviMzA+uQyBldK08gu4gFcBQI/qlB2z27Miidg=;
	b=0crSYH0OyUkBqNqDngGW/ozMqtAz4VL2RIz7ZaMBGReXjUUm/BHwnHBsAlIY7pczYLOT
	 61H5eI/GhzOKv/hnD85w1lIMShOJAuDcfnYocdFa5g55N/xIhRjGV6pQWPEp0THDLUKU0
	 exW5JynPPJyPcXeLs8UKi3Lgbr9x9wSyC9Aj8sawzApnaQInf6vG30nR3kX/x1/BUqmE+
	 nF1KGAwmIltNTexpZoCBPqL3ZdVG/+GMjAi14dJqgzbIP9E3veFz4v+QbLbtyXRwuif9w
	 R8VSo4Fl4j2wHmEQ2AfQh6m1HbjAraJpBuKBDBToPiFXrjyd2wGW86+ewCYAQ3lNMAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qh53mD6Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8B2606A339
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qh53mD6Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B527B1F0089F;
	Sat,  7 Nov 2026 10:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047009;
	bh=X5MqvYviMzA+uQyBldK08gu4gFcBQI/qlB2z27Miidg=;
	h=From:To:Cc:Subject:Date;
	b=Qh53mD6QGbhuRV4ugh1KIvwIaDLkSbd2gxtLEK4v4628KDbp4LBVBWGcIO6zyz2fI
	 yXY+qGtpZEXTuaZWWL8aMRdPiKHg4mH1DgR63f2b30zCwumWyBsP9LNcQo0F9FBmx1
	 z4DAGG6jEIh+cQzmMlGVRAkmzyahCqnHe1hCQjEgrjkNjX/afy1wp14ahcr0+idwQr
	 yr3qPZdx5NrxrMlYBMfl3k/H+SXZ9k6nB8W/sJIICeFmSwG5cLaAbBk08MV++9mUs7
	 TDw453tqnveXwE6UI1ZvlJC/wRI/spT0eN2zr703zZfZh2SPRtDH1yG1BBWr0VBz3S
	 zUQmtJFvA8Idg==
From: Sasha Levin <sashal@kernel.org>
To: rosenp@gmail.com,
	daniel.machon@microchip.com,
	kuba@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] net: bgmac: enable interrupts only after NAPI is ready" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:23:27 -0500
Message-ID: <20261107052327-failed-6.12-ac1f6e58cb77@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x ac1f6e58cb77bb66b8811f7d98703e0f076a8f65
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052327-failed-6.12-ac1f6e58cb77@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From ac1f6e58cb77bb66b8811f7d98703e0f076a8f65 Mon Sep 17 00:00:00 2001
From: Rosen Penev <rosenp@gmail.com>
Date: Sat, 10 Oct 2026 00:00:11 -0700
Subject: [PATCH] net: bgmac: enable interrupts only after NAPI is ready

bgmac_open() calls bgmac_chip_init(), which unmasks the interrupts and
enables the MAC receiver, before request_irq() and napi_enable().
bgmac_enet_resume() also enables NAPI only after bgmac_chip_init().

When frames arrive in that window, the first RX interrupt masks all
interrupts in bgmac_interrupt() and calls napi_schedule() on a NAPI
instance that is still disabled, so nothing is scheduled. Nothing
unmasks the interrupts again, the RX ring fills up and the interface
stays deaf until it is brought down and up without traffic.

On an Asus RT-N16 (BCM4716) a single "ip link set eth0 down/up" while
a host sends UDP to the router left INT_MASK at 0, INT_STATUS with RX
pending and the RX DMA idle on a full ring, with the RX packet and
interrupt counters no longer moving. With this change, 10 of 10 such
cycles recovered on their own.

Request the IRQ and enable NAPI before the chip is initialized.

Fixes: dd4544f05469 ("bgmac: driver for GBit MAC core on BCMA bus")
Fixes: f3537b3494c0 ("net: ethernet: bgmac: driver power manangement")
Cc: stable@vger.kernel.org
Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
Link: https://patch.msgid.link/20261010070011.60403-1-rosenp@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bgmac.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
index 3e9c57196a397..1835266fdd09f 100644
--- a/drivers/net/ethernet/broadcom/bgmac.c
+++ b/drivers/net/ethernet/broadcom/bgmac.c
@@ -1183,9 +1183,6 @@ static int bgmac_open(struct net_device *net_dev)
 	if (err)
 		return err;
 
-	/* Specs say about reclaiming rings here, but we do that in DMA init */
-	bgmac_chip_init(bgmac);
-
 	err = request_irq(bgmac->irq, bgmac_interrupt, IRQF_SHARED,
 			  net_dev->name, net_dev);
 	if (err < 0) {
@@ -1195,6 +1192,9 @@ static int bgmac_open(struct net_device *net_dev)
 	}
 	napi_enable(&bgmac->napi);
 
+	/* Specs say about reclaiming rings here, but we do that in DMA init */
+	bgmac_chip_init(bgmac);
+
 	phy_start(net_dev->phydev);
 
 	netif_start_queue(net_dev);
@@ -1608,10 +1608,10 @@ int bgmac_enet_resume(struct bgmac *bgmac)
 	if (rc)
 		return rc;
 
-	bgmac_chip_init(bgmac);
-
 	napi_enable(&bgmac->napi);
 
+	bgmac_chip_init(bgmac);
+
 	netif_tx_lock(bgmac->net_dev);
 	netif_device_attach(bgmac->net_dev);
 	netif_tx_unlock(bgmac->net_dev);
-- 
2.53.0




