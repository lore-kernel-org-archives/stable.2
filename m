Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20D637F737
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 02:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783305303; cv=none; b=ghppFE/PbutjfmZl39fBnC7VbMj3no6sFs0A1zy3C67VA7FU5CyDtQTdyG2Dcy8LSLjxr2nY4/Atyo/Y7l0d3HW+psnLXGeiAbQRdVsrPey9jlo4jRmHq1qFsc4BgADhaidl2JLS+Gs5n0ZGBJvejSJGvEZImSjl7iV+nfvd0T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783305303; c=relaxed/simple;
	bh=bGVfpODRYTOPWw8MO04AR1OR9mfO9GVzMrditrCeZwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HlcMoxNk9U34uEzkcXo1Q5+g9RWSoMMRpBRieYQpKq22CLhsrEt6NHc0lgEhKyaCipjibMLw0Ve+eVOzdQX4WuQjFe+HPOqsLOAm3maiRlbEv52EXD1mn05j/P+zHkM4KZccyCIiM57Th7UzGruQ9sa7AHg/Xa7GwcM5pIcOvgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDil9Iro; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDil9Iro"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4EE51F01559
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 02:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783305296;
	bh=22CkwgfrVerzyYBreK9SVLhFVeqTRhuZq9yxw53V0Wo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=gDil9IroSj8nU9nEJdL3sIKnUMJkBx5d9rQgu7Pa9CCnHGxcGm8JWWW5vg9MCe08j
	 +0h1yWYaMfu4a5FQE/++J1Y3LbKkq97WoWzud2WWEKGUiBU5htsFMyagWfhPyevRyp
	 GeSFMo2m5tjB6ikn9CnZJarHK+xDYjdIhaZFDXAs9qqQ1y6/zaQnot3v+CvG8aRvM4
	 wv7TGGFK2yaU1nZK3dwfT05nkMdljdYM/21cxfpJLqVEAQs/Cuz2ige9uEq834hQiQ
	 7+T+MDM/+MjqN148Arzlcr59tux43QEPAZ7Xv6A+W7aA6mPYVyBF0A71Sek9KGFnod
	 l6cZb4qZ/0Ozw==
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-966d7738c3bso1411747241.0
        for <stable@vger.kernel.org>; Sun, 05 Jul 2026 19:34:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrVf1Ip8PJJ629qFJXiirY6X04gO+MhIdi+cH3Fhk6pmhlLUzyj4O0BUnnquMz2S8z/jLfz0BM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxetGqbKg8CMgNf0gVUfgFQOq7OOwOCUttE4424tyJUJpTlokVC
	iQFJ2mQqHHXrCwqFRda607pvohqk0iJ0bRD+KYCT08uof/Ccnq8/4f2IgCXV693VE8IUnJS/DyV
	7ozn+hq2n1cVgRICQwJ9lxCkKUUCjhm0=
X-Received: by 2002:a05:6102:1483:b0:631:4cda:3ebb with SMTP id
 ada2fe7eead31-7427e5f8144mr3352981137.24.1783305295988; Sun, 05 Jul 2026
 19:34:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706021909.2346535-1-zhoubinbin@loongson.cn>
In-Reply-To: <20260706021909.2346535-1-zhoubinbin@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 6 Jul 2026 10:35:19 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5VUDCKAGKDFRNySzJYX9ok5j_VAmV_tBFkqBmfTQ_O8g@mail.gmail.com>
X-Gm-Features: AVVi8CeDWjQjxOKXJ_wTEeFwyOh_W_uaEHj9oKvjoc1VBbySFBXklB3GDeKd3-I
Message-ID: <CAAhV-H5VUDCKAGKDFRNySzJYX9ok5j_VAmV_tBFkqBmfTQ_O8g@mail.gmail.com>
Subject: Re: [PATCH v3] mfd: ls2kbmc: mfd: ls2kbmc: Fix iomem pointer handling
 in video mode parsing
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>, 
	Lee Jones <lee@kernel.org>, Corey Minyard <minyard@acm.org>, Chong Qiao <qiaochong@loongson.cn>, 
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, mfd@lists.linux.dev, 
	linux-kernel@vger.kernel.org, openipmi-developer@lists.sourceforge.net, 
	jeffbai@aosc.io, zhuyunfei@loongson.cn, stable@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Binbin,

