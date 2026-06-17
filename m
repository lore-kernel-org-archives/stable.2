Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D79492182
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 15:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781710891; cv=none; b=u5KfpuK15rZtGsyE4/9pOVsmhIzXTUxqrhqaIYUSNi7wlds64DaSBAa6U4VFJtxoP74BglD2kMBUIjdIe7GDYmzCCTSzutoakLJ6ncDaW/hAVqQRUGPIjJtqzGCen69qeaCB18mXKyf9L/4zq/6/EFoYBbhFhYawXkOJVsoZhtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781710891; c=relaxed/simple;
	bh=sj2X5KYK9Qw6VQOUT10LVyWyhkAog43+vpDeeGJyO8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oAy8Rd/Kne2ddiYUyLtSNOqjiARhAeyqY1hMR3MyzKANlaygDYA9DlQfLRN8bbiPPMHCsl7x+hJClDC52PG4xATsU5WCW680Bcf2LgNEbv+35BVNyaj0c8jILmemLHCvqfkavyfCxxCUHOV+N08ERx8GW+Q28bpFJSFH6PKGgh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CXewF/Sa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CXewF/Sa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6341A1F00A3A;
	Wed, 17 Jun 2026 15:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781710876;
	bh=nBn2p8pdyU3TZYXBqSMJNqI2gqJzj4w30AULxwSyvjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CXewF/SaT6pjB+vSmXGkNyp5AQl1tox8c/LYnVxVyFgFyQHUdnVeJdzPjm8gJgRa4
	 0gtsn0Auta/7a8quH9IFMDyaSqomlxCjT8Xh8a2HlVDPnQWWJ1uKU3pt9ySIfaSyOQ
	 byX2cOdhAfqfFXXgo6D847Tp4PgHXzcIfdo+vxPE=
Date: Wed, 17 Jun 2026 21:10:08 +0530
From: Greg KH <gregkh@linuxfoundation.org>
To: Petr Machata <petrm@nvidia.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	Wojtek Wasko <wwasko@nvidia.com>,
	Mahesh Bandewar <maheshb@google.com>, Shuah Khan <shuah@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Yong Wang <yongwang@nvidia.com>
Subject: Re: [PATCH 6.1.y] Revert "selftest/ptp: update ptp selftest to
 exercise the gettimex options"
Message-ID: <2026061754-patronage-wilt-e4fa@gregkh>
References: <2e4d2f2b9efa7b0b32476947f63506cfe9568d1d.1778851656.git.petrm@nvidia.com>
 <2026061639-antennae-upstage-bd52@gregkh>
 <2026061610-lying-manor-2d57@gregkh>
 <871pe5i3v1.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871pe5i3v1.fsf@nvidia.com>

On Wed, Jun 17, 2026 at 05:22:44PM +0200, Petr Machata wrote:
> 
> Greg KH <gregkh@linuxfoundation.org> writes:
> 
> > On Tue, Jun 16, 2026 at 06:58:53PM +0530, Greg KH wrote:
> >> On Fri, May 15, 2026 at 03:53:53PM +0200, Petr Machata wrote:
> >> > This reverts commit 06954f715deb0ed053f8bf85547370db6870225d, which is
> >> > commit 3d07b691ee707c00afaf365440975e81bb96cd9b upstream.
> >> > 
> >> > The cited commit allows testptp to set a configurable clock_id. That is
> >> > done via a PTP_SYS_OFFSET_EXTENDED ioctl call, whose argument is struct
> >> > ptp_sys_offset_extended, where the clock_id is set. However, this Linux
> >> > version does not support the ptp_sys_offset_extended.clockid field, and
> >> > the test case cannot be built against this tree's own UAPI headers.
> >> > 
> >> > The reverted commit was introduced to resolve a missing dependency of
> >> > commit c6dc458227a3 ("testptp: Add option to open PHC in readonly mode"),
> >> > which is 76868642e427 upstream. My suspicion is that the only conflict
> >> > between the two is the getopt string, and there is otherwise no direct
> >> > dependency between the two.
> >> > 
> >> > This patch therefore reverts the cited commit, with hand-resolving the
> >> > getopt string to include 'r' (as introduced by c6dc458227a3), but not
> >> > 'y' (introduced by 06954f715deb).
> >> > 
> >> > Reported-by: Yong Wang <yongwang@nvidia.com>
> >> > Signed-off-by: Petr Machata <petrm@nvidia.com>
> >> > ---
> >> > 
> >> > Note: the issue appears to exist in 6.6, 6.12 and 6.18 as well.
> >> >       Depending on your preference, I can prepare separate
> >> >       patches for those branches as well. Let me know.
> >> 
> >> No need, I did it now for those branches too, thanks!
> >
> > Oops, nope, spoke too soon, 6.18.y still needs it, this one doesn't
> > apply there.  Can you send that revert?
> 
> My bad, 6.18 does appear to have the field already.
> 
> In fact, looking at 6.12, I see it as well. I am not sure why I thought
> 6.12 and 6.18 are impacted. I wonder if I looked at at 5.12 and 5.18 by
> mistake.

So should this be dropped from 6.12?

thanks,

greg k-h
