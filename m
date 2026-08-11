Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65240353A91
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 02:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786415499; cv=pass; b=nZ/0W7OJzQ1WM6EJRQgUvUSqibDatVT0/uv+oAXkWsY9x3XeznVgdwhtyeCzCBLn0hRjI3ehFaqcFMFusD4igHc2L8rz0uejVnGw9YDRDFzDcggNVdc1ejH8+V7szL441Ngeff2GXXYSHhSq2WM/nmTdvCAFaM+feGHFhsWWl7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786415499; c=relaxed/simple;
	bh=PXjrvIsr4R2AfKDYC7mp0sM4AWT8zdJDguJTqMb5XmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JsdcWp20be7KqtJ6LTgnGkz2u9z0Zc6lm70id6byDNpdxMPjqdEo9cBsm+oEiVfP1SFnLwEBhFQw0KwZ7lcpO0SSZG1FwOST9p6ZGE9XH6xHU70Fni/zWnUEU7CdQnqCoG8bkDRUz8e8+mG4W2mdhK85EFVrhYXdoLk5Cc02GXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=O8BY/OBB; arc=pass smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="O8BY/OBB"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7eb5bdb50fcso1608608a34.1
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 19:31:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786415494; cv=none;
        d=google.com; s=arc-20260327;
        b=WXvovpf0Rw0o7C+m0WD2bNUmRDiHiHdJfFJI42V7Jk3jPpWi1k3+tBHiAWtgvibwg/
         0cW1VedmIN/ZosqBv8wMcR6dPQ6rqDJFOZpHBZD3YR7GIrasrQU6AEv6SUlz8YG5MisH
         E3X8hEsv+/51Ml/zOod8XyaIAP2nlIq+7clxSrLkI9MgaYEoCG53nxdk7vEzzw52JcyH
         8mKonG4kMUpzEt3SR7MRNJQSEh/787yaWDXQEWcqHJ9dkLKNbYzl4yMiA6xJe4DjCWLg
         nIZhaoTWcCqkbxZ4Q1oAcl8M4/4TS54HmtjgYMQZ01dSGg/D2mwpLqJk37AehDzylxpV
         7lgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JgxUsn6bXXlTXTzE9w1hjUQJ+4UQHLS+g00NWeF1hYk=;
        fh=61gVFWe9FuveQ6EVKxRHl4xc64OtHhlnrgq+BqsOpOw=;
        b=qVUBmJ74o2LSF6bNaRUqLHt6OXM2gyoA3n9ZEVZXoMn7GtOiUwtkm9me6HYUKEFTp4
         TJeyF0ozpWoOrS3E5sUcMYtAHKCzMPdxq3pm94072voinsakx2aAP7D070YM21Hh/LKQ
         I47BbC9bCt/fIaIcooq5EYQygQDdl62crAXACa5IV7wdt6NHWkAjxp37uGUGVGN3kFMZ
         eTMObEJ4K6gF19CU6gt9Anc/zYahzDt3aWk/05Ch8BI46aXeKJcUG1rqYgalObYgRGbT
         oaBAF6xLYYZHDFnfcTD1v5ACSQ69SwX4CMM4dbkRTXsbIIYD2MJ+ipsx95YXtBmDETeF
         hhiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1786415494; x=1787020294; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JgxUsn6bXXlTXTzE9w1hjUQJ+4UQHLS+g00NWeF1hYk=;
        b=O8BY/OBBgTq5bCNw/dBoizeFouo2hQ4iXdno1eTEwfhErZ17HyFj44+P/yOid35Pzz
         tnpVM4R9LOAxhkCdvOi5+udgfvk3HUR3ARpJ3EBH7mswUBd6OUKf6ax0epWUXG5MxsIp
         MK5uY50B0ZFz3uZI7PHrwx19jrbPZypCvVSLNNZmatn2wD4ZEQYIZNeAkDIujq5lkRJY
         a+cCtMdlOGhK0mdWv1JUw2yFtbhK/UyKRnByRrBEI0u9l24PG/nf5WmZXkg2aJnsHl0N
         eUKesFLkWmiLkAKL9GEOyssNLAYBTmUHgSD7HffIy7R8Oe9Jra4ElHjC9eYsVn7EjogU
         Lfeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786415494; x=1787020294;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JgxUsn6bXXlTXTzE9w1hjUQJ+4UQHLS+g00NWeF1hYk=;
        b=IN4WwFJSz966+wqM3oE/YG+b2IFkDmH4WHVkMCxuwJc9/GYFEZp4s1oKBGyTKp2jgr
         zyI5gRhrH5sVGZVBgBJzDMM4yRgFaNEGDF1GPsBWqJ5ddhaLC7agUt0oZcl44XTtAX7r
         gMzaRvW3X9eJX5L3/NXZUd3WKxT/EqCV5zkIRNkH8rnBLQGWPgC7lUTSrV+QvwLxuTE3
         o4Mc4LQOTgX/iWinf66RxQ8u0LnS2ufTtlJIWB7vMSHC1Pln/CQhc+J7ZmFG7S7BQvWT
         i9ZVquggIQxXDnxcVRDSJLuTuiC9IqSHmCEHfsozU42mItuF/wAsATNa5gTLcUUQyTi8
         VBjw==
