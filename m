Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795592718;
	b=EjpyGXoqJIAkMgBS0zzws//DwDwPJC+C6h6PNrAHkpCXgsNQNyt0fyNkA6mRAy/B4iUs
	 S9vNdfXpsDQE4Oju8l8wwpnIbevSUHzNmXhGfxYH4ubyk0Zs9xWzx7Vn7fwESXpf+c6Qe
	 nRnNhtlah5suDWOerprLrDgnQmcFZh3rhWkgTwydUKQQtx+njTFmXosbCh/mHLQZ6BC7e
	 SRZoFY87U5vv6nwiRiy9iS3Ke3ZwF1NO8Cn3uiM+rNyG27kCBXo4jNYUPLQhZu6QBH9Tb
	 88UdaDyzENCOv0DgKRwr5fKpubmaDUVyiZcusxvTMmKabHT4m5Rl7TqeS3PebydpGgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795592718;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=dV4BF6J45U2pVPcVBsCXGeaOfYJGsf58GzHV9B+rH6Y=;
	b=ncaZuQml0OYYVCnrhF6pDcf9MbligTvK2zlAY54vkdAg8abOe2l1FhR6gK/TNjtNJQwS
	 qVkQp+OBoG4yv3jRXvFYQDs9C6rQy8U0lYkPIfPCl+m/3txIwiiDFBBtWTjfX+BY9BdAa
	 ejxvN0JeasovqxiqJ6DbuQ48pXsKS2i+9Vh4NYQpLcSkW/lfrFYJC55oDDmHsAtq4rKux
	 OxX0SLw/HhrV22mGShbdu9xPOMMf6Ed0SCA859UsVTtOEEC/xchh6gJT2dMEPW2yoQl2r
	 TXuurBRFxnTfQZFUMcrfbMKrobT0IVy57hbKrt2WDR5DZpa8wedkIgqe7NVEgmhF7Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E+4VXlHP;
	arc=none smtp.remote-ip=209.85.161.46
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FECF606A327
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 07:45:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FECF606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E+4VXlHP
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-716c0217635so6557617eaf.0
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 23:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795592716; x=1796197516; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dV4BF6J45U2pVPcVBsCXGeaOfYJGsf58GzHV9B+rH6Y=;
        b=E+4VXlHPEoaPeHftfHEf7nQze0dpXaqD30slT9nQ3ZTLVlaM/Qs7GOJ7MfD8+BTKRE
         WtTbAgB0o7ZpXmAxA+wOKRYt1+itYBSmhG8LoYGd6z5P8zMYsRkS0qbpdQmYOAo4tqW/
         Gd+4MnKa7cTNBtPJzvFYh6w5R+de36fmUy+ZkArC6Z/tF3mdqNt1bn8WlyNAe3eKvOJp
         D68mhzLB5KaWVoVPdAw0KkuTPsTUT7/CZkvHfMjqDU5Kqnn10K4rNYuWMLpKWnNgzygk
         lT8eG4EtIGWKZ4I9UYp/CXV4s3GqtsqxhRfAs/EFouLiBPje39Jo3hJ+PpfgnDQk576O
         pUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795592716; x=1796197516;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=dV4BF6J45U2pVPcVBsCXGeaOfYJGsf58GzHV9B+rH6Y=;
        b=2IOXFRhc7qI6WmwY56aSkzP8uMXE5LNiYwU1zeP2135F1bPloaSDHVNyN3nENzvwAT
         T65Hw9o7PnD9JcSy9UwuHZr+L+suDoNPBmfvz4LK0C1fx/zmn/NzHiqbEwyGZEyy4fic
         VgBer7RmGFb+3+X5W6+M1RPgBCm3Z4+7nzQtIFir9gYIjVlYZruOCs0Efuc5CQKYedrA
         /igDc/oP3ueNqBatONssmVQxT1VmNdqYAqROfZpmMRop4tAvknWYbl07nuBDxo0/5yJu
         i0ihBLsLmgM2GorTjCBy82mhv4AMyWQbbk4Eqnk1Cl+HxyelzlD97bJqztqx11y73oyL
         4ugQ==
