Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795813954;
	b=jvFVorlIuYGhcq8KZscZh54b4HAeyTpKOX3AJaMoqnhjuEbAu1bJF5lPRCQH8dv6d20x
	 9rz/+7lGMwgPrRqWkJo1I/PGkiFHNkSNlgcFIKiAuPVHaAnkvm6NLtLykaOWcfAUjrWax
	 rxlZrVxpgjDW2RCwuah4+nEUkq434h5cCwTrMDPQ15/ctogEnJYS4eHjuh+wj05tZWv1B
	 DMLu1Tu1A+TQg4wjkD3yeqOV3a+jAmB2OmNNBTC4ElEgnI0uyc2XE3R6Hgr4+3QYPdjJw
	 e3zhPPfRW3yfuii7LY8GwDgUWGgRO4ZzOkaID1K9/H5AkE5NumWgt83FgxWkgIqaLeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795813954;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-Stat-Signature:
	 X-Spam-Status:X-Rspamd-Server:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=WJRBzUzJZ+tgBaQq4KY26RhwxXZWXxbYJlvgwrZZbrw=;
	b=nsZInXynbfxuYsAjZVOE+QtLzdAH/pw6jjAoNKAGNb3dUHJE969cDjaryTNMwN9/RtvA
	 7ZkQE+kwRzMv8pte8Kjo2wUaac79RPMii8eOlk03NQztSdg/H0bmMTkfoi1Sjae35kwaU
	 MFToT9IX5BOa9VlSplhI/K4MRJQk8Z0xri4hOmUcm3ZVMpB9O+1V42JXnMmQ02kNTqIU9
	 P13Dt9+L9+iNuSq5G4eWhQh8/k274GxqTA7uzbB+G+NM3NwgRLHgcJbmdTw6fiw85kTC4
	 Y5qRyZtvFGnUwKHKGI5zYLjIxwu40GH3/7Sybc5r0qlHdF6xiL96+fdCMfTtg11aGFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=yncFUsyX;
	arc=none smtp.remote-ip=216.40.44.11
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41837606A31C;
	Fri, 27 Nov 2026 21:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41837606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=yncFUsyX
Received: from omf12.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 98BA21204FD;
	Fri, 27 Nov 2026 21:12:31 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id B0FA317;
	Fri, 27 Nov 2026 21:12:29 +0000 (UTC)
Date: Fri, 27 Nov 2026 16:12:28 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Kyle Zeng <kylebot@openai.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 mhiramat@kernel.org, outbounddisclosures@openai.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] tracing/filters: Check perf permissions before
 accessing kernel data
Message-ID: <20261127161228.5bc04b90@gandalf.local.home>
In-Reply-To: <20261007050315.65139-1-kylebot@openai.com>
References: <20261007050315.65139-1-kylebot@openai.com>
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
X-Rspamd-Queue-Id: B0FA317
X-Stat-Signature: t6sutwdxo6bmogix97qrfumin7phw3nk
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18x8GGEvyH8/0KRIoNIfdQCxLKIMeig0M8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=WJRBzUzJZ+tgBaQq4KY26RhwxXZWXxbYJlvgwrZZbrw=; b=yncFUsyXkavtBTxgjftzpZFvXZmHTq595Vqnxku0PN+8Prd4FtsCHqvwOnkuUIXJ99luW1MF2sad/xC1OqTh0zI8yHuKK1L2fMf9a50W6cvPrjjKR2h6nKf9zVPqIrBTi2LJ4GHzlx/Hzbu2sijYcBDH+b211FCtaQy6+6fDIdg=
X-HE-Tag: 1795813949-558610
X-HE-Meta: U2FsdGVkX1+/sRRWxwU+r225PucSlfynXxSG/GWXJQ8SOh3dNit2p2TsaRqg4Z6w6OkkbXj2iGyW6KeJLcvcFZ5+vqB+F6iofYME03Alc+AVDSaTP/aTRdtjuFfJdibXpy8/ziwQGDbd/C0CHW4L2pQ6Eb4PkH60pthQhMRqFNWb4GxM1AMxk9ZIL8qrLxyyozKsT3x9JTUds/TW6N9ENNMNqZSJQqUweeJgPsaDGxPbgxQHi4cy2i+gkAGiCAbPG6fgzdlTtHPj5o2/Nxe9CLhDE0+YRZpAQ++ro/CjuIsobfauSF7OSiSwyVxY5B4p0J717741kgMNn0WZLM1DD+gS+ra20EVCZxrDsnZpOPBrhSmwr0LWbw==


