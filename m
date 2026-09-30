Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F333D75A0
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 19:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790798044; cv=none; b=DhFV6UDuDDFaCnU81o7B1nbkisvupDpMTeH6O+gyKbLfQ04y6tGA2bRldpmVJr6p33xJAx4mTRKh938EeSD0ByTJ4VmNmIeesiqbxfwIqAAO/x5kVLsgYuihZGg9RIKtAB4d8TbILfBF06ZotteWZ6zHxGRHuW2Q/X7ORE2aSVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790798044; c=relaxed/simple;
	bh=r4EueZ/kPSrqSNB4h3oVad4aRxPelxGBvgtsPYItrWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aPxkF7jsKydIqw8EACYPu/5Du0KoYIJm+iXvrVssON/FF7erIrfEEQaQk1wqQW9+qkrSlOv6fnEYQ2WczjOkw4zNEspoW9+IF4XJZE60k1KWMVsDNq+dA+jAsjV3uYsiYc+C0UPhK50KIu3iC9Tc/WtY/e20DerKejdBeafSdnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZgzpuYod; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZgzpuYod"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F741F00898
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 19:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790798041;
	bh=McrGr+mWNp/PQ7emF32ERE0RLMv5AFRRptelodwTEZI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ZgzpuYodpSk43oSsTxaO5RO5d37g78sCQcdO+5Pa+RYupBRPW7zlzl2I/GeDBGwdh
	 +vdj8OhuLKubqXQC/yP5Zc+FG1HU8pH19T2EWQfs2tEptQajpT9+xw6O73dQe3VSdB
	 RAqeWZL5vT8ogierP8gdTuYRlQ///mStgXWKJ87byjMr59QaQgAZOEyh5HtRd6RSmq
	 YJce2sT/Ob/tzjxUH4hSLZtzKbVwbYpuPsxXg6lmDLmayd1BJyzhmSgPzfJM5Eo05B
	 xPXfROtapNFyttr5m74jJL5Oz3Ukk/kpb1p0PkwSqUhzPCVIaJngSOprREYB26khYG
	 eyHs75R3O78xg==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b8b3c8c4bbso92630e87.0
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 12:54:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzGxgsAUff/c2bTmEAwPdylCu1qPESu0qAIUIPqJXFkVmI9Aa1HaPb7q/Bx0HC5IW1xi7dbKek=@vger.kernel.org
X-Gm-Message-State: AFq9FYJlapOT1GJsZyqV7d5Vma0LJeqFKowaZm19RaXuAlUOfrpdKiJK
	/D1gJ99RDuUaFFC9AsIwDRtBQPY5pJWa1ffkbxvDF+1uLBwAFfeYIhG3ATw1stfCsXcM3mtaEzS
	rJ7iG/u2FLtK/7yM+royQn8ZKVVU2mAA=
X-Received: by 2002:a05:6512:1287:b0:5b8:c311:88e8 with SMTP id
 2adb3069b0e04-5ba433ef5e1mr212198e87.26.1790798039650; Wed, 30 Sep 2026
 12:53:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929151845.23980-1-fanwu01@zju.edu.cn>
