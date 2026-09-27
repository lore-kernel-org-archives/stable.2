Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C051397E85
	for <stable@vger.kernel.org>; Sun, 27 Sep 2026 23:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790552157; cv=none; b=cw6kcnisCVuppEJdrSYJGWw2pDQ+nBZJXIEvHws/UBDE/LNYUYBinkGreqln+3QkZ8ToY/TOaV3RjKhkjlwdVWHPgIzb23+1F3vgzDA+coxMVMe+pnDWdEuRLw6oss0+Rxo0uTjXUYjpEOEYnC17OZOREEyHboqDbb2QobEmd2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790552157; c=relaxed/simple;
	bh=zUczv42xnBRKDUlSGntImfEdrqpq77GiCQwYtmt81sM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZlDF+8fMYxCtwC3O0xk830NirEIOx0wBwp1gvXOwOK8ncCcHAJzkummuALAxS3s/1H0DZoUGf2a2IVL6oMFrHbOQA2qNM/5LUB/aYwYh5DCHI5hZf9fh/3ZiKR63Bjbz+f2ZzEOItlTsxleCLTUDqABB7ORnydvucsHsXix/+a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fij3G/n8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fij3G/n8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B8591F00893
	for <stable@vger.kernel.org>; Sun, 27 Sep 2026 23:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790552156;
	bh=zUczv42xnBRKDUlSGntImfEdrqpq77GiCQwYtmt81sM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fij3G/n8kwYuF2eBJMCfHWg+vdXGfdnkHxCkLhlUAGNkSI4ivHuJu8okW5pTnQZR8
	 vQudTBXi7ORXxpRTO1DweAZu4N0VWmmXw+iNpjubsy1cnfjMAIccdVT8JxQk+QBNpD
	 Y8okmP15TENXP673WqKdN5N7xCEA6N238feY5605ZP/62xI1wQ67Rvuo4ioq7XN4in
	 MpUQ5aUmTDKtkg4BP55qDvOzSkfdB48erJn/ZGSgIvaX6aLiCxf/2nCSgDogJqOxAF
	 DzDfNIOGjmEPOZyHBBm13VtAD0NS/OODV3l8H3gZHGUW7QWWKUmveHVNdlQAg+SwKT
	 3ZVdk2cQ4b64A==
Received: by mail-lr2-f34.google.com with SMTP id 38308e7fff4ca-3a6595b02ebso13286721fa.0
        for <stable@vger.kernel.org>; Sun, 27 Sep 2026 16:35:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByQMDj9kz0Jg7fXNvCTVTpxTgCxu0NIpZHdT9bdAXloXwA+gK83J5HGR3MtOy2wpNKPDcu509M=@vger.kernel.org
X-Gm-Message-State: AFq9FYITlJmCYYGHf4aBe2O7x7ELgzCO+Kpsh2nBK1aPnpAfCpIMqOBm
	zf5sdRrMqJI73FCbafeui8Vo+tbbO4hUnUXOn4es+7LlruVRB7UPW0D9jNOZrmWFDQED3dVD6wr
	HNITfhXIG+GdB2ORRolMsyHH9p5lyjOE=
X-Received: by 2002:a05:6512:b92:b0:5b8:f562:d232 with SMTP id
 2adb3069b0e04-5b8f562d300mr836313e87.53.1790552153978; Sun, 27 Sep 2026
 16:35:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927-submit-stmmac-reset-fixes-v1-v5-0-feec6c14dd06@gmail.com>
 <20260927-submit-stmmac-reset-fixes-v1-v5-2-feec6c14dd06@gmail.com>
