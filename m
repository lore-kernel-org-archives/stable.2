Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795193329;
	b=0epaOKCRxg1+5VAU4x/O0OgKfbUjFhTFr2xc14+72n1kvYewyTIJosOTEbI2JjsjQs35
	 tkF3DQTQXQ0m/opvByZ1GumWuN09V8NB9+nlcl2g8YzfRGhFqqoimwsRmUuqV6W/AdqKM
	 YT2jpRjQAHKcNaprk11P/AoKPrxityItQL6e9kudumrMyarrBjLknU6wip7TWS79m+ZgG
	 /3gH3rLniLHsWnSItmXOZTUtPy/R7S86RIw/eqVf1h6hJ8YwbYAlj70z6K5JZ1ik5rvBV
	 FQ0nhlB3zN0BE5xdcdfAJJm19NxzNS3PUzmVA3VdasPrBemS3ARqjTeDupoVxJ1qjTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795193329;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=nf7ZvY803TNekaL5vmEd7TKoQhygNYuaeAFOBV+qHIY=;
	b=S1MMlimF7CZa5qxGipz4J7+Ys9MQT/rqHjDTuEnuzlLIwB6AGhRIwDd+5Zb6GuEr/wNJ
	 wEMPNqPcggaIVlgC1BZraEYuZiXhPcpRb0fcPKW1uMqYGMjrPDfNhnoQsRuqtIoLc4kp3
	 YoyyuEwSHY+YctRHT7E/rOMZWqe930KU6c57Hcu5oUmwDEEl7cMQtFnsQxDjI9MH77mY2
	 c2xUOoeTjc6qVnoDwFSDTKZhsLsgoARPxpsAmlnNJZRWFwRvWkGXMUJe8z0NvD+k//lZn
	 yfs6tj5MsuZ7lVF0OED6TfhxdbxFv9SMiM7Nh42Gay4q1vajkPRWSMOA8NIhG2v6yYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bmwEFXDX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB54606A331;
	Fri, 20 Nov 2026 16:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bmwEFXDX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3672D1F000CF;
	Fri, 20 Nov 2026 16:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795193328;
	bh=nf7ZvY803TNekaL5vmEd7TKoQhygNYuaeAFOBV+qHIY=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=bmwEFXDXKyTx+0R2/7PyhMY+lL6CQdTn9OoCgvd/vi0lUEOMSBVqOu4auFFdRs/sQ
	 2M9OG7yvDwEmfSjcjwtHNVt7j5YWTETFNFiYhDRNT8tUtlpzJ7P12g8N6fqC9mhkNW
	 bC8REw99Emfrk/un/tGhhUPP3ExPLbfk7C0d8jE+YWKlhjhbsHhHUc3pLmDt2wvuiW
	 QthuYHsLLyCJO4pw6H0ZW7ySakKlI0DCgbqKd8lcYTC5J/WQBmKwyv66iRmhLucSPo
	 YhAnUNr2iwTYK1iD5HJvN8DLsyxzOsFcsyhKaauodEDqz9EVVIolcZ1dve4YhBD+nl
	 ES1287K33hprA==
Date: Fri, 20 Nov 2026 10:48:47 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Dave Jiang <dave.jiang@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>, lukas@wunner.de,
	sebott@linux.ibm.com, schnelle@linux.ibm.com, bblock@linux.ibm.com,
	linux@roeck-us.net, matthew.brost@intel.com,
	michal.wajdeczko@intel.com, piotr.piorkowski@intel.com,
	dtatulea@nvidia.com, mani@kernel.org, kbusch@kernel.org,
	lkml@mageta.org, alifm@linux.ibm.com, julianr@linux.ibm.com,
	ionut_n2001@yahoo.com, sunlightlinux@gmail.com
Subject: Re: [PATCH 1/1] PCI: Don't block bridge config access while waiting
 for the device lock
Message-ID: <20261120164847.GA887103@bhelgaas>
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
In-Reply-To: <20261119123504.25906-2-ionut.nechita@windriver.com>

