Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B174477F5;
	Mon, 14 Sep 2026 11:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789386264; cv=none; b=QB+ci7WDfvpwSF01/S2eE18bs6IwxRv9bvJ6/vSZwrQd2OF2tSmWnOCdr8sKUUHPhz/xmV0a5qZk9zu0gnCqkpePyo/fABjZpaXOglp6RgTgt/ci75MRJRNpl+V0DwqtmWt8g4HRkpGrMl3jmG1SkV0G8LBaamLXWs+ymdgkezU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789386264; c=relaxed/simple;
	bh=0Yr5S6bTpSLfpOUhhORGDoYAQW1Sh6O5HLDj/LGgdSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ho/n1bliWdgnHkN7sRgvLd9DDkwOMaJ+UGbAMUsFZ3yi7u+/0oXLvUlMYt0BROHDftUlcG+s+f9seOfZxo+WKdlPw9gJPjrEFCSox0WNHGEHmYUAE9nmCUFxR0jyK699q1C6Vf7UHrveWvq0JC47Il8Tv8Q3m8xgOsWTqfuLr1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DCuDAEEO; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DCuDAEEO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789386263; x=1820922263;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0Yr5S6bTpSLfpOUhhORGDoYAQW1Sh6O5HLDj/LGgdSs=;
  b=DCuDAEEOwH/ibMxev8vFjisnyc0xrAM9oFZOoFup8P0eLVTjs0WWE9Os
   bszAMhJ9UemDe9qTfPjKaXIC9r5ArAAQUCOHmhrSgxFRzQFpyOEo5va22
   yesE8Azh7nUUi/LUtGH8qnk3z5cvaytJHmH0zGhziTWK68EWm/94mDNg0
   pAKDjrAA/DyjkyPH+V0w//drFf2C5Cs1XAiuXV7f22vseYSOyZzQVQ3tJ
   cx6oO2LgfT1X/v6l/eBDyhO2v9oMnNyIBc3RnCU8krlXJbfB+fcl57thZ
   M+Ad8Yg/hb6oVyY+LrqVpV/rlkBPQfNAgLCVKS1qtz8Z6gYwqSbwcFaAv
   A==;
X-CSE-ConnectionGUID: Tp3nDIp0S2yGL86ab5L16Q==
X-CSE-MsgGUID: syf9bMYGTMGyBBa97wgKqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="100397287"
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="100397287"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 04:44:22 -0700
X-CSE-ConnectionGUID: wQGh43OYRKukOlA6kPUPsw==
X-CSE-MsgGUID: i63VEpqOSFC7O0++6L862A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="274538960"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa004.fm.intel.com with ESMTP; 14 Sep 2026 04:44:21 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 5715499; Mon, 14 Sep 2026 13:44:20 +0200 (CEST)
Date: Mon, 14 Sep 2026 13:44:20 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Linkai Gong <gonglinkai@kylinos.cn>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Xin Ji <xji@analogixsemi.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] usb: typec: anx7411 - stop the IRQ before destroying
 the workqueue
Message-ID: <aqfeFD-2RVMaO4u9@black.igk.intel.com>
References: <20260908060333.4097219-1-gonglinkai@kylinos.cn>
 <20260910011150.2966843-1-gonglinkai@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910011150.2966843-1-gonglinkai@kylinos.cn>

On Thu, Sep 10, 2026 at 09:11:50AM +0800, Linkai Gong wrote:
> The IRQ is devm-managed, so it can still queue plat->work while
> remove() is tearing the queue down. Disable it first.
> 
> Fixes: fe6d8a9c8e64 ("usb: typec: anx7411: Add Analogix PD ANX7411 support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Linkai Gong <gonglinkai@kylinos.cn>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> v3:
> - add Cc: stable (Heikki)
> 
> v2:
> - keep the minimal remove() race fix; drop the workqueue later if wanted
>   (code unchanged from v1)
> 
>  drivers/usb/typec/anx7411.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/anx7411.c b/drivers/usb/typec/anx7411.c
> index 41df115912b9..c3d36da692e4 100644
> --- a/drivers/usb/typec/anx7411.c
> +++ b/drivers/usb/typec/anx7411.c
> @@ -1566,8 +1566,11 @@ static void anx7411_i2c_remove(struct i2c_client *client)
>  	anx7411_partner_unregister_altmode(plat);
>  	anx7411_unregister_partner(plat);
>  
> -	if (plat->workqueue)
> +	if (plat->workqueue) {
> +		disable_irq(plat->intp_irq);
> +		cancel_work_sync(&plat->work);
>  		destroy_workqueue(plat->workqueue);
> +	}
>  
>  	i2c_unregister_device(plat->spi_client);
>  
> -- 
> 2.25.1

-- 
heikki
