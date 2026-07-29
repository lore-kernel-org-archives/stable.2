Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA7D48CD41
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785331778; cv=none; b=nQHO/BH39OVVq4SwdNrxsCDhy2vcD6D97UWJJ7Ug8i4iYV88tqvmF5TyfHcFPOZOadBg8WAZCAkHZEb9Qo5goW9LijVPPcfJxPYtb+HoRnL+e9wdsNE7U+bNxwLLAira6sjS09QBJS9y5egn05e3+avrVoSCYm4692KYxDkOIfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785331778; c=relaxed/simple;
	bh=PHt+aRmkFWbvB8uR6W5QXVfMRltRQJ9Is6QfG2qzQ2A=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQvWgV3pAEZ1J/yfblRN5qtJSTTQVCyBLM9L4MeLxS56OlGaZH/c6hTAYV4XMWHLz5dVePHm4LGRudDB+xXSl9aqh225OonSyiQUZzbHoU/38jokDqhKhb1F8iLl1JWS3hemprkVJF8w2C0BjDKQzkhXSyP1B+q0uhsXrOHXxP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHnG/e1q; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHnG/e1q"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4954d29264cso4410885e9.2
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 06:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785331773; x=1785936573; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DK37VB3qMOhbD5yb9Im3WBPoq9gsNNuMseW5SbMeCGk=;
        b=LHnG/e1qy+rsALO7v0Ccj8HwqpildvCNBXCZr1nm2WojnRGD67GKCIVpoFWPtVl7jq
         xVN73dmX/fwjmjx6ekQEDm2betmAOuV/QxiXhFz/Kz+X5YW8N4j0fuVxxNbEPBq9UZZj
         wpn9f7dTv+3HqWnT/VkDAWkMg7DyXujnsPkVO3UbWcQEkQCV6pnyA4ToGCd5ILZngKz7
         UlZR4lfFTjKNayXfrzsbduZYnZ1cPdWfDDMZlGyr4FH4HJcrgzBPFnWJnFiwj6TkCqax
         bhqsoh5HV2QigIOzBX0HT9LyxKjoeUv3rQVB24RrVXSv3ELzHlNtDvvqyFmNrhWiohUS
         Pe2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785331773; x=1785936573;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DK37VB3qMOhbD5yb9Im3WBPoq9gsNNuMseW5SbMeCGk=;
        b=cPtKIU1I2MeQsc0STOe2D4FmkoTWlVtwXhhZKytetuWIDFIzMB+b7dxc1BRwZEa0T7
         j1/k2HJEYr5zjv8TgsfUTjWyhK0z7VpC6BRdufDfqlXtFzpjYymN+xQwzA9PaWIKejL/
         GT4d4xYqpNKpWH9RsRLsisQH4mWdlAkknB2uDb5YuDht7tSVRkp1DvjiX1H21xjzxD94
         iVePb59nIFM5TNPfT+FeEMbhihPj8HU0mtzfVuIXCFgMwDmCRbTgshh4grsLL+7Ye6Pw
         rqVXuMr0jaPwuJj9Bkvu1V9VBsEVs/8UvY62v/CNa8vejBjuGjRXxDaiKYIlBDWQfnNf
         bIgA==
X-Forwarded-Encrypted: i=1; AHgh+Rph8zbjQbqfn3Ga28agtLEukXx0Vrd4GBknh8euc20FuMNIjdx0EKAl7q++1XOCBNdCtCnRdhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW7QolkZsGQ/6jMnuM1x/jOl6NcqAGCA12ebCQVCvc1PCepUIi
	nPI23NS0TgqOGx4GCoVCpf3VMY6FeqTsds4YWMCARdR4OaT5UYB9kRuL
