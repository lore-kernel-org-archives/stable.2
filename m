Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C8F3D891D
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 15:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782228464; cv=none; b=epL+KnJPa0kpJ624kBaT5XRT6cOHukJCJuo34rPgt0ajlDm4bOU/Nfu0+MNhwKKZ+JshXebcMoWlE2240NnJmo15KHbH5sHZpHhfr90XmZIwjQ1n18PGAjLS2OaaC2VxmxyW59f6/j5QdtqyBDgQUEZAxlKX5v/l7FZbF8yGUDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782228464; c=relaxed/simple;
	bh=VGISIkuM6cBCm44W8mdczkbu3jpiPhtikc9p/vXJ+kA=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=oPa5lnqr7JbmYj1yVxCEX9rd72RAs0hQDbLO2VA2vCx/wMJZvh5Ntmt452zK2fnMg0ISsqCVxI+oNsb6FbsxCkZo0uvL+nWh57IdXLeKiknV5B7lRIVyj8eceRY33mDzXoKbiJpUfu98SYK2gwIBsvd/Jy6+TGOKMh6soGri8s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Drip6E7C; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Drip6E7C"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7e9483cd614so992341a34.1
        for <stable@vger.kernel.org>; Tue, 23 Jun 2026 08:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782228462; x=1782833262; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8OAvyMh4VrWL/Mmr/l/ESjGHF6/uUimT4xTLWLq23Fo=;
        b=Drip6E7CBTxqSlCUZzu8Y3P8qtvMmWNHCC6zAgK7JRlOq0zbsY27fvkRtxWa4wqoh6
         VnsHa5rX77gxD05KaRrze1yia2hZQZ26GonPeu8ALyDdStqVS+bE3pEc1obFbV81CKBk
         +5FVWARQwJk4zYD4xMqSqJdNDiFD4lVS8Fzh89Eel562AbG5oDg1aEW2+8GytRbTh3mj
         RDbYBlSY1uGp5U+iEcBuNQ4DsPB/PINSy+0N6PAAbDMHb8k8WncVliwSgsYovTAJ0uRr
         JErCDw3qZIBkek92EqRvV0BWuYspnsSi9x8hN1+duW0dajRaJtjBBEzf4euyliCpHmBB
         v8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782228462; x=1782833262;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8OAvyMh4VrWL/Mmr/l/ESjGHF6/uUimT4xTLWLq23Fo=;
        b=Mi4TVYs1uhTHLEH0qXIqtTi3KzZLGBJI2AOUX8k+N2SUkW9AGxRDOPSH741WPpc409
         ml0u3Pxj2PgQeUVdSyKWAUrwaQ6Emje2rwnJGMf6Xxi75WZmRcKxOr+mZRvd4uk9giT4
         Eud3SH234xk7m8UxcMlXoJjcMN8hzf4MsJZYbP4qqr3UVply7C2LTl7ZA6cRIFiSfHvj
         LNHL4G7DSUuKk9Z+o+kmXNFaIS3rNDuCTA8d4h/4rq3n6jSq+D1q0Rwb1iFkSHTTQX0U
         CcCCHbV72babN0f35mRzasU45iauOXGYYXOO6lHf4lfVe9WmpOCPke2hsp5J3D+k+n2B
         yqCg==
X-Forwarded-Encrypted: i=1; AFNElJ/NWXwTtMUOQaqagrThkn42OTf9h1txnu27twYl3A60LRPtgu9hQPjM+Db9rQuwH8sCPAw3NbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFgr4IbgXL5q7CDaNv9i7f0gUxzpCTaBEWtP97X+wpOKskb7nk
	JTCshtR/MmUapmdfHLxhnzq6/CtZdgZao/6TUA/cD6vLhr09Mcu9ecBd
