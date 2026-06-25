Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B4325771;
	Thu, 25 Jun 2026 18:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782413334; cv=none; b=JC82tU8OPpbKGYcZGeaA4qrLCWsnru41F8xvN3LcHnFZ4zvbfnf/oIJdst3knqvK+WQHR2vA6HdcxGMcpTeFGcoPXs29VZ1uVMkJkI+MdFAZ5ydgxou43YCrD2/sBTYu5sDUzt8meJWjDdLfmpd4Pp0cB826/gNwXXeH97ThSqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782413334; c=relaxed/simple;
	bh=xsFcv7coMc3ffWy8ax4oxLzM7nA5wbv9rgIFhK0hraw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=flU2WINYpO3tyAKbDcFunN03V2WdAgEpHdmU8ZCSUbIGfFMrMs1AVzB1F85XxosNrBcIJbfycadVhWaQw4h57BlcMHHxT7fFlDMjQxne27BToVT6Xn03huCdiHUILLJpn2MML8IwF9TXwburSPbQUofUFXw3J8qhJ3haLrZdljg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=r9QqTBVB; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="r9QqTBVB"
Received: from CPC-beaub-VBQ1L.localdomain (unknown [70.37.26.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id DD7D420B7169;
	Thu, 25 Jun 2026 11:48:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DD7D420B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1782413327;
	bh=WWWEeEJQyfWPC96k4vP/imQwH05OswkULx/7aXs9mio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r9QqTBVB0/1OOaYno9BTmn1ba8l+gtscMU057ECEsrry5kRC215wTtaaFnLaF3usI
	 Cz0DyIv2vT6+iCiWylvFaC3izmnAJyhKTqtkdDFPeAR3DEIZJ70Vuka5pAij+TG10e
	 svco4OQtmDOoCPhY6SijI3b9dX+UHG/LNhxWt7og=
Date: Thu, 25 Jun 2026 18:48:44 +0000
From: Beau Belgrave <beaub@linux.microsoft.com>
To: Tristan Madani <tristmd@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH] tracing/user_events: Use kfree_rcu for enabler cleanup
Message-ID: <20260625184844.GA368-beaub@linux.microsoft.com>
References: <20260625180203.3343545-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625180203.3343545-1-tristmd@gmail.com>

On Thu, Jun 25, 2026 at 06:02:03PM +0000, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
> 
> user_event_enabler_destroy() removes the enabler from an RCU-protected
> list via list_del_rcu() and then immediately frees it with kfree(). This
> can result in a concurrent reader in user_event_enabler_dup() accessing
> stale memory during fork, since the enabler list is traversed under
> rcu_read_lock().
> 
> The ENABLE_VAL_FREEING_BIT check in user_event_enabler_dup() is not
> sufficient to prevent this, as the enabler can be freed between the bit
> test and the subsequent pointer dereference.
> 
> Use kfree_rcu() to defer the free until after all RCU read-side critical
> sections complete.
> 
> Fixes: 7235759084a4 ("tracing/user_events: Use remote writes for event enablement")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
>  kernel/trace/trace_events_user.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> index c4ba484f7b38b..72bcb429eb4f3 100644
> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
> @@ -109,6 +109,7 @@ struct user_event_enabler {
>  
>  	/* Track enable bit, flags, etc. Aligned for bitops. */
>  	unsigned long		values;
> +	struct rcu_head		rcu;
>  };
>  
>  /* Bits 0-5 are for the bit to update upon enable/disable (0-63 allowed) */
> @@ -404,7 +405,7 @@ static void user_event_enabler_destroy(struct user_event_enabler *enabler,
>  	/* No longer tracking the event via the enabler */
>  	user_event_put(enabler->event, locked);
>  
> -	kfree(enabler);
> +	kfree_rcu(enabler, rcu);
>  }
>  
>  static int user_event_mm_fault_in(struct user_event_mm *mm, unsigned long uaddr,
> -- 
> 2.47.3

See [1] as there are more issues than simply the enabler being freed via
RCU, there are lifetime aspects of the underlying user_event.

Thanks,
-Beau

1. https://lore.kernel.org/linux-trace-kernel/20260618222743.538915-1-michael.bommarito@gmail.com/
