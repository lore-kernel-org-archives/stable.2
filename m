Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793273583;
	b=3V0hcS5lC1t9JzWXIIu00NciUm+BVQoknwwvo14h3PVHwPg8RmzsUFUadvNtOhlwqDhd
	 NyYOSA9hexFdijsg8z3indqBhu6Fc6Nz2PkrVH1LKDcsMKFqM3Qme78tjH1LE69iLvznF
	 jXra5SMQFbtWqyPcXt/GfdA5yIOg7GPfTxLqw+VzGoAlQytTZSd3UMAzCQePBEHt5k/Ir
	 MNIBwAkFdxLzNYj9NnmtP3cmFjQ/c76YMUpoikAUMbLBuICfKHGV2JAjaUs1qVV7oW06W
	 Y9VPUen98PIhnAeUEoIZMP8x5M/+PDUI9Y1UnXNTfG/V9ccXPNzKMSO+lnbtHuqFe1A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793273583;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=SEsAp8eo59mWI4USMvrk2DfJuqFK7nYytkvtGnfb6o0=;
	b=DVd7M8lhLff9CVLrz3oxy9U84owHsKFTFcRfmf6W1bu2POIO/+x9ytTVsbVff2TebcM4
	 jdbG9q9vkWDAXceGTNmreDaY+T+K44KZE2990IfzjgsO/47SvUgdI+MdfyEy70BShpGxx
	 IunQoHEOYIaWhV84j2Tjhwj0STv1fH4ITajunB0OCWVh+hL5AMXMcC3ee41+/4dx2ej0t
	 wwrg4x3byOChJNKjjV+ym7keCaiCR90gVD+o/xl6ae6ZwwuI/kuS6fI5pjxND8J2/I33S
	 EZYkr0fw1o4TOGX9I4fICxu/7V2B+WZi9LEKbZKfKtXXKXN8soUOa4bKsnBQd7dVWhg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=KFEbraKV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.42
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10ED606A31D
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 11:33:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F10ED606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=KFEbraKV
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6df5e315bd1so1457637eaf.2
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 04:33:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793273581; cv=none;
        d=google.com; s=arc-20260327;
        b=FbU4iUIpqiYO2kY5cfabhK5FWrg0CK+zgzcxcCit665O4f6DZtoYR3v3TnGI/uahdg
         fQU8DvM9p8CcCOa9qpg5ZkDgIKjoV1UW1B016+J/fE0oe+RVVRl7vewLyCBN5QtGBGRY
         x4AKNZFML/afO4ZX5Hw/WKjEVwrTYlbIwuz8fUMHfIzuj3XphdF+TC8eCf6Ds1aEkxzJ
         CCbeJzxMIcxzCfEhc5LA4k1jWynquoAbaGYmGzcEgdS2micnuIKHoRH7lJLvyrsVyIPJ
         /4vNH9bJTaIMs2m3Sz7Es/XsoS3v3KGgKtc7+n4xhzylvs64Lni7L9qTiibDFPzyBlY4
         Utug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SEsAp8eo59mWI4USMvrk2DfJuqFK7nYytkvtGnfb6o0=;
        fh=Sm3a2evjSpaxISZu9cufn3wsB8YRWdBypiV/pi8BMYw=;
        b=hHGX/Ew0R6hW1PxgYK0C9cXE5U1DMSlQ0X3dO0XiRjAYEf288hp14WzPhyUYfxv6wG
         z+bPADoySj6WdPI3ar88oW55y7/oKoAtjvxw9PEWMuHtz+p5Rxxp+E5CEiQtvUYUq8qA
         8TYN58WKJtjIgkp1NtX0vRCgw1gTTfGryq9IHeqhqp83nJ4HpZ8hs7zRoXoJz/+iiV8y
         4FA8HmuybfOKmMNXRV1ZRyLCsn+Qt24FbrfJ1mUkHh3Z14DLRYOc/JDkKi8F3vhXFvoo
         pFjfCzl/bikeZmJuW4rgIJCvEWFuqmGJ6b8m4iu4kL4MaMbCP7UCrXFM403qP6enIt/i
         Y6Pw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1793273581; x=1793878381; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SEsAp8eo59mWI4USMvrk2DfJuqFK7nYytkvtGnfb6o0=;
        b=KFEbraKVW7fUuXQBFvZ81tX96XlEJi0iIFiLju8j9dPNKY1JXR0eLkVvhemyA1zkj9
         mGQ4qzIQPPXAilrHQd8MqBvXNLA0KxA5V7rKjQcVuhuOXLzjxHGR5HBUKPSJNTp5lyCJ
         Npz89BtdA+dipigKTToxV/R0/XuDWsAnAc+wkmviz41aJlIPrXyZ6rTcEWdHgdNq9X0x
         +sDrXbnfovYgwzIgtzaXiBPEiPs3MCOOkbXXKlLW181JY1lpLRNGxJYr0f+1qt6wMO3d
         HL3RU3zn/o8aLyJuC8pHDhosV3DSZB68aOotBR3N8oXTc3NfrERtm9nFVAXugK6ILtu/
         vPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793273581; x=1793878381;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SEsAp8eo59mWI4USMvrk2DfJuqFK7nYytkvtGnfb6o0=;
        b=PJPKfKm8pwal9fPdCPiZfYEPgXfHXbVBpIrxuearasAauZCAoaeuNwjX1fety+y+ip
         YHcEP6vKyJNUajCoQf91MRF6I9dbT+WqTiUWg1bZlVtOtjRPE3Wx2cAIcywTK0oE3wX1
         IN+UBPqHzGMY55TYU24Vx42GE/Q1yUoivglsE0hGhxGXTpjZp8BftrlE1cnMakolP6fn
         +tE0hFwHKEHhTJpuUGvDKX+aAU8Oc2hCCNP2HiaFpQvY75/epn/tEwvzAiHea05G9GdI
         +ghfc4zn1dmAsuRuDZSiGMd9Yl1QbKjiYXefo9vxmGvx6jiSKzz7l5tiilvVFA+WyVs8
         KgXA==
