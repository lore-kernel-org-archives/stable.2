Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB0C49C4C7
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 14:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792073299; cv=none; b=gFmNsbaS2vcBJeTRhy+G88Vn4vODq5dBl8mvJotFimSli0/MuI/7FAYWpas5LqoO/SeZsaePGhi0gYXRrFOvFu0HxOozMkmZV3vpTBRACEqhC44KoxFiciJbmwW8tedhJfT9YQJlferJscbntf48Y4O/t/Gzl4K6ToIjAB1Sbqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792073299; c=relaxed/simple;
	bh=ojMoOR8oUU+8xt/k9Y38b1NdawZsmiQiEKoJb2Ez4Kw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UO2RhqP8PTId0HPLH90j8ltv5hSIqTrR4uqy18KwKM3itGKtRSAnOkJZQ6JMrkTe+6CGjijWHy86padBXl9aRuyFyHbifTiK6dwIlWFXSvWJIUNNqT2nns/a3e6ADSByg6Co8fGsFHwKHhrD4RU2Eauy22JMeiaYVsmMZZrhIcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHIwQwms; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHIwQwms"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A22CF1F000C7
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 14:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792073298;
	bh=A3bj0UZ1aUBftNTOifFwWEMQ6/RGn/aZjo6guTib8XI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=XHIwQwmslI5/dCOJWOvu1RDXzB9iJWbNgjylijQPnGB7MEDdfpu4hCPROw/EwTQGG
	 zBbjt7+nCZHu57gdDSfyROj5JhuXoP/ru+39/SMOT7m3ehSWirJlMrwLfzxmChMDiE
	 owWSVTKzhtXQWOnk/UA8MEdkH8Zs+iP+DX3xlhu4I56cpOt6GtAG3LsKsRqR+fwJd5
	 MCXlZSzNOir6Z/SJQ0ar0pI63Ly7xe4g36yoqCGQSUiyxcO2ANjv/Z5k5NeMemV+HY
	 fD2EELnzGaffzxUSiieCLw7Rn31GbWLo8wRZN00O9/lVL4wyE2HNqsoCQe7ZUpYnza
	 8EH4Vi3OFszqw==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5bb7c6980f1so4288796e87.2
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 07:08:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzM547gnruzD7NrJtZBlxbrdzcgxkeF3twrifzt+ACb7xPjN6LqEQ+oB9LgpQbRdbHep2f/vNo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLATJuIE55ATJHfLCqhw8KZMMzL6EvI0jeUXyn69BhV4POvT6kC
	DIEKEPgub2+Lbhj5FSX6lzCzpdy0cq8xp1IKcLDoJjvZ5+QP5r8IBV/f1GLVTP5q0WW0Zp5toDv
	x683v5sPhCMq7Nf7FpPWsC2IJtMl6mD8=
X-Received: by 2002:a05:6512:1296:b0:5b8:bc5e:d118 with SMTP id
 2adb3069b0e04-5bcde8d85c3mr6833272e87.66.1792073297020; Thu, 15 Oct 2026
 07:08:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015020811.1132314-1-keng-yu.lin@hpe.com>
In-Reply-To: <20261015020811.1132314-1-keng-yu.lin@hpe.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 15 Oct 2026 16:05:44 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iYieKPAQTDcr+g6o+JHz+kMRqYYmakeBsyn-BxtxQcvw@mail.gmail.com>
X-Gm-Features: AclHuK_PKJRxbQlAyAIZYFksh4eHiHwbFXfpckaLOSJc8M78WLJ7k21R-50Fh_w
Message-ID: <CAJZ5v0iYieKPAQTDcr+g6o+JHz+kMRqYYmakeBsyn-BxtxQcvw@mail.gmail.com>
Subject: Re: [PATCH v3] PCI/PM: Restore BARs after powering up during enumeration
To: Keng-Yu Lin <keng-yu.lin@hpe.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Mario Limonciello <mario.limonciello@amd.com>, Matthew Ruffell <matthew.ruffell@canonical.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, andy.liang@hpe.com, david.chang@hpe.com, 
	s.collins@hpe.com, jenifer.golmitz@hpe.com, pravallika.kamma@hpe.com, 
	zhen-dong.lai@hpe.com, zachary.pabor-ext@hpe.com, acelan.kao@canonical.com, 
	michael.reed@canonical.com, desnesn@redhat.com, dlee@hpe.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 4:08=E2=80=AFAM Keng-Yu Lin <keng-yu.lin@hpe.com> w=
