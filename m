Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D39B299A87
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 13:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781616639; cv=none; b=UEoPDNwx2GWqgH9wnlX5VimCdFp/1GH4ifH3SVp07c8Z68i0qDV+xBSmU1yDhyjtzgJqrVDzJv3fGGPinHEA6Ur+YJdQ5otr5H/EZPauYmPiiJeUrhdo7BVmnec5aE7F5Haz1sXWNNkcC5IcqlnIhFckTQ0EMtpYmpOr4bEJ0WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781616639; c=relaxed/simple;
	bh=sBRcbmTzOu8TXzhiWw0fI3obJUXvMsF1cuhkOIFn7mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LjtpoPaJrzz5CRiQkNRtDdQF09RbgzPp6K7/wJIJ3Jy0fn56Lmq/UkKXTKfV7nEW51wnhQZip9mbObeR0Ix7UHZCyUehx9Q2Zkrkk9biY1jm/tWQnFXVAJlISBmVSq3XsKgyklhS9fUSHQLTKNxiG2BAHsPukEiNTIPobtvJOAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IxyUvvZt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IxyUvvZt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 184301F000E9;
	Tue, 16 Jun 2026 13:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781616638;
	bh=9OnGf72Cxu8l9KSsIJL67D6foomoCU1PO/Jfc++OIJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IxyUvvZtBnEhfRB9+gl61IW8M0FgIoPZyhLrd29XLxuLZqLcpHtUkoIb75a9ir5tB
	 6c+poTC4VEy0yVfEf/schJ26TgZNatG64k5Ka2mMhIEmX+tvjDwwiDnQqglQlKSO4i
	 KsBGyqKbnq/kS9iqMq00vSAml+3r0D8770XdgFLc=
Date: Tue, 16 Jun 2026 18:59:32 +0530
From: Greg KH <gregkh@linuxfoundation.org>
To: Petr Machata <petrm@nvidia.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	Wojtek Wasko <wwasko@nvidia.com>,
	Mahesh Bandewar <maheshb@google.com>, Shuah Khan <shuah@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Yong Wang <yongwang@nvidia.com>
Subject: Re: [PATCH 6.1.y] Revert "selftest/ptp: update ptp selftest to
 exercise the gettimex options"
Message-ID: <2026061610-lying-manor-2d57@gregkh>
References: <2e4d2f2b9efa7b0b32476947f63506cfe9568d1d.1778851656.git.petrm@nvidia.com>
 <2026061639-antennae-upstage-bd52@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026061639-antennae-upstage-bd52@gregkh>

On Tue, Jun 16, 2026 at 06:58:53PM +0530, Greg KH wrote:
> On Fri, May 15, 2026 at 03:53:53PM +0200, Petr Machata wrote:
> > This reverts commit 06954f715deb0ed053f8bf85547370db6870225d, which is
> > commit 3d07b691ee707c00afaf365440975e81bb96cd9b upstream.
> > 
> > The cited commit allows testptp to set a configurable clock_id. That is
> > done via a PTP_SYS_OFFSET_EXTENDED ioctl call, whose argument is struct
> > ptp_sys_offset_extended, where the clock_id is set. However, this Linux
> > version does not support the ptp_sys_offset_extended.clockid field, and
> > the test case cannot be built against this tree's own UAPI headers.
> > 
> > The reverted commit was introduced to resolve a missing dependency of
> > commit c6dc458227a3 ("testptp: Add option to open PHC in readonly mode"),
> > which is 76868642e427 upstream. My suspicion is that the only conflict
> > between the two is the getopt string, and there is otherwise no direct
> > dependency between the two.
> > 
> > This patch therefore reverts the cited commit, with hand-resolving the
> > getopt string to include 'r' (as introduced by c6dc458227a3), but not
> > 'y' (introduced by 06954f715deb).
> > 
> > Reported-by: Yong Wang <yongwang@nvidia.com>
> > Signed-off-by: Petr Machata <petrm@nvidia.com>
> > ---
> > 
> > Note: the issue appears to exist in 6.6, 6.12 and 6.18 as well.
> >       Depending on your preference, I can prepare separate
> >       patches for those branches as well. Let me know.
> 
> No need, I did it now for those branches too, thanks!

Oops, nope, spoke too soon, 6.18.y still needs it, this one doesn't
apply there.  Can you send that revert?

thanks,

greg k-h
