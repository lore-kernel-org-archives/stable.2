Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C944CEE55;
	Fri,  9 Oct 2026 11:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791545766; cv=none; b=GpvlQgKwbD97fFzoj9Z+FzH1GpBGAo84G+WDNamdPf2X3BQQHr+oBl47rYiAD7LWUujYTZheJCN6Joj+0hvxZddTqqdhna6qHiMc8fAhT05y7R5hJ9DiuBUup83EgKEhESBpasYKQn7ZU/v3TMd4VmajnZdFG2WF1Wd7RkIyUlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791545766; c=relaxed/simple;
	bh=fm1ZXvPtr+gMm2HM6zjBQLAeTxwW+QbhZ/anVQUB/nM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=slBcCQqmAIAYIE314LXTpPvcsMAaaTlkVsGRubD3WpRvBZFusz4rb4t8k+r1WkRjdDiGt8ujWCDcUOPHt7wHrOWIB0eR7iMxMn94Anez8sdccGbbeb+q48ywtU4kiMi171FAhy86UbBoKHYRLTPvW3pFotJaFO+TDlJjKiKhnrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I2D2fX0s; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I2D2fX0s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791545757; x=1823081757;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fm1ZXvPtr+gMm2HM6zjBQLAeTxwW+QbhZ/anVQUB/nM=;
  b=I2D2fX0scJ2wJy7bMYHxxnnmgSCBQGZsgS9ynOFXlu1N6BObgn++XBrk
   9d/TO3t1Evc4RPeY9oVgo9z4GoZsJEZrfx3dMU4Ji5Eh55+vUyFXx5Tw3
   +vHF2AUdKEN227CqfezB+bmWT7lha7GudJHeayirtkM9Rpw6u8i6Q7umJ
   Big/l4Jo28FZD2Bv2Usmm6DSc/PHm32buElBedjuBxWbzXE+eK01xkRPz
   v1iMqM4otbPgKd1VQU8Wr4VatBbcvuVmxP6pFT2nazteE1qzZ5Rpv+mdu
   89MFaa2h4rM+UsKR3cyeRcnMsRyKFxk9ZldABZwt66CMJMvyhvGu0l+Xs
   g==;
X-CSE-ConnectionGUID: Q0ZF+I3HSWGf7HcQA04Cgg==
X-CSE-MsgGUID: VI/XAdWoQ5mbx/YvRxnBmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="229923"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="229923"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 04:35:56 -0700
X-CSE-ConnectionGUID: ra5t7a/xRqe7FxnCHSq/1g==
X-CSE-MsgGUID: u24BpNR7TKa8MhwWhU3jKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="753915"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa010.fm.intel.com with ESMTP; 09 Oct 2026 04:35:55 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id EAD7F99; Fri, 09 Oct 2026 13:35:53 +0200 (CEST)
Date: Fri, 9 Oct 2026 13:35:53 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Uttkarsh Aggarwal <uttkarsh.aggarwal@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hdegoede@redhat.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: ucsi: Set ucsi->connector before enabling
 notifications
Message-ID: <asjRmXRRIShLTdFc@black.igk.intel.com>
References: <20260929092939.1806907-1-uttkarsh.aggarwal@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929092939.1806907-1-uttkarsh.aggarwal@oss.qualcomm.com>

On Tue, Sep 29, 2026 at 02:59:39PM +0530, Uttkarsh Aggarwal wrote:
> In ucsi_init(), ucsi->connector is assigned only after the
> UCSI_SET_NOTIFICATION_ENABLE command completes. But once that command
> is sent, the PPM is free to raise a connector change notification at
> any time, which is handled through:
> 
>     ucsi_notify_common() -> ucsi_connector_change()
> 
> ucsi_connector_change() indexes into ucsi->connector to get the
> connector and schedule its work item. If this notification arrives
> before ucsi_init() reaches the "ucsi->connector = connector;" line,
> ucsi->connector is still NULL and the driver crashes dereferencing it.
> 
> Fix this by setting ucsi->connector right after the connectors are
> registered, before notifications are enabled, so it is always valid
> by the time a connector change event can be delivered. Also clear
> ucsi->connector in the err_unregister path so it isn't left pointing
> at freed memory if a later step in ucsi_init() fails.
> 
> Fixes: 0482c34ec6f8 ("usb: ucsi: Fix ucsi->connector race")
> Cc: stable@vger.kernel.org
> Signed-off-by: Uttkarsh Aggarwal <uttkarsh.aggarwal@oss.qualcomm.com>

Reviewed-by: Heikki Krogerus <heikki.krogeurs@linuc.intel.com>

> ---
> Changes in v2:
>  - Add Fixes tag pointing to 0482c34ec6f8 ("usb: ucsi: Fix ucsi->connector race").
>  - Add Cc: stable@vger.kernel.org.
>  - Link to v1: https://lore.kernel.org/all/20260923060434.2599545-1-uttkarsh.aggarwal@oss.qualcomm.com/
> 
>  drivers/usb/typec/ucsi/ucsi.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index bef3f9b71d71..8f7b73a9f4f4 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -2122,6 +2122,14 @@ static int ucsi_init(struct ucsi *ucsi)
>  			goto err_unregister;
>  	}
>  
> +	/*
> +	 * Set ucsi->connector before enabling notifications. A connector
> +	 * change event can be handled as soon as the notifications are
> +	 * enabled below, and ucsi_connector_change() indexes into
> +	 * ucsi->connector, so it must not be NULL at that point.
> +	 */
> +	ucsi->connector = connector;
> +
>  	/* Enable all supported notifications */
>  	ntfy = ucsi_get_supported_notifications(ucsi);
>  	command = UCSI_SET_NOTIFICATION_ENABLE | ntfy;
> @@ -2129,7 +2137,6 @@ static int ucsi_init(struct ucsi *ucsi)
>  	if (ret < 0)
>  		goto err_unregister;
>  
> -	ucsi->connector = connector;
>  	ucsi->ntfy = ntfy;
>  
>  	mutex_lock(&ucsi->ppm_lock);
> @@ -2143,6 +2150,7 @@ static int ucsi_init(struct ucsi *ucsi)
>  	return 0;
>  
>  err_unregister:
> +	ucsi->connector = NULL;
>  	for (con = connector; con->port; con++)
>  		ucsi_unregister_port(con);
>  	for (i = 0; i < ucsi->cap.num_connectors; i++)
> -- 
> 2.34.1

-- 
heikki
