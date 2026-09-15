Received: from mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF7643A7E7
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 06:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789452199; cv=none; b=TX51kibEw02/xty7fzujHv/ZjRnLoDBgCAzUozsaYo0WnQwpkeeSw0B9P/C54ITIBCKJhUnuS7lUgsNXZy9KFlrm+HwjgUyftmCqW6aeBVadlbp8xPo/NXEE7/SmZWpmLVd+4SS2HsUnJ7p33Jsl1w79FiZGqFJ907NrhuAyQpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789452199; c=relaxed/simple;
	bh=VxXvoS/pk6AQ9isv9v+6xTsGC/UpL94vqH+j6nxcV5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IMllVMeGRTK2KTyYzsHMIK9fYA78hn25axTyDT83MkRUhfGI+9VnDWvknMJXI1kN00Zj7dPDWFCHW81dN70s2Jpl4Aa9LQEOoEewf8QqerBlWY2aapoh9obd1g02g60JQ4CdqXRP/pMJeUTWu0bPVIh7BdCjze08ND0XC57B8BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GqqNC5xB; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GqqNC5xB"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=VxXvoS/pk6AQ9isv9v+6xTsGC/UpL94vqH+j6nxcV5U=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789452192; v=1; x=1790056992;
 b=GqqNC5xBjYCRR4xW16fkZZiZFicVUleepiiW3yVCd3/zUJz4wCmXHtHGw5vbl8lbAsQI00Cg
 dczApg/koqiiMgyz+BLmUQvVCk2zN9Hl6KhBx9AH5L9iKxCOOQ01tu2Qsw6bTawj1bEDLoRJpIs
 L22Q/3X54YDkqFBTJOPPWzNA=
X-Envelope-To: stable@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 013b99232fc5dfaa;
	Tue, 15 Sep 2026 06:03:12 +0000
X-Mizu-Trace-ID: 013b99232fc5dfaa
X-Migadu-Flow: FLOW_OUT
Date: Tue, 15 Sep 2026 14:03:02 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	idosch@nvidia.com, alex.aring@gmail.com, justin.iurman@gmail.com,
	bestswngs@gmail.com, stefano.salsano@uniroma2.it, xmei5@asu.edu,
	stable@vger.kernel.org
Subject: Re: [PATCH net v3] ipv6: rpl: fix NULL dereference of idev in
 ipv6_rpl_srh_rcv()
Message-ID: <aqjflqdySFG51YEa@fedora>
References: <20260817132644.2223-1-andrea.mayer@uniroma2.it>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260817132644.2223-1-andrea.mayer@uniroma2.it>

Hi Andrea,

While reviewing the SRv6 code, I noticed you added an `idev` check in
`ipv6_rthdr_rcv()`. I’m wondering whether it makes sense to also halt
processing for `IPV6_SRCRT_TYPE_2` when `!idev`, given that IPv6 is
disabled on that device.

If so, could we drop the skb early at the entry point of `ipv6_rthdr_rcv()`?
The downside is that subsequent processing and `__IP6_INC_STATS()` would be
skipped.

BTW, `ipv6_rthdr_rcv()` handles both `IPV6_SRCRT_TYPE_3/4` entry points and
the full `IPV6_SRCRT_TYPE_2` processing path. There are four separate
`switch (hdr->type)` blocks inside this function. I plan to refactor it for
clearer logic. Do you think this is feasible, or unnecessary?

