Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9273B370AD5
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 16:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784824882; cv=none; b=i/Zggokbi8FoeLNrMONdVmMqrLNRpI1P9+AYBetiy4ICkEaOMeQC/0uaJ8Mnyn8Hx6cLsMq+atqQ6hVV6b/INJ0Q9GV2s8wAQyDmOgaPK44GQxaeK7UKVEYcWmabO+S00s9bP6qdk3fInLyN3bUhqigZQ9cEa4TmyrbA5K+3M8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784824882; c=relaxed/simple;
	bh=fjKL20u3H7MJwfLBlBVYKcR7U31I3UVlkiS/UYwoUHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FGPPuCLwZm/VmTJaOrCKn4RBjgMIu5IDC6IhFgIKD4m0yqGtK8onpil2ZMcnh1JWoFPbY82HCJAADL3QgHcGhAlLqpWEByUoMcm92TUP/D5V80buv/aek6vhjQCFCq2Bgeux+M7xriHqUTg1kaMYnKVexfgWlXyDJ6M5716bfhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qccqKIbU; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qccqKIbU"
Message-ID: <0550c263-136b-4f50-8424-409ebd805503@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784824868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G+gn24VVAAAi6zUEkzBGlUUubpWFgtnijncTWuNJRqc=;
	b=qccqKIbUQSRqv4xWFnSdLSHC+MkTIwc99MfLERBd3csWZXzSElmq3RfTTBUevag0fVr17L
	Phewy61L7Whi9mZPu5AAmcGLX9v/JfdLXyGaHTBwiq06nVnCARv1plOEILmfMB5RHaSsM3
	AXR0NA5d7ZwXcc+3gXdPbrnDn5ALTME=
Date: Thu, 23 Jul 2026 17:41:04 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net 3/5] vxlan: use neigh_ha_snapshot() in
 route_shortcircuit()
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, stable@vger.kernel.org
References: <20260723144249.759100-1-edumazet@google.com>
 <20260723144249.759100-4-edumazet@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260723144249.759100-4-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 23/07/2026 15:42, Eric Dumazet wrote:
> The neighbour hardware address n->ha can be updated asynchronously by the
> neighbour subsystem, protected by n->ha_lock seqlock. Reading n->ha without
> holding the seqlock loop can lead to torn reads or reading a partially updated
> MAC address.
> 
> Use neigh_ha_snapshot() in route_shortcircuit() to safely copy n->ha under
> read_seqbegin()/read_seqretry() lock protection before using it.
> 
> Note that arp_reduce() and neigh_reduce() seem to have the same issue
> left for future patches.
> 
> Fixes: e4f67addf158 ("add DOVE extensions for VXLAN")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>   drivers/net/vxlan/vxlan_core.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index fb4a706cd5786d1937b1922acced31ffdb187c2f..10dd19eec09e266197ee51330a652f4e76c9643a 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -2159,9 +2159,11 @@ static bool route_shortcircuit(struct net_device *dev, struct sk_buff *skb)
>   	}
>   
>   	if (n) {
> +		u8 haddr[ETH_ALEN];
>   		bool diff;
>   
> -		diff = !ether_addr_equal(eth_hdr(skb)->h_dest, n->ha);
> +		neigh_ha_snapshot(haddr, n, dev);
> +		diff = !ether_addr_equal_unaligned(eth_hdr(skb)->h_dest, haddr);
>   		if (diff) {
>   			if (skb_cow_head(skb, 0)) {
>   				neigh_release(n);
> @@ -2169,7 +2171,7 @@ static bool route_shortcircuit(struct net_device *dev, struct sk_buff *skb)
>   			}
>   			memcpy(eth_hdr(skb)->h_source, eth_hdr(skb)->h_dest,
>   				dev->addr_len);
> -			memcpy(eth_hdr(skb)->h_dest, n->ha, dev->addr_len);
> +			memcpy(eth_hdr(skb)->h_dest, haddr, dev->addr_len);
>   		}
>   		neigh_release(n);
>   		return diff;

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
