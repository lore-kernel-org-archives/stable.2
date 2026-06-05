Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899613B582F
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 14:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780670128; cv=pass; b=FkXeDwVbttHi7cCQhrTj8xECZ3Yh/D0hK8xzLiFyyQ4bQL20mgzNp9CVynwPpxwnWUG6Ofddxoah7zG4MqbeAAYf4XN090E6cCSBJdzFcQijp19VT+L6C6462qzQTqM75tdaf3j8XimGbxJmtidMRCybHfIs1kz2oS5H+mcxuAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780670128; c=relaxed/simple;
	bh=rLYiSxh3A+P0zUydMPQeaHxe6IJau77uxIgbZw19QR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rne6thKxou0V10W8r2e2CX0qu14fgmE3AIPiFAaPPmPDiEo++wiasB0d9tfkDduN9cH9fxq9VXm0LJPciG9j9I8V7uVEYOKypJnQYJZBlYpqq20GEJzRMHuRRR0N27orQ+9YPVAz7mUegx0bM9QQP6xN5QNM0zD8nTDx4M83BF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PJGv3PG0; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PJGv3PG0"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-68d22476e88so12093a12.0
        for <stable@vger.kernel.org>; Fri, 05 Jun 2026 07:35:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780670125; cv=none;
        d=google.com; s=arc-20240605;
        b=GSHkVArnCLPfuYXnR6zoUCtICwcLp934kAQrk7sMlY32z94I5ZtM3FjQ6ztJUEmAJO
         u4qDjuksOvVKtzOI2dLOGKS1y0cynei+lHZyQ3lO5q+BsNK2ISqC/7ZSo4k61zm1xlpB
         FC6IUgpCY4/PsQmrw4NJIwTtYYlcRfATRGYgaMsf5VRFXRuygZa2R8rMtPFxS+4D7eZw
         lJ0w6d42UAT0k3gf+YAxuqjmqepe1yRdBXiS7luLtRmGCfm975uGBYX0dIhXJcrKWZ4k
         yO7/gHS9Afd+nR1pOmkB27XeF4oETMG8cpLc6iexOahhWJLpe4rWRLJ7BUKSkcXz+NOy
         4W5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cQ/3w04o+ggaB38jN74hv+yv2x9YXo9JGbMZzk+XFXg=;
        fh=xXfXJibF4Zz+yp3PtuwWdfpE7AXd7XIYeY2z51zcFIc=;
        b=BljXrpqWEdpNPD1kInYMt7Dibm03NBfL+HlX1RJhbYcs4KW1uvjeqrlwlMynrlC+HT
         hh3RrBtN2Sw3CovS2vaoG0XwDESsDjGmEZ7gKZMszFSX39wo2TFZLpaypZ3CHxP6wqO8
         9kpw4gfYH+OcFL8c92GmUTyFv469KQWb5BXi9P0xZMlcm6u7N/F5lKbE9CgE6uWcFcjF
         W5NtwInfSo1WcbeN6O/qJgp8yYz3XRsnjNLcmCVILjKVn/yEYSklwvkPf1YdrvWKqs6j
         n5c5xdzlvJZWmHoPs7MbqY8zf46eEo1n5VnmGcURYhNnfOkSk1/KNv6aqLYWSwEyEK4B
         yuYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780670125; x=1781274925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQ/3w04o+ggaB38jN74hv+yv2x9YXo9JGbMZzk+XFXg=;
        b=PJGv3PG0ES1KWw0ZZmhb/ShAlD0nS665YgUxOvKn3nDKgoM7elYUxuC4zKFwruEY39
         lJ28NxBgOkszB8z15XfA2FmPQx+vG712zNCdTdXsdOOipc/l28qJfUdxYdglXjWkoT5p
         8OwRtg1xn2EjyN3zLtPQ2IbyDXS/AYgFuqO+KdB5+NPJ8xnVXzCjP4kmH79dZ7irovzR
         82AqTHmY8toXZxwRlu9ZTmoCh7aiSEuuRjwyK3btX4LLFVLF3QiDx8iDpOBSHEruRF0C
         8yqhzC8hHBjHw0eT9/y0JoG53+3L/oq6LVV7yOTQIraVdllzUcFpiThU+3x19uUIATmr
         JR/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780670125; x=1781274925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cQ/3w04o+ggaB38jN74hv+yv2x9YXo9JGbMZzk+XFXg=;
        b=OxzMKiH17juPlOGL+Ph3V7kGfLyWG3SEv82jxzFDdcJyRFmQBTq68htPv54S5vQ5tN
         +B/FrDkkQqldA4mi9I8Y8eqKacSSp2FPWZLARdM0WAPxmhv6spRML4DjqGmIwSsMDHLU
         7xZqeEcouGCaQzBONtA6UZVWtVtss+etKkLuIVttL9BsX92n1oiJmnIFDpE2JIrejELm
         OBbB6uBNqRJcHDt5n8CaMrVsyPvUM9FgEi3LmAtfLV17QUbaiYKCnQ4RfiECa8CU70LX
         SGkWfxF4cSZ80YQ0J34NUfJO/j6beqHQsKIBQGHW8pJTOdjB1rdR/Ef1z5/o85MFAN/W
         lE/w==