rote:
>
> Commit 4d4c10f763d7 ("PCI: Explicitly put devices into D0 when
> initializing") added pci_pm_power_up_and_verify_state() to pci_pm_init().
> The helper ignores pci_power_up()'s return value indicating that BARs
> need restoring. Its resume callers restore saved configuration
> afterwards; pci_pm_init() does not.
>
> D3hot-to-D0 may reset a device and lose its BARs (PCI PM 1.2, sec 5.4.1).
> After enumeration powers it up, pci_enable_device() reads D0 and skips
> the full power-up path. Previously, a device still in D3hot at enable
> time took that path, including BAR restoration.
>
> On AMD Venice SP7, two AMD xHCI controllers [1022:17d2] are in runtime
> D3hot with No_Soft_Reset clear before kdump. Diagnostic reads on
> v7.3-rc6-37 show the following for 0000:01:00.4 in the crash kernel:
>
>                                    PMCSR      BAR0
>   before the platform power call   0003       f4100004
>   after the platform power call    0003       f4100004
>   after native D0 power-up         0000       00000004
>
> The upper BAR DWORD stays zero. pci_power_up() returns 1, but the BAR
> address remains zero while dev->resource[0] still contains 0xf4100000.
> Without BAR restoration, the crash kernel hangs during boot. The
> last console output includes:
>
>   pci 0000:01:00.4: enabling device (0000 -> 0002)
>
> Restoring both controllers' BARs gives matching readbacks and allows
> kdump to save a vmcore and reboot. An AMD Turin xHCI [1022:1557] shows
> the same BAR loss; restoring its BAR also allows kdump to complete.
>
> Read the initial power state first. Otherwise, pci_power_up() may
> request a BAR restore based on a cached PCI_UNKNOWN state, even
> when the device is already in D0.
>
> For devices already in D0, only synchronize the platform state so
> that ACPI calls such as _REG still run. For other states, use
> pci_set_full_power_state() to power up the device and restore BARs
> when needed.
>
> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
> Fixes: 4d4c10f763d7 ("PCI: Explicitly put devices into D0 when initializi=
ng")
> Link: https://lore.kernel.org/r/CAJZ5v0ie2AvCbdv8-zkpYzHLcTwUPUj+=3DWWOQj=
DAPmSepSAQPg@mail.gmail.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Keng-Yu Lin <keng-yu.lin@hpe.com>

Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
>
> Changes in v3:
> - Use Rafael's sequence: sync only the platform state for devices
>   already in D0, and use pci_set_full_power_state() otherwise.
> - The D0 path no longer runs the full helper's ASPM update.
>
> Tested with diagnostic prints on AMD Venice SP7 and Turin. Normal
> boots made no BAR writes from this path. The crash kernels restored
> only the cleared xHCI BARs (two on Venice, one on Turin), with matching
> readbacks. Both systems saved a vmcore and rebooted.
>
> v2: https://lore.kernel.org/r/20261012104645.975190-1-keng-yu.lin@hpe.com=
/
>
>  drivers/pci/pci.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8cc6a89130b5..895969fe4520 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3255,7 +3255,15 @@ void pci_pm_init(struct pci_dev *dev)
>         }
>
>  poweron:
> -       pci_pm_power_up_and_verify_state(dev);
> +       pci_update_current_state(dev, PCI_UNKNOWN);
> +       if (dev->current_state =3D=3D PCI_D0) {
> +               /* No need to do a full power-up, just sync-up the platfo=
rm state. */
> +               platform_pci_set_power_state(dev, PCI_D0);
> +       } else {
> +               /* Power up the device and restore BARs if necessary. */
> +               pci_set_full_power_state(dev, false);
> +       }
> +       pci_update_current_state(dev, PCI_D0);
>         pm_runtime_forbid(&dev->dev);
>
>         /*
>
> base-commit: 7b63ef2d55f24519e7e9e5f4d15dbea03f126e40
> --
> 2.43.0
