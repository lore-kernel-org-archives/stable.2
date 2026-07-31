Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E09321A42D;
	Fri, 31 Jul 2026 08:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785487900; cv=none; b=VDbicLGK3DSTD2E9SNWWzdmU2Qdp+kAWawYTtQFUhn4D25SU4ZjZzq0Th2jwIMLIIWijBhgj5HO8zY3CATXv5d5EH/YMjf4OchLbQsXio9qn9Xb7Ms0bZl1y8IcDJhJkpqOV0Lm/qs11nQ9WDtTM7x2XSxNt+kU3iHTTDVODwi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785487900; c=relaxed/simple;
	bh=oVA6GAykCnjUjoqEbg7/ziVq1267X6jca6NFSr+5asU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXN7u21aLrZ54wGZH0+CM34nbVNS12Yfv/SsIhiQKXOcLrx2Oaz7MMqLZPko3criRkY4OHyrgoXn3qs0A61sZmviC9XdcTYxh0wgH5d2VaSo/xrXM7cyzVwK6F2wl8zShZRALOZJcchJyjconzywciEa7Cz5HkV/Jvojn/aJnRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=psaBciIq; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="psaBciIq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LvkyHfWthEPTNyIP4d/nXbdvuACixTM6aKQkMxt8KlY=; b=psaBciIqJx2de1aSJKTu5AZK4F
	geYbUDWhms1q2ZuPLhAlddAPt3lLfEx9foZieJ4IpSUFevldyXgcLdpwq/Crg+ileL96uBbaztD8E
	F3lq3V96aQm5TT6LZxeEvvt+R7v4CiG7cv/vv6Se+cAAAGZZt76lOc4Bq6RareFv0YgOg+RM6MUPd
	70TPbCpkhhXSuNJAu0x9ZCbnY8ycV6+yszRPSzSU7hXAJX86Bf8ckIwMuul7QGXMJtcu7vmfB1uWQ
	7UT5KGSwEUOKla+MqEkQkLmI1RKKMdtZ2UVAV0Y5G3eZAyr5mzKyItCbIwNxgMbPvchIP/lVlW7CS
	B68Y8aag==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpixl-0000000FgFp-2Ztx;
	Fri, 31 Jul 2026 08:51:29 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0CF7F3004AB; Fri, 31 Jul 2026 10:51:29 +0200 (CEST)
Date: Fri, 31 Jul 2026 10:51:29 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Breno Leitao <leitao@debian.org>, Ingo Molnar <mingo@redhat.com>,
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
Message-ID: <20260731085129.GG776954@noisy.programming.kicks-ass.net>
References: <20260729-uprobe-v1-1-61896b87c867@debian.org>
 <amokG13tEnA7VVVf@redhat.com>
 <CAEf4BzYON57L_HD71qUOdRdni_=1S-Xomz27PeDBxbbXDy0Jug@mail.gmail.com>
 <20260730085421.d455361164695270bd764a4b@kernel.org>
 <20260730103824.GD751831@noisy.programming.kicks-ass.net>
 <20260731095652.fc5d64f8c122d7dc6ddd89be@kernel.org>
 <20260731083039.GD776954@noisy.programming.kicks-ass.net>
 <amxgF3S7jfmjHvPv@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amxgF3S7jfmjHvPv@redhat.com>

On Fri, Jul 31, 2026 at 10:43:03AM +0200, Oleg Nesterov wrote:
> On 07/31, Peter Zijlstra wrote:
> >
> > On Fri, Jul 31, 2026 at 09:56:52AM +0900, Masami Hiramatsu wrote:
> > > On Thu, 30 Jul 2026 12:38:24 +0200
> > >
> > > Either way works. Can we update MAINTAINERS file if you will maintain
> > > uprobe in tip tree?
> >
> > Well it is in kernel/events/ which MAINTAINERS should already assign to
> > me, no?
> 
> Confused... you are already listed as a maintainer. From MAINTAINERS:
> 
> 	UPROBES
> 	M:	Masami Hiramatsu <mhiramat@kernel.org>
> 	M:	Oleg Nesterov <oleg@redhat.com>
> 	M:	Peter Zijlstra <peterz@infradead.org>
> 	L:	linux-kernel@vger.kernel.org
> 	L:	linux-trace-kernel@vger.kernel.org
> 	S:	Maintained
> 	F:	arch/*/include/asm/uprobes.h
> 	F:	arch/*/kernel/probes/uprobes.c
> 	F:	arch/*/kernel/uprobes.c
> 	F:	include/linux/uprobes.h
> 	F:	kernel/events/uprobes.c

Yes, but the 'PERFORMANCE EVENTS SUBSYSTEM' entry will also cover this.
So I have it twice ;-)

PERFORMANCE EVENTS SUBSYSTEM
...
F:      kernel/events/*

Anyway, patch should be in tip/perf/urgent now.
