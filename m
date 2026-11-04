Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793833768;
	b=glRtQWIKXzRb4CSsj1qv1xgmAPQweffwMbFRNZQzxY7dH8xjsSN/82RlQnQait5oeRs2
	 lP9gGaNjRCw9oIY5JJYZ27njVSe8fbqYnlSZdXpfJiJxtxlQ+fBlLeRujc/tiHibfehe6
	 y3nF4Dg05PsN8UcP6MjEBqJOQ9ryHtnV7OWDC3vzXBQt+FXTLTWnOMoFbHpmC2P+rKTuq
	 cERfhR3dPG1VVS2LyI2Fwi3n6/rPvPNig2BZmvywgDCT7RmEbITh5nS5M23q/3g4Q96na
	 gI4CElMHOK+cIqGp7AuqOCJY2ZuC8/CJfWDnMlnYc67uRz4nZGMyRVj8Y9f9v5yBANg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793833768;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=QJ44xLdhQI1uBh7xxp/N2gaMNtMNeyLEDRfUNR/7E78=;
	b=mLq70ltuWCyuUWZ8unaVwX8EvQQFpE7bLd/4YbiDcjbJptWmhH+n0jbziA7AjghQpTNM
	 1QfAEQu0JHx00XsYMk1EL1558EPdlkifnhhLHK2wNUu2Uwc4a4rhArgbln0FD5FcXQhqh
	 FmT+J2gtIO/FJ3llW0CV+YaeEBZopfCnHqa2xtJzGYcRb/LRgTeAfZ6fqL7Wuw99gbN0m
	 Q+kK7QMDqAY8bmuII9ahqB055o7WmJ6KQzr751zErY8WrLQgSwjJaaH7EEIZvMF2OUyUB
	 VztQSk97ClzBhzVMjVokmlk7BzbHgRZ3DFW+C5ebnKN9IwLsLgUQDXxaWKThmSMmaBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wjPH+Yne;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64F4606A326
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 23:09:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D64F4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wjPH+Yne
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49d05d51553so7906365e9.2
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 15:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793833766; x=1794438566; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QJ44xLdhQI1uBh7xxp/N2gaMNtMNeyLEDRfUNR/7E78=;
        b=wjPH+YnexCxHCatAS+O3CqB/uti+0YeZ1zpXdmwJfGvl18ME2cwPE17tj9l8RL6zKG
         4YD+rNP0FbGe1DApbRxNUKKDQxKiWWyJsEsiIeD5m3R1WFqh5uyBi5/u3mZOh93btlba
         3eNdOhcnOs7Rz8iwRjpkdDIuKPNF5iof1aLQiDacU5C4shWTx6C57mU+9gbm2GGZcfBA
         p5pZk14nucF2DgMpHAyDsRhrYK1h49CfvSIS462o++nOlfmXwYGmg6Vlq1VcyCgAzpCN
         hIQfwykB+Z6qGuAShuE0FkkN5trrXYAempNz1eSEyLl34fNFWujFVUwcAFwoGY/0fLOu
         XYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793833766; x=1794438566;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QJ44xLdhQI1uBh7xxp/N2gaMNtMNeyLEDRfUNR/7E78=;
        b=f/ImoGf00aICMupbLOWTmHLaeu3TPrcL6e2302oZ5m3agMiKWv/eVroGJqPcA69Pga
         M2aqml04qkDwTNnjeUcz9ciR60NFm8OJIQm6tR98Sg/DRZ+JCQO4R5b+9Oon5dFpdqFJ
         oh74G7n8+oeRZMmU7Ch188eOP71/Ph9PPCN4N2JFh+HzqIe3H/nfwLKdDUe9zn0Jz2Km
         M2k810Ttj9TjKqUEsKmlUWkegNrQ42JTZ9TyxyvA/ym202f26iMVVZaUeQQeRQivi03o
         ltuAwhANGf6c6nKWXhxJ78yRtb9HT53LZQMYzkY+BYILPJH/tXjRxbUpXGlgCyH2tGex
         roZw==
X-Forwarded-Encrypted: i=1; AKwUvBy8ltOI1ykcdtJRVJlRfzFP3gO13iKqKURtz163k9jm4qiVCYt5H2Kz29aBm8moGK+jPxhq4jo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9U2WlB5376CLMZkxjOYysrvpnZSxayyT+KFZhWdDoK44bl302V
	1RbqWgBGuTUd1hUEBi24HO6qzAAahY9Yme99xXJPHJPDT5hasvi81min
