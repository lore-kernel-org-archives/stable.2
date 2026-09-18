Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7E95208DF;
	Fri, 18 Sep 2026 19:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789759709; cv=none; b=hIU7Vrh93OZMgPOaskW6h69kDjUlkzkJo2jJH2EV2xSJuxK4A+ZmHxNY/Z2ct6NWtfdbBYK1fYQU670MSseVr0C5LjbZNhlors6EGNFHVGJQdTvkqcp80+boRW0TIA2DXwfFv4pr8lYqfmhreFDyosCt/3JkpZqSE/eLXvQ8H9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789759709; c=relaxed/simple;
	bh=tw2Vyuwd4+Dh5gxZoHj/gJNqhm25qkl41kbImDVXZck=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KJdAdDVuYXjrUwTjbIXlifHUrRpOIE5VQKqtnPyOyrfU/uSgO0rba7SqLjZ9Kh9vxfOyJD0IpFVYIF3QMaS43GnMLMirR1q6z1DWpLusQKsLfDxp0l9T2gqDeP7+Ygr3kj6V5GlUkhLLh4DLdR8Jr349kXL1bquSu59BkwZ1v48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xvf9Vbeu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xvf9Vbeu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D99BB1F00898;
	Fri, 18 Sep 2026 19:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789759701;
	bh=vfQpgzL0yQfcKMep+p5Od+GqI+HCHPfznhvSO3/vutY=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=Xvf9VbeupeHL6KGvvHdN2PaAbMhDbiWGTlBP4AwduEIqaPXlc07HWgHs/m0pG866p
	 S9/4STpZuQc9pU890xPT/fNHiSO+Swb3mRDVGHxoH9wCZ0TchVr/uPeeT0pb8oZkpF
	 blHs+xCc1/awYUPoyn3kRrzqWFggqRhIJF2MkELIc7gtajn9ZRknWAPwx5owHfdT/I
	 BCrnChZyijlVFbNE32b74qXO3snhpGnTy/2/w7cm4BUuldv9NY2cwn5YCotki3ggAG
	 lcrA9nUdwquE7nK3nh3KRfYKCJaZpilEMGQ2kYv/2LhesE2SARxF5EJQoSS3Iz6gbW
	 nGpiVHooHfBQw==
Date: Fri, 18 Sep 2026 14:28:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Liz Fong-Jones <lizf@honeycomb.io>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev, amd-gfx@lists.freedesktop.org,
	Jon Nettleton <jon@solid-run.com>,
	Jon Nettleton <jon.nettleton@gmail.com>,
	Jacob Martin <jacob.martin@canonical.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	stable@vger.kernel.org
Subject: Re: [PATCH v6] PCI: Fix BAR resize for devices on a root bus
Message-ID: <20260918192819.GA1179462@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260918035633.566823-1-lizf@honeycomb.io>