Thanks
Hangbin
On Mon, Aug 17, 2026 at 03:26:44PM +0200, Andrea Mayer wrote:
> ipv6_rpl_srh_rcv() dereferences idev from __in6_dev_get() without a NULL
> check when reading idev->cnf.rpl_seg_enabled.
> 
> When the device's MTU drops below IPV6_MIN_MTU, addrconf_ifdown() clears
> dev->ip6_ptr through RCU_INIT_POINTER(). A packet that passed the idev
> check in ip6_rcv_core() can then reach ipv6_rpl_srh_rcv() with
> dev->ip6_ptr already NULL.
> 
> Reproduced by flooding the receiving interface with ping6 traffic while
> flapping its MTU between 1500 and 1200:
> 
>  BUG: KASAN: null-ptr-deref in ipv6_rpl_srh_rcv+0xb3/0x1070
>  Read of size 4 at addr 00000000000006b4 by task ping6/394
> 
>  CPU: 2 UID: 0 PID: 394 Comm: ping6 Not tainted 7.2.0-rc7-micro-vm-dev-00095-g24ef02f934ee #240 PREEMPT(full)
>  Call Trace:
>   <IRQ>
>   kasan_report+0xc6/0x100
>   ipv6_rpl_srh_rcv+0xb3/0x1070
>   ip6_protocol_deliver_rcu+0x759/0x9a0
>   ip6_input_finish+0xa8/0x1b0
>   ip6_input+0xe1/0x490
>   ipv6_rcv+0x33d/0x460
>   __netif_receive_skb_one_core+0xd6/0x130
>   process_backlog+0x2cc/0xa00
>   __napi_poll.constprop.0+0x56/0x270
>   net_rx_action+0x327/0x730
>   handle_softirqs+0x11e/0x630
>   do_softirq+0xb3/0xf0
>   </IRQ>
> 
> Both ipv6_rpl_srh_rcv() and ipv6_srh_rcv() are called only from
> ipv6_rthdr_rcv(), which already has an idev lookup.
> 
> Fix the NULL dereference on the RPL path by checking idev in
> ipv6_rthdr_rcv(), before it calls either function. The callees take idev as
> an argument and no longer call __in6_dev_get(), so the packet is now
> dropped in one place, with SKB_DROP_REASON_IPV6DISABLED on both paths.
> 
> Fixes: 8610c7c6e3bd ("net: ipv6: add support for rpl sr exthdr")
> Cc: stable@vger.kernel.org
> Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
> Tested-by: Xiang Mei <xmei5@asu.edu>
> ---
> v3:
>   - move the idev NULL check into ipv6_rthdr_rcv() and use the same drop
>     reason on the seg6 and RPL paths (David Ahern)
>   - pass idev to ipv6_srh_rcv() and ipv6_rpl_srh_rcv(), and check it for
>     NULL in ipv6_rthdr_rcv() only for the seg6 and RPL types
>   - add Xiang Mei's Tested-by tag
> v2: https://lore.kernel.org/netdev/20260518140630.24280-1-andrea.mayer@uniroma2.it/
>   - use SKB_DROP_REASON_IPV6DISABLED as drop reason (Eric Dumazet)
> v1: https://lore.kernel.org/netdev/20260428224816.11223-1-andrea.mayer@uniroma2.it/
> ---
>  net/ipv6/exthdrs.c | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
> index 9c677eb1d1a6..51941ad656a3 100644
> --- a/net/ipv6/exthdrs.c
> +++ b/net/ipv6/exthdrs.c
> @@ -368,23 +368,16 @@ static void seg6_update_csum(struct sk_buff *skb)
>  			   (__be32 *)addr);
>  }
>  
> -static int ipv6_srh_rcv(struct sk_buff *skb)
> +static int ipv6_srh_rcv(struct sk_buff *skb, struct inet6_dev *idev)
>  {
>  	struct inet6_skb_parm *opt = IP6CB(skb);
>  	struct net *net = dev_net(skb->dev);
>  	struct ipv6_sr_hdr *hdr;
> -	struct inet6_dev *idev;
>  	struct in6_addr *addr;
>  	int accept_seg6;
>  
>  	hdr = (struct ipv6_sr_hdr *)skb_transport_header(skb);
>  
> -	idev = __in6_dev_get(skb->dev);
> -	if (!idev) {
> -		kfree_skb(skb);
> -		return -1;
> -	}
> -
>  	accept_seg6 = min(READ_ONCE(net->ipv6.devconf_all->seg6_enabled),
>  			  READ_ONCE(idev->cnf.seg6_enabled));
>  
> @@ -485,12 +478,11 @@ static int ipv6_srh_rcv(struct sk_buff *skb)
>  	return -1;
>  }
>  
> -static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
> +static int ipv6_rpl_srh_rcv(struct sk_buff *skb, struct inet6_dev *idev)
>  {
>  	struct ipv6_rpl_sr_hdr *hdr, *ohdr, *chdr;
>  	struct inet6_skb_parm *opt = IP6CB(skb);
>  	struct net *net = dev_net(skb->dev);
> -	struct inet6_dev *idev;
>  	struct ipv6hdr *oldhdr;
>  	unsigned int chdr_len;
>  	unsigned char *buf;
> @@ -499,8 +491,6 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
>  	u64 n = 0;
>  	u32 r;
>  
> -	idev = __in6_dev_get(skb->dev);
> -
>  	accept_rpl_seg = min(READ_ONCE(net->ipv6.devconf_all->rpl_seg_enabled),
>  			     READ_ONCE(idev->cnf.rpl_seg_enabled));
>  	if (!accept_rpl_seg) {
> @@ -689,10 +679,14 @@ static int ipv6_rthdr_rcv(struct sk_buff *skb)
>  	switch (hdr->type) {
>  	case IPV6_SRCRT_TYPE_4:
>  		/* segment routing */
> -		return ipv6_srh_rcv(skb);
> +		if (!idev)
> +			goto disabled;
> +		return ipv6_srh_rcv(skb, idev);
>  	case IPV6_SRCRT_TYPE_3:
>  		/* rpl segment routing */
> -		return ipv6_rpl_srh_rcv(skb);
> +		if (!idev)
> +			goto disabled;
> +		return ipv6_rpl_srh_rcv(skb, idev);
>  	default:
>  		break;
>  	}
> @@ -837,6 +831,10 @@ static int ipv6_rthdr_rcv(struct sk_buff *skb)
>  	icmpv6_param_prob(skb, ICMPV6_HDR_FIELD,
>  			  (&hdr->type) - skb_network_header(skb));
>  	return -1;
> +
> +disabled:
> +	kfree_skb_reason(skb, SKB_DROP_REASON_IPV6DISABLED);
> +	return -1;
>  }
>  
>  static const struct inet6_protocol rthdr_protocol = {
> -- 
> 2.43.0
> 
