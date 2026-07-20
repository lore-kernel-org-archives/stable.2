Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338663EB7FB
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 16:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784566406; cv=pass; b=Uarmk9WqN1GQLEBM7AhAdbPWtpdAXc5/AFkIXA23cd+2vU1vhQiwXoMtCP3mPyqcZEumnlvAOFcetTl8rTmEsLbxSL4V6qHddm20lL1zxGGCSscfC9aBKWz0kzQocYSGhKBv3xbwbGQiOF/3/u+0Q2gGkopGjBCfY+EiZJZPVK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784566406; c=relaxed/simple;
	bh=qSOihwAar06nv8h68gm4bvTuHPJpIJ55wjBa33x1Ebg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aN1zPhkF+0M3QaCntjjhnU6RPV8kmAUehWnqOhtzzlYNP1891/J4fGmDoYzI3OfnWJioMMgLYtb4emgbLhA2LaZG/ABxX6oNzb6QJG1rdi5GKGwBJdXpNLuXdeTN8G5pAmDJ1TGRhK+JT94y4SSrh7c5mcnF8ckwFhi0Z+DA54s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GjguF/93; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GjguF/93"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c1691e4ec40so645279266b.3
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 09:53:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784566403; cv=none;
        d=google.com; s=arc-20260327;
        b=I3nj9VPMzMz13wUEYGS6dYzDxlQQM5Qaymf5+2gB4LXMqbBWFE6yfMEO3hFEGtFwHO
         rrByTv5SDNGldDWOS9ExiPzR1QeRg3p6eqXweS0JKMfUh5IiUU5vShnZ7HRuTcSBZJSQ
         bI8tnJKZ7UEC3S7CcpbSqP1N9YqSLO3dv5at3PtudG29iXav424l3OVGcy4m5hA2eAiP
         UyuyfTQXZtpLyyvG3Qlb5htrGZ/PMZfaEDmRiOPduKf2EUvUoe/8NoQu5mjvuYJ09H1H
         Po0dDhOu38H1SgJVHoM1BIDKolMi8DRdwro6YSddA9ti+ioGRCdRMoZ2cRM4QWhld2G4
         dHjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3TIixJrgxWFhjPBn/7cXBuahRTs588KwiH/BnLWvNO8=;
        fh=8/RJ/dI4lF4nrd8oQZD0rAp8n9Vm6Q9zP6ykSe+tJdk=;
        b=pj2YB2riWnm1ldi42HMbftf59DPHOx8PeJBLOrRxUJfOaSGjw2H0p5dUROa7q9GjFa
         luq/4lQjKuSuPyho98Dk3cFxu7klbU29FKnGGb1N1thaRjp3aycUrPSGzjOhmHWOMUIu
         n+w9Or/YUx49vXaP3qA39l9x3dsYWFnauR/1YuytoaQx3bE6MNR0UbLWGzT8qbavxC8W
         ul+puDMBVnPHzB/eK4xJOs35bGfIVWoES3aHWaLT/zrJOLXNtSRtlSSpNK5KN9qzP6sd
         gigNvH0mkzdqkeXpp3osqpcsGUP45H0yVXfhNJXoe1CfEFSuUtvYFPiavXE5baAYfepR
         mB4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784566403; x=1785171203; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3TIixJrgxWFhjPBn/7cXBuahRTs588KwiH/BnLWvNO8=;
        b=GjguF/93VJlBXtA+x7sJ9583irQ/G7i7cDrS/2onu+FsY30xC1utoxMpZG8ZXYs9X6
         ZGAKNpOX/fIipflHyaiy53SzeXlMliiWGWcM+JAifHJxP5GnpmCZHQKxG5nW4R33ALgZ
         oXSo9pGtkDYxpcKP0nnwwmC4jHk+mS9zn5/DZyb3OM2LplXVxdcoJVpmlU0QPBwU26q/
         AYI2HPSADg0XTN7IgoJAjFA4LKG4RJAvrDQ/LeT1pd1jUFdhRJoPSeBQ301syYIusYGU
         Pi6sOY/CPSmld953/XWcWUwlt5wFNI23yEuiDAlOYfAJn1dye0EsvWZU2agqF5yJqkM1
         jPvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784566403; x=1785171203;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3TIixJrgxWFhjPBn/7cXBuahRTs588KwiH/BnLWvNO8=;
        b=T7hL2Rh/0kj6w1vuuyNEGTjMtBOjKcw7z4YpJKV5oLPpv1xHE2Eyrmox23tP1yKmqs
         CvmH0cLdGssZqzwMr9LIPqCJaJuAOI8TjcWhbSWlLWfLF5AOWlhzvi6lbmBC2TB3mOXD
         YrWJQwioJpxjxMZXcuoq71+nqwrunMVSRxdSRSZ//1QCDT+i+55fIMxcGayC+s7Uhx4X
         umnMUJ0DNG/iIhoMBMIl4DXzsIYkvdQ20SEiOdTfSR50x+pQ2fBf6tRMdMaa5iXfKB00
         geWKZZszsA6TP8CNiEz5VWS0gryLniwCWiUEV2VHlwqPjIj7OYSzSY1hVv0U1JMhe68S
         IwbA==
