Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792743497;
	b=Co9JIrRV+JeCxG5ViYsBffdi8w3tQ/waMjNnZlzrjf3W0Ft/aXdPiTDFAvgAj8Qo6jib
	 1+BRWiVEu0so0COa1DlZBLsmMfOd30/l/Yppgg/C3cb/SX9E3ay8ohMgEk+Na249CxFiZ
	 eQstxbqtOYbf/TSizo4fPMXQnunMci7GlLWkOMibkYCZYbTenBiS7EtHLrI0hJa/pYHwf
	 VL6/aJVI9CTBGm4xsqkKkG6ZIhVmzcGPsVRn2qVNiydz6QsVohyO1QWX87ZGDVxvF6+FB
	 Onk+yYU1A6FouUOSzPDu5JC2doNm6iim/hBItUBLlF17+eqh1CaB4aMuyQ+uOGPZ9rA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792743497;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=5oVeJI18w0YWnW1MyEvLa+/8268RVOyYzuorpmt19/c=;
	b=oS1YdeOzHaRU6TIwG9vC7okBTvg8haKIbsvsYo/F+f8uYooRfc0mvl2zQ/ZwDtuh9hns
	 j55AWOQweWrfUHb9yC3Wl2Wt7a2esaJ0OTU9u+fOvXbIz4DmLFQnXRKw8VZdvJrtZcSIG
	 exNFjjagoJ99ESImUzC2sjq9dUeXCz1bPlQNRYv2R5X5zlVrbx8W6+kOV9O4bhKPE6K6Y
	 +SSmkhvWI/6ewmTXmq563RMb6rsag8rCaXYj5Xo8ggyj96S550rH/o3Q1ILppMhgvhbiD
	 LyqhAlKuhRvG1aIAc44XvGdX+xbk/cWNclR2bWvNlK4HQeF4JoURSHj7cenG3hpwiUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=EioUjT0Y;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4884F606A328
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 08:18:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4884F606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=EioUjT0Y
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so2635335e9.3
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 01:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792743496; x=1793348296; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5oVeJI18w0YWnW1MyEvLa+/8268RVOyYzuorpmt19/c=;
        b=EioUjT0Yqv1EF4pWajYbSIY49dvGUSf8SN5pfXf9T1v4+nNBoQo6FvRdo8HiXaHxsU
         Xl0iI5NK+jH63hwp4kCo4v4AKB1iGFLoOUTHMtauv26oPjEzkHgDHtS9+xeINe3DBFh9
         TaDSYlDW5NYasgcRLYjWZ8JmcOBSG1/aaXVLocU8W+aas0RWuRZJWlcMe/XpjxUz5cHU
         JQVrt1L/3ihp4i2Jk0PI8kMWcb3XvNkNWY0ylNI+UilCqVZSOhUPNWOJTIJHXC/eEVmO
         Xp9evZa63AseEMg8ILEthoP3PlJJruSkFRClIOpuuEb4W/qkulJz9Vx91jaLqVxP4LU9
         Rkbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792743496; x=1793348296;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5oVeJI18w0YWnW1MyEvLa+/8268RVOyYzuorpmt19/c=;
        b=wMS0W2AagO8/v4zjF5LVBAdanpAZasWukPTy6veaZJ1cM9EU93mqSwbAyIh4r75eeK
         HkGPvWnHSaABijnHTuHy3ZFpWOeMSNooJUEtpWE9n4Ex84oidJZUmBJz/Ggz4U6cul35
         rLryCq2EK8KvZMy7gxN5RxXlbSiYWxVPhORWOIPsLyLTiQpLGKKtX0+XKmlbvYw0vQFw
         p0vH58Ip40khednMKWZM84WMUcmMzf2F25fA90edL+K6xeHOQW/6uEWF6C6JYTSf2Cr9
         Gd3jWOcKe2e5rAJqC0YX52wn3hpfCE1fi7aA8l+sJqUt5Byeh5OJdjUhWvHamnKzjbAZ
         KoIw==
