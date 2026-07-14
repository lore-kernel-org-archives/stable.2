Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A23D31ED8B
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 17:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784051826; cv=none; b=RjsbT6Urb2Yy8EUS/KAirbJDofqwV0zbnpuy9dAiwbMg6PJth1XffUYDAAGlH2xsKjwUdQaiZwtpK7AfBwT5g1nwdEwA+VcKnQbyHRxyrRVtPtEjcVo4y07Jrh8S5H9UEOkM/XeoUsf2hwy3Ha0L1GYzDEhZWg/MDk0zE7eaIbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784051826; c=relaxed/simple;
	bh=AW+Bkvp260zd7mo7rwqrkG/oEXgcvCKkOpFoWmG90R4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lKt2hUUZ0awx2mPGgYqVGytWuuZNQJhgLKiWshYdhC0LWQKmMJ8mlID483LdiPDNU5YpaGiMZj11ZDBmd2fHLHdxGK/IE00GkWWxwNlgxHYezzdJcb/ahHuTLk5zw2FoHcxvS2FHymYeqCbdk/Lq/qLq0lTUtj3QQ3tfp8OxDCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RGNymDXj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RGNymDXj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784051824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GiPZIKgYVUVSiAjyu5+zq1YI0UjtcnYBb3hfexOE/0Q=;
	b=RGNymDXjNibn88nVst1RgZVtqLntMIzS2JeCfo1wvXbL9ZhuAruIPHq+UDGuuu5jMhBwQP
	/rRdlReJPwxQQnSAL6Fm9SQmM1Ctj62R6oyGZuvogpMfjJIBLNlWXmuUCUXfMBXaXNYPdW
	QlH5vN8Sgq6y5yPFOa1lp7VTCsjEQ9w=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-JLcGMj4wOKic2aLjatRYpQ-1; Tue, 14 Jul 2026 13:57:03 -0400
X-MC-Unique: JLcGMj4wOKic2aLjatRYpQ-1
X-Mimecast-MFC-AGG-ID: JLcGMj4wOKic2aLjatRYpQ_1784051823
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8ee2847cbd4so67235236d6.3
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 10:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784051823; x=1784656623;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GiPZIKgYVUVSiAjyu5+zq1YI0UjtcnYBb3hfexOE/0Q=;
        b=NBauyDVX2giv9thhuadKAiHNCzivarnP95m/0LmVKgvZDfgBX5c6/Uey6vVi+YKFfS
         P+Ll39s/h6XixHp+WQbMKqO6/CHGEKBp3nWzniwUdr0MFM3DjGvrMnMwBSw+Ees9tpJl
         L24WsLEtTPWW0wTKFX3o7vALMptKR/GoioRwrRiYiy8WaGnCQfnA5ZSH7trKCo3W9T8S
         5qgVpf4WU8yBq5fFDrPc4blWrqIJY22ywYZzC5tfc97fF66S9TPr7ZoCqDZa9JaNYRkr
         1wDiTF/VliBrLCsdK0q1oc+nROuMMoHqq9NyYxfrhIsoDVqXUviPToTHBhqcI7N76KgP
         htQQ==
X-Forwarded-Encrypted: i=1; AHgh+RqJaESNk4FaotwBtgOb0xRu3W2NYS2G5PHWD3JBdY4GK9ZONG9H1pspP52XX/VNYSvXR6wnuhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUfKIPkEzsnU7rCfdMGJ9yZ5dKkFVoMMUivQfJgwq14ykKv7K+
	DNCwhSBeBk+CE8/0ulqVvBTfwuKt9Val6BWB8irnXqLJdcFs2eaH6jnfLRYGn4kZS8y0q9qCWnW
	H+JVGKOG/vHuP+zPB0G6R+eihsGJ4mSIIvimodQ/IALXXebLiH63EgTdzaA==
