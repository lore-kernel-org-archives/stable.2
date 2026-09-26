Received: from mail-qv2-f43.google.com (mail-qv2-f43.google.com [74.125.230.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAF53115A2
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 22:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790462573; cv=pass; b=bVyOKC5RuVAu38gY6gKoz44iKcMw/uZdfOusxYEUmjjM/z0U2KUAuWSIMxWwzqq94H1R5XBXaRsVI9aDVPYZ6arx7hN85yqKYCfu7zWqW71iZy6TrucgWbo93CeGVMValgda6ffaYo1tmWqvM6XGWS5McmmdOvOIluETIfI6OJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790462573; c=relaxed/simple;
	bh=oIoustKk4MCA1sbn3VwyOj5Ut9UQ8rmwcxgVxCOzBEw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M9IYSHNET8xxL97FNI7jEuFKudpMRYjVKf0fwbEsSE+2dbMD4e1J2YYfJFZCLXAVdEg7QAFpCK3XC/1AWTN+phzPi7Rr8098DIpGGDb6tVKM0hzsLZz1nD2GRBF0EcwH4riDzAerK/yjXav55xsIRcEoC90Frml4r+Pk6GYZWSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n4ivHikq; arc=pass smtp.client-ip=74.125.230.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n4ivHikq"
Received: by mail-qv2-f43.google.com with SMTP id 6a1803df08f44-914446005e8so9493426d6.0
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 15:42:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790462571; cv=none;
        d=google.com; s=arc-20260327;
        b=LlWOe829kcSOuP0wSONSsYX3C/jN2sb6EqQ55TFKSS0D1JJ2uschZ1YMBpTxCt6TuW
         Ef42Hp0N3T17hxVfigFsg77thBWBpQGK6jKSqc1llFwUc4xAfQ+GJwjmpxWwhhDhyitY
         FmAazHJo/9Y7RlgnnAb63F0hV/Hle3uLxt6utoP8puciZPhfdGBDp4Cj3WsnwQ6ORveZ
         7xNDmPoXxsEEjO7b9VjBd5kUC3Ab/gWI9pL9svWcT9L7V+EBzv6HqJSzyYCRG//0Q3dJ
         M280PTJmUxvDLJZnWNh4hmNyXnYKpxbk4a/1eRMWgFYoHH67kyNqklB04QcTS0ogKfpA
         jVJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=oPvBitOMBlhp8Hdy1YMUl7WEgUJJU4NLUnrbTGzbCOM=;
        fh=dGNgJvGxNrsdKRYoqfRCbyGYf1U8h85YLeiY072ezXM=;
        b=ETVpAUpDFgXl1UnhcUCYe4fyVvcCg/Y2WcM5+RtLRmeWGMhpGeweLDjoyjeT6fX8Tq
         cny4QrgCitb6n9Oy0JsDi9LXu4Hysnwd7aNzYwkX3iT3Z18KwxMWnGCFXr+owLchcLA4
         0sxCOQ/50IZI3CDM9oal9BnVbIhonGJA4+YrvPtICtZgqwidZIsBxOz2m7+K9dAHecsb
         ZIXycuko7KPW7NgtXb2H8hwjJyU2lgPk8Ane0grMowp6zr0DXAAwyORorjcAC4hCD2JZ
         ng9X5KNdR/LkuWMUuxJa27KkbU3Pp2GN7HQKanwii9LA5adk+0X3qcVa4+NXgG8jM32n
         JdJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790462571; x=1791067371; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oPvBitOMBlhp8Hdy1YMUl7WEgUJJU4NLUnrbTGzbCOM=;
        b=n4ivHikqoV8KJDh7LQu/SK6F88rEqYd2t2lH+kHUYuj1WKGVWjFT7Fdgxky03Aj5Nl
         RYrFXkJCF7yMws79bx7mINZ8ksDj2hSmdwHd/oMAEAPAE41vXwG7z/CgOoUrvxB1+wRm
         ev4JE8NXqZ6vKaI3emAj7hGz2Eh71Qd7wWX7huuTFMbsjQloRC3hn468HRddYv19OCXT
         UK7Li5D3ctZ0Y3caVk7+A00pmorXk12A9skAugvqeEjCx8/TjnADSgFNncc0MwuXdvO0
         NmDSaXA9rdq7R9UX0Xgl38jOmPf3p7DGOytMrO3I3H0VnGb03kSw4oKkPacUsdg1Wlfl
         zyaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790462571; x=1791067371;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oPvBitOMBlhp8Hdy1YMUl7WEgUJJU4NLUnrbTGzbCOM=;
        b=v+HnxpaE7vF2AWlD3GRb0tl0b2lEmp215tAh0a3ge1NmwIgIc1sSCluwWlaETLgZ0e
         UccJDa/GS+tmb5Q9JAiqneKEqX95MyceTKPHaPsNsg2Ofxvaei7wt4dGGxYxM6k5Gu+G
         oxQEtHp9vZZgoxAq5p7KljeupAoPEKIJaCTWV16BRhQ3YYn1egr1NEDK6CFvXbTGzI6O
         4HOdWT2pZD+mkxPrct752yEgBVut/jdllmXieYCiys6DhtZ1WgYvVXUGeRgfJGAgSykv
         kOYiBT2CVm0gkSCQGMwXKlHwzlSh3YGODdxK6oPB8RKGruwXWSLj4diUdStR3LLfKjn9
         l9sg==
X-Forwarded-Encrypted: i=1; AKwUvByVTm2hYdFiWxYqtRzJmuSVmgwHsIBHfbPtLjMX6DgvusxWFO4v97hVuATDdS2iKE2X1eP+Iw8=@vger.kernel.org
X-Gm-Message-State: AFuF++nG5oh5PsCOJkfKk3tfvOcqa1YHLHE41KsjZG1JoE2UngXXnycZ
	XrOHa0MJzY2QXLPkru9kVMInhAiH1ITjjwXsq+/dQNQXY5tJQ4sJjnJeIUJ0JBgy/Og+g+QoOVY
	BSEVcEldJ/XBIHJTeXhSFgch/aBihqetqeT6Bzeca
X-Gm-Gg: AYBFou1SUCD2zLg6Gq7buMPIgct+/TyXs1EyVp8Q3jQxLjonCDtXhrrud4QhGPjLqob
	K1PbXiAN/07jQBPxriFkdVTdXpHZVPvB1NjuAVd/DxdBc5ztrnajKw6FMA3TSfxW+x/RGZRV0Gf
	w1jM9VXE8S3ahImf+fBinbx6g0JFZ1mCYySenlCdfknPPmrvV4oLMC/OB2wFy/mFQyCsXBj0TSA
	mCWZ5eM/ABNoRnMw+IRxUTzHlidJ/o7WVmHq7/5WQEDLzMPUTbXMX4d5ej5ixi2niThW3qJYhl3
	Uh1R6854Pha/Mt4YDP0Oes9zNJj5cR8pbW3OhcyHKz3oGrtLoQkvjkUtHF0GVVJHQfdnI1Ljbr7
	IC35qqJHt2vmKh73bTUmV
X-Received: by 2002:a05:6214:419c:b0:914:4464:41ba with SMTP id
 6a1803df08f44-91444646dc8mr70530596d6.26.1790462570563; Sat, 26 Sep 2026
 15:42:50 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 26 Sep 2026 15:42:49 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 26 Sep 2026 15:42:49 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <CAEvNRgHZTYUuFBXS3sGyyjiveQOeLHuPxvud8o+R3NCCwM6Ukw@mail.gmail.com>
References: <20260916-hugetlb-subpool-always-track-used-v3-0-38aae9b5ccdd@google.com>
 <20260916201307.5618114cbac4af52d98aecfa@linux-foundation.org>
 <20260923220912.46905-1-kmehltretter@gmail.com> <CAEvNRgHZTYUuFBXS3sGyyjiveQOeLHuPxvud8o+R3NCCwM6Ukw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 26 Sep 2026 15:42:49 -0700
X-Gm-Features: AclHuK8P2H5EpMJy1YvK3gvIP-rpUihsCxDjwpAZl1LdwcYKlVTgraMVSJkaNkw
Message-ID: <CAEvNRgFPpigP6zq+6+dvC7nubFBjeYNZYPj4RHB1uXd6c26H2g@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Fix HugeTLB subpool used_hpages tracking
To: Karl Mehltretter <kmehltretter@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Zhao Li <enderaoelyther@gmail.com>, Jinmeng Zhou <zhoujinmeng@bytedance.com>, 
	Alex Shi <alexs@kernel.org>, David Hildenbrand <david@kernel.org>, Dongliang Mu <dzm91@hust.edu.cn>, 
	Hongxiang Lou <louhongxiang@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Jonathan Corbet <corbet@lwn.net>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, 
	Michal Hocko <mhocko@kernel.org>, Mike Rapoport <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Nhat Pham <nphamcs@gmail.com>, Oscar Salvador <osalvador@suse.de>, Peter Xu <peterx@redhat.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Shuah Khan <skhan@linuxfoundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, Usama Arif <usama.arif@linux.dev>, 
	Vlastimil Babka <vbabka@kernel.org>, Wupeng Ma <mawupeng1@huawei.com>, 
	Yanteng Si <si.yanteng@linux.dev>, Naoya Horiguchi <nao.horiguchi@gmail.com>, fvdl@google.com, 
	jthoughton@google.com, rientjes@google.com, vannapurve@google.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Ackerley Tng <ackerleytng@google.com> writes:

>
> [...snip...]
>
>> 2. On splitting: 1/4 applies cleanly on top of both queued fixes, but
>>    in my tests it made min_size-only mounts worse on its own. As far
>>    as I can tell, that's because it starts tracking used_hpages on
>>    those mounts, while the two error paths only release it after 2/4
>>    and 3/4.
>>
>>    HugePages_Rsvd, expected value in parentheses. Q = the two queued
>>    fixes, wrap = 18446744073709551615:
>>
>>                                    rc3   +Q  +1/4  +Q+1/4  +1/4..4/4
>>    min_size=4M only:
>>      SIGBUS faults [1], no files (2)  2    2     0      0      2
>>    min_size=8M only:
>>      failed mmap [2], umounted (0)    0    0     3      3      0
>>    size=8M,min_size=4M:
>>      SIGBUS faults [1], no files (2)  0    0     0      0      2
>>    size=10M,min_size=8M:
>>      failed mmap [2], umounted (0)  wrap   0  wrap      0      0
>>
>>    With 1/4 alone, the min_size-only mount loses its reservation, and
>>    in the failed-mmap case three huge pages stay reserved after umount,
>>    presumably because the subpool is never freed.
>>
>> So it looks to me like 1/4 shouldn't go anywhere without 2/4 and 3/4.
>
> Thanks for testing this! IIUC from your table, 1/4 introduces
> regressions.
>
> How do we handle this, should I squash patches 1/2/3 together, or is
> there some way to use the Fixes: tags to require those 3 to go together?
>

I think I have a better way to organize the 4 patches and the two
already queued. Will work on this.

>
> [...snip...]
>
