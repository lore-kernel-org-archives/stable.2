Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F123D9DC0;
	Tue,  1 Sep 2026 03:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788232103; cv=none; b=E+sybSdxyyxa2GVXcRNdg6yDYINdWz35+163Ug9ZggRovQysOzfhehC8zVH2XitdMxBzuD3YH0Gi42kPakjVXkv6QoLzneNQodBWC5sBeIqaAA97w3qyYghJh9VbsnvNeriWNckeG0B2bCjnZjGtrgRKNRBwKZbVpXDAOLd8NtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788232103; c=relaxed/simple;
	bh=wTAj7j+kfNNe9TFWu03zyquPjDfJPBnNKzuGVDeLdvs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nKt++G1OMs5mnsHs9AGuYBn+fO3Y9FLaa5ZaZAMRDS5LXMqUTb6MLRuqfyH97tByDyHNlDNLnmkFAb3DttjPlONRH1kzEYVOISrov0VfHwV2tcoTqxxl5uBwvdBg7cMI9A7rKx8ghOxuYWvNQ+/dyVpNSEMFYxY32l0Bcbqolus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jadh3hiV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jadh3hiV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C191F000E9;
	Tue,  1 Sep 2026 03:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788232102;
	bh=mHanEbP43xNR3nBIqo5iaqZoua+wJSDpVuuuXC39M64=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jadh3hiVAG6cNlr3l1JQOYzB13QBnzc0O7TKsT0mFRXthaAX7WKv6k3nAaQL8jVhU
	 zyJNbkSYJGusEkiDw+OUNTlvcBYfZL+MCUPAvrBjCwYfL+scy28wGqcBDF/FOvHais
	 tBz/9WcTxj9LbgJP2yPvAUCKOusw8D27Ba+KgSJlY58Uvq2n2xdmWi76y0pllGTLLu
	 xnFjj+lVTy0aKq0TUlvBZ8xjoUNxcaOnDsJKQPnWcyJGFKslr9YUNMHwC2tXHwT14s
	 QpWLOOLEXEZRLGNhaRXj2BVkWHHxuAKcDYIN5sCBCcWTqPF5HEkr/is/8mrqu50Uql
	 RxVtGRlBti4ag==
Date: Mon, 31 Aug 2026 20:08:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowangio@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, stable@vger.kernel.org,
 vega@nebusec.ai, Victor Nogueira <victor@mojatatu.com>
Subject: Re: [PATCH net 1/2] net: cap tx_queue_len at S16_MAX to prevent
 oversized ring allocations
Message-ID: <20260831200820.523ac597@kernel.org>
In-Reply-To: <20260828121902.66837-1-jhs@mojatatu.com>
References: <20260828121902.66837-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Aug 2026 08:19:01 -0400 Jamal Hadi Salim wrote:
> Several subsystems allocate ring buffers sized by dev->tx_queue_len
> with no upper bound. An unprivileged user (via unshare -Urn) can set a
> huge tx_queue_len and create many devices/queues to exhaust global
> memory, causing a system-wide OOM:
> 
> - pfifo_fast: pfifo_fast_init() and pfifo_fast_change_tx_queue_len()
>   allocate 3 skb_array rings of tx_queue_len entries each.
> - tun: tun_queue_resize() and the queue-attach path resize ptr_rings
>   to tx_queue_len on the NETDEV_CHANGE_TX_QUEUE_LEN notifier.
> - tap (macvtap/ipvtap): tap_queue_resize() and tap_init() resize/init
>   ptr_rings to tx_queue_len on the same notifier.
> 
> netif_change_tx_queue_len() is the single entry point for IFLA_TXQLEN,
> sysfs, and the SIOCSIFTXQLEN ioctl. Cap new_len at S16_MAX (32767)
> there so the oversized value is rejected at set time. This will take 
> effect whether the device is up or down before dev->tx_queue_len is
> written or any notifier fires or any ring is allocated. So a good
> choke spot.
> 
> S16_MAX is the virtio virtqueue size limit: the virtio specification
> stores the queue size as a u16 with a maximum of 32768, so 32767 is
> the largest tx_queue_len any in-tree driver can meaningfully use.
> Values above that only serve to inflate ring allocations.
> 
> Conditions to recreate the bug:
> - CONFIG_NET_SCHED=y, CONFIG_VETH=y, CONFIG_USER_NS=y, CONFIG_NET_NS=y.
> - Unprivileged user in a fresh user+net namespace (unshare -Urn).
> - pfifo_fast: create veth pairs, set tx_queue_len to 500000, attach
>   mq+pfifo_fast. ~28 iterations OOMs a 2GB guest.
> - tun: create 50 tun devices with IFF_MULTI_QUEUE, set tx_queue_len to
>   500000, open 8 queues each. ~1.6GB of ptr_ring allocations OOMs a
>   512MB guest.
> - tap: same as tun with IFF_TAP. ~960MB OOMs a 512MB guest.
> - On the fixed kernel the oversized tx_queue_len is rejected with
>   -ERANGE at set time.
> 
> Fixes: 6a643ddb5624 ("net: introduce helper dev_change_tx_queue_len()")
> Reported-by: vega@nebusec.ai
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
>  net/core/dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 38336858c168..1d3fc0a268a5 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -9982,7 +9982,7 @@ int netif_change_tx_queue_len(struct net_device *dev, unsigned long new_len)
>  	unsigned int orig_len = dev->tx_queue_len;
>  	int res;
>  
> -	if (new_len != (unsigned int)new_len)
> +	if (new_len > S16_MAX)
>  		return -ERANGE;
>  
>  	if (new_len != orig_len) {

clashiko points out that we need to also cover the newlink path:

net/core/rtnetlink.c:rtnl_create_link() {
	...
	if (tb[IFLA_TXQLEN])
		dev->tx_queue_len = nla_get_u32(tb[IFLA_TXQLEN]);
	...
