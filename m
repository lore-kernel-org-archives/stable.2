Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793899616;
	b=Qq9ppBqESj0cMNyoaDTBfetwwXQM/1mMTZEamY1hjQJW/4LVFSDfu/jBjq12OPA4HCBU
	 rXrs7eliaMJRbXJWEl7UhJYxGQhpJsxU0QXXmnjU2x9vAVDHyxUEOKQZWIyPZLLsI0wZn
	 IH50xfIpLt1AUnoiYaEHMDxJYAjz8JMey6TM4ObtZJCgafnYH3aPgs23EsNkU8cvQPNyK
	 YluvU++C9LZ5E21OfTInxIEBK/3EXXZNLUWIp/MHMsnXin4fyziptyXbgekWnoGWzXuqD
	 MGDDTs3x54wLsljyuGt1IyhxkNic04LJB4SQ7zORRZhbj6GVjhn9jgtnWPA6S1yRJng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793899616;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=pv7MklMh40uZcAi4SKZfbl5EAYBB+uiXBzpLsbSe1GE=;
	b=rzXrNDkV6dMQbZk0A8zpt/0r+OlHh71PwCC5rtSDeCpC4lBuFXaj1WyLSb+EJNPCmRSC
	 eelYbd49Q17q+1qx/VQRRZqBKH/ewXY86NN6CqVasXy6bdM0mo+1fpcb+7It4Gu3H5UDd
	 aRTKamkujP5XlHnbQdqEonjsQMxvdeyplCT520SY81de0xClbYFgynxobvv/7wFajvddq
	 gu4OqcjknNMVJsWaStP0n+Y1s0mvV4nW0eA8qjawjXOVHn9udB2DA9pdpgYWhLRzpPUhN
	 L3eDiENBBhC0PclT7RKNcI8vt1Z/XOMB8Kd2BmTrOvGc4kUsMTPdPzaTEtrmoA/4Guw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=RHfWCLgr;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC552606D803;
	Thu,  5 Nov 2026 17:26:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC552606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=RHfWCLgr
Received: from omf01.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id B40781A0C0A;
	Thu,  5 Nov 2026 17:26:52 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 5DDF36000F;
	Thu,  5 Nov 2026 17:26:50 +0000 (UTC)
Date: Thu, 5 Nov 2026 12:26:48 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Vineet Gupta <vineet.gupta@linux.dev>
Cc: Peter Zijlstra <peterz@infradead.org>, mhiramat@kernel.org,
 mark.rutland@arm.com, mathieu.desnoyers@efficios.com, andrii@kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] tracing: fgraph: Raise FTRACE_RETSTACK_ALLOC_SIZE
 to 1024
Message-ID: <20261105122648.67abbe1d@gandalf.local.home>
In-Reply-To: <1e223334-b371-487b-a60a-7f1f5c007f7e@linux.dev>
References: <20260922225526.1554758-1-vineet.gupta@linux.dev>
	<20260922225526.1554758-2-vineet.gupta@linux.dev>
	<20260924100040.GD4121339@noisy.programming.kicks-ass.net>
	<1e223334-b371-487b-a60a-7f1f5c007f7e@linux.dev>
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
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 5DDF36000F
X-Stat-Signature: 6d38fdaz4tpccretw3cu5fob64q9xee9
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18Y4DFtXkg4jsJZYBISd9ocbt9PHNYCMOA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=pv7MklMh40uZcAi4SKZfbl5EAYBB+uiXBzpLsbSe1GE=; b=RHfWCLgrnx4ZxBIH2r6VcZ24XDAK/69saLUX/jGVp0l69uyPFkkq0WeCWSkgL10OXYnAU1ucQ2OfghwEK7IsYCvppdeMyO/3GE5HBISOAeDYIuyzbGJdIvzG2CrCoQ0mBjHaeE8ETynP6wIhnMy2C+g8ErmBzNDkTUTMcwuxFEI=
X-HE-Tag: 1793899610-320862
X-HE-Meta: U2FsdGVkX196ApTKk9z3YfX9TVkdxyThCeVOey5oiGGnblNR0vtupo1sCnJeFXkpA+lsfg/nxOW0Ze/w06Jw5JgIcSOEolRbWv5tNNLDILUXjhqq6WNqFPREk+mBYz04qFk6NKvY5hCTgXUTrfFg3HSILOjh+bjTnNDhuJZgJCMZVxw33zouJ87ekKPUazr5bW/jS4b7ikPpuziO1Vdm56194XyDemAtffZiF1kGknFBvEluljcUQ0ERGV8DO9wzvExfgDg4NnSWmFd3jnBlKhMyvqZMjpJCNh1fJQr2bumme3is7qyL5cvl+r8uMc+JgZjuU6Jgz7HGasXAGR3Pbh37Hxmi9Wo4TO87NhmOhmWmnt2wQaDBXTBGJlSk6cRuBEL99hNd+b0ejQudiWHHmVNfGXL4VNJdz5Z4FT01x2YwYKyM0G30yDFh53dc3fjcUbZm1E5kVN7a1XiO4vEJoA==

On Fri, 25 Sep 2026 12:32:49 -0700
Vineet Gupta <vineet.gupta@linux.dev> wrote:

> For submission, would you take this up as reported-by me or do you 
> prefer I send a v2 (your authorship and SoB etc) ? No big deal either 
> ways just not sure what the std operating procedure is and nuances of 
> all the tags etc.

Please implement Peter's suggestion and send a v2 with the tags:

Link: https://lore.kernel.org/all/20260924100040.GD4121339@noisy.programming.kicks-ass.net/
Suggested-by: Peter Zijlstra <peterz@infradead.org>

Thanks,

-- Steve
