Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3864377ABA
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 16:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784824964; cv=none; b=ZP6WKcF86EM2OCwz3hDERu5yLNBAElve2Iy+zqkgAb/eSGrlRVJ7RsyLani3u4apSPAUTZrHQPlGagqrSP+T3G2zvBLcSWByXM4X/rI1Ph95SVnMrXW38ZyXKg8s1aGFcvCU1ggLSTBadFWT2iNkrgFJuf2KAZ9GC0bOlTNNaVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784824964; c=relaxed/simple;
	bh=aTP/yMnIC2L1ejzj4boaIHt+P1zqJ4J2xSG/yAbYhIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rII0LIzYyLIaDuYno20gqctLcWH3GawhlNiGSIa94vP1ZG33gV1hs91rQae2NVSTFI3P8Vuv60O5BzJ82DB0pv868gJmPwVYin7K99AsNCT2LmGpdG1MVmy4Yu9NW3aOgb460YyKltvjuqwi2Qv3nLT3uAJqMsugmiPxvEImQu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sHgz2JFu; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sHgz2JFu"
Message-ID: <615463b2-d374-414e-baef-8c0f99823ac8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784824960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/BshofQY1H8MB8+nNff+kHnkMHTbCIWQPzgaoD3vRLY=;
	b=sHgz2JFutgp5Y6O0whEVzqh31TPs1kQm4bbPYqlrccM0H2333jXI9KqwZNIPXWOL/VJ/Fc
	oQ9IJ8RxmeEUp3loTA/2f1M2bYRZ6yos1JRtAHUAHA0MaLoxIHSkvaVV0aqKRttYHrgiNf
	RyMWLUUr9bYBhTgxiBW2Q3ITZZ/iSL8=
Date: Thu, 23 Jul 2026 17:42:29 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net 4/5] vxlan: use pskb_network_may_pull() in
 route_shortcircuit()
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, stable@vger.kernel.org
References: <20260723144249.759100-1-edumazet@google.com>
 <20260723144249.759100-5-edumazet@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260723144249.759100-5-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 23/07/2026 15:42, Eric Dumazet wrote:
> route_shortcircuit() currently calls pskb_may_pull(skb, sizeof(struct iphdr))
> (or ipv6hdr), which checks if bytes are available starting from skb->data.
> 
> However, in vxlan_xmit(), skb->data points to the MAC header, so
> skb_network_offset(skb) is ETH_HLEN (14 bytes). Using pskb_may_pull(skb, 20)
> only checks 20 bytes from skb->data (which is 14 bytes MAC header + 6 bytes of
> IP header), leaving the rest of the IP header potentially un-pulled in non-linear
> frags. Subsequent dereferences of ip_hdr(skb)->daddr can read beyond the pulled
> linear buffer length.
> 
> Fix this by using pskb_network_may_pull(), which adds skb_network_offset(skb) to
> the length check to ensure the full network header is present in the linear buffer.
> 
> Fixes: e4f67addf158 ("add DOVE extensions for VXLAN")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>   drivers/net/vxlan/vxlan_core.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index 10dd19eec09e266197ee51330a652f4e76c9643a..9ccbebda860480f8378918ff360deee1c46f3f7d 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -2111,7 +2111,7 @@ static bool route_shortcircuit(struct net_device *dev, struct sk_buff *skb)
>   	{
>   		struct iphdr *pip;
>   
> -		if (!pskb_may_pull(skb, sizeof(struct iphdr)))
> +		if (!pskb_network_may_pull(skb, sizeof(struct iphdr)))
>   			return false;
>   		pip = ip_hdr(skb);
>   		n = neigh_lookup(&arp_tbl, &pip->daddr, dev);
> @@ -2137,7 +2137,7 @@ static bool route_shortcircuit(struct net_device *dev, struct sk_buff *skb)
>   		 */
>   		if (!ipv6_mod_enabled())
>   			return false;
> -		if (!pskb_may_pull(skb, sizeof(struct ipv6hdr)))
> +		if (!pskb_network_may_pull(skb, sizeof(struct ipv6hdr)))
>   			return false;
>   		pip6 = ipv6_hdr(skb);
>   		n = neigh_lookup(&nd_tbl, &pip6->daddr, dev);

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
