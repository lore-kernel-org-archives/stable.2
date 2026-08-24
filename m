Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63632405C48;
	Mon, 24 Aug 2026 10:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787566817; cv=none; b=SnCT5QScu6ejftf0v1a9Ln4eMRCs6/Vuni0oLz9lLFkZEzSllN4iBg23WvkolbeOhRpl8aMNhqNLn8kiMxyoWzsdiguiCpHKEBIs4lSzbrz8cH4gRyhXxdqfzs4YqD1InN+qCBdrHStq6uVNJbOLU+Ss1M8SP1ph2LfqNeYsrIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787566817; c=relaxed/simple;
	bh=3D6Sd1+e/FBxZ9fkabl5xffpF/WxLKwNEek1cInCfhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KD9W9m77vYWaIzfbCRyU2BM/4NiyuBUzsYp3gribkFWxAGyPGPYyKl3LCk9nELctLmlayBcg1PUXnbULM/I31aJVpxFsBe7K8g/ZZTW/Es2eBdVRaA5p63bKkVpKm6jEkkVEs8OyKWjjexfX7gQ/11T1MfloY+31P/OyEm43Nco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h4yGG95K; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h4yGG95K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787566815; x=1819102815;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=3D6Sd1+e/FBxZ9fkabl5xffpF/WxLKwNEek1cInCfhg=;
  b=h4yGG95KMmZYhJVqp7HioJndHM7vfPULN2gP7WqYJ/uZh1TyfMG3zOos
   xbRhjcMMekNodirF/09ckGro/NM80QR7gqPhumA6ddyXC8gRPhswOfBLP
   cRE3XYYCuUlrtR1ixqXap1agr8XBaXgJuYaGCrA+nDYu8DAAdeNQyI4jM
   Jvrzdd2JzSEUg62yjrtQIiMHsLgTVFimGqCVX69EbzD0/f1L8wdJXvPKA
   SWOV4KMUG66k+M8v0CiRdxbG1KipxKefd2q1KwH+kAUtYw5kceHZ5PpF6
   Ats6B8vJZBGtdLGaGIWwcwxY662gBzRtPsSlVaHqymzzUado8xkpp6R/8
   Q==;
X-CSE-ConnectionGUID: eq+DV8ssQEupzpP5b5Mg0w==
X-CSE-MsgGUID: hfSH12vTR2azBoR+giFRUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="88029411"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="88029411"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 03:20:15 -0700
X-CSE-ConnectionGUID: W7VsOx47R32dg7wnElMHQA==
X-CSE-MsgGUID: iOIgI4ejSlGhEbYwYXP2mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="263685440"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa007.fm.intel.com with ESMTP; 24 Aug 2026 03:20:12 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id D7CC799; Mon, 24 Aug 2026 12:20:11 +0200 (CEST)
Date: Mon, 24 Aug 2026 12:20:11 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Sven Peter <sven@kernel.org>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>, asahi@lists.linux.dev,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Konrad Dybcio <konradybcio@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 5/5] thunderbolt: Cancel the DPRX read when the domain is
 stopped
Message-ID: <20260824102011.GD893316@black.igk.intel.com>
References: <20260817-b4-tbt-fixes-v1-0-eded2461f5fc@kernel.org>
 <20260817-b4-tbt-fixes-v1-5-eded2461f5fc@kernel.org>
 <20260818061717.GW893316@black.igk.intel.com>
 <1a51d323-8437-4d59-b185-710901eb9922@kernel.org>
 <d989dda7-951c-4e4a-b251-aa5e97a6ebd7@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d989dda7-951c-4e4a-b251-aa5e97a6ebd7@kernel.org>

Hi,

