Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A1E3DAAAB
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 16:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789403452; cv=pass; b=ToQUAsFfHjmw0dY/TY0j1deq6CZK4c6wvA/4FoX2AtJRc2Eoj/ROP4E6o/OXsLdqcNlaLqOF02ZGZn2IN+E2KpvU8TpH+5vnWlHoXjqGx9hjO0Szuf1voC0k5zVePN6L9Y2fl3MWEWCyvpfxkJhiOAY7QDAcgIQ0sn4urvUUz6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789403452; c=relaxed/simple;
	bh=XSenOVdio0MTk3GC6131u10bA8proRI6SzfxE3M5VwI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IYRqh78ShEGndTLkE5J28cWEGmWmZzVxc4FrJqjt/jfvpWYEA+kgWbJbGbn9dHu9b9JSL2AVcDsB6KAMpgHSWPt5MYE4GOka6HBqf+pj/5bc2UNn8trgO+i37Clv8ixWVANJbr+HdMd6KZXhsaLncD2wCC6yda+jUAzcfQoTSG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QkJef4Iv; arc=pass smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QkJef4Iv"
Received: by mail-vs2-f12.google.com with SMTP id ada2fe7eead31-78ffc0e2f23so634430137.0
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 09:30:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789403450; cv=none;
        d=google.com; s=arc-20260327;
        b=WXpm7tihbdh84SA+sbxU6A4Pc41dTP0Dp7qXgZyCptjoF+sWWE6Dn6kMOVb4oxFMDp
         4uVu5EaaYoiOWiiAD6FM1pt/tpLcqOCoRsmRIOmzAgReOyJWJl6/MxzGeS03pEOdJn+e
         Ix4pnudwu9sJZpxaVM0LyyuicYfkTVCexNeHKgovvxwTs5z8So0xX9VePiT19CRnPZJ3
         fAaIiuwIdSUu4KK1p6zE59vjHnshcCB73hW/VfGytGutmKmLm9h/fvWE/Xqls8w7okUc
         Y9Ghn3wLz+Umj7zQl3q1T49Le8pRyE84JEu/xqDfLl2LhdsJUcV5MyLumC1+potw3rBR
         HcUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=XSenOVdio0MTk3GC6131u10bA8proRI6SzfxE3M5VwI=;
        fh=9VtSZTMxOXDwyORLI8GZnPTKZ+pSeS8b60V3gjap8gg=;
        b=s2HssBqJnfylMxA7xzjLqz//vzFoVVBEpfeT3YU9DKL5LBW8XWrSIYUsKaDC3LKAwb
         Ru2O46XF8XFKz5KkE9BrM+5Wi6dA+z+W2w22hvkhEEpy8WQvgtiO9lDeG8AuNkXgnc+1
         TDg7Axvgp1YwV4zUwc64898yfTX2Bv0F/tl78pqv9Xvw5bvH3eBQNtyUprDOrSqfdFHb
         n5bhB7dcxx2jBpmFSjxL+rYXGRlRQoQ3XntWnDPS3K0t+mUxibsOb2p03wZHKBkZzQbz
         NRk+ISYz0TfaBq2iblB/s8otYIanyLul3QYi3JE9op/v/oEh2MfceKbphcSOCKwdfDSG
         9qjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789403450; x=1790008250; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XSenOVdio0MTk3GC6131u10bA8proRI6SzfxE3M5VwI=;
        b=QkJef4Ivs6iY3syqkU/t38p7D+wTwdUbU8t1xmm/eQm99eHLgDtK2CmSnuksIIFK59
         ZV+NQVIGYwtPwi3NTjGeIzuxlmVGudaEysd1VCg3kBoSCi86mxGhd6MIZeu7sGeD3SE9
         rw2XkiUFQKgl0nOCl6Vp/o0odSnDa9ErlWimnlF7NeJ/9wmiNDotmPGEYOLMeZn4bl9J
         HYqgh6o0H6370UJqhu8ieJglt2VaHzMnqsAZnoePtknhQUAzZNiJFNI7Gk/4VC5HSq5Y
         zcPrCSnB23FF5QmUwxtFfAXzSb+7GNFQRefFXTlfRyPUA1l2iVqtuFyzu1zLh5MFqHpJ
         7NKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789403450; x=1790008250;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XSenOVdio0MTk3GC6131u10bA8proRI6SzfxE3M5VwI=;
        b=I8VjwniF4u4dkmxdIakuxcwixDwINIOes8VyzIL6G/30EqH4KMlX6wEyg+hYu1Lmiu
         R3Ox4BB55776YrOUEjejTmrfYCueGobiQzUn/p5DzMHwE9ymx2zWKhIzqtdMWTsCDJZX
         qpTbbIlcF+N/yupBUu+tXkKZa3sk9vtXg1LRIyHEUHHJPQMymnih+nh+3q50r44cMUHB
         9a0MVfzPF5QhGmE66F6n2tujPg3JmbIFMQJb8VBdhqv6ficg84N+XUlaKca3L2j+OuqQ
         KQF7o8l0Fr1o2ac2KNKtecmqAVL42O2rdqnJnmhR8uFqGbukkzlwOlHUj2fA37euG4us
         4rEQ==
