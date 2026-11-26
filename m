Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795704268;
	b=mzY7qAS9FwqO4gKo5Vmp5t5DwvaJ3Z6/hk95UwSV9kIyWfsJ0BIJY1wooecgQsTW4iwD
	 qAo2v7oq/RNgPwry1gpz3ygtm4TOHHbWcYL7r2AlTUUPHtOycGqyaeiO2oLkm9KAqjJ5z
	 WMbYpgC4AYajdt4qanoJxeImOxlLnvllQ0ZhNhcNgFPymVLY7Odue01CdwDSbxZjEvQzN
	 kSQLpScoern2+vdtEQ10zyv1zf4RswFLlWXKEOty8XEgcUOzAySHJWoRykt44Xof5iS0n
	 FPbgif+EAn/cy5m+HpWxHhK5KwJCsTQpziAOg3hkZ8Kg91zsNYbQNYHzg+VJIP+U6+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795704268;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=/F03eUzlSZS3lGGItRD6xh+3pnGh0qbk1j8Zd949jzY=;
	b=txWnEJwk2LZdNYtLIIyIP/Rox8sWJtTIqfEWy8Y5+k7U0gu9CZMbs4sKm1wckDZHVkn2
	 iLYX0UX6vcAR7BTwXa5scNTZp4xPyuOP4+rOVs8o/qJivOpY3+GukI+aabXTsFabN6+Nu
	 dtmnomssDvymXfdDXHFbOa8hWgre48Ilbr5ExIBDU4ZpxzMeLR4MwCMph/aPoPo+45b53
	 kPF2jQltMcZof8B/WGkxhissiNcSCTIE3i7nUdPDMwT8q8N5UTtXyyqEt5l5C2Hhloy+D
	 +31xqTgD9Wyq23kRNfO1c8TgnUYzmNhYmv78Opm8pTCig56g+Cc2rhZSGBBEHUEWYKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dds1NovW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0B8606A31E;
	Thu, 26 Nov 2026 14:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dds1NovW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B27C1F000D4;
	Thu, 26 Nov 2026 14:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795704268;
	bh=/F03eUzlSZS3lGGItRD6xh+3pnGh0qbk1j8Zd949jzY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Dds1NovWaL+F3h5ErqE94Q4IEGbX9rOZO2Dse6iWjZccsYtCTsI4yE4Xw4g3nxUSq
	 As3x6YWAY/RbkBTL+WsVUPWvYR/ouJEDFWTJY0YgLzrZ7cO3il05uDapQMWXzGHG3p
	 AyBb7DssURFJhCcjVBFcSNdrgZ7Yr05KivIpmHGt8FudqeKidwLcleuE4whJNf/4NE
	 kKChoEYtGotRVKk6bqldkEXMOBl/Ybk4BJQnQTZCfpaxvMxpCyTZDbi4HiNJTrNF2r
	 qMXsylCKUYo8YgWdGlRb9dFtmW6bIUpS/yupfJtaRoeBJI3BXVZ78NBp8A7bBkbchQ
	 90PcYt/tBPEPg==
Message-ID: <832f42a7-1d44-4138-a7f5-7cead4a28e57@kernel.org>
Date: Thu, 26 Nov 2026 15:44:19 +0100
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
To: Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Kiryl Shutsemau <kas@kernel.org>, Song Liu <songliubraving@fb.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Rik van Riel <riel@surriel.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Pedro Falcato <pfalcato@suse.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 stable@vger.kernel.org
References: <20261118-skb_refcount_overflow-v1-0-5551b4954c3f@kernel.org>
 <20261118-skb_refcount_overflow-v1-4-5551b4954c3f@kernel.org>
 <14059088-7992-4d89-ac6c-1e6d1f61b3c8@redhat.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <14059088-7992-4d89-ac6c-1e6d1f61b3c8@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/26/26 15:18, Paolo Abeni wrote:
> On 11/18/26 09:32, David Hildenbrand (Arm) wrote:
>> @@ -3299,14 +3311,14 @@ int skb_splice_bits(struct sk_buff *skb, struct sock *sk, unsigned int offset,
>>   		.ops = &default_pipe_buf_ops,
>>   		.spd_release = sock_spd_release,
>>   	};
>> -	int ret = 0;
>> +	int ret;
>>   
>> -	__skb_splice_bits(skb, pipe, &offset, &tlen, &spd, sk);
>> +	ret = __skb_splice_bits(skb, pipe, &offset, &tlen, &spd, sk);
>>   
>>   	if (spd.nr_pages)
>> -		ret = splice_to_pipe(pipe, &spd);
>> -
>> -	return ret;
>> +		return splice_to_pipe(pipe, &spd);
>> +	/* Returning 0 would make callers report EOF. */
>> +	return ret < 0 ? ret : 0;
> 

Thanks for having a look.

> AFAICS the above introduces a change of behavior:
> caller with tlen==0 get 1 as return value, while they
> used to get EOF. I think the return code from
> `__skb_splice_bits` should be ignored, when not negative.

I think you are right.

> 
> I think the churn here could be reduced re-using the `len`
> ptr argument to store the error code; something alike the
> (completely untested) following:
> 
> ---
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 85d5caa08887..9fd5116f33f3 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -3177,6 +3177,10 @@ static bool spd_fill_page(struct splice_pipe_desc *spd, struct page *page,
>                  spd->partial[spd->nr_pages - 1].len += *len;
>                  return false;
>          }
> +       if (!try_get_page(page)) {
> +               *len = -EFAULT;
> +               return true;
> +       }
>          get_page(page);

