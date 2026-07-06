Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA574314AE
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 16:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783355815; cv=none; b=QHXljzj/WLkF/5cc8n4C0AWAwHtFAJjW39eUz8C7IhosWYIPwKwveIWrjDXs98M1k00usQupVNW/9cqmlxF1BnK3alGxLNdAL9CRcI0aG/eYa96/fE5/DknSAvUCScGimUNy/S4wfziWsHeipO4hax/nXJizGo/0eh7tBDv6hcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783355815; c=relaxed/simple;
	bh=Rq2wwkYTiUr3Hh85G7r77JXihYNgK7FBfHMZJMmDOgw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=lihuySsYgYTW2L3vgfMskLWnPNq9ueUE4uauaOO8jTbVCtBWn+aElN0V7VRvg8U5uG+/547Wkx0soob0/OhY1Iads3/JBY5o8dkOjCG0r6xyK5Yjd/2j9IqtuN2Y4jnjJBpZdekYKX7osmDdPaUBSso8s/atthRGhjaqX/AusgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4X877jB; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4X877jB"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8143d904b01so34534677b3.3
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 09:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783355813; x=1783960613; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0pJcWvIhqLuJxPO4aE4cyY/xCREGxJtBF+FRAD54hro=;
        b=V4X877jBA9oDVQfacZTHh6TmZK3jJb0jUWyEPTuOKLpq+ELFkbFePRD98+hhojR5kL
         s9XkPqndgB4AqsaztKYHkFrg7Q+rvIOYa6CBwYpqduAbYwauX9TB7dPjsNUYhwD2XrMz
         GIMijs/flIefi7urgK/1KKVqQ4SD6C7A2zpLZnOQrAXtYshud5kFACcGvd1/vwbMUN+Y
         xGlyY0ToXXN9EZamR1giZj5FLOzY/Ry/TYPjPf+6u5xMrMld432ZXpKcmT2crC6p8O2o
         PxOpQLtmDglTb83OtDo7XTC2ERQpBYiLjXEqpFkwzNV+uAe+xSKbV4WTpSdsBc9Sz14f
         /ufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783355813; x=1783960613;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0pJcWvIhqLuJxPO4aE4cyY/xCREGxJtBF+FRAD54hro=;
        b=VbvOM+pGlQyVcz5WiRZZk1zPaS/TpDI12zB6RTo885S0pdzeM4Vq/G5BIykz4M+SMm
         bNf06zjMoRhQ2dKIzNcl49FAUxNkHXHN13sxs3IQDKkfarBMDyL9QbTs9FOJLyp1YbSv
         HNoK/95YAK899VTQpt5NqznbNz21PCJ+2a3riyj9NgxYRgBSfZla9m7KVsHKeJb2b/yA
         5DqHpLmIv/KqDnYSt10v/f7V9eEYSj+QinuL8/rkEHwqDvmlN30Hf4qNMuHfC/atdiNH
         IcAIDPIHMTyQH2oHUo4XX0Gs5Z+odAGoRGorIdDrd1vNNYZ/Bxkko1hR2k6JjSp/29Rd
         j/2g==
X-Gm-Message-State: AOJu0YyI8zp5MO4AP8KJ8yS9CPaipLxDpp9faDeZR/k2wqyKsc9QGAlR
	4xgYe1z6px3AINtdrrqMBOB1HOLo0byY1ox1LcIVM/0LZhln1C4Byps+
X-Gm-Gg: AfdE7clAcudz5vhbAJ3c4fABk9Fj82NKVS7oV/cwiODd9myce5LrfDxkVI/Mi1OEEZT
	uWEFkQwgj6gLcHmSMxItWnFGOWGuZdzFc6yCwItmpU9tUmccUCkJ1OyPgm4Wlu+uGsj/82kzfGJ
	ZPRfNDH/wCu/7j7O6mDF8wCmdEtfPYh+xnGXgwz68PmYG8HPdR7Rb0i8cf8RAB1tPRd+/kRxKpO
	OLh9+Iz8iSj1Jsyw0QRMO+BIjkp9dYqJVdjuUBV3zEX6t6IPz087++zaelm8AvNZuRJUMhMrfdO
	ZJA3bHHb/2MFpG7i4oBVtEO6fGNmrK+ku3m+Uv+0zhK+ENnN+OO1HwXsCsuXAFCsNPNEjrWfB7y
	v50FAS35aFe4PmMPn67SujvwgeWw0x3y3QUVLqhXhAORVfDDTE38XViox4hnArCk+cw/xTqzZAD
	11BIWFFQELQl3OZLpcsbFp93UMg0ZiRCH7d1shiRSs1dI9jeFNVWBBgQAFatQsCI+Pkw==
