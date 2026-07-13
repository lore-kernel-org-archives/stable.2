Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076CC2798F8
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 15:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783957780; cv=pass; b=jQNv7L8TkWJbRmk+ym4r7vj6gUkC+923t5e3KFQOgsm9oSo41/8mI5VVeXzZbO/wuHRGYx+NSghuXBeUOUlLQJYZIEhc9w1pjCz40m8CJKyuCAGq33737YGt6sJ1+QjbOjqqzivRLGZN3kEJjpb3mcm9M4XtmyKDFWoYpvwvSTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783957780; c=relaxed/simple;
	bh=lNJSkGONn9lYV95nqCXo8sCoGbX0/al5SfBWu24qIKg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o15XhxA3MErO1gAugv8pGb2J/YzHCYLeL2fT4mjVKmAe9mSyCoKjofMle8k2dZfDuU5kZ5VCRdfW84ow4d7v8JnNtFMJ5UiVHE4a2C1MOHcO0N/uPNgrEyE5ojNIOahoyJz6b0hAci2v5ekTRJ4cMaoalEBBbiqG5J3y908g88w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jP/RHyqe; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jP/RHyqe"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cc61541f8cso328805ad.0
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 08:49:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783957778; cv=none;
        d=google.com; s=arc-20260327;
        b=hIyVrH7FPdPS0uFXxPBdqVgvBFSuZU55UEWpCLR3J0p2uw4H4kkf7QDZa1G6xlLjDh
         EpaTYypYMHSCQvvGqatD5stUTfrbU2JDlA58dyDk2ftc9/9i8R5GMWQQNG02NcIqVO6O
         +hNG695+voqhUgZ+x5Rlg/5GsfEIyr/rLtWDi7pIVv4RJD7o2huZCvgm077DT8XBUkUN
         4fBQ0mV+Q2oONCEVoNYKQihWS36m1Hkf5XZV4M1woIVN/bnp5bOsBu/tVvs5m6xoINCc
         9EfuhsrkZNSOlHY4yjQTN8njJ8TUzxHnzde5D3XL1Q64kA/4RTZcauG5ZiQ5lyuUSv3d
         e0dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=2kjXkxaArn2amA2QIiRqCeGoYfIXMvqGUNcKcx37v/Y=;
        fh=jLeGZ0YGp2f64hOqwllM4p63CR+WC2HaHSGPeKJ3PV8=;
        b=bnIUbRRuSCYIWTuAla0CgVKE0ql3CITo1Py7qq9ppGv0MkiI/5793bOrVuB+aEZWQJ
         pE1bgpZyTssnbLebLvmCSlDkX+w5B/V3rK8d24Q9Xlis4+BIBQGgEkDPMyv73nhAu0G3
         4gTt8kxqBuUNf1BdNQagZXzAqxM9ATQXI/b2ooQkVolGtKC/RfrF206uxmpKmdOXfyM/
         PQvvcVAIAXsxTWqpCqfn/mf+bLysBoi9huMXFPpI8Qcz6gkbkbjIS9JRDsorqZ++1Emu
         F4/UHJinqA8zdruxqcxyiFmyceACwrBCly0d4EwBnYqL4xDHXvlf8ltoer08RpIq0ERY
         Rmiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783957778; x=1784562578; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2kjXkxaArn2amA2QIiRqCeGoYfIXMvqGUNcKcx37v/Y=;
        b=jP/RHyqedUN2iToIouJPEDmK8BD4MinUheBEvyZbsiXOoXEGYy9wdyZrnjTq90ZK9b
         y8xL818hUs9Tdt0IlRzS7qbTA+8vZi3hJIoZbbiOvKNmPk0StPFN4Gdv82jppQQA5JJ+
         oFK/Uva6px5GPxacHM5ACtTbVhdBmK4cQ/kfZCSFdhd41atyPn/TjH+2shuwEZjtnrZJ
         IIz9uXUHBmiCDq4+z9G6gKLtBjmJhN/ZYur5c9tTOxjWu3tQERH6siVzZIlQ1s4GtqK2
         J281cNren5MDwezenDYh6U5bpxFEin6f8dZcGvGb/2sE/pGAoyQbYdD39MLhb0Ejk2IZ
         5IKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783957778; x=1784562578;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2kjXkxaArn2amA2QIiRqCeGoYfIXMvqGUNcKcx37v/Y=;
        b=M4D3X5sQPDiLtSUYLCRk7mln9fmmw6EQXLgMfLYWRpa3BvsLhmQsmnGon+zEu3TDyl
         7YHE89ElevqQk8M6pwRG5L0igdwDvOoxbVN8EtpsWcJQRyQtneiLu4UJQvMc5l1a6AHr
         XIe5d1Lvupxeb17ocXnrQEXxcb9+ZrYZXSGlNokt9voarseqhXn8omnxZT458J8JTCZM
         i6ntDyaIUdBS/exlLnXsWx1VVmSbfO/mu1gSovQ8Wgk1Qh9TxUGUmT4RPem0bRTfvH5i
         5y5hpewtZwk7+32/dzo9dQ7vP4j4Nh1MXr7szypGnqoO+UomjkreqY/KBgC6eBTDwCrJ
         /sRw==
