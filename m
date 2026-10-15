Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA38F3E0C7B;
	Thu, 15 Oct 2026 20:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792097602; cv=none; b=VKNI3FXMAigYtNTjJEVPqZ4A+XGO/MFcRnDwOF8I5euG9hrcV1mLsZNNc35vG7fo2En7YUXCtkJWoby272j7JWHYRgfNzX5ZQHUk1B0/8l0nIKAN/7YF35jd2cMUDU9J2vR3zs1ZnkZw2CGv75XZVzLn9Im0x9SRozHBhRkol6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792097602; c=relaxed/simple;
	bh=YfQQPy5+MOxkqE+FfiEMBzPHvjFlAZtpQKu1vGl9G4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FjLqSZ9eE74Aw9rN4eEZrUZsXtp8TJmmA3bDtCYExAPZF7CQJT27b3yHPtpwcMjkL/zU7Bzwboe0Jyq9a1f7ca1mr7Bj7FvedxK1VojQCLVnQhAnfdWrvBJbqpqFE6MryRmh7AgeFkJGctgmAATaP0pLRYCeujN8ieu5HNm9TX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUNo+W4x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUNo+W4x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4330D1F000C4;
	Thu, 15 Oct 2026 20:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792097599;
	bh=DgJhMXN5DzbvRdGl3zbFIawwZe9+pLSMJLF/xU/9aBg=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=MUNo+W4x9ntN4iUT6HDl5GBQzZEXYNePIVqHdk32XICteBVzAi4WwdC+NTmsNcLau
	 3L2GEx45Eh7E5C3hk3zgXZ9AjIMxzaP/5+T+N+EZFm/bUeXbusRHf2PertFSbt94vY
	 7lNa+tv+uunC4wNIywkh1UCntx9npQrYKi8XCNsnlq4YUUYj35lZ4Rs6kEV+g328+b
	 oiR+9Hef1WOr61nzp2YZP9elPnCUKiBF8Ih1ZWja5Vek8QN+Ut1cr8IaNV47Dbu2Ut
	 WL/eILLrK51q2N495yMNzyTLkOz3R/2ykxJ1eQlCyGneCmo2BzrGLysq02J6+I/lGU
	 HkxQ92LTt2hUQ==
Date: Thu, 15 Oct 2026 15:53:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keng-Yu Lin <keng-yu.lin@hpe.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Matthew Ruffell <matthew.ruffell@canonical.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, andy.liang@hpe.com, david.chang@hpe.com,
	s.collins@hpe.com, jenifer.golmitz@hpe.com,
	pravallika.kamma@hpe.com, zhen-dong.lai@hpe.com,
	zachary.pabor-ext@hpe.com, acelan.kao@canonical.com,
	michael.reed@canonical.com, desnesn@redhat.com, dlee@hpe.com
Subject: Re: [PATCH v3] PCI/PM: Restore BARs after powering up during
 enumeration
Message-ID: <20261015205318.GA1799241@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015020811.1132314-1-keng-yu.lin@hpe.com>

On Thu, Oct 15, 2026 at 10:08:11AM +0800, Keng-Yu Lin wrote:
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
> Fixes: 4d4c10f763d7 ("PCI: Explicitly put devices into D0 when initializing")
> Link: https://lore.kernel.org/r/CAJZ5v0ie2AvCbdv8-zkpYzHLcTwUPUj+=WWOQjDAPmSepSAQPg@mail.gmail.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Keng-Yu Lin <keng-yu.lin@hpe.com>

Applied to pci/pm for v7.4, thanks!

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
> v2: https://lore.kernel.org/r/20261012104645.975190-1-keng-yu.lin@hpe.com/
> 
>  drivers/pci/pci.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8cc6a89130b5..895969fe4520 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3255,7 +3255,15 @@ void pci_pm_init(struct pci_dev *dev)
>  	}
>  
>  poweron:
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
>  	pm_runtime_forbid(&dev->dev);
>  
>  	/*
> 
> base-commit: 7b63ef2d55f24519e7e9e5f4d15dbea03f126e40
> -- 
> 2.43.0
