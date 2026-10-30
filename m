Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793345462;
	b=nLcLHcZe0a3AIATm0HbCLTCokUIm1StPMoULjh4+sR0+P7XBpe4tBXG+lPXTC/64tGlz
	 iyfa2LuadDCFwQLqFPtaMlD/EG66zX0lwo2UEdnMaY45tLlkL+/sVacv6tLOue6ZpBbdv
	 zCPzakVITMKtDu1rbh5uqdvZzMBA54Xer6HC7KYzRrMxEyyepprQZ8YnOMhoruD+9szff
	 vsF1KHM2tzcN1ME0uFrc9XoUyGKLvUwCnNaN+xhMOPuHXwD7+j9a56UEckZySp5ocog9K
	 Q/45Fk4jvdVtN15rBRy8k7DZ+n0ZCvJgN1fZ207KqkExa44KWgJjUc0gNyGltrr4eKw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793345462;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ricWTCs0M4NsESlZHHSGvxdphtzZh7pRSrlVHDLTA7E=;
	b=s7rj6Frs10yZh7ljAiOnQhUhB5jPi6ANvW66ecLXWYSgcWLWK1cRuzJZ1YHdwg0bUBxG
	 NF/Cq4GqKIBjyd9TUX0WKG0jkMqflBhSZ42g7MvYu6/a09WYnNSEw00pCdRpljc+nt/Ss
	 HmrcSIoJXY3ON/ezZJoeC/6LcMw29WCFQ4qPUzIARDNS6ahuyQiG29HF8hyCC8RNVHZoK
	 NT520MbdQlNbZg/NFKLLNgWhgqjE+w+AUFnGV9h7e9soyRchozMqwB+O+qoJt0bro4png
	 Bgq3V1LukUjlWUZS/gnMCdn7BGOMj64B79HlOo/ouOj7V3srexe0Cj4EUpwyGagCdmw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nYCh61Ea;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF06606A31C
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 07:31:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DF06606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nYCh61Ea
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c3fd91337baso48805566b.3
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 00:31:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793345460; cv=none;
        d=google.com; s=arc-20260327;
        b=mfHWSooWdoVpPwxMxvAY8tFCCVg6G5chowgA8HRApYBkXeHA+bxikpAVM6tB0RrZqd
         pU/A8bHd9U9np+xA1bpJqUcC7Z1tEyOHtQ4R3PafS/MsFQiaa0yRe9+0t6mkRKwIcr3j
         X1cK3tcSXxN8oYXwmsCK39atBYRmTzrALL3XtUCYdih/fySzGN+f7t52c324pniZhalY
         ka+hyuzeMLHnogG/LPR5vVnRWmF5xrjPVsTV3RsHqH5XGYrI6WvC4r5tHi0DVQ7hw4J2
         guiXx6ogIC8dCNV2/9AI4cPpOB1T3ySddM5foksDs1hzkClSOV24mQ7EG6vOKZ9FuUzB
         B7Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ricWTCs0M4NsESlZHHSGvxdphtzZh7pRSrlVHDLTA7E=;
        fh=zaA06TJqa7Z51qurZ457JwG968RbLl5bN3/LZa6mWH0=;
        b=ZQtmiO1/i4uMwVK90naC2qaC/QHe8o2NrruP+K76kwa4u0ldXQOg2jv7AmSY9/14bf
         qWjnEPY6bG1RkFYfz3+2ypvuFttNHflA0pRFRm92ov+065DsNs32GJGjeCrLsDBhAZni
         RLwP/nnsiTa+LHpjUueVuFHmTESgvx+P/7QJgBBovtR2O7pB+ZqPU8OigesrO2KfFEaP
         wNgKlW2Qsv5iRnqp/Dzp5ZklmswzrvdLlWG75Pb6n3ADG9nWT8HzOLtAkQXSImSV5TcP
         PtsbtgxFA6s7Ubtv3AstCBFlVz82njNrUuataqNNeQ+pmeT4nFg7GnE1T7XT9MDH/xGA
         jn/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793345460; x=1793950260; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ricWTCs0M4NsESlZHHSGvxdphtzZh7pRSrlVHDLTA7E=;
        b=nYCh61EadQLM/wqJ+snUmPMgI7slVWEW1E7vHasGasP4v+YCMch/PQEosubLG/BWU0
         o+zg/H9kHstU22yy0r86r/npXPikuhY7i+OfOHOVoFwHZI3w6w0qyQid3Rnjew3fLVgJ
         MR94YAkd3qMDJK6QbZOeJGNRoTuY40+rWp0eZckzHjWb9BTQFISjd/HoN9fY9X9WqO1J
         bbpqJKktxfIcubtQeV3MyF9q9A336wl4dKUPr7Ncvn/QFbcyVjKWVLGsLo3TMRfBf4My
         iLtDBo0TvcLq9HDAajhxvGoiMXCDd5RsT38ya/TgUopnj7ElYlVcqxNWdrd/JMW+Cnml
         0Stw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793345460; x=1793950260;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ricWTCs0M4NsESlZHHSGvxdphtzZh7pRSrlVHDLTA7E=;
        b=R6/ApYAD7Lovm3b8vkQJWr2/RHC3lRFencS8g3B0QPiAxpI8NZIBFRvhpsT4UwyhPl
         imFeMbXo+ccxTapP7sAitOV4q0YFPqXI48p6H+sRtMtJ2HKKgJsAGLLTqsu5ffY3BcJx
         ikXfx+u1zn27puBc/p3YrSRXkr3Ta2FV0wRtUHORp0PSkZn3lFtGqxeI0+BruNXq9nlc
         /lFHSp8ydlqfAtDPE9EMBEzb/ILPWscYosbgsHi+w8VkOPg1WG3Bt8dSVHY3LLWe4YEk
         +f4Gu+zIyYFk+XQTpMWdzGh8kXSpOjTk3DTxwMpxyhB2qU/nzuL1+XpAPi9eiZbWYpRe
         5hOg==
