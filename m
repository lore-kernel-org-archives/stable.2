Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.167.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795046369;
	b=HyqleS1WDfey5kbyuNQnDDmoblKpBLv5czyg7jWwzXundDNM/hC0cqKywlXJ3jb2I7Tj
	 3aw11OJ3stnSuIcYkL3rWfaNtmvcbh99RtPMfW0yf5jGQwY1JOpuBwfKcQ6+dB/tAFwwe
	 m4qE88+uOQVrvrux2QJKruyNQe0pnReUrbxhLvZ0vahG6REmXFhPWzvuSR9RSBpKynIzK
	 f2FbL+QRzdNIQdlUldXD8L8SQEq8/aYn4JPD7/HdsxhQrdjF99mcZNkBp+vnQq2iud9BV
	 0nAuwcarlhTObczco45l/MtQQ55gZ7FPmZ/eCuE6h7H16xRsjmmJpo1j6QJC/Jic6RA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795046369;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=T6R/PYV+nSxp1UtaMco+VKM8S4ufxpCmVV0RFQLraMg=;
	b=AkTIkUgXWNWRzFvJuE0SaaBZF+z8HoT0yxR642yWubN3XvGh3lhco7B/enHbWAm0Hq39
	 g10pJvs4XmgqLNWKoF2q1qVFRsVT209K2cRkTfL/svWOQ2lYekXKioHizSlKgm4EW9CB6
	 7X0axey+Vb9/5NInInzPMdap5FPFmtiBBbZwiiTRF4m0vlRc1yGE8xfjFifSI9u7MYU89
	 aJr8kvUzLA+xVC/7aJQDYTAIRT8S9Np/8QoFsSPQO6NOgQ/aKzjc3RkgWEp4WyGiiDXEM
	 XVhhZFzTGS/rTt9+fgrzGdIWpBI+FQz40hrwzFtOKCdHi1tp/YwLGzoBDCLISEcUjgA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crosse.dev;
	spf=pass smtp.mailfrom=crosse.dev;
	dkim=pass header.d=crosse.dev header.i=@crosse.dev header.a=rsa-sha256 header.s=google header.b=LTwTP1XC;
	arc=fail smtp.remote-ip=209.85.167.47
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54245606A330
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 23:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54245606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crosse.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crosse.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crosse.dev header.i=@crosse.dev header.a=rsa-sha256 header.s=google header.b=LTwTP1XC
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5be3ed646a5so1886448e87.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 15:59:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795046367; cv=none;
        d=google.com; s=arc-20260327;
        b=U817XV1XeO0Vkna/VgVqvfydcVirEueCh7A7ynn7Cjc0zVUQqiMrZtbbUgUONh0Huh
         XY6RwEIMRZLYZErjxmkJJl7IK860fmak+EbK2dfAwftEcctyACCe0ahtcOf4wABMKep7
         HD5mQ9XsEkRGUN6Cbs28W0u/EMrJx9poKcJT+lRL+hkd42yqdi1GmIY3YXmoHkbVb3BV
         ps+EmkzBnivBT1v7myGDnSCECtfDjAhaL0Kvz2WdDeMKDEaXw7j0pbBHsNyapMjtII7P
         hkeDt9MjOhqT8C+qPeV4X4zb6i9hVFWQ/g+pUiBQl/v7N8ZR7eehFTTrT3M6MuOmH5H1
         bzXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T6R/PYV+nSxp1UtaMco+VKM8S4ufxpCmVV0RFQLraMg=;
        fh=cvPNlqYQ06cZkKq7piLVqCN4xafxXlGcmtrcPfR4t5I=;
        b=Ktnh/Z28+dBa3RMu3MMRQTznXOx6A0c4GT4WwGlB+aWWBQln+faT+1dJFoUviObLIJ
         UyohGktjBIzkOBMEOrcd5kBKUkzC/YVkBeHKFkUIPyX3KLg4PVyfpk2vyXUl/2yZYnVt
         ysCgDECuYkWoSKAVjqbwrKHMRooUtFQXTjhBw8no8YRsp6QV6F4NBfr3dhCs4AAgOM1W
         c6hzkdTYv06Jgy+a7mG+Czv9Q31cmQlftAeTG7MMOYk6i6almckooSb7iS57wX6Rnqmj
         dw9BIbUz8/9GieuTvI19do90UyKmqChW+h2w6rOkdKOHbrsirpLfZGMNoB0GH1qkcfWv
         wH6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crosse.dev; s=google; t=1795046367; x=1795651167; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T6R/PYV+nSxp1UtaMco+VKM8S4ufxpCmVV0RFQLraMg=;
        b=LTwTP1XCBdKUZG4tfRx5wu4oUSByB7xTmM/n1Q8XIc0hQR8QE2hdg+rfBBDhF/eA0V
         iw7ZxjM3xQuOqYSkpaGatIzPD8HZZ80rLBrykozLkXddarwEtW3/YMyRlM3D8h1TqRgb
         iR/K44rgcU6P9QVgvvGwwgJEP5fGU27fYldrXpacoMjmUhzMrHG4b39ain/oV2x+2pvO
         fOp1zDPrICIi8ISvwZhv8KYNFpserQpR6Dtn1JAZZVuqhFoBX/ADF3q8FCZkLtuvHlCx
         TavY2I8r7iKpl+lQCUNOo1/YFUE9XUtHzq/Yi+dSmDd9/hrva4MF2S833V4E5N3KD9WY
         LP8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795046367; x=1795651167;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T6R/PYV+nSxp1UtaMco+VKM8S4ufxpCmVV0RFQLraMg=;
        b=skpBbIHW7+HJ+8r279hNljAhOoeheVwZT92wXgCiYTJXgIkZbaBcLLOSXKysiPD2Cx
         v8gQ6s+mrijn70YDY5fPgkuJJ42zjML81HoYNroAP6HZO3qakNzOfalVgpfa/j8zLs5D
         mioTLVL2h2+IvtN9C+fQDk/iPMXk/BvTQx18StlLMM0a3WtBbSlBqKJqrH9IuaCXw9Yg
         dB2BlfzUK69RSCJ9EM0UomY9Iq6Xw1H41bGqTGS9ARkX25dWpNnKWSvTuRtTdyOYuofV
         mRO3ToAYA5lAVTbp7Z+EMKja/jAGjV8dIeW8X8I2DMwjR5IvV4C8xQupDXbov5NfqS9q
         1llw==
