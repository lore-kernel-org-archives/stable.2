Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3B93E44FD
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 08:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787646870; cv=none; b=bMBAtNWyiA+YXf0WLxvIK1Ab1UyU7yEXt7H//qe/AcRkwVi6WDjvwdc++fSlhxsGputrcsBbukAl8Nsqe6jGCdf4Yf/Gk/hOR1gVn/0gnuM2Fu3oTt+DjlHHp5/ZZ4pJl1Um8RCOqCo/2MjDk7ePKaHCcDO023zaxsQe4FQbFbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787646870; c=relaxed/simple;
	bh=Osz8dIVx9pcjDLZBVhUg7eExjzhfbTT9XPNOuGpP5Ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RyWdr+exDzJSWfWmuf0QsUT1aNikCO8DSYuHuVIPX7clDRgOCDaxhRjBHN9+us0JpZvvQppsrHTFrLayaVcsqn1MT5087QQmLzkhdp9lc5SBymQIE+148dvp1C33Tf/tFhDd8MaPp1cB7StkTXj5U9feKngX8Hb+1zdDK6Cjv5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XcC/pSNe; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XcC/pSNe"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-482db627cd8so133918f8f.1
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 01:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787646866; x=1788251666; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IVGtX9QFUX57YpBuir6YXJ5ojxTug80HJTjtVuCANHI=;
        b=XcC/pSNeMVVdjeNAd8Z8ukLJiIuqrtTnZshRUB6X2M5/JIQ7h2zbM+Exc7Xetr8QSX
         h1X/LVdMVmwjbB+65HLFxgCQw2nKfF+Bh0T7ovmbfp6jDxnRPB6Srz/GCNB6InkssIi4
         j7tJ+P9iMgRCYpPzaz4Y9dPKzC+vTW9c+Fh1F+L8Gl456NxFY6ML56wCl3LsoWEByPum
         i3+6Nkt94+9UWFvtWzrJjNPL4xPQI69HHISuVIP6h+aCtUyRF21zjiYZtJVkE3x2gXTH
         Rr/ZgJHdSUwHywB483eDsYqDjsuT0MCp4gCVbiKUwaixoxNYaVwz//jYYQGttrlIPBQ9
         +egA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787646866; x=1788251666;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IVGtX9QFUX57YpBuir6YXJ5ojxTug80HJTjtVuCANHI=;
        b=Mi8XMh403rmvy0w7HuzoQFE3iP7C8i+bpKOHRZHclbsCbKMVEA7gj+flumkaJrGERE
         FzztLs0+jlCOVla7DsVTtIvq4A/H0s53dBqYAvaT7sVKLt7Y0kEpadHbeJD6LcmzW88k
         mBiy6jtFXjD3nv8s5ci3fFRTCTvsWirm7dCrrYVTCGmkDY+avwJfHR9I/SrnDTsCz3kB
         g5obAJK6Znsy/q0iD6UPZvL0W9TPH0LnyCqRPFhHh6YgqBbLcHlIRMlcZk+5u74v/eGp
         icpkrlZk8MXwf+GHZjz4+9DmE1v7Opn+EU/qpvbMExYQnF1hBFGtgdB/Odn+uSPoWrDZ
         6tUg==
X-Forwarded-Encrypted: i=1; AHgh+RrmoYKdGBUhnov5nDWyc6U3lLpyy4lIjGI66tCM8nvTFDIOMNlk3h9g0lYBKd0oQlleE3cm98k=@vger.kernel.org
X-Gm-Message-State: AFuF++k17ycV3BVq+cLL9ddoUoAqyRHmWXC36Weg8BGpPWe5XOTQ2olX
	M2qnkAyCDN+SiPAw2RuS0AC9JlXgyBOVbw8P4PGsUkIGJVjhBjOYvI5Mvm34uVD8NSmrd077hbQ
	S8+H6tSOGfao=
