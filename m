Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE00370D77
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 16:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784825048; cv=none; b=Ls+vFJD/q0Wpd+lSmQx724PAPrNDonlY1LWFH4BHtJf2py/Us0LyyYrkXktsFZ1ljCTtKe3S0zdawiocIpEYlZf7g8QNuNrAOq62oFkzfNEY1WXeyU56EL4yue9HKsW9mS2yDFPIRN0aNvarjAJ6DZ/z5ByTrFsAPz6JmQuM/jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784825048; c=relaxed/simple;
	bh=XE1bs/bhfgFzwHqNa9jUpZcOPDO8JOGr7lUZSea/JUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i2i/NtjT9Zjxc/jygvsdLSx8JK8QFlAEYfR+W7uFwG2ZSaj0z4gPngX4AhVcZA59pbzhT4gNgEoquUZcZk/0FmYVsI5iJGDEfPNy982eGVh0LbVP7qG940st/EuWbqEoH9dC9AJJG0V+HaGeziwV5bx0BMzQpIsw2sysphJu+rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xxjjLDNq; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xxjjLDNq"
Message-ID: <f974b9e9-52e0-4f82-ac30-e84d50cee26b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784825044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hgYAgjezpFiK7Lyak+iGtO4lqaBDVHoIzPdft8Z85PY=;
	b=xxjjLDNqmKkgTm6wqUoKaqK2/Ss3VOG6xTVhyoGex2uJhDnrHRtl4ADjcC5KEQygl6JdMI
	nJOpYOzz/WljNzcLWeAww+ols0/GEajZ3GUS5cnhXGyY0/E5JIc2LCoNTaQxVdLIFYmJaF
	kdYgg4uQ/YLdKOJAFx+i3p4/96mKqgM=
Date: Thu, 23 Jul 2026 17:43:55 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net 5/5] vxlan: use pskb_network_may_pull() for transmit
 path header pulls
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, stable@vger.kernel.org
References: <20260723144249.759100-1-edumazet@google.com>
 <20260723144249.759100-6-edumazet@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260723144249.759100-6-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 23/07/2026 15:42, Eric Dumazet wrote:
> In vxlan_xmit(), arp_reduce(), and vxlan_mdb_entry_skb_get(), pskb_may_pull() was
> being called to verify the availability of network layer headers (ARP, IPv6/ND,
> IP/IPv6 MDB keys).
> 
> However, during transmit skb->data points to the MAC header, so skb_network_offset(skb)
> is ETH_HLEN (14 bytes). Using pskb_may_pull(skb, len) only checks len bytes from skb->data
> rather than skb_network_offset(skb) + len, which can leave part of the network header
> in non-linear frags.
> 
> Replace these remaining pskb_may_pull() calls with pskb_network_may_pull() to properly
> account for the MAC header offset.
> 
> Fixes: 465016142711 ("vxlan: Add ARP reduction support")
> Fixes: 9e061a50a116 ("vxlan: Add IPv6 Neighbor Discovery reduction support")
> Fixes: 4e94f09d84bf ("vxlan: add MDB support")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: stable@vger.kernel.org
> ---
>   drivers/net/vxlan/vxlan_core.c | 6 +++---
>   drivers/net/vxlan/vxlan_mdb.c  | 4 ++--
>   2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index 9ccbebda860480f8378918ff360deee1c46f3f7d..eff17987c5b531ecb1e2943b6274d20c1827d299 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -1850,7 +1850,7 @@ static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
>   	if (dev->flags & IFF_NOARP)
>   		goto out;
>   
> -	if (!pskb_may_pull(skb, arp_hdr_len(dev))) {
> +	if (!pskb_network_may_pull(skb, arp_hdr_len(dev))) {
>   		dev_dstats_tx_dropped(dev);
>   		vxlan_vnifilter_count(vxlan, vni, NULL,
>   				      VXLAN_VNI_STATS_TX_DROPS, 0);
> @@ -2763,8 +2763,8 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
>   			return arp_reduce(dev, skb, vni);
>   #if IS_ENABLED(CONFIG_IPV6)
>   		else if (ntohs(eth->h_proto) == ETH_P_IPV6 &&
> -			 pskb_may_pull(skb, sizeof(struct ipv6hdr) +
> -					    sizeof(struct nd_msg)) &&
> +			 pskb_network_may_pull(skb, sizeof(struct ipv6hdr) +
> +						    sizeof(struct nd_msg)) &&
>   			 ipv6_hdr(skb)->nexthdr == IPPROTO_ICMPV6) {
>   			struct nd_msg *m = (struct nd_msg *)(ipv6_hdr(skb) + 1);
>   
> diff --git a/drivers/net/vxlan/vxlan_mdb.c b/drivers/net/vxlan/vxlan_mdb.c
> index af7a0d7f95a57a17486a8ecc277b7bb9d921a061..9a9038ae90c18c5f0e4362b2b254b0c48dfdad0e 100644
> --- a/drivers/net/vxlan/vxlan_mdb.c
> +++ b/drivers/net/vxlan/vxlan_mdb.c
> @@ -1631,7 +1631,7 @@ struct vxlan_mdb_entry *vxlan_mdb_entry_skb_get(struct vxlan_dev *vxlan,
>   
>   	switch (skb->protocol) {
>   	case htons(ETH_P_IP):
> -		if (!pskb_may_pull(skb, sizeof(struct iphdr)))
> +		if (!pskb_network_may_pull(skb, sizeof(struct iphdr)))
>   			return NULL;
>   		group.dst.sa.sa_family = AF_INET;
>   		group.dst.sin.sin_addr.s_addr = ip_hdr(skb)->daddr;
> @@ -1640,7 +1640,7 @@ struct vxlan_mdb_entry *vxlan_mdb_entry_skb_get(struct vxlan_dev *vxlan,
>   		break;
>   #if IS_ENABLED(CONFIG_IPV6)
>   	case htons(ETH_P_IPV6):
> -		if (!pskb_may_pull(skb, sizeof(struct ipv6hdr)))
> +		if (!pskb_network_may_pull(skb, sizeof(struct ipv6hdr)))
>   			return NULL;
>   		group.dst.sa.sa_family = AF_INET6;
>   		group.dst.sin6.sin6_addr = ipv6_hdr(skb)->daddr;

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