On Mon, Jul 6, 2026 at 10:19=E2=80=AFAM Binbin Zhou <zhoubinbin@loongson.cn=
> wrote:
>
> Use pointers annotated with the __iomem marker for all iomem map calls,
> and creates a local copy of the mapped IO memory for future access in
> the code. memcpy_fromio() and memcpy_toio() are used to read/write data
> from/to mapped IO memory
>
> Cc: stable@vger.kernel.org # v6.18+
> Fixes: 0d64f6d1ffe9 ("mfd: ls2kbmc: Introduce Loongson-2K BMC core driver=
")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202603021730.Yy3QXYTw-lkp@i=
ntel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202606120639.WG6eb8VU-lkp@i=
ntel.com/
> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
> V3:
>  - Reduce the range of `ioremap` from `SZ_16M` to `SZ_64`;
>  - Define a new variable `pos` to iterate through the string;
>  - Add failure handling for `strncmp()`.
>
> Link to V2:
> https://lore.kernel.org/all/20260624085550.1508771-1-zhoubinbin@loongson.=
cn/
>
> V2:
>  - Add the missing memcpy_fromio();
>  - Drop the unnecessary `buf` variable.
>
> Link to V1:
> https://lore.kernel.org/all/20260616115530.4012675-1-zhoubinbin@loongson.=
cn/
>
>  drivers/mfd/ls2k-bmc-core.c | 29 ++++++++++++++++++++++-------
>  1 file changed, 22 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mfd/ls2k-bmc-core.c b/drivers/mfd/ls2k-bmc-core.c
> index 408056bfb2fe..a2aee2131529 100644
> --- a/drivers/mfd/ls2k-bmc-core.c
> +++ b/drivers/mfd/ls2k-bmc-core.c
> @@ -66,6 +66,9 @@
>  /* Maximum time to wait for U-Boot and DDR to be ready with ms. */
>  #define LS2K_BMC_RESET_WAIT_TIME       10000
>
> +/* The length of the LS2K BMC display resolution string stored in PCI BA=
R0 */
> +#define LS2K_RESOLUTION_STR_LEN                SZ_64
> +
>  /* It's an experience value */
>  #define LS7A_BAR0_CHECK_MAX_TIMES      2000
>
> @@ -427,27 +430,39 @@ static int ls2k_bmc_init(struct ls2k_bmc_ddata *dda=
ta)
>   */
>  static int ls2k_bmc_parse_mode(struct pci_dev *pdev, struct simplefb_pla=
tform_data *pd)
>  {
> -       char *mode;
> +       char *mode __free(kfree) =3D NULL;
> +       void __iomem *base;
> +       char *pos =3D NULL;
Don't need to initialize, and you can define it in the same line as mode.

>         int depth, ret;
>
>         /* The last 16M of PCI BAR0 is used to store the resolution strin=
g. */
> -       mode =3D devm_ioremap(&pdev->dev, pci_resource_start(pdev, 0) + S=
Z_16M, SZ_16M);
> +       base =3D devm_ioremap(&pdev->dev, pci_resource_start(pdev, 0) + S=
Z_16M,
> +                           LS2K_RESOLUTION_STR_LEN);
IOREMAP is page based, so just use PAGE_SIZE rather than
LS2K_RESOLUTION_STR_LEN.

Huacai

> +       if (!base)
> +               return -ENOMEM;
> +
> +       mode =3D kmalloc(LS2K_RESOLUTION_STR_LEN, GFP_KERNEL);
>         if (!mode)
>                 return -ENOMEM;
>
> +       memcpy_fromio(mode, base, LS2K_RESOLUTION_STR_LEN);
> +
>         /* The resolution field starts with the flag "video=3D". */
> -       if (!strncmp(mode, "video=3D", 6))
> -               mode =3D mode + 6;
> +       if (strncmp(mode, "video=3D", 6)) {
> +               dev_err(&pdev->dev, "Simpledrm resolution missing or corr=
upt!\n");
> +               return -EINVAL;
> +       }
>
> -       ret =3D kstrtoint(strsep(&mode, "x"), 10, &pd->width);
> +       pos =3D mode + 6;
> +       ret =3D kstrtoint(strsep(&pos, "x"), 10, &pd->width);
>         if (ret)
>                 return ret;
>
> -       ret =3D kstrtoint(strsep(&mode, "-"), 10, &pd->height);
> +       ret =3D kstrtoint(strsep(&pos, "-"), 10, &pd->height);
>         if (ret)
>                 return ret;
>
> -       ret =3D kstrtoint(strsep(&mode, "@"), 10, &depth);
> +       ret =3D kstrtoint(strsep(&pos, "@"), 10, &depth);
>         if (ret)
>                 return ret;
>
>
> base-commit: d5d2d7a8d8be18681a0864f58e3875f1c639e11c
> --
> 2.52.0
>
