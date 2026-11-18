Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795027760;
	b=Ay6z3b6Voq6Ls9RgbD7BiJ2ZadzkdqYAcqcg5tLOpJGBORUJfHpH/zrKwEeNuLwmMu5+
	 Ijm0aHEKS8GxvtzMFDpFNGJaMBzxfU4QVT2h8I3Qis/Ilhjea8qOu1Z3RT+KFQUt1X7+u
	 Y5WquOSfuPV2caHsa230VeF5KdBpiAxpsRb7YYKKNJZYWdYzqEpT0mHwqKI5u6zjcD4Xc
	 gad5ZYtrs9G9B/5dkFFbh1bZOcLwS7VmutRgkba2DabJpKxxswI918ashZu/ErpILr2Sl
	 LG3HPIDB5WWXweI9sgpm1dx+mRnKDz1MPyNfhDPFxotCwvFdPJW8c5S0Uvx93tyMqJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795027760;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=+ReOE7+oksxTjjUsOQ26pn+3f7hbbQ4VGUdBzm7H5LA=;
	b=JClxFl0AbGRts68OY3cYq+HuWpCjT0QNZtOVqntBjfSX/OohXvjtA/OQNqfB/7y/VGrK
	 2F8uetMplF2lrp1VXCtTiR0CTKaH97S6MUbsYlDizpuhWwxFwzrKz2det5rDoeovfiyhY
	 NeI+xKQt6cYU19YDH1hKfVoVt1XHtKErQneNh8kCmFAqy8+9wSbbfrO1FiIex5T4RZXXU
	 ejrZ59M6kfy3YcJs/SDYMPdeSMQel8n4nIBKpd9GPfZvM+/Exv82H3QaniJgFvNTpIhHj
	 fwgPgqP+l6oyst93a7H0iIDLOwX/8+sPBeMJaEIbnRtV6r8r9C77VSAA5ud0yqntLKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=OyP7ZRNj;
	arc=none smtp.remote-ip=216.40.44.17
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBC9606A338;
	Wed, 18 Nov 2026 18:49:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EBC9606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=OyP7ZRNj
Received: from omf15.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 25994A8504;
	Wed, 18 Nov 2026 18:49:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 0D1D81B;
	Wed, 18 Nov 2026 18:49:15 +0000 (UTC)
Date: Wed, 18 Nov 2026 13:49:14 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Weiming Shi <bestswngs@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 co+bba0c6b49150bef3@bugs.sh, Xiang Mei <xmei5@asu.edu>,
 stable@vger.kernel.org
Subject: Re: [PATCH 2/2] ftrace: Complete subops teardown after hash update
 failure
Message-ID: <20261118134914.7991e6b1@gandalf.local.home>
In-Reply-To: <20261103175832.3374540-2-bestswngs@gmail.com>
References: <20261103175832.3374540-1-bestswngs@gmail.com>
	<20261103175832.3374540-2-bestswngs@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: atym8eksuqi9eehfucjpmoqhtpife3p6
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 0D1D81B
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19OUE1FKMHGZW9QUIFotSrLvpNnAWu6w1c=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=+ReOE7+oksxTjjUsOQ26pn+3f7hbbQ4VGUdBzm7H5LA=; b=OyP7ZRNjmgQTnaOlErNJbRwBhwuKwfAbOaEXrBZeocJZWRAS9WATXieSrNMt9m5piUTpKUe+ExdqXyeE8140XINgrq9LcECNlF/FSLAuj3TWB9y957/lrtnulJDqFlM/X+uh0OeZk4o/rVq+INBf3vSbfRgE5bn6S+rYel75kOw=
X-HE-Tag: 1795027755-842503
X-HE-Meta: U2FsdGVkX19PU9kb0ccycLG/UsVgfEfcGHlOceuVyM/ND/tDddB8SeWfGR0qAIRUPCPYtHiq5HGJ842OjXSUtKFOhCK/LTOFk5xOLuImAqLOjCkGaGuvZ4CawCEuV4NBaMpp6QqNvXMGd2RRYCOEHK1s/UDEb21+1DY0wjL0m41j8Q4HMIJIOJsX5ApeMWObQt4CdRC8UbgNNi3Zo4Z0Ui5NwaZVthxPwMUJuEgcp3Oav9j1KjMC7yqdxg3fj02Rf8JX8Gq8Id4bqMUO49S2Xr7M7d6tx79OKE0jTrSIlo6X6D7bi/imTv4fDJ5ahF1zZ4yT1n2kTABa6t61U5MRqqRYHJ8EN8JDLEbFaBPklYw6TOVcNnmz9g==

