Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAE63B38B1
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 06:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789628138; cv=none; b=Lud43q2o7IAQiqxI4MkIfVSqGli3mj72cykKnoxLqggUCvY1beXZ7ml/5K0nAPAAxtbe6vzBIAEdzBhOcFhxBzNNVWylAD727X8oy15XJLU/OFHjXgnmUxkkn8U0oiS1H28V/JfuSohsfgrsn4mf8LvCrD2m97ldlGVjBi+cySM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789628138; c=relaxed/simple;
	bh=CS2cwFdXUqiLJJhG9B82sxQOgAkaZzVT0GzQwzD3wv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGk+AklIlBsobIr3IBVJ06kJejsvAqwUJ2/lJJBXazyOVucjYnesBzl9kTZLiEz2nlIPsU7Z56cbqF41uxc0jdjUhRhsvgJYl25VrDX2CUV3XAe7rW1aY95ApssvDx4UuAQlO/yC2oB7qbOw307ordvTRRE5ncjZpLPRMSQc/04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DpS/eJq8; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DpS/eJq8"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cc9f581c4so1718995e9.0
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 23:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789628135; x=1790232935; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=30cUCuKfgfqmVMRq8leKktvsIG+ddt8eRO9Ay65U310=;
        b=DpS/eJq8R5txoU+RHSEOI3RxJDzcL/t1LE9cAdXUBhg5DrJj7MX1/b0uXgIobQRJAH
         zm4N7vxDBI0vaEkVXaWwPI0N++USG8+U+PQsB6DT5TG7WX6z3TBrB4WHk82A/dodgjsV
         6Kbv6HRlXlmAoRsAET+KNFOhkwUHlz7uT+UeRF4A8lLh6VmxLt+70naEBjDmZl+hZnA2
         42kFdEWnqMrLvsNowyHf8nP2vXuCMQtDdra2oToSyRNgFekGeEyhxwPSwGcCeluaqJ+o
         35cRKlJxL8MymA2YtSzvNAJI1I/aREexMr92N7CFQGz20I5nX/7TruS06jF++ax11Fnq
         vfjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789628135; x=1790232935;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=30cUCuKfgfqmVMRq8leKktvsIG+ddt8eRO9Ay65U310=;
        b=YZYmrwY5Bxqr4zBu25xV3xyiGOoR7yubAyg7syDnxzzyia2VjslCwHCOV3dK1QplHU
         5BQNy2O635R/IyRPDDB6rTfmGX1L6G0fInuy7iq6nZZU1zQwHVjZxGDKsFWOdqutMRot
         6UVkAnxQ2lVKcaiJxW7fFCrp5hjXf4ODaq3NTUgOGRTqtfZ8GWhPtIqOsm6SXTSO89vK
         xZ0GEf6wYuAYEI+QJZWNxw7y2V6JdNEczxDZCStayFggo+ygPEJTlWyXlVhjIF92RPuD
         xWznTxYzOa9WRaZRfdA1qZ3/V6sxutBTX/6FrGR8WoKr1AUS0Rc10i7hEsuNjq2vaKiD
         1j1A==
X-Forwarded-Encrypted: i=1; AKwUvByDAvheaoBnkKEJ6f2Ixj3GbHnNQ+4D6RW8HRMvf561nvZRBNcprJ5puSG52crbo792sK31nHQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kfSZD/StaG0FND/oiSKTBZQZfpuP7yLUjRK6cRhF+fKrhKhTrg
	TXTajl14TSDdr9VJmfALJIbp1qUU8wK/N8dL37W3+N0s9XB/6lIs+O04tOGdzdKRNg==
X-Gm-Gg: AYBFou23irkT+E9gFWxPuPvjngSvZC+nWcMJ96Qp24vuBDm9hWUqf7Jf2uQgqiX047z
	XdQDPc0SSsENo4bZZ5KwAsGWelOpEHD9nAu+7qsr0B3YSZ7RIhVVr33MNP+7gYm+5CrJOQ1CQ8g
	m7rFWw047I2LtSQBbvf0tlq15HXWiYLA3tyqE41sUPVD1ES4Y+iJ1arVrKseaLHkR8cKZIHg6zY
	pwC3KZwywkwSZWh6HQE5JKHjGlM3Wu56ZCsW14dM5RW2VUd53AE7u6cqEfcDVIjP3fwia+hl08x
	HOjHmybI1DOcZKdZOOlCIYrYsegiR0YunHTAl5a3DRJqHHl4NW7hZkOHeC8oYlm6Of9V+KcN7PE
	7PkzDjJMOjUIlTDArvCP7uROPg3ImEG15nPaTVbZpSDIb4C46SPqnVaZkL9IwVn67l9AgAUZNSl
	ksGenWvrEHiwOrTA8KzH2jrZn6bhAARfRhD8+xcMS5DtfkX+F4J2XjLKyhhT94vpgLWbMzGMwjV
	eXEw5VZrQd23sH1LB2ou/X6fAypoDNrQzKdusqXkJs=
X-Received: by 2002:a05:600c:1992:b0:49b:8f5e:51fb with SMTP id 5b1f17b1804b1-49fbd1af43dmr28764665e9.3.1789628133837;
        Wed, 16 Sep 2026 23:55:33 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd23a815sm54524765e9.14.2026.09.16.23.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 23:55:32 -0700 (PDT)
Date: Thu, 17 Sep 2026 07:55:29 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: David Carlier <devnexen@gmail.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] ring-buffer: Take cpus_read_lock() when changing the
 subbuf order
Message-ID: <aquO4fKay-7zTBRw@google.com>
References: <20260914182850.21449-1-devnexen@gmail.com>
 <20260916192628.274136-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916192628.274136-1-devnexen@gmail.com>

On Wed, Sep 16, 2026 at 08:26:28PM +0100, David Carlier wrote:
> A CPU coming online for the first time gets its per CPU buffer allocated
> by trace_rb_cpu_prepare(), which then adds it to buffer->cpumask. If that
> happens while ring_buffer_subbuf_order_set() is running, the CPU shows up
> after the allocation loop and the install loop walks it with an empty
> new_pages list, corrupting the buffer.
> 
> Take cpus_read_lock() as ring_buffer_resize() does.
> 
> Fixes: f9b94daa542a ("ring-buffer: Set new size of the ring buffer sub page")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Carlier <devnexen@gmail.com>

It is usually good practice to not link the different versions of patches
together.

Beside,

Reviewed-by: Vincent Donnefort <vdonnefort@google.com>

> ---
> 
> Notes:
>     v2:
>      - Reword the changelog: offlined CPUs stay in ->cpumask, so only a CPU
>        coming online for the first time can appear mid-flight (Vincent)
>      - Drop the comment above guard(cpus_read_lock)() (Vincent)
>     
>     v1: https://lore.kernel.org/linux-trace-kernel/20260914182850.21449-1-devnexen@gmail.com/
> 
>  kernel/trace/ring_buffer.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 04bb94c29f58..e78fb4bb2195 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -7464,6 +7464,8 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
>  	if (psize > RB_WRITE_MASK + 1)
>  		return -EINVAL;
>  
> +	guard(cpus_read_lock)();
> +
>  	/* prevent another thread from changing buffer sizes */
>  	guard(mutex)(&buffer->mutex);
>  
> -- 
> 2.55.0
> 

-- 
Vincent
