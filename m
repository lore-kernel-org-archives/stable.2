Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4705F38DC4C;
	Tue, 29 Sep 2026 08:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790671040; cv=none; b=uGgjwfcyqQA+fTQ86yA/5ee+42eES9LkO3rtyX7+oQgK4AJysfbk3pk8BYBedtzhURgicSidinkpdCJEygNW1fXSvxjg4KCVdd1fXdwSw5TZQrwELfG921wUiQEwEpugygY7ktyFipb96MaPddnbgK/dLTTg5WI5rWRDX0Pl7h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790671040; c=relaxed/simple;
	bh=M2JXzE3zIwIkT1S8LxLIkp2+49+KV5l8uAfXQ+4e87c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbzsP5BTXb1omnon3EQVqCCb6bgekYPLvIegw3B8Gtw1KM/4t5jEJJhSRaDGWLBxPAa5pU8jy741WxfpFs/hPOWpPBqGmBmP1oZoOo2ME0fZQuksaWB8cO0KJS0MFUe5s81R2ulzK5ySnBdwgtPapLlfn4ZTqffe1ofZGprn+lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q59h4zwu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q59h4zwu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D0E1F000FF;
	Tue, 29 Sep 2026 08:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790671038;
	bh=YoTGfFpD5N52CwPyLgX/9cfP1trb40z1SuK53T9oW6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Q59h4zwuWG/cfTJMlPtgyuqRwFJ0/wMiwUpAtO+U/9jwGWh4v8wRRpCScbzSwioPu
	 XeBnIRy3HqEOwHFUKd46EAPuvHuLMNsyeG5Ndu0d2RCjIYEkSfqey5ngrZAIALXkqA
	 3IzIj46Nj0AK7Z56JcxoBh5kgW5XN9sSCZK5yqeogCRUEyV6lcYmXBs81xhZTCGPh2
	 3D5jn49dUK0t0zpRVbIWVDQbOfYsZANFgkBmzYhMEyu5YITyweiqsbXGQ4LRkTz782
	 Rfqq2K1PSGVVMatLZinfZcwSEEpZsbvn+txrXFLVICeQWJdGDUNmIhI4wNzIwGFKnA
	 E6NcgI+IFV9vA==
Date: Tue, 29 Sep 2026 10:37:16 +0200
From: Antoine Tenart <atenart@kernel.org>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Martin KaFai Lau <kafai@fb.com>, Wei Wang <weiwan@google.com>, 
	Hangbin Liu <hangbin.liu@linux.dev>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] ipv4: Fix device use-after-free in ip_mc_output()
Message-ID: <art4s86oKKYjHcQt@kwain>
References: <20260928162534.2122207-1-nicoyip.dev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928162534.2122207-1-nicoyip.dev@gmail.com>

On Tue, Sep 29, 2026 at 12:25:34AM +0800, Chengfeng Ye wrote:
> ip_mc_output() reads rt->dst.dev and stores it in skb->dev without RCU
> protection.  dst_dev_put() can concurrently replace the destination device
> and release the old device after an RCU grace period, leaving the multicast
> output path with a stale skb->dev.
> 
> The stale device can be dereferenced by the post-routing path.  In
> particular, a socket using IP_PMTUDISC_PROBE reaches ip_skb_dst_mtu() from
> ip_finish_output() and reads the freed device's MTU.
> 
> KASAN reported:
> 
>   BUG: KASAN: slab-use-after-free in ip_skb_dst_mtu+0x634/0x740
>   Read of size 4 at addr ffff88810921c038 by task poc/98
>   Call Trace:
>    ip_skb_dst_mtu+0x634/0x740
>    __ip_finish_output.part.0+0x22/0x2c0
>    ip_mc_output+0x287/0x930
>    ip_send_skb+0x11d/0x150
>    udp_send_skb+0x63e/0xdf0
>    udp_sendmsg+0x1235/0x1da0
>    __sys_sendto+0x32c/0x3a0
> 
>   Freed by task 99:
>    kfree+0x131/0x3c0
>    device_release+0xc8/0x240
>    kobject_put+0x14d/0x280
>    netdev_run_todo+0x4cb/0xc70
>    rtnl_dellink+0x362/0xa90
> 
> Protect the whole multicast output path with an RCU read-side critical
> section, as ip_output() already does.  Load the destination device through
> skb_dst_dev_rcu() and keep it protected through the post-routing hooks and
> ip_finish_output().
> 
> Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>

Reviewed-by: Antoine Tenart <atenart@kernel.org>

> ---
> Changes in v2:
> - Protect the whole ip_mc_output() path instead of only the MTU read.
> - Load the destination device with skb_dst_dev_rcu(), matching ip_output().
> - Use the commit that made dst device replacement RCU-protected as Fixes.
> 
> Link: https://lore.kernel.org/r/20260927071051.3693368-1-nicoyip.dev@gmail.com/ [v1]
> 
>  net/ipv4/ip_output.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> index a24cc8ee11d3..cf44597896cd 100644
> --- a/net/ipv4/ip_output.c
> +++ b/net/ipv4/ip_output.c
> @@ -367,8 +367,11 @@ static int ip_mc_finish_output(struct net *net, struct sock *sk,
>  int ip_mc_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>  {
>  	struct rtable *rt = skb_rtable(skb);
> -	struct net_device *dev = rt->dst.dev;
> +	struct net_device *dev;
> +	int ret;
>  
> +	rcu_read_lock();
> +	dev = skb_dst_dev_rcu(skb);
>  	/*
>  	 *	If the indicated interface is up and running, send the packet.
>  	 */
> @@ -406,7 +409,8 @@ int ip_mc_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>  
>  		if (ip_hdr(skb)->ttl == 0) {
>  			kfree_skb(skb);
> -			return 0;
> +			ret = 0;
> +			goto out;
>  		}
>  	}
>  
> @@ -418,10 +422,13 @@ int ip_mc_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>  				ip_mc_finish_output);
>  	}
>  
> -	return NF_HOOK_COND(NFPROTO_IPV4, NF_INET_POST_ROUTING,
> -			    net, sk, skb, NULL, skb->dev,
> -			    ip_finish_output,
> -			    !(IPCB(skb)->flags & IPSKB_REROUTED));
> +	ret = NF_HOOK_COND(NFPROTO_IPV4, NF_INET_POST_ROUTING,
> +			   net, sk, skb, NULL, skb->dev,
> +			   ip_finish_output,
> +			   !(IPCB(skb)->flags & IPSKB_REROUTED));
> +out:
> +	rcu_read_unlock();
> +	return ret;
>  }
>  
>  int ip_output(struct net *net, struct sock *sk, struct sk_buff *skb)
> -- 
> 2.43.0
