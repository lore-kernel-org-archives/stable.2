Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A63E396579
	for <stable@vger.kernel.org>; Sat, 25 Jul 2026 10:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784973618; cv=none; b=qq4uJ/MF7x6zndjOjxA409DcJn2Ak3Iqg3oSMx1L0i14Z0/H4UdvpJeGPuRFM63GwyFw6VVQXNn2vhB0iUCYJBfthnKsdl8MEFs1241KaX39tu9FbiU5yxgmPT/5WKr3hPo5SqEvv/rxcAgpWKxIvZRlA8J/gS2IgjfhsI5DwIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784973618; c=relaxed/simple;
	bh=R9+eHSSRaNSMn5gfAQa4T+nJmQ3AaUjOI/z3OxupB/w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bMx4oQw7kPAlvr13a0FarnCn4PPBnhBtMvpSofLqMxwJRV/gcpBts7HOGryOGMxQgczJ66IexZQlGZrdl6G592ohzx/cXb4/WGTxEJYoNx68vrqaFw/s1+7FAeki78Ikc/ySTIA7mwmWoRc1JjkdFaq058NV492o6Ul9XR23i48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kl7+eY5e; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kl7+eY5e"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-495437bb891so11070515e9.1
        for <stable@vger.kernel.org>; Sat, 25 Jul 2026 03:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784973615; x=1785578415; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Yd+jk16uLDBllgEthpdyLs2rszBLLyqW9n9CRNG4JS8=;
        b=Kl7+eY5edBMHTlZigB3Ji/wMlDubAM48Hx9ca4M2TpBET7wYE5/E9cFnpY1HsqFTsQ
         fUw4KV8+dmmgTCHq0WOqxdw3SBCPUfW+d1tux7wZLaLWLDTHYMAIg5X7ZxVuhK9bEdb4
         I3uvCkdrGLKiD/GlBw/cmykhxBW1M8WdZql/rVe50P6YWI0AnaJONewRhlPlqmX4aFCe
         qtDaEx1UyG9lXjPPgmHKjVh4mkCRAS2gTaJ7bKCmRUXB86xYHMBUnbvlGgyfBwxi9LWa
         xVR+RNLizT7ye57b4CgBQAW71NfFPff/6+4vknK2vcF21BQI6et6sq+R44s9JJxbTvhB
         Wkxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784973615; x=1785578415;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yd+jk16uLDBllgEthpdyLs2rszBLLyqW9n9CRNG4JS8=;
        b=G+uQX2WXwbh33/3zFnjKE5Gj0bn3Qs/uWJaEJCQNut5hJhRdfh+gcEjxzbPsRqOgsy
         OSQN1BcQrUArdhWYUJm0BBFEhN5NkY/COBbxwM1wpKX9l65EQaqL7Ddi0Hbo0n+w4t9S
         hODY9vOjyI2dG0SUTxDiIQ5pQ7gOOXnNJoTuvpwsPyU0dZyN3EZMufx3E/LywkzSVJSY
         FSdjLpGHiEzpMs55R1igCWsLd2q61maqvFsweRS5eJ3ZxJ0xJxmVaz12amuTFSS8wZy5
         rl8THv69BstNiRppJj84zAo+g8zgvNe70jeZaQsH9P0TDoCxmsKpGjAY7obOn1fXfSGd
         Anjw==
X-Forwarded-Encrypted: i=1; AHgh+Rp6ORlNBSZNk1qx+c8PGuml4QjEXre5kvEHU4NsAeAzum4Bp6dDxdRCadx1ruWZPCUVrehpYzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYHvzRRI2EMxTns5Y8znKEr0xuUnznQ1MKXSWYavRXbSosaZIL
	ab8gEBazNr8Rox0WCSUAkiztKuvEtWu/2mdmX6KzzHwlfShwGi6+9Urv
