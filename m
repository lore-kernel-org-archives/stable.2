Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EE234CFCA;
	Thu,  3 Sep 2026 23:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788476740; cv=none; b=jPo0ANoxUb1qy1dwQou6OR14K+E6QVLsCx5Q4fho2yhHPL9bheTx6p6gtNKJPI+8aBsZlQhJAdPh6mK/eOc+cVup0GbbvrIGJkb7lixZDch5pm69yJV/mYX5Rh/azJcQSxfBGR/wAgC0I5IsOyMJmdHgsIbo3IgA+TEervcKI+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788476740; c=relaxed/simple;
	bh=7wAJrAQK5JISKKxRnovrwP/3jxpCcFk4jzbaLrD3EyU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VfWjOAPmKQ7jvebE7dg4ZFYqp0gioS9pkrcuNUepnW7AkZ0rMwNjynFkPTNYvhrGIc82QF+RdywBOOKbMCZIAzuzx3sD4J0TIUJru1eftVQLa7I6lFbJ952O89H3NJSdi72dvK20w43zRJ3/kXv2zUJ4r1lkCRMYIpGIfCmtUtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhbzFe9+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhbzFe9+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47861F000E9;
	Thu,  3 Sep 2026 23:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788476738;
	bh=R+eZylBeFLCipj4LV/kc98eg7afNWvoivAoeDLzItDA=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=RhbzFe9+VofsnBnBsrlI2uKcJxFWNbA6X2O0NYvJoHWB5OIczyyLlkRshDMI1sxUh
	 1JJP67iS77NDiWcBN0xt54SFSNDP2A3GFnfKvDWMoNbD/LqIIEL4U9Viwa6whtXPSD
	 RvF/HjHJMkLv+ZEyq5KRFMjT+5LV4amfecS+TD610hHKEfL+WnhwwKIzYLfQUN/jws
	 T3PsIabHhcbP/HOqk+nqREw0A47Gj+LV1eME83aZ/D0Wa3pONGDJ09tmkHOVaKG17W
	 FP+1ln9raqw5EtZfYkEhpzGbUM6o6uU1HhVaJ+uoGv/1rmNaYBgRN7qB/qc4YZpruY
	 UvDex7e77jhOg==
Date: Thu, 3 Sep 2026 18:05:37 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>, Lukas Wunner <lukas@wunner.de>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Kees Cook <kees@kernel.org>, Darshit Shah <darnshah@amazon.de>,
	Brian Norris <briannorris@chromium.org>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	linux-pci@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] PCI/DPC: Honor "pcie_ports=native" when enabling DPC
Message-ID: <20260903230537.GA2273943@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901064554.2178688-1-kanie@linux.alibaba.com>

On Tue, Sep 01, 2026 at 02:45:54PM +0800, Guixin Liu wrote:
> Commit 97ca178c899d ("PCI/DPC: Allow DPC on all Downstream Ports when
> OS controls AER") replaced the AER service bit with host->native_aer
> when deciding whether to create a DPC service device.  Unlike the AER
> service bit, host->native_aer does not reflect the "pcie_ports=native"
> command-line override.
> 
> Consequently, if firmware retains AER control, "pcie_ports=native" no
> longer enables DPC on Root Ports that advertise both AER and DPC, even
> though the option is documented to force native DPC handling.
> 
> Check pcie_ports_native explicitly so both command-line overrides
> continue to work.
> 
> Fixes: 97ca178c899d ("PCI/DPC: Allow DPC on all Downstream Ports when OS controls AER")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>  drivers/pci/pcie/portdrv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index a9cbfc1d2bc7..a05ee7980fb2 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -264,7 +264,7 @@ static int get_port_device_capability(struct pci_dev *dev)
>  	 */
>  	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
>  	    pci_aer_available() &&
> -	    (pcie_ports_dpc_native || host->native_aer))
> +	    (pcie_ports_native || pcie_ports_dpc_native || host->native_aer))

Oh my goodness.  I think I completely dropped ball on this YEARS ago.

It's crazy that we have "pcie_ports_native" checking littered all
over.  I think we should instead treat host->native_* as the single
source of truth, and pay attention to pcie_ports_native when setting
host->native_*.

Sathy did some great work to do exactly that in 2020, and I never got
it merged.  I wish I had some great excuse, but I looked at my 2020
calendar and couldn't find one.  I think I just blew it.

So I think we should resurrect that series and update it as needed and
solve the problem that way.  I dug out the links just for
completeness, but we should probably just start with the most recent
ones (v11 or v12):

  # v2 https://lore.kernel.org/r/cover.1590355211.git.sathyanarayanan.kuppuswamy@linux.intel.com/
  # v3 https://lore.kernel.org/r/cover.1590355824.git.sathyanarayanan.kuppuswamy@linux.intel.com/
  # v4 https://lore.kernel.org/r/cover.1590534843.git.sathyanarayanan.kuppuswamy@linux.intel.com/
  # v5 https://lore.kernel.org/r/cover.1591545462.git.sathyanarayanan.kuppuswamy@linux.intel.com/
  # v6 https://lore.kernel.org/r/cover.1593195899.git.sathyanarayanan.kuppuswamy@linux.intel.com/
  # v7 https://lore.kernel.org/r/cover.1595006564.git.sathyanarayanan.kuppuswamy@linux.intel.com/
  # v8 https://lore.kernel.org/r/cover.1595649348.git.sathyanarayanan.kuppuswamy@linux.intel.com/
  # v9 https://lore.kernel.org/r/cover.1600457297.git.sathyanarayanan.kuppuswamy@linux.intel.com/
  # v9 https://lore.kernel.org/r/20200928011131.MI-pJpJNRQw6c35j_O6019flLWHe08C4WvKPmKEbnik@z/
  # v10 https://lore.kernel.org/r/cover.1603738449.git.sathyanarayanan.kuppuswamy@linux.intel.com/
  # v11 https://lore.kernel.org/r/cover.1603766889.git.sathyanarayanan.kuppuswamy@linux.intel.com/
  # v12 https://lore.kernel.org/r/20201126011816.711106-1-helgaas@kernel.org/

>  		services |= PCIE_PORT_SERVICE_DPC;
>  
>  	/* Enable bandwidth control if more than one speed is supported. */
> -- 
> 2.43.7
> 