X-Forwarded-Encrypted: i=1; AHgh+RqOY2pDm7IXjH4Kt28SavINKE/dF3edjHneGIyJWFg+g35+XENMfAbowSpcFoydBp6b/+G3UIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGtNQag4ldHX0/9bZZmTNYqxJXImKJ4BuY3mRk+Tz8IfkqYo5G
	HwZxWiXRFQrQIHXfpU/mAFdBVZaPNw+S8TgcbgUuUyf6TNSKO/oZyRhzE57qp5LCwjIAlVpbRS5
	nceL4xYUJO4G6F5F5Y+N01GSw/Y54D35nq1yqwdiO
X-Gm-Gg: AfdE7cnnPgt3TWmR3i+i3YVvHdrhdAN3teNxZ4UCP1mMyDkgWx0rjCYAqjVskp356ZM
	/g+dI4tgOaL89d5yTBs9DDCQY760AGKWAPtJAQ3rCgRrTkHOSm0nLrav4a6HpLWmoYHEPyGEeCB
	1PiJuuSa17fKV4Us30Pwshv57SLTJ0e/lTlpwectESozzc+VSsbDIFaWhjB9X9KfjJWZ/jO32YS
	hZJYy4BeAhX20ENS9lcNPjhuIbmZtOSQ0e7QvpynpQ/ZVIbnWh9sW1fcQFauX245HvUHa/gU/6Y
	2eTaluNRIomix/ekcysIm+Lv45tYcLg1TZ5FdTXMNph0locoAp0IITmxjNRA5wXaRJLC
X-Received: by 2002:a17:902:f60f:b0:2cb:402:70cc with SMTP id
 d9443c01a7336-2ce82988044mr131703855ad.28.1783957777649; Mon, 13 Jul 2026
 08:49:37 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 13 Jul 2026 08:49:36 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 13 Jul 2026 08:49:36 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260713144557.3845941-1-joshua.hahnjy@gmail.com>
References: <20260713144557.3845941-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 13 Jul 2026 08:49:36 -0700
X-Gm-Features: AVVi8Cdh7Zm2xz6VvnNu7YZe_vlQ0EdMypGL7cnWYZk8YXXL9XNBTQclMKF_wMY
Message-ID: <CAEvNRgHMsva75JcJBEw2UdmNwAvKOZb44w0-Z_dq14D8QT2LAQ@mail.gmail.com>
Subject: Re: [PATCH] mm/hugetlb: restore failed global reservations to subpool
 in alloc_hugetlb_folio
