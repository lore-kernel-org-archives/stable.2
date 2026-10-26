Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792989982;
	b=ESHVkpmTI8HDA9M/mmstYIf/f1TixwRz3Ia1qymAobQmWIfBfTj4+PjFWCUFmjnNO8jM
	 U0T5vs2Rql3zGjmpHSXwhMqoQ9pUAA2HMiESm0vzty7we0A93rG5AxOMmUk6SBX567amH
	 AaVCKtJigheBjdhCDVOe0z4AFNhjSp5slsb6ZAtKb94Jc4M1f1dM9lDAZVtunTSBGL6Kh
	 W/RiO6cDhwivoKy0b/AS7bpX477fQUTr5eUbG0EjATJ1Mxr0tUsn2NOylx6Qkn4MKHbGF
	 AeNrpjLX0LaLEAMnhyTZCRR+YMV5KldxlAJeKJVChu5q8kXEBHSPzWM9rm7SGn7mXQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792989982;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=mOrTqyFuWDMhTrOz4qH+PVMDq3SnFizbYjluGLBXc3Q=;
	b=EzpzenrE+5XIIQ1muwH42oSIbwX6naB1Hn8oS4VNet6KPx/k5H0I/g3KRakOb1RP93Dz
	 MDm+tB4Ndla+lzB6Hi9KnrmUcZBk/Le/TptK6YXY16N69u1DzYuwA4lro7bhJObKoul38
	 f54AHR/2HBMAAdTNBE1EsxogOI9h+bEzjDWl3enrEcrZN+PiwsLkgDsWwtk8boVtkXhfP
	 bziDGUHZS2kfJsjAqppJRQrX4f9JagQWS0cCGD1LgDww1lbdwowjSxaM8tbCB3NPLumRl
	 UOch1w+Oo6MFpeIh2nCCyQ4xtB59ybqwizwkP8ZZnkbjRPeueyrIvObbvSFmg242UNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JgNinzJd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FA7606A32A
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 04:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JgNinzJd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DD1A1F031E8
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 04:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792989981;
	bh=mOrTqyFuWDMhTrOz4qH+PVMDq3SnFizbYjluGLBXc3Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JgNinzJddzXO4gVHgLL2xsH4hSXg8Q/MD7W0aKn37vi9Nm+U9kEj8fE8FODdzfLvf
	 vvoSvxo8WKH3d6NwxlOSBO+PhjLD8/WdZRQnkX9MiiZpl3+5l0SMnLu1E1tJQtc6th
	 M9oYuKzKY1TQt4TbOev36uZRtXZOOYhD1QUF7Ere0W2va5OUiHoxyZnrP0mbpqr/7F
	 wTe1ZRW8hkL7S+k7m6M812EIJXOppQb7AtwcCesXC5wYgcCoSjTZoacYBwGQR+TpZ9
	 KMmeCjcodArjOadcgXVOps3rzSo+x3S2FfsuMkGVEgTocwcByRU0PXujV5zPYjx7ov
	 MIeJcSsPHb7JA==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b1aa2848d2so4106163a12.3
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 21:46:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxxKl7SmCAkd4KQkCXSGehq5jJZKL0N1+5DTrST3Pk0useChN/vYtoawRxv6FDO2yfSrzGqz64=@vger.kernel.org
X-Gm-Message-State: AFq9FYJEWxgfDz0NWe8Fd51ZvV8I4bZgpyBsRlEVNJLMQXDLxuFilHbQ
	7RVsru06pITOzZ55oFzB49yS0L4kyFTg51y3z5c0vItbAClz2q5KiUh/YgrRXyTZGJgna/Pqexk
	ibxZPNHZHzpehRDRGANEbrM7pYDCgAkc=
X-Received: by 2002:a05:6402:e8d:b0:6ad:186a:fda9 with SMTP id
 4fb4d7f45d1cf-6b442db3ca4mr6960926a12.2.1792989980084; Sun, 25 Oct 2026
 21:46:20 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020-fw-devlink-nexus-ready-v3-0-fd6f1c17e16d@toradex.com> <20261020-fw-devlink-nexus-ready-v3-2-fd6f1c17e16d@toradex.com>
In-Reply-To: <20261020-fw-devlink-nexus-ready-v3-2-fd6f1c17e16d@toradex.com>
From: Saravana Kannan <saravanak@kernel.org>
Date: Sun, 25 Oct 2026 21:46:07 -0700
X-Gmail-Original-Message-ID: <CACRMN=fkhoaTLBrk-01yZBKirrSiND=zspBs=BAur+3CnKLU8w@mail.gmail.com>
X-Gm-Features: AclHuK-OYUzzrtUJCFh4TFZ-yZrKNaI32savpoRnm_cngkmiLTtp5icSCjr4rXk
Message-ID: <CACRMN=fkhoaTLBrk-01yZBKirrSiND=zspBs=BAur+3CnKLU8w@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] of: property: fw_devlink: Follow GPIO nexus maps
To: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	"Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>, Frank Li <Frank.li@oss.nxp.com>, 
	Kieran Bingham <kieran.bingham@ideasonboard.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Herve Codina <herve.codina@bootlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Leonardo Costa <leonardo.costa@toradex.com>, 
	Frieder Schrempf <frieder.schrempf@kontron.de>, devicetree@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, stable@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 6:00=E2=80=AFAM Ernest Van Hoecke