X-Forwarded-Encrypted: i=1; AKwUvBwAKD+zheAX65z8XXwvrqYzrdTJwmzQ2C2uo0gVNU1Hox/TkW1f+FrvuKWWgHwsR8OOlhnEqjo=@vger.kernel.org
X-Gm-Message-State: AFuF++muAN8pWmmL+BGcCVd8dabbLPRMCHZgfqZIsI8XCjzkvsqTnqCq
	xyazFdS+yZSqxwHFSigFKMf1yMs/5hmKEh+QnPtO+S9aW1M3OHeuXUv+VnxyaUiODFPOE4Sal2S
	xiNa0+yxpJMmkA6L79IMmDOl2JgMEu9GWYjUqoLcQ
X-Gm-Gg: AYBFou26wtYnE7KMkrMHiDGFTBppqMqxIYEhekXNAErfEwbThIWNEhLx/v51bPIniHS
	leMc3R+aYJXHn7+3lQwOBpJ9KIDjPv/wGEKrgOgHkNyRdPR2XUM8oAmqMQNVPSCnhDNEK0UbYxj
	NnZJUgREbKzAHCC8sJ9e8Og8fYq4+ZsgAgMZc/DfO6dWcMIcE15xqWlbs+yzFRk/UHogTQCgXjD
	jgLc3c9uxxzdtczcWqHPIQ/VkagLntot7taY0aweSRVx6nVW/H5JR7WqIN+jOH3kF7v5D7SShe6
	Im6JrQdpefy1LZtFbRD+pHR4kPK/M6PyD9fRYMV8xIVD8e3kJihqMksqEybQrOZY4nNJEKgeDFJ
	jvudwHsSGWCZsvUjjXDEaRg==
X-Received: by 2002:a05:6102:511f:b0:785:d308:cc0a with SMTP id
 ada2fe7eead31-79b5b2909fbmr3656947137.9.1789403448800; Mon, 14 Sep 2026
 09:30:48 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 14 Sep 2026 09:30:47 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 14 Sep 2026 09:30:47 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <CAEvNRgEwbUXj5cVQq4A-U=AMOzP3S1mjnrOC79Li71wf-E+dDw@mail.gmail.com>
References: <20260909-hugetlb-subpool-always-track-used-v2-0-30c5d83b572a@google.com>
 <20260909155003.e6c2f4fe3c0bbee3b34578fd@linux-foundation.org> <CAEvNRgEwbUXj5cVQq4A-U=AMOzP3S1mjnrOC79Li71wf-E+dDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 14 Sep 2026 09:30:47 -0700
X-Gm-Features: AcwNN1XXPLdtIsXucpy4FdPGkhqMrtzwEGfBrz_XeIOSoKwnvb1TbO6LQoI4Y4A
Message-ID: <CAEvNRgHPGzfyr5Uuir2QoLqSNTkspkn3yJ5CTz7rAQmREe2Apw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Fix HugeTLB subpool used_hpages tracking
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>, Alex Shi <alexs@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Dongliang Mu <dzm91@hust.edu.cn>, 
	Hongxiang Lou <louhongxiang@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Jonathan Corbet <corbet@lwn.net>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, 
	Michal Hocko <mhocko@kernel.org>, Mike Rapoport <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Nhat Pham <nphamcs@gmail.com>, Oscar Salvador <osalvador@suse.de>, Peter Xu <peterx@redhat.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Shuah Khan <skhan@linuxfoundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, Usama Arif <usama.arif@linux.dev>, 
	Vlastimil Babka <vbabka@kernel.org>, Wupeng Ma <mawupeng1@huawei.com>, 
	Yanteng Si <si.yanteng@linux.dev>, fvdl@google.com, jthoughton@google.com, 
	rientjes@google.com, vannapurve@google.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Ackerley Tng <ackerleytng@google.com> writes:

> Andrew Morton <akpm@linux-foundation.org> writes:
>
>> On Wed, 09 Sep 2026 14:49:25 -0700 Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org> wrote:
>>
>>> HugeTLB subpools currently only track used_hpages when the user configures
>>> a size limit.
>>>
>>> This is buggy since when there are existing allocations from the subpool
>>> that would have satisfied the minimum reservations,
>>> hugepage_subpool_put_pages() will still restore a reservation to the
>>> subpool. See below for an example of a false reservation.
>
> "false reservation" should have read "false reservation
> restoration". Will fix in the next revision.
>
>>
>> That sounds annoying, although isn't clear how this affects end-users.
>>
>
> I'll also add this to next revision:
>
> hugepage_subpool_put_pages() falsely absorbing reservations (aka
> reservations being falsely restored to the subpool) means
> hugepage_subpool_put_pages() will return 0, and h->resv_huge_pages won't
> be decremented. The page(s) still being reserved in h->resv_huge_pages
> means fewer HugeTLB page(s) for use in the entire host.
>
>>> In addition, the subpool is considered free prematurely, is freed, and this
>>> ends up causing a use-after-free.
>>
>> That sounds alarming.
>>
>> Do you think it's best for us to submit [1-3] for -stable backporting?
>>
>> Is it feasible to come up with a set of small little fixes to get
>> -stable out of trouble and then to prepare broader updates for our
>> ongoing mainline development?
>
> Please see [1]. I don't think it'll be easy to come up with a complete
> set of small fixes to fix all the issues that are fixed here.
>

I'm hoping this will make it to 7.4 and it's 7.3-rc3 now, so I'll respin
perhaps tomorrow or so if people are ok with the suggestions on the 4
patches or if there are no objections!

>>
>> If it's "shut up Andrew you're always saying that" then OK, I can take
>> that :)
>
> [1] https://lore.kernel.org/all/CAEvNRgHbzY30n1hz2vv7BiBMMhci+NEv_ubP1LjQNmBuu6Kjgw@mail.gmail.com/