Hmm, I thought I replied to this already but perhaps I never sent my email.

Anyway, I have issues with this change.

On Tue,  6 Oct 2026 22:03:15 -0700
Kyle Zeng <kylebot@openai.com> wrote:

> perf_trace_event_perm() allows tracepoint counters that do not request
> PERF_SAMPLE_RAW without raw tracepoint permissions. A self-targeted
> event with exclude_kernel=1 can therefore reach the filter compiler even
> at perf_event_paranoid=2.
> 
> The .function suffix resolves its operand through kallsyms. The result
> of a numeric filter discloses whether an address belongs to a known
> kernel symbol range, allowing the randomized kernel image base to be
> recovered. A named filter also exposes the resolved range through the
> counter when the tracepoint field is controlled by the caller.

Once you allow tracing function events all bets are off with KASLR. The raw
addresses are recorded in the perf ring buffer. Thus, you just have to
filter "ip==schedule" and then the address of schedule is saved in the user
space perf ring buffer and the user now knows the KASLR offset.

> 
> Pointer-string filters expose kernel memory in the same way. A caller
> can supply a kernel address as the filename argument to openat() and
> install a string filter on sys_enter_openat. Without .ustring, the
> filter uses strncpy_from_kernel_nofault() on that address. Whether the
> counter increments reveals whether the kernel bytes match the pattern.
> The nofault copy prevents faults but does not authorize disclosure.
> 
> Pass the filter's perf origin to the predicate parser and require
> perf_allow_tracepoint() before resolving a .function operand or creating
> a kernel-pointer string predicate. This uses the existing sysctl,
> initial-namespace capability and LSM policy for raw tracepoint access.
> Keep ordinary counting filters, explicit user-string predicates and
> filters created through the separately controlled tracefs interfaces
> unchanged.
> 
> Fixes: e6745a4da964 ("tracing: Add a way to filter function addresses to function names")
> Fixes: 5967bd5c4239 ("tracing: Let filter_assign_type() detect FILTER_PTR_STRING")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> ---
> Changes in v2:
> - Require raw-tracepoint permission for kernel-pointer string filters
>   as well as .function predicates, preserving explicit .ustring filters.
> - Add the pointer-string Fixes tag and describe the confirmed
>   sys_enter_openat counter oracle.
> 
>  kernel/trace/trace_events_filter.c | 41 ++++++++++++++++++++++--------
>  1 file changed, 31 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
> index 2b46ca536045..84d4a4fe56ad 100644
> --- a/kernel/trace/trace_events_filter.c
> +++ b/kernel/trace/trace_events_filter.c
> @@ -1625,12 +1625,18 @@ static int filter_pred_fn_call(struct filter_pred *pred, void *event)
>  	}
>  }
>  
> +struct filter_parse_data {
> +	struct trace_event_call *call;
> +	bool is_perf;
> +};

NAK, I don't want perf permissions to infest the filter logic.

Either perf is allowed to use the filtering or it is not. It's not going to
be conditional. At least within the generic logic.

