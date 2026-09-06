Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833531EB1AA;
	Sun,  6 Sep 2026 19:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788724362; cv=none; b=IadCwuLUt1UMh+s1ixspFl0bULc+p3+66hWy6g5xQVzuDvnOOymMvOPQ4CW23t1vwKtzNS1oLenn7dqEOUZa9oVwEnQL92vMxdOG52kndvnjP6ec0trye6sDOPE0cs9zMrk7Yu9j9puj6cB3ONBYBYsUJXDFxTwkiLNlV48Fqao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788724362; c=relaxed/simple;
	bh=OA6vPk1cj13Z7r23IRYKry6s5N4X9utwCg7tuvNfRBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOA7hbazxEmEf1tT/IdAgdrMMaCafLYuamvsdVl26eiPkdfxjWjkC7fZowxLuBUl3PHSFqk1gx0+v92HU4Q1pgj2oEsUgTRd70av7cwGb6Xw8RexL3KyJYexdgPUXBlvhc/mIeo1JQ90vBwqOeM1zDku6HkgSDi6EVWXFDFVArs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EBErOy9C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EBErOy9C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535B31F00A3A;
	Sun,  6 Sep 2026 19:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788724361;
	bh=fgI5axET70L7iQ52jUKyjZguO+vam3RREyyEnjLL8/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EBErOy9CMwEEXmlSmRkILsDJPsrX5A7AV0ucsCEYAr9VyPfsGBk1ESaXmzJYWgXr2
	 JrW3TXND0QNocYZPVgyxPTvmF2R+07lq0GY3TP+9F7bBM7zTyizXGx4p8iN9ZIvDxc
	 p+PaJcPEjDb4LXzH4ksPQo6yYKTMWs4GhYMPZ6856NhRmvOT8lYtq5fgpf+dTsw0Pu
	 G9gDbdjOHbq4E6EbFUvD/NXmS3tCgac0/UEXhAyi6i4mFR2ql6sxL663JrZJjywSaa
	 Wqp59RHk733pxXvVtL2cK6bOIs07GaYC6eSgSRUNIMn6q1GzXlKFl0UEAU5Jf97wQO
	 eN39WXK/kkpww==
Date: Sun, 6 Sep 2026 22:52:34 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-tip-commits@vger.kernel.org, Juergen Gross <jgross@suse.com>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	syzbot@syzkaller.appspotmail.com, Atish Patra <atishp@meta.com>,
	Nikunj A Dadhania <nikunj@amd.com>, stable@vger.kernel.org,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [tip: x86/urgent] x86/mm/pat: Fix effective RW computation in
 lookup_address_in_pgd_attr()
Message-ID: <ap3EgrZJILehwIQK@kernel.org>
References: <20260813-cpa-fixes-v2-5-39b4ff90f91d@kernel.org>
 <178837401172.3717435.314324339347590321.tip-bot2@tip-bot2>
 <20260905044253.GA3816371@ax162>
 <b3fe6376-bd3f-4c58-8698-abcca3ad7186@intel.com>
 <20260906181247.GA1148584@ax162>
 <1987b7d6-7aa3-4bcd-9082-f2cdfde7c1e4@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1987b7d6-7aa3-4bcd-9082-f2cdfde7c1e4@intel.com>

On Sun, Sep 06, 2026 at 12:12:54PM -0700, Dave Hansen wrote:
> On 9/6/26 11:12, Nathan Chancellor wrote:
> > On Sun, Sep 06, 2026 at 07:50:26AM -0700, Dave Hansen wrote:
> >> On 9/4/26 21:42, Nathan Chancellor wrote:
> >>> I just bisected the following warning on a couple of my test machines to
> >>> commit 453e78594434 ("x86/mm/pat: Fix effective RW computation in
> >>> lookup_address_in_pgd_attr()") in next-20260904.
> >> ...
> >>> If there is any information I can provide to help debug this, I am happy
> >>> to provide it.
> >>
> >> Well, the thing you bisected to is the patch that fixes the warning. The
> > 
> > Hmmm, I don't see a warning prior to this patch though. Do you mean that
> > this patch is just revealing the bad behavior that you mention below?
> 
> Yeah, "fixes" was a bad word to use.
> 
> The W^X detection has been broken for a while. The patch you bisected to
> fixes the W^X detection. It doesn't actually cause the issue.
> 
> >> actual issue comes from:
> >>
> >>         if (pages == &its_pages)
> >>                 set_memory_x((unsigned long)page, 1);
> >>
> >> which its_alloc() does on an execmem allocation. Any chance you could
> >> get the output of:
> >>
> >> 	/sys/kernel/debug/page_tables/current_kernel
> >>
> >> for the page that page that it's complaining about? I'm curious if this
> >> is temporary or permanent.
> > 
> > Sure. For
> > 
> >    CPA detected W^X violation: 8000000000000123 -> 0000000000000123 range: 0xffffffffc0200000 - 0xffffffffc0200fff PFN 100e00
> > 
> > I think it is this line if I understand correctly?
> > 
> >   0xffffffffc0200000-0xffffffffc0400000           2M     ro         PSE     GLB x  pmd
> 
> Yeah, that does seems to show it getting fixed up. Thanks! That means
> that the warning (at least in early boot) is essentially a false
> positive. The problem is that there's module-load-time patching too and
> that is much later and is arguably an actual problem.
> 
> Oh, and thinking about it a bit more... This warning came from
> alternatives patching which is too early for normal text_poke(), thus
> the existence of text_poke_early().

But text_poke_early is a memcpy :)

The warning at core text patching is completely spurious because anyway the
entire kernel text is mapped as RWX at that point.

This one should be fixed as with the patch below. As for the modules,
text_poke()ing sounds like the way to move forward and ...

> Anyway, I'm curious what Peter wants to do with this.

... I'm also curious what Peter will suggest :)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index c38faf39ce152..42ea8b4234b82 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -686,6 +686,10 @@ static inline pgprot_t verify_rwx(pgprot_t old, pgprot_t new, unsigned long star
 	if (!(__supported_pte_mask & _PAGE_NX))
 		return new;
 
+	/* skip verification until kernel text is set to read only */
+	if (!kernel_set_to_readonly)
+		return new;
+
 	if (!((pgprot_val(old) ^ pgprot_val(new)) & (_PAGE_RW | _PAGE_NX)))
 		return new;
 
 

-- 
Sincerely yours,
Mike.