X-Gm-Gg: AYBFou263ysAUpIpqQrQJq49T50ayca8iMcx5qSi3KgC9L3mmhqUcb0FhTi5IF6wJmH
	OECVpXK36lyurDB/vPrrbSJTPZkiaZRDR5uXPqfFXEiHEZZGdEvcvFs9EseKU8YSOvC9Yzh+Q0G
	wLmmKKryTBg0zlfJy/VqrMdPPJKoytPKCgsu4UCAoMdxIWCksqIajFzILFOUTDh8Datma6bDC6i
	C/WPFx7SD+yIi+3mYZVyjNo1WnKncYgV0GyScC5dUNCXmxVyk/qQOXxDJ+l8KZcspdAA0TjdC5x
	mXdtq61pwUQ9KS8d22G074yiFKs0TgjXXOS9C+gDFrKMGj25bamlBej6gvYGbgi54VwdnYiQWDr
	kiDrwS+NFdgyzXfTx2Uq5czZoE10+Jxu0ILpPltNanhyh0XYr5HVyP28CJqpSesQb+5112yDTh3
	71+DZx6LzijzdnWcUoxhfy0EDMooIAnqxNNNC2yTxi5wxm3bKoC2d7+3lHAGen/T7NOooIxgN2T
	vgnWB//grbeOF+2VOi8k/R13oGxLOoEyAAB5FUhmQefs4McEV3tO1159r5BbWg74KvqjdarCl6/
	YqnJRfTtlL7CUZdC0DdBKms=
X-Received: by 2002:a05:600c:3b88:b0:4a1:cf60:dcc3 with SMTP id 5b1f17b1804b1-4ac187a6ffcmr414345865e9.29.1793833766131;
        Wed, 04 Nov 2026 15:09:26 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56e2ae73csm18115315e9.1.2026.11.04.15.09.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 15:09:25 -0800 (PST)
Message-ID: <a9ed4146-691d-4a35-9b82-e60329688277@gmail.com>
Date: Thu, 5 Nov 2026 00:09:22 +0100
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
Subject: Re: [PATCH v5 3/4] mm/huge_memory: read a special PMD under the lock
 in copy_huge_pmd()
To: Konstantin Khorenko <khorenko@virtuozzo.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
 Peter Xu <peterx@redhat.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
 =?UTF-8?Q?Lo=C3=AFc_Molinari?= <loic.molinari@collabora.com>,
 Lorenzo Stoakes <ljs@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
 stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
References: <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-0-c56d0d26f970@virtuozzo.com>
 <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-3-c56d0d26f970@virtuozzo.com>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-3-c56d0d26f970@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/26 9:40 PM, Konstantin Khorenko wrote:
> copy_huge_pmd() reads a special PMD without the page table lock and
> copies that value to the child. The mmap write lock held by fork does
> not stop unmap_mapping_range(): it zaps under i_mmap_rwsem and the PMD
> lock.
> 
> The zap visits the parent VMA before the child's, as dup_mmap() links
> the child right after the parent in i_mmap. If it clears the parent PMD
> after fork has read it, and passes the child before fork copies it, the
> child keeps a mapping the driver has revoked, for example:
> 
> - vfio-pci: the child reaches the BAR after the device memory was
>   disabled or the device was reset, instead of getting SIGBUS;
> - panthor: the child maps the pages of an evicted buffer object after
>   the driver has released them.
> 
> The same branch deposits no page table under the copy. ppc64 in hash
> mode keeps the hash slot array of every huge PMD in that table, so the
> child dereferences a NULL table on the first hash fault, in
> __hash_page_thp(), and on the zap, in hash__pmdp_huge_get_and_clear().
> 
> Take the locks first and let vm_normal_page_pmd() tell a PFN mapping
> from a folio under them, as copy_present_ptes() does with
> vm_normal_page(). The zap clears the parent PMD under the same lock, so
> either fork finds it none and skips it, or the copy is in place before
> the zap reaches the child.
> 
> The copy of a PFN mapping then goes through the same tail as a folio:
> 
> - it gets a page table where the architecture needs one;
> - in a shared mapping it is marked clean in the child, as a PTE is;
> - in a CoW mapping, which only VM_MIXEDMAP allows, both sides are write
>   protected instead of a warning being printed.
> 
> Fixes: bc02afbd4d73 ("mm/fork: accept huge pfnmap entries")
> Fixes: d1503aa9ab80 ("powerpc/64s: Add support for huge pfnmaps")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v1-1-d225c60bc316@virtuozzo.com?part=1
> Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
> Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
LGTM:

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a
