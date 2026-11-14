Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794663409;
	b=Sg6NUzMt17SB9ehWg4RTGRsPqzLeT7Ae48a6dp+hnW/LKxWj7PdIsdjKkr8TiKvI8B1m
	 dYXHnZVtSzQTfOEHbajb1JsUyjWoXNB7kvAPfcnSNRchM1xe4kcx5292sRSSldPGj5sWy
	 jlOjlbsYJni7imrmitkUPyM6rKoC5t4eCGQuN4iEAvcl4UnYALK8POcSxkw/T07G1JVmh
	 ebAuMtW0LEiFFriI7SuGIUMdxNgxDtKjbjgDFLNqO0A8E8sTMcNwxk3QEQ/WwPd5cM/DL
	 agevoeKrKjF7QRy8t7HY8H2mM9O+2vZr2L+TNPTPcLQecx0GSFpG7JZQd2vRVKIdWVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794663409;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=EiwQ9+40yAXFn07zwAJTDOokEVNTIlZDDkhdTgBrFpo=;
	b=Jfr/3zplHvoqXnm2pzNgMtfhvme900EKZIXPjD/SA5BAfwybtoU0q0KVxEUcQ8HnBwQG
	 pqJ8bsRYEdXkaGXiQcFouvzf6OUaRIwH8TzcvMi9kOgW7NnCLgsEkq7EjfIf1ZB+0r+dY
	 gC21j9EvDyNKclDVJIAGnOFQH0SQS4v4P4HwpByCBSlziek9LZouGVLnP23ozhsOWNxcB
	 0hMGEiM+mXAKoMO7DyJX9TLdyQqxst+Hh5qnUNC5Gma7u6pGW4nvdwxVV3hd2NTqwTUeQ
	 k8WUOCj/hH5egt0VEkoNoPDM7qo3A7dG1sjxOcl3JZbUUCwbC81QModI34jPObDJADA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=grische.xyz;
	spf=pass smtp.mailfrom=grische.xyz;
	dkim=pass header.d=grische.xyz header.i=@grische.xyz header.a=rsa-sha256 header.s=google header.b=MkOH2p7S;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A47606A8A8
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 13:36:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3A47606A8A8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grische.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grische.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grische.xyz header.i=@grische.xyz header.a=rsa-sha256 header.s=google header.b=MkOH2p7S
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48dee593f18so2348012f8f.3
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 05:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grische.xyz; s=google; t=1794663407; x=1795268207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EiwQ9+40yAXFn07zwAJTDOokEVNTIlZDDkhdTgBrFpo=;
        b=MkOH2p7SuwAXsiBq4F55QCEzAIz0+ZP/EFEvsb8IrMkKeZQzocxAzYRj6AE5tUbRi9
         cPaNBaLSJu49yc6AZ9LQSqsDGCJh2XkmMWBonuz2UcF4sWovTmScDqzMTUz/vcorBCM7
         vTTP6IAybe8Wfp0/upllpHC9ycYA+AeL5bVTfkW+vZw0uYO5Ycvzupt1YyzKmhoULi+L
         Bl0Rjq+xfyD+L7awyp3v1oo+EiRPKgeGbHV1TWE5574ikJnN5t86Ks2wkSnz6J7Reysk
         BQlQmiH60b8nOoyZNpkyS3xSI8yOn3CdWUxGw5y+BJeykHjKLqm7UULdot7aCuuK19JP
         ARNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794663407; x=1795268207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EiwQ9+40yAXFn07zwAJTDOokEVNTIlZDDkhdTgBrFpo=;
        b=Do4VW8U7dv+4KU1R2l2hrsd0vm4XJOjOWL3DqGmV4dBWOybe1DQhuUouEInzlOkqs9
         N98jfmmw6EIJ+7omjAtU4x8UU2OWXuWeAOyQsaif7ylZnDHzRAXVWyaAiZt1xRmPiMik
         7XTyt42It0uJpX7gL6yUNx5BDESy2Rvv+BhxGH+74ANGWBnnz8XoQN2f7r1tdtUYnhIX
         802ph/yi00XFSYpmTO0hIre0gWlCaqoFwsctq4NLJJ7D/PjImKxd/wN4G3cpop7NHd6K
         50WsZeCUBoJvN5+jJm2HC9xtfJWNGvOmXcBgB/KNrtfVp5gUM5n7uYQQnPm+K/vFDKkf
         4HSg==
