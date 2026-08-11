Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDB8424653;
	Tue, 11 Aug 2026 08:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786438485; cv=none; b=aocO/SzmtDxwKUy0XkaNeMgUfPthopxz7HR3Ciot1lnn+89IxTQZJh0/8vByK0n6uqKTkiM3Z/zY/uoKJEZPWJfusuju5eQ9Qrsw8M6q7q+Y6YYbcYrorv5SAd4Aoo+qmS4H5VB8NAUwWRg53D6D6Wk0lFKGkzwxStzouphrk9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786438485; c=relaxed/simple;
	bh=7m2UyZp4k1WpP9Bc92s0OgkcrKkV7KZjkLSbvbZjPZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bd6a3G/NTmBk5EniWJgJvXLBYGLYz3CDSYku93eZbw+F9Us/hOz+TAfNuDxMpXdXpvXyJkVcLOJauEXbCLb/dkKDC3kVUnJVJTczkg0xO3yKFln5eMpw+jZi0P4hxPHqM4fE5+xsxHoTUCWJ4DMAF4TYmuXgEBJVqOpfNq5VXO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BewEr8xV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BewEr8xV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 878721F000E9;
	Tue, 11 Aug 2026 08:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786438483;
	bh=/Wt5VIZo+ZwB/zj291Ig8wwAgCqWaMk8U+Bv6zERJxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BewEr8xVIDd73BA15/Z7e6vlZdpTpiaMk8CA1nIys+BYpL0PdTmBvdCIpHQMq5L1s
	 Ndvub9D69KdMtMby/is4On7hi9WWXUunXVhH1XRgjcwlWhwWeWqGRVeuz13TI7Z8uL
	 cpMXcZ9qROFVA1KQ/tIuBOzQKZYdyZB3Z77j+6M7G219j9UaoagQBkk56PNZO32Trf
	 dNMT9lpAi6rjWBhzVMbi2vKidGzsuN98wQEUIk5/Bmzmp3hIn7gBKZeYSA290zwNok
	 DoD2Afsiz5SjeyaFl8NCHtFP2+SqmTabK742KpiBfzxhMdA7qA5Jk0xYmJ4cfOT2S7
	 D3DMx51pqWFcA==
Date: Tue, 11 Aug 2026 10:54:39 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: me@black-desk.cn, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] pidfd: hold exec_update_lock around namespace ioctl
Message-ID: <20260811-dachziegel-nordost-akkreditieren-3aecf70032da@brauner>
References: <20260731-pidfd-exec-update-lock-v1-1-b388f2f3a8b0@black-desk.cn>
 <CAG48ez2YssN-F9DHHskmiWORTnaBPUUyixqufD-L5VkW96Uv4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez2YssN-F9DHHskmiWORTnaBPUUyixqufD-L5VkW96Uv4Q@mail.gmail.com>

On Mon, Aug 03, 2026 at 03:44:21PM +0200, Jann Horn wrote:
> On Fri, Jul 31, 2026 at 4:50 PM Chen Linxuan via B4 Relay
> <devnull+me.black-desk.cn@kernel.org> wrote:
> > The PIDFD_GET_*_NAMESPACE ioctls in pidfd_ioctl() perform a filesystem
> > credentials ptrace access check before handing out a namespace file
> > descriptor.  The accompanying comment states that the code "mirrors nsfs
> > behavior", but, unlike the corresponding procfs paths, it does so without
> > holding the target task's exec_update_lock.
> >
> > proc_ns_get_link() and proc_ns_readlink() both take exec_update_lock for
> > reading around the ptrace check and the namespace lookup, so that the
> > credentials used for the access decision match those of the task when its
> > namespace is read.  Without it, a caller can pass the check against the
> > target's old credentials and then read the namespace after the target has
> > execve()'d a setuid binary and committed new credentials -- accessing
> > namespace information it should have been denied.
> >
> > Hold exec_update_lock for reading around the ptrace check and the
> > namespace lookup so that pidfd truly mirrors nsfs behavior, as the comment
> > already claims.  open_namespace() itself runs outside the lock: once a
> > namespace reference is obtained it carries its own refcount and is opened
> > with the caller's own credentials, so a concurrent execve() on the target
> > can no longer affect the outcome.
> 
> I think this makes sense.
> 
> Given that the rest of this function is written with scope-based
> cleanup (https://docs.kernel.org/core-api/cleanup.html), I wonder if
> this patch would look cleaner if it also used scope-based cleanup...
> that documentation also says:
> 
> "Lastly, given that the benefit of cleanup helpers is removal of
> “goto”, and that the “goto” statement can jump between scopes, the
> expectation is that usage of “goto” and cleanup helpers is never mixed
> in the same function."
> 
> But we probably shouldn't be holding the exec_update_lock across the
> open_namespace() call... so I guess this will require either
> refactoring this function into two, or indenting most of the function
> body, or some explicit "drop this guard" operation.
> 
> @Christian, do you have an opinion on this?

No strong opinion tbh. If I don't like the next version I can also just
massage it when applying.
