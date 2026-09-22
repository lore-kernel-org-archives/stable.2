Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D1743B6DA;
	Tue, 22 Sep 2026 12:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080072; cv=none; b=hJE6zJ9vJv2sW63QKIfPeK9OkE09HjqR17yf2mlRXM3SLpo2Snt+sfakdwGkYj+eujBoIszyI95JZn+R53YCot5+GxQBuna3SZHG704cxyB3Jd0plQDTzXfxRhBC/jFpyLdvD/Vq5wAWm13Q29YXlPnd8czr8k0flWKzZGgLl1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080072; c=relaxed/simple;
	bh=Z9OBTdIX8f7OAhs5VeelW2/TsHyjmAyRxASOGqoeuCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EoPjglFNB94gT3VNk5D2PzbUxc5QQWDcKgjdnvW7HCne2BSnm3eaPnWpzrhhZK2Si4V9NPHjIySupBRZo31VOHJA7pVuGEnb1LOw88DOFjs1Ejo5I0JwezG9J2EK193n9vbYEnIBqaVJhlNhFBtJabFufRNqt+IBctWbbA/fFT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N1xRLb0J; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N1xRLb0J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790080070; x=1821616070;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z9OBTdIX8f7OAhs5VeelW2/TsHyjmAyRxASOGqoeuCI=;
  b=N1xRLb0JOFSW+rRSOrj1XjFxUl2FV7SKNScxutHTbyrPjybfkoF6D55K
   cX9A8NUOD3ueoP4oNKyk7+2WmJDN33toBdhBczXpvfKQkeUzPg/rvywl1
   0OL+KZNr+YbeKJzUg0fCtt1NW7Y9cb5l6OAx7YQyAMY2BjZESXairnDja
   bZMqsRPoYWsmHiS43FIKyUCcCduysJ9jL4vZD2oZ85SuF1ausnLuw5pT7
   8r2L3Yiy4Qk5VsNZ3AiO+PE4kWaIa7Qr6eqKMF1nQYm585UuGqGTsslKg
   JC+rHiZOMXWK5AOxlH2jMVxEcih0aBXAoHcTNf7QXrFlwpoj1tNuwEP0X
   A==;
X-CSE-ConnectionGUID: Qd8Wwf1rQdO9t6D4a3+AZw==
X-CSE-MsgGUID: 6AFzTnyGTyWAlZWa52LFAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="102027572"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="102027572"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 05:27:49 -0700
X-CSE-ConnectionGUID: UeWf61Z1Ts+0FQYfb8yUcQ==
X-CSE-MsgGUID: F+HmhtM2Tk+xrJxmCqmMTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="4408441"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa013.fm.intel.com with ESMTP; 22 Sep 2026 05:27:47 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 343D799; Tue, 22 Sep 2026 14:27:46 +0200 (CEST)
Date: Tue, 22 Sep 2026 14:27:46 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: jens.glathe@oldschoolsolutions.biz
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Abel Vesa <abelvesa@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	stable@vger.kernel.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v4 1/3] usb: typec: mux: ps883x: support TYPEC_DP_STATE_F
Message-ID: <arJ0QsQpW8UYph-4@black.igk.intel.com>
References: <20260922-ps883x-disable-usb4-v4-0-0a7b5b70cba3@oldschoolsolutions.biz>
 <20260922-ps883x-disable-usb4-v4-1-0a7b5b70cba3@oldschoolsolutions.biz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922-ps883x-disable-usb4-v4-1-0a7b5b70cba3@oldschoolsolutions.biz>

On Tue, Sep 22, 2026 at 02:20:19PM +0200, Jens Glathe via B4 Relay wrote:
> From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> 
> Several docks, including the Lenovo 40B0 and SSK SC220, still send the
> legacy TYPEC_DP_STATE_F mode request (deprecated since DisplayPort Alt
> Mode spec version 1.0b).
> 
> Group it with TYPEC_DP_STATE_D.
> 
> Assisted-by: Grok(xAI):4.6
> Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/mux/ps883x.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/typec/mux/ps883x.c b/drivers/usb/typec/mux/ps883x.c
> index 64e0a61b776a1..a5696aef054ee 100644
> --- a/drivers/usb/typec/mux/ps883x.c
> +++ b/drivers/usb/typec/mux/ps883x.c
> @@ -207,6 +207,7 @@ static int ps883x_set(struct ps883x_retimer *retimer, struct typec_retimer_state
>  
>  			switch (state->mode)  {
>  			case TYPEC_DP_STATE_D:
> +			case TYPEC_DP_STATE_F:
>  				cfg0 |= CONN_STATUS_0_USB_3_1_CONNECTED;
>  				fallthrough;
>  			case TYPEC_DP_STATE_C:
> 
> -- 
> 2.53.0
> 

-- 
heikki
