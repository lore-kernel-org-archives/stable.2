Received: from flow-b8-smtp.messagingengine.com (flow-b8-smtp.messagingengine.com [202.12.124.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C905360EF2;
	Fri, 25 Sep 2026 08:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790326071; cv=none; b=S8LuK0Y6wq8nPZdGkQLuU88qTflA0LOk1+3hwpw5y0kfpBhXinfXU64698n909s2R0kDoSpTQ9X5PURfhYdTQVeTC/gn0Vw3PjBwwKWCt9GoXEBmYkLktlMhBFb/5rjUmdKSSSDsZaS+8rC9Vlq9S296+f3cDKQ9R0eT98/6vhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790326071; c=relaxed/simple;
	bh=rMLqjiIwp6Rf3l7p9+AQhM2Z8mwzvWc66Gpf/0Rlh8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ro3melNk5ltkzb+NkEFZ8pXmvFd/Kq8EOOBTs7T30PUTXQaa5eC30Vefycp0VRq62YpJPmyPZVaQkXbXm8rUVZztU62Eirgh0cpt5z0QEUVpZz7r25AcVy9dlGtsAOMtc3gKmyXPjUPH/5USf3MOXSu3lKDlPQsNCwNTsA6vE1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=PbbXW9Ih; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nIzolef2; arc=none smtp.client-ip=202.12.124.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="PbbXW9Ih";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nIzolef2"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id F2B4E13010D1;
	Fri, 25 Sep 2026 04:47:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 25 Sep 2026 04:47:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1790326056; x=
	1790333256; bh=tCBr0UIM+ZOSlkOXM66AmLoOKnOh8wXT+x6TqU1msEQ=; b=P
	bbXW9IhAXl2dv579QJm3Q65uwaUKl6JRdur6WuArNK7mw2GFamPQ2zTi8Wl8L3zj
	/HVziA0Tqc6dBhO8tLa1iaQQSnfhCkWxaZQMClQMv6+Ve7vj6SmZt8DDHcH7xBqE
	kc1g/8h7KeQVgr1pc3M8+BuisCxcJooKcRgF7BlLLZbN/4VXubYXf+i7AZLNe0ZU
	f1GWnx2YZbTC/sqfcd8/vVPIXgLeXApDv7scOvN51dON+k0EO6svNqWgNQZ7bPrV
	5npZnEkQKfmAVWxzOLwweOdfM0IK6privz7v7D6sqt0ku84yi4qIVFX3j/iUJHOv
	DZ8tAVYQGpNfa0VR74D2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790326056; x=1790333256; bh=tCBr0UIM+ZOSlkOXM66AmLoOKnOh8wXT+x6
	TqU1msEQ=; b=nIzolef2YYoegmGajku3bWR6RQPfleyIsgsLvEB48c1+OIuxUM/
	DI7/7PXdb4lsyvyne2GphrUlW8HFJBbi1tDsnHNljBw1ccpL+axG1YZUNSzDYmcc
	vzzAUj0FvBVsnY+BfQS5PqPkt5VZcrFS2BzcJ9tcsKqNComjMcqGrEQq324r1jB8
	SASvwQhH6jQtEPMV5+LH8SqCAV5mg4HwUUIw7Qm+FhHmXG1CHvm5dZw68/90FJRS
	/Fn7C6nV/7XRm2EcWVrchnmF+47cj/r8NsOmQkcBbJsPW+XEwG/t3LhzpBgnX5l6
	6VtBZJ+FLkPdtKl/tszppnXmVdQtgeYIrwA==
X-ME-Sender: <xms:KDW2auny5uRt6LjfjXmh92A95qmL8RdpmrgbKd9eJ-MBjY2Bpen9Nw>
    <xme:KDW2aoJnWI4JSm0kuXBIYbkyputDbxvyIsag5zcxJ6wOkeAMVApX4DEc9v0bZ6ZM5
    zk-1fpLhbDTDCWx_XPrcEu6vOREEgpArnmCqM80QCyVJDtV-iItqen0zg>
X-ME-Received: <xmr:KDW2arU7Tk0LyQW4QjMuiPl08UW0IDQ3_Z6fNcL1qv8x4GhvvaNMc0qLeCM>
X-ME-Proxy-Cause: dmFkZTE8kmhn51s93gEL4j5H/7PvaLCa+mnP6uN/rdMzANRhDhcdNNZL3sAjI1QoWaVkua
    Bgg4YxoH/NrFlGs+IQPNyUzZRouZGayZskRSc0kDeB9PGdnVVbrJah4HJV23mSkK597Lnz
    O5aIMe3MqpJpXd7nyNHwfgXLzGNm4aVKvH9aRpiVPiA5bMvrYKA3ej72/BqpcMcdHDwJqS
    s7Zu2wQ9Nc5aOqx4Scfie5/eZK008o/dmXkjr66IXwfjsmPElYIOafuWx6XLTPM1YUsfA6
    qCTl2GkfCbcpitCX7FkvDWmkeRF/qPgUbfWzWJAtdw6BtQX8kpcVtFrjby1KhaSKa11mHL
    iexPnZOwy+iLCsMNmbV28vNK4rm0H/odzH9Qw8cUKIP4NdESfQ7EWgcqJ/KCcs+RimSaS9
    FQdJSI3zvaIsYFuxrfjOm3NRw5Z88cOyD/yWvVikRFuBG2onu1uiwDMP4K9fTz8ZdUiegQ
    5mQZr2SfNC2vc+KqUm0kGHex8rXkLWhfyWSgYJU0OnghDc5NqFj9N2ei3T8b/kC9wgOC0Q
    WOEo5vOQ3Zq5AkckuyhuXBhl/sUiu4J54ClJXvbtRSjfSI8yXOaNOxfFstLPCBRqzguVrq
    FUVC7rVlBqES7lZGboj0m0tbG4Ezg7K9r1CKqFuashA7l2btiDmQ35O4t/ng
X-ME-Proxy: <xmx:KDW2avgf_a33O3TuMjXtVn6u4jydTeZ0D036Kde6cPwoMKeoDXGblA>
    <xmx:KDW2aqeJsKUXmjbeZtjUdVp-VIJawYFq5pDmI1aFF0Msrx0lbse85A>
    <xmx:KDW2ahtWmg-5FVBKMbGkyL3xs_r1l8H8YHahJfm7mqUAOCDlTFUF4g>
    <xmx:KDW2ankBbCNWvbkpphtAXKHGYXzKozwMXvWRvxcwR6_mNAVFPNZEOw>
    <xmx:KDW2aqjmKRE0-8Efa-WwFeJ6hL9TY27XA8hySSb49pUrgdzhLTWlM1TG>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Sep 2026 04:47:35 -0400 (EDT)
Date: Fri, 25 Sep 2026 09:47:34 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Donggeun Yoo <donggeunyoo.kernel@gmail.com>, akpm@linux-foundation.org, 
	rppt@kernel.org, peterx@redhat.com, surenb@google.com, aarcange@redhat.com, 
	ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, mhocko@suse.com, 
	shuah@kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1 1/2] userfaultfd: clear the inherited uffd bit in
 move_swap_pte()
Message-ID: <arY0shOhxugdxT4E@thinkstation>
References: <20260919004630.1159895-1-donggeunyoo.kernel@gmail.com>
 <20260919004630.1159895-2-donggeunyoo.kernel@gmail.com>
 <arO0a3CU_idyVsqQ@thinkstation>
 <90fc724a-08c4-4324-9420-89fab05d53d1@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90fc724a-08c4-4324-9420-89fab05d53d1@kernel.org>

On Fri, Sep 25, 2026 at 09:01:22AM +0200, David Hildenbrand (Arm) wrote:
> On 9/23/26 13:18, Kiryl Shutsemau wrote:
> > On Sat, Sep 19, 2026 at 09:46:29AM +0900, Donggeun Yoo wrote:
> >> UFFDIO_MOVE on a swapped-out page installs the source PTE at the
> >> destination unchanged, so a uffd bit set on the source lands in a
> >> destination VMA that was never registered for write protection.  It is
> >> then permanent: the bit is dropped only by change_protection() under
> >> MM_CP_UFFD_{WP,RWP}_RESOLVE, which uffd_wp_range(), mrwprotect_range()
> >> and userfaultfd_clear_vma() issue only for a VMA registered in that
> >> mode.  pagemap reports the page as uffd-tracked, and MADV_COLLAPSE
> >> refuses the range while the bit is set, because collapse_scan_pmd() is
> >> strict about uffd on swap entries.
> >>
> >> move_present_ptes() and move_zeropage_pte() build the destination PTE
> >> from dst_vma->vm_page_prot and arm RWP only when dst_vma asks for it, so
> >> the destination's own registration decides the result.  move_swap_pte()
> >> copies the source PTE instead and only ever sets the bit, never clears
> >> it, so one UFFDIO_MOVE behaves differently depending on whether the page
> >> happened to be resident.
> >>
> >> Clear the uffd bit on the moved swap entry unless the destination is
> >> RWP-registered, as copy_nonpresent_pte() does where it installs a PTE
> >> into a destination that may not be armed.  A WP-registered destination
> >> stops inheriting the bit as well, which is already what it gets when the
> >> moved page is resident.
> >>
> >> Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> >> Cc: <stable@vger.kernel.org>
> >> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
> >> ---
> >>  mm/userfaultfd.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> >> index 74f04c323c50..6495666c596b 100644
> >> --- a/mm/userfaultfd.c
> >> +++ b/mm/userfaultfd.c
> >> @@ -1452,6 +1452,8 @@ static int move_swap_pte(struct mm_struct *mm, struct vm_area_struct *dst_vma,
> >>  	/* Re-arm RWP on the moved swap entry if dst_vma is RWP-registered. */
> >>  	if (userfaultfd_rwp(dst_vma))
> >>  		orig_src_pte = pte_swp_mkuffd(orig_src_pte);
> >> +	else
> >> +		orig_src_pte = pte_swp_clear_uffd(orig_src_pte);
> > 
> > Putting it in the 'else' is wrong. Clear uffd on the source
> > unconditionally and re-arm based on the target VMA:
> > 
> > 	orig_src_pte = pte_swp_clear_uffd(orig_src_pte);
> > 	/* Re-arm RWP on the moved swap entry if dst_vma is RWP-registered. */
> > 	if (userfaultfd_rwp(dst_vma))
> > 		orig_src_pte = pte_swp_mkuffd(orig_src_pte);
> 
> I'm confused why the original code proposed would be "wrong"?
> 
> I prefer your way of writing it as well, but I don't understand why it would be
> "wrong"?
> 
> Maybe I need more coffee :)

It gives the right result, but communicates wrong reasoning to the reader.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
