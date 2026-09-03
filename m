Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1749D418359
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 07:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788420904; cv=pass; b=RCaf2FCrzsnamXT6BpgTF+o4Or+SbNCd77AhiBjbYMKgPuwQYMnZp8B0o6sOEcrQdAc51b+05+2fPgjgYoe5+BoyrgbMZagZsr7UXU8wjpPE1oigfnVty/2juwUSxEicv7tvYmqZHgg95VnYJ0U3Up8gWgPHkNsYU/H7DRsQ684=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788420904; c=relaxed/simple;
	bh=lQRuEti2mB0O/I4QWuPvvTuIsqoH0BHyFkEmnXQZyhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u1GlERysjQXCyjmqGLX9wySwJayQHskE4HTT485Osf/gCJLB4oetaECZNTMacb3bzM7mS48qpztD5zLH+Ci+BkjkbRg/sLt8rsNKqi9d875iXGrNHVPH+hOv4CUJCzglizZrevGDPyDnvJYFBrhIbGttyLneo3HrSGWseHCPZaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5eaik0R; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5eaik0R"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-867a943b149so33128767b3.1
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 00:35:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788420902; cv=none;
        d=google.com; s=arc-20260327;
        b=g40zh21QICJ108lZKnfO3CYjNhE2T67iMDra1wp6F7xiZoNEDwG6jEPaVOzW8BAXno
         XADZbvrLDw3/MhgdlMHBk3dsN8/ef9sqBIj4IBvmRrrK8ecxjgZ55Nur6uXdresCg6P8
         AQaaPUI6GtzZ+8o//whsU5wxbhdrxa9VlXSQ7IR0fARAzYrVbg33ooWaEXxIYsv7K6bc
         wSg2J/eTqqcE8T3clLPA+JPZfmvlV7qZvY8L0whPkP/jMjHtMvP0Uf4xXMH3wzB7+zOi
         VVlpDHkc700lFwFVgObJKJfQB1Je7vUkpfGaxjEGOck228VIWgMOZK6AmipLfscp4GRY
         4OwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5k5+Fsqvp3x6hqAgGWwJ6Y9lY2700zpmH7OyCgfIjgU=;
        fh=9bfDjtn5Fqid5SXsEVANQi2UdNZxX16IjJvOvmkEpsI=;
        b=fDKzFqA1+4J1E+ydra/UoXYdG9/UT6PqkqcYlLQR3vJixwk7YHCNSeKEhlOxzq1WuG
         Guxev5HkRr7sQ4z2Hzf3pZqbffs16sajQv8iWvoPP2PWjySKZZ4K7F9luKrkfSOixbUa
         VG2y5V/maO9G9TM9MKNxRPkuS/676h/gtxJZNugSjGhWzFBoAAcSM589ONMIQKNyy2/R
         xCgCDprYfNuNNBKaCVTavVIDxayn16NY2BDnRCiowcHhzqoSy471DvZmXHeKO1xA+d95
         JON3hO3SHXv2jodvazMz4uIl9EbILpSj5fF7+yvDx8OZxcHYRzB297tbXFI0kaoOpu2N
         j7JA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788420902; x=1789025702; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5k5+Fsqvp3x6hqAgGWwJ6Y9lY2700zpmH7OyCgfIjgU=;
        b=A5eaik0R2hG+al0h0j3Qx0VhX2+9W+H+sRhkO3IjLg/dnn8IPoUBfULHDV+VXIKkHx
         H3FEwKRUMDISBtBKUGsDBJBnk2H6EVmwKvuVKneTurOsBwnuRMUiMwKXClYD/pPY6sC7
         EqCSA84Jmwpxs9dI8WTyGHevqtxSgMuMjUKzARRMS7RwpfTAP+KPOuhsci+bsvycbsPV
         b3jfktVEiQ2seJCycIexkBZVf2Xzj6gMBNdIwMaEucJ0ghrom5KwG05bhI5guNcp8mnW
         PtTsUhE9Qag2QKwFe3DthByIGAUZBPc4+xLK7WCPSmE7733V8ddgmvvl0JizQ3Gnt4tB
         rcqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788420902; x=1789025702;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5k5+Fsqvp3x6hqAgGWwJ6Y9lY2700zpmH7OyCgfIjgU=;
        b=WLD7bpDFTpf9nxkSjU9SBsOIJgQdGgrWyfd9gqWyk4yijEKtMPbU0Rc8TkXgOmBwx4
         cuMxCThd0EhafdB/B8i+oRj0dkIshjwLrl/fcKsJOBQk/3p2q3C/XGVjOT3jbpivmj2t
         rXjZ+mwM70svWsu/5YwzhvAmafrcs/bqVsOdjeDu3IWCabrLdXCzj1tyKdjbuYCMLVom
         YsPzVFefI+Cy/wERNgJxoWZzJqU2wWmTaFvMtiTam0uHNtj/+i18kJEg3cRiJQJx21YL
         UaWYUHszIH3D+OJ3JrhQVTZyPHK6xc/0dtIeVngtwj1/2a4+GGiKI20I/segEhZsWir9
         +/cw==