X-Forwarded-Encrypted: i=1; AHgh+RrmI+vcjTjxG4fxC3YzOjm8sJF5VXX1uWx8EJuqbggctj4U/kpspfCitpplm5vspiYvgUMTT/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPCTy0qEzxdbS5yiKWXDxJjrOmEyTr3DCThvtLbnxxemtrKPxh
	pZ9qu3+P8uFgL7h2s8hY4G3mSuCre2uyEM1UmDmmz0QEkUIVp3rmeyIGfZimDuEchFlMqOM6psA
	EsWgn9pei8QdmPvyh3VhnNTD5Q1Kaew6NTtuZc7dOqQ==
X-Gm-Gg: AR+sD10OUh1LmAb3ymPbQYXV3DKUiXuDd+yQeE3OHd/IGIfs+mYOD5flSAi6UQYzlXX
	h/x79mKGbaIfC91Mta85kMWjN5NFfAueGDdwdJ79wWPFDm7g67pW8EoDNWO4x3YtGvqoU4LH5oL
	VtCb3qIc+sKg0RpW7ZHiVDyuReIICqy9WnBMKNnyWcuyInNbJrjrf2AWkxdQNHD4rcwTimTpgWT
	JuTmC3H4OLhxa3/FpR1dnvfhmZKjg5SFhB8ra4cxu2ShPp6bYC5GXhgawCahtQRRtcGmCL0nJoO
	/4yvO8pPn9eKfrgjblEQNka37irhvgHBj4yNBPu/MzjC9i8=
X-Received: by 2002:a4a:e911:0:b0:6ab:f90:1da6 with SMTP id
 006d021491bc7-6b041eb0f97mr13666641eaf.2.1786415494199; Mon, 10 Aug 2026
 19:31:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806055501.56761-1-cuiyunhui@bytedance.com>
 <anQyoZgi5Urnvvjw@lucifer> <919b804b-6f1d-417e-9c0c-d06f50d765d8@kernel.org>
 <anSar_i8UjniSbML@lucifer> <a6a9e0cc-e6cf-4f83-b6be-7d64058b8fa6@kernel.org> <anSqbW1w2bDDHpAx@lucifer>
In-Reply-To: <anSqbW1w2bDDHpAx@lucifer>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Tue, 11 Aug 2026 10:31:21 +0800
X-Gm-Features: AUfX_mwbnD7l5DBw46pgAlHGrER4CbOSHy1IXkZ3P9w15OLF8_3zuFbcxsU8T3Q
Message-ID: <CAEEQ3wmJoUF5TDQDfMU_dUHnY+gg7MYG=OmmdB3Ynpdu9gJ7-g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] mm/madvise: avoid skipping pages after
 splitting large folios
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, akpm@linux-foundation.org, liam@infradead.org, 
	vbabka@kernel.org, jannh@google.com, 00moses.alexander00@gmail.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew, David, Lorenzo,

On Thu, Aug 6, 2026 at 11:40=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
>
> On Thu, Aug 06, 2026 at 04:46:10PM +0200, David Hildenbrand (Arm) wrote:
> > On 8/6/26 16:34, Lorenzo Stoakes (ARM) wrote:
> > > On Thu, Aug 06, 2026 at 01:35:30PM +0200, David Hildenbrand (Arm) wro=
te:
> > >>>
> > >>> Let's at least split out the folio check into a helper to make thin=
gs
> > >>> clearer:
> > >>>
> > >>> static bool poison_splits_folio(const struct folio *folio)
> > >>> {
> > >>>   /* Hugetlb is, as always, a world unto itself. */
> > >>>   if (folio_test_hugetlb(folio))
> > >>>           return false;
> > >>>   /* Soft-offline errors out, hwpoison traverse DAX intact. */
> > >>>   if (folio_is_zone_device(folio))
> > >>>           return false;
> > >>>   return true;
> > >>> }
> > >>>
> > >>> Then for your patch:
> > >>>
> > >>> -         size =3D PAGE_SIZE;
> > >>> -         if (folio_test_hugetlb(folio) || folio_is_zone_device(fol=
io))
> > >>> -                 size =3D folio_size(folio);
> > >>> +         size =3D poison_splits_folio(folio) ? PAGE_SIZE : folio_s=
ize(folio);
> > >>>
> > >>> I tried writing something that was neater and nicer but AI kept poi=
nting
> > >>> out how it was totally broken and I really really hate this code (n=
ot your
> > >>> fault :).
> > >>
> > >> No, I don't think any such special casing on folios is the right way=
 to handle it.
> > >
> > > I mean the issue here is the stride varies depending on whether the t=
hing is
> > > hugetlb or not (and some weird DAX thing), and the poisoning causes a=
 split
