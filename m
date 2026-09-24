Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405834756B1
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 12:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790252393; cv=pass; b=fbo5cQieq/EfFnIoGKsckpNIkPExo09hZMMc7uYYqIiDvRqUu7Y4vfso5fo5HlevofGID36FD6YjZ5t7+aqYdsfr3FMYgBippTJ20kgAGapC8+EsNPyCj/1YvhSHDxixIxBxAmmVL6pQPqk288vvgPkMJt7dt638wu/+lB2Xw0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790252393; c=relaxed/simple;
	bh=QrzmK3wGyZKCxCcAVNUy/oG4X2vMWpqXP/L7GgMxP+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZA80IBcrL1lwQfP6PHR8WnqPKjvIeq1ZjFTc+hFh+Jv15ox07KUauk88Pjn5RpqH/OOUGh0p2S1A6uEUkEs75QlpdhbK4Q7cfR5mqv8Mmu8/5o6F9fzJatiXCxSubL3ByE3BjW5C1UtCrh+bo/U/XXOlQ1+Mo6S4Gz9zm1rgrN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPcUBqDT; arc=pass smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPcUBqDT"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485984ebf5cso1638983f8f.0
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 05:19:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790252389; cv=none;
        d=google.com; s=arc-20260327;
        b=f9qTghJ+WxCTsxhG/TYxroR90kHc+Arm48oBS3xuuCxjsbIIx6gjIGnS3eZbN/vhHk
         +xw1LOQ3QhG2jknHEF+cra/e8MwYD9hYrbe1e5vnQECj9aIZhCSW4zw1peeTpiGnd/za
         i8HWHtqQKe+9YB5MNNa4RanPqnGelgpoJEAiL9F9HpgT6NnH+9FdWWDsvtOVtZoLa3NU
         Xv//cXYr8ZFfQ1n14LXbe1aH9zqyoLgP1soHM62XVmKIBbXZb5rPhrjKnzyMuaFj72Iw
         p7ApoclgG9OHmQcmPaz2zTNoTaT3SwxHHrkRDjQXdsdq5N37YSE3sKau4j1xiWl/s0k6
         HjSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sOdRDaL5nLRUX0xNiudVZSR4Cv7Thxx5Y/qYJ603sMw=;
        fh=vEVls8syR6gY1DVfwk5iRxjHAA6ffm1Xl5UbFyBiQu8=;
        b=nzIabOqSRkss7MJnaC8cMwJ78R7q8MbTUtIFxZ+ILNc8mMchOMGhatUihUvN1N0r4r
         aK8j6iD5F6+0ymXcFsAGmFNcWxYCOFDYJeZ8psv0184hqszQ5VG8HS/RQv1PbTcs1Zb4
         SjSvG+gku2BLpFJY+KqawzuAugqAFZNSkOZ/VIfHcg+5PysAju6M5og7BE928ZLUs0bn
         AG3YoaSbxa4G+Nruo/JAXdNkKxKpR+ZQPeg0KztBTWQR7Yx7N83fGfoZ1RCfDnCsy9U5
         UqzKSC2+wifPlDPuRQSaEvP7v8tYJuzKXWkdO9c8+rZnsoY6IBp9MOHKHUqI+wkY3zRf
         OceQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790252389; x=1790857189; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sOdRDaL5nLRUX0xNiudVZSR4Cv7Thxx5Y/qYJ603sMw=;
        b=PPcUBqDTOHXMbQqnuToY4PpxvUAX5PNdSZD+MIImFeeX20rDeNqccQ34vtNOQIXT6g
         pZhlGtSmi3tnU3UqqfatzdI39oYv/jOV3IoSW0AfI9cOenHrOK7q7T6YT3oNqtPonF6m
         6QMekfIz+0pozib8s0wmry63TNp94rLMeCWavcjj25q+GUIn7s7J5pqpVPCkLK+4iCJc
         fn8TdMKhd39RdndpsOxl35ica9Gdji9q3tCr9QaOKb4y9VSjXp9RwxJC8qJJ9WaQpqsp
         a2gxHy3jQfEHITsmAqkhd7/G/SBELSzqSIVW1ccdxXWVmUcfdKfqU98Ka4E0KL5sReMu
         aIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790252389; x=1790857189;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sOdRDaL5nLRUX0xNiudVZSR4Cv7Thxx5Y/qYJ603sMw=;
        b=mTflI9euUAMJ0mwjEGY6Z0ILGKyKiXG6j4uSNLu94hQP7ORxW0ayeh6rmHwlKm+lpz
         aZZRcATt8FOI2ckQh87Va7WC2BNKfL7PBCoAzNj2Sapm1MeBMI2gdPYBt0ggxeCXewnJ
         MXccC6Ur+i2+uAiybf6+jSk9CZBAhRLHdo6+rWN9WthOiL2sdeHUZHnQ+5gukZn0FRYL
         ++rHJ9xOEFoaAcrj6n+kKFLwJKcLy1kHn50avSUlplMdqxfbX/PTsyvxlgYWxp0XjCz4
         sGV+i4ZAKPbYIHSg/042S36QeLsd30v7ef1i8gKdCb/9pxXyW3eCoUxVdqGoxUxRS1mA
         Mtcw==
