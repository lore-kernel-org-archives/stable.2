Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793908736;
	b=fp02tKnbfeQZn52UwLMEYLmkoMoM7DoNrL4R0Ub4Z8lkG0qlpbDfVD8SLl8wWNm8ZfBj
	 88sWY2/QvmAJjGU7Ril+CJeYA35QX9tJUXwAKFl6aB2ngrW4WkKL6686vdYGCJ0cGYjxx
	 R5NDWVC0tb8gyyKn2rk1lRDiUXFSUizMNdrUS1JrEWdWqPmzSkUInn8mZCYbnt3QCHujF
	 5LqE+aBH4u16ZZscej32hA8tAmg0v7OfE4lB+UTkxSdFfvIxDGK9O4Y9m3W9yIJyrQ0Gz
	 x+PLBGg5+evrkxsakEz9UeD52BdP6+BLAzJUeGglqpneyGYuT6haU/+UogI1RGU1DXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793908736;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type;
	bh=km0LURr6P7Lx8jR5JYqDxaUcl9rwTeeAgZu6u5Eug1Q=;
	b=kKi5Xv4+vKo92NQ8sn6XfxTT84t3ReOKlcz/Q3HXkk6lxy0cJ6tzkHmNJHJeHWBBypAA
	 Emlqo7gsHw7Cv4uCpT7NGHyAfm4gNFcadEDw1VH/ytXh+/xDYZcH3Bdam6rEfuVki8JW0
	 H1ET8Xee6dSjM3sTyBZCXBU2xGmMJRo7rLJF6G2FKbI9H58b/yVwdBUtGv7vFveS7BRsq
	 1vwZNHU2sCzUhgaP+PcpuncKv9cfmxgXfl2L/c8tIqdpNuS+CJbsFRrSKBQIP8vVECq/1
	 RMq631Sonu1BpdpUM7B+FrNljuZ7z2guTCoJ47HkcuV5hNDq617AYbSn07xXmK60B9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XJOymQ0m;
	arc=none smtp.remote-ip=209.85.128.182
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38047606A6C6
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 19:58:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38047606A6C6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XJOymQ0m
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8b118bea471so18599507b3.0
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 11:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793908735; x=1794513535; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=km0LURr6P7Lx8jR5JYqDxaUcl9rwTeeAgZu6u5Eug1Q=;
        b=XJOymQ0mMkimJZUfpxnT80Ebiw3Py5HmDR9gMq3ivMBkzb7SJprP9+OODYRr9ZOHYq
         1tAuts+PErrYncO0eFf8BndsV7TU14sV4tSZTp4LlnHtfdWXbSef7YsLrYOJ8K3TaI5i
         idfi5oT3uMtrLwHj9LoT9/k+sjBAk9CVrhnOT1eYrNXYkYyKDYOE1dF5HK0hQ9FrlFbk
         SBn/sXcLH4866345PRwk+baiJdmsfcUJDr5SpQQHb83F4ugcGHkpwypOsPUqyfyiT2ck
         JO/Gow3w0mtK0NgZp/cCBY3LKgy5RJO9mrYQrGwdKgNCevt/Hkg9RVtS0GLwzxnryhxe
         aECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793908735; x=1794513535;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=km0LURr6P7Lx8jR5JYqDxaUcl9rwTeeAgZu6u5Eug1Q=;
        b=DarLjdIKbyJUK8fQzUcFVUvPaxf/DV6UY7NFX33NbsuuT7l9Nyml6MAMBt2gJG9Yyi
         jaBWwEoas+8notJaeHc/pXq41unM2GvPW/J1CPzLJcyw4pajvOuGwbOk+zQVmHHnQFcG
         1W315OoColhaJG0KC9NivzaGpToKfw3dbNsqTeERFeaOu2IIH8vy+fDeSbYc+z5/ytcp
         K3wxJR2pKBDiH/ERBMDGyZwuVf0evRkXh8TuygYiIIMDQPwqKMoYclVfpirjl+M3GJdu
         kQ/WqATMjCHlS4b4HICJ4PHDibFi7aMKu2Nvq8ebKAkvlFsc1M8f9wrCEXzyu9EMl4ni
         mgdQ==
X-Forwarded-Encrypted: i=1; AL+hErHZpPcW7qwt4TR46wPvi2W/nW0h7sdAexmx7yy6ns+h1YbsvTFIFm4j9MpUvTTFnXSmZFK0HI4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9PVDxVYdMfw7jGaJh2lGilwVrS19ITV6Ro39DDFpg6BlNJz9j/
	32DXve2n+0+3qjkdu0XxwQEcOE7UHxHO917yfvNdXr8xfjTXOi11Oe0as/OIOMgClw==
