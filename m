Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADC43C9437
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 22:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783635354; cv=pass; b=dj4oDefK9igvHmGPy859g4Isi77WnuXUkX+wBjLR6bwqwErxhIMZ2CmblfWsWKbFeHVgY1TQVY7f4uB8+Ruy2bCEQO9bogJYjntHUU5RPFbPBjADp8IwsDPz5d0y6EUz4HiVGWjyoCMN3nUcZAuu4GmUkvtpalYe3ezeSuO4OEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783635354; c=relaxed/simple;
	bh=ci/J+gaTFmWCkCHGqDb6lW58XZZcFPNtF7bz+f8Zy4A=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FDYjMsgyWd29ZSmrnauqNvuVNpOMSBDDOA6UWEl5X+fzDog5Y+qnOvKTYaJfzvzqvZngTWSnhMCtoZ/VYUBA+yq5DFanfxAjyeV94GT8fYXx2s9jaIvLtQ9X+Rps0+VF+e5Q/Ab0bZRy0GXCBKfSPFt2ZsNYX/0dPWUFupXl6no=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wiV9nnDj; arc=pass smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wiV9nnDj"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-ca88130e09aso178544a12.3
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 15:15:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783635352; cv=none;
        d=google.com; s=arc-20260327;
        b=jN4VM9OZX+zcpMru7cC4jcqaa2V0+aMF8SCae24djHNTVHO7sbF9LJTdxy4SyxjVJR
         giBg5SnF4cwIy0ZdxoJO+7qkorbXWWcM2kLg9iFMNEJHTczXuk9YCuR0qa89d8+wJIXN
         YKhLjsIbM+5ewLnjLuqqVt+e1zvU6cu5ZZ36QHaCZPFYZXdQKj186brvpkxYDmS31JFU
         x/25GysAZ7W/Ix3CdyUJPjZnKdhS2qx0UK/n+uSkjQgC7kQ/CznNS/tLWvbQVDpwWkQC
         yWQzSTP2azF8xhCZ+9EYrtu096SJBYzPfy2AvEsyg9RogyN6gBXeTtrT85R8SCYmGn/e
         qy9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=mEwVlE35yinwK/CaZ7UcUKT4GdRsANBC6/sIz3zUbfo=;
        fh=9dcXwQje+jiZ7B8QSIvU3qjAGyXsdB5c7IYQDe+mOgQ=;
        b=fjJW/RGz6r+c5tgbRldWtcSjp60NA+KuCeeZKCRApXG8A47+5opzRGWDFoAC8bBDOg
         e7GD4oFLdv/G0vd9G1pSBfR+xgST3Ye3p784NAYRZISVy8yUt/j18Rg4T85c6hVrkub1
         t7WT8T7pf6j7kUQxDJAEnYNOGXOHI76nNFBsRKXEjD5z/17gCJzVYD5xIrG1PXicJT57
         2t5zn8C2YLpsJl4LJUSr1WMWD18JzpvB8BxofT7B0C6dGEHBNNBmXlZm1l1kjifinh3P
         LZLRsUf8Pzx2kPF7B0ok8im2mA89Ae+XMkw82/kICfk82CI+2usblLlaTVDb7BhFdUq5
         o1+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783635352; x=1784240152; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mEwVlE35yinwK/CaZ7UcUKT4GdRsANBC6/sIz3zUbfo=;
        b=wiV9nnDjwWyvbkJMZPdtcZipjwqDmNsF1QRYhYBAwpIjd71mtENaL7NQnQYwnOxW8r
         u0KR8EnsfD5SBWI5ABxYhlXKJHf4DErVufTFaxEVOs1D1wASKF/+b2onQVorNur/btd4
         or3/QB+pjSx25R4EXu5CuVHZXRu0RLktA/cBA26hYdeF/j5/T3IUk3S6vH7j6s1htFc5
         uJQ1rfuLSfCPfHHJikTMchweDsoEJ8elE/4uRJOipfqO9qILJOPwu+Gd3ISOVl8qcX52
         zInLlIQpqy1Bk6mrIdSngy+F09Un1skuk4DW6Q1DD9g9Beh2r2JE/LNYIhfdcFUoL2d6
         hZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783635352; x=1784240152;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mEwVlE35yinwK/CaZ7UcUKT4GdRsANBC6/sIz3zUbfo=;
        b=EzCHDvmCWs2vO3j65fEwhsVbYDM5Hu9dzsY6djKqtQ1ma+HpgHHyMEqOWYoiZxctSN
         X13jcspGKw2UeGyd30XVNhKltJF3a/lQf6uWwMgsF3lzqYvW+BFssTMv/XPH36EHUY45
         Bnn5uH3E09zmMgYwkwSJx5Op3HdOSzSWSu9fbPO42uycDEk90wUiEsVLrjJ/mO0SxsAV
         zE/ARmsKFtFyDz21l2asEdPkBB2Aqo3zGGfololkLJ4hGRJYD33/mJyQ7AlBgafrcjE9
         6BSdLkIWy2hnyZN3e5yZ+KO8gHsUcEdQ2LLSxVYBlg+1DvrqWxi8y2iBmvzRjBXZQVPU
         UdLw==
