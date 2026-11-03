Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701741;
	b=1+OAsmyK1I8UE1OI9eVDbb7e7bKtngMTZfyud5RR+yBENDsmUQypwMWy6zpHQ0e3Tm1j
	 xMByqFagkVufHG7+IOSgWEpQkk/+vDM/epRHK9vFZqgEw+3ONyAM1vHXGYGM3fuFRv2KU
	 B8iipebQ9YVVA82QlKRQqJDItZSUyrft3Wibj+rK5x7FmmT6zUOxfGKERJnoQ/6YckNLL
	 bIC8fuc8UQ5skn+ur3Kbq8UBCP+cYmt1DH88miHejDjnH3pzsWRRWoeeEbLW/eCfD9lsJ
	 doC2QuuyJ8AgHBj+nTult5BLIidt7U43p7bryWpeh8rL7jH3rlUXyjxyIyVUBXZW/xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701741;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=jqrLKz9LrRsFxqXYepb2D+Y6GF21YYOQi1/zUhtLyRg=;
	b=KKWNMgwM/VErlO9hUW/w2z1J4nekDMxVuAW9DMBrq+D5VJdnw5aRqnLRqg4wkkyvrodv
	 U+CESW0eobsO3axZAcstyfleIWyv5ODkjdLBKjxsTdv61dNtJ/ibeDdoSBrtnu/RXZ7gk
	 LFUMlzfndb4//8NE1Z7fkVQ7kXyh/32Lhz27zuW3KiftPMh9sNPmPgWgarKGhBAi8yiNu
	 CbKYPD0wb5R3BONUxz7tdgDJHhWJbxFxvH2MvPVAjDtUvchcs32O4LiogKHAh0EuxrvAP
	 XWsSgSfyfeS2H0bOkyaE2dNopoebngdNeYOtiuVW86CWhSEi78cy5e5FuVq7JV3u1tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8252760A5BC4;
	Tue,  3 Nov 2026 10:29:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8252760A5BC4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAC3wZJgt+lqsak7AA--.3028S2;
	Tue, 03 Nov 2026 18:28:48 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] net: stmmac: free RX resources when TX allocation fails
Date: Tue,  3 Nov 2026 10:28:57 +0000
Message-Id: <20261103102857.1340748-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:rQCowAC3wZJgt+lqsak7AA--.3028S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw4DZr13ZF4UJr43Zr43KFg_yoW8XryUpw
	s3ZayUKr9Fqr4fJw4DJw109Fy3uaySyr4UWa1xZa1fWF43uryjgr1aqrWUXF1UJFW8ZF1a
	vr4qk3W3CF1DA3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9a14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26F4UJVW0owAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6r
	yUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_Gc
	JvcSsGvfC2KfnxnUUI43ZEXa7VU8jQ6JUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAMAA2rpnOFxBAAAsH

alloc_dma_rx_desc_resources() unwinds the RX queues when the RX
allocation itself fails, and alloc_dma_tx_desc_resources() unwinds the
TX queues when the TX allocation fails.  But when the RX allocation
succeeds and the TX allocation then fails, the RX queues that were
already set up are left behind.  stmmac_setup_dma_desc() only frees the
dma_conf on this path, so the RX DMA rings, page pools and socket
buffers are leaked.

Release the RX queues from alloc_dma_desc_resources() when the TX
allocation fails, before the caller drops the partially populated
dma_conf.

Fixes: ba39b344e924 ("net: ethernet: stmicro: stmmac: generate stmmac dma conf before open")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 9ded31150fbe..049d85b3e25f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2446,6 +2446,8 @@ static int alloc_dma_desc_resources(struct stmmac_priv *priv,
 		return ret;
 
 	ret = alloc_dma_tx_desc_resources(priv, dma_conf);
+	if (ret)
+		free_dma_rx_desc_resources(priv, dma_conf);
 
 	return ret;
 }
-- 
2.34.1

