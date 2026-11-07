Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050669;
	b=qIQCafyK5rLQtoeKVg8Q+EFyYV78m++VnYqn1Ejni982L1DhA4SoladF+Sr96qebwW+3
	 H0CdKuhFcOkA6C9IlFmgrsIV9vAiKE7zBIhw9x+KSxtzgyNWS3LOE/chohIBh4q0vBAxp
	 xIi/iLrJlBVcZawYLkbLzAChq0O6ILBlSsyvSEC73udor/pgjMn+H8EGfQkMnexYyuUMN
	 gfne8tbZGHyNXR4VF/E9GzOtWy9EeUPnkVtdUNNRdBRmdbeWVjWdbLUkR2y+yWFBmkDxr
	 QN37N8hhXW/TDp6b0O/7rHLQPRDuRLsxoyxD5ILTc6hUxkha7iMtW9ZaJdW+IQ4Lg/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050669;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=CwzeLXUATBayiDGw7Dbrc3Pdc2NiVcECV+XYClxTNJg=;
	b=IVAV52IJUpZ2rxgW6WWUsZQhkBcqCjAqB8Wrb69kGhyq7wQnPIgXc2xeGHhSuQ0L3l+h
	 FiTVDe18OnQ5QgD4sssZTwDbp4mk++w41hmW4NZMkZJiyFQ8l/WuiA+/BARiwL7xuxObq
	 CNuDoQ9eJCLmNSWtjznrImMmdh7bLBLbj6JAqpAJwirW8tSL0t24MTubKycTmaJeEqugs
	 D2+S1hP4bVh9GCbE6iMb+nUgEsztpbq/JhVmOOeata2qAOLOkUOLXJG/EaqE1uLsQIR4U
	 gzR0qhZiiBcmJ1rAzHqzIEfy+CuiQFvxUTX5cBZvZWHuAAOzIDYL0nlYFmTlWIih8jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="mN/0XCCd";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795A8606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mN/0XCCd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78091F0089F;
	Sat,  7 Nov 2026 11:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050669;
	bh=CwzeLXUATBayiDGw7Dbrc3Pdc2NiVcECV+XYClxTNJg=;
	h=From:To:Cc:Subject:Date;
	b=mN/0XCCdlZ9yxsqaP+4ojZor4AZxyYo4O4Jxvq8d1eR7jRtorWFRIXUVEZPuzLTre
	 BrloW9wpp/srtTUTJVsqtjk+alolwP8Fdf1LS2I3TCcQ+YwFywwl42QA9OXR81B4s/
	 7q0dtmh+LSp3xvBYdA9vGCbR3wG2xKS/XsYLyDxFr4S5+bXefB9ktF6ki6YKe14OrY
	 YJxegVQrEzac4IeP8WCjgBhhnopzdjnj2G/VfFniNtHoxHrvzqbZ/7/QahiyauDMQd
	 da2q66Uf0dsz2YbyO/HsVTPhVrWtdt4yj9oFri6UkhnL0nxLkqGf7t3hLwQupyllfo
	 Lj1zkBmrgHVYw==
From: Sasha Levin <sashal@kernel.org>
To: rosenp@gmail.com,
	daniel.machon@microchip.com,
	kuba@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] net: bgmac: enable interrupts only after NAPI is ready" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:24:27 -0500
Message-ID: <20261107062427-failed-5.10-ac1f6e58cb77@kernel.org>
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
git cherry-pick -x ac1f6e58cb77bb66b8811f7d98703e0f076a8f65
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062427-failed-5.10-ac1f6e58cb77@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




