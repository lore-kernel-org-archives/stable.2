Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D1D401A25;
	Mon, 28 Sep 2026 13:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790600937; cv=none; b=CizFIaCwwBkR72vI/7ayg8uat8b7qPF+rimEFJMoejaO58Xj4nC4uGnn9wG3QnPFDMgD1I0kjh5dAdefdN5FVJ4ocrufu8V68F2mlTFuhGDVaCyt3aC7L0DxnTKCVoK7eDC5NIzvBTK5zSB5G6ALezePmI73M/6DbkJGAkTJQWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790600937; c=relaxed/simple;
	bh=6qQf4RhaH0BmLuDSzTlP51a6XdeA8jUYoENzUueonkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mgOGnL8oh/DBbXlEfE+wwYD5zcObvW7UZArU4OUv0p2oeqSRJihkcI0aqYYNnKDkhEDmEAFn2wsAyO+wJXmvJipc42Xo2z7zPi5WU79VSn7C01V1WhA3lSIzikeGggV1ksBRjAWK/9G7pgnKVZk3I7bXCL03c/7nbR9hBzBzWyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W2YNCQGB; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W2YNCQGB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790600936; x=1822136936;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6qQf4RhaH0BmLuDSzTlP51a6XdeA8jUYoENzUueonkY=;
  b=W2YNCQGBLC1Hk09yAbeMso8sI0lx0IirQmGzcHcMksrAGq3cT6eoVwWc
   bxe/+BSL+lnraPa0vMbZrzLDKlMmyaVYJj1ItZwU4Em+XB2xjaU88FSDA
   bLP8kP2fU3Q7QHieYzv8dCcTyEV0JQQXo13VE11O43W0WZQeeK2OGkkvY
   aS5/WHIwODA3L7EuI3+rEFq3ik+5mQvC/t45X1pf7s78zGQVVvfLIAJG4
   tZ1Bq++yCq0AelMHiJ37/1id/kqV8CLOF2auSOV7uce5E6DxNL++BxzsS
   AeVduj3/+mRMxmJyaQhZ9qIVmhWt1nKBlzlmgv4bEzk5JTW+r0Mo5PW5X
   w==;
X-CSE-ConnectionGUID: 4Jg8rgHpQ/eC9BHfLiNzsg==
X-CSE-MsgGUID: FpNv0RrVRKuiUFQJXMZkdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="101867171"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="101867171"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 06:08:55 -0700
X-CSE-ConnectionGUID: bbK0evoWRcCK758tZKw+VQ==
X-CSE-MsgGUID: YhqaW/lCSTeUR0cK7c+1FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="274270715"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa010.fm.intel.com with ESMTP; 28 Sep 2026 06:08:53 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 3339999; Mon, 28 Sep 2026 15:08:52 +0200 (CEST)
Date: Mon, 28 Sep 2026 15:08:52 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Marek Maslanka <mmaslanka@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>
Subject: Re: [PATCH] usb: typec: port-mapper: Only match USB4 port if host
 interface is available
Message-ID: <arpm5HpsYGtfbXLs@black.igk.intel.com>
References: <20260925131650.3777399-1-mmaslanka@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925131650.3777399-1-mmaslanka@google.com>

On Fri, Sep 25, 2026 at 03:16:50PM +0200, Marek Maslanka wrote:
> typec_port_match() adds a component match for the USB4 port whenever a
> USB 3.x port that shares the _PLD with the Type-C connector has the
> "usb4-host-interface" property, regardless of whether a USB4 port can
> ever be registered for it. The component framework binds the aggregate
> device only once every match has found its component, so if the USB4
> port never shows up, the USB 2.0 and USB 3.x ports are not linked to the
> connector either: the "connector" symlinks are never created and USB
> devices enumerated on those ports are never linked with the Type-C
> partner.
> 
> This happens in at least two cases:
> 
> 1. CONFIG_USB4 is not reachable from the Type-C core, i.e. CONFIG_USB4=n,
>    or CONFIG_USB4=m with CONFIG_TYPEC=y as in the x86_64 gki_defconfig.
>    usb4_usb3_port_match() is then a stub that always returns false.
> 
> 2. The firmware references a USB4 host interface that is disabled. For
>    example, on Intel Alder Lake-N (ChromeOS Nissa) the TCSS xHCI USB3
>    ports (SS01-SS04) reference TDM0/TDM1, whose _STA returns 0 because
>    the SoC has no integrated Thunderbolt/USB4 and the DMA controllers
>    are disabled in TCSS DEVEN. No PCI device is enumerated for them.
> 
> Only add the USB4 component match if CONFIG_USB4 is reachable and the
> referenced host interface is available and has been enumerated as a
> device. The latter mirrors the check in usb_acpi_add_usb4_devlink(), see
> commit 623dae3e7084 ("usb: acpi: fix boot hang due to early incorrect
> 'tunneled' USB3 device links").
> 
> Fixes: 4fd7a1f0f7f2 ("usb: typec: Connect Type-C port with associated USB4 port")

+Alan

> Cc: stable@vger.kernel.org
> Signed-off-by: Marek Maslanka <mmaslanka@google.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/port-mapper.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/port-mapper.c b/drivers/usb/typec/port-mapper.c
> index cdbb7c11d714..3a97b084c3bd 100644
> --- a/drivers/usb/typec/port-mapper.c
> +++ b/drivers/usb/typec/port-mapper.c
> @@ -42,6 +42,23 @@ static int usb4_port_compare(struct device *dev, void *fwnode)
>  	return usb4_usb3_port_match(dev, fwnode);
>  }
>  
> +static bool typec_has_usb4_host_interface(const struct fwnode_handle *fwnode)
> +{
> +	if (!IS_REACHABLE(CONFIG_USB4))
> +		return false;
> +
> +	struct fwnode_handle *nhi_fwnode __free(fwnode_handle) =
> +		fwnode_find_reference(fwnode, "usb4-host-interface", 0);
> +
> +	/*
> +	 * The USB4 port can only appear if the host interface is enabled in
> +	 * the firmware and has been enumerated as a device. The latter is
> +	 * the same check as in usb_acpi_add_usb4_devlink().
> +	 */
> +	return !IS_ERR(nhi_fwnode) && fwnode_device_is_available(nhi_fwnode) &&
> +	       nhi_fwnode->dev;
> +}
> +
>  static int typec_port_compare(struct device *dev, void *fwnode)
>  {
>  	return device_match_fwnode(dev, fwnode);
> @@ -64,11 +81,11 @@ static int typec_port_match(struct device *dev, void *data)
>  				    adev_fwnode);
>  
>  		/*
> -		 * If dev is USB 3.x port, it may have reference to the
> +		 * If dev is USB 3.x port, it may have reference to an available
>  		 * USB4 host interface in which case we can also link the
>  		 * Type-C port with the USB4 port.
>  		 */
> -		if (fwnode_property_present(adev_fwnode, "usb4-host-interface"))
> +		if (typec_has_usb4_host_interface(adev_fwnode))
>  			component_match_add(&arg->port->dev, &arg->match,
>  					    usb4_port_compare, adev_fwnode);
>  	}
> -- 
> 2.56.0.rc1.315.gc6ed9934b7-goog

-- 
heikki