In-Reply-To: <20260929151845.23980-1-fanwu01@zju.edu.cn>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 30 Sep 2026 21:52:15 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g4qK+ZAgscqYvQ5Vw6wUZ97pV7LazfzoP_j1s5K3ghfg@mail.gmail.com>
X-Gm-Features: AclHuK-BfvAK2h54ZMHElErScypLwiqeZJ4pwOGvQC30PUhLeIskAhsM4LnPiQY
Message-ID: <CAJZ5v0g4qK+ZAgscqYvQ5Vw6wUZ97pV7LazfzoP_j1s5K3ghfg@mail.gmail.com>
Subject: Re: [PATCH v2] thermal: intel: int340x: Fix potential use-after-free
 in proc_thermal_pci
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	srinivas.pandruvada@linux.intel.com, stable@vger.kernel.org, songl@zju.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 5:19=E2=80=AFPM Fan Wu <fanwu01@zju.edu.cn> wrote:
>
> proc_thermal_pci_remove() cancels pci_info->work before disabling the
> interrupt sources that schedule it. A threshold IRQ which arrives after
> the cancel but before the THRES_0 and INT_ENABLE_0 MMIO mask can
> reschedule the work, which may then run after devm cleanup has freed
> pci_info and dereference pci_info->tzone and proc_priv->mmio_base. The
> shared IRQ is never freed in remove(), which widens the window, and the
> probe error paths never cancel the work either.
>
> Fix this by cutting off the producers before draining: mask the
> threshold interrupt, remove the sysfs interfaces which can re-enable
> the power floor and workload type hint notifications, disable the
> secondary interrupt sources, including both workload type hint
> prediction bits, free the IRQs, and only then cancel the delayed work
> and unregister the thermal zone, with a final mask afterwards. The
> probe error paths unwind in the same order, and partial MSI setup
> failures go through the same teardown instead of freeing the requested
> IRQs inside setup_msi().
>
> The workload type hint helper removes its sysfs group before disabling
> its interrupt sources and now clears both prediction bits. It is shared
> with the legacy int340x driver, so the same gap is fixed there too.
>
> This issue was found by an in-house static analysis tool.
>
> Fixes: acd65d5d1cf4 ("thermal/drivers/int340x/processor_thermal: Add PCI =
MMIO based thermal driver")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6
> Co-developed-by: Song Li <songl@zju.edu.cn>
> Signed-off-by: Song Li <songl@zju.edu.cn>
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>

It would be good to say what happened between v1 and v2, like in this
patch, for example:

https://lore.kernel.org/all/20260930-acpi_spcr-v4-1-ab649aa1f09c@posteo.de/

Also Sashiko still complains about this version:

https://sashiko.dev/#/patchset/20260929151845.23980-1-fanwu01%40zju.edu.cn

so please let me know what you think about its findings.

> ---
>  .../processor_thermal_device.c                | 13 +++++
>  .../processor_thermal_device.h                |  1 +
>  .../processor_thermal_device_pci.c            | 57 +++++++++++++++----
>  .../processor_thermal_wt_hint.c               | 22 ++++---
>  4 files changed, 74 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_devi=
ce.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> index f80dbe2ca7e4..a8d355044972 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> @@ -335,6 +335,19 @@ void proc_thermal_remove(struct proc_thermal_device =
*proc_priv)
>  }
>  EXPORT_SYMBOL_GPL(proc_thermal_remove);
>
> +/**
> + * proc_thermal_power_limits_attr_remove() - remove the "power_limits" g=
roup
> + * @dev:       Device passed to proc_thermal_add().
> + *
> + * Remove the group before the power floor interrupt source is disabled:
> + * a concurrent store to power_floor_enable could re-enable it.
> + */
> +void proc_thermal_power_limits_attr_remove(struct device *dev)
> +{
> +       sysfs_remove_group(&dev->kobj, &power_limit_attribute_group);
> +}
> +EXPORT_SYMBOL_GPL(proc_thermal_power_limits_attr_remove);
> +
>  static int tcc_offset_save =3D -1;
>
>  int proc_thermal_suspend(struct device *dev)
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_devi=
ce.h b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
> index b79937a386ec..918adc6d8712 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
> @@ -116,6 +116,7 @@ int processor_thermal_mbox_interrupt_config(struct pc=
i_dev *pdev, bool enable, i
>                                             int time_window);
>  int proc_thermal_add(struct device *dev, struct proc_thermal_device *pri=
v);
>  void proc_thermal_remove(struct proc_thermal_device *proc_priv);
> +void proc_thermal_power_limits_attr_remove(struct device *dev);
>
>  int proc_thermal_wt_hint_add(struct pci_dev *pdev, struct proc_thermal_d=
evice *proc_priv);
>  void proc_thermal_wt_hint_remove(struct pci_dev *pdev);
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_devi=
ce_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_p=
ci.c
> index c5131423ec9b..28c5cf53a6f5 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.=
c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.=
c
> @@ -302,6 +302,12 @@ static int proc_thermal_setup_msi(struct pci_dev *pd=
ev, struct proc_thermal_pci
>         dev_info(&pdev->dev, "msi enabled:%d msix enabled:%d\n", pdev->ms=
i_enabled,
>                  pdev->msix_enabled);
>
> +       /*
> +        * Set MSI mode once the vectors are allocated, so a failure belo=
w
> +        * unwinds through the caller's masked teardown path.
> +        */
> +       msi_irq =3D true;
> +
>         for (i =3D 0; i < count; i++) {
>                 irq =3D  pci_irq_vector(pdev, i);
>
> @@ -309,19 +315,12 @@ static int proc_thermal_setup_msi(struct pci_dev *p=
dev, struct proc_thermal_pci
>                                                 proc_thermal_irq_thread_h=
andler,
>                                                 0, KBUILD_MODNAME, pci_in=
fo);
>                 if (ret)
> -                       goto err_free_msi_vectors;
> +                       return ret;
>
>                 proc_thermal_msi_map[i] =3D irq;
>         }
>
> -       msi_irq =3D true;
> -
>         return 0;
> -
> -err_free_msi_vectors:
> -       proc_thermal_free_msi(pdev, pci_info);
> -
> -       return ret;
>  }
>
>  static int proc_thermal_pci_probe(struct pci_dev *pdev, const struct pci=
_device_id *id)
> @@ -383,8 +382,12 @@ static int proc_thermal_pci_probe(struct pci_dev *pd=
ev, const struct pci_device_
>
>         if (use_msi) {
>                 ret =3D proc_thermal_setup_msi(pdev, pci_info);
> -               if (ret)
> +               if (ret) {
> +                       /* Full teardown: at least one IRQ was requested.=
 */
> +                       if (msi_irq)
> +                               goto err_free_vectors;
>                         goto err_ret_tzone;
> +               }
>         } else {
>                 irq_flag =3D IRQF_SHARED;
>                 irq =3D pdev->irq;
> @@ -403,8 +406,24 @@ static int proc_thermal_pci_probe(struct pci_dev *pd=
ev, const struct pci_device_
>         return 0;
>
>  err_free_vectors:
> +       proc_thermal_mmio_write(pci_info, PROC_THERMAL_MMIO_THRES_0, 0);
> +       proc_thermal_mmio_write(pci_info, PROC_THERMAL_MMIO_INT_ENABLE_0,=
 0);
> +       if (!pci_info->no_legacy)
> +               proc_thermal_power_limits_attr_remove(&pdev->dev);
> +       proc_thermal_mmio_remove(pdev, proc_priv);
>         if (msi_irq)
>                 proc_thermal_free_msi(pdev, pci_info);
> +       else
> +               devm_free_irq(&pdev->dev, pdev->irq, pci_info);
> +       /* Cancel after the IRQs are freed, or the handler may reschedule=
 it. */
> +       cancel_delayed_work_sync(&pci_info->work);
> +       thermal_zone_device_unregister(pci_info->tzone);
> +       proc_thermal_mmio_write(pci_info, PROC_THERMAL_MMIO_THRES_0, 0);
> +       proc_thermal_mmio_write(pci_info, PROC_THERMAL_MMIO_INT_ENABLE_0,=
 0);
> +       if (!pci_info->no_legacy)
> +               proc_thermal_remove(proc_priv);
> +
> +       return ret;
>  err_ret_tzone:
>         thermal_zone_device_unregister(pci_info->tzone);
>  err_del_legacy:
> @@ -420,16 +439,30 @@ static void proc_thermal_pci_remove(struct pci_dev =
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
> +       /* The group must go first: a store could re-enable the source. *=
/
> +       if (!pci_info->no_legacy)
> +               proc_thermal_power_limits_attr_remove(&pdev->dev);
> +
> +       /* Secondary sources must be off before the IRQs are freed. */
> +       proc_thermal_mmio_remove(pdev, pci_info->proc_priv);
> +
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
> -       proc_thermal_mmio_remove(pdev, pci_info->proc_priv);
> +
> +       /* The work function and trip updates can re-enable the interrupt=
. */
> +       proc_thermal_mmio_write(pci_info, PROC_THERMAL_MMIO_THRES_0, 0);
> +       proc_thermal_mmio_write(pci_info, PROC_THERMAL_MMIO_INT_ENABLE_0,=
 0);
> +
>         if (!pci_info->no_legacy)
>                 proc_thermal_remove(proc_priv);
>  }
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_wt_h=
int.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_wt_hint.c
> index f8c33e8e5b7a..3e70f66dae8c 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_wt_hint.c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_wt_hint.c
> @@ -278,17 +278,25 @@ EXPORT_SYMBOL_NS_GPL(proc_thermal_wt_hint_add, "INT=
340X_THERMAL");
>
>  void proc_thermal_wt_hint_remove(struct pci_dev *pdev)
>  {
> -       mutex_lock(&wt_lock);
> -       if (wt_enable)
> -               processor_thermal_mbox_interrupt_config(pdev, false,
> -                                                       SOC_WT_PREDICTION=
_INT_ENABLE_BIT,
> -                                                       0);
> -       mutex_unlock(&wt_lock);
> -
> +       /* Group removal waits for active stores, so remove it first. */
>         if (workload_hint_created)
>                 sysfs_remove_group(&pdev->dev.kobj, &workload_hint_attrib=
ute_group);
>
>         workload_hint_created =3D false;
> +
> +       mutex_lock(&wt_lock);
> +
> +       /* Disable both bits: the slow prediction bit was never cleared b=
efore. */
> +       processor_thermal_mbox_interrupt_config(pdev, false,
> +                                               SOC_WT_PREDICTION_INT_ENA=
BLE_BIT,
> +                                               0);
> +       processor_thermal_mbox_interrupt_config(pdev, false,
> +                                               SOC_WT_SLOW_PREDICTION_IN=
T_ENABLE_BIT,
> +                                               0);
> +       wt_enable =3D false;
> +       wt_slow_enable =3D false;
> +
> +       mutex_unlock(&wt_lock);
>  }
>  EXPORT_SYMBOL_NS_GPL(proc_thermal_wt_hint_remove, "INT340X_THERMAL");
>
>
