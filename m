Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F7F322B9F;
	Tue, 29 Sep 2026 18:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790707517; cv=none; b=C8GQ+4EGNB59ZdiozFPci/RVVzJVNojSm94wgkWnPPrLuzUMk0JlrV2ioFudealGhDTWWL99L1Aeerd2UudfTSCCUzK5NVV3xOs3MCcilpgyDM/uJ0epVBouUqv87RttJfKXyM4CRxgUiE1XqttSpX3midxL8HYVlW5TRosM/ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790707517; c=relaxed/simple;
	bh=2JdM+OMPCZBlPoQlhlqezVeWZuDcC5Zlfj3r2CMimOE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OJDcQSMkli7iZvoESzTCKdpqp0Zl0lp7YlSmtouiDeLKPXIXxAyQFPMoO9nyk6Vi9FFbn5Iv4yNzZ9FZMhKlrx7F8Rm8+/jS6Ol+2aravher/ANiFqzkgJact1Op8gmuQUa52nFrCv9w8m+FjbpxmLWQRcDP6EfQ2CEHf1F5x+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=A9s7kt09; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="A9s7kt09"
Received: from omf13.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id B498CA6E7E;
	Tue, 29 Sep 2026 18:45:07 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id D3D5920012;
	Tue, 29 Sep 2026 18:45:04 +0000 (UTC)
Date: Tue, 29 Sep 2026 14:45:01 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Zhengchuan Liang <zcliangcn@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Ross Zwisler <zwisler@google.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Peter
 Zijlstra <peterz@infradead.org>, linux-perf-users@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH 1/1] tracing: Require tracepoint permission for perf
 function filters
Message-ID: <20260929144501.3b8dcaa1@fedora>
In-Reply-To: <95d3721fa8d4c7a4577ec14e9d7caec4fd0cefcc.1790553331.git.zcliangcn@gmail.com>
References: <cover.1790553331.git.zcliangcn@gmail.com>
	<95d3721fa8d4c7a4577ec14e9d7caec4fd0cefcc.1790553331.git.zcliangcn@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 4ya17dfarmkk4htb96ob3aha9eommb6e
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: D3D5920012
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18GL/mrHDhEiZ3ZbHV70hICMpCHCUrs18A=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=erBVOtzQymQefzUtqhd4VKSH1rxw2Rm3xOKAGzz55vU=; b=A9s7kt09INscftYVxj+F8EKD/EKmIQbkaztj0PetDyBg5GyrchzpvzN5FZClLbONuAhnpvQTnZIzoO0zUR5N24FNMJOIOlzKpIUmNFY7Tg0kqkdleodNBMzz4VcpgSjdb2qEJfe4EFLdlSavo4PizKqPufEECBNZ4suV1yYW240=
X-HE-Tag: 1790707504-858915
X-HE-Meta: U2FsdGVkX18U2j4LHPRsXH7+1ORfjtFwJBdEeS1WZcEaRhTIQfsCCILWYQnB391saFBb5LYQ7oOpnh2j+x2JIT0ZYvfEF++nUziZ+fBB2pl5Lf6hZNHtUf6j9kQGc1Bvppeof1rfyvi69c086ryIUkL7cjLB1avt2KQAsC0v+tpKDLBULZgmaDLV8TwCkoYFwkCIy6dWt1/m0Y5o6cnUai2hhKyfm5LdpZR/07aYrmfbJb875Xm37t9+nlfA8y8D1iFyt9P9mOwCVfYHn4QnStLbsQvLihhsVp81U3LwceRuFnmmgcP3qSwg7DN26n5A6dBMP9re3P96CaqYHIB1PwVyfWovNSFaMYLvq7reiZ1DjvCdcjhphw==

On Sun, 27 Sep 2026 17:00:31 -0700
Zhengchuan Liang <zcliangcn@gmail.com> wrote:

> Count-only perf tracepoint events can be opened without tracepoint
> permission because they do not sample raw event data. Their SET_FILTER
> ioctl still parses .function predicates. Numeric operands call
> kallsyms_lookup_size_offset(), making ioctl success an oracle for
> recovering the randomized kernel text base. Symbolic operands resolve
> hidden symbol addresses and can also match user-controlled event fields
> against those addresses.
> 
> Pass the perf origin through filter parsing and require
> perf_allow_tracepoint() before resolving either form of .function
> operand. Ordinary perf count filters and tracefs event filters retain
> their existing behavior.
> 
> Fixes: e6745a4da964 ("tracing: Add a way to filter function addresses to function names")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Zhengchuan Liang <zcliangcn@gmail.com>
> ---
>  kernel/trace/trace_events_filter.c | 39 ++++++++++++++++++++++--------

NAK.

This is a perf issue and not a ftrace issue. It should not touch any
code in kernel/trace/* for the fix.

Looks to me the code that calls ftrace_profile_set_filter() from
kernel/events/core.c should not be allowed by unprivileged users.

-- Steve
