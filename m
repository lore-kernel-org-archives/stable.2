Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049654;
	b=o9u5cFtFynZ6aZ2s2Z/ZLCFNe7z+jZqGMacvN5uYhbT3u8BvT8QQin0ecnTb1LDhdR28
	 mf8tJoXdAhbBhSCTgF9kjHMyLNbyaoqIoVz1GXzNeow84xWkrrz3NriwfaygbNZC2vZ5r
	 jaJuFe9+cR1sL1iTMw9OSzIpmdjWdmjYRT8iTFn9Oapy8h6Sh5Ew5fxFUqxmabkqLPmQq
	 2lUzzuOr02tLvWt0q++qLeIhnFAfIigl9kLDlM1d4JlYNWR2QsopKHBUbC953aB/x7jn8
	 3ucM3v+ps8JjM8GboMq2ArfCubRKo+PU6GCPA7B3q69dBqvMcmczKSAHsMF9YaVujuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049654;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=I7f2h8koVDYwIUxyAx35UpvXfNx7g33rKbpA9+cLUSE=;
	b=oYZ38LzKcNQqo40cDSYweV0dwTaOBf3YD20e/4BX8X+X+gewEWIEXRGD5VSQ8XwvF1KA
	 Hod4zO8uK4T4R6vSUje4tk8KR8PBy1H47y3tcuOimAz3TkyFwO7OAHDys/TB/MTmlEfr+
	 m2QMVzKyCM+lFdf/Fy87FvpTgOMPKx0cRl62rRc2KNneMfnMWW9i6q2ADX6bOle7Vro/d
	 aieT+nI/CZErLcjRocUnLcnvOAXhQ8eG902fXfsIROsqcduiI0EOje44XPYZhJ7ADqJ/v
	 kpgCnua+5MuFTJVC+vopDe5FSY47naC9QAjQjHdXHZHWQJzEMiTWcof8gYSyAVi5/Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bcpp9Iy3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE911606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bcpp9Iy3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A42B1F0089F;
	Sat,  7 Nov 2026 11:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049653;
	bh=I7f2h8koVDYwIUxyAx35UpvXfNx7g33rKbpA9+cLUSE=;
	h=From:To:Cc:Subject:Date;
	b=Bcpp9Iy3BobMJya0Xf5PgurNjeBRZCn3kSB6T1sWzpuh3DE2OXT8g3WDr94Vu1JRV
	 ebfUz3pFFA2cwSiDr2JjLmYzddLZLSEjXFpmHBPwjhhVUemJJv6M1aQImZcl5FxGl6
	 eyK9+OTcgdP6n9ku/KNhhCEBRMhe9kq59ctU9is4jJfpeAiQ+TgRyAdfQafwoH2SkQ
	 oz26Fd4VUck6Yoc4NRMBMFknHVjhLjX61ej2d5DER3L0ZhHlDfnBr8A+YmNCWemidL
	 Wh6VGRZPCf9D1VymcN79ekWuZfS6/wolUA9IXjvjSd+/61+NHLEulEnLOGmPn3H1MP
	 NoH/woWtEYYHQ==
From: Sasha Levin <sashal@kernel.org>
To: rosenp@gmail.com,
	daniel.machon@microchip.com,
	kuba@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] net: bgmac: enable interrupts only after NAPI is ready" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:07:31 -0500
Message-ID: <20261107060731-failed-5.15-ac1f6e58cb77@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x ac1f6e58cb77bb66b8811f7d98703e0f076a8f65
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060731-failed-5.15-ac1f6e58cb77@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