X-Forwarded-Encrypted: i=1; AL+hErFdiVUkgLysSLP5kCDffv2RFFtVmm13uQZtzt0pDEyTfHsLi2GLOSeBMW5OucaFZz1NIj4BsMY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+RWMF+xfCy3gPB0j//0XlAUIYWcCDYWyn23LMhr1o3NVzA2mA4
	1b0CpfWt8GYk1kygp6lOCwCn/hqH8zYLG8mo6q+gx6EFi+M5A+gCbsXz
X-Gm-Gg: AZFdTZcyV6WQkwHI5IAHNXiRDxB/54YnmxZxcXdNKSikc266Oe28MlKrAKopWHp0m+m
	HWS4i+YGEcl6x7FFNG1Peyir+u+Bgf3uGZrrLAdGQlSKv/JyvieFggwkZiAo4PldbF8J3qt1Yo9
	966HaVzMAPC0DBIQY2TInYliUUJESBJ5skL2E8WB8kB9+Khi4rYlKlqjzufwiM0mYPMcykxvaAb
	EDH4xKz4w5gP8zfBxwnRS6/trM8sGLI6bnT6CEd8vyhF2lp9PG7ZlXoiRdgt53lKP+ieM6/mlYv
	G3/Z3Mketb6h2AF+7pCf4FOwdSVcx7jxm3Am5AbEBipcZwCG0XXFp0B6MlicVn0HslpLGsYq+qb
	ub/FcClSXwJ0fNji8CI3iWn5GiNW1iiKgojy2SxH909BKcOzaP0bKGFP9x19e8fjqfPI+dhlf3h
	EUchcdS5gYQ9PerH9/iLxdfaZVTl5zv0X/uzIliOJEeh0ZodJaJ0BsJ4qlUksvaOQTvygYBmDXg
	WfKmRUSusf5axvWseUvLHNjMr/Y8zN+LfdLcC+yVq55IhfSiFMe+zVZGuPiSx7eoiZhfuK6yth4
	5r4i3WjeghzdsUS95SP1l7RdWvKJsvKlyoLyjR+w0F1g/eC3x3B26eBIvi4oXjuo0GS9B33j98S
	a4gkMGjuRqONGe43P7/DM11JWy22dyEfDKZcpDDXk3pO+pBO5PJbRjCWCdofl1+g4lfD2LGdQtB
	pF5vR60+TNDmjZXZ9Vp3HrY3dP5QGmNJPWmbeglhEquQ2SNq/fLKk=
X-Received: by 2002:a4a:ec49:0:b0:703:ad5d:e673 with SMTP id 006d021491bc7-71b326d0891mr12600232eaf.30.1795592716413;
        Tue, 24 Nov 2026 23:45:16 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc5fc97bb2sm15715251fac.9.2026.11.24.23.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 23:45:15 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 25 Nov 2026 00:45:02 -0700
Subject: [PATCH net v3] net: stmmac: dwmac-sun8i: deliver RX checksum
 errors to the stack
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-submit-sun8i-rx-features-v1-v3-1-79273f18a028@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32OwQ6CMAyGX8XsbM1WYA5PvofxMKDTGgGzTYIhv
 LsDL5xMmjR/8+f7OolAnimI024SngYO3HcpZPudqO+2uxFwk7JAiVopVUJ4Vy3HtDrD4EdwZOP
 bU4BBQamORzIZmqI0IhFenhyPK/0iOori+jsmxoPquHCX2p1D7P1n/WFQa/mnQ/lXl0ZCIQvjq
 K6srrLzrbX8PNR9u5oG3LLwPwtBAeYWC507TY3bsuZ5/gI6s22YKQEAAA==
X-Change-ID: 20261119-submit-sun8i-rx-features-v1-9177e8328598
To: netdev@vger.kernel.org, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 LABBE Corentin <clabbe.montjoie@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 stable@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.17-dev

The sun8i MAC drops packets with a bad IP or transport checksum before
packet sockets or the protocol stack can see them, even with RX checksum
offload disabled. This was observed with a bad UDP checksum on an
Allwinner H616 with an AC200 PHY. The same hardware bit controls
forwarding of link-layer errors and checksum failures.

Enable error forwarding and decode the sun8i RX status in software.
Give checksum failures and unchecked packets to the stack with
CHECKSUM_NONE. Continue to discard Ethernet errors, incomplete frames
and lengths that cannot fit in the receive buffer. Address filter and
VLAN indications are not checksum errors.

