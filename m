Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CC42C15A5;
	Mon, 31 Aug 2026 10:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788172634; cv=none; b=FqN2fZu3z5Sqj+XP2fOqvNzgIGSDuRweASePPHHncrgP8ViZJj+1MQ38F8fBTDciHFrfuqA7z3udmH6yYsDdafT7MRiPJcmJpbQx0Pv5o4fc9fnrOgNltBhA+JrPz7XFy0ShmJdoiX28nTyWTB76eUMOfI6j05WOgptTN21kZQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788172634; c=relaxed/simple;
	bh=+UoDTFhAEDQzXAzl1odwHhUN4copmwFG2NFdJ5FgILc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0Pm3+Hb09Gfv0IqnAfGPI6iWRrDa7j8XGm+B6hHajGG7GOQcGqPW7QjOCQVBUFIK8dQMFJ16EzojeupU/bI9RyVBULqh6C8R/F/7+7JvwhoquYYI0pm/r9piXB+wwEo+oYTSRYd5pb1fqXK5psWk/E7LwfNwVYM/T2v68/DJXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iXU/ze68; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iXU/ze68"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788172632; x=1819708632;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+UoDTFhAEDQzXAzl1odwHhUN4copmwFG2NFdJ5FgILc=;
  b=iXU/ze68TY/haykXMYiL2kMjiDV7apRnmXwUhtNlkRZlUw+3LFwr31AP
   gHjkV7z//AzMtalzU9XOUG6rFozUApj0dz7A7qnCvFOYC8ljtbQ81B6FO
   mez8YRAhtgdtBINaqSAz9TrWCEB5xh6UyrRuneTtJTuVoD8TeTlg5UwzO
   kEhIUrgjg5W2WJ8EX3q4k+HuHB3vbZcb+OPQ7GsJyRacFvEgvhGWjmsHv
   HokC6C1dE11TU6yAc5Gg8mrRs9vl9fmob2dPQF5aDXfW47tXl4I0uk2dC
   LenuXx1/p/e+98tjkBDso4In327qtJ/ijAeeGPFaw+Du6Vzp2qKpg8jgZ
   g==;
X-CSE-ConnectionGUID: guzEz+sOStS+CDhqkSCPAQ==
X-CSE-MsgGUID: SAnRAo4IQBmHAfFrA8jVkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="88625975"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="88625975"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 03:37:11 -0700
X-CSE-ConnectionGUID: C3vtV/PkR+SNUpmCECnThw==
X-CSE-MsgGUID: fPIdlb/+RYKfwrbVnoKNyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="268807521"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP; 31 Aug 2026 03:37:09 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 7E13899; Mon, 31 Aug 2026 12:37:08 +0200 (CEST)
Date: Mon, 31 Aug 2026 12:37:08 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Jameson Thies <jthies@google.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	bleung@chromium.org, gregkh@linuxfoundation.org,
	akuchynski@chromium.org, stable@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: ucsi: displayport: Fix OOB altmode array
 index
Message-ID: <apVZVCzUEXp1Ahv2@black.igk.intel.com>
References: <20260825234545.2076049-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825234545.2076049-1-jthies@google.com>

On Tue, Aug 25, 2026 at 11:45:45PM +0000, Jameson Thies wrote:
> The UCSI displayport driver indexes the connector's port altmode array
> with the GET_CURRENT_CAM response after checking it is not 0xff. The
> port altmode array is UCSI_MAX_ALTMODES elements long. If the PPM
> returns an invalid GET_CURRENT_CAM response above UCSI_MAX_ALTMODES and
> not equal to 0xff, the kernel may crash with an array index OOB error.
> 
> Update the UCSI displayport driver to verify the current cam is less
> than UCSI_MAX_ALTMODES before accessing the port altmode array.
> 
> Fixes: af8622f6a585 ("usb: typec: ucsi: Support for DisplayPort alt mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jameson Thies <jthies@google.com>
> ---
>  drivers/usb/typec/ucsi/displayport.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/ucsi/displayport.c b/drivers/usb/typec/ucsi/displayport.c
> index 7067f2561b84..8d2032d0762c 100644
> --- a/drivers/usb/typec/ucsi/displayport.c
> +++ b/drivers/usb/typec/ucsi/displayport.c
> @@ -74,7 +74,7 @@ static int ucsi_displayport_enter(struct typec_altmode *alt, u32 *vdo)
>  		cur = 0xff;

Can you remove the above line while at it?

>  	}
>  
> -	if (cur != 0xff) {
> +	if (cur < UCSI_MAX_ALTMODES) {

Shouldn't that be the other way around?

>  		ret = dp->con->port_altmode[cur] == alt ? 0 : -EBUSY;
>  		goto err_unlock;
>  	}

Thanks,

-- 
heikki
