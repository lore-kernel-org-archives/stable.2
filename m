Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CF64D09EE;
	Mon, 19 Oct 2026 10:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792407429; cv=none; b=uuteXJh1Pha5hpqq8nqT5a8Lw79fstE3zHqeLjtQn+HKbEMKYAEq441X2UrIKRWulzCSmjsRtBHZD3crKnPschvXfwfx908KAB7qooyhjSnWjuKTHy9ulW7UFSgwGZWI5h9MVDfSCcJIhbQrBTeT1OuoxD3j1LBmqybZqOf7T4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792407429; c=relaxed/simple;
	bh=+WzZhkAwkPXH6W1kia133VCOMslYqRZKnzSwUNXCui0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/1UNMKmPAte32pDX8MTVtMGGqCTHtTG7fbY85bm019GBeg4HLt2JYgOIsHiLOQjY2JfuzIAoivReZQFzYJbtFIP8V/XnFTsanedv54b52Ankioej1uUsEN2Nxtcv+6f5YV7NIvnlNbrJm/DxEId3CqbsXAoesqvjgIR3UbLvg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SbkJR+fC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=trsT8hH/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MWBwni5M; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4desH9I3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SbkJR+fC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="trsT8hH/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MWBwni5M";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4desH9I3"
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8C7C921C96;
	Mon, 19 Oct 2026 10:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792407426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HBoLQBnR2x2I9gF8Bsc1t9MrDCxYKDsvlVnMLW9MKsg=;
	b=SbkJR+fCsBxBEvs2CEDuET0EMPfVlddVpr5wDMpd0yK6EGsXT0d74uG0jNK+XAQ3oI0ZdX
	IxBL42BqXVjogxi2antYzRwseb7DOd0bv6pvDLX+bITHjfB40c7pe2otKl23Pjza0ouv3a
	urwdskWD2DqeX7bPkPg1DbbWBiHjDAg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792407426;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HBoLQBnR2x2I9gF8Bsc1t9MrDCxYKDsvlVnMLW9MKsg=;
	b=trsT8hH/s7rOWEqSiO4V52ryJ932QZ+OpYW/KMmVg1lfSODvQpOV19Cyal6hNCwFZ6DuUJ
	2tsdd3EDY7CdmVCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MWBwni5M;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4desH9I3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792407424; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HBoLQBnR2x2I9gF8Bsc1t9MrDCxYKDsvlVnMLW9MKsg=;
	b=MWBwni5MFz43iAvEWU+bVeL33MPkYVQEoh7Wj3bJbypjGswq3ziGwyFayvKJcEwO21vTti
	ALDpuPhhN0hpCDPR769lybiQSjn5+fMs8JQL2kmOVch7gmpjNgE/Xc0SmQ2uzUgSob7Wmd
	2rGnYITCmgAdQsh4sMLY+BrU6jkAgIo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792407424;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HBoLQBnR2x2I9gF8Bsc1t9MrDCxYKDsvlVnMLW9MKsg=;
	b=4desH9I3xRvpv6asRs58vFO5OnHYl2ZrLSIUJFOwP/sEoL6hY8mFJ5I1bq5oH37+NTd/bQ
	3puQ7U4tHScmV5BQ==
Date: Mon, 19 Oct 2026 12:57:03 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Vincent Donnefort <vdonnefort@google.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] ring-buffer: Do not check si_mem_available() before
 deferred init completes
Message-ID: <atX3fzEV_Pai4woV@kunlun.suse.cz>
References: <20261009163557.88467-3-amachhiw@linux.ibm.com>
 <20261016134247.70722-1-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261016134247.70722-1-amachhiw@linux.ibm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.99 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ONCE_RECEIVED(1.20)[];
	HFILTER_HELO_IP_A(1.00)[kunlun.suse.cz];
	RDNS_NONE(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[kunlun.suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[14];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b306:2000::2:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[goodmis.org,kernel.org,vger.kernel.org,lists.ozlabs.org,google.com,efficios.com,linux.ibm.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,kunlun.suse.cz:helo]
X-Spam-Score: 2.99
X-Spam-Level: **
X-Spamd-Bar: ++
X-Rspamd-Queue-Id: 8C7C921C96
X-Spam-Flag: NO
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

On Fri, Oct 16, 2026 at 07:12:47PM +0530, Amit Machhiwal wrote:
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
> ---
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
>  kernel/trace/ring_buffer.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 04bb94c29f58..aa877a272c89 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -2452,10 +2452,24 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
>  	 * memory. It may not be accurate. But we don't care, we just want
>  	 * to prevent doing any allocation when it is obvious that it is
>  	 * not going to succeed.
> +	 *
> +	 * With CONFIG_DEFERRED_STRUCT_PAGE_INIT, NR_FREE_PAGES only reflects
> +	 * the initial non-deferred pool during early boot and throughout SMP
> +	 * bring-up (smp_init() runs before page_alloc_init_late() completes
> +	 * deferred initialization). si_mem_available() returns a false negative
> +	 * across this entire window while actual allocations succeed by growing
> +	 * the zone on demand via deferred_grow_zone(). Only re-enable the check
> +	 * from SYSTEM_FREEING_INITMEM onward, after page_alloc_init_late() has
> +	 * finished and si_mem_available() is accurate.
>  	 */
>  	i = si_mem_available();
> +#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
> +	if (system_state >= SYSTEM_FREEING_INITMEM && i < nr_pages)
> +		return -ENOMEM;
> +#else
>  	if (i < nr_pages)
>  		return -ENOMEM;
> +#endif
>  
>  	/*
>  	 * If a user thread allocates too much, and si_mem_available()
> 
> base-commit: 2f2f7eeef8b0a1a9b9ca998231419873ccae8d4e

Hello,

due to other conflicting changes this no longer applies.

Will you send a rebase?

Thanks

Michal
