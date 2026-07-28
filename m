Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77C246C4D2;
	Tue, 28 Jul 2026 14:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785250463; cv=none; b=QYxptYO6EdC78Lb10ES1rQb2iDuaP+nZgDa0eAml05uxIsCqEdHT2kyDtJMqiUllS8y6YHIQtEf9ZGW8fSMXsFfycV2Aaq9bvhwxVoPZEXGzKVTiRsr9aMiDkSb6OYqcDm6bQ3SuELuUMq9qCEBDNnp22p9PSTt+cp3GbkNOrbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785250463; c=relaxed/simple;
	bh=/blEOI+/koXMGIOKtbyA6wSzO33KbLQo33O11w32c2I=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RtkdQYVup9CVb5X9aIexgaZBq5F4ltYg2GkvZsy8hGnD9yoLF09Mn1Cz4QRSSl5Y0sfz/n9+7o4rGkfGTkLcEyD0qwYAoSBH/yLaXZruXC5fBBK/wXB6nOcE8ZwiYllbHCF/qUOGhOFA/rmQeHVp7wrfOXgcx+GD154+0gzdMWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0fJK9PZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0fJK9PZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C0E61F00A3A;
	Tue, 28 Jul 2026 14:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785250461;
	bh=qBN7Me+rZGxl2PQohgAo67SUwSE3XAgiS3k3ueB+0oE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=R0fJK9PZ0BOielkzZCQBPkiyW6+orim9tNH9MKM3hu0WgL8EkXOAEo1zaGYvTgg8g
	 gCYkrJcgdSgpJRjKx01fzQ912qAa2Jb3DDPxx0inmnTgDGpSijQh98yM/O+YIjopSe
	 obP0q6cxl3G+j4pHyWH0J7w27KP8D+/xPrjwWBtAU7WjQiuL7PDz+oxJ6gcJTXB82y
	 GmCJZ2Yp/IajheIEpK+7gQKPyYhW54c62JfBCmD2WCLylw0KNGUTNKWRi5XXsw3mho
	 vvcO5FNHCTC8FSZQ58Y6LebTPvXE7EZbCrSnADSZ42tx8t2oS7oa0GMpIRH7bkoTIW
	 rV4AKTKAhzVCA==
Date: Tue, 28 Jul 2026 23:54:17 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Raushan Patel <raushan.jhon@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] tracing/fprobe: Roll back on enable_trace_fprobe()
 failure
Message-Id: <20260728235417.67604155d14d30094d6fd100@kernel.org>
In-Reply-To: <20260724064208.480030-1-raushan.jhon@gmail.com>
References: <20260724064208.480030-1-raushan.jhon@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jul 2026 12:12:08 +0530
Raushan Patel <raushan.jhon@gmail.com> wrote:

> enable_trace_fprobe() sets the file link or the TP_FLAG_PROFILE flag and
> then registers each trace_fprobe in the probe list. If
> __register_trace_fprobe() fails partway through, the function returns
> immediately without unregistering the trace_fprobes it already registered
> or undoing the file link / flag it set, leaving the event half-enabled and
> leaking the registered fprobe(s).
> 
> enable_trace_kprobe() already handles this with a rollback path. Do the
> same for fprobe: on failure, unregister all probes and clear the file link
> or profile flag.
> 

OK, looks good to me.

Thanks!

> Fixes: 334e5519c375 ("tracing/probes: Add fprobe events for tracing function entry and exit.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Raushan Patel <raushan.jhon@gmail.com>
> ---
>  kernel/trace/trace_fprobe.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
> index 9f5f08c0e7c2..3120403a5b60 100644
> --- a/kernel/trace/trace_fprobe.c
> +++ b/kernel/trace/trace_fprobe.c
> @@ -1481,11 +1481,21 @@ static int enable_trace_fprobe(struct trace_event_call *call,
>  		list_for_each_entry(tf, trace_probe_probe_list(tp), tp.list) {
>  			ret = __register_trace_fprobe(tf);
>  			if (ret < 0)
> -				return ret;
> +				goto err;
>  		}
>  	}
>  
>  	return 0;
> +
> +err:
> +	/* Failed to enable one of them. Roll back all */
> +	list_for_each_entry(tf, trace_probe_probe_list(tp), tp.list)
> +		__unregister_trace_fprobe(tf);
> +	if (file)
> +		trace_probe_remove_file(tp, file);
> +	else
> +		trace_probe_clear_flag(tp, TP_FLAG_PROFILE);
> +	return ret;
>  }
>  
>  /*
> -- 
> 2.53.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
