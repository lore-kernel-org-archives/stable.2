Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795566315;
	b=dqHhPrTFSlcaTPIfGudodX6n2Co5r7gv1oTTO9va7IsRfina7eCV9pJvAHzqvlR/brpN
	 8Zgi/QSU8NWLhzujfmApK/YQE0QthB+DqNPbjDkHbQhTXOtrVuzB/ibjF4O8anuRuhDIy
	 0YykRFJMTofEHf2/fmIIa3aKs+6DjZFR+A+ha0BvvGYI5OL8Pnh4EqokvaNr6Nmj77kGP
	 Uj3yGbUTxz2EclITezI46d0g4uJ3Qn9kLIrnJCSSu1I0x/mJygJ03p4DCa/ETjEndPp9X
	 SYI+jTDsU2+Y+NseSssbxNNYKaOY+mTwRM2do5eS8Be7Mq/FR1MCPx53ZhG+6YYpSfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795566315;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Symlo491TPdhJrREXQmOnSha527963qk4UMvwZkfuiE=;
	b=w0r5QCCfkAVb+z0EzuEMUHEo6tnIBH1/kvJT8zVZ4TZeXf8WCKe9gr5uFiOx3aKrExSk
	 pqhqAR6IMNU9Tw3dYtzfZz+yik+AKt81xO3yI2xoubdnM294x1IRJXfQAnJOru6lpf7rS
	 fx83ejkexwzMgaTKn0/p/o3qnwnWaNAkslmvbn0ugN3ei9kYUGUqV7wXf5chLgBbTQxMK
	 ILaum5Cz+AJDbyjXmapEkT3BnjsytG7b5EnThy3Vaf+d2FMw46jfGCbYTo4YwWu2lQH1e
	 llhawXmXySKqUIj5kemEH2sZ71qu79b4bRz5aSnCxB5yTqI9yTJAR0vGyk6mMGtuzYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CIWMMnP6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D329606A31E;
	Wed, 25 Nov 2026 00:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CIWMMnP6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B37C1F000C0;
	Wed, 25 Nov 2026 00:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795566314;
	bh=Symlo491TPdhJrREXQmOnSha527963qk4UMvwZkfuiE=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=CIWMMnP6ZEeenbdNqfqBhWWv6qeNJmxAmW5C47UB7GUGTSsrzqkPJBB0IV4qt+hAU
	 f6iHkP3y78pPfgGBY3NbwZZfc1tj6pqf+7yv8C+EJBBflsVIMGzTPHj81/h2qbsQ8j
	 vnDp8v8o2p++9RnJNsJNTn6CimjoqOt1gBU13B6j2zOAKHgtfRlYnS5OenihQBCuCp
	 HzOjSTmUXCV4d39zfB/R3oUVrsGbIPM8XKk49+XSZT5IF6OWFVLSjNZ612vt7Mb0zR
	 TQyJDO/r4sURu1N6jaVRnb8K2fIdmgLIXU5eltHWP5XAc4UZdmGndLkhVKQloTKLuu
	 v4VNldkEctKgQ==
Date: Tue, 24 Nov 2026 18:25:13 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Anthony Pighin <anthony.pighin@nokia.com>,
	Dave Jiang <dave.jiang@intel.com>, Dan Williams <djbw@kernel.org>,
	Ionut Nechita <ionut.nechita@windriver.com>, kvm@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] vfio/pci: Only lock the upstream bridge if the reset
 may need it
Message-ID: <20261125002513.GA1197529@bhelgaas>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261124212842.1934651-1-skhawaja@google.com>