Have both stmmac_rx() and stmmac_rx_zc() call a per-MAC RX status
decoder. Only sun8i overrides it. For other MACs, install the descriptor
format's existing decoder after hwif_quirks runs: the DWMAC100 and
DWMAC1000 quirks select the normal or enhanced descriptor ops there.

Set EMAC_RX_DO_CRC when enabling the receiver instead of setting it in
the rx_ipc callback. As before, the checker stays on when RXCSUM is
disabled, so turning reporting back on can use the result already
recorded in queued descriptors.

Backports need commit ee0aace5f844 ("net: stmmac: Correctly handle Rx
checksum offload errors") or its equivalent in stmmac_rx(). Trees with
AF_XDP zero-copy RX also need commit fcfc52fcf89a ("net: stmmac: honour
Rx checksum errors in the AF_XDP zero-copy path") or its equivalent for
XDP_PASS. Otherwise a forwarded packet with a bad checksum can be
marked CHECKSUM_UNNECESSARY when RXCSUM is enabled.

Backports also need commit 834ec9530832 ("net: stmmac: drop split frames
on AF_XDP zero-copy RX") or equivalent handling. The sun8i decoder
returns discard_frame | rx_not_ls for a non-last descriptor. Both RX
paths must test the discard bit and drop the remaining descriptors
through the end of the frame.

Fixes: 9f93ac8d4085 ("net-next: stmmac: Add dwmac-sun8i")
Cc: stable@vger.kernel.org # see backport prerequisites above
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v3:
- Explain how both RX paths select their decoder and why the default
  is installed after descriptor selection.
- Clarify that moving the checker enable preserves its behavior.
- Document the checksum-status requirements for stable backports.
- Link to v2: https://patch.msgid.link/20261122-submit-sun8i-rx-features-v1-v2-1-24a2564f6edf@gmail.com

Changes in v2:
- Submit the checksum-delivery fix alone for net, following Maxime's
  review. The RXALL feature will be submitted separately for net-next.
- Link to v1: https://patch.msgid.link/20261120-submit-sun8i-rx-features-v1-v1-0-5058fecba6b3@gmail.com
---
 drivers/net/ethernet/stmicro/stmmac/common.h      |  2 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 98 ++++++++++++++++++++---
 drivers/net/ethernet/stmicro/stmmac/hwif.h        |  2 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  7 +-
 4 files changed, 94 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index a972bee66504..706feb7bcbed 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -615,6 +615,8 @@ struct mii_regs {
 struct mac_device_info {
 	const struct stmmac_ops *mac;
 	const struct stmmac_desc_ops *desc;
+	/* Defaults to the descriptor format's decoder unless the MAC overrides it. */
+	int (*rx_status)(struct stmmac_extra_stats *x, struct dma_desc *p);
 	const struct stmmac_dma_ops *dma;
 	const struct stmmac_mode_ops *mode;
 	const struct stmmac_hwtimestamp *ptp;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 2ece7ba9dd73..0ad2203f76c3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2017 Corentin Labbe <clabbe.montjoie@gmail.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
@@ -197,6 +198,7 @@ static const struct emac_variant emac_variant_h616_emac1 = {
 
 /* Used in RX_CTL1*/
 #define EMAC_RX_MD              BIT(1)
+#define EMAC_RX_ERR_FRM		BIT(3)
 #define EMAC_RX_TH_MASK		GENMASK(5, 4)
 #define EMAC_RX_TH_32		0
 #define EMAC_RX_TH_64		(0x1 << 4)
@@ -644,6 +646,9 @@ static void sun8i_dwmac_core_init(struct mac_device_info *hw,
 
 	v = (8 << EMAC_BURSTLEN_SHIFT); /* burst len */
 	writel(v, ioaddr + EMAC_BASIC_CTL1);
+
+	/* Forward checksum failures to software before starting RX. */
+	writel(EMAC_RX_ERR_FRM, ioaddr + EMAC_RX_CTL1);
 }
 
 static void sun8i_dwmac_set_mac(void __iomem *ioaddr, bool enable)
@@ -654,7 +659,7 @@ static void sun8i_dwmac_set_mac(void __iomem *ioaddr, bool enable)
 	r = readl(ioaddr + EMAC_RX_CTL0);
 	if (enable) {
 		t |= EMAC_TX_TRANSMITTER_EN;
-		r |= EMAC_RX_RECEIVER_EN;
+		r |= EMAC_RX_RECEIVER_EN | EMAC_RX_DO_CRC;
 	} else {
 		t &= ~EMAC_TX_TRANSMITTER_EN;
 		r &= ~EMAC_RX_RECEIVER_EN;
@@ -698,16 +703,9 @@ static void sun8i_dwmac_get_umac_addr(struct mac_device_info *hw,
 			    EMAC_MACADDR_LO(reg_n));
 }
 
-/* caution this function must return non 0 to work */
-static int sun8i_dwmac_rx_ipc_enable(struct mac_device_info *hw)
+static int sun8i_dwmac_rx_ipc(struct mac_device_info *hw)
 {
-	void __iomem *ioaddr = hw->pcsr;
-	u32 v;
-
-	v = readl(ioaddr + EMAC_RX_CTL0);
-	v |= EMAC_RX_DO_CRC;
-	writel(v, ioaddr + EMAC_RX_CTL0);
-
+	/* The receiver always records the checksum result, even with RXCSUM off. */
 	return 1;
 }
 
@@ -1053,7 +1051,7 @@ static const struct stmmac_ops sun8i_dwmac_ops = {
 	.core_init = sun8i_dwmac_core_init,
 	.set_mac = sun8i_dwmac_set_mac,
 	.dump_regs = sun8i_dwmac_dump_mac_regs,
-	.rx_ipc = sun8i_dwmac_rx_ipc_enable,
+	.rx_ipc = sun8i_dwmac_rx_ipc,
 	.set_filter = sun8i_dwmac_set_filter,
 	.flow_ctrl = sun8i_dwmac_flow_ctrl,
 	.set_umac_addr = sun8i_dwmac_set_umac_addr,
@@ -1061,6 +1059,83 @@ static const struct stmmac_ops sun8i_dwmac_ops = {
 	.set_mac_loopback = sun8i_dwmac_set_mac_loopback,
 };
 
+static void sun8i_dwmac_rx_error_stats(struct stmmac_extra_stats *x, u32 status)
+{
+	if (status & RDES0_DESCRIPTOR_ERROR)
+		x->rx_desc++;
+	if (status & RDES0_OVERFLOW_ERROR)
+		x->overflow_error++;
+	if (status & RDES0_RECEIVE_WATCHDOG)
+		x->rx_watchdog++;
+	if (status & RDES0_SA_FILTER_FAIL)
+		x->sa_filter_fail++;
+	if ((status & RDES0_FRAME_TYPE) && (status & RDES0_IPC_CSUM_ERROR))
+		x->ipc_csum_error++;
+	if (status & RDES0_COLLISION)
+		x->rx_collision++;
+	if (status & RDES0_CRC_ERROR)
+		x->rx_crc_errors++;
+	if (status & RDES0_MII_ERROR)
+		x->rx_mii++;
+	if (status & RDES0_LENGTH_ERROR)
+		x->rx_length++;
+}
+
+static int sun8i_dwmac_rx_status(struct stmmac_extra_stats *x, struct dma_desc *p)
+{
+	const u32 csum_mask = RDES0_IPC_CSUM_ERROR | RDES0_PAYLOAD_CSUM_ERR;
+	const u32 dma_errors = RDES0_DESCRIPTOR_ERROR | RDES0_OVERFLOW_ERROR;
+	const u32 wire_errors = RDES0_CRC_ERROR | RDES0_MII_ERROR |
+				RDES0_RECEIVE_WATCHDOG | RDES0_COLLISION |
+				RDES0_LENGTH_ERROR;
+	u32 status = le32_to_cpu(READ_ONCE(p->des0));
+	u32 len = FIELD_GET(RDES0_FRAME_LEN_MASK, status);
+	bool runt = len < ETH_ZLEN + ETH_FCS_LEN;
+
+	if (unlikely(status & RDES0_OWN))
+		return dma_own;
+	if (unlikely(!(status & RDES0_LAST_DESCRIPTOR)))
+		return discard_frame | rx_not_ls;
+	if (unlikely(!(status & RDES0_FIRST_DESCRIPTOR))) {
+		x->rx_length++;
+		return discard_frame;
+	}
+
+#ifdef STMMAC_VLAN_TAG_USED
+	if (status & RDES0_VLAN_TAG)
+		x->vlan_tag++;
+#endif
+	if (unlikely(status & RDES0_DRIBBLING))
+		x->dribbling_bit++;
+	if (unlikely(status & (RDES0_ERROR_SUMMARY | wire_errors | dma_errors))) {
+		sun8i_dwmac_rx_error_stats(x, status);
+		if (status & dma_errors)
+			return discard_frame;
+		/* An unexplained error summary is not a checksum verdict. */
+		if (!(status & wire_errors) &&
+		    (!(status & RDES0_FRAME_TYPE) || !(status & csum_mask)))
+			return discard_frame;
+	}
+
+	/* One buffer per chain descriptor; the reported length includes FCS. */
+	if (unlikely(len < ETH_HLEN + ETH_FCS_LEN ||
+		     len > FIELD_GET(RDES1_BUFFER1_SIZE_MASK, le32_to_cpu(p->des1)))) {
+		x->rx_desc++;
+		return discard_frame;
+	}
+	if (unlikely(runt || (status & wire_errors))) {
+		if (runt && !(status & RDES0_LENGTH_ERROR))
+			x->rx_length++;
+		return discard_frame;
+	}
+
+	/* Only a checked IP frame is eligible for CHECKSUM_UNNECESSARY. */
+	if (!(status & RDES0_FRAME_TYPE) || (status & (csum_mask | RDES0_DRIBBLING)))
+		return csum_none;
+
+	return good_frame;
+}
+
 static int sun8i_dwmac_setup(void *ppriv, struct mac_device_info *mac)
 {
 	struct stmmac_priv *priv = ppriv;
@@ -1068,6 +1143,7 @@ static int sun8i_dwmac_setup(void *ppriv, struct mac_device_info *mac)
 	mac->pcsr = priv->ioaddr;
 	mac->mac = &sun8i_dwmac_ops;
 	mac->dma = &sun8i_dwmac_dma_ops;
+	mac->rx_status = sun8i_dwmac_rx_status;
 
 	priv->dev->priv_flags |= IFF_UNICAST_FLT;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 8ae95e91a36a..047d809b8b88 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -125,8 +125,6 @@ struct stmmac_desc_ops {
 	stmmac_do_void_callback(__priv, desc, set_rx_owner, __args)
 #define stmmac_get_rx_frame_len(__priv, __args...) \
 	stmmac_do_callback(__priv, desc, get_rx_frame_len, __args)
-#define stmmac_rx_status(__priv, __args...) \
-	stmmac_do_callback(__priv, desc, rx_status, __args)
 #define stmmac_rx_extended_status(__priv, __args...) \
 	stmmac_do_callback(__priv, desc, rx_extended_status, __args)
 #define stmmac_enable_tx_timestamp(__priv, __args...) \
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index a685ce4638f6..20e9aa7b14f5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5723,7 +5723,7 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 		p = stmmac_get_rx_desc(priv, rx_q, entry);
 
 		/* read the status of the incoming frame */
-		status = stmmac_rx_status(priv, &priv->xstats, p);
+		status = priv->hw->rx_status(&priv->xstats, p);
 		/* check if managed by the DMA otherwise go ahead */
 		if (unlikely(status & dma_own))
 			break;
@@ -5926,7 +5926,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		p = stmmac_get_rx_desc(priv, rx_q, entry);
 
 		/* read the status of the incoming frame */
-		status = stmmac_rx_status(priv, &priv->xstats, p);
+		status = priv->hw->rx_status(&priv->xstats, p);
 		/* check if managed by the DMA otherwise go ahead */
 		if (unlikely(status & dma_own))
 			break;
@@ -7732,6 +7732,9 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
 			return ret;
 	}
 
+	if (!priv->hw->rx_status)
+		priv->hw->rx_status = priv->hw->desc->rx_status;
+
 	/* Set alternate descriptor size (which tells the hardware that
 	 * descriptors are 8 32-bit words) when using extended descriptors
 	 * with ring mode. Only applicable for pre-v4.0 cores. Platform glue

---
base-commit: cc7fe6e741730fef549e484379281736d32746f0
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git main
change-id: 20261119-submit-sun8i-rx-features-v1-9177e8328598

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