X-Forwarded-Encrypted: i=1; AKwUvBx900OxcWeJmipUI8GsXO637PKOw1zN8QzhlMBpBydVQ+I8cS6SIEXo4FAyt970PdJ9NggD0RA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJWmgmKwqGgCvDgY3RK9exLYaYkrNtr8TirVMc1AGvF/Wyi2ALO
	Cxe6DmfEQiuXOoPtrjZsHdIbH+W007TUENM4gqxpqvx5OS92qWll5AMEtyZ3wBl4OcCSi/e5gQQ
	P+7/VAQ6kWXQPKzsA+jMncZgPYHTeT/Vk0newcACuLA==
X-Gm-Gg: AYBFou2KHa+THP3DFiO3WRTNqjH/nIK77CJqXpZYCaqQK8NEaCqDCn+B1IZqVBP52kF
	rdxsVK9VGUaYpbjHYmBHdPh9RTN7//pilLdvrwH5dGIGqYsrSTta+DQRh8dqPkNP3tQQPHEm3ty
	4x6MI66hW47UAysjkF4iVDGFjYIXphDL5UTZdySoNT8kXpKF4euA6xuxKMi5cDNPBDSjupj7bpe
	MlwiwK768ntAi65+Mxt9x1lfR42i/vXYydAqRz7IpCtEZo+NWJ5EGhnN91aINFmWNIwg4Psvm8H
	2MUQyFnBxECraEogl9sIfURGcmWLZV1yFisIHw0bJrZn0kvPHaJF+rLp4wasYZXOQ778UqZcJJO
	tzyFDO2jaPk6piyEpYBUcLNaxtqmTaV98k1+mBVpeZNhs3jFDIOHvVdimxNXp+VAN3HX4tHQ=
X-Received: by 2002:a05:6820:a514:10b0:70e:2d38:4b70 with SMTP id
 006d021491bc7-713eef43a73mr2044037eaf.7.1793273580795; Thu, 29 Oct 2026
 04:33:00 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260806055501.56761-1-cuiyunhui@bytedance.com>
 <anQyoZgi5Urnvvjw@lucifer> <919b804b-6f1d-417e-9c0c-d06f50d765d8@kernel.org>
 <anSar_i8UjniSbML@lucifer> <a6a9e0cc-e6cf-4f83-b6be-7d64058b8fa6@kernel.org>
 <anSqbW1w2bDDHpAx@lucifer> <CAEEQ3wmJoUF5TDQDfMU_dUHnY+gg7MYG=OmmdB3Ynpdu9gJ7-g@mail.gmail.com>
 <3882e553-4be3-4b2d-b884-4443032e7853@kernel.org>
