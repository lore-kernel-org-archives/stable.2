Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF293EDE56;
	Mon, 24 Aug 2026 09:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787562357; cv=none; b=iZeVoTFzjV5tYID6yywSuVVG5p3sgG473D82VZShm0n/yFtFHfcWvkqPiME3xwYWjTK8q9e5WdpTyqmNSUFhAuwbTrlwjBX7LX3apNLVSwtrbaBFmncFLggEfKdN6cMgADAXH8HRgiEXQltgjzOIxnumNmo/tHAXsmi2x5fObWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787562357; c=relaxed/simple;
	bh=oZxCWFuQD6szuHl1pKGylf7564QNTW6TXi3gd9V3HWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EotuGmW3fwXgrS5BKJJwNqWDjiEFoWWipjvLqRwJnYfQ4dGLdwfNWCpCLhLyQGaQWQoYjpk0ovWDbWYygVkY/SzWBgLEE6A7OS7kBVOJ3vRUPHJoHNNCMLsPHAF4/fDGlLYqMOmwI9NBYHlWsC5e0NpsYXFrORzTb4m5G4oz51o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jEe2Ixuk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jEe2Ixuk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C7431F000E9;
	Mon, 24 Aug 2026 09:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787562355;
	bh=dmNYOyggAsYWtg/mnF83LfjOdjmihcNh48F4hWdUPDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jEe2Ixuk5b+/7QpBLgs0Nc+0uAVNmAKzgLj0/XlI2Dr6aOfYVr2cy+2mbscRYjI98
	 NRBMaqugh4HXKpFvxmGkEzNmnL1XUFZslrPlB7eHezJEJcMHRsKSsbFKRb3KwlKHPd
	 d6QcfPgD+BdUXaBNmIKWAsDe3V4lllbYoYeRFPQI=
Date: Mon, 24 Aug 2026 11:05:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Cc: stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Martin KaFai Lau <kafai@fb.com>, Wei Wang <weiwan@google.com>,
	thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.12.y v2] ipv4: start using dst_dev_rcu()
Message-ID: <2026082420-reanalyze-dehydrate-c386@gregkh>
References: <20260821-cve-2025-40074-v2-1-7cb3fcb7c3ac@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821-cve-2025-40074-v2-1-7cb3fcb7c3ac@bootlin.com>

