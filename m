Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793450443;
	b=2H7RSB/SjxVrs1t8HzLgsxcHQgUBe0EbjzrpkArpLKWgDEBFZgYVzSZIWyfMVni0UgQF
	 Zm6VYrIInsiaVF8W9iXgWDj6r7hVoxEAf8IRhZM0WdWpyAA6vCBNr+YACCwI2g70uvoGD
	 ilIwP84T8eGQTS1LhHUSIAEouR8GJHS9OsX1+qbXThQEuSVo+2yCLlF+qFwqcnSA00t0t
	 IIyMXgn1rDHNq6I9PIDSmc2pGJZCn/e3OHTcgVKcZ5O+L3oW9dgB8kVh2VVG+EE4b+j2u
	 iPW+WpmqMYhYXO8KO43R3xegDgUkU7JlPRFfJstLR+cJVMRYuFt8CgYuo4KnHWUxp5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793450443;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Cxqf9Bqorso0fGl5m6PKE59KMlkjDZ4/kjDJmjbnK7Y=;
	b=5FQZDSRyE2b0wcakFLrkpw4m0Gjfxh/y50j3G4vu7RWQxuyWac/8fZ47UetSRjS9jFLA
	 cNvzI9xIg2SlEZkppBa1efWK5LG68Q5M81XVPg9RpVpFsvejlCtJ3Ghtn6P1OZP0BWt+e
	 oCl8Y1AkE8ugmUjwRdfcberp86TvsKRmi28SqPhu1PUyrDWMBuBA8d7ybT6s3bkJxCGNW
	 xTY4gVV8+NBFyC5RxZ2RabpCCNpNdm4HhU1Moqqw6b9hg5D1HDWZ+UjbDEUBrrvrlo0Uc
	 v47iLfPqupH1FxcHUTlVlttJxwX3ABAVENffVDH1CuUJd1+QI+0gWWBXLdvbbYrJANA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qy8WbEhN;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1B4606A31D
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 12:40:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B1B4606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qy8WbEhN
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48e20edd106so1289925f8f.1
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 05:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793450441; x=1794055241; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cxqf9Bqorso0fGl5m6PKE59KMlkjDZ4/kjDJmjbnK7Y=;
        b=qy8WbEhNvxLv28vR/bD8Dmmw3fyZBPw4FeqtBM+B5UsizZTUzx99aZZM3rs9fe3wRv
         CTZvEO/yoOWb851TAoLT5y1t/fM3PEOkEhj7XSDMljPsoYR0GhFQvSoDAvAL848fzLQp
         bXVAVuNWGnESh09nncjfS3UAOqUnOMM+BYpAGuILeFmTfDugnPI7tdNKbTqyR+xJdEoO
         qozVY55bD7jSu1YAUzrqGxzH3IPVygjs60wre44jjyjwJg4qql1xoMCfI3ByE73s/83W
         F1Oy0idXYhtOytdKxVKdQqAdnF3H8/uDPNULdTTvlD8cF94qwQjxtrDErjQqSBJu5qQg
         ZAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793450441; x=1794055241;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Cxqf9Bqorso0fGl5m6PKE59KMlkjDZ4/kjDJmjbnK7Y=;
        b=blNF0Afl/zYpq5bYvxUgD8Zwz4mvoCNviBO2DP9DavASmNarn23CwDnO3bZm7JGr2a
         cVbWnmLwnjqISVdas/2BlRM2EMFBSU9VhJuyEyoKliSnC1nfGfLCAQ4fj1m/ny29PW7Z
         YNBBCkXXTJJPItscf2QJH+f83EAkG57cU/GcpRabCLWXKe+NPb1kqgxmWF2aIDFaUdL/
         m2elUjqGcgLf/zTOqilDdExQ5rIt5SbJjIQ87Zxdq+hBEq/GyMvm7Ndv8Lc37vAyXQGu
         +ZWjh8hRW/HYb7puJH8CgXchCmkcpbnctqB6CBUh+oUJ3/SifaeS0CDeuvZzfYfxnHSG
         Sr6A==
X-Forwarded-Encrypted: i=1; AKwUvBzJi1xeOCdfmPiFZ4Xao5MmewiMDfFQaqSJ3xqIMu8lSApJhyC4o9YfSch8b5UCIN0xoIyO8DQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJdDZ9MNaql+ZZHrjmwSTuiB44biomerM7ldFnq4YJJpwwgtB35
	C4Y7TVBVZcW3yceEpzjP06RDYygSzXu7KtG34FvOIrui+6uLwOOxHDIu