X-Forwarded-Encrypted: i=1; AHgh+RrKq3x8AySXsDscI6sgPeaAd0/DB7J6p31HsDCHSxLLsloOy6HV+Bl/sB9nC6czolW2Nbrx2+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YytLfuQUaU8Je8AGxLLy3TLDyAG6B6vu7ZCkmY9csntCgKZxby8
	GiiLBNjMda8ZN09T1ky+DVXppjbwUIIthNlFnktm8ArFsMq6aaTrcMepRbIK/sAK7gJiwHYeq5h
	Tfxw28ugineF3jc10XqBbQSlx6ewgRPEM9uB+xDCo
X-Gm-Gg: AfdE7clKaCJoGLDwWpXUKRWAexn4DyDkJbuqPMMvgDPxgdEBgAx8IqsL07HdZ+mx0Xj
	VPv21rvg15PLmU7pS+uhvqnd1PZ/l9b3EFvudTv9JGxwSRyznnK4bWwDYb87R3MpMmpZKmg4/lt
	JPJT1jWogTBmjP2G7xLgG6B+onUSHh+bVL5pkxelN6CvlnxtwM8CaWj7w5d9u/4H8RIYdnbgkZt
	0d5VNeE2etYh7iIP4K2fnXLYN3DCMos5FyQSn0178jgaOfegmTlchz+8xoasEFaPvMxiR7tTxY1
	+b/GPf9fZvIuN64XRSpcIMK+y9tYagEfWeaDGd81ZeWGgEyctQ0ebzRDz9XNLGoQi9tjHvlKL6m
	Tt9RB9qRtTk0=
X-Received: by 2002:a17:907:6d14:b0:c15:e137:d57f with SMTP id
 a640c23a62f3a-c16b48678d9mr657987166b.54.1784566402947; Mon, 20 Jul 2026
 09:53:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718111340.159896-1-linux@yoavmoshe.com>
