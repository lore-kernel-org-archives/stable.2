Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FB420125F;
	Tue, 18 Aug 2026 06:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787033396; cv=none; b=hBcwVszQ4lwn2MA4powLLDMPm5SYpE9g8ZdowGnT0c/4LDEa7BZQNL2ppptjd4GOAIH+5ueo33ZBa2F51bXgn9pS84To7UR3kJMpxls3UEZrIEhp+JaHT0IsLm4mGzgZq4F+gBwlhziRDeV+hJTbPDMbomtuabV0V9ltInciM4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787033396; c=relaxed/simple;
	bh=uByPnSFd0OYn7VntEjdOE+vMWQkaM9OgiNWRprXLcr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9JT7oEpM0K2CI5SUxHQjfs4rhNLfkTeE82bb/jDR0BdztciQKHI6CqarNU4SBFyaRt3PcLP5dCBCOfuh63WDRmFVb5j3L4cTpcARp6NtQCuMPzA/8334cN1eLcF9rpNI8MLQepakOrWpscofqGxrzTkrwCblZPoMF0RftZ27xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BaGmuQ3b; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BaGmuQ3b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787033393; x=1818569393;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uByPnSFd0OYn7VntEjdOE+vMWQkaM9OgiNWRprXLcr8=;
  b=BaGmuQ3bqFrkVQydgdOhmb/989dVyPihEWLW7r06Xu1+9h53JZ8pVez0
   GNSj8xy3DKhIh7GudlfsWclKR3Oi2fxlxl8U5gPmhVl7+IYlrnOcoxM+l
   g0vYbC/L9OOnY8t2bq1quhs5X9nKh6xs6jS+NfiYxAE8Qk6Zn2wGE7kaW
   ++ahFx4uzxWlZFKEst141Tv71M7udZLRIEnBD0P3OB6ZUg5ITfLWKIhf/
   /o+52V/3gQYn7VFt3bHppoJWdVibPQychX/z/eg8IMTRPDa+v20fgpz7X
   +OoJqzVeJSswp4oLOoQpFC+9itWgBputLSRGi4N5WbvJgxvhmaV5PvXNo
   w==;
X-CSE-ConnectionGUID: 7R0oS9m4QOePrrFZ63zFqg==
X-CSE-MsgGUID: wmjFGPqaTBKzkIHmbq1o9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="91329266"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="91329266"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 23:09:52 -0700
X-CSE-ConnectionGUID: Cf0Vf5HjQ7iAsH2zFYcHFA==
X-CSE-MsgGUID: RQ3uV12xSuK2GglH75TgSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="264689062"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa008.jf.intel.com with ESMTP; 17 Aug 2026 23:09:51 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 82EFE99; Tue, 18 Aug 2026 08:09:49 +0200 (CEST)
Date: Tue, 18 Aug 2026 08:09:49 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Sven Peter <sven@kernel.org>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>, asahi@lists.linux.dev,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Konrad Dybcio <konradybcio@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 4/5] thunderbolt: Don't access a DP tunnel after its DPRX
 read was canceled
Message-ID: <20260818060949.GV893316@black.igk.intel.com>
References: <20260817-b4-tbt-fixes-v1-0-eded2461f5fc@kernel.org>
 <20260817-b4-tbt-fixes-v1-4-eded2461f5fc@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260817-b4-tbt-fixes-v1-4-eded2461f5fc@kernel.org>

Hi,

On Mon, Aug 17, 2026 at 09:54:01PM +0200, Sven Peter wrote:
> tb_dp_dprx_work checks dprx_canceled before it takes tb->lock so it
> misses a tb_dp_dprx_stop that could not cancel the already running
> work. It then polls the DPRX capabilities and runs the callback for a
> tunnel that is being torn down and touches routers that may already be
> gone after an unplug.

Also here it would be good to describe how you reproduce this.

> 
> Check the flag with tb->lock held instead and check it again in
> tb_dp_tunnel_active because the callback runs after the lock has been
> dropped again.
> 
> Also clear the flag in tb_dp_dprx_start so that it only ever describes
> the work that is currently in flight.
> 
> Fixes: d6d458d42e1e ("thunderbolt: Handle DisplayPort tunnel activation asynchronously")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sven Peter <sven@kernel.org>
> ---
>  drivers/thunderbolt/tb.c     | 12 ++++++++++++
>  drivers/thunderbolt/tunnel.c | 11 +++++++++--
>  2 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
> index fb9da53fe391..e368a6b53f64 100644
> --- a/drivers/thunderbolt/tb.c
> +++ b/drivers/thunderbolt/tb.c
> @@ -1910,6 +1910,18 @@ static void tb_dp_tunnel_active(struct tb_tunnel *tunnel, void *data)
>  	struct tb *tb = data;
>  
>  	mutex_lock(&tb->lock);
> +
> +	/*
> +	 * If the DPRX read was canceled the tunnel is already being torn
> +	 * down by whoever canceled it. Do not touch the adapters here
> +	 * because the routers may be gone by now.
> +	 */
> +	if (tunnel->dprx_canceled) {
> +		tb_tunnel_dbg(tunnel, "DPRX read canceled, not activating\n");
> +		mutex_unlock(&tb->lock);
> +		return;
> +	}
> +
>  	if (tb_tunnel_is_active(tunnel)) {
>  		int consumed_up, consumed_down, ret;
>  
> diff --git a/drivers/thunderbolt/tunnel.c b/drivers/thunderbolt/tunnel.c
> index 82d9c0b556dd..52fa90786ff8 100644
> --- a/drivers/thunderbolt/tunnel.c
> +++ b/drivers/thunderbolt/tunnel.c
> @@ -1090,8 +1090,14 @@ static void tb_dp_dprx_work(struct work_struct *work)
>  	struct tb_tunnel *tunnel = container_of(work, typeof(*tunnel), dprx_work.work);
>  	struct tb *tb = tunnel->tb;
>  
> +	/*
> +	 * The DPRX read can be canceled while this work is waiting for
> +	 * tb->lock. Check the flag only once it is held: while the lock is
> +	 * held the tunnel cannot be torn down under us and the adapters are
> +	 * safe to access.
> +	 */
> +	mutex_lock(&tb->lock);
>  	if (!tunnel->dprx_canceled) {
> -		mutex_lock(&tb->lock);
>  		if (tb_dp_is_usb4(tunnel->src_port->sw) &&
>  		    tb_dp_wait_dprx(tunnel, TB_DPRX_WAIT_TIMEOUT)) {
>  			if (ktime_before(ktime_get(), tunnel->dprx_timeout)) {
> @@ -1103,8 +1109,8 @@ static void tb_dp_dprx_work(struct work_struct *work)
>  		} else {
>  			tb_tunnel_set_active(tunnel, true);
>  		}
> -		mutex_unlock(&tb->lock);
>  	}
> +	mutex_unlock(&tb->lock);
>  
>  	if (tunnel->callback)
>  		tunnel->callback(tunnel, tunnel->callback_data);
> @@ -1123,6 +1129,7 @@ static int tb_dp_dprx_start(struct tb_tunnel *tunnel)
>  		tb_domain_get(tunnel->tb);
>  
>  		tunnel->dprx_started = true;
> +		tunnel->dprx_canceled = false;
>  		tunnel->dprx_timeout = dprx_timeout_to_ktime(dprx_timeout);
>  		queue_delayed_work(tunnel->tb->wq, &tunnel->dprx_work, 0);
>  		return -EINPROGRESS;
> 
> -- 
> 2.55.0
> 
