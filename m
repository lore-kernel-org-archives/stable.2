Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2593A2222AC;
	Wed,  7 Oct 2026 05:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791352348; cv=none; b=jOQR2F91EZs1+BLEqBn5HG3PlNIlZjvPa2PT+uDppx4AB3saCwLBiSzV5na4zD2aq/J4N8lBqie9iSOZXXfjBp84mE4F9Pb4ugPXgohBhuaYyc1E5wxMoVW8U0H/AfT+38qjUJ1kwD+pv9v9ZxQ/q9Y615P/oEF5lJhIHbngtZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791352348; c=relaxed/simple;
	bh=eNXwv+3bE7EFysSqOx3zsqS83s03c53nR6/ozfz8bS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-Id; b=gJkglBpr7LP0XTy3ruRTCLW6gDey57JmLsvpsW4tDD0lbsUT0c3qj9uc9uUFlpwx7kAhZgySN/PIiBTXQqNnZsEmd9+tBxeYi0XEl4E9QUqAT0mxiQRbopw6iicypijwzWfATDVjZKbkE0RthQwCQ/bgym6nZkNr625kjYuhlB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fx4KgWOu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fx4KgWOu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32DDA1F0089B;
	Wed,  7 Oct 2026 05:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791352346;
	bh=GdjMU9k4F7x6/rjAjbdSug09OfCl1IVYHFb5BuvL2WQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fx4KgWOu7/o+l1XmH6yfTVogKylmJu6db7QQUpA8y9thPFEJNkDfzA/5bVgD0RSPL
	 m2opzykxD8LL6O2vQZDv9cPTWLcF7foaTNGAZiEB+J5Yie01Exd4gQpaxHZeP4p4kO
	 GFXmMkqOvj6eO2edw0KCN9dicFTa9/7aqi9UQECfaCUx9VXxLSRb251iMiddQZZwAi
	 fcgzWcPkFlZRw55eJZlRmkRn3zNhIaYq3pf1W2GCh9wHpMFQG1tJ7U2o1wWDPfKaI5
	 GV6xALy2szBWDZhAUgDdOCVq06W8BfJEGjcXqhKOFNijyZJ7pBITPbFzfUHBHS8t+f
	 qljgZzsZle6JA==
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: kylebot@openai.com
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 outbounddisclosures@openai.com, stable@vger.kernel.org
Subject: Re: [PATCH] tracing/filters: Check perf permissions before resolving
 .function
Date: Wed, 07 Oct 2026 05:52:22 +0000
In-Reply-To: <asXAxf0edslJI-Ge@com-75606>
References: 20261006225112.53503-1-kylebot@openai.com
 20261007034423.310311F0089B@smtp.kernel.org asXAxf0edslJI-Ge@com-75606
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20261007055225.32DDA1F0089B@smtp.kernel.org>

On Tue, 06 Oct 2026 20:47:17 -0700, Kyle Zeng <kylebot@openai.com> wrote:
> On Wed, Oct 07, 2026 at 03:44:20AM +0000, Masami Hiramatsu wrote:
> > On Tue, 06 Oct 2026 15:51:12 -0700, Kyle Zeng <kylebot@openai.com> wrote:
> > > perf_trace_event_perm() allows tracepoint counters that do not request
> > > PERF_SAMPLE_RAW without raw tracepoint permissions. A self-targeted,
> > > disabled event with exclude_kernel=1 can therefore reach the filter
> > > compiler even at perf_event_paranoid=2.
> > >
> > > The .function suffix accepts any field of sizeof(long) and resolves its
> > > operand through kallsyms_lookup_name() and kallsyms_lookup_size_offset().
> > > The success or failure of a numeric filter discloses whether an address
> > > belongs to a known kernel symbol range. On x86-64 this can be used to
> > > recover the randomized kernel image base. A named filter also exposes
> > > the resolved symbol range through the counter when the tracepoint field
> > > is controlled by the caller, as with a syscall argument.
> > >
> > > Pass the filter's perf origin to the predicate parser and require
> > > perf_allow_tracepoint() before resolving a .function operand. This uses
> > > the same sysctl, initial-namespace capability and LSM policy as raw
> > > tracepoint access, and closes both the numeric and named-symbol oracles.
> > > Do not change ordinary perf counting filters or filters created through
> > > the separately controlled tracefs interfaces.
> > 
> > Good catch!
> > 
> > >
> > > Fixes: e6745a4da964 ("tracing: Add a way to filter function addresses to function names")
> > > Cc: stable@vger.kernel.org
> > > Assisted-by: Codex:gpt-6-astra
> > 
> > nit: This should be 
> > 
> > Assisted-by: LLM
>
> Didn't know there was a change of convention. Should I send in a v2 or
> it will be picked up automatically?

We can change the tag when picking up, so you don't need to resend it only
for tag update. But for this patch, please update according to Sashiko's
comment.

 https://lore.kernel.org/all/sashiko-outbox-162502@kernel.org/

Thanks,

>
> Thanks,
> Kyle
>
> > 
> > > Signed-off-by: Kyle Zeng <kylebot@openai.com>
> > 
> > Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Thanks!
> > 
> > 
> > -- 
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
