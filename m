Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BEA34753B
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 19:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782158145; cv=pass; b=BRLq+OMbHUBG2W1HAaj9/SrMsuv633MFlx4jqwU9bn240/JIUjU5Torhq8FfS58rZukvy+A9nPjOoIlg6k5l11NvtTVgUt8yQ2GUctenqo2HjMXUxxxUl267bju5MXdGrBRF/jAC1+oivC4hZorNB+/+ZAf6k01VDBr0ECpeNHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782158145; c=relaxed/simple;
	bh=ZmsMtIrrAEsVlRMJ9A3LZo2l4S6v7ZkaR9D49GID7Z4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iShmN6UUb7IbBt1hyTCINNBzQWFadFHqEz4KgM8oOW5sI9IbSqTd0BuDDfPPBBkWQNAU1VLT2DzTUn3jQySa2k+blyP4sE580CrCQuRzBPJmT8qLHJQaAcyr8X+fZ/sin5FL9E3feR5VfN5b/2tOPtlfH0xnyP0iGVZrH0ya0Pc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dcD7MzOt; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dcD7MzOt"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4923fb1f095so36169705e9.1
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 12:55:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782158142; cv=none;
        d=google.com; s=arc-20240605;
        b=AUQ06f3FWhVWhWsZkXxplAifTpcXPbXYjNXsL2lUASwJi0wrzPvsmUFg9C4CnHc0mB
         j224b6C3Cw9Mra6sm4O0wSR5Fj6DU8QyvUH9zKcJ1H7H2tA3XTuczPYZuGW8uqQ9y5ZR
         K6v+H18tvY1ey9498YmL89JnUfc0iHJ/efdnD8+2rbmHNSKctkhLB7il1WluOg636Nt0
         3JX+Jx5ToCX5fWByw0a0vBJUMRVbWBMYhFvCYdXPqMSOhe8ND2FrrJP6hbhqnpsEc0kB
         yJsdR/7o8SV2MLHM5MTBwPwZuga/mc6ynrErI8l7vTvERkIVoE7e65Y9Je2qO8wiNr4A
         BRzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oB+R+nS7CUg/CnxbDRkHlMSijv4qa+YSiLc4/dPHrTQ=;
        fh=ahdRaIe0HVkp7N+bpGNZd8d+zH5XF+oAplt50rWDbYw=;
        b=GtQHRstlsoA28A4BGnmEGtjtTYTZngV3mmKORnEUD1aQhIBZRxkMk8zKpF6/x/+gKu
         DWuw6i38hnHK8Br0ROSEgTIK4x+4kgXmdgNJpYR+uRn8ONWEpR+dQ/iSJ8SQRUK3vafI
         9hatQ05D3GbOoWPLU8pmfcoJP5teP2E7gGIjKp0wMWgOMlNRr7wztv23RfD5UG4i49C/
         Y5dinLDBZFbqG8mCZZ1ngqQC40EGbkYE8qiPzT5khuAbhadhHkoD+7Dofk0Am1Mz85zj
         VBp0XIHo7JFz7Ie9rB0zWv/oXvRQIaGGzvr1xsizKKLKrTkU/Ffjbr3ZNmOjWiAxJo6e
         NxpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782158142; x=1782762942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oB+R+nS7CUg/CnxbDRkHlMSijv4qa+YSiLc4/dPHrTQ=;
        b=dcD7MzOtuhqn5U/xXbwfQ6/Yfhuz08mDcOB/O5vMqajvOkEwyokhE+yBzpUVJ2SV+X
         cyv/lz8ZJvqB3LoLZXswiwyRw4JBxxdoyN/AI/LNVkQK4FBBFxExAiN6CzTSJ6qRCxNw
         LyaSY17exOlaij9S7qViB93Dt12bnDc8tF+dAZxy4Rfi3HMFG1p1Wr/ynOmx2+Bs2Koi
         q4Y2Io88HsCyn/sa6nPQw89pRX5kWoAuulhlButc7GprV913DoKJgEf6n/JgIvNrN9Im
         xWEFoRsy2oyIEHNnd0nBHXEtjm/MfLtoYQaftADhyg/InHozX4Vam7WjQ1Fvae89RsTy
         CDrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782158142; x=1782762942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oB+R+nS7CUg/CnxbDRkHlMSijv4qa+YSiLc4/dPHrTQ=;
        b=YPYMr6F9ElKnPxFQki5A+/m6eHsibMfyEEW0yQ6DVPbquNj7GZ3pZke0H2yeo9ntlq
         fTAaSVmOtwWJW8T+DTzTiV/zfp6T/FbyMZdTQJjJYqGtBcVGC3IicO9CEPjn4ss5UlHN
         nnk2C7/DOeDUT08ypCYnzVDGCXXHHBho20KPV7URluL4kwXx4TruxmRTvGbpwXYr+sgV
         y/gi2F08qC98Rf+MJwkvUKzItNTnbP4NfVbFS3rHUv56lrFCv4CISfDzsG2/XNO/MBnj
         0EXpkQ2lGLFwFlFaWJn6GtTKBp1v4WtKfKrqwiStwbFmNr6j3rZh2Ubk/IGQNbdqF1Fs
         h9FQ==
