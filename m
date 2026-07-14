Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FB9417BFE
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 17:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784050959; cv=none; b=cuWmUs0JhUpmVQv6XStOl1N5XhRlBNY2V+i+jSFZrQ20PeAJxISp7/cJNcyz/7C/XV1rYks6ZCCwpVoOuZBX0sS6/KRpCaX2Ow63ebi1faW0su4aDMYtk5Mss5Q/HFftcd/rUFXWBrkfqng0Fwt/6mCSpv9xn43boDSGOwPMz9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784050959; c=relaxed/simple;
	bh=KA7yxA87EpUa70BsOJGm3jGECo/kO/v5dEvRZOSkHJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XOVzSK18rZVBCIqAAxQMHXJfmDwY0dcThRuWUic5BHnfmBk4ELsZegqtu8Iu6TaEpFe75KBewiPrxLh3ZqhCAONRPOKyZn+z8OGRU3aGV7deKyeqpKZIaCgSCgh19sb5lccWgE8b6jNK3gFX76urQZtmqqYVhinVMqSMJMtloxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BjCGqZ9j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BjCGqZ9j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784050948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0XneA0CYM00BRNRTb4B9DVpDpuR42nW+B7bPBHZY/xY=;
	b=BjCGqZ9j9poFa/STKDDLcclY7VvpgjDsEQbK/QaLxjOjxtq1kImMAz5agygwx6lhjyhxVg
	GYaYGBEzYzJLymuATXTGohg1qaUwJGcNcwqsMEGSm+KGwN7+OEIedWEdum6/n1ev3TKOaR
	4zhZtjrEAoCqg/sDDQpuggpxTS7cWbQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-uuGR4G2DNMuxPlmcgrn2Dw-1; Tue, 14 Jul 2026 13:41:18 -0400
X-MC-Unique: uuGR4G2DNMuxPlmcgrn2Dw-1
X-Mimecast-MFC-AGG-ID: uuGR4G2DNMuxPlmcgrn2Dw_1784050878
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8ec45d9628aso23416916d6.1
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 10:41:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784050878; x=1784655678;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0XneA0CYM00BRNRTb4B9DVpDpuR42nW+B7bPBHZY/xY=;
        b=LkzSLQJobfJhcVgUnNGIljP5BbWwcTRUlKar5UYD4KGqZfDsQrBu3814+jzr6FMWFJ
         x6ZGuyUU6nA6otezUHRtuoR2kpM2lLyJDP1z0aVV4VvYg1X/cKpA77Ew/6cxUNoQpqN9
         jF0ZfSSX0oj+OhMK08pnlxUFCIY7ruUMku/QWKhH+1D1+PVzSFZUKU9Dfqz34mzjUO0J
         YaaprunClRQnohSdavJnlDNlvsehkxyaoCP/M8LqYDOwlPTq1YWzmzP66ss1XpIfEJ0U
         XfZiHOOVGiJ6zvM8UngECqWm624rnR5gIxZbEsKYRY99W398iF53kbcxgNO7Mc5b2tAo
         eJLA==
X-Forwarded-Encrypted: i=1; AHgh+Rpp4ZpUZ+HQ2VZjX6jtV2qeVYscIfDbhBHYnYh3ZxtUAnw1ZP5RAz/0bPo2ojmiqWFnQ06I1LA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv2eKmUPabD1TFTlHwmPIgVeaUJ2aDOoc5lpvxhTWVS6Q/tSLB
	PUk3xpdgE3TkB5k6hYUE6wUsibtnf8jpEAyc6smBDo4knBKkATcSL8dT1gJ0yKmIcwQ+Qk0zgNT
	NvIRrONNP0GwygoVXSem8a9HM/xtBKG2IX068olDwmtno2L8RfEmjlZbs6Q==
