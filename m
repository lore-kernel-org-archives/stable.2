Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B054231839
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 22:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789339617; cv=none; b=CDBrR4BEuc/M/BJN/S8e1qj1KYF5pbY806efLutUthwx/MM0klOKwGm0c2A+4DDLbsdv2eEuhviNrXehzqrgnCVpsp+vfahoUCB5v2fptA7YMyJlNXWfKTicnXXQrbeopVlDHTVXvpyaJ13fdfNk5qtY4oPLlxdmSmOwH6ypiKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789339617; c=relaxed/simple;
	bh=f7g6zXVilwddxptfkL/USO9oZbQ1gzWDd74Fx4qifog=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=QjcCC+FTOxl0l/fBYJz/iWoaHdMghLAm1RyvHGEBSCUJDG+QH2RHjWNszIqP0+RVhJaZcjtEDiJRGHpRE9S1Vsi74p5qH8hOeWKr+epJZPdIeZ/SLQ8jZVPBje784a3VythwF6gO4GBB+Xfnd8hk6UkIqJj7OgCy0w/g/Qq5rO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7mVFiLU; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7mVFiLU"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-861a2ae9c51so22175457b3.0
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 15:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789339614; x=1789944414; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2O2w+/0+tuJH6CYorTtrmcLZUju0PTpZ3Cer9pa/gqA=;
        b=N7mVFiLUQWpxKAZgthOiJqCUKTX59+4jU8MFszY3n7AsLqNxMvPoRdGbNzxtyvKkg3
         CaAAOSkxHyWDC63vpfXnLa6z4vI820iasa32O3cLwUab73KNGIcl/jJN84V0euXnrq3a
         RaCssAouxXeXBiXs4V07sSR3y7HYp26Er9suLPuK9pHKHlZ9acG1AQtnTDXd7HxT6v09
         zY7uToss3SNZdBI/PD+owPXZkqQKkzSo9V0kJrYRUckiB3QTHnsUxbw2rJg2CE+l3KkW
         JhGkUYTM15ZsrNjdZGXoBReW03A2RigwNKyCLyLQxb0knqgSu4zUls8nwbxYVrILwUAJ
         TQjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789339614; x=1789944414;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2O2w+/0+tuJH6CYorTtrmcLZUju0PTpZ3Cer9pa/gqA=;
        b=iiTLbPIyKsthcu8TAM2KSQkFR+OZKOQkisEm9UdIOCQj/EJqckyqLoxlBlD+WxmBW4
         nvWFyRW5TiDIj+Nnstwfi768aI0F4AhdCcukckXCFt2E+HKnnj5vDo/Oz8WV5oqCjSx7
         GVS7XHh1jUMBGxPvKVhCbttWD4XbiO+c0I7Doly7a8NffMjLUmIE5k7rWL3+wspBWQaD
         wNzxb/KgwX3fGKUx4DaP2+7grSnLZRD4AxJv+KwoEU1WlgK0m8SZr29C2Zej8vgFJJC2
         OiTuGk7bAN/JZyQk0a0p7EstLMOAeZpfrt6NWG7O8YmglDGHyHNXrfT58Nua8eqFdXIs
         oAhw==
X-Forwarded-Encrypted: i=1; AKwUvBwayqkxzS4rLZSmKXLPGov4vATsy8xDQnFmUDowGgKFd5xXSfqAzhZ3FcPT52kl+66HJ3pdvls=@vger.kernel.org
X-Gm-Message-State: AFuF++n/MKjHFLBlXkLtjXDuyBZoh8gwJJ6oa52l0qy+hIlQs2p7Gt23
	G454qfQdhSOhnQLUrE98Yo8OabgTeML248xb3QtPLNatAD+EVJpOYzyz
X-Gm-Gg: AYBFou1rP45YZw2FJBfqdWndAPTnuDHrDPWWgGCAci8CPCpEEtjauJfhcXJ1Hr3ITZQ
	Keb9QYfJ3wqj3SONE2Cgf1XYOpmyaQFVsTf4XOoz27D20Y4Ho2qUd9z87dbPxnoP0cMAnL7Ynzu
	mJdDPtSvbmmEpYY6Z9sB97sHPlBPL38BmTxdfXecUsYrF1G0s2dKCdljxG1DvgHRIeFdObmIcYx
	Dn3+JEG0ElcqWIJCre/wjAsjpoCFJbKjBvWdAWmKkqU8icEiqR1pfJh1HNhiN0JJeVN7Hb3aURY
	j+wTSnPv2brcmT4/LhX1NZE6w99DF8dfSJOBda9rLimxb/UhcBgC0oDfBalpy0RV18i+5QtsGtM
	X3kIw106DkL6pEV06lLm1WCjOTkr1DNVvTOYpeVe4OPsROE3QRj8ldkArXpdD8DebGiW59vT2Nt
	KYYoa5K7awvevXWqryTqFZOd3EwEt46mtRde9vYMh/oIFPor2FiB0CuOtRQiGtUH3VnVto24d5O
	lOZdLi1Z6OCdo5PeZKUzqnyWM9GdEVAt9zQ+F6mLVpTy8/4Czkd