X-Forwarded-Encrypted: i=1; AL+hErEzrq0ca10K/Hzn+xXNcPO1WIRSeuHnDqWn1hzCZHvtEGfJGoTvFWt6c4uevnLauTuWw6BomJs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8OhqONrExF8GrhrMMFnNLM0rnu8t0c40HgyEKb7bn7cnAJy0iH
	g1PSTRW0H2dMvN1UYb/BXFfCO7w8PVbck4dtqkvRvhWZd0GiCu0xAQEJ1DWaikXPj6R8zhIKiXS
	jwziCpVW8BnY+Gq/M231eRk8iqH6bql4Y6AvwQOgggQ==
X-Gm-Gg: AYBFou1c3iydiMctW84LnzoHBxX/ms+elajlG69wCoR5w9P7ai4ckf2lBdOVe0zK1vJ
	6SRoBDRpayGpu02yUA/FgddM8DJRRXKF9GE5hf8KX/lXJRqRrQhRRHqTF8uHJ+cnuMZeGkqRyxq
	V/7wf4+YFs6EyRqtesR6epzfx+KjjLJbagQ5cAE779HlTW8l+9kv52ufIH0CIlXgPvkdTp7/+Pc
	gdVppsk6XDccBNRz7FuL8JihCuAxikx2MU55Lc4DNm+iiO/dgKuPrcoo9vvWidxSAZ8lByzVpsn
	OLOx3mRDvCKQDdXyC2pKzrkNcJbfocSANSiWgy5LFZRfP242owUWvg8/3oNLlzCD6UcqdqX7tks
	IBbStToJUNS6Jk53xqy3TdigYACfFmd9zr2k7
X-Received: by 2002:a05:6512:10d1:b0:5b8:f81b:dfea with SMTP id
 2adb3069b0e04-5c1aa2ce5d9mr1273317e87.62.1795046367239; Wed, 18 Nov 2026
 15:59:27 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118-mmpop-populate-v1-0-9c561d178d11@crosse.dev>
 <20261118-mmpop-populate-v1-1-9c561d178d11@crosse.dev> <e32482de-295a-4e26-b6ae-5b8b58f8b98c@kernel.org>
In-Reply-To: <e32482de-295a-4e26-b6ae-5b8b58f8b98c@kernel.org>
From: Harrison Crosse <harrison@crosse.dev>
Date: Wed, 18 Nov 2026 18:59:16 -0500
X-Gm-Features: AclHuK_1VAQDAg1dH3obLDVFJKWckiVyn_K5qUH1FINUpBm1FFDjoVLIC7OItpA
Message-ID: <CAAFYBzy=Rf+gtYBkHfR9MpmakDrZBpOEfk-rLxUtRo7RfiFy+g@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/gup: make mlock() and MAP_POPULATE handle
 VM_FAULT_RETRY properly
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>, 
	Yeoreum Yun <yeoreum.yun@arm.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Let me take care of this (or find someone more familiar with that code
> that can help).

Thanks for taking this over David!

Harrison

