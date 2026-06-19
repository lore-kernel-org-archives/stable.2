Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6F340D594
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 05:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781847611; cv=none; b=o0S4kuUqEVWewUjPBGBZCjEtzbbTtEDp3zZcbLSHzibi9GGcyFryTKZJg+N9B1Wh09PhEQczxX8K1j5+8zT+qvaqAGPNjjxRipyNhzRkm899QhCFW6LZ4s22UAHQIIksrGKAe4oIxUDRGP0FJwW7FAhF8uTXYUzFLFkYkqrJ26Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781847611; c=relaxed/simple;
	bh=T7rNpxPHz64RIbJJQx8Y3MNjCxE6fUYmNlgby3Rl4c8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WD598RdBg12bLd5Xon1AxSbFIrkGhZIr/NF5X2nNMumi/mvNHN8tnMCAnoiYSUBfvjemMe5vRsm2yjjhd0gr+I0XObd4ff6D3xUCx8yDWVXJNYtCq9Se1XALLQDAk05a1Ya7PkLXLSpjDCmD7d+fhFEUk+0Glo9hu3nPwAhU884=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W65T20s8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W65T20s8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A71C1F000E9;
	Fri, 19 Jun 2026 05:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781847610;
	bh=kDP4ChyqcfH1FgqynMDN3E55iirmCZRh6YE5e4sRWyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=W65T20s8lSoO90yu2czF+SA2XtgWx9f9KaDYurv22/d9sKsYhbiLwHNONzn7XF5mE
	 j2zNjZKTlZX1UyJhB2em6wgzvSKhhTALbeytuUqV99S9Vgdwcqvss+bBokbQB7npU1
	 h1FFQVzfT2W1A9omfHtM4SCvKumwo/rdVdpuSfTc=
Date: Fri, 19 Jun 2026 07:39:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mathias Stearn <mathias@mongodb.com>
Cc: Mark Rutland <mark.rutland@arm.com>, stable@vger.kernel.org,
	catalin.marinas@arm.com, peterz@infradead.org
Subject: Re: [PATCH 7.0] arm64/entry: Fix arm64-specific rseq brokenness
Message-ID: <2026061930-tightrope-bronze-4198@gregkh>
References: <20260618151426.308099-1-mark.rutland@arm.com>
 <CAHnCjA3HBwt-rtgmyfanu9wA0eNc3oQqHemPOwUVfp9kotuEwg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHnCjA3HBwt-rtgmyfanu9wA0eNc3oQqHemPOwUVfp9kotuEwg@mail.gmail.com>

On Thu, Jun 18, 2026 at 10:50:00PM +0200, Mathias Stearn wrote:
> On Thu, Jun 18, 2026 at 5:14 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > Mathias Stearn reports that since v6.19, there are two big issues
> > affecting rseq:
> > [...]
> > The other rseq fixes made it into v7.1 and were all backported to v7.0.y
> > as of v7.0.10. We forgot to CC stable, so this patch was missed.
> >
> > This isn't needed for earlier stable trees.
> 
> What about 6.19 itself, or is that not a stable tree? AFAIK it isn't a
> priority for us (MongoDB) like 7.0 is, but I felt like mentioning it
> for completeness, since rseq is quite broken on arm64 with 6.19 today.

If you look at the front page of kernel.org, you will note that 6.19 has
gone end-of-life a long time ago, sorry.  We aren't supporting that
anymore at all.

thanks,

greg k-h
