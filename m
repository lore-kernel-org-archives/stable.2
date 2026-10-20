Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792523010;
	b=A4vTyx/Z9u+Yo783JgRVJJvsQEX1W3qzfTKirHRYORfx5s7UGilvq+8X19auSuMgJoH5
	 ic/EpvKnzzYtovfD5RHU6FnBMNQf+ZLBNH0N/Pi25v0aITmbs7y3JEx94dJFiIZNVOyM3
	 nJ+gylJLhEvddASo+AT74IdxKrw+JUUkB6xo3I0RlHRClkk6pa7c1PRrxgpzodkXb0Vue
	 h1vXoD3FHxoD9UqEfCpnUzlyrNZagmke9NI1xswSOaSljaGt7dKAXq6LrRhSrN7B9gQlS
	 EMap3ZPYo5KtS53oGdzHhm+0muB/4cVXtbJIbvVYbiXwa0QTUcstyWL2k3ca7p0ndkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792523010;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uC5zYyNDKu5QdLJSVPD/ZbHeH86phuOD6U9spopPKrw=;
	b=Mrsr1EuO75a/T+A5jzsb7l1OPFUFw5zCjwGTa/4Xv1Ekr6itVWuT6FYfdP5oMKOWD2ED
	 SSF4LgrP/AcmXLjCAZ03pfx51ytRY8vL+DfrJUb45E3xe2djRffNEclkEFFIr41YnocP2
	 SvOV4s+kdXa/CP+CY5sKn96a3xi+Q5Rdgl/cnHwGa24dioHS2GjZTXq5fW0T4uu+DqgmH
	 F2oaQZnhfnudcgG5bTxlgWAzUqYDePO/8Pv0cYYdmGFEbdwlipIj9lguZfCDGvM0U5jW7
	 pJyFFQ0cWVVqRMuBHwsMTyaGMbJD9YMFo+Y1ej9KnHY32c+lrv/qBUHChOh9OBe20OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=grische.xyz;
	spf=pass smtp.mailfrom=grische.xyz;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1173606A335
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 19:03:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1173606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grische.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grische.xyz
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a180fbeef5so27273595e9.1
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 12:03:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792523008; x=1793127808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uC5zYyNDKu5QdLJSVPD/ZbHeH86phuOD6U9spopPKrw=;
        b=Fp1+pHaos/gh+3WRwe909TMMpnjf+3985gsfs7Ufff5zYz5p/WHqOkDmO+RhwlI+rE
         7R3lbu9cM26pMr2p6/zp/dDbab7RJT5z/PuVSJUgHUXGCwe/ekDT2Cd5JnjF1FYxUH4g
         11ktnZPmdED1U8ObcVA9PMdcWe4klAd9fSc0S3t5x+ANc3ZxQf6Tzd0gE2JqTWCLRcv0
         6pYUKswim1gGbkn5PIj1Hem4UsanmdWBl8JxWdYMYQscvGlFkINr8XWRQ0Sq6wkCKdxp
         jviUbihyrZXpddzVFfqMjvEJoBSL9lvtx8aIM8fhO4Af6GBKWS3fg2crEQtRQ5/R35iE
         SvgA==
X-Forwarded-Encrypted: i=1; AKwUvBwxZS3PIPatXTQHdt2jJmP4KMJQh1xeCIwSLJO6V0NEeNDC03sZ2jfaHALyPnRNqwuqXn/RPKQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKryngaEppBVYoTaH5RNfxm6bEHl3JlvdTHYkeqrnlf04R8H0bz
	r6iR293nGAyjcYMjIeQzMsT13cKUx3FDt6kQrhUq92o5Nsnl2sbUtefqflYikob2Yrw=
