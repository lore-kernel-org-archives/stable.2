Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402B13DB328;
	Mon, 12 Oct 2026 10:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791799614; cv=none; b=egCA8EUO/WxbXnT05zjpkfmn+dq1elBuxkSRqmVm7E55bsE4zxbnot29D75FLWcEDksbsoV0JaWFy51dSIlnXOv2Lzk0Iwqm3X98mWpO3XbgSL5VACXU5J5BXiAfJn1RYfVziJa0VEu0y9DiUoxkXLGl+PAUBrf5IGEPmAojf9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791799614; c=relaxed/simple;
	bh=UPexDGGT5Z5R8GFc8aoWeG8IcB5zmAhAwaXiH54Bt/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ly7w0BVYWqDBbyJfFESYNe0sudYRMgSuVZjvTLg/dHPUnOSwxt5QmjzSZ54UXOIPBqJHNKnfgHnBfkLL5QjJswTQhuK0At+5U+RQduhQo7AmWaMIvqGibR07i5u34VU19NnIybgWnY1nb0AtCJT9PhuTCRWsm1d5LVfcWwfYRNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xTIAxMX6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZyCqZYoY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2B/1uOOa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=liL655Bv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xTIAxMX6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZyCqZYoY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2B/1uOOa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="liL655Bv"
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EF2E221E05;
	Mon, 12 Oct 2026 10:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791799599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MYhP4QK8hX0Tr71CRIBp10bpXbQNb2lJPWWD//D+Vwk=;
	b=xTIAxMX6sIw3OC59VuLvftJu1HTRbr9hKWakXYYblrr8wXnND/nIsLwAntOMnwjNYLp4Oj
	lNuD6L2uBrmN5tNQ/5KtB/KDajArJJMs8tv5I1TTUDzOZuNISJh/K5MV1r85iJbuwUkm6r
	/3juTgsT4qMFr2g20C048MLGMBoRHTI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791799599;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MYhP4QK8hX0Tr71CRIBp10bpXbQNb2lJPWWD//D+Vwk=;
	b=ZyCqZYoY20yAgdv6f47t2+rWB9eyWF42xho3/h0/OwGXz2QGHh6d0tX28NWQa61gXt1xPG
	bYzB7hHIdA46eaCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="2B/1uOOa";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=liL655Bv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791799598; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MYhP4QK8hX0Tr71CRIBp10bpXbQNb2lJPWWD//D+Vwk=;
	b=2B/1uOOaluJPw2FBMtAY7PiYbGrxFXO1X1ZRSHjlw9/I2WDKpo7mMMuVkUeLtBEUI7tWho
	MvI99aEhVNlfPbMbGHlHevLKqr8GZLfHOh9u5r5b1W8qkcIi+hrg/dXeHQg/qBjSGTd5xk
	a9s5nfwgUfM145MiW+m5jfXDe3KWu4s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791799598;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MYhP4QK8hX0Tr71CRIBp10bpXbQNb2lJPWWD//D+Vwk=;
	b=liL655Bvljq0rf/ZA7O6bJJGyxiHHYmwBSsRL7uCOXLR8p3YZIgbo8PExbx3EuluEppm9X
	bgb44cUf5NAQFSBg==
Date: Mon, 12 Oct 2026 12:06:37 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org, Mark-PK Tsai <mark-pk.tsai@mediatek.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] ring-buffer: Do not check si_mem_available() during
 SYSTEM_BOOTING
Message-ID: <asyxLYOjzqQ5VfFb@kunlun.suse.cz>
References: <20261009163557.88467-1-amachhiw@linux.ibm.com>
 <20261009163557.88467-3-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261009163557.88467-3-amachhiw@linux.ibm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.99 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ONCE_RECEIVED(1.20)[];
	RDNS_NONE(1.00)[];
	HFILTER_HELO_IP_A(1.00)[kunlun.suse.cz];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[kunlun.suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.977];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[goodmis.org,kernel.org,vger.kernel.org,lists.ozlabs.org,efficios.com,linux.ibm.com,gmail.com,mediatek.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b306:2000::2:from];
	TAGGED_RCPT(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim]
X-Spam-Score: 2.99
X-Spam-Level: **
X-Spamd-Bar: ++
X-Rspamd-Queue-Id: EF2E221E05
X-Spam-Flag: NO
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

On Fri, Oct 09, 2026 at 10:05:57PM +0530, Amit Machhiwal wrote:
> During early boot (early_trace_init() called from start_kernel()),
> tracing allocates initial ring buffers (temp_buffer, array_buffer, and
> snapshot_buffer) for CPU 0.
> 
> Before attempting page allocation, __rb_allocate_pages() performs a
> heuristic check using si_mem_available() to return early with -ENOMEM if
> memory appears insufficient.
> 
> However, on kernels built with CONFIG_DEFERRED_STRUCT_PAGE_INIT=y,
> defer_init() leaves only a single section per node (e.g.  16 MiB with 64
> KB pages) initialized up-front.  On kernels with large static binary
> footprints (such as debug configurations enabling PAGE_OWNER,
> DEBUG_PAGEALLOC, KFENCE, or SLUB_DEBUG), the static kernel image and
> early core initialisations (SLUB caches, vmalloc, static ftrace records)
> consume virtually all managed pages in this initial pool.
> 
> At T=0.000000, watermarks have not yet been established
> (totalreserve_pages = 0), so si_mem_available() returns the raw free
> page count (often 0-1 pages).  When the snapshot buffer or global trace
> buffer attempts to allocate 2 sub-pages, si_mem_available() returns <
> nr_pages and prematurely aborts with -ENOMEM.
> 
> This failure is false: if the page allocation were actually attempted
> via alloc_pages_node(), the page allocator would trigger
> deferred_grow_zone() on demand to initialise additional deferred memory
> sections.  Checking si_mem_available() before attempting the allocation
> short-circuits this on-demand growth.
> 
> Skip the si_mem_available() check when system_state == SYSTEM_BOOTING.
> Once the system transitions past early boot and page_alloc_init_late()
> initialises all deferred memory, si_mem_available() accurately reflects
> system-wide free memory and the check operates as intended for runtime
> allocations.

Tested-by: Michal Suchánek <msuchanek@suse.de>

> 
> Fixes: 2a872fa4e9c8 ("ring-buffer: Check if memory is available before allocation")
> Cc: stable@vger.kernel.org
> Reported-by: Michal Suchánek <msuchanek@suse.de>
> Closes: https://lore.kernel.org/all/arYskzbiaNzBR9MD@kunlun.suse.cz/
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
>  kernel/trace/ring_buffer.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 04bb94c29f58..a9f82e2f8fad 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -2452,9 +2452,15 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
>  	 * memory. It may not be accurate. But we don't care, we just want
>  	 * to prevent doing any allocation when it is obvious that it is
>  	 * not going to succeed.
> +	 *
> +	 * Skip this check during early boot: with CONFIG_DEFERRED_STRUCT_PAGE_INIT,
> +	 * NR_FREE_PAGES only reflects the initial non-deferred pool at this
> +	 * stage. si_mem_available() returns a false negative while actual
> +	 * allocations succeed by growing the zone on demand via
> +	 * deferred_grow_zone().
>  	 */
>  	i = si_mem_available();
> -	if (i < nr_pages)
> +	if (system_state != SYSTEM_BOOTING && i < nr_pages)
>  		return -ENOMEM;
>  
>  	/*
> -- 
> 2.54.0 (Apple Git-157)
> 
> 
