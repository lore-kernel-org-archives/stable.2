Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F2045C701
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 07:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789456586; cv=none; b=b/q1z3OFiYezrp9Z2bi4XJutIPWIzeOpfK1kkpUkpBLsg+HWO9HcXx6AD4YMkmpTLanAKydvud3AXa6x3t2imC29fL469/r7rTALGEdmr2Vw926Zmq6Y3E+kv2rMOhvfMZalRRUT8fDHOlQ5bfN+wj1u9KaxHh8gMNqCQkattYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789456586; c=relaxed/simple;
	bh=0OEldKzHhvkbzoc57SjOq6JvGavLCHquBbc6Yq5zze0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBV9EbD6fm3WMnXq4tB/vWS1/gOjGxYgcfQeaJ4Y27QBH6JjA035LH5EoH8/PVcgJDXYoyZO/G9r9jncwlsKxtIsMdPLqonf4DkRKUe66Jq2HKqrlFkYmmX3n8HznnKlyLsZnPPn7E7RNydl+wxm32YLYoNnb9ljTn7n+0tlFFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hq0qtWYa; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hq0qtWYa"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a6063d7dc4so4404399a12.3
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 00:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789456580; x=1790061380; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W+PRomH3eBPy4oMEKXIP3fH6Wa2h0KkiuNEK9e340p8=;
        b=Hq0qtWYaKxMcGScWSb4W4GIoFRYwCWnxQY6BfK32sxrCGPJj5n7v3iWpw+cyPQ8aN5
         ctafwXNTKj9a/C6qYpMS757///HMhMWlRua7XqWSj2RKvqV1cwHvK9JlDEd1yfDu8Tj0
         y1OutLwvT5+VaDKbBKYT6c3ffZu5Q7n2OvrSvh/onUG9poi83WNfmkgZOzahuVJxO1g/
         5XK+P0xKnCnczTiSkwM3HuEBK2FI3S6tx/RVxSWZj09z6RTG8NqsV1JSN+gJBYH14tIi
         jcO2VHeZhGdpwSiH1CaoMy3zituJFlBeiRQTt3kkLef+nV0l2v3so9A1J4Nly5FWcimj
         UJRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789456580; x=1790061380;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W+PRomH3eBPy4oMEKXIP3fH6Wa2h0KkiuNEK9e340p8=;
        b=juFcM9+926uiQa4LpFNEYEIoV2pOiXxAgv87GitE1X0BTIdWeL4D4Gpyw/Fjqi3d02
         Z2v2gKtcWB//uFppAdTout9eZNsN+G+J1g9uFJtd4w1+Hl/ebiVIqfk+JyVjdZmb7gAl
         nNMjXUXsW0QCk2tcDG1FCSUU2bTBYJlUT0OeoRPddoxCSuSQcG5R6q1Vo1EGh7OFe7Mv
         9guqpvDPCkHo6NiB7qLKHuHk9JNzw/BXwDW+MFd0315ARxJ+HOTvv7offrYY6QgyIub8
         JpyN21wwycZlZKaGX+UQ6DQTMY2DSa1XKMkS5/iVUzcQhFrmEZrH38jCS3gXcPGOO9so
         SPYA==
X-Forwarded-Encrypted: i=1; AKwUvBwodLeOIURc2EsxZ09fCo5IgZ5PqxEx+BV6nD7F9l3wqmJnW4uR1KsAu4dv383wlFHMr7I0PYk=@vger.kernel.org
X-Gm-Message-State: AFuF++nUqTqCz9iHyuVlYaSHU0Jd1cWWtiGSVV3+Vb+f/akIePWyC8lJ
	XeA/LA7EjiUoPWwR1eCdIr9BKVwyEm6jI+uNi5V+BHK5axBgTEiBRdBIiermfoSWTw==
X-Gm-Gg: AYBFou0CDpAZo69DDfOQNI9aWufnE56Emgpyk3Q2jcVpSmhaHelmuf1dOCze4iQAkL9
	ga0nxmT5KONsUFWNcPG6x1X5N1BuUcETPXNT/qyywpYL1/Y2uA92C+naJqVlo/2l7zBqwZC29GO
	Ky3Gd+8vuF93S1npNTOg16EBbCsi2LtJwJZL+JnMPesUmm+cEIi2aNn9evAdLLiBDUtS/+h4VA+
	UA4sBP48Y+paHypfF1hiEdBy85mPA5J/jv6x8q8hTtCK4SPAtC/z3vOplKl4jHuORk+QepehMhr
	UPSavC99POa+gYbe+0wHw8hWLBeK1SDC+t/2S6WkxOaun171D0BJxcxAQzjySqN2huCYf814aWJ
	QpKt+cZaie7qNp6d/LCgrzdKrPv3QrzMXdPJ9AWMoPapLjFALgZYbPPFONIJwVla8LklGHP9iiN
	J4RZlp7ezcW3AOv3+wVmnk+9Es4fzSYyBN9/tZ364JKSSx6iJweusdYwKai6kJ4FXwl72avLBSb
	Uy1xgJgUZdF3Q6/QraIdWLz/fBzWMh3noc1b7Vxs2s=
X-Received: by 2002:a05:6402:4617:b0:6a5:f4eb:df3 with SMTP id 4fb4d7f45d1cf-6a9f61e4e87mr7464066a12.2.1789456579785;
        Tue, 15 Sep 2026 00:16:19 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a9d0ef7228sm3569166a12.9.2026.09.15.00.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 00:16:18 -0700 (PDT)
Date: Tue, 15 Sep 2026 08:16:15 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: David Carlier <devnexen@gmail.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ring-buffer: Take cpus_read_lock() when changing the
 subbuf order
Message-ID: <aqjwvznfLPcN1G-J@google.com>
References: <20260914182850.21449-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914182850.21449-1-devnexen@gmail.com>

On Mon, Sep 14, 2026 at 07:28:43PM +0100, David Carlier wrote:
> A CPU coming online during ring_buffer_subbuf_order_set() can be added

nit: a "new" CPU or "A CPU we've never seen before"?

Offlined CPUs aren't removed from ->cpumask.

> to buffer->cpumask after the allocation loop, and the install loop then
> uses its empty new_pages list, corrupting the buffer.
> 
> Take cpus_read_lock() as ring_buffer_resize() does.
> 
> Fixes: f9b94daa542a ("ring-buffer: Set new size of the ring buffer sub page")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  kernel/trace/ring_buffer.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 04bb94c29f58..445931bc9ae0 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -7464,6 +7464,12 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
>  	if (psize > RB_WRITE_MASK + 1)
>  		return -EINVAL;
>  
> +	/*
> +	 * Keep CPUs from coming online while changing the order to
> +	 * synchronize with new per CPU buffers being created.
> +	 */

Can we drop this comment? cpus_read_lock is self-explanatory.

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
