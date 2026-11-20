Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795208484;
	b=c6Rovpk+LSKC5J0QctEp0/FdIKcUHR4f7CASl/Pscl0+W8uvLICE8G5QzQSPPRdjoXRQ
	 9EPenCyDgxtbZrw4DRxGZTh++7884fa3E6pQyjagPKaGg26XPn/X/m1coXE0O9qoAQWnI
	 SLRgEjT8EOP3MKh5gtXKuMj9kLf8bFfH4VlWNss/RQxqSBLcXn/wfIwDMlN9bRrTckRW5
	 MGPhrC6oczVEdEqp9AeFTQeNjmptNoq0u1AbZI5QE1VcmJgz88Qa3RemEM9KBWe6yc6BP
	 tcjtijq4nsNLyH31DDc/FKJQetOUay6TzbdAVcvLAJdBkYOXAwmzkSu8o0JiMHyKHwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795208484;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=W5goPGg+WDIckAjo0y+m2U6zzWKb+HVqL7jjH8fkywk=;
	b=IEefMduVBO+8bsc517JdjEEGYnVCHpWaNAhOEiNONjVJocKE5z2s8wpNqzH8RL6Ym9ML
	 xC6xz9ijGY2lnywUGXGBo8uTOQ1AbLV2y3mbRjhSok+YutHDdCfWSP6xbazAqE7AhqR6G
	 qyad+ZqJdQ4terRl88NxaSG4Pk6CVnCKxuh8AlT1tUGCUeYR7MaKf7PI8pb0PhwXH6GhI
	 0Um9FCf19lxNoeDv202jNYh4BGR6zewbEFcdzp4LR2nrZZmKQUAAydzoQN9CzgTybeN6u
	 7vP225lyjw8g8C9S2NO+4ubLrJKbhWFnouee1AoRqDQrNNRt2XZoXW4exXv/FSIxn0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GOgX0mLj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF460606A690;
	Fri, 20 Nov 2026 21:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GOgX0mLj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42101F000C4;
	Fri, 20 Nov 2026 21:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795208484;
	bh=W5goPGg+WDIckAjo0y+m2U6zzWKb+HVqL7jjH8fkywk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GOgX0mLj54E9H90rvK6W0y+jRPmLdcrlX+0ZhEVqNgkd0nRgvqmtDHCmboKD9fpFK
	 s/iscvIH6Y58jhFrxmY/jxNyrvzylLSOCb8YrN2E/IsOq5SkSZ2WWaUgIY0FQ1O4RB
	 ls9tXQFhzJs1R1eZNmyqBPw3M34GcVN4XX/rZxy6vvMnCsuvrj8o7/4fyDV5iINLQi
	 iwQ4yjGIVGez1zjcalCy1kFe2KbPnmLfg+4Um8V6CB60etK5YIobQFugfSxU8P3nui
	 /q2Cxa/FzkK2EvXwkwjlSfQiME1H6qFbv4rEHsuQ7u36qeMwrU1xdfvhJ0owXLMSGq
	 RfDPieHKs6zxw==
Message-ID: <cd61f39f-db93-4f37-9836-7a81f7a82f9c@kernel.org>
Date: Fri, 20 Nov 2026 22:01:15 +0100
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
Subject: Re: [PATCH net 1/4] net: skbuff: limit folio refcount when copying
 skb frag references
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Kiryl Shutsemau <kas@kernel.org>,
 Song Liu <songliubraving@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Rik van Riel <riel@surriel.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Pedro Falcato <pfalcato@suse.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org
References: <20261118-skb_refcount_overflow-v1-0-5551b4954c3f@kernel.org>
 <20261118-skb_refcount_overflow-v1-1-5551b4954c3f@kernel.org>
 <awBy7PoxdEMEGWyW@devvm16445.scu0.facebook.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <awBy7PoxdEMEGWyW@devvm16445.scu0.facebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/26 17:21, Stanislav Fomichev wrote:
> On 11/18, David Hildenbrand (Arm) wrote:
>> Various networking features copy frag references of an skb, for example
>> when unsharing a cloned skb (AF_PACKET trimming a clone), when copying an
>> skb (nft dup) or when building NFQUEUE messages. This is an effective
>> way for multiplying folio references held by an skb, allowing for
>> exceeding folio refcount limits.
>>
>> This is not specific to large pagecache folios, but with them it is a
>> lot easier to reach the refcount limit, as page table mappings can cheaply
>> create many references.
>>
>> Let's introduce skb_frag_try_ref() and skb_frags_try_ref(), which use
>> try_get_page(), and use them in pskb_expand_head(), __pskb_copy_fclone(),
>> skb_zerocopy() and pskb_carve_inside_*(). All of these can already fail,
>> and their callers handle that.
>>
>> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
>> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
>> Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
>> Cc: stable@vger.kernel.org
>> Acked-by: Pedro Falcato <pfalcato@suse.de>
>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>> ---
>>  include/linux/skbuff_ref.h | 53 ++++++++++++++++++++++++++++++++++++++++++++++
>>  net/core/skbuff.c          | 35 +++++++++++++++++++-----------
>>  2 files changed, 76 insertions(+), 12 deletions(-)
>>
>> diff --git a/include/linux/skbuff_ref.h b/include/linux/skbuff_ref.h
>> index b6f6da556ee90..560ddc863bbec 100644
>> --- a/include/linux/skbuff_ref.h
>> +++ b/include/linux/skbuff_ref.h
>> @@ -44,6 +44,33 @@ static __always_inline void skb_frag_ref(struct sk_buff *skb, int f)
>>  		       skb->pp_recycle);
>>  }
>>  
>> +/**
>> + * skb_frag_try_ref - try to acquire a reference on a paged fragment of an skb
>> + * @skb: the buffer
>> + * @f: the fragment offset
>> + *
>> + * Like skb_frag_ref(), but acquires non-page_pool page references using
>> + * try_get_page(), refusing additional references to a page whose refcount is
>> + * at its limit.
>> + *
>> + * Return: True if a reference was acquired, otherwise false.
>> + */
>> +static __always_inline __must_check bool skb_frag_try_ref(struct sk_buff *skb,
>> +							  int f)
>> +{
>> +	netmem_ref netmem = skb_frag_netmem(&skb_shinfo(skb)->frags[f]);
>> +
>> +#ifdef CONFIG_PAGE_POOL
>> +	if (skb->pp_recycle && napi_pp_get_page(netmem))
>> +		return true;
>> +#endif
>> +	if (netmem_is_net_iov(netmem)) {
>> +		net_iov_inc_ref(netmem_to_net_iov(netmem));
>> +		return true;
>> +	}
>> +	return try_get_page(netmem_to_page(netmem));
>> +}
> 

Hi,

thanks for taking a look!

> I don't see you removing original skb_frag_ref implementations after
> the conversion, any specific reason? 

As explained in the cover letter, I want to get these fixes here upstream asap,
to backport them alongside the core fixes that already landed.

The focus is on the skb users that allow for multiplying folio references easily.

> Do we still have any skb_frag_ref
> callers left? 

Yes, after this series there are still some left. Primarily ones that are not
considered harmful for overflowing the refcount. And some of these require a bit
more work to convert, like skb_split().

> Maybe at least you can make skb_frag_ref do 'return
> (void)skb_frag_try_ref' to avoid duplicate code?

That would be bad: calling code would assume that it obtained a reference but it
actually didn't.

There is some headroom above the folio refcount limit to allow for such harmless
users that are not converted yet. The immediate problems are the users that
allow for unbounded folio references.

> 
> (optional) Also, an easier way to migrate might be to make the existing
> skb_frag_ref return bool, convert everything, and then add __must_check.

That would require teaching all callers about handling errors in one go, because
callers would otherwise silently ignore failures. That's nothing we can
backport, really.

I agree that as a follow-up, all code should be converted to use a single
function that can fail.

But that's nothing for this series that focuses on fixing folio refcounts in a
way that can be backported.

Thanks!

-- 
Cheers,

David