On Sun, Aug 23, 2026 at 01:34:17PM +0200, Sven Peter wrote:
> hi,
> 
> 
> On 8/21/26 19:58, Sven Peter wrote:
> > Hi,
> > 
> > On 8/18/26 08:17, Mika Westerberg wrote:
> > > Hi,
> > > 
> > > On Mon, Aug 17, 2026 at 09:54:02PM +0200, Sven Peter wrote:
> > > > tb_stop only tears down DMA tunnels so a DP tunnel that is still
> > > > waiting for dprx_work to complete keeps that work queued while the
> > > > routers are removed and the control channel is stopped. The work only
> > > > stops once the DPRX timeout has passed and because it requeues itself
> > > > until then the flush_workqueue in tb_domain_remove won't wait for its
> > > > final run. The callback then runs against a domain that is already torn
> > > > down. A reference to that domain is kept so the completion waiting for
> > > > that domain to disappear in unbind will block until the timeout is
> > > > eventually reached.
> > > > 
> > > > Just cancel the work in tb_stop. This doesn't affect DP tunnels that are
> > > > already alive and keeps those displays working.
> > > > 
> > > > Fixes: d6d458d42e1e ("thunderbolt: Handle DisplayPort tunnel
> > > > activation asynchronously")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Sven Peter <sven@kernel.org>
> > > > ---
> > > > I also didn't run into this but noticed it when fixing the hop
> > > > alloc thing
> > > > and think it makes sense to fix it anyway.
> > > > ---
> > > >   drivers/thunderbolt/tb.c     | 5 ++++-
> > > >   drivers/thunderbolt/tunnel.c | 9 +++++++++
> > > >   drivers/thunderbolt/tunnel.h | 1 +
> > > >   3 files changed, 14 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
> > > > index e368a6b53f64..f7e68372da09 100644
> > > > --- a/drivers/thunderbolt/tb.c
> > > > +++ b/drivers/thunderbolt/tb.c
> > > > @@ -2958,10 +2958,13 @@ static void tb_stop(struct tb *tb)
> > > >           /*
> > > >            * DMA tunnels require the driver to be functional so we
> > > >            * tear them down. Other protocol tunnels can be left
> > > > -         * intact.
> > > > +         * intact but a DPRX capabilities read that is still in
> > > > +         * flight has to be canceled before the routers go away.
> > > >            */
> > > >           if (tb_tunnel_is_dma(tunnel))
> > > >               tb_tunnel_deactivate(tunnel);
> > > > +        else if (tb_tunnel_is_dp(tunnel))
> > > > +            tb_tunnel_cancel_dprx(tunnel);
> > > I prefer not to expose "non-generic" functions for the CM if possible. I
> > > wonder if this would work:
> > > 
> > >         else if (tb_tunnel_is_dp(tunnel) && !tb_tunnel_is_active(tunnel))
> > >             tb_tunnel_deactivate(tunnel);
> > 
> > I think this might also tear down discovered tunnels because they aren't
> > originally set to active in tb_tunnel_discover_dp().
> 
> this is correct I think, but
> 
> > Only on the resume path tb_tunnel_activate() is then called on
> > everything in tcm->tunnel_list which will, because they have no
> > callback, then reach tb_dp_dprx_start(), take the synchronous path and
> > then finally end up in tb_tunnel_activate().
> 
> ^-- is only true for the hibernation path:
> 
> nhi_freeze_noirq() -> tb_domain_freeze_noirq() -> tb_freeze_noirq() ->
> hotplug_active = false but nothing else, so tunnels stay in the list

Right we keep the tunnels up until the poweroff happens so that whatever
displays the user has stay enabled.

> and then on restore:
> 
> nhi_resume_noirq() -> tb_domain_resume_noirq() -> tb_resume_noirq() ->
> tb_tunnel_activate() -> tb_dp_activate(true) -> tb_dp_dprx_start() which
> then has no callback and takes the sync path.

Indeed, I think this is a good reason to make the callback mandatory :)

> while the non-hibernation suspend path ends up in tb_tunnel_deactivate()
> which drops it from tunnel_list and the resume path is fine then I think.

Agree.