X-Forwarded-Encrypted: i=1; AKwUvBz7bLorYapR+XPDKatTG0jzHguKC6OTbSb9JzlWIDHZ3u6e2yF5dqmj5E6XdpySdix9ilej5hA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIfi+3/wsmgzyiwlCjwbD13aCJWkcKZ/MLzwOciawNJhPvfkV5i
	srTOjIpVPTtzvm9rawgIle+XamfuZVxnVDnMTsyi4+gnXH/nt33svM/oHNukj3oiTt1EeS2cWpx
	ZruOh1bC82lgEec0Ifld+FfAw9pyc1ZY=
X-Gm-Gg: AYBFou3kYntYsxMKDTgWWkB+U7HfHujxYtf7oReMjXnpg7ngeuQcWTUmSTT3H3ao/lw
	De8SS2QUrNUirn42pcD2xQxSut4KMU0nsiqfFpdhh6cz3s0U++kDBRm+j3/ImpTjMWYOm1zn2gJ
	FtfRzTiJPKXgWaqpk0vtNXYrIVIgXnxrOT6PPgQj0CCpuQMQpiP2cZVrFR4wWxVoWn86MK/JTmI
	e+69Y/jXt5nAuhSfYH1Sx4FQ3trFqMLSkIV//JWYueTtNwQnV1UMXZ5OEuRgWsF1EieYdDJtxjv
	4f+uwR4r0PcY/i9mOrOtbyw9xZnNkbYSIUsfxdLvaGpHMwCtwbypD7F+W6xJ0Ahy3nHUP3b1bg+
	987Ywu77cWWsprKkGT6KOAONKYC1CECLjOTeu411RDtLjEjWRQFTD5k9yIe6hLD7f0dmKWg==
X-Received: by 2002:a17:907:60d3:b0:c31:fb29:a137 with SMTP id
 a640c23a62f3a-c4ca7a72d9dmr122779566b.21.1793345460293; Fri, 30 Oct 2026
 00:31:00 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030-swap-fixes-v1-0-73f73a59f2fc@tencent.com>
 <20261030-swap-fixes-v1-3-73f73a59f2fc@tencent.com> <CAKEwX=MJcyr1GjKNQ81x+fUS07T=THXGivjebt=W0ayjjZ3fgQ@mail.gmail.com>
In-Reply-To: <CAKEwX=MJcyr1GjKNQ81x+fUS07T=THXGivjebt=W0ayjjZ3fgQ@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 30 Oct 2026 15:30:23 +0800
X-Gm-Features: AclHuK_5zGeSFYxm22Ak0DBi9H9DruGl1-1gM-J338_JJvTdWweQtUaJ6xf3TVs
Message-ID: <CAMgjq7BHC=68=+2DsdZW7_1_PfdjCyd9fXN_2YZiaXFi1pHy=w@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm, swap: fix large swap-in across swap file extents
To: Nhat Pham <nphamcs@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>, 
	Youngjun Park <youngjun.park@lge.com>, Yosry Ahmed <yosry@kernel.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Usama Arif <usamaarif642@gmail.com>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Chuanhua Han <hanchuanhua@oppo.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Mani Tofigh <mt4022@columbia.edu>, linux-kernel@vger.kernel.org, 
	Chris Mason <mason@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 5:21=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Thu, Oct 29, 2026 at 11:32=E2=80=AFAM Kairui Song via B4 Relay
