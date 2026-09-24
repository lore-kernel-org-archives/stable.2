Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A6D23BF9F;
	Thu, 24 Sep 2026 01:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790212019; cv=none; b=hoPWCpU2uyesDvHE7MoyN1KBd+skmOulKPulSxL+K6lAVga8/JNs6xTeGhQ3wvhUCZGk3cCbuZV46rxbVT+6V/MPAhNr4E4o/GL2wInKI1yYBQ6bOLr3ClTgmd48zzKgnShf7uYbIUxEGq0fWjZjPQ9K455f04rdR33/jOrtDcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790212019; c=relaxed/simple;
	bh=OFG7solwFJRuwBszQ7Wnwkkpl8Opqn5d4oDAoeNgtfw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=IE1YdEwv2fU9Y0DRGrLoV8XrT6kNG++d/itSC+fjUgQmfdPRwh9gMd3tijbDu+djy/Wc1q1+vFld7aTU9grXYCHNQGBB2y+u19k14Wx8lX3KjCq+fMArJfXSEIeQkmNNinJKDMQYc6xsdKP8pZ/0zNxHnyoMGGdJeJvQVFRQAWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPXk9yS1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPXk9yS1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 118E71F000FF;
	Thu, 24 Sep 2026 01:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790212017;
	bh=CJkNWkNrY+y078XLIOaRAPfEesb+E74HSkQALPyaJbM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XPXk9yS1BU/M0jfJbkv2L68IC9GWxkDZPn86zB7oC5cQh18ZiHUGlqB2ftmrLBchk
	 gmiKBPLFlEzNQ2r7wFaVyaUEpo9jhnumi4Sttonwdn4EHXcaZbsIutNGLwgMNFuht8
	 aUTvgzv8movXQzUUz+Z/gb9DVXxhfT8efFmmPacY47xk5Ue1NRgNiWU7wGBzRFiE2F
	 Zdk3YKG2SiMHNNKfwPgpv5j3XaULtb8Zp8N64fqzzgdSjA8e9wwby94BgEc95Y1EYj
	 LZhLW17QsCsNUJXrQVQhQcwBBxpcs2SGPeL12wBTzy/GNy3F2TYslkuJxumnkgPY6B
	 Lvvc8MwoJ/hww==
Date: Thu, 24 Sep 2026 10:06:54 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1] ring-buffer: Fix the sub-buffer array base in
 rb_meta_subbuf_idx()
Message-Id: <20260924100654.49809fad606e577ee39f3086@kernel.org>
In-Reply-To: <20260918071507.1019251-1-donggeunyoo.kernel@gmail.com>
References: <20260918071507.1019251-1-donggeunyoo.kernel@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Sep 2026 16:15:07 +0900
Donggeun Yoo <donggeunyoo.kernel@gmail.com> wrote:

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
> 

Ah, nice catch!

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

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


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
