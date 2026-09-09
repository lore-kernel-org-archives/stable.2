Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8A1579818;
	Wed,  9 Sep 2026 14:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963627; cv=none; b=HSUNQtDSLYSyOwcrxB4BeY2FK3LPBeDZGg8kg2rfk0yF/j5U5b1oAJX0Td4Em9az26GECSaNj5RmcI2d4aUPTAMuoiUi+biUD6vXNidWLpv7UK0HA+OfuTONHCM17qNU6vqAtneuuuzruS1cDa8mjVLPGhX/M0YoS+JNk/nrqkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963627; c=relaxed/simple;
	bh=KtmoCF5c4xErrZMUr/YDnMNE3HZkcgBgnRjdqlBDukA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PF5omK+6I+CeDHSWtO+H15/hIQAkv7ivzFH3R8LpQJkjwvbTL/LZ6O7EsLkBlx4PNhwX7CcRSasxLtTBGrTH/JFFkpMt8aSqIMVgDW2KhUvWmgi1n/Qb4wIWH76WEl/5mcLWicRfpOKwCswQ6A4iqiR5dVO2pD5UM7i8CBZL4ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rluv3343; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rluv3343"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788963625; x=1820499625;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KtmoCF5c4xErrZMUr/YDnMNE3HZkcgBgnRjdqlBDukA=;
  b=Rluv3343Y4UV5jzfNe/toCviIcUUiNBCPVwACu4fwKSy8UhNIf2hbYjy
   3CxYXfoUoox9SHrbu5BNSTSD0Qla/72pcJxiv9g8frHtxm2lEYMUBJg4E
   ZxaOzc4H1xLtbrgZUdxnx/acQLwKZZnmkM1oH/kz6pUfZpiCeMQYEF1oI
   C+Q47webRrkrl6zgEnyZG987LaprdUgsJMqx99xJ+QFtc/vl5e/nU+59+
   LIcI8B77WODCSTqUQpQXgR4pSJH6yrSCLzWC3S9CXxyFzlF+DS1katukc
   T8qB27Y1ZFtPRL9djn68tUlOWfQgh4R5sMwZSLCojZT9xOwIsprkUBQCb
   w==;
X-CSE-ConnectionGUID: HdQEQq+TRFiV8JBQUa8c4w==
X-CSE-MsgGUID: i62VsZooTZuFBXol3iaUGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="93084397"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="93084397"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 07:20:25 -0700
X-CSE-ConnectionGUID: SJkxrSycRiCs5CtulKzo0A==
X-CSE-MsgGUID: Mx5AHwPRSLqqwnwYF3BpfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="276558873"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa005.fm.intel.com with ESMTP; 09 Sep 2026 07:20:22 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 0859999; Wed, 09 Sep 2026 16:20:21 +0200 (CEST)
Date: Wed, 9 Sep 2026 16:20:21 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Song Li <songl@zju.edu.cn>,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] usb: typec: ucsi: glink: fix use-after-free of ucsi on
 remove
Message-ID: <aqFrJUHVKJz9Dyzq@black.igk.intel.com>
References: <20260908060216.616045-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908060216.616045-1-fanwu01@zju.edu.cn>

On Tue, Sep 08, 2026 at 06:02:15AM +0000, Fan Wu wrote:
> The pmic_glink client is released by the devres cleanup, which runs
> after pmic_glink_ucsi_remove() has returned, so its notification
> callbacks can queue work until then. Work that runs after
> ucsi_unregister() has been called touches freed state: it dereferences
> the connector array that ucsi_unregister() freed, or registers and
> unregisters the instance a second time.
> 
> Disable both work items with disable_work_sync() before unregistering,
> and unregister only if the instance is still registered.
> 
> This issue was found by an in-house static analysis tool.
> 
> Fixes: 62b5412b1f4a ("usb: typec: ucsi: add PMIC Glink UCSI driver")

+Neil

> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6
> Link: https://lore.kernel.org/r/20260227190430.889-1-nathan.c.rebello@gmail.com
> Co-developed-by: Song Li <songl@zju.edu.cn>
> Signed-off-by: Song Li <songl@zju.edu.cn>
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>

Just a note. ucsi_registered was introduced in commit 11bb2ffb6793
("usb: typec: ucsi: Move unregister out of atomic section").

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi_glink.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
> index 12e07b9fe..1db0c88d8 100644
> --- a/drivers/usb/typec/ucsi/ucsi_glink.c
> +++ b/drivers/usb/typec/ucsi/ucsi_glink.c
> @@ -362,6 +362,10 @@ static void pmic_glink_ucsi_destroy(void *data)
>  {
>  	struct pmic_glink_ucsi *ucsi = data;
>  
> +	/* Drain the work items before ucsi_destroy() frees the ucsi instance */
> +	cancel_work_sync(&ucsi->notify_work);
> +	cancel_work_sync(&ucsi->register_work);
> +
>  	/* Protect to make sure we're not in a middle of a transaction from a glink callback */
>  	mutex_lock(&ucsi->lock);
>  	ucsi_destroy(ucsi->ucsi);
> @@ -467,8 +471,15 @@ static void pmic_glink_ucsi_remove(struct auxiliary_device *adev)
>  {
>  	struct pmic_glink_ucsi *ucsi = dev_get_drvdata(&adev->dev);
>  
> -	/* Unregister first to stop having read & writes */
> -	ucsi_unregister(ucsi->ucsi);
> +	/* Callbacks can queue work until devres releases the client */
> +	disable_work_sync(&ucsi->notify_work);
> +	disable_work_sync(&ucsi->register_work);
> +
> +	/* register_work may have unregistered the instance already */
> +	if (ucsi->ucsi_registered) {
> +		ucsi->ucsi_registered = false;
> +		ucsi_unregister(ucsi->ucsi);
> +	}
>  }
>  
>  static const struct auxiliary_device_id pmic_glink_ucsi_id_table[] = {

-- 
heikki