X-Gm-Gg: AfdE7ck+LZjnefPlPREDQpbVHhFugkLRmLvwPAIoK1HzImYu8q2/53M9g19jn9pwQSt
	CqS3waNE2T0aG+L+eOLDnFuDpN8SK2vctzgWOSMLJlINrQmczd8J6Ma6NglDn02nHbPZy2NLy6q
	o0MUw2JRbSJG8sFOy7BwuN9UFg+TgjCyZHr0L+LNkSG4G5CTsZZIROX6OEmyKgXGL6JzKuaw/37
	OC62FLHnp5+mQCVKmbYytbQw3htfJ/0ZRp7bQeQ/OctRKjgwoGk2pGUgRRhj7cxsyiEx0dP3579
	u6HEV3zWHVk7W6KLQ8ehSNGQ7inCqfZpReoVG3yJCVf5I3mrYvEbczd9la5vc87syQPYTSX1+3h
	lJn+wSaJS5T9N8YMvAItA/ADtIwvYx09sFrlJNa57ifcQTmCwGSPzr3rdIwRVGzRiv+5QQmMd
X-Received: by 2002:a05:6214:3a8c:b0:8dd:4979:4b19 with SMTP id 6a1803df08f44-9074c6fa76bmr42057216d6.13.1784051822591;
        Tue, 14 Jul 2026 10:57:02 -0700 (PDT)
X-Received: by 2002:a05:6214:3a8c:b0:8dd:4979:4b19 with SMTP id 6a1803df08f44-9074c6fa76bmr42056776d6.13.1784051822114;
        Tue, 14 Jul 2026 10:57:02 -0700 (PDT)
Received: from [192.168.2.110] (bras-base-aylmpq0104w-grc-61-70-49-81-60.dsl.bell.ca. [70.49.81.60])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd56c4cd1sm173212066d6.16.2026.07.14.10.57.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 10:57:01 -0700 (PDT)
Message-ID: <24432756-29fb-46e8-8d7b-de6e724da958@redhat.com>
Date: Tue, 14 Jul 2026 13:57:01 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/util: don't read __page_2 for order-1 folios in
 snapshot_page()
To: Matthew Wilcox <willy@infradead.org>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R . Howlett" <liam@infradead.org>, Vlastimil Babka
 <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Ritesh Harjani <ritesh.list@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260708201954.686111-1-aboorvad@linux.ibm.com>
 <ak6zsw5R4Ub8FnmQ@casper.infradead.org>
Content-Language: en-US, en-CA
From: Luiz Capitulino <luizcap@redhat.com>
In-Reply-To: <ak6zsw5R4Ub8FnmQ@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-07-08 16:31, Matthew Wilcox wrote:
> On Thu, Jul 09, 2026 at 01:49:54AM +0530, Aboorva Devarajan wrote:
>> snapshot_page() currently reads __page_2 after checking nr_pages > 1,
>> but it should only do so when nr_pages > 2.
>>
>> During DLPAR memory remove on a 22 TB ppc64le LPAR, snapshot_page()
>> oopsed on the page isolation path while reading an order-1 folio's
>> __page_2 from an adjacent absent section (unmapped vmemmap).
>>
>> Fix this to avoid reading memmap that doesn't exist (e.g., a vmemmap
>> hole).
> 
> I appreciate you're absolutely swimming in it, but there's absolutely
> no need to inflict IBM terminology on the rest of us ;-)
> That second paragraph could simply be:
> 
> If an order-1 folio is allocated at the end of a vmemmap section,
> __page_2 will not exist and reading it will cause a fault.

I think having a brief description on how the issue was originally
reproduced can be useful for determining impact and validating
backports.

> 
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
>> Fixes: 31a31da8a618 ("mm: move _pincount in folio to page[2] on 32bit")
>> Cc: stable@vger.kernel.org # v6.15+
>> Reported-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
>> Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
>> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
>> ---
>> v1 -> v2:
>>   - Condense the commit message.
>>   - Drop the code comment.
>>
>>   mm/util.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/util.c b/mm/util.c
>> index af2c2103f0d95..34cb43b3eaa4c 100644
>> --- a/mm/util.c
>> +++ b/mm/util.c
>> @@ -1353,7 +1353,7 @@ void snapshot_page(struct page_snapshot *ps, const struct page *page)
>>   	if (ps->idx < MAX_FOLIO_NR_PAGES) {
>>   		memcpy(&ps->folio_snapshot, foliop, 2 * sizeof(struct page));
>>   		nr_pages = folio_nr_pages(&ps->folio_snapshot);
>> -		if (nr_pages > 1)
>> +		if (nr_pages > 2)
>>   			memcpy(&ps->folio_snapshot.__page_2, &foliop->__page_2,
>>   			       sizeof(struct page));
>>   		set_ps_flags(ps, foliop, page);
>> -- 
>> 2.54.0
>>
>>
> 

