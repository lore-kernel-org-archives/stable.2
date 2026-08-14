Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272F4238D54
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 04:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786681541; cv=none; b=CC1tsiW/OwfvcaNM5s0NKktabbDOBiouGjtqSj3bVxCcW0MPECV1MftZw3mTq7aVCHJ9YDztH7cKP3fxK+3SDTY1cTpyDb4Ui33gYB7HkqU4B/C3afPmHFobKYSf1hngwbNP5aYPnAlbinqhNATiYYa9NidRdEQJ2n+H7Eykg98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786681541; c=relaxed/simple;
	bh=Bj+GFIAM9t+QnayRLXvIYZmBxLjkp3TTy/+Mx2LFMYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=syYe0hwAIFyPvlCXUJnUyTYRcKJB91zInc3DZfbaC8vyNzL4NFOtH2jhgfRNorH37cPGr29nQ0TI/TNAJTmrvwFYzkHso2O5qdQxbwIXQiIZjD7o6L/DppY6H5GaodwWMR8WQhZ5cvbG+7UNz5VK4fKCj3GyzexBr/nmaOjxGS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WaqsdDX3; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WaqsdDX3"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38759bcd877so693370a91.2
        for <stable@vger.kernel.org>; Thu, 13 Aug 2026 21:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786681539; x=1787286339; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TPnXUKqHB09+gprPc9dr6m7TW7NThR7K77XWxdq9JR4=;
        b=WaqsdDX3HuPNP2Y/vu10HvhJX6WBEuOxJQg/3eoqrf2cRknlQ6aLiEUKct26NTuXg0
         4uHEbgB/pSlz1gHEId+IpZby9MFxA31SGDB+dOFtTvA6rISpwm1lI/qhCFMUoHk/mVjY
         eSkORXZNEJ19xOUTChFNNe1vwZ4jI0z2+7VoPGJFY2iSl3Gghr1Pk8OBrYeFbWBIvHIb
         kGAkJC7ae2anTHjBf4ntrwDLaHsyjTeIapjIf2joLyJGWKFFnhZK+E6Ra/GrBLsNwBQU
         E9PG5eduMbyO4JZUeIM39C/UHtdsMn3Ks1gho/qcKLsGH/diFDqcC1U9PC1Yx6QSkH+W
         BDHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786681539; x=1787286339;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TPnXUKqHB09+gprPc9dr6m7TW7NThR7K77XWxdq9JR4=;
        b=XpFObtAltJD7Bhj5DfYHJftaCUQgT1UpOiuFba0qsw0Dk+o3EtKny/pgHt1SpGtlZP
         AemzrJ3TijLiziGOqxNSKS0KcUOLzNXuoQIbsGUPgAugQyaRL3KZB2yROw0jK/YNLef+
         zlyJ/X+Q/rAgny+tpeviFU3MDkGDgZEaNLMr9UNkgvGVZPuYLtfUYy9P0+82gKeFK7qh
         nJU1MUnRzhBwxsyQ4mwNHr4m3dmk/O+Z4ymGucTc1fgI8MKuFhtJifXw6/LR2bzPKcm7
         8W3//ZDXLsJ7lkZ4meHeZKmMymy1uhYJmrsm+ZmPRql8hLCU/Myb6efilrNp1KfP9LWo
         Dy6g==
X-Forwarded-Encrypted: i=1; AHgh+RoNKLLysJX6nVKUiF8QoLDP6tLpnT5EkQkOYk3zixziQR1Nlfgovz6cK/Kj2Gw9EXJWZOwzd38=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlSp5MhLIIv+NKga9CBoFEnCWvatyL6h41p9yGuEv8GB5awpic
	2+WU2XRfTJDUFfqaJC1gQBVDSIYxmzycar5+zEnfeyOXh0fsjhnaIGVU
X-Gm-Gg: AR+sD12LqDKNxDi4Woh+U8qmlfrUEZB/nGlIb7/jdD2EtBwMSAXvgUUjPYEMs9qORWC
	isbH8ZCxOqzG/VNAhi3IUhmtC7waTA4M+daU5rqw+jH/AD3enR4l+KeL67EnzDZa2lIr+QIWqXC
	7oA+qTeHbCYDmn1IUbMHS7dCMfwnK/HJ/waXhNhFpFlEKSMF7vGGuvNoSKbGNM1SqZ5R6Ds8BZS
	g1PqejcxAsqZr1PvSzWnhVcGzbCDYxrxQq04yDzlWzxpWXqyCesaGFi8BinFZ2M9nnvQStGJZcl
	6j/Y+N+qoIhrd1BZRChHdoIDdQRcWTYv94zGoKXnxqmJJfchzIsIndO3UhTd8tEdxzvgInuQ0P1
	MZBCtDUtRVILnWQefDfAwmLpEI8cDubXBtzpiYBM5SP9Hn8wEPFJ3DQF3JInCRwrhhkM5p5/IST
	ZXsGM7vT7M3AB8ZDAb0u14iCNUfJmeo4uNMrR71IbDh5q1HyP1j4vO0YlYOEMbRLg6RTDZx2AzK
	8Jx1R+arw==
X-Received: by 2002:a17:90b:1c87:b0:380:540:d499 with SMTP id 98e67ed59e1d1-3933cae4b3amr2936349a91.6.1786681539297;
        Thu, 13 Aug 2026 21:25:39 -0700 (PDT)
