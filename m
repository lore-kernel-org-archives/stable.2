Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793015915;
	b=BIlQNDkeA3tfHTCmH6n5yNrzT6TCWaIKDchA5DrzJMdLeuNR9Uhc4Ry67Ky5/wZzhdak
	 ym8VTqOSzMZnmLoru2fq+aNzmK1lp+MyGwSnhI45dyWSTMcJ25lCV+eN3CGoZJk/c0CIh
	 YeQtuCsL6TswYIp3fZ5X2lDe7d2PNw3BCG+PNRGkaGXqB+3/tf66Q3WnSSYIenwxeSzcQ
	 5KqQjbA0GH7mJecb8j/q0mtc53D1B+f74UZtj3RgWWBtXcypPXEu85qOuHf20ocA4nfnV
	 heAgpv6nj0YsITOVnQ2pC6L8ixdNmfNlsWCQEd0w5nFRx9T6DRd+yDs9F9XyBCWlISQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793015915;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=xA5Je2qa8vdBHWmi+aA7U89RPIKhmEKHRSzdtLfH5tk=;
	b=jMxxP5MhZ35iVYdxZbAXdkvcJx0Sf0T2Lhs+enrzRBBEyF2On71/ZJ8xXoyG8GM+j4a5
	 GoNsP9kCRZldNnKclJOPHGarF9ol4osWy5SwCwP2p7a7OOoLqt7iEHF/7DIYSRr75v2bM
	 ZK+/bIm8Uwsc3Gxz5TYTmRSYj7mmY2Aqc5lFKm4vhbxeAfMibLXhLhBcXCAkQAqzbwr9d
	 YX1dSQqTolLPJ8K/OH3eL4IMHBda9DsqkgWYyT6eM5emHuCKut3j8wNUV9YhKpJ1o84AQ
	 U0hyCCcMDdUJfvjC0qjhr6wyGm1aXBWA2BOSjsohE1QDDptx7iskh6NM6SH5wND7iBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WYd3qw+8;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A0B606A31D;
	Mon, 26 Oct 2026 11:58:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1A0B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WYd3qw+8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793015915; x=1824551915;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N4+rXbY563duUc5ZojoYwToBOC9b5UWgotUeQPKwe7c=;
  b=WYd3qw+8Kn1oymEBOnxk2mdH1Hc12UaWkRs/UCzdDUNuWFW3ghj6OXC5
   HJQD5/rOUozByl76Olg+g4DJFGmDLuk7sABpW75jKHwjP9BbUOQXLUn5t
   lwbbTCToqCKIw0zXWdxbl3lbGCdej0GFDz/dJWGDeMsa6iMxftTv6/joc
   3OQm1gb7oKHPz36JSQy1OpC4nG1W7mv/jAJHNvZbxrSx3HDtg/mSvBxMo
   AF1AFDMXvY401DUqO9SFS1tpUoPDUCIZw93nZHVR6qPzwv2ney99d8MqP
   6iIIimS4TX2Y/oRWgRVDV6+VlKMfNug9RVdHbmBDZkB+WdxrlJVljZt9X
   A==;
X-CSE-ConnectionGUID: C4UKCHtgQXKdQKXb0uq8ig==
X-CSE-MsgGUID: bT9VsuoqS0qlk+iJRr3MBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1700797"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1700797"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 04:58:34 -0700
X-CSE-ConnectionGUID: qWhAAVibSyyppIZEQpTr1w==
X-CSE-MsgGUID: VLLP/3JoSfGPymKiN2oWkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4645279"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa009.fm.intel.com with ESMTP; 26 Oct 2026 04:58:32 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id C17B699; Mon, 26 Oct 2026 12:58:31 +0100 (CET)
Date: Mon, 26 Oct 2026 12:58:31 +0100
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Kyle Tso <kyletso@google.com>
Cc: badhri@google.com, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: tcpm: Fix out-of-bounds read of the pds
 and pd_list arrays
Message-ID: <at9AZ7KH_1At6Vq1@black.igk.intel.com>
References: <20261013081549.2375441-1-kyletso@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013081549.2375441-1-kyletso@google.com>

On Tue, Oct 13, 2026 at 08:15:49AM +0000, Kyle Tso wrote:
> select_usb_power_delivery_show() iterates through port->pds (via the
> pd_get() callback) and tcpm_find_pd_data() iterates through
> port->pd_list until they find a NULL entry. However, tcpm_fw_get_caps()
> allocates only port->pd_count entries for each array, and
> tcpm_port_register_pd() fills all of them. Without a NULL terminator,
> both loops read and dereference one entry past the end:
> 
>   Unable to handle kernel paging request at virtual address
>   adacafaea9a8ac1a
>   Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
>   pc : select_usb_power_delivery_show+0xa4/0x110
>   lr : select_usb_power_delivery_show+0x90/0x110
>   Call trace:
>    select_usb_power_delivery_show+0xa4/0x110
>    dev_attr_show+0x38/0x74
>    sysfs_kf_seq_show+0xb4/0x130
>    kernfs_seq_show+0x44/0x54
>    seq_read_iter+0x158/0x4ec
>    kernfs_fop_read_iter+0x68/0x1bc
>    vfs_read+0x230/0x2c0
>    ksys_read+0x78/0xe8
>    __arm64_sys_read+0x1c/0x2c
>    invoke_syscall+0x58/0x118
>    el0_svc_common+0xb4/0xf4
>    do_el0_svc+0x24/0x80
>    el0_svc+0x2c/0x90
>    el0t_64_sync_handler+0x68/0xb4
>    el0t_64_sync+0x1a4/0x1a8
> 
> Allocate one extra, zeroed entry for both arrays so that they are
> always NULL-terminated.
> 
> Fixes: cd099cde4ed2 ("usb: typec: tcpm: Support multiple capabilities")
> Cc: stable@vger.kernel.org
> Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>
> Signed-off-by: Kyle Tso <kyletso@google.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index d721baef5210..8f4e10ec6d66 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -8376,14 +8376,21 @@ static int tcpm_fw_get_caps(struct tcpm_port *port, struct fwnode_handle *fwnode
>  		}
>  	}
>  
> -	port->pds = devm_kcalloc(port->dev, port->pd_count, sizeof(struct usb_power_delivery *),
> +	/*
> +	 * Allocate one extra entry for each array to keep them NULL-terminated.
> +	 * select_usb_power_delivery_show() iterates through port->pds (via the
> +	 * pd_get callback) until it finds a NULL entry. Similarly,
> +	 * tcpm_find_pd_data() iterates through port->pd_list until it finds a
> +	 * NULL entry.
> +	 */
> +	port->pds = devm_kcalloc(port->dev, port->pd_count + 1, sizeof(struct usb_power_delivery *),
>  				 GFP_KERNEL);
>  	if (!port->pds) {
>  		ret = -ENOMEM;
>  		goto put_capabilities;
>  	}
>  
> -	port->pd_list = devm_kcalloc(port->dev, port->pd_count, sizeof(struct pd_data *),
> +	port->pd_list = devm_kcalloc(port->dev, port->pd_count + 1, sizeof(struct pd_data *),
>  				     GFP_KERNEL);
>  	if (!port->pd_list) {
>  		ret = -ENOMEM;
> -- 
> 2.56.0.385.gd3acb90ef8-goog

-- 
heikki
