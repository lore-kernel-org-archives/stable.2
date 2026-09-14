Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104C83EF0AA
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 08:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789372985; cv=none; b=P4E41QGP/Mixyf+YgDgcLGFHWphH0JxwlxJeVTTDGiEjULPawoxiP67NTpBnoI50kTVPTNy6JzEn2bnLoDO1vSgpNiA+x5M+z/Tcpt6GZVuqheSp+Z/jsnP1DJujOsRVWWHN6ubNfpMaLpvWv26BPAOwSc07N2MMBAgHQoTxGoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789372985; c=relaxed/simple;
	bh=50eSPHox2Zsfj7F9UKH3Tuowfr6Y0XyNXGmvAoGBepI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JErgQME2k+i9ib9POWGqoB1w1WAbXDkeb8HC5XeYxMOHni5IZMp+tiwdDVpBNTrs2y8to+Ku8P0V6gHx0LQuxDjq22U3pUqHV5yKrlBh1lVEpohB2dxsSzWGjuj1UQ+xpiucOpznIGMlZ/Wq1RBxQkiMLWpZoT712kRmiUyHaew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mlLkcFNf; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlLkcFNf"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccfd61ecaso16059505e9.3
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 01:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789372982; x=1789977782; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nFvY4nvrp8jk1FFzx/RVet+XhGQRlYHVzbRdGgTlNOU=;
        b=mlLkcFNf3YzGcBxUFp3/WbWyXNtIgfmGgEKKAveM/br/e15J1ZMXSRR0hdXUjLA/5s
         wchZlHEvHlgJn5m9e+OHFeA8aBfFgFb1V8nCA6h4ve8xLEyhi66IMrItUUdGO32nU9VE
         aUNGu8fTMSQ5LEII8Wp0eIRh6/xqy7ZVmYgCyRWirfYz1aV2lq8ekr8d6FlqyHfuQHq5
         LzelKDWb+uoAlFYAMU1TKPtLsBEyv/XXe1jCiE/bPXzsUgZ78DqLzBQzxzJnmhBu0uNN
         PX50Qjq+6k5n6I0mbU2zZYftFwrukqO6mZDhi+2ZJzI+UGDX2TOiVFd4izONLR2wDnG0
         hWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789372982; x=1789977782;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nFvY4nvrp8jk1FFzx/RVet+XhGQRlYHVzbRdGgTlNOU=;
        b=E6Pfhfjeq7dYRO1VFl1X5yjwEF0wOlDPzjEYftGpS8qBBYZZwrAaCPX8gm6qt9RNgB
         eeb/JwgMUsOkair47npX4TLhDOfJnwUvfe0YB37cTB3OHTvcIIYCtCohvhYT45a3d7UG
         x37vaKInuP7bALDK3EcA/HrzzmJFcYi1ZuV8p1PmA1UuxA0Fkloo/tV18l+cS6yzE38U
         sBgYXvnu266IVNYUfBQkC/a3iZ4Uv7fQ2i3fj3SEi30PYL65ldd+ZWWCLZl5ZSr820UZ
         U+fUyw30s+4y6WqgP/Nw3VzxrmMqzKYpI0FBdxh+JT4+ila9qYC1D24ZQxGmJVOQOTkT
         ITzA==
X-Forwarded-Encrypted: i=1; AKwUvBzisfSoEF5y5CdUAqrp5mHGtJRcxs3cW9CGa+w04P55am/hKN6wbmAASZtVMwF9UD+knX5FD1U=@vger.kernel.org
X-Gm-Message-State: AFuF++lkki2gI9arxDepHk+lGe2gQhx0WzBem0OC6JX9ozBp1YF5nyCs
	7Ae02zyCDWSO5fGf/LTFxaW0zVtWFggN3dDdChu2094+h/94E4BavWkIM3GRNWnj
X-Gm-Gg: AYBFou0+7HYSFTi/t8mAwBthZRfS39aavBFvg+dn4XgJbrT7E/YWw9WG084AE5u6dFj
	NjPHshOTmVr+J0PKrCktnR+0akkg+x/6EKH0RlCzJ8DcsjlEZj6uoYJUtuQ8Mgdh7qXRLjNUWCg
	wH0pv3XS7KLt1nT5AkHPGlewMtPya5si0PanoRt/kM0tsIifwZCK3ELSLc7CbAx/HQ7UeLfYmuU
	P7G3wrjWPtT9h0zt5g9eZo/n0gztWPaYn+BKMjDFWHO5pjQQg34Xx9uUqDkXhpLcYS9RkkCWGYq
	cno4yCeASzOpYBT97p6jJCHkyWeBqexeEpOnzgQZBCoLI4pX5lmM2doejzkACA14nflSLjmXLHY
	4pq23JLmJUzMLu2dkZIbB2crurfaWMQDCjgvHS3hkvr84Wo/IWH/5QQ2FUk6Jqzqzu/GpdgZ1rd
	Ei2MaXIAv12du9+4WSBLbhEStex3bbzDy1VT6X2bzSrpkPbW0g7225SQDfTyZuBaYajOOyZ9r7D
	ESHqldDwILEVVkvME4mG7ZDDubpimAl92y4
