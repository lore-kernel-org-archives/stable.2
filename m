Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792707545;
	b=agZgCGhLI+QnmqQ+5iskJXdaZq4qfsjI/69vCsytx74blTHWxXSHMUsGOf5cu8ExSYrz
	 AfmUyK3bvBDajnqZVvdsERmmS/RAp4Xmb5u38ko/wos0Qz91ouTV7pP3dcItQT4ftFPoD
	 zSMccV/cA8jOHOMCwUXA6o4w0D6ddsfZMHxxC3xMeXdObZirGfAvXsv0Tc4Ny7NwQiG3T
	 iLLxEEAaBf0hu8L+R8NXAptkD9jwa2gWcCNYqX0TTYebbrPCxXl+KSHY7u7S4CA92g5TC
	 CH5JqBtBGisTnNIwGNL8M7prQC+9triDYmeXoDiiNCa35xqxyBRJwW5nkDBKh+XkYCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792707545;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=U+fNGXuTxSBSDzV/8UaJRSMWMc2y739xNcnwuXMGhOM=;
	b=JKqZ2HsnhNRdgiNPUridHeY8FvJguz5Xq6opNUUQj7bYF5VkHtyUV3aBdLuXpLRXVdij
	 zJfWA/Tb7YtKplHyiGjkq0s3ghv2pGnduZ+9zKKfmM097rFpfLHSGrD0bsCkMopZK/Sk5
	 OV4C/+nSpIHoHDbEP+4EGqN2SNz61pS7g4D5Y7UxX3qMMJiBjQ0Wl2puyYKSxpWK6DLXw
	 I/FKQx6d4m78XE1SxQtZwIutGUUgTHHVabqgdVvFqmbzJ7OienK6jsOOJNAhhSZfAbSBj
	 EAaxHTzuIwLqMP+fd3Ucq6weWoczXAxTWg/WDwFv6WvhikBHZuoP4uP2Tmsf/s6aoEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tenstorrent.com;
	spf=pass smtp.mailfrom=tenstorrent.com;
	dkim=pass header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=UVXW82Um;
	arc=none smtp.remote-ip=209.85.161.46
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942F0606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 22:19:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 942F0606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=UVXW82Um
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6aa9606ddadso204064eaf.0
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 15:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1792707543; x=1793312343; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U+fNGXuTxSBSDzV/8UaJRSMWMc2y739xNcnwuXMGhOM=;
        b=UVXW82UmJEyPVGoE1zADd2PlLrWf2Q55H0DbUqCX+Rh2spjP8ewRwWzKPEyUjIQSga
         xJo2mvNGbLYJyaBFei59ls/n7MIrpcTy7kTLQD//L3zaWnVNbIl5TNsFW4XeqMKmydVw
         s7ByfXc6ixdSyAyg/98J6zjI/FfDxKQllk4H4ennofDE6CDoOnUbh9gI2wco4eMqqi1x
         /nrSrsPyt6t2DC7cYf5E9ajT6Cyu8r8bmDEEZ7hgo/Erdu+O1qySJZ6xCeGgqahs8fyg
         0bqcvwMOBrOVboCrbhQytVOga8EkCZyDzocKHTP/2/TtPcKN6gYT2iJJzkokWEOIeHwy
         PgkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792707543; x=1793312343;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U+fNGXuTxSBSDzV/8UaJRSMWMc2y739xNcnwuXMGhOM=;
        b=VE86m6vJzWt5KAvAddNCmK5nvwUr1jxOfSdiZ9Ytnrq6PfPGo/KfoPfmiAIIwtyACE
         MxlxaZM3XShgTT/POds3feqGxOb7BkxlE9NaggwNN82xWVfEg1Rj2aKkeIZUOrN2ZKcC
         yVoKssoB2wnRa4QQTcXsL4d0OKb5wRj/T84qTIrgdLwlBB7fs2GVBTfiYFEqrEJFjkmk
         AWvRdI55HZE6NCqV88H05d4JUiqQPZ7QoAgL2YjF0uVHQIzjp3s4uRE6wEONfDFUS96y
         bOjtaV3YjmiX6fzB3t6yr2+1WqI1JpILugnK/72Tq2R4OjGozwP/wIoS7Inb2VPlQAjY
         e+Og==
X-Forwarded-Encrypted: i=1; AKwUvBxkbG65tjBwElkL/iY2h3mf8P0yRLM8XUwClETvlynijfZlH6N7uLIQt3xQy3B8yL6L8jXJpEY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ1A9sCCZq/HWXV2vVxzXgPoNWsOZOMyDd9IUlKk7joFOZgcQCW
	hgVgDXcyO5g4/++F45SxRmtQaH6DI9OlIeCRLm2erwtQfV8smLyaajsQt+KJ/+vA0Pc=