X-Forwarded-Encrypted: i=1; AKwUvBxcyeshArrJf8MW1f99T1VecTOkts7FXYUsL8uvODpLypAZM6Qm/NPDPRfkYewDmXgedjWH3b4=@vger.kernel.org
X-Gm-Message-State: AFuF++kkSmY1ltu6pritk1h9Rxn912GqqKTZ/nkWlJRRq2pw3ZF87n+W
	CTPUY7PiEAKzjDNVyKLjnfqDQ+4b3vIJqrvUCU67J5AE+X7o13gVV4QkY6p2i5QLs+lNUHUJ3KE
	gPxn1h3FuP++1bHjxrR8uUvFXLZ0D8KQ=
X-Gm-Gg: AYBFou0hkBZCYgZWTB4sD3rGc5P9n0I1wiyDj/BK8sPuHtGK81ZWtT+g0gKO2CQftOw
	LqFF9Bzw/UETQlGnSTBZaWfG1yxObnXWkEU0u9M9EqQmZ1pZRQxmfLj83QBY7YZDmc2gq/qt9Vo
	Vd/PNgQoDuyVoLyWX1tCG7XjwsnNCBjLNZUI6p5dJK2xjGWExIjfUDdCxhgd/FVjWqwzHCxFGfG
	hHb/zGMS4wvm/sGF5o7pTnZM8SDzhrVvJyYChIRwc9CHTD8JutL+BUwPqF9uXS21wQws9LbGU3Y
	WHLJwHAsSAiLgzign1sOLpUvrhjSFIVvDrfY9f2AjHEsA8+xGiTK07dIytpx0gzxE9YWgh+reC8
	1yEOzchBM
X-Received: by 2002:a05:690c:a198:b0:81d:edf2:dad8 with SMTP id
 00721157ae682-86c53684de5mr42681947b3.22.1788420901952; Thu, 03 Sep 2026
 00:35:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903031608.1194238-1-vernon2gm@gmail.com> <20260902211036.8184c6e5535669bd73c71fd0@linux-foundation.org>
In-Reply-To: <20260902211036.8184c6e5535669bd73c71fd0@linux-foundation.org>
From: Orson Peters <orsonpeters@gmail.com>
Date: Thu, 3 Sep 2026 09:34:50 +0200
X-Gm-Features: AcwNN1XmU1byQhOAnlxDSVcgMESrE-dNDgSfZURu06PxV6xOgn5ADMEdyXgvAEY
Message-ID: <CAJxLxMXN+y03VPWyiLcT5-eLVGE8iojDm4+GYd5fdJ4ZtQ45UQ@mail.gmail.com>
Subject: Re: [PATCH] x86/mm: Fix pmd_modify() dropping the dirty bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vernon Yang <vernon2gm@gmail.com>, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, david@kernel.org, hpa@zytor.com, 
	rmclure@linux.ibm.com, andrew+kernel@donnellan.id.au, 
	pasha.tatashin@soleen.com, kas@kernel.org, tj@kernel.org, rppt@kernel.org, 
	rick.p.edgecombe@intel.com, yu-cheng.yu@intel.com, 
	linux-kernel@vger.kernel.org, x86@kernel.org, linux-mm@kvack.org, 
	Vernon Yang <yanglincheng@kylinos.cn>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Andrew, Vernon,

