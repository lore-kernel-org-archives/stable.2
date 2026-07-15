Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B8B2931C2;
	Wed, 15 Jul 2026 09:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784109204; cv=none; b=NSsiwFfCh+rGFiey9RAbwx85PCHjjVWbmsV9v4W1PdyV6kweoutodHCNczW69ecepG/0ibxhA1c1D0G2sz0QXKU+iI/lf46BQB++PN9n7Olt9Fs+VxCL1/t8/IZCBRNk1ZI53PEK113v1b0qf8U3aZcaHinOhHT1I4MEOBP5loQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784109204; c=relaxed/simple;
	bh=6Th/RXyykNSrIqrevfiN5rbJul6P9tKqyVwuBd89v7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjNxgS80R3w6V16T6W5j8FHrjTFXZPkrq4Q9zLhNJ4Lcj21v661muvZCa90Ovw67LmNFU7LQUqhYD8KZNN7mFXLrN3vmDNHn9Bai5W3btuYW+d6FOwVeNuTWw8/7Yg4+LcOuzmaCRWq7v6SYt4+hiAQWjYtaEd0e127MZxjrJdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fJ7wLgkE; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fJ7wLgkE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784109203; x=1815645203;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6Th/RXyykNSrIqrevfiN5rbJul6P9tKqyVwuBd89v7E=;
  b=fJ7wLgkEsSxJW7Ahk0BFTmzOJtD6ias4sM+mms/INe9gBPwSOxOtlt/P
   pM1CG3LlZ5fvba39GMWBzGy7uYjx0vTkKV+HUoMVWCvt5HA2BVz7RSafb
   cZsO/Zvjmaw9bokN7oFyUTzelHg2MzEPs3g7Q678BZHUB4zutAvBOBEJ+
   3+/Xn+Ewfz/okZHDo0KMJc0yUFo4FXJxzsnGjC/U8Jpghyi0XAp3F8Zl4
   2cEjcvr7rux1X25/Tt/RPT9nkXqXNFBs0EMEWk1YbAV9IlnrntG2rogr3
   5O4TAqyopOZ4R6obtrmVKRIyP2oueqbOxxnaJNe8xbBjfaT+WSV/py+F3
   w==;
X-CSE-ConnectionGUID: 5ECzR+8lTN6CB7Sq9ZJf7w==
X-CSE-MsgGUID: MFALIqcTS4u/QwDOemsAIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="88643901"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="88643901"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 02:53:22 -0700
X-CSE-ConnectionGUID: 7KWkKS7ES2qZaJdubtX2wQ==
X-CSE-MsgGUID: //QGPZhlQMmswNeqt5C3qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="255627747"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa008.jf.intel.com with ESMTP; 15 Jul 2026 02:53:19 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 72A4495; Wed, 15 Jul 2026 11:53:18 +0200 (CEST)
Date: Wed, 15 Jul 2026 12:53:16 +0300
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
Message-ID: <aldYjL2pxA7QxoLN@kuha>
References: <20260713155601.711389-1-heikki.krogerus@linux.intel.com>
 <20260713155601.711389-3-heikki.krogerus@linux.intel.com>
 <alcoDtq2aul-tA_h@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alcoDtq2aul-tA_h@black.igk.intel.com>

