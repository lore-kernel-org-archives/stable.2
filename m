Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C0447D46D
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 12:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790252492; cv=pass; b=oDB/1SSuSZfX6QhLpcJQ6/WXlb55PteTl2tSAkTgPKQ8clj2EcWFdgLwgnV+2qcprJC8/WLGyB3WW2v479pDgKcdzQ93MaO4uREqyZX/WxxhjTr9nVG5xgKTqiJktaAyeYNGYWGvLn6pOQNMpgfunuY3B/48c8sRFfEI/GDM8Qw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790252492; c=relaxed/simple;
	bh=xeNd5Z4KutAQUnG4imh+PXHxOYvDguVwzRBnlJk6ubU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tUI4gWtws9GqLUL+/k2P+kW7FBWFiyeHjYlk9opI5e9xD64tsWZCQXfLtgBSb76FkPEUAKxHYALYXaUNHWRaDvH7UCoVIDyobpkLqAqMimrvnyx2/OJnpTHUTu9T4mZxlbl16q2zQix1LcJSKTtWFiz7HgjDEMDC9nvnbFxSeRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zg1veJnj; arc=pass smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zg1veJnj"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6350f89so1398833f8f.3
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 05:21:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790252489; cv=none;
        d=google.com; s=arc-20260327;
        b=cLCaqgdLpXKB6njHOXINnELynQxxJV1jq02MWFuxwCjr1lcTYOb/HwJQNJMQniFQhm
         uutNXLJ9OXV1X3ecu3r4bCHuHtOAzK8grVTfL5RlbicD91WqU2Seit1P1+nCtDxkFgEw
         BREg7UGiGrU7ylisdRdZi+SXyIbSembEjAg8BVzXosKCPAEnco3CLyfW130wyJstyElh
         fOLafLNcRDQ9RU8iyZSDatXvsqloSAapq12+H93kUmTGDiD8EbB1n/6tPPV/sEApKKQq
         5gX9pte6yE1wHotExvk97nNbsIUKjRXwalS7CX5PJXaBnjtx4FfrDBiCmawmk4eOKRMf
         GKCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qM5+SKQmy+vgU7/eLGaFkuMRmst60I3hKbtua8AJCxc=;
        fh=oWiUcjJfomtwrgRozCJuUg7w5P8YpUyUxc4AKaukB3g=;
        b=TxpUo0zfvWZmF5nCZ2NzQC2VEYINh8A2zm5bmYvbV13FIYz99ikTGGuxTbFLyX3LXG
         wapE/Nql1bwszTDVLz08WWrt66c4L/65JKMJy5nbOoTNCbjbopEyOSSatlud3FEkSZ7s
         N5y2N1dZFVBQlnwun996xnhE8vVg0jv6zjw1vPQzVQRfjjik9TBs33fZVeEnBwy8sv34
         9dOYfXL23NBzf/Y9PUKMQtiaZ6kSfX77icUAPWAv+dz8n0gZQqB7Hz5grhAWDbv6mtBy
         R7JLl3GFD2baNjjhlmxz6/NheaZHJzdGWznfVQyzTL1LogZKv5TtCMwRy/v15WPEQcHt
         Ru3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790252489; x=1790857289; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qM5+SKQmy+vgU7/eLGaFkuMRmst60I3hKbtua8AJCxc=;
        b=Zg1veJnjezsEgJvBYZtGGJ+l1w5aCC3xIToB28sSyDZ6qrclGyHkZ/BkblIybs6Oj/
         BD2FsYhT2bQjZPGYAlSMUEO2ZmURV/2oDLLt6w81DWQhjVCb4v7QpXEkQ6o7M885RfWP
         7ljUhNqdYxe9qSuExVXISLn1DhufuDrJnEDeaqB2umhgQ+ptjrPERmzMHPTw+tOwibIR
         XBzoKX4HNqPmr1U5KUQySm+vmRKMN3qTTyIPSYkNouwVHhun86IqAoW+tlV50p3LxKLS
         WM0M1FZKknIkHkwklcNTP5tAfG4XJf0pwha3/Cse40U9S1KCrJgw8/1XnUGmnJq0jiQS
         mOZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790252489; x=1790857289;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qM5+SKQmy+vgU7/eLGaFkuMRmst60I3hKbtua8AJCxc=;
        b=ugCBVBcJTJMyIrNuzE/8p+nZhwRrAjcVBzzHseu6VHu5AS0En424XlFRAL70F2MT40
         86R66JoSs778cu99EgUTqLAiP+KZTIMZVYnYgeBUXa6OjCQoHsyj/WCS0KwFzWMBPfki
         WW4FshZPIzyo/xh4FFTLIXYZvH13ejz2sEWXIGd77fndIEASh2Yzpr9PhdAEMYBl4Lnl
         P3pzcDHn89HQZh7OOw0hMSUqjTBHmzOTkMljEZrN7A12twB2uN0Jlho9CvvXjIUcf48O
         Gfj6d288nLZKR4V4lcInhsQvTeZRN90ScQcjpaFlyYh4DvBeTeJCZ16T24CMp9UBbIdo
         aXbA==
