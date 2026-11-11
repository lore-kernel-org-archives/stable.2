Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794408936;
	b=5DOKLSy0baTAqrNuwixRuZCEAR/iu478Ol0oDswIZFpf5zYs8sTzzurkdxx19C6ckjhI
	 XgNU4p9MQ1nCPiyncpwQvvXbJ//TUcXpAoIhcmSYiuXEnlNdkaOHKjrw4zMtqplV4hXbA
	 upc2GzkFWRUW6lQrcJ9/B0hEjsprb4QebBndn4qr2asnEGMArr2wXnoWMqJbALMHMzei+
	 XYNp5cuWEtJszLAP7e9nT4cOW8yx9JL+H+UxlTxabOuinRmQmkblIvYopW+vhfZAT8eFo
	 nXNPm/Cwa5WF8EWMlTpO+ocSACj42h6YhLNKjW4ZpxOk6bsGHiWNZMOjBHK77C5+lYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794408936;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=vXxZNPloblwez8eotIUyzVyml6BygSTK9IEoRgeJrow=;
	b=g8E34MVvK2cIlRmeUsQuykC/2PnJHi6DvdsDZK3M/OHT5jHKufTS4kbk/IP6O3uqFtLc
	 jniWJYEgx0J02Mnt/jMid7wL1VkY1qi0b1JsE0SfabMukXfDDdNuUyWFlImTO1IRE6Bge
	 xoAcMGmcOE95JWe0e+iJj3l7K9Raq4dfFi7jkXgqL8/GQIfFwDSLCVaYkEfSoKVoCSmbF
	 CDvQVcHS1OSBqU0Y0/nogiNeq8msb2uUxcmK0LVca2robZodSe2H/Ojs/PDtc+I2uFluW
	 VVnoM8dT2Ud0rLFDtYjwoXwKX//AHTTtnFQr9EWlGH/iu/NNfNO1JpJWCGoFio0qsxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RxLhxysO;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C5A606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 14:55:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25C5A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RxLhxysO
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a210470b49so27046145e9.2
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 06:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794408934; x=1795013734; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vXxZNPloblwez8eotIUyzVyml6BygSTK9IEoRgeJrow=;
        b=RxLhxysOcaNdcB0XGAEo6B0YeZFM4L1zjSNZgalq3sSFQPok1HrneylAxIwgB+JjVH
         ykeGhbIsoEAbxjsX/+xNyyrEKlqaYFFegHgIYnBLzb1DJHPyoeGT08bFKkuUT337bThC
         oB+8f8PQem5apiluQM2nmt/ksGjsDY9RsVn0ueSKmoh4Uspjk4N3OlwRewgrtgoMMY8X
         eLEQikrs8lhL/A/elJnXgUD8aArfLzROzEWCgXPza+cc1Rubpnw3O6GWo4WU1UJxfhDR
         uw5bdJqTo9mw/d8Ec9BTKelOV7tyAMJnQw0c67Y1UEk3sJskwVMvuratCTzlW3UOpQsR
         dZvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794408934; x=1795013734;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vXxZNPloblwez8eotIUyzVyml6BygSTK9IEoRgeJrow=;
        b=GJ8yLFsdvbWTo7UeSO6tDzyQf/WB6maDK3o0vRT8q1QtSW5HMUgpA4D8Ms/Fg6ArZr
         fWogJ5iHM8fl3EkIfNMcWyUIbv68vEAwGmm/yho4tnEMz64b/EsYxbD1m+61rXwboho2
         5v5FCc5A2gG0Jk1m2BfPwuG7ks8LYEbuMHOK07C8bLOweaKsrJMPmvB6BG27JUNDV3hA
         lu6pGextEjqTb/Bi0ZNc3qiKP+nQKa1O1ZP/dqRLrQz0f8dPKpW8XO0OBGM13uVAJ+or
         jOFEKaB4/t9sGiFA2jA1CXIA1k4iuc/uF0/3BgQbf2Oti4OhNe70EjzwkSY7SVroBHnn
         Wj6w==
X-Forwarded-Encrypted: i=1; AL+hErGTBTkNi+8KmAokE1qXeFNweYX2VAuMl2KZ46cCz2+TWKPRkyB6Q0V7V2XP7+zAa8kyDXZb/OM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+C4WizmLN62EDDbu6UyIprK7zZYQCprzU+STV5ynP7Now2bBoW
	/OxVrU8bb2lQvLID5HLIeBKESy2RLVoPgWZyXfkeoHw4h8N7sXB4bnOZ
