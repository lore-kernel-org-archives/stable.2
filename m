Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC163BE642
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 19:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790795730; cv=pass; b=A1scqOFunrqrKzKzUMFAr0Jj0ZGOEaEu0n51ADNAxSyjhdCxZh1jMYVlbRjE/u04jXhTHhDxtT+lvSLpgzEanH4btzOxzLDcQA8NVUYYWcTp3vtp2R8XxVtIpiafjTnN3VPc2xPHZCFgsQguEsX2viNQaQ76YbjVV/YmQpIef+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790795730; c=relaxed/simple;
	bh=fZthL+tWzR9E/xcvxwzbMjS1v8ySe2/09qkUj/BN7gs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GiCxt3vlLqKMYsdaL5F7ylfsVZtC+wgwnxHZ5Ig7QhnHFGZE4lxemiTF/FXpuIgYZdhLDh1UHfNf6rLpdIt77qghjqf/44HW05qGJsIIp6beoNPJ1q+/dEtqhfylSkkENPEuS317mnJU/LJCTB9hbXEHghXJivIcpyDn+gANkyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=O1aHOzu9; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="O1aHOzu9"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-67583c777abso76151d50.1
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 12:15:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790795727; cv=none;
        d=google.com; s=arc-20260327;
        b=Yd5Y67ZPjVi9oInYchTvWVGd/gYvPdhvDScIkx0y7e8mj1/aCM3q0/Bw6hHoD3mde/
         4hbZnw1AK3hNe2iHPMpV/a4rtrLXYzsAzyXgSEUcd2BsIfiC1SK7h8ZT1Fkni1Jo+Xu+
         xxirGNS2hIIyhwFkziOk8vGtcuBRbye17QQOic/RzdE/tF6W39HtoxURVrIOJpeuzlNW
         kc84y306BbwkcPZGWN9+kPKQbLu3Y0SM3lqEQBUnW/A7iMlbi9CSY56mzUOXIE7ZzcR3
         tfUGqqzgpZ3PuobyEEys5BZfJcXSMrIZdfy2XaYJNseNKb283KIGl5ZoeMGDscgDiYQX
         Acgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sykxas6Adj+WIJltS14TUveHVHPawmc/B3/hESpzPNs=;
        fh=dhO3lSn4GJxqg5fjLybFMpbiYOGuqV43zkkm2n9y/vM=;
        b=n3xHlY0n7GweAXLPQasRadD8d4cJgjrzhEI7+s/BxAJwo+gy731vEAnUv28c65nbVi
         EU1bKu2KmhUJEtwJ+yRiUz6GopDInhMfnogAPHSVtl8ySOlGp6Uc2kIC6IZ0hRlh1TYx
         e0OQEuqnfIZJgOq5ikfKsC/WeZHk9Uv3cdT00DGU4SHja44Ze2PtfhiMit7wvA4GmlM2
         X/yaZ6t7k2oWaCUd5yQh+KEPIjbdzj1sVb/u2FaUKBl0ZhCGgwbI9erQbqbBrNKWGl6x
         fR9T0Fehgut6etWAiBMNlxrhucssMXs1fuhtWr1wSRztCsF2IUV4LI6NIU6CDnlkTeRq
         XDQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1790795727; x=1791400527; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sykxas6Adj+WIJltS14TUveHVHPawmc/B3/hESpzPNs=;
        b=O1aHOzu9CUR8grxwHyvW6ZdNu9R40dNRACLsRteyrCm+grJlgN86FrEFKnDtmIShg/
         loiox00NjEId2yqco2nVYma2uoWoNMnHieGGAinouaoNPNA7P5jhH16V9s6QBiir8npc
         FJj9HbJ4bEwwrHNjmLhISBmxokWzr2pijkzCadw3UOR3+PcSINDxoUHc5o1nIuOdKfZI
         ktC4NmRSOCYtry8elPt4FIjeM7P7a4cZvnk4QSfBW7CJWJy48v4XbJosn/XQFtUrhBnT
         NSVxpyLE4udahn4/N6jZZ0dWsHVS3chRRLn8byPdiJlSf/WyThu11nGSoII5MnRiJtEK
         Yxrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790795727; x=1791400527;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sykxas6Adj+WIJltS14TUveHVHPawmc/B3/hESpzPNs=;
        b=dfFtnyBSCRSb0IhQzpZbx+XdBhEhz/cs73QbkXhWEwSutS5j4khD3+t47ZnP/8XXCn
         x5VAtbZUq9LhXunaF7x+ywH+N3amsBUQ0HY/PRlR9IpHi0XPZ2eQSmMrD8fQFHCh3GjJ
         edBjWdpjw2hcrQJFt/RN3sKOXhFLV27tIUH/Df9UXyNNiehPKGCzuehupUc5Zi0SGLZj
         vKMCef1ZsKHERRKv9uUgvw3WuFfgADL/K2Fq8yoRLZpeWqRmVnjZvYk48VSGSrFn2ThH
         f7QfMY4PL2Kv7+N53LgYvOEHa06T6p2b79mOV4kKiXC6REy9sL0W1HOxKtjWxXj4zJmv
         0G2w==