X-Forwarded-Encrypted: i=1; AKwUvBwSIB2MM2xkPTKHErzep+UPYMG4gFGWSU4ZpNkxG29utYW1tLOBd6cs5tDv2riBpbz4yUlmevM=@vger.kernel.org
X-Gm-Message-State: AFuF++kzD28JVDIwvDpCLeYYhHWIQYBFxOXgjCWohq6liwy/1SghFx6r
	4UU09gpunvgsB3MGpnC0oNEdf0J0k/yM00B1orVaJO8aKZ6G1lLTWzZsQOmDnKEYY/5IGtZawuV
	pvK03ddEUpa3llu8L/3ufRXPPQARFSStHXMCHMPI=
X-Gm-Gg: AYBFou3pqCSPLT9n1IwH8KwtVgj0haaZcf6PZM9PqpV7bxf6t6sUKIfN0CvqXDorrkC
	ampe4vtgM5d3yXQ6cFrAVldlckhEH93sOAz6zyDfp3DlgzWwGyGm74Q0RTjxvVmST2kN+ZqjWCk
	dxXMLo7ZCwFChk7ZiSZzGtrQdCsbmvBrnBthMJr5XoExQAWJO3yO1HxyIgb+9NlGFr7xozvx/32
	QBw1Wc+NAQ9X8acG9gn2Jh9Dsw3SMQZvIK6YA47psf/v3Q4xu8Fd3ecQur0JJOJULLBkv2w4TIm
	zXlVIYsyU4LTmT/S1A9A2g3aFOau5oRH4Lcief9j5aG0zgh/sxoZRZ6Mer4LC9vFrF8my8unjYi
	ED6D+6TEvn/Ju4Y8osM8HyvAcm4VL24ZK2NSeKS5KkhNxZGmh+UZMEg==
X-Received: by 2002:a05:6000:41ee:b0:487:71a:be5e with SMTP id
 ffacd0b85a97d-48871751e7emr3952817f8f.28.1790252488589; Thu, 24 Sep 2026
 05:21:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922144629.586997-1-claudiu.beznea@kernel.org> <20260922144629.586997-3-claudiu.beznea@kernel.org>
In-Reply-To: <20260922144629.586997-3-claudiu.beznea@kernel.org>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 24 Sep 2026 13:21:01 +0100
X-Gm-Features: AclHuK_X7dFqx5_PZTR1oHZdsVG_VtavdMBztYLyOGLheA-ut1aT-qqdUnVWM6M
Message-ID: <CA+V-a8tnpOF8gEjMcz8+sg7c2ec-uAncRK01NWcsL4A-TM-bSQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] PCI: rzg3s-host: Fix runtime PM handling in the
 NOIRQ suspend/resume phase
To: Claudiu Beznea <claudiu.beznea@kernel.org>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
	robh@kernel.org, bhelgaas@google.com, p.zabel@pengutronix.de, 
	claudiu.beznea@tuxon.dev, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 3:57=E2=80=AFPM Claudiu Beznea
