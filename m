Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795332424;
	b=FJjUgV3kcC52CPO6QCzJmq5NKolGBW1wKXYVsRBl8U+bau00Tb4pwfOVYvhG+v+4z9wW
	 4y1s8wt0NZMssey1Rq5h+/ntO2wVZxWA33PXWj83fx51S6TxILBocT2g8XPcZZ3mWhQ3B
	 /v+Qx37SbAJ/v/nSzfx23JQzgVCDinH25iDWK5fAiTEqod1OrV949eooosC7Xp+IQNM+O
	 rTsjWRk5aGt/10Vv72z6RkM2NvFBoAOgFUIxkkULJMGqUhgqzGBSh8he1Y2nfFrvfUQ4r
	 KBm+NXc/KaDCrO7yV5VD/dudf6eyGswdnPjpQxesTS4iCA7nWUKvSKWblBau84A/jYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795332424;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=jRxJug/Y1WR98+oKDtwiqnL5a0+fWq49VTbpoM67nmI=;
	b=GtdSdxgwO7DNjj/zUW+YiSE2IDCdzrWXbzuMzSrwSjN30izUR3NXclQr9N/Z566cuHI5
	 YggQtv2UZNsvtFbp1wIpU2MvTm5Bja+bXlMbUroBDFL9b/agLq6c/spNU2KOk0xGGjEqi
	 yTCg0Tb7L4ZC7yGXkqeLzCNcL/PRDpy86PR/1ffuwt3ifwFs7sqiVTYfGACKRAnILzyot
	 mwiYHqj0DUnIV6R5jViPLVh7L1BD9l5D0uWamP8kZdzeH1UYNlLSag7GL6d0ps0sowLNs
	 s1NwZjQ8s1//HTBnvkBQFkx7j6iregXl4jAxqJ1dl3u2i6DgK3eqG4LoJjTpuiAU9aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S6FbkVu5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFBE606A32A
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 07:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S6FbkVu5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9A7C1F000E6
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 07:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795332423;
	bh=jRxJug/Y1WR98+oKDtwiqnL5a0+fWq49VTbpoM67nmI=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
	b=S6FbkVu5BgQO29DX6U30yzL0DFo/On2Mx4EHxvghcK/CX5rbIRKYkICiatN+NYuKm
	 NZHuONpPqleoDfcTeyUZEu7v3JUQw5fMoUd/1JWG/29OQI33kNPcVAf0ZEuo/3FaWS
	 uLw5/+E7X9IPfvCbRU67QuRrBQYVAebwdQhiTLfHruF15OuwzMkug19e8PEPwLu1b4
	 aQJwaBSHIUxIkZES4bu5qpmPORDOt2nQ1fdzhshXbunBDFvLKvJXdiUZujew5b/86d
	 GqoO5nUYLNgVPqJ0bNEyxAIHtepTBEY7eR+YaaPdPxtIxqjr7LFVl6c9BpQhBs1K41
	 Q1guFWQHz73PA==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3ad0102edd4so20792001fa.1
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 23:27:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFYDNYpJm/wmvB9QWEVHCZj1rtZo51aMH2SVVs7x589emOpGXis8pVkOel7FZRQ1RmcbyR1eAo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9T8z/cTTzsdX4l4z0YnXBX+yyPmz/xlQpst9lINQQnBzUMfNDx
	26eytPC46Z5K0Jsv53B21qZoM9MDH0cnR7W1fbFYop11PR5xmUSz59yt9rjiKMgZf8PAZCPab4R
	CrDjWhOFPzZBD8QKjy5ViEKE1FmgC0kw=
X-Received: by 2002:a2e:a98d:0:b0:3ae:7eee:15d2 with SMTP id
 38308e7fff4ca-3ae7fa63ad1mr24050091fa.18.1795332422005; Sat, 21 Nov 2026
 23:27:02 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261121-sun8i-emac-mtu-limit-v1-1-22492842d318@gmail.com>
