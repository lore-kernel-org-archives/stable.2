Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB06361963;
	Mon, 10 Aug 2026 18:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786388184; cv=none; b=YWyah2uZ3EJ+jKF9bxiXVI7FO/jkuwi7AetdS0I7usxyTVOA6a3sHGGNx6ApmJ2EQPUdBXgdb6UU4wV2EljnBXlSSP4UEhBBEM1d1Y1HZb7rbgFbH2K0AWtWnR+iGEoGqfnVpXPWuEtoKnweLKMFuTEdcSjI/H67M9B+Ww63Eiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786388184; c=relaxed/simple;
	bh=gVRs3AeSdilOG2pi51SsbkyBClk2vsu77Ogq3gtnbdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YA6HPCuGpdDuSYF2mVb2A6eVewuXxXQrT+v+CR1gv8z1o8h/+zfYtMTRrmHy2L6rRMReGTwL7fh7DxJvgjIy51bKGSwrHBnEeXC1t/i+1mdOyBa6Pogp5ptlkxzIt/kkY2JWlc8r/soFP1iRwgM54obvtOdirwnZrEypzJCM8wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ayKMI+HI; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ayKMI+HI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786388183; x=1817924183;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gVRs3AeSdilOG2pi51SsbkyBClk2vsu77Ogq3gtnbdg=;
  b=ayKMI+HIh6zGK2ZdDz3snElIaMcoIOWFaeFIrh/5kPAxv5g69pd5YPZJ
   6OH3+kH1He2Y7fwiozx9S8r/4lVW/9I9N3eF2d33YyfHbFT8sI15gEmFr
   qqrcSsu6IeB/e5iRQicIpLBaaw2UOZvBKfZetSTAnl0rz30YAYJRI0E87
   QzRRjDPqeoPNZb1Ex6Iiso+lEjbM+6eIg2hve8gjUSZ4cuapsEJHBEV8h
   oR5O10T3I2KA0VfwJYH5eHM/I7pfhHQ56C02boipaXji3apdySnO1qtwF
   /seEmlTVPkKoV6ZugWTJCwdYNiVSce4r6XhxI7fwGr0OXTl3aY0Xkeec7
   A==;
X-CSE-ConnectionGUID: R2a/nUwDTMSMZ1OkBBWA+A==
X-CSE-MsgGUID: tlpgp7tyRYmMLjDEM5MeeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="97263535"
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="97263535"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 11:56:22 -0700
X-CSE-ConnectionGUID: 5H2exk9yTx2BNZC+q6TmBg==
X-CSE-MsgGUID: pfyz1KfHQgul1r4my4h+sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="266607290"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.99])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 11:56:18 -0700
Date: Mon, 10 Aug 2026 21:56:16 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: fy15309206903@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH net v2 1/2] net: thunderbolt: Release the Rx HopID that
 was handed out on mismatch
Message-ID: <anoe0LCeiR9NIz2o@ashevche-desk.local>
References: <20260810-b4-tbnet-hopid-v2-0-0eee557e75df@gmail.com>
 <20260810-b4-tbnet-hopid-v2-1-0eee557e75df@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810-b4-tbnet-hopid-v2-1-0eee557e75df@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 10, 2026 at 09:39:14AM +0000, Fan Ye via B4 Relay wrote:

> tbnet_connected_work() asks for a specific input HopID and treats getting
> a different one as a failure:
> 
> 	ret = tb_xdomain_alloc_in_hopid(net->xd, net->remote_transmit_path);
> 	if (ret != net->remote_transmit_path) {
> 		netdev_err(net->dev, "failed to allocate Rx HopID\n");
> 		return;
> 	}

No need to cite the code, we all able to see it well from the source tree.

> That call ends in ida_alloc_range(&xd->in_hopids, hopid,
> xd->local_max_hopid, GFP_KERNEL), which allocates the lowest free id at
> or above the one asked for. When the
> wanted HopID is already taken it does not fail - it succeeds with the next
> one - so this path returns with an id allocated and no reference to it
> left anywhere. It stays allocated for the rest of the XDomain connection.
> 
> Forcing the branch by occupying the wanted HopID first shows the returned
> id is a live allocation, not an error code:
> 
>   LEAKPROBE squat=8 requested=8 local_max_hopid=27
>   LEAKPROBE real alloc ret=9
>   thunderbolt-net 0-1.0 thunderbolt0: failed to allocate Rx HopID
> 
> Release the id when it is not the one we wanted, matching what the error
> unwind at the end of the function already does for the expected id.

General hint: do not blindly copy'n'paste the Dostoevsky saga from AI. Squeeze
it and show (by rephrasing) that you also understand what's going on there.

-- 
With Best Regards,
Andy Shevchenko


