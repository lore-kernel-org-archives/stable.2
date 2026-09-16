Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823864AC148;
	Wed, 16 Sep 2026 23:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789600137; cv=none; b=pdFGAqz6sV1eftW6wQEmf/pTAokAUxo4Osc97V3wx638XyIQ8WiQAqDp4lPHY3qaj90G5HQrJ50o0iHqhDASKVp71UkW3CRk2wsN2Bnn/1nNWOXQZaMSe9FzXgQitThUqGixJqEGdCu6Qlp/UU0Brr5102gCbqTrBsuXJRvKzKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789600137; c=relaxed/simple;
	bh=GOFL7RaNXqoMY7224a/drIf5k+yrXZaqVSGLWVC2Dh0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=n38xDppDcEPa36M/6dFhJyFOjfF6A/XAEBPCWcgv2pEEI4xKmlMgQV2QHW3m1WljG+VOe4svHQbXTUuY8u+6ZOgepekAEbEVX8+91D2TBkgs8gn+1MMErnZ5mwKntIs0Mgx8R6otOHVrIG5r1CHTQqmFWzWYjKQOtHaRqFDYbiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tvi5MzsD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tvi5MzsD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C95081F000FF;
	Wed, 16 Sep 2026 23:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789600136;
	bh=I5a23cQRfcihY9WZZSlPkSoJLWnDwHQNE5jTh0BrC2Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Tvi5MzsDZyA23wpMGunHmcdfNuu+g2DISs8flBBgzZ128pbr1CNYmraftwCVELk1k
	 lAZy+Gr8TnAqMIOdoalybj+OXw3z2701U3H/1tnq6NXb4qJOJj0nNU8D5v2fIOA3rx
	 E2VcMwT01tcqykgbkfRAkhVkpdzM5MD64Zs2UAhjDHxE02id4FO2WrGBsPBy+NfvRO
	 mihtxCkLTS9iLvCfRCNW9PgmJU4hOuuZalVWnlCgyigyV3fhNXaIbgkiVxS04P7s20
	 opaPEEk1EUtpbhmzL21qa0c1F68yl8vpOivkXceiYYMQoYVP65irrdeQcO1sMYmTq/
	 bd2fr9G7AhqJw==
Date: Thu, 17 Sep 2026 08:08:51 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: David Carlier <devnexen@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Martin Kaiser <martin@kaiser.cx>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] fprobe: Clear the unused part of the fgraph_data
 reservation
Message-Id: <20260917080851.1f803eeb8afb4c1a9a847c8a@kernel.org>
In-Reply-To: <20260911195559.230709-1-devnexen@gmail.com>
References: <20260911195559.230709-1-devnexen@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Sep 2026 20:55:59 +0100
David Carlier <devnexen@gmail.com> wrote:

> fprobe_fgraph_entry() reserves shadow stack space for every fprobe with
> an exit handler, but only fills it for those whose entry handler returns
> 0. fprobe_return() walks the whole reservation, so the unused tail is
> parsed as stale headers from an earlier call, and an exit handler can
> run twice or despite its entry handler asking to skip it.
> 
> The original memset cleared only (reserved_words - used) bytes, and
> commit e0a384434ae1 ("tracing: fprobe: do not zero out unused
> fgraph_data") removed it. Clear the whole tail.

Thanks for reporting! But this does not fix the problem correctly.
See this;

static inline void read_fprobe_header(unsigned long *stack,
					struct fprobe **fp, unsigned int *size_words)
{
	*fp = arch_decode_fprobe_header_fp(*stack);
	*size_words = arch_decode_fprobe_header_size(*stack);
}

#define FPROBE_HEADER_MSB_PATTERN \
    GENMASK(BITS_PER_LONG - 1, FPROBE_HEADER_MSB_SIZE_SHIFT)
#define arch_decode_fprobe_header_fp(val) \
    ((struct fprobe *)(((unsigned long)(val) & FPROBE_HEADER_MSB_MASK) | \
                       FPROBE_HEADER_MSB_PATTERN))

So even if the *stack is zero, the *fp is not NULL.

We need to add *stack check in read_fprobe_handler()s.

Also, since the fprobe_return() exits the loop if fp == NULL,

---
	while (size_words > curr) {
		read_fprobe_header(&fgraph_data[curr], &fp, &size);
		if (!fp)
			break;
---

What we need is writing 0 to stack[used] if used && used < reserved_words
instead of memset.

> 
> Fixes: 4346ba160409 ("fprobe: Rewrite fprobe on function-graph tracer")

And this should be introduced by below commit.

Fixes: e0a384434ae1 ("tracing: fprobe: do not zero out unused fgraph_data")

Thank you,


> Cc: stable@vger.kernel.org
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  kernel/trace/fprobe.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index 1e9b00997ff2..bd84a982961a 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -635,6 +635,10 @@ static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops
>  		}
>  	}
>  
> +	/* Clear unused slots so fprobe_return() does not see stale headers. */
> +	if (used < reserved_words)
> +		memset(fgraph_data + used, 0, (reserved_words - used) * sizeof(long));
> +
>  	/* If any exit_handler is set, data must be used. */
>  	return used != 0;
>  }
> -- 
> 2.55.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
