Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.201
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795191673;
	b=WVyW7XNlfBWetQ+35XQ6xuMRSGS81lBu1To2Fi1LvKt8/2khNZZ3bDIo9/zmmqr5XgP5
	 1zqRzUyB9DeIS3U1q32o1dyn9ICk1Eg6ec9gGrfiKrXM3GHUukZnjn5PwmcGhsoqu/BAu
	 u01bjE8qN0M3lmla3JhgW9JDTcl8Dh8pUwlf2xYgSSfz9TuY7XUsMjpgqTa03vaBRTxge
	 5TrEDNnE2pld4zPBG+UEgvzPT9vB8z6fRPIMMWrP+v4N4DMomeOK4zG995Zjhb0TJWDE7
	 JxX/G48ibO7IHYVDN3TdxoaESv8+MfTkYbXOWw1Kc1eSGkObTNzLA8JXFtWuJIqcfOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795191673;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=DlHp18CPjbRy2dBjwYmV0o13g/8Est+vNGExs52wGVI=;
	b=Fr7b0uqwZxtDgmXc06xFTXwpqjYNcx5NurOP5+nmBQ+LxqmFv9tQUxzprBnzT/9ic/bN
	 0bIDqXmrNCkBg0bThCJSc+el0aj6ZkEwLkNJapx9X/AJqnkJyXeB59bWXBVMFBNf3qyp9
	 Sn5PHjGvrkdX0A0oju5tWDTo8vkFfbxpPIFbV/pV0lbF4sPB6ot9dVSdH3Gm23xmSJk3R
	 xxx4mC6SEgskMZiu7uA4gWuyfwZLq7moBopmU7XRhOy6riyu7kG4FSOi5vcGF1oHbgxrQ
	 w7RSVM8UHQMsYdumC2wBeWR1ajFn/uZRn7XfSO1mZQ8ZvmhoXBi/IGOyjVI5Z01iIbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QFIMvXBw;
	arc=none smtp.remote-ip=74.125.227.201
Received: from mail-pi2-f9.google.com (mail-pi2-f9.google.com [74.125.227.201])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC590606A32C
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 16:21:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC590606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QFIMvXBw
Received: by mail-pi2-f9.google.com with SMTP id 41be03b00d2f7-cdd9779aac8so181901a12.0
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 08:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795191672; x=1795796472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DlHp18CPjbRy2dBjwYmV0o13g/8Est+vNGExs52wGVI=;
        b=QFIMvXBwT5UZma+RH3dkZsdOYQvdRV5lMg2aPbcMemqkf8Dupdo41EKmwIjAfGV4QA
         Rp/STC14Fr5kxpZn+8zkLj31m1bjMjxlpVWu5+0//Z8eCJbmEBx3iIRpFCCMESlrrf9Q
         74BR4tGYR7QwgQcBkHvI2flO0QSGZaaSskVdakj/+23kYau/j0GxnIcVBm3nNd5igetR
         HGiHwoG0tUTt/5hlWBXpo2Q8eAbrCY5t5yCGNINLQ0L+yQv+Ww8SSN4ZSQZtyT1IqnWr
         gdzRJT0GAx4L7UAT6H4ozbogf5xYExqjbow2iVzPZ+99dtMfu3s32l3yKwAv/yQqsHNG
         Cuqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795191672; x=1795796472;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DlHp18CPjbRy2dBjwYmV0o13g/8Est+vNGExs52wGVI=;
        b=oXF0CwxubMZpPiENQyl7EKZukkgWPkRbU1gpDukXe0aAutQ9V8qx9crvzrSXt/kDDz
         lJ20VNBNrGvSgEmvLdhSQkbQZtT3mpufMV5/ZqjY2P6LFjFhQIWCk7SdXnDZfb6V3uut
         HnHjc8oKK2E/A8NcTXGT310TD4gA8JgELi6s4ndZViu95dvKMVEOQVIGuYHBTmPwtC76
         0dPdaUmW9ULJyWGy8Jljb54J9L2aLqY2NQP80CSDvzB7Y7zBcvEvfDjH+OnpgM/3wSbV
         lsLlFUSwk36kT2BLhJBZYVMMv6iYFAvz7MTmQT0J+jBaF9q6mNIDMe3gNLVxUKQXW6U4
         RIog==
X-Forwarded-Encrypted: i=1; AL+hErEF+1mlT6GUfjaD8HmK4tsx03OCx1TTjRTQ1I19KMtqb1bQUAgOtoA9yzlNCLj7yw4HRU0pWyA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Dud5vP/8oTq12GMk8iIFVKn8pMueqRomVPvxzPb9z2Igg0DNF
	6fyVd0ludPQ+MhlAGcSXI8xnSmgikW2dlFqbtUwAf4VVfNrQRijzlyLR