Thanks for your quick reply, confirmation and patch.

What I failed to mention in the original report is that this isn't
just a hypothetical issue found by analyzing the code, some of our
users (of Polars, a data analytics library) have hit this in
production. "Live data can change silently" is never a fun issue
report to get.

Transparent huge pages + MADV_FREE + NUMA hinting + cgroup
limits isn't your typical mom-and-pop setup, but it is not an
unreasonable configuration either in high-performance computing. The
only missing ingredient when you use Polars on a multi-NUMA-region
machine running default Ubuntu configuration is the cgroup limits.

Considering that the impact is so severe if the bug does occur (silent
memory corruption), will there be backports of this patch? If I'm not
mistaken the offending line that introduced the bug was first released
in version 6.6.


Best,

Orson

On Thu, 3 Sept 2026 at 06:10, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Thu,  3 Sep 2026 11:16:08 +0800 Vernon Yang <vernon2gm@gmail.com> wrote:
>
> > From: Vernon Yang <yanglincheng@kylinos.cn>
> >
> > pmd_modify() masks the old value with (_HPAGE_CHG_MASK & ~_PAGE_DIRTY),
> > silently discarding the hardware dirty bit.  The subsequent
> > pmd_mksaveddirty() call is supposed to transfer _PAGE_DIRTY into
> > _PAGE_SAVED_DIRTY when write-protecting, but the dirty bit was already
> > stripped from the value, so there is nothing left to transfer.
> >
> > Contrast with pte_modify(), which keeps _PAGE_DIRTY_BITS in its mask,
> > and pud_modify(), which keeps _HPAGE_CHG_MASK untouched: pmd_modify()
> > is the odd one out.  Any pmd_modify() on a writable, dirty PMD loses
> > the dirty state.
> >
> > One visible consequence is data loss with MADV_FREE on PMD-mapped THP:
> >
> >     memset(buf, 0x5A, size);          // PMD-mapped THP, PMD dirty
> >     madvise(buf, size, MADV_FREE);    // PMD cleaned but left writable,
> >                                       // folio marked lazyfree
> >     memset(buf, 0x5A, size);          // hardware sets _PAGE_DIRTY again
> >     mprotect(buf, size, PROT_READ);   // pmd_modify() drops the dirty bit
> >     mprotect(buf, size, PROT_READ|PROT_WRITE);
> >     // ... memory pressure ...
> >
> > Reclaim (e.g. under memcg pressure) then finds the lazyfree folio with
> > no dirty bit set anywhere and frees it in
> > __discard_anon_folio_pmd_locked(), even though the data was rewritten
> > after MADV_FREE; subsequent reads fault in fresh zero pages.  NUMA
> > hinting alone can trigger the same loss, as do_huge_pmd_numa_page()
> > restores the PMD through pmd_modify() as well.
> >
> > PMD-mapped file THPs are affected too: mprotect()/NUMA hinting dropping
> > the dirty bit means rewritten data is never written back.
> >
> > Fix it by keeping _PAGE_DIRTY in the preserved mask, exactly like
> > pte_modify() and pud_modify() do.  The existing
> > pmd_mksaveddirty()/pmd_clear_saveddirty() pair then performs the
> > hardware-dirty <-> saved-dirty transition based on the write bit,
> > preserving the shadow-stack encoding rules.
>
> Yeah, this is exactly what I came up with, using chatgpt.
>
> > Closes: https://lore.kernel.org/r/CAJxLxMUGu1-L+O_nAONOwOXnS=cNbNApCWqdthRjd76LThtSPg@mail.gmail.com/
>
> We definitely want a Reported-by: Orson here.  He obviously did a ton
> of work on this, and it's the least we can do to thank him.  I'll add it.
>
> > Fixes: bb3aadf7d446 ("x86/mm: Start actually marking _PAGE_SAVED_DIRTY")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Vernon Yang <yanglincheng@kylinos.cn>
>