X-Forwarded-Encrypted: i=1; AKwUvBxJ/+3bRopTsGRiV2aj4fAWUsRmj47pi8/UuM1baKTUvXtpn5Kem/F2RY/vHp4UQGbWEySfNwA=@vger.kernel.org
X-Gm-Message-State: AFuF++kl5RmFczpxcRPb/4UvHtn4BTAHTIEbCGgL5TjFQfHh9K7IvBWe
	kAz3vAnSVA/rppv8QzBzdzmprsIltHmjYauYInKbrV05zvfydSH2ElfQ3S1XY+a+Y4T5MLF9OKA
	6y26EEtJJOucjavrjUT+xB7UCp6DXtvk=
X-Gm-Gg: AYBFou3H2wvoWrk7HsotkPv+coe4EwAvTgjsFhcVUQrKXVJD0dhP0TpVRnNP/sq//u/
	vgdPv1ITw9zbCuAveWF4fvEsMT4ExP1mKDATwtAR51ONVC0I5D5MpvBOzDMelbpbmLSBB+y98jU
	/z7gxnhYctrdg1x3/+gHFAV09cvd+/9gM0Rpnd6ZD0Y3QCSOBNQtsU6po2vKR2tN8UBrvsmV5dt
	rIfQI9sdOwmHxhc3VBbgto5W5z0UBUMD7HGovODiquZlZpl944FLGZQVZtxTUk0ZgVt6WRMjXi4
	rAtpoF4MB8gU05Qp58zo7NQL5qqybuNWI8RFibYdrBB8jAi/EbZtyV9eo0GlyEwV7ijAgIqKzvd
	tMDbi7cXsEAdpwSgZTWi6OiKLDM4DD9TVVCBNzln9yOE=
X-Received: by 2002:adf:e188:0:b0:486:f980:2361 with SMTP id
 ffacd0b85a97d-48872ac750cmr3107347f8f.45.1790252389207; Thu, 24 Sep 2026
 05:19:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922144629.586997-1-claudiu.beznea@kernel.org> <20260922144629.586997-2-claudiu.beznea@kernel.org>
In-Reply-To: <20260922144629.586997-2-claudiu.beznea@kernel.org>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 24 Sep 2026 13:19:22 +0100
X-Gm-Features: AclHuK-idVdhsB6tGLLC0zrpRkFq8euSZ0ifbTPMKw_QOO-4kHiRYVKAvxMjB_A
Message-ID: <CA+V-a8tqoLXKX2W2-QdR+_+grpskwXpDwg32aJ72cgmbUqMG5g@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] PCI: rzg3s-host: Follow hardware manual
 clock/reset initialization order
To: Claudiu Beznea <claudiu.beznea@kernel.org>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
	robh@kernel.org, bhelgaas@google.com, p.zabel@pengutronix.de, 
	claudiu.beznea@tuxon.dev, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 3:53=E2=80=AFPM Claudiu Beznea
