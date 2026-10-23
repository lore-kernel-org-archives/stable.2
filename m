Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.93
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792724831;
	b=2LeMJyidZdCjW/iro6f3FXHVfL+1fTRtd+HPaEgQ2vpqbN/Sgsv/lq502G2VXMzfmOkA
	 aPrp2Ri5DqTB2FpcRwLWQt6QTCspg8z0ly3Mnf19Fk/2Zo4zbYHSHBDuTHJ/uxV1dJrtv
	 QfeEM6ZRYQnoqYFO5AETe3ZJJGMixfG1kYhS114qV3c2rSSnedsDGBDqypBlll4faSJ61
	 vIEL78868NNH1ZRlHvySV6bV4FD6eVCW7pX1eJvM+MVETxcYv+NKjmOLRgVmdMFetBi/U
	 Jyk9/FqHynfd1h7s+Ba2ifX9AuaZpbnNxC8rPQSF/EolVkJoIsIzGfaV4vwQe8mq71Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792724831;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=OnaK5kbThapjGVWcJhLkCw2nwI2aKy4NlMeDCe0tH1E=;
	b=bYprbq7X0gDyd/pH3mvd2RkwAhug/0UxirjXPN6blKHG9oco0dsq9cB7f0lYdnOR/XLV
	 lRH0DMX7wQdgXXycwjLYEAfJnp8VciC5esg9vVwWPGNwlxeUf+N3fotUNyVTXL9RnQuQI
	 Wo3Sx7J481iUnKWkeAgwbgooLGFJ9Wf+f/zjXtLrNiciJJLzPCZBQA25pOMM38LNdgskt
	 vIJCrx3xwbhH7YS7DkoiJsRkDqGvsK9cnTFQziDI51bMZd+5LygWEXqtScHbtxji7NDpU
	 p/FHMXjeFec4Hk+RDsqL6nA8RqVx+W31mwhz8RZHI3vlrq14M0gF68Bag6vhVMfPUJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MnBQGBjR;
	arc=none smtp.remote-ip=91.218.175.93
Received: from mta0.migadu.com (out-93.mta0.migadu.com [91.218.175.93])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296C3606A319
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 03:07:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 296C3606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MnBQGBjR
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=pd2I5oM/BwmyoWBqQfZA7OoTc66uRFuXEF4QDOOUqVY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792724828; v=1; x=1793329628;
 b=MnBQGBjRguopHlbIL3KeN0Sjj/xWS8xEyjjGls3YBwPzGa0X0pfe26WKP4LuJ2ncogD3oFvY
 kXavbAnz2BWJSs1IwJn5IXUuD/MQIlmH3HRlMR8hfg9P9c+X/fGo07KooFLUMud6qLTD3eJT4KV
 j3EJO8Aqn+DP9a8NYn+p3GVg=
X-Envelope-To: stable@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 98355a6fe4b1d75d;
	Fri, 23 Oct 2026 03:07:07 +0000
X-Mizu-Trace-ID: 98355a6fe4b1d75d
X-Migadu-Flow: FLOW_OUT
Date: Fri, 23 Oct 2026 11:06:57 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Xia Yan <yanxia@cmss.chinamobile.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, yana06070@163.com
Subject: Re: [PATCH net] macvlan: fix passthru promiscuity accounting while
 down
Message-ID: <atrKdb1atGzCYka4@fedora>
References: <20261022090809.12019-1-yanxia@cmss.chinamobile.com>
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
In-Reply-To: <20261022090809.12019-1-yanxia@cmss.chinamobile.com>

Hi Yan Xia,
On Thu, Oct 22, 2026 at 05:08:09PM +0800, Xia Yan wrote:
> macvlan_changelink() adjusts the lower device's promiscuity count when
> NOPROMISC changes, even if the passthru macvlan is down. The reference
> is acquired in macvlan_open() and released in macvlan_stop(), so a down
> interface has no reference to change.
> 
> Clearing NOPROMISC while down leaves an extra reference after the next
> open/stop cycle. Setting it while down can remove a reference held by
> another user of the lower device.
> 
> Guard the count adjustment with netif_running(dev). Keep storing the
> requested flags while down so the next open uses the new setting.
> 
> Comparing changelink with open/stop exposed the unmatched count changes;
> the same issue was also described in earlier macvlan reviews. A netlink
> test on UML reproduced both DOWN cases before the fix and verified the
> expected counts afterwards. Repeated flag updates, two open/stop cycles,
> deletion and bidirectional small-frame delivery were also checked.
> 
> Full x86_64 builds completed with WERROR disabled for allmodconfig, and
> WERROR and KASAN disabled for allyesconfig, including the resulting
> dependency changes. Neither comparison showed new diagnostics.
> 
> Fixes: df8ef8f3aaa6 ("macvlan: add FDB bridge ops and macvlan flags")
> Link: https://lore.kernel.org/netdev/179170088566.434549.4699134797461783473@kernel.org/
> Link: https://lore.kernel.org/netdev/20261016003009.2692872-1-kuba@kernel.org/
> Cc: stable@vger.kernel.org
> Signed-off-by: Xia Yan <yanxia@cmss.chinamobile.com>
> ---
>  drivers/net/macvlan.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
> index afad90b..a48c9e6 100644
> --- a/drivers/net/macvlan.c
> +++ b/drivers/net/macvlan.c
> @@ -1664,7 +1664,8 @@ static int macvlan_changelink(struct net_device *dev,
>  	if (data && data[IFLA_MACVLAN_FLAGS]) {
>  		__u16 flags = nla_get_u16(data[IFLA_MACVLAN_FLAGS]);
>  		bool promisc = (flags ^ vlan->flags) & MACVLAN_FLAG_NOPROMISC;
> -		if (macvlan_passthru(vlan->port) && promisc) {
> +		if (macvlan_passthru(vlan->port) && promisc &&
> +		    netif_running(dev)) {
>  			int err;
>  
>  			if (flags & MACVLAN_FLAG_NOPROMISC)
> 
> 

If we discard the MACVLAN_FLAG_NOPROMISC change, should we remove the bit
before calling WRITE_ONCE(vlan->flags, flags)?

Or set extack and tell user that setting this flag with link down is forbidden.

Thanks
Hangbin