On Fri, Sep 18, 2026 at 03:56:33AM +0000, Liz Fong-Jones wrote:
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
> This breaks amdgpu completely on the SolidRun HoneyComb LX2K (NXP
> LX2160A, arm64, ACPI), where the GPU endpoint is enumerated directly
> on the root bus of its segment (there is no root port device, so
> pdev->bus->self is NULL):
> 
>   amdgpu 0004:01:00.0: BAR 0 [mem 0xa400000000-0xa40fffffff 64bit pref]: releasing
>   amdgpu 0004:01:00.0: BAR 2 [mem 0xa410000000-0xa4101fffff 64bit pref]: releasing
>   amdgpu 0004:01:00.0: sw_init of IP block <gmc_v8_0> failed -19
>   amdgpu 0004:01:00.0: amdgpu_device_ip_init failed
>   amdgpu 0004:01:00.0: Fatal error during GPU init
> 
> No error is logged because the resize path reports success; amdgpu
> then finds BAR0 IORESOURCE_UNSET and bails out with -ENODEV.
> 
> When there is no upstream bridge, call pci_bus_assign_resources() on
> the root bus to place the BARs released above, using the same
> alignment-sorted algorithm as normal enumeration instead of a manual
> per-BAR loop. This also walks the rest of the hierarchy under the
> root bus, as pci_assign_unassigned_bus_resources() used to for amdgpu
> before commit db92e3fef53e ("drm/amdgpu: Remove driver side BAR
> release before resize") removed that call -- the core-side fix that
> commit asked for ("such a problem should be fixed inside
> pci_resize_resource() instead").
> 
> pci_bus_assign_resources() returns void, so failure is detected by
> checking whether the released BARs are still assigned afterward; if
> not, roll back as in the bridged case. This is stricter than the
> bridged path -- it fails on any unplaced resource, not just required
> ones -- since a root bus typically has one shared window, and failing
> loudly seemed better than leaving something silently unassigned.
> 
> The root bus path also had a locking bug that any fix here necessarily
> touches: the old "goto out" jumped to up_read(&pci_bus_sem) without a
> matching down_read() (as does the "goto restore" taken when
> pci_dev_res_add_to_list() fails in the release loop). Take pci_bus_sem
> before the BAR release loop so every path through the function holds
> it exactly once.
> 
> Use pci_upstream_bridge() rather than testing pdev->bus->self
> directly. The two are usually equivalent, but pci_upstream_bridge()
> is the canonical test -- pci_is_root_bus(), which it's built on,
> warns that bus->self == NULL doesn't necessarily mean a root bus
> (SR-IOV virtual buses from virtfn_add_bus() are the same).
> 
> Fixes: 337b1b566db0 ("PCI: Fix restoring BARs on BAR resize rollback path")
> Cc: stable@vger.kernel.org
> Link: https://bugs.launchpad.net/ubuntu/+source/linux-hwe-7.0/+bug/2159596
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Assisted-by: Claude:claude-fable-5 checkpatch
> Assisted-by: Claude:claude-sonnet-5
> Signed-off-by: Liz Fong-Jones <lizf@honeycomb.io>

Applied to pci/for-linus for v7.3, thank you!

> ---
> 
> Confirmed against v7.3-rc3: drivers/pci/setup-bus.c is unpatched
> there, pci_do_resource_release_and_resize() still returns without
> reassigning the released BARs when bus->self is NULL.
> 
> Tested on the real root-bus hardware this fixes (SolidRun HoneyComb
> LX2K): both a manual resize via the resource0_resize sysfs attribute
> (shrink to 256M then back to 4G, forcing the release+reassign path
> both directions) and amdgpu's own natural probe-time resize (with the
> amdgpu.rebar=0 workaround removed) succeed cleanly -- VRAM and BAR
> size match, no "Fatal error during GPU init", full IP block init.
> 
> Changes in v6:
> - Repost, confirmed still affects v7.3-rc3
> - Added real-hardware test confirmation (both a manual sysfs-triggered
>   resize and amdgpu's own natural probe-time resize)
> - Picked up Reviewed-by from Ilpo
> - Link to v5: https://patch.msgid.link/20260908-pci-rebar-root-bus-v5-1-a210f405ea81@honeycomb.io
> 
>  drivers/pci/setup-bus.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index e8c94aa1d3c12..ed16ef7c26fa7 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -2380,6 +2380,7 @@ int pci_do_resource_release_and_resize(struct pci_dev *pdev, int resno, int size
>  	struct resource *res = pci_resource_n(pdev, resno);
>  	struct pci_dev_resource *dev_res;
>  	struct pci_bus *bus = pdev->bus;
> +	struct pci_dev *bridge = pci_upstream_bridge(pdev);
>  	struct resource *b_win, *r;
>  	LIST_HEAD(saved);
>  	unsigned int i;
> @@ -2397,6 +2398,8 @@ int pci_do_resource_release_and_resize(struct pci_dev *pdev, int resno, int size
>  	if (ret)
>  		return ret;
>  
> +	down_read(&pci_bus_sem);
> +
>  	pci_dev_for_each_resource(pdev, r, i) {
>  		if (i >= PCI_BRIDGE_RESOURCES)
>  			break;
> @@ -2415,13 +2418,21 @@ int pci_do_resource_release_and_resize(struct pci_dev *pdev, int resno, int size
>  
>  	pci_resize_resource_set_size(pdev, resno, size);
>  
> -	if (!bus->self)
> -		goto out;
> +	if (bridge) {
> +		ret = pbus_reassign_bridge_resources(bus, res, &saved);
> +		if (ret)
> +			goto restore;
> +	} else {
> +		/* No bridge window to adjust; let the core reassign the bus. */
> +		pci_bus_assign_resources(bus);
>  
> -	down_read(&pci_bus_sem);
> -	ret = pbus_reassign_bridge_resources(bus, res, &saved);
> -	if (ret)
> -		goto restore;
> +		list_for_each_entry(dev_res, &saved, list) {
> +			if (!resource_assigned(dev_res->res)) {
> +				ret = -ENOSPC;
> +				goto restore;
> +			}
> +		}
> +	}
>  
>  out:
>  	up_read(&pci_bus_sem);
> -- 
> 2.53.0
> 
