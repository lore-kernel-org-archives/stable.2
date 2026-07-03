Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0091A2010EE;
	Fri,  3 Jul 2026 23:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783122638; cv=none; b=h0RY4ccHgvGUCWazhYTN/R5mw9n9ZeWVWdJ4krdFRAbV7oI/GT++ZsBSteQzgEs/t4N7iaReaYvg353bXfP3rTkH7dRGWAMmqI3dYMj/LO++XCuI2gNPprsPAqw4aHo7824qxgOmlpDAa6gyKdPVZfheYoVB8Jo3bGuvf1ZFHXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783122638; c=relaxed/simple;
	bh=TkrybskFUGZtsmgALZurdtMV3PqjIfExbobqQcjITl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKa4wXVBTcug/XfmDvLDUA1NQn73dTnOKhkQADva7iHlaUfT0ygjolJBZjZdf3+SjC1Zf20ixKs8HZPUbJ5ZRtU2XMW3GFQLRVMwbiD4ZIvN/T88zrSrhV0COAT32C/nhQLB1R1iohU5ZfWBVoGgWg4BFWeevQO+xEmNP7z6PQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UvJbNs0G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvJbNs0G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04CC11F000E9;
	Fri,  3 Jul 2026 23:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783122636;
	bh=uDBBLHYlQ9eH7ydUzqsOntLmjeZd3Y1X/yPy0uGQUF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UvJbNs0Gulm9BiLJ7LyKPuP1gTWzPJWzXdypK74e9Sn/k8ItkNVd3ijUWaat73wGG
	 ASWWMFzcWomZAp9l6lS49gXa/ap79YgY8u14v6PbP2uvHqZS7Xaz1D2FlvkUoLYzOD
	 zvUNhhsJ4shL1wWpIipW/kba93iaDbX+/rIVYogSf3s0WryYN1PYp1QZs7D7QCXKv3
	 nSmynATyynyPdKyKhinmJuyDvl2iYT8IW16dNyruikQjISHWmZKMDm3LFYRJOCVeG0
	 VkIwdqzdq0aIyGfDnPMXO3etzkg71Ki3vmixF/vsb8ocrlma44TxgYMCLTqxVYLfw/
	 SLNruwP+MjyJw==
Date: Fri, 3 Jul 2026 16:50:34 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Viktor Malik <vmalik@redhat.com>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, Michael Petlan <mpetlan@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] perf trace: Refactor augmented_raw_syscalls using
 bpf_for
Message-ID: <akhKyjlsSg82XN2Z@google.com>
References: <cover.1783070132.git.vmalik@redhat.com>
 <8ceb8f3323d0742163c42c343eb9d26843fe9e9b.1783070132.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8ceb8f3323d0742163c42c343eb9d26843fe9e9b.1783070132.git.vmalik@redhat.com>