X-Gm-Gg: AR+sD13HhFqQz5WFEMOhC8TMgy0bP82yYwnrFDjv6HhB7OBphnPUkY/begX+wrpTw17
	TVjXKsClYKtgvvTSromZbAnWhMg8EIvVXbQ+45vmw1U4fMUtpmdwzl3pRqca+NiZ7iV/EZgkXd+
	o/2TLCqH3e/CB42Qnk+F3J8Vd0mNrraI7xElEbHz/d3+HzEw4Ok+jX+bAC1UPUt1Y8Zx1JdoExd
	653f7Go7R7PK9NYcDdO6d/jhbeVK54l3O+DB3JDjtvagMlSkX9o8y4B/tUWI2PYbBLZdajUGSTV
	T5cJ030RE4me298c9ZBNSSVl2Htn45EW1siUWVgsi60Uq3oCzpYZVJCUcUwa+BXd6RMFs9dbKbW
	CFivMaMXfKD68403xmlHWjXVhYcTVEL3Lk1y4+UbBfWUrES6EXK3ea/ez9au1MIkEi2vhxzQ6vA
	LwX14Oy3tspFWkV5Wr0ZxOgi3oQ2bvrOoZ1xgiBB4pBwkwy/psMQ==
X-Received: by 2002:a05:600c:4f89:b0:495:501a:fcf8 with SMTP id 5b1f17b1804b1-496b5c7181emr20673975e9.9.1784973614526;
        Sat, 25 Jul 2026 03:00:14 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4ed6b76sm57502545e9.2.2026.07.25.03.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 03:00:13 -0700 (PDT)
Date: Sat, 25 Jul 2026 11:00:12 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, stable@vger.kernel.org, Fuad Tabba
 <fuad.tabba@linux.dev>, Vincent Donnefort <vdonnefort@google.com>
Subject: Re: [for-linus][PATCH 1/9] tracing/remotes: Fix page_va[] access
 before counter update in trace_remote_alloc_buffer()
Message-ID: <20260725110012.2962b76c@pumpkin>
In-Reply-To: <20260724231855.591578614@kernel.org>
References: <20260724231840.483353969@kernel.org>
	<20260724231855.591578614@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jul 2026 19:18:41 -0400
Steven Rostedt <rostedt@kernel.org> wrote:

> From: Fuad Tabba <fuad.tabba@linux.dev>
> 
> page_va[] is annotated __counted_by(nr_page_va), so nr_page_va must
> cover an index before that element is accessed. The allocation loop
> writes page_va[id] while nr_page_va is still id and increments it only
> afterwards, so every write is one element past the declared count.
> 
> The store is out of bounds with respect to the annotation: a build with
> CONFIG_UBSAN_BOUNDS on a toolchain that honours __counted_by
> (clang >= 20.1, gcc >= 15.1) flags it as an array-index overflow.
> 
> Increment nr_page_va before writing the element it now covers. A failed
> allocation then leaves the slot counted but NULL; the error path frees
> it with free_page(0), which is a no-op.

Uggg...
Shouldn't the __counted_by() field be the size of the array itself, not the
number of valid items?

	David

> 
> Cc: stable@vger.kernel.org
> Link: https://patch.msgid.link/20260713072823.2668323-1-fuad.tabba@linux.dev
> Fixes: 96e43537af546 ("tracing: Introduce trace remotes")
> Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
> Reviewed-by: Vincent Donnefort <vdonnefort@google.com>
> Tested-by: Vincent Donnefort <vdonnefort@google.com>
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_remote.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
> index 0f6ef5c36d84..ef42d9c38b37 100644
> --- a/kernel/trace/trace_remote.c
> +++ b/kernel/trace/trace_remote.c
> @@ -1004,11 +1004,10 @@ int trace_remote_alloc_buffer(struct trace_buffer_desc *desc, size_t desc_size,
>  		desc->nr_cpus++;
>  
>  		for (id = 0; id < nr_pages; id++) {
> +			rb_desc->nr_page_va++;
>  			rb_desc->page_va[id] = (unsigned long)__get_free_page(GFP_KERNEL);
>  			if (!rb_desc->page_va[id])
>  				goto err;
> -
> -			rb_desc->nr_page_va++;
>  		}
>  		rb_desc = __next_ring_buffer_desc(rb_desc);
>  	}

