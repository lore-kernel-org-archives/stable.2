Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA5A41E6A7;
	Mon, 24 Aug 2026 14:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787581084; cv=none; b=uB7/4Lsn7mW8dK+HbqgmN9o83GxwXIWtOGY4Mb+QjBSZ++s2/J4L4VFeXaICTjLeWUh2VHl9UZVcUFkpfy5lC0sfdOEbD7b/rCrLBc9yNmDqHA6vK9KkZLf6ys1HQDtnglqkzG11V3dtmFl6LDoVJncSpYPx5dgCqrr1VEvtrpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787581084; c=relaxed/simple;
	bh=5u5XWutov21XCm8kelqGZUt5Fwj29/nTjgyQqrilABI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejyU+A9hZJeODoPoVV42bnM89TGVmLpe3KDM56poidezFiiO6etR5lxPpDbQBE+YqBJOfzZ4a1CjslNn/40BsvYIKiqhX4Bl0a5TyXlrrYxeY+cfpKP8KkzYH0c5SeQXkdRX2WBlCBN6Xb2Bhl1vX3NBz1Z45euast0oblX6CXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eoom/OaO; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eoom/OaO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787581082; x=1819117082;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5u5XWutov21XCm8kelqGZUt5Fwj29/nTjgyQqrilABI=;
  b=eoom/OaO6hEg2DhiTj7K0RjH/hiOjkol6aVmlKsQm9AFsBnye/qVP2aL
   wSFnp5ZxA9Mjt+hU04BGbj76jLWHdAzh+93A9XoFs2zRFvE+XL8fcnclq
   FfJMtmMgThht4ElTESoTNmDso7sA/c+YJePWrldwM4v8zp1QGUTz3B+oq
   RZRNyL9kGcWGhu+TGmMWgYdVhjoK2giXgqyrrLIxPG6ix1/mpd8u4lXZt
   NRibfGdIb4/cRN4oT1qIiGJ2h2BJ9FhM7yzanN3h/Eo+eSaZYSazVHsDX
   /HHNU4nPGzj6Igx0V0zUrno6e11ZDTA8WFuqeRRYLzcHAgWX1AfQAxluF
   A==;
X-CSE-ConnectionGUID: PAtHdUW4RCqZK9W0qPysOg==
X-CSE-MsgGUID: 1Q+KmXi8Tn2o3GEaZuVamQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="98708703"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="98708703"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 07:18:01 -0700
X-CSE-ConnectionGUID: 1F9tGv5vRq6Vmx5tddnKRg==
X-CSE-MsgGUID: Py++nsuKQDuzdYWzMar1gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="272233082"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa005.fm.intel.com with ESMTP; 24 Aug 2026 07:17:59 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id F181199; Mon, 24 Aug 2026 16:17:57 +0200 (CEST)
Date: Mon, 24 Aug 2026 16:17:57 +0200
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
Message-ID: <20260824141757.GI893316@black.igk.intel.com>
References: <20260823-b4-tbt-fixes-v2-0-26a18a426c9f@kernel.org>
 <20260823-b4-tbt-fixes-v2-2-26a18a426c9f@kernel.org>
 <20260824104546.GG893316@black.igk.intel.com>
 <b15f514d-d7de-46b7-8b78-fa21515f1fe2@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b15f514d-d7de-46b7-8b78-fa21515f1fe2@kernel.org>

On Mon, Aug 24, 2026 at 04:13:44PM +0200, Sven Peter wrote:
> 
> 
> On 8/24/26 12:45, Mika Westerberg wrote:
> > On Sun, Aug 23, 2026 at 06:09:15PM +0200, Sven Peter wrote:
> > > tb_tunnel_alloc_dp() takes an optional callback which is run from
> > > dprx_work once the DPRX capabilities read has completed. Without that
> > > callback tb_dp_dprx_start() reads the capabilities synchronously and
> > > never queues the work. It however always takes a tunnel reference which
> > > is only dropped by dprx_work itself or by tb_dp_dprx_stop() when
> > > cancel_delayed_work() actually canceled that work. That reference is
> > > thus leaked for every tunnel without a callback.
> > > 
> > > The only tunnels without one are those from tb_tunnel_discover_dp(),
> > > which are activated again when restoring from hibernation.
> > > Pass the callback to tb_tunnel_discover_dp() as well and drop the
> > > synchronous path such that the DPRX capabilities are always read from
> > > dprx_work. Hibernation restore then also no longer blocks for up to 12
> > > seconds while waiting for that read to complete.
> > > 
> > > Also fix up the KUnit tests.
> > > 
> > > Fixes: d6d458d42e1e ("thunderbolt: Handle DisplayPort tunnel activation asynchronously")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Sven Peter <sven@kernel.org>
> > > ---
> > >   drivers/thunderbolt/tb.c     |  4 +++-
> > >   drivers/thunderbolt/test.c   | 37 +++++++++++++++++++++++-----------
> > >   drivers/thunderbolt/tunnel.c | 47 ++++++++++++++++++++++++--------------------
> > >   drivers/thunderbolt/tunnel.h |  8 +++++---
> > >   4 files changed, 60 insertions(+), 36 deletions(-)
> > > 
> > > diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
> > > index f43f2d952372..29b9879c40d8 100644
> > > --- a/drivers/thunderbolt/tb.c
> > > +++ b/drivers/thunderbolt/tb.c
> > > @@ -89,6 +89,7 @@ static void tb_dp_resource_unavailable(struct tb *tb, struct tb_port *port,
> > >   				       const char *reason);
> > >   static void tb_queue_dp_bandwidth_request(struct tb *tb, u64 route, u8 port,
> > >   					  int retry, unsigned long delay);
> > > +static void tb_dp_tunnel_active(struct tb_tunnel *tunnel, void *data);
> > If possible move the whole function here instead of forward declaration.
> 
> It calls a bunch of helpers that are only defined further down and I'd have
> to move all of them as well (or forward declare them which defeats the
> purpose of doing that)

Okay then this is fine.
