Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA9E199FAB;
	Sun, 16 Aug 2026 14:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786892268; cv=none; b=prb8QTLaMFjFCdNEF+FsSo2QDSMAD3V2Fp8gU3469llpEw+E4VW60L+/P/80x6PiGcj+E6YTqr2FwB1XtN4tm3rMB4UNjWSbyY/DXUERNjYOd7WIgqplKA2afK/ntoQO/RotkGh1ban5yiZBFYBK2vmqh+kpqUZr+IK5F4eTXYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786892268; c=relaxed/simple;
	bh=WV3JQ1FL1O2NMXu8O1O+AEVbXI4Wu5zeCs7BeHJaCa8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EQJY9f07FodvJ99jkOE+AjtOO7yxVO//QklYwWbsmuxzLxECzsC0Do8GjdiA3ubc+jF1ZQhTBrSCl1myfcz2nowhpTFqkbLeypB64blHJphOP44Bt56sez4ZdxUx45YuUzuqGPKvCY8yv0rKfACZ4LILonOV4DZI32CxqOq5cbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=jDtS/caJ; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="jDtS/caJ"
Received: from omf18.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 8C87E14020C;
	Sun, 16 Aug 2026 14:57:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 929C22E;
	Sun, 16 Aug 2026 14:57:36 +0000 (UTC)
Date: Sun, 16 Aug 2026 10:57:35 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Jung <admin@ptr1337.dev>
Cc: gregkh@linuxfoundation.org, stable@vger.kernel.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 7.1.y] Revert "tracing: perf: Fix stale head for perf
 syscall tracing"
Message-ID: <20260816105735.6845e413@robin>
In-Reply-To: <20260816133101.83109-1-admin@ptr1337.dev>
References: <20260816133101.83109-1-admin@ptr1337.dev>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 929C22E
X-Stat-Signature: 35j9194iq8idkc7n5ejhefzke84rcj1p
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/uWL9I5KP+Xni3WYnL4frd0ADhlKJ8PtU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=FyNwopeLqEhladEB6HRs7DSvJHhjGtcwUysL8cExsN8=; b=jDtS/caJ6Qt+1gCBq8RCOsUF8U8DFUYKALLJtPgiPoRVP+evJiLmUarKkVYgiCR+WzdVXeRWviNebBJMrMJMzELE5pYZUPoUqMhFodbOFFMD/PhASk1VSB2VtAMnef5OOgzw/FWZnU2VayWhskNL4XYHv+3j4T/nQgp+bhvaQkE=
X-HE-Tag: 1786892256-688881
X-HE-Meta: U2FsdGVkX1/Q3w+nKElqOOMoKttzUYxJZPEk4EJqArFNEgRTc94OKGxtePACY5ekztvyAY3KKFS+YW11zBahuKxSLr2gqQtWj2c7SN258Xu9ShZT3XUB7jbxU2L15xCvislCNC4iYYlMdnL+qTb9nCWKR8dQAErE8r8OFKU/IYOwU+fOLDiS8OnHmDjd3Jq2KwDCldli1oiVjnJTV2PoiLD36Qpvo4VToqyUV/teUgU7m28UjK8xKB8Mb/EEF90k2y5R7bWjDZmE/Pfg4UO69p+XMn6ewf3OhM127FwWQlps5dvW+CsrrBYZnHdm+hmNPSWCDaSQxpdLys2iXQzgSQXyTBMkWNAV

On Sun, 16 Aug 2026 15:31:01 +0200
Peter Jung <admin@ptr1337.dev> wrote:

> This reverts commit be94a3a77e7eb99c53418de7d4a01bc7eb3f634e.
> 
> The upstream commit was applied after commit 57918341dd19 ("bpf: Add
> sleepable support for classic tracepoint programs"), which moved BPF
> program execution before the per-CPU perf event list is checked.
> 
> The 7.1.y implementation has not undergone that restructuring. It handles
> BPF and perf consumers together, and already reloads the current CPU's
> perf event list after syscall_get_data().
> 
> As a result, the backport adds an unconditional hlist_empty() return before
> bpf_prog_array_valid() is consulted. A syscall trace event can have a valid
> BPF program array while the current CPU's perf event list is empty. In that
> case the early return prevents the BPF program from running.
> 
> This breaks BPF consumers of faultable syscall-enter tracepoints such as
> sys_enter_execve. One observed consequence is that Proton VPN's app-based
> split tunneling no longer receives exec argument events and therefore
> cannot match newly started processes.
> 
> Revert the stable backport. The existing head assignment below the removed
> block preserves its intended stale-head protection while retaining the
> previous BPF-aware handling.


OK, so the Fixes on the original commit be94a3a77e7e should have had:

Fixes: 57918341dd19 ("bpf: Add sleepable support for classic tracepoint programs")

Instead?

-- Steve


> 
> Fixes: be94a3a77e7e ("tracing: perf: Fix stale head for perf syscall tracing")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Peter Jung <admin@ptr1337.dev>
> ---
>  kernel/trace/trace_syscalls.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
> index 8dcedff8429a..8ad72e17d8eb 100644
> --- a/kernel/trace/trace_syscalls.c
> +++ b/kernel/trace/trace_syscalls.c
> @@ -1436,11 +1436,6 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
>  		if (syscall_get_data(sys_data, args, &user_ptr,
>  				     &size, user_sizes, &uargs, buf_size) < 0)
>  			return;
> -
> -		/* The above may have caused a migration */
> -		head = this_cpu_ptr(sys_data->enter_event->perf_events);
> -		if (hlist_empty(head))
> -			return;
>  	}
>  
>  	head = this_cpu_ptr(sys_data->enter_event->perf_events);