In-Reply-To: <3882e553-4be3-4b2d-b884-4443032e7853@kernel.org>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Thu, 29 Oct 2026 19:32:49 +0800
X-Gm-Features: AclHuK-NsCthzCzymfm9IrdjWCbL02wiGiuXLxLhRNRDCgpTPiA9M8Ic3D1KQcI
Message-ID: <CAEEQ3w=t4fCXZSqDUZ+XQCJ7UhtrKz+TSM=H8y=JvdAoJG9NXQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] mm/madvise: avoid skipping pages after
 splitting large folios
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, akpm@linux-foundation.org, liam@infradead.org, 
	vbabka@kernel.org, jannh@google.com, 00moses.alexander00@gmail.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

On Tue, Aug 11, 2026 at 10:49=E2=80=AFPM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 8/11/26 04:31, yunhui cui wrote:
> > Hi Andrew, David, Lorenzo,
> >
> > On Thu, Aug 6, 2026 at 11:40=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kern=
el.org> wrote:
> >>
> >> On Thu, Aug 06, 2026 at 04:46:10PM +0200, David Hildenbrand (Arm) wrot=
e:
> >>>
> >>> We GUP'ed a single page and now try to be smart about which other pag=
es we'd GUP
> >>> next.
> >>>
> >>> That's just wrong, and hugetlb special-casing is just ugly.
> >>>
> >>> The problem here is that, if we GUP'ed a page and poisoned it, the GU=
P'ing the
> >>> next page might fail and we'd return an error.
> >>>
> >>> But maybe that error can simply be handled? We have FOLL_HWPOISON.
> >>>
> >>> So maybe we can just use FOLL_HWPOISON and skip over the entries that=
 already
> >>> return -EHWPOISON?
> >>
> >> Yup this is ugly debug code so that works for me.
> >
> > Thank you for the review. Based on your feedback, I went back through t=
he
> > madvise, GUP, soft-offline, and memory-failure paths and outlined the
> > changes I plan to make for the next revision.
> >
> > The issue is that using a page obtained for one address to infer how fa=
r
> > the range walker can advance is the wrong abstraction.
> >
> > For an anonymous large folio, soft_offline_page() splits the folio to
> > order-0 and handles only the supplied base-page PFN. Advancing by the
> > pre-split folio size can therefore skip the remaining base pages while
> > madvise() still returns success.
> >
> > Lorenzo also raised the semantics of a range that covers only part of a
> > hugetlb page. Looking at a range that crosses a hugetlb boundary expose=
s
> > another problem. For example, with two 2 MiB hugepages:
> >
> > hugepage A: [0, 2 MiB)
> > hugepage B: [2 MiB, 4 MiB)
> > requested range: [2 MiB - 4 KiB, 2 MiB + 4 KiB)
> >
> > The first GUP resolves the last base page in hugepage A. Adding the ful=
l
> > 2 MiB hugepage size to that unaligned address produces the next address
> > at 4 MiB - 4 KiB. That is already beyond the requested end at
> > 2 MiB + 4 KiB, so the loop terminates without ever visiting hugepage B.
> >
> > For MADV_SOFT_OFFLINE:
> >
> > - ordinary pages and large folios advance by PAGE_SIZE because
> >   soft_offline_page() handles the supplied base-page PFN after any spli=
t;
> >
> > - hugetlb advances to the end of the current hugepage because successfu=
l
> >   soft-offline migrates the complete hugepage and leaves a healthy
> >   replacement mapped. If the walker advanced by PAGE_SIZE, its next GUP
> >   would resolve that healthy replacement and soft-offline the same virt=
ual
> >   hugepage again;
> >
> > - ZONE_DEVICE does not need a stride case because soft_offline_page()
> >   rejects it.
> >
> > Advancing to the current hugepage boundary, rather than adding the huge=
page
> > size to the original unaligned address, lets the next iteration start
> > exactly at hugepage B.
> >
> > For MADV_HWPOISON, I plan to follow David's suggestion and walk at
> > PAGE_SIZE using:
> >
> > get_user_pages_unlocked(start, 1, &page,
> > FOLL_GET | FOLL_HWPOISON)
> >
> > get_user_pages_unlocked() is the appropriate interface here because the
> > current gup_fast_fallback() flag mask rejects FOLL_HWPOISON, while the
> > memory-failure madvise path enters madvise_inject_error() without
> > mmap_lock held. get_user_pages_unlocked() acquires and releases mmap_lo=
ck
> > internally, handles fault retries, and propagates -EHWPOISON from the
> > fault path. FOLL_GET makes the page-reference ownership consumed by
> > MF_COUNT_INCREASED explicit.
> >
> > A successful GUP is followed by memory_failure(). If GUP returns
> > -EHWPOISON, the address was already covered by an earlier larger-granul=
arity
> > injection, so the walker continues with the next base-page address. Oth=
er
> > errors are returned. This avoids hugetlb, DAX, and folio-size inference=
 in