X-Gm-Gg: AfdE7clcmXJJZxprUAy2+zW28j2MXY+H3t7JUDuOiDsnE+84N9OlzF85hA7al8Tfw2n
	kE4vI/wH5vHFQOAwOTcQ6E/qq64nRwhc3zOIDbFW6yGAjtSXMzOi5893oN9lqTFL87pqivIGsRk
	RI2oxPIwIww9iXe9Zce+8dLUhh2ftev+UeFzNxPaKl5nsM/5yFeCp7ywp4sa9F3dVBMi29CFzSK
	SJtU7UccRyfl21cY9nGPFsEHT/0ssp6oEImqFLLP4NSeECMjBZoNXp/gyeZDyYx+XUaz30LoYj+
	uTOGxSd0ed+KN91Ahe4t9NQOQIy35/BKV+HJVu6BOwlLMCu1H6KDgpg6Or1ieg+d8Qw4QIImyQX
	a0L82zKwuqLVulYy7DHMZquREUdK1sOuJwWmKtIEO1FBVCTrn5Xhrunc5hVQgqE+IiNSb5occ5r
	C/P0+IEg1THRuEBZje7/QoIXl+hjcFJn/SrdjyUiD602JmeEsBfDI0RhiFp8vHXKdNkJlvjvRgT
	IOK7A==
X-Received: by 2002:a05:6830:65cf:10b0:7d7:dead:e388 with SMTP id 46e09a7af769-7e9743556e5mr1877454a34.15.1782228461598;
        Tue, 23 Jun 2026 08:27:41 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:c::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9442e98c4sm8823777a34.26.2026.06.23.08.27.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 08:27:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jun 2026 08:27:39 -0700
Message-Id: <DJGJ9F6WQZV9.2W4WBIHYLJQ97@gmail.com>
To: "Viktor Malik" <vmalik@redhat.com>, <linux-perf-users@vger.kernel.org>
Cc: "Peter Zijlstra" <peterz@infradead.org>, "Ingo Molnar"
 <mingo@redhat.com>, "Arnaldo Carvalho de Melo" <acme@kernel.org>, "Namhyung
 Kim" <namhyung@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>,
 "Alexander Shishkin" <alexander.shishkin@linux.intel.com>, "Jiri Olsa"
 <jolsa@kernel.org>, "Ian Rogers" <irogers@google.com>, "Adrian Hunter"
 <adrian.hunter@intel.com>, "James Clark" <james.clark@linaro.org>, "Howard
 Chu" <howardchu95@gmail.com>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, "Michael Petlan" <mpetlan@redhat.com>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH] perf trace: Refactor augmented_raw_syscalls using
 bpf_loop
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc
References: <20260623112533.1151502-1-vmalik@redhat.com>
In-Reply-To: <20260623112533.1151502-1-vmalik@redhat.com>