On Fri, Jul 03, 2026 at 12:32:15PM +0200, Viktor Malik wrote:
> The loop for processing syscall args in augment_raw_syscalls has a
> history of breaking with Clang updates, see e.g. commit 013eb043f37b
> ("perf trace: Fix BPF loading failure (-E2BIG)") from Clang 15 to 16.
> 
> Now, a similar thing happened between Clang 21 and 22. While the issue
> is mitigated on the main line by a recent verifier update, it remains
> broken on the 6.12 and 6.18 stable branches:
> 
>     [linux-6.18.y]# sudo perf trace true
>     libbpf: prog 'sys_enter': BPF program load failed: -E2BIG
>     libbpf: prog 'sys_enter': -- BEGIN PROG LOAD LOG --
>     [...]
>     BPF program is too large. Processed 1000001 insn
>     processed 1000001 insns (limit 1000000) max_states_per_insn 40 total_states 37941 peak_states 232 mark_read 0
>     -- END PROG LOAD LOG --
>     libbpf: prog 'sys_enter': failed to load: -E2BIG
>     libbpf: failed to load object 'augmented_raw_syscalls_bpf'
>     libbpf: failed to load BPF skeleton 'augmented_raw_syscalls_bpf': -E2BIG
>     Error: failed to get syscall or beauty map fd
>     [...]
> 
> The reason is that the loop is quite complex and the BPF verifier often
> struggles to prove that it terminates.
> 
> Fix the issue by replacing the standard for loop by the bpf_for macro,
> which uses numeric BPF iterator. This should prevent future breakages of
> this kind since the verifier has much easier job proving that the loop
> terminates.
> 
> Small adjustments were necessary for the loop to make it work.  The main
> problem is that the verifier has sometimes problems with bpf_for loops
> that use a carry-over state, such as the `payload_offset` and `output`
> vars here, since the verifier tries to track their values too precisely
> and cannot prove loop convergence. To resolve the issue, we (1)
> explicitly recompute `payload_offset` in every iteration and (2) use a
> trick with adding a global zero to `output` to help verifier forget its
> precise state and use a range instead.
> 
> In exchange, this also allows to drop a few artificial checks to help
> the verifier, including the changes introduced by 013eb043f37b.
> 
> Finally, to keep backwards compatibility with older kernel versions
> which do not have bpf_for (i.e. numeric iterators), fall back to
> standard for loop in such a case.
> 
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Fixes: a68fd6a6cdd3 ("perf trace: Collect augmented data using BPF")
> Fixes: 013eb043f37b ("perf trace: Fix BPF loading failure (-E2BIG)")
> Cc: stable@vger.kernel.org
> ---
>  .../bpf_skel/augmented_raw_syscalls.bpf.c     | 54 +++++++++++++------
>  1 file changed, 39 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> index cbdd5ce19a2f..60babc06f381 100644
> --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> @@ -429,6 +429,8 @@ static bool pid_filter__has(struct pids_filtered *pids, pid_t pid)
>  	return bpf_map_lookup_elem(pids, &pid) != NULL;
>  }
>  
> +u64 ZERO = 0;
> +
>  /*
>   * Determine what type of argument and how many bytes to read from user space, using the
>   * value in the beauty_map. This is the relation of parameter type and its corresponding
> @@ -439,12 +441,13 @@ static bool pid_filter__has(struct pids_filtered *pids, pid_t pid)
>   * buffer: -1 * (index of paired len) -> value of paired len (maximum: TRACE_AUG_MAX_BUF)
>   */
>  static inline int augment_arg(struct syscall_enter_args *args, int i,
> -			      unsigned int *beauty_map, void *payload_offset)
> +			      unsigned int *beauty_map,
> +			      struct beauty_payload_enter *payload, u64 offset)
>  {
>  	int index, value_size = sizeof(struct augmented_arg) - offsetof(struct augmented_arg, value);
>  	s64 aug_size, size;
>  	bool augmented;
> -	void *arg;
> +	void *arg, *payload_offset;
>  
>  	arg = (void *)args->args[i];
>  	augmented = false;
> @@ -454,6 +457,12 @@ static inline int augment_arg(struct syscall_enter_args *args, int i,
>  	if (size == 0 || arg == NULL)
>  		return 0;
>  
> +	/* bounds check for the verifier */
> +	if (offset > sizeof(payload->aug_args) - sizeof(payload->aug_args[0]))
> +		return -1;
> +	barrier_var(offset);
> +	payload_offset = (void *)&payload->aug_args + offset;
> +
>  	if (size == 1) { /* string */
>  		aug_size = bpf_probe_read_user_str(((struct augmented_arg *)payload_offset)->value, value_size, arg);
>  		/* minimum of 0 to pass the verifier */
> @@ -464,11 +473,13 @@ static inline int augment_arg(struct syscall_enter_args *args, int i,
>  	} else if (size > 0 && size <= value_size) { /* struct */
>  		if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->value, size, arg))
>  			augmented = true;
> -	} else if ((int)size < 0 && size >= -6) { /* buffer */
> +	} else if (size < 0 && size >= -6) { /* buffer */
>  		index = -(size + 1);
>  		barrier_var(index); // Prevent clang (noticed with v18) from removing the &= 7 trick.
>  		index &= 7;	    // Satisfy the bounds checking with the verifier in some kernels.
> -		aug_size = args->args[index] > TRACE_AUG_MAX_BUF ? TRACE_AUG_MAX_BUF : args->args[index];
> +		aug_size = args->args[index];
> +		if (aug_size > TRACE_AUG_MAX_BUF)
> +			aug_size = TRACE_AUG_MAX_BUF;
>  
>  		if (aug_size > 0) {
>  			if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->value, aug_size, arg))
> @@ -497,11 +508,10 @@ static inline int augment_arg(struct syscall_enter_args *args, int i,
>  static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
>  {
>  	bool do_output = false;
> -	int zero = 0, written;
> +	int i, zero = 0, written;
>  	u64 output = 0; /* has to be u64, otherwise it won't pass the verifier */
>  	unsigned int nr, *beauty_map;
>  	struct beauty_payload_enter *payload;
> -	void *payload_offset;
>  
>  	/* fall back to do predefined tail call */
>  	if (args == NULL)
> @@ -513,7 +523,6 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
>  
>  	/* set up payload for output */
>  	payload        = bpf_map_lookup_elem(&beauty_payload_enter_map, &zero);
> -	payload_offset = (void *)&payload->aug_args;
>  
>  	if (beauty_map == NULL || payload == NULL)
>  		return 1;
> @@ -521,14 +530,29 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
>  	/* copy the sys_enter header, which has the syscall_nr */
>  	__builtin_memcpy(&payload->args, args, sizeof(struct syscall_enter_args));
>  
> -	for (int i = 0; i < 6; i++) {
> -		written = augment_arg(args, i, beauty_map, payload_offset);
> -		if (written < 0)
> -			return 1;
> -		if (written > 0) {
> -			output += written;
> -			payload_offset += written;
> -			do_output = true;
> +	if (bpf_ksym_exists(bpf_iter_num_new)) {
> +		bpf_for(i, 0, 6) {
> +			written = augment_arg(args, i, beauty_map, payload, output);
> +			if (written < 0)
> +				return 1;
> +			if (written > 0) {
> +				output += written;
> +				/* guide the verifier to forget range of `output`, which
> +				 * helps to prove convergence of the loop
> +				 */
> +				output += ZERO;
> +				do_output = true;
> +			}
> +		}
> +	} else {
> +		for (i = 0; i < 6; i++) {
> +			written = augment_arg(args, i, beauty_map, payload, output);
> +			if (written < 0)
> +				return 1;
> +			if (written > 0) {
> +				output += written;

Woundn't it also need '+= ZERO' here?

Thanks,
Namhyung


> +				do_output = true;
> +			}
>  		}
>  	}
>  
> -- 
> 2.54.0
> 