X-Gm-Gg: AR+sD11RdciUqmOS2Q9yGZmetORcFxut0SziVe56Sb17ln5Z+2F/+uCPwEdF2VQ0Xaf
	8KfkKO7KcLlp4KNNfvJz6nflpvFs1B8aL5M8yUnZUIe5Zs5VUhC8FsKZLCw3IUmEg7B6BTreGb2
	JkKYf1wii7rKQYxZta4PbzqPElfKkov4XwD/9zspMu7ui08MLZCQ2YlJhc47IqUnPnP6e15HnBi
	swe+d5w3ezfCGepxUG+TNthPcYejfDcZYQF6xUhfgBBryMCJ7cDQNc+gJHInnW5LWCkYepWOghH
	FYqT+FgKmLhL0Z9upeu9aJToN04wWgXHH8YXbtPFRnp+tqMzU4V6fpt/rc5PdbV1l04WHX9M93f
	aMHpYjTeYkSIXoGBbztYNrIgupNPr0jU9KQLKve2EwrXoRU7nTkAod2pptI8VaoYkHXzGbXArLO
	cj7AHgY6dHgrn9NH9daOYFH38a1n5NwSUXzw==
X-Received: by 2002:a05:600c:b85:b0:495:6934:414c with SMTP id 5b1f17b1804b1-496c656e6d8mr85293065e9.19.1785331772970;
        Wed, 29 Jul 2026 06:29:32 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::dd7e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496c4615681sm158139025e9.11.2026.07.29.06.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 06:29:32 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 29 Jul 2026 15:29:30 +0200
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, song@kernel.org,
	rostedt@goodmis.org, naveen@kernel.org, davem@davemloft.net,
	mhiramat@kernel.org, stable@vger.kernel.org,
	linux-open-source@crowdstrike.com
Subject: Re: [RFC PATCH bpf-next 1/3] bpf: mark trampoline ftrace_ops
 permanent
Message-ID: <amoAOqd0MdO04bM5@krava>
References: <20260729005959.3853865-1-andrey.grodzovsky@crowdstrike.com>
 <20260729005959.3853865-2-andrey.grodzovsky@crowdstrike.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729005959.3853865-2-andrey.grodzovsky@crowdstrike.com>

On Tue, Jul 28, 2026 at 08:59:57PM -0400, Andrey Grodzovsky wrote:
> kernel.ftrace_enabled=0 silently kills BPF trampolines (fentry/fexit):
> attach still succeeds, the hook stops firing with no error, and
> re-enabling silently restores it with no indication anything happened.
> 
> This is a regression, not a new gap: BPF trampolines were already
> protected against this the same way livepatch protects itself, via
> FTRACE_OPS_FL_PERMANENT on the shared trampoline ftrace_ops. That
> protection was silently dropped during a later refactoring and never
> restored, so this has been broken for years.
> 
> Both the shared direct_ops (CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS
> arches) and the per-trampoline ops allocated on other arches (arm64,
> s390) are BPF-trampoline-private, not shared with any unrelated
> subsystem, so restoring the same unconditional flag is safe and needs
> no kernel/trace/ftrace.c changes -- its existing generic sysctl gate
> and attach-time refusal already scan the ops list and pick this up
> for free.
> 
> Fixes: 00963a2e75a8 ("bpf: Support bpf_trampoline on functions with IPMODIFY (e.g. livepatch)")

hum, we did use it before this commit, I completely missed that, thanks

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka


> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-sonnet-5
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>

> ---
>  kernel/bpf/trampoline.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 129d07db117e..3d5069091db7 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -224,6 +224,8 @@ void bpf_image_ksym_del(struct bpf_ksym *ksym)
>   */
>  struct ftrace_ops direct_ops = {
>  	.ops_func = bpf_tramp_ftrace_ops_func,
> +	/* Same protection livepatch gives its own ftrace_ops. */
> +	.flags = FTRACE_OPS_FL_PERMANENT,
>  };
>  
>  static int direct_ops_alloc(struct bpf_trampoline *tr)
> @@ -303,6 +305,8 @@ static int direct_ops_alloc(struct bpf_trampoline *tr)
>  		return -ENOMEM;
>  	tr->fops->private = tr;
>  	tr->fops->ops_func = bpf_tramp_ftrace_ops_func;
> +	/* See the direct_ops initializer above for why. */
> +	tr->fops->flags |= FTRACE_OPS_FL_PERMANENT;
>  	return 0;
>  }
>  
> -- 
> 2.34.1
> 
