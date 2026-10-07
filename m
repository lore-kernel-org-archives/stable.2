Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABB4448BA7;
	Wed,  7 Oct 2026 08:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791360136; cv=none; b=bt3Du/fvROwtbnf9/o5NAQw6nxN0CDqZ3Rdi5GNbi9gmovcwhsZ8fjA+WA8ce4nkJlsuU4qt/pl/vNUpRtWCr3gMWUCihKuJbXllwTFldjkl1IerlLbc36kS8mVaOmmk1KCJVDyk+gs1ANqZpdOncJfzT/6Q7WpDKbmRGeqeZxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791360136; c=relaxed/simple;
	bh=f60JLRw+MLGOUJzsOmgTN77ebFm2WAWFTeQfDVywaJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-Id; b=iEniq4UpojWbOuj7bHwntrG51Dd34FT7o/a5xBDrL2aCC87RhX/8fqcRj33PqbKyfB8XoGhk5ftrsncNxTOjcRRtvKjZdeu+vI26OjOUxLfytQzRtZDe18h1Act2xckYlyiq97rT7cPPjfEPHqI74delzHg/8y7NZntR6qjU7KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLR+KYTw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLR+KYTw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A0C1F0089B;
	Wed,  7 Oct 2026 08:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791360117;
	bh=5gB7RfAkOdEGSFhOWLgi6YsJKhGW3gY2uSHOIE2J6CU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QLR+KYTwtN55hXcSxDOrqv4w3ESBqZooi+MQ2+e+ySuhme3zNGjA9dltGbvrYFrCV
	 9yx4AxlEI0JwThWpmN0exz2Ggvb0HTZMerFAYW9baV5N8RGh6ZoQviVgBdYVPYSvMh
	 +0wiS/SL80UNvzexs4UgfENMW9FehcB1eHonNYpYQM1S4HVbB0QMVlkkX12eLJgv7L
	 szt9iMHwudZJBCYMcnWr8cESnLJ8HThtJz/QgOxV8dwdlixPXIuGUAVpGbem/slJPt
	 c6t2HoXXY/yRPpawhNigfwn7tSDDH3g6ibfriTxQ6FG3GACE0M/Eg6H8jtXgUZHo0Z
	 DeKiyoo5ePuaw==
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: kylebot@openai.com
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, mhiramat@kernel.org, outbounddisclosures@openai.com,
 Kyle Zeng <kylebot@openai.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] tracing/filters: Check perf permissions before
 accessing kernel data
Date: Wed, 07 Oct 2026 08:01:53 +0000
In-Reply-To: <20261007050315.65139-1-kylebot@openai.com>
References: 20261007050315.65139-1-kylebot@openai.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20261007080155.F2A0C1F0089B@smtp.kernel.org>

On Tue, 06 Oct 2026 22:03:15 -0700, Kyle Zeng <kylebot@openai.com> wrote:
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

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
