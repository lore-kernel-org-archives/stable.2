Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795176197;
	b=HxC+UqBwMJKTaRxMtuZlyGKP3OJCId02lcktpykH44GRG+hlxYS3lqCD3Y3dP48qpjwD
	 yVxIEtRdH+vswt1vuznhrBoUR8ZvzQJf1uN5yUC8nRpzkLtlHL+WUQZ6YypiBcYPSqEKv
	 dgDgwU7MPsFtWm3SxGX7dluoG5oIWAe1d2rFVtoyf+WVbj0PPTU5TnMhcmwU0zW1nnlHb
	 wSBDPa+NWutyk5rz9SBqQffeCPmwXIWa++3+QQwdFCbKAiFgCWM6ODC8z61yJ+cJ0spNS
	 uuNzUk9YMxwPWbl5Z8Sg8gMBRzg5C6C9Bwz5gBj+ET6RYqdfM31R2bBFfowbY247Xng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795176197;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:
	 Organization:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=NdHy/rwYUEq++mkyLWvRUCOO+WKgIjcITiwS2xyhgio=;
	b=fOrMxForojenDdlwlHnyqeY5ac+dn5CkuT9ROS3ke3XEsLLj6LtMgQ4La7aNm2p7tLSO
	 sxikeEOkz+iK9U3uRuiNflkSWrwPrkkbkOuX9UiZQJZ7RnOdX8kURfTIR4djAut9eqU+Y
	 oSACo8Bv0FUgfaDxVlq78dkogYfW2tYjXYx39DKmi361Bb5ApImxzS4auzzpoXDrCtshp
	 Djk8KfvClSdp8R5tYH6rVr6SIjb/xXc1g+l4PONd8ASEBiKaGStGWtuVPtNh0FvP+wxfe
	 Oiso3Dkp+3bRzSjR/5JkJbsJYktGd2JWmEgnhYApEkY5ss3di7rofZHwRXCn6w1qpNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MzC0waTw;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9F9606A320;
	Fri, 20 Nov 2026 12:03:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE9F9606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MzC0waTw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795176198; x=1826712198;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pRHMxUiP6iGLsO/OyWGbqEeX2MfXfIYhkJEzMCE5raI=;
  b=MzC0waTwIRF4HKlj2bIhlklUJwZrWjo3ztSjoCN4A4uD0avpYLsYLgD9
   c1Dg6OKidI+kPEqR68KIbG2YOiIUQjhFmsPWOHJwvi3A5lpcXTA4lM8Bt
   pkixl9vWA/FxhqOBWgN2k+dfy6WojcuTavzyPLnbTey+AWvrOV8oN6OWv
   UTHBE3fdiVYxVZmsLz/XB7ugpG+H6uOfKi89OTHHySZpk8a2RdL1V8gKq
   I1gkewLWFqAbuZUe+LIWlSETy4LF/TT5O26naIgXRs/HovhciYBhN9snd
   jIkbARnePZfXybPSstxlJGic33JYwvJtU+p5KVfp/F9CML0Yz27r0ds6D
   A==;
X-CSE-ConnectionGUID: mPKgkLaDQ3G+GYBqcgH15w==
X-CSE-MsgGUID: mAL2u3EaQNilCao1V0VHFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="4040592"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="4040592"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 04:02:16 -0800
X-CSE-ConnectionGUID: 5CswuKtJT8aM+cIuX6Rg/w==
X-CSE-MsgGUID: yVe4Xg9MSIyt73Afpgu5aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="11024252"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.253])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 04:02:07 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 4D05C121B79;
	Fri, 20 Nov 2026 14:02:06 +0200 (EET)
Date: Fri, 20 Nov 2026 14:02:06 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Cc: Israel Cepeda <israel.a.cepeda.lopez@intel.com>,
	Hans de Goede <hansg@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: Re: [PATCH] i2c: usbio: check the return value of usbio_acquire()
Message-ID: <awA2vjN8yD19R3Oj@kekkonen.localdomain>
References: <20261116020850.10526-1-25031212351@stu.xidian.edu.cn>
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
In-Reply-To: <20261116020850.10526-1-25031212351@stu.xidian.edu.cn>

Hi YuanZhe,

On Mon, Nov 16, 2026 at 10:08:50AM +0800, YuanZhe Liu wrote:
> usbio_i2c_xfer() ignores the return value of usbio_acquire() and always
> calls usbio_release() on the way out.
> 
> usbio_acquire() returns -ENODEV once the USBIO bridge has been
> disconnected: usbio_disconnect() sets client->bridge to NULL, and
> usbio_acquire() then only drops client->mutex and returns without
> taking usbio->bulk_mutex or the runtime PM reference of the USB device.
> The transfer is nevertheless issued.  usbio_bulk_msg() dereferences the
> NULL client->bridge in its packet size check and the kernel faults on
> usbio->txbuf_len.  The matching usbio_release() then drops a runtime PM
> reference that was never taken, which is reported as "Runtime PM usage
> count underflow!", and unlocks a mutex that nobody holds.

The patch seems fine but I think the commit message could be improved. The
code is simply missing a check for errors, after all. The above paragraph
could be just dropped.

> 
> Propagate the error instead, so that a transfer racing with the
> disconnect returns -ENODEV without touching the bridge.
> 
> A NULL pointer dereference in usbio_bulk_msg() was observed when the
> bridge was unplugged while i2c-dev was reading from the adapter:
> 
>   usbio-bridge 1-1:1.0: Bulk out failed: -19
>   usbio-bridge 1-1:1.0: Runtime PM usage count underflow!
>   usb 1-1: USB disconnect, device number 3
>   general protection fault, probably for non-canonical address
>   KASAN: null-ptr-deref in range [0x0000000000000060-0x0000000000000067]
>   RIP: 0010:usbio_bulk_msg+0xce/0x9f0
>   Call Trace:
>    usbio_i2c_init
>    usbio_i2c_xfer
>    __i2c_transfer
>    i2cdev_read
>    vfs_read

While this may well be true, the bug being fixed is rather simple so I'd
drop this as well.

> 
> Fixes: daf161343a39 ("i2c: Add Intel USBIO I2C driver")
> Cc: stable@vger.kernel.org
> Co-developed-by: Bin Yu <byu@xidian.edu.cn>
> Signed-off-by: Bin Yu <byu@xidian.edu.cn>
> Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
> ---
>  drivers/i2c/busses/i2c-usbio.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-usbio.c b/drivers/i2c/busses/i2c-usbio.c
> index 259754e5fd05..232397efe8a4 100644
> --- a/drivers/i2c/busses/i2c-usbio.c
> +++ b/drivers/i2c/busses/i2c-usbio.c
> @@ -178,7 +178,9 @@ static int usbio_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int nu
>  	struct usbio_i2c *i2c = i2c_get_adapdata(adap);
>  	int ret;
>  
> -	usbio_acquire(i2c->adev);
> +	ret = usbio_acquire(i2c->adev);
> +	if (ret)
> +		return ret;
>  
>  	ret = usbio_i2c_init(adap, msgs);
>  	if (ret)

-- 
Regards,

Sakari Ailus
