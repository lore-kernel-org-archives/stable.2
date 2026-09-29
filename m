Received: from mta1.migadu.com (out-131.mta1.migadu.com [95.215.58.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3814D4E73AF
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 09:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790674957; cv=none; b=biqb4KmfrOShmHCP2RDaAo3f1t8/gEwKnja+Wru1Djf5wqxKj4P80H+YJjI9ypvkCGZzuVj5TGeKZNjl0Zwu/SQPj0aDrkbxAEo3zCcdkuKIAKc+tL8DZIYAaEr14UzPONLMwokgOe10wV+jRjWfYvCZ7hWBNSjk/msNg9faexI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790674957; c=relaxed/simple;
	bh=hjbnwEvt8ydnYEKvUzHxUCMmyQW3dNWvlnyx2W86n8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vrj+5oDJw/JL7QXDzplK20MmrlO501wODzGlBV6WjbineSeWTnpGh83qYZupEzZmDb2kSoI2PzvsS2C1N/FY/9D7hJOIG+jQ57bChehLtHGp//BooHxTfiIggs5zuoWx0McXBukTkF3MLld/5bR+KrEOMsLeoLu/w7hvXLurFso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oAYgTB2g; arc=none smtp.client-ip=95.215.58.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oAYgTB2g"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=hjbnwEvt8ydnYEKvUzHxUCMmyQW3dNWvlnyx2W86n8A=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790674953; v=1; x=1791279753;
 b=oAYgTB2gjkMQK7vODX+VyaWW6lNw1a+fJyDtbrnA7fA+9L60dOrgJAXIE8tITZsjptKpVu2a
 0RIz4QuHfM5IaDuGs/AJ//ZPhpm7GqEZwNPA1D0J8jvwzf4YAHNWJLHfV/9D3wBL8a6Iga9W6XJ
 mChaSZQ15gnpSfDUIDD8HzuQ=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 3290ea20537c19e2;
	Tue, 29 Sep 2026 09:42:32 +0000
X-Mizu-Trace-ID: 3290ea20537c19e2
X-Migadu-Flow: FLOW_OUT
Message-ID: <8d3bdc29-7195-42de-91d7-960d6ba81c06@linux.dev>
Date: Tue, 29 Sep 2026 17:42:22 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] ipv4: Fix device use-after-free in ip_mc_output()
To: Chengfeng Ye <nicoyip.dev@gmail.com>, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Martin KaFai Lau <kafai@fb.com>, Wei Wang <weiwan@google.com>
Cc: Hangbin Liu <hangbin.liu@linux.dev>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260928162534.2122207-1-nicoyip.dev@gmail.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260928162534.2122207-1-nicoyip.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/29/26 12:25 AM, Chengfeng Ye wrote:
> ip_mc_output() reads rt->dst.dev and stores it in skb->dev without RCU


Could you take a look at this thread ?

https://lore.kernel.org/netdev/ahveCu-zzFlpeVut@v4bel/


It seems there are still a lot of similar paths to be considered.


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
>    BUG: KASAN: slab-use-after-free in ip_skb_dst_mtu+0x634/0x740
>    Read of size 4 at addr ffff88810921c038 by task poc/98
>    Call Trace:
>     ip_skb_dst_mtu+0x634/0x740
>     __ip_finish_output.part.0+0x22/0x2c0
>     ip_mc_output+0x287/0x930
>     ip_send_skb+0x11d/0x150
>     udp_send_skb+0x63e/0xdf0
>     udp_sendmsg+0x1235/0x1da0
>     __sys_sendto+0x32c/0x3a0
>
>    Freed by task 99:
>     kfree+0x131/0x3c0
>     device_release+0xc8/0x240
>     kobject_put+0x14d/0x280
>     netdev_run_todo+0x4cb/0xc70
>     rtnl_dellink+0x362/0xa90
>
> Protect the whole multicast output path with an RCU read-side critical
> section, as ip_output() already does.  Load the destination device through
> skb_dst_dev_rcu() and keep it protected through the post-routing hooks and
> ip_finish_output().
>
> Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> ---
> Changes in v2:
> - Protect the whole ip_mc_output() path instead of only the MTU read.
> - Load the destination device with skb_dst_dev_rcu(), matching ip_output().
> - Use the commit that made dst device replacement RCU-protected as Fixes.
>
> Link: https://lore.kernel.org/r/20260927071051.3693368-1-nicoyip.dev@gmail.com/ [v1]
>
>   net/ipv4/ip_output.c | 19 +++++++++++++------
>   1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> index a24cc8ee11d3..cf44597896cd 100644
> --- a/net/ipv4/ip_output.c
> +++ b/net/ipv4/ip_output.c
> @@ -367,8 +367,11 @@ static int ip_mc_finish_output(struct net *net, struct sock *sk,
>   int ip_mc_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>   {
>   	struct rtable *rt = skb_rtable(skb);
> -	struct net_device *dev = rt->dst.dev;
> +	struct net_device *dev;
> +	int ret;
>   
> +	rcu_read_lock();
> +	dev = skb_dst_dev_rcu(skb);
>   	/*
>   	 *	If the indicated interface is up and running, send the packet.
>   	 */
> @@ -406,7 +409,8 @@ int ip_mc_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>   
>   		if (ip_hdr(skb)->ttl == 0) {
>   			kfree_skb(skb);
> -			return 0;
> +			ret = 0;
> +			goto out;
>   		}
>   	}
>   
> @@ -418,10 +422,13 @@ int ip_mc_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>   				ip_mc_finish_output);
>   	}
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
>   }
>   
>   int ip_output(struct net *net, struct sock *sk, struct sk_buff *skb)
