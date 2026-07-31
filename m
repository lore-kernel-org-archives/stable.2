Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346154562B5;
	Fri, 31 Jul 2026 16:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785515067; cv=none; b=RtxOTEI2HyChANAa9FrxFBzapIqsJU7zkSdPo80v+ZuxcvD/Ef54tS+Ti4JvgZbjv9Zz2xt8MMkFFws1VReYzE3LvVKJoadiyYevYmaHAqA8RPI2pfQX0EMFtOPOrZ3IuwjOokzu0Z60AZRhN9BWRg69PxMrYlhJ4Yyd64bVzl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785515067; c=relaxed/simple;
	bh=jLy2oxYoq2BDoxhea619lXJyJFuuD2tinsJHp1GzKnE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=AgkOB3Ge2PXZu4hwsn7ETCobUoNmbGUdlZfaHgoFeRneZGoRBxgUqBRtDnnFEdsdwgGsTdwhvak8wHOckQFJEzHo8pHilJ0eqGLT0+sw9jNLmGxJbrt07ztBAsiSMhBH60oH7HQn0+nut1bsUC9tWg+LBElWAUs3Yn+Ffb75dcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dptk9Q8/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dptk9Q8/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84FFE1F00ACF;
	Fri, 31 Jul 2026 16:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785515065;
	bh=y1YM1FtXEXTem+Rp2vWEYmY6TR2drUxiW8KEqcpWJqQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=dptk9Q8/V7jZUR2QsFwSRGzaaqmmDzkq7swlrDVs/bbqmKW5Vimm5mmi5wzoPN9AV
	 /eeDWNAqUj9FAPZYxhehbk5XcNKpZbk5LW9A6ieKtUaxslcg0FEKUWE1eq5yvsXSeV
	 MxHsPs8Qvempbe5kZaqpQSQA9I0wHQz6Hgz8cT/Wo63wqk97eDW89spNIFlkcsKbPt
	 wX+A6sDl6JvyzUjg/7dUWZPOxduyP+B6Zzu7GECggJeDiq+CPD99Yx3oKaAItD9X4e
	 aKnDfUU3+Pmkk5ho9GJa8wv/Sw88jFCo/5DLeGWHf0AG8Lezp2qOpMmtMgrphjhZo3
	 oJK1DmDqH3qVQ==
Date: Fri, 31 Jul 2026 11:24:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: lizf@honeycomb.io,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
	amd-gfx@lists.freedesktop.org, Jon Nettleton <jon@solid-run.com>,
	Jon Nettleton <jon.nettleton@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Fix BAR resize for devices on a root bus
Message-ID: <20260731162424.GA1571989@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260712-pci-rebar-root-bus-v2-1-a1b9107a82dc@honeycomb.io>

[cc->to: Ilpo, I think we need your review/ack for this]

