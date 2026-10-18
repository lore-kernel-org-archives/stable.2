Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFD54A2A46;
	Sun, 18 Oct 2026 16:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792340876; cv=none; b=A7d76ad0j2VOVxOqc+uxvZV9O0SzbkGoCedtKtJiS83w0z/sPEzszMI5lj1qnFBkHrRR0UxaTYsJ4YMlM6YAn9UUUp0jnTGfaNvQo9ykyxw1ENoDkEnqNKmsOKF3Ca9NM5V+4lkQlbASXDK0RW47GkToPJdfZtdhN86i5L8SGOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792340876; c=relaxed/simple;
	bh=zFTCaKctHU/dgcTz4fJxnzuN9ChTCA4PFmsOdvp8W/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Up7wd6BYL9q8RsYb6AwQ7J7x7fvgDneA+JdoacAfuuOoyBUkiVUGykDICjVTogSiz+IeeJ7U25tvGmdxOo1IrlZlVjBqtrFKJLDplTJF3jGSYEv/AuzEfXz9w9DwKaTdhNHl5f/qT/7UAfULjptuJit1zCx6C6hOv5MbFE+iuTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAsYlT86; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAsYlT86"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 010F61F000C4;
	Sun, 18 Oct 2026 16:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792340875;
	bh=CJp7IGwRNv51s2AUzxgvpb1+5GYEYJb/XW2pP9VE+dY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hAsYlT86AAcKtKqIsma/Pck45sBR2SoBuYwWrmpq8rL4bUX728xlq+SN1aGh5eyoZ
	 H/4AfGtkOQezjEQyNLxyxtY5l+ZH9pRkimpONwfWLr04XDlHGIIzVKFzwhYcdP1hiW
	 mm9zr0gXYxwBatJVP4XROH6KTQk/2Vdkc78R4dY7mkfKqDBgydg5uGokLT7i4DM8jg
	 /KLMV+HcEmCam6BIbfIyG36dV+lZYXmgp0/l11whWjQMXyzU8l1fyFoc0tYJJ/vXdc
	 mzPpDDS4ECF6m2kev+KaQX31ZB7Rlps8svFwDPPd4M223FBqA7qIAKFRocE9pOWcFm
	 vwUsUar3Ge4zw==
Date: Sun, 18 Oct 2026 18:27:51 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jan Kara <jack@suse.cz>, stable@vger.kernel.org
Subject: Re: [PATCH 5/8] fs: don't silently unmount busy mounts
Message-ID: <20261018-haarausfall-erdarbeiten-aufwuchs-5f1467040468@brauner>
References: <20260923-work-mount-fixes-v1-0-f424cf8d3242@kernel.org>
 <20260923-work-mount-fixes-v1-5-f424cf8d3242@kernel.org>
 <20261018013815.GA3535232@ZenIV>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261018013815.GA3535232@ZenIV>

On Sun, Oct 18, 2026 at 02:38:15AM +0100, Al Viro wrote:
> [My apologies for being MIA since July - had been sick; should be
> back to normal now]

Glad you're better!

> >   mount --make-shared /mnt
> nit: mkdir /mnt/a
> >   mount -t tmpfs none /mnt/a

Yep, lost that line.

> > Teach propagate_mount_busy() the same checks that propagate_umount()
> > does. It now checks for a single victim mount without children
> > for which it can assume that MNT_LOCKED is cleared on every copy like
> > propagate_umount() does.
> 
> Huh?  propagate_umount() does *not* assume anything of that sort - look for
> those IS_MNT_LOCKED() in there.

Badly worded, sorry. What I meant is that in the do_umount() path
propagate_mount_unlock() has cleared MNT_LOCKED on every candidate by
the time propagate_umount() looks at them. It's the same set. The mount
at the mountpoint below each receiver. So for a single childless victim
none of the IS_MNT_LOCKED() checks can trigger and
propagate_mount_busy() doesn't need to mirror them.

> Explanation is somewhat misleading here, IMO...  Sure, all candidate
> victims have identical mountpoints, so they must have distinct parents,
> etc., but "copy" is not a good word here - all of them *are* copies of
> copies of the same mount, but the history of copying might have nothing
> to do with your chains.

Fair. "copy" was meant as "receives propagation from the victim's
parent", the clone history doesn't matter.

> ; umount /mnt/a			# takes out M1, M3 and M4
> ; /bin/pwd
> pwd: couldn't find directory entry in '..' with matching i-node
> 
> What happens is that propagate_mount_busy() sees that M3 has something
> mounted _not_ on its root and decides that propagate_umount() will not
> take it out.  M1 and M4 are not busy, so we proceed to propagate_umount(),
> which notices what propagate_mount_busy() hadn't - the thing mounted on
> M3/a is something we are taking out, so M3 is not pinned by remaining
> mounts...

That one is covered. M3 is the first candidate in the chain below M2
and M4 is its next candidate, so chain_busy() does the refcount check
on M3 and umount(2) fails with EBUSY. I ran your sequence on current
mainline: EBUSY, cwd intact. On v7.1 it takes M3 out as you describe.

> I'm not fond of the patch itself, TBH - the amount of work done under
> mount_lock would better be linear by the number of mounts involved and
> your variant is at least quadratic.  That's not hard to fix, but that'll
> obviously have to wait - Saturday after -rc7 is not a good time for
> that.

Agreed, it isn't pretty. receives_from() walks the master chain for
every candidate and chain_busy() walks every chain twice. But I very
much didn't want to touch propagate_umount() in something that goes to
stable.

For 7.4 the obvious way is to run gather_candidates() and the trim
passes without committing anything and refcount check whatever ends up
in to_umount. If you have something send it my way, otherwise I'll do it
for 7.4.
