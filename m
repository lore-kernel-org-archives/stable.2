Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECA530C164;
	Tue, 23 Jun 2026 17:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782234612; cv=none; b=rRMHQBXYbvPZPcMjeBd0ekCYmG/exBHVPmwRwchP/MghxvINTYSSEs5rJwymfOs9kS44UkTkTXIPyS425PeYeSctIEp/DmPJTLI2vxbM3OTO8F1b+147qlc4qYHnDYagP9g+tJoOChnDBffbFp4Qp2wC3JbyApg1P0zfqvg99O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782234612; c=relaxed/simple;
	bh=G2juHNm0MQSkesq1JQVu2orcc7IIrgmx+oXkd4LHWFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GX1HiVwNsOOPfcIiOMkUr8x7GmgzDSEMaSsnrztJQZfnFtZze19qHt18PWlYAjKy96Xqeaq/It3Ns8SLv3v30qj7CWtcK0zSO/MPeZ63SSGKSokC8yxvxamr6EWCZQpXS3NmBnVygTym7IhUTDdK2DnewP6DcMYNkxQ1O0Pb0sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ieednaGG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieednaGG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD771F000E9;
	Tue, 23 Jun 2026 17:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782234611;
	bh=WDvdzY1ErQFnk/RK+FkTuVAjD4osJ5TRcU6EtvGfSxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ieednaGGvYm2myJJqbDa4a12RAoxTEbph0h036DThaLkxKy8+88OP8D9jqmPrWkwM
	 01V+i/rkY+XNLsY5VStIr/7otCQcFVI8wNNFqnBepeqEso4vTP9l7Wa3PcSX0jKrHL
	 SEeOfdVL12UoCq6lSenY/0hy+7liT+WdYP/I3GClj3a5K3D+5KXKEmYTwOkDv311Az
	 vy5hch/wNQh5KNeZ7ZTFT2jCGOuJI8etMF3RKLnSBS1lZfbSorNno8uPE96Ju6rx/w
	 gmJp8+l5VLxeFyJU0dj5g9EINushzC+23dCws8Rrwr8nUQdW1kb9jzDrNqlYOX0GZg
	 +CujLJOl3V1/Q==
Date: Tue, 23 Jun 2026 10:10:09 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Viktor Malik <vmalik@redhat.com>, linux-perf-users@vger.kernel.org,
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
Message-ID: <ajq98dm4gAwEzkMb@google.com>
References: <20260623112533.1151502-1-vmalik@redhat.com>
 <DJGJ9F6WQZV9.2W4WBIHYLJQ97@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DJGJ9F6WQZV9.2W4WBIHYLJQ97@gmail.com>

Hello,

On Tue, Jun 23, 2026 at 08:27:39AM -0700, Alexei Starovoitov wrote:
> On Tue Jun 23, 2026 at 4:25 AM PDT, Viktor Malik wrote:
> > The loop for processing syscall args in augment_raw_syscalls has a
> > history of breaking with Clang updates, see e.g. commit 013eb043f37b
> > ("perf trace: Fix BPF loading failure (-E2BIG)") from Clang 15 to 16.
> >
> > Now, a similar thing happened between Clang 21 and 22. While the issue
> > is mitigated on the main line by a recent verifier update, it remains
> > broken on the 6.12 and 6.18 stable branches:
> >
> >     [linux-6.18.y]# sudo perf trace true
> >     libbpf: prog 'sys_enter': BPF program load failed: -E2BIG
> >     libbpf: prog 'sys_enter': -- BEGIN PROG LOAD LOG --
> >     [...]
> >     BPF program is too large. Processed 1000001 insn
> >     processed 1000001 insns (limit 1000000) max_states_per_insn 40 total_states 37941 peak_states 232 mark_read 0
> >     -- END PROG LOAD LOG --
> >     libbpf: prog 'sys_enter': failed to load: -E2BIG
> >     libbpf: failed to load object 'augmented_raw_syscalls_bpf'
> >     libbpf: failed to load BPF skeleton 'augmented_raw_syscalls_bpf': -E2BIG
> >     Error: failed to get syscall or beauty map fd
> >     [...]
> >
> > The reason is that the loop is quite complex and the BPF verifier often
> > struggles to prove that it terminates.
> >
> > Fix the issue by refactoring the loop body into a callback function and
> > calling the bpf_loop helper. This should prevent future breakages of
> > this kind since the callback function has no loops. It also allows to
> > drop a few artificial checks to help the verifier, including the changes
> > introduced by 013eb043f37b.

