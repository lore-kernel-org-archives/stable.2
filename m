Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795264878;
	b=5LnkQKVUhbgevic429qBFV/b+k3qD3jaMmRQPzhKqZ3JldHJ3elnSWl4NmjZQpQTvbmz
	 NC1AmfCWGk2+xUNCXktqiEMePja/4nlCBYTHa7Cfl13e94pKeYkqfxoVnCCSg88K6uJq6
	 7ldXI7UHgq05WTABhNayU2ICq9xuwg5Zde5bDMmixTXMaSESH67fOXx84Amk8UCw0MqOx
	 q2anUK0mrRmOqDjfC2iKQ+c6swWMx9l9T2HW9aAZA6oC+2hnplvXIOgW7oEiewo63zais
	 Wk/euIAbkucK1+pfv1gVUnLZH7kfzml7BRKfHw+hDfuSun1B5kGNdelWzY+Q/Og4k0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795264878;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=c164Hmbr735n5mNaKtM6iTMF9AUxTNwADbTKvfj5lqY=;
	b=eZSoOiP4Lw+6w5g7sJcc9qFSkSOZf9otp7DItJE9p3BK9Q3nAazNjvtEd61UM4SwoViu
	 hJwVcjVUquz5gxKSugSnEeXTcMCEPw5nqNnW7R2+ris+ekrYVG2tYvrjVA4yprbhtbUfX
	 um/xzE7UGVj2+gBhB2fIo0niVAt4bS43bceRExhDMtYLPBuIfz0FZCTOcqehUWnRYb6jC
	 pUUQ47pRVBnotrf+KgimdDzNl3fiOCodU+SIZ+zqeWKXl6evMoPR58+62c2dnviL3fms8
	 XkRNbuZNWROGJH3VFJ2JOjwNSFbJ/u5Dvs1PkoSG8+3tkXq0m0amaYSl3wmxwrjLBeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XETjTlsV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0265606A320
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 12:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XETjTlsV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B1C21F000C0;
	Sat, 21 Nov 2026 12:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795264878;
	bh=c164Hmbr735n5mNaKtM6iTMF9AUxTNwADbTKvfj5lqY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=XETjTlsVsLXlnYtr4HaCo3KD/0wwyfOgv9/6YcSrTwzLDDddus/bgbajmCX2JaDTc
	 yyzwzt6t1vd4pUsuCakjuppiVrAPh0L/91M5cV6jj+4L3XQ9BLNsW2smLRT696/tlq
	 Rqeymmat/niMyLDypJmXzFf4CBxe0bxWC3rC4Mzeagn6jB/lVhClGvgrp3G1Pb/J8e
	 1zmrUqtYwotOZgRPpZVrbPai9DeUdnooCp67T7s3OJ/ydEApHZZuyyV/cHLOuqvNgL
	 7Igd1A0tTnUEwfKF+biRNjqKrt/uDpBe0x6FzKq2mnb+JxQIVsjIliVKOI+NsGXakD
	 r0RtAbS8uPvzQ==
Message-ID: <bc42fbba-1c35-4d81-b28f-6b1324b34ebd@kernel.org>
Date: Sat, 21 Nov 2026 13:41:12 +0100
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
Subject: Re: [PATCH 2/2] [v3] mm/mempolicy: replace copy_nodes_to_user()
 interface with put_nodes()
To: Arnd Bergmann <arnd@kernel.org>, Gregory Price <gourry@gourry.net>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, larips <larips950@gmail.com>,
 stable@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org
References: <20261120185248.823415-1-arnd@kernel.org>
 <20261120185248.823415-2-arnd@kernel.org>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261120185248.823415-2-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/26 19:52, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The get_nodes() function handles copying node masks from userspace,
> while copy_nodes_to_user() copies the same masks to userspace, but
> with a different argument order and slightly different meaning of the
> same variables.
> 
> To make that less confusing, change copy_nodes_to_user() to look more
> like get_nodes(), using similar name and arguments as well as adjusting
> the maxnode value once, and restructure it for readability.