X-Gm-Gg: AfdE7ckW/KZfSx15rvZHLZH0haw65otyJLozh9irnXSQz/R7/kCcR6qeojO9DHAzgUE
	Wbeud5DjB88xXOyyuZHiHAwhTikb5/ZlS5U5sl/hCr6SAzt4nvLxV8/MRfwSdgQeLOmBICcgU6o
	2nkV0XIPcmCYJx+wY9yfHv82E78/AWy+ewVXG/73RsG53j3iooRjeahWBnuDpBjQytF7HldxRDz
	Ovt+E9rSrRq5EXXHqBkh1ehOhOQqF0huYe6fTYkExiPKZFWIuHp5UtzA+Ienwp90c4dm39JeF5A
	TAPX1hqoH9DfM3CW6hwl05336Wcezb8BiT9C87GChY7XgqLwqiPbqAdYHItZ+sWtJtZnuby+p8F
	iDkyBb2PccZVwT2vpvqxUSjfbFrUn8Odfrsqe9U5e+U9vC+opmih5mdFabrvGx7eFWvY49T0Y
X-Received: by 2002:a05:6214:130b:b0:8ea:efae:ab26 with SMTP id 6a1803df08f44-903fdd64832mr161430616d6.0.1784050877663;
        Tue, 14 Jul 2026 10:41:17 -0700 (PDT)
X-Received: by 2002:a05:6214:130b:b0:8ea:efae:ab26 with SMTP id 6a1803df08f44-903fdd64832mr161430346d6.0.1784050877267;
        Tue, 14 Jul 2026 10:41:17 -0700 (PDT)
Received: from [192.168.2.110] (bras-base-aylmpq0104w-grc-61-70-49-81-60.dsl.bell.ca. [70.49.81.60])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd7c1fd2bsm175197236d6.27.2026.07.14.10.41.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 10:41:16 -0700 (PDT)
Message-ID: <690257d2-2126-4a8e-86de-b0882e282431@redhat.com>
Date: Tue, 14 Jul 2026 13:41:16 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/util: don't read __page_2 for order-1 folios in
 snapshot_page()
To: Aboorva Devarajan <aboorvad@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, "Liam R . Howlett"
 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Sourabh Jain <sourabhjain@linux.ibm.com>,
 Ritesh Harjani <ritesh.list@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260708201954.686111-1-aboorvad@linux.ibm.com>
Content-Language: en-US, en-CA
From: Luiz Capitulino <luizcap@redhat.com>
In-Reply-To: <20260708201954.686111-1-aboorvad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-07-08 16:19, Aboorva Devarajan wrote:
> snapshot_page() currently reads __page_2 after checking nr_pages > 1,
> but it should only do so when nr_pages > 2.
> 
> During DLPAR memory remove on a 22 TB ppc64le LPAR, snapshot_page()
> oopsed on the page isolation path while reading an order-1 folio's
> __page_2 from an adjacent absent section (unmapped vmemmap).
> 
> Fix this to avoid reading memmap that doesn't exist (e.g., a vmemmap
> hole).

Reviewed-by: Luiz Capitulino <luizcap@redhat.com>

> 
> Fixes: 31a31da8a618 ("mm: move _pincount in folio to page[2] on 32bit")
> Cc: stable@vger.kernel.org # v6.15+
> Reported-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> ---
> v1 -> v2:
>   - Condense the commit message.
>   - Drop the code comment.
> 
>   mm/util.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/util.c b/mm/util.c
> index af2c2103f0d95..34cb43b3eaa4c 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -1353,7 +1353,7 @@ void snapshot_page(struct page_snapshot *ps, const struct page *page)
>   	if (ps->idx < MAX_FOLIO_NR_PAGES) {
>   		memcpy(&ps->folio_snapshot, foliop, 2 * sizeof(struct page));
>   		nr_pages = folio_nr_pages(&ps->folio_snapshot);
> -		if (nr_pages > 1)
> +		if (nr_pages > 2)
>   			memcpy(&ps->folio_snapshot.__page_2, &foliop->__page_2,
>   			       sizeof(struct page));
>   		set_ps_flags(ps, foliop, page);

