Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F44F470E88;
	Wed, 22 Jul 2026 19:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784749491; cv=none; b=JSrSFUmDKLc3zLwKztLmyY2681t4qjf1FsBXjaRxblG1VTVPTCe4o0VX62CpmOsfLA2aZvqgZjwWe+k9LGs4VdhRBeGCpafPDIHslg3cCPgJlSPe1pGEcXz+JBoCJrv24Z6pctBkXJ5GVfiyOYjehXyL/zflWD5w2s2iPtIKYwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784749491; c=relaxed/simple;
	bh=ovp2DkAQxSFtGdrZt3qt+dwHwhZRCL38L+KRrmFji+8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qtqiTEmwBhhM2rPWzLOElB8PMufMAHL80+M5wSh+ZVI2V6OZlnk46oSXP6u7jEzb+47AuTDoe+32ICAUT4xTzHCPbyr1mdCdKUT7R6nqF3mQ0lttAj/k0SQVODG4zaasL6mxVvLIJHauXEVWFWpEaDJPpmR7czaJX3b7V0BC55Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 4CBECC02E5;
	Wed, 22 Jul 2026 19:44:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 7718C2000F;
	Wed, 22 Jul 2026 19:44:46 +0000 (UTC)
Date: Wed, 22 Jul 2026 15:45:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Li Qiang <liqiang01@kylinos.cn>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 3/4] tracing/inject: Validate entry allocation size
Message-ID: <20260722154507.12e91c34@gandalf.local.home>
In-Reply-To: <20260722061040.112747-4-liqiang01@kylinos.cn>
References: <20260722061040.112747-1-liqiang01@kylinos.cn>
	<20260722061040.112747-4-liqiang01@kylinos.cn>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: schffwjy3mdgybjkqo3ke53sh836cime
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 7718C2000F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+7N008mxetN1tp9Jjs/q4tEwuClT3Tb9Y=
X-HE-Tag: 1784749486-677547
X-HE-Meta: U2FsdGVkX1+PUd+tprx4fpwv/ypOcQtkw5pEQkbc+8z472Wzyz9YEPw2UwG32Uo6E9pdW4sqfhiDxhRU6ufihP06O1HYdmd1uYiJ44SNV+gMO/t5/nUnZN/WeiZA3pq9L2wvfxiC274tl7bV0oLo4bpMLscZisYxSlagwyYCsXeGpePmh8JQXyMfqghH8cUHU7nxA1qhQUqz4h+V/JzaXzwGesPM1961maI1jFhNkVBKY4qBrf9f3STQFjNwNdVZdowrq7Al3t/QPPS8bFp3gzlOFuBPiV7AiiiGwp5/RYdi+f5phpCGogG5wkXAry3XA+qY413mWx6x/0gFRZlY4ssiZ2A2IhVp/Ui1YYIaAIpysBGyoA1a38dXu/BqNRLR

On Wed, 22 Jul 2026 14:10:39 +0800
Li Qiang <liqiang01@kylinos.cn> wrote:

> trace_get_entry_size() calculated the allocation from signed field offsets
> and sizes without validating their sum. A malformed event could use a

What type of malformed event are you talking about?

> negative range or overflow the calculation, allocate too little memory, and
> then write past it while initializing or populating the entry. Events with
> no fields also allocated less than a trace_entry.

What event has no fields?

Note, trace event injection is only for debugging tools that read trace
events. It is in no-way something that should *ever* be used by a
production machine.

Is this being found by AI? If it is, you must specify that.

> 
> Start at sizeof(struct trace_entry), validate each field range, and reserve
> room for the trailing NUL. Propagate sizing errors to parse_entry() before
> it initializes the allocation.

Was an AI agent used to create this?

> 
> Fixes: 6c3edaf9fd6a ("tracing: Introduce trace event injection")
> Cc: stable@vger.kernel.org

No need for the stable Cc. This is not something anyone should care about.
If you want to inject a bad event, by all means, crash your machine!
As I stated, it would be a bug to have this enabled on a production machine.

That said, I'm all for making this more robust.

> Signed-off-by: Li Qiang <liqiang01@kylinos.cn>
> ---
>  kernel/trace/trace_events_inject.c | 31 ++++++++++++++++++++++++------
>  1 file changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_inject.c b/kernel/trace/trace_events_inject.c
> index a8f076809db4..b8b141c00d5c 100644
> --- a/kernel/trace/trace_events_inject.c
> +++ b/kernel/trace/trace_events_inject.c
> @@ -135,27 +135,43 @@ parse_field(char *str, struct trace_event_call *call,
>  	return -EINVAL;
>  }
>  
> -static int trace_get_entry_size(struct trace_event_call *call)
> +static int trace_get_entry_size(struct trace_event_call *call, int *entry_size)

Why does entry_size need to be a separate parameter? Just return it, and
have a negative be an error.

>  {
>  	struct ftrace_event_field *field;
>  	struct list_head *head;
> -	int size = 0;
> +	int field_size;
> +	int size = sizeof(struct trace_entry);

Keep the upside-down declarations please.

>  
>  	head = trace_get_fields(call);
>  	list_for_each_entry(field, head, link) {
> -		if (field->size + field->offset > size)
> -			size = field->size + field->offset;
> +		if (field->offset < 0 || field->size < 0 ||

Explain to me how the field->offset or field->size can be less than zero?

> +		    field->size > INT_MAX - field->offset)
> +			return -E2BIG;
> +
> +		field_size = field->size + field->offset;
> +		if (field_size > size)
> +			size = field_size;
>  	}
>  
> -	return size;
> +	/* trace_alloc_entry() reserves an extra NUL byte. */
> +	if (size == INT_MAX)
> +		return -E2BIG;
> +
> +	*entry_size = size;
> +	return 0;
>  }
>  
>  static void *trace_alloc_entry(struct trace_event_call *call, int *size)
>  {
> -	int entry_size = trace_get_entry_size(call);
> +	int entry_size;
>  	struct ftrace_event_field *field;
>  	struct list_head *head;
>  	void *entry = NULL;
> +	int ret;
> +
> +	ret = trace_get_entry_size(call, &entry_size);
> +	if (ret)
> +		return ERR_PTR(ret);
>  
>  	/* We need an extra '\0' at the end. */
>  	entry = kzalloc(entry_size + 1, GFP_KERNEL);
> @@ -202,6 +218,9 @@ static int parse_entry(char *str, struct trace_event_call *call, void **pentry)
>  	int len;
>  
>  	entry = trace_alloc_entry(call, &entry_size);
> +	if (IS_ERR(entry))
> +		return PTR_ERR(entry);

Why this change? trace_alloc_entry() returns NULL on error. The above chunk
broken.

-- Steve


> +
>  	*pentry = entry;
>  	if (!entry)
>  		return -ENOMEM;

