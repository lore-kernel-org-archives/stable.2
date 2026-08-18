Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766B22472A6
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 20:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787086007; cv=none; b=DPmsQJ/gZnIc6p12WpCIEOsuAJEhDpJUxcSpQKVavtzBrYfQBiNySYTJ6sDMT1vTZtXxk8RTncBwVwCzl28aREDY8N11dzSM7lUsgXJiFi593QqzWpYUxpxZ9S/fb85Af0BeSTSuICNBmK0UM8qMgHIJunQJN6Iw4U1T0epyKOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787086007; c=relaxed/simple;
	bh=iJGjwOHPh4YuY9kr8w4+W1rM42dfPnAVwtGMdqR89RU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBjh6uwKWTRIKe/kWFFIsl6vHjC2hPBKld7su8mA4xpT2f3Mh48yNChlMfYugqO4l4e3vfGvkYdSaLOhG9v7kfTGvQ/LQGdvpcdnwpVCVxyAj28lY3qdPEKRT3MizQMKjPKjAtfjc/3DHuKv/V0TErpF9gdmdcPeh9V85I/UcYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBBOzQ94; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBBOzQ94"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47fe2d179e2so151432f8f.1
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 13:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787086004; x=1787690804; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jEoCjWMiQtD+w2HLXdKanKRDEQHtdfUfccyF+OQon+0=;
        b=OBBOzQ94Nm1PqSBOaqZdaefa9KtIHtxdPXyuXM53v7OCOOkgs1nxA80cphpJAdXZLD
         c08918IYiZlV4d/QTt29hA/ucSwRGTAPxCkTI5HwEy+TrVc6vkA927FACcP69NYEHhcs
         pVKrMp8bzL+8IzlkgqB2LokEZpTIpiYAfWsPirsoWvbzvg5UjeM2TgdV0v8o2xeeM/4o
         fCKLU/3vNpy0wGmIF5NfJL/qgcmHz7drLJlKCHJCqG08E5Jn+SrSdeNm4jcUXfi95+YS
         MwETgkwF5Fm7/gvnPtQjg3KLKGnYqWFwtdUQvnBX/TbKaoFT92tNfWZ0Ed9rx6WSZKNS
         W5KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787086004; x=1787690804;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jEoCjWMiQtD+w2HLXdKanKRDEQHtdfUfccyF+OQon+0=;
        b=kwlQkK1V5wLt1iypLOJFWJcSUbLsN8iiTEoa3ctDHMQUgjWdIsR+S2BQORvRM+U9JN
         RFh+RLI7Bs/yjAKoXCCM855s8vCTujwhqE5VlnlaXsuXxgDlkTqQUn61pItbePSeDK5J
         4Jq6MznsnuUkVCgoWW3RfA9yUJVBeUkxyAj64E/z4qhgesmV33lNoz+7RgLLmIsB1ko7
         ipgOQkcvFpElb5Ox7zTrovwdRpbPAmtj6hhN5EjycFsOKMQazfTjFshwkDPtsxVOnR0w
         prYM7zuDP4dgKsZiEmi3HOxIP7gWpqq1CX3yU+nBASEfP8sQGk1NPknjJ54qNhzAPYsP
         uCwg==
X-Forwarded-Encrypted: i=1; AHgh+RoRyPyDmt/zb3EuEwdDEpYGnM0mpLNvnZfK1ICFvv0Zx16ZjhpiOYuIP1gjLby5CkohvVI+UyU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1REf7FxwUaTQJk5/+4ul2vvmCdR4BSXtzQctCSUtovf7WQg97
	cJzXlnO4VFRQxYHvlkrPM6c3pCSrk+BzoBYpTz6rZX0yJe/wo5e7y95G
X-Gm-Gg: AR+sD13Jy74gB9MMjpxmul7ppF05ZeB6wPXBE0qAx8XD8zr4PkoVBLz4jOqUluPItdC
	4mZwBMw8UlprsCTIh0rOxeWwwGYJ1wUlbarMo8uPo5neiPDFovWud15uS3MBOFU/g31ygg0bmbp
	vGlWQKdEIr60rfF1nN8T+YNPmPQXznod0G+jpyqRTEJY1LDMeNDh9o8Af7FZONbYJdCzdhghC7s
	MOkW+BQBzQb1JQDlAKRvn84+KGUwdVtspD6FVC2QOZUJE+Snyf8t7WHIWkHpn4YxW3ntGoIaPSN
	goKrHYSaaVVBVv+biLKbzkng3WzcrX+gZ+B60/yb2nWz4Ja1D9lvK0WqSeYP5W3sLBM0fUEroHQ
	ADUM+qwe5ydcje4EoO4ckfggkw7AYIlJgzgigSILCJMrpXFGaWzJD9Iv+efiqHziCKLCCkYgFxI
	znHv5JAXp0ahHuWHDWXvPfgYtGqCW13DNEex4m2gWp2+wBUPp6wU7J8EiniEk7711+7HF97Hw=
X-Received: by 2002:a05:600c:6286:b0:499:7ce1:d8a2 with SMTP id 5b1f17b1804b1-499a8f8166fmr12816065e9.8.1787086003443;
        Tue, 18 Aug 2026 13:46:43 -0700 (PDT)
