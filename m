Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E724EA398
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 20:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790367135; cv=none; b=tmLqTmUg6WvHIp/m7/lGCDna3bnquDEHozLkS5TgUQeH4QVYHs7NPzn4k8pHYHQRMMNAJMl3S97gn+7BvW+ZQd8LiqvspAqxI5Jdri18sm544euJQteVdlfrvlo/qUzA7tK54z+aSk3hjRiCU+8AKacneU+lLRE+Y3QEVajr5NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790367135; c=relaxed/simple;
	bh=002S8vnOMFAFJ6nMl4iWnh77cSjc+g9V5FRVgu3Kd9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dHsNkFOHZghcy9DCm9NXoYKiEvW22PbcKZPn+7qlD+yzVL97HxOlcNkINk0skAj9dWVpFnxlpzJhIU6SmEJHeWrZE9suZaczUsy8unNYo356SmDVqunr8twYsffkcqvZ4RteZtajwIy52fqbe78w0hQvMXxZEVSym7Z3An65yEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P43pVqON; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P43pVqON"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEBA31F0089E
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 20:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790367126;
	bh=NN+opJ6O2i01W0leRwrhsq0wiHd+Q/Ia/9/Q0jKm2jo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=P43pVqON16RdSxxedGDaoYJRXM0lPKYOXPyFcPO6QGJ7o5qjzmFPr0VwvOOveyt2X
	 zR4oF8a36+p76I2Lqf5k2JR+9TsEP3AzLYb7aEGU0UTf0syDHHm+HDyCcROptndioo
	 faiWzEGv7C3PSA3m7IoRJbN7txH9OPm0unPs+JX+s3zkhnLkz0TTQdaMhRLAcblzvm
	 sOewHWYQ5dMB/SkLg8Lxo+pmrrkhscHh00vCpQ7oNVxI8eU9TmIkZCiG9228jDt0YQ
	 Dd3vcAw+UTPz8QwGMLFpg00bNlj+cv1TqcxvwQ+jBBQLjooytQ7nyROmMwp3r5UZ1D
	 kl6d5+0bgIawA==
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a5b2864f1cso10815871fa.3
        for <stable@vger.kernel.org>; Fri, 25 Sep 2026 13:12:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwmO9Vtyz8NV+QAzrfJ92DPTLQdCqWpKGVbRX6wD201m7ztxrygsQPnG1x6mkCGPsZCIDBNg3g=@vger.kernel.org
X-Gm-Message-State: AFuF++ntcqz7qPV7AoYJLDPpiumlR0SQdQieQkQMUDdQqqsLtzdKGBiO
	kqVymdJ9GAR7deeZG6qCJ1GmvUTcQRH25bkjR70M0bYkZ/IsV1YepEPF0WCpnWOCFZifP55/0nm
	n4pLhHY70uoW7ajknusnRRXtNBuaiXz0=
X-Received: by 2002:a05:6512:10cf:b0:5b6:1a7c:fd82 with SMTP id
 2adb3069b0e04-5b8df0d7b78mr2515060e87.40.1790367125182; Fri, 25 Sep 2026
 13:12:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923072730.487900-1-fanwu01@zju.edu.cn>
In-Reply-To: <20260923072730.487900-1-fanwu01@zju.edu.cn>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 25 Sep 2026 22:10:26 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i6W1QX97vuNvenqQ3QDv-fzStCff3LtyJTXWnheTCRSQ@mail.gmail.com>
X-Gm-Features: AclHuK-Wj2SzVKECYTkqnGCHaP1RVehr5DmH6bxqZpoFFJ9I8SsW-EPjTvEB7GM
Message-ID: <CAJZ5v0i6W1QX97vuNvenqQ3QDv-fzStCff3LtyJTXWnheTCRSQ@mail.gmail.com>
Subject: Re: [PATCH] thermal: intel: int340x: Fix use-after-free in proc_thermal_pci
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, stable@vger.kernel.org, 
	Song Li <songl@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 9:28=E2=80=AFAM Fan Wu <fanwu01@zju.edu.cn> wrote:
>
> proc_thermal_pci_remove() cancels pci_info->work before disabling the
> interrupt sources that schedule it. A threshold IRQ which arrives after
> the cancel but before the THRES_0 and INT_ENABLE_0 MMIO mask makes
> proc_thermal_irq_handler() reschedule the work, so
> proc_thermal_threshold_work_fn() runs after devm cleanup has freed
> pci_info and dereferences pci_info->tzone and proc_priv->mmio_base. The
> shared IRQ is never freed in remove(), which widens the window, and the
> probe error paths never cancel the work either.
>
> Fix this by cutting off the producers before draining: mask the THRES_0
> and INT_ENABLE_0 registers, free the MSI interrupts or the shared IRQ,
> and only then cancel the delayed work. The probe error paths cancel the
> work before the thermal zone is unregistered.
>
> The work function re-enables the INT_ENABLE_0 bit, but the IRQs are
> already freed when it is cancelled and THRES_0 stays cleared, so nothing
> can schedule the work again.
>
> This issue was found by an in-house static analysis tool.
>
> Fixes: acd65d5d1cf4 ("thermal/drivers/int340x/processor_thermal: Add PCI =
MMIO based thermal driver")
> Cc: stable@vger.kernel.org
> Co-developed-by: Song Li <songl@zju.edu.cn>
> Signed-off-by: Song Li <songl@zju.edu.cn>
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>

Please see Sashiko's feedback on this:

https://sashiko.dev/#/patchset/20260923072730.487900-1-fanwu01%40zju.edu.cn

and let me know what you think.

Thanks!

> ---
>  .../processor_thermal_device_pci.c                | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_devi=
ce_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_p=
ci.c
> index c693d93..1856e76 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.=
c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.=
c
> @@ -409,7 +409,10 @@ static int proc_thermal_pci_probe(struct pci_dev *pd=
ev, const struct pci_device_
>  err_free_vectors:
>         if (msi_irq)
>                 proc_thermal_free_msi(pdev, pci_info);
> +       else
> +               devm_free_irq(&pdev->dev, pdev->irq, pci_info);
>  err_ret_tzone:
> +       cancel_delayed_work_sync(&pci_info->work);
>         thermal_zone_device_unregister(pci_info->tzone);
>  err_del_legacy:
>         if (!pci_info->no_legacy)
> @@ -424,13 +427,16 @@ static void proc_thermal_pci_remove(struct pci_dev =
*pdev)
>         struct proc_thermal_device *proc_priv =3D pci_get_drvdata(pdev);
>         struct proc_thermal_pci *pci_info =3D proc_priv->priv_data;
>
> -       cancel_delayed_work_sync(&pci_info->work);
> -
>         proc_thermal_mmio_write(pci_info, PROC_THERMAL_MMIO_THRES_0, 0);
>         proc_thermal_mmio_write(pci_info, PROC_THERMAL_MMIO_INT_ENABLE_0,=
 0);
>
>         if (msi_irq)
>                 proc_thermal_free_msi(pdev, pci_info);
> +       else
> +               devm_free_irq(&pdev->dev, pdev->irq, pci_info);
> +
> +       /* Cancel after the IRQs are freed, or the handler may reschedule=
 it. */
> +       cancel_delayed_work_sync(&pci_info->work);
>
>         thermal_zone_device_unregister(pci_info->tzone);
>         proc_thermal_mmio_remove(pdev, pci_info->proc_priv);
>
