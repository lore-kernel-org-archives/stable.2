Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C42043DEB7;
	Fri, 11 Sep 2026 11:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789124934; cv=none; b=q1NMLJF4vPF8vj8ZYjyicP5tsARa2+sxjby6GbSbe0P2iLBexP6rLLgEVYQBIVSNDoVDv0QTGlXQJUz+z2LB4a28nAU5XE7Md0s1x8+kDnDGhH33tCarWhQpc/aRAdNkETDxx777czFz6UHp1sOrf+Sph2JUYEsNRqtBdAvR81E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789124934; c=relaxed/simple;
	bh=E0Yt69cVRt11IGIn0puB02EStQIs81GWIcAdHTR8RJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mM9KgJiSkZ0s9ZMuy0SuiJUDVg5xah2zdQEuqJrucWg4xmoE4+sgXPNPcvgZ1d5rQG4d4GEu4moQQvbgFHM//2la4fzQdGH2eQFaXYp+KPk7gWwYd5zjf/RTIXIIAT9RzhhsAeZ+nGxS2sGxW2FiDLl7ewZcTtHMYkRuxgTgvbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R+iRbhAD; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R+iRbhAD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789124932; x=1820660932;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E0Yt69cVRt11IGIn0puB02EStQIs81GWIcAdHTR8RJY=;
  b=R+iRbhADb694Yfd4jbQzEC856Qw3Z1OOOMyagivEZwSjL57IXuBCJ1kM
   BheqUDGg+0uh+bZLy3f3/L6hDGHlbWluQnT30tFfGp1XjZStK5zh3tX4t
   ++Oglyl2lbvs9fAykl0kdd8bDd7wIDWeD6Tg4+pA7oJpeQg+q6Olyjgvj
   Kq4Tw6OX5BuJfUceUaWdjJyg3aDItBdkdmg78IeHdJk2eLK3LhsZry5j3
   +VPrfY3SwP573OhP5zHOcrvcHgiQvzFVT8X7kyfB2VKSBKll5A8gHmTHk
   FtW0+jQyJVt01/+9H7v1pU5pbOCnt5Jdgo8UKoIqe7Q8ShZfAF+zSQn8m
   Q==;
X-CSE-ConnectionGUID: AV5mQq7ISCyXZ8BgOCH2Mg==
X-CSE-MsgGUID: /uCnERyDSteCZqmS5STCPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="100938613"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="100938613"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 04:08:51 -0700
X-CSE-ConnectionGUID: pX1HYB3dSr6ulwz2veJREw==
X-CSE-MsgGUID: caEtU+byS7iekhD3pb4/kQ==
X-ExtLoop1: 1
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa003.fm.intel.com with ESMTP; 11 Sep 2026 04:08:49 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 5DDF899; Fri, 11 Sep 2026 13:08:48 +0200 (CEST)
Date: Fri, 11 Sep 2026 13:08:48 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Wayne Chang <waynec@nvidia.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi_ccg: Add retry mechanism in ccg_read
Message-ID: <aqPhQPUh6ZkpCPp0@black.igk.intel.com>
References: <20260909152805.6254-1-waynec@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909152805.6254-1-waynec@nvidia.com>

On Wed, Sep 09, 2026 at 11:28:05PM +0800, Wayne Chang wrote:
> CCG4 firmware occasionally fails to respond to I2C read requests,
> especially when reading cci and intr_reg from the ISR path. In these
> cases, i2c_transfer() returns -EREMOTEIO.
> 
> The CCG4 is EOL, and Infineon no longer supports firmware updates, so
> a software workaround is necessary.
> 
> Retry the read operation up to three times (four attempts total)
> when -EREMOTEIO is returned, with a 1-2 ms sleep between retries.
> This allows recovery from transient I2C failures without affecting
> other error paths.
> 
> The sleep is safe because ccg_read() is called both from process
> context and from ccg_irq_handler(), which runs in threaded IRQ
> context (registered via request_threaded_irq() with a NULL hard-IRQ
> handler), so sleeping is allowed in both cases.
> 
> Fixes: 247c554a14aa ("usb: typec: ucsi: add support for Cypress CCGx")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wayne Chang <waynec@nvidia.com>
> ---
>  drivers/usb/typec/ucsi/ucsi_ccg.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
> index 91c2958a708c..da8beb14d84c 100644
> --- a/drivers/usb/typec/ucsi/ucsi_ccg.c
> +++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
> @@ -135,6 +135,8 @@ struct version_format {
>  #define NVIDIA_FTB_DP_OFFSET	(2)
>  #define NVIDIA_FTB_DBG_OFFSET	(3)
>  
> +#define CCG_READ_MAX_RETRIES	3
> +
>  struct version_info {
>  	struct version_format base;
>  	struct version_format app;
> @@ -255,6 +257,7 @@ static int ccg_read(struct ucsi_ccg *uc, u16 rab, u8 *data, u32 len)
>  	};
>  	u32 rlen, rem_len = len, max_read_len = len;
>  	int status;
> +	int retry_count;
>  
>  	/* check any max_read_len limitation on i2c adapter */
>  	if (quirks && quirks->max_read_len)
> @@ -266,7 +269,17 @@ static int ccg_read(struct ucsi_ccg *uc, u16 rab, u8 *data, u32 len)
>  		rlen = min_t(u16, rem_len, max_read_len);
>  		msgs[1].len = rlen;
>  		put_unaligned_le16(rab, buf);
> -		status = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
> +
> +		for (retry_count = 0; retry_count <= CCG_READ_MAX_RETRIES; retry_count++) {

That will run up to 4 times even though your maximum is defined 3?

> +			status = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
> +
> +			/* Only retry on -EREMOTEIO, and not after the last attempt */
> +			if (status != -EREMOTEIO || retry_count == CCG_READ_MAX_RETRIES)
> +				break;
> +
> +			usleep_range(1000, 2000);

fsleep(1000);

> +		}
> +
>  		if (status < 0) {
>  			dev_err(uc->dev, "i2c_transfer failed %d\n", status);
>  			pm_runtime_put_sync(uc->dev);
> 
> base-commit: 940de590b839f71d6dc846160534bf202401b8b7
> -- 
> 2.25.1

-- 
heikki
