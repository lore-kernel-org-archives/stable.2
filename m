Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D420444AB89
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 08:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789977876; cv=none; b=muh8Wk45+JHqTqBhKR445kXaEenejbJ31k7j/Pt/vFbSjjAm2j7NLp8MWyLzIVmcWXRXrTKRn79KBxPt5GbxBep9ZMGzv4LAV8BcqkuEoH5bCg0jNuU85AI5J+nb822lvju4r7Yf1JHb7io5UdMkkIZZEYsxmIoqOvQpflnvzEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789977876; c=relaxed/simple;
	bh=C7mMnFJQB3qempjHrlBdVTOUGGgoRYdjU5+sL3G1+ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=spltSLK38T8h0AdTs+bnBwezAb0nJzCEfpWy8QEdtfWSX0e6Frsa/klffMxbnmBl5NhLf1SSr4Pz228ZPJgCTbrf/xAB63E+M5F6hRARm475QAZx1W1nMIPc8yEpiwKYiwM+gOlYzF5229Dyagq66C/QY1s+zgjEtXBPSrtYkE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HxbgWhiK; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HxbgWhiK"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cc9f581c4so11188075e9.0
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 01:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789977872; x=1790582672; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VkcfJuXNZITCOn3dUrvlxZ3BtWVxpJZeQyLT04gvHjg=;
        b=HxbgWhiKAYcgLIkszVr5ZGrOCAqxBSsGMkjBHpqYSMypy6yyWU7DSbZjXGwJK/anD5
         pNy8GBUBw3E8kYGc6UHvGNv6HUGynd/usbk8YXVqnpdoklBY/SgJ4FFyX63Be/EIun08
         qf+U/zuChe5pkIDWCuF6tq1OAO+7L+X9JdAV8AHRAf1g6tavRSqFELI/0YYTNzeKyIBm
         tSVz2ouluyF1/K4JTL14YKc5Vemca119lL3pd+S/bkl7H4cr9K09IuoKYUxO4bm8aUCJ
         Wp9igXA/Bwfs5ZE18p3UB8shTkPBWGGPRxDov9uXcqprEkRZfKZiDWEV37nDGpSGHjxf
         drLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789977872; x=1790582672;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VkcfJuXNZITCOn3dUrvlxZ3BtWVxpJZeQyLT04gvHjg=;
        b=o7jYa4xKipZhnBV9C/XKxDla0oQMi7grZGLZFtld3C079XH655i3y5qR9f2/m7iNaZ
         1JiG7S/8BpoBZ0AhMmrFxgM3PlI0nhzLv94+InfgPLhaCXNC3oXBw1U6qb8OFFUOss5I
         G62n5koC14n+mjXwBk8qCAbW4RwgOGbBGgndu9lyrDtDhTHLeTS0BwGKvyXpa4ZXhWKB
         /S5TQEV6LEDoWO/XOtIGNQXfGFBkqtwvqmcMmVX5qoSWh7KQpD3FJOBiqzYCnG8pAmzt
         do4GyAAMJSRukWCTYp5G+FhTJhvSeoNIMGgjczmm/KbZJi7kylCB7J5aRFWme/rC1r20
         yftQ==
X-Forwarded-Encrypted: i=1; AKwUvBy6gRGxSFA6nO5eKMdJFHCvDRryw1daBO7NF6OnBbjQq1HzAqGEPVCMZYQjDAA7YXCJ1ACbi+A=@vger.kernel.org
X-Gm-Message-State: AFuF++nFGVCbZ1jcw902kWxBa0/inZ1WC18tFOg255nCrfPmpEnnH4pq
	LDOZVJGXxfcSHMogPlU24GTC3eDzLqKzYM5417c0HKTRpWalOjhtUfDwmqmeIUOAjQ==
X-Gm-Gg: AYBFou3lFymMMrffg2dNqbneSVJ4TtZkqoKN7JaeGgriSIBBGx53TcevY2czehnXnVC
	GClk84WstTjdAYSBFWF/PaW252JXNmmiLN3fC2rWijaO1RK/CYnnvxtKfibEXjL9l5L+p2FnnwD
	xCRjZR+vV/8EQaPsZh7V8u+9tcYS8ZGUC+BAD+GKYt+RVMdoetUMh07HP5nKPYAD/UP3NLWjpWs
	aJONAQk4Pa9+nE7Q4dmkpXfmFz4D7OrQ2wU74P9+wiuDZr4Pvf+5ZSK//HO72dmyKe459iRGRlZ
	SsK9zmszT5QV2RKD+y3jrTGWvPDZL3kP9shf6Skv81HrDL6FjCdULTgpZQ9UOsiIWaGbGae5AAR
	y7RWeLdB7KeV5virYELdVcSVkmD+wCtZL6z41pUsOqBz7V1aE86m4LtdjYo+6x34IIswZ81ORwk
	zpzV2mcOH+VmNZTNEYXnaRRKQEAGaIjkrVJqMwP4dHWWMCJeZjOpNBsAyOTN7O5R38Stybi7B6K
	ILj6cZs9PnuKSZqpR6YQ+AlKhJBYyr6u1Orw0C5XVg=
