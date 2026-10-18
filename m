Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893A5175A95;
	Sun, 18 Oct 2026 01:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792287501; cv=none; b=RYbF5ywxA64XNFYYyrPJWOr1yC0X9XHJruQ++miT8L6RmB5IdQ1N1ByRA37a8ni7QVEphPL+0gZhuZLWn//CbbkB7JJhG6LIWyeyKnK2DrI6pCP2OWXzKuBXuKKf6qfw7jWDBdKME0hPnUbLDMpfOIFNhvfBXUsEpBG7QtEHJxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792287501; c=relaxed/simple;
	bh=UYF2FhLWFm9K4byAoLLAILLJp4ThIymJ2W0QJosTd0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9mmgjbX502rPzNWZg9Ovdn+u2DhoJoEHT0TEi/LAfy/+RkDAhkNWRv8LAUdblAe0RGAvLVb0H+8eSemLwB9DflbrXvW8tqD9XR0HNpNv7GvKouBOCDtIFmPhLrYO7fW8fh1xPXXFIIX48cSr6Jww0Wz2nNTPLzOV74zAMTW7MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=k/gMh2WP; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="k/gMh2WP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5mdBr0ds+u26HvP98HulAZzEoHd4VlVXGqeDXzZIiUs=; b=k/gMh2WP8bX519Hj+1hImLQLPR
	Oah6i4VcmT+3AayMfZ0CK16HI9QqZk8J9irVqRBAPhZP5s+7EKUaEZVqocur8aLjvWMK7sZDVT/ew
	YHBY1uVHq0omINj8mU4Uyd+9RVAz0J/HFtz5vB2aPe+asl+SEWOOOgTzuTiAPbItLQqQnfrS/kjBo
	wHwHBZ7PHNYc1Hqd67IxrCwD5ATlGa32wMbEe0stMsbCeyJtfvhPIb+GgUoNNIpoKSs6TBUxrQlLL
	Q7V49o2N5wh/zBAf2Co/3LSnpUe6XIiqOGr+fLvS6XlrqRONFcweP/A+scHxBPV2tVX+EzS0nsGLW
	4/B+OEvQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xIFqp-00000001oDw-1pTC;
	Sun, 18 Oct 2026 01:38:15 +0000
Date: Sun, 18 Oct 2026 02:38:15 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jan Kara <jack@suse.cz>, stable@vger.kernel.org
Subject: Re: [PATCH 5/8] fs: don't silently unmount busy mounts
Message-ID: <20261018013815.GA3535232@ZenIV>
References: <20260923-work-mount-fixes-v1-0-f424cf8d3242@kernel.org>
 <20260923-work-mount-fixes-v1-5-f424cf8d3242@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923-work-mount-fixes-v1-5-f424cf8d3242@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

[My apologies for being MIA since July - had been sick; should be
back to normal now]

