Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD1B362154
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 16:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784824677; cv=none; b=E2V+uNOSg1tFMS2VC6yRb73SOk3UL98HunJRUF81mayMkmfJZcmLuTcKwpEB9m3WYf391jHAz4Yqxl/I9TnYToXuNkB0Vr7IRnNCajyqucGUsziwj98yZml5uyCZsk1sDt0Tnek7jPDNfeekrgfLKajJf6wyTuH/4ihEuRAwhfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784824677; c=relaxed/simple;
	bh=W/T2FA1R4NH66U6bC7cndb/uQPgJ9gby8hVfWUCOP/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OAj1yx6KishNWlNNvQA+KSkUkgtjVJyYndtyqvIcNKTUrvZiBAC9Pi2Bsjt5LSrdkMX6FSlBqAf44towKF8s7HExvnWfbQIM/odk+Gebwwo69GgwyKN4RAPLPo5BQiNMm9rx952SmECgf4bG2zLrAP2reqaGPmcHxspy0wgkBZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EivCEZj4; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EivCEZj4"
Message-ID: <71290c27-fcf1-417a-b568-308032ebd062@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784824664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=64lkH0/R8q1P2u1zVQWMzaRUcohCQ/TFRVF5P01HfPI=;
	b=EivCEZj4x3dhdY0Loo3RHRKFxupXqoOD0WndYUP1CbFuJzvIlb89EIIcX0iDpKGDzt7tzd
	xPW1mklx1ShwThFTvazmVWXtWspZ8NuiCJctrPTNepfYuxnlXKEXuR6SNAZKttm4m6OZjD
	PKXof82hWbk6LECbWLbihsd74EB4m6g=
Date: Thu, 23 Jul 2026 17:37:34 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net 1/5] vxlan: re-fetch eth header after
 route_shortcircuit()
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, stable@vger.kernel.org
References: <20260723144249.759100-1-edumazet@google.com>
 <20260723144249.759100-2-edumazet@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260723144249.759100-2-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 23/07/2026 15:42, Eric Dumazet wrote:
> Before route_shortcircuit(), the eth header pointer is cached from eth_hdr(skb).
> 
> Inside route_shortcircuit(), pskb_may_pull() can be called, which may
> reallocate skb->head.
> 
> In this case, returning to vxlan_xmit() leaves the cached eth pointer pointing to
> freed memory, leading to a use-after-free when dereferencing eth->h_dest.
> 
> Fix this by updating eth = eth_hdr(skb) after calling route_shortcircuit().
> 
> Fixes: ae8840825605 ("VXLAN: Allow L2 redirection with L3 switching")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>   drivers/net/vxlan/vxlan_core.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index 67c367cc566233e809b0f70e0d939dd1c1ac0d9f..9060a1259ac283d4db4b7a854ce74203496e9313 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -2796,6 +2796,7 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
>   	    (ntohs(eth->h_proto) == ETH_P_IP ||
>   	     ntohs(eth->h_proto) == ETH_P_IPV6)) {
>   		did_rsc = route_shortcircuit(dev, skb);
> +		eth = eth_hdr(skb);
>   		if (did_rsc)
>   			f = vxlan_find_mac_tx(vxlan, eth->h_dest, vni);
>   	}
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
