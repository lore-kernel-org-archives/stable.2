Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DB446AEDD
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 16:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787590000; cv=pass; b=Lx3d7Z+DiNsBpSaJrJ+dYD7wZV1IILoZ9msg5VB0lMr+cNuErkcrG1qsOQVEByLVbq4qhomTSRMZTEokkyccAnP9LSYU2fxvXYH4UvKN/sLrsQujugtWH6okadfe34WRXn4299vEN2xAmf51c/sXnRN5CziBGniV7thNw219r9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787590000; c=relaxed/simple;
	bh=hEmgWjDHeVx/08GjnuKmhCudAsXDhlQnYWAqBTjYOoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uvPyyaWAtmIUx4NbN2lIO/Q0+IZpN0AiNE4/XNR1n1j1uJXW/5uxzQQbmS+TJtlLg/mDnwKuG9BnxJRpievZXyCiG0YcdagzdJTwLd9yK7s/c1LuTo3AI5Lk4eY61CzEM5fAIOQWdEFpdbPF7lwGkc/oT9jxMvn0Gek0NTjP02E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BT4iH1sW; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BT4iH1sW"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c01c79467so593561cf.0
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 09:46:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787589998; cv=none;
        d=google.com; s=arc-20260327;
        b=DGp4xYUWTE/C5nFpbB7nwvxqYxXq7lBs0kZr+bCYNlCezeYhLoyC7CjcPLw+AN0LKI
         HoZYWi66MgooTvhbGrhG9+7qvGiXkoqOYiIpuaeFHc0w9gP7IaZTH9eB8vslRw9bsI87
         jj7gIT+RMHVnUdVwllAN1QMpDYiwRN/9YXMBymuIqzCBAuCOCboV0MivB0bIXNhpuwrM
         yVKkTPn46BWxnSoDFOtY+7TtvyX1Ga73ttR0jj67EZguem9C0zc3F1mANKTgBwFEBmd2
         eK2gegF9jihwxj3oe0KO/jfGg1x0hHptw44yvZolKRzNw1385Na0tvVzlRVO4JI0dpoQ
         IITQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aBhTc82nB66e/4NpNewHf6JJYCPf4dCSCUGVU1FeI6w=;
        fh=/+uFpXthJXKLVOIkGy4IPp0mZ8jqphKHytTG40pyQVY=;
        b=n0qIVRHA3m1HhEbwjkTV3jkvtHMXfzDV2GQ/egoqwl43UOtzV7/qQ1GZhrj5vuTYGI
         3/Tn9PmoJNx7UK5pOr5SepsXzNcvH3W72lCcmdXFEf9TAKJRau7zuYthjDXP/RToE3Pe
         9D02j+d5DXs5Wiboo93V+T4Cu0PYPK5srGWykru+WrzAfyef1eHTkLcWOEKU4J5Z1ZWs
         Ye68FWmlbsK2bjLhtIPnyjoAB94dXjACD7o1Sob6xgVr/KGAPr8HExxfXpJZkwCTDdt4
         OxzugXuYAOxSw5nh2t1t3wDPsHXvEQejPBfiGktImF/pIIr+XxPcFBnVePFkNKaPqwD7
         lfGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787589998; x=1788194798; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aBhTc82nB66e/4NpNewHf6JJYCPf4dCSCUGVU1FeI6w=;
        b=BT4iH1sWwhG1CcxAHaRnv4oQqyf6iAvul9RmDRoDU3HFkFIXa2pak3sFWzwSQpHNKh
         Bot6zgxhJTwnuNi6VQJYkR3fFBkITEwtluljVOiC1eiZYEhPu417jDhSr8E3nE7vGMBR
         UzbtEL1mcg7CCNnxVJNQkmhQYVMs7NFmDFiV8TZVh+fHu7NI/ax49kzvGu+miJV7/mJp
         5yj6TP5E+hUuHF3mv+1RaxGKIBDSfh+uJC4ydzdyEBFsPkdH++S0/XfMC6HmlKCBuEWP
         qgvQ1Dj0BEJtK/FYhChn8uYkt/vBRr0gzVnweV1SCGRMFPynRk3FzjB1wrAMjWfP0YC9
         SrVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787589998; x=1788194798;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aBhTc82nB66e/4NpNewHf6JJYCPf4dCSCUGVU1FeI6w=;
        b=Ja6QvwiiN17LzNXuOMN49I4fm+abL01MGndvmJ0yM5k0FhbBYbZdad0mssYlK5Sj/t
         rIn2NjlYjhSuWD0AXaPN8vv1UzoV+XjwbSIlEXFHhGmRKA/KvKMXZ0aDqFnJ9TD1joD7
         wn5/9SxxnBgrnR3WJ128AYOTbG6oph9Vr8eAsW0rA7/hD+e0AbfvxWzM/XxokYg/baPu
         XD6h5ixx2/3qMtugxUU57EzMesZx4QRpA0/pe8/9+LyVdaQ419viO5a2VkCisDvLCj4m
         VaoBMQ4wmpahg9kpkCDBDOCATVlf0scbvGRyMjET2iS7HYUnciMW3ofsBy/OO0F1JOA8
         BAbw==