> > > otherwise so if you want to poison a range you have to account for th=
at.
> >
> > We GUP'ed a single page and now try to be smart about which other pages=
 we'd GUP
> > next.
> >
> > That's just wrong, and hugetlb special-casing is just ugly.
> >
> > The problem here is that, if we GUP'ed a page and poisoned it, the GUP'=
ing the
> > next page might fail and we'd return an error.
> >
> > But maybe that error can simply be handled? We have FOLL_HWPOISON.
> >
> > So maybe we can just use FOLL_HWPOISON and skip over the entries that a=
lready
> > return -EHWPOISON?
>
> Yup this is ugly debug code so that works for me.

Thank you for the review. Based on your feedback, I went back through the
madvise, GUP, soft-offline, and memory-failure paths and outlined the
changes I plan to make for the next revision.

The issue is that using a page obtained for one address to infer how far
the range walker can advance is the wrong abstraction.

For an anonymous large folio, soft_offline_page() splits the folio to
order-0 and handles only the supplied base-page PFN. Advancing by the
pre-split folio size can therefore skip the remaining base pages while
madvise() still returns success.

Lorenzo also raised the semantics of a range that covers only part of a
hugetlb page. Looking at a range that crosses a hugetlb boundary exposes
another problem. For example, with two 2 MiB hugepages:

hugepage A: [0, 2 MiB)
hugepage B: [2 MiB, 4 MiB)
requested range: [2 MiB - 4 KiB, 2 MiB + 4 KiB)

The first GUP resolves the last base page in hugepage A. Adding the full
2 MiB hugepage size to that unaligned address produces the next address
at 4 MiB - 4 KiB. That is already beyond the requested end at
2 MiB + 4 KiB, so the loop terminates without ever visiting hugepage B.

For MADV_SOFT_OFFLINE:

- ordinary pages and large folios advance by PAGE_SIZE because
  soft_offline_page() handles the supplied base-page PFN after any split;

- hugetlb advances to the end of the current hugepage because successful
  soft-offline migrates the complete hugepage and leaves a healthy
  replacement mapped. If the walker advanced by PAGE_SIZE, its next GUP
  would resolve that healthy replacement and soft-offline the same virtual
  hugepage again;

- ZONE_DEVICE does not need a stride case because soft_offline_page()
  rejects it.

Advancing to the current hugepage boundary, rather than adding the hugepage
size to the original unaligned address, lets the next iteration start
exactly at hugepage B.

For MADV_HWPOISON, I plan to follow David's suggestion and walk at
PAGE_SIZE using:

get_user_pages_unlocked(start, 1, &page,
FOLL_GET | FOLL_HWPOISON)

get_user_pages_unlocked() is the appropriate interface here because the
current gup_fast_fallback() flag mask rejects FOLL_HWPOISON, while the
memory-failure madvise path enters madvise_inject_error() without
mmap_lock held. get_user_pages_unlocked() acquires and releases mmap_lock
internally, handles fault retries, and propagates -EHWPOISON from the
fault path. FOLL_GET makes the page-reference ownership consumed by
MF_COUNT_INCREASED explicit.

A successful GUP is followed by memory_failure(). If GUP returns
-EHWPOISON, the address was already covered by an earlier larger-granularit=
y
injection, so the walker continues with the next base-page address. Other
errors are returned. This avoids hugetlb, DAX, and folio-size inference in
the MADV_HWPOISON caller.

Device DAX is relevant only to MADV_HWPOISON because
MADV_SOFT_OFFLINE rejects ZONE_DEVICE pages. Since the proposed
MADV_HWPOISON walker advances by PAGE_SIZE and uses each GUP result as
feedback rather than inferring the handled range from folio_size(), it
should also avoid the same granularity problem for Device DAX. A
successful GUP is passed to memory_failure(), while -EHWPOISON indicates
that the address was already covered by an earlier injection. Advancing
by PAGE_SIZE should therefore also work for Device DAX in principle. I do
not currently have a suitable Device DAX setup, so this remains untested
at runtime.

Because MADV_SOFT_OFFLINE must advance past a hugetlb replacement while
MADV_HWPOISON can use FOLL_HWPOISON feedback during a PAGE_SIZE walk, I
plan to use separate walking models for the two operations.

Before posting another revision, I plan to split the work into:

1. the MADV_SOFT_OFFLINE range-walk fix;
2. MADV_SOFT_OFFLINE large-folio and hugetlb selftests;
3. the PAGE_SIZE + FOLL_HWPOISON MADV_HWPOISON walker;
4. MADV_HWPOISON large-folio and hugetlb selftests.

Does this separation of the SOFT_OFFLINE and HWPOISON walking models look
reasonable?

For stable, would you agree that I should omit the explicit stable Cc from
the next revision?

>
> >
> > --
> > Cheers,
> >
> > David
>
> --
> Cheers, Lorenzo

Thanks=EF=BC=8C
Yunhui
