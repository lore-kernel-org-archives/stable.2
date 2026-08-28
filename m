Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C13E471CED;
	Fri, 28 Aug 2026 19:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787946278; cv=none; b=J+w1S7Hqjx945MJzh6yYiy/uRKPADj2eWOW1vb1nNT+F8mXGTySnFZ/xaXAVVrCa2p9WlBEqCCthkHkjAnrVKJkhOeIHLE21PKnqZvWMtIZJPCiBqJWrkecBkb70d2tarD1Rrbgar7GBwH8ll+QMRI0shly2qxtIBOcibvTquoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787946278; c=relaxed/simple;
	bh=RwlCa+t6dIq1rxouaYaRmmA3T7lfvMdAhNdIaM3gWgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tm449fQv5WEwQcjCWXdxCI7QJ2xcIktQ7A6cQyHVK/TsgO1gH/QSMzPxqYUGh/MdDgsteBLIQI/+jYsF7rmBGYDX4pFejdZFwIDpnBAgQIUu52nI8HLHhwH0BoCmAwr1v0KBjUpCch2iDIa1TFjlX2pTVM8r+Py3Q8MdxOpdinY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JK1LohB7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JK1LohB7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9977F1F000E9;
	Fri, 28 Aug 2026 19:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787946277;
	bh=IpdH02QA/LcoI2X6u7ScHAw7VBEB1RPjCK91e47PraA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=JK1LohB7wESH6ubI7weJLBoP4FcORJF5AU40piE4r31M8HhF1QmRZBc6sT2ZXyYpT
	 mVA9ek/7LkboqMXvWyRqo5/ytBgJ1MIe0nBxKtc6eY2qvxLrpeG9hxteg7Vqb21Tc8
	 2nhNY6z01RI3iNInWQW5xVfpdF97ID1/yt5OZzYeCvz4LqWvE5+9HpWwMOOsPLRXN8
	 Mx3XySs8nNs8bpnV8/53+aWZCmWLh2wlxFkfALeTjHhY1/qrU/4E/5TMpJuL/750vK
	 jGcuwW+Agr2awa9N7xloVYvIoaEKwfTNtrB+TX3fbiVP6eRX2AbPml8FM9E5BZo6wZ
	 3TEwmAVRNgxvA==
Message-ID: <78032928-40aa-4a38-97dd-875bde7de1f2@kernel.org>
Date: Fri, 28 Aug 2026 13:44:35 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/4] ipv4: udp: Create exceptions before socket
 matching
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, horms@kernel.org, willemdebruijn.kernel@gmail.com,
 aksecurity@gmail.com, noam.caspi@mail.huji.ac.il, stable@vger.kernel.org
References: <20260828192344.2596928-1-idosch@nvidia.com>
 <20260828192344.2596928-3-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260828192344.2596928-3-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/26 1:23 PM, Ido Schimmel wrote:
> Currently, when ICMP Fragmentation Needed and Redirect Message packets
> are locally delivered and quote a UDP packet, a FIB nexthop exception
> (FNHE) is only created if the kernel can match the UDP packet to an
> existing socket.
> 
> This behavior allows off-path attackers to conduct a side-channel attack
> on the FNHE cache in order to discover the ephemeral port used by a
> connected UDP socket.
> 
> Commit 6457378fe796 ("ipv4: use siphash instead of Jenkins in
> fnhe_hashfun()") and commit 67d6d681e15b ("ipv4: make exception cache
> less predictible") tried to mitigate such attacks by making it harder
> for attackers to discover hash collisions in the FNHE cache and by
> randomizing the number of exceptions a hash bucket can hold,
> respectively. Unfortunately, both of the mitigations can be bypassed.
> 
> Instead, mitigate such attacks by always creating a FNHE, even before
> trying to find a matching socket. Do that by calling ipv4_update_pmtu()
> and ipv4_redirect(), the helpers used when the quoted packet did not
> originate from a socket.
> 
> This means that guesses (right or wrong) from an off-path attacker will
> always result in a FNHE being created or updated in the cache that the
> attacker can observe.
> 
> Pass an oif of 0, in a similar fashion to icmp_err(). This is also the
> oif used by the socket path for sockets that are not bound to a device.
> 
> Note that this does not allow attackers to create FNHEs that they could
> not create before, as both helpers can already be reached with little to
> no validation. For example, by sending an ICMP error that quotes an ICMP
> Echo Reply or one that quotes a UDP source port that matches a wildcard
> socket.
> 
> Also note that in the good case (matched socket) the above scheme comes
> at the cost of an extra route lookup, as the no socket helpers perform
> their own lookup before the one performed by ipv4_sk_update_pmtu() /
> ipv4_sk_redirect(). When the two resolve to different nexthops, it also
> results in two exceptions being created for the same destination IP. One
> in the FNHE cache of the nexthop resolved by the no socket helpers and
> another in the FNHE cache of the nexthop used by the socket.
> 
> Fixes: 4895c771c7f0 ("ipv4: Add FIB nexthop exceptions.")
> Cc: stable@vger.kernel.org
> Reported-by: Amit Klein <aksecurity@gmail.com>
> Reported-by: Noam Caspi <noam.caspi@mail.huji.ac.il>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/ipv4/udp.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>