X-Gm-Gg: AYBFou3waR9RJDTuJM2ELqpBxCjP0VFbWpbyGjLugc8XswVLc/I+peGmZ0Yg8cN7s3V
	dFFKGQFIuviuv/sn4HhN2EoIlUqiFo1/n+Hd5y2f1Nz8W6J8K97w8f1CZ+TFdqcJ9QOHiAslUC+
	sT7W+WnbnXQLubDcql1HCekM2b2V94uxxsQboBFB5Vr7PFJRZxI+gsASaZrr5HsrNKSeuBMDMjI
	SMNda723qEgpu36kh3hd08MOs7JNJJS8jttDNNg/FBp9fPvPYtv/bagMNPhsj9f8o2w1PZ/TC5q
	yMMC+vbwqbe5rzXAF6+5fxRrh737G4mLAFLfe38zKLEhkR1EfDmc2aCWyIrrUHMQvfmczasEfvb
	zz4raVZWFYKq40CYCVRvK2VgY+FOQq1A2QndfFdYuHwLKlVL/uGw9d7mAIGuKBpYxBCzvin6P3e
	RryQrjdxnyMSqYFccG3+5aE81YkefamLTbGnxBhz8h4cM26aHgFm9Lr2VU3FOSnrQbHTF4A9WUT
	hVT0dmkNbRjnRzF1/0ppLDbJyKA1PmAcl6IGAVVhQhjF9tvev8ItRF6U11N3MXGwOqvnDbQ+eNF
	W1reytSSre+OnGNKKjvXDFgFBBsWiwsI5ZJj+RJgTx2WDA==
X-Received: by 2002:a05:6000:2c0f:b0:48b:68:594a with SMTP id ffacd0b85a97d-48e6e2e7798mr11167496f8f.12.1793450440315;
        Sat, 31 Oct 2026 05:40:40 -0700 (PDT)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b789c6sm9294444f8f.26.2026.10.31.05.40.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2026 05:40:38 -0700 (PDT)
Message-ID: <57717da3-d309-47c5-8c1d-d4686e8fd8a2@gmail.com>
Date: Sat, 31 Oct 2026 13:40:37 +0100
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
Subject: Re: [PATCH 1/2] mm/userfaultfd: recheck WP registration in the
 hugetlb UFFDIO_COPY retry
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Peter Xu <peterx@redhat.com>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>, stable@vger.kernel.org
References: <20261029221129.89068-1-azpijr@gmail.com>
 <20261029221129.89068-2-azpijr@gmail.com> <auWz5tAzi0p6NMou@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <auWz5tAzi0p6NMou@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/31/26 10:24 AM, Mike Rapoport wrote:
> Hi Jose,
> 
> On Thu, Oct 29, 2026 at 11:11:01PM +0100, Jose A. Perez de Azpillaga wrote:
>> mfill_atomic_hugetlb() drops its locks to copy the source page with page
>> faults enabled and then looks the VMA up again. The retry doesn't check
>> that the VMA is still registered for WP, so if the range is re-registered
>> without WP in that window, a UFFDIO_COPY_MODE_WP copy installs a uffd-wp
>> PTE in a VMA without VM_UFFD_WP. That is one of the leftover uffd bits
>> hugetlb_fault() has to tolerate.
> 
> The "leftover" sentence will be confusing for future readers

sure, will drop it.

>  
>> The non-hugetlb retry goes through mfill_get_vma() again and fails with
>> -EINVAL. Do the same check in the hugetlb retry.
> 
> No need to reference non-hugetlb path, just describe the added check.

okay, will do in v2.

>  
>> Fixes: 6041c6917903 ("mm/hugetlb: take care of UFFDIO_COPY_MODE_WP")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
> 
> With those fixed:
> 
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

thanks for the review :)

> 
>> ---
>>  mm/userfaultfd.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
>> index 3b71712edab4..a70ecfc8a998 100644
>> --- a/mm/userfaultfd.c
>> +++ b/mm/userfaultfd.c
>> @@ -810,6 +810,10 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
>>  		if (vma_hpagesize != vma_kernel_pagesize(dst_vma))
>>  			goto out_unlock_vma;
>>  
>> +		/* The range may have been re-registered without WP meanwhile. */
>> +		if ((flags & MFILL_ATOMIC_WP) && !(dst_vma->vm_flags & VM_UFFD_WP))
>> +			goto out_unlock_vma;
>> +
>>  		/*
>>  		 * If memory mappings are changing because of non-cooperative
>>  		 * operation (e.g. mremap) running in parallel, bail out and
>> -- 
>> 2.55.0
>>
> 


-- 
cheers,
jose a. p-a
