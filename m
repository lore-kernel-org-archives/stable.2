Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12A340B10C
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 11:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791804984; cv=none; b=P0MpVePd5SLZ0U5E02IzukaL9AmXpwkjyeIWiLr1ctkyOzLEmMQ7oy8h3W9dJl8dgT/b0q76vLzRapaodBv5nqLKT/xnAWJf6SMFKi9vJYaPifrlQGu77KVj+vHNVZ6DSjfE/YL9F2QXt74yioGgdpDAtr7X1uPsoc1eoO5L2yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791804984; c=relaxed/simple;
	bh=FjmnLFlfVj86Z4Lsk90TGlztgG6qCa0yTtWjTAvBckg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A50eXH+hN9+DZgQgyEhYJibr04K8yLY9syA9VZTSRIDLHzwbtH2qCwBYQOIBuNzfvrTSgUS6DHL/g038j8jOxAOzWZI6rnABFf34jrQ/FauVqajmqB7SzOlMrlXcH6FiRefX5eje8AV8vA++lJIbDWO6Zebhd6LZVqUl1U/W6JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kAiFJ275; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kAiFJ275"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80B41F008A7
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 11:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791804982;
	bh=ky47BzJ//yKIcUY2PnOFYEc1XjY4/LJ0O9+7vqs3eic=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=kAiFJ275iQlKj/focLD/sUso6BSO7tjIuitoVCaDDHZ8kO5DgcHFnwqnwZ0AoQLpc
	 PsWRuXwlfh3KvN5X29TmNPgGNN3blV21ra1yRTlqaLnS3L2k7y8NPU3G/xCbdGE/8Q
	 HpIULSU9vFj7rbqVoMaoMr6cbSaxZem0uFro5y+nqMih6Sa3KyoWI/MX86q+tOQJfV
	 Hz/9InoUrFxRXms0HvMvSwBZnQVbt8Y7Ta8bAXrAUanYKYjaJ8wf41GBXOIn9MrQ4V
	 W2cLvqlmjN/kvLe87GjZH8MTY96oxqcNGFsVnvje4ke9Z98t/o4xd9YBpLFkdYDvZb
	 +A81bukWrnqEA==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5bc18f54abbso138896e87.1
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 04:36:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxGUx8vhQ9lYZ/h01P4rr2LmWlsp+Czl0+Wx2LGQpWG+/TPEFRfrKv4jXGZN8BMlzmRWQ6RpCE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIRLYqaH1sM4TVBuQ6qEHmp5iIuywGSvRvWJr6oDFla2egE4ksO
	xfXAQOjL6WfgxJ5s6mtkR9UVogBz6lGJ/5VBo54Aln7hhW9ahISY8RLlBHYu9GPvLQGIygmwSbm
	uZD8YVCuB3G1GKfHeybZcpNIjVD9Ux3k=
X-Received: by 2002:a05:6512:3047:b0:5b8:f564:16f9 with SMTP id
 2adb3069b0e04-5bcde6b8e70mr3320947e87.19.1791804980924; Mon, 12 Oct 2026
 04:36:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012104645.975190-1-keng-yu.lin@hpe.com>
In-Reply-To: <20261012104645.975190-1-keng-yu.lin@hpe.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 12 Oct 2026 13:34:15 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iGhqaF1m-Vc2xdXQXj_BxPFFWCBTP=Ypg_gWQEqWkNfg@mail.gmail.com>
X-Gm-Features: AclHuK8-y1dZbNQ0Rqfa3EbBgnELKusG9hIe29WvVNPE4Ch78O9H6Nl3kpfHVzQ
Message-ID: <CAJZ5v0iGhqaF1m-Vc2xdXQXj_BxPFFWCBTP=Ypg_gWQEqWkNfg@mail.gmail.com>
Subject: Re: [PATCH v2] PCI/PM: Restore BARs after powering up during enumeration
To: Keng-Yu Lin <keng-yu.lin@hpe.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Mario Limonciello <mario.limonciello@amd.com>, rafael@kernel.org, 
	Matthew Ruffell <matthew.ruffell@canonical.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, andy.liang@hpe.com, david.chang@hpe.com, 
	s.collins@hpe.com, jenifer.golmitz@hpe.com, pravallika.kamma@hpe.com, 
	zhen-dong.lai@hpe.com, zachary.pabor-ext@hpe.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 12:47=E2=80=AFPM Keng-Yu Lin <keng-yu.lin@hpe.com> =
