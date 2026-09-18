Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9248B418A29;
	Fri, 18 Sep 2026 09:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789725189; cv=none; b=X6AZ2xt8T74E3Wok8s4ZnlYHjJtBoMorYUcz8xb1OuiZY8gRoFhz6PRNu+cP6Uy6Ij1E2rahp5fIHD9+V1RJ+tM3hlcSqjcqgJG16tnGGcCDDYCaSscqKT53b2cGhcay39uZwfcn50P3mhd0smPMNMfCMxvQCJj6WW98zKUt0Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789725189; c=relaxed/simple;
	bh=A2BCPxbyBOcu7X3icYlUuLbRwiLcqIjGSpxVUnQ2rDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WkQZZuaOo0sZc6r0K4S0XwmVLl67YgabYIkqPjltqVJxQnH06pu3D6j14slLEjGwg9/FAx66iS3/EMm7GGzHm8rZ3wz6cZzEOadSA6EmOGpCJQpDJeZzQ1uMJCtNmctCLESkeEZUj8P81QPvGDTi4ioJpPtejt5JUrHzp8uAdS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uesenlux; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uesenlux"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789725187; x=1821261187;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A2BCPxbyBOcu7X3icYlUuLbRwiLcqIjGSpxVUnQ2rDc=;
  b=UesenluxtXyx5EScbqUh+X08XINN7DB0Xs/gN7z2EzELSPLb4S9PAc+r
   ASbwInQF40yGtdu13ittnzsHXeSAkVLLnZEqYzwpBqoJybEl5YmMByHUV
   XHdSZiwqs5lQkKjehi/gpwjCJXOUiUMCJByNjV+WM2QzBMLv3iyPzmgj8
   LT7FQv959Udxd3IqHljct/qIaWVOlvSg0tTgmM1Z4srAtMOP9ZsE8Uxxm
   7pDiKQKHmKe+Q1MonaSMceTQFyJKReU4CqEml0rGg8C3HkJnI70vKpkUN
   om/sHwEkuzsdQZC2NGcJ5L61EgNi4QjeH65VMLiTU/9AygdzKRVQeIxVj
   w==;
X-CSE-ConnectionGUID: uQCBPyz4Q4Wjr7co041UxA==
X-CSE-MsgGUID: 3FxkxgrGQJqUQKijZs8yfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="90085849"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="90085849"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 02:53:07 -0700
X-CSE-ConnectionGUID: 35Z2PhwCRF+Bwer0KXRtBQ==
X-CSE-MsgGUID: w4LxUBk0SruRMJi41bUAKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="268066188"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa009.fm.intel.com with ESMTP; 18 Sep 2026 02:53:05 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 57B9699; Fri, 18 Sep 2026 11:53:00 +0200 (CEST)
Date: Fri, 18 Sep 2026 11:53:00 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] usb: typec: Fix PD object leak in
 select_usb_power_delivery_store()
Message-ID: <aq0J_PL-T0ccaAGf@black.igk.intel.com>
References: <20260916170139.2085947-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916170139.2085947-1-vulab@iscas.ac.cn>

On Wed, Sep 16, 2026 at 05:01:39PM +0000, Wentao Liang wrote:
> select_usb_power_delivery_store() looks up the requested USB Power
> Delivery object with usb_power_delivery_find(), which returns the
> object with a reference taken by class_find_device_by_name(). The
> reference is never dropped, neither when port->ops->pd_set() fails nor
> when it succeeds, leaking a reference to the USB PD object on every
> sysfs store.
> 
> Drop the reference with put_device() once the pd_set() callback has
> returned and the object is no longer needed.
> 
> Fixes: a7cff92f0635 ("usb: typec: USB Power Delivery helpers for ports and partners")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

There seems to already be a fix for this:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=43ae2f90b70cda374c487c1639a01d0f14e5d583

Thanks,

> ---
>  drivers/usb/typec/class.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 0977581ad1b6..0595e8cb83aa 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -1619,6 +1619,7 @@ static ssize_t select_usb_power_delivery_store(struct device *dev,
>  		return -EINVAL;
>  
>  	ret = port->ops->pd_set(port, pd);
> +	put_device(&pd->dev);
>  	if (ret)
>  		return ret;
>  
> -- 
> 2.34.1

-- 
heikki
