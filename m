Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A6B4C9573;
	Mon, 28 Sep 2026 14:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790606656; cv=none; b=ZIgdDgkgasnYXruMdUkH2DNx9nLTbJ7tJMYEkoHRbzeVuVimKvBHQ8VChZf6HA11LdgE75ZFLqoDZmfztCX9a2ytp5hV8aa1mHwubnlnl1UMwaN8FH1L1ue5ZrRvGFiidZesHZmxpshoXLEhVZhr8mR5FBVepEOifAA+YoQf1eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790606656; c=relaxed/simple;
	bh=8827mwI9ePq+tLBqt0/WixaVjA5dDxqutBrhIqv0p3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e7RlvroNpAeddV8GFNayxpgtyAUfbcmyIsEB/QRs0zpDvbcBtOPongjWk1wgtKgCu75lM0KGUq08HvMUS8NWefxamAhVjeNuRfLAqpvIbjC23jiCjk/HgludYb2QQDc+nmUZjrRnKlwgkMeq5ONgYhKGe7bcoos4ZLoTdV7Rks8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kr9CVAyD; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kr9CVAyD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790606651; x=1822142651;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8827mwI9ePq+tLBqt0/WixaVjA5dDxqutBrhIqv0p3w=;
  b=Kr9CVAyDU2Fnfn0acA5L7O2Ph3BASZHk0OriRz/FR9Zg3Ox7Et7T9asn
   tvBnqk8fsWiy5exRN0VunAPj3VcB9ghwq0OOdI4DSq7ASIbUQgQPxTwhl
   eDxIUs4tpgwhYftaPadvwLeiTkucrG+CoYHjo1GvSVwr2u5YqijatFtyz
   LCRzB/uGPAcBCsmCXk3/A90f+iOQr75VtuCYqqot2cgqCvZ7gIk9kw8vo
   hg/QM/EoxNjnTVNvPmwCEb2WXum2ZswohEQ1Et0vjjLf6wlozER5G2Lit
   mhFaZ3hUjD3QFFYtD86KfHvB8IglhwexkIPogZw7k0EbSsraDC7vhlvJr
   Q==;
X-CSE-ConnectionGUID: CqLi2X0GT2y3/uzcHoUT8A==
X-CSE-MsgGUID: uLETA+4gR/S+lRtqusOnOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="113092611"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="113092611"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 07:44:03 -0700
X-CSE-ConnectionGUID: BAZDn/oDQnS/t4YIJWGPsw==
X-CSE-MsgGUID: VCYkQyrZRxa0xIQGyzx3fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="274182044"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa008.jf.intel.com with ESMTP; 28 Sep 2026 07:44:00 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id A875599; Mon, 28 Sep 2026 16:43:59 +0200 (CEST)
Date: Mon, 28 Sep 2026 16:43:59 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: pip-izony <eeodqql09@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pooja Katiyar <pooja.katiyar@intel.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Randy Dunlap <rdunlap@infradead.org>, Fan Wu <fanwu01@zju.edu.cn>,
	Johan Hovold <johan@kernel.org>, Ajay Gupta <ajayg@nvidia.com>,
	Kyungtae Kim <Kyungtae.Kim@dartmouth.edu>,
	Nathan Rebello <nathan.c.rebello.27@dartmouth.edu>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: ccg: Validate altmode index in
 GET_CURRENT_CAM response
Message-ID: <arp9LwRxhoyolsTA@black.igk.intel.com>
References: <20260928053759.533956-3-eeodqql09@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928053759.533956-3-eeodqql09@gmail.com>

On Mon, Sep 28, 2026 at 01:38:01AM -0400, pip-izony wrote:
> From: Seungjin Bae <eeodqql09@gmail.com>
> 
> When the PPM reports more than one DisplayPort alternate mode for a
> connector, ucsi_ccg_update_altmodes() merges them into a single entry
> in uc->updated[] and sets uc->has_multiple_dp. In that case,
> ucsi_ccg_update_get_current_cam_cmd() rewrites the response of the
> GET_CURRENT_CAM command. The response is a single byte holding the
> index of the currently active alternate mode, and it is provided by
> the PPM firmware.
> 
> The function uses this byte directly as an index into uc->orig[], and
> then uses the linked_idx read from that entry as the translated index
> into uc->updated[]. Both arrays have UCSI_MAX_ALTMODES entries, but
> neither index is checked against that size.
> 
> If a malicious or buggy PPM reports a value of UCSI_MAX_ALTMODES or
> larger, e.g. 0xFF, uc->orig[cam].linked_idx reads over the end of
> uc->orig[]. The byte read from there is then used as the index for
> writing cam into uc->updated[new_cam].active_idx, so the out-of-bounds
> read is followed by an out-of-bounds write. This happens without any
> userspace action, since the UCSI core issues GET_CURRENT_CAM on its own
> when handling connector changes.
> 
> Fix this by ignoring responses whose index is out of range and leaving
> the original value in place. The UCSI core only uses the value as an
> index into con->port_altmode[] when it is below UCSI_MAX_ALTMODES, and
> otherwise treats it as no active alternate mode. Also check linked_idx
> before using it as an index, so that the write into uc->updated[] is
> always within bounds.
> 
> Fixes: 170a6726d0e2 ("usb: typec: ucsi: add support for separate DP altmode devices")
> Cc: stable@vger.kernel.org
> Reported-by: Nathan Rebello <nathan.c.rebello.27@dartmouth.edu>
> Signed-off-by: Seungjin Bae <eeodqql09@gmail.com>
> ---
> The issue was found through code audit and was reported privately,
> so there is no public report to link to.
> 
>  drivers/usb/typec/ucsi/ucsi_ccg.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
> index 91c2958a708c..4d1166c20639 100644
> --- a/drivers/usb/typec/ucsi/ucsi_ccg.c
> +++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
> @@ -389,7 +389,13 @@ static void ucsi_ccg_update_get_current_cam_cmd(struct ucsi_ccg *uc, u8 *data)
>  	u8 cam, new_cam;
>  
>  	cam = data[0];
> +	if (cam >= UCSI_MAX_ALTMODES)
> +		return;
> +
>  	new_cam = uc->orig[cam].linked_idx;
> +	if (new_cam >= UCSI_MAX_ALTMODES)
> +		return;
> +
>  	uc->updated[new_cam].active_idx = cam;
>  	data[0] = new_cam;
>  }

Make this function return an error, and don't forget to print
something too.

> 2.43.0

-- 
heikki
