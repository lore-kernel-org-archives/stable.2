Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D5235DA47
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 02:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792032557; cv=none; b=FEpMiuGPRn5IHEVQ/HWhNqHWTLxCk/ipootqcORQ7cv0tEw8rCDknIUFy6ifaZHybn5+8sAUg28n3HQuD8A2xfvv2Gi2ex9JQ36sO1kwZKUbqpgjTL3GKuwCiluxIsrfEbKOz3YG5RPgdI3/jPczHHhrZeEYfXCzd5Sh9oh83aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792032557; c=relaxed/simple;
	bh=8V8yPSbMw8apmNIJjJAl4vBZi2BIixdWgWO4jufkzQQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Y030kjc+cPA1MBvKa2o3Xoxfr06SksT8SMBH4V2+CjxcrIYBq8ISpVpK0lBh/Bf/RhYkXdZMovixsQp9O12e1iYh9nwVdwMPeWlsx6pgl0aOd4fA+dH8smQvV/ZkSJkdBN2SDllwbPOCKzTjqcXZzW+FrcJAWNtAi+vWvxoX06s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=glJ5AhqG; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glJ5AhqG"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5e95b036302so1839885e0c.0
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 19:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792032555; x=1792637355; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TnNQqUDr8SKFHy59cY2mWfkC4N5kb7edfWV3cIhUTxs=;
        b=glJ5AhqGh96jVbRrQWgQeClc7pRzE23jGbJRnF4Bwl+ewd1CKnnyh7VCnwGEdFlhXS
         CEK6PyRNRmGEEZ987M7cGLhD30NjpOVHR+6a9i2UCWlzhspbTi3HsCVo75CI6C5reIFB
         QFKLQYbEbeKXkcvHFQAdvgbAuTsdDFWmjt24lQ+LHDxHFvUDR2ITdBK8cmEPU6VlO9SG
         LHD+gWDySBsc+nCQwcOxrpuk0tKKXZMAgU3C6VHstg8aZx4V0kBrHJEWdgizT5+t4tSZ
         J65DA0tG4seShv88H++0UPD0NphG6j1YWfkBplb1VQuJiO271PfYf21a6YMmd0hZ01DQ
         LtHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792032555; x=1792637355;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TnNQqUDr8SKFHy59cY2mWfkC4N5kb7edfWV3cIhUTxs=;
        b=rzzkbXsULmKecF+pmWkZ5IdmdZG0KxVQ0ak1DrDzAtv9Owc59S1MSxksPvIT5UzhGG
         TUu3e9R/4rTJeRSkdTnaGWU3uP6cZ7RhVOSvUgHxXXgK4Dxd0bgRDMR1+GZteeVVYx5s
         hFryXzjRWRGOYbmWnJJ+MCjSDEqkKvZwU6/0Xd8SHpqfIE9OQvba6StQtNVC3O9KQ6uF
         ZS9r/SxRn2uzpmxBRTDopqU84RJyR1ICv8s/z53uWEM9x34IepXfeeXAJD0qNZl656NL
         0DKHMk0vVCKuw2z2kcRcj+bgI8nk6Z9d1i8Rk98WpHRV111pVs+6laf/MI8Iku2VAOm/
         afHA==
X-Forwarded-Encrypted: i=1; AKwUvBwsIl6hixQUZXBAMHdQcANpFC7EkEeMXEzZaZAKefdM7eftMoc/GGjqGIaOd7xpZRDnwMTmLqs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJIqTgySbUZUE9GuklZbkosMjfyCqWEnLr/pW6pdbibsBq/+xJF
	DqFRFdFIK0Iz68LhaEpBnVd74pGhhK/FbvXM0hrb/VuyBtFxFuknDY5n
X-Gm-Gg: AYBFou1kyeNGYowRsWMadGoC7O2dpzuAtlM1FlBC/qgS/ahRLzs6WmABxGLXuFhu91C
	qRiEdMAxeOW4f4zV7aXprt/4twIjugc3hR1X0x5LqOJ30wzUkGZb8HVw2B/WB/2Wfs9xElHHwWe
	vHAgTmGtd711y98eLwqWML/fueBB6dhJZxRgq9yw20flRpNPq/cBCNWgnRk5MVwjAdemt3VesWb
	wILkestemY43NQe3RYsr8Y+ZhYenxaPfJZFPa2j3qECPgHcoXcpWj0ebE67Jxduc7hGqQ95twiy
	3hSKgeBoqszegkW+Oo+T1sdHj+bb/fc7PWDz7BiIEkPmhoOHKusaOkYsalLSJIkfgMZqhFWQux1
	9+U04HuaTOIlUihbZYpnJJMi5FZBU6GLWOR5rfYW1jfExxTXnHZBHiYc9ESMG8uT2N8bp7wSxkd
	PLP5cD/GmQt3GsO/dH+KUIhI+gDdTb8pveOpcLqxQ1Kn0Hc0n4+kxqZ7FVnW+LgDOJqPXsw2wKP
	N3YYGL7019jmxHqzBKO92XctAMqSiSzjI6+FsXSytKbgi/s8Q+L5s6zIoe/YT7SYr2UNIiPukkq
	SgiI0T39S/3euVFQOpCz9vxGBYNlwJJwgOYJOT4=
