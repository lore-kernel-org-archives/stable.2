Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEC140EB94;
	Wed, 15 Jul 2026 12:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784120400; cv=none; b=sZzFazWZB4E40uTanGG0MJ/Hx/9gamlMia7U1D4LBVe51cMyolyc3lwuL3Iv1ueV7YQHwO7T69x+kS3NtrM7SeFLBcS5V/kO8Msg+rl5G2xVmB9hKLPEpEmefGz04ElVvCVoYOh1ebut+3snjpmVLprV1xck97MCLRrcrdyeU/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784120400; c=relaxed/simple;
	bh=w8aJWrF1Nf/0ERxnBiNWFSlFyI2NJKQoDJmBc7nBkSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2QUZA3YTTVRlf+uxyMxmNTqe1RPqhAnz+JAwnwPO4brdipCOkxZgiqqslNKWhhzB2cYFkNsOUYlO4/JpM7Q1EmKcbSE+A6H0DNMzJ8eAB4ywCX2THAfcm6kDS6IlkBTv4NgRcdZsP40qAE6W3+Z/Qu8HVnlnKjb9d1iRpbtRI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DeRW5bV/; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DeRW5bV/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784120397; x=1815656397;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w8aJWrF1Nf/0ERxnBiNWFSlFyI2NJKQoDJmBc7nBkSw=;
  b=DeRW5bV/loXMAhtE2eFeBTOsYIxpk1SxY0sQ+M3uYXL9mJwcenXnn1sZ
   i38Mp6/N1VdX6kc+0whFyrr1HMFws5GZRP+K3EOyki5MRuYZ0ku8iNDTA
   TzlRH41Y1FRF6B3Qh3NXeUo8VV/G6XstgxDgIAuu2L6ZJzCQJg3aNn/Ma
   pNGYVyfX5M3OvjU9exFsxh7nCLpuIMnbKmfvWOUBI7p0Pa9UY+fnQkTFc
   9tWr7jh9w4hI4rKWiMiW6swGJl+b8/bl0fYwtGDcKpvauDpAM0dnh/pcn
   22Hoay0qF/ergR56UZuOCWF8EzH3/QVkw+hfV9BNXDY17iwBgyiwxTnxx
   g==;
X-CSE-ConnectionGUID: TtrXWyg7RVu1JbnhwEfTWQ==
X-CSE-MsgGUID: wg2f+RqWSvmIgsxKtktqbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84638190"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="84638190"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 05:59:55 -0700
X-CSE-ConnectionGUID: s84493LkQq+LsPWRT/uq7Q==
X-CSE-MsgGUID: x0BNHSheR9K3oRoK8oP2iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="286246387"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa002.jf.intel.com with ESMTP; 15 Jul 2026 05:59:52 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 0ACD795; Wed, 15 Jul 2026 14:59:51 +0200 (CEST)
Date: Wed, 15 Jul 2026 15:59:49 +0300
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
Subject: Re: [PATCH v4 2/3] drm/xe/i2c: Fix the interrupt handling
Message-ID: <aleEReNBnQMy3-1E@kuha>
References: <20260713155601.711389-1-heikki.krogerus@linux.intel.com>
 <20260713155601.711389-3-heikki.krogerus@linux.intel.com>
 <alcoDtq2aul-tA_h@black.igk.intel.com>
 <aldYjL2pxA7QxoLN@kuha>
 <ald1HG6KzjWb9CUK@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ald1HG6KzjWb9CUK@black.igk.intel.com>

Hi Raag,

On Wed, Jul 15, 2026 at 01:55:08PM +0200, Raag Jadav wrote:
> On Wed, Jul 15, 2026 at 12:53:16PM +0300, Heikki Krogerus wrote:
> > On Wed, Jul 15, 2026 at 08:26:22AM +0200, Raag Jadav wrote:
> > > On Mon, Jul 13, 2026 at 05:56:00PM +0200, Heikki Krogerus wrote:
> > > > The platforms that support the interrupt from the I2C
> > > > adapter can not handle the amount of interrupts the adapter
> > > > generates because of the way the IRQ is routed in the
> > > > hardware. The I2C controller driver has to be kept in
> > > > polling mode because of that.
> > > > 
> > > > The AMC MCU can still generate critical alerts that have to
> > > > be handled. The interrupt from SMBus Alert is left enabled
> > > > and handled separately in the Xe. The alerts from the AMC
> > > > will cause the device to be declared wedged for now.
> 
> ...
> 
> > > > +	    memcmp(&response.message, &request->message, sizeof(struct amc_message))) {
> > > > +		dev_err(&client->dev, "response does not match the request\n");
> 
> Forgot add, use drm_*() variants where possible.

I used deliberately the dev_*() here so I can use the i2c client
device, which to me feels more appropriate. With drm_*() I would need
to use the drm device, right?

But I can change this if you still prefer the drm_*(). Let me know.

> > > > +		return;
> > > > +	}
> > > > +
> > > > +	if (response.error) {
> > > > +		dev_err(&client->dev, "AMC error 0x%02x\n", response.error);
> 
> Ditto.
> 
> > > > +		return;
> > > > +	}
> > > > +
> > > > +	dev_dbg(&client->dev, "%s: Alert reason: %d\n", __func__, response.value);
> 
> Ditto.
> 
> > > See below [1].
> > > 
> > > > +	switch (response.value) {
> > > > +	case AMC_ALERT_FW_DOWNLOAD:
> > > > +	case AMC_ALERT_THERMAL_TRIP:
> > > > +	case AMC_ALERT_OOB_REQUEST:
> > > > +	case AMC_ALERT_OOB_RESET:
> > > > +	case AMC_ALERT_CATERR:
> > > > +		xe_device_declare_wedged(i2c_client_to_xe_device(client));
> > > > +		break;
> > > > +	default:
> > > > +		break;
> > > > +	}
> > > > +}
> > > 
> > > ...
> > > 
> > > > @@ -181,8 +187,7 @@ void xe_i2c_irq_handler(struct xe_device *xe, u32 master_ctl)
> > > >  	if (!(master_ctl & I2C_IRQ) || !xe_i2c_irq_present(xe))
> > > >  		return;
> > > >  
> > > > -	/* Forward interrupt to I2C adapter */
> > > > -	generic_handle_irq_safe(xe->i2c->adapter_irq);
> > > > +	xe_i2c_handle_smbus_alert(xe->i2c);
> > > 
> > > [1] Can we move the below re-assert code to wq now? Or do you suspect any
> > > side-effects?
> > 
> > I think that you know this better than I do. But at this point
> > interrupt is cleared, so why should we wait for the wq?
> 
> When does AMC clear the alert signal? Is it when you query from the wq?
> If the answer is yes, there's a possibility we might end up with an
> interrupt storm here.
> 
> > To play it safe, can we change this as a followup if necessary?
> 
> Sure, I'll leave it to you.

I'll move it to the wq. There are no side-effects.

> > > >  	xe_mmio_rmw32(mmio, I2C_CONFIG_CMD, 0, PCI_COMMAND_INTX_DISABLE);
> > > >  	xe_mmio_rmw32(mmio, I2C_CONFIG_CMD, PCI_COMMAND_INTX_DISABLE, 0);

Thanks,

-- 
heikki