X-Received: by 2002:a05:690c:ed6:b0:80c:85e5:8750 with SMTP id 00721157ae682-81be33a3727mr8097857b3.57.1783355812853;
        Mon, 06 Jul 2026 09:36:52 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8144bd26ebfsm59805817b3.48.2026.07.06.09.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 09:36:52 -0700 (PDT)
Date: Mon, 06 Jul 2026 12:36:51 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Shiming Cheng <shiming.cheng@mediatek.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 matthias.bgg@gmail.com, 
 angelogioacchino.delregno@collabora.com, 
 willemb@google.com, 
 daniel.zahka@gmail.com, 
 alice@isovalent.com, 
 sd@queasysnail.net, 
 eilaimemedsnaimel@gmail.com, 
 imv4bel@gmail.com, 
 nbd@nbd.name, 
 dsahern@kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 steffen.klassert@secunet.com
Cc: stable@vger.kernel.org, 
 lena.wang@mediatek.com, 
 shiming.cheng@mediatek.com
Message-ID: <willemdebruijn.kernel.27b4940999026@gmail.com>
In-Reply-To: <20260706034611.360-1-shiming.cheng@mediatek.com>
References: <20260706034611.360-1-shiming.cheng@mediatek.com>
Subject: Re: [PATCH v5] net: gro: fix double aggregation of flush-marked skbs
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

[PATCH net v5]

Shiming Cheng wrote:
> The skb_gro_receive_list() function is missing a critical safety check
> that exists in the skb_gro_receive() implementation. Specifically, it
> does not validate NAPI_GRO_CB(skb)->flush before allowing packet
> aggregation

In v3 I requested referring to the commit that fixed this in
skb_gro_receive: commit 0ab03f353d36 ("net-gro: Fix GRO flush when
receiving a GSO packet."). That explains the issue well.
> 
> This allows already-GRO'd packets with existing frag_list to be
> re-aggregated into a new GRO session, corrupting the frag_list chain
> structure. When skb_segment() attempts to unpack these malformed packets,
> it encounters invalid state and triggers a kernel panic.
> 
> Scenario (Tethering/Device forwarding):
>   1. Driver: Generated aggregated packet P1 via LRO with frag_list
>   2. Dev A: Receives aggregated fraglist packet and flush flag set
>   3. Dev A: Re-enters GRO, skb_gro_receive_list() is called
>   4. Missing flush check allows re-aggregation despite flush flag
>   5. Frag_list chain becomes corrupted (loops or dangling refs)
>   6. Dev B: TX path calls skb_segment(), crashes on corrupted frag_list
> 
> Root cause in skb_segment():
>   The check at line ~4891:
>     if (hsize <= 0 && i >= nfrags && skb_headlen(list_skb) &&
>         (skb_headlen(list_skb) == len || sg)) {
> 
>   When frag_list is corrupted by double aggregation, when list_skb is
>   a NULL pointer from skb->next, skb_headlen(list_skb) dereference
>   NULL/corrupted pointers occurs.
> 
> Call Trace:
>  skb_headlen(NULL skb)
>  skb_segment
>  tcp_gso_segment
>  tcp4_gso_segment
>  inet_gso_segment
>  skb_mac_gso_segment
>  __skb_gso_segment
>  skb_gso_segment
>  validate_xmit_skb
>  validate_xmit_skb_list
>  sch_direct_xmit
>  qdisc_restart
>  __qdisc_run
>  qdisc_run
>  net_tx_action
> 
> Fix: Add NAPI_GRO_CB(skb)->flush validation to the early-return check in
> skb_gro_receive_list(), matching the defensive programming pattern of
> skb_gro_receive().
> 
> Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist chaining.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
> ---
>  net/core/gro.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/gro.c b/net/core/gro.c
> index 35f2f708f010..b1573d98f3a5 100644
> --- a/net/core/gro.c
> +++ b/net/core/gro.c
> @@ -229,7 +229,14 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
>  
>  int skb_gro_receive_list(struct sk_buff *p, struct sk_buff *skb)
>  {
> -	if (unlikely(p->len + skb->len >= 65536))
> +	/*
> +	 * Packets marked with NAPI_GRO_CB(skb)->flush have already gone
> +	 * through GRO/LRO processing and must not be aggregated again.
> +	 * Re-entering frag_list GRO may corrupt the frag_list chain and
> +	 * later crash during GSO segmentaiont.
> +	 */

Such a verbose comment is not needed. Code would be overwhelmed by
comments if done everywhere.

> +	if (unlikely(p->len + skb->len >= 65536 ||
> +		     NAPI_GRO_CB(skb)->flush))
>  		return -E2BIG;
>  
>  	if (!pskb_may_pull(skb, skb_gro_offset(skb))) {
> -- 
> 2.45.2
> 


