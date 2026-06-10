Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06992376BE0
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 06:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781074223; cv=none; b=aB6zb9yoz2KPV7iHOYcitD9S3x7+CTMJAXtKmkMPy3keqbRsG7srBPnWcxII4coXVMcRvH/CuDrRmupwduTbYPxwFnLqXW+uUKCKoWwQdSvdX2AzS5ZJrRbXEWXjdsfQ6F7Rk+vi5m25piGR5VEtNaiNV73k4Dr0oUv65kHIA+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781074223; c=relaxed/simple;
	bh=jKfE6a5TaSVzDEupEWUxlVjQJEQNk2ihgL/iofH7YZ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sH1z9JxLJlO4eCysMeP46V+xIoD9usqaqU62aw55HRsDp8tr38rGFyP79aPlInvicQZFbGtswMPOyD0kLZGVC6atjvlxFit2MPTWLyQodGwYyYg2sRbajAsYE6YIfweeia3ptYD5Qkch9SG+XI/y3KigztJRNMbAxkFyLqwjPdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Aie3j5Da; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Aie3j5Da"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-68d232dc704so6629782a12.0
        for <stable@vger.kernel.org>; Tue, 09 Jun 2026 23:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781074220; x=1781679020; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zBP+gyWP0FVt0I05DGqGEo5PSl+DTUOm1WH2EmKpkXo=;
        b=Aie3j5DaffUSaY7DdI73G+q+sOfxAVNTyp676BJlYoIJ7dyOOgLJfDluhYgl2EMoZz
         cEQIclBuKG16M9zt9IWrT1p2Ta4RIHpjjebJVN1D94Ukq0xN9xI4BGThzRDFly+h0NhA
         5goZ+Vs9C2Lu9ggxLH6d3tUoRRrpqZovmeJNmf0r5foatzSGJJpROWFpXnyhmyOmibpp
         yYG7+jf8RPqE5mCVBHF+jaIHkV0BMBAzMRwUlUNaMH2LIr3lU0N2K/hXnwXf8a47jMUl
         kR2Ts0PJTiCCcIk3NXLir9DrPyHi/+VEznpYCYVcq14KxViGAoiwNzO4ZtKsiH2JSoza
         peZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781074220; x=1781679020;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zBP+gyWP0FVt0I05DGqGEo5PSl+DTUOm1WH2EmKpkXo=;
        b=SSjRRlQonm9eFk4/Q0Sz3GAZEDNleJowKKI5L862+x6cd2pLNFYrFZu+VqBewWKuml
         +5jeh3l4dytLbzqhA1P1qReEQYZ+XSBgmp83+jqChtZjWcLkn+pFkNZEcipFMd4CtYED
         oDazXVwIUdCYEE+f4zv03dcn9SaO3YxlVKLzYeFOtsxdsFW+YyFyCnzE9z+3FvdUVKG/
         YcVXFihCixzAmArW4MWiDoMXRS7OdamKQLFRnFwNP2rpu957purIruiVPEQXD8yxXXh9
         Km4jXWGl+s5FyHIl7RzIFALLo9yG7JCM9wmeKToLbumTtoaxgVDIqAbX6NC81xelS1H4
         2qmg==
X-Forwarded-Encrypted: i=1; AFNElJ9XVujiAbR/kM/uWSPDAniJxUSPQsmS+VT9Sql3pDeNdpEcxC2au3ay3EhPi7MMrobunhDfxu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLkunULjg+htaLktUKr0+yf6SCKqlVLWUk0oanGjUcM8VSbKay
	J0Kt9whfhW7XLn3C9Q4L2uXvVVgOCQ5RnjjoCmgDq0OII1i1PGRbaG5CvswjY1h3sq7vvLI2ENF
	lN8vBJxhjdP+dh8F4Fg==
X-Received: from edvl10.prod.google.com ([2002:a05:6402:28a:b0:692:5e5e:968f])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:5405:b0:687:3580:fc26 with SMTP id 4fb4d7f45d1cf-68fa4f2dae1mr10525298a12.13.1781074220179;
 Tue, 09 Jun 2026 23:50:20 -0700 (PDT)
