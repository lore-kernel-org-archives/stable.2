Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246B63E51F5
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 08:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787647188; cv=none; b=uoSrSMr+L90sz6sHbIettNw5l1ySI/6h/8JrAFsnRpY8UYCwOvaPcsZ+4vlLX6QWJzYFNjEI3UT0CDcItNGsP61tZHr7KglzO2OG3ha2dmDNU9TqfjFj63VNKx3CAP6M5n266qzfIMorIULrHXwf8+l2n82A3eSFhGK1uB8sZkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787647188; c=relaxed/simple;
	bh=4bQy4f4qdvQOwMEZC2OyjV2O2mUVqY8x7xOCljRlQXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C57YCg2Cg6qpRX96udoFeheQxXmYrFn/P2qc+wF+ERRb4JUQKAWLSpxWJoysadgfYb3JurvAjx3JCxtMONeSjBqZ6BN7HuUgjJrkgFoGUU/D+jFeYLYIIqHe8J/bPG0K3fTcz92WY/bHE0lrwXGpxQ7TBASN3HTPZSWtjg/zDP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lCCW2TCr; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lCCW2TCr"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-496bb7cdf51so26495425e9.2
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 01:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787647184; x=1788251984; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4MxiI6dQZjsqlXXMkr9OPsJ2JcGD28bAQB1bOc8N8OA=;
        b=lCCW2TCr/6I3dC/qx3ff5FdW0qmFxoksbVZ9+icJaxIMcuvvuFRwS4vqyjwHzksOPR
         pAQiAOxv5qni1na0iCeIo4RmJjMjOybGZx66kn8TEZGFZyeyPHSOEqjP8whp5EDI3erK
         MM2QZxDYaEdi7+5ng9gFrT3Yj18YAX2VlO5OX5Ixz7/Ip111g7JiITQt+TND/+rSQz0G
         EiJqjvpf9B1GJDVTpGbBx0b5qlmF+EKklizkkB5H62KgaHTn2zu0xMKBf1hgM6e+9UrH
         u01QizqXd7ifI2tC3t9Y3K704Rd6iE0Q8rLbVxFKVvRiX/UdiJhS5HL4AdodXt+U4QCt
         WFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787647184; x=1788251984;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4MxiI6dQZjsqlXXMkr9OPsJ2JcGD28bAQB1bOc8N8OA=;
        b=hz1/hvLTlEPx+3iIUXTBvEV1sQ0zB1XPz3gre8vMN/Nj9vADrT9Igyx9VsfpE1Lwsc
         tj6l7LhHqGtytcbLmNP5aiIVlVcUAPqUNQSeL/AIKDJ877qeZHLrYLZ47A6p6hmMZ186
         Dq1DNDAZT0VU4Qne3WvjoCRcDH8Y6eylMpdvPCc8EDfaLwgNQxm2ePMdUoGHCj6A89rb
         +eyiXwnYm6LeJRt9QqGCrRRmkP1Sl6fB7kEaYaJjnRiUj4U2CXFdDCSMVwaDdFeIePBC
         8qTjlhF0B0cSJ6ypXAj1SZspd7wdWrradhhhYWbJLf9lGLU1LdpMIU+dS3xbQXmmFj/i
         9o1A==
X-Forwarded-Encrypted: i=1; AHgh+RpGgEhEVTzP9R5V39qBUVAlxyll4V49mlmUumBimBnNYGFD+lzdiloWxfwFo5jLoY3mgwkckjs=@vger.kernel.org
X-Gm-Message-State: AFuF++l9vD/hG+lL2HJkywAji1tLxhqstUPBhCC5CgAlcPl78/C05lSU
	mOm0XY543Kqxux2m0J/vrbce+pxKkEqXwDOkt5Nqrlh7t6Q5CfVvLyxjj7nqi0rA0w==
