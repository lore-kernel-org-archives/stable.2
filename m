Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3404532FA18;
	Tue, 29 Sep 2026 23:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790725038; cv=none; b=AM8yOkaBA6YA2p2tFDSjkcJ8o0sYhtESFEgCWTX3QbCfRpR4LbfUAW5rZehx4qqGqAE/y4p9dFdyWFHavy/cG7NXVReZBymqvzYn4wzidsfUn86u55Hk2C0pqVfAWJimcmth8ZGTybKY75dl1//XcN+FllPKGmOV3PBR4s9W7Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790725038; c=relaxed/simple;
	bh=uXvN0o/i49sd09BGH+OHO5km4+lh8+UVoNj8DyAMh2g=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=IV/LoAOU4Y7WSFCpmV4uHYt4T5csUNT5+WmD0M9o51KNjo67TD4hLBz4F43AutxWi0yhOHH6KfCSduCfQNTHJJApSZ6WFegKembplwcVLbq3rvqeKKuD29gXyq1+fC+IrfxOvbxVl2rT+NOPLM3HxjBWyTkauwTU09ktA0sxnok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5tMbgrk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5tMbgrk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA53B1F000FF;
	Tue, 29 Sep 2026 23:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790725036;
	bh=WHiYLve/r8dKdJur6CLdF1ljoKuGu9MvD9+c1UIePVY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=M5tMbgrkov2WEkxH+jdoYNwC5CHPdy7Zt3lqertwdfZbF/qqbbbpmEvIr2GgeQMl/
	 k1X6mb6cu+0cycJhbCZ+xCaA/MQ0l3UblRETJ9399UuLJ1POWo2dxyvoFc4cGGFQd+
	 R2yMBXQZyZF45DB1hXqD+u/P5UPOus5mVxEyFdvKFOkouW0UzTNDh9a5RL5NXyy0cC
	 /X9o+GxZEaNOsiKsga+hBawTLGcpXqm8mU45DFdDPS3mDafYy63Gd6gFEjOKZHgSOf
	 Ar6j0jcUIuNsmq4ymJrfExlkwtTc6dO4uat03Vo4h42GdSQ8WkayyJKq7NRU0xZs7d
	 XDtEYQVnYKuoA==
Content-Type: multipart/mixed; boundary="===============6591287826219115497=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d8aa770b82f03b9cbae1bc84c8505c32d451abde5fe4517a903f1311b940b0d6@mail.kernel.org>
In-Reply-To: <20260929014206.4175245-1-irogers@google.com>
References: <20260929014206.4175245-1-irogers@google.com>
Subject: Re: [PATCH v1] perf/core: Restore header fields in sideband output callbacks
From: bot+bpf-ci@kernel.org
To: irogers@google.com,peterz@infradead.org,mingo@redhat.com,acme@kernel.org,namhyung@kernel.org
Cc: mark.rutland@arm.com,alexander.shishkin@linux.intel.com,jolsa@kernel.org,irogers@google.com,adrian.hunter@intel.com,james.clark@linaro.org,song@kernel.org,ast@kernel.org,linux-perf-users@vger.kernel.org,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,stable@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 29 Sep 2026 23:37:15 +0000 (UTC)