X-Gm-Gg: AYBFou0FbINsoIrK4El6Bw/a7FM4BnU0ivzCpj++dUsnjwe+d60RlvlHyxYT2cw5cq4
	EKnOoBS98foLhGLzVsA177a/swzJ0WjY3zVdSG5/gSfTYkNmGxWN1gv5ZpMqOv7pXHZ2tB4ff14
	RRUbn6IfRw9HFH7gpaYskiwDbOdFfzXtM6GUFqgwm92BZKUFbtG6mefe23lStZxcqUyI8tZD4X6
	h4gzW378t+zZNBoFhD+gj5iV6y4EfX/T2nan+rspbxkIj3jTd1xyFFNt2FUY3Tf0hmtd0p3fUpb
	4OUJi//+v15jbFqo9GuWw/XPSVaEgaLEbQLA/uKOz08OrmynflGLT3dPQktQjzykYQN3Hok5IWu
	ROBNGfkZ58sLtKt4IVwcSdwkbkbaHB+QiFcbhqw6L0aTY9q5tBVGvU8nfEDAo2VTP0reMCL24qG
	dP4PfwOkSSMRRGRJEfqngIQFtij32xEvcLfewuCmEFSADlwcVkeMtjQnv1giDoXHrOGX0MLa5Wu
	05kHM1BXBIcCVbtF4JmCQtRD8i2UDPvJZ1pzQGxfrHrZYu+hnivHL7WYwSAadw7R7P67DmGgLPX
	4b4+b9JeEGWfOaiQOO/rTPFk+bO2doD7aLiZP/w/uxOL2KC0yZb/Tb35rYh5WxoVi7CB/OpGXjl
	KwCw8/J5e4a40sBtqeEU=
X-Received: by 2002:a05:690c:e1ce:10b0:8b0:acc6:8e5c with SMTP id 00721157ae682-8b3417dd26fmr509307b3.9.1793908734656;
        Thu, 05 Nov 2026 11:58:54 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b33f76dba8sm3113237b3.13.2026.11.05.11.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 11:58:54 -0800 (PST)
Date: Thu, 5 Nov 2026 11:58:41 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
cc: Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Hugh Dickins <hughd@google.com>, "Liam R. Howlett" <liam@infradead.org>, 
    Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
    Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
    Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
    Kiryl Shutsemau <kas@kernel.org>, Zach O'Keefe <zokeefe@google.com>, 
    linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
    Chris Mason <mason@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/khugepaged: don't map folios that are not uptodate
 in MADV_COLLAPSE
In-Reply-To: <20261105-set_huge_pmd_uptodate-v1-1-a78d8a1b7117@kernel.org>
Message-ID: <1f69d159-4a59-535a-c24f-a26188698862@google.com>
References: <20261105-set_huge_pmd_uptodate-v1-1-a78d8a1b7117@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 5 Nov 2026, David Hildenbrand (Arm) wrote:

> madvise(MADV_COLLAPSE) can map PMD-sized pagecache folios that are not
> uptodate. For example, shmem fallocate() can put such folios into the
> page cache.
> 
> collapse_file() already refuses to proceed with folios that are not
> uptodate. Let's just do the same in try_collapse_pte_mapped_thp() and skip
> such folios, leaving handling to the page faults.
> 
> Note that collapse_file() effectively clears shmem folios through
> shmem_get_folio(); let's keep this fix simple and simply let the page
> fault path deal with that.
> 
> Fixes: 34488399fa08 ("mm/madvise: add file and shmem support to MADV_COLLAPSE")
> Reported-by: Chris Mason <mason@kernel.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Hugh Dickins <hughd@google.com>

Valuable catch, thanks. I was worried that "try_collapse_pte_mapped_thp"
implies there's already a PTE mapping the non-uptodate folio, which
would already be wrong. But we've been a little too free with the
SCAN_PTE_MAPPED_HUGEPAGE result code, so there's no such implication
(and even if there had been a good PTE, I doubt there's enough locking
to stop racing fallocates putting a non-uptodate folio there meanwhile).

I was going to quibble with the Fixes, thinking the problem was there
earlier: but no, I agree with you, that's when install_pmd came in.

> ---
> Once reviewed, I will pick this up in a timely manner.
> ---
>  mm/khugepaged.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 8d9f05a39afb3..db135b3c44ef1 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1900,6 +1900,12 @@ static enum scan_result try_collapse_pte_mapped_thp(struct mm_struct *mm, unsign
>  		goto drop_folio;
>  	}
>  
> +	/* Leave any uninitialized folios to the page fault path. */
> +	if (!folio_test_uptodate(folio)) {
> +		result = SCAN_FAIL;
> +		goto drop_folio;
> +	}
> +
>  	result = find_pmd_or_thp_or_none(mm, haddr, &pmd);
>  	switch (result) {
>  	case SCAN_SUCCEED:
> 
> ---
> 
> base-commit: f44fd601f72e09e44c667b9234c9cd469856679c
> 
> change-id: 20261105-set_huge_pmd_uptodate-9b9820307f30
> 
> --
> 
> Cheers,
> 
> David