X-Gm-Gg: AYBFou0UmrnFU6gB7/v5/GgVhpQBkPJrujqdEQoXnIErFKknV9G+vmypZk7EnNFb5Ej
	aAjXgSVOdTNTrmP4osxB1m/z8fzPKJEHaRZlmL1Wth7wEODkSCJvAwb27AHKW9Z4vU2nSj+EpKC
	ptHIyi5k1f5mzA4JGJhVIQRNbeu4Fc0fcIZjafH+65QZOApSzglcrxED0kYDJhS4ibscmlkNIQ/
	x+GJZBTPm57///32eqzNs8Ur/f5QwUsIWFhiEIfNpATYLNeUADVD+0XEDQfZhVL7jmlYfXXBmdo
	yReqY5/DqbYIUqmYYjDrwttcsk89PbF6L3gN0VMTYhJSud+fnxPkSJkAafXHk9RXZyjdVwuo2Uc
	NRZ86ei7RZltJ5xuVEuyz69s/WIFdT98OGj3NkZQjbX8ibdqsAuSR/pLYkLf/pa9gyHRuusMt21
	a5fdE+0BAlGr2Fv8oahHDcxeGnFrvTZ2vlzeMcdFT19uI0SdRi+Ji/YF4R1QVmFjCST6MdfMq3W
	YhPDNvpT9Wx5YFaX0cyimMh3/3QiCpq8oQ4/GZq3QvwazDwazF6eOKjV0zs07FhdMS3lCttHPAT
	i0fwq+L/Y4YbVxCcl6R/VSG0IRiMHsFv+8jrWiCTug4waBT7Atl73+xn5mwHD0K4weID
X-Received: by 2002:a05:600c:4f4a:b0:4a1:7e76:d02f with SMTP id 5b1f17b1804b1-4ba0938a45bmr58472185e9.14.1794408934448;
        Wed, 11 Nov 2026 06:55:34 -0800 (PST)
Received: from [172.31.15.113] (6.red-83-60-147.dynamicip.rima-tde.net. [83.60.147.6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4c554832sm1485795e9.12.2026.11.11.06.55.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 06:55:34 -0800 (PST)
Message-ID: <5b4c2e29-9c83-458c-a8ab-fc78cb1fc92f@gmail.com>
Date: Wed, 11 Nov 2026 15:55:32 +0100
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
Subject: Re: [PATCH v2 2/3] mm/hugetlb_vmemmap: fix PMD split TLB flush race
To: Muchun Song <songmuchun@bytedance.com>, Oscar Salvador
 <osalvador@suse.de>, Andrew Morton <akpm@linux-foundation.org>,
 Miaohe Lin <linmiaohe@huawei.com>
Cc: Muchun Song <muchun.song@linux.dev>, David Hildenbrand
 <david@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, Sashiko <sashiko-bot@kernel.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261111093747.50048-1-songmuchun@bytedance.com>
 <20261111093747.50048-3-songmuchun@bytedance.com>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261111093747.50048-3-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/11/26 10:37 AM, Muchun Song wrote:
> Bulk HVO optimization converts vmemmap PMDs for a list of folios into
> PTE tables before issuing a single global TLB flush. After publishing
> a PTE table, a concurrent single-folio optimization can observe it and
> remap its PTEs before the deferred flush:
> 
> CPU0                             CPU1
> hugetlb_vmemmap_optimize_folios()
>    hugetlb_vmemmap_pteify_folio()
>      vmemmap_split_pmd()
>        pmd_populate_kernel()
>        /* TLB flush deferred */
>                                   hugetlb_vmemmap_optimize_folio()
>                                     vmemmap_pmd_entry()
>                                     /* sees a PTE table */
>                                     vmemmap_optimize_pte()
>                                       set_pte_at()
>    flush_tlb_all()
> 
> Modern MMUs permit overlapping TLB entries with different mapping
> granularities only when they translate to the same physical address. In
> this race, the stale PMD translation still points at the original vmemmap
> backing range while the new PTE can point at a shared or replacement
> vmemmap page for the same virtual address.
> 
> Serialize deferred PMD splitting against PTE remapping with the HVO
> rwsem. Hold it for write across the split-only pteify batch and its TLB
> flush, then downgrade it before remapping the folios' vmemmap pages.
> This guarantees that no PTE remapper can observe a newly split PMD until
> the stale PMD translations have been invalidated.
> 
> Fixes: f4b7e3efaddb ("hugetlb: batch PMD split for bulk vmemmap dedup")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/bug/linux-fbdc3410-a4cf-457e-88e6-684380fbadfe


LGTM:

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a
