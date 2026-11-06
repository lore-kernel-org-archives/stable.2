Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793959998;
	b=BmSJ7ydFXgwnfmRyBlauoEkcQguepE1wjLYj0CBjVDz5P7iR4NFfhy8eFhqPBR3oUcJQ
	 19t5A6VcLPWiWnLNzZo8Rxo+//iIvp/KOywb62YX1KiDBCnJUyYe/r6YKDw4XwiTN1GH7
	 Hzq1G+p59XlzVQkuei8BzqAPc4+6heWmWZB0/L/vsGfyIE6i+vhdl0eG40whoMm+anC/I
	 tj5opFUnkeHxdji0ZUujZr9issjABIkLA/bTx6mkwe859RhEA2HSMic3BuQ8nlL01KrgF
	 Hu88KRjd9+qcMKytyETgitAfe24XkH9FSnMoBrUWNQqKGVN2LmtGkNEwK5s6l/O70VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793959998;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=fLL3XmqFz5Pf3FaFIovTOe/0d0X3Y15DtdwfOU4Sa2o=;
	b=p1XcIQegfR6tq1GG3Shotw1VjqX5KJZTipUNDh4b6CZfPomRnPwUVwQo9m5wMeyM4UMf
	 MwO6/UL3+D48jjASSGhYQu22VHyXcTY0NR93bFPmYAV4O4ZMk8QeacW8iwS7aBcFK5hLo
	 8dn5dU26w/cZdHahyhzv1G34+V9Vo0XzOAPsCIbx9MfOXpjRqrd9FmC0JrfEGXR/uv3hL
	 6lx0ex4p/3eKjpAhzFSWZ70Scc3x5GCDm+sQRiD++D1kD/BmEfLxHCv0EXoOBG56fEocg
	 tRLNLlDeA/GdSpZBLHBHGDF8gShWscV2RYem33nt4roCB76dAEQ+Wz5a1MY9FKjnfCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lmi5Q0Fv;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4404B606A333
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 10:13:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4404B606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lmi5Q0Fv
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso4980525e9.1
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 02:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793959997; x=1794564797; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fLL3XmqFz5Pf3FaFIovTOe/0d0X3Y15DtdwfOU4Sa2o=;
        b=lmi5Q0Fv7T71Md66nuBX67PlvPoEFrAFoRKV1Sq9HgiIufOQpo6A5qA4voQ9XVsQnI
         Y5Hj/M5KiCFqmc99z/aMxLeWTTEEj7wwOi2WSlzSWmo/tAk3DTZOxVOHqmd3JGBbyX5p
         MjxD+nIIkXrtlDg79Rto+zQPgz6nVr2WPvpz2LPA0t+/5xqCmE79Ud+YVNwx95IDOpUY
         6gKHohlLzrUuTmWRolrPZjIckPQ9XVpyHmmteUBXc8zNdemlnEFZM9+mZVxPhBgRgSxd
         OK8xZxmBxgiJbDDXxSodZkJXJeAnpIIx2xVIJR2W/+gMaMI2CJhuiL6Zi46Q+a4Dwvd2
         pmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793959997; x=1794564797;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fLL3XmqFz5Pf3FaFIovTOe/0d0X3Y15DtdwfOU4Sa2o=;
        b=Vx0URB08KcN26KUxAzFUZ8EMJZ6z4gO3Z/lLx1ZCSTnJa+Ht38QaERFoPXAKymQarq
         160bcuCOfhPKVkfj0boOtpHMWNY1Z+iOtWrPtmgocDkymKuPPCXLOQbaWoEVJTEXTU3U
         XvDQ+F6I/e6imnalAJ/+K9KrpKRNjieRyOqvco8tshLnfzJRIgLMiTp8gAmp5M9W2Sxb
         yqeUVsqEu6eBnrOto1LIGzEacCHY7m+y2iLWDDekJuDCpMxU9iMge3Dv6pz2hYDucd6b
         gC2wXc6V30tZS9wg45izHqIiBKpwRcOkTrucfLIIKOR6tvCKAyTj7Ad9ASizSk+BkBlr
         jOpw==
X-Forwarded-Encrypted: i=1; AKwUvBzSTVYV0YayLMdzDnj+Sv+LMTClQZrhTmhlhLnKvwULpdRmAOPrB/+7hcb7IiDIR5MLNB4tDNg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/7uxQbOIopH0ESwZWUAGbmvLOmQ7HwcEbaZbllrVxB39pq9nmP
	mBwsCBN/efj6v9nsA0S3maoDwG+gkiFzXxnBJFcWnoJOxttlDoZy5L/X