On Wed, Jul 15, 2026 at 08:26:22AM +0200, Raag Jadav wrote:
> On Mon, Jul 13, 2026 at 05:56:00PM +0200, Heikki Krogerus wrote:
> > The platforms that support the interrupt from the I2C
> > adapter can not handle the amount of interrupts the adapter
> > generates because of the way the IRQ is routed in the
> > hardware. The I2C controller driver has to be kept in
> > polling mode because of that.
> > 
> > The AMC MCU can still generate critical alerts that have to
> > be handled. The interrupt from SMBus Alert is left enabled
> > and handled separately in the Xe. The alerts from the AMC
> > will cause the device to be declared wedged for now.
> 
> ...
> 
> > +static void xe_amc_work(struct work_struct *work)
> > +{
> > +	struct xe_amc *amc = from_work(amc, work, work);
> > +	struct i2c_client *client = amc->i2c->client[XE_I2C_CLIENT_AMC];
> > +	const struct amc_request *request = &amc_get_alert_reason;
> > +	struct amc_response response;
> > +	int ret;
> > +
> > +	ret = i2c_master_send(client, (u8 *)request, sizeof(*request));
> > +	if (ret < 0) {
> > +		dev_err(&client->dev, "failed to send request (%d)\n", ret);
> > +		return;
> > +	}
> > +
> > +	fsleep(20 * USEC_PER_MSEC);
> 
> Nit: Probably worth an explanation.

Sure.

> > +	ret = i2c_master_recv(client, (u8 *)&response, sizeof(response));
> > +	if (ret < 0) {
> > +		dev_err(&client->dev, "failed to read response (%d)\n", ret);
> > +		return;
> > +	}
> > +
> > +	if (response.header.len == 0) {
> 
> Nit: Perhaps !response.header.len?

OK.

> > +		dev_err(&client->dev, "empty response from AMC\n");
> > +		return;
> > +	}
> > +
> > +	if (response.header.command != request->header.command ||
> 
> Curious, what about the rest of the header? Would it be any different?

The command is the only field that matches. But that check is not
needed. The command is always the same. I'll drop that line.

> > +	    memcmp(&response.message, &request->message, sizeof(struct amc_message))) {
> > +		dev_err(&client->dev, "response does not match the request\n");
> > +		return;
> > +	}
> > +
> > +	if (response.error) {
> > +		dev_err(&client->dev, "AMC error 0x%02x\n", response.error);
> > +		return;
> > +	}
> > +
> > +	dev_dbg(&client->dev, "%s: Alert reason: %d\n", __func__, response.value);
> 
> See below [1].
> 
> > +	switch (response.value) {
> > +	case AMC_ALERT_FW_DOWNLOAD:
> > +	case AMC_ALERT_THERMAL_TRIP:
> > +	case AMC_ALERT_OOB_REQUEST:
> > +	case AMC_ALERT_OOB_RESET:
> > +	case AMC_ALERT_CATERR:
> > +		xe_device_declare_wedged(i2c_client_to_xe_device(client));
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +}
> 
> ...
> 
> > @@ -181,8 +187,7 @@ void xe_i2c_irq_handler(struct xe_device *xe, u32 master_ctl)
> >  	if (!(master_ctl & I2C_IRQ) || !xe_i2c_irq_present(xe))
> >  		return;
> >  
> > -	/* Forward interrupt to I2C adapter */
> > -	generic_handle_irq_safe(xe->i2c->adapter_irq);
> > +	xe_i2c_handle_smbus_alert(xe->i2c);
> 
> [1] Can we move the below re-assert code to wq now? Or do you suspect any
> side-effects?

I think that you know this better than I do. But at this point
interrupt is cleared, so why should we wait for the wq?

To play it safe, can we change this as a followup if necessary?

> >  	/* Deassert after I2C adapter clears the interrupt */
> >  	xe_mmio_rmw32(mmio, I2C_CONFIG_CMD, 0, PCI_COMMAND_INTX_DISABLE);
> > @@ -212,45 +217,6 @@ void xe_i2c_irq_postinstall(struct xe_device *xe)
> >  	xe_mmio_rmw32(mmio, I2C_CONFIG_CMD, PCI_COMMAND_INTX_DISABLE, 0);
> >  }
> 
> ...
> 
> > -#define XE_I2C_MAX_CLIENTS		3
> > -
> >  #define XE_I2C_EP_COOKIE_DEVICE		0xde
> >  
> >  /* Endpoint Capabilities */
> >  #define XE_I2C_EP_CAP_IRQ		BIT(0)
> >  
> > +enum XE_I2C_CLIENT {
> > +	XE_I2C_CLIENT_AMC,
> > +	XE_I2C_MAX_CLIENTS = 3,
> 
> I know it was already like this but I probably missed why do we have 3
> (atleast from driver POV)?

That is the maximum number of clients these platforms can support.
The AMC address is actually at a fixed offset 1. I'll change this so
that XE_I2C_CLIENT_AMC matches the offset:

enum XE_I2C_CLIENT {
	XE_I2C_CLIENT_AMC = 1,
	XE_I2C_MAX_CLIENTS = 3,
};

That probable makes this a bit more clear (right?).

Thanks,

-- 
heikki