X-Gm-Gg: AYBFou2R5zQB1bYkPh1YfDxsi+DmSSMcHcHvQ3vGdWohZiMfo0tFuW0GE8Vudm1L5kG
	CnqiBaoQjr49hqYSWjjxyj8tHaoVKjL9tC0AjYcOmPUJwyYVMCluuX4IGwIxGkCgk9J8ZsDOgvw
	4sar7AOA61m0k0W3pMXsbE/i3APYl/3e2JhHq8P8aXiGrgRNA94rhGtGkPzwzj7+nbvalYlXUzQ
	8DohFqIxa/QXxWCJaq/VuUYe7FPV1jgWDG4JxH9nqqcydetj1VEySiQxDRt2rXtmUotB6tYgwFL
	iEumUh0z6YrDIaemqgIBv//5/AkYrC+1TlyTPjw5xZLmzaZdrEyBsS+fP++yav2BIISJq5T5VY5
	uHxGqWXeqkwkCDkJJHGrjlA3ShSpu6kiV3LgfYFzEC3YQ51yhbj2aPZK4nq4eJLNDc2OrEf5j2t
	I4K9LeJWPwdwOWrLDioJZevXJY87r5ohPVFKsMlA0i/eedCrMCRdkHVgXzSspOBvScg1Y03AZyn
	u3/SRQs2r+GVzWSzggbqizjd5CgnY+9ZkdIwB/34mKWy6rGTmdQPzvYxY6uepc1rP0=
X-Received: by 2002:a05:6820:221a:b0:6f5:eeee:b22 with SMTP id 006d021491bc7-70b88a52a06mr594387eaf.49.1792707543577;
        Thu, 22 Oct 2026 15:19:03 -0700 (PDT)
Received: from localhost ([68.203.12.10])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a82021ea20sm312316fac.0.2026.10.22.15.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 15:19:03 -0700 (PDT)
Date: Thu, 22 Oct 2026 17:19:01 -0500
From: Andy Chiu <tchiu@tenstorrent.com>
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, zong.li@sifive.com, wangruikang@iscas.ac.cn,
	debug@rivosinc.com, qirui.001@bytedance.com, guoziyi114@gmail.com,
	samuel.holland@sifive.com, ben.dooks@codethink.co.uk,
	cyrilbur@tenstorrent.com, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] riscv: Fix SR_SUM leakage across context switches
Message-ID: <atqL1ScMLUg2bM_E@Tao-Chiu's-Mac>
References: <20261022083212.84721-1-cuiyunhui@bytedance.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022083212.84721-1-cuiyunhui@bytedance.com>

Hi Yunhui,

On Thu, Oct 22, 2026 at 04:32:12PM +0800, Yunhui Cui wrote:
> __switch_to() saves the sstatus value of prev and restores the SR_SUM bit
> of next with csrs. However, csrs only sets bits. If prev has SR_SUM set
> and next has SR_SUM clear in its saved state, the old SR_SUM bit remains
> set in sstatus.
> 
> This lets next run with user memory access enabled even though its saved
> SR_SUM state is clear.
> 
> Use csrrc to save the sstatus value of prev and clear SR_SUM from the
> live CSR before restoring the saved SR_SUM state of next. This keeps
> prev's SR_SUM state intact, while preventing it from leaking to next.

Do you have a way to trigger this bug on existing code or is it the cae
where the bug could happen but we never experienced it in real life?

If I understand correctly, this can only happen when the user access
routing volutarily makes a schedule() call mid-flight, or a code fogets
to turn off SR_SUM right after an user access and has a live SR_SUM when
calling schedule some time after. Both case should be a bug as SR_SUM
shouldn't live in the kernel code that is not doing user access.

A trap-introduced context switch would interrupt a code that have SR_SUM
set. However, since the bit is cleared at every exception entry, the
context switch code would not see a live SR_SUM. Seeing the bit set in
this case means something is not turning SR_SUM off properly.

I aggree that this is the better way to handle SR_SUM in a context switch
but attaching a call trace or stating that "We have not caught this in
real world due to ..." in the commit message would be appreciated.

Cheers,
Andy

> 
> Fixes: 788aa64c01f1 ("riscv: save the SR_SUM status over switches")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  arch/riscv/kernel/entry.S | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 61b7a77166971..628b85e3915a7 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -443,15 +443,15 @@ SYM_FUNC_START(__switch_to)
>  	REG_S s10, TASK_THREAD_S10_RA(a3)
>  	REG_S s11, TASK_THREAD_S11_RA(a3)
>  
> -	/* save the user space access flag */
> -	csrr  s0, CSR_STATUS
> +	/* Save and clear the user space access flag. */
> +	li    s1, SR_SUM
> +	csrrc s0, CSR_STATUS, s1
>  	REG_S s0, TASK_THREAD_SUM_RA(a3)
>  
>  	/* Save the kernel shadow call stack pointer */
>  	scs_save_current
>  	/* Restore context from next->thread */
>  	REG_L s0,  TASK_THREAD_SUM_RA(a4)
> -	li    s1,  SR_SUM
>  	and   s0,  s0, s1
>  	csrs  CSR_STATUS, s0
>  	REG_L ra,  TASK_THREAD_RA_RA(a4)
> -- 
> 2.39.5
> 