X-Received: by 2002:a05:6122:d0b:b0:5d3:9cb7:f723 with SMTP id 71dfb90a1353d-5e91f45eeb1mr4583576e0c.5.1792032554895;
        Wed, 14 Oct 2026 19:49:14 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5e91cab4a97sm12928147e0c.6.2026.10.14.19.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 19:49:14 -0700 (PDT)
Date: Wed, 14 Oct 2026 22:49:13 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Boyan Liu <yymhvert@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 co+98d7de09cd94fec5@bugs.sh, 
 Boyan Liu <yymhvert@gmail.com>, 
 stable@vger.kernel.org
Message-ID: <willemdebruijn.kernel.2a345d6bd54c5@gmail.com>
In-Reply-To: <20261010073015.7665-1-yymhvert@gmail.com>
References: <20261010073015.7665-1-yymhvert@gmail.com>
Subject: Re: [PATCH net] udp: Fix out-of-bounds read with unset mac header in
 unexpected GSO path
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Boyan Liu wrote:
> udp_queue_rcv_skb() and udpv6_queue_rcv_skb() re-segment an
> unexpected GSO packet after restoring skb->data to the mac
> header with __skb_push(skb, -skb_mac_offset(skb)), assuming
> the mac header is valid.
> 
> SRv6 End.DT4/End.DT6 VRF decapsulation calls
> skb_unset_mac_header(). iptunnel_pull_offloads() can leave an
> inner UDP GSO type (SKB_GSO_UDP_L4 or SKB_GSO_FRAGLIST)
> behind, so a socket that does not accept that GRO type runs
> the unexpected GSO path with mac_header == 0xffff.
> skb_mac_offset() then returns a large positive value, which
> the unsigned __skb_push() argument turns into a huge length:
> skb->data moves far outside the buffer and skb->len is
> corrupted, so segmentation reads out of bounds:
> 
>     BUG: KASAN: slab-out-of-bounds in inet_gso_segment (net/ipv4/af_inet.c:1383)
>     Read of size 1 at addr ffff88800da7ffff by task exploit/149
>     Call Trace:
>      inet_gso_segment (net/ipv4/af_inet.c:1383)
>      skb_mac_gso_segment (net/core/gso.c:53)
>      __skb_gso_segment (net/core/gso.c:124)
>      udp_queue_rcv_skb (net/ipv4/udp.c:2476 net/ipv4/udp.c:2466)
>      udp_unicast_rcv_skb (net/ipv4/udp.c:2620)
>      ip_local_deliver (net/ipv4/ip_input.c:262)
>      seg6_local_input_core (net/ipv6/seg6_local.c:1640)
>      lwtunnel_input (net/core/lwtunnel.c:465)
>      ipv6_rcv (net/ipv6/ip6_input.c:351)
> 
> __skb_gso_segment() resets the mac header to wherever
> skb->data points, so the push target only needs to be a valid
> header start. Fall back to the network header when the mac
> header was never set.

I wonder if the right fix here is to not call skb_unset_mac_header in
the first place.

There are plenty of L3 device type with no L2 header. They still have
a valid skb_mac_header.

This fix may be papering over a tunnel doing something non-standard.

> Fixes: cf329aa42b66 ("udp: cope with UDP GRO packet misdirection")
> Cc: stable@vger.kernel.org
> Reported-by: co+98d7de09cd94fec5@bugs.sh
> Signed-off-by: Boyan Liu <yymhvert@gmail.com>
> ---
>  net/ipv4/udp.c | 5 ++++-
>  net/ipv6/udp.c | 5 ++++-
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index bb8cfc62c..fe5a23f1c 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -2441,7 +2441,10 @@ static int udp_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
>  		return udp_queue_rcv_one_skb(sk, skb);
>  
>  	BUILD_BUG_ON(sizeof(struct udp_skb_cb) > SKB_GSO_CB_OFFSET);
> -	__skb_push(skb, -skb_mac_offset(skb));
> +	if (skb_mac_header_was_set(skb))
> +		__skb_push(skb, -skb_mac_offset(skb));
> +	else
> +		__skb_push(skb, -skb_network_offset(skb));
>  	segs = udp_rcv_segment(sk, skb, true);
>  	skb_list_walk_safe(segs, skb, next) {
>  		__skb_pull(skb, skb_transport_offset(skb));
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index 93478d1ad..8db4e2869 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -895,7 +895,10 @@ static int udpv6_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
>  	if (likely(!udp_unexpected_gso(sk, skb)))
>  		return udpv6_queue_rcv_one_skb(sk, skb);
>  
> -	__skb_push(skb, -skb_mac_offset(skb));
> +	if (skb_mac_header_was_set(skb))
> +		__skb_push(skb, -skb_mac_offset(skb));
> +	else
> +		__skb_push(skb, -skb_network_offset(skb));
>  	segs = udp_rcv_segment(sk, skb, false);
>  	skb_list_walk_safe(segs, skb, next) {
>  		__skb_pull(skb, skb_transport_offset(skb));
> -- 
> 2.43.0
> 


