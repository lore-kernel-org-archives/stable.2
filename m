Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BC737C0FE;
	Tue, 18 Aug 2026 04:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787028158; cv=none; b=eNcmEWxlA9rnWkIgTNVp/V23bkTTjoeOseE0+ya8LfR8sf51ZgpVF54RTr4druuukgo8YGxNevqNpSNFLGp+HyR1RDh5jE/ooyQbFIgfTQ0zFjbaPK2OzrbG9/XiuhYGgEjh8jYSl5McEtdxs/1L3lAiju2WrnXbiy6d2Cq1TZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787028158; c=relaxed/simple;
	bh=beJQykPMz75byPsAGpDchMYPEmOy2/H1CoYZ5C4bcsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdEye34VJPuPlD+pNhXRuz0euooYyC/aPQ6NE3RxQlsszf2F3GyXDi6DvcZvSfSikCiWA5EwmAoEdP55LFKw8XAGWek/qlBEKmoi1XTHbckA8YjuVfIv7yGcvTOBpTJIGi/1aS+LDsNCZL7MxVgYrClCAUO5Xps/3ymE+UFQwmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F0mE4OnY; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F0mE4OnY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787028157; x=1818564157;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=beJQykPMz75byPsAGpDchMYPEmOy2/H1CoYZ5C4bcsw=;
  b=F0mE4OnYPvtPENzjKreY1y5z8rvxZnBM5lgfSO7y9n0gNEWpYVb+LIa1
   0giPBkVLaT0+3aXeO/NUjU6QTSO6N5Sc2zNeGnzzQtpsHQpLvBb91b7JK
   b16lI/VY9B+tD1NftIuuf8kk3GQ2RydZ/cGlNc3Hy1ocnftS18iX0Q5BK
   hJHvL0Zjm8X/PELAOtSJS6vMCuuvJbas6f0WKokPT0xy2F53DivAjm2XW
   nq66yzF6r7ZimNAqLoREEjLM/6t+OVbAKvCtpulfARH4J0Wk5BOObLPpn
   FIWmYk2eAXHyCpSe/+Kw9DDheqyZKZLyXpWexw+aVlevyXSZxkpE2kaHt
   w==;
X-CSE-ConnectionGUID: 6r4JMpOuQRSNFoHENp0E9A==
X-CSE-MsgGUID: k6+vO9tYTSKircEyTHvQGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87529074"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="87529074"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 21:42:36 -0700
X-CSE-ConnectionGUID: 1gfHfwMZRZOINcQ8JGDwAg==
X-CSE-MsgGUID: 01wVAVsjRm2AG06qDtxQFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="261369324"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa010.fm.intel.com with ESMTP; 17 Aug 2026 21:42:33 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 5B72399; Tue, 18 Aug 2026 06:42:32 +0200 (CEST)
Date: Tue, 18 Aug 2026 06:42:32 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Sven Peter <sven@kernel.org>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>, asahi@lists.linux.dev,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Konrad Dybcio <konradybcio@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 1/5] thunderbolt: Fix tunnel reference leak when the DPRX
 work is not started
Message-ID: <20260818044232.GS893316@black.igk.intel.com>
References: <20260817-b4-tbt-fixes-v1-0-eded2461f5fc@kernel.org>
 <20260817-b4-tbt-fixes-v1-1-eded2461f5fc@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260817-b4-tbt-fixes-v1-1-eded2461f5fc@kernel.org>

Hi,

On Mon, Aug 17, 2026 at 09:53:58PM +0200, Sven Peter wrote:
> tb_dp_dprx_start always takes a tunnel reference which is only dropped
> by dprx_work eventually. Tunnels that have no callback don't ever queue
> that work and tb_dp_dprx_stop then has nothing to cancel. It however only
> releases the reference if cancel_delayed_work returned true and the
> reference is leaked then.

Okay but we always actually pass that callback there so I guess you are
hitting this because you have modified the caller in tb.c not to pass the
callback, right? If that's the case then I suggest mention how you actually
reproduced this whole issue.

I'm thinking we should make the callback mandatory instead as we always
need it for DP tunnels anyway. It should work the same also in Apple
silicon (one you have the DP tunneling in place).

> Fix this by only taking the reference when dprx_work is actually queued.
> 
> Fixes: d6d458d42e1e ("thunderbolt: Handle DisplayPort tunnel activation asynchronously")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sven Peter <sven@kernel.org>
> ---
> I didn't actually hit this on hardware but found it while fixing a domain
> leak in the same area and that fix depends on this one.
> ---
>  drivers/thunderbolt/tunnel.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/thunderbolt/tunnel.c b/drivers/thunderbolt/tunnel.c
> index b7f32305f14a..50580ebdac4b 100644
> --- a/drivers/thunderbolt/tunnel.c
> +++ b/drivers/thunderbolt/tunnel.c
> @@ -1113,15 +1113,14 @@ static void tb_dp_dprx_work(struct work_struct *work)
>  
>  static int tb_dp_dprx_start(struct tb_tunnel *tunnel)
>  {
> -	/*
> -	 * Bump up the reference to keep the tunnel around. It will be
> -	 * dropped in tb_dp_dprx_stop() once the tunnel is deactivated.
> -	 */
> -	tb_tunnel_get(tunnel);
> -
> -	tunnel->dprx_started = true;
> -
>  	if (tunnel->callback) {
> +		/*
> +		 * Bump up the reference to keep the tunnel around until the
> +		 * work has run or has been canceled.
> +		 */
> +		tb_tunnel_get(tunnel);
> +
> +		tunnel->dprx_started = true;
>  		tunnel->dprx_timeout = dprx_timeout_to_ktime(dprx_timeout);
>  		queue_delayed_work(tunnel->tb->wq, &tunnel->dprx_work, 0);
>  		return -EINPROGRESS;
> 
> -- 
> 2.55.0
> 