wrote:
>
> Commit 4d4c10f763d7 ("PCI: Explicitly put devices into D0 when
> initializing") added pci_pm_power_up_and_verify_state() to pci_pm_init().
> The helper ignores pci_power_up()'s return value indicating that BARs
> need restoring.  Its resume callers restore saved configuration
> afterwards; pci_pm_init() does not.
>
> D3hot-to-D0 may reset a device and lose its BARs (PCI PM 1.2, sec 5.4.1).
> After enumeration powers it up, pci_enable_device() reads D0 and skips
> the full power-up path.  Previously, a device still in D3hot at enable
> time took that path, including BAR restoration.
>
> On AMD Venice SP7, two AMD xHCI controllers [1022:17d2] are in runtime
> D3hot with No_Soft_Reset clear before kdump.  Diagnostic reads on
> v7.3-rc6-37 show the following for 0000:01:00.4 in the crash kernel:
>
>                                    PMCSR      BAR0
>   before the platform power call   0003       f4100004
>   after the platform power call    0003       f4100004
>   after native D0 power-up         0000       00000004
>
> The upper BAR DWORD stays zero.  pci_power_up() returns 1, but the BAR
> address remains zero while dev->resource[0] still contains 0xf4100000.
> Without BAR restoration, the last console messages are around:
>
>   pci 0000:01:00.4: enabling device (0000 -> 0002)
>
> Restoring both controllers' BARs gives matching readbacks and allows
> kdump to save a vmcore and reboot.  An AMD Turin xHCI [1022:1557] shows
> the same BAR loss; restoring its BAR also allows kdump to complete.
>
> Use pci_set_full_power_state() in pci_pm_init() to power up the device
> and restore its BARs when needed.  It already checks the native power
> state before restoring and updates ASPM when link state is present.
> Leave pci_pm_power_up_and_verify_state() unchanged for the resume
> callers, which restore saved configuration afterwards.
>
> Read the initial power state first, as pci_enable_device_flags() does.

Is this really necessary or even useful before pci_set_full_power_state()?

pci_power_up() updates dev->current_state regardless of its previous
value AFAICS.

> Otherwise, PCI_UNKNOWN can request a BAR restore even for devices
> already in D0.  Keep the final pci_update_current_state() call so the
> final cached state still accounts for platform power and failed config
> reads.
>
> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> Fixes: 4d4c10f763d7 ("PCI: Explicitly put devices into D0 when initializi=
ng")
> Cc: stable@vger.kernel.org
> Signed-off-by: Keng-Yu Lin <keng-yu.lin@hpe.com>
> ---
>
> Changes in v2:
> - Use pci_set_full_power_state() in pci_pm_init(), following Mario's
>   suggestion to reuse the existing BAR restore code.
> - Leave the shared resume helper and its interface unchanged.
> - Keep the initial state readback and the final platform-aware refresh.
>
> Unlike v1, BAR restoration uses the full helper's native PMCSR check.
> It also updates ASPM when link state exists.
>
> Tested v2 with kdump on both systems.  Normal boots made no BAR writes
> from this path.  The crash kernels wrote only the cleared xHCI BARs:
> two on Venice SP7 and one on Turin.  All readbacks matched.  kdump saved
> 2.53 GB and 1.10 GB vmcores respectively before rebooting.
>
> v1: https://lore.kernel.org/r/20261008133708.947908-1-keng-yu.lin@hpe.com=
/
> Review: https://lore.kernel.org/r/04f5463b-f123-4079-9286-06a241976d3a@am=
d.com/
>
>  drivers/pci/pci.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8cc6a89130b5..d3a5871e1b36 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3255,7 +3255,9 @@ void pci_pm_init(struct pci_dev *dev)
>         }
>
>  poweron:
> -       pci_pm_power_up_and_verify_state(dev);
> +       pci_update_current_state(dev, dev->current_state);
> +       pci_set_full_power_state(dev, false);
> +       pci_update_current_state(dev, PCI_D0);
>         pm_runtime_forbid(&dev->dev);
>
>         /*
>
> base-commit: 7b63ef2d55f24519e7e9e5f4d15dbea03f126e40
> --
> 2.43.0
