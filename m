Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660C33750CC;
	Tue,  4 Aug 2026 12:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785846148; cv=none; b=Fh5L0xqsdASyYRkHD8ufUzNLrGm8xX80qNeO7OiGf09pLWXNS/TNU0GaIe7hQo+CpJQEOy2lFPV0YBewLt57DozG83IooYBHRjhqLBnLp+MxyjGNs1V6FP3RIhSt2KDkz/PJZ8nDv6u7x4rNwkbt1pKaSi8WJ/lRbxod4fXPcuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785846148; c=relaxed/simple;
	bh=80VPIY6cvYDU7CWSdWjXmO7aiMYm3eknZwrHXsmn++Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOBMrexP5ZgYUserieWch0KLlmd2FNy2VCNDpqVTyMdSp9P0Z4PXLDTiUDK23YFgJCA6/9wT9jr6qBtIa7v/TIxczIcGtKYTgLdpXpWLtCw9zgSDskjlaw5GBRZ+iCW/92gGDz0Ysn/OsJh1lyuRSz36NlkF2iNc0gX+DjV8oFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iv1PqUTW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iv1PqUTW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92F231F000E9;
	Tue,  4 Aug 2026 12:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785846147;
	bh=oDKv2YB+SliVBTc7RpmI0tanIUeMGo0j9xzTciOg/QA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iv1PqUTWLOdvcmrw0GwKTX7Uc0iuscfeUVF/TDYz+8zH1MEHPF/HwAVmCiIy+gEZC
	 ld62S+vXWAn7fAoNzCM5yhOYuooROU46hQ7gnNm+l6mPOVFO8cbMWaGNeW4xIGRkwS
	 PZzIRY9rg9G97TaoF2F5vTYoI9T71WNyDn2UT6sAEHuiOwDF84o6tUv5VhV4+yLLCB
	 CWT7g9cw2Z2fgeARBJaVigZVSckmPAm+/FUz4EChATtSb/0AB2aqZ4sImOzye5x/uA
	 GE0BK1PBIbEuccSO3MLQopuFUbk28JZyfMmuzcWy04kBUphB+snCMWFg7OVgkB7GQe
	 Xebdb78KJdHMQ==
Date: Tue, 4 Aug 2026 14:22:24 +0200
From: Antoine Tenart <atenart@kernel.org>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Richard Gobert <richardbgobert@gmail.com>, 
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>, Xin Long <lucien.xin@gmail.com>, William Tu <u9012063@gmail.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] fou: ensure GUE headers have enough headroom
Message-ID: <anHVNZdaVfxzbXCO@kwain>
References: <20260801060115.3538849-1-nicoyip.dev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801060115.3538849-1-nicoyip.dev@gmail.com>

On Sat, Aug 01, 2026 at 02:01:15PM +0800, Chengfeng Ye wrote:
> ipgre_changelink() installs GUE encapsulation before it publishes the
> new GRE header length and updates dev->needed_headroom.  The transmit
> path does not serialize with RTNL, so it can interleave as follows:
> 
>   CPU 0 (ipgre_changelink)        CPU 1 (ipgre_xmit)
>   install GUE encapsulation
>                                   reserve the old needed_headroom
>   publish larger GRE flags
>   update tunnel->tun_hlen
>                                   push the larger GRE header
>                                   push the GUE and UDP headers
>   update dev->needed_headroom
> 
> With REMCSUM, the new layout can push 16 bytes of GRE and 20 bytes of
> GUE/UDP headers into an skb with only 32 bytes of actual headroom.  The
> final UDP push writes four bytes before skb->head.
> 
> With the update window widened, the kernel reported:
> 
>   skbuff: skb_under_panic: ... len:128 put:8 ... dev:gre0poc
>   kernel BUG at net/core/skbuff.c:214!
>   Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
>   Call Trace:
>    skb_push
>    fou_build_udp
>    gue_build_header
>    ip_tunnel_xmit
>    __gre_xmit
>    ipgre_xmit
> 
> Make __gue_build_header() ensure space for both the GUE header it is
> about to push and the UDP header that follows.  On normally sized skbs
> the check is a no-op.  If configuration changes race with transmission,
> skb_cow_head() expands the head before either GUE write, or returns an
> error without modifying the packet.
> 
> Fixes: dd9d598c6657 ("ip_gre: add the support for i/o_flags update via netlink")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> ---
>  net/ipv4/fou_core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/ipv4/fou_core.c b/net/ipv4/fou_core.c
> index ab09dfcdecbd..8cf0d43acb41 100644
> --- a/net/ipv4/fou_core.c
> +++ b/net/ipv4/fou_core.c
> @@ -980,6 +980,8 @@ int __gue_build_header(struct sk_buff *skb, struct ip_tunnel_encap *e,
>  						skb, 0, 0, false);
>  
>  	hdrlen = sizeof(struct guehdr) + optlen;
> +	if (skb_cow_head(skb, hdrlen + sizeof(struct udphdr)))
> +		return -ENOMEM;

My understanding is this takes into account the UDP header pushed in
fou_build_udp. Isn't fou_build_header also affected by the same issue
then? (If so check the IPv6 paths too).

Also please check Sashiko's output,
https://sashiko.dev/#/patchset/20260801060115.3538849-1-nicoyip.dev%40gmail.com
