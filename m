Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795338828;
	b=sKKy/z8LcOry5oP8H2DHB3YVQ/fMdJ+IBpbMlAsnRIdTvpwoc9vdgyW2cNo8n/WPyn+y
	 NmLo+Am51C1bsprw1vs19hrcotMzUwOezpOCxr3aptUe9xXEGjpOrtfJtgGQZHJmsQ52g
	 DgTkKuQ5rXubkYeZosxPmB3bxSY0FvdlgoM17yWLJyPG5LqaiubcswJJmGEzYE9NdU1pg
	 SvY7OmMeeb2lCAG+q9SWVbNxUCbHN5IluEvSXhmIwZdcfAEVx5w9CaPicLhmU2eSEtppu
	 h0+sHLZWsemUsx4OPN9PCX/5XGhbhxpO4JZk6vOOleqkDXce3iwDagxBMNaSGhQCmIg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795338828;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=kQry4Cjw3RPbx5td1ZWs5hKjkfOnlF6f++DPnxPHX6o=;
	b=d66Q2eeXrOcnPI+7xtcR7i9ydXF9/S5COG5s0t/tg9MsRGvVU37/hH2kaVuY2OjbKE3T
	 KxZJnoRN+yV8Ehjmonog1z3dYmUOtiFX06ltqgN/JK8ZOMJT0VHEn/oRi0erlE5KYSmv/
	 BIM/tCN3nFTiaNE1kfM1kx88eSF+4PaJHcgSpSQCmWiD9mF+hiNvkEh/L5eemp0OMMdyM
	 kcoe6HeKodazL+LWt4yHY/y+RqBoUdB6koJp1V3Nxl3VStak1qnCKsu8FCZH5aU8K9l2m
	 m0O05eCM33d0QrroADB5FgxK9zDnqC6bcnhHz7BmAhj9ZqC6cmIG8pFpuUNdtQ3dE1g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jr7GG1GM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96024606A32A;
	Sun, 22 Nov 2026 09:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jr7GG1GM
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795338828;
	b=CkESDhiyd9wn0L/Zq2tE0Boh/3/D82+U9r4euSCCbDNGCJ0k+ImcbfgcnIWh893AljcU
	 JVmcZexQsZOBa6J/JjCBiYZRg6H0IhS6PXaxs8Sx70vGnA45+1HzpAvi2WZPt0F8VF/br
	 lY7oJri6w14c8kK5bwhlWK73onYiudrZoOL13xWcUB7Farj2+2/f9ipUEVHs5t121aOJB
	 9DoXWXrbPFbZl21p0nTrtRv9/RQy6N4xjgwjW/6A/+Po6R7GwZWZKqDSdBFASJPZi0GUV
	 S0+3d4O6fk5FzdtiRyh6X324Wrq9q2ezaj1vTfbaLWRmx1znEOlFcIGct96cGPaIMJQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795338828;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=kQry4Cjw3RPbx5td1ZWs5hKjkfOnlF6f++DPnxPHX6o=;
	b=jlljnLjYolqF9TCoaEevqYNU5bKiNg6XgbOSk08nP+UBYTGOVuS5RNaYNoY9cLZCq8Wj
	 t4msnwnEu/i5r6sSA+tYZ0+dM8iYBD0yLzzXqh3Yac1bDEZUcSLT87qg4Hz3TUiVTcsOZ
	 N3rhEtAznLLcCKOvU+2I7bv06w/7vYQcf8NXHCstuRqc4Km75WQeOnmc9eanWBXXNEdsN
	 jpc4VkI+vKRm51/XVTgLfUifoeBCsxLz3zH/ihN2IPnbwvEb9oY78b/ApgdZ5q19MJaSq
	 BE/e3MG34tH6xu9mmGBubLTcIgeZhOkxQUY+4kBPTACK6Kx6Uwyjblcdal45zSuDnmQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A5C621F000CA;
	Sun, 22 Nov 2026 09:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795338828;
	bh=kQry4Cjw3RPbx5td1ZWs5hKjkfOnlF6f++DPnxPHX6o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Jr7GG1GM3wN8lGV/5Ne/P+ipH2xCagiq4gW/RFVvvgriQGQjvtcJCJuobyiqWmO7m
	 GsX+6Gf2hKIds+h6SHSrDOkEga44QT5ZuHf7LMWJO1egwE3RB6JLG5PML+huhsZRR1
	 rb6n2YC1JFTI3U24bqBu5AVWqz7ofuGmZSvIaNS6uLbTzpFbKPjcblcB7wMlF2D0gz
	 tQ7FGi/+lorNgo6XwJ3xAL1DjHXz5P0tod5MxyzNBqgHVVONsn9lr5XPVtawvM4CsQ
	 bZtAHSNoVlK+k7cKW7F3BfFvO4OFvaG8KqE/nZU7yL7yDz0R7VNW2FU+05wqZZ/B30
	 /o9Ms/uptGnRw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 344354BFCA;
	Sun, 22 Nov 2026 09:13:47 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Sun, 22 Nov 2026 09:13:47 +0000
Subject: [PATCH net v2 1/2] net: stmmac: Limit the MTU of normal
 descriptors to one buffer
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
Message-Id: <20261122-sun8i-emac-mtu-limit-v2-1-c4081e5b83cf@gmail.com>
References: <20261122-sun8i-emac-mtu-limit-v2-0-c4081e5b83cf@gmail.com>
In-Reply-To: <20261122-sun8i-emac-mtu-limit-v2-0-c4081e5b83cf@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 LABBE Corentin <clabbe.montjoie@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 Russell King <rmk+kernel@armlinux.org.uk>, 
 Nicolai Buchwitz <nb@tipi-net.de>, Arun Iyengar <aiyengar1990@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795338826; l=1453;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=ydeE7IevavZwGHNIu116JiJ5XTZiQzYRPI/kkGQMzGs=;
 b=OLm0NCIxVOoxm3a4kij2GdUDVN9qdNUwsdi1iIXrDZaiZGALtLXXIx9TtK0tjAzcFaWaxY1k8
 mGSIgLgx6xqC513OzVh3vXdfOC+UQQ/ED6uVIfpTgaEe/CLkDlGWvW+
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

Russell King noted in [1] that max_mtu for normal descriptors,
SKB_MAX_HEAD() (3712 on arm64), does not match the hardware. Their
buffer sizes are 11 bits, and stmmac neither splits TX frames nor joins
RX descriptors for them, so a frame must fit one 2047-byte buffer.

Limit max_mtu so that a frame with two VLAN tags and the FCS fits.

Link: https://lore.kernel.org/r/E1vLJcL-0000000ExBL-0GFe@rmk-PC.armlinux.org.uk [1]
Fixes: 48febf7e6476 ("stmmac: allow mtu bigger than 1500 in case of normal desc (V4)")
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Cc: stable@vger.kernel.org
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index a685ce4638f6..2a27e1e7f9b9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -8247,6 +8247,9 @@ static int __stmmac_dvr_probe(struct device *device,
 		ndev->max_mtu = XGMAC_JUMBO_LEN;
 	else if (priv->plat->enh_desc || priv->synopsys_id >= DWMAC_CORE_4_00)
 		ndev->max_mtu = JUMBO_LEN;
+	else if (priv->hw->desc == &ndesc_ops)
+		ndev->max_mtu = BUF_SIZE_2KiB - 1 - ETH_HLEN - 2 * VLAN_HLEN -
+				ETH_FCS_LEN;
 	else
 		ndev->max_mtu = SKB_MAX_HEAD(NET_SKB_PAD + NET_IP_ALIGN);
 

-- 
2.55.0