On Wed, Nov 18, 2026 at 6:25=E2=80=AFPM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 11/18/26 22:56, Harrison Crosse via B4 Relay wrote:
> > From: Harrison Crosse <harrison@crosse.dev>
> >
> > If every read of a page of a file mapping fails, mmap(MAP_POPULATE)
> > and mlock() of that mapping do not return: the task spins in
> > __mm_populate(), submitting a new read of the page on each iteration,
> > until it gets a fatal signal. Touching the same page gets SIGBUS, and
> > madvise(MADV_POPULATE_READ) fails with -EFAULT.
> >
> > The first fault on the page reaches filemap_fault() with
> > FAULT_FLAG_ALLOW_RETRY and without FAULT_FLAG_TRIED. filemap_fault()
> > releases the mmap_lock to read the page and, because it released the
> > lock, returns VM_FAULT_RETRY before it looks at the result of the read.
> > It cannot report the error then: a fault that has released the lock
> > returns VM_FAULT_RETRY or VM_FAULT_COMPLETED, and neither carries an
> > error. faultin_page() turns VM_FAULT_RETRY into -EBUSY, so
> > __get_user_pages() stops at that page without an error, and
> > __mm_populate() calls populate_vma_page_range() again at that address,
> > again without FOLL_TRIED. The page fault handlers and
> > __get_user_pages_locked() retry with FAULT_FLAG_TRIED instead, and on
> > that attempt filemap_fault() reads the page with the lock held and
> > returns VM_FAULT_SIGBUS if the read fails.
> >
> > Commit 631426ba1d45 ("mm/madvise: make MADV_POPULATE_(READ|WRITE) handl=
e
> > VM_FAULT_RETRY properly") fixed the same loop for MADV_POPULATE_* by
> > calling __get_user_pages_locked(). That does not fit here:
> > __get_user_pages_locked() retakes the mmap_lock itself and carries on
> > with the GUP flags it was given, while populate_vma_page_range()
> > derives those flags from the VMA that __mm_populate() looks up again,
> > and may skip, after each unlock. Retrying with a NULL locked instead
> > would drop FAULT_FLAG_ALLOW_RETRY and FAULT_FLAG_KILLABLE, so a
> > userfaultfd range would fail rather than wait, and folio lock waits
> > would not be killable.
> >
> > Instead, have __mm_populate() remember the address of the page whose
> > fault released the mmap_lock. When the next iteration starts at that
> > address, fault in that page alone with FOLL_TRIED, as
> > __get_user_pages_locked() does, then continue with the rest of the
> > range as before. The retry reads the page with the mmap_lock held, as
> > filemap_fault() did for a page that was not uptodate before v5.1, and
> > as the other GUP retries do. With a persistent read error the retry
> > fails with -EFAULT: mlock() returns -ENOMEM
> > (__mlock_posix_error_return() maps -EFAULT to it), and MAP_POPULATE,
> > which ignores populate errors, returns the mapping. A fatal signal
> > still ends the loop, with -EINTR from __get_user_pages() or, if it
> > interrupts the FOLL_TRIED read, with -EFAULT. The other callers of
> > populate_vma_page_range() pass a NULL locked, so they cannot get
> > VM_FAULT_RETRY and are unchanged.
> >
> > Reproduced with ext4 on dm-linear over a loop device, with the eight
> > sectors of one page of a file mapped to the dm "error" target, on arm64
> > (Debian's 6.12.116 and v7.4-rc3) and x86_64 (v7.4-rc3): mmap(MAP_POPULA=
TE)
> > and mlock() of the file were still running in the kernel after 5 second=
s
> > and ended when sent SIGKILL. On 6.12.116, the block layer tracepoints
> > showed about 280,000 bios a second being submitted and failed.
> >
> > The analysis, the patch and this changelog were prepared with the help
> > of an AI coding assistant (Claude).
>
> Yes, that's rather obvious from looking at it, thanks for documenting tha=
t :)
>
> Thanks for the report!
>
> [...]
>
> > +              *
> > +              * filemap_fault() reports a read error only when
> > +              * FAULT_FLAG_TRIED is set: on a first attempt it release=
s the
> > +              * mmap_lock for the read and returns VM_FAULT_RETRY what=
ever
> > +              * the result. So when the last call released the lock at
> > +              * nstart, retry that page with FOLL_TRIED, and only that=
 page,
> > +              * so that later pages still get a first attempt that rel=
eases
> > +              * the lock for the read. Compare the address because nst=
art
> > +              * moves past that page if it is no longer mapped, or its=
 VMA
> > +              * is skipped, when the lock is retaken.
> >                */
> > -             ret =3D populate_vma_page_range(vma, nstart, nend, &locke=
d);
> > +             tried =3D retry && nstart =3D=3D retry_addr;
> > +             ret =3D __populate_vma_page_range(vma, nstart,
> > +                                             tried ? nstart + PAGE_SIZ=
E : nend,
> > +                                             &locked, tried);
>
> Yeah, that's quite the ugly code. Let me take care of this (or find someo=
ne more
> familiar with that code that can help).
>
> @Yeoreum, do you have some spare cycles?
>
>
> --
> Cheers,
>
> David