--===============6591287826219115497==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index db7b76d6b68a..2be915a293ce 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -9032,6 +9032,11 @@ static void perf_iterate_sb_cpu(perf_iterate_f output, void *data)
>   *
>   * For new callers; ensure that account_pmu_sb_event() includes
>   * your event, otherwise it might not get delivered.
> + *
> + * Note: @data is shared across all @output calls, so any fields modified
> + * incrementally or conditionally (e.g. header.size via
> + * perf_event_header__init_id()) must be saved and restored by @output,
> + * or unconditionally re-initialized on each call.
>   */
>  static void
>  perf_iterate_sb(perf_iterate_f output, void *data,

Peter Zijlstra identified that perf_event_switch_output() also modifies
header.type and header.size before calling perf_event_header__init_id()
and suggested it might need similar treatment.

Looking at perf_event_switch_output():

    if (event->ctx->task) {
        se->event_id.header.type = PERF_RECORD_SWITCH;
        se->event_id.header.size = sizeof(se->event_id.header);
    } else {
        se->event_id.header.type = PERF_RECORD_SWITCH_CPU_WIDE;
        se->event_id.header.size = sizeof(se->event_id);
        ...
    }
    perf_event_header__init_id(&se->event_id.header, &sample, event);

The new comment mentions that fields must be "saved and restored by
@output, or unconditionally re-initialized on each call."
perf_event_switch_output() does unconditionally reinitialize both
header.type and header.size at the start of each callback invocation,
which should prevent the accumulation bug.

Is this analysis correct, or does perf_event_switch_output() need the
save/restore pattern as well?

> @@ -9726,6 +9731,7 @@ static void perf_event_mmap_output(struct perf_event *event,
>  	struct perf_sample_data sample;
>  	int size = mmap_event->event_id.header.size;
>  	u32 type = mmap_event->event_id.header.type;
> +	u16 misc = mmap_event->event_id.header.misc;
>  	bool use_build_id;
>  	int ret;
>

[ ... ]

> @@ -9783,6 +9789,7 @@ static void perf_event_mmap_output(struct perf_event *event,
>  out:
>  	mmap_event->event_id.header.size = size;
>  	mmap_event->event_id.header.type = type;
> +	mmap_event->event_id.header.misc = misc;
>  }

[ ... ]

> @@ -10247,6 +10254,7 @@ static void perf_event_ksymbol_output(struct perf_event *event, void *data)
>  	struct perf_ksymbol_event *ksymbol_event = data;
>  	struct perf_output_handle handle;
>  	struct perf_sample_data sample;
> +	u16 header_size = ksymbol_event->event_id.header.size;
>  	int ret;
>
>  	if (!perf_event_ksymbol_match(event))
> @@ -10257,13 +10265,15 @@ static void perf_event_ksymbol_output(struct perf_event *event, void *data)
>  	ret = perf_output_begin(&handle, &sample, event,
>  				ksymbol_event->event_id.header.size);
>  	if (ret)
> -		return;
> +		goto out;
>
>  	perf_output_put(&handle, ksymbol_event->event_id);
>  	__output_copy(&handle, ksymbol_event->name, ksymbol_event->name_len);
>  	perf_event__output_id_sample(event, &handle, &sample);
>
>  	perf_output_end(&handle);
> +out:
> +	ksymbol_event->event_id.header.size = header_size;
>  }

[ ... ]

> @@ -10337,6 +10347,7 @@ static void perf_event_bpf_output(struct perf_event *event, void *data)
>  	struct perf_bpf_event *bpf_event = data;
>  	struct perf_output_handle handle;
>  	struct perf_sample_data sample;
> +	u16 header_size = bpf_event->event_id.header.size;
>  	int ret;
>
>  	if (!perf_event_bpf_match(event))
> @@ -10347,12 +10358,14 @@ static void perf_event_bpf_output(struct perf_event *event, void *data)
>  	ret = perf_output_begin(&handle, &sample, event,
>  				bpf_event->event_id.header.size);
>  	if (ret)
> -		return;
> +		goto out;
>
>  	perf_output_put(&handle, bpf_event->event_id);
>  	perf_event__output_id_sample(event, &handle, &sample);
>
>  	perf_output_end(&handle);
> +out:
> +	bpf_event->event_id.header.size = header_size;
>  }

[ ... ]

> @@ -10499,6 +10512,7 @@ static void perf_event_text_poke_output(struct perf_event *event, void *data)
>  	struct perf_text_poke_event *text_poke_event = data;
>  	struct perf_output_handle handle;
>  	struct perf_sample_data sample;
> +	u16 header_size = text_poke_event->event_id.header.size;
>  	u64 padding = 0;
>  	int ret;
>
> @@ -10510,7 +10524,7 @@ static void perf_event_text_poke_output(struct perf_event *event, void *data)
>  	ret = perf_output_begin(&handle, &sample, event,
>  				text_poke_event->event_id.header.size);
>  	if (ret)
> -		return;
> +		goto out;
>
>  	perf_output_put(&handle, text_poke_event->event_id);
>  	perf_output_put(&handle, text_poke_event->old_len);
> @@ -10525,6 +10539,8 @@ static void perf_event_text_poke_output(struct perf_event *event, void *data)
>  	perf_event__output_id_sample(event, &handle, &sample);
>
>  	perf_output_end(&handle);
> +out:
> +	text_poke_event->event_id.header.size = header_size;
>  }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36643934404
--===============6591287826219115497==--
