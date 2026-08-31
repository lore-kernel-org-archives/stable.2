Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5723E51CC;
	Mon, 31 Aug 2026 11:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788176883; cv=none; b=qnhIA1anNxaaNGLUdAf74KXSrIHKWBcdNtXFIDpmQ//joStkifqKJHp1KBOmpHTDJAT7fWLduj9Dcx7gUfpK6bEK5mav3LNtvivkdZ64i0Bw6tQa866oBxc+JHWIw+Lmko4V4u0gTMQN0j184ACnq7HSI41pWaNKGrn5LTTWqG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788176883; c=relaxed/simple;
	bh=ybxxMyix51xqvrqBGYhUS6IMU27DX79vaaLno+VWho4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FnZARtUNY+EaQwbS0zDjWTkkPKHYTUoKgG3ivEbSeDbgKVP8En5H58mqz49r6S9oiOy7VblxuCZtSpH4crKWJBFYaSFgklL8u2xCxuBuMh3Mgyjx0fYVBhzj2wh9o5NxmlJ8yTrgw9dKvm135bFWJpxOlFOG/6bjJTwJVVLcQKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UHxa2HoV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UHxa2HoV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 523D91F000E9;
	Mon, 31 Aug 2026 11:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788176881;
	bh=ZplZYncnRKFZipftv7wfZbHiyWAoIb0g/sXD3GATNRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UHxa2HoVnTkRM9dXAL4NlPRAfXc44P7fjNSKtyf2HRLbEz4v2On+DWypCl44RJlC3
	 Cx6JCPXv9NPqa/RXFI3Q5+46AACLKpTG2gkyIKi7bQiAQweXLk6GwCcCrmRI8+3xz+
	 1qqouYAqKauRD1DvD9+IBwTri70T0Xabk6xHAe/E=
Date: Mon, 31 Aug 2026 13:47:57 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, stable@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.6.y] arm64: mm: clear extra idmap level before use
Message-ID: <2026083151-mascot-unshaken-5f46@gregkh>
References: <20260831054247.33352-1-kmehltretter@gmail.com>
 <2026083125-upbeat-series-9565@gregkh>
 <7f744f2a-409b-454f-bdb9-fccb5031640d@app.fastmail.com>
 <apVbNN_gtowKWVhR@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apVbNN_gtowKWVhR@gmail.com>

On Mon, Aug 31, 2026 at 01:00:34PM +0200, Karl Mehltretter wrote:
> On Mon, Aug 31, 2026 at 08:15:52AM +0100, Ard Biesheuvel wrote:
> > 
> > 
> > On Mon, 31 Aug 2026, at 07:54, Greg Kroah-Hartman wrote:
> > > On Mon, Aug 31, 2026 at 07:42:47AM +0200, Karl Mehltretter wrote:
> > >> The 6.6.y adaptation of commit 0e9df1c905d8 ("arm64: mm: Don't remap
> > >> pgtables for allocate vs populate") removes the clearing performed by
> > >> early_pgtable_alloc().  Its replacement clears allocations made by the
> > >> generic page-table walkers, but 6.6's create_idmap() still allocates an
> > >> extra root level directly when a sub-48-bit VA kernel is loaded
> > >> sufficiently high in physical memory.
> > >> 
> > >> memblock_phys_alloc_range() does not zero the returned memory.  The direct
> > >> caller therefore publishes an uncleared root page and passes it to
> > >> __create_pgd_mapping().  A stale nonzero entry can trip the bad-descriptor
> > >> BUG_ON or be followed as a page-table descriptor, preventing the kernel
> > >> from booting.
> > >> 
> > >> Clear the direct allocation through its linear alias before publishing it.
> > >> init_clear_pgtable() also supplies the barrier required before the table
> > >> descriptor becomes visible.
> > >> 
> > >> Mainline is not affected because commit e6128a8e523c ("arm64: mm: Use
> > >> 48-bit virtual addressing for the permanent ID map") removed the dynamic
> > >> extra level before page-table initialization moved out of the allocator.
> > >
> > > Why can't we take that change instead?
> > >
> > 
> > Nope. That relies on a massive refactoring of the arm64 startup code.
> > 
> > Can we just revert 0e9df1c905d8 (aka 54322d95309d) instead?
> > 
> 
> Yes, that fixes the issue too.
> 
> The commit was patch 3/3 of the following speedup series:
> 
> https://lore.kernel.org/r/20240412131908.433043-1-ryan.roberts@arm.com
> 
> Patches 1 and 2 accounted for most of the speedup.
> 
> I'll wait a bit to give the others a chance to comment.
> 
> I can send the revert as v2, or my original patch as v2 with the
> missing "Assisted-by: LLM" and "Signed-off-by:" trailers.

REvert would be great, thanks!

greg k-h