X-Forwarded-Encrypted: i=1; AKwUvBzLYl80YZjC7HnXzFCYCmI7I4zFn1GPw+cdS2Cs/89cpUTVY0YfJKXY3muOMpQoIulxgbT/A4w=@vger.kernel.org
X-Gm-Message-State: AFq9FYLhjDdAGdDtem6RyvFUxZ841yGiymZ7i1cM5OV9XA1TNBouToIY
	tRkF1lR+KSM+O4VVRQeCzy6KtolNLHw+xYhBBAiANMN0iJSkhzO0ViRfmp6h+DYQKy811nT6uci
	KZ3lYdA==
X-Gm-Gg: AYBFou0OETxQlNDy/eqGKMCs2UVZW32zNdnl+vUYbnQNVzJqoa/HK0hs+aVTpaAe9bM
	QSDTysEwVtceh1UsIHNgKMf88RhcGUgTApiJgfP8ejCBuJUOf+2V76+UCnst7O2It9pkL2e5ccp
	pO/5qsibrzagyrpA93pDUUjrbZAjNwqn+SxzgCChF6OLCSncgOCghcsfHdxW8zxQK0f4ktguB3V
	5m4XKwa+Ect64I/nUJ9kWzYk5VwMCFhSIHWP9Z7O2vUL78NtqDLT5MfKD6heqv268lweFScrVu7
	zgx6mskeIwAM9/8rK4Tr4mNhxNaPmqwnaNPJ+0WYbf+58FoJezXOjU+yDLVuP0WnP/6hAcoS96Y
	1emQvTT0hn5tiCTOZVVqNFeOa/dm0gDMiWSRmIIZ+A+yOG8fgHx+NBnydZP8RrdCmq6YOS+gp0A
	sKo2OMMpGw00uXc6EYq7Sm27BbZK9xoqMMNctxU7NPf4xLvxvM3uY2jZrWcva1qJaqYY2T4qE5V
	3g3iSK/+BruJu9CukgvoiiJDo7kb63YHKqwl6nFNoUKi40pOWTlywnS6Vsb58WRtwVmPCpifu9d
	hfz6y6Bs1nPr6HiWpLybmdTD
X-Received: by 2002:a05:600c:524b:b0:4a1:f720:74cd with SMTP id 5b1f17b1804b1-4a211ed3f5emr23048395e9.24.1792743494996;
        Fri, 23 Oct 2026 01:18:14 -0700 (PDT)
