Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795428421;
	b=b28qYGLYXaQtzv+PGpoB1otEYuOY4RT97ZGfkozXqDRRsmWaD8DhZBVmN2RXGORavjFv
	 vE98YnjozeWrF8yzS+ks+nGKJb1/Ve1Um5/D5FHu+6n8YKj0x3Zhk83pN7eXsOAlsoNU4
	 htjCvY7gSf9ZsiFcmxbmAB0u4rWijsdPWsGwHj1ihXyqYaQ325zOLBHnZAvJyT5RvvllX
	 WZyPBBmT2nfrMDnxRDn+WTWwPRAFz+u4T/+ilyTEPMVNUE6N+bNMpsugaOOMzanuYHDo1
	 nZgNye7HY7C42PzPcRn5sSMYvUTe2nstXSy2jmsWZrd4pWF/ANO7tiaTHj2jxGqLDPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795428421;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=6dWrzTEqrK6nKc1TJcUidD5GK19M6KlUED1psMXUX8s=;
	b=w7XYKvWE9KY474PjntLdJszjUKauXQ2oD0tQLhO4ehcd4hEU1tUT9Xt1SnZdh2eIwKSK
	 9nnBP+U0UIqU2yvRjGqZiXWaVJDsiyrevWOjrigHvpQHcNaN6thFZQ084wa5gg9vUJ1+H
	 VNoMt0I+RIVoyYe58KNYrwgv1rwZSIyi/Y/7rd97HqLwmtGKiaJnwhSOOBoDNjrbT0VgO
	 Bl8j199BxWif3pMwgy/xnKewTI7dGy3rRuSrmYv16StWk8zj2iKrX523iyHlxvWdS2K1c
	 jXXiwMLBn05UEmEn8hNlE00VG0LoIVYXgexdfH/qQFn1AJsOo4CUpVWc8fjzIpahEHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dsrkcxhg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2048D606A336;
	Mon, 23 Nov 2026 10:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dsrkcxhg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E551F000D8;
	Mon, 23 Nov 2026 10:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795428420;
	bh=6dWrzTEqrK6nKc1TJcUidD5GK19M6KlUED1psMXUX8s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Dsrkcxhg1JctUS6kzFQxFlyk5X67Z+ZI3nDmladFozerpVBrQpgk9Sy12Ec05yQ6Z
	 Nz80e8sE9yrbv0SpzoPuusPH3f0gkuQDAuYYz9gWv8vmMUkdX4Vlcn7kxfVASgeDF+
	 lGFtldgSDVgsGG+ts9EiN0O6EpuT40RHaN4F03ix8sQf8zNWzh76Ndu4s2EBeFnWBn
	 XqHMVsnLzjl50UIrFqDGL5tzwgSfFimzMLZEw7hlTlyKBENHbPkPWaNujOKAB+x/cx
	 zZ7lPl1ffVVWTVMyLuZEhmxPRoVytWlmDpyaGNrUcNVFrJq3qLg9qTzsAeE3zwBB3Q
	 mxYTFXlNGjYKA==
Subject:
 Re: [PATCH net v2 2/2] net: stmmac: dwmac-sun8i: Limit the MTU to 2018
From: netdev-bot+sashiko@kernel.org
To: aiyengar1990@gmail.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, wens@kernel.org,
 jernej.skrabec@gmail.com, samuel@sholland.org, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, clabbe.montjoie@gmail.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 rmk+kernel@armlinux.org.uk, nb@tipi-net.de, stable@vger.kernel.org
Date: Mon, 23 Nov 2026 10:06:59 +0000
Message-ID: <179542841933.3135.13344268634308620175@kernel.org>
In-Reply-To: <20261122-sun8i-emac-mtu-limit-v2-2-c4081e5b83cf@gmail.com>
References: <20261122-sun8i-emac-mtu-limit-v2-2-c4081e5b83cf@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch hard-codes a 2044-byte limit as an MTU cap in one
  glue driver.
- [Low] The commit message and the code do not cover the same hardware.
- [Low] The 2044-byte fill limit was measured on the H616, an arm64 SoC
  where NET_IP_ALIGN is 0 (arch/arm64/include/asm/processor.h:17).

--

net: stmmac: dwmac-sun8i: Limit the MTU to 2018

This commit caps the maximum MTU of the dwmac-sun8i glue driver by setting
plat_dat->maxmtu in sun8i_dwmac_probe(). The cap makes a frame with two
VLAN tags and the FCS fit in 2044 bytes. According to the commit message,
the H616 RX DMA fills only 2044 bytes of a buffer.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> index 2ece7ba9dd73b..ec401cae8187b 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> @@ -1208,6 +1208,7 @@ static int sun8i_dwmac_probe(struct platform_device *pdev)
>  	plat_dat->mac_setup = sun8i_dwmac_setup;
>  	plat_dat->tx_fifo_size = 4096;
>  	plat_dat->rx_fifo_size = 16384;
> +	plat_dat->maxmtu = 2044 - ETH_HLEN - 2 * VLAN_HLEN - ETH_FCS_LEN;

