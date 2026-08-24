Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0531DB13A;
	Mon, 24 Aug 2026 10:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787568164; cv=none; b=av5MiV+ZzGjmmb9UGuYbrfqpyRm/qXXp+IcD3zAguiGOTnVOICc2m8r2m5AtrvHQmhTWpwI3juOZX5F8OIYjSBiwdbbEmMotNigW82tEm1h51iGseYSdvIIHgKuVjHad7ahKO4DZRLi1LMxPNBdAetfCEzkmrRXbOheYIZm4wo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787568164; c=relaxed/simple;
	bh=kVjUh+EoJXC8TjXoux47UFXVZqJcZMec3OAtT1y1yow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fyq4a5ZP+AHfeaYc/WJCAjsdDvtHg/Xy2mbscKMK7PGfccTv5edi1F7IAuPtnT0Klk7tMZJ9t4/Hl+2Ot9AeNeyxwH33Jio9msUUIaFDiVL9cJCcIxrysDcm9ZxR+ftw03lG3vIlvqRZINUun4upwNxHUDLJ+UTpWt/uHirnDbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D3+C35xZ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D3+C35xZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787568161; x=1819104161;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kVjUh+EoJXC8TjXoux47UFXVZqJcZMec3OAtT1y1yow=;
  b=D3+C35xZJKxdci1rJQEiWnfs1dMg7454f3kYVb1reVJsX9m6Qz1XqFq6
   40sMe6DJgZRfxlEQ7ztqwwOcShsXVXZg9k6OIugx8755fL0V4ckDm/cEm
   AhmkYzjr6jALQQETlrobK59nwoDYC/XvgqiJg3W9oXd3IY1zgOIquTI1m
   xRFrZ9Zx7rjBQ+0dF7XIuAdaA/z1ramcG1osXT8TLbwNthxHZDrPVEVMj
   WXpTxNC3SYGQNBvQcAOIn6wFScS/jEkyflU6sXGmQ6w2oLry4ogcVoo9j
   TerkwZqPXhNLyVBPCDOWbt2ti5dWhPjAkGRk3nQlBcaEG20aJid3zWK7F
   Q==;
X-CSE-ConnectionGUID: T+FBRtFlRwqLiT35ju0LRA==
X-CSE-MsgGUID: 2lMz2QPeRqq+jmn2uhWdfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="113548363"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="113548363"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 03:42:41 -0700
X-CSE-ConnectionGUID: UvUhFTxhQHC9SKsWim8WqA==
X-CSE-MsgGUID: GzbioUGIQuigVFaIe4ddNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="267013247"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP; 24 Aug 2026 03:42:39 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id DEA6199; Mon, 24 Aug 2026 12:42:37 +0200 (CEST)
Date: Mon, 24 Aug 2026 12:42:37 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Sven Peter <sven@kernel.org>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Konrad Dybcio <konradybcio@kernel.org>, asahi@lists.linux.dev,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/7] thunderbolt: Hold a router reference for each
 path hop
Message-ID: <20260824104237.GF893316@black.igk.intel.com>
References: <20260823-b4-tbt-fixes-v2-0-26a18a426c9f@kernel.org>
 <20260823-b4-tbt-fixes-v2-1-26a18a426c9f@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260823-b4-tbt-fixes-v2-1-26a18a426c9f@kernel.org>

Hi,

On Sun, Aug 23, 2026 at 06:09:14PM +0200, Sven Peter wrote:
> tb_stop drops the reference to all DP tunnels but does not deactivate
> them, thus nothing cancels a dprx_work still in flight (which holds its
> own tunnel reference) and the tunnel can outlive tb_switch_remove. The
> HopID releases in tb_path_free then operate on freed IDAs and trigger
> warnings like
> 
>   ida_free called for id=8 which is not allocated.
> 
> This can be triggered by unbinding the driver while a DP tunnel is still
> waiting for the DPRX capabilities read to finish. On the Apple NHI
> unplugging the cable runs into just that reliably because the read can
> never finish right now and because the unplug powers down the
> entire USB4 complex and removes the NHI device.

Thanks for adding this.

Is this behaviour due to something missing still on PM side or this is how
it is designed to work on Apple silicon? This resembles the early PC way
where ACPI dealt with all the hotplug PCIe stuff and the host router was
only present when a cable was connected. I would kind of expect that Apple
did this using "RTD3" way so keeping the host router present and the OS
then deals with putting it into D3 and back.

