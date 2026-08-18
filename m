Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAE53DD84A;
	Tue, 18 Aug 2026 06:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787033117; cv=none; b=f97JT3gZWIfIzPBj6Xiah7lGlJJyn7c0pfLq6rzyLAXyZrBooM3pXX94iHmE2A61ToJiSPglRkir4lqD9/2ObqAMDi/KNH+6vqslh2U5rupGG6qc95vfV9qc9fsZQ8TSHW5K5kWvPsb8Fna2xbqdxsUf/D/z5PUZjLv0Q6J3klY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787033117; c=relaxed/simple;
	bh=3LdCHce4oQ9qEx0BbeaIBtKUeAV9h84AOTuAbNmU3v4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZxjB+oeUQrF4AdlUsXNihBBBmyYIDZ4fvg9VunSWmCmMJk2bVFy0QR62GBBGqUmnuACDi1IoyaBz/s26wZjeubvMcR5DZYF1o3lolz8UqEn7rZNK00GTaY15AuMKfjnQZz2S+AvSxOk5lOpHJ6KPpJ2p9Pxf0MTme57PqFFlnaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h6B6XxWn; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h6B6XxWn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787033114; x=1818569114;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3LdCHce4oQ9qEx0BbeaIBtKUeAV9h84AOTuAbNmU3v4=;
  b=h6B6XxWnh9vIJDzAvlfBwfuJ+U7RFxtkwqN268B2e3VEslwr3fmFQihn
   yTdQQ0Ep6hCMYNRQd75TVzPaF3zzrzRqhoE2yh5fJA/JNMiSbPu7USWbc
   /RMd6GKCuqzegPBGJFyxMLqy7vZYH7MPPCdxQIG8LPuyBmLEtVuNNw/2M
   JuYZplYXeM8/yDuK/4A0nVLBHYn7t51gbZfppy30d4WoQlIhoacn2SZmF
   fGNGQHG2BfDSZcq6DpCvJF9DlQJgkWoQCqcbH62hioW8gz3erZwbVV4lK
   egO6vuLyfhjOnJ4useUaQVRBvZt1/HQlJUges+WlWyToa/ZyMgZEfx+4A
   w==;
X-CSE-ConnectionGUID: oht/gNz4RNK9CTKH1zjikw==
X-CSE-MsgGUID: iVUGcPLzRAGdQGSzs7h/aA==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="110299654"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="110299654"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 23:05:11 -0700
X-CSE-ConnectionGUID: ifrrDgw3RpCPHi4euI4Kgg==
X-CSE-MsgGUID: oVTwruWvSLaJfoPLA3Jh7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="261845305"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa007.fm.intel.com with ESMTP; 17 Aug 2026 23:05:08 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 1CF0899; Tue, 18 Aug 2026 08:05:07 +0200 (CEST)
Date: Tue, 18 Aug 2026 08:05:07 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Sven Peter <sven@kernel.org>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>, asahi@lists.linux.dev,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Konrad Dybcio <konradybcio@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 2/5] thunderbolt: Hold a switch reference for each path
 hop
Message-ID: <20260818060507.GU893316@black.igk.intel.com>
References: <20260817-b4-tbt-fixes-v1-0-eded2461f5fc@kernel.org>
 <20260817-b4-tbt-fixes-v1-2-eded2461f5fc@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260817-b4-tbt-fixes-v1-2-eded2461f5fc@kernel.org>

Hi

In $subject I prefer "router" over "switch" as that's what USB4 calls it.

On Mon, Aug 17, 2026 at 09:53:59PM +0200, Sven Peter wrote:
> tb_stop drops the reference to all DP tunnels but does not deactivate
> them, thus nothing cancels a dprx_work still in flight (which holds its
> own tunnel reference) and the tunnel can outlive tb_switch_remove. The
> HopID releases in tb_path_free then operate on freed IDAs and trigger
> warnings like
> 
>   ida_free called for id=8 which is not allocated.
> 
> Take or release a reference for both ports of each hop whenever the
> HopIDs are allocated or released to ensure they have the same lifetime.

You reproduce this by unloading the driver while DPRX work is still
running, correct? Can you mention this in the commit log, I mean how this
can be triggered.

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
> +
>  	sw->config.upstream_port_number = upstream_port;
>  	sw->config.depth = tb_route_length(route);
>  	sw->config.route_hi = upper_32_bits(route);
> 
> -- 
> 2.55.0
> 
