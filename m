Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794436003;
	b=oAvmYNfWH334KIL9tXOSSl6RFOQwUX0GXMxrXQcxV1gWA5CRZWPlMe/7D4ZM8P0w/3Fg
	 FLHwGu4bo/0u5Bvn9mP6hj6BCUHjdPcvQ3VrAVq78Xs9QUOOOqXdbC+WJDKHK7Zj0PfoZ
	 AtXq492jYcXpK0kFnt8jIjR4EN4EPRh3sePv0OqRVwuGvxCs3hL5K0hx436dQtaD0LUOh
	 YHSkCzEW6k+GTwU8auyrXA28Nq7GgjLSRXLnUH54hhOLA9121j2WX3Een6LzGRt14v6g9
	 hGZfbbe5464roGbkLmbw6PjisgCbJM31sbxglWI8NrKzPVve3PTqXC7d5NR4PdeWMsw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794436003;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=0qXxJbBqWWiSbLfZQoa2Zp5mRREk6/0luQcqtAQF1PU=;
	b=gK8/WhryzR2noaDNkQGWD6+b1HOUrJ30Oq/IlrCJehaBRwsif+65mNebpnZ8yEpSE6LO
	 wPgc86fkQ8jc2ZVR/vuFMZbQxQjupDVKSXLEcRAYccbZCqHpYpWtZeKllGwaGUTrxo6qQ
	 9AG6IMjJ+YkYA35IytvUtjvCBn7cgIjsN8EBC1JLTufGl6vU8WXnRqrhsKMDKa8sykTq9
	 ktlUIldy1NzxRNQJziYFMVMfPlhiPji+pK85EI/6E76kl+RNHaAuwAsFPNm1qSWJ/Dl6d
	 avcp/JEdV0qRV1WgrfOVOJLaK7XF1w242HUu89Us2nOE1Iosf56AyyNit/LiOsOcy7A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UCuaRIHD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA1F606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:26:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACA1F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UCuaRIHD
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-533202fe429so28911cf.0
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 14:26:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794436002; cv=none;
        d=google.com; s=arc-20260327;
        b=H35IpsVR6Cu4tRX7f30PICgzhK2tYEp7RnRP/U6rStU8W5Qt5SU50b3pw6O/8Lv9At
         5sqPfi9+ffP25/jrMuls2Bzc5j8BgPHmYEMNpRvHFfvyFgssSKm+scIP9whq9VKqmk8b
         6sfEoW6GzWWqWhcS37jPWNgiOQ2Kn0A3MHOZE6LwHB2kRH20ZuN3r33AkCfDGk7qLOej
         W6oOS+vJ7y60D0NUwoA3bf/CV3TRK88waczAcoX453CRpbiIWnpAdKRl4RnSMBbnzj3/
         9NKzdqK3/fiKazPJr+i4h0NRRSyUwpwOdGJ4gXTP+dkLLGJqcwtDleK3o9O89Rizs0Wx
         Lg2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0qXxJbBqWWiSbLfZQoa2Zp5mRREk6/0luQcqtAQF1PU=;
        fh=hZRyKM6aktcUe+Uc4adW+VFuQrDZAIyDXpa5mXZJApA=;
        b=e9B6evX2qVXqf0+15qZ5ve8CGsk5GycEtTq17rKzBvZOO8mZ2cPfSa0LhKpc0X8MKr
         m9v00i2SHzCyQE9Xr677t/Pu2QDecm+Xw4kPUxEh4JNbK15/Srw549ZEW/dvClO1uJpI
         3uQQUM30i8ZC0kLUUYXhQNv2RRepG8LFfKroEK9cM0fRxTEtqlUPytELHgW9dYNiClgS
         Ff3UTMk5b6bTaVvpDrOMU+H+2mcqM5psnmk0K31kcio3tULz4GIcZhg6ejucERfJ1mhr
         gLbUZQJDm7HzYjowOkmwTj1diMwRZHmDfiMF5rA7CMFX7zXDzGNV1Ox+NiFka+copE2S
         jipQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794436002; x=1795040802; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0qXxJbBqWWiSbLfZQoa2Zp5mRREk6/0luQcqtAQF1PU=;
        b=UCuaRIHDR1v09nZ+20R0pIYkXK/Zw8oSxZdnbR+K8deJYoMO4K8zSW/Ufqc1BNwGdA
         78CsiV1ewWjSn4MXgiZqu2dhjzeC3Rah7HNq5uG37/t6rJtValM/yZDBnNteOdZrzNsl
         S40FxJRKh2JyKZQ3V7x1AF8FudlbeOrNUY3CSxd8TOf4qLoq2abD0mgaf3xYkECePmQe
         E4wuRwVBxYNOd1Bx7QL0R6ibmSJXI/4mMf+t6ivJANt4SiLFbUjMj7GWlP8SAOGM2Dz3
         CQK9WwNxJ/suMgBPE8HyshQ8D8mG5igzTFAazrQaRpYvXgztiG+Q5zqNtGzcc5QkaskD
         cNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794436002; x=1795040802;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0qXxJbBqWWiSbLfZQoa2Zp5mRREk6/0luQcqtAQF1PU=;
        b=ZjVqw7IN9/QwBoW/is7NKUklIz/XnoKn6J5MWZE2AMpQad5+GrlaMf8V2KYkpICXsD
         Qp4+nEp+4Uun13BbJ42VhHHX5pGVNjg9VydHE5jT5FZn8csHDsfQdsH6hloKuGjlLHUP
         xkw1kYVJR6+hjvVDU1b9yOoGy6OisXZRBmZjQkFPQIivBNUadf8bIP6lhr9++2xmz80Z
         B4iMFkt3fFdtDl84i7tc8LCRC+39eZD6aJ4qYF/MvxSMtT//IKJrOpSji9aQeJJZANpy
         73an2fsrc/tlDP5EgdaAHREasjFarM549W7t4Slke/qzFzhfjukltE3Hk/kk3/q6OoHw
         2WXw==