On Tue,  3 Nov 2026 09:58:31 -0800
Weiming Shi <bestswngs@gmail.com> wrote:

> When removing a graph operation while other operations remain,
> ftrace_shutdown_subops() rebuilds the manager hashes. Memory allocations
> in rebuild_hashes() or ftrace_update_ops() can fail with -ENOMEM.
> 
> On a rebuild failure, the subop has been removed from the list but still
> has FTRACE_OPS_FL_ENABLED and FTRACE_OPS_FL_SUBOP set. On an update
> failure, it is added back to the list. Neither outcome matches
> unregister_ftrace_graph(), which has already removed the graph slot.
> 
> For example, enable a function_graph tracer with a nonempty filter and a
> return fprobe. Fail an allocation in rebuild_hashes() while disabling the
> fprobe, disable the tracer, then re-enable the fprobe. The stale SUBOP
> state routes its filter update through the now-empty manager list.
> rebuild_hashes() leaves its output pointers uninitialized, and ops_equal()
> can crash when dereferencing them.

Please show the example that can cause the above situation.

> 
> Complete non-final subop removal on both error paths by clearing its
> enabled/subop flags and manager pointer without adding it back to the
> list. Initialize the rebuild outputs to EMPTY_HASH as well.
> 
> A failed manager hash update may leave functions enabled that only the
> removed operation traced. Keep per-subop filtering in that case, since
> direct graph dispatch skips those checks. Restore direct dispatch after
> a successful removal from two graph operations to one, or after a
> successful first registration.
> 
> This depends on the reader synchronization in the preceding patch.

Every patch needs to be stand alone, and not mention other patches.

