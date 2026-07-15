Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D6943849D;
	Wed, 15 Jul 2026 09:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784108738; cv=none; b=oxnemYE4bhR0QKv1oBJLxy0SNHljOVW8kilmFGW6S7xW0N77J4TIXvp9p4uS9b10F9R5NaHlkG72LU4xs7FQZsos2fc6fpRK0ug7XAfAONR5QEdvTKTn6ikQuxAOTWeR7Py6S+OnaCQxpF5zNJu0kcmVh0szj6Xa0x9jqVZe7Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784108738; c=relaxed/simple;
	bh=e9EVrjo4je06jJvzKOXmUSY/lYq5x3Z/o92jN55pK0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lePW7tnli9dpRG3XFTumiHWuYI2g0U7ypXFYik9YA3mrJwCo294rXeCNi+Ou+HtFwPyy9w0W0Rkz7sjXCunpkK3WXCYFcxMyNJNed9YteShvDOr6dLUwdTHUuipQttNg8W2T+oKWvrT7cgOIQNQcxYwtBA+yFkC9Z0qn4CbuWeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hRcI8pQr; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hRcI8pQr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784108727; x=1815644727;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e9EVrjo4je06jJvzKOXmUSY/lYq5x3Z/o92jN55pK0M=;
  b=hRcI8pQrlTnCrwB2AJQ09UUJyKdrsu7rv2O1CaLoGqMKIAL9MiOogsCr
   muuHvRDTxJhdO7RTMMHii/MALqgVFqi6O6+KOD9hP9LfjmT4ISk9w+H/O
   4E8wPwHtDcS6Ga554Sodv9kEFwGVz2qVIqCaRicsVewlA6qsvIyHkUZgh
   axr5AS3fAR4WjQ7bJTbm5rjfHyWNIWoButWfX3p9rmOV7QbwSxzugmQqR
   MRZL4nvudLhScDvxM0u63AA4DG0RyRu/H8EnigV/UG4punOntuCpuDIc5
   1FpfURA6s60TOp3uN3FUTDIas13vKwmpAnFU1xt4Mvs+KI3zIswQQgYGh
   A==;
X-CSE-ConnectionGUID: aF9clrLDSdCUIl2PjrJ07A==
X-CSE-MsgGUID: Nojr+s7ZSjKU4pRw+w5AhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="96257149"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="96257149"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 02:45:21 -0700
X-CSE-ConnectionGUID: bS6xCzrUSFq3jpUdTo3EPQ==
X-CSE-MsgGUID: 76+3OtpmRq6zXHTmIOx6xQ==
X-ExtLoop1: 1
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa003.fm.intel.com with ESMTP; 15 Jul 2026 02:45:18 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 747CB95; Wed, 15 Jul 2026 11:45:17 +0200 (CEST)
Date: Wed, 15 Jul 2026 12:45:15 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Ramesh Babu B <ramesh.babu.b@intel.com>,
	"Michael J. Ruhl" <michael.j.ruhl@intel.com>,
	linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 3/3] drm/xe/i2c: Keep the i2c controller always enabled
Message-ID: <aldWqyg_bnt5KsGT@kuha>
References: <20260713155601.711389-1-heikki.krogerus@linux.intel.com>
 <20260713155601.711389-4-heikki.krogerus@linux.intel.com>
 <alcpuxJktaVwrIaa@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alcpuxJktaVwrIaa@black.igk.intel.com>

On Wed, Jul 15, 2026 at 08:33:31AM +0200, Raag Jadav wrote:
> > +/* See "Disabling DW_apb_i2c" in the DesignWare DW_abp_i2c databook. */
> > +static void xe_i2c_disable(struct xe_i2c *i2c)
> > +{
> > +	int timeout = 100;
> > +	u32 status;
> > +
> > +	xe_mmio_rmw32(i2c->mmio, I2C_REG(DW_IC_ENABLE), 1, 0);
> 
> Can we use DW_IC_ENABLE_* defines?
> 
> > +	do {
> > +		status = xe_mmio_read32(i2c->mmio, I2C_REG(DW_IC_ENABLE_STATUS));
> > +		if (!(status & 1))
> 
> Ditto for DW_IC_STATUS_*.
> 
> > +			return;
> > +		/* Can't sleep here. */
> > +		udelay(25);
> > +	} while (timeout--);
> > +
> > +	dev_warn(&i2c->adapter->dev, "timeout in disabling adapter\n");
> > +}
> 
> ...
> 
> > @@ -230,7 +260,28 @@ static int xe_i2c_write(void *context, unsigned int reg, unsigned int val)
> >  {
> >  	struct xe_i2c *i2c = context;
> >  
> > -	xe_mmio_write32(i2c->mmio, XE_REG(reg + I2C_MEM_SPACE_OFFSET), val);
> > +	switch (reg) {
> > +	case DW_IC_CON:
> > +	case DW_IC_TAR:
> > +	case DW_IC_SAR:
> > +		/* Disable the controller. */
> > +		xe_i2c_disable(i2c);
> > +
> > +		/* Write the register. */
> > +		xe_mmio_write32(i2c->mmio, I2C_REG(reg), val);
> > +
> > +		/* Enable the controller. */
> > +		xe_mmio_rmw32(i2c->mmio, I2C_REG(DW_IC_ENABLE), 0, 1);
> 
> Ditto.

Yes to all three. I'll fix these.

Thanks,

-- 
heikki
