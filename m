Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058931F8723;
	Tue, 18 Aug 2026 06:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787033844; cv=none; b=FLoqh2Rh5KcJcORhx/vRKVYNTkO+s9s1900wyKaJVwN5rjiDg7W4sRrbWowedP6vIa829Xbu94l0ajess++OS0cjz5kzZbDWOIBz7F9SGHKg4Q2RS9bHxS+EugVE0VfhUvDralR2TPlqT3Id+/gUnHaYY8Wf76aTto6qY/rmL+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787033844; c=relaxed/simple;
	bh=xNbdBARRum/J8SkVmBT9x1FfZk1D22cVT1NbKyKbUZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BG5M6oLMHnyTT7nKRabC8TJZBEPAeirT3v5psZhlvfAprPDrNtXBQXEZenu2YHppxxd2ISAuxqDq5xPZH4u42R1pl4+eS1RZ5qvCp7lrwmP+ZlRvUC42JYd8FD1WEVGu40L0/rTc5Lh1ohVrpUMK7nonBrVaiJtRi0LEafsxG2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O3qFbCiy; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O3qFbCiy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787033841; x=1818569841;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xNbdBARRum/J8SkVmBT9x1FfZk1D22cVT1NbKyKbUZ4=;
  b=O3qFbCiyHb3WeKYDRQ1yeYH47armzr1V6mwSoRbM6NBkVsvhbmRZ+Bi2
   msMjtiPWjfoPCSPolDChqf298Q0JY/eporPL02Eh7rfABzlLo36FC5hhC
   Ng8w6QPVrbhfcmSoF86Gc2xY/1wBs1Zcq+fs7f6IufWgzApdWp4p5TckS
   XbBS2NjnZF6ZzgSYyg9LZfxiRBBVfuNdWetLR6wZZTaWMwhHBNw5fAHaS
   ZhcX5IhBe/FoOqAfFx0TlWMsWrFF3Bj3rLOxgO9awqy1DMvVRCdR3cd62
   Ahs6yhQlozHGsndKWsjlwA77u2HuypD3XQIRrT5GF04e2PlAg72b48C4x
   g==;
X-CSE-ConnectionGUID: PzdVh7wbRc2S/ok9mKDn5A==
X-CSE-MsgGUID: oHg/rpqtT5CkZf6KpnJ8Vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87430282"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="87430282"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 23:17:20 -0700
X-CSE-ConnectionGUID: D4L980oERoe2LEsRZe/xhg==
X-CSE-MsgGUID: efY0NxXgR1ua5nFysEB9GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="268965765"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa004.jf.intel.com with ESMTP; 17 Aug 2026 23:17:18 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 44A3199; Tue, 18 Aug 2026 08:17:17 +0200 (CEST)
Date: Tue, 18 Aug 2026 08:17:17 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Sven Peter <sven@kernel.org>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>, asahi@lists.linux.dev,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Konrad Dybcio <konradybcio@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 5/5] thunderbolt: Cancel the DPRX read when the domain is
 stopped
Message-ID: <20260818061717.GW893316@black.igk.intel.com>
References: <20260817-b4-tbt-fixes-v1-0-eded2461f5fc@kernel.org>
 <20260817-b4-tbt-fixes-v1-5-eded2461f5fc@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260817-b4-tbt-fixes-v1-5-eded2461f5fc@kernel.org>

Hi,

On Mon, Aug 17, 2026 at 09:54:02PM +0200, Sven Peter wrote:
> tb_stop only tears down DMA tunnels so a DP tunnel that is still
> waiting for dprx_work to complete keeps that work queued while the
> routers are removed and the control channel is stopped. The work only
> stops once the DPRX timeout has passed and because it requeues itself
> until then the flush_workqueue in tb_domain_remove won't wait for its
> final run. The callback then runs against a domain that is already torn
> down. A reference to that domain is kept so the completion waiting for
> that domain to disappear in unbind will block until the timeout is
> eventually reached.
> 
> Just cancel the work in tb_stop. This doesn't affect DP tunnels that are
> already alive and keeps those displays working.
> 
> Fixes: d6d458d42e1e ("thunderbolt: Handle DisplayPort tunnel activation asynchronously")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sven Peter <sven@kernel.org>
> ---
> I also didn't run into this but noticed it when fixing the hop alloc thing
> and think it makes sense to fix it anyway.
> ---
>  drivers/thunderbolt/tb.c     | 5 ++++-
>  drivers/thunderbolt/tunnel.c | 9 +++++++++
>  drivers/thunderbolt/tunnel.h | 1 +
>  3 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
> index e368a6b53f64..f7e68372da09 100644
> --- a/drivers/thunderbolt/tb.c
> +++ b/drivers/thunderbolt/tb.c
> @@ -2958,10 +2958,13 @@ static void tb_stop(struct tb *tb)
>  		/*
>  		 * DMA tunnels require the driver to be functional so we
>  		 * tear them down. Other protocol tunnels can be left
> -		 * intact.
> +		 * intact but a DPRX capabilities read that is still in
> +		 * flight has to be canceled before the routers go away.
>  		 */
>  		if (tb_tunnel_is_dma(tunnel))
>  			tb_tunnel_deactivate(tunnel);
> +		else if (tb_tunnel_is_dp(tunnel))
> +			tb_tunnel_cancel_dprx(tunnel);

I prefer not to expose "non-generic" functions for the CM if possible. I
wonder if this would work:

		else if (tb_tunnel_is_dp(tunnel) && !tb_tunnel_is_active(tunnel))
			tb_tunnel_deactivate(tunnel);


>  		tb_tunnel_put(tunnel);
>  	}
>  	tb_switch_remove(tb->root_switch);
> diff --git a/drivers/thunderbolt/tunnel.c b/drivers/thunderbolt/tunnel.c
> index 52fa90786ff8..5b1ae5a0c12b 100644
> --- a/drivers/thunderbolt/tunnel.c
> +++ b/drivers/thunderbolt/tunnel.c
> @@ -2487,6 +2487,15 @@ void tb_tunnel_deactivate(struct tb_tunnel *tunnel)
>  	tb_tunnel_set_active(tunnel, false);
>  }
>  
> +/**
> + * tb_tunnel_cancel_dprx() - Cancel the DPRX capabilities read work
> + * @tunnel: tunnel to cancel the DPRX capabilities read work for
> + */
> +void tb_tunnel_cancel_dprx(struct tb_tunnel *tunnel)
> +{
> +	tb_dp_dprx_stop(tunnel);
> +}
> +
>  /**
>   * tb_tunnel_port_on_path() - Does the tunnel go through port
>   * @tunnel: Tunnel to check
> diff --git a/drivers/thunderbolt/tunnel.h b/drivers/thunderbolt/tunnel.h
> index 4878763a82b3..9de5fac04269 100644
> --- a/drivers/thunderbolt/tunnel.h
> +++ b/drivers/thunderbolt/tunnel.h
> @@ -138,6 +138,7 @@ struct tb_tunnel *tb_tunnel_alloc_usb3(struct tb *tb, struct tb_port *up,
>  void tb_tunnel_put(struct tb_tunnel *tunnel);
>  int tb_tunnel_activate(struct tb_tunnel *tunnel);
>  void tb_tunnel_deactivate(struct tb_tunnel *tunnel);
> +void tb_tunnel_cancel_dprx(struct tb_tunnel *tunnel);
>  
>  /**
>   * tb_tunnel_is_active() - Is tunnel fully activated
> 
> -- 
> 2.55.0
> 
