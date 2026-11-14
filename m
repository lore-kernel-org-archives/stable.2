Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794663406;
	b=ywYvuGslSRLQymoUFXEBS1FvSW90dWmwXxImNFBT5/PjPdvKAc3dkMjZ2XLLXDS/uiwC
	 T0IRacarEDUwnyZNzayE4CSiN2dDeE5uweGeLokVnInGVRNtjCbZt6XZsswXvqDeyvGWR
	 ecvj+34WfMsUy1Xc8mK3rmqaU8bGN7wyNJ5eTw/0MM9tw1WJAFrJsSgs4hVnPmzRB4wRq
	 jKqmDlRIf4SVRACVw09I1sAOBirQhk5i6G5ZZfhZFbIQGwMY5bQtbvAj5C5T4OUBs0pI5
	 vyKGLv2yddF+acknzrxZ5x95zedG0xpR0PDCCgRDn1psqpsP9R0JlwzJuRxUDls9Xsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794663406;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=1kasbafd3T9Fhrw7R0Nr/dFHUF4ChKeJYhTGf2AiF+Y=;
	b=hAAGNqvTAFZpeXUXoFbbGQC9/cQ8Ly63N9oP2g8Ei5qHKFXDYRj+zE2IV3Jzvl/noMhn
	 otFEoxG37Xf+s3BQa3iCPwVDPvbaAo7jKpjg7idF7AOhT5l5AYfQTfe9eje7r145USQlU
	 tHeD8B+3YA6Uqi0mht6BT6d4GotR8CdLnuI27v1j5u9/DlM85hPCY7GU3ZlkzR7GwPgmW
	 NkQFHBzR0Y2D0Hv1AXqNjIW4Tt6Woz0qIHSfLVDpKec9iZ6bjm5DxmK2oNtaCp+aoxVhG
	 szSYvR7hgDb07umoWf5t1xpMz69QJJoDIPt8Lu6PE+SdjYYJaiVUyVCFoe8gaIufV9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=grische.xyz;
	spf=pass smtp.mailfrom=grische.xyz;
	dkim=pass header.d=grische.xyz header.i=@grische.xyz header.a=rsa-sha256 header.s=google header.b=RLiTW4j2;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE1F606A33A
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 13:36:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCE1F606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grische.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grische.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grische.xyz header.i=@grische.xyz header.a=rsa-sha256 header.s=google header.b=RLiTW4j2
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so9074995e9.1
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 05:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grische.xyz; s=google; t=1794663404; x=1795268204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1kasbafd3T9Fhrw7R0Nr/dFHUF4ChKeJYhTGf2AiF+Y=;
        b=RLiTW4j2PZ22Di6wXigCid5UZFJoV8dam7pEz8ccG+3BR1ZeTpnU/jNYAdUaF6+GKV
         i4u/7Ahng6orsr62b4sAutMAc49qkZhOwoBVIUV7+sQMzQ/RECJlhxBglurbIjPkJ7c1
         80jVIZDhu7AB1+KcwjFjddolobsJ/sVfAdM2BVtyRYJ8rONTqblrO3dBwr6f6esVg1Ek
         sBFq+16x+IvjNW+wRQYuZxLo9ySeio0fArjTkHjGFAnz2LVbcyXrgkANCZHgChnkDoA9
         5QNoMASS08Vn34NZb9IBUnhw0jMaxOUbNcHwbUBD8oKt7dUPJgFjGvNz3Cs1ZB0H/DXb
         jRRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794663404; x=1795268204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1kasbafd3T9Fhrw7R0Nr/dFHUF4ChKeJYhTGf2AiF+Y=;
        b=yg6Zvf4UnSaMiFc/PHCHAng2Y92ctY/i23AYPuDbAsar1i6XjnrLwYeWL4yXxKO/m6
         Pcg2o9zB4g0O9otwZ6q00vfIcdpRnFgbJVZMdgKtSidqNm3xYVA6LmsmxYQynaaRrkf4
         b0Jv1uZtPRFy2uiPC5K9e7GiaC1dUkgEAl6mua5vT1TqWXIISPS2/YubG9XA2qLvlqrq
         xnKx9pldvdS3W/iCGxvmldG/u4M0smkP/WJN6Dpv7d9hcJKyyiPw0kcgVeuaYZCE/hv8
         vnW3N0w3EqP+7vWRdw3/IFGhIZ8yLpnmkUmGKEQ28/UkqLb4ZrN9nSlXLydKfVF29PTr
         gVBw==
X-Forwarded-Encrypted: i=1; AL+hErF5ndDtQElFxv4tA864a4/MMBKJ74uSMDdUMhKoi5T1ncAITtnmEevdX0XIXYHVSj7rKMrVXv8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/odwjANq3bApqqrbdrXCzlM3+mhwP7RQImC8dwfTg/Z+Oa+mnx
	Xs57gm1pvfQ3sDqGuaXYHX7QQnDwS55FmTf62OjdOyWDi8vgRffbu4IZKsCQBVbi2qepuy9nm5K
	qT7ED37L34w==
X-Gm-Gg: AYBFou22j3d9xlUEJmknRweSLX7RqmxqQlKCLuQGkW02A/UZhYzy7U8fZiACGaTtXQx
	CIArM7A5iedhRWGGGJeItvsaq9GIuL6m9f//V+AH447r6cHfcBJBGFSbtLVvECGBBmyG8DV84tD
	Fhff3L+p7X3Vzs2dOSMJqwvPFoIJqXT0EnTgHiYgfkxUivAXmpjojohG6eH4LKwHjUgO0j5HLQv
	gv3RnwSQfR37G0L3jrOdktabR9SKhW5P56/1YSMEbVVIckxLW0PmcJck214NhVWA1flSLkMpggq
	5xIFFhtXg98HFbT/Lb9sYUdD281g5lZcpgBAYvN4w41HPlIOwnTtWaS01bdMlHf3rJGrQPvDI5t
	lDobEUiYDYGBk7VRfox3e0YEGx+R2fPSnglMRIeYGz72H0YPypZl+RmyoE6OgF8yUk4RCLPWgnn
	T7JWXDa6IixiTs6dJMCl99nudkhuGYgYPlwHx67XX3VEHrhd/Abelxd31lrqvJr8x940hf4n9dT
	98UxNXFGLw2O+IUGufEntJOyQnCi/jk3CcamoAZrvKyQoe6SMaA4A9Ebv9qe8038zbSNzv1KTDj
	g8ufrgvo2DcdnyjJ79W3+ZzR1azGYfsXfOqLooPImTQM62U=
X-Received: by 2002:a5d:5f03:0:b0:491:e062:383d with SMTP id ffacd0b85a97d-49c7390fb5emr10908010f8f.57.1794663404019;
        Sat, 14 Nov 2026 05:36:44 -0800 (PST)
Received: from lake ([2a02:810d:d09:1b65:1a41:5e41:61a6:f0b6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49d69c21a17sm6657866f8f.50.2026.11.14.05.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 05:36:43 -0800 (PST)
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
Subject: [PATCH net v3 1/3] net: stmmac: honour Rx checksum errors in the AF_XDP zero-copy path
Date: Sat, 14 Nov 2026 14:36:37 +0100
Message-ID: <20261114133640.3285413-2-opensource@grische.xyz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261114133640.3285413-1-opensource@grische.xyz>
References: <20261114133640.3285413-1-opensource@grische.xyz>
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