X-Gm-Gg: AYBFou2lUGc/Nn+Uag163GwRPgnfEUhAFUeqJSfpkMYtVzC6hYLOLTftQKr2OJRQP31
	hAnGLwGOdQCKHK3epv1d1cJGq70qIyb5AJMZrq46tYF0I25W6GN3ZmU7FH3/kzxCygdFgn3PPcY
	hnXrSW+X00vBGlrMXGS6MM9kuOpidYbMzZU7SUcSkrcWbKfUrpBQ14GizxrE3Mao98TqD/aX8CR
	VrmpEpTkd8NGetfbh0SRKNVXFmYmw6IWQpePVYXEIg0LukZFDcu5wJo8ZnQO7oPQy512fk6ysJ7
	T/g7OP5prD9UsKE3gdZ2OozEsuFg6R8uLgbWwMR2jwt3Rj35ALhpHmdN4R3E2VQkZOZnzVKFV+p
	FjLONiYeWa5dycq3Btcw31O5RHmvJLf+7jYT8R2GV2ZWqU8m+zI4PWjwe53BCTpHkDeEFeZot0t
	KWpTYlWvaxrBVpgR7wAjT0E32pkqfrcW9Ywxu1+C4tv9+xeX9vH4f1czxD+zQwpwMPYQhJ6fRtW
	hFSU2puw3sNnmTe1DNJQPV1pnBp/xNRfVR1cM9f8tqGmLVTnBafdyY35XznFFhSxwF3TemVXBLv
	MfDT/Xw6paNAit8HK5jh/2U=
X-Received: by 2002:a05:600c:310f:b0:4b6:bb67:bb9 with SMTP id 5b1f17b1804b1-4b6ded4a3b0mr30188925e9.29.1793959996617;
        Fri, 06 Nov 2026 02:13:16 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b572bba207sm121341505e9.10.2026.11.06.02.13.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 02:13:16 -0800 (PST)
Message-ID: <4763a039-60f8-4263-8124-beb0f9ab3366@gmail.com>
Date: Fri, 6 Nov 2026 11:13:13 +0100
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
Subject: Re: [PATCH 5/5] mm/gup: limit pagecache folio refcount when grabbing
 references
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>,
 Gregory Price <gourry@gourry.net>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Song Liu <songliubraving@fb.com>, Rik van Riel <riel@surriel.com>,
 Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin
 <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
 Steve Sistare <steven.sistare@oracle.com>, John Hubbard <jhubbard@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
 iommu@lists.linux.dev, stable@vger.kernel.org
References: <20261105-refcount_overflow_stable-v1-0-70b9c655da3e@kernel.org>
 <20261105-refcount_overflow_stable-v1-5-70b9c655da3e@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261105-refcount_overflow_stable-v1-5-70b9c655da3e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/26 2:10 PM, David Hildenbrand (Arm) wrote:
> Let's replace our existing safety check by the new
> folio_ref_count_over_limit() check in fast and slow GUP before acquiring
> additional references or pins.
> 
> Keep it simple and use the check for all folio types.
> 
> Drop the WARN_ON_ONCE(), because apparently these things can currently
> happen with large pagecache folios.
> 
> Keep the zero-refcount rejection if the refcount is 0.
> 
> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  mm/gup.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 2ab42fc6834e5..db9db6b2a4662 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -77,7 +77,7 @@ static inline struct folio *try_get_folio(struct page *page, int refs)
>  
>  retry:
>  	folio = page_folio(page);
> -	if (WARN_ON_ONCE(folio_ref_count(folio) < 0))
> +	if (unlikely(folio_ref_count_over_limit(folio)))
>  		return NULL;
>  	if (unlikely(!folio_ref_try_add(folio, refs)))
>  		return NULL;
> @@ -140,7 +140,11 @@ static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
>  int __must_check try_grab_folio(struct folio *folio, int refs,
>  				unsigned int flags)
>  {
> -	if (WARN_ON_ONCE(folio_ref_count(folio) <= 0))
> +	if ((flags & (FOLL_GET | FOLL_PIN)) &&
> +	    unlikely(folio_ref_count_over_limit(folio)))
> +		return -ENOMEM;
> +
> +	if (WARN_ON_ONCE(!folio_ref_count(folio)))
>  		return -ENOMEM;
>  
>  	if (unlikely(!(flags & FOLL_PCI_P2PDMA) && folio_is_pci_p2pdma(folio)))
> @@ -1482,8 +1486,8 @@ static long __get_user_pages(struct mm_struct *mm,
>  				struct folio *folio = page_folio(page);
>  
>  				/*
> -				 * Since we already hold refcount on the
> -				 * large folio, this should never fail.
> +				 * Grabbing more references can fail once we
> +				 * hit folio refcount limits.
>  				 */
>  				if (try_grab_folio(folio, page_increm - 1,
>  						   gup_flags)) {

this can fail now, so shouldn't the error path below return -ENOMEM like
the first page does, instead of -EFAULT?

-- 
cheers,
jose a. p-a