[Severity: Low]
The commit message says:

  The H616 RX DMA fills only 2044 bytes of a buffer, so frames of 2045 to
  2047 bytes, allowed by the previous patch, are dropped.

This assignment in sun8i_dwmac_probe() does not check gmac->variant. So
it applies to every entry in sun8i_dwmac_match[]:

  allwinner,sun8i-h3-emac
  allwinner,sun8i-v3s-emac
  allwinner,sun8i-a83t-emac
  allwinner,sun8i-r40-gmac
  allwinner,sun50i-a64-emac
  allwinner,sun50i-h6-emac
  allwinner,sun50i-h616-emac1

H616 EMAC0 is covered too, through the a64-emac fallback. On all of these
max_mtu drops from 2021 to 2018.

Has the 2044 byte limit been seen on the non-H616 parts as well? If it
belongs to the whole sun8i EMAC IP, could the commit message say so? If
not, should the cap be per variant, for example kept in struct
emac_variant?

The Fixes: tag points to 9f93ac8d4085 ("net-next: stmmac: Add
dwmac-sun8i"). That commit added H3/A83T/A64 support, and H616 was not
supported at the time. Doesn't the tag contradict the H616-only
explanation?

The phrase "allowed by the previous patch" also seems misleading. Before
"net: stmmac: Limit the MTU of normal descriptors to one buffer", max_mtu
for normal descriptors was SKB_MAX_HEAD(), about 3712. So frames of 2045
to 2047 bytes were allowed long before that patch. Once the series is
merged, "the previous patch" will also mean little to stable backporters.

[Severity: Medium]
Is 2044 really a sun8i-specific limit? It could also come from the RX
buffer size that the shared normal descriptor code programs.

drivers/net/ethernet/stmicro/stmmac/common.h states:

/* RX Buffer size must be multiple of 4/8/16 bytes */
#define BUF_SIZE_16KiB 16368
#define BUF_SIZE_8KiB 8188

But ndesc_init_rx_desc() in norm_desc.c still programs 2047:

	bfsize1 = min(bfsize, BUF_SIZE_2KiB - 1);
	p->des1 |= cpu_to_le32(bfsize1 & RDES1_BUFFER1_SIZE_MASK);

2047 is not a multiple of 4, and 2047 & ~3 is exactly 2044.

__stmmac_dvr_probe() also still sets this for every ndesc_ops platform:

	else if (priv->hw->desc == &ndesc_ops)
		ndev->max_mtu = BUF_SIZE_2KiB - 1 - ETH_HLEN - 2 * VLAN_HLEN -
				ETH_FCS_LEN;

Other normal descriptor users, such as older GMAC 3.x and MAC100 cores
without enhanced descriptors, would still advertise an MTU of 2021. The
largest frames at that MTU need the out-of-spec 2047 byte buffer. If that
hardware handles an unaligned RBS1 the way the H616 does, those frames
would span descriptors and be silently discarded. On 64-bit or 128-bit
buses the aligned size would be 2040 or 2032, so the gap would be larger.

Could ndesc_init_rx_desc() program an aligned RBS1 instead, with the
ndesc max_mtu in __stmmac_dvr_probe() derived from it? That would remove
the need for the hard-coded 2044 here.

Neither the code nor the commit message explains where 2044 comes from.

[Severity: Low]
Was 2044 measured only on the arm64 H616? There NET_IP_ALIGN is 0, so
RX buffers start word-aligned at page + NET_SKB_PAD.

On the 32-bit sun8i SoCs (H3/H2+, V3s, A83T, R40), arch/arm does not
override NET_IP_ALIGN, so the default of 2 applies. stmmac_rx_offset()
includes it in the DMA buffer start:

static unsigned int stmmac_rx_offset(struct stmmac_priv *priv)
{
	if (stmmac_xdp_is_enabled(priv))
		return XDP_PACKET_HEADROOM + NET_IP_ALIGN;

	return NET_SKB_PAD + NET_IP_ALIGN;
}

So every RX buffer on those SoCs starts 2 bytes into a 32-bit word.

Suppose the EMAC DMA rounds its fill relative to the start address and
not only the size field. Could the usable fill on the 32-bit variants
then be below 2044? Maximum-size frames at MTU 2018 would span
descriptors and be silently dropped again.

Could the commit message say which SoCs and buffer alignments the 2044
constant was checked on?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261122-sun8i-emac-mtu-limit-v2-0-c4081e5b83cf%40gmail.com
