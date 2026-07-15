Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373D8448CE1;
	Wed, 15 Jul 2026 11:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784116517; cv=none; b=cFwAGXLuDxaWrTwRJfLLS0nSCV3nVcv7twP72bKX18kJGKqPA7UeiqmgwrDubscCeIDPFtoI2I62NTgHM6okcnNOLdy2DO1ci5teNuDaTejaYywgHJMu6I1vtm6esA/PuX6Ny7gDfmcooLxt36FGNRNmlQwAnqSOQqquvmFiv3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784116517; c=relaxed/simple;
	bh=NiI3H4QRbyjalnLO2FOTr0Npjt27DSj0yNz1CRgg7PU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NqPPZd3e8QarxUVjzRA4hPl5XQ79sXrDwjo53cLiqoSXKL8FePtYQJBMRYTSt4stPXFPJSV/jntJhLXsxFV7WWj4CzaE7QSW68fOer1eLDM8ww4Kr9pkBxsAxePZE+kfTtZ2OPSrW08JvqxPGcmk4BdKh1zRtjkOjYz+Lc4ttiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ciBaqtog; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ciBaqtog"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784116516; x=1815652516;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NiI3H4QRbyjalnLO2FOTr0Npjt27DSj0yNz1CRgg7PU=;
  b=ciBaqtogFsLYqG2eILKVjBRVNBASQGvg8HH97YxUSIZggIFhNeoCxNtG
   8tKkhJTO/0FWXkDP52yNcNzAMubQGBpPOl3BxjLoS8hfkX7vc4ZIY3v5M
   bYwDaiu097VEDrhfFvNtVDSZSp9tUpFzwsU2M2KJBcLOWQ3d5pZAKuYb3
   1OyIpmARXlGk/4Mea0JugvYUs64kUWEjRbtx+GQpXugMr3noOdvbotcLC
   8bWGoWSAC5vSVAnzY2uSDdfawszMM1vTNkYuIOSQ5h1wz3vzOcIbXy2H6
   5mNXBOHC8GidjjSKODJJ7hGDIYZTi8MBQqzCYcUdGGJbMtyvo8NUzdjND
   A==;
X-CSE-ConnectionGUID: /es5pajfTf6magvFzSy2QQ==
X-CSE-MsgGUID: sF33twFTQBW9w9SgPu92Sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84776860"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="84776860"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 04:55:14 -0700
X-CSE-ConnectionGUID: ORXn5ai7RfmdyHT/uP2wSA==
X-CSE-MsgGUID: Vu7QXx7TSLyLxbnbwisE6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="261067409"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 04:55:11 -0700
Date: Wed, 15 Jul 2026 13:55:08 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
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
Subject: Re: [PATCH v4 2/3] drm/xe/i2c: Fix the interrupt handling
Message-ID: <ald1HG6KzjWb9CUK@black.igk.intel.com>
References: <20260713155601.711389-1-heikki.krogerus@linux.intel.com>
 <20260713155601.711389-3-heikki.krogerus@linux.intel.com>
 <alcoDtq2aul-tA_h@black.igk.intel.com>
 <aldYjL2pxA7QxoLN@kuha>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aldYjL2pxA7QxoLN@kuha>

On Wed, Jul 15, 2026 at 12:53:16PM +0300, Heikki Krogerus wrote:
> On Wed, Jul 15, 2026 at 08:26:22AM +0200, Raag Jadav wrote:
> > On Mon, Jul 13, 2026 at 05:56:00PM +0200, Heikki Krogerus wrote:
> > > The platforms that support the interrupt from the I2C
> > > adapter can not handle the amount of interrupts the adapter
> > > generates because of the way the IRQ is routed in the
> > > hardware. The I2C controller driver has to be kept in
> > > polling mode because of that.
> > > 
> > > The AMC MCU can still generate critical alerts that have to
> > > be handled. The interrupt from SMBus Alert is left enabled
> > > and handled separately in the Xe. The alerts from the AMC
> > > will cause the device to be declared wedged for now.

...

> > > +	    memcmp(&response.message, &request->message, sizeof(struct amc_message))) {
> > > +		dev_err(&client->dev, "response does not match the request\n");

Forgot add, use drm_*() variants where possible.

> > > +		return;
> > > +	}
> > > +
> > > +	if (response.error) {
> > > +		dev_err(&client->dev, "AMC error 0x%02x\n", response.error);

Ditto.

> > > +		return;
> > > +	}
> > > +
> > > +	dev_dbg(&client->dev, "%s: Alert reason: %d\n", __func__, response.value);

Ditto.

> > See below [1].
> > 
> > > +	switch (response.value) {
> > > +	case AMC_ALERT_FW_DOWNLOAD:
> > > +	case AMC_ALERT_THERMAL_TRIP:
> > > +	case AMC_ALERT_OOB_REQUEST:
> > > +	case AMC_ALERT_OOB_RESET:
> > > +	case AMC_ALERT_CATERR:
> > > +		xe_device_declare_wedged(i2c_client_to_xe_device(client));
> > > +		break;
> > > +	default:
> > > +		break;
> > > +	}
> > > +}
> > 
> > ...
> > 
> > > @@ -181,8 +187,7 @@ void xe_i2c_irq_handler(struct xe_device *xe, u32 master_ctl)
> > >  	if (!(master_ctl & I2C_IRQ) || !xe_i2c_irq_present(xe))
> > >  		return;
> > >  
> > > -	/* Forward interrupt to I2C adapter */
> > > -	generic_handle_irq_safe(xe->i2c->adapter_irq);
> > > +	xe_i2c_handle_smbus_alert(xe->i2c);
> > 
> > [1] Can we move the below re-assert code to wq now? Or do you suspect any
> > side-effects?
> 
> I think that you know this better than I do. But at this point
> interrupt is cleared, so why should we wait for the wq?

When does AMC clear the alert signal? Is it when you query from the wq?
If the answer is yes, there's a possibility we might end up with an
interrupt storm here.

> To play it safe, can we change this as a followup if necessary?

Sure, I'll leave it to you.

> > >  	/* Deassert after I2C adapter clears the interrupt */
> > >  	xe_mmio_rmw32(mmio, I2C_CONFIG_CMD, 0, PCI_COMMAND_INTX_DISABLE);
> > > @@ -212,45 +217,6 @@ void xe_i2c_irq_postinstall(struct xe_device *xe)
> > >  	xe_mmio_rmw32(mmio, I2C_CONFIG_CMD, PCI_COMMAND_INTX_DISABLE, 0);
> > >  }
> > 
> > ...
> > 
> > > -#define XE_I2C_MAX_CLIENTS		3
> > > -
> > >  #define XE_I2C_EP_COOKIE_DEVICE		0xde
> > >  
> > >  /* Endpoint Capabilities */
> > >  #define XE_I2C_EP_CAP_IRQ		BIT(0)
> > >  
> > > +enum XE_I2C_CLIENT {
> > > +	XE_I2C_CLIENT_AMC,
> > > +	XE_I2C_MAX_CLIENTS = 3,
> > 
> > I know it was already like this but I probably missed why do we have 3
> > (atleast from driver POV)?
> 
> That is the maximum number of clients these platforms can support.
> The AMC address is actually at a fixed offset 1. I'll change this so
> that XE_I2C_CLIENT_AMC matches the offset:
> 
> enum XE_I2C_CLIENT {
> 	XE_I2C_CLIENT_AMC = 1,
> 	XE_I2C_MAX_CLIENTS = 3,
> };
> 
> That probable makes this a bit more clear (right?).

With that I think these can be used as ep.addr[] indexes as well, but
I'll leave them at your mercy.

Raag
