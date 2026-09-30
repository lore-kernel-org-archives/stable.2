Received: from mta0.migadu.com (out-247.mta0.migadu.com [91.218.175.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F380335DA63
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 06:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790748296; cv=none; b=f58DuZzr1Fa4WTE2qxzGCon034VU3uAu73mn0KCYDusDhW5o8Bse1h+bcWrsEuUIXhDtVkOy5/tDHsObKKmB9mb/5PQmKr5PrbEQbQoNCeTxTl99b84vpE1ffX840yiDfNIhzcnFYZFEo8AAploKi71Mr5laCt6hpB6r+0psyfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790748296; c=relaxed/simple;
	bh=HeK8ZDCCOt1Xu9LSP0fGs8eVYgK1CGaMuUWO4rHDwzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pkKq50N1XNOT5z2AkG/XGhulFc3n9MOXmPcT3yWsx3TGI1gA+DSfQJ3JXxYN5slidfPqgarOrYYsrJJ4Gef5Dct1nijtRh1V7sEzeDPH5tvtcQb6DSQtRtop0algUOGQQoQ303cFzlgthZjTC+GMxZUP3ProDZZTlVYPUisIm0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iCLeFu5N; arc=none smtp.client-ip=91.218.175.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iCLeFu5N"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=HeK8ZDCCOt1Xu9LSP0fGs8eVYgK1CGaMuUWO4rHDwzI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790748291; v=1; x=1791353091;
 b=iCLeFu5N2qgauBEAYUt/w+FTwp6p1pHIa4swSrTtGwVSzr7aHxiP1cDgvt9TXThdajxBnNWQ
 WVtxtFZtp8AcS5Up7o4Vo+F/C0t33VaVrSsdbZ/FqlbhyS0Isxf+AUYMB7YR+oaoxAoiYl8vaHD
 uT/OzzybloZHu6ajKDqeee9M=
X-Envelope-To: stable@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id e486eb0ba4f1d327;
	Wed, 30 Sep 2026 06:04:51 +0000
X-Mizu-Trace-ID: e486eb0ba4f1d327
X-Migadu-Flow: FLOW_OUT
Date: Wed, 30 Sep 2026 14:04:35 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Weiming Shi <bestswngs@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>, co+2cf741c3005abc20@bugs.sh,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: team: stop reusing skb after queue override
Message-ID: <arymc6JbQN5GDBaF@fedora>
References: <20260926090039.1714460-1-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260926090039.1714460-1-bestswngs@gmail.com>

Hi Weiming,
On Sat, Sep 26, 2026 at 05:00:39PM +0800, Weiming Shi wrote:
> dev_queue_xmit() consumes the skb regardless of its return value, but
> team_queue_override_transmit() treats a non-zero result as if no handoff
> occurred.  An AF_PACKET sendto() can therefore make team_xmit() pass a
> freed skb to another override port or the mode fallback when the port qdisc
> drops the packet.
> 
> Report the handoff decision separately from transmit success and stop after
> the first override port.  This preserves the existing success and drop
> accounting.
> 
>   BUG: KASAN: slab-use-after-free in sk_skb_reason_drop
>   Read of size 4 at addr ffff88800d5e979c by task poc/131
>   Call Trace:
>   ...
>   sk_skb_reason_drop (net/core/skbuff.c:1220 net/core/skbuff.c:1249)
>   team_dummy_transmit (drivers/net/team/team_core.c:502)
>   team_xmit (drivers/net/team/team_core.c:1869)
>   __dev_direct_xmit (net/core/dev.c:4990)
>   packet_xmit (net/packet/af_packet.c:286)
>   packet_sendmsg (net/packet/af_packet.c:3140,3172)
>   __sys_sendto (net/socket.c:800,815,2281)
>   __x64_sys_sendto (net/socket.c:2288,2284)
>   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
>   Freed by task 131:
>   ...
>   __tcf_kfree_skb_list (net/sched/sch_generic.c:59)
>   __dev_queue_xmit (net/core/dev.c:4353,4884)
>   team_xmit (drivers/net/team/team_core.c:832,1867)
>   __dev_direct_xmit (net/core/dev.c:4990)
>   packet_xmit (net/packet/af_packet.c:286)
>   packet_sendmsg (net/packet/af_packet.c:3140,3172)
>   __sys_sendto (net/socket.c:800,815,2281)
>   __x64_sys_sendto (net/socket.c:2288,2284)
>   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
>   Kernel panic - not syncing: KASAN: panic_on_warn set ...
> 
> Fixes: 8ff5105a2b9d ("team: add support for queue override by setting queue_id for port")
> Reported-by: <co+2cf741c3005abc20@bugs.sh>
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
>  drivers/net/team/team_core.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
> index beffbe450612..59dd94271ff1 100644
> --- a/drivers/net/team/team_core.c
> +++ b/drivers/net/team/team_core.c
> @@ -820,7 +820,8 @@ static struct list_head *__team_get_qom_list(struct team *team, u16 queue_id)
>  /*
>   * note: already called with rcu_read_lock
>   */
> -static bool team_queue_override_transmit(struct team *team, struct sk_buff *skb)
> +static bool team_queue_override_transmit(struct team *team, struct sk_buff *skb,
> +					 bool *tx_success)
>  {
>  	struct list_head *qom_list;
>  	struct team_port *port;
> @@ -829,8 +830,8 @@ static bool team_queue_override_transmit(struct team *team, struct sk_buff *skb)
>  		return false;
>  	qom_list = __team_get_qom_list(team, skb->queue_mapping);
>  	list_for_each_entry_rcu(port, qom_list, qom_list) {
> -		if (!team_dev_queue_xmit(team, port, skb))
> -			return true;
> +		*tx_success = !team_dev_queue_xmit(team, port, skb);
> +		return true;
>  	}


Since dev_queue_xmit() consumes the skb and we should not loop for all
the ports. Is there still a need to using list_for_each_entry_rcu()?

Thanks
Hangbin

>  	return false;
>  }
> @@ -1864,8 +1865,7 @@ static netdev_tx_t team_xmit(struct sk_buff *skb, struct net_device *dev)
>  	bool tx_success;
>  	unsigned int len = skb->len;
>  
> -	tx_success = team_queue_override_transmit(team, skb);
> -	if (!tx_success)
> +	if (!team_queue_override_transmit(team, skb, &tx_success))
>  		tx_success = READ_ONCE(team->ops.transmit)(team, skb);
>  	if (tx_success) {
>  		struct team_pcpu_stats *pcpu_stats;
> -- 
> 2.55.0
> 