On Thu, Nov 19, 2026 at 02:35:04PM +0200, Ionut Nechita (Wind River) wrote:
> From: Ionut Nechita <ionut.nechita@windriver.com>
> 
> pci_reset_function() locks the upstream bridge with pci_dev_lock(),
> which takes the bridge's device lock and then blocks config access to
> the bridge, and only then takes the device lock of the function being
> reset. If another task holds that device lock, the reset sleeps with
> config access to the bridge blocked, and every user config read of the
> bridge sleeps in pci_wait_cfg() for as long.
> 
> This happens with vfio-pci when a userspace driver keeps a VF open:
> 
>   1. A driver unbind of the VF waits in vfio_unregister_group_dev()
>      for the user to release the device, holding the VF device lock.
>   2. Writing 0 to sriov_numvfs on the PF takes the PF device lock and
>      waits in sriov_disable() for the VF device lock.
>   3. Writing 1 to the PF "reset" attribute calls pci_reset_function(),
>      which blocks config access to the PF's upstream bridge and waits
>      for the PF device lock.
> 
> From then on lspci, which reads the config space of every device,
> hangs in D state, and so does any tool or agent that runs it, until
> the userspace driver releases the VF:
> 
>   lspci           D
>     pci_wait_cfg+0x60/0xc0
>     pci_user_read_config_dword+0xcc/0xf0
>     pci_read_config+0xf5/0x290
>     kernfs_fop_read_iter+0xb6/0x1b0
>     vfs_read+0x21f/0x340
> 
> This was hit with an Intel FPGA PAC N3000 FEC device bound to vfio-pci
> (PF and VFs), where the SR-IOV FEC operator reconfigures the PF while a
> DPDK application holds one of its VFs.
> 
> Take the device locks first, bridge before device as before, and block
> config access to the bridge and the device only once both are held.
> The order between the two device locks is unchanged. Config access is
> now blocked only while the reset runs, not while waiting for a lock.
> 
> The reset itself still waits for the device lock, so the tasks in
> steps 1-3 stay blocked until the user releases the VF. Only config
> reads of unrelated callers stop being blocked.
> 
> Fixes: 7e89efc6e9e4 ("PCI: Lock upstream bridge for pci_reset_function()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>

Applied to pci/reset for v7.5, thank you!

> ---
>  drivers/pci/pci.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index d79f73b28..9c8d5dda9 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5345,19 +5345,35 @@ int pci_reset_function(struct pci_dev *dev)
>  	 * no upstream bridge configuration to hold consistent.
>  	 */
>  	bridge = pci_upstream_bridge(dev);
> +
> +	/*
> +	 * Take the device locks, bridge before device, before blocking
> +	 * config access to either of them.  device_lock() can sleep for as
> +	 * long as another task holds it, e.g. a driver unbind waiting for
> +	 * a vfio user to release the device.  If config access to the
> +	 * bridge were already blocked at that point, every config read of
> +	 * the bridge (lspci, sysfs "config") would sleep in pci_wait_cfg()
> +	 * for the same time.
> +	 */
>  	if (bridge)
> -		pci_dev_lock(bridge);
> +		device_lock(&bridge->dev);
> +	device_lock(&dev->dev);
> +	if (bridge)
> +		pci_cfg_access_lock(bridge);
> +	pci_cfg_access_lock(dev);
>  
> -	pci_dev_lock(dev);
>  	pci_dev_save_and_disable(dev);
>  
>  	rc = __pci_reset_function_locked(dev);
>  
>  	pci_dev_restore(dev);
> -	pci_dev_unlock(dev);
>  
> +	pci_cfg_access_unlock(dev);
>  	if (bridge)
> -		pci_dev_unlock(bridge);
> +		pci_cfg_access_unlock(bridge);
> +	device_unlock(&dev->dev);
> +	if (bridge)
> +		device_unlock(&bridge->dev);
>  
>  	return rc;
>  }
> -- 
> 2.55.0
> 