X-Forwarded-Encrypted: i=1; AFNElJ8wEe0xtyRmjoCjHMd6fArAFsrdcqeVd2l+uLDDSif2Qv/W2k5bNXKgzR6VcC7uJBVIdh7tYpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhGIbztpwG3PRNv+2iiJ8LzYXpyA+yO4R5yzGA89nvaa+14Ldl
	srCUt4/zksIqEUg2Ck4cHqg/CUPe2z6YdtryjMkSZBbnVOzIS/SsLjHB+JWC8dkA6Mqm8Gc9qhj
	40NfBe+dWULltoo0uInH65iJpb5jY6ZGINCUodt1z
X-Gm-Gg: Acq92OFfYDVGVUZd86lUirf7fuq2rvADVU6FJqGnPeEBTaF1sV9aTHyqVlBnAUNgpKf
	tAC0nwmVFWsuknEvelW6CrJgutRqQDZUgm8dN7bNCRLTdE3BrLxOkGrzgkZtrxCQP0IlIl+SlH0
	d2zriSptdp6FJf/uVcymovucfq7d97UkZcdSqgw18NbnYUu00RMF2d/MORU2n1mhbUvVe4D6aHl
	ecGP4PeQvC6TWOPbyP4q8jynwV0DbmvOpROmWkJwnHoTDHI9az8iRLlLxvMQhFkKg8kXBAGJ68X
	jNNut46NgtRHHFmJvlMF1EYPwyn8sCJw7iiI9ER9xdJrDbId
X-Received: by 2002:aa7:c413:0:b0:68f:d41d:ca5f with SMTP id
 4fb4d7f45d1cf-68fe927fc75mr41426a12.13.1780670124230; Fri, 05 Jun 2026
 07:35:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518-procfs-lockfix-part1-v1-0-5c3d20e0ac33@google.com>
 <87ik8b2rh8.fsf@email.froward.int.ebiederm.org> <CAG48ez2pmuoTCZh_AVKDDLeQEYmm=gLMgThnqFhRMFfZvABpdw@mail.gmail.com>
 <87wlwny905.fsf@email.froward.int.ebiederm.org> <CAG48ez3Wp757fQh1gyTxf-k3p__utUOWM8xdJeUig4gPpSmTEA@mail.gmail.com>
 <87mrx9f8q2.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87mrx9f8q2.fsf@email.froward.int.ebiederm.org>
From: Jann Horn <jannh@google.com>
Date: Fri, 5 Jun 2026 16:34:47 +0200
X-Gm-Features: AVVi8Cd7jelK0RchbvZkK8JckyqyuXyMS-X2Q1_f7RoNp6olcsRkRpqJzk9SZw8
Message-ID: <CAG48ez1ksU=6KBSW1fREo4itu7vdP5KEt3s4hCAcbVkdthLXsw@mail.gmail.com>
Subject: Re: [PATCH 0/2] proc: protect ptrace_may_access() with exec_update_lock
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Arjan van de Ven <arjan@linux.intel.com>, Jake Edge <jake@lwn.net>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>, Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 2:54=E2=80=AFPM Eric W. Biederman <ebiederm@xmission=
.com> wrote:
> > On Thu, May 28, 2026 at 3:11=E2=80=AFPM Eric W. Biederman <ebiederm@xmi=
ssion.com> wrote:
> >> Jann Horn <jannh@google.com> writes:
> >> The issue you point out with memfd's definitely needs to be fixed.
> >> It should be separated out from the rest of the races simply because
> >> it is a completely different kind of issue.
> >>
> >> I wonder if anyone even anticipated you could open another file handle
> >> to memfd's through proc.  If so leaving everything to path based
> >> permissions assumed a feature of proc that doesn't exist.
> >
> > I don't think memfds are particularly special here, they are just a
> > nice, clear example of a case where an inode is protected based on
> > which processes can path-walk to it.
> >
> > As another example: Making a directory mode 0700 is also supposed to
> > prevent other users from accessing things inside it.
>
> The simple counter example is that linux has an open by inode
> facility.   That is exposed to nfs and as a syscall.
>
> Well strictly speaking the syscalls  name_to_handle_at and
> open_by_handle_at.
>
> Most filesystems including shmemfs support those operations.
> See shmem_export_ops.
>
> Which is a long way of saying that if someone can guess
> the inode and generation number of a memfd inode it can
> be opened with open_by_handle_at.  The usual permission checks
> are performed but unless I am misreading something the only
> permission checks that are relevant are the permissions on
> the inode.

