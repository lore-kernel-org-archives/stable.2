Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1F8348C4B
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 20:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782766348; cv=pass; b=Auai2TO+XqFTUILgiJ4/Ymoj+mpRfo/lQm1F/DRKxFTfqZdlEdWTRDcukJsngQh1iVpicZvN4HRWlwehZxxhwwZNiopxO+VyuCoWbzaAEM4a6jFGgj85qL7FJ92J9H3iJ9hGLTvRXdUY5yHu1B2/zWxSkE9UcHK+1LmYSBr18GE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782766348; c=relaxed/simple;
	bh=gpK5nT+UzDd0LPb7Ov+gA94oFziKAgmgvHbG5DSebhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oZl2Huop52Y+lXpGTCSz+wNIr0zvr/4gUhS/sIQ840uziQ9DMbtkSVBrGNLcxS4AkP14X03NBdGHUnxmkamSSYbeNOizwmh1zwThBsFBTS/P63g8HbrufuhAZvx3jHVZzl8fz5Mb0mpGXDlCeNbVlOq15sSDxjdifPWtD79pupU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X6SNRgXi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IQEcdGe/; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X6SNRgXi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IQEcdGe/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782766346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZExeYtPmbb6AZR2E0E7zl1B/EIM3ypaStq/+Uw+ubN0=;
	b=X6SNRgXiG4qjCyaKYHkPvfm7M+ORNGWcMwN+U+4A/dXp97Vn5Zl3kHCfrRhZ4sA0jhHsKe
	YDlsDq8xacFtZuf0c3Cl0CPyuvg+R7DU9k7Hs+yf+gEDqPP6bYV/L8oq9XH4ye26LSZgIJ
	FULSydPyV0uFfwiPZ3StvZoXFqcH090=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-Ynh6IPqwNZCVopPsW9Zq-Q-1; Mon, 29 Jun 2026 16:52:24 -0400
X-MC-Unique: Ynh6IPqwNZCVopPsW9Zq-Q-1
X-Mimecast-MFC-AGG-ID: Ynh6IPqwNZCVopPsW9Zq-Q_1782766343
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-473bc66c837so1092491f8f.0
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 13:52:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782766343; cv=none;
        d=google.com; s=arc-20260327;
        b=qvkJTNmFluatgvZ8GEjM6YdIvqZrdIovgW3KvPZgpINX46wU6tT/aL+NaavhHu1t/t
         coSYKq4wWtRpQQdx8QyP1Lo1x1vqbAhrbVUNz5sHfYt+jyebM12jPV+VKxIv8FSU3Xka
         ZMHVUx315qD/Oioyp12mIzEC0uxiqJvCAJwubJcw8dtUgFsCz4qRgCKsnBebkq1GVIJo
         DG2eLmgOrFp9aWoLLzluZUOpZxXeSz7vkqqckwcC+ZZaQgvYbvje1KG2rTlipI5VGAc1
         O8k8AyYwIQe6pdTWEiumfOeOB3oL4Evn6za272Vs+kVFiHQLtdlYc+kmgQ9N5WGaoN8B
         NR5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZExeYtPmbb6AZR2E0E7zl1B/EIM3ypaStq/+Uw+ubN0=;
        fh=VvsnBuBhsA7Tw8Ppw57TMsu1XxMyQMH3qEG8ygGQvog=;
        b=SZkfBgJfMQVeiRd/HzQl+AnIOLivHAHs+ZGAu31BJmHxrUgHb6A5LSox93HXtHYnqv
         GFh6C9PEu68A7NoCGOdIVXtzFLN50pk3WjbmGDfwrST8J/38EaOwJRQOkzfxDp0Bw7NU
         qeDdJbZrBVf7FvYns5p6HdPIM3gYy2+yCSOyVCbKl1Ed2S6whkYGih0KrfxRgz3PFRM7
         DdJBFoJ0mXtp1sEJQg05alYYPaoaCif2aS/TJVZ/gJ4zj8fqFf0bAfrgCbeMvraBGbRx
         N0Ljz8ILH6/SREvqY/myPm53EK6GIWXhlEMxcmXOjy/S8cwdvThu3k9tdcCzUdT8CsLD
         Cuxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782766343; x=1783371143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZExeYtPmbb6AZR2E0E7zl1B/EIM3ypaStq/+Uw+ubN0=;
        b=IQEcdGe/QPO0PEcJ7vhnxoUDCNHWB898GYpvQ5AN6V9/ZgO4drV4gYUBrHZVsOPIv2
         avANr2jA+vFNqQPU3hsDpGUCbcMjSBhljcU3r5ZK+rOr9MNR8LpJJw3jypUVEFy4O7JB
         uLtz/v3icfyPOCBeUSSw7dnBQyzMQML4WDWRWw6ZNfON7I4pIscX0ZOxDqnkD/l6cthm
         jhKsDGPHuMYiYcCd4nhEGfFtlkAFyiK0jBz2Jj2qnA5uFJSX5gXq/t55Wwzh+IMC7RuO
         pgyQr45TWmU4Fymrc50VbYH6Xlkuv7KUq8+XpizRmmZhkDP9beb/pSr0O5ukJtH8rAQx
         L6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782766343; x=1783371143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZExeYtPmbb6AZR2E0E7zl1B/EIM3ypaStq/+Uw+ubN0=;
        b=hmHwUI4kCFgTXvDV5mFuQSRrXWh3Blwm4HndFdapweEYIrJOv53kZ3EMI4gQ2fW7mW
         6Y3Sp2J45nm7X5ycal+QG/18O5SoBLgjoLPQXC6BwQLMXfpVfW+jA/jLUV2VaEfoUpMa
         hIUzn/ocJUU0jTomJlvHTkRrImMegqV3d8UFsh6hioIC4p1LTFHHW7qw4F/Fr1oIyELP
         L55NIfKu30aySswd+I9tuPDhMIbfNK4JsRfzZOt5V+hzqQrEMF+GCe6YW8+MR1Ho9Szg
         yWqTbst7vc4DpKdtt+L78rF8ZzJG+1rYRK4nJue1iIG7QqdMm2vHu43cF4oljFENGcCD
         bkBA==
