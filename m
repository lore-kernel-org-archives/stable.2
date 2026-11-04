Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793805570;
	b=qvcqKpMgUu/SgngFC8H7fazO2E9zJJF3+Akw7s3TNB931ZTi2xoi1BIL9/GPKHRfxBLn
	 pIZZAHfq7oIaVz2kW48YsVMG1dhsCjao546Nbuw8LVPStdE0fRm7rIESyDaFjR8iHFV7M
	 GiBLxXF2wkweXIUxgUFOyssctlDhK9TJxVNZR/sYxhkE/f/4tmKvfFC4dKv1s5mc3zyXn
	 CgK2p9W9cYwxF8+KydlSOv3P5Jn3dZM7vhG3QEihgMlkt8iG3+fFEd49Jkvk06bboUVNb
	 OgLajiyC5D0rvGBteLmM8DFjEVIBiscU8NfBq1uDwGeyvtlU9TMUoDcv5uHB99gOVlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805570;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1kasbafd3T9Fhrw7R0Nr/dFHUF4ChKeJYhTGf2AiF+Y=;
	b=L5PoxoSDiwf/XPPGqP5q1vf8Gn2oBkUZWkDo4SRMejglM3fpyvN7JRndivP/jhMXxxqs
	 7iF+4DIO+TyNzJytFe4+5j/K/5xoR4gRuZgU60A0AaEAHvCPCbH1KAXPQgOnzJEBqzHgW
	 KuFGkTXe0st2U7TmRjyr2iDlvdL7Y+glViNvSEtUmkYP0RVWMUyeS0nWc0ON/iLx4LpXX
	 Hph93xUYk2YsBnKDtabzTYe8SjehguLGhEXQvYZ34K9obgbqUVYR325GDhjk7gXHs98YP
	 ub7X183retRQkc/gBbHU1X/EE5iUB6yrELhsKVS+w041fpyHxXfxibqzX6h9FUHP4TA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=grische.xyz;
	spf=pass smtp.mailfrom=grische.xyz;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C43606D814
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 15:19:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91C43606D814
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grische.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grische.xyz
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-490f38e9688so69141f8f.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 07:19:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793805568; x=1794410368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1kasbafd3T9Fhrw7R0Nr/dFHUF4ChKeJYhTGf2AiF+Y=;
        b=my8YSM3QWjtHgspjhoRoNQSXZsWW/12+F3ymLF/N5rJmophf4BCtLgDI6o4HQINQGd
         h6YyF24e5BsT9Z1J+73KHy88Fp3g+5x4XDlkShVxQsrSvH1eycsAqalVggUrZH5CWt4x
         USRiEM9hefR0e3+PTqv3PfvUTKK6fO2xN8nJQ1S1Kd9FzPVUAPIK72SnYS63Vf3xW+G/
         5D6N3qRk+QTizzXulFlsEhStCZs+M5u0/DRvvWfgkyj3w+7pSRbyS6Lkj1/cw168FTY7
         /KYum4onsJb3pvZzWyYuMYvv4JBU7/cXkiCyygGt6rPmk0k5/l9GZETHFeIk2VmAA/ee
         +kEA==
X-Forwarded-Encrypted: i=1; AKwUvBwd7O55zvt0+pKQkf0cqu3nPOH2au053NNT3dWYsMI6iXjvprBF+Os3pvsnfIH/nymSrUGWDdQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9SOn+BIGBREdut7r9BMvKvi1/1uoscyxdhHjGMLm3qCc2aNXJL
	pMXcv42CFWZGW96uWEOwjV/kxV9MK/Mx3QQnEnL2WVA7yxgrqc398/7GCa7xwjBH9ok=