No. open_by_handle_at() is not supposed to let you bypass
non-executable directories.

Filesystems without a special export_operations::permission handler go thro=
ugh:

do_handle_open -> handle_to_path -> may_decode_fh

which requires that the caller has global CAP_DAC_READ_SEARCH, or is
capable over the superblock, or is capable over the containing mount.

> >> My gut says the best fix for the entire memfd issue is to simply chang=
e
> >> memfd's and probably everything that calls shmem_file_setup to not hav=
e
> >> an open method.  That eliminates any chance anyone will do anything
> >> clever with proc.  But I can't see why it makes any sense to be able t=
o
> >> open another file handle into memfd's, or anything else that calls
> >> shmem_file_setup for that matter.
> >>
> >> We can first try to remove the open method of memfd's set by
> >> shmem_file_setup, and if that doesn't work we can look at fixing proc =
to
> >> provide the guarantees that were assumed (as a security fix).
> >>
> >>
> >> As a quality of implementation issue I can see fixing the small race
> >> where when looking up a file descriptor through proc, exec does not
> >> appear to be an atomic operation.  I keep wondering if that is somethi=
ng
> >> that should be done in get_link or d_revalidate.
> >
> > I don't see how d_revalidate would help, that still wouldn't be
> > atomic.
>
> You have to pick the correct one, but in general it is the job of the
> revalidate methods to find something that is stale and see if it works
> in the current context.  AKA make it look like something that wasn't
> done atomically behaves semantically as atomically.

d_revalidate refreshes dentries, but it doesn't make anything about
the underlying inode atomic; and my understanding is that procfs wants
to avoid tying inodes to things like task_struct or mm_struct to avoid
keeping those objects alive unnecessarily.

I think d_revalidate would make sense if, for example, we wanted the
/proc/$pid/maps inode to hold a reference to the corresponding
mm_struct.

> >> I suspect the answer for proc_pid_get_link is to either cache somethin=
g
> >> like a seqcount, or simply to repeat the permission and existence chec=
ks
> >> just before calling nd_jump_link.
> >
> > That seems like it results in complicated semantics, while a mutex
> > would provide clear semantics. Which is already what we use in places
> > like __pidfd_fget() and /proc/<pid>/syscall.
>
> An important point to remember when dealing with proc is that it is for
> implementation purposes a distributed filesystem.  Thinking of it like
> a syscall is wrong.
>
> There are lots of places that for correctness reasons (and to not burden
> the rest of the kernel) proc does something and then validates what
> it has done is correct.  AKA just like a distributed filesystem.
>
> As for semantics I am not proposing anything that will have complicated
> semantics to userspace.  It may have a slightly more complicated
> implementation in proc, but that can save complications in the
> rest of the kernel.
>
> Anything that needs to block exec to block to operate correctly is a
> real can of worms review wise, and something we have repeated gotten
> wrong in the past.  Something where exec can just do it's thing and
> proc can still give a point in time correct answer makes the analysis
> that things won't break much simpler.

Hmm... the reason we got it wrong in the past is that we were using
cred_guard_mutex, which was held across stuff that can (indirectly)
wait for ptrace, right? Whereas nowadays we basically only have to
ensure that we don't block on userspace actions while holding the
exec_update_lock? Which still requires some care but should be less
problematic.

