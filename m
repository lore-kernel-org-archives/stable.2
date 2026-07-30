Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E263E3CB907;
	Thu, 30 Jul 2026 10:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785407916; cv=none; b=oggHieLv1UbUPKkuSsyMkhiuZoFSKNf4DFXqXCb9F5NjU0MOHTvDSjXpTbjNTUhrOn41G5hZkJJtGvwf+dB4GeaXwOakDBvJeVRwcnJf9WTfntdf0NKudtZmATBBfXHclVLNy6nwsT2ljSfeayU4EsMQo686GWrROiSwusNWITc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785407916; c=relaxed/simple;
	bh=y2c7izy/2FYRnfRN12can+CAVIvfdFzhZjH7aChaxn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPPglhmUeHEmRm5mA/PNIwAhKquznR5/usL5LDLQHj+9sAkWfwKLzNytXWEN6fkc9FcE+qdqFlQEMHz60HiO1Dg4WAyUIl8z9hyIdMC7ANceNf5Nm4fHIUrpY/k8rB40dqU2JIeaU+DNiLf5kBjO3D2agcj4gt0b8oAwX9+fFKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JDvp/04L; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JDvp/04L"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=Rcs1SBXiBwJpq/ruUIyy1Zfd296CkNk+OrxVLeQxu1M=; b=JDvp/04Lr/hO4YluP7VORZw3d7
	0jA/U6hxlcPSFbFYzWFKinEnunysB5QfVng7KCLa3ccQIu1kOiZ7SzzDGgNUolngHx+uSWk9HfocR
	Y7/8BfBxBOxvdoSoxw342hpX9E6/eCgUOwylL6Xde7xz8J+4dZfWV+ULt8bvOAtXt/NnMNuWusSsX
	8syAJzk3LXVUvvlcBMleybapsmIztjU3XH5llanJgnyne/ExU70y34on87HDO7zJaI6uv6Y4qGAqR
	bDoxlLgxiKO65KS+8lNie1HR01QAowIet2MDJxYuD7WvvMPfIooMGzkQjqke8PXBpQgJu+SRuDNW6
	O40cNstw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wpO9i-00000006aZw-0ACm;
	Thu, 30 Jul 2026 10:38:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E751530095A; Thu, 30 Jul 2026 12:38:24 +0200 (CEST)
Date: Thu, 30 Jul 2026 12:38:24 +0200
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
Message-ID: <20260730103824.GD751831@noisy.programming.kicks-ass.net>
References: <20260729-uprobe-v1-1-61896b87c867@debian.org>
 <amokG13tEnA7VVVf@redhat.com>
 <CAEf4BzYON57L_HD71qUOdRdni_=1S-Xomz27PeDBxbbXDy0Jug@mail.gmail.com>
 <20260730085421.d455361164695270bd764a4b@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260730085421.d455361164695270bd764a4b@kernel.org>

On Thu, Jul 30, 2026 at 08:54:21AM +0900, Masami Hiramatsu wrote:
> On Wed, 29 Jul 2026 12:31:08 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> 
> > On Wed, Jul 29, 2026 at 9:02 AM Oleg Nesterov <oleg@redhat.com> wrote:
> > >
> > > On 07/29, Breno Leitao wrote:
> > > >
> > > > --- a/kernel/events/uprobes.c
> > > > +++ b/kernel/events/uprobes.c
> > > > @@ -832,7 +832,7 @@ static struct uprobe *hprobe_expire(struct hprobe *hprobe, bool get)
> > > >               if (try_cmpxchg(&hprobe->state, &hstate, uprobe ? HPROBE_STABLE : HPROBE_GONE)) {
> > > >                       /* We won the race, we are the ones to unlock SRCU */
> > > >                       __srcu_read_unlock(&uretprobes_srcu, hprobe->srcu_idx);
> > > > -                     return get ? get_uprobe(uprobe) : uprobe;
> > > > +                     return get && uprobe ? get_uprobe(uprobe) : uprobe;
> > >
> > > Well, looks "obviously correct". At least the current code is obviously
> > > wrong, it even checks uprobe != NULL 3 lines above.
> > >
> > > Andrii ?
> > >
> > 
> > Yes, indeed, I'm more surprised this didn't come up much earlier
> > (probably it's rare enough to have uretprobe with refcnt at zero
> > during fork). The fix looks good, thanks!
> > 
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > 
> > > Acked-by: Oleg Nesterov <oleg@redhat.com>
> > >
> 
> Thanks, this seems good to me. (uprobe is NULL checked in try_cmpxchg(),
> so it could be NULL.)
> 
> Can I pick this to probes/fixes branch?

tip/perf/urgent ?