X-Forwarded-Encrypted: i=1; AL+hErEU5gzXJ816yqz90pWYgnCnBbY//pAhODMiU7LTXECueK6Ayh1Um1I+7pCg0OaJMdz/UuGIQ1s=@vger.kernel.org
X-Gm-Message-State: APuU4Z9YjjwP13OoVNUlpCq0AAHGyP+YzzFdgfB2G+I+rjaV5BRCHv1W
	oH/FQCfaZ4HykuQ9tqPEtAXw32MFZXU97kuRtPmTJd7pvYoUFN/mCxEHzOvwe6ORsleILrLdsSV
	M9/7xWNPJiwlx0eaFWO6Tp5Xg5o8UB4oqqsDFPcBo
X-Gm-Gg: AYBFou0GaBGWVEgYsmC9HEzd0b0nTwYIbBhknuRjVIemnyMPMzHO3AR4kggWQSDYnNM
	Bg4eXHf9XnUtlCTSwneTtK8HUkDKd/7fHbY8d1KcIph51VEn15SrAJ88+ZwgG5INB2zkpJ6nWb9
	jGRCFV8EABKVo4ezyvb1dTZsuSD9QUOa8xPuec/CYCu2eKQRWsD2zutR65RqJAjM/qhfw6TkmE5
	4wmeqxdfFNaK147oPvNRPlILsXBasvb2TTKPXXBkE0j7ZVB70G9JkxqXfasZaLz+xFLccPdni9E
	D1cMS/cxCMDbbECpQBTjLP/xCRv8h4lIPll/RjokzZ9KuCeoMi/8MSKXY4ogtnycKnjXfw832sF
	zNfTv8UOFGDK1m5IiKFiV6K3FXKCLqkB9tsI+
X-Received: by 2002:ac8:5c84:0:b0:534:d386:c3f1 with SMTP id
 d75a77b69052e-5598d505571mr2598201cf.9.1794436000897; Wed, 11 Nov 2026
 14:26:40 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1794046188.git.zhengqi.arch@bytedance.com>
 <586d6c53ab7e4c64d6e89ad3cf0cf7e07dabbfaf.1794046188.git.zhengqi.arch@bytedance.com>
 <7abb3aa1-385a-422f-86bd-7aac9661c4d8@kernel.org> <423c9b28-ecf2-4fab-817d-2fb326690c73@linux.dev>
 <3a1a3bb5-0b01-4f20-aa0e-74a952544b8c@kernel.org> <5f68ffba-9f56-4e31-9e7c-9d110f552efc@bytedance.com>
