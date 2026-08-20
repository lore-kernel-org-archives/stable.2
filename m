Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A2D3D9DAC;
	Thu, 20 Aug 2026 20:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787259318; cv=none; b=Hh7wHmt0ycpNJ2u9+ftUUsMg5HRKg3B7CQ7XCYVaTWTaOm/nYWz7/OaPpS0aC2QTGqTdq9gN2haZJD4XaeofmW6r/mDYaXuys7MbyCS9rx2FkBByZuVb4ucdjCGij/fjiQY6xTVoF2j2FMDHAlkYxYSAQtOo24H+2QqV6wCeO74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787259318; c=relaxed/simple;
	bh=VaDYhMvwCgRJNgtbHvUcrXvZBbhA9Q/v9V1dKjBxYxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bzCzGbJVa/3IBzSCnYOwgy6orgeHuUKQRHJT2xTiy4XCw2WQsSdGcgp96Fb2Gf4PurV3KpAymuHd4YMssIWTdnjxeofKiuilsKoytLT1bBjUbK6YjJyZzvYI1T7zf36c62xLQGtoI37mFxstgDA6LEq0fwyXpkzNl1V/kUzz+r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JYpLIWkk; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JYpLIWkk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787259317; x=1818795317;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VaDYhMvwCgRJNgtbHvUcrXvZBbhA9Q/v9V1dKjBxYxU=;
  b=JYpLIWkkxcwgOgdWfHep0IyyCfc+nfOxAc6BsVg7nxpDqRroiJFVMWuu
   Iz+gXK6QY9zYxa0y3ILKuhYcm68bB6i+F/ZqTmJ4BKeu6LsDFG+3RykwQ
   UjRuqLW3hzvgRRCqpPRFF3837IVtzk0b7NuBBO5umuZn25tj5yUkbtcHD
   3FHHP0bJtNv8ZhVz3oKNrLKEr7bauN/M+1LzaJVWgRmMa7Sm3FoRqeNKZ
   VkInVKvnQizsYQJeUTxfMhFTDN4eI7nS8Z6I+HTV7heStZdtwm4apssO2
   sscHYtSQC8azDSFSFu/rVMhCqaz0KV5jHdA9Pu2l5S6sudQGbKwBC6RK7
   w==;
X-CSE-ConnectionGUID: NjNeEt6+RcKVD7pO39DyDw==
X-CSE-MsgGUID: gQl+qX32TEW1e6FwWCyWWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="87823249"
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; 
   d="scan'208";a="87823249"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 13:55:17 -0700
X-CSE-ConnectionGUID: Ls/vOV09SWmhG8gY94x9BA==
X-CSE-MsgGUID: 5nhwvTplSjSmi9fY2emQwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; 
   d="scan'208";a="266189130"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.149])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 13:55:14 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 745A711FA3A;
	Thu, 20 Aug 2026 23:55:21 +0300 (EEST)
Date: Thu, 20 Aug 2026 23:55:21 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Maciej Andrzejewski ICEYE <maciej.andrzejewski@m-works.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	chris.packham@alliedtelesis.co.nz, daniel@zonque.org,
	andriy.shevchenko@linux.intel.com, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uio: uio_pdrv_genirq: restore UIO name without the unit
 address
Message-ID: <aodpuQzLJlB30UYf@kekkonen.localdomain>
References: <20260820140119.1546932-1-maciej.andrzejewski@m-works.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820140119.1546932-1-maciej.andrzejewski@m-works.net>

Hi Maciej,

On Thu, Aug 20, 2026 at 04:01:23PM +0200, Maciej Andrzejewski ICEYE wrote:
> Commit 90fa0280553a ("uio_pdrv_genirq: convert to use device_property
> APIs") switched the driver to the device_property API so that a UIO
> device can also be described through an ACPI overlay. As part of that
> conversion the default name handed to userspace changed from "%pOFn" to
> "%pfwP".
> 
> The two specifiers are not interchangeable. The printk format
> documentation defines %pfwP as the node name including an address if
> there is one, while %pOFn prints the device tree node name with the unit
> address stripped. A node named "dma@a0000000" therefore appeared in
> /sys/class/uio/uioN/name as "dma" up to v6.9 and as "dma@a0000000" from
> v6.10 onwards.
> 
> That name is the only stable handle userspace has for a UIO device,
> because the uioN index follows probe order. Applications that resolve a
> device by name, for instance through the libuio uio_find_by_uio_name()
> helper, stop finding it.
> 
> Nothing in the conversion suggests the rename was intended.
> Documentation/driver-api/uio-howto.rst still states that the node's name
> without the unit address is exposed as the name for the UIO device in
> userspace, and uio_dmem_genirq still builds its name with %pOFn. The
> "linux,uio-name" property added by commit b0297622a972 ("uio:
> uio_pdrv_genirq: Make UIO name controllable via DT node property")
> already lets a board distinguish several identically named nodes, so the
> default does not need to carry the unit address.
> 
> fwnode has no equivalent of the %pOFn name-only modifier, which is
> likely why the closest specifier was picked. Print device tree nodes
> through %pOFn and leave every other firmware node type on %pfwP. This
> driver could not be probed from ACPI before 90fa0280553a, so ACPI
> naming is unaffected.
> 
> Should the unit address in the default name turn out to be wanted after
> all, then uio-howto.rst is the file that needs the change instead, and I
> am happy to send that patch rather than this one.
> 
> Fixes: 90fa0280553a ("uio_pdrv_genirq: convert to use device_property APIs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Maciej Andrzejewski ICEYE <maciej.andrzejewski@m-works.net>

The original patch indeed appears to intend no changes on existing users.

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Ideally we would have an 'n' specifier for printing a less full name of a
node, i.e. %pfwn. I wouldn't try to backport that so this patch makes sense
as-is.

The '@' character doesn't have such significance on ACPI as it does have on
DT so I think 'n' would probably be best behaving as 'f' on ACPI. This
would probably mean a new fwnode op.

> ---
> 
> Notes:
>     Found on a Zynq UltraScale+ platform where FPGA blocks are exposed
>     through generic-uio nodes. Userspace uses libuio and resolves those
>     devices by name, so the applications stopped finding them after a move
>     from 4.19 to 6.12.
> 
>     The single generic-uio node in tree is renamed the same way:
>     uio@d0000000 in arch/arc/boot/dts/vdk_axs10x_mb.dtsi reads back as "uio"
>     before v6.10 and as "uio@d0000000" after it.
> 
>     Build tested on x86_64 with W=1 and CONFIG_UIO_PDRV_GENIRQ=m, once with
>     CONFIG_OF=y and once with CONFIG_OF=n. No warnings either way.
> 
>  drivers/uio/uio_pdrv_genirq.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/uio/uio_pdrv_genirq.c b/drivers/uio/uio_pdrv_genirq.c
> index 0c8d73e7be52..27268c8d1b94 100644
> --- a/drivers/uio/uio_pdrv_genirq.c
> +++ b/drivers/uio/uio_pdrv_genirq.c
> @@ -128,6 +128,9 @@ static int uio_pdrv_genirq_probe(struct platform_device *pdev)
> 
>  		if (!device_property_read_string(&pdev->dev, "linux,uio-name", &name))
>  			uioinfo->name = devm_kstrdup(&pdev->dev, name, GFP_KERNEL);
> +		else if (is_of_node(node))
> +			uioinfo->name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
> +						       "%pOFn", to_of_node(node));
>  		else
>  			uioinfo->name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
>  						       "%pfwP", node);

-- 
Kind regards,

Sakari Ailus
