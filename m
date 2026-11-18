Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794966670;
	b=qwZ7QEf00TnN+1oMFlWYpm0+NAh+kt0MCvAJxspro0R/rb5V/Su74C59k42ljigWcxwN
	 rLKd7qqLhduCf7cmVJXoY2npYirhuGmIEBxzHg3DrccJ1yz+l3cXmou+YUaI4lo/ydouR
	 Mtl3oGSrjrgA0y9mitLF3rcj4HshlK6NwHFIc7vZHPP36RnBlw+fm90t6s5GnoUq99Y4V
	 Jps4HorafBFo7T8XcvzIyKfy/2UKFYWaklk5cSAAMb2jGyYbj91WAhkwuDuEks6nD46T6
	 bAcFiA36wM5cThOMMZyWXvWU9NkH8eAG3XDv4QZL/UCJGVXaQrm7oeekO2S6Y9XJOHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794966670;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=xui+L1Kl8YV8BY/zkHbqr+YzjXk4VH0pkRVVyFr69gk=;
	b=sCe7H7/jwrhcwNcl2J7YyVLyAiwN1tnTqpDhH3y6UrkKH0JZ/nTMUo1VEjQOb1DBufgw
	 KPjYmgFB+CNTnFxsq2hRVrgCynDWyibLEWF7yHfogDW3VB0Ufy+/ZTFuLD01cp3LwLq13
	 5OrZ2SE0DdBF4Q9dkpkzlnfeLeiiDSaD+cGRxzDRUTiTMN3UsmTrwa153MDTT1CNZEZxD
	 ChyT8cpmlxkgKMbFgkU2Aepv3Hu55v0/hjCNUMzUFP3Jx4jXMSzK4l1vBujvuK4tsY6eE
	 SjBGCJ+17/day2PzD/ktLe/Vbea+8HGpd/R+Boq2rAQo4+CxDQGM42aHkSrG+WLTifw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Ln3yavLO;
	arc=none smtp.remote-ip=91.218.175.131
Received: from mta0.migadu.com (out-131.mta0.migadu.com [91.218.175.131])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17162606A33F
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 01:51:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17162606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Ln3yavLO
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=rm+AxKqTEOXCpk9Th0qeoefjY+08yAH5hlAEglN9Rgk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794966667; v=1; x=1795571467;
 b=Ln3yavLOPytuKHfZPe5QYObzrdgPsQkepZJE4WVOafWZy3hLA3nYTZc3C/7QztuWz6kuOLNl
 o/OteqBnBpLONtPkSKfIWAr5wKLl04XXL4upWSW0YFmqQQkiY2GoW/PFGrkXw8z5Hb9jK6uAKGd
 EPYm5u2j9OaxUhESxsoQscF8=
X-Envelope-To: stable@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id f9f5a1b8f39bf639;
	Wed, 18 Nov 2026 01:51:06 +0000
X-Mizu-Trace-ID: f9f5a1b8f39bf639
X-Migadu-Flow: FLOW_OUT
Date: Wed, 18 Nov 2026 09:50:55 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Hyunjung Ko <hj351016@gmail.com>
Cc: James Chapman <jchapman@katalix.com>, Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Chris Elston <celston@katalix.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] l2tp: reject short IPv6 address attributes
Message-ID: <av0EfxJlYXo2XbU-@fedora>
References: <20261117092157.85513-1-hj351016@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117092157.85513-1-hj351016@gmail.com>

On Tue, Nov 17, 2026 at 06:21:57PM +0900, Hyunjung Ko wrote:
> L2TP_ATTR_IP6_SADDR and L2TP_ATTR_IP6_DADDR are NLA_BINARY with .len set
> to sizeof(struct in6_addr), which only bounds the attribute from above.
> l2tp_tunnel_sock_create() then copies a full in6_addr out of each one,
> so a shorter attribute makes it read past the payload. If the attribute
> is the last one in the message this picks up whatever lies behind the
> skb tail (stale heap data unless init_on_alloc is set), which ends up
> in the socket address and can be read back with L2TP_CMD_TUNNEL_GET.
> 
> The commands are GENL_UNS_ADMIN_PERM, so this is reachable from a user
> namespace.
> 
> Require the exact length.
> 
> Fixes: f9bac8df908d ("l2tp: netlink api for l2tpv3 ipv6 unmanaged tunnels")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
> ---
>  net/l2tp/l2tp_netlink.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/net/l2tp/l2tp_netlink.c b/net/l2tp/l2tp_netlink.c
> index 89ef04c78787..a07009d4cb00 100644
> --- a/net/l2tp/l2tp_netlink.c
> +++ b/net/l2tp/l2tp_netlink.c
> @@ -910,14 +910,8 @@ static const struct nla_policy l2tp_nl_policy[L2TP_ATTR_MAX + 1] = {
>  	[L2TP_ATTR_MTU]			= { .type = NLA_U16, },
>  	[L2TP_ATTR_MRU]			= { .type = NLA_U16, },
>  	[L2TP_ATTR_STATS]		= { .type = NLA_NESTED, },
> -	[L2TP_ATTR_IP6_SADDR] = {
> -		.type = NLA_BINARY,
> -		.len = sizeof(struct in6_addr),
> -	},
> -	[L2TP_ATTR_IP6_DADDR] = {
> -		.type = NLA_BINARY,
> -		.len = sizeof(struct in6_addr),
> -	},
> +	[L2TP_ATTR_IP6_SADDR] = NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
> +	[L2TP_ATTR_IP6_DADDR] = NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
>  	[L2TP_ATTR_IFNAME] = {
>  		.type = NLA_NUL_STRING,
>  		.len = IFNAMSIZ - 1,
> -- 
> 2.43.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
