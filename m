Received: from mta0.migadu.com (out-87.mta0.migadu.com [91.218.175.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F5B345CAA
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 01:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789694058; cv=none; b=ZtlwymA9VMTuHX6LkXjzs+7zwy5TbrK9xJPGFIoz4v1JHJkokcuJORCBTQNXedgwPsNNLb+UQtczdrRlQCJ2E/kwVE8gY09eocBt5cRGEP0H+wkufcgwQn2Q1KOUVWHVkKmSGGG3m0hE2i88XEL+qyChZuqMVrdZM2WBT0AV2M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789694058; c=relaxed/simple;
	bh=xd3HLoWCvqAvLmFf1rcOFjGuOS7Rbqozm40WR+knmgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lezJSuWceDv/ONtUi+mt0Er6OwEprzs48WrVEku7e3ueXWhqcuaJex2Vjt3e1DcKItFaY9zpLly+VBaT5r4LiojTkpPA5rKPUxupcjZCXS50ZhKA+GJfWhkjfuNHGUeFTv+r3Own5RikXxFixbetHzsdPmeWgAoWESYXnzuupXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MgD/1O1n; arc=none smtp.client-ip=91.218.175.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MgD/1O1n"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=xd3HLoWCvqAvLmFf1rcOFjGuOS7Rbqozm40WR+knmgo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789694053; v=1; x=1790298853;
 b=MgD/1O1nHCFy5UJMXRpRv9e/PAXTgqh7zpohvNNOBzry2FJlKlJfjv8VUVfOEF2AIJnKTAkH
 wjEVosSIUK7TKL78dpu5NRwPrAsHq2okpd4JD2X3TDGDQrCOuGzlLucMusyd3OaxW9mIOBKLlzN
 SxQEu9jWVK31SsKLkTv49sJI=
X-Envelope-To: stable@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 1ba77223abdbd243;
	Fri, 18 Sep 2026 01:14:03 +0000
X-Mizu-Trace-ID: 1ba77223abdbd243
X-Migadu-Flow: FLOW_OUT
Date: Fri, 18 Sep 2026 09:13:47 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	idosch@nvidia.com, alex.aring@gmail.com, justin.iurman@gmail.com,
	bestswngs@gmail.com, stefano.salsano@uniroma2.it, xmei5@asu.edu,
	stable@vger.kernel.org
Subject: Re: [PATCH net v3] ipv6: rpl: fix NULL dereference of idev in
 ipv6_rpl_srh_rcv()
Message-ID: <aqyQS7knJ2SwKxPG@fedora>
References: <20260817132644.2223-1-andrea.mayer@uniroma2.it>
 <aqjflqdySFG51YEa@fedora>
 <aqk49jT8tGsqn61d@fedora>
 <20260917194128.c078117a13eca6f3c97e3dde@uniroma2.it>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260917194128.c078117a13eca6f3c97e3dde@uniroma2.it>

Hi Andrea,
On Thu, Sep 17, 2026 at 07:41:28PM +0200, Andrea Mayer wrote:
> On Tue, 15 Sep 2026 20:24:22 +0800
> Hangbin Liu <hangbin.liu@linux.dev> wrote:
> 
> > On Tue, Sep 15, 2026 at 02:03:12PM +0800, Hangbin Liu wrote:
> > > Hi Andrea,
> > > 
> > > While reviewing the SRv6 code, I noticed you added an `idev` check in
> > > `ipv6_rthdr_rcv()`. I’m wondering whether it makes sense to also halt
> > > processing for `IPV6_SRCRT_TYPE_2` when `!idev`, given that IPv6 is
> > > disabled on that device.
> > > 
> > > If so, could we drop the skb early at the entry point of `ipv6_rthdr_rcv()`?
> > > The downside is that subsequent processing and `__IP6_INC_STATS()` would be
> > > skipped.
> > 
> > Oh, another behavior change. At present, if !idev, we can still process the
> > IPV6_SRCRT_TYPE_2 message. And the process will be skipped if we return early.
> > I'm not sure if this kind of change is acceptable or not in kernel.
> > 
> > But on the other hand, is it correct to accept and forward SRCRT Type 2
> > packets on device that IPv6 is disabled?
> > 
> > Thanks
> > Hangbin
> 
> Hi Hangbin,
> 
> One case is when IPv6 is already disabled as the packet arrives:
> ip6_rcv_core() drops the packet before ipv6_rthdr_rcv().
> The other is the transient window: dev->ip6_ptr can be cleared after
> that check, and ipv6_rthdr_rcv() can then find idev NULL.
> In that window the TYPE_2 path can run without idev. ipv6_srh_rcv() and
> ipv6_rpl_srh_rcv() cannot: they read idev->cnf. That is why the check
> sits before those two calls.

Thanks for your reply. So in fact, if IPv6 is disabled on an interface,
*all* SRCRT types get dropped in ip6_rcv_core(). The idev check inside
ipv6_rthdr_rcv() exists to close this transient window.

> 
> On the counters: __IP6_INC_STATS() goes through _DEVINC(), which skips
> the per-device bump when idev is NULL and still increments the per-net one.
> Stopping TYPE_2 in that window as well is a behaviour change, and I think
> it would need a reason of its own.

My understanding is that handling TYPE_2 within that window is also mismatched
with ip6_rcv_core(), theoretically it should not be processed.

However, since there is no harm for TYPE_2 with the current code. We can
retain the existing behavior unless someone reports issues, or until I have
time to restructure this function.

Thanks
Hangbin