To: Joshua Hahn <joshua.hahnjy@gmail.com>, Song Hu <husong@kylinos.cn>
Cc: Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, Wupeng Ma <mawupeng1@huawei.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Zhao Li <enderaoelyther@gmail.com>, David Carlier <devnexen@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Joshua Hahn <joshua.hahnjy@gmail.com> writes:

> On Mon, 13 Jul 2026 19:50:08 +0800 Song Hu <husong@kylinos.cn> wrote:
>
> Hi Song, thank you for the patch.
>
>> When hugetlb_alloc_folio() fails, alloc_hugetlb_folio() only rolls back
>> spool->used_hpages in the out_subpool_put path when gbl_chg == 0. For
>> gbl_chg > 0 (e.g. a size= hugetlbfs mount), hugepage_subpool_get_pages()
>> has already incremented used_hpages, but the error path skips the
>> rollback, so each failed fault permanently leaks one used_hpage until
>> the subpool is exhausted and hugepage_subpool_get_pages() itself fails.
>>
>> Decrement used_hpages for the gbl_chg > 0 case too, mirroring the
>> hugetlb_reserve_pages() fix.
>
> So something is clearly wrong with this codepath here; there are now 4
> competing fixes in the mailing list currently being discussed [1] [2] [3]
> including this one and they all do things slightly differently.
> Let's please agree on what the correct solution is,
> I've CC-ed the authors of those 3 other solutions to discuss here.
>

Thanks for connecting us!

I'd like to make a pitch for centralizing the fix into the subpool [1]
:) I think it will also let us clean up the existing codepaths where
each path does its own open-coding and reaching into the subpool. Also,
if that cleanup is centralized into the subpool, we might be able to
track availability instead of reservations [4], which I think simplifies
HugeTLB reservations and removes some possible races (for keeping
rsv_hpages and resv_huge_pages in sync) completely.

[4] https://lore.kernel.org/all/CAEvNRgGN0HSJ2iLSDD2haSKOxifa-uhkO9Hwossh0+Q_d9fzOw@mail.gmail.com/

I understand the above solution is a deeper change, does anyone have any
thoughts on the approach, or existing tests other than libhugetlbfs and
tools/testing/selftests/mm/ksft_hugetlb.sh (which pass) that I could use
to prove this works?

>> Fixes: a833a693a490 ("mm: hugetlb: fix incorrect fallback for subpool")
>> Signed-off-by: Song Hu <husong@kylinos.cn>
>> ---
>>  mm/hugetlb.c | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index d6c812d1857b..8413ec92d836 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -3073,6 +3073,19 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>>  	if (map_chg && !gbl_chg) {
>>  		gbl_reserve = hugepage_subpool_put_pages(spool, 1);
>>  		hugetlb_acct_memory(h, -gbl_reserve);
>> +	} else if (map_chg && gbl_chg > 0 && spool) {
>> +		/*
>> +		 * Restore used_hpages for the globally-requested page that
>> +		 * hugepage_subpool_get_pages() counted against the subpool's
>> +		 * maximum, but which we failed to back from the global pool.
>> +		 * Mirrors the fix in hugetlb_reserve_pages() (1d3f9bb4c8af).
>> +		 */
>> +		unsigned long flags;
>> +
>> +		spin_lock_irqsave(&spool->lock, flags);
>> +		if (spool->max_hpages != -1)
>> +			spool->used_hpages -= gbl_chg;
>> +		unlock_or_release_subpool(spool, flags);
>
> Why are we unlocking or releasing the subpool here?
>
>>  	}
>>
>>  out_end_reservation:
>> --
>> 2.43.0
>
> Thanks again for the patch,
> Joshua
>
> [1] https://lore.kernel.org/all/20260708-hugetlb-alloc-failure-fixes-v2-2-c7f27cbb462b@google.com/
> [2] https://lore.kernel.org/linux-mm/20260428113037.88766-2-enderaoelyther@gmail.com/
> [3] https://lore.kernel.org/linux-mm/20260515202902.461539-1-devnexen@gmail.com/
