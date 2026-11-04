Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793805575;
	b=uP5++hZpYlN8UOBH1v9EPyj8jrmyXGT/5c65JW6c4LQH8HV+ACnN2f9YtFFvr/LLW0Q/
	 l6g3CqU9ihIg05/LSFltwrH2EuOWOAwypgTVRQmyq+vDfsvE4r1AgTHx4FnrCed5YrEdX
	 GIpKZ4/23NAdrPOrobVhSm5DCpr9w+XAha0bT4X83gB67CgFQ0BH5+dKemNCUrnjgtsLZ
	 gtFSLBs2u2RZ+sd11WyaMWV0zZOtgGbcm8vfS+JBsSiD8T3JpDKQAXHwFsJveDWEJxfOD
	 taocsBoHpIjCspPOvQk7zUguRAwCyEl97HtYSpwq4AVHTP8NEl2t3t/1kRwZtt9Jblg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805575;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bLOJZaXgrljjby6d2ZZG7h7GGo4k7OpcvIB3L0adEqA=;
	b=JGK/xdnmnJbqaA16v+C0mHtBosKqjMkFrcIDzSom2MPbcXsFyt6B/Sp/YaMb8SxprXsT
	 QxxXll/+LalNz56vSASSfmx0b2hprcr1dz1AKjvnRnk5lbXIxozd6K3Qgp6SndkTI7vPV
	 CqQKjFSq4hTrkp3352j/Xv8JR98sDmPCkbcgTA3S5L2fE/C4CSXOa3E04n/uHQyuEsEv8
	 XYIH/2uWRADIy7W9ZQ6wMkS6tYAga5t+Nc3WNxhsAJ6GkBRNLA9UZiRzUYuakhBXpbe/i
	 hhl8Gey/OZXr4cE1V5uKsodvmw9ICgx0Ci6maAW3t3NM2KqY2VVyE7yvS6KatlWU+GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=grische.xyz;
	spf=pass smtp.mailfrom=grische.xyz;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AC2607475B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 15:19:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9AC2607475B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grische.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grische.xyz
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48c5358fc28so752704f8f.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 07:19:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793805573; x=1794410373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bLOJZaXgrljjby6d2ZZG7h7GGo4k7OpcvIB3L0adEqA=;
        b=tp5cwFdWD3LhsJmpCYFvyDZvXrcDhGcj6v8YKzBD2FIuiF/KcFSMdMgxz60BeZFEzh
         y8i2BzrBjFMGLKthCf2HXtC4Rh5Onmf+npX1w4XDOzxZUAExSyHB6PCiYzHzIoSCCceh
         21ps7baqSr8Z4vF7WU3VjIjyOAJT0DFcS8slHbtdZJttyyLoEEu/zfYdQi0Cc1s38lwJ
         dXZaCghyKt/PwF1Z7nzjNPfaqtsc4De0bqwWRTOR+L2pSMqGVwDv1GIdI73rBXlJOEzf
         i90+phmABOKldt23V77t/uZCUbIb4G+qeDp/zHLtDPa0vWrLJSZkmhLiU56Cw9nqzgoi
         2HIw==
X-Forwarded-Encrypted: i=1; AKwUvByP2/bVuToTcN4eeVPOEzaIvnJwmiyzHiQ50JTHRdtalwkHwfrF5Sold76mEjhHP/M3//5W0vk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8NFBwL5EF483l/ByIBFyGpiJXWACfx6/fG6gY6o4aqOhZuCgMl
	kUV0J8RjhENC8uE16MhtUTVTeowjWaY5WKp4e961pUclafgvHAQAuCbGKMR8dxSgtig=
