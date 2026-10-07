Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A4F3438BF;
	Wed,  7 Oct 2026 03:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791344666; cv=none; b=e+ApvLSI4BfLJFlLYUu6kXEC4Q4RDKwCO2FSWzvAywKmQLFo2XoYM1pQUOI6jHjvtEvmMOMEET2xOR7Gj5m+ZCUTIuKxLSnvZiLawh407uqvEABWjLuX5mWI6BwDTR3D7MfVP87s6saP1SqXUWzZ7jokaj2kUG6dm5e838F4U8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791344666; c=relaxed/simple;
	bh=mFzKg42GVmLx6h/4yl6xj6KSMuymvTPF0/e81Ac0cgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-Id; b=I+12ojOMB4jbyQcWr3APnReuVmn+Z6Ai0paRsLVAGc1UNRlqsLhwAUm/HPwYZCqSFZTztPAH5Vc3GTnXuVwQx7lfRJE0z4nbDObaS/jBv3EYZhYT1CTSjxm48d1kyivxAcNy3wCTCpTdzvAavIx5eh7aldglOzj16vgJFB/OFD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZMM9k/z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZMM9k/z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 310311F0089B;
	Wed,  7 Oct 2026 03:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791344665;
	bh=zKA2ACHgb+tI7MaQHSdm6LEtcWsgBuDwOsJPGBne1P8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YZMM9k/zr1t4fym5QwDB7Eot3xTkB7uK/VMREeskt2ldqpTBJKGb1ozdYoI1Fo5Py
	 A9WgHjU+1ojU4VkdS47pqwWXOBOvGZW4HBdpYRiKQHlusVEotB08GnTUwKW4dMjzhq
	 3O0UlPP+whb5RRgDlBZ1NsDMIdFlSrfBqNQUB+fRDSbY8pGjK7BaWOkKagUZaRV8Eb
	 e4iNF8TEZQ0xHlNXneNyZFZ6+MAWMrEZiuaaSuYjh8pmBM2eMWBlXEC2Zl3yLOLMOw
	 dwVWjzcuCfV8RQ39QTOPtch+fG2X7/aFzOip3RuX0tNdXrhsdP0hgyrd1S2+xDz99Y
	 0HT+BK2xuGc/g==
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: kylebot@openai.com
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, mhiramat@kernel.org, outbounddisclosures@openai.com,
 Kyle Zeng <kylebot@openai.com>, stable@vger.kernel.org
Subject: Re: [PATCH] tracing/filters: Check perf permissions before resolving
 .function
Date: Wed, 07 Oct 2026 03:44:20 +0000
In-Reply-To: <20261006225112.53503-1-kylebot@openai.com>
References: 20261006225112.53503-1-kylebot@openai.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20261007034423.310311F0089B@smtp.kernel.org>

On Tue, 06 Oct 2026 15:51:12 -0700, Kyle Zeng <kylebot@openai.com> wrote:
> perf_trace_event_perm() allows tracepoint counters that do not request
> PERF_SAMPLE_RAW without raw tracepoint permissions. A self-targeted,
> disabled event with exclude_kernel=1 can therefore reach the filter
> compiler even at perf_event_paranoid=2.
>
> The .function suffix accepts any field of sizeof(long) and resolves its
> operand through kallsyms_lookup_name() and kallsyms_lookup_size_offset().
> The success or failure of a numeric filter discloses whether an address
> belongs to a known kernel symbol range. On x86-64 this can be used to
> recover the randomized kernel image base. A named filter also exposes
> the resolved symbol range through the counter when the tracepoint field
> is controlled by the caller, as with a syscall argument.
>
> Pass the filter's perf origin to the predicate parser and require
> perf_allow_tracepoint() before resolving a .function operand. This uses
> the same sysctl, initial-namespace capability and LSM policy as raw
> tracepoint access, and closes both the numeric and named-symbol oracles.
> Do not change ordinary perf counting filters or filters created through
> the separately controlled tracefs interfaces.

Good catch!

>
> Fixes: e6745a4da964 ("tracing: Add a way to filter function addresses to function names")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-6-astra

nit: This should be 

Assisted-by: LLM

> Signed-off-by: Kyle Zeng <kylebot@openai.com>

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
