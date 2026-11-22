Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795338829;
	b=lV1fwBLm3rSDvsuR9pnZN8ssNoLHymLWV61zMId/10lbZN0hy3UhuwpWPiP9HZVcoXHY
	 zPz09jd/Ht9uzR7Uc17bqjFivKxVJVZF7382IEtX00OLX5gDrZdUV78QyRdFv8cOY7HtR
	 pbaRYEOSWNuPVCyw17YkDOKnUygJsIc6BmN+dNRVbAAhX4v8aMS94IC402A4A5aRujay0
	 q1m7TehGTh+2imlmyIiOtnVUcn0JSfrOk5O9IPZ8ER3DRINQLc9rb5jL557c21NvYqlEV
	 Iv3sYGWNQjvnTIgoiK5h8Vw89cOzXtxtU6/ptn1vs3P18s53LrkcsydtnmoO860yenw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795338829;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=03lpGLn/bddD577LSC4qtqKsNtreiXE/VEdiR+KAR38=;
	b=bporuLPPzl4nvbi8g9VO/5j857LuPDBu2o/HVfGZ5kr5Vi9IEWTBecio31MPuqzadI60
	 NjCc5IrgcFLcmYTxqoHkZSkDRWpAThHRDcujsRAHpfGJct8K/xRoCRaBDsJLlKacrFzN8
	 lhueis+oHWnPONpWHj0M8cR2gcFwKO5nVEtxyCqsiGR3LjAMPg4wgkiQXsf4kEA2xLETF
	 SUvuct1zsp2mAb5nJviwPZ0PeznKgvNY6d6w15eBAI96UjnCLXONQ3yEm1UO/ssNBNsvm
	 /T5+LymkhZz80V7qfn/HW217DTcGkJfUNwcmGurJYhVm5YDApAK683f5jaXbD8nDQFQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="SXiOCo/d";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B517606A338;
	Sun, 22 Nov 2026 09:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SXiOCo/d
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795338828;
	b=JUx5MZUTrkdGqMiR91i9Qqek1GbCdzNIUm6aiYULjvUS2trcw/Mdkt0YGGJmcoOL+ZIO
	 uGR/fRqoBeXxQ32YPsUJVFyZpMAIUBLN0izl+u13bQZyQnbFdLdKH/dBFyEtxP9zwy4zT
	 EjaTnRZgxNzRfP08t4BtU0JZeLc/VicpkcFAPEAi++TI7sWprZlGloMuvnYox+fnn1jOV
	 WvDoYm1pzNBIuSqqsAfIliy82f0OyB0Y0nc7KbrJyVtdKyUhuavui0VTVqsw/kQ/H7BOF
	 UNKL92Ufr11FM9xkxHay/14DgVcQkIPGZMWF9hKkkonKiLqAOgr05Bam63th1COC1Mg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795338828;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=03lpGLn/bddD577LSC4qtqKsNtreiXE/VEdiR+KAR38=;
	b=e3eCDFHTqOZEfI+Ah7SZ/4PJ9rP+BydaVI5HO5RuZ0p0ZxyY5uW3uL+AhqvXr0EWdcXe
	 Dkla9VKW9vg+UnGtw7vsVjfjLr6MbU+97Qaep+ZhFeppxTxHEtfWLfjZVrGK6mlh8tpl7
	 zbLN0KK079X5bYSVdCL/8nA8xcauATOfBLruXbGBsLZT01n+HGgyKscfMOq+UcjFfWEjn
	 KtQb2BWlLrSeu0gowvU3jbKG7BA1A1OmAfb1xBc9bwm33H58MWn4cvScD3r85bR18XZEF
	 ROAnMUSCXgQ2isL5FqZfaIPVqfEGgOihwIAm90SLQOoGpKpWZeztF0BoAws8lp+kkxg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BFA891F000CF;
	Sun, 22 Nov 2026 09:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795338828;
	bh=03lpGLn/bddD577LSC4qtqKsNtreiXE/VEdiR+KAR38=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=SXiOCo/dV6Mpv/ALd/f5WJLrpYUV5rSMonz7x9bSN5rrzUezVn22LW7S6MXLzb0FI
	 lYRJFE/za5KXtdj1rgoPVsfI6JPZDVpuAv2vyhXeNy+Inx/GxCcNkc/cEQ41dL6UsV
	 bL/onpK9xL+jW5W891QcllFHdHT5Gnp/EZzufrZEHDCiNVV5nHjEUrYx+I+jEaR/uj
	 74RQlobRcgJnt7AJK/1kwjSh/NO+o9Xl0vr+CLFUlYKlbZJSIPNJxJrQRVDGm9FXx/
	 HmjDlOW+0OElzqQHWGo5XtuWXwpwxFU5UOkXhTJE/YDw9W4bq4YshQhMctknPHMvl6
	 UPZQMWDSXFO1A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4DF194BFCD;
	Sun, 22 Nov 2026 09:13:47 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Sun, 22 Nov 2026 09:13:48 +0000
Subject: [PATCH net v2 2/2] net: stmmac: dwmac-sun8i: Limit the MTU to 2018
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
Message-Id: <20261122-sun8i-emac-mtu-limit-v2-2-c4081e5b83cf@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795338826; l=1070;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=hoWHCAAprzrO2D+coALtPpyIBw9Qkx95wvyejnjliCM=;
 b=so3ZK26Uz/bNPFobSNeO22ZQm5P4aH7euK1OUEWe1ZVZE0wm4pIfqRAkW6IWpaCz3BSNnqcoH
 8J38CexopsuDI097y8ytNlosmfgYlB7QO7/ZFWQ1GLxpzn+Ltn+ToJd
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

The H616 RX DMA fills only 2044 bytes of a buffer, so frames of 2045 to
2047 bytes, allowed by the previous patch, are dropped. Limit the MTU
so that a frame with two VLAN tags and the FCS fits 2044 bytes.

Fixes: 9f93ac8d4085 ("net-next: stmmac: Add dwmac-sun8i")
Cc: stable@vger.kernel.org
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 2ece7ba9dd73..ec401cae8187 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -1208,6 +1208,7 @@ static int sun8i_dwmac_probe(struct platform_device *pdev)
 	plat_dat->mac_setup = sun8i_dwmac_setup;
 	plat_dat->tx_fifo_size = 4096;
 	plat_dat->rx_fifo_size = 16384;
+	plat_dat->maxmtu = 2044 - ETH_HLEN - 2 * VLAN_HLEN - ETH_FCS_LEN;
 
 	ret = sun8i_dwmac_set_syscon(&pdev->dev, plat_dat);
 	if (ret)

-- 
2.55.0