X-Gm-Gg: AYBFou0btyHZsP4tu0V90sQOq+fclh7BWrAC9ZmPk3zRvVV5UkzRCcri6beBEbb6GFv
	41TE9mFHH5FMBiB08ADoIWYJRu/eLg/9R90pm+bESbbA7wK8zOp5kyAXCA5Es7k1BlETgwu3ruZ
	npnuF3Q0oGdZF9tjpGQoS9XicU1+A5AbMVltXSCnypjJu1d1p3vXxrAdwAPCA4RLRMD8k/y9VVU
	Z7ZFErItnM6F2qAZVFbEyLwwvwpNmESHBpcWHviGAE0LOjjN3PutLLTJ+Y86o8w9nt0kRFGfxel
	xN2LRknOPrqT1As8u/ULNyz0i7VbJgW21RxeCX8gwCuZvM3ritC3WhLdl6xZzGW/xN8gaDiICKV
	OQ9tdEVcCZ6pFlmKg1KAGIb8QwaFAGHBgvltPzdfwud+6Noezyf58+s1Bcxe/qJFYE9GZZArDDC
	1igxxbr+sOIimIP6bBOnh3cfPU6KQN8cN0Rp5H8YeG/ajMDrOAg0qMI/OfNCUqpPv0/Bhv7NXo+
	M4bHVLFmbIsYrBIiOXoGlaaf5OFH3Niw66PZYPvwHn1emLzf6/+grc2sgaRITpmVmUxK7oE8894
	QaUJwf3y+DpauMFHfIn8aadymQ==
X-Received: by 2002:adf:e18c:0:b0:48e:eb:56c5 with SMTP id ffacd0b85a97d-48e6e2c1d83mr40340920f8f.8.1793805567922;
        Wed, 04 Nov 2026 07:19:27 -0800 (PST)
Received: from lake ([2a02:810d:d09:1b65:4366:70cb:bf82:f8ac])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fec8d8e29sm4639812f8f.19.2026.11.04.07.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 07:19:26 -0800 (PST)
From: Christian Schmidbauer <opensource@grische.xyz>
To: netdev@vger.kernel.org
Cc: maxime.chevallier@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Christian Schmidbauer <opensource@grische.xyz>,
	stable@vger.kernel.org,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Ong Boon Leong <boon.leong.ong@intel.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net v2 1/3] net: stmmac: honour Rx checksum errors in the AF_XDP zero-copy path
Date: Wed,  4 Nov 2026 16:19:11 +0100
Message-ID: <20261104151914.2651241-2-opensource@grische.xyz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261104151914.2651241-1-opensource@grische.xyz>
References: <20261104151914.2651241-1-opensource@grische.xyz>
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

Commit ee0aace5f844 ("net: stmmac: Correctly handle Rx checksum offload
errors") taught stmmac_rx() to honour the csum_none status, but
stmmac_dispatch_skb_zc() still ignores it and sets CHECKSUM_UNNECESSARY
for every IP frame whenever the checksum offload engine (CoE) is
enabled.

Since commit fe4042797651 ("net: stmmac: dwmac4: stop hardware from
dropping checksum-error packets") dwmac4 delivers such frames instead of
dropping them, so this path receives them.

Mark the skb CHECKSUM_NONE when csum_none is set, as stmmac_rx() does.

Fixes: bba2556efad6 ("net: stmmac: Enable RX via AF_XDP zero-copy")
Cc: <stable@vger.kernel.org>
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Christian Schmidbauer <opensource@grische.xyz>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 7ffed295eb14..3e5803db19b4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5547,7 +5547,7 @@ static struct sk_buff *stmmac_construct_skb_zc(struct stmmac_channel *ch,
 
 static void stmmac_dispatch_skb_zc(struct stmmac_priv *priv, u32 queue,
 				   struct dma_desc *p, struct dma_desc *np,
-				   struct xdp_buff *xdp)
+				   struct xdp_buff *xdp, int status)
 {
 	struct stmmac_rxq_stats *rxq_stats = &priv->xstats.rxq_stats[queue];
 	struct stmmac_channel *ch = &priv->channel[queue];
@@ -5575,7 +5575,8 @@ static void stmmac_dispatch_skb_zc(struct stmmac_priv *priv, u32 queue,
 
 	skb->protocol = eth_type_trans(skb, priv->dev);
 
-	if (unlikely(!coe) || !stmmac_has_ip_ethertype(skb))
+	if (unlikely(!coe) || !stmmac_has_ip_ethertype(skb) ||
+	    (status & csum_none))
 		skb_checksum_none_assert(skb);
 	else
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
@@ -5789,7 +5790,8 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 
 		switch (res) {
 		case STMMAC_XDP_PASS:
-			stmmac_dispatch_skb_zc(priv, queue, p, np, buf->xdp);
+			stmmac_dispatch_skb_zc(priv, queue, p, np, buf->xdp,
+					       status);
 			xsk_buff_free(buf->xdp);
 			break;
 		case STMMAC_XDP_CONSUMED:
-- 
2.54.0

