Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3053AF65A;
	Wed,  2 Sep 2026 20:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788380597; cv=none; b=u2w48Qq+OKff/RNZguQJnXnc1Vvqq0UJezw72Qs443K6c5D4B8nDPHWHjfNz01Ql6LPsKnyZTkF6jP4r9ZK4fBDbEHCmfOq65XkoCUYrZDVsqiya/M535/bbZ6PS2Yh046uucyUYoMlDUrGRBbpnawHgNygV88fLOsJJJ7+HoJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788380597; c=relaxed/simple;
	bh=nu1WIE3ei6FHDqZYvsO0hq/WTr2hgN5wXY9v84y/GZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g7Xo3SjYBc0NXw48BNwjwO1IuUXC08sYcJ3nlPjYyYSdzhcHMd737RgVSmOAfYDwW6sZcZEXP0iBNi2milKk+JI+OrTWIfNIvP1wSb81Mu9rcQFa0oQzgXgsafSCTFq90GbH8n4Ii7n3rg8rB9o8T/dJtIjKwk9RgfXKGUGT8bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3U4+ZOG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3U4+ZOG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA2091F000E9;
	Wed,  2 Sep 2026 20:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788380595;
	bh=IyD8PJIAU/ivp+yW1A765I7ZM8+hJz+Gaak/AdDpoHs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=F3U4+ZOGfURgQ+w+FTww3KK6JrTXQZ1zI18w8AcqYgVcyBC4mMpYRgjmhvpbmiLfY
	 MwDt60WAHlHRF4D2dveabEG9nR/f+FiP5WU2HVvW+HYRow8OheC44EJX0AE1YEXt++
	 O+lnHd6df0DbP30pCtWGDMEbVYTsjsYJX6+UEP2i17GhlBkzWrw9YdGjit+jGRVjXr
	 1905F7fRCBBsijQQ6gaktAwas+On1HtJdgVUnGU3pwg9Cg4+Y7AZqu5ACBhAquwwRP
	 bCLkxlxngw7gFXxTIpK+LdFpY+UxI9VmbTa/Gv9apAETJ102nZwEeWe0oyr1vrI5yP
	 9Lv8aGTPGNpew==
Message-ID: <d6b9b185-29a0-4dae-adc2-329474018bdf@kernel.org>
Date: Wed, 2 Sep 2026 14:23:13 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tunnels: Drop stale dst when building an ICMP error
 for PMTUD
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, horms@kernel.org, aconole@redhat.com,
 sbrivio@redhat.com, gnault@redhat.com, laikabcprice@gmail.com,
 aroslavdudkov622@gmail.com, rough.rock3059@datachamp.fr,
 stable@vger.kernel.org
References: <20260902190112.4126199-1-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260902190112.4126199-1-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/2/26 1:01 PM, Ido Schimmel wrote:
> Bridged UDP tunnels such as VXLAN and GENEVE build an ICMP error packet
> around an overlay packet if the packet is going to exceed the underlay
> path MTU. The ICMP error packet is then injected back into the Rx path
> with the source and destination addresses swapped, so that it will be
> delivered to the overlay source.
> 
> If the overlay packet was routed to the UDP tunnel or locally generated,
> then it is already carrying a valid dst entry and this entry is not
> dropped when transforming the packet to an ICMP error packet. This
> causes the IP layer to reuse the dst entry, leading to the ICMP error
> packet being dropped or routed out of the UDP tunnel interface in case
> of forwarding.
> 
> Prior to the blamed commit this could not happen, as
> skb_tunnel_check_pmtu() did not build ICMP errors for PACKET_HOST
> packets. Such packets were instead encapsulated and, unless the DF bit
> was set in the outer header, fragmented by the underlay.
> 
> Fix this by making sure that the ICMP error packet does not have a valid
> dst entry, thereby forcing the IP layer to perform a route lookup.
> 
> Adjust the bridged PMTU exception selftests accordingly. When the
> local sender in ns_a pings the overlay destination with a deadline
> (-w), ping exits on the first socket error before any reply is
> received and returns a non-zero exit code. The test therefore only
> passed because the ICMP error was never delivered. Use a packet count
> (-c) like the ns_c line above it, so that the ICMP error counts
> against the packet budget and the exit code depends on whether echo
> replies were received. This passes with and without the fix.
> 
> Fixes: 8930424777e4 ("tunnels: Accept PACKET_HOST in skb_tunnel_check_pmtu().")
> Cc: stable@vger.kernel.org
> Reported-by: Laika Price <laikabcprice@gmail.com>
> Closes: https://lore.kernel.org/netdev/20260614-master-v3-1-9f5060ba1ed1@gmail.com/
> Reported-by: Yaroslav Dudkov <aroslavdudkov622@gmail.com>
> Closes: https://lore.kernel.org/netdev/20260901081825.287173-1-aroslavdudkov622@gmail.com/
> Reported-by: Charles Bordet <rough.rock3059@datachamp.fr>
> Closes: https://lore.kernel.org/netdev/aHVhQLPJIhq-SYPM@eldamar.lan/
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/ipv4/ip_tunnel_core.c           | 6 ++++++
>  tools/testing/selftests/net/pmtu.sh | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


