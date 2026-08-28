Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D88F21CFE0;
	Fri, 28 Aug 2026 19:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787946298; cv=none; b=h8QQFVI9KGvLWsHRDMS1Hda23HmZs1xKV/sdxltFA8uyABY1uCGn7GJY71fHHNF18zMhmVyfgM1hWImFswqaWSAkg5uEh93uuEeE8YO1nHsABca5zNqaacfxYPcv/DjuDVQvsU1+XO3VTgEyJXlVPM6YhlZxFjcqyu2F6Co9t8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787946298; c=relaxed/simple;
	bh=jvZNRQq3kA0rBx/VcQ4rV7jTOcI+DelloWhRKNAxOPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nnSQKNcjJ0gI6pXKs/bQYkh0lno7MuP1DrmfRvsyD+dI8CHrCXIG6I8ga+PKiP12yyLczWZJSClwep5rGAXUCAewSpvg3d2OcaKK+DYsspEg3C7xo/4JrFJMRgGD4A0FfqZEoM8D5BqsFOhLNzvj/hh6jbl+o5XEMOkRhW6UwSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UG0i4geA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UG0i4geA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D150F1F000E9;
	Fri, 28 Aug 2026 19:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787946297;
	bh=2xrorIB96g4AterKUn/4KyE7LL2lnmN63z99FhnTzZo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=UG0i4geA2c1TEH9LgMXPn9rJEQtSOIRgvvZfalusJTZHr6NBAgSVel80106uV0wdd
	 58RoaOvFEczRCRmtmmvNd6ZlzXUHZzI3ZEFPw5eV6gImm0BkLlV8wcfh8ss4zzZGCV
	 nzPrT60eR9RMmYku/t2wmb+Mn7HV0CFV5mfhin9Dlvjt2ycQxkS3SV0xhTCP4yd5bN
	 u99wT1m0jPLJFM97k/4KiZ7Qp/U35ltaDBlTv5kDrjzc5QIAyTFjX1yr0YYbH9sUv0
	 kTYekSNGOInJ12Lf0rXkWjwOa4bDTlT/KjtlghjBTJFnFxrnaXBxjx7ivoTvOBHnaN
	 /ysnnq+TojWrA==
Message-ID: <746834f1-1a50-41c6-800f-703443efeb83@kernel.org>
Date: Fri, 28 Aug 2026 13:44:56 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 3/4] ipv6: udp: Create exceptions before socket
 matching
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, horms@kernel.org, willemdebruijn.kernel@gmail.com,
 aksecurity@gmail.com, noam.caspi@mail.huji.ac.il, stable@vger.kernel.org
References: <20260828192344.2596928-1-idosch@nvidia.com>
 <20260828192344.2596928-4-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260828192344.2596928-4-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/26 1:23 PM, Ido Schimmel wrote:
> Currently, when ICMPv6 Packet Too Big and Redirect Message packets are
> locally delivered and quote a UDP packet, an exception is only created
> in the IPv6 exception cache if the kernel can match the UDP packet to an
> existing socket.
> 
> This behavior allows off-path attackers to conduct a side-channel attack
> on the exception cache in order to discover the ephemeral port used by a
> connected UDP socket.
> 
> Commit 4785305c05b2 ("ipv6: use siphash in rt6_exception_hash()") and
> commit a00df2caffed ("ipv6: make exception cache less predictible") tried
> to mitigate such attacks by making it harder for attackers to discover
> hash collisions in the exception cache and by randomizing the number of
> exceptions a hash bucket can hold, respectively. Unfortunately, both of
> the mitigations can be bypassed.
> 
> Instead, mitigate such attacks by always creating an exception, even
> before trying to find a matching socket. Do that by calling
> ip6_update_pmtu() and ip6_redirect(), the helpers used when the quoted
> packet did not originate from a socket.
> 
> This means that guesses (right or wrong) from an off-path attacker will
> always result in an exception being created or updated in the cache that
> the attacker can observe.
> 
> Pass the ifindex of the ingress device and the default uid, in a similar
> fashion to icmpv6_err(). Unlike IPv4, an oif of 0 would not match any
> nexthop in ip6_redirect_nh_match() and no exception would be created in
> response to a Redirect Message.
> 
> Note that this does not allow attackers to create exceptions that they
> could not create before, as both helpers can already be reached with
> little to no validation. For example, by sending an ICMPv6 error that
> quotes an ICMPv6 Echo Reply or one that quotes a UDP source port that
> matches a wildcard socket.
> 
> Also note that in the good case (matched socket) the above scheme comes
> at the cost of an extra route lookup, as the no socket helpers perform
> their own lookup before the one performed by ip6_sk_update_pmtu() /
> ip6_sk_redirect(). When the two resolve to different nexthops, it also
> results in two exceptions being created for the same destination IP. One
> in the exception cache of the nexthop resolved by the no socket helpers
> and another in the exception cache of the nexthop used by the socket.
> 
> Fixes: 2b760fcf5cfb ("ipv6: hook up exception table to store dst cache")
> Cc: stable@vger.kernel.org
> Reported-by: Amit Klein <aksecurity@gmail.com>
> Reported-by: Noam Caspi <noam.caspi@mail.huji.ac.il>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/ipv6/udp.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


