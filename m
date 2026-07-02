Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074B954774;
	Thu,  2 Jul 2026 00:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782950436; cv=none; b=I9vy3ixNnN9pagDUK58ll2EmA6ooHLZUe8PzQ6DYuwfoaC+w3QtuNd9fLgiSbmT3gjmuaDVpf5bVNRQCOqwC2M0fFO+415CJpCL1f1gvh2C8Y1+/4xCwTamvsIitVnD+gK2zouoh6VQitGnsnZbWb86tl3PoG2c6mS9PVH9OvLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782950436; c=relaxed/simple;
	bh=49oNaBsWC1ibQFOVK2VcpZiHrR3tpRL6dBrdVrGD1bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TrCaClcx4CQQ0HIlsdxo81TeoaqZSshWFhzrZxKsuXPDMjjMFXq0zpZ73hP6VJDPkwPz4LfhMzto2z704j6JlLcz3NgPKIu4R6LN5wudMlMrTEcvxr4k2mMo3Q8M/TcQkYGf999o+d5qO3ayEcY2fqonakmEWqg1pGHi77KMDew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAGaEWdv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAGaEWdv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A291F000E9;
	Thu,  2 Jul 2026 00:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782950434;
	bh=4DxY+NveVlYpMYk9+8EzvprbIuiW7b27j/Q3O7UOpGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RAGaEWdvlnS9Lk1iGe3zDhYAk6CUI8rBdM1J/vFEMw1SLmdPLWnnT+uC42wd/nSmY
	 0YhlR50K/drAQqj7QRUqMrkVzEkLYFAbSXGbdgnphLlmWnUk/KmPi0/7wRs48jlxUF
	 gmmY3i5/gvTlNCpgHz9Buvpr6TZYOuU1wJyx3CXTVGLDeQKka/4OFN08+D+XCclhQo
	 HafrnBWIukbhH+vk85drrar6sNt+oCdG96JicMekQQFhj9zhteAMvXe3rBLy3MwIwC
	 dormm8qIrhHbCXV90PWTc0lPEdd07za8UzAP8qmMvD0offBS4IY1VXPH23bvU9ZOqM
	 qGhR+rDHKZSYw==
Date: Wed, 1 Jul 2026 17:00:33 -0700
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
Message-ID: <akWqIfWPMCdaGgGg@google.com>
References: <20260623112533.1151502-1-vmalik@redhat.com>
 <DJGJ9F6WQZV9.2W4WBIHYLJQ97@gmail.com>
 <ajq98dm4gAwEzkMb@google.com>
 <c2f4e45e-d5c9-42e9-a46b-25fb0cacb267@redhat.com>
 <ajwu7xR6V6MAQOFw@google.com>
 <3c221e35-d642-4036-88fd-d25df7f8807e@redhat.com>
 <akLXCFpnum0WgXGf@google.com>
 <c1666061-c3e7-4eda-82ca-d03daf05f4f8@redhat.com>
 <360bfd5c-b023-4952-9e24-53fcc26690d3@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <360bfd5c-b023-4952-9e24-53fcc26690d3@redhat.com>

On Wed, Jul 01, 2026 at 08:12:06AM +0200, Viktor Malik wrote:
> On 6/30/26 07:42, Viktor Malik wrote:
> > On 6/29/26 22:35, Namhyung Kim wrote:
> >> On Thu, Jun 25, 2026 at 02:05:29PM +0200, Viktor Malik wrote:
> >>> On 6/24/26 21:24, Namhyung Kim wrote:
> >>>> On Wed, Jun 24, 2026 at 08:47:38AM +0200, Viktor Malik wrote:
> >>>>> On 6/23/26 19:10, Namhyung Kim wrote:
> >>>>>> Hello,
> >>>>>>
> >>>>>> On Tue, Jun 23, 2026 at 08:27:39AM -0700, Alexei Starovoitov wrote:
> >>>>>>> On Tue Jun 23, 2026 at 4:25 AM PDT, Viktor Malik wrote:
> >>>> [SNIP]
> >>>>>>>> +	struct args_loop_ctx loop_ctx = {
> >>>>>>>> +		.args = args,
> >>>>>>>> +		.beauty_map = beauty_map,
> >>>>>>>> +		.payload_offset = payload_offset,
> >>>>>>>> +		.value_size = value_size,
> >>>>>>>> +		.output = &output,
> >>>>>>>> +		.do_output = &do_output
> >>>>>>>> +	};
> >>>>>>>> +	iters = bpf_loop(6, process_arg_cb, &loop_ctx, 0);
> >>>>>>>
> >>>>>>> bpf_loop() is old and generally not recommended.
> >>>>>>> Please use bpf_for() then the diff will be one line change and
> >>>>>>> can scale to any number of args. Not just 6.
> >>>>>
> >>>>> Thanks Alexei, I didn't know about this preference.
> >>>>>
> >>>>>> One thing we should take care is to support old kernels.  The oldest
> >>>>>> LTS kernel in the kernel.org is 5.10 and bpf_loop() was introduced in
> >>>>>> 5.17 and bpf_for (bpf_iter_num) was 6.4.
> >>>>>
> >>>>> The problematic loop was introduced in 6.12 by a68fd6a6cdd3 ("perf
> >>>>> trace: Collect augmented data using BPF") so we should be good using
> >>>>> bpf_for. Or is perf from 7.2 supposed to work on 5.10 LTS kernels?
> >>>>
> >>>> Yep, we'd like to support old kernels.
> >>>
> >>> How much strict are you on this requirement? IMHO, the very least we
> >>> need to fix the verifier issue is bpf_loop, so that would still not work
> >>> on 5.10 and 5.15 LTS kernels.
> >>
> >> I don't think it's an absolute requirement, but I think we don't want to
> >> break any existing working setup (old kernel + old compiler).
> >>
> >>>
> >>> We could probably keep the open-coded loop in case bpf_loop is not
> >>> available but `perf trace` would still fail on kernels without bpf_loop
> >>> for new perf built with Clang>=22. Also, the code would be a bit ugly
> >>> and I'm not sure how well the feature check for helpers (bpf_loop) works
> >>> on old kernels.
> >>  
> >> Any chance process_arg_cb() can be called directly in the regular for
> >> loop on old kernels?
> > 
> > That's my thinking, too. Should be pretty straightforward, I'm going to
> > give it a try in v2.
> 
> Btw, I just noticed that util/bpf_skel/lock_contention.bpf.c already
> uses bpf_loop without any fallback so newer perf (at least `perf lock`)
> won't be usable on kernels without bpf_loop anyways.
 
IIUC the lock contention tracepoints were added to v5.19 so it won't
work on old kernels anyway. :)

Thanks,
Namhyung