On Tue, Nov 24, 2026 at 09:28:42PM +0000, Samiullah Khawaja wrote:
> Commit 962ae6892d8b ("vfio/pci: Lock upstream bridge for
> vfio_pci_core_disable()") makes vfio_pci_core_disable() trylock the
> upstream bridge before resetting the device, and skips the reset if the
> trylock fails.
> 
> All VFs of a PF have the same upstream bridge. Take a device with two
> VFs, both used by one process. When the process is killed, both VFs can
> be released at the same time. The first one takes the bridge lock and
> does its FLR, the second one fails the trylock and is never reset.
> 
> The bridge lock is only needed for a bus reset, which is done through
> the bridge. Add pci_reset_function_needs_bridge_lock(), which returns
> false if there is no upstream bridge, if bus resets are disabled for the
> device, or if the device is a VF. Use it in vfio_pci_core_disable() and
> pci_reset_function() to only lock the bridge when it is needed.
> 
> Fixes: 962ae6892d8b ("vfio/pci: Lock upstream bridge for vfio_pci_core_disable()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>

Applied to pci/reset for v7.5, thanks!

Minor conflict with Ionut's "PCI: Don't block bridge config access
while waiting for the device lock", so double check if you have a
chance:
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=reset

> ---
> v2:
> - Replace pci_reset_needs_bridge_lock() with
>   pci_reset_function_needs_bridge_lock() as suggested by Alex, and use it
>   in pci_reset_function() too.
> ---
>  drivers/pci/pci.c                | 25 ++++++++++++++++++++++---
>  drivers/vfio/pci/vfio_pci_core.c |  3 ++-
>  include/linux/pci.h              |  1 +
>  3 files changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7c6f2aba8144..cc6647d091f7 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5256,6 +5256,24 @@ int __pci_reset_function_locked(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(__pci_reset_function_locked);
>  
> +/**
> + * pci_reset_function_needs_bridge_lock - check whether a function reset of
> + * @dev may need the upstream bridge to be locked
> + * @dev: PCI device to check
> + *
> + * A bus reset of @dev is done through its upstream bridge, so the caller must
> + * hold the bridge lock. The bridge doesn't need to be locked if there is no
> + * upstream bridge, if bus resets are disabled for @dev, or if @dev is a VF.
> + *
> + * Return: true if a function reset of @dev may be a bus reset.
> + */
> +bool pci_reset_function_needs_bridge_lock(struct pci_dev *dev)
> +{
> +	return pci_upstream_bridge(dev) &&
> +	       !(dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET) && !dev->is_virtfn;
> +}
> +EXPORT_SYMBOL_GPL(pci_reset_function_needs_bridge_lock);
> +
>  /**
>   * pci_init_reset_methods - check whether device can be safely reset
>   * and store supported reset mechanisms.
> @@ -5313,10 +5331,11 @@ int pci_reset_function(struct pci_dev *dev)
>  		return -ENOTTY;
>  
>  	/*
> -	 * If there's no upstream bridge, no locking is needed since there is
> -	 * no upstream bridge configuration to hold consistent.
> +	 * The upstream bridge only needs to be locked if the reset may be a
> +	 * bus reset, which is done through the bridge.
>  	 */
> -	bridge = pci_upstream_bridge(dev);
> +	bridge = pci_reset_function_needs_bridge_lock(dev) ?
> +		 pci_upstream_bridge(dev) : NULL;
>  	if (bridge)
>  		pci_dev_lock(bridge);
>  
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index fcbb2da860e2..5dcbefd2eba4 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -777,7 +777,8 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
>  	 * overwrite the previously restored configuration information.
>  	 */
>  	if (vdev->reset_works) {
> -		bridge = pci_upstream_bridge(pdev);
> +		bridge = pci_reset_function_needs_bridge_lock(pdev) ?
> +			 pci_upstream_bridge(pdev) : NULL;
>  		if (bridge && !pci_dev_trylock(bridge))
>  			goto out_restore_state;
>  		if (pci_dev_trylock(pdev)) {
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index aa3765a20a96..aee6a178a535 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1486,6 +1486,7 @@ void pcie_print_link_status(struct pci_dev *dev);
>  int pcie_reset_flr(struct pci_dev *dev, bool probe);
>  int pcie_flr(struct pci_dev *dev);
>  int __pci_reset_function_locked(struct pci_dev *dev);
> +bool pci_reset_function_needs_bridge_lock(struct pci_dev *dev);
>  int pci_reset_function(struct pci_dev *dev);
>  int pci_reset_function_locked(struct pci_dev *dev);
>  int pci_try_reset_function(struct pci_dev *dev);
> 
> base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
> -- 
> 2.56.1.831.g720f3f5937-goog
> 
