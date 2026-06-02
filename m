Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8308632B;
	Tue,  2 Jun 2026 14:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780412101; cv=none; b=r/n4yvb7APgFHhPZ0oruIeMJt6DMBSptVRR2LHgyeY1t4L7g4y+e7lTQbB9maoTn17j0WVbGr7oDMZ+Fl3hTwLURcD3q8CfIkTL+SjimPNUT1qxN1a6T5/xQm7o4DOJBzkVJPavN8ksD4HIZtI5oo5TQKG0ZFd6K7zG84+K8s+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780412101; c=relaxed/simple;
	bh=S1Aqo6Uij0cbHupXQq1E9Qhx3SnZwi9VeVA0Oh7F2h8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EiOjw9CHezDpSZOTDHEd+F8jghDogq3ezTqbfkedxG2nCMyqL/ASEKgp+NNkOgrp4hiYTPDMlMkENz/WfvTe8kZo6nqbIlHHZiu0d1k9V19EtsfdGwO4t6/dRuaPCMO+GumRdMV//MVRkacMXKEyadjHJl/oTyXkMLDTU3WCxIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ARSucd0o; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ARSucd0o"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=7PVJaWtVSSMph3tTsu2PYFRenhL66s4EMmDJXQC5W8o=; b=ARSucd0owgtskOTpU5gg5Dmr2W
	8PFy0VAh0enDGf8SAcE9gyfUjIAeh4TmsvSOmpsRZBwxua/wL8hw8a8MsTPs3ucmryznyUsaskzSR
	WX9GhybnSEfPT7vAhXQ+zJUW+8AzzRiAxZG0B2zK8X3bM8qhvTr6sAIJ1cngIQnx//7B2hFVOyInZ
	kAibLDBG1uIynSySNzgvwFEn2rWx9/RQXt26Z42C/n742YHPUdSkHkI/84jKfdi0Hry58BCJvNCQ5
	oTtHTUj18g4yRy5mOJHjEfSICZBbkNPhr6K6VPrQT2Ug9Z9Lyac1DxGvYVrYKARtKAq6jtj+Yf0mv
	UmJ3cScQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wUQW8-00000008UWz-0aH2;
	Tue, 02 Jun 2026 14:54:56 +0000
Date: Tue, 2 Jun 2026 15:54:56 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Arefev <arefev@swemel.ru>
Cc: Jan Kara <jack@suse.cz>, Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org, stable@vger.kernel.org
Subject: Re: [PATCH] make new mount API honour SB_NOUSER (was Re: [PATCH]
 block: Avoid mounting the bdev pseudo-filesystem in userspace)
Message-ID: <20260602145456.GT2636677@ZenIV>
References: <20260521072857.5078-1-arefev@swemel.ru>
 <20260602011907.GM2636677@ZenIV>
 <20260602013526.GO2636677@ZenIV>
 <20260602020444.GP2636677@ZenIV>
 <eevyuiiqt5b4n7kws2lc24jk2njdllanojl76t5cftx6he6hba@y46tiknbebj4>
 <b106ed26-e6ec-4254-b337-1d2e8e2adc58@swemel.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b106ed26-e6ec-4254-b337-1d2e8e2adc58@swemel.ru>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jun 02, 2026 at 04:23:21PM +0300, Arefev wrote:

> The sequence of system calls before the crash could be as follows:
> 
> fsopen("bdev", ...)
> fsconfig(fd_fs, FSCONFIG_CMD_CREATE, 0,0,0)
> fsmount(fd_fs, 0,0)
> move_mount(fd_mnt, "", AT_FDCWD, "./file1", 0x46ul)

	Huh?  "file1" being a regular file or was it actually
a directory?  AFAICS, the d_is_dir() mismatch would be rejected
by do_move_mount()...

> The system call executed at the time of the cras:
> 
> open("/dev/media0", ...);
> 
> Simplified stacktrace:
> 
> path_openat
> |-> link_path_walk
>    |-> walk_component
>       |-> __lookup_slow
>          |-> ld = inode->i_op->lookup(inode, dentry, flags);   <- Oops

How the hell does that thing bound on top of "./file1" lead to
resolution of "/dev/media0" walking anywhere near it?  Something's
missing here.

> Checking the fc->sb_flags flag before calling vfs_create_mount() is a great
> idea,
> if it helps prevent crashes in two more file systems, 'sockfs' and 'pipefs'.

Calling vfs_create_mount() is not a problem; refusing to attach
the result if SB_NOUSER has ended up in ->s_flags is the right
thing to do, but I still would like to understand how did this call
of walk_component() manage to evade
                if (unlikely(!d_can_lookup(nd->path.dentry))) {
			if (nd->flags & LOOKUP_RCU) {
				if (!try_to_unlazy(nd))
					return -ECHILD;
			}
			return -ENOTDIR;
		}
on the previous iteration through link_path_walk() or, if it had been
the first one, the corresponding checks at chroot()/chdir()/fchdir() time.

Note that there are very legitimate objects with NULL ->lookup() - every
regular file is like that, obviously, but there also exist ones that look
like directories in mode bits, but still have NULL ->lookup().  See
d_flags_for_inode() and look for DCACHE_AUTODIR_TYPE there.

So whatever scenario has played out, you've got a call of walk_component()
with nd->path.dentry that should have failed d_can_lookup().  That ought
to have been prevented and this prevention would better be much closer
than anything fsmount(2) does.

Don't get me wrong - userland mounting of bdev and friends should not be
allowed, but that's not the only thing that went wrong in the reproducer.
BTW, how easy to trigger it is?  Is that "you need to run for a few months
on a bunch of boxen" or "run this sequence and it'll crash that way"?
