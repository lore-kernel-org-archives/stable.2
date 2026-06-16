Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A9442847B
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 10:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781607144; cv=none; b=bi/9+VRM1vPsEM7IMsMFt/KIAVnpq6Sr2IEPLquLqekVTryE05HLRWxKJf88zv1kR1ucF8tMuWkYMbXQAT4nkhgrvBZBewfhrCA+/C380aU17vajmooPuHKx+sLcJ+znnkT2FiuqdxWsjqkXCkmqtg3RbdYxf8HPxnKXK1fzIFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781607144; c=relaxed/simple;
	bh=gREfZnfgLmUTFhhzBicAnDy2Je16XA6X8rMqNNigJtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRrupLmh3yl3PiHf2LlqQw69cYLtmf0UN31M8MB2QajdfhaKwEtSRZZcC2eUhhfUKt7g+F+oBWYiPxU68C3lf4gtsLER7HSSzKhhm6uxox8ncLxQzANEeVykBalnyfusPRFgxMFnUmbZkWwdKKqLfKbGW72VG0cXc31JHl9dMpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=gYlVH83J; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="gYlVH83J"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30E8A43D0;
	Tue, 16 Jun 2026 03:52:17 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 94F923F915;
	Tue, 16 Jun 2026 03:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781607141; bh=gREfZnfgLmUTFhhzBicAnDy2Je16XA6X8rMqNNigJtY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gYlVH83Jp6I0D/1Fthy2kS9zB3FEa3R6vK9lAqpwrZ7jJBn6fEo4e9j1omEFPzVU2
	 MJVKQScIveUt0xmiU53mV914DD9Jfx6O7MTAEgs6OWzswvKMIa3bN8x6jPsreamvPC
	 E9w0p8QFbZsmfr+uFAbzI6IZy9beH4teCvXj1aHA=
Date: Tue, 16 Jun 2026 11:52:14 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, catalin.marinas@arm.com, lee@kernel.org,
	sdonthineni@nvidia.com, will@kernel.org
Subject: Re: [PATCH 6.18.y 0/5] arm64: errata: Mitigate TLBI errata on
 various Arm CPUs
Message-ID: <ajEq3rRp8rYQg7Fu@J2N7QTR9R3>
References: <20260616051329.111597-1-mark.rutland@arm.com>
 <2026061655-veggie-rerun-83e6@gregkh>
 <2026061658-landowner-dangling-5d07@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026061658-landowner-dangling-5d07@gregkh>

On Tue, Jun 16, 2026 at 03:34:27PM +0530, Greg KH wrote:
> On Tue, Jun 16, 2026 at 03:31:11PM +0530, Greg KH wrote:
> > On Tue, Jun 16, 2026 at 06:13:24AM +0100, Mark Rutland wrote:
> > > This is a v6.18-only backport of a workaround for a TLB invalidation
> > > issue affecting several CPUs. The final patches landed in mainline
> > > yesterday:
> > > 
> > >   https://lore.kernel.org/linux-arm-kernel/178157002783.358810.8206806281627742561.pr-tracker-bot@kernel.org/
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=80476f22b8b7e193b26f285a7c9f9e4b63abca16
> > > 
> > > This issue has been assigned CVE ID CVE-2025-10263, and Arm have
> > > published a security bulletin:
> > > 
> > >   https://developer.arm.com/documentation/112137/latest/
> > > 
> > > I've pushed a copy of this backport to my kernel.org repo:
> > > 
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=stable-6.18/arm-4118414/backport
> > 
> > Should I cherry-pick these to 7.1.y and 7.0.y as well?
> 
> Ok, cherry-picking didn't work well, I gave up on patch 3...
> 
> Can you send backports for those branches too?

Sorry about that.

I'll send out backports for v7.0.y and v7.1.y later today.

Mark.