In-Reply-To: <20261121-sun8i-emac-mtu-limit-v1-1-22492842d318@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Sun, 22 Nov 2026 15:26:49 +0800
X-Gmail-Original-Message-ID: <CAGb2v65w3cVgxb_G38UgKEa4ErKLN4qiF05N3nmdJbmPeRRNBg@mail.gmail.com>
X-Gm-Features: Aa3M54rfrvVdNKa1udG-e9AkPOB_QrPlPhXGt3xZXT_wwKFSdTyEz2lu2p5fCqA
Message-ID: <CAGb2v65w3cVgxb_G38UgKEa4ErKLN4qiF05N3nmdJbmPeRRNBg@mail.gmail.com>
Subject: Re: [PATCH net] net: stmmac: dwmac-sun8i: Limit the MTU to one
 descriptor buffer
To: aiyengar1990@gmail.com
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	LABBE Corentin <clabbe.montjoie@gmail.com>, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	Russell King <rmk+kernel@armlinux.org.uk>, Nicolai Buchwitz <nb@tipi-net.de>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 21, 2026 at 12:43=E2=80=AFPM Arun Iyengar via B4 Relay
<devnull+aiyengar1990.gmail.com@kernel.org> wrote:
>
> From: Arun Iyengar <aiyengar1990@gmail.com>
>
> Russell King pointed out in [1] that max_mtu ignores the 11-bit buffer
> size of normal descriptors. dwmac-sun8i always uses them in chain mode,
> so a frame must fit one buffer, but max_mtu is SKB_MAX_HEAD() (3712 on
> arm64). Sashiko asked in [2] for this to go in as a fix.
>
> On an H616 the RX DMA fills 2044 bytes of a buffer and
> ndesc_get_rx_status() drops a frame that spans two. On TX the MAC cuts
> a frame after 2048 bytes (TX_FRM_LEN_CTL is clear). At MTU 2033 no UDP
> datagram gets through in either direction.
>
> Limit the MTU so that a frame with two VLAN tags and the FCS fits 2044
> bytes (MTU 2018). MTU 2019-2026, which worked without VLAN tags, is now
> refused.

So what's the overall plan? Limit it first to make things work, get the
fix backported, and then fix jumbo frame (>2K) handling so it works
for any MTU value?

> Link: https://lore.kernel.org/r/E1vLJcL-0000000ExBL-0GFe@rmk-PC.armlinux.=
org.uk [1]
> Link: https://lore.kernel.org/r/20261112-sun8i-emac-jumbo-v2-2-aca0cf23cf=
17@gmail.com [2]
> Fixes: 9f93ac8d4085 ("net-next: stmmac: Add dwmac-sun8i")
> Cc: Russell King <rmk+kernel@armlinux.org.uk>
> Cc: Nicolai Buchwitz <nb@tipi-net.de>
> Cc: stable@vger.kernel.org
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
> ---
> Tested on an Orange Pi Zero2 (H616) on net/main with and without this
> patch (RX fill measured on v7.3.5). Claude (AI) helped write this patch;
> I reviewed and tested it.
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/=
net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> index 2ece7ba9dd73..1f4fa722529f 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> @@ -6,6 +6,7 @@
>   */
>
>  #include <linux/clk.h>
> +#include <linux/if_vlan.h>
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
>  #include <linux/mdio-mux.h>
> @@ -1208,6 +1209,7 @@ static int sun8i_dwmac_probe(struct platform_device=
 *pdev)
>         plat_dat->mac_setup =3D sun8i_dwmac_setup;
>         plat_dat->tx_fifo_size =3D 4096;
>         plat_dat->rx_fifo_size =3D 16384;
> +       plat_dat->maxmtu =3D 2044 - ETH_HLEN - 2 * VLAN_HLEN - ETH_FCS_LE=
N;
>
>         ret =3D sun8i_dwmac_set_syscon(&pdev->dev, plat_dat);
>         if (ret)
>
> ---
> base-commit: d5b89d55a322b632e2b465b392a4c1d9d338db9c
> change-id: 20261121-sun8i-emac-mtu-limit-66a936064965
>
> Best regards,
> --
> Arun Iyengar <aiyengar1990@gmail.com>
>
>
