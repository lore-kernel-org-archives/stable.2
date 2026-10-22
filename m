Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792655423;
	b=IbGBplcAK3xppl25SLRhFBuqVVl6jirXu7bx2pqNtBlp860oDPfIvFpQid5YtkElmX9v
	 ydMBXmA/FT2cSLbeBukE+NdpbBAAA34w/FbC2CIvFAgSutCsjogPjwupZbTEYpYoUCZnT
	 tLv7PCOKxaHZc3BK3LauQpM7WrS6RJS7QOrzjzInaY+zxPPNR6tySDteTmOHpQTeOT1OQ
	 5RXQT3/W3FvFwNg4v8gY0sUpH+tIyjOfUVP/ByTL33Gn0My10bwnYNr8Kt7+Cvff5gt0V
	 oRNtuTXK9K93U0jf2O/3VBiUUb/1Pd93BYmHdi6XdAqtyvZDu9MnOH16VPCA7qV8n9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792655423;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=e9y/B98B53XepG7Kbbw67L5Vu6aVQaPU44qj1hKmGys=;
	b=00aTXQ8lBv4gpSHJtVuhcbEExqmhmFH20CTXgqW0DnibGs9xtmx9FsYcOoB/KOP66TL5
	 zS2O7z9J9aIt4fVxls6R2d3nXrh5Ws6fWXPwJGYSLLYAT4mtZTohl1L+lUxsGp3Drianp
	 yvJx22XCQa3BUUfdC05OZmbZ5i1OpfVhol7nc0g2ckFvI6WkYsOBfNX0ZK4TGwsPtB1+5
	 W+z69+DOeV0oN1oFCjUOFevsznFxE3p8nTPh8OaFfBhMKAR7C6cszrceQH4SvSp7wL0UT
	 TwuMzNZJII/JfQrh8lIhooALCzrr1eZSyliISYw7IcVmfz0vNmSv3NXoEQj2lUwf3KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F3+s+32z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD76B606A320
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 07:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F3+s+32z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E7931F000C1;
	Thu, 22 Oct 2026 07:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792655422;
	bh=e9y/B98B53XepG7Kbbw67L5Vu6aVQaPU44qj1hKmGys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F3+s+32zZBSpBeWadtWy+igWqZy9gN7nv76P280GZobJYE/smQ7yntzVv+1qszMF2
	 OoamCIfv+kG41SgGZAayu4ANAcpkq2yfQ8V7jQebZe90Um3VHChHn1ulleJXa0hVxV
	 sBRMLRMLQ9FEn6ljklgv4bT9hxjjfjbC9wadXwAepjVacxdv91Lop8eEq1KsJBxUFF
	 RN7Ha94PD0rRGNQslCKX4UQsTDuAAeLGMKY5iaXZC2t+WS3gEnu+Nby1NRB65IB780
	 kv3qMNfZOGSzNfAs31XY63ORMWpQzA5UfSga0oNdBx5FO4HKZqHiFTvE0pq3E+P2Pd
	 0toP5L01/15Zw==
Date: Thu, 22 Oct 2026 08:50:18 +0100
From: Lee Jones <lee@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 6.1.y] tracing/histograms: Reject non-stacktrace fields
 for synthetic stacktrace fields
Message-ID: <20261022075018.GJ1795367@google.com>
References: <2026102125-surely-nastily-2d17@gregkh>
 <20261021153403.303474-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021153403.303474-1-sashal@kernel.org>

On Wed, 21 Oct 2026, Sasha Levin wrote:

> From: Lee Jones <lee@kernel.org>
> 
> [ Upstream commit a244c241593b5b38a08f0df2cb43c26574efbdcb ]
> 
> In check_synth_field(), when a synthetic event field is a stacktrace
> (field->is_stack) and the histogram field is not a "long[" stacktrace
> array, validation falls through to the generic size and signedness
> comparison.
> 
> Because parse_synth_field() sets a stacktrace field's type to
> "__data_loc unsigned long[]", its size is sizeof(u64) and
> synth_field_signed() marks it as signed.  Consequently, any 8-byte
> signed scalar histogram field passes the fallback check, and its scalar
> value is subsequently dereferenced as a kernel stacktrace pointer in
> get_field_size() and trace_stack().
> 
> Furthermore, checking strstr(hist_field->type, "long[") is insufficient
> because tracepoint fields defined with __bitmask() or __rel_bitmask()
> also have type "__data_loc unsigned long[]" or "__rel_loc unsigned
> long[]", whilst create_hist_field() treats them as 4-byte scalar values
> without HIST_FIELD_FL_STACKTRACE.
> 
> Propagate HIST_FIELD_FL_STACKTRACE to variable references and field
> variables (whilst excluding variable aliases from per-element
> stacktrace capture), and reject any mismatch between
> HIST_FIELD_FL_STACKTRACE and field->is_stack in check_synth_field().
> 
> Cc: stable@vger.kernel.org
> Fixes: 00cf3d672a9d ("tracing: Allow synthetic events to pass around stacktraces")
> Link: https://patch.msgid.link/20261013112449.1006088-1-lee@kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> [ sashal: Retained string-only buffer conditions because histogram stacktrace-variable support is absent. ]

Nice.  Thanks Robo Sasha!

> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  kernel/trace/trace_events_hist.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 40d9de933fc85..f04037d01bdd7 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -2067,7 +2067,8 @@ static int init_var_ref(struct hist_field *ref_field,
>  	ref_field->size = var_field->size;
>  	ref_field->is_signed = var_field->is_signed;
>  	ref_field->flags |= var_field->flags &
> -		(HIST_FIELD_FL_TIMESTAMP | HIST_FIELD_FL_TIMESTAMP_USECS);
> +		(HIST_FIELD_FL_TIMESTAMP | HIST_FIELD_FL_TIMESTAMP_USECS |
> +		 HIST_FIELD_FL_STACKTRACE);
>  
>  	if (system) {
>  		ref_field->system = kstrdup(system, GFP_KERNEL);
> @@ -3210,6 +3211,7 @@ static struct field_var *create_field_var(struct hist_trigger_data *hist_data,
>  		ret = PTR_ERR(var);
>  		goto err;
>  	}
> +	var->flags |= val->flags & HIST_FIELD_FL_STACKTRACE;
>  
>  	field_var = kzalloc(sizeof(struct field_var), GFP_KERNEL);
>  	if (!field_var) {
> @@ -3837,7 +3839,10 @@ static int check_synth_field(struct synth_event *event,
>  	    && field->is_dynamic)
>  		return 0;
>  
> -	if (strstr(hist_field->type, "long[") && field->is_stack)
> +	if (!!(hist_field->flags & HIST_FIELD_FL_STACKTRACE) != field->is_stack)
> +		return -EINVAL;
> +
> +	if (field->is_stack)
>  		return 0;
>  
>  	if (strcmp(field->type, hist_field->type) != 0) {
> @@ -4360,7 +4365,8 @@ static int create_var_field(struct hist_trigger_data *hist_data,
>  	if (!ret && hist_data->fields[val_idx]->flags & HIST_FIELD_FL_EXECNAME)
>  		update_var_execname(hist_data->fields[val_idx]);
>  
> -	if (!ret && hist_data->fields[val_idx]->flags & HIST_FIELD_FL_STRING)
> +	if (!ret && !(hist_data->fields[val_idx]->flags & HIST_FIELD_FL_ALIAS) &&
> +	    hist_data->fields[val_idx]->flags & HIST_FIELD_FL_STRING)
>  		hist_data->fields[val_idx]->var_str_idx = hist_data->n_var_str++;
>  
>  	return ret;
> @@ -5093,7 +5099,8 @@ static void hist_trigger_elt_update(struct hist_trigger_data *hist_data,
>  		if (hist_field->flags & HIST_FIELD_FL_VAR) {
>  			var_idx = hist_field->var.idx;
>  
> -			if (hist_field->flags & HIST_FIELD_FL_STRING) {
> +			if (!(hist_field->flags & HIST_FIELD_FL_ALIAS) &&
> +			    hist_field->flags & HIST_FIELD_FL_STRING) {
>  				unsigned int str_start, var_str_idx, idx;
>  				char *str, *val_str;
>  				unsigned int size;
> -- 
> 2.53.0
> 

-- 
Lee Jones
