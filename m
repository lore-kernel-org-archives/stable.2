Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793773984;
	b=tL8bZJPSH+L9C1h9g0UqbQWVAKnlX06yhYgFRAfB62yA9xrVVbcoU9IVtpYTjI7JO5d6
	 dM4tjGyCidZRmXcnXea3RtNcSj5y203HDDey533tLbrAyWK9KDPb1LGcPY0rEf+Qrghll
	 O86lgULtygGo3VmXEhbwJZdxfHNqWXOIdJpsZ8dkBcQfy6NEMaSRXQ+EpUK4X6RjB9r8M
	 gBiijX6NRT/UnsV+Tmp1ifMIHu1gr2r2+S+nBUWxUX06mX5SDMGFZo9zq85FsIaM8qNGG
	 VlcKtJDQgub1DlZ7eaBbGirY2qPQsf7hMXVF96Yl5+c66tHbRhWlHzeIRhOaWnGIyzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793773984;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=A267S55gzLsHKNdX2hHubjRBVjQyKepuiQmncpiS49s=;
	b=2nqD2Oxhg6WXjLNIJZLqYy3cH875cAbLUfxYOWtTnVapOVR2YHiUbh5L3cAOwdTXUJYL
	 KYDIMTXc1RRJh76RDgYgRJ3hFmbbQ7afZ1S5OIHEl6dSn0nVrCjILBmxs8PeM6MtlYnRU
	 SPJi7XIhf4Ek+HjZfj55mEDodvm0yd9l7/IgNYm+07hj9B98GJwoN8G2BhwS6obDpshTI
	 jYzbtthbQXRBK/uCJGw7TMOlIrFxcYaSLjwobUIEZHIBxag7foYwxIRT6zY0ZKvwoyrNz
	 LDD5Wv2axlLHw8tZoB+/A5LeNqPkkYLyphVb52QfD3KBLiEI3v5BA/JpvEwMWENtKfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="P/3fRZtB";
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12BF606A33A
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 06:33:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D12BF606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P/3fRZtB
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e9f6a16aedso2318575ad.2
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 22:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793773983; x=1794378783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A267S55gzLsHKNdX2hHubjRBVjQyKepuiQmncpiS49s=;
        b=P/3fRZtB4Qn317tlZqnrQOHNMnODYV5scoIBkngzWbm7EbPJDSL/xd0W/t6zO4uXRI
         BmPwbwD6oyUwUCNrkTw+zT0T7HLsOffjX9vLv5NhAr1QOddMCwsYsjeS+MEfDJDkPyfN
         0r6X808DuXj0HYmBHpB97UUeqovf8ofndKWnNZPHyW/HjFvftFE+xvD5i8IHqWM90HiD
         /bQu88706FAoYlIIOBa+jDf74VcitTwBUJ9d3y7fCQzyhbVqKhDPLNPqLdt7oHVAMhzb
         Y6VXnMAf9/jir/7leYCFvcfv5hlmDKOd1YrRZJfaacGkwVt1lQfr8g0AhbgtQ1G/0nVV
         ZzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793773983; x=1794378783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A267S55gzLsHKNdX2hHubjRBVjQyKepuiQmncpiS49s=;
        b=WOu/SIwcMq5wE5hh8n4MDaw9+PknpqANXEr42/uIQ5PpCXCkzNKR9ZEfZtbL92pHTv
         xQtDO9UJP6GDR5ClS+2WGVqv71tKp8js0hAgrTchCWOX4w+r0yDvLZ7wCDn5vdkkIDQ4
         oVdhDM/w4aJuieaOBaBRB5ohN4IwR8yK2bhOJiFhY2Hrbp0gBjgDAcnR121T3xq7UNda
         ax28+Ud8IsM8ie7V3Vk4HemgPt8XbpxyyyLgVy1x6L/BT6l98Dx8q2qW0cEriB6x6hF7
         v9rKrLXeq70KnznnVEVvv19nF4NaEIYqh6+vfbo62cvRhuE5w9jeoqCHql7sGMfW9qAV
         +5nA==
X-Forwarded-Encrypted: i=1; AKwUvBzfR7cW/fEgFtYyD2RanmHbUWCjmJNlN6RMnwH3pTTZK8DCrDofDVBs+zppaFmlveSs9vnth/g=@vger.kernel.org
X-Gm-Message-State: APuU4Z/LLJ25HWeTQ0kUAVkG2Lt4jiFhViMx/DL6GIGRfVyZFQUccnEE
	4gOUgkHrcuKHbWhERqvLACTAGkFihLCjew9i1vp54sOmuBx0zwtoup4p