> > the MADV_HWPOISON caller.
> >
> > Device DAX is relevant only to MADV_HWPOISON because
> > MADV_SOFT_OFFLINE rejects ZONE_DEVICE pages. Since the proposed
> > MADV_HWPOISON walker advances by PAGE_SIZE and uses each GUP result as
> > feedback rather than inferring the handled range from folio_size(), it
> > should also avoid the same granularity problem for Device DAX. A
> > successful GUP is passed to memory_failure(), while -EHWPOISON indicate=
s
> > that the address was already covered by an earlier injection. Advancing
> > by PAGE_SIZE should therefore also work for Device DAX in principle. I =
do
> > not currently have a suitable Device DAX setup, so this remains unteste=
d
> > at runtime.
> >
> > Because MADV_SOFT_OFFLINE must advance past a hugetlb replacement while
> > MADV_HWPOISON can use FOLL_HWPOISON feedback during a PAGE_SIZE walk, I
> > plan to use separate walking models for the two operations.
> >
> > Before posting another revision, I plan to split the work into:
> >
> > 1. the MADV_SOFT_OFFLINE range-walk fix;
> > 2. MADV_SOFT_OFFLINE large-folio and hugetlb selftests;
> > 3. the PAGE_SIZE + FOLL_HWPOISON MADV_HWPOISON walker;
> > 4. MADV_HWPOISON large-folio and hugetlb selftests.
> >
> > Does this separation of the SOFT_OFFLINE and HWPOISON walking models lo=
ok
> > reasonable?
> As Lorenzo says, this reads AI generated.
>
> I assume what you mean is:
>
> MADV_HWPOISON will actually hwpoison the pages. We can just use FOLL_HWPO=
ISON +
> -EHWPOISON and should be good. So far the theory.
>
> MADV_SOFT_OFFLINE will migrate pages instead. So if we don't skip multipl=
e
> pages, we could end up migrating multiple times (and setting hwpoison mul=
tiple
> times).
>
> Well, for large folios (except hugetlb) that's not a problem, because we =
try
> splitting to order-0 either way, and if that fails, we bail out.
>
> So what remains is hugetlb, which is nasty.
>
> I don't really enjoy having any special-casing here, because the moment w=
e e.g.,
> change how soft-offlining deals with splitting, we would be in trouble.
>
> Assume we start support splitting to min-order at some point, we'd also w=
ant o
> skip over min-order. Gah.
>
>
> Can we just make our life easier and disallow specifying ranges for
> MADV_HWPOISON/MADV_SOFT_OFFLINE?
>
> It's a pure testing interface IIRC. tools/testing/selftests/mm/memory-fai=
lure.c
> seems to always call it with PAGE_SIZE. Similarly
> tools/testing/selftests/mm/hugetlb-read-hwpoison.c
>
> There is one catch I think: an existing LTP test case issues MADV_SOFT_OF=
FLINE
> on a larger range. But it respects -EINVAL at least :)
>
> So we could return -EINVAL and fixup the test case to issue multiple madv=
ise().
>
> [1]
> https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/sy=
scalls/move_pages/move_pages12.c

Sorry for the late reply, and thanks for the feedback.

This turned out to be more involved than I expected. I am not an
expert in the memory-failure/hugetlb area, so if someone is interested in
taking it over, that would be appreciated.

Thanks,
Yunhui

>
> --
> Cheers,
>
> David
