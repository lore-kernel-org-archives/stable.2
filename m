Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB10D3ADB98
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 09:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786701448; cv=none; b=oGlo+CS+g4NTssHxgXe6w0S9+QeQ93sMUl8F6DDNCip9u/1is0BRG7EkbnWWJ+7Y1T+PBNw0f1MUIel4W+lmSEf3OErj4fF7C/1YJHuiKE5naZkydxAhOLhvuBWGJXWAGKhPW9KLPO+Lajrmg899XzCIvs5CNRC6ZOxSehlHXKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786701448; c=relaxed/simple;
	bh=534CagOdQ35DzD17xlcuafXbatIB2JIffyCe7kh9eOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jo8AJTPkUB2IAFtwuyCl8v9mVyQksBueQMAeJ6QulxXClutRlSsISZvWqcUhRPKAnhYtTxVQ8Ej7YKvHUJa5kHYiIdkN/B9cOmHyFx3UOhDXDf/syL2YWyQgSNhQ99r6QzbDqnMzLe5MabwKQ694sUcHGzsc/KNeRJ4w1cH8ZX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qrpUuAbf; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qrpUuAbf"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3811f512167so1021403a91.3
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 02:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786701443; x=1787306243; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oqq/eesd6KpkKbZO5cDYLRl1ZtXvrm9zL+ZkU4ZzFdE=;
        b=qrpUuAbfgp3YKv4gFfJmathDmGWEc4NV+wc6m19FIjwYYcoelM/8Oio2C10A4iIKFo
         JWytLDhqhvR2FsbzvmkaxZkf7sIi2g+oENlKDuBQR47WaXcopvkxRgrlK+gstT/EQoIo
         eCs9+fTthWQKarrgJnQFpbr3XNS1UvdcZ9JyYvSOATc5erdDoJTq0GhYK4f4D2s+QHqw
         H36aq2/fVlEscCnxIe3u2usH4F2CYY1I7+tfzce6r369rkxDbYMk0OO847Qop3dF6dMf
         MiLa49sx1W0KU8i/kAplkfIYpNocmo/BDePOq2/BEl0NrejYSnsJkEPlubarhRdRGYyc
         uziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786701443; x=1787306243;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oqq/eesd6KpkKbZO5cDYLRl1ZtXvrm9zL+ZkU4ZzFdE=;
        b=FAfb1PjKhfxy/dyUad9owvq8tyjIvjR3O7w9rTA6LbGxJfUvbfYi2YquH0+yP1E8FE
         uTNM5h46r607IAfkbyzqbC49fDkiHZT/QQI7mtxB0gV0cEPLFCymMLeFMdzVrP6g6rBu
         Ux96072wJTQzALMOgzRBtrbrTYkKO3Basw2BtSK9xJuT6WOVeoHwtnji1ZjM3klvZVWA
         Oh9SIdONyTCG0/PlVb5lVZObBagn6gH0XsUg4LklB1IkmjR1UtCDIe8eF1Pi7ycFHUsY
         aLUQh/PXjXhOTOVI+4PdbFOp9NTBDgsWtdv9F6GEr/YOVhlOcVg2+Mt8gOJB7APBAm+d
         4GOA==
X-Forwarded-Encrypted: i=1; AHgh+Ro4kuVaGBjcD8bPjdLbPcuw40C45oCnVfUzu61O0wObTub+QQVnVeuRxp1Ia0pY59gyX1aJZdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjXYrsoqxZ2m6hfafLzJp2CGFYHTX7edS/ya0FlkUsKmR97XLz
	QhskoI09P6ygwZieCJ71OKEAyUwnMz/0Y2RtpZ5R6/dly83JGtJIT3BN
X-Gm-Gg: AR+sD135aVsM8fD9oHk9DTHuFlLek+HJuxldctU/zm9QTm3T+JGB1MSaB5nnEAtQCvV
	G7NgvtTvJplE7m7SDcOUNtfcZR62xiKKlNCuwJoAaj0PdMiTl7b+gozVjGypmpXzjw7U0SNvgl3
	NSqkuHtL8LyMN7tZyl0oPyG+ewQhV1U4/QpzAArsw39+4/QffB5gPqWzNxwl7M1BvNJk/IACeJX
	h1nlAPP0b2JF0CCh3qf9oNjUOmZn4DE68c94qSujeGW5g095rOb6fkYbF4zedluNbbuufkbE9bz
	9zTxIKtkjAZmYoYyrT+dFrD38E87f+CS3q4mNz/+qOWz2dMafxfnpKJbnWzHAeAv+7cvbmOaRZw
	iWTVVPX1mljC6dQqrZpAxhaWINHqPUkhTn36SOj9KtgaX5QU0jxEQiVvd1OM4eArrftgh8TkCcK
	alyCFtCftTWuyCyx7ad5ui7ax519LsdBcBVYpBSwM7c5DKg6VGYCi6X1qpMLflkPEc8Om4mhjv8
	WIsPL7uh8OLnB+K5AoOOg==
X-Received: by 2002:a17:90b:1c83:b0:392:ca3b:370a with SMTP id 98e67ed59e1d1-3933b77c3f9mr4752626a91.2.1786701443357;
        Fri, 14 Aug 2026 02:57:23 -0700 (PDT)
Received: from [10.22.68.200] ([118.201.124.118])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39339b1d20dsm1115327a91.0.2026.08.14.02.57.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 02:57:22 -0700 (PDT)
Message-ID: <7489ab68-9da6-4c47-8dcd-3bfa1690fbd5@gmail.com>
Date: Fri, 14 Aug 2026 17:57:18 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: clear stale intr_entry in fuse_remove_pending_req()
To: Baokun Li <libaokun@linux.alibaba.com>, fuse-devel@lists.linux.dev,
 Jun Yang <littleddfu@gmail.com>, Jun Yang <junvyyang@tencent.com>
Cc: miklos@szeredi.hu, jefflexu@linux.alibaba.com, winters.zc@antgroup.com,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 TencentOS Corvus AI <corvus@tencent.com>
References: <20260728031641.2497811-1-libaokun@linux.alibaba.com>
Content-Language: en-US
From: Tang Yizhou <tangyeechou@gmail.com>
In-Reply-To: <20260728031641.2497811-1-libaokun@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

Hi Baokun,

I just read Jun’s solution, and it seems his fix is more comprehensive. If you
don’t mind, I hope you can take some time to read it.

https://lore.kernel.org/all/20260804091757.503476-3-junvyyang@tencent.com/T/#mf9bb60e63dbd4ef0ab5cf826e97ad67037ccd3ff

To be frank, Jun doesn’t seem to have a deep understanding of the issue. His
patchset appears to have been written by AI, and the problem description is a
complete mess. However, his approach to solving the problem seems viable.

I’m not sure whether Jun is able to rewrite his patchset that Miklos would
accept. If not, I’d be happy to help, since we encountered the same issue in our
stability testing.

-- 
Best Regards,
Yi