<ernestvanhoecke@gmail.com> wrote:
>
> From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
>
> GPIO consumers use of_parse_phandle_with_args_map() to resolve
> specifiers through gpio-map properties. fw_devlink instead parses GPIO
> properties as direct phandle references, so it records the nexus node as
> the supplier rather than the mapped GPIO provider.
>
> A nexus is a translation node, not the GPIO provider, and need not be
> populated as a device. The resulting fwnode link can therefore remain
> unresolved and indefinitely defer the consumer while
> device_links_check_suppliers() waits for the nexus.
>
> Use the map-aware parser for all supported GPIO property spellings. This
> makes fw_devlink resolve the same provider as the GPIO consumer API.
> Direct GPIO references continue to work because the map-aware parser
> returns the original provider when no gpio-map property is present.
>
> Fixes: 7f00be96f125 ("of: property: Add device link support for interrupt=
-parent, dmas and -gpio(s)")
> Reported-by: Leonardo Costa <leonardo.costa@toradex.com>
> Link: https://lore.kernel.org/all/juuc4af7ndbajcl7gzf4tg5qz2q2j5tt3rvql4j=
bauradujrre@gc5nbdhhixaf/
> Tested-by: Leonardo Costa <leonardo.costa@toradex.com>
> Cc: stable@vger.kernel.org
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Reviewed-by: Herve Codina <herve.codina@bootlin.com>
> Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> ---
>  drivers/of/property.c | 38 ++++++++++++++++++++++++++++----------
>  1 file changed, 28 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 45e55f618488..aa65976739e1 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1311,6 +1311,19 @@ static struct device_node *parse_prop_cells(struct=
 device_node *np,
>         return sup_args.np;
>  }
>
> +static struct device_node *parse_nexus_prop(struct device_node *np,
> +                                           const char *prop_name, int in=
dex,
> +                                           const char *stem_name)
> +{
> +       struct of_phandle_args sup_args;
> +
> +       if (of_parse_phandle_with_args_map(np, prop_name, stem_name, inde=
x,
> +                                          &sup_args))
> +               return NULL;
> +
> +       return sup_args.np;
> +}
> +
>  #define DEFINE_SIMPLE_PROP(fname, name, cells)                          =
 \
>  static struct device_node *parse_##fname(struct device_node *np,        =
 \
>                                         const char *prop_name, int index)=
 \
> @@ -1361,6 +1374,15 @@ static struct device_node *parse_##fname(struct de=
vice_node *np,      \
>         return parse_suffix_prop_cells(np, prop_name, index, suffix, cell=
s); \
>  }
>
> +#define DEFINE_SUFFIX_NEXUS_PROP(fname, suffix, stem)                   =
    \

It's the node that's called the nexus node. The properties themselves
all have a "map" in their name.

I'd prefer calling these DEFINE_SUFFIX_MAP_PROP() and the simple one
as DEFINE_SIMPLE_MAP_PROP(). Similar fixes for the function names too.

I know it's a nit pick, but I think it makes sense.

-Saravana

> +static struct device_node *parse_##fname(struct device_node *np,        =
    \
> +                                       const char *prop_name, int index)=
    \
> +{                                                                       =
    \
> +       if (!strends(prop_name, suffix))                                 =
    \
> +               return NULL;                                             =
    \
> +       return parse_nexus_prop(np, prop_name, index, stem);             =
    \
> +}
> +
>  /**
>   * struct supplier_bindings - Property parsing functions for suppliers
>   *
> @@ -1416,7 +1438,7 @@ DEFINE_SIMPLE_PROP(pses, "pses", "#pse-cells")
>  DEFINE_SIMPLE_PROP(power_supplies, "power-supplies", NULL)
>  DEFINE_SIMPLE_PROP(mmc_pwrseq, "mmc-pwrseq", NULL)
>  DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
> -DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
> +DEFINE_SUFFIX_NEXUS_PROP(gpio, "-gpio", "gpio")
>
>  static struct device_node *parse_pinctrl_n(struct device_node *np,
>                                            const char *prop_name, int ind=
ex)
> @@ -1436,8 +1458,10 @@ static struct device_node *parse_gpios(struct devi=
ce_node *np,
>         if (strends(prop_name, ",nr-gpios"))
>                 return NULL;
>
> -       return parse_suffix_prop_cells(np, prop_name, index, "-gpios",
> -                                      "#gpio-cells");
> +       if (!strends(prop_name, "-gpios"))
> +               return NULL;
> +
> +       return parse_nexus_prop(np, prop_name, index, "gpio");
>  }
>
>  static struct device_node *parse_iommu_maps(struct device_node *np,
> @@ -1452,8 +1476,6 @@ static struct device_node *parse_iommu_maps(struct =
device_node *np,
>  static struct device_node *parse_gpio_compat(struct device_node *np,
>                                              const char *prop_name, int i=
ndex)
>  {
> -       struct of_phandle_args sup_args;
> -
>         if (strcmp(prop_name, "gpio") && strcmp(prop_name, "gpios"))
>                 return NULL;
>
> @@ -1464,11 +1486,7 @@ static struct device_node *parse_gpio_compat(struc=
t device_node *np,
>         if (of_property_read_bool(np, "gpio-hog"))
>                 return NULL;
>
> -       if (of_parse_phandle_with_args(np, prop_name, "#gpio-cells", inde=
x,
> -                                      &sup_args))
> -               return NULL;
> -
> -       return sup_args.np;
> +       return parse_nexus_prop(np, prop_name, index, "gpio");
>  }
>
>  static struct device_node *parse_i2c_parent(struct device_node *np,
>
> --
> 2.43.0
>
