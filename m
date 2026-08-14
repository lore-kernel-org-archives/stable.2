Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA073A874D;
	Fri, 14 Aug 2026 09:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786701313; cv=none; b=kaojsoyn3VuHfPVWzxBF7A3msdk+FI/1s8/kjkLCmtxjjLs2zuBaRGKsVSB3viDCMxVQf91A0leVUwoPWq5t2DkIvJo4+A5C5Qk17F/PSjXA4FVJUzNwLLSz1haOMYfUmLbGobFfl811FaNEd1VfsdfiTTiHgTb0+Pt53P01ZLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786701313; c=relaxed/simple;
	bh=0T+f8JEOj92JHGa1TCRTIxJOscVM+UJ6z6RLSzVbRqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FOgPj07bjIpsrfTzDoc97QH4OirYLvxcEsg0HQoRtWYuq9c2210vgkXESfIyBm3os2OCHyDlRA29w2Zijw99OgGG+Fswn+yBZI102yokGrVLENNVsSU4cOPVJbkCj9fnHOGn+eS3+yZYR8cJc/Rm0TM7K33C6rLvfCHbOJyNGb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S4XB3hBc; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S4XB3hBc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786701309; x=1818237309;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0T+f8JEOj92JHGa1TCRTIxJOscVM+UJ6z6RLSzVbRqQ=;
  b=S4XB3hBcLFOZVtfZhUUxTjkmjZhYSftR/Xbam+4Wkb0KXwg9QsOSffU+
   FMvJ+ZHMCArtGW/juWacfyKU1AGQS7uO0sOVvSpl1bZeLOEkF9y4vP2UV
   dUefsT7p4Kl6i3f2/698HDdaSQXHb8gsrQBrYrPJPAEQj1AwIKoep9rK+
   sgXU65Fv5G3UbEF0mcd1AySXsxdG+vfZjprbSFcxfsvxnLfdSaDURPrCc
   g/CvVQdgXZOsVcUWd/v87iO+RLEtSRd6IWmwz6jLU2FJbEukhnE2a4iDr
   YLm86+QuAwblKfJJe4qOA9KzXKQnvt1t37+hn1FV9JpYaES+ULZrb72oX
   w==;
X-CSE-ConnectionGUID: jzALNurvTgGasjkgFXmMsA==
X-CSE-MsgGUID: pyecC/GcSEK+bdcXVN6sAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="87408840"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="87408840"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 02:55:05 -0700
X-CSE-ConnectionGUID: iqNWZyRoQvqFva1sare29w==
X-CSE-MsgGUID: 962vBUMjRgC74aVrNrN5Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="266169704"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa004.fm.intel.com with ESMTP; 14 Aug 2026 02:55:03 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id D963899; Fri, 14 Aug 2026 11:55:02 +0200 (CEST)
Date: Fri, 14 Aug 2026 11:55:02 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, git@amd.com, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/2] usb: typec: tipd: fix uninitialized
 typec_partner_desc in cd321x_update_work()
Message-ID: <an7l9oHsXR3Zp8TL@black.igk.intel.com>
References: <20260812161454.149606-1-radhey.shyam.pandey@amd.com>
 <20260812161454.149606-3-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812161454.149606-3-radhey.shyam.pandey@amd.com>

On Wed, Aug 12, 2026 at 09:44:54PM +0530, Radhey Shyam Pandey wrote:
> cd321x_update_work() passes a stack-allocated typec_partner_desc to
> typec_register_partner() after initializing only usb_pd, accessory and
> identity.
> 
> typec_register_partner() copies attach and deattach from the descriptor
> into the partner. With those fields left unset, garbage function pointers
> may be stored and later invoked from typec_partner_link_device() when a USB
> device is linked to the port. Uninitialized pd_revision and usb_capability
> similarly leak stack data through partner sysfs.
> 
> Zero-initialize the descriptor so optional callbacks remain NULL and the
> remaining fields are zero.
> 
> Fixes: 82432bbfb9e8 ("usb: typec: tipd: Handle mode transitions for CD321x")
> Cc: stable@vger.kernel.org # 6.18+
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes for v3:
> - Split v2 into separate patches to simplify LTS backporting.
> - Drop Heikki reviewed-by tag as now patch is split.
> 
> Changes for v2:
> - Add  Assisted-by tag.
> - Remove explicit indentity=NULL
> 
> AI code scanning identified this issue; the possible call graph is shown below.
> 
>   USB-C plug event (IRQ)
>     tps6598x_interrupt()
>       tps6598x_handle_plug_event()
>         tps6598x_connect()
>           struct typec_partner_desc desc;     /* bug: attach/deattach unset */
>           desc.usb_pd / .accessory / .identity = ...
>           typec_register_partner(port, &desc)   /* class.c */
>             partner->attach   = desc->attach;   /* copy stack garbage */
>             partner->deattach = desc->deattach;
>             [if port->usb2_dev || port->usb3_dev already set]
>               typec_partner_link_device(partner, dev)
>                 if (partner->attach)
>                   partner->attach(partner, dev)  /* indirect call via bad ptr */
> ---
>  drivers/usb/typec/tipd/core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 54ca726c3b15..d99a55063e34 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -840,11 +840,10 @@ static void cd321x_update_work(struct work_struct *work)
>  
>  	/* Set up partner if we were previously disconnected (or changed). */
>  	if (!tps->partner) {
> -		struct typec_partner_desc desc;
> +		struct typec_partner_desc desc = { };
>  
>  		desc.usb_pd = is_pd;
>  		desc.accessory = TYPEC_ACCESSORY_NONE; /* XXX: handle accessories */
> -		desc.identity = NULL;
>  
>  		if (desc.usb_pd)
>  			desc.identity = &st.partner_identity;
> -- 
> 2.43.0

-- 
heikki
