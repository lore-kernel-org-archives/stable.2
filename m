Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F073382F9;
	Tue,  7 Jul 2026 17:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783443939; cv=none; b=P60Zj7Kxe/VNdGzzguwC2yJ9140Jotn7T4RRzW+HsYq+xIJhtHrOHQ56bvKijkJYK8HwmxCrFjJw9Bf9ONfb+C7bXOIYxB5IPJbPZmVFSPpQtDnggJGBIavZN6u+w9Twr0OEftHPB+GgVKWlUD8sfNQWaUGvlUC2uOLWc89VO6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783443939; c=relaxed/simple;
	bh=KEHxTtsl41KswiDo90xFdJrLDf6xCa7cgueyLvhvmic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ct8tdBlkHbEKyHgFIkAymzwpHzDZVmU1w4W7jNtIMFmlcsSQVqr0Nzab4UPzIDKHhDb2SEB8VAlKIOumqElHxLXV7fZzFeKKvRUPRUdyVv8yfN8Bbac2E5bQUjUfN10yObN8Bg0LtjUd+2ibHD96eE/RJke7RKl4F7KWDtJrofw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=UutIYnkM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ns2IwfsX; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="UutIYnkM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ns2IwfsX"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 6695CEC0182;
	Tue,  7 Jul 2026 13:05:36 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 07 Jul 2026 13:05:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1783443936; x=
	1783530336; bh=dh7IO6rJY00utCxWkBxZI6oDTG8b9OIvf3pFDe9X22o=; b=U
	utIYnkMUqBeYJ/0pyMM0v6Way1XFBWXpEjI81ZdzIq5ksYmwg4RHuZ8eOJL2s34z
	OXkIFtRPAWLdEO1hSRe2FG22YJPcUwDOmzh09uDJomBczCh9syMqywqBC+U5FCzu
	cEfZAtuBBjBgn6RLyJbKIPQGg2FH2wgzX84j311KZXySDde7hN70rHMihzJKrydO
	cdRlxnpIk4SdNZ38HHgISZSWNy/+ZPnuQa1Nj8HEeJEAIuX64Qw1cstKbgVo9I6H
	Iyw6Uox3gLirGjv7Sw6bt4A7FnMltngZCkv7GW7Q/gRjsXPfkdRAT3Dv+tBJhinF
	z9Ygngv7guvRkT+kiG6Yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783443936; x=1783530336; bh=dh7IO6rJY00utCxWkBxZI6oDTG8b9OIvf3p
	FDe9X22o=; b=ns2IwfsX+9pdi/X/uLuQhb7ryjY81q6v/qiNCTwO8lVsZj9qdvz
	icz+xzZViEdPkNAZtSPkR47iq3enMRFVz1nH7qwAtWyuSmEucQg87z/SuznyFwvm
	A1B0O4NVaOoc3bu7//Gbq9sMn8tYB9NK5u4fKpKcMITZgM3l42a4iwD7kEHlPuLg
	uL1CbIAE4ODoDLQQd5ilBc4kcEmnlfe9t8QvLCGMziEOGUv7sOA4MMP/6POuBNzt
	SOr3/K31Ofth6dKdZPRkJnl4Fz1+RG8Tn+vmyqcVEWpmxU6HxUaRsT4ayPeVEcIU
	dpNrBOd28gJBcIV3abSTNfFkQWqayK1JoPw==
X-ME-Sender: <xms:4DFNalCMtnaJ2xvShANHrYSwsnRSzkIUSVtZeTdFoROzmQs5JcJfOw>
    <xme:4DFNapC9KJJaGbQA2y4Ylg4fwt6EG2QUzK3z9TZ3Jn_bMIDn8GLLzWpTzXvzz69QX
    sFM5jsYbQP5RuJ60i26RRFHiMsmTbHXwVlhKqdiUz-jykWy671b2-M>
X-ME-Received: <xmr:4DFNao6tgthKXOngEKjQz1p1WhefLAzCojHVICjUlzzHS8w3JUKKi0jowdvZPQ>
X-ME-Proxy-Cause: dmFkZTEGSpDUWObu6TWZb4QSLM1eEyRYKmhxlPRhOVqLounqixVImzwTqjRlbYuMfaogN+
    kROBczESMsWnH4+pws8Be4hW1tms7ZIMwCL3biCzS7w1TMvCKK+7GkzosUFvTVFFeXhd6d
    9mj/UlpKJJBJVMg9txZEn/uZucdLzc4ZZQ7WX9/IPzzelQLXmpzFBLwD+Ly3X8HRedtMa1
    nJruo/mjZTWThclPzchFJES8rU61UDQVpSNAFlL8+yRw+bJwv0H3005uKjFu0WIo1N0gmS
    Nf+88WySWFa2gIPgyREiexDBebKGgn4bO2dEjrkVW8CIKxmsEBIxV6OZwl8EOv8xYJoHe+
    oZoZU2mFjTazV8VTLW0duM6T+OukXtF5MAxgUxiHPbipU2pxLQ/qmrsg2JHrjEIDql78/Y
    TcVRVgN05vhNHjGHvB/d5jG1pAV7kao3283/v2+mBIO4Lr7JtGLqmjRYInimNwjadLsKUA
    +a4TrMBSWPN5OXHtYU+cKRWsS7Uck3PgfsEeZGSc/db7A1dyMetUmS6ieRbgwLJtKGHhtY
    wXOERzFpHBrxz/ce/83WwD5glL6E3IHppgFCsn2WXRMvurjh2J3+43mc+I2pTzqtw1BSXj
    GK3OGSZ1hSnT1o4i71BdbvhvZ3vpOHEzwyR0NP6ewBOLYkMzqW4j33dCuolg