X-Gm-Gg: AR+sD11bB8aWqcki4kYD2IQsloNPC+vgUJiWZU8IyN0gHi9lGO83WYPwAgoWkUgK4cz
	ueUx2TKTGEP+wq5X34kJSieT1HL3yP152317xiXBrizqp6gDsakrNeqOJBgyHOIvE1CakBQg5Fe
	2NErPcv/6r2bW6A+WocMj5FocFbp1gSJOFx3dxrHmaABUBZsPcwBtH9jqikEA7vFM17QyhntyLM
	iTWELzrDS6CQI/8xDcHYOUwqXqOmfHkw2NN3RA7tX4CppgZk5uAdmHoiklRf5bqVpVgMTf9yoD3
	tMc1Lx/l16sWnsS5p3cvPMDsIl7GRfsCAdjzwU0hDYsf2EunRAbfQUN3npw/oEJbUtSN3PvIlAZ
	2f2ScRbaMV/+S007dw70dbDd1SOlb+c6ZoZ+jdN0yxuS/VNMshZ7qXejMtmzUb8han4onKlAKpj
	fG1QwgnwmTdLQy1M6lCD6l+zgbk8DA8DiA+gYDb4U6LPe1tBdAYLybbAiGfD5x4qFSao+Q6Jn+x
	dpYS+J09lzcoinV9p7rbcciKJ0fZQuZ
X-Received: by 2002:a05:600c:3e1b:b0:499:a685:c10 with SMTP id 5b1f17b1804b1-499b82e5427mr431534635e9.4.1787647182685;
        Tue, 25 Aug 2026 01:39:42 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499d6364720sm22212585e9.12.2026.08.25.01.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 01:39:41 -0700 (PDT)
Date: Tue, 25 Aug 2026 09:39:38 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: ivanimmanuel1234@gmail.com
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] ring-buffer: Stop remote reader update when page
 swap fails
Message-ID: <ao1Uyps5JSTyOlZf@google.com>
References: <20260825-kernel-patch-1-v1-0-e9349aa0b165@gmail.com>
 <20260825-kernel-patch-1-v1-2-e9349aa0b165@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825-kernel-patch-1-v1-2-e9349aa0b165@gmail.com>

On Tue, Aug 25, 2026 at 01:20:38AM -0400, Ivan Immanuel Shaji via B4 Relay wrote:
> From: Ivan Immanuel Shaji <ivanimmanuel1234@gmail.com>
> 
> The remote swap_reader_page callback can fail when the writer moves the
> head before the remote catches it. __rb_get_reader_page_from_remote()
> warns about that failure but continues with the unchanged reader ID and
> rearranges the local page list as though the swap succeeded.
> 
> Stop immediately after warning. Callers already handle a NULL reader
> page as a failed attempt, and this avoids splicing the same page as both
> the previous and new reader.
> 
> Fixes: 2e67fabd8b77 ("ring-buffer: Introduce ring-buffer remotes")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM sparse
> Signed-off-by: Ivan Immanuel Shaji <ivanimmanuel1234@gmail.com>
> ---
>  kernel/trace/ring_buffer.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 3c3ed639923d..d11b2759caac 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -5805,8 +5805,9 @@ __rb_get_reader_page_from_remote(struct ring_buffer_per_cpu *cpu_buffer)
>  
>  	prev_reader = cpu_buffer->subbuf_ids[cpu_buffer->meta_page->reader.id];
>  
> -	WARN_ON_ONCE(cpu_buffer->remote->swap_reader_page(cpu_buffer->cpu,
> -							  cpu_buffer->remote->priv));
> +	if (WARN_ON_ONCE(cpu_buffer->remote->swap_reader_page(cpu_buffer->cpu,
> +							      cpu_buffer->remote->priv)))
> +		return NULL;
>  	/* nr_pages doesn't include the reader page */
>  	if (WARN_ON_ONCE(cpu_buffer->meta_page->reader.id > cpu_buffer->nr_pages))
>  		return NULL;
> 
> -- 
> 2.53.0
> 
> 

If handled gracefully and as this can be triggered by a storm of events on small
buffer (when -EBUSY) I wonder if we shouldn't use a pr_warn_ratelimited()
instead of a WARN()?

-- 
Vincent