X-Received: by 2002:a05:600c:4e89:b0:49d:7f5:4cdd with SMTP id 5b1f17b1804b1-49e7a68d80emr14744645e9.27.1789372981897;
        Mon, 14 Sep 2026 01:03:01 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e71861d71sm172806235e9.11.2026.09.14.01.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 01:03:01 -0700 (PDT)
Date: Mon, 14 Sep 2026 09:03:00 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Zihan Xi <zihanx@nebusec.ai>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 idosch@nvidia.com, willemb@google.com, kuniyu@google.com, kees@kernel.org,
 richardbgobert@gmail.com, jiayuan.chen@linux.dev, stable@vger.kernel.org,
 Vega <vega@nebusec.ai>, Luxing Yin <root@tr0jan.top>
Subject: Re: [PATCH net 1/1] net: gso: limit recursive IP-in-IP segmentation
Message-ID: <20260914090300.6ad169c0@pumpkin>
In-Reply-To: <willemdebruijn.kernel.57ad3a4d0955@gmail.com>
References: <cover.1789302084.git.zihanx@nebusec.ai>
	<a4f108b00c7d3c0997bfcee84a9e7e481c07ad5b.1789302084.git.zihanx@nebusec.ai>
	<willemdebruijn.kernel.57ad3a4d0955@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 13 Sep 2026 18:46:53 -0400
Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:

> Zihan Xi wrote:
> > IPIP GSO/TSO support makes IP-in-IP GSO dispatch re-enter
> > inet_gso_segment() or ipv6_gso_segment() for every nested IP header. The
> > only state that tracks this nesting is encap_level, which records header
> > bytes and has no recursion bound. A sufficiently deep chain can consume the
> > kernel stack before a transport GSO callback is reached.
> > 
> > The unbounded callback nesting was introduced when inet_gso_segment() was
> > made stackable by "ipv4: gso: make inet_gso_segment() stackable". GRE GSO
> > support predated that change, and IP-in-IP GSO/TSO support later made the
> > affected path reachable.
> > 
> > Track the number of IP GSO callbacks in skb_gso_cb and reject the 15th
> > callback entry. Thus 14 callback entries are allowed to complete;
> > GSO_RECURSION_LIMIT is the rejection threshold, not the number of
> > successful callbacks. Initialize the counter for each top-level GSO
> > operation and check it in both IPv4 and IPv6 handlers so mixed IP-in-IP
> > nesting is bounded.
> > 
> > Fixes: 3347c9602955 ("ipv4: gso: make inet_gso_segment() stackable")
> > Cc: stable@vger.kernel.org
> > Reported-by: Vega <vega@nebusec.ai>
> > Assisted-by: LLM
> > Co-developed-by: Luxing Yin <root@tr0jan.top>
> > Signed-off-by: Luxing Yin <root@tr0jan.top>
> > Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
> > ---
> >  include/net/gso.h      | 9 +++++++++
> >  net/core/gso.c         | 1 +
> >  net/ipv4/af_inet.c     | 3 +++
> >  net/ipv6/ip6_offload.c | 3 +++
> >  4 files changed, 16 insertions(+)
> > 
> > diff --git a/include/net/gso.h b/include/net/gso.h
> > index 29975440cad5..2665acbb9205 100644
> > --- a/include/net/gso.h
> > +++ b/include/net/gso.h
> > @@ -19,10 +19,19 @@ struct skb_gso_cb {
> >  	int	encap_level;
> >  	__wsum	csum;
> >  	__u16	csum_start;
> > +	/* Number of GSO callbacks this packet already went through. */
> > +	u8	recursion_counter;
> >  };
> >  #define SKB_GSO_CB_OFFSET	32
> >  #define SKB_GSO_CB(skb) ((struct skb_gso_cb *)((skb)->cb + SKB_GSO_CB_OFFSET))
> >  
> > +#define GSO_RECURSION_LIMIT	15	/* First callback depth to reject. */
> > +static inline int gso_recursion_inc_test(struct sk_buff *skb)  
> 
> What is 15 based on? Is that where in your test stack overflow occurs?
> 
> A realistic practical limit would likely already be smaller.
> 

What is the recursion limit on sparc64?
(The minimum stack frame is 176 bytes.)

It would be more sensible to check the 'amount of stack remaining' than
the number of levels of recursion.
Even though that is still asking 'how long is a piece of string'.

David
