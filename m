Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9547530BF67;
	Tue, 16 Jun 2026 02:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781577474; cv=none; b=RpM3WWyYmAcXC9SbN1ZcUf7xm+5Yq8tdOQtSCvuPmzt1nTdVh2mIiH/MHTyImVjYFJu4CLGzXfB0/ygTEp7nWPyhy6ObYY1/u5c0MuoBXVsnSsFONht52V+d1SHG53Kd63QBzhPMUgdRw1ShCPEojLk4YrMDpVbpILEWv8kPv1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781577474; c=relaxed/simple;
	bh=4BnT4gm5t+ZU6Ek6UEMjioOb2BIYJuqQonldwNGGFsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ganFVtQxikccIhmuRb9ySVlQRtJOUeBs03nOHcaEEj4ld6L+tvylDYalXLaGZfkrNUq8cqAaXLDMwd9+Lm6GiXVBYzemtm32uy/IlqRxs3d6sGukP0LgNIEp38OVBDRrJGBCZ9+klcdUmMHA9yHJbYn9W+vgYr+XLZNZPopmBm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1880ZYxu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1880ZYxu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4145A1F000E9;
	Tue, 16 Jun 2026 02:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781577472;
	bh=ViaFrLbrc82d7O4k7T9xRDpbbrH3Q0H1tROvLSFc/So=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=1880ZYxuqGw1us+IfQ96KMIVEyDT2nhk/zn55s/zsdZ/dnHRYsL4JTzg4STI5IoRh
	 mM6o/rbRs7sF1f/hh6mjSJzQdlS72atgF/wsHj2thGV2sfTrDf/sHJ6mwedrLx3Roh
	 Sk/EYEEZJA70NEwfgLC1nl5LwwKvNpxsyTA5DN48=
Date: Tue, 16 Jun 2026 08:06:46 +0530
From: Greg KH <gregkh@linuxfoundation.org>
To: Bernard Pidoux <bernard.f6bvp@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, stable@vger.kernel.org,
	linux-hams@vger.kernel.org
Subject: Re: [stable request] ROSE memory-safety fixes for 7.0.y and earlier
 (merged out-of-tree in linux-netdev/mod-orphan)
Message-ID: <2026061625-starless-mascot-691a@gregkh>
References: <CAFAa3YBfk2UOjAktrLq3_9+563m6UZuKv9XdBjfp2aB1twV1HQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFAa3YBfk2UOjAktrLq3_9+563m6UZuKv9XdBjfp2aB1twV1HQ@mail.gmail.com>

On Mon, Jun 15, 2026 at 07:21:21PM +0200, Bernard Pidoux wrote:
> Hello Jakub, Greg, and stable maintainers,
> 
> (Resending in plain text; the previous copy was rejected by the lists
> because it carried an HTML part.)
> 
> I am Bernard Pidoux, F6BVP, an old-timer ham radio user of the Linux
> ROSE implementation. ROSE and AX.25 no longer have an official kernel
> maintainer; I am one of the people still running this code on real
> nodes and fixing it when it breaks.
> 
> Over the past weeks a series of fifteen memory-safety fixes for
> net/rose that I wrote was reviewed and merged by Jakub Kicinski into
> linux-netdev/mod-orphan. They fix real, reproducible kernel bugs that
> affect any node running AX.25 networking over the ROSE protocol:
> 
> - several use-after-free conditions in the ROSE teardown paths
> (neighbour timers fired after free, socket freed under an open fd,
> sockets reaped from the heartbeat while still owned by userspace);
> - a rose_neigh refcount underflow in rose_kill_by_device();
> - netdev reference double-holds in rose_make_new() and
> rose_rx_call_request();
> - dev_put()/neighbour reference leaks in the loopback timer path;
> - a notifier unregistered too early in rose_exit().
> 
> These are crash bugs (use-after-free writes, refcount underflow) that a
> remote peer or normal session teardown can trigger. They have been
> soak-tested on production ROSE nodes and confirmed to remove the
> crashes and the kmemleak reports.
> 
> The problem is the path to the stable trees. ROSE was removed from
> mainline in 7.1 and is now unmaintained, so these fixes were merged
> into the out-of-tree mod-orphan repository rather than into Linus'
> tree, and therefore have no mainline commit ID. The normal
> "cherry-pick from upstream SHA" stable procedure cannot apply.
> 
> However the affected code is still present and still buggy in every
> stable series that predates the removal: 7.0.y first of all (the last
> line that ships net/rose), and the older long-term branches that carry
> essentially the same ROSE code. Distributions tracking those kernels
> currently ship the crashes with no official way to receive the fix.
> 
> My request: would you accept these as stable-only patches applied to
> 7.0.y and to the earlier stable series that still contain net/rose, so
> that distributions pick them up? If a stable-only submission is the
> right vehicle, I will send the series rebased per target branch, each
> patch with a proper changelog and the bug it fixes; if you would rather
> route them another way, please tell me and I will prepare whatever form
> you need.

Great questions, I was waiting for something like this to eventually
happen :)

Ideally, we would just backport the "delete the code" changes, and then
distros can use your external module for their older systems, if they
care/want to, BUT that will increase the load on you to support older
kernel versions, which isn't very fair for you as in the end, you will
be getting bizarre requests from dead^Wenterprise distros asking you to
support 10+ year old kernels...

So let's try the other way, yes, I'll gladly take patches that you have
applied to your tree to fix issues in older kernels.  One request,
please use the same git id that you use in your repo as the "backported
from" git id that is in the stable message, so that we can track them
properly across different stable releases (the ecosystem has lots of
tools that rely on this.)

As for the format, whatever works for you is fine for us.  Ideally a
mbox full of patches, but we can take anything as long as we can
eventually turn it into a patch that we can apply.  How about trying one
set of backports first so we can see how well the process works to
smooth out the details?

Oh, and of course, thanks for stepping up and offering to do this work,
it's much appreciated.

greg k-h