X-Gm-Gg: AZFdTZeo5lOsh9LoWtJis8J66R1C8uPJ8DVlFornQR8GLH+s1wG+vcNMcBwdMe/AMbM
	eJbEQCibsFPhEJj/eUgNoYUFs6xJs+hKfres2w0LdETLMWwenEVgSwKhZuTkyzw3BkhOgyu2pVx
	ZQI5ks56G9Uc39Ytw5jYUt1EI5j8Ic9o3wh9b4fk9duwv5hvbsjqjw7iRJsCYgEqsrnzr9TVAjP
	RgLGprFxIIKurRJm4yBkhCn1ncZa9CGjHi2LgnmFDh/oxPOguwsGwYSzLdLo0xH59fZAtPAKLgg
	qDjk8/LNudbE2hVXQTbWjHNR1N/UgX8jVJZdcSNOT1p97g0pIhF8VlvT33udmrEROEwssRIPxQL
	/A3LJPxPGWh3mVwREpfOrj9IgI4A5UlPdNur3OHu65NzSfHa6dpe5b6H0Yk0uq+0WY4HwvLxv6C
	QLAWAAzXF7E5GbS0/IjAVtcl8vnVaF451J/aA5ayR3QJSKX/4nMCmwMbNs/nq3ky8JlcnhEWb+M
	H5IvojRVFt70FdTIPNHK9VkjjFrYy2J9lawq2BpCkzemKW0Vm+5ft1HiMjylUw+zr+gKCtgMJS6
	kNCYlC9LMPVftJ+TdVKmdjo=
X-Received: by 2002:a05:6a00:1c97:b0:8b5:7fc8:866f with SMTP id d2e1a72fcca58-8c87d32b004mr3231608b3a.44.1795191671804;
        Fri, 20 Nov 2026 08:21:11 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:60::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c872e45e32sm1696071b3a.24.2026.11.20.08.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 08:21:11 -0800 (PST)
Date: Fri, 20 Nov 2026 08:21:05 -0800
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Kiryl Shutsemau <kas@kernel.org>, 
	Song Liu <songliubraving@fb.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Rik van Riel <riel@surriel.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [PATCH net 1/4] net: skbuff: limit folio refcount when copying
 skb frag references
Message-ID: <awBy7PoxdEMEGWyW@devvm16445.scu0.facebook.com>
References: <20261118-skb_refcount_overflow-v1-0-5551b4954c3f@kernel.org>
 <20261118-skb_refcount_overflow-v1-1-5551b4954c3f@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261118-skb_refcount_overflow-v1-1-5551b4954c3f@kernel.org>

On 11/18, David Hildenbrand (Arm) wrote:
> Various networking features copy frag references of an skb, for example
> when unsharing a cloned skb (AF_PACKET trimming a clone), when copying an
> skb (nft dup) or when building NFQUEUE messages. This is an effective
> way for multiplying folio references held by an skb, allowing for
> exceeding folio refcount limits.
> 
> This is not specific to large pagecache folios, but with them it is a
> lot easier to reach the refcount limit, as page table mappings can cheaply
> create many references.
> 
> Let's introduce skb_frag_try_ref() and skb_frags_try_ref(), which use
> try_get_page(), and use them in pskb_expand_head(), __pskb_copy_fclone(),
> skb_zerocopy() and pskb_carve_inside_*(). All of these can already fail,
> and their callers handle that.
> 
> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
> Cc: stable@vger.kernel.org
> Acked-by: Pedro Falcato <pfalcato@suse.de>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  include/linux/skbuff_ref.h | 53 ++++++++++++++++++++++++++++++++++++++++++++++
>  net/core/skbuff.c          | 35 +++++++++++++++++++-----------
>  2 files changed, 76 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/skbuff_ref.h b/include/linux/skbuff_ref.h
> index b6f6da556ee90..560ddc863bbec 100644
> --- a/include/linux/skbuff_ref.h
> +++ b/include/linux/skbuff_ref.h
> @@ -44,6 +44,33 @@ static __always_inline void skb_frag_ref(struct sk_buff *skb, int f)
>  		       skb->pp_recycle);
>  }
>  
> +/**
> + * skb_frag_try_ref - try to acquire a reference on a paged fragment of an skb
> + * @skb: the buffer
> + * @f: the fragment offset
> + *
> + * Like skb_frag_ref(), but acquires non-page_pool page references using
> + * try_get_page(), refusing additional references to a page whose refcount is
> + * at its limit.
> + *
> + * Return: True if a reference was acquired, otherwise false.
> + */
> +static __always_inline __must_check bool skb_frag_try_ref(struct sk_buff *skb,
> +							  int f)
> +{
> +	netmem_ref netmem = skb_frag_netmem(&skb_shinfo(skb)->frags[f]);
> +
> +#ifdef CONFIG_PAGE_POOL
> +	if (skb->pp_recycle && napi_pp_get_page(netmem))
> +		return true;
> +#endif
> +	if (netmem_is_net_iov(netmem)) {
> +		net_iov_inc_ref(netmem_to_net_iov(netmem));
> +		return true;
> +	}
> +	return try_get_page(netmem_to_page(netmem));
> +}

I don't see you removing original skb_frag_ref implementations after
the conversion, any specific reason? Do we still have any skb_frag_ref
callers left? Maybe at least you can make skb_frag_ref do 'return
(void)skb_frag_try_ref' to avoid duplicate code?

(optional) Also, an easier way to migrate might be to make the existing
skb_frag_ref return bool, convert everything, and then add __must_check.
