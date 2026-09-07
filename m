Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B711418A6DB;
	Mon,  7 Sep 2026 06:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763627; cv=none; b=A0yxYyNrj2FMN1n2ByciasKG4d+uAJAi8QJ8cYDobYk7l4ME44RaKC3nOnZpfSsp7R8/m7H9OjyTYcIo30CnYbKtrpdA021xjlWALkDGyC77a7Q2l7FtS9wKljwcyBKdWuusdalTLq6DkzMKPHr+ga3FrBcSMCqlu7Z85VrvFtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763627; c=relaxed/simple;
	bh=tca7PimGU09et+8+jXclurn63CWS7YzQd6TXIaQcIxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+u8Kr7D7GOYouBPwRm7AT6sj0c4R9g/X9t8r6LzHPUrFM7Jrp/Jguua9bKrJgiSFvjlxw8tJjYB62sYC0GHakg62QwntONsBlWdZctF3Qz8H4+PK0vvFhuzjyMLIxoW5U8N6Q2A+vzk/rwPxLVnoBtRE4ZlrrzrgmBDn+y1q3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwGAS30i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwGAS30i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0FB91F00A3A;
	Mon,  7 Sep 2026 06:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788763626;
	bh=7Q8SgKaQsoBb0PUNIYstKJgTZKAX/kgSRpOfyb6gKNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cwGAS30i87YTb7mbKD73RynW5ZpmCpbArvIX+3K4KCdmIgqNjLsLRnY+h35gRz+ci
	 oxbuz7G8jerfdbP92HQAslqFFEeJxZTRmXUCCJ8gYF/J8lZFESvuJNUxZJB3lGPtox
	 y+ap7SBqGlZ764UyGLnNFgpTOjrrjAkvFFG80wV2LTCzlFrLeqALk+Eu8Pg03X7bpz
	 LJWzTo/C/OYiSuZcCdJ9xzWO+8woXoO/v6PeckuZQUxMZs+e0yQhl6B7kqXEtkNpT8
	 qOpbYp8kT+kR15XDvleIPnFRDByd/WHrYQpngwBk57p0idj+6rBx9ztlayPrgXSR4m
	 FXH5bk+NmcxgA==
Date: Mon, 7 Sep 2026 09:46:59 +0300
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
Message-ID: <ap5d422O7U0q6rAn@kernel.org>
References: <20260813-cpa-fixes-v2-5-39b4ff90f91d@kernel.org>
 <178837401172.3717435.314324339347590321.tip-bot2@tip-bot2>
 <20260905044253.GA3816371@ax162>
 <b3fe6376-bd3f-4c58-8698-abcca3ad7186@intel.com>
 <20260906181247.GA1148584@ax162>
 <1987b7d6-7aa3-4bcd-9082-f2cdfde7c1e4@intel.com>
 <ap3EgrZJILehwIQK@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ap3EgrZJILehwIQK@kernel.org>

On Sun, Sep 06, 2026 at 10:52:41PM +0300, Mike Rapoport wrote:
> On Sun, Sep 06, 2026 at 12:12:54PM -0700, Dave Hansen wrote:
> > On 9/6/26 11:12, Nathan Chancellor wrote:
> > > On Sun, Sep 06, 2026 at 07:50:26AM -0700, Dave Hansen wrote:
> > >> On 9/4/26 21:42, Nathan Chancellor wrote:
> > >>> I just bisected the following warning on a couple of my test machines to
> > >>> commit 453e78594434 ("x86/mm/pat: Fix effective RW computation in
> > >>> lookup_address_in_pgd_attr()") in next-20260904.
> > >> ...
> > >>> If there is any information I can provide to help debug this, I am happy
> > >>> to provide it.
> > >>
> > >> Well, the thing you bisected to is the patch that fixes the warning. The
> > > 
> > > Hmmm, I don't see a warning prior to this patch though. Do you mean that
> > > this patch is just revealing the bad behavior that you mention below?
> > 
> > Yeah, "fixes" was a bad word to use.
> > 
> > The W^X detection has been broken for a while. The patch you bisected to
> > fixes the W^X detection. It doesn't actually cause the issue.
> > 
> > >> actual issue comes from:
> > >>
> > >>         if (pages == &its_pages)
> > >>                 set_memory_x((unsigned long)page, 1);
> > >>
> > >> which its_alloc() does on an execmem allocation. Any chance you could
> > >> get the output of:
> > >>
> > >> 	/sys/kernel/debug/page_tables/current_kernel
> > >>
> > >> for the page that page that it's complaining about? I'm curious if this
> > >> is temporary or permanent.
> > > 
> > > Sure. For
> > > 
> > >    CPA detected W^X violation: 8000000000000123 -> 0000000000000123 range: 0xffffffffc0200000 - 0xffffffffc0200fff PFN 100e00
> > > 
> > > I think it is this line if I understand correctly?
> > > 
> > >   0xffffffffc0200000-0xffffffffc0400000           2M     ro         PSE     GLB x  pmd
> > 
> > Yeah, that does seems to show it getting fixed up. Thanks! That means
> > that the warning (at least in early boot) is essentially a false
> > positive. The problem is that there's module-load-time patching too and
> > that is much later and is arguably an actual problem.
> > 
> > Oh, and thinking about it a bit more... This warning came from
> > alternatives patching which is too early for normal text_poke(), thus
> > the existence of text_poke_early().
> 
> But text_poke_early is a memcpy :)
> 
> The warning at core text patching is completely spurious because anyway the
> entire kernel text is mapped as RWX at that point.
> 
> This one should be fixed as with the patch below. As for the modules,
> text_poke()ing sounds like the way to move forward and ...

For modules everything should just work, the memory is RW until
its_fini_mod() that resets to to ROX, so there are no RWX violations.

Looking at the code after morning coffee rather than near midnight helps :)

-- 
Sincerely yours,
Mike.