In-Reply-To: <20260718111340.159896-1-linux@yoavmoshe.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 20 Jul 2026 09:53:11 -0700
X-Gm-Features: AUfX_mw9O2p0DT6-W8ngt0co6elfl4BwN1-CYf_F0Yc57cKNxMjDlorSGTBkHkI
Message-ID: <CAKwvOd=eAC-Mz0kZhbHQMFOY=ba=WXDH6X_Zzh6KGfuq5PmJ4A@mail.gmail.com>
Subject: Re: [PATCH v3] ARM: imx: Fix suspend/resume crash with Clang CFI
To: "Yo'av Moshe" <linux@yoavmoshe.com>
Cc: Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Russell King <linux@armlinux.org.uk>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 18, 2026 at 4:14=E2=80=AFAM Yo'av Moshe <linux@yoavmoshe.com> w=
rote:
>
> Relocated suspend code in OCRAM lacks compiler-generated CFI type
> signatures. When CONFIG_CFI=3Dy is active, the indirect call to
> imx6_suspend_in_ocram_fn triggers a strict CFI violation panic.
>
> To resolve this safely without reducing CFI protection scope:
> 1. Create a minimal wrapper function imx6_suspend_in_ocram annotated
>    with __nocfi to handle the unverified indirect call.
> 2. Remove the __nocfi annotation from the main imx6q_suspend_finish
>    function to preserve full CFI coverage for other indirect calls
>    in that scope (such as cpu_do_idle() and flush_cache_all()).
> 3. Mark global variables ccm_base, suspend_ocram_base, and the
>    imx6_suspend_in_ocram_fn pointer as __ro_after_init to prevent
>    them from being used as target vectors for CFI bypass exploits.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Yo'av Moshe <linux@yoavmoshe.com>
> ---
> Tested on a Kobo Clara HD (i.MX6SLL SoC) running postmarketOS edge.
> Before this patch, suspending the device caused an immediate silent
> hang requiring a hard-reboot. With this patch applied, suspend and
> resume work successfully.
>
> Differences from v2:
> - Restrained __nocfi scope by adding a dedicated, minimal 1-line
>   wrapper function (imx6_suspend_in_ocram) for the OCRAM call,
>   avoiding disabling CFI checks for cpu_do_idle() and flush_cache_all().
> - Marked global pointers ccm_base and suspend_ocram_base as
>   __ro_after_init to fully neutralize Write-What-Where exploit bypasses.
>
>  arch/arm/mach-imx/pm-imx6.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
> index a671ca498..3d5b960c5 100644
> --- a/arch/arm/mach-imx/pm-imx6.c
> +++ b/arch/arm/mach-imx/pm-imx6.c
> @@ -61,9 +61,9 @@
>  #define MX6Q_SUSPEND_OCRAM_SIZE                0x1000
>  #define MX6_MAX_MMDC_IO_NUM            33
>
> -static void __iomem *ccm_base;
> -static void __iomem *suspend_ocram_base;
> -static void (*imx6_suspend_in_ocram_fn)(void __iomem *ocram_vbase);
> +static void __iomem *ccm_base __ro_after_init;
> +static void __iomem *suspend_ocram_base __ro_after_init;
> +static void (*imx6_suspend_in_ocram_fn)(void __iomem *ocram_vbase) __ro_=
after_init;

Are we able to just put __nocfi on the declaration of
`imx6_suspend_in_ocram_fn`, rather than bother with a wrapper
(imx6_suspend_in_ocram)? I don't know if that works, but surely you
can test that quickly?

>
>  /*
>   * suspend ocram space layout:
> @@ -360,6 +360,11 @@ int imx6_set_lpm(enum mxc_cpu_pwr_mode mode)
>         return 0;
>  }
>
> +static void __nocfi imx6_suspend_in_ocram(void __iomem *ocram_vbase)
> +{
> +       imx6_suspend_in_ocram_fn(ocram_vbase);
> +}
> +
>  static int imx6q_suspend_finish(unsigned long val)
>  {
>         if (!imx6_suspend_in_ocram_fn) {
> @@ -374,7 +379,7 @@ static int imx6q_suspend_finish(unsigned long val)
>                 if (!((struct imx6_cpu_pm_info *)
>                         suspend_ocram_base)->l2_base.vbase)
>                         flush_cache_all();
> -               imx6_suspend_in_ocram_fn(suspend_ocram_base);
> +               imx6_suspend_in_ocram(suspend_ocram_base);
>         }
>
>         return 0;
> --
> 2.55.0
>


--=20
Thanks,
~Nick Desaulniers
