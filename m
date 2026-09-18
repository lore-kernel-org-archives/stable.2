Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D86352F95;
	Fri, 18 Sep 2026 00:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789689645; cv=none; b=Ors1ohWRXCL9dCLLjwuXR4VlgvltyO34Pap7By95XTe8ykSODIAtA/CHwkuDiajrcnHwi5ApZlrSWnTpppFEsdMxlwZ8AgjxC/G982oq+eJphZlZmPORFalyGo0SM/RhEYU1agxv7hJE7BR01t4Ay8A0S7INP/IYDC3wjnl9ZA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789689645; c=relaxed/simple;
	bh=rl1IPRYrZA5ZJXNeyvLPx6hLjnGt6ykbVMhqaWryNHs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fzD/4AN3nsy/Mpc9kRE5iOg8TknFjnyKatYm49S2D99U3xhwgt70QdfhCnHGzhFTbtrX7YadK5+Z7xyCHsI3OJ+No6XHDJKmJ1A2mGtRWzzBWdawxXgnrfSklvw+mh3Po3f71lW4Zo8MDD9TLivrUXn8aDjqhFHTsxJHE0q045A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LOXsPO3G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LOXsPO3G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C11C1F000FF;
	Fri, 18 Sep 2026 00:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789689643;
	bh=Pwy7lAr6hzhWtQyhO2xpyNkZkRHrhmyKH1VIR30q6HI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LOXsPO3G/AuiYSmXUV0aQv0HKHJcfm7TTeqn/rWxKV/RGlyKCSkC4eEiw/jZNULds
	 khyrc9CGPyI/hebp7OxaXnDSdXmqEjRc4n5kP/L55S2auvWX7ATFJlnEYNmNX+6mSJ
	 r6Ii0Q2pB77KlXXUIYJD3/3Lg7puEuDsM5+MKuVIBi8ZFzpuBpuVv2wCo7GCEFe23f
	 G24V+HAoiz+U+UrABUeuaMbFHwHe4XIEuza/9VvfuUvI1AxJkNn2pGYZJXwzwQfKZv
	 pDbS0sqoCrVfNhB4B0IhsKsNVo2fwA5KPLExzI2heOOBQ5TaPLRSU9NeufO+EV7ixn
	 WKa2M9EGLLjXg==
Date: Fri, 18 Sep 2026 09:00:38 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: David Carlier <devnexen@gmail.com>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com, martin@kaiser.cx,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] fprobe: Terminate the fgraph_data list when the
 reservation is not filled
Message-Id: <20260918090038.8bb79d5b132ea82846a4c9c5@kernel.org>
In-Reply-To: <20260917212407.384468-1-devnexen@gmail.com>
References: <20260917212407.384468-1-devnexen@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 22:24:07 +0100
David Carlier <devnexen@gmail.com> wrote:

> fprobe_fgraph_entry() reserves shadow stack space for every fprobe with
> an exit handler, but only fills it for those whose entry handler returns
> 0. fgraph_reserve_data() does not clear the area, so fprobe_return()
> parses the unused tail as headers left over from an earlier call, and an
> exit handler can run twice or despite its entry handler asking to skip
> it.
> 
> Write a zero word after the last entry to terminate the walk. A zeroed
> slot does not decode to a NULL fprobe on the arches that encode the
> header into one unsigned long, since arch_decode_fprobe_header_fp() ORs
> in FPROBE_HEADER_MSB_PATTERN, so make read_fprobe_header() return NULL
> for a zeroed slot.
> 

This fix looks good to me. Let me pick this.

Thanks!

> Fixes: e0a384434ae1 ("tracing: fprobe: do not zero out unused fgraph_data")
> Cc: stable@vger.kernel.org
> Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  kernel/trace/fprobe.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index 1e9b00997ff2..9f2d98181779 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -171,6 +171,11 @@ static inline bool write_fprobe_header(unsigned long *stack,
>  static inline void read_fprobe_header(unsigned long *stack,
>  					struct fprobe **fp, unsigned int *size_words)
>  {
> +	if (!*stack) {
> +		*fp = NULL;
> +		*size_words = 0;
> +		return;
> +	}
>  	*fp = arch_decode_fprobe_header_fp(*stack);
>  	*size_words = arch_decode_fprobe_header_size(*stack);
>  }
> @@ -203,6 +208,12 @@ static inline void read_fprobe_header(unsigned long *stack,
>  {
>  	struct __fprobe_header *fph = (struct __fprobe_header *)stack;
>  
> +	if (!*stack) {
> +		*fp = NULL;
> +		*size_words = 0;
> +		return;
> +	}
> +
>  	*fp = fph->fp;
>  	*size_words = fph->size_words;
>  }
> @@ -635,6 +646,10 @@ static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops
>  		}
>  	}
>  
> +	/* Terminate the list, fgraph_reserve_data() does not clear it. */
> +	if (used && used < reserved_words)
> +		fgraph_data[used] = 0;
> +
>  	/* If any exit_handler is set, data must be used. */
>  	return used != 0;
>  }
> -- 
> 2.55.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