X-Forwarded-Encrypted: i=1; AHgh+RrOLkOtGi7CeF0q5/NFbGI9nD43DMN7oxloG23/ew+3VBt5/t3kwqaZPybmK8tPAQrJFfm7hGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMUxUpI+kDzJ9OXotE/guXMwOnDqN20lTIbcEfNKDlopSgwcRJ
	8ZI+ckQJl7WBIhNhaGzKNy7lL45g0YzzRI9+Ox6IEiiLuHC5orG+ww/H9SwSneuBNBvK/DLCe5F
	d/Zz0SGBEBJ6C9RaRk6X9DxsQwveEiaBuXRQ2bBIh6W2c7WZU5N0h1KgDGQ9dlkMwmWE6XVd/nI
	ztbeohCXLc/zjcLVpO6SxGgzsJiCLE8WX3
X-Gm-Gg: AfdE7cnkKy3jyhpy4uq1pT7Y39rZltW2nRfJwprjbjnOVa/BWI/rJKxh2ShcV+eEcwX
	2Pj4ef5fGihAQsnkNNfNEM7a6H+wNhyBPO5tVFx3DAunfQUOEwD8heZ4XY+M87LvEifmn+0d9d/
	CCMBxQLJ4DWjgWQNh9Ih/QuMk2nmCCSfC7fm40xnemexceyNeDMkQ4YVQ2hAmhrn0cQhSTokSAn
	UwHoFcnSpd2sO4DnP4EVw1+mzFq
X-Received: by 2002:a05:6000:611:b0:46f:5d62:d914 with SMTP id ffacd0b85a97d-47551737df3mr938026f8f.12.1782766343353;
        Mon, 29 Jun 2026 13:52:23 -0700 (PDT)
X-Received: by 2002:a05:6000:611:b0:46f:5d62:d914 with SMTP id
 ffacd0b85a97d-47551737df3mr937986f8f.12.1782766342923; Mon, 29 Jun 2026
 13:52:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1781666867.git.namcao@linutronix.de> <1c378963f27c5960e8a57c50b8b444d30954cb54.1781666867.git.namcao@linutronix.de>
In-Reply-To: <1c378963f27c5960e8a57c50b8b444d30954cb54.1781666867.git.namcao@linutronix.de>
From: Jesse Taube <jtaubepe@redhat.com>
Date: Mon, 29 Jun 2026 16:52:10 -0400
X-Gm-Features: AVVi8CcsutnsmZmsWanoQyRTk1OST7gOCnzK4k_GYxuuXSQew-iHrhleNoTl064
Message-ID: <CADRr4bdNtwX10sDqRT69WHJHjXx+y-93wm8AHj4v2h1wQfF8pA@mail.gmail.com>
Subject: Re: [PATCH 1/2] riscv: unaligned: stop using kthread for check_vector_unaligned_access()
To: Nam Cao <namcao@linutronix.de>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Andrew Jones <andrew.jones@oss.qualcomm.com>, Jingwei Wang <wangjingwei@iscas.ac.cn>, 
	Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 11:41=E2=80=AFPM Nam Cao <namcao@linutronix.de> wro=
