Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E534740801E;
	Fri, 18 Sep 2026 09:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789724742; cv=none; b=bgSacmmLQ2g7vV1Y3mQPF37CwdK3nQ/LOudaYhhHL6vSdpnmgsFT5M1VSZ7tMHPlYrfFOTgc9ZiKBFb7T8sc0Bi6ScdxAaiS1s29hSUZ3KM5+Tm8MfzLP6aNqli8pD8e0IMLWj+0cwQdeZ1BpDuoVFtll6gPrgFJxIDsfC/blvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789724742; c=relaxed/simple;
	bh=89XNQWaJJfGotGWu/y8kapAmM51DkG82nQ/unU2N1NQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWws3NHAtyZ9juGRUbd6npE8p4sSMnRVgOd8uvvMtra4+p49EqNU1Wip/olbgDh/s4MHYOzq05wxuaeRcwjlsohkULJtm9O3qj6bZGzj2doG+bzzFrNb6q35x52e1YsiDF2RFD7N5u668KzHuYbRxpzUvG+V5+fP5BIk7eePadE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RJ1HCIwt; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RJ1HCIwt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789724740; x=1821260740;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=89XNQWaJJfGotGWu/y8kapAmM51DkG82nQ/unU2N1NQ=;
  b=RJ1HCIwtKHBO2yTy1nUZmx0XzKemSwCBLnof0o58Ne1q8BCWkEYvOiVg
   sDfwOzpdOoqFS3w4p64KHSAY8FfRedMVq1ZxoyPPnNChfgFFtqB7mZoy6
   BUi9oqj7hYWdCVj+PXE4Nr+to2S5KtYfBXhgtyDUi09oTcXbiIluvv+ZG
   v+snblko2yhg//lP/ODEPWxTxIGNG+zx4awXP99H/cmH97meHRWi3+Mht
   0DfJNlInmkV1YgKGVesrjhzu/9W2h6vjkn5LT6iSuEdPF8o5PUGw2+JPO
   2h0VWWd5ldcrSsJXJdWtsRM/DRoasndu+pKobwUrjofupJSJDVtJkhKuo
   g==;
X-CSE-ConnectionGUID: bTsfPMSMT7KJs+/w8jh54w==
X-CSE-MsgGUID: EiH7P7wQTdGC6IBKu/Zmhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="77782486"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="77782486"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 02:45:39 -0700
X-CSE-ConnectionGUID: XTKBeoNFTmG7p/9NjQwnPA==
X-CSE-MsgGUID: aSQkoXbcT2OadNgmRfHhZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="270638789"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa010.fm.intel.com with ESMTP; 18 Sep 2026 02:45:37 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 6F40199; Fri, 18 Sep 2026 11:45:36 +0200 (CEST)
Date: Fri, 18 Sep 2026 11:45:36 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Wayne Chang <waynec@nvidia.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: ucsi_ccg: Add retry mechanism in ccg_read
Message-ID: <aq0IQA_7TrlM7-VO@black.igk.intel.com>
References: <20260916061858.1471606-1-waynec@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916061858.1471606-1-waynec@nvidia.com>

On Wed, Sep 16, 2026 at 02:18:58PM +0800, Wayne Chang wrote:
> CCG4 firmware occasionally fails to respond to I2C read requests,
> especially when reading cci and intr_reg from the ISR path. In these
> cases, i2c_transfer() returns -EREMOTEIO.
> 
> The CCG4 is EOL, and Infineon no longer supports firmware updates, so
> a software workaround is necessary.
> 
> Attempt the read up to CCG_READ_MAX_RETRIES (4) times in total when
> -EREMOTEIO is returned, sleeping ~1 ms via fsleep() between attempts.
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

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> v1 -> v2: Per Heikki's review:
> - Fix off-by-one: CCG_READ_MAX_RETRIES was 3 but the loop ran 4 times
>   (retry_count <= CCG_READ_MAX_RETRIES). Changed the macro to 4 (the
>   actual total attempt count) and the loop condition to
>   retry_count < CCG_READ_MAX_RETRIES, so the name and the loop bound
>   now agree. Adjusted the "skip the sleep on the last attempt" check
>   to retry_count == CCG_READ_MAX_RETRIES - 1 to match.
> - Use fsleep(1000) instead of usleep_range(1000, 2000).
> - Reworded the commit message to say "up to CCG_READ_MAX_RETRIES (4)
>   times in total" instead of the ambiguous "up to three times (four
>   attempts total)" that prompted the off-by-one question.
> 
>  drivers/usb/typec/ucsi/ucsi_ccg.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
> index 91c2958a708c..4b6c53d2a998 100644
> --- a/drivers/usb/typec/ucsi/ucsi_ccg.c
> +++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
> @@ -135,6 +135,8 @@ struct version_format {
>  #define NVIDIA_FTB_DP_OFFSET	(2)
>  #define NVIDIA_FTB_DBG_OFFSET	(3)
>  
> +#define CCG_READ_MAX_RETRIES	4
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
> +		for (retry_count = 0; retry_count < CCG_READ_MAX_RETRIES; retry_count++) {
> +			status = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
> +
> +			/* Only retry on -EREMOTEIO, and not after the last attempt */
> +			if (status != -EREMOTEIO || retry_count == CCG_READ_MAX_RETRIES - 1)
> +				break;
> +
> +			fsleep(1000);
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