On Wed, Sep 23, 2026 at 02:27:57PM +0200, Christian Brauner wrote:
> The propagate_mount_busy() helper exists to decide whether a synchronous
> can suceed. It does that by looking at the copies of the victims in the
> mounts its parent propagates to. One of those functions from propagation
> hell.
> 
> It skips a copy that has child mounts except for the case of a single
> child mount covering the copy's root. That algorithm used to be exact.
> It isn't anymore.
> 
> Originally only childless copies were unmounted during propagation.
> And 1064f874abc0 ("mnt: Tuck mounts under others instead of creating
> shadow/side mounts.") ended up adding covered mounts to both sides in
> one go.
> 
> Along came 99b19d16471e ("mnt: In propgate_umount handle visiting mounts
> in any order") and that started to unmount more than before:
> 
> [1]: A copy of a mount is unmounted when each of its children is either
>      its overmount or a copy of the victim itself. In the former case
>      the overmount gets reparented. In the latter case the copy of the
>      victim will end up being unmounted.
> 
> So propagate_umount() ended up being rewritten without adjusting
> propagate_mount_busy(). And currently propagate_mount_busy() doesn't
> look at copies of the victim that have two or more children nor a single
> child that is not the overmount.
> 
> So any such copy in [1] is not checked for
> references. The result is that a synchronous unmount succeeds, pulling
> out a mount that is still in use.
> 
> A container can run into this with its own mounts. The host shares a
> tree with the container and the host has a mount in that tree:
> 
>   mount -t tmpfs none /mnt
>   mount --make-shared /mnt
nit: mkdir /mnt/a
>   mount -t tmpfs none /mnt/a
> 
> The container's /mnt is a slave copy of the host mount. The container
> now takes a detached copy of the tree and mounts that copy beneath its
> propagated copy of /mnt/a and keeps the file descriptor to the tree
> open:
> 
>   unshare -m --propagation unchanged
>   mount --make-rslave /
>   fd = open_tree(AT_FDCWD, "/mnt", OPEN_TREE_CLONE | AT_RECURSIVE)
>   move_mount(fd, "", AT_FDCWD, "/mnt/a", MOVE_MOUNT_BENEATH)
> 
>   grep /mnt /proc/self/mountinfo
>   775 355 ... /mnt ...     master:646
>   777 775 ... /mnt/a ...   master:646
>   776 777 ... /mnt/a ...   master:647
>   778 777 ... /mnt/a/a ... master:647
> 
> The now attached tree (777) is now mounted beneath the container's copy
> of /mnt/a. That's also where the host mount sits (as seen from the host
> mount namespace). So the propagated copy (776) of the host's mount is on
> top of its root and the copy of that (778) is inside it. Now the host
> runs:
> 
>   umount /mnt/a
> 
> and it succeeds. The moved tree tree and the copy inside of it are gone
> from the container. Now only the propagated copy is left and it got
> reparented to where it was before:
> 
>   grep /mnt /proc/self/mountinfo
>   775 355 ... /mnt ... master:646
>   776 775 ... /mnt/a ...
> 
> But the file descriptor still refers to the moved tree. So a synchronous
> umount detached a mount that is still in use.
> 
> Teach propagate_mount_busy() the same checks that propagate_umount()
> does. It now checks for a single victim mount without children
> for which it can assume that MNT_LOCKED is cleared on every copy like
> propagate_umount() does.

Huh?  propagate_umount() does *not* assume anything of that sort - look for
those IS_MNT_LOCKED() in there.

> The copies form chains. IOW, when a copy itself
> receives propagation from the victim's parent then the mount at the same
> mountpoint inside that copy is a copy as well. Whether a mount receives
> propagation from the victim's can simply be checked by walking its
> masters. Walk each chain once from its top so we are sure that nested
> copies stay linear. Check every reference once of every copy that gets
> unmounted.

Explanation is somewhat misleading here, IMO...  Sure, all candidate
victims have identical mountpoints, so they must have distinct parents,
etc., but "copy" is not a good word here - all of them *are* copies of
copies of the same mount, but the history of copying might have nothing
to do with your chains.

	FWIW, there are two related bugs here; one is the horror with
MOVE_MOUNT_BENEATH (and the more I'm thinking of interplay between that
and propagation, the less I like the entire situation).  Another does
not involve MOVE_MOUNT_BENEATH at all - 

; mount --type tmpfs none /mnt    # M0
; mount --make-private /mnt
; mount --make-shared /mnt
; mkdir /mnt/a
; mkdir /mnt/b
; mount --bind /mnt /mnt/a        # M1 = M0/a
; mount --make-shared /mnt/a
; mount --bind /mnt/a /mnt/b      # M2 = M0/b
; mount --make-slave /mnt/a
; mount --make-slave /mnt/b
; umount /mnt/a/b
; mount --bind /mnt/b /mnt/b/a    # M3 = M2/a
; mount --bind /mnt/b /mnt/b/a/a  # M4 = M3/a
; cd /mnt/b/a			# M3 is busy, isn't it?
; /bin/pwd
/mnt/b/a
; umount /mnt/a			# takes out M1, M3 and M4
; /bin/pwd
pwd: couldn't find directory entry in '..' with matching i-node

What happens is that propagate_mount_busy() sees that M3 has something
mounted _not_ on its root and decides that propagate_umount() will not
take it out.  M1 and M4 are not busy, so we proceed to propagate_umount(),
which notices what propagate_mount_busy() hadn't - the thing mounted on
M3/a is something we are taking out, so M3 is not pinned by remaining
mounts...

I'm not fond of the patch itself, TBH - the amount of work done under
mount_lock would better be linear by the number of mounts involved and
your variant is at least quadratic.  That's not hard to fix, but that'll
obviously have to wait - Saturday after -rc7 is not a good time for
that.
