Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17244347FCD;
	Wed,  7 Oct 2026 04:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791346788; cv=none; b=io/hY7PvcGtfHc8IaHggQEAfESWU8OLhehyaA/3b5xNmrdZm0cP7obXzIlOHmPKrnBU12gmkPA5qTGKPGVrHiDLnutQth85eAaU3uupCF6S7erdEVJGZ2ZItOt5tENYVPr888SmE8xvwGWtZ9U0TcMLRqbPSjYG88WuxBMbiBgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791346788; c=relaxed/simple;
	bh=rF6Atx0QB+IRloEnSYn8db/75iSHktfOLfZaskW82sQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-Id; b=GIQIoN8aUsTvXCuAVEJPgA9uDyBSLnfRlhFpBumbsAl5RP32gF3qmg4jTcSxdwlpyiNdkH6gbV+lzwn5y7Rrd2jtT6zT4N0tHAWSLZJznpN9C7n17b5MxIQQ0LOA+XM48KrXNLVyvooel5eoMx43r3JeaE0E42SSB3rqD26ngHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/gU3J7H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/gU3J7H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D5151F0089B;
	Wed,  7 Oct 2026 04:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791346786;
	bh=DFSi2Wk0MvpE9fCPPDSt7iv3uIUllMCpxznmfG9s3vc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j/gU3J7HuXc7irqCXpZ9/sr3dGZgJ956/GIFFBrYb/zHuTj2VBsAX9NUcYVal9hc5
	 QOcjSEhsusgR8t1FJLfL0EScXWI9NtKHf/iVWgR/H5CJfK9sFGW2k22oVFc8OGv9yg
	 F00e60iqGX8wUrJlXwiJOSUx4UZ3jaGNutfvBzpY6ZRur2GaMkqjw5qRGmxq+sN3nN
	 II/eIy6xoNSEm4lGQ60sTYqUcMkP5igUSoDyAr693QdOHHJX6l2AWNE74Pyyo6lL8/
	 2GVTzmo7VB9w0WL0MGuz5Mu+UENYBE453Fsy+tMPQW6aJEMvzmSKgBrwTGILIZA2l6
	 tI72r7wdoO9XA==
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: kylebot@openai.com
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, mhiramat@kernel.org, outbounddisclosures@openai.com,
 Kyle Zeng <kylebot@openai.com>, stable@vger.kernel.org
Subject:
 Re: [PATCH] tracing/filters: Treat zero-length dynamic strings as empty
Date: Wed, 07 Oct 2026 04:19:41 +0000
In-Reply-To: <20261006225642.58778-1-kylebot@openai.com>
References: <20261006225642.58778-1-kylebot@openai.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20261007041944.6D5151F0089B@smtp.kernel.org>

On Tue, 06 Oct 2026 15:56:42 -0700, Kyle Zeng <kylebot@openai.com> wrote:
> The regex callbacks use a length of zero for NUL-terminated strings of
> unknown size, such as the trailing buffer in a trace_marker record.
> However, filter_pred_strloc() and filter_pred_strrelloc() pass the length
> from a data locator directly to those callbacks. A zero-length locator
> has no data and need not point at a NUL byte.
>
> In particular, syscall entry events can contain an empty captured array
> or a failed user-string copy. Matching such a field with an equality,
> prefix, or substring filter can read beyond the record. The per-CPU perf
> trace buffer is reused, so an unprivileged counting syscall event can
> disclose bytes left by a previous kernel tracepoint even when raw
> sampling is denied and exclude_kernel prevents counting that tracepoint.
>
> Handle both locator formats through a common helper. For a zero-length
> field, pass an empty string and its actual size to the regex callback.
> This gives all matching modes the empty-string semantics without reading
> the locator's target. Keep nonzero fields and the legacy trace_marker
> unknown-length convention unchanged.
>
> Fixes: 10f20e9f9da9 ("tracing: Have zero size length in filter logic be full string")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-6-astra

nit:
Assisted-by: LLM

> Signed-off-by: Kyle Zeng <kylebot@openai.com>

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> ---
>  kernel/trace/trace_events_filter.c | 38 +++++++++++++++++++-----------
>  1 file changed, 24 insertions(+), 14 deletions(-)
>
> diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
> index 2b46ca536045..02aaa92e0361 100644
> --- a/kernel/trace/trace_events_filter.c
> +++ b/kernel/trace/trace_events_filter.c
> @@ -884,6 +884,25 @@ static int filter_pred_pchar_user(struct filter_pred *pred, void *event)
>  	return filter_pchar(pred, str);
>  }
>  
> +static __always_inline int filter_dyn_string(struct filter_pred *pred,
> +					     char *str, int len)
> +{
> +	int cmp;
> +
> +	/*
> +	 * The regex callbacks use zero for an unknown-length, NUL-terminated
> +	 * string. A zero-length data_loc or rel_loc field has no bytes at all.
> +	 * Match an empty string instead of reading past the end of the field.
> +	 */
> +	if (!len) {
> +		str = "";
> +		len = 1;
> +	}
> +
> +	cmp = pred->regex->match(str, pred->regex, len);
> +	return cmp ^ pred->not;
> +}
> +
>  /*
>   * Filter predicate for dynamic sized arrays of characters.
>   * These are implemented through a list of strings at the end
> @@ -900,13 +919,8 @@ static int filter_pred_strloc(struct filter_pred *pred, void *event)
>  	int str_loc = str_item & 0xffff;
>  	int str_len = str_item >> 16;
>  	char *addr = (char *)(event + str_loc);
> -	int cmp, match;
> -
> -	cmp = pred->regex->match(addr, pred->regex, str_len);
>  
> -	match = cmp ^ pred->not;
> -
> -	return match;
> +	return filter_dyn_string(pred, addr, str_len);
>  }
>  
>  /*
> @@ -923,13 +937,8 @@ static int filter_pred_strrelloc(struct filter_pred *pred, void *event)
>  	int str_loc = str_item & 0xffff;
>  	int str_len = str_item >> 16;
>  	char *addr = (char *)(&item[1]) + str_loc;
> -	int cmp, match;
> -
> -	cmp = pred->regex->match(addr, pred->regex, str_len);
>  
> -	match = cmp ^ pred->not;
> -
> -	return match;
> +	return filter_dyn_string(pred, addr, str_len);
>  }
>  
>  /* Filter predicate for CPUs. */
> @@ -1014,7 +1023,8 @@ static int filter_pred_function(struct filter_pred *pred, void *event)
>   *
>   * @str: the string to be searched
>   * @r:   the regex structure containing the pattern string
> - * @len: the length of the string to be searched (including '\0')
> + * @len: the length of the string to be searched (including '\0'), or zero
> + *       for a NUL-terminated string of unknown length
>   *
>   * Note:
>   * - @str might not be NULL-terminated if it's of type DYN_STRING
> @@ -1023,7 +1033,7 @@ static int filter_pred_function(struct filter_pred *pred, void *event)
>  
>  static int regex_match_full(char *str, struct regex *r, int len)
>  {
> -	/* len of zero means str is dynamic and ends with '\0' */
> +	/* Zero is reserved for a NUL-terminated string of unknown length. */
>  	if (!len)
>  		return strcmp(str, r->pattern) == 0;
>  
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
