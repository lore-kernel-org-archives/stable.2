Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C66C3164D8
	for <stable@vger.kernel.org>; Sat, 25 Jul 2026 07:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784965574; cv=none; b=DcaUzBbvjC8tsBRWSnVP9K9S0TrEnjkUUn9+Cp0QTdrv680mXMh2wmIIpJkPcxT10hQOFr+lDM9XsfjEZ3wgjKmPoLm5mBuKOEowN9cZiA/fkeh91nAwsVR9inwqEvyhtQdxe5edv71Yb0gQ7VS9Wyk4H8D/u/PHtlImFyU8Z3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784965574; c=relaxed/simple;
	bh=5OVQlVYe2jv+wEYK1liAv5L/mkNj8Al5Qnr2AyBTr+I=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=h6x3bO/0XLfAHUQmCniyo4eNZSAT2vJaeixX+YapkUGRzg5wBL5WZzAPH/G2nZiBBlMc5SuBVtByjVnFq7K9DlDEqQq8XkW85G8dlMqF9BIX9HRM9IEaTRCaLSVHn/acA6VrOLVqxPcLlh4v36OBF6xoPVsfbHoCXebH7Y7vQN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEBReZ8g; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEBReZ8g"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-66896892b6cso1108441d50.0
        for <stable@vger.kernel.org>; Sat, 25 Jul 2026 00:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784965572; x=1785570372; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=K5kSd1k8vO99vMXYvgUXMROeYIo+K1uhrvqwiQkFcJ4=;
        b=KEBReZ8gejgJ0vUOp6rKdrn8OYTZLicKJnyraak560maouyN5LqcjS5v4429Ift6L2
         gkGE0KiYNIs8joWlma2R2HhgFwm1LKIZiwathEAxCpHWY7bw6QZlMwLN1rvIx2vQ3ZvW
         Ihu8akQGQBxinsSAUlQT9J8Otjo86KWRQOWtIKxIjAGcSbc1yAVciIr8+LJP1Zol4bEY
         sT12pZGShkGdx3GT/sEbluhBIbwlwjPrWIfO8d7KfZ7RLp0Mot9NF4A+NTFHwRsW5u00
         y9voFSTgOJ9SmBBEeIhzWa8eHVYPrSD/WWPzLMyNOvN94bfxugA+ljL+jIPUFS0bQF8p
         aBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784965572; x=1785570372;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K5kSd1k8vO99vMXYvgUXMROeYIo+K1uhrvqwiQkFcJ4=;
        b=sAwzU/fHZscKiOZnNb254jCxNFAHJXBToXAxPn4xuKSykyUI8hu4bWzj+L/Lu09GKP
         IdM9ALMDHndPx2C1vhMXrDLuWZ6G+oac1oQuXRCmc6BdTp6O7NkZWJSKqQ4ZtVZdH+vJ
         omTWNvbcDVGB1HrBBZr4jAEJW7TbYr3J7QE8RqyQ0eRjtzSQShmvAylU4xC4i7CFQHtn
         pHtulka4yP3bCRlhRU4glgN69q9yfkuhLHwtac+sRAdJKRWibcLycPkjaaO6SdB6ZWgf
         y1w5oU2UK0Md1Z1+gMluFYLgHxvqlCwfclOKYTnU2B2J/JVlIqTlf0k4RlcWOgWtEarv
         4NSg==
X-Forwarded-Encrypted: i=1; AHgh+RrQ0Y5Icdd2qMyrwpTDPWGjmvIDhJsZIM1iFTSeNjegkbNNV9YXXVdmGabmC8nxKw2ND47tB3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTU838C2TYa10n8CQDh4WmKJ0fy0Yyj6HoTdIRjunaB5VMuuTV
	u02GNjd9YN7X/T9m38FqXKfuNfMrENzdzsRO+miuEsD9HYZykmSUms0K
X-Gm-Gg: AR+sD10LzyJYOBUV3Klvqnlr1VDS27CbSiyVPkawDtcXgeuQxXE8T3l0QZsQevofC9p
	x+EdkOxGaKPbPWFjl0GR1FHd0YmcTh9hLUIa72UgGoL6y1ShaiXTgsHf3HOTc6C1OKK7HvdFE9B
	EsPolF3sM8k05JVTljGyywDehs/8hjKwa1c3bhGMirRfC9hYq8fe5t3mwJwu+h67Ou6eBV/p6av
	pw5tKsNDmvqokap9Cw+VQkSLyHTO1CvevYYv2G51WQoXUmw2w6mLzwHYcE2j2pdfqgRlaSnKYRN
	ThqWWP2efmZHv0VKLat8m5z1k16ptkz1puFR5dJ3mMCrGf39l3038uKMZeYKG7Bd1zcM6KfYsUV
	yKpTyal8GsUDzkJM13VwWUH9C/uUa43pqoOVTZ29LpKgF4vv9PgWyxTV1JcGXsNEi0gB8c7rhFT
	pSaxQDi/gzkkpw4tk4K51puJOP8QFPd1AEimNTaGPWYptH4qzALCyNd9aZhp5AwBQpsw==
