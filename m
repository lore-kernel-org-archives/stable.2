Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795347559;
	b=Nkr8SpTc4lOQt71JHtRh5ximg4D8rplbkKKgcJnx+ji2v422q8y0If8sJRdr075oFOCG
	 TwwQ9Ix3kN+ADhKZLi6NaONYOoz/Sfdjy9msMS06diW4cuIh8VJjL5RTm/l4F9pw7G/l6
	 NHQdOWnWiiItVCzKBNuyvcf/78xe0p20NDRscsX/HUpT3Q7WbWYd1/SaAWzP2b/rYv7xS
	 Nj1nUPOMbZPB2SRt/SGSHyRPXbw82iVAyjpDYxZlzzaYer9TGtYmeu5c3cGprEPOTFUrC
	 L54yA6SwQzrRrCknULMd7pteFNNUKGjG6fVcNBGO31lrml+lXsxG1ZMWY3vr4OPe9Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795347559;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=OfjJ0WvNmPf3yRVeCkab8QDdbLg01cA0144pAfNS/ko=;
	b=Gv+0xmyIlMvPKGe/9iQwiNk+0A+aZF48dYSg9TqZZoVkkklR1IQJxO7I5BV3jfo9J3w4
	 RpxkG0Nu8rvDyupcjZYWWHy0Faze3jhicPNApHFgCDFBzN/cL8SmgvVjjiltB7NyB3bSQ
	 ZYrpHnYZu4F/tj/9sqgMCfocch8RqnNkJ/58QSUo90BtKBTjMyJ9Ct6FhJ0ZC+ZlETw80
	 3vcltk9FDaBz/yLc+7OhmGoEMpq4d6Bg1W2P1ziA9O2AUDaFozQ3TrxCSJx0KTDLoPguH
	 /R56DXN1D3KJmNyXT9tNhnzVucF142vNQOk3C7a32UXeFFnPivOpvzrU39D0pmhFeng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kOpbrZVn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1950606A320
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 11:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kOpbrZVn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3AF91F000C0
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 11:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795347558;
	bh=OfjJ0WvNmPf3yRVeCkab8QDdbLg01cA0144pAfNS/ko=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
	b=kOpbrZVnERYgmaaHoZkURlOzHTL+LmFRPMuRjwwd8z7TPSCj6Lk3JAEbho+16Z0/R
	 apEgAP3EnQ5uxlyI7qAJyaD7CI5muLzZaudrhoiYnUwWOd+c+4H54zZ1ocD0jUedQg
	 jBZ0cStZBZ/mLGr0V8v+gpT9duqIkGufxmUhwvviey5PImNCxB1AE8HsqfVmWAPUFr
	 hrf3oI4Go6+NmSFQkOStXZXLHtl7rdCEDoxstXxHP5PXodvvdaQiSQGK7VlC2eTwvN
	 WTN4tMGmaYk6ghQmHlRPX0UP+KHi8Hj4eJswJez/PSW+9LAMKQUSCUqB5JBW1Q47el
	 lDsbMfWHFEvjA==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3ae85add4ceso14738741fa.0
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 03:39:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErE6evD5ZkdcPL7Gx83QV/m2GUCcbC6o/qdSiVyFXqW+NjltVZ88EON0U/AKV26o4CJosH1Ci80=@vger.kernel.org
X-Gm-Message-State: APuU4Z9qaeN6c/L/2wgIZLYrrzbV4CGqB69sGWHfHg+Jl6864Kk97kBU
	b3ZGWflBqfszJO8mA1T0gMxSPqmtOTksTEQCOzOhePBgTkCoyWc9/o+IkCDfrVsYjtHYFavDRyu
	C2Lkx3cH0fHaNMW3tZXjbrmUnE5Vvty4=
X-Received: by 2002:a05:6512:61aa:b0:5c1:57cd:5c3d with SMTP id
 2adb3069b0e04-5c1bc806a59mr2586829e87.23.1795347557053; Sun, 22 Nov 2026
 03:39:17 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261122-sun8i-emac-mtu-limit-v2-0-c4081e5b83cf@gmail.com> <20261122-sun8i-emac-mtu-limit-v2-2-c4081e5b83cf@gmail.com>
In-Reply-To: <20261122-sun8i-emac-mtu-limit-v2-2-c4081e5b83cf@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Sun, 22 Nov 2026 19:39:05 +0800
X-Gmail-Original-Message-ID: <CAGb2v65_vY86WqvKr1m=g0N1Qr2UhLC1v3OHKPG3x+oURUKp7Q@mail.gmail.com>
X-Gm-Features: Aa3M54rz_NQ7yOvBXle79aW57ZyemtshMgGI-7Gz1C236a3c9B6hMMfTmke5swY
Message-ID: <CAGb2v65_vY86WqvKr1m=g0N1Qr2UhLC1v3OHKPG3x+oURUKp7Q@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] net: stmmac: dwmac-sun8i: Limit the MTU to 2018
To: aiyengar1990@gmail.com, Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	LABBE Corentin <clabbe.montjoie@gmail.com>, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	Russell King <rmk+kernel@armlinux.org.uk>, Nicolai Buchwitz <nb@tipi-net.de>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 22, 2026 at 5:13=E2=80=AFPM Arun Iyengar via B4 Relay
<devnull+aiyengar1990.gmail.com@kernel.org> wrote:
>
> From: Arun Iyengar <aiyengar1990@gmail.com>
>
> The H616 RX DMA fills only 2044 bytes of a buffer, so frames of 2045 to
> 2047 bytes, allowed by the previous patch, are dropped. Limit the MTU
> so that a frame with two VLAN tags and the FCS fits 2044 bytes.

FWIW I think this applies to all DWMAC cores.

So I tried to do some research of my own. Google AI search pointed me to
STM32F4 or STM32F7, and some Altera FPGAs (I used the Intel=C2=AE Arria=C2=
=AE 10 Hard
Processor System Technical Reference Manual"), that had some variant or
version of the DWMAC core, and had proper programming guides.

The STM32F4 reference manuals has this note:

Even when the start address of a receive buffer is not aligned to the
system databus width
the system should allocate a receive buffer of a size aligned to the
system bus width. For
example, if the system allocates a 1024 byte (1 KB) receive buffer
starting from address
0x1000, the software can program the buffer start address in the
receive descriptor to have
a 0x1002 offset. The receive DMA writes the frame to this buffer with
dummy data in the first
two locations (0x1000 and 0x1001). The actual frame is written from
location 0x1002. Thus,
the actual useful space in this buffer is 1022 bytes, even though the
buffer size is
programmed as 1024 bytes, due to the start address offset.

The Intel one had the same note. It looks pretty much the same, but I didn'=
t
compare it word-for-word.

So for normal descriptors the buffer size is bound to (2KB - bus width).
Not tested, but I think there is more evidence supporting a cross-platform
limit.


ChenYu

> Fixes: 9f93ac8d4085 ("net-next: stmmac: Add dwmac-sun8i")
> Cc: stable@vger.kernel.org
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/=
net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> index 2ece7ba9dd73..ec401cae8187 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> @@ -1208,6 +1208,7 @@ static int sun8i_dwmac_probe(struct platform_device=
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
> --
> 2.55.0
>
>
