Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B693E0C7A;
	Mon, 12 Oct 2026 10:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791799481; cv=none; b=ILLYKnCg0Mgg97IKdWl6t4mwD1uEpDIcydALTsn7OzFzhCFkh1VG7yIMM0iRoc6IRgJDlfYwkk8XN5xg1WqUH5y4QX1vawp2pJegRdBSfnHLm08tlIrASMehsv0L10466csj73x1HHF1Lv6ynIchTKUB0VDUtQMa6Im8uwxTuXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791799481; c=relaxed/simple;
	bh=vy4mldlWgn2BM/HDz16yO6KnMvCSECqq1Z9iQ4F/nEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XLfvrusLuO3HHUM76d6nRnAcfkNsfqj6qwNYDL4IpghtSy6Mg5bnw+glbUkqc0TQQj8MUJDdEFgW/clax+dHiqYRZknRotZTfC5cQUu+ICyZUfzR7uPw0qXYCtYEen4NMbWN4MKXHIJtL9J4qcd3jeSGBaxB7oJrvPkL9HEJItY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ObvDo3gn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QmfbedIY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ObvDo3gn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QmfbedIY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ObvDo3gn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QmfbedIY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ObvDo3gn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QmfbedIY"
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9ABD31F76C;
	Mon, 12 Oct 2026 10:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791799476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kV/uchDiV6BTnoljBvD8VleslGZ6Gbxx1QPYEt6Kc7A=;
	b=ObvDo3gnEPoN+VUfHnzb0zfbkhh8LRHVzgywDABcSgf4o/28kL5BF+OzqFBJ7KxrndM8xb
	kQE5RGqqOlzgupcdLJPSWMx8wR6KmxsiJyCQ2X38ctOCqm1yhQSlijtYL7eT3fTAn5wYsy
	kSLsadb+VxyXS4NyCQVwrclCvoo8Ta4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791799476;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kV/uchDiV6BTnoljBvD8VleslGZ6Gbxx1QPYEt6Kc7A=;
	b=QmfbedIYDfCznU/qAZcKnNcBZ+C19RNjPp1M0SggWKes4puqwQGJeIjd3n3RtwXc2aNdrt
	WMYTXHCNIy/XcUCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ObvDo3gn;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=QmfbedIY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791799476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kV/uchDiV6BTnoljBvD8VleslGZ6Gbxx1QPYEt6Kc7A=;
	b=ObvDo3gnEPoN+VUfHnzb0zfbkhh8LRHVzgywDABcSgf4o/28kL5BF+OzqFBJ7KxrndM8xb
	kQE5RGqqOlzgupcdLJPSWMx8wR6KmxsiJyCQ2X38ctOCqm1yhQSlijtYL7eT3fTAn5wYsy
	kSLsadb+VxyXS4NyCQVwrclCvoo8Ta4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791799476;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kV/uchDiV6BTnoljBvD8VleslGZ6Gbxx1QPYEt6Kc7A=;
	b=QmfbedIYDfCznU/qAZcKnNcBZ+C19RNjPp1M0SggWKes4puqwQGJeIjd3n3RtwXc2aNdrt
	WMYTXHCNIy/XcUCA==
Date: Mon, 12 Oct 2026 12:04:35 +0200
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
Subject: Re: [PATCH 1/2] tracing: Do not initialize tracefs work if tracing
 is disabled
Message-ID: <asywswm6JClQDcOg@kunlun.suse.cz>
References: <20261009163557.88467-1-amachhiw@linux.ibm.com>
 <20261009163557.88467-2-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261009163557.88467-2-amachhiw@linux.ibm.com>
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
X-Rspamd-Queue-Id: 9ABD31F76C
X-Spam-Flag: NO
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

On Fri, Oct 09, 2026 at 10:05:56PM +0530, Amit Machhiwal wrote:
> If trace buffer allocation fails during early boot (e.g.  in
> early_trace_init() -> allocate_trace_buffers()), tracing_disabled is
> left set to 1 and the global trace array events list remains
> uninitialized.
> 
> Later during boot, tracer_init_tracefs() (invoked via fs_initcall)
> queues tracerfs_init_work asynchronously without checking if tracing was
> disabled.  When tracer_init_tracefs_work_func() runs, it calls
> event_trace_init() and init_tracer_tracefs(&global_trace, NULL)
> unconditionally.  This leads to __find_event_file() dereferencing an
> uninitialized tr->events list, causing an early boot NULL pointer
> dereference Oops:
> 
>   BUG: Kernel NULL pointer dereference on read at 0x00000010
>   Faulting instruction address: 0xc000000000485be0
>   Oops: Kernel access of bad area, sig: 7 [#1]
>   ...
>   NIP [c000000000485be0] __find_event_file+0x70/0x3c0
>   LR  [c000000000448874] init_tracer_tracefs+0x274/0xc80
>   Call Trace:
>    init_tracer_tracefs+0x274/0xc80
>    tracer_init_tracefs_work_func+0x50/0x320
>    process_one_work+0x1e8/0x5c0
>    worker_thread+0x1dc/0x3d0
>    kthread+0x194/0x1b0
>    start_kernel_thread+0x14/0x18
> 
> Check tracing_disabled at the beginning of tracer_init_tracefs_work_func()
> and return immediately if tracing is disabled or failed to initialize,
> preventing the crash.

Thanks for the patch

Tested-by: Michal Suchánek <msuchanek@suse.de>

> 
> Fixes: 6621a7004684 ("tracing: make tracer_init_tracefs initcall asynchronous")
> Cc: stable@vger.kernel.org
> Reported-by: Michal Suchánek <msuchanek@suse.de>
> Closes: https://lore.kernel.org/all/arYskzbiaNzBR9MD@kunlun.suse.cz/
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
>  kernel/trace/trace.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index e4a490d3d08c..7ac9e1c92702 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -9287,6 +9287,12 @@ static struct notifier_block trace_module_nb = {
>  
>  static __init void tracer_init_tracefs_work_func(struct work_struct *work)
>  {
> +	/*
> +	 * Do not attempt to initialize tracefs if tracing was disabled or
> +	 * failed to allocate
> +	 */
> +	if (tracing_disabled)
> +		return;
>  
>  	event_trace_init();
>  
> -- 
> 2.54.0 (Apple Git-157)
> 