Received: from [10.22.68.200] ([111.223.92.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394ea996575sm788095a91.8.2026.08.13.21.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2026 21:25:38 -0700 (PDT)
Message-ID: <33747609-53e7-4f17-9e97-2fdff67b4460@gmail.com>
Date: Fri, 14 Aug 2026 12:25:36 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: clear stale intr_entry in fuse_remove_pending_req()
To: Baokun Li <libaokun@linux.alibaba.com>, fuse-devel@lists.linux.dev
Cc: miklos@szeredi.hu, jefflexu@linux.alibaba.com, winters.zc@antgroup.com,
 stable@vger.kernel.org
References: <20260728031641.2497811-1-libaokun@linux.alibaba.com>
Content-Language: en-US
From: Tang Yizhou <tangyeechou@gmail.com>
In-Reply-To: <20260728031641.2497811-1-libaokun@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/7/26 11:16 am, Baokun Li wrote:
> Commit f8fce75fedf7 ("fuse: clear intr_entry in fuse_resend and
> fuse_remove_pending_req") removes stale interrupt entries in
> fuse_chan_resend() when requests are moved back to fiq->pending.
> However, that cleanup only covers interrupt entries that are already
> linked at scan time.  It can race with a concurrent queue_interrupt()
> from the request holder:
> 
>   CPU 0 (holder thread)           CPU 1 (resend)
>   ---------------------           --------------
> 
>   req in processing (FR_SENT=1)
> 
>   signal arrives
>   set_bit(FR_INTERRUPTED)
>   test_bit(FR_SENT) -> true
>   queue_interrupt():
>     spins on fiq->lock ...
>                                   fuse_chan_resend():
>                                     set_bit(FR_PENDING)
>                                     clear_bit(FR_SENT)
>                                     spin_lock(&fiq->lock)
>                                     cleanup scan:
>                                       intr_entry not linked yet
>                                       -> list_del_init is a no-op
>                                     list_splice -> fiq->pending
>                                     spin_unlock(&fiq->lock)
>     ... acquires fiq->lock
>     list_empty(&req->intr_entry) -> true
>     FR_FINISHED not set
>     -> intr_entry added to fiq->interrupts
>        AFTER the cleanup already ran
> 
>   fatal signal arrives
>   fuse_remove_pending_req():
>     test_bit(FR_PENDING) -> true
>     list_del(&req->list)
>     __fuse_put_request
>   fuse_put_request (refcount -> 0)
>   -> req freed, intr_entry dangling
>      on fiq->interrupts
> 

Good catch. We discovered this issue in our recent stability testing. The
proposed fix looks reasonable, and we plan to validate it.

> fuse_dev_queue_interrupt() only checks list_empty() and FR_FINISHED
> before linking intr_entry -- it does not check FR_PENDING, so a
> request already spliced back to fiq->pending can still be added to
> fiq->interrupts.  The lock contention itself produces the bad
> ordering: while the resend holds fiq->lock to scan the queued
> requests, the holder spins in queue_interrupt() and links intr_entry
> right after the scan finishes.
> 
> The dangling entry then causes the same use-after-free that the
> above commit describes: fuse_read_interrupt() writes to the freed
> slab object via list_del_init() and leaks req->in.h.unique to
> userspace.  Once the freed memory is reused, INIT_LIST_HEAD() turns
> the entry into a self-loop and list_empty(&fiq->interrupts) returns
> false forever, so the daemon reads the same phantom FUSE_INTERRUPT
> in an infinite loop and never consumes fiq->pending.
> 
> Close the race in fuse_remove_pending_req(), which is the common
> bail-out path for both the legacy and the io_uring transport: after
> the request is removed from the pending queue, also unlink intr_entry
> under fiq->lock before the reference is dropped.  fiq->lock must be
> taken explicitly since the lock argument is the ring queue lock in
> the io_uring case, while fiq->interrupts is always protected by
> fiq->lock.  This runs on the holder thread after any
> queue_interrupt() it issued, and no other path can re-link the entry
> once the request is off the queues (re-queueing an interrupt from
> FUSE_INTERRUPT's -EAGAIN reply requires finding the request in the
> processing queue first).

The commit message is too verbose and looks AI-generated.

-- 
Best Regards,
Yi

> 
> Fixes: 760eac73f9f6 ("fuse: Introduce a new notification type for resend pending requests")
> Cc: stable@vger.kernel.org # 6.9
> Signed-off-by: Baokun Li <libaokun@linux.alibaba.com>
> ---
>  fs/fuse/dev.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 5763a7cd3b37..87891162985c 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -678,6 +678,8 @@ static int queue_interrupt(struct fuse_req *req)
>  
>  bool fuse_remove_pending_req(struct fuse_req *req, spinlock_t *lock)
>  {
> +	struct fuse_iqueue *fiq = &req->chan->iq;
> +
>  	spin_lock(lock);
>  	if (test_bit(FR_PENDING, &req->flags)) {
>  		/*
> @@ -686,6 +688,18 @@ bool fuse_remove_pending_req(struct fuse_req *req, spinlock_t *lock)
>  		 */
>  		list_del(&req->list);
>  		spin_unlock(lock);
> +
> +		/*
> +		 * Remove stale intr_entry queued by queue_interrupt() before
> +		 * the request was requeued, which would otherwise dangle on
> +		 * fiq->interrupts once the request is freed.
> +		 */
> +		if (test_bit(FR_INTERRUPTED, &req->flags)) {
> +			spin_lock(&fiq->lock);
> +			list_del_init(&req->intr_entry);
> +			spin_unlock(&fiq->lock);
> +		}
> +
>  		__fuse_put_request(req);
>  		req->out.h.error = -EINTR;
>  		return true;


