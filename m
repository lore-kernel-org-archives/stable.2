Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795621107;
	b=r0l6SWZXL7JlV4+vigtC1mtFgR+0+MB6svvoO3zTqJ3jQvci32AA0a+7CMcNo5UoxuJt
	 7NveyroXOE2ED/Jv5auiJvvkbdudn/SJ1QdsLYjhmrJ2JbW2Br3pgl8mrfT7Y01feH6sH
	 wvdO81QiTEOrnIJWWxuu+h44Jt1BJNdUH/OCbOMIT08Ca6xo9aB4co38RFoTrescTPYf0
	 1rtKH7cyR3beX+ebJvwBO/w+0ZBMQrf8TmVgY9OjpLAmPoYQ/e0PvXmP89rtV836dn1EQ
	 ljp6X1Sphn2sZVj8o+zUl2slAo6HwVV4miCmd3vVuVPlB5t2k0a3UcH16P8WHT9Q1Fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795621107;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=zKCR4oP/mX5BJ7mTpADOUsC3cnHnHzXBJf9HdDltW00=;
	b=ckKa3yR6TkfvmGTDJGm8BwKLNo6B7ky495ofXX1fam3gw4v6D//jULtnB0eBTqDhUrPt
	 Lpn7ewcHCGIzxK674v7QMxI6fNK2AllR6AAppdH8kbcqDoGaqTQqx/6KEnOSOKG9v8WrH
	 9s0rFJU8+XmfIOlgfAjryOzcVIWCGkex7il4O1QXTOSDNlijlmtzYX72QBE4tZaKxcfa/
	 hwrLiTt8B7ePSxsnyLJBt9bNt/GJ5H8CwkHwnoJVkJL5b4C30VOBPryL6rFcSQ4mD9Mfy
	 zZkWVT4W5eJFGRvlPjGgPaCXNimWykdqj5RD6Y1DTktQ+OXG/ZilP6fxlLxm9n3pl9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=RujuUyP2;
	arc=none smtp.remote-ip=216.40.44.12
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B892D606A31E;
	Wed, 25 Nov 2026 15:38:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B892D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=RujuUyP2
Received: from omf07.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 4EB4BA0FB2;
	Wed, 25 Nov 2026 15:38:25 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 7154120037;
	Wed, 25 Nov 2026 15:38:23 +0000 (UTC)
Date: Wed, 25 Nov 2026 10:38:22 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Wenwu Hou <hwenwur@gmail.com>, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] tracing/hwlat: Bind the sampler kthread instead of
 setting its affinity
Message-ID: <20261125103822.2129a7ec@gandalf.local.home>
In-Reply-To: <awbklFE66PIMKFop@localhost.localdomain>
References: <20261125084600.2306377-1-hwenwur@gmail.com>
	<awbklFE66PIMKFop@localhost.localdomain>
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
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 7154120037
X-Stat-Signature: g1hnmyttzo9tnhqq1u7kt8xf6sj8zk7u
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18umlukJvwoHDIfgGPDrfhRzvlEEpeAWz0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=zKCR4oP/mX5BJ7mTpADOUsC3cnHnHzXBJf9HdDltW00=; b=RujuUyP2JA1/EKN9fCHIzUbuH/rHGhTDNiAYFJpsXYIG/rbIoNGXl8Vbn5eBNAqA1QJAvDtV3GHTjk8faEQHcknTT/rOqBpWj4wya71U/5otjtLhZJmOHAgP4fZJBWUaQPJKU91IsKLt8vv8nQQ3WF1sWHTJfRqqC6Vt7o/dlLg=
X-HE-Tag: 1795621103-29035
X-HE-Meta: U2FsdGVkX19yRzOLkjBZpHGVK2kE7mt94uJO6OGBXapd17g13p5lNTl4H5e6JHuZan1oeBo4aimNmcLhWh98oG2jiAIOx+yf7wwCw6pIxRYDyZ9Pv7Gsg9K4/cLKCQ6/0tPQ9Oin9huMX63XXFTYkjrXYHYd5FSJ2WKGVXQa2Mn0/jcAqnYDQE6+SPwEvNnQoAjvunl3rrgSciYMduevyX0V/4dOCVPNEPIbgkd1UK7fCu3NnxnLh5olHlkEDgsyxaSjP1G7wf6jojkOHKCckZlLyg4TX1SJdnGXqdr8M+J3iGur5noW+r1aZtLNtbHMF4y0bZ5YO/8/cx9m+rI8FAmUy4OIILzK

On Wed, 25 Nov 2026 14:37:24 +0100
Frederic Weisbecker <frederic@kernel.org> wrote:

> >  static int kthread_fn(void *data)
> >  {
> > +	unsigned long flags;
> >  	u64 interval;
> >  
> > +	/*
> > +	 * kthread_bind_mask() sets PF_NO_SETAFFINITY to keep the initial
> > +	 * affinity from being overridden by kthread_affine_node(). Clear it
> > +	 * now to allow userspace affinity changes and cgroup migration, but
> > +	 * keep per-CPU threads bound to their CPUs.
> > +	 */
> > +	if (hwlat_data.thread_mode != MODE_PER_CPU) {
> > +		raw_spin_lock_irqsave(&current->pi_lock, flags);
> > +		current->flags &= ~PF_NO_SETAFFINITY;
> > +		raw_spin_unlock_irqrestore(&current->pi_lock, flags);  
> 
> This is not pretty but moreover, is it a good idea to let the user override
> that affinity?

No, but we used to. Perhaps we should make that not possible instead? :-/

-- Steve
