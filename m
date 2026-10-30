Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793349367;
	b=PwgBm7h4q35R+lTg6/pMZI+S9fvF6B8PQ4ySX4/K19XEIokmTfzKK0Y5TqbdIYX3j2QG
	 90FJXPOCmTRtZKFiDDxQt32GmwjQgwARLvpUG+7aKn75sN2OzDDedeRCDa7XIilXGSsW9
	 lvM3uCiYjHPQ/5sG9j6lh5sCX5V/QfjgCZofu0P6Lpens2RGoJhSvHepsBdMbeFLzO7p6
	 4O0qqdmlEFxWJ/FUULljJ6P2LqIFXUhAmKsUVffn7/Gq05Nd/qir9tYJ7L3rMEnQQe0/2
	 RXroZWicbqV8KPtBNznlrUHRO9JUlKP/hLjKuQBxKsuh+lx9cv1yTL5aBedmpi7foSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793349367;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Z/0fKFpcOL8jDtKycmBdD2w0mXmNA4E4QEafzXaEJGg=;
	b=rIbAI0IM4oBF64B8Z4PcpvhzZJWqjKpw8uhO4AWH+tDA9Fu8822yr+q9H2wL5G9GAhCc
	 8q2znj4GKR/+yOHl8ndMuyrVeKMzydtsnh1Tc/EiQi1uQlNGPWWVn6bpdNNz2ZNemnLno
	 ECVhKf5q0l4NC+EMTrHCrYpPQGZKFbclWNu7nCxGI1PsLfPvVCmgLw+H9tbhn0S9tRQTf
	 5kMG+GJeGHs951f0fuIaDjS42EfrP/aF7A7i1MumM15BP9Yu/Z2PkRjxcTbTbFtMnYtuI
	 k56fef8mH6cSMvBt9NPTNtHQOEUqYltsKbiZnDufaUVLg2sUCFlFbBSKH9Gxh0UKbkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ffueVzOQ;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7915F60A263F
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 08:36:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7915F60A263F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ffueVzOQ
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-18818daa3e7so140256c88.0
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 01:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793349366; x=1793954166; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z/0fKFpcOL8jDtKycmBdD2w0mXmNA4E4QEafzXaEJGg=;
        b=ffueVzOQGc+pangLd5R4aw3Fl2k+ml76QXYStCqWEw5twV+CeSuaV+KVA0sKWquktA
         8puoSLyQKkdrfnHQtJJ5XLEqcpyZ5+hNE5w66ch6+5n1fFVr0gCabMOXJMeMBFfD9dAK
         DUQK3t1sXXRdKuFIFCuDsjM0pxZLCoM9gKKTSNwW888ooNS+2SVc0Af6C2ZqcxkXs6ot
         SFa/228BKDnr+rC85nhUq5T1zUesyMLeAHhiFJ551QJeKXtRX4L1CUiyjaAiCjU8AYoX
         xgKn3tUpZWLbTwiYOBDmiH0B7ja+ukWNqTjZT9c7uyCKUU9nVQgWZ7XXDx59fHPrqh6X
         YPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793349366; x=1793954166;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z/0fKFpcOL8jDtKycmBdD2w0mXmNA4E4QEafzXaEJGg=;
        b=aWtBfJTr8v93XdWFZfEli6g07PK6DrH4cSf7ODTl9rgT+8fnAAIdxNvfhDu+V+8dEm
         sEEFHfMuOIu1I1Gx+RLeasmMoF0xYmeFDuze5+2DmKdyxhV+7+8aNi1WFGsuFB976jbu
         pEQk/D9T0yJsseb9RMFVGrWR9JKbhTLqmU/xxC2/S+7eZtyfcSNhzBS7TRgrneMjGhnr
         fjfF+cN0hmHWZHFbnaukNOlJWHgpqhvvFECjvgYwQraYOoK4c0I5u1XxuQpp1Q8glfX+
         XjtOvCHMeH92xdYEQQD3tdxAQXKMn78XAgwmw3dAk2KXIHgYV/wf1dXO41UmlUm2/WS0
         ZYlg==
X-Forwarded-Encrypted: i=1; AKwUvBzAoaIlEkv7IKntQSuCVKRRQRAUUS5kHib+ktqUkB8nEBoEN7EGqXbORduEWjWO2Xk6CdP+YNY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIPKA6n6JxBMH/2PfHlOOEQr4HmNsBu5vl+SU1aAQWhdxWqDTSR
	/g3NKpsTjpea9Anq1M9dZt5O4/UDnor1XKQkZD3D/fSjQseJlsLLhZBW