> Clearing the enabled flag after a failure allows the caller to release the
> subop filter, while an existing graph callback may still hold it. Backport
> both patches together.
> 
> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000802: 0000 [#1] SMP KASAN NOPTI
> KASAN: probably user-memory-access in range [0x0000000000004010-0x0000000000004017]
> RIP: ops_equal (kernel/trace/trace.h:1011 kernel/trace/ftrace.c:3416)
> Call Trace:

What were the commands that caused the above?

-- Steve

>  ftrace_update_ops (kernel/trace/ftrace.c:3464)
>  ftrace_hash_move_and_update_subops.isra.0 (kernel/trace/ftrace.c:3795)
>  ftrace_hash_move_and_update_ops (kernel/trace/ftrace.c:5095)
>  ftrace_set_hash (kernel/trace/ftrace.c:6006)
>  ftrace_set_filter_ips (kernel/trace/ftrace.c:6020 kernel/trace/ftrace.c:6769)
>  register_fprobe_ips (kernel/trace/fprobe.c:290 kernel/trace/fprobe.c:1020)
>  register_fprobe (kernel/trace/fprobe.c:979)
>  enable_trace_fprobe (kernel/trace/trace_fprobe.c:838 kernel/trace/trace_fprobe.c:1480)
>  fprobe_register (kernel/trace/trace_fprobe.c:1555)
>  __ftrace_event_enable_disable (kernel/trace/trace_events.c:913)
>  event_enable_write (kernel/trace/trace_events.c:943 kernel/trace/trace_events.c:1995)
>  vfs_write (fs/read_write.c:685)
>  ksys_write (fs/read_write.c:739)
>  do_syscall_64 (arch/x86/entry/syscall_64.c:61 arch/x86/entry/syscall_64.c:84)
>  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
> Kernel panic - not syncing: Fatal exception
> 
> Cc: stable@vger.kernel.org
> Fixes: 0ae6b8ce200d ("ftrace: Fix accounting of subop hashes")
> Reported-by: <co+bba0c6b49150bef3@bugs.sh>
> Assisted-by: LLM
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
>  kernel/trace/fgraph.c | 10 +++++++---
>  kernel/trace/ftrace.c | 22 ++++++++++++++--------
>  2 files changed, 21 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index 14733f519..48521bc33 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -1406,8 +1406,11 @@ int register_ftrace_graph(struct fgraph_ops *gops)
>  	gops->ops.flags |= FTRACE_OPS_FL_GRAPH;
>  
>  	ret = ftrace_startup_subops(&graph_ops, &gops->ops, command);
> -	if (!ret)
> +	if (!ret) {
>  		fgraph_array[i] = gops;
> +		if (ftrace_graph_active == 1)
> +			ftrace_graph_enable_direct(true, gops);
> +	}
>  
>  error:
>  	if (ret) {
> @@ -1435,6 +1438,7 @@ int register_ftrace_graph(struct fgraph_ops *gops)
>  bool unregister_ftrace_graph_start(struct fgraph_ops *gops)
>  {
>  	int command = 0;
> +	int ret = -EINVAL;
>  	bool removed = false;
>  
>  	if (WARN_ONCE(!(gops->ops.flags & FTRACE_OPS_FL_GRAPH),
> @@ -1461,9 +1465,9 @@ bool unregister_ftrace_graph_start(struct fgraph_ops *gops)
>  	if (!ftrace_graph_active)
>  		command = FTRACE_STOP_FUNC_RET;
>  
> -	ftrace_shutdown_subops(&graph_ops, &gops->ops, command);
> +	ret = ftrace_shutdown_subops(&graph_ops, &gops->ops, command);
>  
> -	if (ftrace_graph_active == 1)
> +	if (ftrace_graph_active == 1 && !ret)
>  		ftrace_graph_enable_direct(true, NULL);
>  	else if (!ftrace_graph_active)
>  		ftrace_graph_disable_direct(false);
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index c7d74b33d..7c712d99f 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -3672,6 +3672,8 @@ static int rebuild_hashes(struct ftrace_hash **filter_hash, struct ftrace_hash *
>  	bool first = true;
>  	int ret;
>  
> +	*filter_hash = EMPTY_HASH;
> +	*notrace_hash = EMPTY_HASH;
>  	temp_hash.filter_hash = EMPTY_HASH;
>  	temp_hash.notrace_hash = EMPTY_HASH;
>  
> @@ -3713,7 +3715,13 @@ static int rebuild_hashes(struct ftrace_hash **filter_hash, struct ftrace_hash *
>   * will not affect functions that are being traced by other subops that
>   * still exist in @ops.
>   *
> - * If the last subops is removed from @ops, then @ops is shutdown normally.
> + * If @subops is the last subop, @ops is shut down normally. Otherwise,
> + * @subops is detached even if the manager hash update fails. The manager
> + * hashes may be partially updated, but still cover all functions required by
> + * the remaining subops.
> + *
> + * Return: 0 on success, or a negative error code on shutdown or hash update
> + * failure.
>   */
>  int ftrace_shutdown_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, int command)
>  {
> @@ -3753,15 +3761,13 @@ int ftrace_shutdown_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, in
>  	/* Rebuild the hashes without subops */
>  	ret = rebuild_hashes(&filter_hash, &notrace_hash, ops);
>  	if (ret < 0)
> -		return ret;
> +		goto out;
>  
>  	ret = ftrace_update_ops(ops, filter_hash, notrace_hash);
> -	if (ret < 0) {
> -		list_add(&subops->list, &ops->subop_list);
> -	} else {
> -		subops->flags &= ~(FTRACE_OPS_FL_ENABLED | FTRACE_OPS_FL_SUBOP);
> -		subops->managed = NULL;
> -	}
> +
> +out:
> +	subops->flags &= ~(FTRACE_OPS_FL_ENABLED | FTRACE_OPS_FL_SUBOP);
> +	subops->managed = NULL;
>  	free_ftrace_hash(filter_hash);
>  	free_ftrace_hash(notrace_hash);
>  	return ret;