X-Received: by 2002:a05:600c:83c9:b0:49c:f13e:e4d with SMTP id 5b1f17b1804b1-49fc4ff402cmr146994445e9.10.1789977871433;
        Mon, 21 Sep 2026 01:04:31 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd115dcbsm208413135e9.15.2026.09.21.01.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 01:04:30 -0700 (PDT)
Date: Mon, 21 Sep 2026 09:04:26 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] ring-buffer: Fix the sub-buffer array base in
 rb_meta_subbuf_idx()
Message-ID: <arDlCou_U1nV9Zqq@google.com>
References: <20260918071507.1019251-1-donggeunyoo.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918071507.1019251-1-donggeunyoo.kernel@gmail.com>

On Fri, Sep 18, 2026 at 04:15:07PM +0900, Donggeun Yoo wrote:
> On a persistent ring buffer, rb_meta_subbuf_idx() can return an index one
> sub-buffer too high.  rb_setup_ids_meta_page() then fills subbuf_ids[]
> shifted by one and leaves subbuf_ids[0] NULL, which __rb_map_vma()
> dereferences when userspace maps trace_pipe_raw.  rb_update_meta_reader()
> writes two such indices into meta->buffers[], which rb_cpu_meta_valid()
> would reject on the next boot, discarding the previous boot's trace.
> 
> A CPU's sub-buffer array starts after its meta header and the nr_subbufs
> integers that follow, aligned up to a sub-buffer.  rb_meta_subbuf_idx()
> inverts that calculation but skips only the integers, not the header, so
> its base is one sub-buffer low whenever the omitted header size crosses
> the alignment boundary.
> 
> Invert the calculation with rb_subbufs_from_meta() rather than repeating
> it.  rb_range_buffer() maps an index back to an address through the same
> helper, so the two directions can no longer disagree.

Looking at the delta between rb_meta_subbuf_idx() and rb_range_align_subbuf, it
seems it's just the former didn't include that struct ring_buffer_cpu_meta
isn't?

That is quite long commit description just to say that :) 

Otherwise the code looks good.

Reviewed-by: Vincent Donnefort <vdonnefort@google.com>

> 
> Cc: <stable@vger.kernel.org>
> Fixes: b14d032973d4 ("ring-buffer: Add ring_buffer_meta data")
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
> ---
> x86_64_defconfig plus KASAN, FTRACE, TRACING and TRACER_SNAPSHOT, on
> 5dd1818b15d9, booted with reserve_mem=<size>:0x1000:trace
> trace_instance=boot_mapped@trace.  head_buffer is from
> instances/boot_mapped/per_cpu/cpuN/buffer_meta, the map of that CPU's
> trace_pipe_raw.
> 
> nr_cpus=1, 24 reserved sizes 4096 bytes apart:
> 
>   nr_subbufs      head_buffer  map      head_buffer  map
>                   unpatched             patched
>   997 .. 1004     1            ok       1            ok
>   1005 .. 1012    2            oops     1            ok
>   1013 .. 1019    1            ok       1            ok
> 
> nr_cpus=4, nr_subbufs 1017, one boot:
> 
>   cpu 0           1            ok       1            ok
>   cpu 1, 2, 3     2            oops     1            ok
> 
> cpu 0's meta sits after the buffer-wide header and the scratch area and is not
> sub-buffer aligned; every other cpu's is, so the affected nr_subbufs differ
> between them.
> 
> Unpatched oops:
> 
>   Oops: general protection fault, probably for non-canonical address 0xdffffc0000000007: 0000 [#1] SMP KASAN NOPTI
>   KASAN: null-ptr-deref in range [0x0000000000000038-0x000000000000003f]
>   RIP: 0010:__rb_map_vma+0x418/0xa20
> 
> With no reserved range at all, both kernels map the global buffer.  On both
> arms, tools/testing/selftests/ring-buffer passes 6/6 with no skips and
> CONFIG_RING_BUFFER_STARTUP_TEST reports "Ring buffer PASSED!".  ftracetest
> gives identical per-test verdicts on the two arms -- 153 pass, 6 fail, 6
> unresolved, 10 unsupported, 2 xfail.  The six failures are the same on both
> arms and their cause was not established; the unresolved and unsupported ones
> need pahole, a hypervisor trace remote, or userspace this initramfs does not
> have.
> 
> The discarded-trace path is not measured: a fresh QEMU boot gets fresh guest
> memory, so this harness cannot carry a persistent buffer across a reboot.
> 
>  kernel/trace/ring_buffer.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 04bb94c29f58..fa2e2ce683aa 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -3627,10 +3627,8 @@ static void rb_inc_iter(struct ring_buffer_iter *iter)
>  /* Return the index into the sub-buffers for a given sub-buffer */
>  static int rb_meta_subbuf_idx(struct ring_buffer_cpu_meta *meta, void *subbuf)
>  {
> -	void *subbuf_array;
> +	void *subbuf_array = rb_subbufs_from_meta(meta);
>  
> -	subbuf_array = (void *)meta + sizeof(int) * meta->nr_subbufs;
> -	subbuf_array = (void *)ALIGN((unsigned long)subbuf_array, meta->subbuf_size);
>  	return (subbuf - subbuf_array) / meta->subbuf_size;
>  }
>  
> 
> base-commit: 5dd1818b15d98d4a20806cd00b1b40320b06004f
> -- 
> 2.53.0
> 
> 

-- 
Vincent
