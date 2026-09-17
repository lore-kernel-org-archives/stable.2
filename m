Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C120D4AD7DD;
	Thu, 17 Sep 2026 12:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789649101; cv=none; b=I5/86iT6msriUjxC/ZsekW/spyDdJfBXga3SrFZEbPgPSk9IMHBqmX86P2bxkJVPEIsEK9UpGJ9Oz6YRq7FucwMfyfWBOEezkY1SonxZpG3hsrcfwY0SWdP209XaxQHm1PFWhBjvkw/IF1/duaaN2ZPZD2dQOlqW+kXmcGYTGxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789649101; c=relaxed/simple;
	bh=Et3Dd7CnMhawxZfrawZeh/YHWG6zUOvgBYdFTpdbvPU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sfcDYLUQ7He+mpNdJDSnIjqUtwPCzbbaPktv9rfqAoCioQMvQFLT6I8DFzQtDyaECKfVDjkAs8VSbvFNIrsRNBBXur3vUJg5lxmZ2WFd5eZPbjyzMZ0/RhgJFtGVDyLPR9Af4X8naXsCgVB2aTS36c5oBhle0Efb7uczJdP6JHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=AzYpqDKD; arc=none smtp.client-ip=117.135.210.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="AzYpqDKD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ud
	jmkgviHBM10spBzNASNtKUvaVRGwvulqW5jHHFEYk=; b=AzYpqDKDPT6uQ0QNSp
	AFQsykS5eszIdzvKC3sbJDAip2ApyxCFKrWC6tJaLF1+7RPasXvilXi6Pv7wri5E
	g+VqD3iMmMBdgFqxdzkS0/RWwgXjKtARdm3OM5BGFA6IYOHMo8IQdGadJVm20AKt
	euVjcPEPKQy509PH5tBse5m7Q=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD31zM84KtqpddEBg--.12077S2;
	Thu, 17 Sep 2026 20:42:38 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: maxime.chevallier@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Linkui Xiao <xiaolinkui@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH net] net: stmmac: do not cache the new TSO MSS before it reaches the DMA
Date: Thu, 17 Sep 2026 20:42:34 +0800
Message-Id: <20260917124234.1348673-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD31zM84KtqpddEBg--.12077S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr4rJFW7WF17XFW8KryrXrb_yoW8urW7pF
	4UAayvy3s8Jr1fZw48Cw40va45JayxtFWYkw1UGr9xCr43Jr9FgrySgrW8W34UJ3y5ZF1S
	ka1Du347AF45JrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UlhFsUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqR7Mo2qr4D5VtQAA3n

From: Linkui Xiao <xiaolinkui@kylinos.cn>

stmmac_tso_xmit() fills the MSS context descriptor and stores the new
MSS in tx_q->mss right away, but the descriptor only gets its OWN bit
much later, right before the frame is handed to the DMA. Every error
path in between - the dma_map_single() of the linear part and the
skb_frag_dma_map() of each fragment - returns with tx_q->mss already
updated while the MAC is still programmed with the previous MSS; the
abandoned context descriptor is later reclaimed by stmmac_tx_clean().

The next skb carrying the same MSS then compares equal to the cached
value, so no context descriptor is emitted and the hardware segments
the TCP stream with a stale MSS, generating frames whose payload size
does not match what the stack accounted for.

Only update tx_q->mss once the context descriptor has been given to the
DMA so that the cached value always describes what the hardware is
actually programmed with.

Fixes: f748be531d70 ("stmmac: support new GMAC4")
Cc: stable@vger.kernel.org
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index af2d38a2bb3d..a8f94cd6abb4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4563,7 +4563,6 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 			mss_desc = &tx_q->dma_tx[tx_q->cur_tx];
 
 		stmmac_set_mss(priv, mss_desc, mss);
-		tx_q->mss = mss;
 		tx_q->cur_tx = STMMAC_NEXT_ENTRY(tx_q->cur_tx,
 						priv->dma_conf.dma_tx_size);
 		WARN_ON(tx_q->tx_skbuff[tx_q->cur_tx]);
@@ -4714,6 +4713,7 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 		 */
 		dma_wmb();
 		stmmac_set_tx_owner(priv, mss_desc);
+		tx_q->mss = mss;
 	}
 
 	if (netif_msg_pktdata(priv)) {
-- 
2.25.1

