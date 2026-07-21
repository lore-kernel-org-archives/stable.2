Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71762F8EAD;
	Tue, 21 Jul 2026 10:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784630761; cv=none; b=StQvNnPQGzOaTm3smQ4p9EjsQhxZmW/h8ZwyyvrL2HCdmurlPE0bdtjkYLPxHZZPQ47qhk6olNSygzCOuU97EyweMB6oScyL/rKHrTSEvPyjrSq6VhpuuPf0p7C5rvhC5BE9MvjQj3B1fYnDmc4WG2tQWKnBkCLjxkft3KbZ3cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784630761; c=relaxed/simple;
	bh=XiJ52Ro979Sd9I4QKn9c0heyv42apiPL9gmEGpxd7/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cjZwLS/eJAFu4p/zDH0E22jYeWC/udU/j52oFzkESkSdMwyIIlZW498S2vzKgCpTQEgqMlN1o5v9BuZ5M3WOC3PtjmBtybnCCSVwJQIVk7+VL6UmQZ6DcyDmAz4tivJ4eqVVeg+ifry51D1JYlfL+D+5OW0aravOdXAziKe0Itg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IuTAUrua; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IuTAUrua"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784630752; x=1816166752;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XiJ52Ro979Sd9I4QKn9c0heyv42apiPL9gmEGpxd7/E=;
  b=IuTAUruaZNEX8Wd1kWAbnjrgzbbv9nXHl90AjvJFcYzKkmnDifXtuoRh
   MMXfL6rSoC17cv63z17RGTHd03e6AvStxvj4VW3qYS2pHjiyeElQt37qT
   xqE6auF/qIHx3COQqdnEfF7KOeSWDW5RESgylYyizkbMliksBhdkjt1cI
   epXUxZl9bISvtm6WC1tV2IFOlT5mwO02z2kLCayqLr/UVTJnYkq3KnkBM
   4IuxNKXf9ZQgXi5jFg9Xi9bevRDewmmmIu6CoIXLRe4qcU2J97ZJ8+7Rd
   Q98fqywLm4HL5IJwJ/tSre0gMrhG5Wy/gWEZgU91DdVw/1ZH5Wil0d2/h
   w==;
X-CSE-ConnectionGUID: eovB+DC1TTGBFFj5ew5bKg==
X-CSE-MsgGUID: qUrereYGSnSZakPd86MFew==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="85425829"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="85425829"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 03:45:46 -0700
X-CSE-ConnectionGUID: BRMn8gthTUOZpen0KK6RBg==
X-CSE-MsgGUID: 1+3gm2alRWmzcCIucRJVkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="281001141"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 21 Jul 2026 03:45:43 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 0120C95; Tue, 21 Jul 2026 12:45:41 +0200 (CEST)
Date: Tue, 21 Jul 2026 13:45:40 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: jens.glathe@oldschoolsolutions.biz
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, stable@vger.kernel.org,
	"Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH 3/5] usb: typec: mux: ps883x: refactor DP altmode
 handling and support TYPEC_DP_STATE_F
Message-ID: <al9N1GncsKvVU9tZ@kuha>
References: <20260718-ps883x-disable-usb4-v1-0-cec86d0b909e@oldschoolsolutions.biz>
 <20260718-ps883x-disable-usb4-v1-3-cec86d0b909e@oldschoolsolutions.biz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260718-ps883x-disable-usb4-v1-3-cec86d0b909e@oldschoolsolutions.biz>

On Sat, Jul 18, 2026 at 07:06:31PM +0200, Jens Glathe via B4 Relay wrote:
> From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> 
> Several docks, including the Lenovo 40B0 and SSK SC220, still send the
> legacy TYPEC_DP_STATE_F mode request (deprecated since DisplayPort Alt
> Mode spec version 1.0b). Treat it as USB3 + DP altmode (same as
> TYPEC_DP_STATE_D) so that DP altmode works correctly, especially on
> the 40B0 in Type-C fallback mode.
> 
> Extract the state handling into ps883x_apply_dp_altmode() (modelled
> after qmp-combo-phy) for consistency.
> 
> Assisted-by: Grok(xAI):4.3
> Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/mux/ps883x.c | 35 ++++++++++++++++++++---------------
>  1 file changed, 20 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/usb/typec/mux/ps883x.c b/drivers/usb/typec/mux/ps883x.c
> index 3fa26ce01a9c9..3533d4f363286 100644
> --- a/drivers/usb/typec/mux/ps883x.c
> +++ b/drivers/usb/typec/mux/ps883x.c
> @@ -188,6 +188,25 @@ static int ps883x_configure(struct ps883x_retimer *retimer, int cfg0,
>  	return 0;
>  }
>  
> +static void ps883x_apply_dp_altmode(int *cfg0, int *cfg1, int dp_state)
> +{
> +	*cfg1 |= CONN_STATUS_1_DP_CONNECTED | CONN_STATUS_1_DP_HPD_LEVEL;
> +
> +	switch (dp_state) {
> +	case TYPEC_DP_STATE_D:
> +	case TYPEC_DP_STATE_F:
> +		*cfg0 |= CONN_STATUS_0_USB_3_1_CONNECTED;
> +		fallthrough;
> +	case TYPEC_DP_STATE_C:
> +	case TYPEC_DP_STATE_E:
> +		*cfg1 |= CONN_STATUS_1_DP_SINK_REQUESTED |
> +			 CONN_STATUS_1_DP_PIN_ASSIGNMENT_C_D;
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
>  static int ps883x_set(struct ps883x_retimer *retimer, struct typec_retimer_state *state)
>  {
>  	struct typec_thunderbolt_data *tb_data;
> @@ -203,24 +222,10 @@ static int ps883x_set(struct ps883x_retimer *retimer, struct typec_retimer_state
>  	if (state->alt) {
>  		switch (state->alt->svid) {
>  		case USB_TYPEC_DP_SID:
> -			cfg1 |= CONN_STATUS_1_DP_CONNECTED |
> -				CONN_STATUS_1_DP_HPD_LEVEL;
> -
> -			switch (state->mode)  {
> -			case TYPEC_DP_STATE_D:
> -				cfg0 |= CONN_STATUS_0_USB_3_1_CONNECTED;
> -				fallthrough;
> -			case TYPEC_DP_STATE_C:
> -				cfg1 |= CONN_STATUS_1_DP_SINK_REQUESTED |
> -					CONN_STATUS_1_DP_PIN_ASSIGNMENT_C_D;
> -				break;
> -			default: /* MODE_E */
> -				break;
> -			}
> +			ps883x_apply_dp_altmode(&cfg0, &cfg1, state->mode);
>  			break;
>  		case USB_TYPEC_TBT_SID:
>  			tb_data = state->data;
> -
>  			/* Unconditional */
>  			cfg2 |= CONN_STATUS_2_TBT_CONNECTED;
>  
> 
> -- 
> 2.53.0
> 

-- 
heikki