On Fri, Aug 21, 2026 at 11:54:04AM +0200, Miguel Gazquez (Schneider Electric) wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> [ Upstream commit 6ad8de3cefdb6ffa6708b21c567df0dbf82c43a8 ]
> 
> Change icmpv4_xrlim_allow(), ip_defrag() to prevent possible UAF.
> 
> Change ipmr_prepare_xmit(), ipmr_queue_fwd_xmit(), ip_mr_output(),
> ipv4_neigh_lookup() to use lockdep enabled dst_dev_rcu().
> 
> [ minor modifications to fix conflict , added rcu_read_lock and unlock
> to ip_defrag function ]
> 
> Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: David Ahern <dsahern@kernel.org>
> Link: https://patch.msgid.link/20250828195823.3958522-9-edumazet@google.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>
> ---
> Signed-off-by: Miguel Gazquez <miguel.gazquez@bootlin.com>
> ---
> Changes in v2:
> - Added rcu_read_lock and unlock to ip_defrag function
> - Link to v1: https://patch.msgid.link/20260820-cve-2025-40074-v1-1-f045d5f74950@bootlin.com
> ---
>  net/ipv4/icmp.c        | 6 +++---
>  net/ipv4/ip_fragment.c | 9 +++++++--
>  net/ipv4/ipmr.c        | 4 ++--
>  net/ipv4/route.c       | 4 ++--
>  4 files changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> index c7af8b914e13..1fc967a60bb9 100644
> --- a/net/ipv4/icmp.c
> +++ b/net/ipv4/icmp.c
> @@ -320,17 +320,17 @@ static bool icmpv4_xrlim_allow(struct net *net, struct rtable *rt,
>  		return true;
>  
>  	/* No rate limit on loopback */
> -	dev = dst_dev(dst);
> +	rcu_read_lock();
> +	dev = dst_dev_rcu(dst);
>  	if (dev && (dev->flags & IFF_LOOPBACK))
>  		goto out;
>  
> -	rcu_read_lock();
>  	peer = inet_getpeer_v4(net->ipv4.peers, fl4->daddr,
>  			       l3mdev_master_ifindex_rcu(dev));
>  	rc = inet_peer_xrlim_allow(peer,
>  				   READ_ONCE(net->ipv4.sysctl_icmp_ratelimit));
> -	rcu_read_unlock();
>  out:
> +	rcu_read_unlock();
>  	if (!rc)
>  		__ICMP_INC_STATS(net, ICMP_MIB_RATELIMITHOST);
>  	else
> diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
> index d3abc84a6c02..f8919b2543e1 100644
> --- a/net/ipv4/ip_fragment.c
> +++ b/net/ipv4/ip_fragment.c
> @@ -483,13 +483,16 @@ static int ip_frag_reasm(struct ipq *qp, struct sk_buff *skb,
>  /* Process an incoming IP datagram fragment. */
>  int ip_defrag(struct net *net, struct sk_buff *skb, u32 user)
>  {
> -	struct net_device *dev = skb->dev ? : skb_dst_dev(skb);
> -	int vif = l3mdev_master_ifindex_rcu(dev);
> +	struct net_device *dev;
>  	struct ipq *qp;
> +	int vif;
>  
>  	__IP_INC_STATS(net, IPSTATS_MIB_REASMREQDS);
>  
>  	/* Lookup (or create) queue header */
> +	rcu_read_lock();
> +	dev = skb->dev ? : skb_dst_dev_rcu(skb);
> +	vif = l3mdev_master_ifindex_rcu(dev);
>  	qp = ip_find(net, ip_hdr(skb), user, vif);
>  	if (qp) {
>  		int ret;
> @@ -499,9 +502,11 @@ int ip_defrag(struct net *net, struct sk_buff *skb, u32 user)
>  		ret = ip_frag_queue(qp, skb);
>  
>  		spin_unlock(&qp->q.lock);
> +		rcu_read_unlock();
>  		ipq_put(qp);
>  		return ret;
>  	}
> +	rcu_read_unlock();
>  
>  	__IP_INC_STATS(net, IPSTATS_MIB_REASMFAILS);
>  	kfree_skb(skb);
> diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
> index de0d9cc7806a..ad0b922ebc73 100644
> --- a/net/ipv4/ipmr.c
> +++ b/net/ipv4/ipmr.c
> @@ -1906,7 +1906,7 @@ static void ipmr_queue_xmit(struct net *net, struct mr_table *mrt,
>  		goto out_free;
>  	}
>  
> -	encap += LL_RESERVED_SPACE(dev) + rt->dst.header_len;
> +	encap += LL_RESERVED_SPACE(dst_dev_rcu(&rt->dst)) + rt->dst.header_len;
>  
>  	if (skb_cow(skb, encap)) {
>  		ip_rt_put(rt);
> @@ -1943,7 +1943,7 @@ static void ipmr_queue_xmit(struct net *net, struct mr_table *mrt,
>  	 * result in receiving multiple packets.
>  	 */
>  	NF_HOOK(NFPROTO_IPV4, NF_INET_FORWARD,
> -		net, NULL, skb, skb->dev, dev,
> +		net, NULL, skb, skb->dev, dst_dev_rcu(&rt->dst),
>  		ipmr_forward_finish);
>  	return;
>  
> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> index 4dce0de6ab89..0f31ae4da3d9 100644
> --- a/net/ipv4/route.c
> +++ b/net/ipv4/route.c
> @@ -413,11 +413,11 @@ static struct neighbour *ipv4_neigh_lookup(const struct dst_entry *dst,
>  					   const void *daddr)
>  {
>  	const struct rtable *rt = container_of(dst, struct rtable, dst);
> -	struct net_device *dev = dst_dev(dst);
> +	struct net_device *dev;
>  	struct neighbour *n;
>  
>  	rcu_read_lock();
> -
> +	dev = dst_dev_rcu(dst);
>  	if (likely(rt->rt_gw_family == AF_INET)) {
>  		n = ip_neigh_gw4(dev, rt->rt_gw4);
>  	} else if (rt->rt_gw_family == AF_INET6) {
> 
> ---
> base-commit: 7155f3c7a69b8480e785f2a4252d31df95daa8d1
> change-id: 20260820-cve-2025-40074-b2b8c05342a1
> 
> Best regards,
> --  
> Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>
> 
> 

Doesn't apply to the queue anymore due to me taking this patch series
from Sasha:
	https://lore.kernel.org/r/20260821144926.3428433-1-sashal@kernel.org

Can you rebase it on that?

thanks,

greg k-h
