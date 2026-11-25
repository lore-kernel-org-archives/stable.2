Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620896;
	b=EoIw2b34aNclsb8/lpRU4X65ldwefGdZwi0o+6JfpN09l7WUoip2LL6c6sQp5XMwHjSC
	 JQHFFDMWxaWZrHFEtim6B9ldQn6JKYV8MTvOb7SyDK0E9dnY8aaVDYQYWGXSPYtH4J53W
	 x9zTZFg4yBvdIrqn0HVIszr3LEOYufRBj0f8amdiYQvNynJknHrAcZmGrugPW67EBgv3D
	 LRhg0lGb773GDeLXqOmBvZkLYNAtOF4UJcfZh6HQIVZzF7rUGO5tSDPSx96JXPpJmg3ag
	 czbUOz77rRvo/yjUJ9wCRwLgvKrDXFOW9SC+9McU2aJRBhWCnllp/mnLcEJoV0Gubzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620896;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-Spam-Status:
	 X-Rspamd-Server:X-Stat-Signature:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=yx9YK7GyALNlSIOlyd6tdiuojVKohVxx5VZC4AGzrUg=;
	b=yKUeXGWjACcZv6LU1KC+vF4P/u+/wX4s4dtSA2fDy+ChqPuQ6e2oEZUfF6Ww6LLVqHPL
	 qX0Jxq37VJ2ZsrNCsB4zICAWt+otDA6PWvO5p3D/zEWOk469Kf4w2QDHICqokB3Kptn+U
	 yQN8l+lKnRFQQI0XKbADjASeMWMhQvGSBeiRpgKB2O225nB3t7BJFMZrrTz08K5uKUejE
	 oJtHDWcIVQ2gcdxaWv7E9zOPhDLTHluFfaVY786b5R4xNxX9FWKJsBRN0NucMoMtuEnCM
	 kkLEk6lE+DSkFU1TKLYMSQonybRS65h2E6X5NgELBaGBRn1kzd3RF3ZiKLn7OuOoD8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=VWvc5xgG;
	arc=none smtp.remote-ip=216.40.44.12
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22264606A323;
	Wed, 25 Nov 2026 15:34:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22264606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=VWvc5xgG
Received: from omf16.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id B8FB1A0FB5;
	Wed, 25 Nov 2026 15:34:53 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 6455B20016;
	Wed, 25 Nov 2026 15:34:51 +0000 (UTC)
Date: Wed, 25 Nov 2026 10:34:50 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Kuyo Chang <kuyo.chang@mediatek.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Martin Kaiser
 <martin@kaiser.cx>, Vinod Koul <vkoul@kernel.org>,
 <stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH 1/1] tracing: Fix UBSAN shift-out-of-bounds in
 test_event_printk()
Message-ID: <20261125103450.5ac2cb14@gandalf.local.home>
In-Reply-To: <20261125080431.1612026-1-kuyo.chang@mediatek.com>
References: <20261125080431.1612026-1-kuyo.chang@mediatek.com>
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
X-Rspamd-Queue-Id: 6455B20016
X-Rspamd-Server: rspamout08
X-Stat-Signature: ubqde6ieu3wdxtk8jdhq1tp7gf991wrc
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/JLtkXh3EEEE35Z0otfqP+yQWg8VULYJc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=yx9YK7GyALNlSIOlyd6tdiuojVKohVxx5VZC4AGzrUg=; b=VWvc5xgG/+glr+78M8MPdPTRirY2FRLf7NiL8eY4xUMujYNoszr0W7v4665cG8Q3RpArRQBb+aYIzCCsRsYwwzx05Ovaz0hZLLZytXdTsf4zU7dxldoQ543ySEy7MWNXKbHzAZEj3g6AwLVwpjggxeAq1KZrcsbBS4bTi50Av0s=
X-HE-Tag: 1795620891-404864
X-HE-Meta: U2FsdGVkX18C7udoKw12/AiHBrrty8VxiPCnt1dz7a0K2CPgVnK39U+tiZVbMUG0XznJYcP8D/G4dF0WEmPOS/6MvG5jDwMfS1nVfjcrTGZIq4r6EnJO+u+A59uuGDDS+AZezMMpTIs2whZ3YQrxA+uglJj6UcWN9ZxeIyxsW9FF2Ikw+73OEYebLNIGhRFAXLTE9LFa4t02CdbbbZzCyFGUOINKa7nG1WFLmbeF+bcQgpKjfhpyJutl2AstX+LOBrFlhc7kLwy3Hbd0LLOtu/691a3GFu6eDHnLUq3sMrNU0Znqkph4CwX0v7iFboeEinWSLba7R9ekkOOVbR9Xe7e7VIeOJsLaKL1tbaUMJlDxrBEfj//WhQ==

On Wed, 25 Nov 2026 16:03:56 +0800
Kuyo Chang <kuyo.chang@mediatek.com> wrote:

> Commit b5cc230af5e5 ("tracing: Warn when an event dereferences a pointer
> in TP_printk()") removed the early return when dereference_flags is zero
> so that test_double_dereference() can check all event arguments.
> 
> As a result, trace events with more than 64 arguments in TP_printk() now
> always reach the argument-parsing loop and evaluate (1ULL << arg) when
> arg >= 64, triggering a UBSAN shift-out-of-bounds trap.
> 
> Additionally, in the format string parsing loop, the bounds check only
> tested 'arg == 63'. If the first 64 specifiers are non-pointer and
> non-string formats (e.g., %d) and a subsequent specifier (arg >= 64) is
> %s or %p*, 'arg == 63' evaluates to false and '1ULL << arg' also shifts
> out of bounds.
> 
> Fix both issues by changing the upper bound check to 'arg >= 63' and
> guarding the '(1ULL << arg)' checks in the argument loop with
> 'arg < 64'.
> 
> Fixes: b5cc230af5e5 ("tracing: Warn when an event dereferences a pointer in TP_printk()")
> Cc: stable@vger.kernel.org

I'll add this as a cleanup but I'm nuking the above tags. There is no event
with anywhere close to 64 args. These checks were simply a failsafe in case
they ever happened (which they likely will never do).

-- Steve
