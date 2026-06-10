Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2414530C60C;
	Wed, 10 Jun 2026 07:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781077716; cv=none; b=uLbnGpixj3H5KdaZicbbKjIDPhnj+rBIi9lUVovbSyNJNi9+CAzL4iTgHMu+PX4mV1C5SVWsfEU98jz73DQVdPo1/Vttw7Qz3Ev7u8ySdObFETcGrM7ZchTDRDW4xMAu+1ddAr1h094nMahuNozoO9UHboh9phcHfO4w3WDfjAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781077716; c=relaxed/simple;
	bh=jFC3MsMaejvQIh7rOSylVCRjJ51UT7dHc2sgdGrL/k0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZtD/SGK3E2m+DfCqiAq78D2BtAAGL2nXa8YzvVeMAWQ05f2nl3exn311P9HQ6LmUby7jwT1tGQo6saq7M4r2vXpr2xxFLlf7q9+t65t7pdBdlj45KEqRhBl03+ATlTZE1xwwfOtuOP9cV1WhGj2cz10WiuZuEKlCtll82GjSR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwwn//mP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwwn//mP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26DC31F00893;
	Wed, 10 Jun 2026 07:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781077714;
	bh=PmYO7qAWoOzsSKErncOiMM5bfzhOjU8/eW6c/WV/lbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cwwn//mPaWQ/IJBH/DqQP67LbZ/NkcTke9bq7+77djBWgOkqRXcIF4znUAzFC8qSJ
	 YH+JfxI3PSVFM/ck0xwemzRXyCqzAbkPCrD/1HH2KoP93/IWbh6D0fhTq+n2YKvwze
	 lzQCdK7FOuYvpZ/pdU+7xXyd8rufY+gSNPEtORm6v8jUmg7+e2R4BvXG0BZd0Y4nlw
	 4Q2pzOVeMMGYYJnq0XkZABqgBd9Otmh99U3SFXFOEJ6wZ8x5f/P3MtL81DL/Nfl0SU
	 DWQ36URJsgCwNKuwRPys03dlwkHSZ3EXhEUB12pL56q9yihB0nHjBHXDHXKViL0/Sj
	 GMclDSF7pg0Jg==
Date: Wed, 10 Jun 2026 09:48:29 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Arjan van de Ven <arjan@linux.intel.com>, Jake Edge <jake@lwn.net>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, Kees Cook <keescook@chromium.org>, 
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 0/2] proc: protect ptrace_may_access() with
 exec_update_lock
Message-ID: <20260610-virusinfektion-garage-melden-e4160292d40b@brauner>
References: <20260518-procfs-lockfix-part1-v1-0-5c3d20e0ac33@google.com>
 <87ik8b2rh8.fsf@email.froward.int.ebiederm.org>
 <CAG48ez2pmuoTCZh_AVKDDLeQEYmm=gLMgThnqFhRMFfZvABpdw@mail.gmail.com>
 <87wlwny905.fsf@email.froward.int.ebiederm.org>
 <CAG48ez3Wp757fQh1gyTxf-k3p__utUOWM8xdJeUig4gPpSmTEA@mail.gmail.com>
 <87mrx9f8q2.fsf@email.froward.int.ebiederm.org>
 <CAG48ez1ksU=6KBSW1fREo4itu7vdP5KEt3s4hCAcbVkdthLXsw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez1ksU=6KBSW1fREo4itu7vdP5KEt3s4hCAcbVkdthLXsw@mail.gmail.com>