X-Forwarded-Encrypted: i=1; AKwUvByx1/YQdUZqIeum2/Pqt1+Z4v42KqBhstkMJrWqCq3eSolu/KgNchvLokomEOtnk9+H63WmNlE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLu5dI3B3Tjx/NwcIzY8Dx0YUE0cvaeQ3J7oYtGNoqkpeGQ5TJI
	XVmTdEcHx+oco/gZizlT5OJyUP+FkPf8RCp/aAAmHLPOpAxg0W9fTyPukBIyrdli68R9/xXWrOX
	n1ISmt0dzeqewbQp2Enp5MBe2mlq18XlHA/XeW3haDQ==
X-Gm-Gg: AYBFou3sYv3v3sDs0ojPXYIZz84UMHUReNXHMZqXQpx4c64pSvmrBlHe8arSm6Ioku8
	HGr6CCbaWRvx6J90N7c4d5dZf8nB3/Q0DIHQNOvGcbVJNCSEC1H7bo9a/HE2yA3kNR8l4/Ps8Ep
	2a7dhj8i0VSU6WtSR6iv/06sv6+ZXB1nrlsdiDvuiunIbK+e8JwyP2SlYjg+7/G/HAZzkdx7Eoq
	MmLqnMfnUtYY35h526gXKJB0c1+ciPNRVoMjqPeMR8FZWFwWPp+5OF7DU8vpJqwmyC9T8/nxcft
	JgCPuJnu0qMS6EXevE7bCqaCuLCD41Qihwe88YOonHmiydbL4sAWSLmIFsyVAyDktUrqlD7BT5D
	Dd2e4lwz1hQ==
X-Received: by 2002:a05:690e:1586:10b0:672:96c4:af92 with SMTP id
 956f58d0204a3-676911e16b6mr273044d50.33.1790795727505; Wed, 30 Sep 2026
 12:15:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930-fix-dontunmap-partial-self-merge-v2-0-f388985a0f0a@kernel.org>
In-Reply-To: <20260930-fix-dontunmap-partial-self-merge-v2-0-f388985a0f0a@kernel.org>
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Wed, 30 Sep 2026 14:15:16 -0500
X-Gm-Features: AclHuK-pvBqXamSowcqonc1nkj-a8CmAPv0aSHfEztWllhc4V4grOHWSW8mGpDM
Message-ID: <CAEev2e8TXNwon=Ro27WYvyn-N5j=CenA8pEgLTPerMQtDh2OWw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] mm/mremap: fix two issues with MREMAP_DONTUNMAP
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Brian Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, 
	Kiryl Shutsemau <kas@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 1:47=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
>
> The MREMAP_DONTUNMAP feature is highly unusual in that it permits mremap(=
)
> operations that keep the original VMA in place.
>
> Historically this has led to a lot of bugs where non-obvious interactions
> occur between existing mremap() operations and the original VMA.
>
> Commit 397432cab17b ("mm/mremap: account mm->locked_vm correctly for
> MREMAP_DONTUNMAP") fixed an accidentally introduced bug around
> mm->locked_vm accounting, but this wasn't the only issue.
>
> And thus history repeats itself, as it turns out that mm->locked_vm
> accounting is broken by MREMAP_DONTUNMAP yet again by two further cases,
> and has been broken ever since the feature was introduced.
>
> Both relate to the fact that VMA_LOCKED_BIT is cleared on the source
> VMA (it has to be as all page tables are moved):
>
> 1. If an unfaulted VMA_LOCKONFAULT_BIT anonymous VMA self-merges it
>    clears the VMA_LOCKED_BIT flag and permanently leaks mm->locked_vm
>    pages.
>
> 2. If a partial mremap() is performed on a locked VMA there is a leak equ=
al
>    to the number of pages not copied.
>
> (Both for MREMAP_DONTUNMAP operations only)
>
> Both issues can be fixed by treating the source range as distinct from th=
e
> destination range, which is the definition of what MREMAP_DONTUNMAP does =
so
> is appropriate.
>
> In case 1, simply disallow the self-merge, keeping adjacent source and
> destination VMAs distinct.
>
> In case 2, split the source range ahead of time if the VMA is mlock()'d, =
so
> accounting is always correct.
>
> Both changes were tested locally and confirmed to fix the issues.
>
> For the purposes of a backport, the fixes are kept distinct, a follow-up
> series can add self-tests.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
> v2:
> * Added tags (thanks everybody!)
> * Updated 2/2 to avoid splitting the VMA if the VMA was not mlock()'d. It
>   is only meaningful and necessary to perform the split in this case. Thi=
s
>   also fixes the proc_maps_race selftests that broke, as reported by
>   Anirudh.
>
> v1:
> https://lore.kernel.org/r/20260920-fix-dontunmap-partial-self-merge-v1-0-=
6ffb556f8f8b@kernel.org
>
> ---
> Lorenzo Stoakes (ARM) (2):
>       mm/mremap: fix locked_vm leak from MREMAP_DONTUNMAP self-merge
>       mm/mremap: fix locked_vm leak by splitting VMA for MREMAP_DONTUNMAP
>
>  mm/mremap.c                   | 70 ++++++++++++++++++++++++++++++++-----=
------
>  mm/vma.c                      | 21 +++++++++++--
>  mm/vma.h                      |  7 ++++-
>  tools/testing/vma/tests/vma.c | 10 +++----
>  4 files changed, 81 insertions(+), 27 deletions(-)

Thanks, the selftests are passing now.

Tested-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>

Regards
Anirudh Srinivasan
