Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF7535F60F;
	Wed, 29 Jul 2026 23:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785369269; cv=none; b=NI0rfEvNMvDreAlEOTc0szUjRKbr7bwg/QrmAb20gZzBFKU1c/K5Wnh4sEmMYIwvPE8Wx5o5X/7nQXghJXgKjet0nh7qChWniWLch7wyja+eLVXfhy32GbqvHJPlVHFUU2LrNKiFMYVhDGZGx+tQNLVOqOwZPQ5tlJNMn77Wbtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785369269; c=relaxed/simple;
	bh=mk0ysuQeVKrkFHWAAQe9lU/hLVqzePR/R1QAUuh8rP0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=nPKDnrbeYazfvK92L8iyEzkCS0q5YgnN3t+i1FRGwD6nxV/0/Mrtx9m/PQYIfGouStKDdAAKa+ZwLR6DXbiaxGkVw71c26qFEUH4+TuYQueDPuDV3f43OsU+PLHfeeeSaSAI5Y2h0VYV+qv6mveyvna0agY5HArTn07/23eUf5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3AcRQA9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3AcRQA9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA6F71F000E9;
	Wed, 29 Jul 2026 23:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785369268;
	bh=S4i1MKc4I4+9ayCuIhJnqaUS/QxUEZoRrMHVFl5plEg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=U3AcRQA9/oI4tUSq1anW24dD1dbCZkK61nJ6+d2dHzhGH7dF+qy3SoWte2menLjEb
	 0QhcdfK0wkG/qwt3Gm93P0I+A1f/ybfhLYecKG3hVip2UULAzp8vUKn0nUrzbkX+FR
	 r6h018Ja1rJk5D3/T3LBm+9ZYeQz+AYpivdzNYx6F9kRG0Wi6aIBkdLSCEONZ09BNW
	 yZOehJ5tU9yEwLKg59aIGRAlFqu2U340ix+jKB7lDdJnQ4mm3Ab/MuGKVjzYY0vM36
	 9S/lBhtSSOwVO6b5+T4W+9ScULxwBc046GQjcu4ICrk0KgYHPrdd2+W/DzsciPO8kt
	 saWxHjd0Epvfg==
Date: Thu, 30 Jul 2026 08:54:21 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Breno Leitao <leitao@debian.org>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, James
 Clark <james.clark@linaro.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH] uprobes: Fix NULL pointer dereference in
 hprobe_expire()
Message-Id: <20260730085421.d455361164695270bd764a4b@kernel.org>
In-Reply-To: <CAEf4BzYON57L_HD71qUOdRdni_=1S-Xomz27PeDBxbbXDy0Jug@mail.gmail.com>
References: <20260729-uprobe-v1-1-61896b87c867@debian.org>
	<amokG13tEnA7VVVf@redhat.com>
	<CAEf4BzYON57L_HD71qUOdRdni_=1S-Xomz27PeDBxbbXDy0Jug@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 29 Jul 2026 12:31:08 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> On Wed, Jul 29, 2026 at 9:02 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > On 07/29, Breno Leitao wrote:
> > >
> > > --- a/kernel/events/uprobes.c
> > > +++ b/kernel/events/uprobes.c
> > > @@ -832,7 +832,7 @@ static struct uprobe *hprobe_expire(struct hprobe *hprobe, bool get)
> > >               if (try_cmpxchg(&hprobe->state, &hstate, uprobe ? HPROBE_STABLE : HPROBE_GONE)) {
> > >                       /* We won the race, we are the ones to unlock SRCU */
> > >                       __srcu_read_unlock(&uretprobes_srcu, hprobe->srcu_idx);
> > > -                     return get ? get_uprobe(uprobe) : uprobe;
> > > +                     return get && uprobe ? get_uprobe(uprobe) : uprobe;
> >
> > Well, looks "obviously correct". At least the current code is obviously
> > wrong, it even checks uprobe != NULL 3 lines above.
> >
> > Andrii ?
> >
> 
> Yes, indeed, I'm more surprised this didn't come up much earlier
> (probably it's rare enough to have uretprobe with refcnt at zero
> during fork). The fix looks good, thanks!
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
> > Acked-by: Oleg Nesterov <oleg@redhat.com>
> >

Thanks, this seems good to me. (uprobe is NULL checked in try_cmpxchg(),
so it could be NULL.)

Can I pick this to probes/fixes branch?

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
