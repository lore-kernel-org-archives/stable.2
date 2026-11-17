Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941816;
	b=2b/SL3eFsOVZPNeV0HUWPjgibvVG2Ur6bpgqCnkRdoIZnzxQts24yZhKdWAMRD/Aca+G
	 vRy988N3y8ZEwwGqGtTk/91i1PWNQEDJ6xzJY+c88/3eN3ai0S9pva108qER6Ye9J/4Xi
	 ntSN4SK7f61brslaP1+8bvt3evZWma9MQnekKayq7sXNKd6ofiHwuTOX8ypYh6IqfZ4VL
	 ERX/KS1xR3qljJQlQaD0/sK/7svQojtJBqM5TAA1uAsNTP1Qq6oOKkBPBUT02cDgqs78l
	 F7f/kK8Cc6qFDQmfq43ryVkY/SvRJtmkka5jjimsK6p6dvUtYAl41v3jqy27i2e4qFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941816;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Spam-Status:X-Spam-Checker-Version;
	bh=jNUxV4jVJx7zuK7K9KL7Gk8uxMgQLIQMcT7ZNJeh7lw=;
	b=JeO9ve4jMe2C/NrSa9L2ZGkEV7tew2DUZu6EVOWvA6st6WGhMJhbqF23GADpYbnXylHK
	 uuPm0QK4TOMQa8kb8/gNo5G0DXHjSJSxxQ8sV7tD0pGQUrVjs9LXBP6oV+3uSgXTO5uSq
	 j9ZxCKJ6wlbO19MCGiOCk7fw6xFHjI7Pjqs3HDe9OlhL+F/cN0fhdbpWEXvDFQaQTLEWv
	 +FX5ifXYeM+dDg509ifOa0NdePitvZvJBxFAATj3TZfDIyA8xqNgMVlCjB12fw6aQ32gK
	 oMT+mXYxvx/7yNdsRa+LbSCY0D/KGxdnGUdleryA22Oa2DlbJkWHbSwPdLentEsRYuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=bcjp12uX;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F83606A31C;
	Tue, 17 Nov 2026 18:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21F83606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=bcjp12uX
Received: from CPC-beaub-VBQ1L.localdomain (unknown [70.37.26.63])
	by linux.microsoft.com (Postfix) with ESMTPSA id EC08320B7169;
	Tue, 17 Nov 2026 10:56:54 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EC08320B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1794941815;
	bh=jNUxV4jVJx7zuK7K9KL7Gk8uxMgQLIQMcT7ZNJeh7lw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bcjp12uXvD5DeJhWjAX0VkOI83nLkwtJo4LRkFqkaAd4fbUbxeRHk3mk6/WumzCOi
	 reiTK0KcC9y+uQWiuVnL3NaAuIPfpFnr0KB/mEgoG3nVVjWaecpTRgl4BC+rDkzo01
	 IAMZq7GOBPsD6lu6rABAXaf2vHYxdUnEtalLDhws=
Date: Tue, 17 Nov 2026 18:56:47 +0000
From: Beau Belgrave <beaub@linux.microsoft.com>
To: Danish Khateeb <danishkhateeb03@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Shuah Khan <shuah@kernel.org>, linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] tracing/user_events: Handle ioctls from 32-bit tasks
Message-ID: <20261117185647.GA460-beaub@linux.microsoft.com>
References: <20260928171424.199202-1-danishkhateeb03@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928171424.199202-1-danishkhateeb03@gmail.com>

On Mon, Sep 28, 2026 at 12:14:23PM -0500, Danish Khateeb wrote:
> The DIAG_IOCSREG, DIAG_IOCSDEL and DIAG_IOCSUNREG ioctl numbers are
> defined with pointer types, so their size field is 4 for 32-bit
> userspace and 8 for 64-bit userspace. user_events_data has no
> compat_ioctl handler, so on a 64-bit kernel every one of these ioctls
> from a 32-bit task fails with -ENOTTY and such a task cannot register
> any user events.
> 
> struct user_reg and struct user_unreg are packed and only use fixed-size
> fields, so they have the same layout for 32-bit and 64-bit tasks. Add a
> compat_ioctl handler that maps the 32-bit ioctl numbers to the native
> ones and passes the argument through compat_ptr().
> 
> Fixes: 7f5a08c79df3 ("user_events: Add minimal support for trace_event into ftrace")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Danish Khateeb <danishkhateeb03@gmail.com>
> ---
> 
> Notes:
>     Tested on x86_64 in QEMU (v7.3-rc5 plus this series, KASAN and lockdep):
>     - A 32-bit program that registers and unregisters an event gets -ENOTTY
>       from DIAG_IOCSREG before and works after.
>     - tools/testing/selftests/user_events built with -m32 (with 2/2): all
>       four tests fail before and pass after, in three runs each. The
>       64-bit build passes before and after. No splats.
>     Also built with CONFIG_COMPAT=n on x86_64 and with CONFIG_COMPAT=y on
>     riscv64, both with W=1.
> 
>  kernel/trace/trace_events_user.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> index f658c3a77aa7..07cfbb5a17de 100644
> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
> @@ -8,6 +8,7 @@
>  
>  #include <linux/bitmap.h>
>  #include <linux/cdev.h>
> +#include <linux/compat.h>
>  #include <linux/hashtable.h>
>  #include <linux/list.h>
>  #include <linux/io.h>
> @@ -2737,6 +2738,36 @@ static long user_events_ioctl(struct file *file, unsigned int cmd,
>  	return ret;
>  }
>  
> +#ifdef CONFIG_COMPAT
> +/*
> + * These IOCTLs encode the size of a pointer and thus change their numbers
> + * between 32 and 64 bits. The structs they point to have the same layout.
> + */
> +#define DIAG_IOCSREG_COMPAT	_IOWR(DIAG_IOC_MAGIC, 0, compat_uptr_t)
> +#define DIAG_IOCSDEL_COMPAT	_IOW(DIAG_IOC_MAGIC, 1, compat_uptr_t)
> +#define DIAG_IOCSUNREG_COMPAT	_IOW(DIAG_IOC_MAGIC, 2, compat_uptr_t)
> +
> +static long user_events_compat_ioctl(struct file *file, unsigned int cmd,
> +				     unsigned long uarg)
> +{
> +	switch (cmd) {
> +	case DIAG_IOCSREG_COMPAT:
> +		cmd = DIAG_IOCSREG;
> +		break;
> +	case DIAG_IOCSDEL_COMPAT:
> +		cmd = DIAG_IOCSDEL;
> +		break;
> +	case DIAG_IOCSUNREG_COMPAT:
> +		cmd = DIAG_IOCSUNREG;
> +		break;
> +	}
> +
> +	return user_events_ioctl(file, cmd, (unsigned long)compat_ptr(uarg));
> +}
> +#else
> +#define user_events_compat_ioctl NULL
> +#endif
> +
>  /*
>   * Handles the final close of the file from user mode.
>   */
> @@ -2787,6 +2818,7 @@ static const struct file_operations user_data_fops = {
>  	.write		= user_events_write,
>  	.write_iter	= user_events_write_iter,
>  	.unlocked_ioctl	= user_events_ioctl,
> +	.compat_ioctl	= user_events_compat_ioctl,
>  	.release	= user_events_release,
>  };
>  
> 
> base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
> -- 
> 2.55.0
> 

Thanks for this!

Acked-by: Beau Belgrave <beaub@linux.microsoft.com>

-Beau
