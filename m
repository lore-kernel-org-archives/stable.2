Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795621010;
	b=LjZsmBOPmNQXSoPdwelAu8k0z7jzOa9e+FdwjJAG/2iWmstO8OzPtR/i395bBsYRw8LM
	 nycjuwKtGW11ut1oe3D6jf6mrL451qSjaLBbBr4eHh1fHDuRl5JND9uul+qwblOHtkt4s
	 DKFHd4/QPXgR3oXtCG4FP4mWI5nr2beCely5ZkJOd82gGdUtdFmLdPvt7fhLMSdqWiIx/
	 +pidkqYBSWby9Nls45nShBvDXbfzB4lKyLB/+/pI9GubwzWfW+lVQgNw2h4NrdXog/7FW
	 kIdoZCoQjF4/xT/9N8UP4egAtOzj6KWtVSQZIAA3OGfGQvRYUpKGsz3O8C9MeaeqzTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795621010;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Spam-Status:
	 X-Rspamd-Server:X-Rspamd-Queue-Id:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=NwvHgGTXJz0wJa/djlhMj0y+yVLq4gmsEHRyjatrEP0=;
	b=4wnVoADyOhvQQJk4uWrFcIFm4VvNcgRJJy3nIBzuVZrB1p0QTcKjtD/EfIWIFo6tgzrv
	 LKXtscKHrZnSkDBIgPfm/xzYSH/tPa68SjIicJB7dIbrC7W+vMYNPLfFhbFi4dUCTQ0JT
	 MOXur6TZg1KSQFJLogVjsSjKEm8AqOs+DjnV/Q1HkxV+rtSBU2wg6sMVJj2akZgplfA2v
	 OS669LBArnIZZ8L/JbPz3z5BRR3NcSZnZW7TtWuUh7G2L+hNct/Hzxy8YDBcKbh89pjXq
	 0nepO/csh1496YqR1wxgDbEpkZ0VHr/Vml0OjvQTy81QzJLm6pjT+FJil8N3KakhOVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=XsGzjmjo;
	arc=none smtp.remote-ip=216.40.44.12
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF0C60A263E;
	Wed, 25 Nov 2026 15:36:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDF0C60A263E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=XsGzjmjo
Received: from omf15.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id C1B84A0F80;
	Wed, 25 Nov 2026 15:36:47 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 3AABF18;
	Wed, 25 Nov 2026 15:36:45 +0000 (UTC)
Date: Wed, 25 Nov 2026 10:36:43 -0500
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
Message-ID: <20261125103644.5bad3010@gandalf.local.home>
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
X-Stat-Signature: m4pnd9zcch9bbufyr11t9hmbuaht3zhm
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 3AABF18
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1//DpdCkurl9IwChUg4S7PUZPcI6x6HW/A=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=NwvHgGTXJz0wJa/djlhMj0y+yVLq4gmsEHRyjatrEP0=; b=XsGzjmjoMxoMNthM05a1soAIZVCxY2jFkSDWG+o3ya/P4N4bpCdnf6e2xkUKZKZoZPGTrkCKdDnzhzUkISwLnTSLMn1/0i1w9U+N0Zw7B0F1FAuJzvH/6sK4ChPR1233R9OiOV64cVIQM9yryrVUgPFATAn2J/cl24oHrxraCyU=
X-HE-Tag: 1795621005-232792
X-HE-Meta: U2FsdGVkX1+P7p3L822E/fIOJ09gdK0kUBB9BPSUyBuoVEeMsP2HEPTRIFkFOXDsyPzvuPHbPiQwZK8znmtz7AGHbj3uW1X8+1fg9qJ9H2DWcWGwN59oE9XrGTkxTkP35JrqzA2kx/7vnEcsSFF6uXXY4ojMxFUcETDUaXPsko9NmeF44Jv3mKDb+I4j+/Ditay3S7jnX4+GMX30/Pn9caNemdPW0s3p9IpyBrSgZULdpWGgHx0FobNv3zu0mYVJiE9k5xgG00DjJ3znejhdmh8TKyuF6C8ln7z34Tx5UW2VNoqTGoK7ilrhJF1ACMCn27j64DaE1ZZFVCOZm0MnluJaRxjiklQe

On Wed, 25 Nov 2026 16:03:56 +0800
Kuyo Chang <kuyo.chang@mediatek.com> wrote:
>  kernel/trace/trace_events.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 7f89160aeff3..5933fc92f786 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -526,7 +526,7 @@ static void test_event_printk(struct trace_event_call *call)
>  				case 'a': case 'd': case 'D':
>  				case 'g': case 't': case 'C':
>  				case 'O': case 'f':
> -					if (WARN_ONCE(arg == 63,
> +					if (WARN_ONCE(arg >= 63,
>  						      "Too many args for event: %s",
>  						      trace_event_name(call)))
>  						return;
> @@ -556,7 +556,7 @@ static void test_event_printk(struct trace_event_call *call)
>  					if ((fmt[i + j] == 's')) {
>  						if (star)
>  							arg++;
> -						if (WARN_ONCE(arg == 63,
> +						if (WARN_ONCE(arg >= 63,
>  							      "Too many args for event: %s",
>  							      trace_event_name(call)))
>  							return;
> @@ -610,7 +610,7 @@ static void test_event_printk(struct trace_event_call *call)
>  
>  			test_double_dereference(fmt + start_arg, e - start_arg, call);
>  
> -			if (dereference_flags & (1ULL << arg)) {
> +			if (arg < 64 && (dereference_flags & (1ULL << arg))) {

The above should never happen. If anything, arg >= 64 should exit this
function immediately.

-- Steve


>  				handle_dereference_arg(fmt + start_arg, string_flags,
>  						       e - start_arg,
>  						       &dereference_flags, arg, call);
> @@ -625,7 +625,7 @@ static void test_event_printk(struct trace_event_call *call)
>  
>  	test_double_dereference(fmt + start_arg, i - start_arg, call);
>  
> -	if (dereference_flags & (1ULL << arg)) {
> +	if (arg < 64 && (dereference_flags & (1ULL << arg))) {
>  		handle_dereference_arg(fmt + start_arg, string_flags,
>  				       i - start_arg,
>  				       &dereference_flags, arg, call);