On Fri, Jun 05, 2026 at 04:34:47PM +0200, Jann Horn wrote:
> On Fri, Jun 5, 2026 at 2:54 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> > > On Thu, May 28, 2026 at 3:11 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> > >> Jann Horn <jannh@google.com> writes:
> > >> The issue you point out with memfd's definitely needs to be fixed.
> > >> It should be separated out from the rest of the races simply because
> > >> it is a completely different kind of issue.
> > >>
> > >> I wonder if anyone even anticipated you could open another file handle
> > >> to memfd's through proc.  If so leaving everything to path based
> > >> permissions assumed a feature of proc that doesn't exist.
> > >
> > > I don't think memfds are particularly special here, they are just a
> > > nice, clear example of a case where an inode is protected based on
> > > which processes can path-walk to it.
> > >
> > > As another example: Making a directory mode 0700 is also supposed to
> > > prevent other users from accessing things inside it.
> >
> > The simple counter example is that linux has an open by inode
> > facility.   That is exposed to nfs and as a syscall.
> >
> > Well strictly speaking the syscalls  name_to_handle_at and
> > open_by_handle_at.
> >
> > Most filesystems including shmemfs support those operations.
> > See shmem_export_ops.
> >
> > Which is a long way of saying that if someone can guess
> > the inode and generation number of a memfd inode it can
> > be opened with open_by_handle_at.  The usual permission checks
> > are performed but unless I am misreading something the only
> > permission checks that are relevant are the permissions on
> > the inode.
> 
> No. open_by_handle_at() is not supposed to let you bypass
> non-executable directories.
> 
> Filesystems without a special export_operations::permission handler go through:
> 
> do_handle_open -> handle_to_path -> may_decode_fh
> 
> which requires that the caller has global CAP_DAC_READ_SEARCH, or is
> capable over the superblock, or is capable over the containing mount.
> 
> > >> My gut says the best fix for the entire memfd issue is to simply change
> > >> memfd's and probably everything that calls shmem_file_setup to not have
> > >> an open method.  That eliminates any chance anyone will do anything
> > >> clever with proc.  But I can't see why it makes any sense to be able to
> > >> open another file handle into memfd's, or anything else that calls
> > >> shmem_file_setup for that matter.
> > >>
> > >> We can first try to remove the open method of memfd's set by
> > >> shmem_file_setup, and if that doesn't work we can look at fixing proc to
> > >> provide the guarantees that were assumed (as a security fix).
> > >>
> > >>
> > >> As a quality of implementation issue I can see fixing the small race
> > >> where when looking up a file descriptor through proc, exec does not
> > >> appear to be an atomic operation.  I keep wondering if that is something
> > >> that should be done in get_link or d_revalidate.
> > >
> > > I don't see how d_revalidate would help, that still wouldn't be
> > > atomic.
> >
> > You have to pick the correct one, but in general it is the job of the
> > revalidate methods to find something that is stale and see if it works
> > in the current context.  AKA make it look like something that wasn't
> > done atomically behaves semantically as atomically.
> 
> d_revalidate refreshes dentries, but it doesn't make anything about
> the underlying inode atomic; and my understanding is that procfs wants
> to avoid tying inodes to things like task_struct or mm_struct to avoid
> keeping those objects alive unnecessarily.
> 
> I think d_revalidate would make sense if, for example, we wanted the
> /proc/$pid/maps inode to hold a reference to the corresponding
> mm_struct.
> 
> > >> I suspect the answer for proc_pid_get_link is to either cache something
> > >> like a seqcount, or simply to repeat the permission and existence checks
> > >> just before calling nd_jump_link.
> > >
> > > That seems like it results in complicated semantics, while a mutex
> > > would provide clear semantics. Which is already what we use in places
> > > like __pidfd_fget() and /proc/<pid>/syscall.
> >
> > An important point to remember when dealing with proc is that it is for
> > implementation purposes a distributed filesystem.  Thinking of it like
> > a syscall is wrong.
> >
> > There are lots of places that for correctness reasons (and to not burden
> > the rest of the kernel) proc does something and then validates what
> > it has done is correct.  AKA just like a distributed filesystem.
> >
> > As for semantics I am not proposing anything that will have complicated
> > semantics to userspace.  It may have a slightly more complicated
> > implementation in proc, but that can save complications in the
> > rest of the kernel.
> >
> > Anything that needs to block exec to block to operate correctly is a
> > real can of worms review wise, and something we have repeated gotten
> > wrong in the past.  Something where exec can just do it's thing and
> > proc can still give a point in time correct answer makes the analysis
> > that things won't break much simpler.
> 
> Hmm... the reason we got it wrong in the past is that we were using
> cred_guard_mutex, which was held across stuff that can (indirectly)
> wait for ptrace, right? Whereas nowadays we basically only have to
> ensure that we don't block on userspace actions while holding the
> exec_update_lock? Which still requires some care but should be less
> problematic.
> 
> > >> >> Question 2.
> > >> >>
> > >> >> How does this race compare to racing with setresuid?
> > >> >> Do we need to fix the setresuid case as well?
> > >> >
> > >> > Which setresuid case? setresuid clears the dumpable flag and has a
> > >> > memory barrier that is supposed to make that properly ordered against
> > >> > ptrace_may_access(); so setresuid() should normally not cause a task
> > >> > to become traceable, though that could maybe happen in weird
> > >> > scenarios.
> > >>
> > >> The cases where the dumpable flag get set are all part of exec.
> > >>
> > >> I was thinking of cases where we have a daemon that is started by
> > >> root and then it changes it's uid to do something.
> > >
> > > (Normally such a daemon would only change its EUID, which is mainly
> > > considered when the daemon acts as a subject, unless it intends to
> > > permanently drop privileges.)
> > >
> > >> Looking at ptrace_may_access the uid based checks won't allow
> > >> accessing of such a task unless it changes all of it's uids.
> > >>
> > >> At which point arguably it is on the process that calls setuid to make
> > >> certain ptracing it won't be a problem.  I am not certain that ever
> > >> actually works in practice but that does seem to be what the current
> > >> code is saying.
> > >
> > > When a daemon changes its EUID for some reason, commit_creds() will
> > > change that daemon's dumpability to suid_dumpable, which will prevent
> > > ptracing it even if the UIDs match.
> > >
> > > The ptrace.2 manpage guarantees that a process which is not
> > > SUID_DUMP_USER can't be accessed without CAP_SYS_PTRACE.
> > >
> > >> Now I am wondering if dumpable should get set if setresuid changes
> > >> a uid like I described above.
> > >
> > > What do you mean by "get set"?
> >
> > I was and still am wondering if dumpable should be set if setresuid
> > completely drops all of it's uids.  AKA the case where dumpable is not
> > set today.
> 
> You mean the case where the EUID is different from RUID and/or SUID,
> and userspace calls setresuid(current_euid, current_euid,
> current_euid)?
> 
> > Unless someone wants to do a bunch of work survey such code
> > we should probably wait until a motivating example presents itself.
> >
> >
> > >> > I think another case we should probably care about is what happens if
> > >> > a process which is only protected against ptrace by being non-dumpable
> > >> > goes through execve() - it shouldn't be possible to access resources
> > >> > associated with the pre-execve state while checking against the
> > >> > post-execve dumpability. It might be important for this that the
> > >> > do_close_on_exec() logic currently happens after committing the
> > >> > dumpable state in exec_mmap()...
> > >> >
> > >> >> Question 3.
> > >> >> Do we care about the case when a privileged process calls a setuid
> > >> >> process and drops privileges?
> > >> >
> > >> > I don't understand the question. Hmm - do you mean a case where a
> > >> > process with ruid=1000, euid=0, suid=1000 does execve() on a setuid
> > >> > 1000 binary? I think we probably don't specifically care about that...
> > >> >
> > >>
> > >> The general case would be a daemon running as root forks and exec's a
> > >> binary running as some unprivileged user fred.
> > >>
> > >> Mostly I bring it up is that it is easy to forget suid exec can drop
> > >> privileges as well as raise them.
> > >
> > > I do not understand the scenario you're describing. Can you give a
> > > specific example you're thinking of - what the ruid/euid/suid would be
> > > before execve(), and which mode the binary would be?
> >
> >
> > A process P1 with uid=euid=ruid=fsuid=0.
> >
> > A user fred with uid=1000.
> >
> > A binary B with uid=1000 (aka fred) gid=1000 (aka fred) that -r-sr-xr-x.
> > AKA everyone can read and execute the binary, and the setuid bit is set.
> >
> > Then P1 execs B.
> 
> I think I see your point - in this case, if P1 calls
> setresuid(current_euid, current_euid, current_euid), fred would
> afterwards be allowed to ptrace P1.
> 
> That feels to me like it is a bit weird, but probably not very
> problematic because fred owns the file; P1 is already running code
> owned by fred. Though fred can't necessarily actually change the file
> contents, if the file is immutable or the mount is readonly or such.
> 
> I... think it is also rare for setuid binaries to call
> setresuid(current_euid, current_euid, current_euid), since normally it
> is desired that they keep the original RUID for stuff like
> signal-sending permissions? But I might be wrong about that.

Yes, I found very few binaries that do actually do a full setresuid().

> 
> > p.s.  My personal opinion is changing permissions upon exec is a dumb
> > idea.  It might be worth doing the work to drop that support and to
> > update userspace to just connect to more privileged daemons when more
> > permissions are needed.  AKA ssh instead of su.
> 
> I agree that it would be nicer to get rid of that... I remember amluto
> saying the same thing.
> 
> Lennart Poettering thinks that, too, and has added the sudo
> replacement "run0" in systemd, which works by talking to systemd and
> authenticating via polkit:
> https://mastodon.social/@pid_eins/112353324518585654

We have been working on a sudo replacement that requests permission from
a more privileged process via ipc for a long time. We've implemented it
and it speaks varlink and run0 can be used as a drop-in replacement for
sudo. We keep adding the bits and pieces to function as a sudo
replacement in most cases:

https://github.com/systemd/systemd/pull/42465

setuid will die (outside of unprivileged containers) and we're getting
very close to making that happen.
