Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794213378;
	b=iA6Q5D5gViWLLQT5+Vf/RNJoOLCtbRYpjErHUXxMUaMjgWWLOBhyPAnqk4BC15N5ndz2
	 jYXMYQeH5qujbfH3+ha2u2N+00ojg8aA3firhlVZ37iiyfLwAUAh5BP+BdecO05p+ythr
	 WhoMTyEtP21ohMVU23q/tEJC60uWHya3NB9WFWUSGHAYO4EOxchNQQ3Z71u0iTUc8It/L
	 v9m6TO/hNbJYN519Qcnb8SLsLuYhZ7+6Ib5yAaVx7Up50ygIjsCh8b5TX0J3IZzZXHF2o
	 KISWQSytfwxEo+P4FN/7c2QkM7nRIFzXCx2vNDsKazLLO0PQHSJONrk8m+YAj0vWwfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794213378;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=NXE4hbBl8ONk/q8S5glLowbFi3mw0cEqAZFES640YHQ=;
	b=I1nsobRiWXdohJxIQ6QYslXOiOXBgMqKJkCnZ3dMq76f08/OFqU1jFRVyy2xCGdhsqtz
	 G5IyS7wHpz7arwoPIbOwjtDBVglI+cKk0GZ6whOGrHm2mT5CBkistaJktJZsFdyvf8gqx
	 TBVWiGk2U0axcmpTAGsoOKfzpTIV5gf7jaN5+Zexla3b58GPRwL3+az7P22OV/M5wKh3l
	 Fpm++/oIJKaLMpwllL8ZYraUtfUWA0Rf6K+O/i5vthzEy2ruEeyXqaW7oDKbB3Y1nfHha
	 BKqv9UBE2uRwTE9OvowsgnyGrLXTIrucpWfjH7ns4Za2qjorxbYiXK/UaPCR8D3N3/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b="U/6mMabV";
	arc=none smtp.remote-ip=216.40.44.12
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0507606A321;
	Mon,  9 Nov 2026 08:36:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0507606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=U/6mMabV
Received: from omf03.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 44CB3A05D2;
	Mon,  9 Nov 2026 08:36:10 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id EB0EF6000A;
	Mon,  9 Nov 2026 08:36:06 +0000 (UTC)
Date: Mon, 9 Nov 2026 03:36:01 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Kyle Zeng <kylebot@openai.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 mhiramat@kernel.org, outbounddisclosures@openai.com, stable@vger.kernel.org
Subject: Re: [PATCH] tracing: Validate user addresses in faultable buffer
 copies
Message-ID: <20261109033601.0cfeb51a@fedora>
In-Reply-To: <20261006225221.54513-1-kylebot@openai.com>
References: <20261006225221.54513-1-kylebot@openai.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
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
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: EB0EF6000A
X-Stat-Signature: dk1hqh63xj8usr8tngrn3swg4d1nnf4w
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19RNuzFDQ4aSWdR/CHSQjuErlUfCkRqFnA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=NXE4hbBl8ONk/q8S5glLowbFi3mw0cEqAZFES640YHQ=; b=U/6mMabVjLowLS12R1mRGRGzNbsDq7J2aEwsW0NbIdGq+No+vH6qCRN1QwZ0ta9SjWVX4CnQae4vh0Tej01niyHs1k1+SJUYi55uR/jtjWW/K+8hyo3FMOWrl18ny0JERRXmT1jpiKM5YCO07H+YVXCC7R2Jpyd8STR9+/zjOAw=
X-HE-Tag: 1794213366-427661
X-HE-Meta: U2FsdGVkX1+LbD5iZS8mZ694xxV3e4DSytQQMzCsAdA4xaK3TkviE5QUnjKVqzdBhkTfL4C4yQu1+UPwOtZ9PaeJVMNHOBdraE7QayPCLfl2PPF6bbLxJHmFx0CafVtzezN5C1WxlAccVYXq5n+obB1O+iu9vFO+WTUN3k2vFPdvocpLOm4igLO7kBtmwkOdhAmJEHxr14uMuwvOHB3vEtt4QTajh8O7bIo+yoGYHlg9tt6wZWiNi8ykw86zKlgZXFF3cT/iPxT8+KeNp3NQGUeaBFm7kGCrRux3iAZc6doFN5wwenfA7OdaYpiZoqkuhdzGPXMtE3ImKHRWRqGTBgj+BV5aFjnzNw1DLUvEmA1LXUPQyRF6lQ==

On Tue,  6 Oct 2026 15:52:21 -0700
Kyle Zeng <kylebot@openai.com> wrote:

> Syscall entry tracing runs before the syscall implementation validates
> its arguments. For a size-bearing user argument,
> syscall_copy_user_array() passes the register-supplied pointer directly
> to __copy_from_user(), which assumes the user address has already been
> checked. On x86-64 this can copy mapped kernel memory into the raw event.
> An unprivileged task can open a task-bound sys_enter_write perf event at
> perf_event_paranoid=2 and disclose that memory with a write() that even
> fails with EBADF.
> 
> Use copy_from_user() for each actual array pointer. Use it in the default
> trace_user_fault_read() path as well: the original syscall-array tracing
> implementation used that path, and the helper is documented to use
> copy_from_user(). Keep the existing length limits and per-argument fault
> handling, so valid user data is recorded as before and failed copies do
> not contribute bytes to the event.
> 
> Fixes: b4f7624cfc94 ("tracing: Have system call events record user array data")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-6-astra
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> ---
>  kernel/trace/trace.c          | 2 +-
>  kernel/trace/trace_syscalls.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index e4a490d3d08c..07acbc44d99c 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -6263,7 +6263,7 @@ char *trace_user_fault_read(struct trace_user_buf_info *tinfo,
>  		if (copy_func) {
>  			ret = copy_func(buffer, ptr, size, data);
>  		} else {
> -			ret = __copy_from_user(buffer, ptr, size);
> +			ret = copy_from_user(buffer, ptr, size);
>  		}
>  
>  		preempt_disable_notrace();
> diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
> index e35744049e3f..d9190fdc030d 100644
> --- a/kernel/trace/trace_syscalls.c
> +++ b/kernel/trace/trace_syscalls.c
> @@ -683,7 +683,7 @@ static int syscall_copy_user_array(char *buf, const char __user *ptr,
>  
>  	for (int i = 0; i < args->uargs; i++, buf += SYSCALL_FAULT_ARG_SZ) {
>  		ptr = (char __user *)args->ptr_array[i];
> -		ret = __copy_from_user(buf, ptr, size);
> +		ret = copy_from_user(buf, ptr, size);

This was fixed by:

  097fd0050089d ("tracing/syscalls: Use copy_from_user for the faultable syscall buffer")

as I missed your patch. But the other one still needs to be updated.

Care to send a v2 that just updates the trace.c file?

Thanks,

-- Steve



>  		args->read[i] = ret ? -1 : size;
>  	}
>  	return 0;