X-Forwarded-Encrypted: i=1; AHgh+RqrcmpzQX20ytKFPTrJCgqSr1YzBEhq5rG0J0dLn6lOEr0c1uAgHX9lX0pkIUDZgRzfhRkLLto=@vger.kernel.org
X-Gm-Message-State: AFuF++nz20ZJsBePlAGTQj+spqwoXjtu/WtKSCtxfWhEKDIK7mJnWBTl
	JOudKqdE3KKsTxRvFYQu9lXhY335UH5j4vzwqy82jhl9lmF/jVdfc+70vSfgxQNenxMimw+1gYI
	JIqYsel7L2T1CpBdRe/YJ7Dh/fXZbru/01QFoyzu9
X-Gm-Gg: AR+sD13yZiNQ2vQQ+wjGb7zFXpdtjnRJrCo+fw2U7399GauA8Gikt//3eWzFxtnHPPj
	cv5sFK3rO8OawcgXOPIWuxmAKFwC5fskxyAYaH8AVvEIKInY8cGmdvnpAOZBjqcKxZ1DoTihfz7
	aUZLz1ySm/MUFFKp5TfT6VF9q8MXSXGEBCShA2dM4hYx6+95R8B3Yv4xfPFBsEzGsOfd+3zdKhf
	YfFPYmnOk9y06S6Rm0xxTyv/UteE+pAqfigLn5KqeKaGnUZKtPcbps+Sj68uJ3V2MulMNY74wzN
	Np4r5Ab1rbaYbaw7AFw10hgUs9iegFS8wT1X8T0buLs=
X-Received: by 2002:ac8:7fcb:0:b0:50f:b69a:f4a8 with SMTP id
 d75a77b69052e-52e0a7e35c9mr33329621cf.7.1787589992298; Mon, 24 Aug 2026
 09:46:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817062726.106511-1-hao.ge@linux.dev> <20260817062726.106511-3-hao.ge@linux.dev>
In-Reply-To: <20260817062726.106511-3-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 24 Aug 2026 09:46:21 -0700
X-Gm-Features: AcwNN1VCYimyRCvoNVNxz7vlNo-ZiPjIZDP5jBXv4SzlMbFF259OhbReYGQYLZM
Message-ID: <CAJuCfpGRh4ZNR1fRQ+d7f87W8xO5SCTmABmxt6w3Jz2bEu2fXA@mail.gmail.com>
Subject: Re: [PATCH 2/2] alloc_tag: remove /proc/allocinfo outside of mod_lock
To: Hao Ge <hao.ge@linux.dev>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 16, 2026 at 11:27=E2=80=AFPM Hao Ge <hao.ge@linux.dev> wrote:
>
> shutdown_mem_profiling() calls remove_proc_entry() from
> reserve_module_tags(), which runs under mod_lock held for write.
> remove_proc_entry() waits for readers, and a reader takes mod_lock for
> read in allocinfo_start():
>
>   CPU0 (insmod)                      CPU1 (read /proc/allocinfo)
>   ----------------                   ----------------------------
>   reserve_module_tags()
>     down_write(&mod_lock)  [held]
>                                      use_pde()            [in_use++]
>                                      allocinfo_start()
>                                        down_read(&mod_lock)  <- blocks
>     shutdown_mem_profiling()
>       remove_proc_entry()
>         wait for in_use =3D=3D 0         <- blocks
>
> Move remove_proc_entry() to a workqueue.
>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compress=
ion")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hao Ge <hao.ge@linux.dev>

Acked-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/alloc_tag.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> index 80eccaca665a..b1d48532a25a 100644
> --- a/mm/alloc_tag.c
> +++ b/mm/alloc_tag.c
> @@ -15,6 +15,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/string_choices.h>
>  #include <linux/vmalloc.h>
> +#include <linux/workqueue.h>
>  #include <linux/kmemleak.h>
>  #include <uapi/linux/alloc_tag.h>
>
> @@ -591,6 +592,13 @@ void pgalloc_tag_swap(struct folio *new, struct foli=
o *old)
>         put_page_tag_ref(handle_new);
>  }
>
> +static void remove_allocinfo_file(struct work_struct *work)
> +{
> +       remove_proc_entry(ALLOCINFO_FILE_NAME, NULL);
> +}
> +
> +static DECLARE_WORK(remove_allocinfo_work, remove_allocinfo_file);
> +
>  static void shutdown_mem_profiling(bool remove_file)
>  {
>         if (mem_alloc_profiling_enabled())
> @@ -600,7 +608,7 @@ static void shutdown_mem_profiling(bool remove_file)
>                 return;
>
>         if (remove_file)
> -               remove_proc_entry(ALLOCINFO_FILE_NAME, NULL);
> +               schedule_work(&remove_allocinfo_work);
>         mem_profiling_support =3D false;
>  }
>
> --
> 2.25.1
>
