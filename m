Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7501E1F03DE;
	Wed, 24 Jun 2026 19:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782329075; cv=none; b=SYSo+YYjAHl1kGcwKyyyJJWtY7AOHTBTYy3FLHBVkKBInm8ErPQqcB217JtWtQ5/YVOBXIEqtXd8oU2UZJT1G6uGgkRa1rgFsyxv0JHXkVE2nOyVkjqW/cck0bpGj/Z4OW2Jh7PMJw0jswiFvCD4RT9X0JXLYPcsmzBm2xrwFuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782329075; c=relaxed/simple;
	bh=ZAURbn3ahEuL4VCiXgoJsC/LIEGfbSYd9zlntFJWWpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iBlVlXvwWdTjigN21kgPpxlG4ig0FWmbl9nx5WB+3UYYfYKD8vBTMgcXlJTrcxf1opvQUAr0ReI/vqSjrMHwuTilNr8WzQJ7Rjb4tX2hiSO9SMzmNTKA7wRfjh3QjjE01gYDh5l+WIJ5/a7jrXzVLc+jlzi43lkwKOfryW0D52I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4yk8lpN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4yk8lpN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAFFB1F000E9;
	Wed, 24 Jun 2026 19:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782329074;
	bh=ztzgs5Aq+B+J2+KqdXSdfO03YP+nS8aAL3x7WZb8f34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=C4yk8lpN2B3PwxEJL1Ck4S3gB3LSNeOTX6JRR522T1LkAFsFx9nNWDTw9eX+RtrTz
	 KRKpWNxmJny167POayyxAVABFuuczKxYDI19L5KvzDsLB5OFZdidp2qrPfwqGs1gSB
	 3FYSBrNx1dldr/1Y7YgjNmmo/WDyHnS0n29fUwG8Bgt2j2czsRgfkSXEB48YLQOmuW
	 Qu7kAqKZEUX8s38GvXZQGlELOdQo1P6p2+MJRCaJHkguBpWQCf1P7g25PGXyDi1ozs
	 LX0htGBmazy9AfhzIfpthmHjSBq7sEi7EgW5gbzv3iP3CPo8XNEEggfbGhB69r1eus
	 QzRmsjY6+3LNA==
Date: Wed, 24 Jun 2026 12:24:31 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Viktor Malik <vmalik@redhat.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	linux-perf-users@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, Michael Petlan <mpetlan@redhat.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] perf trace: Refactor augmented_raw_syscalls using
 bpf_loop
Message-ID: <ajwu7xR6V6MAQOFw@google.com>
References: <20260623112533.1151502-1-vmalik@redhat.com>
 <DJGJ9F6WQZV9.2W4WBIHYLJQ97@gmail.com>
 <ajq98dm4gAwEzkMb@google.com>
 <c2f4e45e-d5c9-42e9-a46b-25fb0cacb267@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c2f4e45e-d5c9-42e9-a46b-25fb0cacb267@redhat.com>

On Wed, Jun 24, 2026 at 08:47:38AM +0200, Viktor Malik wrote:
> On 6/23/26 19:10, Namhyung Kim wrote:
> > Hello,
> > 
> > On Tue, Jun 23, 2026 at 08:27:39AM -0700, Alexei Starovoitov wrote:
> >> On Tue Jun 23, 2026 at 4:25 AM PDT, Viktor Malik wrote:
[SNIP]
> >>> +	struct args_loop_ctx loop_ctx = {
> >>> +		.args = args,
> >>> +		.beauty_map = beauty_map,
> >>> +		.payload_offset = payload_offset,
> >>> +		.value_size = value_size,
> >>> +		.output = &output,
> >>> +		.do_output = &do_output
> >>> +	};
> >>> +	iters = bpf_loop(6, process_arg_cb, &loop_ctx, 0);
> >>
> >> bpf_loop() is old and generally not recommended.
> >> Please use bpf_for() then the diff will be one line change and
> >> can scale to any number of args. Not just 6.
> 
> Thanks Alexei, I didn't know about this preference.
> 
> > One thing we should take care is to support old kernels.  The oldest
> > LTS kernel in the kernel.org is 5.10 and bpf_loop() was introduced in
> > 5.17 and bpf_for (bpf_iter_num) was 6.4.
> 
> The problematic loop was introduced in 6.12 by a68fd6a6cdd3 ("perf
> trace: Collect augmented data using BPF") so we should be good using
> bpf_for. Or is perf from 7.2 supposed to work on 5.10 LTS kernels?

Yep, we'd like to support old kernels.

Thanks,
Namhyung