On Tue Jun 23, 2026 at 4:25 AM PDT, Viktor Malik wrote:
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
>     processed 1000001 insns (limit 1000000) max_states_per_insn 40 total_=
states 37941 peak_states 232 mark_read 0
>     -- END PROG LOAD LOG --
>     libbpf: prog 'sys_enter': failed to load: -E2BIG
>     libbpf: failed to load object 'augmented_raw_syscalls_bpf'
>     libbpf: failed to load BPF skeleton 'augmented_raw_syscalls_bpf': -E2=
BIG
>     Error: failed to get syscall or beauty map fd
>     [...]
>
> The reason is that the loop is quite complex and the BPF verifier often
> struggles to prove that it terminates.
>
> Fix the issue by refactoring the loop body into a callback function and
> calling the bpf_loop helper. This should prevent future breakages of
> this kind since the callback function has no loops. It also allows to
> drop a few artificial checks to help the verifier, including the changes
> introduced by 013eb043f37b.
>
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> Fixes: a68fd6a6cdd3 ("perf trace: Collect augmented data using BPF")
> Fixes: 013eb043f37b ("perf trace: Fix BPF loading failure (-E2BIG)")
> Cc: stable@vger.kernel.org
> ---
>  .../bpf_skel/augmented_raw_syscalls.bpf.c     | 157 +++++++++++-------
>  1 file changed, 96 insertions(+), 61 deletions(-)
>
> diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tool=
s/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> index 2a6e61864ee0..6d553ed3ac23 100644
> --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> @@ -429,15 +429,96 @@ static bool pid_filter__has(struct pids_filtered *p=
ids, pid_t pid)
>  	return bpf_map_lookup_elem(pids, &pid) !=3D NULL;
>  }
> =20
> +struct args_loop_ctx {
> +	struct syscall_enter_args *args;
> +	unsigned int *beauty_map;
> +	void *payload_offset;
> +	int value_size;
> +	u64 *output;
> +	bool *do_output;
> +};
> +
> +static long process_arg_cb(u64 i, void *ctx)
> +{
> +	/*
> +	 * Determine what type of argument and how many bytes to read from user=
 space, using the
> +	 * value in the beauty_map. This is the relation of parameter type and =
its corresponding
> +	 * value in the beauty map, and how many bytes we read eventually:
> +	 *
> +	 * string: 1			      -> size of string
> +	 * struct: size of struct	      -> size of struct
> +	 * buffer: -1 * (index of paired len) -> value of paired len (maximum: =
TRACE_AUG_MAX_BUF)
> +	 */
> +	struct augmented_arg *augmented_arg;
> +	struct args_loop_ctx *loop_ctx;
> +	int aug_size, size, index;
> +	bool augmented;
> +	void *arg;
> +
> +	/* Bounds check for the below map access to help the verifier */
> +	if (i < 0 || i >=3D 6)
> +		return 1;
> +
> +	loop_ctx =3D (struct args_loop_ctx *)ctx;
> +	arg =3D (void *)loop_ctx->args->args[i];
> +	augmented =3D false;
> +	size =3D loop_ctx->beauty_map[i];
> +	aug_size =3D size; /* size of the augmented data read from user space *=
/
> +	augmented_arg =3D (struct augmented_arg *)loop_ctx->payload_offset;
> +
> +	if (size =3D=3D 0 || arg =3D=3D NULL)
> +		return 0; /* continue */
> +
> +	if (size =3D=3D 1) { /* string */
> +		aug_size =3D bpf_probe_read_user_str(augmented_arg->value, loop_ctx->v=
alue_size, arg);
> +		augmented =3D true;
> +	} else if (size > 0 && size <=3D loop_ctx->value_size) { /* struct */
> +		if (!bpf_probe_read_user(augmented_arg->value, size, arg))
> +			augmented =3D true;
> +	} else if (size < 0 && size >=3D -6) { /* buffer */
> +		index =3D -(size + 1);
> +		barrier_var(index); // Prevent clang (noticed with v18) from removing =
the &=3D 7 trick.
> +		index &=3D 7;	    // Satisfy the bounds checking with the verifier in =
some kernels.
> +		aug_size =3D loop_ctx->args->args[index];
> +
> +		if (aug_size > TRACE_AUG_MAX_BUF)
> +			aug_size =3D TRACE_AUG_MAX_BUF;
> +
> +		if (aug_size > 0) {
> +			if (!bpf_probe_read_user(augmented_arg->value, aug_size, arg))
> +				augmented =3D true;
> +		}
> +	}
> +
> +	/* Augmented data size is limited to sizeof(augmented_arg->unnamed unio=
n with value field) */
> +	if (aug_size > loop_ctx->value_size)
> +		aug_size =3D loop_ctx->value_size;
> +
> +	/* write data to payload */
> +	if (augmented) {
> +		int written =3D offsetof(struct augmented_arg, value) + aug_size;
> +
> +		if (written < 0 || written > sizeof(struct augmented_arg))
> +			return 1; /* break */
> +
> +		augmented_arg->size =3D aug_size;
> +		*loop_ctx->output +=3D written;
> +		loop_ctx->payload_offset +=3D written;
> +		*loop_ctx->do_output =3D true;
> +	}
> +
> +	return 0;
> +}
> +
>  static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
>  {
> -	bool augmented, do_output =3D false;
> -	int zero =3D 0, index, value_size =3D sizeof(struct augmented_arg) - of=
fsetof(struct augmented_arg, value);
> +	bool do_output =3D false;
> +	int zero =3D 0, value_size =3D sizeof(struct augmented_arg) - offsetof(=
struct augmented_arg, value);
>  	u64 output =3D 0; /* has to be u64, otherwise it won't pass the verifie=
r */
> -	s64 aug_size, size;
>  	unsigned int nr, *beauty_map;
>  	struct beauty_payload_enter *payload;
> -	void *arg, *payload_offset;
> +	void *payload_offset;
> +	long iters;
> =20
>  	/* fall back to do predefined tail call */
>  	if (args =3D=3D NULL)
> @@ -457,63 +538,17 @@ static int augment_sys_enter(void *ctx, struct sysc=
all_enter_args *args)
>  	/* copy the sys_enter header, which has the syscall_nr */
>  	__builtin_memcpy(&payload->args, args, sizeof(struct syscall_enter_args=
));
> =20
> -	/*
> -	 * Determine what type of argument and how many bytes to read from user=
 space, using the
> -	 * value in the beauty_map. This is the relation of parameter type and =
its corresponding
> -	 * value in the beauty map, and how many bytes we read eventually:
> -	 *
> -	 * string: 1			      -> size of string
> -	 * struct: size of struct	      -> size of struct
> -	 * buffer: -1 * (index of paired len) -> value of paired len (maximum: =
TRACE_AUG_MAX_BUF)
> -	 */
> -	for (int i =3D 0; i < 6; i++) {
> -		arg =3D (void *)args->args[i];
> -		augmented =3D false;
> -		size =3D beauty_map[i];
> -		aug_size =3D size; /* size of the augmented data read from user space =
*/
> -
> -		if (size =3D=3D 0 || arg =3D=3D NULL)
> -			continue;
> -
> -		if (size =3D=3D 1) { /* string */
> -			aug_size =3D bpf_probe_read_user_str(((struct augmented_arg *)payload=
_offset)->value, value_size, arg);
> -			/* minimum of 0 to pass the verifier */
> -			if (aug_size < 0)
> -				aug_size =3D 0;
> -
> -			augmented =3D true;
> -		} else if (size > 0 && size <=3D value_size) { /* struct */
> -			if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->va=
lue, size, arg))
> -				augmented =3D true;
> -		} else if ((int)size < 0 && size >=3D -6) { /* buffer */
> -			index =3D -(size + 1);
> -			barrier_var(index); // Prevent clang (noticed with v18) from removing=
 the &=3D 7 trick.
> -			index &=3D 7;	    // Satisfy the bounds checking with the verifier in=
 some kernels.
> -			aug_size =3D args->args[index] > TRACE_AUG_MAX_BUF ? TRACE_AUG_MAX_BU=
F : args->args[index];
> -
> -			if (aug_size > 0) {
> -				if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->v=
alue, aug_size, arg))
> -					augmented =3D true;
> -			}
> -		}
> -
> -		/* Augmented data size is limited to sizeof(augmented_arg->unnamed uni=
on with value field) */
> -		if (aug_size > value_size)
> -			aug_size =3D value_size;
> -
> -		/* write data to payload */
> -		if (augmented) {
> -			int written =3D offsetof(struct augmented_arg, value) + aug_size;
> -
> -			if (written < 0 || written > sizeof(struct augmented_arg))
> -				return 1;
> -
> -			((struct augmented_arg *)payload_offset)->size =3D aug_size;
> -			output +=3D written;
> -			payload_offset +=3D written;
> -			do_output =3D true;
> -		}
> -	}
> +	struct args_loop_ctx loop_ctx =3D {
> +		.args =3D args,
> +		.beauty_map =3D beauty_map,
> +		.payload_offset =3D payload_offset,
> +		.value_size =3D value_size,
> +		.output =3D &output,
> +		.do_output =3D &do_output
> +	};
> +	iters =3D bpf_loop(6, process_arg_cb, &loop_ctx, 0);

bpf_loop() is old and generally not recommended.
Please use bpf_for() then the diff will be one line change and
can scale to any number of args. Not just 6.