X-Received: by 2002:a05:690c:60c4:b0:873:5bb2:6c21 with SMTP id 00721157ae682-88d22ed00b0mr322407b3.40.1789339614081;
        Sun, 13 Sep 2026 15:46:54 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-88488c3ab26sm30991127b3.40.2026.09.13.15.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 15:46:53 -0700 (PDT)
Date: Sun, 13 Sep 2026 18:46:53 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Zihan Xi <zihanx@nebusec.ai>, 
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, 
 zihanx@nebusec.ai, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 dsahern@kernel.org, 
 idosch@nvidia.com, 
 willemb@google.com, 
 kuniyu@google.com, 
 kees@kernel.org, 
 richardbgobert@gmail.com, 
 jiayuan.chen@linux.dev, 
 stable@vger.kernel.org, 
 Vega <vega@nebusec.ai>, 
 Luxing Yin <root@tr0jan.top>
Message-ID: <willemdebruijn.kernel.57ad3a4d0955@gmail.com>
In-Reply-To: <a4f108b00c7d3c0997bfcee84a9e7e481c07ad5b.1789302084.git.zihanx@nebusec.ai>
References: <cover.1789302084.git.zihanx@nebusec.ai>
 <a4f108b00c7d3c0997bfcee84a9e7e481c07ad5b.1789302084.git.zihanx@nebusec.ai>
Subject: Re: [PATCH net 1/1] net: gso: limit recursive IP-in-IP segmentation
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Zihan Xi wrote:
> IPIP GSO/TSO support makes IP-in-IP GSO dispatch re-enter
> inet_gso_segment() or ipv6_gso_segment() for every nested IP header. The
> only state that tracks this nesting is encap_level, which records header
> bytes and has no recursion bound. A sufficiently deep chain can consume the
> kernel stack before a transport GSO callback is reached.
> 
> The unbounded callback nesting was introduced when inet_gso_segment() was
> made stackable by "ipv4: gso: make inet_gso_segment() stackable". GRE GSO
> support predated that change, and IP-in-IP GSO/TSO support later made the
> affected path reachable.
> 
> Track the number of IP GSO callbacks in skb_gso_cb and reject the 15th
> callback entry. Thus 14 callback entries are allowed to complete;
> GSO_RECURSION_LIMIT is the rejection threshold, not the number of
> successful callbacks. Initialize the counter for each top-level GSO
> operation and check it in both IPv4 and IPv6 handlers so mixed IP-in-IP
> nesting is bounded.
> 
> Fixes: 3347c9602955 ("ipv4: gso: make inet_gso_segment() stackable")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: LLM
> Co-developed-by: Luxing Yin <root@tr0jan.top>
> Signed-off-by: Luxing Yin <root@tr0jan.top>
> Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
> ---
>  include/net/gso.h      | 9 +++++++++
>  net/core/gso.c         | 1 +
>  net/ipv4/af_inet.c     | 3 +++
>  net/ipv6/ip6_offload.c | 3 +++
>  4 files changed, 16 insertions(+)
> 
> diff --git a/include/net/gso.h b/include/net/gso.h
> index 29975440cad5..2665acbb9205 100644
> --- a/include/net/gso.h
> +++ b/include/net/gso.h
> @@ -19,10 +19,19 @@ struct skb_gso_cb {
>  	int	encap_level;
>  	__wsum	csum;
>  	__u16	csum_start;
> +	/* Number of GSO callbacks this packet already went through. */
> +	u8	recursion_counter;
>  };
>  #define SKB_GSO_CB_OFFSET	32
>  #define SKB_GSO_CB(skb) ((struct skb_gso_cb *)((skb)->cb + SKB_GSO_CB_OFFSET))
>  
> +#define GSO_RECURSION_LIMIT	15	/* First callback depth to reject. */
> +static inline int gso_recursion_inc_test(struct sk_buff *skb)

What is 15 based on? Is that where in your test stack overflow occurs?

A realistic practical limit would likely already be smaller.