<claudiu.beznea@kernel.org> wrote:
>
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> The RZ/G3S PCIe hardware manual specifies that the clocks must be enabled
> before the reset signals are deasserted during initialization.
>
> Follow this sequence in the probe(), suspend(), and resume() paths to
> match the hardware requirements and avoid potential issues.
>
> Fixes: 7ef502fb35b2 ("PCI: Add Renesas RZ/G3S host controller driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v4:
> - none
>
> Changes in v3:
> - none, this patch is new
>
>  drivers/pci/controller/pcie-rzg3s-host.c | 40 +++++++++++++-----------
>  1 file changed, 21 insertions(+), 19 deletions(-)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/contr=
oller/pcie-rzg3s-host.c
> index 077cfb0834b3..e1105b1f2652 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> @@ -1888,10 +1888,6 @@ static int rzg3s_pcie_probe(struct platform_device=
 *pdev)
>         if (ret)
>                 goto sysc_signal_restore;
>
> -       ret =3D rzg3s_pcie_power_resets_deassert(host);
> -       if (ret)
> -               goto sysc_signal_restore;
> -
>         pm_runtime_enable(dev);
>
>         /*
> @@ -1902,12 +1898,16 @@ static int rzg3s_pcie_probe(struct platform_devic=
e *pdev)
>         if (ret)
>                 goto rpm_disable;
>
> +       ret =3D rzg3s_pcie_power_resets_deassert(host);
> +       if (ret)
> +               goto rpm_put;
> +
>         raw_spin_lock_init(&host->hw_lock);
>
>         ret =3D rzg3s_pcie_host_setup(host, rzg3s_pcie_init_irqdomain,
>                                     rzg3s_pcie_teardown_irqdomain);
>         if (ret)
> -               goto rpm_put;
> +               goto power_resets_assert;
>
>         bridge->sysdata =3D host;
>         bridge->ops =3D &rzg3s_pcie_root_ops;
> @@ -1922,12 +1922,13 @@ static int rzg3s_pcie_probe(struct platform_devic=
e *pdev)
>         clk_disable_unprepare(host->port.refclk);
>         rzg3s_pcie_teardown_irqdomain(host);
>         host->data->config_deinit(host);
> +power_resets_assert:
> +       reset_control_bulk_assert(host->data->num_power_resets,
> +                                 host->power_resets);
>  rpm_put:
>         pm_runtime_put_sync(dev);
>  rpm_disable:
>         pm_runtime_disable(dev);
> -       reset_control_bulk_assert(host->data->num_power_resets,
> -                                 host->power_resets);
>  sysc_signal_restore:
>         /*
>          * SYSC RST_RSM_B signal need to be asserted before turning off t=
he
> @@ -1948,10 +1949,6 @@ static int rzg3s_pcie_suspend_noirq(struct device =
*dev)
>         struct rzg3s_sysc *sysc =3D host->sysc;
>         int ret;
>
> -       ret =3D pm_runtime_put_sync(dev);
> -       if (ret)
> -               return ret;
> -
>         clk_disable_unprepare(port->refclk);
>
>         /* SoC-specific de-initialization */
> @@ -1964,13 +1961,19 @@ static int rzg3s_pcie_suspend_noirq(struct device=
 *dev)
>         if (ret)
>                 goto config_reinit;
>
> -       ret =3D rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_RST_RSM_B=
, 0);
> +       ret =3D pm_runtime_put_sync(dev);
>         if (ret)
>                 goto power_resets_restore;
>
> +       ret =3D rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_RST_RSM_B=
, 0);
> +       if (ret)
> +               goto rpm_resume;
> +
>         return 0;
>
>         /* Restore the previous state if any error happens */
> +rpm_resume:
> +       pm_runtime_resume_and_get(dev);
>  power_resets_restore:
>         reset_control_bulk_deassert(data->num_power_resets,
>                                     host->power_resets);
> @@ -1980,7 +1983,6 @@ static int rzg3s_pcie_suspend_noirq(struct device *=
dev)
>         data->config_post_init(host);
>  refclk_restore:
>         clk_prepare_enable(port->refclk);
> -       pm_runtime_resume_and_get(dev);
>         return ret;
>  }
>
> @@ -2009,18 +2011,18 @@ static int rzg3s_pcie_resume_noirq(struct device =
*dev)
>                         goto assert_rst_rsm_b;
>         }
>
> -       ret =3D rzg3s_pcie_power_resets_deassert(host);
> +       ret =3D pm_runtime_resume_and_get(dev);
>         if (ret)
>                 goto assert_rst_rsm_b;
>
> -       ret =3D pm_runtime_resume_and_get(dev);
> +       ret =3D rzg3s_pcie_power_resets_deassert(host);
>         if (ret)
> -               goto assert_power_resets;
> +               goto rpm_put;
>
>         ret =3D rzg3s_pcie_host_setup(host, rzg3s_pcie_msi_hw_setup,
>                                     rzg3s_pcie_msi_hw_teardown);
>         if (ret)
> -               goto rpm_put;
> +               goto assert_power_resets;
>
>         return 0;
>
> @@ -2028,11 +2030,11 @@ static int rzg3s_pcie_resume_noirq(struct device =
*dev)
>          * If any error happens there is no way to recover the IP. Put it=
 in the
>          * lowest possible power state.
>          */
> -rpm_put:
> -       pm_runtime_put_sync(dev);
>  assert_power_resets:
>         reset_control_bulk_assert(data->num_power_resets,
>                                   host->power_resets);
> +rpm_put:
> +       pm_runtime_put_sync(dev);
>  assert_rst_rsm_b:
>         rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_RST_RSM_B, 0);
>         return ret;
> --
> 2.43.0
>
>
