Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFF229B795;
	Tue, 15 Sep 2026 08:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789462416; cv=none; b=MOi9qYpqpX8XteBFV1vbdMJ3NayeWbS3/vSM4iN+S6OTwlkXYGGWHJY/ECUuXSEaoKvytt8/+2Wbcfo5cHrw79PGrrD2sxp3gypMJlrfwbGvjRx9hc2LRB0esMMUWSFBBp1jWHNU5ocM5lHEdOzN6CQBF6RyGrAll50LVdNMb8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789462416; c=relaxed/simple;
	bh=SS5rddX69DGcsfgz2G/1cA5l1EzEzoK6HPfY4ZlNrus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXLX+DC6OX/8bs5+yUjns0TFdxSsB34bwBoTfSjckcWTDZnq5VDzV5llaGe/A/rMrQ6IejJvYkcFiuFAd7kUZnyLzf3GzgipcJiZ0K435CIfxSVtiSZjyVrQrs6mSlMqilgOvWlvM+yDPNKiLxfWZXoA1fT44wobMQXiFXsYL+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from martin by akranes.kaiser.cx with local (Exim 4.98.2)
	(envelope-from <martin@akranes.kaiser.cx>)
	id 1x6Oun-00000002mtl-3hcx;
	Tue, 15 Sep 2026 10:53:21 +0200
Date: Tue, 15 Sep 2026 10:53:21 +0200
From: Martin Kaiser <martin@kaiser.cx>
To: David Carlier <devnexen@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] fprobe: Clear the unused part of the fgraph_data
 reservation
Message-ID: <aqkHgVWqa5Lp0PWd@akranes.kaiser.cx>
References: <20260911195559.230709-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911195559.230709-1-devnexen@gmail.com>
Sender: "Martin Kaiser,,," <martin@akranes.kaiser.cx>

Thus wrote David Carlier (devnexen@gmail.com):

> fprobe_fgraph_entry() reserves shadow stack space for every fprobe with
> an exit handler, but only fills it for those whose entry handler returns
> 0. fprobe_return() walks the whole reservation, so the unused tail is
> parsed as stale headers from an earlier call, and an exit handler can
> run twice or despite its entry handler asking to skip it.

> The original memset cleared only (reserved_words - used) bytes, and
> commit e0a384434ae1 ("tracing: fprobe: do not zero out unused
> fgraph_data") removed it. Clear the whole tail.

So we're back at

https://lore.kernel.org/all/20260323104818.0ad25dd5@gandalf.local.home/s

where Steven says

"So fgraph_data is only used internally between the fprobe_fgraph_entry()
and fprobe_return() as it only exists on the fgraph shadow stack. I'm not
even sure if the unused portion needs to be zeroed out."

Looking at this again, it seems to me that your patch makes sense.
AFAICS, fgraph_reserve_data may return memory with dangling data from a
previous call of the traced function.

Best regards,
Martin

> Fixes: 4346ba160409 ("fprobe: Rewrite fprobe on function-graph tracer")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  kernel/trace/fprobe.c | 4 ++++
>  1 file changed, 4 insertions(+)

> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index 1e9b00997ff2..bd84a982961a 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -635,6 +635,10 @@ static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops
>  		}
>  	}

> +	/* Clear unused slots so fprobe_return() does not see stale headers. */
> +	if (used < reserved_words)
> +		memset(fgraph_data + used, 0, (reserved_words - used) * sizeof(long));
> +
>  	/* If any exit_handler is set, data must be used. */
>  	return used != 0;
>  }
> -- 
> 2.55.0

