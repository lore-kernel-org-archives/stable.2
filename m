Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.193
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795419374;
	b=gos9Ce5usaD38tneAQQRqALQMZH4qWly35K6KfGV5JpqzB4JYdNzKrt5HqgP1ctLjGod
	 zTBFBeT/Vd7+mB7dYjMNB9jW2aBeEECgP7NskqiB+7u1lupQAUev3hCvWJC8oGeNq5Cfk
	 MEMsep9qvtkw86tDW9yS+0NlobhrcfOazOmfY2LUYYS/oEVxX6s1hK0z2YZzXwt4d6BT3
	 k4845HUrZ+YNm4ZMHAyOuCK0DOg4LH6HDAGtgRSaqdGKyp5CZmkJrWRVjLHzx2ENUX8GB
	 zHzUoB+1SD87Yt3Ski6C1WD4Ykplg8VrxMvYNMh2V3psydyaTmg7jPWnibUIKyNQWuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795419374;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=eb1bmF8F2PVJN1FG3qeHre4JjGzW9zZyj8slSTuCErU=;
	b=X0ILSy882/AYx6b2VJrANoGY9V3DrLczpvjPLWoAtBD/K7PWsFtL/bjVBigk1C7VYins
	 AaNvJdjB/jgLdrPlHmRHNAS7kMQSJPMer40bAgTsKmAZiKQFojOf0cUBeiUyYYnZBLNVM
	 loxpa5+gPEnLHN5lz8jViPBJ045yk9mVpO4XHcKRxYQ+JDsfIuFsHZEEcVLXJFfCps/Mz
	 Rczx4UykJsqA44RrSRbQkgUQnSa8r/TAKCt3qwJAYyQDs9broM2a3mQmKEWulI3D7WnRM
	 3+GFpcDZtkWg60WR9H1uY1ZYRk7OB0GTP1bq2wciIbWwKdaEsNK2LfmqtlYarYqYoAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wZgwMW7f;
	arc=none smtp.remote-ip=91.218.175.193
Received: from mta0.migadu.com (out-193.mta0.migadu.com [91.218.175.193])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6221606A31E
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 07:36:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6221606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wZgwMW7f
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=GbNG4aEZgYnqy60cKkuKbdz31c//1P7sSXGaCQ5qE5k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795419371; v=1; x=1796024171;
 b=wZgwMW7fFFnHcDSYylDf0JYR3mD5371OJi8tMEM2taMQOAiOc4aGEIvhxJcyW/QO5a7Sex0F
 C7DOYr+d/Wq2F69xGlRIr9L1iKmDiEv1d8UOaYWxIrTsrYP1Mh7KQPRLtMXd/F2V7tFiTLVS/fP
 3eiGH44jZp+Q39bN0AraTgkg=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 87770ef1b8f9854a;
	Mon, 23 Nov 2026 07:36:10 +0000
X-Mizu-Trace-ID: 87770ef1b8f9854a
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5c14bc5a743so8646e87.0
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 23:36:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErG35ONNTRvj9RUbZbYwyMRDL2SQ/VcYlzQfL1i1khfjNaOhbD+ios5pQSGPz1T8vN9vs1ZQrxM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8zNEvjyGTR+hpQdmfevb960InmO8UpWwqmsNJy3OrBWQNE4bMm
	grw6VM7EpjOAbEwhuZdsKla+TcZ/7k3H7kKOwYeqyyrRhmCMTbcCCv0yt/pauzjuUQfhBDDWSXM
	mwKEZEhxQf/9PpsTUwu2YE+CEbdtspLXwvJGPac5u
X-Received: by 2002:a05:6512:1250:b0:5c1:4cd1:131e with SMTP id
 2adb3069b0e04-5c21a261fbamr165167e87.11.1795419366920; Sun, 22 Nov 2026
 23:36:06 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120121638.194154-1-fuad.tabba@linux.dev> <20261120121638.194154-4-fuad.tabba@linux.dev>
 <6782b5ee-3dfe-4076-a79c-fbeb2c2ac7da@arm.com>
In-Reply-To: <6782b5ee-3dfe-4076-a79c-fbeb2c2ac7da@arm.com>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Mon, 23 Nov 2026 07:35:30 +0000
X-Gmail-Original-Message-ID: <CA+EHjTziXrRdR+guikKbj93Az96T+AMx_=0sVeyWG5C4fwaaTg@mail.gmail.com>
X-Gm-Features: Aa3M54qbIcVsswZvgTdf3Pr5w2t6747s-c6Tnij9t_PWy9hwC6gUmChWfQyq38Y
Message-ID: <CA+EHjTziXrRdR+guikKbj93Az96T+AMx_=0sVeyWG5C4fwaaTg@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: mm: Don't defer the barriers when installing a
 fixmap entry
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Yang Shi <yang@os.amperecomputing.com>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Ryan,

On Sat, 21 Nov 2026 11:01:49 +0000, Ryan Roberts <ryan.roberts@arm.com> wrote:
[...]
> > kernel then warns about a spurious translation fault. When kgdb stops a
> > CPU in lazy MMU mode, its breakpoint writes through FIX_TEXT_POKE0 can
> > fault the same way, and fail.
> >
> > Emit the barriers directly in __set_fixmap().
> >
> > Fixes: 5fdd05efa1cd3 ("arm64/mm: Batch barriers when updating kernel mappings")
>
> My memory might be betraying me, but I think this change went in before BBML3
> (BBML2_NOABORT)? In which case, the bug is only exposed by the latter series?

It did, and the set_swapper_pgd() path is only exposed by the later
series. The tag is for the kgdb path, which doesn't depend on BBML3.
When kgdb is entered from a breakpoint in process context,
in_interrupt() is false, so in lazy MMU mode the barriers for its
FIX_TEXT_POKE0 mapping are still deferred.

[...]
> > diff --git a/arch/arm64/mm/fixmap.c b/arch/arm64/mm/fixmap.c
[...]
> > @@ -127,7 +127,9 @@ void __set_fixmap(enum fixed_addresses idx,
> >          ptep = fixmap_pte(addr);
> >
> >          if (pgprot_val(flags)) {
> > -                __set_pte(ptep, pfn_pte(phys >> PAGE_SHIFT, flags));
> > +                /* The slot must be usable on return, even in lazy MMU mode. */
> > +                __set_pte_nosync(ptep, pfn_pte(phys >> PAGE_SHIFT, flags));
> > +                emit_pte_barriers();
>
> I wonder if it would be clearer to wrap __set_ptes():
>
> lazy_mmu_mode_pause()
> __set_ptes()
> lazy_mmu_mode_resume()

That would work. However, there's the stable backport. 6.18 has the
bug, but lazy_mmu_mode_pause() was added in 7.0, so 6.18.y would need
its own patch. This patch applies to 6.18 unchanged.

I'm happy with either, or with a followup patch in the same series.

Cheers,
/fuad