In-Reply-To: <20260927-submit-stmmac-reset-fixes-v1-v5-2-feec6c14dd06@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 28 Sep 2026 01:35:42 +0200
X-Gmail-Original-Message-ID: <CAD++jL=6Ov5BPK1naX6orzMsrJPm_g6SkdRaU6Ji+okXMFaZdQ@mail.gmail.com>
X-Gm-Features: AclHuK8bRJUtWoB2-ejh2LEjrHa5vNcye2LD6vhX4uf9CtkXYnbSEGRsJ5xc6Kc
Message-ID: <CAD++jL=6Ov5BPK1naX6orzMsrJPm_g6SkdRaU6Ji+okXMFaZdQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 02/19] net: stmmac: request the MDIO reset
 GPIO only once
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Christian Marangi <ansuelsmth@gmail.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Serge Semin <fancer.lancer@gmail.com>, Suraj Jaiswal <quic_jsuraj@quicinc.com>, 
	Richard Cochran <richardcochran@gmail.com>, Joao Pinto <Joao.Pinto@synopsys.com>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, Ong Boon Leong <boon.leong.ong@intel.com>, 
	Voon Weifeng <weifeng.voon@intel.com>, "Song, Yoong Siang" <yoong.siang.song@intel.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Jose Abreu <Jose.Abreu@synopsys.com>, Yao Zi <me@ziyao.cc>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Richard Genoud <richard.genoud@bootlin.com>, 
	"Alastair D'Silva" <alastair@d-silva.org>, Maxime Ripard <mripard@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
	ZhaoJinming <zhaojinming@uniontech.com>, 
	Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, Ding Hui <dinghui1111@163.com>, 
	Linkui Xiao <xiaolinkui@kylinos.cn>, Linkui Xiao <xiaolinkui@126.com>, linux-tegra@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi James,

On Sun, Sep 27, 2026 at 11:59=E2=80=AFPM James Hilliard
<james.hilliard1@gmail.com> wrote:

> From: Linkui Xiao <xiaolinkui@kylinos.cn>
>
> stmmac_mdio_reset() calls devm_gpiod_get_optional() every time it runs.
> A GPIO line can only be requested once, so from the second call on
> gpiod_request_commit() returns -EBUSY. devm_gpiod_get_optional() only
> turns -ENOENT into NULL, hence the error is passed straight back and
> stmmac_mdio_reset() bails out before pulsing "snps,reset" and before
> running the STE101P MDC workaround.
>
> The first call, made by of_mdiobus_register(), succeeds, so the failure
> is only visible later on: every resume that does not use WoL goes
> through stmmac_resume() -> stmmac_mdio_reset(), and that caller ignores
> the return value, so the PHY silently stays un-reset.
>
> The descriptor used to be requested exactly once: stmmac_mdio_reset()
> resolved "snps,reset-gpio" itself and cached the GPIO number in
> stmmac_mdio_bus_data::reset_gpio, and commit ae26c1c6cb9b ("stmmac: fix
> PHY reset during resume") relies on that cache to reuse the line on
> every call. commit 7c86f20d15b7 ("net: stmmac: use GPIO descriptors in
> stmmac_mdio_reset") replaced it with a devm_gpiod_get_optional() that
> caches nothing, so the request is repeated on every call and fails from
> the second one on.
>
> Parse the whole reset description, the GPIO and "snps,reset-delays-us",
> in stmmac_mdio_register() at probe time, and keep it in struct
> stmmac_priv. This is where devm-gpiod is meant to be used: the line is
> acquired with the device and released with it, and any failure to
> acquire it is reported during probe instead of being ignored by
> stmmac_resume(). stmmac_mdio_reset() then only pulses the cached line,
> with the delays that were read once and for all at probe time.
>
> Cache the request and delays for DT devices regardless of
> mdio_bus_data->needs_reset. That flag controls the registration-time
> bus reset callback, but system resume calls stmmac_mdio_reset()
> directly. The reset routine no longer looks at the device tree: where
> the description is absent the cached descriptor is NULL and the delays
> are zero, so the pulse remains a no-op.
>
> Keep acquisition conditional on CONFIG_STMMAC_PLATFORM, matching the
> reset callback, so non-platform configurations do not request an unused
> GPIO. Also skip acquisition for a disabled MDIO child: registering that
> bus returns -ENODEV without calling its reset callback, and the driver
> must retain the existing disabled-bus success path even if the unused
> GPIO is unavailable. Remove the unnecessary gpio_desc forward declaration=
.
>
> Fixes: 7c86f20d15b7 ("net: stmmac: use GPIO descriptors in stmmac_mdio_re=
set")
> Cc: stable@vger.kernel.org
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> Co-developed-by: James Hilliard <james.hilliard1@gmail.com>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Dostoyevsky commit message, I didn't read it. Ask the agent
to be terse.

I looked at the code and from a GPIO PoV it does the right
thing: use 1 as asserted and 0 as de-asserted RESET line.

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
