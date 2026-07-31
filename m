Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B28F53E0B;
	Fri, 31 Jul 2026 00:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785459420; cv=none; b=nv/N22rb51xZG2ud8kSHEhipUrIzwd1NaEvIVim1rqNPBiFLI4PpzpPjylZJran5vZqDe/WmP9dxQ0hKyaLxjjH+njpXcdfzxXnRKcgCMYeixGUIdgBjQj2GIHngx1NT52+4CjBCJ4KWNcX0MfAOlYcE98oBNMAxM6EKrgqapRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785459420; c=relaxed/simple;
	bh=J4zkCbF/opIrfT2Xlo+xcCVkiLqELexaZkw6vNHb21U=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hsFJqm6uV+Z+oU1vdGjZm3e5PRvdDVpUZie0m7DnyplsSZgYwVmn3Fxgh0g2ETyUKDQF/iLhw5iQA4cSMXAjWKCYGrjCU7j5pfqlV4tNLt9JedvYMtESJAK8Ac7Ez4VBxES+/44UpkPm16mst9AhdbZd1iV+8Im4aeeG/MCvGIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rv7nVM+7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rv7nVM+7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5C21F000E9;
	Fri, 31 Jul 2026 00:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785459418;
	bh=XXzYaJCuzR0JHm+z1MoU23mGFZW9sah3kBLppL7JY9A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Rv7nVM+711hTMnCqTBK488muy//tXFiaPJI/9sEkcZP2yfddtSsaR42oHxLcPpVUR
	 r18XYmFbkofZtgC5zzzMwBcgQekdYfN/f4xYJxcgrsSm0WkCt3ltIoCjR6dc0OzVe/
	 OcTDBYdBd+RmJYNCWJeshq1tt1IG0GEJnuqYO7emnw6UQs3QFGlc4EDAtvaJiWtEam
	 42GE8Vy3c5u0oMYTMoNY5mT2SkTXcBc0PsGJylb7d3+FBaEyi7jk7VaeT0NURPuGKY
	 fOxEAEvITqmFR9kXNzdnkAOl8ZaEbAkxKWqo1MKo7M+sKU1U29Qnj5opkG8Qzi6q98
	 vn64X5XfhWAtQ==
Date: Fri, 31 Jul 2026 09:56:52 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Oleg Nesterov
 <oleg@redhat.com>, Breno Leitao <leitao@debian.org>, Ingo Molnar
 <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung
 Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
 <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, Andrii
 Nakryiko <andrii@kernel.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH] uprobes: Fix NULL pointer dereference in
 hprobe_expire()
Message-Id: <20260731095652.fc5d64f8c122d7dc6ddd89be@kernel.org>
In-Reply-To: <20260730103824.GD751831@noisy.programming.kicks-ass.net>
References: <20260729-uprobe-v1-1-61896b87c867@debian.org>
	<amokG13tEnA7VVVf@redhat.com>
	<CAEf4BzYON57L_HD71qUOdRdni_=1S-Xomz27PeDBxbbXDy0Jug@mail.gmail.com>
	<20260730085421.d455361164695270bd764a4b@kernel.org>
	<20260730103824.GD751831@noisy.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 30 Jul 2026 12:38:24 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Jul 30, 2026 at 08:54:21AM +0900, Masami Hiramatsu wrote:
> > On Wed, 29 Jul 2026 12:31:08 -0700
> > Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > 
> > > On Wed, Jul 29, 2026 at 9:02 AM Oleg Nesterov <oleg@redhat.com> wrote:
> > > >
> > > > On 07/29, Breno Leitao wrote:
> > > > >
> > > > > --- a/kernel/events/uprobes.c
> > > > > +++ b/kernel/events/uprobes.c
> > > > > @@ -832,7 +832,7 @@ static struct uprobe *hprobe_expire(struct hprobe *hprobe, bool get)
> > > > >               if (try_cmpxchg(&hprobe->state, &hstate, uprobe ? HPROBE_STABLE : HPROBE_GONE)) {
> > > > >                       /* We won the race, we are the ones to unlock SRCU */
> > > > >                       __srcu_read_unlock(&uretprobes_srcu, hprobe->srcu_idx);
> > > > > -                     return get ? get_uprobe(uprobe) : uprobe;
> > > > > +                     return get && uprobe ? get_uprobe(uprobe) : uprobe;
> > > >
> > > > Well, looks "obviously correct". At least the current code is obviously
> > > > wrong, it even checks uprobe != NULL 3 lines above.
> > > >
> > > > Andrii ?
> > > >
> > > 
> > > Yes, indeed, I'm more surprised this didn't come up much earlier
> > > (probably it's rare enough to have uretprobe with refcnt at zero
> > > during fork). The fix looks good, thanks!
> > > 
> > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > > 
> > > > Acked-by: Oleg Nesterov <oleg@redhat.com>
> > > >
> > 
> > Thanks, this seems good to me. (uprobe is NULL checked in try_cmpxchg(),
> > so it could be NULL.)
> > 
> > Can I pick this to probes/fixes branch?
> 
> tip/perf/urgent ?

Either way works. Can we update MAINTAINERS file if you will maintain
uprobe in tip tree?

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
