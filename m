Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A374028FA;
	Wed, 12 Aug 2026 09:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786526917; cv=none; b=GPqX/WmKeiN+kUTwNP/Eo4MCpa962JhSlLiNn4RQ3bL+TSLxcGyOoThJOHPhDoZhJlqd59X7S7h64Bap8Xpv2U89S+uMs6b0Hac59DZCfP1lbiGCGJziMUbtVT8jlPegeSVNKtX5aDSHS/0J8KoKcEwiL82yJMyRxYNW70MNeYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786526917; c=relaxed/simple;
	bh=CJ0PipWjSbNv5x6/551tvLBU3zJZmV4ZgP0tjP1NKhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eao9ogQO0d0UGrRw7SqhahMOMVXD7SOl2iYrrTqQEMzVWLH4UzLcQfCStxrSfVkg2n9QvAhbQ+7fWkZc7euGZ1ujwXSCyUcFz19S+3tcHyZlJSvRD9n5wj3gC9UnDPg6bgWKopGZaLRh3ON1M9+E61wnaoe9vD5IQUZJq8KrPMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LKm1opZS; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LKm1opZS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786526915; x=1818062915;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CJ0PipWjSbNv5x6/551tvLBU3zJZmV4ZgP0tjP1NKhI=;
  b=LKm1opZSEhA1vap8XG+cO1aaJ8/y4+4Pwf5VxDac66Y9pmWP00DxSCjq
   roOGF8s7VnJbYu3JK/aYUKgx2ocoMOzVV9N/WR8ZNv8t0romNNDX+t+Va
   K7gdNcQRFhm+EpkGA2shRguw24QsygFyIogBW+hX1TBmdy/aaP9+G8r7A
   8cqDxG0gjkb57DnP8/2YW6VBi8tl3dyuPJ5qgoXTT9i6CgK1MUa1dx3WA
   e4Kbrv54GycSoDaPbgOv1hRhy6w7LSPBpIWYZLP3PsxaFuR0vKyBf+tJv
   0MdiWjmez56SjcM5aJvaGlNHgIR/jZClyu468AKbcG51ZX1MbHAxiVJBI
   g==;
X-CSE-ConnectionGUID: 5Q8TwOSbQQC6s70hSNVbGg==
X-CSE-MsgGUID: COqDbYSPQmuuvadqjAuYtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="74612106"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="74612106"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 02:28:35 -0700
X-CSE-ConnectionGUID: GbDzB1ftTMiitiW3ES2JIA==
X-CSE-MsgGUID: MwbkIWVQSDCwu9uT6U87mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="260274587"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa007.fm.intel.com with ESMTP; 12 Aug 2026 02:28:33 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 3874299; Wed, 12 Aug 2026 11:28:32 +0200 (CEST)
Date: Wed, 12 Aug 2026 11:28:32 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, git@amd.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: tipd: fix uninitialized
 typec_partner_desc on stack
Message-ID: <anw8wDlUq4Vf4JN6@black.igk.intel.com>
References: <20260807174659.3720863-1-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807174659.3720863-1-radhey.shyam.pandey@amd.com>

On Fri, Aug 07, 2026 at 11:16:58PM +0530, Radhey Shyam Pandey wrote:
> tps6598x_connect() and cd321x_update_work() pass a stack-allocated
> typec_partner_desc to typec_register_partner() after initializing only
> usb_pd, accessory and identity.
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
> Assisted-by: claude-mythos-preview-high
> Fixes: 82432bbfb9e8 ("usb: typec: tipd: Handle mode transitions for CD321x")
> Fixes: 0a4c005bd171 ("usb: typec: driver for TI TPS6598x USB Power Delivery controllers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
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
>  drivers/usb/typec/tipd/core.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 522f56742aa9..d99a55063e34 100644
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
> @@ -841,11 +840,10 @@ static void cd321x_update_work(struct work_struct *work)
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
> 
> base-commit: ea2bff00da89d7767d677bb68470130ba96f4928
> -- 
> 2.44.4

-- 
heikki
