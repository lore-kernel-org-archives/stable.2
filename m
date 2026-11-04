Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793773988;
	b=IJ72bYuVkFrPSngl6I4XZHJQpjIZm9OyO78WqpF8NGF5TqFTjALboDbheOLqqMiAJfnJ
	 wdK1euTxMsYeP4vkVSs9cZJ0PsWMKfXQbGtQ/VAxuht/ae+V0+mXwr/JD5LR4u+hrG+u0
	 h4nXJ0xhem5gVjo9+5VvT9l9QD4pBQ6exSSvYCgUWsP/9OF/mtDcu84PeYFv1P70QdrGi
	 pwhY1CYiimzkBpITpRm/7U98cukHVmc/wZOXH+XjELeHrPnRdCLH5KtasTimr/IKmzaUJ
	 qcpfZJf4NYCUnJAg61Yn0HP5FXxdCZ0o13VdHZiJC4FxXA7LHaGHqxmB3a89btIOd0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793773988;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=sxxQShbp8FZG7pXPyIlcAhi3RD1LSwiwzG+8Ik25uV4=;
	b=SLksG5tWy5qkZ6QjOQ85FIKL8FjvJu3+KQArU74FkLggJ1wQ3RuaHpATbmDRsUcmvDwb
	 HEMu8vfINMVsPeF9ivIQP3n4SatLXkjqloRFjtjVlHPH1CPbTCyobE2IiwT2jJM1ZalrX
	 ZOG3PUKeINE0m3vXdIOBP1cZkNO+UDSG61OveO9RCdSTSDnLJuvOyW+mCzjmvDryoeFoh
	 zjJ/8xyWsKVU/EMbFwkU8eeia3iPbYPjHhL4vk9DZJZT7zaGKFMKIkOXVu4iEx0v5zKsv
	 Kt1e5HnyNQQdJAHGf6b4xQYGtyILpqe6eBQxx1hgnAwqQS75K1CX0wfPjVhdVktFMng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WKKXxiTS;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358A9606A326
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 06:33:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 358A9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WKKXxiTS
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cc1bc88a20eso251948a12.3
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 22:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793773987; x=1794378787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sxxQShbp8FZG7pXPyIlcAhi3RD1LSwiwzG+8Ik25uV4=;
        b=WKKXxiTSTsxPOabagD3SlBgkZ9yigOTxXysn70pKQCdJDv4dO9lyAoyuNmUvzL3YXy
         3RVxTZb+zbkZywHGYo/nt12vEY+pOuzrcFZB9kOvQLiJa4l5dmVZ7ACgy/zXhB/duzvd
         7XlwCx/d/apJzLpgy24jRqUv29j9HdIcY+S9YOe2oAzQv/SZncCKdGVuPtq9bbA7MdKJ
         AEJ1keBLhJq25r6bvhzpTh9zuzHte3bgZGdeH1YtqO+Eu9AxNxvmOLblV+1T6HRp0T6y
         VwghtZ01S6dCksufcuangbp5kmMQ9GUbF8ijXXxR6aZ9SavK7prk+4zpZjnpC90Uq7Ny
         bi8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793773987; x=1794378787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sxxQShbp8FZG7pXPyIlcAhi3RD1LSwiwzG+8Ik25uV4=;
        b=Aidn034pSEMmzg6QysxAJXCR+FXOXcYprmoKptgITjhB/V0dwUInYb3uRdstbmIGep
         D+SqYtHyz/pa16lD6chSjUi4FD5pgfoKq5qvHnrEH3qbV0Z5wgDIwiGpxTzUJ+XWxLRF
         RomilVygU5VLjnro5Ji5PJ16AGpuiY9SSNhE4ikft3WBBEVmZO7lPv+qLtAodttnFKsi
         SRJzhdBhH35r4kcfM5MSXO62RW+RnqO2VWoexr7i9nqi5+spiTxXVrq2vWNuk7DY2Hq6
         9EC2aBjTg59vBQ9uJoEGOAE21P6OO2fCR1JRafbqqgVmi16Tq4JCBJu/XjIPzgOxR9k+
         PqYQ==