Double get, easily fixed.

>          spd->pages[spd->nr_pages] = page;
>          spd->partial[spd->nr_pages].len = *len;
> @@ -3299,6 +3303,8 @@ int skb_splice_bits(struct sk_buff *skb, struct sock *sk, unsigned int offset,
>          int ret = 0;
> 
>          __skb_splice_bits(skb, pipe, &offset, &tlen, &spd, sk);
> +       if (tlen < 0)
> +               return tlen;
> 
>          if (spd.nr_pages)
>                  ret = splice_to_pipe(pipe, &spd);
> ---
> 
> which is arguably ugly but IMHO no more than the tristate
> return value in the current version.

That doesn't work. "len" you write in the function is not tlen ...

__splice_segment() passes &flen.

Further all these lengths are unsigned int, not signed :/

Also, I think we have to respect spd.nr_pages.

If we want it minimal, a separate error pointer might be the easiest way to fix it. Still
ugly, but I tried to get it clean above and there is no way around some churn I'm afraid.


diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index c937d74eed6ac..f471bea7fb26e 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3166,7 +3166,7 @@ static bool spd_can_coalesce(const struct splice_pipe_desc *spd,
  */
 static bool spd_fill_page(struct splice_pipe_desc *spd, struct page *page,
 			  unsigned int *len, unsigned int offset, bool linear,
-			  struct sock *sk)
+			  struct sock *sk, int *err)
 {
 	if (unlikely(spd->nr_pages == MAX_SKB_FRAGS))
 		return true;
@@ -3180,7 +3180,10 @@ static bool spd_fill_page(struct splice_pipe_desc *spd, struct page *page,
 		spd->partial[spd->nr_pages - 1].len += *len;
 		return false;
 	}
-	get_page(page);
+	if (!try_get_page(page)) {
+		*err = -EFAULT;
+		return true;
+	}
 	spd->pages[spd->nr_pages] = page;
 	spd->partial[spd->nr_pages].len = *len;
 	spd->partial[spd->nr_pages].offset = offset;
@@ -3193,7 +3196,7 @@ static bool __splice_segment(struct page *page, unsigned int poff,
 			     unsigned int plen, unsigned int *off,
 			     unsigned int *len,
 			     struct splice_pipe_desc *spd, bool linear,
-			     struct sock *sk)
+			     struct sock *sk, int *err)
 {
 	if (!*len)
 		return true;
@@ -3212,7 +3215,7 @@ static bool __splice_segment(struct page *page, unsigned int poff,
 	do {
 		unsigned int flen = min(*len, plen);
 
-		if (spd_fill_page(spd, page, &flen, poff, linear, sk))
+		if (spd_fill_page(spd, page, &flen, poff, linear, sk, err))
 			return true;
 		poff += flen;
 		plen -= flen;
@@ -3230,7 +3233,8 @@ static bool __splice_segment(struct page *page, unsigned int poff,
  */
 static bool __skb_splice_bits(struct sk_buff *skb, struct pipe_inode_info *pipe,
 			      unsigned int *offset, unsigned int *len,
-			      struct splice_pipe_desc *spd, struct sock *sk)
+			      struct splice_pipe_desc *spd, struct sock *sk,
+			      int *err)
 {
 	struct sk_buff *iter;
 	int seg;
@@ -3245,7 +3249,7 @@ static bool __skb_splice_bits(struct sk_buff *skb, struct pipe_inode_info *pipe,
 			     skb_headlen(skb),
 			     offset, len, spd,
 			     skb_head_is_locked(skb),
-			     sk))
+			     sk, err))
 		return true;
 
 	/*
@@ -3262,7 +3266,7 @@ static bool __skb_splice_bits(struct sk_buff *skb, struct pipe_inode_info *pipe,
 
 		if (__splice_segment(skb_frag_page(f),
 				     skb_frag_off(f), skb_frag_size(f),
-				     offset, len, spd, false, sk))
+				     offset, len, spd, false, sk, err))
 			return true;
 	}
 
@@ -3272,10 +3276,10 @@ static bool __skb_splice_bits(struct sk_buff *skb, struct pipe_inode_info *pipe,
 			continue;
 		}
 		/* __skb_splice_bits() only fails if the output has no room
-		 * left, so no point in going over the frag_list for the error
-		 * case.
+		 * left or on error, so no point in going over the frag_list
+		 * for the error case.
 		 */
-		if (__skb_splice_bits(iter, pipe, offset, len, spd, sk))
+		if (__skb_splice_bits(iter, pipe, offset, len, spd, sk, err))
 			return true;
 	}
 
@@ -3299,9 +3303,11 @@ int skb_splice_bits(struct sk_buff *skb, struct sock *sk, unsigned int offset,
 		.ops = &default_pipe_buf_ops,
 		.spd_release = sock_spd_release,
 	};
-	int ret = 0;
+	int ret = 0, err = 0;
 
-	__skb_splice_bits(skb, pipe, &offset, &tlen, &spd, sk);
+	__skb_splice_bits(skb, pipe, &offset, &tlen, &spd, sk, &err);
+	if (err && !spd.nr_pages)
+		return err;
 
 	if (spd.nr_pages)
 		ret = splice_to_pipe(pipe, &spd);
-- 
2.56.1

-- 
Cheers,

David