<claudiu.beznea@kernel.org> wrote:
>
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> The runtime PM documentation states the following:
> - During system suspend, pm_runtime_get_noresume() is called for every
>   device right before executing the subsystem-level .prepare() callback
>   (in device_prepare()). In addition, the PM core disables runtime PM for
>   every device right before executing the subsystem-level .suspend_late()
>   callback (in device_suspend_late()).
> - During system resume, pm_runtime_enable() is called for every device
>   right after executing the subsystem-level .resume_early() callback (in
>   device_resume_early()), and pm_runtime_put() is called right after
>   executing the subsystem-level .complete() callback (in
>   device_complete()).
>
> The driver's .suspend_noirq() callback is invoked after .suspend_late(),
> while .resume_noirq() is invoked before .resume_early().
>
> If:
> - the device is not part of the wake-up path, and
> - its runtime PM status is not RPM_SUSPENDED,
> the generic power domain .suspend_noirq()/.resume_noirq() callbacks
> (genpd_suspend_noirq()/genpd_resume_noirq()) invoke the driver's
> .suspend_noirq()/.resume_noirq() callbacks and call
> genpd_stop_dev()/genpd_start_dev() before and after them, respectively.
>
> Calling genpd_stop_dev()/genpd_start_dev() allows devices whose power is
> controlled by generic power domains to be powered off and on during
> system suspend and resume, even though their runtime PM usage count does
> not reach zero.
>
> Since the runtime PM usage count is incremented in device_prepare() and
> decremented in device_complete(), runtime PM operations performed from
> the driver's .suspend_noirq()/.resume_noirq() callbacks are no-ops. The
> actual power transitions are handled by the generic power domain
> .suspend_noirq()/.resume_noirq() callbacks.
>
> Moreover, attempting to runtime resume a device while runtime PM is
> disabled may return -EACCES. This may cause system resume to fail when
> resuming after a failed Root Port reset, as described in a subsequent
> patch adding hot-plug support.
>
> Remove the runtime PM calls from the driver's
> .suspend_noirq()/.resume_noirq() callbacks and rely on the generic power
> domain callbacks to power the device off and on.
>
> Fixes: 7ef502fb35b2 ("PCI: Add Renesas RZ/G3S host controller driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v4:
> - simplified the comments in rzg3s_pcie_suspend_noirq()/rzg3s_pcie_resume=
_noirq()
>
> Changes in v3:
> - none, this patch is new
>
>  drivers/pci/controller/pcie-rzg3s-host.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/contr=
oller/pcie-rzg3s-host.c
> index e1105b1f2652..0ef49bb5ab1a 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> @@ -1961,19 +1961,18 @@ static int rzg3s_pcie_suspend_noirq(struct device=
 *dev)
>         if (ret)
>                 goto config_reinit;
>
> -       ret =3D pm_runtime_put_sync(dev);
> -       if (ret)
> -               goto power_resets_restore;
> +       /*
> +        * Since the power domain's genpd_suspend_noirq() will disable cl=
ocks,
> +        * there is no need to manually invoke runtime PM API here.
> +        */
>
>         ret =3D rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_RST_RSM_B=
, 0);
>         if (ret)
> -               goto rpm_resume;
> +               goto power_resets_restore;
>
>         return 0;
>
>         /* Restore the previous state if any error happens */
> -rpm_resume:
> -       pm_runtime_resume_and_get(dev);
>  power_resets_restore:
>         reset_control_bulk_deassert(data->num_power_resets,
>                                     host->power_resets);
> @@ -2011,13 +2010,14 @@ static int rzg3s_pcie_resume_noirq(struct device =
*dev)
>                         goto assert_rst_rsm_b;
>         }
>
> -       ret =3D pm_runtime_resume_and_get(dev);
> -       if (ret)
> -               goto assert_rst_rsm_b;
> +       /*
> +        * Since the power domain's genpd_resume_noirq() will enable cloc=
ks,
> +        * there is no need to manually invoke runtime PM API here.
> +        */
>
>         ret =3D rzg3s_pcie_power_resets_deassert(host);
>         if (ret)
> -               goto rpm_put;
> +               goto assert_rst_rsm_b;
>
>         ret =3D rzg3s_pcie_host_setup(host, rzg3s_pcie_msi_hw_setup,
>                                     rzg3s_pcie_msi_hw_teardown);
> @@ -2033,8 +2033,6 @@ static int rzg3s_pcie_resume_noirq(struct device *d=
ev)
>  assert_power_resets:
>         reset_control_bulk_assert(data->num_power_resets,
>                                   host->power_resets);
> -rpm_put:
> -       pm_runtime_put_sync(dev);
>  assert_rst_rsm_b:
>         rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_RST_RSM_B, 0);
>         return ret;
> --
> 2.43.0
>
>
