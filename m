Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095FB3BBA01;
	Fri, 14 Aug 2026 09:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786701276; cv=none; b=RGxiH59VhJ7nLoU89EEteXwPNzesj3730zAk7RpYGOlz0EvpUceobtb+dx/bkemtkHD42iwFdBIXdYwNI0wmTVjtoxH3gel/6eEcZlSzTidhe0xRSod2JnwGdb5k/yixT5xvBCjxGudr6g17K7QguepcbRgMLPd3QRhkhirN+3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786701276; c=relaxed/simple;
	bh=PAY+8CFx9PAPTMgGFppRU4gBTVoGHxlWNUWE2+tIiZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P31Z/R7RCE4N7SkOFkJiz8rc3XOW7nhvZp8bota7Evuk3HAB7cNZvLFPUwrQ31NDQHeX3JgDwlNx8fx2IHCpJl1V8SCQtF3zOAP+zgo/5IHzOxYM7VkTNFRpQ01gLlpT576WVWfwYypJ9607EcSRi4qi2AOectjHJZXKeJNXy3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IHoOP9pO; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IHoOP9pO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786701272; x=1818237272;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PAY+8CFx9PAPTMgGFppRU4gBTVoGHxlWNUWE2+tIiZU=;
  b=IHoOP9pOheSzJpWwLtPZYt3WILAAXbY2L0G868fD2tMdQz8vPX3wnJyW
   MTRbM4tDgTi4WZhr7B2yAonYgZCa2wA+x0StPbX9lou0zuXBJHmulJ4J/
   +qdy0aFmUNUhxL9TxaQr0LXphtpo0qCkHWi61bPFnyNZvf2q/uz+CUhwM
   ZIowGXbrIjfPCq5cdy9jpRA7Y/60I2B/3g7WelfTKPjaUe2YLjLxpkFBG
   WabNoysrqBKDeBwNpj7gbZphiz5+5LxBIpTms1TtzPxANk8fDVSSsOBo0
   TVHdOu2rgUPZ+WdW/v56N3KLEVj3QyZIr2KPkDmegaEeLWfE2Yq6F3h+F
   A==;
X-CSE-ConnectionGUID: U9lszqJ+RwqWQUph3TG/iA==
X-CSE-MsgGUID: Z2Rm0sWnSViaYrCMUoLe/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="104663090"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="104663090"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 02:54:28 -0700
X-CSE-ConnectionGUID: 3/bj4uRwS1a9Yh7iH+EOBg==
X-CSE-MsgGUID: ON3zlJmHRluQYrf3N71kOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="264223360"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP; 14 Aug 2026 02:54:27 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 69C6999; Fri, 14 Aug 2026 11:54:25 +0200 (CEST)
Date: Fri, 14 Aug 2026 11:54:25 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, git@amd.com, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] usb: typec: tipd: fix uninitialized
 typec_partner_desc in tps6598x_connect()
Message-ID: <an7l0dgQisC8_Smy@black.igk.intel.com>
References: <20260812161454.149606-1-radhey.shyam.pandey@amd.com>
 <20260812161454.149606-2-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812161454.149606-2-radhey.shyam.pandey@amd.com>

On Wed, Aug 12, 2026 at 09:44:53PM +0530, Radhey Shyam Pandey wrote:
> tps6598x_connect() passes a stack-allocated typec_partner_desc to
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
> Fixes: 0a4c005bd171 ("usb: typec: driver for TI TPS6598x USB Power Delivery controllers")
> Cc: stable@vger.kernel.org # 5.15+
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
> index 522f56742aa9..54ca726c3b15 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -344,7 +344,7 @@ static void tps6598x_set_data_role(struct tps6598x *tps,
>  
>  static int tps6598x_connect(struct tps6598x *tps, u32 status)
>  {
> -	struct typec_partner_desc desc;
> +	struct typec_partner_desc desc = { };
>  	enum typec_pwr_opmode mode;
>  	int ret;
>  
> @@ -355,7 +355,6 @@ static int tps6598x_connect(struct tps6598x *tps, u32 status)
>  
>  	desc.usb_pd = mode == TYPEC_PWR_MODE_PD;
>  	desc.accessory = TYPEC_ACCESSORY_NONE; /* XXX: handle accessories */
> -	desc.identity = NULL;
>  
>  	if (desc.usb_pd) {
>  		ret = tps6598x_read_partner_identity(tps);
> -- 
> 2.43.0

-- 
heikki