X-Received: by 2002:a53:d045:0:10b0:668:311a:d444 with SMTP id 956f58d0204a3-668c7c31410mr275480d50.106.1784965572388;
        Sat, 25 Jul 2026 00:46:12 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-668c70698b7sm535928d50.20.2026.07.25.00.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 00:46:11 -0700 (PDT)
Date: Sat, 25 Jul 2026 03:46:11 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Doruk Tan Ozturk <doruk@0sec.ai>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 sd@queasysnail.net, 
 Vladimir Oltean <olteanv@gmail.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
Message-ID: <willemdebruijn.kernel.d5ba4e62d4d2@gmail.com>
In-Reply-To: <20260724144015.63219-1-doruk@0sec.ai>
References: <20260724144015.63219-1-doruk@0sec.ai>
Subject: Re: [PATCH net v2] net/packet: reset the MAC header on the
 packet-socket transmit path
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Doruk Tan Ozturk wrote:
> packet_parse_headers() resets the MAC header only for a SOCK_RAW frame
> whose socket did not bind a protocol. A protocol-bound SOCK_RAW socket,
> any SOCK_DGRAM frame, and the legacy SOCK_PACKET path therefore leave
> skb->mac_header unset here.
> 
> For frames sent via __dev_queue_xmit() this is harmless: it resets the
> MAC header unconditionally. But the packet-socket PACKET_QDISC_BYPASS
> path uses dev_direct_xmit(), which does not, so the frame reaches
> ndo_start_xmit() with the MAC header unset. A driver that reads
> eth_hdr(skb) on transmit then dereferences skb->head + (u16)~0, an
> out-of-bounds access ~64 KiB past the head -- the same class fixed for
> one consumer in commit f5089008f90c ("macsec: do not read an unset MAC
> header in macsec_encrypt()").
> 
> packet_parse_headers() runs only on the transmit path, where skb->data
> points at the start of the L2 header for every packet-socket type
> regardless of its length: SOCK_RAW and SOCK_PACKET carry a user-supplied
> header and SOCK_DGRAM has one built by dev_hard_header(). Reset the MAC
> header unconditionally, mirroring __dev_queue_xmit(), so the frame is
> anchored on the bypass path too.
> 
> Found by 0sec (https://0sec.ai) using automated source analysis;
> verified against source and matched to the macsec KASAN report in
> f5089008f90c. Compile-tested.
> 
> Fixes: 75c65772c3d1 ("net/packet: Ask driver for protocol if not provided by user")

Link: https://lore.kernel.org/netdev/20260723020337.19040-1-doruk@0sec.ai/

and perhaps also

Link: https://lore.kernel.org/netdev/20260713194010.54642-1-doruk@0sec.ai/

> Cc: stable@vger.kernel.org
> Assisted-by: 0sec:multi-model
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>

Reviewed-by: Willem de Bruijn <willemb@google.com>

My slight caveat about variable length protocols remain (though
perhaps not, with the recent removal of ax25). But evidently this did
not matter for __dev_queue_xmit either. Probably because drivers for
such protocols did not incorrectly assume that mac hdr was set, unlike
the three drivers identified as vulnerable. In any case, fine to have
equivalence between dev_direct_xmit and __dev_queue_xmit. Over time,
these changes chip away at the whole point of a "fast path", but
that's a separate discussion.

> ---
> v2: address Willem de Bruijn's review -- clarify that __dev_queue_xmit()
>     already resets so only the dev_direct_xmit()/PACKET_QDISC_BYPASS path
>     is affected; note skb->data is the L2 start for all packet-socket TX
>     types regardless of L2 length; move the explanatory comment out of the
>     code into the commit log (kept one terse line).
>  net/packet/af_packet.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index e75d2932475a..5ae0511e89e3 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -1924,11 +1924,12 @@ static void packet_parse_headers(struct sk_buff *skb, struct socket *sock)
>  {
>  	int depth;
>  
> +	/* On TX skb->data is the L2 header; anchor it for all socket types. */
> +	skb_reset_mac_header(skb);
> +
>  	if ((!skb->protocol || skb->protocol == htons(ETH_P_ALL)) &&
> -	    sock->type == SOCK_RAW) {
> -		skb_reset_mac_header(skb);
> +	    sock->type == SOCK_RAW)
>  		skb->protocol = dev_parse_header_protocol(skb);
> -	}
>  
>  	/* Move network header to the right position for VLAN tagged packets */
>  	if (likely(skb->dev->type == ARPHRD_ETHER) &&
> -- 
> 2.43.0
> 