In-Reply-To: <5f68ffba-9f56-4e31-9e7c-9d110f552efc@bytedance.com>
From: Frank van der Linden <fvdl@google.com>
Date: Wed, 11 Nov 2026 14:26:30 -0800
X-Gm-Features: AclHuK8ui2RDy0cmaEz9Z61Dze9vT6ffy1pZqe99lY-d2GDxcD7lU32xjKq4-x4
Message-ID: <CAPTztWb0XbjCxtihyp=Tx16Z_kjF+M8sa7YcUjvFv0WcS83MAg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] mm: gup: allow long-term pins of CMA-allocated
 HugeTLB folios
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, muchun.song@linux.dev, osalvador@suse.de, 
	akpm@linux-foundation.org, azpijr@gmail.com, lance.yang@linux.dev, 
	Qi Zheng <qi.zheng@linux.dev>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 2:27=E2=80=AFAM Qi Zheng <zhengqi.arch@bytedance.co=
m> wrote:
>
> Hi David,
>
> On 11/11/26 3:43 PM, David Hildenbrand (Arm) wrote:
> > On 11/9/26 04:10, Qi Zheng wrote:
> >>
> >>
> >> On 11/8/26 1:58 AM, David Hildenbrand (Arm) wrote:
> >>> On 11/7/26 11:30, Qi Zheng wrote:
> >>>> From: Qi Zheng <zhengqi.arch@bytedance.com>
> >>>>
> >>>> Long-term pinning treats explicitly CMA-allocated HugeTLB folios as
> >>>> unpinnable, causing unnecessary migration or pinning failures.
> >>>>
> >>>> These folios already own their CMA bitmap ranges, and memory blocks
> >>>> overlapping CMA areas cannot be offlined. Allow HugeTLB folios with
> >>>> HPG_cma to be pinned directly, including in ZONE_MOVABLE.
> >>>>
> >>>> Fixes: cf11e85fc08c ("mm: hugetlb: optionally allocate gigantic huge=
pages using cma")
> >>>> Cc: stable@vger.kernel.org
> >>>> Suggested-by: Muchun Song <muchun.song@linux.dev>
> >>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> >>>> Acked-by: Muchun Song <muchun.song@linux.dev>
> >>>> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> >>>> Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
> >>>> ---
> >>>>    include/linux/mm.h | 29 +----------------------------
> >>>>    mm/gup.c           | 31 +++++++++++++++++++++++++++++++
> >>>>    2 files changed, 32 insertions(+), 28 deletions(-)
> >>>>
> >>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
> >>>> index 2d0b8a4c9974f..75dd40265d3f4 100644
> >>>> --- a/include/linux/mm.h
> >>>> +++ b/include/linux/mm.h
> >>>> @@ -2975,35 +2975,8 @@ static inline bool is_zero_folio(const struct=
 folio *folio)
> >>>>            return is_zero_page(&folio->page);
> >>>>    }
> >>>>
> >>>> -/* MIGRATE_CMA and ZONE_MOVABLE do not allow pin folios */
> >>>>    #ifdef CONFIG_MIGRATION
> >>>> -static inline bool folio_is_longterm_pinnable(struct folio *folio)
> >>>> -{
> >>>> -#ifdef CONFIG_CMA
> >>>> -  int mt =3D folio_migratetype(folio);
> >>>> -
> >>>> -  if (mt =3D=3D MIGRATE_CMA || mt =3D=3D MIGRATE_ISOLATE)
> >>>> -          return false;
> >>>> -#endif
> >>>> -  /* The zero page can be "pinned" but gets special handling. */
> >>>> -  if (is_zero_folio(folio))
> >>>> -          return true;
> >>>> -
> >>>> -  /* Coherent device memory must always allow eviction. */
> >>>> -  if (folio_is_device_coherent(folio))
> >>>> -          return false;
> >>>> -
> >>>> -  /*
> >>>> -   * Filesystems can only tolerate transient delays to truncate and
> >>>> -   * hole-punch operations
> >>>> -   */
> >>>> -  if (folio_is_fsdax(folio))
> >>>> -          return false;
> >>>> -
> >>>> -  /* Otherwise, non-movable zone folios can be pinned. */
> >>>> -  return !folio_is_zone_movable(folio);
> >>>> -
> >>>> -}
> >>>
> >>> Moving code while adding new stuff to it, please don't.
> >>>
> >>> Move code first, then modify it.
> >>>
> >>> I don't want to play "find the difference between two pictures" on a =
Saturday
> >>> evening.
> >>
> >
> > You resent your series way too fast.
>
> Got it.
>
> >
> > Now we have discussions in to threads, congratulations ;)
> >
> >> ;), got it.
> >>
> >> I moved the code to resolve a build dependency.
> >>
> >
> > Why can't that be resolved differently? What is the dependency?
>
> The dependency is that the new check wants to use
> `folio_test_hugetlb_cma()`, which is a HugeTLB-specific inline helper
> from `include/linux/hugetlb.h`.
>
> `folio_is_longterm_pinnable()` currently lives in `include/linux/mm.h`,
> while `include/linux/hugetlb.h` already includes `linux/mm.h`. So I
> can't simply use `folio_test_hugetlb_cma()` from `mm.h`
>
> >
> >>>
> >>>> +bool folio_is_longterm_pinnable(struct folio *folio);
> >>>>    #else
> >>>>    static inline bool folio_is_longterm_pinnable(struct folio *folio=
)
> >>>>    {
> >>>> diff --git a/mm/gup.c b/mm/gup.c
> >>>> index 2b405cce2ca5c..f41701c603500 100644
> >>>> --- a/mm/gup.c
> >>>> +++ b/mm/gup.c
> >>>> @@ -2216,6 +2216,37 @@ struct page *get_dump_page(unsigned long addr=
, int *locked)
> >>>>
> >>>>    #ifdef CONFIG_MIGRATION
> >>>>
> >>>> +bool folio_is_longterm_pinnable(struct folio *folio)
> >>>> +{
> >>>> +#ifdef CONFIG_CMA
> >>>> +  int mt =3D folio_migratetype(folio);
> >>>> +
> >>>> +  /* These HugeTLB folios own the CMA memory, so they can be long-t=
erm pinned. */
> >>>> +  if (folio_test_hugetlb(folio) && folio_test_hugetlb_cma(folio))
> >>>> +          return true;
> >>> More hugetlb hackery ... don't like that, sorry.
> >>
> >> Agree.
> >>
> >>>
> >>> I think this just goes down to a problem we discussed a while ago tha=
t is
> >>> independent of hugetlb: we'd need some way to identify that the the p=
age was
> >>> actually allocated by the CMA owner, and it's not just some other mov=
able
> >>> allcoation that ended up there.
> >>>
> >>> For something generic non-hugetlb thing, can't we call into CMA to as=
k whether
> >>> the current chunk is marked allocated?
> >>
> >> The existing bitmap is set before allocation completes, so the range
> >> may still contain borrowed movable pages. A set bit alone cannot
> >> establish ownership.
>
> The more accurate code path is as follows.
>
> Assuming the 2M buddy allocation is successful, page P is borrowed from
> the 1G CMA area.
>
> Now, proceed to request a new 1G huge page:
>
> only_alloc_fresh_hugetlb_folio
> --> alloc_gigantic_frozen_folio
>      --> hugetlb_cma_alloc_frozen_folio
>          --> cma_range_alloc
>                  /* set bitmap!! */
>              --> bitmap_set(cmr->bitmap, bitmap_no, bitmap_count);
>
>                  <time A>
>
>                  /* may fail */
>                  alloc_contig_frozen_range
>
>          /* set HPG_cma!! */
>          folio_set_hugetlb_cma(folio);
>
> At time A, for page P, a bitmap was set, but HPG_cma was not set.
>
> If a concurrent FOLL_LONGTERM pin uses the bitmap alone to determine
> ownership, it could incorrectly allow P to remain pinned. If
> alloc_contig_frozen_range() fails, cma_range_alloc() clears the bitmap
> bits, while the long-term pin on P remains.
>
> HPG_cma is set only after explicit CMA allocation succeeds. It records
> the folio's own CMA ownership, whereas a set bitmap bit can represent
> another allocation's in-flight reservation. Therefore, the bitmap
> alone cannot replace HPG_cma in this check.
>
> >>
> >> A generic query may need separate ownership tracking, such as an
> >> owned_bitmap recording successfully allocated pages. Its updates and
> >> lookups would also need to handle concurrency with fast GUP.
> >
> > Or simply two bitmaps? "trying allocation - allocated"
>
> As a fix, perhaps this is a bit too complex? :(
>
> Alternatively, we could adjust the timing for setting the bitmap, though
> this might introduce new concurrency issues.
>
> Thanks,
> Qi

Yeah, ideally there would be a way to identify folios allocated
through cma_alloc. But that would probably require.. dare I say.. a
page flag. Trying to check bitmaps does seem too complex.

And, since we've had a local change that does exactly the same thing
for a few years (which I apparently forgot to send along with other
hugetlb_cma changes), I can confirm that this looks good to me and
works. So,

Reviewed-by: Frank van der Linden <fvdl@google.com>