On Sun, Jul 12, 2026 at 02:49:43PM -0700, Liz Fong-Jones via B4 Relay wrote:
> From: Liz Fong-Jones <lizf@honeycomb.io>
> 
> pci_do_resource_release_and_resize() releases the device BARs that
> share a bridge window with the BAR being resized, but when the device
> sits directly on a root bus (pdev->bus->self == NULL) it then skips
> resource assignment entirely and returns success, leaving the BARs it
> just released unassigned (IORESOURCE_UNSET).
> 
> Skipping pbus_reassign_bridge_resources() is correct in that case --
> there is no bridge window to adjust -- but the device BARs still have
> to be reassigned. Before the BAR release was consolidated into the PCI
> core, this case worked for amdgpu because the driver released the BARs
> itself and then called pci_assign_unassigned_bus_resources()
> unconditionally after the resize, which assigns unassigned device BARs
> also on a root bus. Commit db92e3fef53e ("drm/amdgpu: Remove driver
> side BAR release before resize") removed that call, so nothing assigns
> the released BARs anymore.
> 
> This breaks amdgpu completely on the SolidRun HoneyComb LX2 (NXP
> LX2160A, arm64, ACPI), where the GPU endpoint is enumerated directly
> on the root bus of its segment (there is no root port device, so
> pdev->bus->self is NULL):

Maybe this is a tangent, but I'm curious about this topology.  Is this
running as a virtualized guest?  At the hardware level, a PCIe
endpoint must have a Root Port somewhere, even if it isn't visible to
the OS (as is often the case in virtualized guests).

>   amdgpu 0004:01:00.0: BAR 0 [mem 0xa400000000-0xa40fffffff 64bit pref]: releasing
>   amdgpu 0004:01:00.0: BAR 2 [mem 0xa410000000-0xa4101fffff 64bit pref]: releasing
>   amdgpu 0004:01:00.0: sw_init of IP block <gmc_v8_0> failed -19
>   amdgpu 0004:01:00.0: amdgpu_device_ip_init failed
>   amdgpu 0004:01:00.0: Fatal error during GPU init
> 
> No error is logged because the resize path reports success; amdgpu
> then finds BAR0 IORESOURCE_UNSET and bails out with -ENODEV.
> 
> Assign the released BARs directly from the root bus windows when there
> is no upstream bridge. On failure, roll back through the existing
> restore path exactly as in the bridged case.
> 
> The root bus path also had a locking bug that any fix here necessarily
> touches: the old "goto out" jumped to up_read(&pci_bus_sem) without a
> matching down_read() (as does the "goto restore" taken when
> pci_dev_res_add_to_list() fails in the release loop). Take pci_bus_sem
> before the BAR release loop so every path through the function holds
> it exactly once.
> 
> Fixes: 337b1b566db0 ("PCI: Fix restoring BARs on BAR resize rollback path")
> Cc: stable@vger.kernel.org
> Link: https://bugs.launchpad.net/ubuntu/+source/linux-hwe-7.0/+bug/2159596
> Assisted-by: Claude:claude-fable-5 checkpatch
> Assisted-by: Claude:claude-sonnet-5
> Signed-off-by: Liz Fong-Jones <lizf@honeycomb.io>
> ---
> #regzbot introduced: 337b1b566db0
> 
> Observed at runtime on Ubuntu's linux-hwe-7.0 (7.0.0-14, broken) vs
> linux-hwe-6.17 (working), but nothing here is distro-specific: Ubuntu
> carries this code unmodified, and the affected function is identical
> to current mainline. By source inspection the regression window is
> v6.18 (old code paths) to v6.19 (consolidation). Workaround for
> affected users: amdgpu.rebar=0.
> ---
> Changes in v2:
> - Add Assisted-by tags (missing from v1; required per
>   Documentation/process/coding-assistants.rst)
> - Add Link: to the corresponding Ubuntu bug report
> - Drop the "# v6.19+" annotation on Cc: stable; unnecessary noise
>   given the Fixes: tag already lets the stable team derive applicable
>   versions (per stable-kernel-rules.rst)
> - Link to v1: https://patch.msgid.link/20260705-pci-rebar-root-bus-v1-1-55df70cbdd88@honeycomb.io
> 
> To: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: regressions@lists.linux.dev
> Cc: amd-gfx@lists.freedesktop.org
> Cc: Jon Nettleton <jon@solid-run.com>
> Cc: Jon Nettleton <jon.nettleton@gmail.com>
> ---
>  drivers/pci/setup-bus.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index c0a949f2c995..9db1951f6e5c 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -2397,6 +2397,8 @@ int pci_do_resource_release_and_resize(struct pci_dev *pdev, int resno, int size
>  	if (ret)
>  		return ret;
>  
> +	down_read(&pci_bus_sem);
> +
>  	pci_dev_for_each_resource(pdev, r, i) {
>  		if (i >= PCI_BRIDGE_RESOURCES)
>  			break;
> @@ -2415,13 +2417,24 @@ int pci_do_resource_release_and_resize(struct pci_dev *pdev, int resno, int size
>  
>  	pci_resize_resource_set_size(pdev, resno, size);
>  
> -	if (!bus->self)
> -		goto out;
> +	if (bus->self) {

I think pci_upstream_bridge() would be better here.  Not that this
device will be a VF (where pci_upstream_bridge() makes a difference),
but just to be a little more generic.

> +		ret = pbus_reassign_bridge_resources(bus, res, &saved);
> +		if (ret)
> +			goto restore;
> +	} else {
> +		/*
> +		 * A device on a root bus has no bridge windows to adjust.
> +		 * Assign the BARs released above directly from the root bus
> +		 * windows.
> +		 */
> +		list_for_each_entry(dev_res, &saved, list) {
> +			i = pci_resource_num(pdev, dev_res->res);
>  
> -	down_read(&pci_bus_sem);
> -	ret = pbus_reassign_bridge_resources(bus, res, &saved);
> -	if (ret)
> -		goto restore;
> +			ret = pci_assign_resource(pdev, i);
> +			if (ret)
> +				goto restore;
> +		}
> +	}
>  
>  out:
>  	up_read(&pci_bus_sem);
> 
> ---
> base-commit: 7404ce51637231382873d0b55edabc2f3b841a9d
> change-id: 20260704-pci-rebar-root-bus-f3123fe10fc7
> 
> Best regards,
> --  
> Liz Fong-Jones <lizf@honeycomb.io>
> 
> 