Could briefly mention here the change in get_nodes() for consistency.

> 
> Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  mm/mempolicy.c | 48 +++++++++++++++++++++++++++++-------------------
>  1 file changed, 29 insertions(+), 19 deletions(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index afe614efb77c..b240acaa8cf1 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1736,7 +1736,9 @@ static int get_bitmap(unsigned long *mask, const unsigned long __user *nmask,
>  static int get_nodes(nodemask_t *nodes, const unsigned long __user *nmask,
>  		     unsigned long maxnode)
>  {
> -	--maxnode;
> +        /* User space passes the number of bits plus 1. Fix that up. */
> +	maxnode -= 1;
> +
>  	nodes_clear(*nodes);
>  	if (maxnode == 0 || !nmask)
>  		return 0;
> @@ -1769,31 +1771,39 @@ static int get_nodes(nodemask_t *nodes, const unsigned long __user *nmask,
>  }
>  
>  /* Copy a kernel node mask to user space */
> -static int copy_nodes_to_user(unsigned long __user *mask, unsigned long maxnode,
> -			      nodemask_t *nodes)
> +static int put_nodes(unsigned long __user *mask, nodemask_t *nodes,
> +		     unsigned long maxnode)

Two tabs here here is the preferred way in MM. Can fix that up when applying.

>  {
> -	unsigned long copy = ALIGN(maxnode-1, BITS_PER_LONG) / 8;
> -	unsigned int nbytes = BITS_TO_LONGS(nr_node_ids) * sizeof(long);
> -	bool compat = in_compat_syscall();
> +	const bool compat = in_compat_syscall();
> +	const unsigned int word_bits = compat ? BITS_PER_COMPAT_LONG : BITS_PER_LONG;
> +	unsigned long bits, node_bits;
>  
> -	if (compat) {
> -		copy = ALIGN(maxnode-1, BITS_PER_COMPAT_LONG) / 8;
> -		nbytes = BITS_TO_COMPAT_LONGS(nr_node_ids) * sizeof(compat_long_t);
> -	}
> +	/* User space passes the number of bits plus 1. Fix that up. */
> +	maxnode -= 1;
>  
> -	if (copy > nbytes) {
> -		if (copy > PAGE_SIZE)
> -			return -EINVAL;
> -		if (clear_user((char __user *)mask + nbytes, copy - nbytes))
> +	/* Don't exceed what would fit into a single page. */
> +	if (maxnode > PAGE_SIZE * BITS_PER_BYTE)
> +		return -EINVAL;
> +
> +	/* Process full words, which depend on the user space ABI. */
> +	bits = ALIGN(maxnode, word_bits);
> +	node_bits = ALIGN(nr_node_ids, word_bits);
> +
> +	/* Clear anything we won't copy below. */
> +	if (bits > node_bits) {
> +		if (clear_user((char __user *)mask + node_bits / BITS_PER_BYTE,
> +			       (bits - node_bits) / BITS_PER_BYTE))
>  			return -EFAULT;
> -		copy = nbytes;
> +		bits = node_bits;
>  	}
>  
> +	/* Finally, copy the bitmap. */
>  	if (compat)
>  		return compat_put_bitmap((compat_ulong_t __user *)mask,
> -					 nodes_addr(*nodes), copy * 8);
> -
> -	return copy_to_user(mask, nodes_addr(*nodes), copy) ? -EFAULT : 0;
> +					 nodes_addr(*nodes), bits);
> +	if (copy_to_user(mask, nodes_addr(*nodes), bits / BITS_PER_BYTE))
> +		return -EFAULT;
> +	return 0;
>  }
>  
>  /* Basic parameter sanity check used by both mbind() and set_mempolicy() */
> @@ -2054,7 +2064,7 @@ static int kernel_get_mempolicy(int __user *policy,
>  		return -EFAULT;
>  
>  	if (nmask)
> -		err = copy_nodes_to_user(nmask, maxnode, &nodes);
> +		err = put_nodes(nmask, &nodes, maxnode);
>  
>  	return err;
>  }

Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>

-- 
Cheers,

David
