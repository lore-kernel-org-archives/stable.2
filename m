Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5EE3C1D78;
	Wed, 29 Jul 2026 15:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785339075; cv=none; b=t7t73cQXl/vGWsrE/8x0kJhrE0DZvLuc7ve7VGZSOq2sXT/KoiVWBnK69fwbnQwGp6ac3gSEnrDPSbJhPQZuVkD4bA0MZ9Sv33kfYo7rI3k1wVE5oo3KiXVVC0EKqflFO9ENlDLUoNs3F2U5m/MiGdYKUb+55vQr01zXwSOWVno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785339075; c=relaxed/simple;
	bh=mCrppwFzqJJ3wA+pXsNCVDraYaxnPzZ7fkcGZbHDj0A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZydRpSG/Jkc/GySjeXHANHewqxgXkDcW4ZN4s+H4ckU/eP/o+sDGk3XNiI4CvPYRsbvvjuEQSB91h4x4D81cJLRLU2NlOkb/HDwbe9shaDK/iibhxJiMKD2CJXMJVylC5iJaiV4w1q9sqtTYMZe6BiQWHuVB7jFLP66PPzFkNvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 881C0A0702;
	Wed, 29 Jul 2026 15:31:04 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 187762000E;
	Wed, 29 Jul 2026 15:31:01 +0000 (UTC)
Date: Wed, 29 Jul 2026 11:31:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, song@kernel.org, jolsa@kernel.org, naveen@kernel.org,
 davem@davemloft.net, mhiramat@kernel.org, stable@vger.kernel.org,
 linux-open-source@crowdstrike.com, mbenes@suse.cz, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH bpf-next 0/3] ftrace, kprobes, bpf: mark
 trampoline/kprobe ftrace_ops permanent
Message-ID: <20260729113136.32af2a4d@gandalf.local.home>
In-Reply-To: <CAOu3gNgc0XHScgEf+yWF5Kr8sAm8Fsa4RBuwL0YE2EscSiBPrA@mail.gmail.com>
References: <20260729005959.3853865-1-andrey.grodzovsky@crowdstrike.com>
	<20260729104114.04298a48@gandalf.local.home>
	<CAOu3gNgc0XHScgEf+yWF5Kr8sAm8Fsa4RBuwL0YE2EscSiBPrA@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: fi7kd9udmk8fragx7joh8yamexgf4j44
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 187762000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19TYrfKJHtehk40lCha/ZA9AhcvzQlaqVE=
X-HE-Tag: 1785339060-4129
X-HE-Meta: U2FsdGVkX1/nZ9MxXgktekmcCky5uR/3BC1TA3nmiHmC+yuqKFVTke/NdY7s8PcjAZtNIp5ezjyQCHtLutnOHPayYSaJ2QvGkJYCgtEdSki3mKRx+DjQD8LpoeeFIKzKqsjGBQvW+QXgEFz1LP+ILBP5ElNrlZoxjb8yeMf7B/TyFgdLtvAPVg1IzjinRa6Unwnlmww2cw3pgcMYDuzu12R/TWi0Gci2/Hsu5JBi8PcSfSLxNa4JdxIhNXYTDNY3/Dmp21dVagWyVZ/q6jkkeAYzbIwzihsctnolT1qkGdKzkH6uDVW0UBz84GE4j03JDRpBqXoZgvLavngGIL/WmU3F4CDTwtn5iQ+kg5Uvwx4czWp3GZ42PA2jc1H0aMBeYEyRKG6ULYPO+4rqNb1up0gZS5worSRnGI9/aaJgKQU=


[ Adding Linus in case he cares ]

On Wed, 29 Jul 2026 11:00:31 -0400
Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com> wrote:

> ,
>=20
> On Wed, Jul 29, 2026 at 10:40=E2=80=AFAM Steven Rostedt <rostedt@goodmis.=
org> wrote:
> >
> > On Tue, 28 Jul 2026 20:59:56 -0400
> > Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com> wrote:
> > =20
> > > This fixes a long-standing issue: kernel.ftrace_enabled=3D0 silently
> > > disables BPF trampolines (fentry/fexit) and ftrace-based
> > > kprobes/kretprobes. The write succeeds, the hook stops firing with no
> > > error, and re-enabling silently restores it. Livepatch already solved
> > > this for itself via FTRACE_OPS_FL_PERMANENT, which refuses to disable
> > > ftrace while a permanent ops is registered and refuses to register
> > > one while ftrace is disabled[1]. =20
> >
> > The /proc/sys/kernel/ftrace_enabled was added as a "safety kill switch"
> > back when ftrace was first added to the kernel. It's addition was namely
> > there because live runtime modification of kernel code was new and we w=
ere
> > worried about how stable it could be.
> >
> > Honestly, I would love to get rid of it as today ftrace has proven to be
> > rather stable. But as it is a user space ABI, I'm not sure what will br=
eak
> > if we do. I wonder if we just make it a nop, and print a message to dme=
sg
> > saying:
> >
> >   "ftrace_enabled no longer does anything. Please report if you need it=
 to."
> >
> > ? =20
>=20
> Thanks Steven, if you and/or other community members would approve such
> approach I would happily do this instead for a few reasons -

It's actually if Linus is OK with this approach.

>=20
> 1) Seems like the more correct course of action if idneed this switch
> effectively became obsolete in usage instead of piling extra logic to work
> around it.
>=20
> 2) As I mentioned in the end of the cover letter, I believe for some cases
> such as fsessions/ksessions and multi opts retprobes, this patchset is
> not effective and the issue will persist, requiring a more complicated so=
lution
> for them anyway if we want watertight resilience.
>=20
> If you approve this - I can try what you suggested, this would include
> making the
> knob a NOP with a message, dropping the FTRACE_OPS_FL_PERMANENT
> flag and reverting/cleaning what's possible from the original livepatch p=
atchset
> that dealt with this issue [1]
>=20
> One question is what the correct set of tests to run in such a case
> would be to verify
> we didn't break anything. For this patchset I ran BPF and livepatch

Hah! That's the key question isn't it? It's a user space visible knob. I
don't have anything that uses it, but I have no idea of there's a tool out
there that does. Linus's rule is to not break user space. If nothing uses
it, then it's OK to get rid of (as getting rid of it will not break user
space). But, if something uses it for a good reason, then we are stuck with
it. We really will not know until we disable it and somebody complains.

-- Steve



> selftest suites, but
> I wonder what else would need to be run.
>=20
> CC Miroslav for Livepatch.
>=20
> Thanks,
> Andrey
>=20
> [1] - https://lore.kernel.org/all/20191016113316.13415-1-mbenes@suse.cz/T=
/#u
>=20
> > =20
> > >
> > > For trampolines this restores a historical property: from 2019-2022
> > > they shared one global direct_ops, marked permanent the same
> > > way[2].It was later lost as a side effect of the 2022
> > > per-trampoline-ops split (patch 1's Fixes tag) and never
> > > restored.[3][4] Kprobes never carried this protection at all, so
> > > for them that is long-standing issue rather than a regression.
> > >
> > > Patch 1: trampolines. Patch 2: classic kprobes/kretprobes. Patch 3:
> > > a selftest covering both directions for all four hook types.
> > >
> > > P.S
> > > I initially implemented a per-record opt-in flag[5], but dropped it
> > > as over-engineering once I saw the original blanket restriction.
> > >
> > > P.P.S
> > > Open question: kprobe.multi/kretprobe.multi/kprobe.session
> > > (fprobe-backed) aren't covered -- return-capturing fprobes share the
> > > function-graph tracer's subops manager with unrelated tracers, so
> > > marking it permanent needs a different, per-record approach. Perhaps
> > > something along the lines of [5]. =20
> >
> > Honestly, I would like to start deprecating that kill switch.
> >
> > For the series:
> >
> > Acked-by: Steven Rostedt <rostedt@goodmis.org>
> >
> > -- Steve =20

