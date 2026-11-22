Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795352963;
	b=syHnZQdLgU7lvvWt6FGUuG6WR4XJWGjxPBeGoO7aIFiXJ0UjQgfnj919a/zm3A9E20ZY
	 28yQjTYsS112IVmGwYdG5uZ1sKkmHZsbDMqgKNipiIbe1RzGIBodYFClVAYo4mwCVIR75
	 m78Imd2ihNp0Lkr+L6xtr3wFHIadWjLiSt84eaKSWbrqbVdnIgnG7tiScJ9iD+LYg+dMR
	 ERvo3x6ej2FxW6hdDagpSijOW7+oJCnzmViqXcJggOTTINRgO8PFb5J0uheBMgo37Rkus
	 mBOGfRZ72jrHGK9EXVRVXOJME9V0C2Tw8N64XNYm5TYhabOJo0TGidEAhZIy5pe7IcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795352963;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=sZ1PDNEi5E6ogIgtuYs0TfJyc0Jc2h1FjIxlhYKU2LE=;
	b=n29xMHZNKu8rmZVI8ah90MnuJ4uYOo9jkRK/+djtgK5keeKDk8k+U7CF+mNgC3ytdSpC
	 B8i9sj6ZFD6z+lZVe+o2fqILbBK8JBdrd8Go+TaaD3JExMEYqYwP8kXOIiEnPYqafmFyD
	 75PTxyK/9l6uc15awHwW/C7lw4TRqVi0CUAhp2ee2KS8HKMLlDjFkgWg/0I8k0qiUzM9E
	 aLf4j1pHNb44/PKpYQmEkAnBsoX1dYWSj9/MnsqU68N+L2P4oXqlrMTdV6L5xq1n3kuI4
	 EGttDo3fA+Uy0KlT834Sq1Ca/aSizkZcyVX4j2tqSIij5Ffy7ZKYTGL/O71mmR/Z/OQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mgmnpsdm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF05606A320;
	Sun, 22 Nov 2026 13:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mgmnpsdm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2BA1F000C6;
	Sun, 22 Nov 2026 13:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795352962;
	bh=sZ1PDNEi5E6ogIgtuYs0TfJyc0Jc2h1FjIxlhYKU2LE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=MgmnpsdmpI8dKngcWDxf/i1/dekLkMZ2De7V0Wp7NwOxb/sVkZ4OePmkHiIELKEpa
	 cPWS0rtaesk1AabINYYcc3VIlO51S2kqO54ck4doH7CSVnMIpuHqfD+ZhOXSyTLcqx
	 Dq9/tVrWNsDJ3Gmgc/f2MHEZwusB+3StI9cV7w8DzC2j7Af6p8bmrq+qrCe15LlHXs
	 AQu3EG1WdODB6xNa2+hS5GtW7fM3B1YPLPEjGWhB+CKUXmhIq66pqZXFnZ/kvsk9r9
	 aYN8A/RQV9FtwKYp4ncaePyxAcmO5nsoUoaPlQIwvN2y6VWpQVTIGAiJWXDpvWW+xX
	 2lZIBaHD+02gA==
Message-ID: <aa3821a5-6459-4845-8255-00a26bf243d3@kernel.org>
Date: Sun, 22 Nov 2026 14:09:15 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 4/4] net: skbuff: limit folio refcount when splicing
 from sockets
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, akpm@linux-foundation.org,
 kas@kernel.org, songliubraving@fb.com, hannes@cmpxchg.org, riel@surriel.com,
 willy@infradead.org, ncardwell@google.com, kuniyu@google.com,
 pfalcato@suse.de, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, stable@vger.kernel.org
References: <20261118-skb_refcount_overflow-v1-4-5551b4954c3f@kernel.org>
 <179533918041.3135.8460911693239501161@kernel.org>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <179533918041.3135.8460911693239501161@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/22/26 10:19, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in case
> you want to address the nit picks below when you respin.
> 
> Low priority / nit picks for your consideration:
> 
> - [Low] The new comment above skb_splice_bits()
>   (net/core/skbuff.c:3295-3300) says the function "Returns the number of…
> 
> Pre-existing issues:
> - [Medium] skb_splice_bits() still returns 0, which callers report as
>   EOF, when nothing was spliced because linear_to_page() failed to…
> 
> --
> 
> net: skbuff: limit folio refcount when splicing from sockets
> 
> This patch uses try_get_page() in spd_fill_page() so that splicing from
> sockets into pipes cannot push a folio refcount past its limit. On
> failure it returns -EFAULT, and the error is propagated as an int
> through __splice_segment() and __skb_splice_bits(). skb_splice_bits()
> returns the error when nothing was spliced, so the callers don't report
> EOF.
> 
>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
>> index c937d74eed6ac..b73fef7a1b460 100644
>> --- a/net/core/skbuff.c
>> +++ b/net/core/skbuff.c
> 
> [ ... ]
> 
>> @@ -3284,7 +3294,9 @@ static bool __skb_splice_bits(struct sk_buff *skb, struct pipe_inode_info *pipe,
>>  
>>  /*
>>   * Map data from the skb to a pipe. Should handle both the linear part,
>> - * the fragments, and the frag list.
>> + * the fragments, and the frag list. Returns the number of bytes spliced,
>> + * or an error if we could not splice anything because we could not take
>> + * a page reference.
>>   */
> 
> [Severity: Low]
> This isn't a bug, but is this return description complete?
> 
> When spd.nr_pages is non-zero, skb_splice_bits() returns whatever
> splice_to_pipe() returns. splice_to_pipe() in fs/splice.c can fail for
> reasons that have nothing to do with page references:
> 
> 	if (unlikely(!pipe->readers)) {
> 		send_sig(SIGPIPE, current, 0);
> 		ret = -EPIPE;
> 		goto out;
> 	}
> 	...
> 	if (!ret)
> 		ret = -EAGAIN;
> 
> The reverse case also exists. If linear_to_page() fails in
> spd_fill_page(), nothing gets spliced, yet skb_splice_bits() returns 0
> and not an error.
> 
> Could the comment also mention the -EPIPE and -EAGAIN cases that come
> from splice_to_pipe()?

I guess we can just make it simpler by saying

"... or an error if splicing failed."

I assume that could be fixed up when applying.

> 
>>  int skb_splice_bits(struct sk_buff *skb, struct sock *sk, unsigned int offset,
>>  		    struct pipe_inode_info *pipe, unsigned int tlen,
>> @@ -3299,14 +3311,14 @@ int skb_splice_bits(struct sk_buff *skb, struct sock *sk, unsigned int offset,
>>  		.ops = &default_pipe_buf_ops,
>>  		.spd_release = sock_spd_release,
>>  	};
>> -	int ret = 0;
>> +	int ret;
>>  
>> -	__skb_splice_bits(skb, pipe, &offset, &tlen, &spd, sk);
>> +	ret = __skb_splice_bits(skb, pipe, &offset, &tlen, &spd, sk);
>>  
>>  	if (spd.nr_pages)
>> -		ret = splice_to_pipe(pipe, &spd);
>> -
>> -	return ret;
>> +		return splice_to_pipe(pipe, &spd);
>> +	/* Returning 0 would make callers report EOF. */
>> +	return ret < 0 ? ret : 0;
> 
> [Severity: Medium]
> This is a pre-existing issue, not one introduced by this patch. Can the
> spurious EOF that this new comment describes still happen when
> linear_to_page() fails?

Sounds like something for net people to investigate.

-- 
Cheers,

David