Received: from google.com (197.183.140.34.bc.googleusercontent.com. [34.140.183.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a21045df9dsm68556225e9.8.2026.10.23.01.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 01:18:14 -0700 (PDT)
Date: Fri, 23 Oct 2026 09:18:10 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] ring-buffer: Do not check si_mem_available() before
 deferred init completes
Message-ID: <atsYQtXHRH_cCQ5A@google.com>
References: <20261016134247.70722-1-amachhiw@linux.ibm.com>
 <20261022181817.49717-1-amachhiw@linux.ibm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261022181817.49717-1-amachhiw@linux.ibm.com>

On Thu, Oct 22, 2026 at 11:48:17PM +0530, Amit Machhiwal wrote:
> During early boot (early_trace_init() called from start_kernel()),
> tracing allocates initial ring buffers (temp_buffer, array_buffer, and
> snapshot_buffer) for CPU 0.  Later, as secondary CPUs come online during
> smp_init(), each CPU's ring buffer is allocated via trace_rb_cpu_prepare().
> 
> Before attempting page allocation, __rb_allocate_pages() performs a
> heuristic check using si_mem_available() to return early with -ENOMEM if
> memory appears insufficient.
> 
> However, on kernels built with CONFIG_DEFERRED_STRUCT_PAGE_INIT=y,
> NR_FREE_PAGES only reflects the initial non-deferred pool across the entire
> period from early_trace_init() through smp_init().  defer_init() leaves
> only a single section per node (e.g.  16 MiB with 64 KB pages) initialized
> up-front, and on kernels with large static binary footprints (debug
> configurations enabling PAGE_OWNER, DEBUG_PAGEALLOC, KFENCE, or SLUB_DEBUG),
> early core initialisations (SLUB caches, vmalloc, static ftrace records)
> consume virtually all managed pages in this pool.
> 
> si_mem_available() therefore returns a false negative (often 0-1 pages)
> across both SYSTEM_BOOTING (for the initial CPU 0 buffers) and
> SYSTEM_SCHEDULING (for secondary CPU buffers via trace_rb_cpu_prepare()),
> causing __rb_allocate_pages() to prematurely abort with -ENOMEM.
> 
> This failure is false: the buddy allocator is designed to replenish
> ZONE_NORMAL on demand via deferred_grow_zone() when an actual allocation
> is attempted.  Checking si_mem_available() before calling alloc_pages_node()
> short-circuits this on-demand growth entirely.
> 
> deferred_grow_zone() is only permanently disabled after page_alloc_init_late()
> completes (it spawns per-node kthreads and blocks until done), which happens
> inside kernel_init_freeable() — before system_state is set to
> SYSTEM_FREEING_INITMEM.  Skip the si_mem_available() check until
> SYSTEM_FREEING_INITMEM, at which point all deferred pages are initialized
> and si_mem_available() is accurate.
> 
> Wrap the guard in #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT so that on kernels
> without deferred init the original check is preserved unchanged.
> 
> Fixes: 2a872fa4e9c8 ("ring-buffer: Check if memory is available before allocation")
> Cc: stable@vger.kernel.org
> Reported-by: Michal Suchánek <msuchanek@suse.de>
> Closes: https://lore.kernel.org/all/arYskzbiaNzBR9MD@kunlun.suse.cz/
> Link: https://lore.kernel.org/all/arYskzbiaNzBR9MD@kunlun.suse.cz/
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>

It is usually good practice to not use in-reply-to to link the series between
each other.

> ---
> Changes since v2:
>  - Rebase on top of upstream ring_buffer.c changes from Vincent Donnefort;
>    update threshold to i < (nr_pages << subbuf_order). (Michal Suchánek)
> 
> Changes since v1:
>  - Extend the guard to cover SYSTEM_SCHEDULING as well: smp_init() calls
>    trace_rb_cpu_prepare() -> __rb_allocate_pages() before page_alloc_init_late()
>    completes, so the false negative window spans both SYSTEM_BOOTING and
>    SYSTEM_SCHEDULING. Use system_state >= SYSTEM_FREEING_INITMEM as the correct
>    boundary.  (Sashiko, Vincent Donnefort)
>  - Wrap in #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT to preserve the original
>    check unchanged on non-deferred kernels. (Vincent Donnefort)
>  - Drop Tested-by: guard condition changed, requesting fresh test.
> 
>  kernel/trace/ring_buffer.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 9c4e40847e43..8e5a59a7b69b 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -2463,10 +2463,27 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
>  		 * memory. It may not be accurate. But we don't care, we just want
>  		 * to prevent doing any allocation when it is obvious that it is
>  		 * not going to succeed.
> +		 *
> +		 * With CONFIG_DEFERRED_STRUCT_PAGE_INIT, NR_FREE_PAGES only
> +		 * reflects the initial non-deferred pool during early boot and
> +		 * throughout SMP bring-up (smp_init() runs before
> +		 * page_alloc_init_late() completes deferred initialization).
> +		 * si_mem_available() returns a false negative across this
> +		 * entire window while actual allocations succeed by growing the
> +		 * zone on demand via deferred_grow_zone(). Only re-enable the
> +		 * check from SYSTEM_FREEING_INITMEM onward, after
> +		 * page_alloc_init_late() has finished and si_mem_available() is
> +		 * accurate.

This is quite a massive comment for something simple: When
CONFIG_DEFERRED_STRUCT_PAGE_INIT, si_mem_available() will reflect the actual
available memory only after SYSTEM_FREEING_INITMEM.

>  		 */
>  		i = si_mem_available();
> +#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
> +		if (system_state >= SYSTEM_FREEING_INITMEM &&
> +		    i < (nr_pages << subbuf_order))
> +			return -ENOMEM;
> +#else
>  		if (i < (nr_pages << subbuf_order))
>  			return -ENOMEM;
> +#endif

Could we avoid the double i < (nr_pages << subbuf_order) with something like

if (IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT) &&
    system_state < SYSTEM_FREEING_INITMEM)
       i = LONG_MAX;

>  
>  		user_thread = current->mm != NULL;
>  	}
> 
> base-commit: 7be4bc52fd9e0e55dc9a2e0232b89427d2c4b614
> -- 
> 2.54.0 (Apple Git-157)
> 

-- 
Vincent
