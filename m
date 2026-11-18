Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795033946;
	b=YKS4vMDc+bAByx/DWBYLR5Az/cfVdLRwLJuO/4/+ViVmGaojaf/2rzGPmS+GHReUAkCm
	 choiMcNXW4Mrnp2rGQHAtg+T76JutzKSLLVbNWCldx5MkexgzPnzHg9zVRUusLRrVyf6P
	 V1gac6GmAtuTGyZGKClMYsWtwpQkNGYO6wiEFdwhO2/JTmlvny7qL2rzpem+uUqsBxeS1
	 oPuWAF3iVcUfcuCmGE7zLaGSg1OJCvONrqWzbPilPm5OJQo2eVr26aSpvt5oYYxUa0oJj
	 8MfimsAXFMTWrPiI082epAqR2KHX38jTUn1nfy8GdHMQG1zCx8N+Mvpj85iDysgNRIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795033946;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=oKvaPy0lIh3ckFW6p5LBHOOwcup0EIqtLrLFD9khroo=;
	b=1pjv6VcjZvj6rOWZE+k9G5kTkjP73ARJTpPcHQXf+QvrnmK6Cs/3a4RvIju0py7DxiII
	 UzSpMfpLHfqYzNMJwg0pAr6B9y4zx3hvN/RyIX5DsIYf6cPcaw4RrzWqgpfsJiudaSfDV
	 XZtwVcDa7B9NTm/d42NMRWEbdhocqTs8KkuEee1IPZpkmwtceimmA/ZQc4WYzJdiNUXvo
	 q2+xVoO3zFTCXo4h4CujKmqri+Spa2gZ5E2XNRJN+Mt4sstNqyBLVrChzbzaYvK9+7Ly7
	 WqFHBXTNa3w/GF4qWoxbfG4So296DrPXPer/D7WohDXjaxg286W6Z0w8lebTpFSG3VA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=h8EKwDq7;
	arc=none smtp.remote-ip=216.40.44.13
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C16E606A31C;
	Wed, 18 Nov 2026 20:32:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C16E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=h8EKwDq7
Received: from omf18.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 8410C4086E;
	Wed, 18 Nov 2026 20:32:23 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id B1A7833;
	Wed, 18 Nov 2026 20:32:21 +0000 (UTC)
Date: Wed, 18 Nov 2026 15:32:20 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: David Carlier <devnexen@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] tracing: Reject .function on the function trace event
Message-ID: <20261118153220.15542786@gandalf.local.home>
In-Reply-To: <20261114195914.2678414-1-devnexen@gmail.com>
References: <20261114195914.2678414-1-devnexen@gmail.com>
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
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: B1A7833
X-Stat-Signature: q9faisecotch4ibgz7tjniy1wnrgd7ko
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/AM9kBChS00RDKpvMDzSCB8eK9Xxc9hgk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=oKvaPy0lIh3ckFW6p5LBHOOwcup0EIqtLrLFD9khroo=; b=h8EKwDq73i9O4XxvjwmIisd2ObSMhM/rCdn2aNwHMwiaUBUVzd1xnIYak7UjweEGnrw9AB964qLOmc172QNEB3tE11E9FSkk98njsbGZPQs1ARZS6hNvl6Fmy+QUk7M5EdPHLcRh8LX/SI40JU7btkc2DhyrykM1SodiaVyVmfk=
X-HE-Tag: 1795033941-994633
X-HE-Meta: U2FsdGVkX18+9pwbS/sGlAPJpJbi0SLDIvZuhM7I8xhRlVTz292KWaqeIr2lUnAb5eEZQT0JqEo8i//AakzknduJOD3KTyvskFDnzHEJWQZBBn6AoxR4wI3NLt/maduHUMOUpWRP8y4EIKTv9rNYKrpPmcWUXajl2SM0nmWoW1ivc1ebwUXXHx7Sn2DZvsJllRepfhBWqCuOpKGj71ZiF6K4D1cTE9enzEvruWQRHv5YuY3uBIwg7kWHJu4hJopxMjgargA72phWfYX6afM76rNvJj7ReZZsQgsQbt5AvhJzAYj3Fr8VRWUxNghDggTQvKEce+i1qyitC2LizOfq8S+eU5x8vAUGQ7iELSx+UtJoMw9qaW7ZV7ggrA/6k2X+KIFbnMTiBCs=

On Sat, 14 Nov 2026 19:59:14 +0000
David Carlier <devnexen@gmail.com> wrote:

> For the function event, parse_pred() handles the .function suffix
> before the ftrace_event_is_function() case, so "ip.function == schedule"
> builds a predicate with no regex. Setting it through perf then
> dereferences the NULL pred->regex in ftrace_function_set_filter_pred().
> 
> The "ip" field of that event already takes a function name, so reject
> the suffix there.
> 
> Fixes: e6745a4da964 ("tracing: Add a way to filter function addresses to function names")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  kernel/trace/trace_events_filter.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
> index c10951bcfc5f..11bb751c4388 100644
> --- a/kernel/trace/trace_events_filter.c
> +++ b/kernel/trace/trace_events_filter.c
> @@ -1743,6 +1743,12 @@ static int parse_pred(const char *str, void *data,
>  	pred->op = op;
>  
>  	if (function) {
> +		/* Function events already take a function name on 'ip' */
> +		if (ftrace_event_is_function(call)) {
> +			parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP, pos + i);
> +			goto err_free;
> +		}
> +
>  		/* The field must be the same size as long */
>  		if (field->size != sizeof(long)) {
>  			parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP, pos + i);

Instead of rejecting it, why not just ignore it?

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index a1c298210059..e64c44ab3ee5 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1742,7 +1742,9 @@ static int parse_pred(const char *str, void *data,
 
 	/* See if the field is a kernel function name */
 	if ((len = str_has_prefix(str + i, ".function"))) {
-		function = true;
+		/* Ignore if event is already a function */
+		if (!ftrace_event_is_function(call))
+			function = true;
 		i += len;
 	}

The above fixes the issue as well, and allows things to work as expected. 

-- Steve