X-Forwarded-Encrypted: i=1; AFNElJ9MyQF1PAwcIIKKhMixrUIiFDLIBuK5oFTQk3og4o8uod3qLsLwQsFhBgBy5rYwsbG0LikMjZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfNXpy5G9XfoaISIj4Hb+E5N8BrSAPKSgNZbS95xK/q1MxhL67
	KCk2axERKUobHmeDMDpRrXtbkqJyWq5oy9/CBLpTRgGjxFqPFUMyWUbe+EbOeGX9rUj01oiSSJa
	xnoL+Igi8UoNHfxFVysD1WKWAc+QxoivS034FxdLH
X-Gm-Gg: AfdE7cnbPTruZCibQL/0MchtiiR1KaXKAkr421JA3BcjTGlRu4bsnbVtEISWQsjMYZk
	HqnDLwyoItyYCDK2jI/a5zbZTJmKRDAWInY5IukaoRzXIfdPRRaHmSSY+8nKYXSwAGXbN0Qtm/Q
	lkbuCLT8isgctP8ZKIjACQgVTduxgV1BlaL5EOA1S9QSr0a5N8tKzWDhclV2XDUSu3nknmLawo2
	1ZMIVN02yg21MqLCxjCSYMEwlP6A9XhMqdbswvsGGWYHjAmSrCYv9clctBsv4l1ApYaVIkxpHUS
	KGuC0pVRZzVv0uyranU8D5BzRQ8=
X-Received: by 2002:a05:600d:8653:20b0:492:488c:f627 with SMTP id
 5b1f17b1804b1-492488cf6c8mr127951145e9.11.1782158141840; Mon, 22 Jun 2026
 12:55:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619185233.2194678-1-cmllamas@google.com> <20260619185233.2194678-2-cmllamas@google.com>
In-Reply-To: <20260619185233.2194678-2-cmllamas@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 22 Jun 2026 21:55:29 +0200
X-Gm-Features: AVVi8Ccv23Ym_CwKeZAXk0wbH3-JqGaH5YYnH3F9YFSHhjND6MuPd45p3ebKNNU
Message-ID: <CAH5fLghnFSB0KYHQ7T4LEnHcx+kLP0RavpQL2LSyO2MCjE4DeA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] binder: fix UAF in binder_free_transaction()
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 19, 2026 at 8:52=E2=80=AFPM Carlos Llamas <cmllamas@google.com>=
 wrote:
>
> In binder_free_transaction(), the t->to_proc is read under the t->lock.
> However, once the t->lock is dropped, the to_proc can die in parallel.
> This leads to a use-after-free error when we attempt to acquire its
> inner lock right afterwards:
>
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   BUG: KASAN: slab-use-after-free in _raw_spin_lock+0xe4/0x1a0
>   Write of size 4 at addr ffff00001125da70 by task B/672
>
>   CPU: 20 UID: 0 PID: 672 Comm: B Not tainted 7.1.0-rc6-00284-g8e65320d91=
cd #4 PREEMPT
>   Hardware name: linux,dummy-virt (DT)
>   Call trace:
>    _raw_spin_lock+0xe4/0x1a0
>    binder_free_transaction+0x8c/0x320
>    binder_send_failed_reply+0x21c/0x2f8
>    binder_thread_release+0x488/0x7e0
>    binder_ioctl+0x12c0/0x29a0
>   [...]
>
>   Allocated by task 675:
>    __kmalloc_cache_noprof+0x174/0x444
>    binder_open+0x118/0xb70
>    do_dentry_open+0x374/0x1040
>    vfs_open+0x58/0x3bc
>   [...]
>
>   Freed by task 212:
>    __kasan_slab_free+0x58/0x80
>    kfree+0x1a0/0x4a4
>    binder_proc_dec_tmpref+0x32c/0x5e0
>    binder_deferred_func+0xc48/0x104c
>    process_one_work+0x53c/0xbc0
>   [...]
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> To prevent this, pin the target thread (t->to_thread) to guarantee the
> target process remains alive. Undelivered transactions without a target
> thread are already safe, as the target process can only be the current
> context in those paths.
>
> Cc: stable@vger.kernel.org
> Reported-by: Alice Ryhl <aliceryhl@google.com>
> Closes: https://lore.kernel.org/all/aikJKVuny_eOivwN@google.com/
> Fixes: a370003cc301 ("binder: fix possible UAF when freeing buffer")
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---
>  drivers/android/binder.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 09bc052186cf..b85920c39694 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -1658,10 +1658,19 @@ static void binder_txn_latency_free(struct binder=
_transaction *t)
>
>  static void binder_free_transaction(struct binder_transaction *t)
>  {
> +       struct binder_thread *target_thread;
>         struct binder_proc *target_proc;
>
>         spin_lock(&t->lock);
>         target_proc =3D t->to_proc;
> +       target_thread =3D t->to_thread;
> +       /*
> +        * Pin target_thread to keep target_proc alive. Undelivered
> +        * transactions with !target_thread are safe, as target_proc
> +        * can only be the current context there.
> +        */
> +       if (target_thread)
> +               atomic_inc(&target_thread->tmp_ref);

This is more complicated than the comment suggests, but I think it's
correct. As far as I can tell, scenarios where to_thread is NULL but
to_proc is not are also scenarios where the caller ensures that
to_proc stays alive during this function call.

It's unfortunate that there's no obvious better way of doing this. I'd
like to just take a refcount on the process, but it's not atomic, and
you can't take the proc lock protecting it because of lock inversion.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Alice
