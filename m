Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4F72D2394;
	Fri,  3 Jul 2026 23:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783122544; cv=none; b=OvGOhhTFO+V5QphWzA9ojKA/ljrqN+JlH/LUl7LjAA1kQW8aZouks6yf653L/gdeGDSEzueDw64+3ySwM0qjFiDmsNxpF/w3EXLLztMJ5DUnhb5CZL7UO+QI+wMt91DsvcvFhiIxFOAET3tA9MKHfPG97/QmUNliiCA7aJqOvC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783122544; c=relaxed/simple;
	bh=FNhmNMonWtD+W8/Jzn9Y18D9hUVR6pzPJ8SmKjHoVHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDUU+hdfpXO61UkbuGMX5+s3vayh5veMfAMiDNHMoxRG2i93x7fEjCWczWp3yVbEv6yyuTxgIBot0nsxHSzbz9gHy7GsfuzCdwkpHNEak6uWiSm7B5mcYMUwroVPpzBXsJxGcb2gTtxmoktTXbCDq7q1Hnj5TFoqAboz+hIXcKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0YQy/m2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0YQy/m2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 988191F000E9;
	Fri,  3 Jul 2026 23:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783122543;
	bh=bQPClUfw0fqGZZ6pcSXIeD1or1L5L5SDB1AG907rF4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E0YQy/m2twJlYvjAO4IZVvJKzHZIqeDeFIk6Pvj7fKVWexeHn/jEDOfzHN5ieCFc/
	 ZHxb+UTld2p5dGRJFNUlR2w/AOrRL91xPCcXXWeWrSK8n4qUBAZwzd9Bz5N7ii+Uu0
	 BX44g5wFdLD0+8sMJoAJ6eXpBeOh/NagO6KdrCKhYxTYu4q0wK8pfk/ujSd2GcCBxQ
	 tJlZVWfZEf7nGLf8Zj3RbHQYA2126s8Esc4IiP4LzkaqBXbqGIrLG2zii633DKpEMP
	 7bxxnJPKHqhsCVrXE9j1Zy4OErDYxrlnWcqMycqxC4wjF5H90thQgKLYp84oaFRJU2
	 pK+1pVy+AyBlA==
Date: Fri, 3 Jul 2026 16:49:00 -0700
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
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf trace: Factor out BPF loop body
Message-ID: <akhKbOtiracJKkBU@google.com>
References: <cover.1783070132.git.vmalik@redhat.com>
 <20fc67aa2550ca5aff52b3a9a207f2e07f8e0b1d.1783070132.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20fc67aa2550ca5aff52b3a9a207f2e07f8e0b1d.1783070132.git.vmalik@redhat.com>

Hello,

On Fri, Jul 03, 2026 at 12:32:14PM +0200, Viktor Malik wrote:
> The BPF program in augmented_raw_syscalls uses a for loop to iterate all
> syscall arguments. The loop body is quite complex and often poses
> problems for the BPF verifier. As a preparation step for addressing this
> issue, factor out the loop body into a separate function.
> 
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> Cc: stable@vger.kernel.org
> ---
>  .../bpf_skel/augmented_raw_syscalls.bpf.c     | 127 ++++++++++--------
>  1 file changed, 72 insertions(+), 55 deletions(-)
> 
> diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> index 2a6e61864ee0..cbdd5ce19a2f 100644
> --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> @@ -429,15 +429,79 @@ static bool pid_filter__has(struct pids_filtered *pids, pid_t pid)
>  	return bpf_map_lookup_elem(pids, &pid) != NULL;
>  }
>  
> +/*
> + * Determine what type of argument and how many bytes to read from user space, using the
> + * value in the beauty_map. This is the relation of parameter type and its corresponding
> + * value in the beauty map, and how many bytes we read eventually:
> + *
> + * string: 1			      -> size of string
> + * struct: size of struct	      -> size of struct
> + * buffer: -1 * (index of paired len) -> value of paired len (maximum: TRACE_AUG_MAX_BUF)
> + */
> +static inline int augment_arg(struct syscall_enter_args *args, int i,
> +			      unsigned int *beauty_map, void *payload_offset)

Can we make it 'struct augmented_arg *payload_offset' instead?

Thanks,
Namhyung