X-Gm-Gg: AR+sD1193opSDpDoFvd2UOf+/nGp2DSN2C+wYak4xg7PKwZcQFYo/62K+cPEfdoRPhf
	zMNqvHw/E1IFvVHaD3UamuvWA1R9J37pFLciEq5397mEea4BuVaQyv3r/ewtEQ/S6HoyIojJauC
	1YKK2YSvTs2Tu0LBECrYgiLh3CN2B9DjfSW3AWYHKDsnk479SsndSZYhCBbpZnN3x2fslsHeN3h
	VKa6h54/AQae3EGailwG2ZdVkmc7pU+ttPDJimszcXevD5Hjq9KLqzR4qMRC9oOTbLq0psRecL5
	baMkCWj9g2UttoKdJe+qEl2fGAQWLBG0SzyExUrPiQJn7MtmQvjXlah8Bh2Uc4aR9z6lhBE6Mkt
	Ei1447QebsqUCnEOvNhm19AdRQG894+UyK3taE1Ga3ctQejoNV7Ag3h54nq2itmKObemq5nc2Vg
	RJRevI9V69xf/nQHCyKP7hyoZIUYkHtNIERhrZ61jnINXHCYCl2MgakVQ9p/QPJUQb+mfypKv0v
	itH3+HftzShRllTjtYGTjZmvVRwiM1JigPhdIaqcMA=
X-Received: by 2002:a05:6000:2c12:b0:482:bb55:8bdc with SMTP id ffacd0b85a97d-482c0b55514mr40947617f8f.1.1787646865301;
        Tue, 25 Aug 2026 01:34:25 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482c9c0acaesm10806759f8f.29.2026.08.25.01.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 01:34:24 -0700 (PDT)
Date: Tue, 25 Aug 2026 09:34:21 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: ivanimmanuel1234@gmail.com
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] tracing: Fix retry exhaustion in simple ring buffer
 reader swap
Message-ID: <ao1Tjb7VB6JcLhf0@google.com>
References: <20260825-kernel-patch-1-v1-0-e9349aa0b165@gmail.com>
 <20260825-kernel-patch-1-v1-1-e9349aa0b165@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825-kernel-patch-1-v1-1-e9349aa0b165@gmail.com>

On Tue, Aug 25, 2026 at 01:20:37AM -0400, Ivan Immanuel Shaji via B4 Relay wrote:
> From: Ivan Immanuel Shaji <ivanimmanuel1234@gmail.com>
> 
> simple_ring_buffer_swap_reader_page() starts with retry set to 8 and
> post-decrements it only after a failed link replacement. On the final
> attempt, a successful replacement leaves retry at zero, while a failed
> replacement leaves it at -1.
> 
> The current !retry test reverses both outcomes. It returns an error after
> a successful final replacement, leaving the link update complete but the
> reader bookkeeping unfinished. After a failed final replacement, it
> falls through and updates the head and reader pointers as though the
> replacement succeeded, which can corrupt the ring.
> 
> Treat only a negative counter as exhaustion and return the documented
> -EBUSY error.
> 
> Fixes: 34e5b958bdad ("tracing: Introduce simple_ring_buffer")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM sparse
> Signed-off-by: Ivan Immanuel Shaji <ivanimmanuel1234@gmail.com>

Reviewed-by: Vincent Donnefort <vdonnefort@google.com>

> ---
>  kernel/trace/simple_ring_buffer.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/simple_ring_buffer.c b/kernel/trace/simple_ring_buffer.c
> index f4642f5adda3..49913bb0057a 100644
> --- a/kernel/trace/simple_ring_buffer.c
> +++ b/kernel/trace/simple_ring_buffer.c
> @@ -160,8 +160,8 @@ int simple_ring_buffer_swap_reader_page(struct simple_rb_per_cpu *cpu_buffer)
>  		overrun = cpu_buffer->meta->overrun;
>  	} while (!simple_bpage_unset_head_link(last, reader, SIMPLE_RB_LINK_NORMAL) && retry--);
>  
> -	if (!retry)
> -		return -EINVAL;
> +	if (retry < 0)
> +		return -EBUSY;
>  
>  	cpu_buffer->head_page = simple_bpage_from_link(reader->link.next);
>  	cpu_buffer->head_page->link.prev = &reader->link;
> 
> -- 
> 2.53.0
> 
> 
