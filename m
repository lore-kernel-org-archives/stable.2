Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770D53E168A;
	Fri, 31 Jul 2026 08:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785486662; cv=none; b=tjIVMgNhPtHgPZAIkr/0u144lJIxJttgoNeXH7owWqIiJ4arRpkg0t9vavjWbVPtl+c+gOMQSnmF/H15/M/9mGOrpkRKSzOIfamjBdTH5VyAXJhTKUs6fde7sRnl7n6nSW//Aj8/s2tO76Ggs7/GD444rkuHrNtZY1GdGcaunp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785486662; c=relaxed/simple;
	bh=JjNN6BxF4vtlMCrHL466xVF05FtqP5IsvEMIqlWRVS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMB4+htgZKLBZWVLBlwf7NR2IsovdIvaMxSVfQJ1yvMEiu6CuZ91M0MYNRHL371Q44B+Yjv7XHFqVofA/ifNvRrnHyuvWb7nSZ5KUbe+M6hJ4c0XQ5UlSScEfEA1ZMT4xHFfPX3GZbqVFRWJ+fUjkdeG06vjznVJ7DDHj6cI/BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=akgvz90x; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="akgvz90x"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=glPHHyLWHvT59QdWBb+WFz+JpQ0V0Df4ETLiY4e26Jg=; b=akgvz90xykLehE3Vfv2ItTQLKi
	8/wBRXonZ8o7IqmL/lofSYsRM603yodoqOQ61D/8/7+kHOsg431Nz6CPo09bPSoN8sxiHzuWZfALt
	4KDVhWMTw0BbxL5w356y2mkDrjN3VXfrpGfMsUc+Uq4kTP0HpFQBxnu3AhLBn4VgckQUcOC+L3GRs
	2OSTryh2TriCVlyiAD9E2zZCoKY4glBUVSo9Dl59/s3d30vBNZMrsMm818cpqmBrNpVZuT0YcT2EN
	wBoK1rZ+5Baj1abEtsTAwtQXpriH/VlaQ4QlBYn/0Qw5KkdEl3uBDraHnF8k3+pZOSXO05i3/N/ta
	k0rTv8wQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpidc-0000000F9Yk-48Py;
	Fri, 31 Jul 2026 08:30:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CC5113004AB; Fri, 31 Jul 2026 10:30:39 +0200 (CEST)
Date: Fri, 31 Jul 2026 10:30:39 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>, Breno Leitao <leitao@debian.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, kernel-team@meta.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] uprobes: Fix NULL pointer dereference in hprobe_expire()
Message-ID: <20260731083039.GD776954@noisy.programming.kicks-ass.net>
References: <20260729-uprobe-v1-1-61896b87c867@debian.org>
 <amokG13tEnA7VVVf@redhat.com>
 <CAEf4BzYON57L_HD71qUOdRdni_=1S-Xomz27PeDBxbbXDy0Jug@mail.gmail.com>
 <20260730085421.d455361164695270bd764a4b@kernel.org>
 <20260730103824.GD751831@noisy.programming.kicks-ass.net>
 <20260731095652.fc5d64f8c122d7dc6ddd89be@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260731095652.fc5d64f8c122d7dc6ddd89be@kernel.org>

On Fri, Jul 31, 2026 at 09:56:52AM +0900, Masami Hiramatsu wrote:
> On Thu, 30 Jul 2026 12:38:24 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Thu, Jul 30, 2026 at 08:54:21AM +0900, Masami Hiramatsu wrote:
> > > On Wed, 29 Jul 2026 12:31:08 -0700
> > > Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > > 
> > > > On Wed, Jul 29, 2026 at 9:02 AM Oleg Nesterov <oleg@redhat.com> wrote:
> > > > >
> > > > > On 07/29, Breno Leitao wrote:
> > > > > >
> > > > > > --- a/kernel/events/uprobes.c
> > > > > > +++ b/kernel/events/uprobes.c
> > > > > > @@ -832,7 +832,7 @@ static struct uprobe *hprobe_expire(struct hprobe *hprobe, bool get)
> > > > > >               if (try_cmpxchg(&hprobe->state, &hstate, uprobe ? HPROBE_STABLE : HPROBE_GONE)) {
> > > > > >                       /* We won the race, we are the ones to unlock SRCU */
> > > > > >                       __srcu_read_unlock(&uretprobes_srcu, hprobe->srcu_idx);
> > > > > > -                     return get ? get_uprobe(uprobe) : uprobe;
> > > > > > +                     return get && uprobe ? get_uprobe(uprobe) : uprobe;
> > > > >
> > > > > Well, looks "obviously correct". At least the current code is obviously
> > > > > wrong, it even checks uprobe != NULL 3 lines above.
> > > > >
> > > > > Andrii ?
> > > > >
> > > > 
> > > > Yes, indeed, I'm more surprised this didn't come up much earlier
> > > > (probably it's rare enough to have uretprobe with refcnt at zero
> > > > during fork). The fix looks good, thanks!
> > > > 
> > > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > > > 
> > > > > Acked-by: Oleg Nesterov <oleg@redhat.com>
> > > > >
> > > 
> > > Thanks, this seems good to me. (uprobe is NULL checked in try_cmpxchg(),
> > > so it could be NULL.)
> > > 
> > > Can I pick this to probes/fixes branch?
> > 
> > tip/perf/urgent ?
> 
> Either way works. Can we update MAINTAINERS file if you will maintain
> uprobe in tip tree?

Well it is in kernel/events/ which MAINTAINERS should already assign to
me, no?