> +{
> +	int index, value_size = sizeof(struct augmented_arg) - offsetof(struct augmented_arg, value);
> +	s64 aug_size, size;
> +	bool augmented;
> +	void *arg;
> +
> +	arg = (void *)args->args[i];
> +	augmented = false;
> +	size = beauty_map[i];
> +	aug_size = size; /* size of the augmented data read from user space */
> +
> +	if (size == 0 || arg == NULL)
> +		return 0;
> +
> +	if (size == 1) { /* string */
> +		aug_size = bpf_probe_read_user_str(((struct augmented_arg *)payload_offset)->value, value_size, arg);
> +		/* minimum of 0 to pass the verifier */
> +		if (aug_size < 0)
> +			aug_size = 0;
> +
> +		augmented = true;
> +	} else if (size > 0 && size <= value_size) { /* struct */
> +		if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->value, size, arg))
> +			augmented = true;
> +	} else if ((int)size < 0 && size >= -6) { /* buffer */
> +		index = -(size + 1);
> +		barrier_var(index); // Prevent clang (noticed with v18) from removing the &= 7 trick.
> +		index &= 7;	    // Satisfy the bounds checking with the verifier in some kernels.
> +		aug_size = args->args[index] > TRACE_AUG_MAX_BUF ? TRACE_AUG_MAX_BUF : args->args[index];
> +
> +		if (aug_size > 0) {
> +			if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->value, aug_size, arg))
> +				augmented = true;
> +		}
> +	}
> +
> +	/* Augmented data size is limited to sizeof(augmented_arg->unnamed union with value field) */
> +	if (aug_size > value_size)
> +		aug_size = value_size;
> +
> +	/* write data to payload */
> +	if (augmented) {
> +		int written = offsetof(struct augmented_arg, value) + aug_size;
> +
> +		if (written < 0 || written > sizeof(struct augmented_arg))
> +			return -1;
> +
> +		((struct augmented_arg *)payload_offset)->size = aug_size;
> +		return written;
> +	}
> +
> +	return 0;
> +}
> +
>  static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
>  {
> -	bool augmented, do_output = false;
> -	int zero = 0, index, value_size = sizeof(struct augmented_arg) - offsetof(struct augmented_arg, value);
> +	bool do_output = false;
> +	int zero = 0, written;
>  	u64 output = 0; /* has to be u64, otherwise it won't pass the verifier */
> -	s64 aug_size, size;
>  	unsigned int nr, *beauty_map;
>  	struct beauty_payload_enter *payload;
> -	void *arg, *payload_offset;
> +	void *payload_offset;
>  
>  	/* fall back to do predefined tail call */
>  	if (args == NULL)
> @@ -457,58 +521,11 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
>  	/* copy the sys_enter header, which has the syscall_nr */
>  	__builtin_memcpy(&payload->args, args, sizeof(struct syscall_enter_args));
>  
> -	/*
> -	 * Determine what type of argument and how many bytes to read from user space, using the
> -	 * value in the beauty_map. This is the relation of parameter type and its corresponding
> -	 * value in the beauty map, and how many bytes we read eventually:
> -	 *
> -	 * string: 1			      -> size of string
> -	 * struct: size of struct	      -> size of struct
> -	 * buffer: -1 * (index of paired len) -> value of paired len (maximum: TRACE_AUG_MAX_BUF)
> -	 */
>  	for (int i = 0; i < 6; i++) {
> -		arg = (void *)args->args[i];
> -		augmented = false;
> -		size = beauty_map[i];
> -		aug_size = size; /* size of the augmented data read from user space */
> -
> -		if (size == 0 || arg == NULL)
> -			continue;
> -
> -		if (size == 1) { /* string */
> -			aug_size = bpf_probe_read_user_str(((struct augmented_arg *)payload_offset)->value, value_size, arg);
> -			/* minimum of 0 to pass the verifier */
> -			if (aug_size < 0)
> -				aug_size = 0;
> -
> -			augmented = true;
> -		} else if (size > 0 && size <= value_size) { /* struct */
> -			if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->value, size, arg))
> -				augmented = true;
> -		} else if ((int)size < 0 && size >= -6) { /* buffer */
> -			index = -(size + 1);
> -			barrier_var(index); // Prevent clang (noticed with v18) from removing the &= 7 trick.
> -			index &= 7;	    // Satisfy the bounds checking with the verifier in some kernels.
> -			aug_size = args->args[index] > TRACE_AUG_MAX_BUF ? TRACE_AUG_MAX_BUF : args->args[index];
> -
> -			if (aug_size > 0) {
> -				if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->value, aug_size, arg))
> -					augmented = true;
> -			}
> -		}
> -
> -		/* Augmented data size is limited to sizeof(augmented_arg->unnamed union with value field) */
> -		if (aug_size > value_size)
> -			aug_size = value_size;
> -
> -		/* write data to payload */
> -		if (augmented) {
> -			int written = offsetof(struct augmented_arg, value) + aug_size;
> -
> -			if (written < 0 || written > sizeof(struct augmented_arg))
> -				return 1;
> -
> -			((struct augmented_arg *)payload_offset)->size = aug_size;
> +		written = augment_arg(args, i, beauty_map, payload_offset);
> +		if (written < 0)
> +			return 1;
> +		if (written > 0) {
>  			output += written;
>  			payload_offset += written;
>  			do_output = true;
> -- 
> 2.54.0
> 
