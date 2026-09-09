Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB712EEE8A;
	Wed,  9 Sep 2026 01:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788918894; cv=none; b=HFDeMvvxC0tNpleZ8f/TRTinVxSPA2F0GQwO+BIgicZ4ZMf93lmTLoYACtSCoWF7qvKElNbZGpTG45gimN9Y9BEFRIny2tKz2vuXI/WmQ2Yj8yDX2wWMgk1ssJsctImyjSGQ/TUkHo2/iIEV3f8WEozlFSjuBlV/7AsXsq9akRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788918894; c=relaxed/simple;
	bh=u3q67zwEWNpxcLR9UzJLGgQXapS+iQ8jZZnWpcsAoZw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tnhWhGKi4Cce9nSzW6aASO+80ly1cY6gIJw4DS2JwRLaPt+KT82+eek0D8+TpY9oDmDQUWZbqjZl65QBtdNLjFJB0Q8MW+kvwC6gl5+XaPSJ3NP6ZxL655HXRguxbQRAzohnFbpdUAiEhx9gQPSydHMvoTrcEN47ZlYZSxW4gHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmmDVkPP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmmDVkPP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A1B91F00A3A;
	Wed,  9 Sep 2026 01:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788918892;
	bh=bAb3Ny8bot1GqTJl3eZl5xMko6ZykxPClD8Vw7YzPag=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JmmDVkPPPiohw8z1U2yvO5rdEWirlppecRQ+65VZ3VTEzYatr8MHDfdzWBlQPKZSx
	 wHpDQRDFUyknzlV29ODaVULZpTdX1xnrbpL+MsofGF3Tzxqg9+vDj49W0m3XrPzixL
	 vp2mxHf161XNj8fWMdfo/X1GxSonutZjL/pAlIiybqt56kJY25DHu/1v/twvFP8TlS
	 pa4KedreJwFt8tOjVmIlMrAW7FkNgOviL1mf8WEJo1b5RE+yugjc/GnafgnCNuLbBZ
	 5slJU3hGddZ3Du7fRoGeMzEEqad7YVEOIGEZsYS4DYTTz7NpgYziER0UjlOixNgbIL
	 S0BOxhI97jTxQ==
Date: Tue, 8 Sep 2026 18:54:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Zihan Xi <zihanx@nebusec.ai>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Vega <vega@nebusec.ai>
Subject: Re: [PATCH net 1/1] net: fix linkwatch UAF on uninitialized netdev
Message-ID: <20260908185451.73a49bbd@kernel.org>
In-Reply-To: <eeaeddc20bf5382336eaf704b5b15e3780dbb768.1788500348.git.zihanx@nebusec.ai>
References: <cover.1788500348.git.zihanx@nebusec.ai>
	<eeaeddc20bf5382336eaf704b5b15e3780dbb768.1788500348.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  4 Sep 2026 06:46:44 +0000 Zihan Xi wrote:
> linkwatch_fire_event() queues a net_device onto lweventlist and takes a
> netdev_hold() even when the device has never been registered.
> 
> netif_carrier_on(), netif_carrier_off() and netif_carrier_event() already
> skip NETREG_UNINITIALIZED. netif_dormant_*() and netif_testing_*() do
> not. Pre-registration operstate changes are meant to stay local and be
> consumed later by linkwatch_init_dev() in register_netdevice().
> 
> If a driver fires a dormant or testing event before register_netdevice()
> and registration then fails, rtnl_newlink_create() calls free_netdev().
> For NETREG_UNINITIALIZED devices, free_netdev() immediately kvfree()s
> the object without draining linkwatch. The later linkwatch worker
> dereferences the stale list entry and use-after-frees the device.
> 
> The same path is reachable from an unprivileged user who can unshare
> user and net namespaces, because only netns-local CAP_NET_ADMIN is
> required.
> 
> linkwatch_fire_event() has never rejected NETREG_UNINITIALIZED devices.
> That goes back to commit 1da177e4c3f4 ("Linux-2.6.12-rc2"), the root of
> this tree. Later changes only altered callers or were reverted.
> 
> commit b47300168e77 ("net: Do not fire linkwatch events
> until the device is registered.")
> skipped uninitialized devices in the carrier helpers only.
> 
> commit 22604c866889 ("net: Fix for initial link state in 2.6.28")
> briefly added a NETREG_UNINITIALIZED return in the helper after calling
> rfc2863_policy().
> 
> commit c276e098d3ee ("Revert "net: Fix for initial link state in 2.6.28"")
> removed it again because that rfc2863_policy() call could take
> dev_base_lock in software-interrupt context.
> 
> Fix this in linkwatch_fire_event() by ignoring NETREG_UNINITIALIZED
> devices so they cannot be queued, without calling rfc2863_policy().
> Pre-registration flags remain on the device and are still applied by
> linkwatch_init_dev() if registration succeeds.

This commit message seems to be quite low quality.
It reads like the LLM was following some check box list rather than
allowed to think. From the bug report in cover letter the problem
seems to be that one caller (wifi test harness device) fires a
linkwatch even too early. And you think that the fix is to change 
the core helper to silently ignore this event? Just fix the buggy
driver?? Or if you think there's more than one such driver please
provide more info.

> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

Since your trigger didn't exist in 2.6.12 I'm not sure why you're
pointing at that commit.

FTR, the quality of the repro is also looking like a year+ old model
following a checklist:

  This is an rtnetlink RTM_NEWLINK creation path, not a packet-sequence
  or protocol-state trigger. packetdrill cannot express creating a dummy
  lower device...

Please get a better model.