te:
>
> A kthread is used to run check_vector_unaligned_access() to optimize boot
> time, allowing the kernel to continue booting without waiting for the
> unaligned vector speed probe to finish.
>
> However, this asynchronous approach introduces several complications.
> First, the kthread may not complete before a user reads vDSO data,
> resulting in incorrect values. This was previously addressed by
> commit 5d15d2ad36b0 ("riscv: hwprobe: Fix stale vDSO data for
> late-initialized keys at boot"), which added complex synchronization
> between the kthread and vDSO reads.
>
> Second, it was discovered that the kthread may not finish before
> vec_check_unaligned_access_speed_all_cpus() (marked with __init) is freed=
,
> triggering a page fault.
>
> These issues raise the question of whether the kthread is worth the added
> complexity. A past boot time regression report was actually unrelated to
> synchronous probing; it was caused by the probe running serially. Since
> switching to a parallel probe, no further complaints have been made.
> Furthermore, the unaligned scalar access speed probe takes the same amoun=
t
> of time, runs synchronously, and has caused no issues.
>
> Testing shows no noticeable boot time slowdown when running the vector
> probe synchronously (0.464474s with kthread vs. 0.457991s without).
>
> Remove the kthread usage and run the probe synchronously. This simplifies
> the boot flow and allows for the revert of commit 5d15d2ad36b0 ("riscv:
> hwprobe: Fix stale vDSO data for late-initialized keys at boot")
>
> Reported-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
> Closes: https://lore.kernel.org/linux-riscv/20260612-vec_unaligned_drop_i=
nit-v1-1-df969210ae34@oss.tenstorrent.com/
> Fixes: a00e022be531 ("riscv: Annotate unaligned access init functions")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Nam Cao <namcao@linutronix.de>

Acked-by: Jesse Taube <jtaubepe@redhat.com>

> ---
>  arch/riscv/kernel/unaligned_access_speed.c | 19 ++-----------------
>  1 file changed, 2 insertions(+), 17 deletions(-)
>
> diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kern=
el/unaligned_access_speed.c
> index bb57eb5d19df..6e35bca568de 100644
> --- a/arch/riscv/kernel/unaligned_access_speed.c
> +++ b/arch/riscv/kernel/unaligned_access_speed.c
> @@ -6,7 +6,6 @@
>  #include <linux/cpu.h>
>  #include <linux/cpumask.h>
>  #include <linux/jump_label.h>
> -#include <linux/kthread.h>
>  #include <linux/mm.h>
>  #include <linux/smp.h>
>  #include <linux/types.h>
> @@ -288,18 +287,9 @@ static void check_vector_unaligned_access(struct wor=
k_struct *work __always_unus
>         __free_pages(page, MISALIGNED_BUFFER_ORDER);
>  }
>
> -/* Measure unaligned access speed on all CPUs present at boot in paralle=
l. */
> -static int __init vec_check_unaligned_access_speed_all_cpus(void *unused=
 __always_unused)
> -{
> -       schedule_on_each_cpu(check_vector_unaligned_access);
> -       riscv_hwprobe_complete_async_probe();
> -
> -       return 0;
> -}
>  #else /* CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS */
> -static int __init vec_check_unaligned_access_speed_all_cpus(void *unused=
 __always_unused)
> +static void check_vector_unaligned_access(struct work_struct *work __alw=
ays_unused)
>  {
> -       return 0;
>  }
>  #endif
>
> @@ -387,12 +377,7 @@ static int __init check_unaligned_access_all_cpus(vo=
id)
>                         per_cpu(vector_misaligned_access, cpu) =3D unalig=
ned_vector_speed_param;
>         } else if (!check_vector_unaligned_access_emulated_all_cpus() &&
>                    IS_ENABLED(CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS)=
) {
> -               riscv_hwprobe_register_async_probe();
> -               if (IS_ERR(kthread_run(vec_check_unaligned_access_speed_a=
ll_cpus,
> -                                      NULL, "vec_check_unaligned_access_=
speed_all_cpus"))) {
> -                       pr_warn("Failed to create vec_unalign_check kthre=
ad\n");
> -                       riscv_hwprobe_complete_async_probe();
> -               }
> +               schedule_on_each_cpu(check_vector_unaligned_access);
>         }
>
>         /*
> --
> 2.47.3
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
>

