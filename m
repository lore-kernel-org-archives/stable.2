Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8AC3CE481
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 05:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781586809; cv=none; b=CzkSaCTkeBQ0BiGBbyqc39BpbhcBiYxGvnrhPmRHIX8UJrTQLr1VJf4iOy9u5DSbO3tFOqmtIGp9qwuzPMSsI5Pf6StbcczyPlxXkzemkDx/TjDjoyHYu5T66NDULWfrO11naBkrTTPhjvFOT08h5nWHECSSlJglRujUo+pL7Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781586809; c=relaxed/simple;
	bh=zN+JkfaBed6t14OOxabTV2baYgaRMMqHq5HxTke4brY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UTb6dIv5le/EX+46tndKf9YXw5WgK1Kl5j+EHvi+CW0kXSJ8HWLwL+55Gq1viHGIpueOAOrCVdAj2+exRmn5qb3YdJUGgGkfnA90f4ISOC82hx4wsjK3X2X5pb153SzCm0YEBwHvkR6ERFDXA1hfo7XKfd3Etf0fW6H8vkgaOuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x/wPNSxe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x/wPNSxe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0874B1F00A3A;
	Tue, 16 Jun 2026 05:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781586807;
	bh=+DZga0xTEhJ3ren6f5+cf9c00RoQor9hdjEuv50XnTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=x/wPNSxeKjbIKaWIISn0triVl7/J/BqXcJDWf25bwL6Up2sXw5fYTpKS7euWXTGgn
	 4/AVWeMjjd9jdaFBZY+Y3R5MIOPpjkuR4JBdZsEhg1D/nrxtjZpKoq2jbWlHA94J0g
	 mkQpze6xh9Fd+ykR7+VI84urYsYL7OPdrOQsWi7w=
Date: Tue, 16 Jun 2026 10:42:23 +0530
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kevin Berry <kpberry@google.com>
Cc: xmei5@asu.edu, bestswngs@gmail.com, chenglongtang@google.com,
	joneslee@google.com, pabeni@redhat.com, rnj@google.com,
	stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] net: bonding: fix use-after-free in bond_xmit_broadcast()
Message-ID: <2026061617-flyable-civic-a986@gregkh>
References: <CAPpSM+TbMOPL93CkWtrYjYW+T+Q+iWuo+ZhfutYNFOuOCBU5fQ@mail.gmail.com>
 <20260506202842.1788682-1-kpberry@google.com>
 <20260506202842.1788682-2-kpberry@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506202842.1788682-2-kpberry@google.com>

On Wed, May 06, 2026 at 08:28:42PM +0000, Kevin Berry wrote:
> From: Xiang Mei <xmei5@asu.edu>
> 
> commit 2884bf72fb8f03409e423397319205de48adca16 upstream.
> 
> bond_xmit_broadcast() reuses the original skb for the last slave
> (determined by bond_is_last_slave()) and clones it for others.
> Concurrent slave enslave/release can mutate the slave list during
> RCU-protected iteration, changing which slave is "last" mid-loop.
> This causes the original skb to be double-consumed (double-freed).
> 
> Replace the racy bond_is_last_slave() check with a simple index
> comparison (i + 1 == slaves_count) against the pre-snapshot slave
> count taken via READ_ONCE() before the loop.  This preserves the
> zero-copy optimization for the last slave while making the "last"
> determination stable against concurrent list mutations.
> 
> The UAF can trigger the following crash:
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in skb_clone
> Read of size 8 at addr ffff888100ef8d40 by task exploit/147
> 
> CPU: 1 UID: 0 PID: 147 Comm: exploit Not tainted 7.0.0-rc3+ #4 PREEMPTLAZY
> Call Trace:
>  <TASK>
>  dump_stack_lvl (lib/dump_stack.c:123)
>  print_report (mm/kasan/report.c:379 mm/kasan/report.c:482)
>  kasan_report (mm/kasan/report.c:597)
>  skb_clone (include/linux/skbuff.h:1724 include/linux/skbuff.h:1792 include/linux/skbuff.h:3396 net/core/skbuff.c:2108)
>  bond_xmit_broadcast (drivers/net/bonding/bond_main.c:5334)
>  bond_start_xmit (drivers/net/bonding/bond_main.c:5567 drivers/net/bonding/bond_main.c:5593)
>  dev_hard_start_xmit (include/linux/netdevice.h:5325 include/linux/netdevice.h:5334 net/core/dev.c:3871 net/core/dev.c:3887)
>  __dev_queue_xmit (include/linux/netdevice.h:3601 net/core/dev.c:4838)
>  ip6_finish_output2 (include/net/neighbour.h:540 include/net/neighbour.h:554 net/ipv6/ip6_output.c:136)
>  ip6_finish_output (net/ipv6/ip6_output.c:208 net/ipv6/ip6_output.c:219)
>  ip6_output (net/ipv6/ip6_output.c:250)
>  ip6_send_skb (net/ipv6/ip6_output.c:1985)
>  udp_v6_send_skb (net/ipv6/udp.c:1442)
>  udpv6_sendmsg (net/ipv6/udp.c:1733)
>  __sys_sendto (net/socket.c:730 net/socket.c:742 net/socket.c:2206)
>  __x64_sys_sendto (net/socket.c:2209)
>  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
>  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
>  </TASK>
> 
> Allocated by task 147:
> 
> Freed by task 147:
> 
> The buggy address belongs to the object at ffff888100ef8c80
>  which belongs to the cache skbuff_head_cache of size 224
> The buggy address is located 192 bytes inside of
>  freed 224-byte region [ffff888100ef8c80, ffff888100ef8d60)
> 
> Memory state around the buggy address:
>  ffff888100ef8c00: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff888100ef8c80: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >ffff888100ef8d00: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>                                                     ^
>  ffff888100ef8d80: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
>  ffff888100ef8e00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
> 
> Fixes: 4e5bd03ae346 ("net: bonding: fix bond_xmit_broadcast return value error bug")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> Link: https://patch.msgid.link/20260326075553.3960562-1-xmei5@asu.edu
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> Signed-off-by: Kevin Berry <kpberry@google.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/net/bonding/bond_main.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 114ebaa284da..6484ba1ab14c 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -5280,18 +5280,22 @@ static netdev_tx_t bond_xmit_broadcast(struct sk_buff *skb,
>  				       struct net_device *bond_dev)
>  {
>  	struct bonding *bond = netdev_priv(bond_dev);
> -	struct slave *slave = NULL;
> -	struct list_head *iter;
> +	struct bond_up_slave *slaves;
>  	bool xmit_suc = false;
>  	bool skb_used = false;
> +	int slaves_count, i;
>  
> -	bond_for_each_slave_rcu(bond, slave, iter) {
> +	slaves = rcu_dereference(bond->all_slaves);
> +
> +	slaves_count = slaves ? READ_ONCE(slaves->count) : 0;
> +	for (i = 0; i < slaves_count; i++) {
> +		struct slave *slave = slaves->arr[i];
>  		struct sk_buff *skb2;
>  
>  		if (!(bond_slave_is_up(slave) && slave->link == BOND_LINK_UP))
>  			continue;
>  
> -		if (bond_is_last_slave(bond, slave)) {
> +		if (i + 1 == slaves_count) {
>  			skb2 = skb;
>  			skb_used = true;
>  		} else {
> 
> base-commit: 258cf62a6dfde3c6a39d120a56a298f2ed6a8901
> -- 
> 2.54.0.563.g4f69b47b94-goog
> 
> 

Does not apply at all :(
