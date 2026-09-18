Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E1D429827;
	Fri, 18 Sep 2026 09:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789725312; cv=none; b=P1MYbZRldi8oAkjUr1NEV3T9pueEEeC91L/xV+mPXg/fE31f+mkjv1bu2FZTXx8EnjGFjt1OM/slGiktm/axGISwMzbMG0or9bX96uNqJ6d5pFweNfjmMpZZsU/jffp+rfsDJL0m5WWihCnw16q0boM3Zv+iq21VBh084ttJSSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789725312; c=relaxed/simple;
	bh=NyQpiwWFyBhwzO36dTkZElIhO2mMg9RXIWq+AFltKwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVELL5Q+Y4MaO2oUOU+OBICRpVLAkyeYBw0ETAD14/VeCl/ol+vuenso10Ge62VPEq00BfivLi3myMzLFOxEa/caLpU3nuo7a9C86eY1GY1SWVO24VNQC4bqWyaIGvpKu9yq/kw9umvD1okMSF9MRI7jeTngHWlLMS+tsHTdCj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bg4ca9W1; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bg4ca9W1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789725310; x=1821261310;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NyQpiwWFyBhwzO36dTkZElIhO2mMg9RXIWq+AFltKwE=;
  b=bg4ca9W14oAXsio+BXENBUiihsJFBucizIGVDRv9vOIG1MQhwqFBtIZp
   9W9gxIOOIINoBkR/rEeTkP4inC8xAYDBLCxEVHPzlL1Hli4RdC1CLL/Yz
   yc73MmohxmcZVAetvz9f2TWiMyJwbCMKEHLN7710ltEMGDHFTo7mmesGn
   0NtwNCr/T7EdJCpdXoewyxreLNgXNWup5CNqhjvX+1lhq7tuRHAuoSXVO
   NUYLbcUxgijegOto3BWbC6DFAqP138Vj1VKE+b1aPlF7MltoAIzlcWgWT
   q2ie5V9oL7KFVmN05EQNtQACEzrFk+WKgeB/QlcY/OeBpqiSj4X+KuQC8
   g==;
X-CSE-ConnectionGUID: okJ5gb8YSRCKP+D4uv63Uw==
X-CSE-MsgGUID: rfmcq6tOTuyDeeFgMJ6wGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="90351635"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="90351635"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 02:55:10 -0700
X-CSE-ConnectionGUID: s4GtVz8QTBCARtRdvAk8kA==
X-CSE-MsgGUID: pJsxa6ctR0qQn+qdpaqkBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="2513558"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa012.fm.intel.com with ESMTP; 18 Sep 2026 02:55:08 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 8232199; Fri, 18 Sep 2026 11:55:06 +0200 (CEST)
Date: Fri, 18 Sep 2026 11:55:06 +0200
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
Subject: Re: [PATCH v3 1/3] usb: typec: mux: ps883x: support TYPEC_DP_STATE_F
Message-ID: <aq0KeqvmjpMdmfiO@black.igk.intel.com>
References: <20260916-ps883x-disable-usb4-v3-0-8f19386456d0@oldschoolsolutions.biz>
 <20260916-ps883x-disable-usb4-v3-1-8f19386456d0@oldschoolsolutions.biz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916-ps883x-disable-usb4-v3-1-8f19386456d0@oldschoolsolutions.biz>

On Wed, Sep 16, 2026 at 09:36:32PM +0200, Jens Glathe via B4 Relay wrote:
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