X-Forwarded-Encrypted: i=1; AKwUvBx9lJW1TH1t410+rr6kPlzYTaYCWjGqJS8O3knKMh1bhh9qwbt8EykZ6CQqa5eZnP5T2RYIoNk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+mNTj/HibVtOR6P5fJ9Zgi6NuHLzffPMBYauIVU/7ScyboUTzI
	lKF2QTRUXg07fnoaMmM21OzvlqzGT5s6cyPoXZQHJgMqFwIv0a2JFGaf
X-Gm-Gg: AYBFou1kI0WgiLJi+fmmlI+eJHab6h88RS6iv+phanXJQL7fBZmSEezL0YcYJuGKwXt
	g4cnRPyX/LGUtXK7jbA+qUNrOY2KeC7xvCRzTgQq/wqwto00BjmXkvD82rtLOdk2p/8yBu4u+r6
	PkhhQC612GTTM0CnLsaM36NYfKMuhuETH5nBbGWaD8jzheP2N9gEnuWkleUvYdpCdPojH7fSc7r
	YG6sfPowpPbKEy2bdu6v1hHvhXFNw7lCS1uz0tkEIn7xECvWSzxBTRgEIg6T2oNcV5vCwyLBAcn
	MfIlQe/JwHe8Q3fuwglDzASUVMF667iq/rGfwyD/u3W9xVnb9IBHUoatjJb6ZAkWIc6DbJ4GKGn
	t9zimiv6KSM7aqIMoOY0SdP87nTt4hacwBTbutsUUQMcw+Me1eGZH2H7RkPKrKttzOt6UyeQLMv
	6HU8C7Ul9GX4AMoBcC0+dsuSg0xmlwJx13rgQod3stVf0Ksx0JuMdJE5eCJ5SlMdTdxyKwws8Us
	QYnxtuM/gmURAckW9qLn3z19SFBz2eet5YtoaZF4k7zMpL/6XInwJWf7JWjU9th679JhbYdaS55
	1S97dwbwT6dG2kEDqvT4xJ7608gVLMTyxHDtRYdNMc5Y04K03DZHpSS7
X-Received: by 2002:a17:90b:51c7:b0:3a8:c0cd:57fb with SMTP id 98e67ed59e1d1-3ae89819925mr13498598a91.42.1793773987414;
        Tue, 03 Nov 2026 22:33:07 -0800 (PST)
