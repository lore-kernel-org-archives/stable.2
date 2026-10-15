Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4042F84F;
	Thu, 15 Oct 2026 02:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792032537; cv=none; b=IGtAB47PzLXrpXisIOjiWGHMmad2rN+uMur6d5pDAmTnt2xtFcaXGhCRXUMZYIH3XX1Zm4KqCz6EvA/zhp14G8qV908GOhytzuoWaZiEZewjKsQXy3hhEqiMlO1Q3ms/YAKeycxMHBSe5VV497zhtSIAePfQjDpjseWIplH45Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792032537; c=relaxed/simple;
	bh=MHWIw5WohRGeS+nCMpsnchI4dcpYDb/lTWnUMAzmK1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F2M9q+T5aXYdhxRPCwboBNbVo5n9/5tjHjdZzDtmBvE7jwfDm+NNxxrqylP/jnfQaZte4iiHUMyaAuqgZ58QZUCTUBsevUq/yZGddRU00ikm9n/q6451wJcW2VLiznT88yl+CYk4RRUtfmK4rCAwKjfZ2CJregW/hNWB7l19BlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wv9mXWl1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wv9mXWl1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A411F000C4;
	Thu, 15 Oct 2026 02:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792032536;
	bh=46AFgzVmY97B2lLtRfutmz9zdCYQ1/ffN1AhtsIbhMA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Wv9mXWl1i4jT1pmOhcnIXDncu7VWS7vcZa4chM97Sqmi7vAhG86yAJbyIb8Eg6/DJ
	 Ze8lTvigx5dweFj4uG+28gvEzbrru7GrOwt9ViUqCI4b/DSDQkqcqZdp5NmLRmU8Qd
	 mVO6btWaAd75g8Fq7IKF5opwrYgSi864ThO+f1T3gekM0GIAfSYoMELyPvCEMIGzO3
	 c971nKuEeBKsc7HAs79VDBI//op2m74EPBLJm6lOfj08PX83Hmobt+MBT0SgdHCkR9
	 mZWRBhF+QUuYRv68nbkROtRIPQyZNXAVIJ/bYghMpDc0dKOYAFznN+/+E2Rxi4NuO7
	 ltLSaZulGGAjQ==
Message-ID: <1dff27c5-76d6-4137-956f-8e7164cf1c64@kernel.org>
Date: Wed, 14 Oct 2026 21:48:51 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI/PM: Restore BARs after powering up during
 enumeration
To: Keng-Yu Lin <keng-yu.lin@hpe.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Matthew Ruffell <matthew.ruffell@canonical.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, andy.liang@hpe.com,
 david.chang@hpe.com, s.collins@hpe.com, jenifer.golmitz@hpe.com,
 pravallika.kamma@hpe.com, zhen-dong.lai@hpe.com, zachary.pabor-ext@hpe.com,
 acelan.kao@canonical.com, michael.reed@canonical.com, desnesn@redhat.com,
 dlee@hpe.com
References: <20261015020811.1132314-1-keng-yu.lin@hpe.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20261015020811.1132314-1-keng-yu.lin@hpe.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/14/26 21:08, Keng-Yu Lin wrote:
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
>                                     PMCSR      BAR0
>    before the platform power call   0003       f4100004
>    after the platform power call    0003       f4100004
>    after native D0 power-up         0000       00000004
> 
> The upper BAR DWORD stays zero. pci_power_up() returns 1, but the BAR
> address remains zero while dev->resource[0] still contains 0xf4100000.
> Without BAR restoration, the crash kernel hangs during boot. The
> last console output includes:
> 
>    pci 0000:01:00.4: enabling device (0000 -> 0002)
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
> Fixes: 4d4c10f763d7 ("PCI: Explicitly put devices into D0 when initializing")
> Link: https://lore.kernel.org/r/CAJZ5v0ie2AvCbdv8-zkpYzHLcTwUPUj+=WWOQjDAPmSepSAQPg@mail.gmail.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Keng-Yu Lin <keng-yu.lin@hpe.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>> ---
> 
> Changes in v3:
> - Use Rafael's sequence: sync only the platform state for devices
>    already in D0, and use pci_set_full_power_state() otherwise.
> - The D0 path no longer runs the full helper's ASPM update.
> 
> Tested with diagnostic prints on AMD Venice SP7 and Turin. Normal
> boots made no BAR writes from this path. The crash kernels restored
> only the cleared xHCI BARs (two on Venice, one on Turin), with matching
> readbacks. Both systems saved a vmcore and rebooted.
> 
> v2: https://lore.kernel.org/r/20261012104645.975190-1-keng-yu.lin@hpe.com/
> 
>   drivers/pci/pci.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8cc6a89130b5..895969fe4520 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3255,7 +3255,15 @@ void pci_pm_init(struct pci_dev *dev)
>   	}
>   
>   poweron:
> -	pci_pm_power_up_and_verify_state(dev);
> +	pci_update_current_state(dev, PCI_UNKNOWN);
> +	if (dev->current_state == PCI_D0) {
> +		/* No need to do a full power-up, just sync-up the platform state. */
> +		platform_pci_set_power_state(dev, PCI_D0);
> +	} else {
> +		/* Power up the device and restore BARs if necessary. */
> +		pci_set_full_power_state(dev, false);
> +	}
> +	pci_update_current_state(dev, PCI_D0);
>   	pm_runtime_forbid(&dev->dev);
>   
>   	/*
> 
> base-commit: 7b63ef2d55f24519e7e9e5f4d15dbea03f126e40