Thanks for working on this.  I encountered this issue before and never
found time to take a deeper look yet.

> >
> > Signed-off-by: Viktor Malik <vmalik@redhat.com>
> > Fixes: a68fd6a6cdd3 ("perf trace: Collect augmented data using BPF")
> > Fixes: 013eb043f37b ("perf trace: Fix BPF loading failure (-E2BIG)")
> > Cc: stable@vger.kernel.org
> > ---
> >  .../bpf_skel/augmented_raw_syscalls.bpf.c     | 157 +++++++++++-------
> >  1 file changed, 96 insertions(+), 61 deletions(-)
> >
> > diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > index 2a6e61864ee0..6d553ed3ac23 100644
> > --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > @@ -429,15 +429,96 @@ static bool pid_filter__has(struct pids_filtered *pids, pid_t pid)
> >  	return bpf_map_lookup_elem(pids, &pid) != NULL;
> >  }
> >  
> > +struct args_loop_ctx {
> > +	struct syscall_enter_args *args;
> > +	unsigned int *beauty_map;
> > +	void *payload_offset;
> > +	int value_size;
> > +	u64 *output;
> > +	bool *do_output;
> > +};
> > +
> > +static long process_arg_cb(u64 i, void *ctx)
> > +{
> > +	/*
> > +	 * Determine what type of argument and how many bytes to read from user space, using the
> > +	 * value in the beauty_map. This is the relation of parameter type and its corresponding
> > +	 * value in the beauty map, and how many bytes we read eventually:
> > +	 *
> > +	 * string: 1			      -> size of string
> > +	 * struct: size of struct	      -> size of struct
> > +	 * buffer: -1 * (index of paired len) -> value of paired len (maximum: TRACE_AUG_MAX_BUF)
> > +	 */
> > +	struct augmented_arg *augmented_arg;
> > +	struct args_loop_ctx *loop_ctx;
> > +	int aug_size, size, index;
> > +	bool augmented;
> > +	void *arg;
> > +
> > +	/* Bounds check for the below map access to help the verifier */
> > +	if (i < 0 || i >= 6)
> > +		return 1;
> > +
> > +	loop_ctx = (struct args_loop_ctx *)ctx;
> > +	arg = (void *)loop_ctx->args->args[i];
> > +	augmented = false;
> > +	size = loop_ctx->beauty_map[i];
> > +	aug_size = size; /* size of the augmented data read from user space */
> > +	augmented_arg = (struct augmented_arg *)loop_ctx->payload_offset;
> > +
> > +	if (size == 0 || arg == NULL)
> > +		return 0; /* continue */
> > +
> > +	if (size == 1) { /* string */
> > +		aug_size = bpf_probe_read_user_str(augmented_arg->value, loop_ctx->value_size, arg);
> > +		augmented = true;
> > +	} else if (size > 0 && size <= loop_ctx->value_size) { /* struct */
> > +		if (!bpf_probe_read_user(augmented_arg->value, size, arg))
> > +			augmented = true;
> > +	} else if (size < 0 && size >= -6) { /* buffer */
> > +		index = -(size + 1);
> > +		barrier_var(index); // Prevent clang (noticed with v18) from removing the &= 7 trick.
> > +		index &= 7;	    // Satisfy the bounds checking with the verifier in some kernels.
> > +		aug_size = loop_ctx->args->args[index];
> > +
> > +		if (aug_size > TRACE_AUG_MAX_BUF)
> > +			aug_size = TRACE_AUG_MAX_BUF;
> > +
> > +		if (aug_size > 0) {
> > +			if (!bpf_probe_read_user(augmented_arg->value, aug_size, arg))
> > +				augmented = true;
> > +		}
> > +	}
> > +
> > +	/* Augmented data size is limited to sizeof(augmented_arg->unnamed union with value field) */
> > +	if (aug_size > loop_ctx->value_size)
> > +		aug_size = loop_ctx->value_size;
> > +
> > +	/* write data to payload */
> > +	if (augmented) {
> > +		int written = offsetof(struct augmented_arg, value) + aug_size;
> > +
> > +		if (written < 0 || written > sizeof(struct augmented_arg))
> > +			return 1; /* break */
> > +
> > +		augmented_arg->size = aug_size;
> > +		*loop_ctx->output += written;
> > +		loop_ctx->payload_offset += written;
> > +		*loop_ctx->do_output = true;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
> >  {
> > -	bool augmented, do_output = false;
> > -	int zero = 0, index, value_size = sizeof(struct augmented_arg) - offsetof(struct augmented_arg, value);
> > +	bool do_output = false;
> > +	int zero = 0, value_size = sizeof(struct augmented_arg) - offsetof(struct augmented_arg, value);
> >  	u64 output = 0; /* has to be u64, otherwise it won't pass the verifier */
> > -	s64 aug_size, size;
> >  	unsigned int nr, *beauty_map;
> >  	struct beauty_payload_enter *payload;
> > -	void *arg, *payload_offset;
> > +	void *payload_offset;
> > +	long iters;
> >  
> >  	/* fall back to do predefined tail call */
> >  	if (args == NULL)
> > @@ -457,63 +538,17 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
> >  	/* copy the sys_enter header, which has the syscall_nr */
> >  	__builtin_memcpy(&payload->args, args, sizeof(struct syscall_enter_args));
> >  
> > -	/*
> > -	 * Determine what type of argument and how many bytes to read from user space, using the
> > -	 * value in the beauty_map. This is the relation of parameter type and its corresponding
> > -	 * value in the beauty map, and how many bytes we read eventually:
> > -	 *
> > -	 * string: 1			      -> size of string
> > -	 * struct: size of struct	      -> size of struct
> > -	 * buffer: -1 * (index of paired len) -> value of paired len (maximum: TRACE_AUG_MAX_BUF)
> > -	 */
> > -	for (int i = 0; i < 6; i++) {
> > -		arg = (void *)args->args[i];
> > -		augmented = false;
> > -		size = beauty_map[i];
> > -		aug_size = size; /* size of the augmented data read from user space */
> > -
> > -		if (size == 0 || arg == NULL)
> > -			continue;
> > -
> > -		if (size == 1) { /* string */
> > -			aug_size = bpf_probe_read_user_str(((struct augmented_arg *)payload_offset)->value, value_size, arg);
> > -			/* minimum of 0 to pass the verifier */
> > -			if (aug_size < 0)
> > -				aug_size = 0;
> > -
> > -			augmented = true;
> > -		} else if (size > 0 && size <= value_size) { /* struct */
> > -			if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->value, size, arg))
> > -				augmented = true;
> > -		} else if ((int)size < 0 && size >= -6) { /* buffer */
> > -			index = -(size + 1);
> > -			barrier_var(index); // Prevent clang (noticed with v18) from removing the &= 7 trick.
> > -			index &= 7;	    // Satisfy the bounds checking with the verifier in some kernels.
> > -			aug_size = args->args[index] > TRACE_AUG_MAX_BUF ? TRACE_AUG_MAX_BUF : args->args[index];
> > -
> > -			if (aug_size > 0) {
> > -				if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->value, aug_size, arg))
> > -					augmented = true;
> > -			}
> > -		}
> > -
> > -		/* Augmented data size is limited to sizeof(augmented_arg->unnamed union with value field) */
> > -		if (aug_size > value_size)
> > -			aug_size = value_size;
> > -
> > -		/* write data to payload */
> > -		if (augmented) {
> > -			int written = offsetof(struct augmented_arg, value) + aug_size;
> > -
> > -			if (written < 0 || written > sizeof(struct augmented_arg))
> > -				return 1;
> > -
> > -			((struct augmented_arg *)payload_offset)->size = aug_size;
> > -			output += written;
> > -			payload_offset += written;
> > -			do_output = true;
> > -		}
> > -	}
> > +	struct args_loop_ctx loop_ctx = {
> > +		.args = args,
> > +		.beauty_map = beauty_map,
> > +		.payload_offset = payload_offset,
> > +		.value_size = value_size,
> > +		.output = &output,
> > +		.do_output = &do_output
> > +	};
> > +	iters = bpf_loop(6, process_arg_cb, &loop_ctx, 0);
> 
> bpf_loop() is old and generally not recommended.
> Please use bpf_for() then the diff will be one line change and
> can scale to any number of args. Not just 6.
 
One thing we should take care is to support old kernels.  The oldest
LTS kernel in the kernel.org is 5.10 and bpf_loop() was introduced in
5.17 and bpf_for (bpf_iter_num) was 6.4.

Maybe we can factor out the loop body and call it from different
mechanisms like open-coded loop, bpf_loop or bpf_for depending on the
kernel version.  But not sure it'd fix the verifier issue though.

Thanks,
Namhyung