> <devnull+kasong.tencent.com@kernel.org> wrote:
> >
> > From: Chris Mason <mason@kernel.org>
> >
> > A page fault can give an unprivileged process blocks of other users'
> > files instead of its own swapped-out data. This affects systems with a
> > swap file on a synchronous block device, such as brd or zram. For an
> > anonymous mapping it also takes a huge page size below the PMD size
> > (mTHP), such as 64 KiB, that is enabled for anonymous memory.
> >
> > A swap area is divided into slots of one page each. A swap file is a
> > regular file, so adjacent swap slots can lie in two extents, far apart
> > on disk. A folio is read from swap with a single bio that starts at the
> > sector of the folio's first slot. So all slots of a large folio must be
> > contiguous on disk.
> >
> > The swap allocator knows this: it only hands out a run of slots for a
> > large folio if the swap area is a block device (SWP_BLKDEV).
> >
> > The swap-in path does not. On a synchronous device (SWP_SYNCHRONOUS_IO)=
,
> > one that always completes I/O in the submitter's context, do_swap_page(=
)
> > can read several swapped-out pages as one large folio (a large swap-in)=
.
> > thp_swapin_suitable_orders() makes that decision, and looks only at the
> > swap offsets (the slot numbers) in the page table.
> >
> > Pages that were swapped out one at a time can end up in consecutive,
> > aligned slots, and are then read as one large folio. If the extent of
> > the first slot ends inside that folio, the rest of the folio is filled
> > from the blocks that follow the extent on disk. These blocks can belong
> > to other files.
> >
> > Reproduced with a fragmented swap file on brd and 64 KiB folios enabled=
.
> > After single pages were swapped out, a fault returned blocks of a
> > root-owned file with mode 0600.
> >
> > Fix this by allowing a large swap-in only when SWP_BLKDEV is set.
> >
> > Known gaps:
> > - A swap file on zram, brd, pmem or btt is now read one page at a time,
> >   even where its slots lie in one extent. Its swpin counters in
> >   /sys/kernel/mm/transparent_hugepage/hugepages-*/stats stay at 0.
>
>
> I guess we can check for this right? Look for the swap extent of the
> first offset, then get extent's size (swap_extent->nr_pages).
>
> Not sure if these users use swap file here though.

Thanks for the review!

I think it's really not a good idea to use swap over FS on a
zram/brd/pmem device, and we already disable mTHP allocation for any
such setups, and extents is a burden there. Without high-order
allocation, there is no high-order swapout, so high-order swapin seems
much less helpful.

So keeping the fix simple is a good first step, IMO. We may revisit
this after mTHP allocation is doable on these devices, and get rid of
the extent completely.

> > - With the posted "mm, swap: enable THP swapin for xswap entries"
> >   applied as well, the large swap-in that it adds never happens. That
> >   patch gives its swap device SWP_SYNCHRONOUS_IO but not SWP_BLKDEV, so
> >   the new check would have to let that device pass.
>
> Mentioning unmerged patches in changelog? ;)

I can help simplify that part.

>
> >
> > Fixes: 242d12c98174 ("mm: support large folios swap-in for sync io devi=
ces")
> > Cc: stable@vger.kernel.org
> > Assisted-by: LLM
> > Signed-off-by: Chris Mason <mason@kernel.org>
> > Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  mm/memory.c | 16 +++++++++++++---
> >  1 file changed, 13 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index b65b56fe9714..944f57153c89 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -4863,7 +4863,8 @@ static inline unsigned long thp_swap_suitable_ord=
ers(pgoff_t swp_offset,
> >         return orders;
> >  }
> >
> > -static unsigned long thp_swapin_suitable_orders(struct vm_fault *vmf)
> > +static unsigned long thp_swapin_suitable_orders(struct swap_info_struc=
t *si,
> > +                                               struct vm_fault *vmf)
> >  {
> >         struct vm_area_struct *vma =3D vmf->vma;
> >         unsigned long orders;
> > @@ -4888,6 +4889,14 @@ static unsigned long thp_swapin_suitable_orders(=
struct vm_fault *vmf)
> >         if (!zswap_never_enabled())
> >                 return 0;
> >
> > +       /*
> > +        * Neighbouring slots of a swap file can lie in two extents, an=
d a folio
> > +        * is read with one bio. The flag is set in swapon() and stays,=
 so the
> > +        * race is benign.
> > +        */
> > +       if (!data_race(si->flags & SWP_BLKDEV))
> > +               return 0;
> > +
> >         entry =3D softleaf_from_pte(vmf->orig_pte);
> >         /*
> >          * Get a list of all the (large) orders below PMD_ORDER that ar=
e enabled
> > @@ -4924,7 +4933,8 @@ static unsigned long thp_swapin_suitable_orders(s=
truct vm_fault *vmf)
> >         return orders;
> >  }
> >  #else /* !CONFIG_TRANSPARENT_HUGEPAGE */
> > -static unsigned long thp_swapin_suitable_orders(struct vm_fault *vmf)
> > +static unsigned long thp_swapin_suitable_orders(struct swap_info_struc=
t *si,
> > +                                               struct vm_fault *vmf)
>
> Nice, I think Sashiko is complaining about it on one of my vswap
> patches lol, and I was wondering how on earth is correct in non-vswap
> case.
>
> Fix LGTM:
>
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>

Thanks!
