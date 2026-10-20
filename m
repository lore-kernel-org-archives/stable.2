Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792523005;
	b=U/BBQp1phRUgqg/iwBIPT3AKVxlKZv5260BgvKNydpxwcQRRQPLlrqjNTtjU7XX3bi10
	 4Z/CY2QqYkAEhCHtapqqSaiFkKV6DDyoSUOMUuN9jN7Lt2CQyWs4aBq1Z9zVvYd6UALwA
	 bObh/qACiawSXD/TXbi0pvmLn9y3qQBJIG8Y5IlAs9WoZBOJnTDqA06BldOqC3ZvUb7py
	 Cnom8pRRyMmnFGnUJxmyh+KQnwllWbSecWLqP8hCoGaBvcCRHzl8HPd2Fdo/LWGoDwkrn
	 HXMUrTua+LoJHgPJM8BpDhYkDlq3wBO7MlBn+QyLGzbeghbIRG/EYK4I4ie6QtwhwoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792523005;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XW2XawDSDFkTSk897IfBcZxxEG8qyMFEO8Acjxpagfo=;
	b=AN0CYLVXDQhccuj50np/SFjsMF4mzWuUJ7zaANByeN7wnuFNyDPncBMr8hSXgkLVQr8y
	 4L8iP2r9Lx4GntJXEFzHJhidDfNhXxS/3esZ/sH4F8cMoF8nzllPqtEo8O4b7pQVmieRX
	 BVp5FM3Pb+6Ucu8qDMEVFbPQhFPJzBVOaShvtvuNTtCqozZzpjl/3uVhDpSVbZxcDBRMB
	 o1loYWUU84FWAX/Q7WCHE4GFDU40S/Ur+1G6KdUuNH1GmOLFW/qJC2YIzXzTqgV66s+wV
	 Ql3lumXaGN6q1VEJaLiesHVgpCyihga2B5C+IbZdCGPjdC5uzJ1T53zOJNzOwuNfRYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=grische.xyz;
	spf=pass smtp.mailfrom=grische.xyz;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3CE606A326
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 19:03:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF3CE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grische.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grische.xyz
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48441a2ba1bso2312548f8f.1
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 12:03:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792523003; x=1793127803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XW2XawDSDFkTSk897IfBcZxxEG8qyMFEO8Acjxpagfo=;
        b=MF6Vd0T4Zs98ohTZLhGuuU2l526gBr0sEcuU+lhnJ4BX3p5DxfmUtpvXvGp8H8pQD1
         a+qcUBKNsnCVWv487GDvcOjhsImZ0iCiO+9TAjCvu5XQ0hI9Db0VO5LRGnxwzGzeLKno
         lIRhvWkfFXwcymwJafxuKO96NjbbRUPjRTV6FJpC05EsWLsOazCjOJ9zh0ZEXolbi5Z+
         TvV4D48WncNKqt4JKPoDOWsPsZjgZRxlMafZu7qZa8q559Pt22PVmKgpRYWs+1YAv2DN
         hYbNsBXw050fjx2+cecUOrN21E7kAtuJ1F1XHORsrV4qEKZ8XwxtkQaiXLBpwopxOnXA
         TWvA==
X-Forwarded-Encrypted: i=1; AKwUvBwCvE1r5Mw8gFmfdqe4bX85tH9hrT1JYbkDa2+cVFim8A9fE+eAxtZLQL1AmDFIa8cVTGHnXSw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ5iqhXzMvF32t80encWtsrdH10ETuc1ammVuIay8A02OKz9exc
	lDzSD2Bk4RXAuSQUSB6BxF4EstYsBHxbHDJoG8PDd3IOXezvuMe6hsOwE40XchanIks=
X-Gm-Gg: AYBFou1qZsvyqQSFLWBP6VoCgwlOKBwGVmQfE7Yc7NSyx0f61Q8JR8av7XngGc3Pd9u
	sVUD8w4GfJi/uQl8hpdQ5qQltgQFg1uRoKhc+gwbHMYEr7Jo+0fQ1ICXKHVdI/FcDCqmKMfproi
	1NR1v1X4CDSoXSnCHpkTB74lpIy7dMZzjD+kKC2OpTlnGwsBLGNtDAnEXLpY5HI7jOz9y/wDe2T
	TmJYXqiaA4/KoW6sAANckeMG/6cfDk9bfUU6aUfNhmcsuwSTfP3H7pYbb3cy5q+1P7pP0QjfZDC
	vMvlok7O2kMvYezaq730RZHo9672/ZNzueiKq53hzNr262T6WWjfH6LJ5Y4ejbL5wzdKWXUvfAK
	FGAdMjC3SS8VpKyJsu4MqUPzncBD+II7PnTZ5/UUzVEleWh3PXqWd0qCYci0VB+v0IfLTYG/QC+
	VE1iT7/ZBpxTLMfv7hwZQTCMhh/wbwDhzPm9mwHWrglwlRCVRnafvEDHMsiWjG3YN7RFKq
X-Received: by 2002:a05:6000:1ac9:b0:488:8bc1:a2eb with SMTP id ffacd0b85a97d-48e07f99197mr25786391f8f.39.1792523003036;
        Tue, 20 Oct 2026 12:03:23 -0700 (PDT)
Received: from lake ([2a02:810d:d09:1b65:a3ee:29e0:454d:c31e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25828cbfsm279157f8f.23.2026.10.20.12.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 12:03:22 -0700 (PDT)
From: Grische <opensource@grische.xyz>
To: netdev@vger.kernel.org
Cc: maxime.chevallier@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Grische <opensource@grische.xyz>,
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
Subject: [PATCH net 1/3] net: stmmac: honour Rx checksum errors in the AF_XDP zero-copy path
Date: Tue, 20 Oct 2026 21:03:16 +0200
Message-ID: <20261020190319.884375-2-opensource@grische.xyz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261020190319.884375-1-opensource@grische.xyz>
References: <20261020190319.884375-1-opensource@grische.xyz>
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
Signed-off-by: Grische <opensource@grische.xyz>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 9741f97fa37a..32810f949245 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5463,7 +5463,7 @@ static struct sk_buff *stmmac_construct_skb_zc(struct stmmac_channel *ch,
 
 static void stmmac_dispatch_skb_zc(struct stmmac_priv *priv, u32 queue,
 				   struct dma_desc *p, struct dma_desc *np,
-				   struct xdp_buff *xdp)
+				   struct xdp_buff *xdp, int status)
 {
 	struct stmmac_rxq_stats *rxq_stats = &priv->xstats.rxq_stats[queue];
 	struct stmmac_channel *ch = &priv->channel[queue];
@@ -5488,7 +5488,8 @@ static void stmmac_dispatch_skb_zc(struct stmmac_priv *priv, u32 queue,
 		stmmac_rx_vlan(priv->dev, skb);
 	skb->protocol = eth_type_trans(skb, priv->dev);
 
-	if (unlikely(!coe) || !stmmac_has_ip_ethertype(skb))
+	if (unlikely(!coe) || !stmmac_has_ip_ethertype(skb) ||
+	    (status & csum_none))
 		skb_checksum_none_assert(skb);
 	else
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
@@ -5698,7 +5699,8 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 
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