X-Gm-Gg: AYBFou338ZvABzckJRD7h9jvR0NXc8QzmuLQnxWDKDFi3JIpTvdw9eR+ZpYrZzOJBCE
	GrR0kDJ2mkU/ixldZdJqCKd9nKjGTfV5EgEaMkLZZCiKmWMq2wTZnUS4fuTpyYAwlJOIw08XcEF
	3d57+LAPgHV+gYruUfeyrVuxv0X9vhDFe++xjxe6IVJYG3haPgtuYlfXxRnyceoUA7AjA7Eo07+
	qPwRyJ46smN+CJhEmKSAX4q9xNUELAy7FYytcTU+f+yg29W5/b8fSFwNJBSaUS5V9pYFdbLhznR
	m998SCDF+PBxR8RDbxUUXLf5SYL0JbghM0oV+hB9wSp+i5kzHhdp8BUBZ8DTrQ+frs67rsn1yy7
	cnCt7OBP5BrL2oDzPB8ySakv7RqgSoLMGdnCZPIN2ep8vUB1ZvqaWYJfq9891oXAWKq/WJYdFwh
	8DA236qv25GODttiGyr50UxSXWW8Eu/i+bSl2tOVyirS1fOksdryK8Khh/fWGO/jzSBwQ12XAaw
	wK3xOXA1lqDFhukZWgY9j64Q7S6cgfE2LFRPtUAM7c25s5HV3+1E5Tkzvc42z/YKLCalXBRwswj
	eDITkZa9Sv/JE8MIIiJAxgt7pcSaTw==
X-Received: by 2002:a05:701b:271b:b0:148:ece:8cc3 with SMTP id a92af1059eb24-1a94adc93b7mr6251263c88.24.1793349366218;
        Fri, 30 Oct 2026 01:36:06 -0700 (PDT)
Received: from gmail.com ([2a03:2880:9ff:6a::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac19f4b08bsm5936042c88.16.2026.10.30.01.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 01:36:05 -0700 (PDT)
Date: Fri, 30 Oct 2026 01:35:04 -0700
From: Narcisa Vasile <narcisav.kernel@gmail.com>
To: bo cao <treebacker@foxmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] ipv6: fix dead half of the MTU guard in
 __ip6_append_data()
Message-ID: <auRVazv4xBe/q0P0@gmail.com>
References: <tencent_D1F9D5069513D7D12F0FC2E55A32A9ED4C08@qq.com>
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
In-Reply-To: <tencent_D1F9D5069513D7D12F0FC2E55A32A9ED4C08@qq.com>

On Thu, Oct 29, 2026 at 10:38:57AM +0800, bo cao wrote:
> ipv6: fix dead half of the MTU guard in __ip6_append_data()
> 
>  net/ipv6/ip6_output.c | 41 ++++++++++++++++++++++++++++++++--------
>  1 file changed, 33 insertions(+), 8 deletions(-)
> 

The patchwork check indicates that two more people should be added to CC.

> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index 25fe0ba98b1a..ab4eee51f173 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
>  
>  static int ip6_setup_cork(struct sock *sk, struct inet_cork_full *cork,
> @@ -1499,13 +1513,23 @@ static int __ip6_append_data(struct sock *sk,
>  		     (opt ? opt->opt_flen + opt->opt_nflen : 0) +
>  		     rt->rt6i_nfheader_len;
>  
> -	if (mtu <= fragheaderlen ||
> -	    ((mtu - fragheaderlen) & ~7) + fragheaderlen <= sizeof(struct frag_hdr))
> +	if (mtu <= fragheaderlen)
>  		goto emsgsize;
>  

It might be simpler to just contain the whole fix within __ip6_append_data()
without changing ip6_append_data_mtu().

Just factor Sashiko's high severity finding into the check
suggested by Willem. Something like this (untested):

-       if (mtu <= fragheaderlen)
+       reserved_headerlen = fragheaderlen;
+       if (!skb && !(rt->dst.flags & DST_XFRM_TUNNEL))
+               reserved_headerlen += rt->dst.header_len;
+
+       if (mtu < reserved_headerlen + sizeof(struct frag_hdr) + 8)
                goto emsgsize;

>  	maxfraglen = ((mtu - fragheaderlen) & ~7) + fragheaderlen -
>  		     sizeof(struct frag_hdr);
>  
> +	/*
> +	 * Each non-final fragment must leave room for at least 8 bytes of
> +	 * payload after the fragment header, matching ip6_fragment()'s
> +	 * mtu < hlen + sizeof(struct frag_hdr) + 8 check.  This rejects
> +	 * MTUs that make maxfraglen underflow below fragheaderlen and
> +	 * defeat the datalen clamp, which leads to skb_over_panic() from
> +	 * skb_put().
> +	 */
> +	if (maxfraglen < fragheaderlen + sizeof(struct frag_hdr) + 8)
> +		goto emsgsize;
> +

You could then remove this maxfraglen check and its comment.

>  	/* as per RFC 7112 section 5, the entire IPv6 Header Chain must fit
>  	 * the first fragment
>  	 */
> @@ -1635,10 +1659,11 @@ static int __ip6_append_data(struct sock *sk,
>  			else
>  				fraggap = 0;
>  			/* update mtu and maxfraglen if necessary */
> -			if (!skb || !skb_prev)
> -				ip6_append_data_mtu(&mtu, &maxfraglen,
> -						    fragheaderlen, skb, rt,
> -						    orig_mtu);
> +			if ((!skb || !skb_prev) &&
> +			    !ip6_append_data_mtu(&mtu, &maxfraglen,
> +						 fragheaderlen, skb, rt,
> +						 orig_mtu))
> +				goto emsgsize;
>  

The emsgsize label returns directly, which skips the cleanup done under "error:".
Could this, for example, leak uarg if msg_zerocopy_realloc() already allocated it?
If ip6_append_data_mtu() remains unchanged, you could remove this change
too.

>  			skb_prev = skb;
>  
