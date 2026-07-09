Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4E93806DD;
	Thu,  9 Jul 2026 20:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783627760; cv=none; b=Hx6LANwcQuwpnSjCdMbyDGA38sgqFV5Ls4nP4u/xWcp2Na7InHh5+M2lEqodq1QWNd9qR3t2A7DCmReqqahH0jBuSHQw7i2NPFFOTbmC6pzgR58E2c2PB+2tXbEjXmA/g2G5Sgu8AyAXTpC0PFN4HEQSaS+M1lK8E64EimU+cik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783627760; c=relaxed/simple;
	bh=qb3Va2EWJCuabDmEu+LVOT/opeHpRCxCAUvcS18R9VU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IznmrdzzYpd6d++pH7DEw47RacE2J8Ej9TjJiVNxME0TFj15Z88ahEa5XPjwf1EBbHq4+p0iVQ/2bg5LVz1jlG+oYacj+JzGc8L5mGVpwsfgJqM4moK4ZLR9YPOOhHuA1yxitb9JeeUaty+RSitLcdC2l8fBM8vZrM62kp/H/8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKBvQLIB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKBvQLIB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD391F00A3A;
	Thu,  9 Jul 2026 20:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783627758;
	bh=GQuKYkV+RrdDaj2kuGPtykS0VuTmijFhckMfHg5Fm6E=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=hKBvQLIBI2Et62EU1THz3bg3Q+4e00bwkTJvLNGtXuDsckSdhXqWsv7Mi0StVbOTY
	 aoKWr89W7DmkAC1ibeGSvrcyWaMmf8YOcLHa1nK+AGeMLKt9IGsQh0WEg6DgF4cV7w
	 Z6Ln79/0ijRDOhdCXsGIoMExZKegHGM7qmyf4JjTrZ9F3tkLlR5FXj5cHr/ZG3u3IX
	 wKl+5k+yFa3luBLvZ+0Ov5hUUh7znY5Zt57xoIgJSJ2zKa03kyIRJBRpiQLMC4nlP+
	 6laPzpGq4y6TbF/cySM+OuW/dIHMrtg+dIu5YS2PZMZlkhG6gE9fzA+yPHNWre/R4E
	 X4KUFOL2QJaSg==
Date: Thu, 9 Jul 2026 15:09:17 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Steffen Persvold <spersvold@gmail.com>
Cc: Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] PCI: host-generic: Fix NULL pointer dereference on
 32-bit CAM systems
Message-ID: <20260709200917.GA875728@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709122446.3151899-1-spersvold@gmail.com>

