Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EA851FCBB;
	Mon,  7 Sep 2026 17:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788803040; cv=none; b=rtqGPeNYHzpYwkqcgYg2txBc2TLcastglhRkmSyUpPR4HAqWlN443E4tF7clUi5zlQMn2GvF1euSHk0T+a7P6F4tBHFO/7fK7XavyPHrjwATA6WpTEq9Q2GGqOx+VMCoEycmyJd9PooeYb0EX/2Bb5wS8QmzuyyVr6gS4P/mZj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788803040; c=relaxed/simple;
	bh=RrZu78JtYcG/qoOZeEqnWYf/XPk9OKGQE+i4k2jsvM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIO7NHdA1UpyggD58fkeREyIGxO9AJiJA8UqlELoddna1BAqwa1wRI0nI2SIof6pPtX3hjPTadVbdgo+mRIZFwIuxaO1mji9XvYdm/0KTLySeFKFh1sMW1w8MpEKFtvBfprhDeAtR1p44Imb912QW9W0E+VV8QH6n4CI7e7b+xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vx/NhQSt; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vx/NhQSt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788803038; x=1820339038;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RrZu78JtYcG/qoOZeEqnWYf/XPk9OKGQE+i4k2jsvM4=;
  b=Vx/NhQSt0Wf0HM2+XgfhYEtjviQgwSgBYTY2A0GMUB05UwCXrsZf5oUA
   cQbii1NtPWYgyYvikIuUI6unwN+5VV5foUBOUQksUdochbVulu/vPL7Iz
   Qv2+S4yk+XcGXxzShjyKL+eh3grfZh3+qSS6rWkj5MT4G3JmzZ9dULTLI
   FmkyMxtq+3PHD7fnYLPCk9O/twd8TgVWg4/mtaJA0oAqphl0OOzgC0hG7
   qhZi3768B4KuzQ+5lIki+3Gw2TZEFvdR7S37a6KpUm+S2/9edqiCl9qAd
   H/vpqJyqHyG+rBgRCKlBRSZuBf+zjRexShjgUdNKrRpcXe0jtSKqE4dqw
   Q==;
X-CSE-ConnectionGUID: BwefiwgkRxiHolNsbA0wsA==
X-CSE-MsgGUID: 1layvQoGQm6ZnIghCkhBiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="100729550"
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; 
   d="scan'208";a="100729550"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 10:43:57 -0700
X-CSE-ConnectionGUID: GUjS52WpS6qtzgGuDQfvIA==
X-CSE-MsgGUID: KyXBB8v/SMKARz6OFCyLEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; 
   d="scan'208";a="267510655"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa007.fm.intel.com with ESMTP; 07 Sep 2026 10:43:55 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id D156499; Mon, 07 Sep 2026 19:43:53 +0200 (CEST)
Date: Mon, 7 Sep 2026 19:43:53 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Jameson Thies <jthies@google.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	bleung@chromium.org, gregkh@linuxfoundation.org,
	akuchynski@chromium.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: ucsi: displayport: Fix OOB altmode array
 index
Message-ID: <ap732UoS0zqjg_9r@black.igk.intel.com>
References: <20260904234401.2339633-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904234401.2339633-1-jthies@google.com>

On Fri, Sep 04, 2026 at 11:44:01PM +0000, Jameson Thies wrote:
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

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes in v2:
>  - removed 0xff alt mode assignement when GET_CURRENT_CAM returns an error.
>  - return -EINVAL when alt mode index above UCSI_MAX_ALTMODES is returned.
> 
>  drivers/usb/typec/ucsi/displayport.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/displayport.c b/drivers/usb/typec/ucsi/displayport.c
> index 7067f2561b84..572da7bbd29c 100644
> --- a/drivers/usb/typec/ucsi/displayport.c
> +++ b/drivers/usb/typec/ucsi/displayport.c
> @@ -71,11 +71,14 @@ static int ucsi_displayport_enter(struct typec_altmode *alt, u32 *vdo)
>  	if (ret < 0) {
>  		if (ucsi->version > 0x0100)
>  			goto err_unlock;
> -		cur = 0xff;
>  	}
>  
>  	if (cur != 0xff) {
> -		ret = dp->con->port_altmode[cur] == alt ? 0 : -EBUSY;
> +		if (cur < UCSI_MAX_ALTMODES)
> +			ret = dp->con->port_altmode[cur] == alt ? 0 : -EBUSY;
> +		else
> +			ret = -EINVAL;
> +
>  		goto err_unlock;
>  	}
>  
> 
> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
> -- 
> 2.55.0.979.g7e5102b832-goog

-- 
heikki