> Take or release a reference for both ports of each hop whenever the
> HopIDs are allocated or released to ensure they have the same lifetime.
> 
> The KUnit tests allocate their switches without ever registering them so
> initialize the embedded struct device there as well to make these
> references work.
> 
> Fixes: d6d458d42e1e ("thunderbolt: Handle DisplayPort tunnel activation asynchronously")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sven Peter <sven@kernel.org>
> ---
>  drivers/thunderbolt/path.c | 21 +++++++++++++++++++++
>  drivers/thunderbolt/test.c | 12 ++++++++++++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/drivers/thunderbolt/path.c b/drivers/thunderbolt/path.c
> index b2c322e76b8a..02c5e7a2101e 100644
> --- a/drivers/thunderbolt/path.c
> +++ b/drivers/thunderbolt/path.c
> @@ -196,6 +196,12 @@ struct tb_path *tb_path_discover(struct tb_port *src, int src_hopid,
>  		path->hops[i].out_port = out_port;
>  		path->hops[i].next_hop_index = next_hop;
>  
> +		/* Keep the ports alive, see tb_path_free() */
> +		if (alloc_hopid) {
> +			tb_switch_get(path->hops[i].in_port->sw);
> +			tb_switch_get(path->hops[i].out_port->sw);
> +		}

I wonder if we can put this in tb_port_alloc_in/out_hopid() instead? That
would be more "natural" IMHO.

> +
>  		tb_dump_hop(&path->hops[i], &hop);
>  
>  		h = next_hop;
> @@ -323,6 +329,10 @@ struct tb_path *tb_path_alloc(struct tb *tb, struct tb_port *src, int src_hopid,
>  		path->hops[i].out_port = out_port;
>  		path->hops[i].next_hop_index = out_hopid;
>  
> +		/* Keep the ports alive, see tb_path_free() */
> +		tb_switch_get(path->hops[i].in_port->sw);
> +		tb_switch_get(path->hops[i].out_port->sw);
> +
>  		in_hopid = out_hopid;
>  	}
>  
> @@ -356,6 +366,17 @@ void tb_path_free(struct tb_path *path)
>  			if (hop->out_port)
>  				tb_port_release_out_hopid(hop->out_port,
>  							  hop->next_hop_index);
> +			/*
> +			 * Only drop the switch references after both HopIDs

Let's use "router" universally.

> +			 * have been released: the path may be freed after the
> +			 * switch was already removed (e.g. asynchronous DP
> +			 * tunnel teardown) and these references are what
> +			 * keeps the ports and their HopID IDAs alive.
> +			 */
> +			if (hop->in_port)
> +				tb_switch_put(hop->in_port->sw);
> +			if (hop->out_port)
> +				tb_switch_put(hop->out_port->sw);
>  		}
>  	}
>  
> diff --git a/drivers/thunderbolt/test.c b/drivers/thunderbolt/test.c
> index 05652ee82fbf..034c56845380 100644
> --- a/drivers/thunderbolt/test.c
> +++ b/drivers/thunderbolt/test.c
> @@ -33,6 +33,11 @@ static void kunit_ida_init(struct kunit *test, struct ida *ida)
>  	kunit_alloc_resource(test, __ida_init, __ida_destroy, GFP_KERNEL, ida);
>  }
>  
> +static void tb_test_switch_release(struct device *dev)
> +{
> +	/* The memory is owned by KUnit, nothing to do here */
> +}
> +
>  static struct tb_switch *alloc_switch(struct kunit *test, u64 route,
>  				      u8 upstream_port, u8 max_port_number)
>  {
> @@ -44,6 +49,13 @@ static struct tb_switch *alloc_switch(struct kunit *test, u64 route,
>  	if (!sw)
>  		return NULL;
>  
> +	/*
> +	 * The paths take a reference to their switches and those devices
> +	 * have to be initialized for that to work.
> +	 */
> +	sw->dev.release = tb_test_switch_release;
> +	device_initialize(&sw->dev);

The idea was that we don't use this as real device but if we go this route
then I think we should call put_device() to release it and check for any
subtleties device_initialize() possibly does.

> +
>  	sw->config.upstream_port_number = upstream_port;
>  	sw->config.depth = tb_route_length(route);
>  	sw->config.route_hi = upper_32_bits(route);
> 
> -- 
> 2.55.0
> 
