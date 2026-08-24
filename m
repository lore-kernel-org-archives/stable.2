Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735C43AA1AE;
	Mon, 24 Aug 2026 10:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787568352; cv=none; b=E4mQosIeSn4ZjhB5deqhVZuwfXKvbHxaQx3d4KlDKMFOQP7F3xHKWsAGgKvxka+pyje0N+P4ZWJlAYlT9JYvQt+sUbp3DRgcg25ejoXImBYmnTV+4/DyxVGz8offJQ5+CKkbvnRHF5sp7EsyZDW79VTpJIWVYflVai6otkbSCvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787568352; c=relaxed/simple;
	bh=05461UbdMkZxonRDgtnfK9XUrpOa29M4V9DDizrnJ9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g73unT+eZl5Qsbj1GPO2xKsY7R+LMkBxUJaHuGQXQQs+h07X9SAi4qFm26S2Bvk6pImbPYQEEeIbGqrCqcCCZ9pXTLV8p9W0fsZ/aycivwheJzv7CnrRrQ4cew5pxAo3njfoy6JrZ7HY272lT44BUIp0+LEANEdzb/0SFakISPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eD5NgO8b; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eD5NgO8b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787568350; x=1819104350;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=05461UbdMkZxonRDgtnfK9XUrpOa29M4V9DDizrnJ9A=;
  b=eD5NgO8bxVZAWAcMibXy77C2fv03J9PhLcpkX0grCfb0mT2qVNVejn6i
   MfU812+FWc+mbj6dfxy/H4esxiNvzcS8mK23iV7o/Q62z5pDYkVgc5w8i
   XDlay0aXmJgex29rz8HswvXiSE35wxEM8Xb7ZxvqrIqlyhNm4zoN93WJY
   5GtVCxNgur11D0VQ+FbiPQ6Xs7d9D1lhZekLI5SwWIQ5pRGCjyND63PYf
   FANEdOL/ZGkuQGX9+2wHMXnnTsWLz9XY+QLyWquV3ClFkiuH/yk/NSwFj
   z8rfk0xO7Ln/fREytRAFaqDp0fggr5QfA4HSGfwivo0FDsl/dX7uCJsax
   w==;
X-CSE-ConnectionGUID: 1yB8YzO9TaWQGXsadCt4bw==
X-CSE-MsgGUID: x+mk3qQnRman9pfUZR7pQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="113548616"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="113548616"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 03:45:50 -0700
X-CSE-ConnectionGUID: 1RG9Q7CGS4aJv+krVGQpDQ==
X-CSE-MsgGUID: UQOs7zVFTn6SAaUSOjvt7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="270430960"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa003.jf.intel.com with ESMTP; 24 Aug 2026 03:45:48 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 97A4599; Mon, 24 Aug 2026 12:45:46 +0200 (CEST)
Date: Mon, 24 Aug 2026 12:45:46 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Sven Peter <sven@kernel.org>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Konrad Dybcio <konradybcio@kernel.org>, asahi@lists.linux.dev,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/7] thunderbolt: Make the DP tunnel activation
 callback mandatory
Message-ID: <20260824104546.GG893316@black.igk.intel.com>
References: <20260823-b4-tbt-fixes-v2-0-26a18a426c9f@kernel.org>
 <20260823-b4-tbt-fixes-v2-2-26a18a426c9f@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260823-b4-tbt-fixes-v2-2-26a18a426c9f@kernel.org>

On Sun, Aug 23, 2026 at 06:09:15PM +0200, Sven Peter wrote:
> tb_tunnel_alloc_dp() takes an optional callback which is run from
> dprx_work once the DPRX capabilities read has completed. Without that
> callback tb_dp_dprx_start() reads the capabilities synchronously and
> never queues the work. It however always takes a tunnel reference which
> is only dropped by dprx_work itself or by tb_dp_dprx_stop() when
> cancel_delayed_work() actually canceled that work. That reference is
> thus leaked for every tunnel without a callback.
> 
> The only tunnels without one are those from tb_tunnel_discover_dp(),
> which are activated again when restoring from hibernation.
> Pass the callback to tb_tunnel_discover_dp() as well and drop the
> synchronous path such that the DPRX capabilities are always read from
> dprx_work. Hibernation restore then also no longer blocks for up to 12
> seconds while waiting for that read to complete.
> 
> Also fix up the KUnit tests.
> 
> Fixes: d6d458d42e1e ("thunderbolt: Handle DisplayPort tunnel activation asynchronously")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sven Peter <sven@kernel.org>
> ---
>  drivers/thunderbolt/tb.c     |  4 +++-
>  drivers/thunderbolt/test.c   | 37 +++++++++++++++++++++++-----------
>  drivers/thunderbolt/tunnel.c | 47 ++++++++++++++++++++++++--------------------
>  drivers/thunderbolt/tunnel.h |  8 +++++---
>  4 files changed, 60 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
> index f43f2d952372..29b9879c40d8 100644
> --- a/drivers/thunderbolt/tb.c
> +++ b/drivers/thunderbolt/tb.c
> @@ -89,6 +89,7 @@ static void tb_dp_resource_unavailable(struct tb *tb, struct tb_port *port,
>  				       const char *reason);
>  static void tb_queue_dp_bandwidth_request(struct tb *tb, u64 route, u8 port,
>  					  int retry, unsigned long delay);
> +static void tb_dp_tunnel_active(struct tb_tunnel *tunnel, void *data);

If possible move the whole function here instead of forward declaration.

>  
>  static void tb_queue_hotplug(struct tb *tb, u64 route, u8 port, bool unplug)
>  {
> @@ -385,7 +386,8 @@ static void tb_switch_discover_tunnels(struct tb_switch *sw,
>  
>  		switch (port->config.type) {
>  		case TB_TYPE_DP_HDMI_IN:
> -			tunnel = tb_tunnel_discover_dp(tb, port, alloc_hopids);
> +			tunnel = tb_tunnel_discover_dp(tb, port, alloc_hopids,
> +						       tb_dp_tunnel_active, tb);
