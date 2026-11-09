Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794229109;
	b=KGK3Dt11xGu99aEo2tCMmZnJwdrKr+lT2MlfcEYfFNuCp3gYIcS9B7mfaYJN+Cxpg7Ai
	 +WCX6P9JOBycc3/okd+JhQU+SlRsdCbMVZ4sHnIOyBy97D5qwj0gQci84WxsELS6+85tY
	 NslBekTh61ipALzUTKy/XuV9lpHh+DzM7Kp5N1+5lV+Vn7n79v9CfneR9J6oYJe5+MPaA
	 Pl+VCJd/C5j8QPY854MWM8cxJHkmfAJmT2LvqWK+pbo6q3Co/2hprmRtRw10C1CQ/OvGP
	 KEmI5+0YWWOQNnryHoUQ9re7crXu14Y+JsjuAUCFM6JZrD4zI+LZRW2zXcbIoPVQMdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794229109;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=n3PkCkDPnKV8p/iqmyGp7B/JsDJVTkvtOgECOHF++nY=;
	b=B2BzQW+lYFUinCX4n4rKQrOEAQpBqdD/tQx8PXukxA4IuSGtxP9Wc7IfIxsNteYTZv/B
	 e+i5EtdU4rXXu7XQ2AgKoM7xdRXhJIeLbR8qF2GHIeouGuMVqrEPKQFpdKu3yTbrY+QrN
	 uMO4xokxLWpi7Z0ZSFob48xMsdoZ5uN0pfOIg3we0aa4a0Y9wFQRxR9U7H50iQ3fQU96/
	 gzypxtmMYyvSsZjCns4yZW2clFY4sz0R1i3sa7BYRiDNFEAsGDpbofas6X4DB0fLT0ARu
	 m2lQmhoyaT2q8GFyCpkaUxjT9sQa8RhYhWs6BNEtGr20R2pI/5VIkHQ/LsLwg8kD39g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=UL6hyKPi;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B56606A325;
	Mon,  9 Nov 2026 12:58:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69B56606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=UL6hyKPi
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7EA97A12EB;
	Mon, 09 Nov 2026 13:58:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1794229105; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=n3PkCkDPnKV8p/iqmyGp7B/JsDJVTkvtOgECOHF++nY=;
	b=UL6hyKPiXBLAdPxwsOTZLOI6bcNx5FnnF/GkvaOIBEn9Gx77MlqBJ2FMguorUAFwzSdPHJ
	7YCKZ2GAPnl7efJJ7CNEH4rEwfu20aqdI126Pb7ljO5FNnoa17hoT9RR14sF90BF1K2xq/
	1h/XR0U9ZySB3aNkOnF0+7DlLucTT7EzlZn6ul974/UwiZniGMIukXns4O/TlraGvczqGJ
	dwW2z0zKcADfJkKB7Xws9mcu3nyKpfiskvH2YWYhkuBfvLbdvp8RVeXB0RJTskuidQfLy/
	s4AJQsKTfagt+XlNzcVnI7+Jt3awC714Kf5jF0+XInmTa2TFFKhqUOahZKhc/A==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Mon, 09 Nov 2026 13:58:22 +0100
Subject: [PATCH 7.3.y] net: macb: wait for a running xmit before resetting
 BQL on close
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261109-nb-macb-close-7-3-y-v1-1-5c506e2077fd@tipi-net.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQ6CMBAAv0L27JJuGyH4FeOhLQuskWK6aiSEv
 1v1OJPMbKCchRVO1QaZX6KypAJ0qCBOPo2M0hcGa2xDZDpMAWcfA8bboowtOlyRvOntYByFYwO
 lvGce5P27nqGtXb3C5a/1Ga4cH98j7PsHFIwA9X4AAAA=
X-Change-ID: 20261109-nb-macb-close-7-3-y-1a0d2f031b56
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Sasha Levin <sashal@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Sean Anderson <sean.anderson@linux.dev>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

macb_close() stops the queues without waiting for an xmit still
running on another CPU. That frame charges BQL after the reset and
never completes, so after the reopen the queue stays stopped with an
empty ring and the watchdog fires until the next close.

Seen on a Raspberry Pi CM5 with ethtool -G under load.

Upstream fixed this as part of the context swap rework in commit
dcc3288b9433a ("net: macb: use context swapping in .set_ringparam()"),
which is too large for stable.

Fixes: e6a532185daa ("net: cadence: macb: Implement BQL")
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
Fixes a close race in 6.18.y and 7.3.y. Older LTS kernels have no BQL
in macb and 7.4 has the fix through Théo's context swap series, so let's
keep the fix small instead of pulling that whole series in.

The stall was observed on a Raspberry Pi CM5 (2/30 close/open cycles under
load stalled), so it is worth fixing.
---
 drivers/net/ethernet/cadence/macb_main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 261a7e87520a4..9b3008b888bc4 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3236,14 +3236,16 @@ static int macb_close(struct net_device *netdev)
 	unsigned long flags;
 	unsigned int q;
 
-	netif_tx_stop_all_queues(netdev);
-
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
 		napi_disable(&queue->napi_rx);
 		napi_disable(&queue->napi_tx);
-		netdev_tx_reset_queue(netdev_get_tx_queue(netdev, q));
 	}
 
+	netif_tx_disable(netdev);
+
+	for (q = 0; q < bp->num_queues; ++q)
+		netdev_tx_reset_queue(netdev_get_tx_queue(netdev, q));
+
 	cancel_delayed_work_sync(&bp->tx_lpi_work);
 
 	phylink_stop(bp->phylink);

---
base-commit: d50d994bffa3c7c6db2d8bc4c5f0c55e3f46b0cd
change-id: 20261109-nb-macb-close-7-3-y-1a0d2f031b56

Best regards,
--  
Nicolai Buchwitz <nb@tipi-net.de>

