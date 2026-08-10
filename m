Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB7D23E330;
	Mon, 10 Aug 2026 05:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786338256; cv=none; b=G7ipF4M/SKmwHe0oJE4XgJrw9KqTMRLjG1WQ2YNp/ej7Nny0yLTgkPt2O9Cazz7QZhTFaguHXN/QgVz2Vw33+OMetb6vvU8dLhxdzbuIFNLWWHDSOE9Yaa1G4GjypUHKOMQ+saLcrwu3sV9tmkC6O9TuX3iBzzldpS83k4bXN5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786338256; c=relaxed/simple;
	bh=jQPdf8DmqbanZTeMg7ogT+/wFnv9gqBcXzKair8aDbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4QF3yCqdhWubwgaAHxKdQPWOWVPh5G4usbL5uZUcXMqP2MmNZMaTvd0sO8Hh+T8awjcrsZ5Trtzn+sTPgGCN1Nwj3TvST2tkvqmHeAnGTUr3c73nyZLgj+uOvYUtJvJakuVn7ckyiyGzCpcpFcEzv/iai9Q2s48WLO7ZkQFKWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OSK/QKeE; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OSK/QKeE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786338255; x=1817874255;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jQPdf8DmqbanZTeMg7ogT+/wFnv9gqBcXzKair8aDbk=;
  b=OSK/QKeEUaGOcuVeI6kUZmJs/lS64MJVlhiTMvkaZ53m6zmnk1usmWXF
   fDkPA9uu0H9iYdJ6btCmmAuqvICQHpW+yyYAj3Ov7Sfe2oP411HPy/ify
   /ZqdgYfss66mye8fwvjKwsPqke8fnUOSYBpTwfgr+WMrhdpH2mB5ReSuQ
   /f6fpwUVdhn5uAe7y0aF41wrU52931x8t4dFeIEf4E3H2v6ESA/UPB4CW
   oPzH1agA+sXdLvvfVYK0/FBDa+odWuYYI/P9S2nQfMcCezGXqRK5ijNyD
   sRkzDfNGLX0xcHguMxD343sk25GCoYO6RzY7WRjbVle+Imy2+Drvw+RYP
   A==;
X-CSE-ConnectionGUID: joFybAjrTtOs9QvIURmemA==
X-CSE-MsgGUID: Du0vzVhHQJOPfanodN+sZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="85812689"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="85812689"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2026 22:04:14 -0700
X-CSE-ConnectionGUID: PsJGjLqzQkK6y+PngpoMNA==
X-CSE-MsgGUID: qOf3pdAMRR6pdI0toafS0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="268098965"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2026 22:04:11 -0700
Date: Mon, 10 Aug 2026 07:04:09 +0200
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
Subject: Re: [PATCH v6 2/3] drm/xe/i2c: Fix the interrupt handling
Message-ID: <anlbyVOUkafs0UHE@black.igk.intel.com>
References: <20260722133554.2079612-1-heikki.krogerus@linux.intel.com>
 <20260722133554.2079612-3-heikki.krogerus@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722133554.2079612-3-heikki.krogerus@linux.intel.com>

On Wed, Jul 22, 2026 at 03:35:53PM +0200, Heikki Krogerus wrote:
> The platforms that support the interrupt from the I2C
> adapter can not handle the amount of interrupts the adapter
> generates because of the way the IRQ is routed in the
> hardware. The I2C controller driver has to be kept in
> polling mode because of that.
> 
> The AMC MCU can still generate critical alerts that have to
> be handled. The interrupt from SMBus Alert is left enabled
> and handled separately in the Xe. The alerts from the AMC
> will cause the device to be declared wedged for now.

...

> +	alert_reason = response.value;
> +	dev_dbg(&client->dev, "Alert reason: %d\n", alert_reason);

This came up in one of the internal reports. We have quite a few call
sites for wedging and it can happen due to various reasons from driver
POV. We really need to identify the source from logs when it happens,
so can we atleast have this one as dev_info()?

All the reasons are rare enough to not spam the logs and it shouldn't be
a problem IMO.

I'm okay with doing it as a follow up if the series is already merged.

Raag

> +out_reassert_interrupt:
> +	xe_mmio_rmw32(amc->i2c->mmio, I2C_CONFIG_CMD, PCI_COMMAND_INTX_DISABLE, 0);
> +
> +	switch (alert_reason) {
> +	case AMC_ALERT_FW_DOWNLOAD:
> +	case AMC_ALERT_THERMAL_TRIP:
> +	case AMC_ALERT_OOB_REQUEST:
> +	case AMC_ALERT_OOB_RESET:
> +	case AMC_ALERT_CATERR:
> +		xe_device_declare_wedged(i2c_client_to_xe_device(client));
> +		break;
> +	default:
> +		break;
> +	}
