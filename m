Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A1F42E01B;
	Mon, 24 Aug 2026 13:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787579156; cv=none; b=izU9yZNoA1Rs5Nf0llTFAdJwylW905nwlWQFsqKx0Ym8CmCxauhf47Mv+yHA9dYRpC9UhpbbhM0p/FmzNizzYGLKgtcoakKgk2rdHHywnD1f5WgEamfp69vGemnHKEiPRu9ix2CwhmYnoQx0a5NdY54EgLW0dBUMzvHNC5tNgcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787579156; c=relaxed/simple;
	bh=k0LZ5aOPmi6/50zSoKd/vyIpyTWb3o/XhgzZqnE8144=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cAq/MfOx4b4lzpMMY8cAPkptrLf6tdHKORfv81K6a+iyb29ulLmCBQI0lOhGmrK8l9QF1TFvDuNBr8qjkuqHwmAWElsOJ7GFVNXPBi8zIdClWHAMAUjWVgzLczYv6Ns81hPY5ukcOyu+JOvZrgKaDuowLD3IiCzYHJKF1QGSJmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MxpeOTFd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MxpeOTFd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 747431F000E9;
	Mon, 24 Aug 2026 13:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787579152;
	bh=Q9nzPt7jIUBXzxIdZz+oQV8kPmoQxGRBVRISY+ASyys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MxpeOTFdzra/a/MubHO173tMYqjuhsSWW9lP0yDaG2LYuzKA52Oj3Eyln/UYXhZt/
	 LEUTHkNrDBtDv/J2ZYbX/MymL8vTHh9Ufov6pGruJ7virgPGWSTReTPFG7VsNI4iyv
	 QUUUrs3nbBFMkoxCiDXd3VRj4f6lyeQgRYkXXQEY=
Date: Mon, 24 Aug 2026 15:45:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Artem Dinaburg <artem@trailofbits.com>
Cc: stable@vger.kernel.org, Xiang Mei <xmei5@asu.edu>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-kernel@vger.kernel.org, AutonomousCodeSecurity@microsoft.com
Subject: Re: [PATCH 6.1.y] xfrm: fix sk_dst_cache double-free in
 xfrm_user_policy()
Message-ID: <2026082450-eggshell-gigantic-97d2@gregkh>
References: <20260821044210.10076-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821044210.10076-1-artem@trailofbits.com>

On Fri, Aug 21, 2026 at 12:42:00AM -0400, Artem Dinaburg wrote:
> From: Xiang Mei (Microsoft) <xmei5@asu.edu>
> 
> [ Upstream commit c283e9ada7fcb7dd4b10592623086b2e6d2f9925 ]
> 
> xfrm_user_policy() clears the socket dst cache with __sk_dst_reset(),
> i.e. the non-atomic __sk_dst_set(sk, NULL): it reads sk_dst_cache with
> rcu_dereference_protected(), stores NULL and dst_release()s the old dst.
> That is only safe if no other thread modifies sk_dst_cache concurrently.
> 
> For a connected UDP socket that does not hold: the transmit fast path
> (udp_sendmsg -> sk_dst_check -> sk_dst_reset) resets the cache locklessly
> with an atomic xchg(). A per-socket policy change racing a send can make
> both sides observe the same old dst and each dst_release() it, dropping
> the socket's single reference twice and freeing the xfrm_dst bundle while
> it is still referenced:
> 
>   BUG: KASAN: slab-use-after-free in dst_release
>   Write of size 4 at addr ffff88801897b6c0 by task exploit/155
>   Call Trace:
>    ...
>    dst_release (... ./include/linux/rcuref.h:109)
>    xfrm_user_policy (./include/net/sock.h:2239 ./include/net/sock.h:2256 net/xfrm/xfrm_state.c:3053)
>    do_ip_setsockopt (net/ipv4/ip_sockglue.c:1347)
>    ip_setsockopt (net/ipv4/ip_sockglue.c:1417)
>    do_sock_setsockopt (net/socket.c:2368)
>    __sys_setsockopt (net/socket.c:2393)
>    __x64_sys_setsockopt (net/socket.c:2396)
>    do_syscall_64 (arch/x86/entry/syscall_64.c:94)
>    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
> 
> Reachable by an unprivileged user via a user+network namespace.
> 
> Use the atomic sk_dst_reset() so the cache is cleared and released with a
> single xchg(): whichever side wins releases the dst once, the other sees
> NULL and does nothing. Behaviour is otherwise unchanged.
> 
> Fixes: 2b06cdf3e688 ("xfrm: Clear sk_dst_cache when applying per-socket policy.")
> Fixes: be8f8284cd89 ("net: xfrm: allow clearing socket xfrm policies.")
> Reported-by: AutonomousCodeSecurity@microsoft.com
> Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
> Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
> Assisted-by: Codex:GPT-5
> Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
> ---
> Please queue this unchanged upstream fix for CVE-2026-64581 in 6.1.y. An
> unprivileged namespace user can race UDP transmit with per-socket XFRM policy
> replacement and double-release the cached destination.
> 
> Reproduced immediately on KASAN v6.1.182; the patched target completed 50,000
> rounds. The fix is in 7.1.6 but absent from 6.1.y.

Yes, but we need it also for all other trees between those versions.
You do not want to upgrade from the 6.1.y tree to 6.6.y and have a
regression, right?

Please submit all needed backports, including this one again, and we'll
be glad to queue them up then.

thanks,

greg k-h