X-ME-Proxy: <xmx:4DFNat04MFZnoJnwSQA9W8XJD6Laj5ax7nN7sxLvDUNsc3sABfjmvQ>
    <xmx:4DFNasB6URuqjaIB0kV6PSVPJenfNXE6JEOHj3qajGRKnatQiS8uzQ>
    <xmx:4DFNalHNn5S4vvllsZGZL5CDoie9B8As5F3hbo-vxUDMTH4KQ9Bz8A>
    <xmx:4DFNahSPEHQj_yThMyj67bdlrr0Cw5FL5GWrVFqQ625I8CxqKMajUw>
    <xmx:4DFNaiFbh355b2orDABzMgFDo-gVttvz_Sipt0O1VkhvHox51pNoNBkx>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 13:05:35 -0400 (EDT)
Date: Tue, 7 Jul 2026 18:05:34 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: akpm@linux-foundation.org, muchun.song@linux.dev, osalvador@suse.de, 
	peterx@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] mm/hugetlb: fix swap entry corruption when clearing
 uffd-wp at fork()
Message-ID: <ak0w7MB_wKJtBLNu@thinkstation>
References: <20260703161833.57416-1-kirill@shutemov.name>
 <678ecae4-cda7-4683-9012-ed7c5c5b879f@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <678ecae4-cda7-4683-9012-ed7c5c5b879f@kernel.org>

On Tue, Jul 07, 2026 at 05:05:49PM +0200, David Hildenbrand (Arm) wrote:
> On 7/3/26 18:18, Kiryl Shutsemau wrote:
> > From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
> > 
> > copy_hugetlb_page_range() clears the uffd-wp bit of hwpoison and
> > migration entries with huge_pte_clear_uffd_wp(), which operates on the
> > present-PTE bit position. Swap entries keep the uffd-wp state elsewhere
> > -- the same branches read and set it with pte_swp_uffd_wp() and
> > pte_swp_mkuffd_wp() -- and the present-PTE position falls into the swap
> > payload. On x86-64 it lands in the inverted swap offset, where a
> > naturally-aligned hugetlb PFN always has the affected bit set, so the
> > clear advances the encoded PFN by two pages.
> > 
> > No userfaultfd needs to be involved: the clear is guarded only by the
> > child VMA not being uffd-wp registered, so a plain fork() with an
> > in-flight hugetlb migration entry (or a poisoned hugetlb page) corrupts
> > the entry copied into the child. Instrumenting the hwpoison branch and
> > forking after MADV_HWPOISON on a 2MB anon hugetlb page shows:
> > 
> >   offset before=120e00
> >   offset after =120e02
> > 
> > The fallout is mostly latent: rmap walks match migration entries by
> > folio range and remove_migration_pte() rebuilds the PTE from the folio,
> > so a within-folio PFN skew heals once migration completes. But any path
> > that re-encodes the corrupted offset -- e.g. hugetlb_change_protection()
> > rewriting a writable migration entry via
> > make_readable_migration_entry(swp_offset(entry)) -- propagates it, and
> > an hwpoison entry misidentifies which page is poisoned.
> > 
> > Use pte_swp_clear_uffd_wp(), matching copy_nonpresent_pte() and
> > move_huge_pte().
> > 
> > Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
> > Closes: https://lore.kernel.org/all/20260703140011.99E601F000E9@smtp.kernel.org/
> > Fixes: bc70fbf269fd ("mm/hugetlb: handle uffd-wp during fork()")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> > Assisted-by: Claude:claude-fable-5
> > ---
> >  mm/hugetlb.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 571212b80835..a4e6dd3a82f4 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -4918,7 +4918,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
> >  		softleaf = softleaf_from_pte(entry);
> >  		if (unlikely(softleaf_is_hwpoison(softleaf))) {
> >  			if (!userfaultfd_wp(dst_vma))
> > -				entry = huge_pte_clear_uffd_wp(entry);
> > +				entry = pte_swp_clear_uffd_wp(entry);
> 
> I think installing a hwpoison pte will actually drop the uffd marker.
> 
> hugetlb_change_protection() does nothing on hwpoison entrues.
> 
> So how could be possibly get a hwpoison entry with an uffd-wp bit set here?
> 
> If we indeed can't, Id assume there is nothing to clear here at all.

You are right.

I am inclined to remove it in a separate cleanup patch. Any objections?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
