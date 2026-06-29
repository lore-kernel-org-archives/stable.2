Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370D23612F3;
	Mon, 29 Jun 2026 20:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782765324; cv=none; b=d5Ad+9DqdRuBQBnryJGM3tbdReduIRWMiSC/3HLgZR79tDXWdOJ3yGqXz80qmWKEBDGfR0eGPrkkVFfXz8M49xc9n4vd4bmM6Y88gwT8eXwWjYq//f+Kof+o7Es0BvlIOSHVZMXuPf4ZgtBdvPriNNdZGV26z/7EQFt9tp0eVBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782765324; c=relaxed/simple;
	bh=VkoYOlEYcEWos5dD5mpKTK0yY5QHXN+DJ7ZNdSm15Q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KqcAhHwZkEdeZUMC8KuJSUfE+63K3fg2MMr6Uv+ba1c8ySqtb5mt9KdQHSVEikeh/7zc18tZdEUJVKKTxcPZoZusOX7EZnZ5T/Q8Hp4/VFJxIfBCoA0ZJqpYxWOIbJfMWf5qOeewhfXy7uWyQzSJ0FkZPbkWBDAU/CHbWOTT59Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K31tkYmw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K31tkYmw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14FFD1F000E9;
	Mon, 29 Jun 2026 20:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782765322;
	bh=8a06L0VXzdr/uleO9for3GUONneYi0JhHdh4wi547JI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K31tkYmwluD2pwR/vbqAIpy0dFddndW0pniVnPbn0e1VfD5625tRtS1wL9Q95OCbk
	 Gv07rVoDhkp9ASUKKOCaJeMf7QTmPcxt0VCfsJUWw/+zTk5keozQbBjmplndfqpaur
	 6TuIx+kr8p57cuhzWQ07IcBe/u/yJTQqKOtj7aTYV/QLexmag6DJpEhv0laiU2JweU
	 Er3ePN5C3h2oFjNzCrXjVIAEO9tN6H31dFvsDdNNWVdRran9jfDIVLPh6JiCAQI1FO
	 7zYEvattphsB5LYdRFDlvsiVY+EqOKM8xWLVb0W4Ns0K6tAosGNP5ra9VS4UxpnXhP
	 XpQhMDlqgKkWQ==
Date: Mon, 29 Jun 2026 13:35:20 -0700
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
Message-ID: <akLXCFpnum0WgXGf@google.com>
References: <20260623112533.1151502-1-vmalik@redhat.com>
 <DJGJ9F6WQZV9.2W4WBIHYLJQ97@gmail.com>
 <ajq98dm4gAwEzkMb@google.com>
 <c2f4e45e-d5c9-42e9-a46b-25fb0cacb267@redhat.com>
 <ajwu7xR6V6MAQOFw@google.com>
 <3c221e35-d642-4036-88fd-d25df7f8807e@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3c221e35-d642-4036-88fd-d25df7f8807e@redhat.com>

On Thu, Jun 25, 2026 at 02:05:29PM +0200, Viktor Malik wrote:
> On 6/24/26 21:24, Namhyung Kim wrote:
> > On Wed, Jun 24, 2026 at 08:47:38AM +0200, Viktor Malik wrote:
> >> On 6/23/26 19:10, Namhyung Kim wrote:
> >>> Hello,
> >>>
> >>> On Tue, Jun 23, 2026 at 08:27:39AM -0700, Alexei Starovoitov wrote:
> >>>> On Tue Jun 23, 2026 at 4:25 AM PDT, Viktor Malik wrote:
> > [SNIP]
> >>>>> +	struct args_loop_ctx loop_ctx = {
> >>>>> +		.args = args,
> >>>>> +		.beauty_map = beauty_map,
> >>>>> +		.payload_offset = payload_offset,
> >>>>> +		.value_size = value_size,
> >>>>> +		.output = &output,
> >>>>> +		.do_output = &do_output
> >>>>> +	};
> >>>>> +	iters = bpf_loop(6, process_arg_cb, &loop_ctx, 0);
> >>>>
> >>>> bpf_loop() is old and generally not recommended.
> >>>> Please use bpf_for() then the diff will be one line change and
> >>>> can scale to any number of args. Not just 6.
> >>
> >> Thanks Alexei, I didn't know about this preference.
> >>
> >>> One thing we should take care is to support old kernels.  The oldest
> >>> LTS kernel in the kernel.org is 5.10 and bpf_loop() was introduced in
> >>> 5.17 and bpf_for (bpf_iter_num) was 6.4.
> >>
> >> The problematic loop was introduced in 6.12 by a68fd6a6cdd3 ("perf
> >> trace: Collect augmented data using BPF") so we should be good using
> >> bpf_for. Or is perf from 7.2 supposed to work on 5.10 LTS kernels?
> > 
> > Yep, we'd like to support old kernels.
> 
> How much strict are you on this requirement? IMHO, the very least we
> need to fix the verifier issue is bpf_loop, so that would still not work
> on 5.10 and 5.15 LTS kernels.

I don't think it's an absolute requirement, but I think we don't want to
break any existing working setup (old kernel + old compiler).

> 
> We could probably keep the open-coded loop in case bpf_loop is not
> available but `perf trace` would still fail on kernels without bpf_loop
> for new perf built with Clang>=22. Also, the code would be a bit ugly
> and I'm not sure how well the feature check for helpers (bpf_loop) works
> on old kernels.
 
Any chance process_arg_cb() can be called directly in the regular for
loop on old kernels?

Thanks,
Namhyung