> +
>  /* Called when a predicate is encountered by predicate_parse() */
>  static int parse_pred(const char *str, void *data,
>  		      int pos, struct filter_parse_error *pe,
>  		      struct filter_pred **pred_ptr)
>  {
> -	struct trace_event_call *call = data;
> +	struct filter_parse_data *pdata = data;
> +	struct trace_event_call *call = pdata->call;
>  	struct ftrace_event_field *field;
>  	struct filter_pred *pred = NULL;
>  	unsigned long offset;
> @@ -1687,6 +1693,16 @@ static int parse_pred(const char *str, void *data,
>  		i += len;
>  	}
>  
> +	/* Even counting filters can disclose kernel addresses and data. */
> +	if (pdata->is_perf &&
> +	    (function || (!ustring && field->filter_type == FILTER_PTR_STRING))) {
> +		ret = perf_allow_tracepoint();
> +		if (ret) {
> +			parse_error(pe, ret, pos + i);
> +			return ret;
> +		}
> +	}
> +
>  	while (isspace(str[i]))
>  		i++;
>  
> @@ -2205,8 +2221,12 @@ static int calc_stack(const char *str, int *parens, int *preds, int *err)
>  static int process_preds(struct trace_event_call *call,
>  			 const char *filter_string,
>  			 struct event_filter *filter,
> -			 struct filter_parse_error *pe)
> +			 struct filter_parse_error *pe, bool is_perf)
>  {
> +	struct filter_parse_data data = {
> +		.call = call,
> +		.is_perf = is_perf,
> +	};
>  	struct prog_entry *prog;
>  	int nr_parens;
>  	int nr_preds;
> @@ -2232,7 +2252,7 @@ static int process_preds(struct trace_event_call *call,
>  		return -EINVAL;
>  
>  	prog = predicate_parse(filter_string, nr_parens, nr_preds,
> -			       parse_pred, call, pe);
> +			       parse_pred, &data, pe);
>  	if (IS_ERR(prog))
>  		return PTR_ERR(prog);
>  
> @@ -2281,7 +2301,7 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
>  		if (!filter->filter_string)
>  			goto fail_mem;
>  
> -		err = process_preds(file->event_call, filter_string, filter, pe);
> +		err = process_preds(file->event_call, filter_string, filter, pe, false);
>  		if (err) {
>  			filter_disable(file);
>  			parse_error(pe, FILT_ERR_BAD_SUBSYS_FILTER, 0);
> @@ -2377,6 +2397,7 @@ static void create_filter_finish(struct filter_parse_error *pe)
>   * @call: trace_event_call to create a filter for
>   * @filter_string: filter string
>   * @set_str: remember @filter_str and enable detailed error in filter
> + * @is_perf: filter is being created for a perf event
>   * @filterp: out param for created filter (always updated on return)
>   *           Must be a pointer that references a NULL pointer.
>   *
> @@ -2391,7 +2412,7 @@ static void create_filter_finish(struct filter_parse_error *pe)
>   */
>  static int create_filter(struct trace_array *tr,
>  			 struct trace_event_call *call,
> -			 char *filter_string, bool set_str,
> +			 char *filter_string, bool set_str, bool is_perf,
>  			 struct event_filter **filterp)
>  {
>  	struct filter_parse_error *pe = NULL;
> @@ -2405,7 +2426,7 @@ static int create_filter(struct trace_array *tr,
>  	if (err)
>  		return err;
>  
> -	err = process_preds(call, filter_string, *filterp, pe);
> +	err = process_preds(call, filter_string, *filterp, pe, is_perf);
>  	if (err && set_str)
>  		append_filter_err(tr, pe, *filterp);
>  	create_filter_finish(pe);
> @@ -2418,7 +2439,7 @@ int create_event_filter(struct trace_array *tr,
>  			char *filter_str, bool set_str,
>  			struct event_filter **filterp)
>  {
> -	return create_filter(tr, call, filter_str, set_str, filterp);
> +	return create_filter(tr, call, filter_str, set_str, false, filterp);
>  }
>  
>  /**
> @@ -2476,7 +2497,7 @@ int apply_event_filter(struct trace_event_file *file, char *filter_string)
>  		return 0;
>  	}
>  

The permission has to be found here or the one below. 


> -	err = create_filter(file->tr, call, filter_string, true, &filter);
> +	err = create_filter(file->tr, call, filter_string, true, false, &filter);
>  
>  	/*
>  	 * Always swap the call filter with the new filter
> @@ -2721,7 +2742,7 @@ int ftrace_profile_set_filter(struct perf_event *event, int event_id,
>  	if (event->filter)
>  		return -EEXIST;
>  

If perf can profile ftrace function events, then it can get the KASLR
offset. This patch does not protect it.

-- Steve


> -	err = create_filter(NULL, call, filter_str, false, &filter);
> +	err = create_filter(NULL, call, filter_str, false, true, &filter);
>  	if (err)
>  		goto free_filter;
>  
> @@ -2868,7 +2889,7 @@ static __init int ftrace_test_event_filter(void)
>  		int err;
>  
>  		err = create_filter(NULL, &event_ftrace_test_filter,
> -				    d->filter, false, &filter);
> +				    d->filter, false, false, &filter);
>  		if (err) {
>  			printk(KERN_INFO
>  			       "Failed to get filter for '%s', err %d\n",
> 
> base-commit: 602042bf29f6efde39cfb5fdd9289bf4854bc0c5