Received: from ubuntu24.localdomain ([124.77.157.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0945104dasm2583207a91.17.2026.11.03.22.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 22:33:07 -0800 (PST)
From: BeaCox <0xbeac@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net 3/3] net: xgmac: disable timeout work before teardown
Date: Wed,  4 Nov 2026 14:32:45 +0800
Message-ID: <20261104063245.23402-4-0xbeac@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104063245.23402-1-0xbeac@gmail.com>
References: <20261104063245.23402-1-0xbeac@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xgmac_remove() frees the IRQ lines and unmaps the registers before
freeing the netdev, but tx_timeout_work can still be pending or running.
The work is queued from ndo_tx_timeout() and from the DMA error
interrupt path, and its handler disables NAPI, programs the DMA
registers and walks the TX ring.

xgmac_stop() has the same lifetime problem: it frees the DMA descriptor
rings while a queued timeout work can still run.

Disable the work in probe after INIT_WORK() so open/resume can enable it,
disable it synchronously in xgmac_stop() before the rings are freed and
in xgmac_suspend() before NAPI/interrupts are torn down, enable it in
xgmac_open() and xgmac_resume(), and disable it in xgmac_remove() before
the IRQs and MMIO are released.  The enable/disable pairing avoids the
underflow warning that enable_work() emits when the work was never
disabled.  disable_work_sync() also rejects queue_work() from a late
interrupt, which cancellation alone would not.

The patch does not change the existing free_irq()/unregister_netdev()
ordering in xgmac_remove(); it only prevents the timeout work from
outliving the netdev.

Fixes: 8746f671ef04 ("net: calxedaxgmac: fix race between xgmac_tx_complete and xgmac_tx_err")
Cc: stable@vger.kernel.org # 6.10+
Signed-off-by: BeaCox <0xbeac@gmail.com>
---
 drivers/net/ethernet/calxeda/xgmac.c | 30 ++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/net/ethernet/calxeda/xgmac.c b/drivers/net/ethernet/calxeda/xgmac.c
index a2410fba6b..9b7aee56f2 100644
--- a/drivers/net/ethernet/calxeda/xgmac.c
+++ b/drivers/net/ethernet/calxeda/xgmac.c
@@ -1023,6 +1023,9 @@ static int xgmac_open(struct net_device *dev)
 	if (ret < 0)
 		return ret;
 
+	/* xgmac_stop() disables this work before freeing the rings. */
+	enable_work(&priv->tx_timeout_work);
+
 	/* Enable the MAC Rx/Tx */
 	xgmac_mac_enable(ioaddr);
 
@@ -1046,6 +1049,13 @@ static int xgmac_stop(struct net_device *dev)
 {
 	struct xgmac_priv *priv = netdev_priv(dev);
 
+	/*
+	 * The timeout work programs the DMA rings that are freed below, and
+	 * it toggles NAPI.  Disable it synchronously before touching either;
+	 * xgmac_open() and xgmac_resume() enable it again.
+	 */
+	disable_work_sync(&priv->tx_timeout_work);
+
 	if (readl(priv->base + XGMAC_DMA_INTR_ENA))
 		napi_disable(&priv->napi);
 
@@ -1713,6 +1723,12 @@ static int xgmac_probe(struct platform_device *pdev)
 	ndev->ethtool_ops = &xgmac_ethtool_ops;
 	spin_lock_init(&priv->stats_lock);
 	INIT_WORK(&priv->tx_timeout_work, xgmac_tx_timeout_work);
+	/*
+	 * The work is enabled while the interface is up.  Start it disabled
+	 * so the enable_work() in xgmac_open()/xgmac_resume() has a matching
+	 * disable and never underflows.
+	 */
+	disable_work(&priv->tx_timeout_work);
 
 	priv->device = &pdev->dev;
 	priv->dev = ndev;
@@ -1823,6 +1839,13 @@ static void xgmac_remove(struct platform_device *pdev)
 	struct xgmac_priv *priv = netdev_priv(ndev);
 	struct resource *res;
 
+	/*
+	 * The timeout work can be queued from ndo_tx_timeout() and from the
+	 * DMA error interrupt.  Disable it before the IRQs are released and
+	 * the registers are unmapped.
+	 */
+	disable_work_sync(&priv->tx_timeout_work);
+
 	xgmac_mac_disable(priv->base);
 
 	/* Free the IRQ lines */
@@ -1862,6 +1885,12 @@ static int xgmac_suspend(struct device *dev)
 		return 0;
 
 	netif_device_detach(ndev);
+	/*
+	 * The timeout work touches the DMA registers and toggles NAPI.
+	 * Disable it before NAPI and the interrupts are torn down;
+	 * xgmac_resume() enables it again.
+	 */
+	disable_work_sync(&priv->tx_timeout_work);
 	napi_disable(&priv->napi);
 	writel(0, priv->base + XGMAC_DMA_INTR_ENA);
 
@@ -1891,6 +1920,7 @@ static int xgmac_resume(struct device *dev)
 
 	/* Enable the MAC and DMA */
 	xgmac_mac_enable(ioaddr);
+	enable_work(&priv->tx_timeout_work);
 	writel(DMA_INTR_DEFAULT_MASK, ioaddr + XGMAC_DMA_STATUS);
 	writel(DMA_INTR_DEFAULT_MASK, ioaddr + XGMAC_DMA_INTR_ENA);
 
-- 
2.43.0