Received: from krava (37-188-219-233.red.o2.cz. [37.188.219.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a3b51asm14756971f8f.11.2026.08.18.13.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 13:46:42 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 18 Aug 2026 22:46:37 +0200
To: Christian Simon <simon@swine.de>, yonghong.song@linux.dev
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, martin.lau@kernel.org, tj@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH bpf] bpf: guard classic uprobes against private-stack
 corruption
Message-ID: <aoTErdLEwBbiJUHZ@krava>
References: <20260818095545.314358-1-simon@swine.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818095545.314358-1-simon@swine.de>

On Tue, Aug 18, 2026 at 10:55:39AM +0100, Christian Simon wrote:
> Eligible BPF programs use one private stack per program and CPU.
> bpf_prog_run_array_uprobe() uses migrate_disable() to keep an
> invocation on one CPU, but another task can still preempt it and run
> the same program on that CPU. The second invocation then reuses and
> can overwrite the first invocation's private stack.
> 
> Protect each real program invocation with the existing per-program
> recursion context. When the program is already active on this CPU,
> account for the missed invocation and skip it. This matches the
> private-stack protection in bpf_prog_run_array_sleepable().
> 
> Skip dummy_bpf_prog before acquiring the recursion context because its
> active pointer is NULL.
> 
> Fixes: 7d1cd70d4b16 ("bpf, x86: Support private stack in jit")
> Closes: https://github.com/open-telemetry/opentelemetry-ebpf-instrumentation/issues/3056
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Simon <simon@swine.de>
> ---
> 
> This is my first contribution to the BPF subsystem. I reproduced the
> failure described in the linked report and would particularly appreciate
> review of the recursion-context handling.
> 
> I have a reproducer, that this patch fixes, I am also unsure if this is
> something that should be part of the selftests.
> 
> Tests: https://github.com/simonswine/beyla/commit/20c9912a02c5d5924c992faf7ee353c7d71c9fa0 

would be great to have selftest for this if possible

> 
> 
> The analogous uprobe-multi path appears affected but is not addressed by
> this patch.

do you plan to fix uprobe_multi?

would be great to have fix for both together with the selftest ;-)

> 
> 
>  include/linux/bpf.h | 33 +++++++++++++++++++++++++--------
>  1 file changed, 25 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 7719f6528445..11e3d7f00543 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2572,12 +2572,20 @@ static inline void bpf_reset_run_ctx(struct bpf_run_ctx *old_ctx)
>  
>  typedef u32 (*bpf_prog_run_fn)(const struct bpf_prog *prog, const void *ctx);
>  
> +#ifdef CONFIG_BPF_SYSCALL
> +void notrace bpf_prog_inc_misses_counter(struct bpf_prog *prog);
> +#else
> +static inline void bpf_prog_inc_misses_counter(struct bpf_prog *prog)
> +{
> +}
> +#endif
> +
>  static __always_inline u32
>  bpf_prog_run_array(const struct bpf_prog_array *array,
>  		   const void *ctx, bpf_prog_run_fn run_prog)
>  {
>  	const struct bpf_prog_array_item *item;
> -	const struct bpf_prog *prog;
> +	struct bpf_prog *prog;
>  	struct bpf_run_ctx *old_run_ctx;
>  	struct bpf_trace_run_ctx run_ctx;
>  	u32 ret = 1;
> @@ -2635,15 +2643,30 @@ bpf_prog_run_array_uprobe(const struct bpf_prog_array *array,
>  	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
>  	item = &array->items[0];
>  	while ((prog = READ_ONCE(item->prog))) {
> +		/* dummy_bpf_prog has no recursion state. */
> +		if (unlikely(!prog->len)) {
> +			item++;
> +			continue;
> +		}
> +
> +		if (unlikely(!bpf_prog_get_recursion_context(prog))) {
> +			bpf_prog_inc_misses_counter(prog);
> +			bpf_prog_put_recursion_context(prog);

hum, we need uprobes reliable and IIUC this does not happen without
the uprobe using private stack

Yonghong, is it possible to add support to disable private stack for
program.. like maybe with some flag during the load?

thanks,
jirka


> +			item++;
> +			continue;
> +		}
> +
>  		if (!prog->sleepable)
>  			rcu_read_lock();
>  
>  		run_ctx.bpf_cookie = item->bpf_cookie;
>  		ret &= run_prog(prog, ctx);
> -		item++;
>  
>  		if (!prog->sleepable)
>  			rcu_read_unlock();
> +
> +		bpf_prog_put_recursion_context(prog);
> +		item++;
>  	}
>  	bpf_reset_run_ctx(old_run_ctx);
>  	migrate_enable();
> @@ -3208,8 +3231,6 @@ static inline bool has_current_bpf_ctx(void)
>  	return !!current->bpf_ctx;
>  }
>  
> -void notrace bpf_prog_inc_misses_counter(struct bpf_prog *prog);
> -
>  void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data,
>  		     enum bpf_dynptr_type type, u32 offset, u32 size);
>  void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr);
> @@ -3538,10 +3559,6 @@ static inline bool has_current_bpf_ctx(void)
>  	return false;
>  }
>  
> -static inline void bpf_prog_inc_misses_counter(struct bpf_prog *prog)
> -{
> -}
> -
>  static inline void bpf_cgrp_storage_free(struct cgroup *cgroup)
>  {
>  }
> -- 
> 2.54.0
> 
> 