On Thu, Jul 09, 2026 at 02:24:46PM +0200, Steffen Persvold wrote:
> On 32-bit systems the config space is too large to ioremap in one go, so
> pci_ecam_create() maps each bus segment separately and relies on the
> ->add_bus callback (pci_ecam_add_bus) to populate the per-bus mapping in
> cfg->winp[]. pci_ecam_map_bus() then uses that mapping as the base for
> every config access.
> 
> The generic ECAM ops (pci_generic_ecam_ops) already provide the ->add_bus
> and ->remove_bus callbacks, but the CAM (legacy) ops in pci-host-generic.c
> do not. As a result, on a 32-bit host using "pci-host-cam-generic" the
> per-bus mapping is never set up and the first config read dereferences a
> NULL base, crashing during bus enumeration:
> 
> [    1.430647] Unable to handle kernel NULL pointer dereference at virtual address 00000800
> [    1.439441] Oops [#1]
> [    1.442152] CPU: 0 PID: 1 Comm: swapper Not tainted 6.9.7+ #43
> [    1.448753] Hardware name: Digilent Nexys-Video-A7 RV32 (DT)
> [    1.454968] epc : pci_generic_config_read+0x40/0xb0
> [    1.460652]  ra : pci_generic_config_read+0x2c/0xb0
> [    1.534729] [<c038db9c>] pci_generic_config_read+0x40/0xb0
> [    1.541096] [<c038da04>] pci_bus_read_config_dword+0x50/0xb0
> [    1.547623] [<c0391e94>] pci_bus_generic_read_dev_vendor_id+0x3c/0x1ec
> [    1.555010] [<c039245c>] pci_scan_single_device+0xa4/0x11c
> [    1.561273] [<c0392570>] pci_scan_slot+0x9c/0x23c
> [    1.566716] [<c039388c>] pci_scan_child_bus_extend+0x58/0x2f4
> [    1.573275] [<c0393db0>] pci_scan_root_bus_bridge+0x64/0xe8
> [    1.579650] [<c0393e54>] pci_host_probe+0x20/0xc8
> [    1.591396] [<c03bc6f4>] pci_host_common_probe+0x144/0x1e4

Remove timestamps, since they don't contribute to understanding the
problem, and indent the quoted material two spaces.

If there's no other reason for a v2, we can do this while merging.

> Fix this by giving the CAM ops the same ->add_bus/->remove_bus callbacks.
> Since pci_ecam_add_bus() and pci_ecam_remove_bus() are static to ecam.c,
> move the CAM ops definition there as pci_generic_cam_ops (mirroring
> pci_generic_ecam_ops) and export it for pci-host-generic.c to reference.
> 
> Fixes: 8fe55ef23387 ("PCI: Dynamically map ECAM regions")
> Cc: stable@vger.kernel.org
> Signed-off-by: Steffen Persvold <spersvold@gmail.com>
> ---
>  drivers/pci/controller/pci-host-generic.c | 11 +----------
>  drivers/pci/ecam.c                        | 13 +++++++++++++
>  include/linux/pci-ecam.h                  |  3 +++
>  3 files changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-host-generic.c b/drivers/pci/controller/pci-host-generic.c
> index c1bc0d34..9e85c6e9 100644
> --- a/drivers/pci/controller/pci-host-generic.c
> +++ b/drivers/pci/controller/pci-host-generic.c
> @@ -16,15 +16,6 @@
>  
>  #include "pci-host-common.h"
>  
> -static const struct pci_ecam_ops gen_pci_cfg_cam_bus_ops = {
> -	.bus_shift	= 16,
> -	.pci_ops	= {
> -		.map_bus	= pci_ecam_map_bus,
> -		.read		= pci_generic_config_read,
> -		.write		= pci_generic_config_write,
> -	}
> -};
> -
>  static bool pci_dw_valid_device(struct pci_bus *bus, unsigned int devfn)
>  {
>  	struct pci_config_window *cfg = bus->sysdata;
> @@ -60,7 +51,7 @@ static const struct pci_ecam_ops pci_dw_ecam_bus_ops = {
>  
>  static const struct of_device_id gen_pci_of_match[] = {
>  	{ .compatible = "pci-host-cam-generic",
> -	  .data = &gen_pci_cfg_cam_bus_ops },
> +	  .data = &pci_generic_cam_ops },
>  
>  	{ .compatible = "pci-host-ecam-generic",
>  	  .data = &pci_generic_ecam_ops },
> diff --git a/drivers/pci/ecam.c b/drivers/pci/ecam.c
> index 119de32f..a9b3bce2 100644
> --- a/drivers/pci/ecam.c
> +++ b/drivers/pci/ecam.c
> @@ -208,6 +208,19 @@ const struct pci_ecam_ops pci_generic_ecam_ops = {
>  };
>  EXPORT_SYMBOL_GPL(pci_generic_ecam_ops);
>  
> +/* CAM ops */
> +const struct pci_ecam_ops pci_generic_cam_ops = {
> +	.bus_shift	= 16,
> +	.pci_ops	= {
> +		.add_bus	= pci_ecam_add_bus,
> +		.remove_bus	= pci_ecam_remove_bus,
> +		.map_bus	= pci_ecam_map_bus,
> +		.read		= pci_generic_config_read,
> +		.write		= pci_generic_config_write,
> +	}
> +};
> +EXPORT_SYMBOL_GPL(pci_generic_cam_ops);
> +
>  #if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)
>  /* ECAM ops for 32-bit access only (non-compliant) */
>  const struct pci_ecam_ops pci_32b_ops = {
> diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
> index d9306514..044f67ce 100644
> --- a/include/linux/pci-ecam.h
> +++ b/include/linux/pci-ecam.h
> @@ -81,6 +81,9 @@ void __iomem *pci_ecam_map_bus(struct pci_bus *bus, unsigned int devfn,
>  /* default ECAM ops */
>  extern const struct pci_ecam_ops pci_generic_ecam_ops;
>  
> +/* default CAM ops */
> +extern const struct pci_ecam_ops pci_generic_cam_ops;
> +
>  #if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)
>  extern const struct pci_ecam_ops pci_32b_ops;	/* 32-bit accesses only */
>  extern const struct pci_ecam_ops pci_32b_read_ops; /* 32-bit read only */
> 
> base-commit: 53bf92818a8362815708fc7b18e6d2c6a5fc665b
> -- 
> 2.40.1
> 
