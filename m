Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB02024CEEA;
	Thu,  3 Sep 2026 11:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788436494; cv=none; b=Ke6uGLZQLbHYiBP3c7mkHaYCQgHzzoTQ954eWQnzHSujZ5eIxCtwYeHkI9Bgj/kHLSA1bKFQoMvcec+6j4Ye/oIhhGwJil+bj5Y9A1tPu89fIyS6oLNIXSVZrnR5FSzkr05iZ6CxWQBUXmXvuvXQUbps3H2/zbZcSJqeYa1IXCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788436494; c=relaxed/simple;
	bh=Z5z37XkEsb61zGtLR1enwRiogwfaCgfOpyuB25jZx64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KynWqsF2EOBXozgpUFRqANuqm1abKIHGFbAj1DYDoN1xYcEAkGNzBfXIGYen5sWjwr/UbxyNd/H9gjrK7kV9g/HkODMolx78h/gpr/qCZQqov3/fFfGR4zatmmvZwxovYKx2YPkk4IOwJ1zzI6dRTcrTqyGNBgXkp0mY3V6XSCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZwBmM0T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZwBmM0T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D121F00A3D;
	Thu,  3 Sep 2026 11:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788436483;
	bh=lrsApyRAlrAEXb8oYNM0e4ki57YGn/dS7fq9ucKxGg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JZwBmM0T8rEezI81rzPOtSKsc80CaL0qZizFtL+7BYIla5SMnNJZL1ZxJjRMEwgqb
	 gR4JmwhGNnvMat1WcDCGZqu7ugwvVJniCdnA6UhbsOMP9uqja/6lqWPA5P0+bTISZ2
	 iYoC9SwyK9kQeJxNYiAA40wW0wHu2XS+FjcP3KT8B0uJj5nqmZpICVU9QWKONsL/Y3
	 paVGcie002Aj4ei1NEzGgFXNeJytaSUITaXeUQIHuwISBbexfo5nkDtfxHgItV1Uy1
	 71giNJZPbXLuwvmZAmOD8nVNFOaOIb2w/nO5gDXg49SeKvBzyniUe7DWM0U9QA6hJ2
	 aw5YXbYyerxvA==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.ams.internal (Postfix) with ESMTP id C09CB1980050;
	Thu,  3 Sep 2026 07:54:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 03 Sep 2026 07:54:41 -0400
X-ME-Sender: <xms:_V-Zaq-oLXG_tbRV5SL17ux8ZZWIWBI5lch0m-ICKJSNYjW1Kqxdcw>
    <xme:_V-Zam649lsVdZSxRBe8Y4Fkv8iPQl4xoKF8yi7-uhpSI4N_82rXYncBjTcOcrgdl
    jru2YnK1iltr_y3MKD6_bDjGKrjFVmUrmke9Ez28f6iFIpVUGTzVKo>
X-ME-Received: <xmr:_V-ZanLB9z9pZZPNfG871FvzpdzBWebIxdafXCmQk9tqTj5p2-gfcwKhRxA>
X-ME-Proxy-Cause: dmFkZTGRROi4E2jYkPmHGn8HmsKJK+DNhzW0iFBovk5qrcANvc/cyAdiFz8Bf10UjHIIr2
    OCiNRxEcjH1fCCFWSCLqPb2F/nchosJWO+1x6Hoz+5AHWYM5O+CqFcxplyHcG2m0w7RAOJ
    RUZ+jd9/a47JGJrOI5YRYubkQnZiRkL/W1JEXFNtY6qVzb0v768ExU2eXwalE45ySiF3R2
    U4Z7aVpbGLrcxzX2HU/qf4+p9hJ62k5bAdwGbkZvc5vvqB0dtHm9E81ImbEPYAPyYZDO3Z
    xZhLFBqWVSekOwAehorhA1EfjVwqRxpVeLw0fgGTvb/gfBm6l0b+TMrVkfw0ctulats7oK
    wGlwKgXrS8Ti3z540MLDbn7ePC2qI/c2MtU5JUF+dLTMXiRyJivzXiYAn/9wsa0PY1oHXu
    JzW2v+S/SSoVTcbO1JuhD4Nyd0FGNc3o4UObcbk6f1jbDrRJpNJ0EXmUmTp1mwjyGtksB+
    E2wuRcH8c/rtBeyz+MDkuxCE+hb+/e2KAncEfo3PsPYjNhQU6LKaewoSsGySzAeR3lLM5U
    GWx4Tu8ac0h3jZKjFsfGmSSulZ+hKt7eqz9x9VzuosBEqTQAVTDsESwXOF2SwVzeHoF5VZ
    xwz0bboXiq1kvRifcmh7pN2ZbSSOgVvpoezUhaLz0B8RRjYLfKmMTOap1iWA