X-Gm-Gg: AYBFou29OUKj2dbq+gAMOwx6gE3IdBy6YMmJTux2ZRraOu3jY1x09UM6ojSf2LDPTiJ
	YR+7sE8N/MzAIWjN7+KasLjvjaYXZZ/EOPs79xmpLaSpx547HjQ8fmKtD9PZLYemXo3WVUrXIGy
	ZC0p7KKJNEvhoYwhYy8qhUMMifedjCFgURkc0hb80F6uLGv4sJKBDCo0w/w3qlm6JlNhAtH9o86
	FlMFyUkxS+Deea25snimhkbRG6+CbGAt7SQDyJlFqjUbvZgWfhPFU4z7xLqs441Dpc/vp5mdKEz
	+0g+gdoPEXIi4y0iDWUPwA024W+Uo4RQpCwepUsiNbOTANA41y+IZnVhqwUCwxQDg+ss2qGsdaY
	telWw9kE1DlAglhRLk1Uzj7fauB/jQ5hALT15IYSRjmle02pKTfwdL5yyPI/08pODQZQn74q1Br
	mJtpt5lSRbRToor4UkTRR9wTydzsQo2BCjR54UhG/iBmGtE8ZFx40P2DoeMcF3qpiKhP8=
X-Received: by 2002:a05:600c:8709:b0:4a1:813f:2a60 with SMTP id 5b1f17b1804b1-4a1d75e3eb5mr232302695e9.11.1792523008071;
        Tue, 20 Oct 2026 12:03:28 -0700 (PDT)
Received: from lake ([2a02:810d:d09:1b65:a3ee:29e0:454d:c31e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25828cbfsm279157f8f.23.2026.10.20.12.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 12:03:27 -0700 (PDT)
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
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 3/3] net: stmmac: dwmac1000: stop hardware from dropping checksum-error packets
Date: Tue, 20 Oct 2026 21:03:18 +0200
Message-ID: <20261020190319.884375-4-opensource@grische.xyz>
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

When the checksum offload engine (CoE) is enabled, the dwmac1000 MAC
silently drops any frame for which the engine detects a checksum error,
before the driver sees it.

This breaks VXLAN over IPv6 with zero UDP checksums, which RFC 6935 and
RFC 6936 allow for tunnels.

Set DMA_CONTROL_DT so that such frames are delivered instead of dropped,
as commit fe4042797651 ("net: stmmac: dwmac4: stop hardware from
dropping checksum-error packets") did for dwmac4. CoE remains enabled,
so the driver still sees the error status and marks the skb
CHECKSUM_NONE for the stack to verify.

Tested on an Aruba AP-325 (ipq806x-gmac-dwmac) with Rx checksum offload
on.

Link: https://lore.kernel.org/all/20250625132117.1b3264e8@kernel.org/
Link: https://github.com/freifunk-gluon/gluon/issues/3783
Fixes: 47dd7a540b8a ("net: add support for STMicroelectronics Ethernet controllers.")
Cc: <stable@vger.kernel.org> # 6.6.x: ee0aace5f844: net: stmmac: Correctly handle Rx checksum offload errors
Cc: <stable@vger.kernel.org> # 6.6.x
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Grische <opensource@grische.xyz>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac1000.h     | 1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h b/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h
index 1de1f929d61c..004e6e30a68b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h
@@ -163,6 +163,7 @@ enum rx_tx_priority_ratio {
 
 /* DMA operation mode defines (start/stop tx/rx are placed in common header)*/
 /* Disable Drop TCP/IP csum error */
+#define DMA_CONTROL_DT		0x04000000
 #define DMA_CONTROL_RSF		0x02000000	/* Receive Store and Forward */
 #define DMA_CONTROL_DFF		0x01000000	/* Disaable flushing */
 /* Threshold for Activating the FC */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
index 3ac7a7949529..00c8d4dfb553 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
@@ -129,6 +129,8 @@ static void dwmac1000_dma_operation_mode_rx(struct stmmac_priv *priv,
 {
 	u32 csr6 = readl(ioaddr + DMA_CHAN_CONTROL(channel));
 
+	csr6 |= DMA_CONTROL_DT;
+
 	if (mode == SF_DMA_MODE) {
 		pr_debug("GMAC: enable RX store and forward mode\n");
 		csr6 |= DMA_CONTROL_RSF | DMA_CONTROL_DFF;
-- 
2.54.0