> >> >> Question 2.
> >> >>
> >> >> How does this race compare to racing with setresuid?
> >> >> Do we need to fix the setresuid case as well?
> >> >
> >> > Which setresuid case? setresuid clears the dumpable flag and has a
> >> > memory barrier that is supposed to make that properly ordered agains=
t
> >> > ptrace_may_access(); so setresuid() should normally not cause a task
> >> > to become traceable, though that could maybe happen in weird
> >> > scenarios.
> >>
> >> The cases where the dumpable flag get set are all part of exec.
> >>
> >> I was thinking of cases where we have a daemon that is started by
> >> root and then it changes it's uid to do something.
> >
> > (Normally such a daemon would only change its EUID, which is mainly
> > considered when the daemon acts as a subject, unless it intends to
> > permanently drop privileges.)
> >
> >> Looking at ptrace_may_access the uid based checks won't allow
> >> accessing of such a task unless it changes all of it's uids.
> >>
> >> At which point arguably it is on the process that calls setuid to make
> >> certain ptracing it won't be a problem.  I am not certain that ever
> >> actually works in practice but that does seem to be what the current
> >> code is saying.
> >
> > When a daemon changes its EUID for some reason, commit_creds() will
> > change that daemon's dumpability to suid_dumpable, which will prevent
> > ptracing it even if the UIDs match.
> >
> > The ptrace.2 manpage guarantees that a process which is not
> > SUID_DUMP_USER can't be accessed without CAP_SYS_PTRACE.
> >
> >> Now I am wondering if dumpable should get set if setresuid changes
> >> a uid like I described above.
> >
> > What do you mean by "get set"?
>
> I was and still am wondering if dumpable should be set if setresuid
> completely drops all of it's uids.  AKA the case where dumpable is not
> set today.

You mean the case where the EUID is different from RUID and/or SUID,
and userspace calls setresuid(current_euid, current_euid,
current_euid)?

> Unless someone wants to do a bunch of work survey such code
> we should probably wait until a motivating example presents itself.
>
>
> >> > I think another case we should probably care about is what happens i=
f
> >> > a process which is only protected against ptrace by being non-dumpab=
le
> >> > goes through execve() - it shouldn't be possible to access resources
> >> > associated with the pre-execve state while checking against the
> >> > post-execve dumpability. It might be important for this that the
> >> > do_close_on_exec() logic currently happens after committing the
> >> > dumpable state in exec_mmap()...
> >> >
> >> >> Question 3.
> >> >> Do we care about the case when a privileged process calls a setuid
> >> >> process and drops privileges?
> >> >
> >> > I don't understand the question. Hmm - do you mean a case where a
> >> > process with ruid=3D1000, euid=3D0, suid=3D1000 does execve() on a s=
etuid
> >> > 1000 binary? I think we probably don't specifically care about that.=
..
> >> >
> >>
> >> The general case would be a daemon running as root forks and exec's a
> >> binary running as some unprivileged user fred.
> >>
> >> Mostly I bring it up is that it is easy to forget suid exec can drop
> >> privileges as well as raise them.
> >
> > I do not understand the scenario you're describing. Can you give a
> > specific example you're thinking of - what the ruid/euid/suid would be
> > before execve(), and which mode the binary would be?
>
>
> A process P1 with uid=3Deuid=3Druid=3Dfsuid=3D0.
>
> A user fred with uid=3D1000.
>
> A binary B with uid=3D1000 (aka fred) gid=3D1000 (aka fred) that -r-sr-xr=
-x.
> AKA everyone can read and execute the binary, and the setuid bit is set.
>
> Then P1 execs B.

I think I see your point - in this case, if P1 calls
setresuid(current_euid, current_euid, current_euid), fred would
afterwards be allowed to ptrace P1.

That feels to me like it is a bit weird, but probably not very
problematic because fred owns the file; P1 is already running code
owned by fred. Though fred can't necessarily actually change the file
contents, if the file is immutable or the mount is readonly or such.

I... think it is also rare for setuid binaries to call
setresuid(current_euid, current_euid, current_euid), since normally it
is desired that they keep the original RUID for stuff like
signal-sending permissions? But I might be wrong about that.

> p.s.  My personal opinion is changing permissions upon exec is a dumb
> idea.  It might be worth doing the work to drop that support and to
> update userspace to just connect to more privileged daemons when more
> permissions are needed.  AKA ssh instead of su.

I agree that it would be nicer to get rid of that... I remember amluto
saying the same thing.

Lennart Poettering thinks that, too, and has added the sudo
replacement "run0" in systemd, which works by talking to systemd and
authenticating via polkit:
https://mastodon.social/@pid_eins/112353324518585654