X-ME-Proxy: <xmx:_V-ZauAr7fM7WQUuNYCB2wNA2X60UGgz1puUga-gXmYLooLrqGZshg>
    <xmx:_V-ZagiOWoUgQIkkfpkSxwqFHXG16Z4VbZnV2_hDIOY49EB37rOr7Q>
    <xmx:_V-ZaiN_RjR92LznnJrMHPgOIsfRfnKwP9OeVFLO-_u5WtWMYA1ElA>
    <xmx:_V-ZasXGbsML7uAsQ1LEveq9goQh64MBgn9PW56oEWw-3GsSNWHk-w>
    <xmx:_V-ZanCiw98vjCVwwHH4u5kXCgv2ETVbsI4nOpwXxgN_C3BUMY9LCzWE>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Sep 2026 07:54:36 -0400 (EDT)
Date: Thu, 3 Sep 2026 12:54:35 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Vernon Yang <vernon2gm@gmail.com>, rick.p.edgecombe@intel.com
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, akpm@linux-foundation.org, david@kernel.org, hpa@zytor.com, 
	rmclure@linux.ibm.com, andrew+kernel@donnellan.id.au, pasha.tatashin@soleen.com, 
	tj@kernel.org, rppt@kernel.org, yu-cheng.yu@intel.com, orsonpeters@gmail.com, 
	linux-kernel@vger.kernel.org, x86@kernel.org, linux-mm@kvack.org, 
	Vernon Yang <yanglincheng@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH] x86/mm: Fix pmd_modify() dropping the dirty bit
Message-ID: <aplfcTfjeQUgnrvH@thinkstation>
References: <20260903031608.1194238-1-vernon2gm@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903031608.1194238-1-vernon2gm@gmail.com>

On Thu, Sep 03, 2026 at 11:16:08AM +0800, Vernon Yang wrote:
> From: Vernon Yang <yanglincheng@kylinos.cn>
> 
> pmd_modify() masks the old value with (_HPAGE_CHG_MASK & ~_PAGE_DIRTY),
> silently discarding the hardware dirty bit.  The subsequent
> pmd_mksaveddirty() call is supposed to transfer _PAGE_DIRTY into
> _PAGE_SAVED_DIRTY when write-protecting, but the dirty bit was already
> stripped from the value, so there is nothing left to transfer.
> 
> Contrast with pte_modify(), which keeps _PAGE_DIRTY_BITS in its mask,
> and pud_modify(), which keeps _HPAGE_CHG_MASK untouched: pmd_modify()
> is the odd one out.  Any pmd_modify() on a writable, dirty PMD loses
> the dirty state.
> 
> One visible consequence is data loss with MADV_FREE on PMD-mapped THP:
> 
>     memset(buf, 0x5A, size);          // PMD-mapped THP, PMD dirty
>     madvise(buf, size, MADV_FREE);    // PMD cleaned but left writable,
>                                       // folio marked lazyfree
>     memset(buf, 0x5A, size);          // hardware sets _PAGE_DIRTY again
>     mprotect(buf, size, PROT_READ);   // pmd_modify() drops the dirty bit
>     mprotect(buf, size, PROT_READ|PROT_WRITE);
>     // ... memory pressure ...
> 
> Reclaim (e.g. under memcg pressure) then finds the lazyfree folio with
> no dirty bit set anywhere and frees it in
> __discard_anon_folio_pmd_locked(), even though the data was rewritten
> after MADV_FREE; subsequent reads fault in fresh zero pages.  NUMA
> hinting alone can trigger the same loss, as do_huge_pmd_numa_page()
> restores the PMD through pmd_modify() as well.
> 
> PMD-mapped file THPs are affected too: mprotect()/NUMA hinting dropping
> the dirty bit means rewritten data is never written back.
> 
> Fix it by keeping _PAGE_DIRTY in the preserved mask, exactly like
> pte_modify() and pud_modify() do.  The existing
> pmd_mksaveddirty()/pmd_clear_saveddirty() pair then performs the
> hardware-dirty <-> saved-dirty transition based on the write bit,
> preserving the shadow-stack encoding rules.
> 
> Closes: https://lore.kernel.org/r/CAJxLxMUGu1-L+O_nAONOwOXnS=cNbNApCWqdthRjd76LThtSPg@mail.gmail.com/
> Fixes: bb3aadf7d446 ("x86/mm: Start actually marking _PAGE_SAVED_DIRTY")

Hm. I don't understand why would this commit explicitly exclude
_PAGE_DIRTY from the mask:

-       val &= _HPAGE_CHG_MASK;
+       val &= (_HPAGE_CHG_MASK & ~_PAGE_DIRTY);

Rick, could you comment? It doesn't look like a typo.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
