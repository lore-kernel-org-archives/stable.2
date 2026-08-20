Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7C943E08B;
	Thu, 20 Aug 2026 12:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787228920; cv=none; b=ATTwzALHcUqcnGChbBxhVR75eVh6rxRrDL3l8V7q0ucNTgngeTkZpUUPoHO7UGF/j4YrDCe5eJV6K4u9afoV70ZlPxsnxCcuBOoO9qweqdPm8fMDl6zCHJSRxLecGFBIvxKPaa8iubxHKRIWbO1jNB+nyUP2qHvQDzuqfUA7SZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787228920; c=relaxed/simple;
	bh=EsNGQvBFEnfyFnXOauxu5pB6Y9uqtEMBkuR+5miIKX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEymM4Mr1+/l5D5eLYNIoAvUTP3nBXZ0Q2v9E+bbntJCq7feXG1tfPhM321OjVTybYU3zglUUxfGp6OdrOJSUH7ZNXteKudC/FpvZwZ4ocTfgfllleexQsCDC4BhBuHHb7Y37FCo5o4XAmx8WvFYnjsDF3Y7CBdPN5c0Ji+KA28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djv4fkrT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djv4fkrT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 079AA1F000E9;
	Thu, 20 Aug 2026 12:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787228918;
	bh=oMZGU5GSj8gt2gOqW9FR2cIV6MT0EWoLQzwKNUsG8T8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=djv4fkrTFnFvKVin20+vswjV1iOOp4Ek9CEV4BuXTysUXlhQ42lNv9mY2bTqILHYL
	 dnzPc/t1e5GOsxfP94InMah7Jj1W5m12LeO8YB8nOPo6SxalaVdLQ1MzOMNRciDcfB
	 77m9E7v4dhjrplJp6hB8s65Cld8yqUU+cWfXCkTeVj8ZGJZovxuNjcCyZSvMzrQ3OB
	 /ON3lOpzc7VrVKyNpZjSv39JAkuQiwi8i6BTlyexXCpvAeBoZNo28VBkHzff3M0u4r
	 f4fnxdENs874r4xdB8i37rkDbg1l8KJUoF7iJhoKcDB3uwnx89i1acqrsdR7LDo6Fk
	 kiQuuFuQWW7Tw==
Date: Thu, 20 Aug 2026 13:28:33 +0100
From: Simon Horman <horms@kernel.org>
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, idosch@nvidia.com,
	alex.aring@gmail.com, justin.iurman@gmail.com, bestswngs@gmail.com,
	stefano.salsano@uniroma2.it, xmei5@asu.edu, stable@vger.kernel.org
Subject: Re: [PATCH net v3] ipv6: rpl: fix NULL dereference of idev in
 ipv6_rpl_srh_rcv()
Message-ID: <20260820122833.GY265046@horms.kernel.org>
References: <20260817132644.2223-1-andrea.mayer@uniroma2.it>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817132644.2223-1-andrea.mayer@uniroma2.it>

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

Reviewed-by: Simon Horman <horms@kernel.org>