X-Forwarded-Encrypted: i=1; AL+hErE/fPWoiXn3XaviXaioEhWkYbV48RvkxjjWIj48koK7SH0oJ84PNIYehoDrvCobIoTIZ6HWSbM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8B05ot6rFGe2/Aef9mfBEqw2E6Ps4D8EMIXU50enJW43PAjz4x
	x2q6VZ3WkO5LjwHUjnaPGSvcQxu2G+AGKlze0yrEH6ih6F0eJ23Il6+BS6Iz5DG6cdY=
X-Gm-Gg: AYBFou1NMy3mnVuEabunLWX0r28E3morwRpF3yQdA8eWb1lBA9OIhiCRU6vtUYipuXi
	t1KAdRCRONJTuFDo2IV1fvtBL7dGLeRiZHeomvf7P72k7Sg3JatbdcOoWRBfm/cOtoGluzfFWq0
	g0m8smHbXOEvu5ek9TX8VITWO2niG1sAzaezGuBCpA+TwZW8J+oQj6CJfSjd/uNNUUVvrUJHluK
	xNTzcbi1Fiuh3q4LUo7HRqt6C06fTcrd7DsDUgtiVU3MJcj1KEiWIEGTs3bddsdbGEBFayDrsI0
	rum8oTBZV6c6yAt32oZVeb+uGoxyt5XIfQc4mBdH+ICZPhh88dJjDpZXcwt6G6MstsxHXm4phw9
	V0mSiROK13KpNqFG8hjhQfMth2aMAz8H17yfxyI08cdrc4ZegkqfE7k2+D4FrTZoChGL2JM3vIc
	Gh7iSHgAf9umcbTYaK5y9X1cLDBkYdH7SYODkJCKyJ1PCqRgX1xDLO35lg40B7uVwFbF2iXtBw2
	bv15quP8wRDvrzUnmve6lw0tPSvdSi9jHMTPgEn819wla5/BsJSvOoBD7F5Pyj22nW2axokdhcv
	f1zfxELqoipt/PDRMoMiiMUayhEO3C9bqdXdBSCt3vssCelC
X-Received: by 2002:a05:6000:480e:b0:48d:ff71:dd9d with SMTP id ffacd0b85a97d-49c7044c40dmr10978358f8f.23.1794663407155;
        Sat, 14 Nov 2026 05:36:47 -0800 (PST)
Received: from lake ([2a02:810d:d09:1b65:1a41:5e41:61a6:f0b6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49d69c21a17sm6657866f8f.50.2026.11.14.05.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 05:36:46 -0800 (PST)
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
Subject: [PATCH net v3 3/3] net: stmmac: dwmac1000: stop hardware from dropping checksum-error packets
Date: Sat, 14 Nov 2026 14:36:39 +0100
Message-ID: <20261114133640.3285413-4-opensource@grische.xyz>
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

v3:
- Move code comment of DMA_CONTROL_DT on the line of the define, similar
  to the original version in commit 47dd7a540b8a ("net: add support for
  STMicroelectronics Ethernet controllers.").
v2:
- Set DMA_CONTROL_DT only with enhanced descriptors. The normal
  descriptor parser does not report a checksum-only error, so cores
  with normal descriptors and Type 2 CoE keep the hardware drop.
v1: https://lore.kernel.org/netdev/20261020190319.884375-1-opensource@grische.xyz/
 drivers/net/ethernet/stmicro/stmmac/dwmac1000.h     | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h b/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h
index 1de1f929d61c..55d9c39287f1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h
@@ -162,7 +162,7 @@ enum rx_tx_priority_ratio {
 /* DMA CRS Control and Status Register Mapping */
 
 /* DMA operation mode defines (start/stop tx/rx are placed in common header)*/
-/* Disable Drop TCP/IP csum error */
+#define DMA_CONTROL_DT		0x04000000	/* Disable Drop of TCP/IP csum errors */
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