X-Gm-Gg: AYBFou3rqPw96QnvPy3toFSRnWn+qzUfMJ+dqaYliushOzdMln8uMZWGB/ry/4YHUM5
	5jOGrza/jLBPHAS/Xd0na98ox5I01bbZ9FOf0yeLSLy5Ep+ge0IiqkwbW2JHOUrt7BOm+CWJixV
	rveWNPQz91tr4WPWXy3aPfBf+nQvqKnd06CA3lTw0LKQYr7Po1IwOoOKHZxJLlBRNoshvnWP2uC
	8HKQG5oaKwyb3vQsyD6CsoCmBBw67W0pn+0l3cr9K4YCXRykrYn3vL4LLWp78XRZhm4X/1fC0RO
	YlvOyFxfbwBNC+jWa5go5kZYckIhcEndBcV+U9MHfQEZXC62diKjepLUv2EAqeYga2zhCyquMym
	YW9cuysDQe3K7TuLuf5Vy3Y3nBgykNFJGtIxscvJSk9QU4NMjkaaY0bxrp7QcGYXi1Rcb06b85U
	Zefhzg3tkuFbERPQLIfkeZqr12KaXfTLwe30u3tVA8kgCiwIp2hOkwwUaysUW9smybJppaf0f3Q
	R02nntv6zOc2FEkyigX3Mb9l0kUJPgVP2/Vw0G8+I2KJhgdJlsP8laBngvnJ35kEFIB6BF1bnsw
	2ct/EOYs8Y1DUkNMHeWNLk4bDnTndemCKaJgSkWlsKnOo3U=
X-Received: by 2002:a5d:6950:0:b0:48e:3bc4:a367 with SMTP id ffacd0b85a97d-48e6e2fab84mr28602707f8f.33.1793805573103;
        Wed, 04 Nov 2026 07:19:33 -0800 (PST)
Received: from lake ([2a02:810d:d09:1b65:4366:70cb:bf82:f8ac])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fec8d8e29sm4639812f8f.19.2026.11.04.07.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 07:19:31 -0800 (PST)
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
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 3/3] net: stmmac: dwmac1000: stop hardware from dropping checksum-error packets
Date: Wed,  4 Nov 2026 16:19:13 +0100
Message-ID: <20261104151914.2651241-4-opensource@grische.xyz>
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

Set the bit only with enhanced descriptors. The normal descriptor parser
does not report a checksum-only error to the stack, so cores that use
it keep dropping such frames in hardware anyway.

Tested on an Aruba AP-325 (ipq806x-gmac-dwmac) with Rx checksum offload
on.

Link: https://lore.kernel.org/all/20250625132117.1b3264e8@kernel.org/
Link: https://github.com/freifunk-gluon/gluon/issues/3783
Fixes: 47dd7a540b8a ("net: add support for STMicroelectronics Ethernet controllers.")
Cc: <stable@vger.kernel.org> # 6.6.x: ee0aace5f844: net: stmmac: Correctly handle Rx checksum offload errors
Cc: <stable@vger.kernel.org> # 6.6.x
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Christian Schmidbauer <opensource@grische.xyz>
---
Depends on patches 1 and 2 of this series.

v2:
- Set DMA_CONTROL_DT only with enhanced descriptors. The normal
  descriptor parser does not report a checksum-only error, so cores
  with normal descriptors and Type 2 CoE keep the hardware drop.
v1: https://lore.kernel.org/netdev/20261020190319.884375-1-opensource@grische.xyz/
 drivers/net/ethernet/stmicro/stmmac/dwmac1000.h     | 1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c | 8 ++++++++
 2 files changed, 9 insertions(+)

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
index 3ac7a7949529..31d5f79ef560 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
@@ -15,6 +15,7 @@
 #include <linux/io.h>
 #include "dwmac1000.h"
 #include "dwmac_dma.h"
+#include "stmmac.h"
 
 static void dwmac1000_dma_axi(void __iomem *ioaddr, struct stmmac_axi *axi)
 {
@@ -129,6 +130,13 @@ static void dwmac1000_dma_operation_mode_rx(struct stmmac_priv *priv,
 {
 	u32 csr6 = readl(ioaddr + DMA_CHAN_CONTROL(channel));
 
+	/* Deliver checksum-error frames only with enhanced
+	 * descriptors, because the normal descriptor parser does not
+	 * report a checksum-only error.
+	 */
+	if (priv->plat->enh_desc)
+		csr6 |= DMA_CONTROL_DT;
+
 	if (mode == SF_DMA_MODE) {
 		pr_debug("GMAC: enable RX store and forward mode\n");
 		csr6 |= DMA_CONTROL_RSF | DMA_CONTROL_DFF;
-- 
2.54.0

