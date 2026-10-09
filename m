Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489E04C6F04;
	Fri,  9 Oct 2026 11:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791544570; cv=none; b=qMQz94xdYkElb2vs64PgagQ5OOXd/raHI9Ze8IINi5+lbnK24qzz45qTEcE9zyyS8w2fF2NKg+lQspSVEYjfEa7b/ZCLRjos/9YUiQ7eWY3o9ySC+Hx0CECFn2POclTJ52PDb/pPdhn7f5D2r0QYzxR1omMLSxxy1qD6W5bgovE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791544570; c=relaxed/simple;
	bh=VLmBHm79C9+T07hIIKqpw7WoidK1zsW0rHvEEESqu6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HW43297uxNxxe2mPNzk2JsAgUHUdfrpJtMXz3sB1kAwuhFl3k4iXaxcGlMqJ6D6v8Wlbyi47WhelRtqCVF0RpB5v7sT3jjEo6gB4z+alkGsGNRd2l3RaQ1cu7FUNa0W4CKqS25xtszTrIExQxryaZWqZrtrik+ge+qfe09bXIuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NT2Hy3fk; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NT2Hy3fk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791544561; x=1823080561;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VLmBHm79C9+T07hIIKqpw7WoidK1zsW0rHvEEESqu6E=;
  b=NT2Hy3fk58zSNUiDhCsOM3HQL5woRueoC/9gSB/1D6xb74GpKK2qiCbv
   IVwZq3u2IZIkq+gT4ZAaseMmDmnBh4d+RGa8y99+MhiJc7EEh80v+kvGz
   oXxDbVSj45hr6dn4ate09ujZwLcE+KCET+mbyGadua2bjRFbm8QKhjAs4
   JXRB/4QOTvfF9sXWfUe+tYd4fFNe/b3mN059BzfZT2mHg6egpKTieuLRZ
   FWbOwfrDnOkep6fw+nxr/dRLD6ayAku/VnaQ3BWM2AZN27tFIzX/y7wqK
   O2ilG4Q6qwQLBsLNMKjefQBBcZp93kEJwT6m1yxQDfDCL3zl9zJtcvOuc
   g==;
X-CSE-ConnectionGUID: 76y7RSlMSsaTqBV8InX6Rw==
X-CSE-MsgGUID: Qrw5NAcOQNiMCIxHKuYPXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="246886"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="246886"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 04:16:00 -0700
X-CSE-ConnectionGUID: gw5UUaXQTf6GqGS+l1u+OQ==
X-CSE-MsgGUID: X6kIVNv6TiO5K/t7PmcHLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="302632"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 09 Oct 2026 04:15:58 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 7B80699; Fri, 09 Oct 2026 13:15:56 +0200 (CEST)
Date: Fri, 9 Oct 2026 13:15:56 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Gris Ge <cnfourt@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	Benson Leung <bleung@chromium.org>,
	Andrei Kuchynski <akuchynski@chromium.org>,
	Abel Vesa <abelvesa@kernel.org>,
	Pooja Katiyar <pooja.katiyar@intel.com>,
	Jameson Thies <jthies@google.com>,
	Hsin-Te Yuan <yuanhsinte@chromium.org>,
	Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: ucsi: Skip CAM query when partner has no
 alt modes
Message-ID: <asjM7C82ydc6LX-W@black.igk.intel.com>
References: <20260930234611.468765-2-cnfourt@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930234611.468765-2-cnfourt@gmail.com>

On Thu, Oct 01, 2026 at 07:46:08AM +0800, Gris Ge wrote:
> Since Thunderbolt alternate mode support was added,
> `ucsi_altmode_update_active()` is called on every Connector Partner
> Changed event.  This made the driver send `UCSI_GET_CURRENT_CAM` to
> PPMs even when the partner had no alternate modes registered. Firmware
> that does not support the optional alternate mode details answered Not
> Supported, which produced a spurious error on every partner change:
> 
> ```
> ucsi_acpi USBC000:00: GET_CURRENT_CAM command failed
> ```
> 
> Fixed by skipping the command when there is nothing to update.
> 
> Fixes: da87d45b1951 ("usb: typec: ucsi: Add Thunderbolt alternate mode support")
> Cc: stable@vger.kernel.org # v7.0+
> Assisted-by: Codex:deepseek-v4.1-flash
> Signed-off-by: Gris Ge <cnfourt@gmail.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> v2:
>   - skip the invoke of `ucsi_altmode_update_active()` in
>     `ucsi_handle_connector_change()`
> v1: https://lore.kernel.org/linux-usb/20260927021649.8967-1-cnfourt@gmail.com/
> 
>  drivers/usb/typec/ucsi/ucsi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index bef3f9b71d71..c392afdc27ae 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -1519,7 +1519,8 @@ static void ucsi_handle_connector_change(struct work_struct *work)
> 
>  	if (con->partner && (change & UCSI_CONSTAT_PARTNER_CHANGE)) {
>  		ucsi_partner_change(con);
> -		ucsi_altmode_update_active(con);
> +		if (con->partner_altmode[0])
> +			ucsi_altmode_update_active(con);
> 
>  		/* Complete pending data role swap */
>  		if (!completion_done(&con->complete))
> --
> 2.55.0

-- 
heikki
