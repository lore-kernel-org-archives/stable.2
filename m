Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793905264;
	b=42CU5GB/L0BGS282QnpWStILfoo+CTysURQDeSyQAeFsFC+6QL99MKb9RZotciBCewiC
	 ZzU4jJ/oawAV5ZPup57SWyzU82JNhmsyqIcX0dZ1h+CFnhgZm1jYQMqfAZ+qZsbb2Vyqj
	 LY7VEV7b0OvSP1hoIteJ0S7j/U67iT9Wq+XHWKiNwf7t9cYifTq5jp9nnujzMrPg8ayMu
	 Dgt5Gw74CaNiGRSJvAxwR1LOoGxTzv7F13aA/e7z2QHegjpP9Kka+SBlTqIu/yx40/XE7
	 YVugz7JhZGPNX9sWZoqROlZpfcv0nbKvArMoB/n3349EUF3UesMgg4E/jUVjfiae4xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905264;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=cNvHm4P49zGZ0AA9ASMVJBBbN+Qdiu12WvVmr/Br59g=;
	b=AO8UAGZhHcxN1AtbJ6G9GNF82Uf8Hu+VPxKgYw3WzEqCuMdg42UvbpibZQxs3kTNlazk
	 5isIYgSyLP5DxWFZhWgitI0HkWD3vAfaYtRKDi2/dJdfDrRG3Al8D410R8UZJ6MZ6jbUg
	 m+9fgOzfqv01Ssj5EmpxdHFZ8MrTvFFuEbZU7w+lVWaCNRTP96UT7ktdURGVaMz08BZKv
	 yVysdKix9CfDmNXnyVOfbRW3cyfivlqM4AoaUwlS4t0BpWBlP9SV9+MuARObsLIooKV19
	 Ocqw22G4VEWyOpCD2HklNdCCQDZNUAxCQcFWOM9VfntyRiYGm6nsWR2V9Z0OkEpn8ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=mVwNmf4S;
	arc=none smtp.remote-ip=216.40.44.11
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1263606A329;
	Thu,  5 Nov 2026 19:01:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1263606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=mVwNmf4S
Received: from omf04.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 38E62120A7F;
	Thu,  5 Nov 2026 19:01:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id D07D620027;
	Thu,  5 Nov 2026 19:00:57 +0000 (UTC)
Date: Thu, 5 Nov 2026 14:00:56 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Vineet Gupta <vineet.gupta@linux.dev>
Cc: Peter Zijlstra <peterz@infradead.org>, mhiramat@kernel.org,
 mark.rutland@arm.com, mathieu.desnoyers@efficios.com, andrii@kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] tracing: fgraph: Raise FTRACE_RETSTACK_ALLOC_SIZE
 to 1024
Message-ID: <20261105140056.111875ef@gandalf.local.home>
In-Reply-To: <53ee72a4-a5f7-4a7d-8a0a-fc3fc8804d75@linux.dev>
References: <20260922225526.1554758-1-vineet.gupta@linux.dev>
	<20260922225526.1554758-2-vineet.gupta@linux.dev>
	<20260924100040.GD4121339@noisy.programming.kicks-ass.net>
	<1e223334-b371-487b-a60a-7f1f5c007f7e@linux.dev>
	<20261105122648.67abbe1d@gandalf.local.home>
	<53ee72a4-a5f7-4a7d-8a0a-fc3fc8804d75@linux.dev>
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
X-Rspamd-Queue-Id: D07D620027
X-Stat-Signature: nijojfznnj3s8kdiojgc86wnjfhogrsj
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+nm+5gLQ+/jQ61184zf/E+nKVeZtsLm/k=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=cNvHm4P49zGZ0AA9ASMVJBBbN+Qdiu12WvVmr/Br59g=; b=mVwNmf4SBa97XgOt0W+LBsdzkyAGomNG5f3kFlfo2cLPp17X6NbpjJ7FeyINp/Cb9sG/gMkUvqbIXPuvVioKcFs8pz2ngP1nrFU0CwWMLx15z8EhVsBwrvoL+XDwuv75841uOB+7TViLFS1vViwskjohD1kNzqXtcJYdULGUilA=
X-HE-Tag: 1793905257-975753
X-HE-Meta: U2FsdGVkX1+LHqlcgYP7t/pmkV2ynE3kMb2NTGO/kTaMvUBSeBvGzpu0I/wEj2vasu8haOHq2h/UWA0QaqeZARh3oIWLDYcepC876sn7JI/ChsNQoLRPIiHpBh4iNPmZlxDIVDyshTtYkG75cpLL+SlNdfBCHjF1E3Q4L8XOyaXK80xu3UyjP6EsZMniBb/cXyvZQvkAGRjaaxXZbIeg8SuiRGnqbYmbXLj+h7iTanUFH/p4Tr9aZmBKLz1R/J+dz3vMHSnb2367fpoK7KT0AJiKNCSNOAcj7XmG+7b5HuZvRKlM0s1+e58QlKqxIhuMMnWFHomVAP2bfquGXNSvbUOQ+GE7hfDE

On Thu, 5 Nov 2026 09:56:07 -0800
Vineet Gupta <vineet.gupta@linux.dev> wrote:

> I think you have some catching up to do still :-)
> This is v1, we are currently at v4 [1] with Peter's suggestion and 
> further split up for ease of backport and use of new rcu_scope 
> constructs as suggested by Masami san. It has been Acked by Andrii [2] 
> and Alexei [3]

Bah, this one wasn't superseded in patchwork, and I'm going from oldest to newest.

Sorry about that ;-)


-- Steve
