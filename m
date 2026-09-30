Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F9946AA61;
	Wed, 30 Sep 2026 15:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790781395; cv=none; b=qejmlaPiEr6/AOcalAOBsKC1ZpGzJI7E6SMcSoxqC/PfDXZZQoJ0+5oNXEznuwH56VZv9SJwZmx7pMqh3zwa8CyYzWSuOt6wpGmtHMjn03qNQfybPZCFa72iFd/gKVmq645VM7p0P83ZFzVATjsdHWetq/+X3hiy92oTUG+tzvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790781395; c=relaxed/simple;
	bh=TrtuDblVCrqhzl9/Aclsdo8S4vvh9Qw/7twPbojMg3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrCYn/9JJIEFjOzCeaZ5szPSq8Jnzm5UWYHmmtqm8VSkF7tKIAXMRr8s+6UyeVOpB7ZZv6iDBJImQ92yDlCu9yaufytZyvlkMvESz5bpu4OvNcitH2VTvCjiQutCd0JYBLDYsg2Dg66ifyGDEBHupwrYH4/G3UzAAOFYsyNcI/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=POYS0BFv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="POYS0BFv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tAO7/NZ2ik1ulhsGeO4+BUNaazDF/WbZvDUywyLZkgA=; b=POYS0BFvgqAfqlrq9T8sAvkVGy
	0hVvItZggom0M4O9HlezJbnds0pstUuPEnyv6OiUAqnO+xOfOHRz+tsAmorvDF964tQgq8ZWJ5vhj
	m1obPIy7vtUAg25KQFe9qD3tbkpvoFIvbbMDjinh4qvpSc90GFyLgjixgvf56rwZ6IX2b1m3z7bzR
	4JmFEUnCyyNMabMTBdwfldcvSDJG5fLgYA8TiySAC4vlWfYkSHGEFZPcxUky3yJs9z/IINM7bkvYE
	S8XTpegohIal+UwTpBTnYafvvNV/PsOLb2OsGos7FG+ByrQlUtZeHg2dF+KoXI+hrTxIF2dCAvYGn
	Csx5dQbw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBw2V-0000000DrPg-0wVs;
	Wed, 30 Sep 2026 15:16:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1D92A300673; Wed, 30 Sep 2026 17:16:10 +0200 (CEST)
Date: Wed, 30 Sep 2026 17:16:10 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Danish Khateeb <danishkhateeb03@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Marco Elver <elver@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] perf/core: Don't send SIGTRAP after exec removed the
 event
Message-ID: <20260930151610.GN88198@noisy.programming.kicks-ass.net>
References: <20260930144248.59858-1-danishkhateeb03@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930144248.59858-1-danishkhateeb03@gmail.com>

On Wed, Sep 30, 2026 at 09:42:48AM -0500, Danish Khateeb wrote:
> A sigtrap event must also set remove_on_exec, so that its SIGTRAP never
> reaches a program after exec. But the signal is sent from task work,
> which only runs on the way back to user space. If the event overflows
> shortly before execve(), the task work can still be pending when the
> task enters execve(), and then runs when execve() returns. By then
> perf_event_exec() has removed the event and the new program has default
> signal handlers, so the SIGTRAP kills it.
> 
> The exec_stress test in the remove_on_exec selftest catches this and
> fails about half the time in a VM. A process that opens a sigtrap event
> on itself and then calls execve() is killed by SIGTRAP in 15% to 50% of
> runs, both on an AMD machine running v7.2 and in a VM, with or without
> close-on-exec on the event fd.
> 
> perf_event_exit_event() sets PERF_EVENT_STATE_EXIT when exec removes the
> event. If the event fd is close-on-exec and was the last reference to
> the file, exec also queues the file release as task work. Task work runs
> newest first, so perf_release() runs before the SIGTRAP work and moves
> the event on to PERF_EVENT_STATE_DEAD. Exit is already caught by the
> PF_EXITING check in perf_sigtrap(). So don't send the signal when the
> event state is PERF_EVENT_STATE_EXIT or lower, which means the event has
> been removed. That also covers PERF_EVENT_STATE_REVOKED, where the PMU
> is gone.
> 
> Fixes: 97ba62b27867 ("perf: Add support for SIGTRAP on perf events")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Danish Khateeb <danishkhateeb03@gmail.com>

Is this the same problem as this one?

  https://patch.msgid.link/20260920075026.990582-1-luogengkun2@huawei.com