Date: Wed, 10 Jun 2026 06:50:17 +0000
In-Reply-To: <20260606022233.2402965-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260606022233.2402965-1-cmllamas@google.com>
Message-ID: <aikJKVuny_eOivwN@google.com>
Subject: Re: [PATCH] binder: fix UAF in binder_thread_release()
From: Alice Ryhl <aliceryhl@google.com>
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Christian Brauner <brauner@kernel.org>, kernel-team@android.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Sat, Jun 06, 2026 at 02:22:32AM +0000, Carlos Llamas wrote:
> When a thread exits, binder_thread_release() walks its transaction stack
> to clear the t->from and t->to_proc that correspond with the exiting
> thread. However, a process dying in parallel might attempt to kfree some
> of these transactions. And if one of them has no associated t->to_proc,
> the t->to_proc->inner_lock will not be acquired.
> 
> This means that transaction accesses in binder_thread_release() after
> t->to_proc has been cleared might race with binder_free_transaction()
> and cause a use-after-free error as reported by KASAN:
> 
>   ==================================================================
>   BUG: KASAN: slab-use-after-free in binder_thread_release+0x5d0/0x798
>   Write of size 8 at addr ffff000016627500 by task X/715
> 
>   CPU: 17 UID: 0 PID: 715 Comm: X Not tainted 7.1.0-rc5-00149-g8fde5d1d47f6 #30 PREEMPT
>   Hardware name: linux,dummy-virt (DT)
>   Call trace:
>    binder_thread_release+0x5d0/0x798
>    binder_ioctl+0x12c0/0x299c
>    [...]
> 
>   Allocated by task 717 on cpu 18 at 67.267803s:
>    __kasan_kmalloc+0xa0/0xbc
>    __kmalloc_cache_noprof+0x174/0x444
>    binder_transaction+0x554/0x8150
>    binder_thread_write+0xa30/0x4354
>    binder_ioctl+0x20f0/0x299c
>    [...]
> 
>   Freed by task 202 on cpu 18 at 90.416221s:
>    __kasan_slab_free+0x58/0x80
>    kfree+0x1a0/0x4a4
>    binder_free_transaction+0x150/0x294
>    binder_send_failed_reply+0x398/0x6d8
>    binder_release_work+0x3e4/0x4ec
>    binder_deferred_func+0xbd8/0x104c
>    [...]
>   ==================================================================
> 
> In order to avoid this, make sure that binder_free_transaction() reads
> the t->to_proc under the transaction lock. This will serialize the
> transaction release with the accesses in binder_thread_release(). Plus,
> it matches the documented locking rules for @to_proc.
> 
> Cc: stable@vger.kernel.org
> Fixes: 7a4408c6bd3e ("binder: make sure accesses to proc/thread are safe")
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---
>  drivers/android/binder.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 9e6194224593..09bc052186cf 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -1658,7 +1658,11 @@ static void binder_txn_latency_free(struct binder_transaction *t)
>  
>  static void binder_free_transaction(struct binder_transaction *t)
>  {
> -	struct binder_proc *target_proc = t->to_proc;
> +	struct binder_proc *target_proc;
> +
> +	spin_lock(&t->lock);
> +	target_proc = t->to_proc;
> +	spin_unlock(&t->lock);

Although I don't think this fixes all issues here, as we discussed more
in private, this does fix the specific UAF referenced in this patch, so:

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

The logic is that either binder_free_transaction() reads a non-null
target_proc, in which case we take the inner proc lock and fully
synchronize with the entirety of binder_thread_release(), or we read a
null target_proc in which case the transaction spinlock ensures that we
wait for the part of binder_thread_release() touching this particular
'struct binder_transaction'.

Alice

>  	if (target_proc) {
>  		binder_inner_proc_lock(target_proc);
> -- 
> 2.54.0.1032.g2f8565e1d1-goog
> 
