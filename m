Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8392F2C0F8C;
	Wed, 16 Sep 2026 14:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789570248; cv=none; b=fPKgJjWnW7fDZIRBFrH9RX0OYnc1RXeOi6gcPa7AV93Bm1LPFMiB2q/M6wvDfVWOr84f3WjI0Tfl5D8m2Zq7HQPXtJxiFhvCRKG9+pvMIpT3L92wShmIuHMK2gh3N0iOM7IDihl+6gmVPsrZ5dSv7QDHku48+xWH+srabBGyAYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789570248; c=relaxed/simple;
	bh=RhVLTWzVaJaLgfP7/phIIe+ekkV4rdTVEVwEjVESCC4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=P+G5T9UQ3Y8mJtXc17ulgqFABx1XtRQj6yXL47ETdUIjAbFJ/gx1lxtAC9xGxDFHgwJgFTnbcIf8H5UrFLM38rT1Wxpae55wjKVJmNTMESSg1hHXfHPWgv8Dic9z6nXd8tyFisbT4CVKvJVNp1x1FeIKq0VBTOALwV6Nynwc0jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1Jr2asw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1Jr2asw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2AC21F000FF;
	Wed, 16 Sep 2026 14:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789570247;
	bh=9n9CTHcuaXijNoFZR6DZmPgiz11kru6+rNJJzvGm2JI=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=j1Jr2aswkdTNWl5sS0SE0HNk/mgydrHOcEq9xTtwwmAXXzqKwaZTRXHUrYQKHsZFC
	 kOXVjd9yGc5jFlTpqRmBHCDwtaUEm16fp2vgWSDGOkFsyDHnf902ox63Ux44efukZa
	 9vFQ5OHtX4eS6OxvnuBrjc7J8CJgt8Y6RSPWI9Y2qVBLXziCoJGbowm8Zad4whnO81
	 sHJwD2BVnzwwNFOlZeMjKoPDl2Klztbn+HZg5LvA1ILP0bG3bxcFYhkTSY4/WPIlYY
	 4OodtnTuVnCicd0cL2oYHcJRggjwqkXKwhyqJQl/02B2RCo2BatJR/IxdP09YRIL0s
	 uFhFO1pcB01Ow==
Date: Wed, 16 Sep 2026 09:50:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Angel J <iamanaws@httpd.dev>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, robh@kernel.org,
	herve.codina@bootlin.com, lizhi.hou@amd.com, andrea.porta@suse.com,
	florian.fainelli@broadcom.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
	stable@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH v2] PCI: of_property: Omit bus properties without a
 subordinate bus
Message-ID: <20260916145045.GA922158@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912043106.10715-1-iamanaws@httpd.dev>

On Fri, Sep 11, 2026 at 09:31:06PM -0700, Angel J wrote:
> A device can satisfy pci_is_bridge() without having a subordinate bus.
> The dynamic OF helpers for bus-range and interrupt-map dereference
> pdev->subordinate without checking it.
> 
> On a Dell XPS 8940, device 0000:00:00.0 [8086:4c43] has no subordinate
> bus, and enabling CONFIG_PCI_DYNAMIC_OF_NODES causes an early boot hang.
> 
> Generate bus-range and interrupt-map only when a subordinate bus exists.
> Keep the node and its remaining properties for bridges without one.
> 
> Boot-tested on Linux 6.18.44 with CONFIG_PCI_DYNAMIC_OF_NODES=y. The
> system boots and the node for 00:00.0 retains device_type, reg and
> compatible. The other bridges retain their nodes and bus ranges.

I think this is the right approach, with something like this included
in the commit log:

  A bridge (a device with a Type 1 header) may not have a secondary
  bus allocated (pdev->subordinate), e.g., if there are no available
  bus numbers or the bridge secondary/subordinate bus numbers are not
  writable.

I don't think it's necessary to connect this with [8086:4c43] because
I think this situation is very common, and I don't want to leave the
impression that it's related to a Dell system or to that specific
device.  It's just a bug to assume that pci_is_bridge() implies
pdev->subordinate is valid.

> Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
> Cc: stable@vger.kernel.org
> Signed-off-by: Angel J <iamanaws@httpd.dev>
> ---
> Changes in v2:
> - Keep the dynamic OF node and skip only bus-range and interrupt-map
>   when no subordinate bus exists, following review of v1.
> - Tested on Linux 6.18.44 with the v1 guard removed.
> 
>  drivers/pci/of_property.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
> index 75a358f73..acd2e0f70 100644
> --- a/drivers/pci/of_property.c
> +++ b/drivers/pci/of_property.c
> @@ -361,13 +361,15 @@ int of_pci_add_properties(struct pci_dev *pdev, struct of_changeset *ocs,
>  		if (ret)
>  			return ret;
>  
> -		ret = of_pci_prop_bus_range(pdev, ocs, np);
> -		if (ret)
> -			return ret;
> +		if (pdev->subordinate) {
> +			ret = of_pci_prop_bus_range(pdev, ocs, np);
> +			if (ret)
> +				return ret;
>  
> -		ret = of_pci_prop_intr_map(pdev, ocs, np);
> -		if (ret)
> -			return ret;
> +			ret = of_pci_prop_intr_map(pdev, ocs, np);
> +			if (ret)
> +				return ret;

I think this is the best solution, but I do think it would be a little
cleaner to check for pdev->subordinate inside of_pci_prop_bus_range()
and of_pci_prop_intr_map() instead of assuming things here about the
internals of those functions.  We could just make them return
immediately without doing anything.

> +		}
>  	} else {
>  		ret = of_pci_prop_intr_ctrl(pdev, ocs, np);
>  		if (ret)
> -- 
> 2.54.0
> 