X-Gm-Gg: AYBFou1uR1Ajz7FGN/NWFeLBXdYRBXAd2sFhQJSu7B3Miwj5vRG6L1WLfLn1FcLMqSr
	GxrEyUkkNboWZKqzJL6ZSkRzmXVfe/jxhBHhcz22miSucJKnvrWbCsymgQ6uMZ96qMUFjIbaXhQ
	+OS+epIzlTWArXJpAimPT7Z/3pTDmxO+2Y/HmM/tkpV/XS1AUOnNXMpdDj7stRacWyDMMwFK7ik
	W/1PBqWSBHN4QUwrQh4iqEqE75f2j0/9XF2ifHkoMfdHpnoDsZH2XXpoR6aZG37hyVf4I6NjT91
	ghgJf7ED9P8VIx5Puh3uQT3uUWTdw89OqMAHRbuyWWlrl3kexCK59AGBufVp8JYU+1EnlsN0zhc
	VOr9MpDcPaTrv2FNeSQeHLOFreZ0soqHGP5jxjqEsp1M+NpnL94rAOGWeKNr1+tFoFqa31wdICt
	smSV6UiUovea3mmdujcd1ReA05w8KJlrJuZ7kcV0YX2K0yKH1UCa/2Qb5znoPswjsIIBx/PZyMm
	f//P8QnR5dI2gTzw1VKkfN7sekJqdqISrNmq/Npw+n/FhuufGljDQCpmjOLSg7mc5Ie+k3/pTZU
	CfdFPFNXpVIq1Bn49Atlt5m5+Wstl86NGR0eO1gAe1SWsqfmSR1+4oKgng==
X-Received: by 2002:a17:90b:1645:b0:396:41d1:cbc7 with SMTP id 98e67ed59e1d1-3ae8957cf23mr12255501a91.3.1793773983145;
        Tue, 03 Nov 2026 22:33:03 -0800 (PST)
Received: from ubuntu24.localdomain ([124.77.157.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0945104dasm2583207a91.17.2026.11.03.22.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 22:33:02 -0800 (PST)
From: BeaCox <0xbeac@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net 2/3] net: enc28j60: disable work before freeing the netdev
Date: Wed,  4 Nov 2026 14:32:44 +0800
Message-ID: <20261104063245.23402-3-0xbeac@gmail.com>
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

enc28j60_remove() unregisters the interface, frees the IRQ and frees the
netdev, but tx_work, setrx_work and restart_work can still be pending or
running.  tx_work is queued from enc28j60_send_packet(), setrx_work from
enc28j60_set_multicast_list(), and restart_work from
enc28j60_tx_timeout().  The handlers access the private data, the SPI
device and the netdev, all of which are freed with the netdev.

Unregister the interface first so the xmit and set_rx_mode paths can no
longer queue work, then disable the three works synchronously before
freeing the IRQ and the netdev.  disable_work_sync() drains a queued or
running instance and rejects a later queue_work(), which a plain
cancel_work_sync() would not.

Fixes: 3ec9c11da033 ("add driver for enc28j60 ethernet chip")
Cc: stable@vger.kernel.org # 6.10+
Signed-off-by: BeaCox <0xbeac@gmail.com>
---
 drivers/net/ethernet/microchip/enc28j60.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/microchip/enc28j60.c b/drivers/net/ethernet/microchip/enc28j60.c
index d6c9491537..bb29a94a1e 100644
--- a/drivers/net/ethernet/microchip/enc28j60.c
+++ b/drivers/net/ethernet/microchip/enc28j60.c
@@ -1600,7 +1600,16 @@ static void enc28j60_remove(struct spi_device *spi)
 {
 	struct enc28j60_net *priv = spi_get_drvdata(spi);
 
+	/*
+	 * Stop the interface first so the xmit and set_rx_mode paths can no
+	 * longer queue new work.  Then drain the works that were already
+	 * queued; the IRQ handler does not queue work, so the IRQ can be
+	 * released after the drain and before free_netdev().
+	 */
 	unregister_netdev(priv->netdev);
+	disable_work_sync(&priv->tx_work);
+	disable_work_sync(&priv->setrx_work);
+	disable_work_sync(&priv->restart_work);
 	free_irq(spi->irq, priv);
 	free_netdev(priv->netdev);
 }
-- 
2.43.0

