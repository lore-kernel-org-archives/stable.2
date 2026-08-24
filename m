Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACD136E47A;
	Mon, 24 Aug 2026 11:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787571866; cv=none; b=lK7KUhAJ/PJVxJXRQHnEMq3tBg2pknp7nRyQMada3bXAViuR/W/H6c3uVyPVVryOi9PetFxizLfi5QnfcXFz5xSk1EEtiheKTsUsVsgya1/JgspIgS9l+Vsd199rrolqNZizeYE5QM3DDduu9oD71WoM+m8DIn6mhaVALLCnV7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787571866; c=relaxed/simple;
	bh=8dMroJ6R4SVI3fX5UOq5PtSj2MZW8u6Wq0GtJPp5ERs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/a5zHTS14SbhSChkjyxtCUNCe+ozjaD6J/ha7GYx1rTcsJq4l+jsh6pIz7mN/UY3W2ocjO/rAX76aiNtGfBPRDknC7HZqCY/uG6x199PlM1vHx1vCQMR1GUush9hKjutiVhe+856y8CBHXLfr/rMCIKyVydIjUluVyKFG8OojU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dBTSqZYt; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dBTSqZYt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787571863; x=1819107863;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8dMroJ6R4SVI3fX5UOq5PtSj2MZW8u6Wq0GtJPp5ERs=;
  b=dBTSqZYtyC7k//0EYa9hyCiOxqo7gdN3BXqQ1nqijsCEuMO78pYUQCu0
   1wQZN6ihHXGW4DLii0KpYZekEAUys8MX1HZ4rzhGCAjGNIsshXZ337oyD
   SQ+fMGDB4tIb1yk65TNvuC8kfBEZ+rr+7y36ZrQ9QaecN6fvicXz9zt2B
   UyCwBBK19FnFR/gZa2wJl65pDdKhbOkKXatk4h9wuzJLrC6x+07R/YXhy
   EjX+19zriuPauMfnugdBgjKVCN7mypn+uT0BtiG43bA2WRQuV956tNQf7
   7Gd0bJMioakMnOXdMY5N7YJsdh3Pe2hdJQ5dYBTclgmSHSQF6GPj0tu/I
   g==;
X-CSE-ConnectionGUID: bKLezaaFRHSNZe9bjQvh/Q==
X-CSE-MsgGUID: qCArPhcAQtKh+2u+RA6e0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="87880139"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="87880139"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 04:44:22 -0700
X-CSE-ConnectionGUID: IGlGSQ5RRz2Rjl+6R/EQiA==
X-CSE-MsgGUID: N3CdhxTyQ9CxxCgpHwUjYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="291821322"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa001.fm.intel.com with ESMTP; 24 Aug 2026 04:44:20 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 0D26699; Mon, 24 Aug 2026 13:44:19 +0200 (CEST)
Date: Mon, 24 Aug 2026 13:44:19 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Marek Vasut <marex@nabladev.com>
Cc: linux-usb@vger.kernel.org, stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	kernel@dh-electronics.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: mux: Fix typec_switch_match()
Message-ID: <aowuk3WwJW2Jomz8@black.igk.intel.com>
References: <20260817182302.146546-1-marex@nabladev.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817182302.146546-1-marex@nabladev.com>

On Mon, Aug 17, 2026 at 08:22:39PM +0200, Marek Vasut wrote:
> The fwnode_typec_switch_get() sporadically returns NULL instead of an
> -EPROBE_DEFER for orientation-switch described in DT. This makes it
> impossible to discern whether the DT does describe an orientation-switch
> which did not probe yet, or whether the DT does not describe the switch.
> This happens with gpio-sbu-mux connected to an I2C GPIO expander.
> 
> The class_find_device() on typec_switch_match() may return NULL in case
> the mux did not probe just yet early on boot. The sw_devs[] array can be
> empty on boot as well. If these two conditions occur, then the conditional
> if (to_typec_switch_dev(dev) == sw_devs[i]) evaluates to true and the match
> function returns NULL, which propagates to fwnode_typec_switch_get() which
> makes it look as if the orientation-switch was not described in DT.
> 
> This is incorrect, because the mux driver will probe a bit later on, but
> at that point, the caller of fwnode_typec_switch_get() already got the
> NULL return value. The NULL return value also does not trigger IS_ERR(),
> therefore the caller driver interprets this as if the orientation-switch
> is not described in DT, and does not return -EPROBE_DEFER to try again,
> even if it should.
> 
> Fix this by checking the class_find_device() return value, and return
> -EPROBE_DEFER if it is NULL right away. If the return value is not NULL,
> perform the deduplication test, and if that test passes, consider the
> return value to be already non-NULL.
> 
> Fixes: a53b4f9c51a9 ("usb: typec: mux: avoid duplicated orientation switches")
> Cc: stable@vger.kernel.org
> Signed-off-by: Marek Vasut <marex@nabladev.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
> Cc: kernel@dh-electronics.com
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-usb@vger.kernel.org
> ---
> NOTE: A similar change was reverted in
>       f576c75f95a5 ("Revert "usb: typec: mux: avoid duplicated mux switches"")
>       Maybe the orientation switch commit also needs a revert ?
>       Or the mux switch revert can be undone and fixed using this NULL check ?
> ---
>  drivers/usb/typec/mux.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
> index 9b908c46bd7df..2bc7e8edb3cbd 100644
> --- a/drivers/usb/typec/mux.c
> +++ b/drivers/usb/typec/mux.c
> @@ -56,17 +56,19 @@ static void *typec_switch_match(const struct fwnode_handle *fwnode,
>  	 * function "defers probe" for now.
>  	 */
>  	dev = class_find_device(&typec_mux_class, NULL, fwnode,
>  				switch_fwnode_match);
> +	if (!dev)
> +		return ERR_PTR(-EPROBE_DEFER);
>  
>  	/* Skip duplicates */
>  	for (i = 0; i < TYPEC_MUX_MAX_DEVS; i++)
>  		if (to_typec_switch_dev(dev) == sw_devs[i]) {
>  			put_device(dev);
>  			return NULL;
>  		}
>  
> -	return dev ? to_typec_switch_dev(dev) : ERR_PTR(-EPROBE_DEFER);
> +	return to_typec_switch_dev(dev);
>  }
>  
>  /**
>   * fwnode_typec_switch_get - Find USB Type-C orientation switch
> -- 
> 2.53.0

-- 
heikki