X-Forwarded-Encrypted: i=1; AHgh+Rr6PMSjNo0CRE8B5bd+W4zH5z2gscL/ovKA8R6v1XNryvINnoBFaoMdHe6hwDaYn2UAzuAAgek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlr2e457b7wnytGElvLc/GpEY5tyonN0fYtmjmNeGzb8oOzjzk
	DaM5uQ1wFIBZTLTOMRvpGNm8t6ceuqURy9pANWQWE25KdnXw+OzeOkJqtL4kRp9V6BLDrcVJ4Na
	Qng+xvONAdsfbFqXZkVn1h+bzGIa/Vs0s3uz04p3/
X-Gm-Gg: AfdE7clTA0CvcAZjhbDhiJCUKn8Rfm9Vxa1WX6iu2gSYDXn2o1+U0sASU0v+SVzpbzw
	+EArAqeD9ZJVKPM4ga9i45xdfr3NWFpmg2N1QuvoaXbzDtmY7fPvIgCm8vmIGdSISenJjdE9Ar1
	ET9TNTvb7fspAUGZvGIgubW8uc1bx2uhjIkhleyavm+QTxk6Yxpq2tYdTnqlZBbzkO4w6RpV35F
	njeD5YnSY60QhgfpQbIsn9XFwhJFdxJyXU5kft6oGDxXrk0SX/I2AX+JHZSAL3tvv/qButq6we4
	m002CwOJ1d8rkbhVEPnDz8WmxBYP7jcjJnxx3RAgb5MnmfVoRTMd79Vfs1QqmjO9WerFJA==
X-Received: by 2002:a05:6a21:3086:b0:3bf:b705:4b9d with SMTP id
 adf61e73a8af0-3c0bceca396mr10973890637.28.1783635351656; Thu, 09 Jul 2026
 15:15:51 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Jul 2026 15:15:50 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Jul 2026 15:15:50 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <CAEvNRgH9WSF64eKardR9M9VeRiN85UkS=Zsje9H8mqjQQychmw@mail.gmail.com>
References: <20260709153409.2091070-1-joshua.hahnjy@gmail.com> <CAEvNRgH9WSF64eKardR9M9VeRiN85UkS=Zsje9H8mqjQQychmw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 9 Jul 2026 15:15:50 -0700
X-Gm-Features: AVVi8CdvfF-IT3gKBuhe9TeVC3ZAyxvU-Wq7nKHZoFIvtZtPczQqgh73rAYctlA
Message-ID: <CAEvNRgGN0HSJ2iLSDD2haSKOxifa-uhkO9Hwossh0+Q_d9fzOw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] mm: hugetlb: Fix subpool usage leak on allocation failure
To: Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, Nhat Pham <nphamcs@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>, 
	Wupeng Ma <mawupeng1@huawei.com>, fvdl@google.com, rientjes@google.com, 
	jthoughton@google.com, vannapurve@google.com, erdemaktas@google.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	David Carlier <devnexen@gmail.com>, Zhao Li <enderaoelyther@gmail.com>, lance.yang@linux.dev
Content-Type: text/plain; charset="UTF-8"

Ackerley Tng <ackerleytng@google.com> writes:

> Joshua Hahn <joshua.hahnjy@gmail.com> writes:
>
>> Hi Ackerley,
>>
>> Thank you for this series. I really wanted to work on hugeTLB accounting
>> fixes but never got the time to get to it. I'm very grateful that you
>> are taking a look!!
>>
>>> From: Ackerley Tng <ackerleytng@google.com>
>>>
>>> When alloc_hugetlb_folio() fails early (e.g. buddy allocation failure or
>>> hugetlb cgroup charging failure) and gbl_chg == 1 (meaning a reservation
>>> was not used, but a global page was allocated instead), the subpool page
>>> acquired via hugepage_subpool_get_pages() must still be returned.
>>>
>>> Currently, the error path out_subpool_put: only calls
>>> hugepage_subpool_put_pages() if !gbl_chg is true. If gbl_chg is 1, it
>>> skips it, permanently leaking the subpool's used_hpages counter.
>>>
>>> With the earlier patch to always track used_hpages in the subpool, always
>>> call hugepage_subpool_put_pages() if map_chg is true to consistently
>>> restore the page to the subpool. Only call hugetlb_acct_memory() to adjust
>>> global reservations if gbl_chg == 0 since gbl_chg == 0 indicates a
>>> subpool (and global) reservation was used.
>>
>> So I think that I've seen that this part of the accounting specifically
>> is a bit suspicious. There have been two attempts in the past to fix
>> this area [1] [2]. I think functionally they are quite similar to this
>> fix, they just open-code the contents of the put_pages function inside
>> the condition. I've Cc-ed the authors of those two patches in case
>> they wanted to chime in.
>>
>
> Thanks for connecting us! I didn't realize this was already being worked
> on. Also adding Lance, who commented at [3].
>
>> I reference these fixes because I think they handle the minimum
>> subpage case a bit differently. To be honest, I recall reading those
>> fixes a while back and getting a bit confused on what exactly happens
>> when the page is absorbed to fulfill the minimum size...
>>
>> It does seem like Sashiko also notes this as a possible concern.
>> WDYT? Does your reproducer for this issue also work when a minimum
>> size is set (let's say, to 1?)
>>
>
> Let me look into this more!
>

I was looking at Sashiko's comment [4] and Sashiko is right that there
could be a race. Specifically, at the time of
hugepage_subpool_get_page(), I might be using a reservation, hence
returning 1 (thread A), but at the time of hugepage_subpool_put_page(),
some other thread (B) might already have restored a reservation to the
subpool.

With used_hpages tracking within the subpool, we can rely on the return value of
hugepage_subpool_put_page():

+ Return 1: Reservation should be returned elsewhere (pool has enough pages to
  satisfy minimum, or doesn't track minimums)
+ Return 0: Reservation does not need to be returned elsewhere

But calling hugepage_subpool_put_pages(1) doesn't say anything about whether the
1 (in this case, 1 doesn't always represent a page, since specifically on the
error cases, the page wasn't allocated) consumed a reservation or not.

+ gbl_chg == 0 means a reservation was used, and
+ gbl_chg == 1 means a reservation *should be used*, but
+ gbl_chg == 1 does not necessarily mean a reservation should be used, since
  h->resv_huge_pages may not have been decremented yet. (See goto
  out_subpool_put and goto out_uncharge_cgroup_reservation in
  alloc_hugetlb_folio())

So, we need to track if h->resv_huge_pages-- happened (with some local variable
like reservation_consumed)

| reservation_consumed | hugepage_subpool_put_pages() return value |
h->resv_huge_pages++ |
|----------------------|-------------------------------------------|----------------------|
| 1                    | 1                                         |
Yes                  |
| 1                    | 0                                         |
No                   |
| 0                    | 1                                         |
No                   |
| 0                    | 0                                         |
No                   |

TLDR: replace !gbl_chg with reservation_consumed?

    <<== reservation_consumed = true

	if (!gbl_chg) {
		folio_set_hugetlb_restore_reserve(folio);
		h->resv_huge_pages--;
        <<== reservation_consumed = true
	}

	if (map_chg) {
		long gbl_reserve = hugepage_subpool_put_pages(spool, 1);

		if (!gbl_chg)  <<== this should be reservation_consumed
			hugetlb_acct_memory(h, -gbl_reserve);
	}

I believe this depends on always tracking used_hpages in subpools, in order to
know for sure, just based on a number (with no page information), if the page is
supposed to use a reservation.


Perhaps related: does it make sense to flipping the reservation tracking
to instead track an "available" page count? This is basically the
mathematical opposite of rsvd_huge_pages, as in,

  available_pages = free_huge_pages - resv_huge_pages

This way, there's no need to synchronize the number of reserved pages in
both the subpool and global hstate.

It's quite confusing now, that reserved_pages-- can be either "used a
reservation" or "unreserve". If we track the opposite, available_pages--
will definitely mean the page's availability is removed from the global
hstate and transferred to the subpool, and allocating page doesn't
involve updating both the subpool and hstate.

One downside I can think of is that creating hugepages (surplus, or
promote/demote, or hotplug, or runtime echo 1 > nr_hugepages) would need
to update the global hstate's available_pages count, but I imagine that
would be less frequent than allocating huge pages?

>>
>> [...snip...]
>>
>>
>> [1] https://lore.kernel.org/linux-mm/20260428113037.88766-2-enderaoelyther@gmail.com/
>> [2] https://lore.kernel.org/linux-mm/20260515202902.461539-1-devnexen@gmail.com/
> [3] https://lore.kernel.org/linux-mm/20260428113059.79001-1-lance.yang@linux.dev/
[4] https://sashiko.dev/#/patchset/20260708-hugetlb-alloc-failure-fixes-v2-0-c7f27cbb462b%40google.com?part=2,
