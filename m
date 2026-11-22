Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795344541;
	b=xSWOdRIpF98yolLBJzAlp9zlyCgQmFjBuPByr71kVuLc16hl7ExosUicWA0G9r+IiWVL
	 yDmfMuRkqT2UkO1Rc8pfIgcJDV5TTyM74lXAqEsy4FSsw5EbNW2FkW2blRVtXg2AzY2vs
	 sS0DgUEYQQ4LAT2/P+pJ24Ggc1CYApSZ3CtNznmq2fmsrZqUJ3mE4/qARxUYCK1hoAx4Q
	 uEFwtff3i32UiMmFmm+YxznhUG3xeTtKouWuacrtJGhJGPqppWHC0hlYz8IfyZnoCRSws
	 6iZe0XQoy8Scz0N6zf5lf6uCBOt/XjCEK1Avahp3E/sG0HzahowJ5JhViOSWHjI93uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795344541;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=82vT/MidDA+8aMYka2WD5yUJcaeeqPoH6Zw6wVte8cw=;
	b=rsU7GPeB9cOplK7P6ERNXvytiXMBWtGDoKTJlqoAUZaMQX2e6CEPZD5RgXUkYGH6804g
	 FmJJalGdP2xnui/DqS5YEuYneYC4xbK7bsI/qxafEa0PVKueVgieL5QCXGeKUalMjO5nz
	 PGfqFVFTSZ/w5Pxloe9jM8vgiXd5GHlbhCC004H2gkoSrnWyOW9NWS+w1q8uXW8phkama
	 SgC+YS2R+jtqXMigJ4DSvVsLnRUBWtw2Wq3gwM9BzWrtrQaQ/09oYAGD1QotuwwH/gwze
	 Dmphx3u/Jjz6QiXanIvUHczESs71aQNkziRfEhczYlAYr8S1VnrSzpaMBOhwUXit5MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q3tRe0tK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2FA606A32C
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 10:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q3tRe0tK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC47A1F000D1
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 10:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795344540;
	bh=82vT/MidDA+8aMYka2WD5yUJcaeeqPoH6Zw6wVte8cw=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
	b=Q3tRe0tKc+da4fHoKNZggf+QYLWK/vw/RT2uLgHl0fU/2aO0OT1jAjK4bf+xeyIbM
	 WL5hrs5EqOPsI9Vd5n5n73nG13jsMd/zZQ26MhWur+5jcjOH/qUU+/c5ND84/GrT06
	 atCOmot23FoQM6oc7n8w4ILuhPkx35rD9bRB54dUrP44iPF16GIc0fJMnFtY6UnvcR
	 cBdftCQ8izLhWvRPd0DkX4YKlQ7fetTicDR1Knq+We68oZSx3vBVpS5PFdBROluTQJ
	 cgcDOCp3iBzj5huZTUfRRDJ+w882AMl5P4dHV9ipwgLRUi3SATQhzFVCVkSwJeoEpg
	 XxAKPk49RUx0g==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3ae81ae52ffso15577581fa.2
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 02:49:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGbhjeP9B4yZMyGJKUTygy9+g7mMQbCMWe93r6sUSjaMhwElNdGedxn/+D0tqpmJVu4nhM0Gtw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+xfIqomIsSolDpPBOGkBiWDCzB+YqKk/o78wDLNcTWfJZdE7e4
	8cc/ZWfgiz8pqovVHreb+oz1yaEeKg0UFqx1yHy7za5BlZdylB4v4VIsCEnflTo1+TzUOdOkyKs
	PPMcdMvHre7JdRgag6QpSooMNVnqw5Ew=
X-Received: by 2002:a05:6512:6811:b0:5bf:a209:f81f with SMTP id
 2adb3069b0e04-5c1bc8227e0mr1708230e87.37.1795344539095; Sun, 22 Nov 2026
 02:48:59 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261122-sun8i-emac-mtu-limit-v2-0-c4081e5b83cf@gmail.com>
In-Reply-To: <20261122-sun8i-emac-mtu-limit-v2-0-c4081e5b83cf@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Sun, 22 Nov 2026 18:48:47 +0800
X-Gmail-Original-Message-ID: <CAGb2v66oxp7G92psuF-pQsha5doh47j2gSMiTY7PAB2dYfozUw@mail.gmail.com>
X-Gm-Features: Aa3M54r7bLOgFVd2AUy7gPHcb4qGTG5JYucqFv0oQ6biMXQehq8fLcl6BjtfAGY
Message-ID: <CAGb2v66oxp7G92psuF-pQsha5doh47j2gSMiTY7PAB2dYfozUw@mail.gmail.com>
Subject: Re: [PATCH net v2 0/2] net: stmmac: Limit the MTU of normal
 descriptors to one buffer
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

On Sun, Nov 22, 2026 at 5:13=E2=80=AFPM Arun Iyengar via B4 Relay
<devnull+aiyengar1990.gmail.com@kernel.org> wrote:
>
> Normal descriptors take frames of at most one 2047-byte buffer, but
> max_mtu allows 3712 on arm64. Patch 1 limits it in the core, patch 2
> limits dwmac-sun8i further to the 2044 bytes its RX DMA fills.

I think you should clearly state that *one normal descriptor* can have
a buffer of up to 2047 bytes. And the driver is currently limited to
using one descriptor per-frame.

The way you write it makes it unclear whether it's a hardware or driver
limitation. I believe it is the latter.

> Tested on an Orange Pi Zero2 (H616) on net/main. Without the patches,
> MTU 2029 to 2100 is accepted and ping gets no reply. With patch 1 the
> maximum is 2021, with both 2018. UDP and ping are lossless up to the
> maximum, and larger MTUs are refused. Ring mode and other cores are
> untested.
>
> Claude (AI) helped write these patches; I reviewed and tested them.
>
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
> ---
> Changes in v2:
> - Limit normal descriptors in the core (patch 1, Andrew Lunn, Maxime
>   Chevallier), keep the lower sun8i limit as patch 2
> - Link to v1: https://patch.msgid.link/20261121-sun8i-emac-mtu-limit-v1-1=
-22492842d318@gmail.com
>
> ---
> Arun Iyengar (2):
>       net: stmmac: Limit the MTU of normal descriptors to one buffer
>       net: stmmac: dwmac-sun8i: Limit the MTU to 2018
>
>  drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 1 +
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 +++
>  2 files changed, 4 insertions(+)
> ---
> base-commit: 890f23ba87a7ca1aba97c8320770a686e3b689fb
> change-id: 20261121-sun8i-emac-mtu-limit-66a936064965
>
> Best regards,
> --
> Arun Iyengar <aiyengar1990@gmail.com>
>
>
