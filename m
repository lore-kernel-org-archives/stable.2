Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFCB3A2E39;
	Fri, 18 Sep 2026 09:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789723105; cv=none; b=jFleXmu1+1WmIlrOaotlOF1DBW25egG8tsDM18dRuAWXTv2mzSft9cBCt64+n8AZtg4TjtMShPLsEqwivSdWWhQ3/+NJHfEXhsV5dTj9pebiibJbqYcf6mebjYN0iHsTRg934a/2vBY3OEEo4dkMW8RZUamOY1xH3UErQBivbdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789723105; c=relaxed/simple;
	bh=E8AsN97Bu2/b8qLr0ls10sRcfdh5cijJGRteM0JRgEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKJK3Bnf1RpA6yJH/SGgR+p9iAOY2yCdRFrJeSOVhaaFpLzsTweHcviUA9yJAldsRjlwaDjZbGZDaHElrqRSXBlc27XFOEyMfcFilkHFKAZZrlusWn2SkFcyoUajJeD+OxVz3tJiIu1izv1EXB7QGpsthMmtmlKaouUjc781oa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c3kKt1RX; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c3kKt1RX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789723102; x=1821259102;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E8AsN97Bu2/b8qLr0ls10sRcfdh5cijJGRteM0JRgEE=;
  b=c3kKt1RXcCPAF+DQVpAyS2ovThyKLTyCZrYeMCpzsOerQvHYBKLYVG63
   LPf9M9etsBrv1lFfVtVg89ZT6DTCTZ8LfXD+Oaey7K0bgZ8WAHz8Scxv0
   2hFW2M7FOgRxZd1K+q1S678JNlAn58ZIkWxSedfCFVfdv3RU9zEJ1dDSP
   k1s74NA8H4siijlxOJcWPjxaKgW/IwlJGeVxVjkTVicCFORT91gZ8cyKf
   HgeNkYqYLLWv8YgQz4tdV47NfaIj3LDJAx0DeLrW1E+5H6fLLtoSzRvV6
   woPQPMUJltoclf22pDmTY4bjNtyZ1b+VDpbRmzjJjBWp2zxOXwi0sIeBb
   w==;
X-CSE-ConnectionGUID: 8qzh1BLsSMic10rkmTIRqw==
X-CSE-MsgGUID: l1i0XQPZQlmnoUhu8oIV/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="94049250"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="94049250"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 02:18:20 -0700
X-CSE-ConnectionGUID: fqJsv+fcR82bZkY5be73tQ==
X-CSE-MsgGUID: iZCqG7kETFeT3ZPpErXKmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="2533060"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa011.fm.intel.com with ESMTP; 18 Sep 2026 02:18:19 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 5B6A999; Fri, 18 Sep 2026 11:18:13 +0200 (CEST)
Date: Fri, 18 Sep 2026 11:18:13 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Prashanth K <prashanth.k@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: Get the connector fwnode based on reg
 value
Message-ID: <aq0B1fbrqk5_ppsv@black.igk.intel.com>
References: <20260916042808.2879079-1-prashanth.k@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916042808.2879079-1-prashanth.k@oss.qualcomm.com>

On Wed, Sep 16, 2026 at 09:58:08AM +0530, Prashanth K wrote:
> ucsi_find_fwnode() currently maps UCSI connectors to Device tree
> connector nodes based on the order in which connector child nodes
> are described in DT.
> 
> This can fail because the ordering of child nodes isn't guaranteed
> in Device-tree. For example, DTB may contain connector@1 before
> connector@0, causing connector numbers to be associated with the wrong
> fwnode. As a result, role switch and Type-C notifications can be
> delivered to the wrong remote endpoints.
> 
> Fix this by using the "reg" property of each connector to match
> its corresponding fwnode. While at it, if the reg property isn't
> present, then fall back to the old method.
> 
> Fixes: c1b0bc2dabfa ("usb: typec: Add support for UCSI interface")

That commit does not yet include any kind of support for DT.

Thanks,

> Cc: stable@vger.kernel.org
> Signed-off-by: Prashanth K <prashanth.k@oss.qualcomm.com>
> ---
>  drivers/usb/typec/ucsi/ucsi.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index bef3f9b71d71..c1450639c795 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -1801,10 +1801,21 @@ static struct fwnode_handle *ucsi_find_fwnode(struct ucsi_connector *con)
>  {
>  	struct fwnode_handle *fwnode;
>  	int i = 1;
> +	int ret;
> +	u32 port;
>  
> -	device_for_each_child_node(con->ucsi->dev, fwnode)
> -		if (i++ == con->num)
> -			return fwnode;
> +	device_for_each_child_node(con->ucsi->dev, fwnode) {
> +		ret = fwnode_property_read_u32(fwnode, "reg", &port);
> +		if (ret < 0) {
> +			if (i == con->num)
> +				return fwnode;
> +		} else {
> +			if (port == con->num - 1)
> +				return fwnode;
> +		}
> +
> +		i++;
> +	}
>  	return NULL;
>  }
>  
> -- 
> 2.34.1

-- 
heikki
