Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D11262D0B
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 01:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786065089; cv=none; b=kTCdAFgrhofpUhxfABaO7xBLsOsybPRodW5ZK1bfSH2b52/jORWR00E0OlyPZynoDmXXpfc/HZIbGH537DXPvboo/ITh2ho9QXQ9Esgpk6uLXSqR4O1p8/Scv5gxVohgTTxrFMbXe+8gQyzcTxcMqkYWYTo10aGA1x6+4zCELas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786065089; c=relaxed/simple;
	bh=DWmsYwvXlNcS0nafhmAN8vonDANQ0KtQSTrMivl4Ii8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DLxG+qJzzCbut3wjVmUb0WjjPnZ+Hd8LxbPTU0cKbia41WjPDGmPsZSnhd8hj9+DgIwh51LULnTUX5WWVOysDvcClXgDYh0Z4ks3LP5Kt0h16Fw4IYHTqgoYOZDJ4f5cVhXN5IqGndlsFbxRthiyvfy4wmtrikDZ8KjxacBzHJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=ONrNjKXi; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="ONrNjKXi"
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 273293F9C4
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 01:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1786065082;
	bh=eseWD7+QIvTlT0URhL2f19vXeeOZAqjSdrcbsi5dv+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=ONrNjKXiW8wltujzE4aj+fKBbse4V8+uSgwe83us2ZMmS4Lr3F/Wb8vHTaVc7Boid
	 DGgBQJn9/4b0xltPTJkXbCS8gfb5CCfNcnlukydu2uuaqgX+bU1jz8QA8gTvJ1gwDT
	 YS4w7ivReXymkowE+8gsm4iKBtRMaFxe+J3Q7C0iFZPaIBsBCuTOj2o7QdNpIpljsr
	 DUtIYVx7Ho4zq+oa5UknH26qCUu/TlKnISPJkp/lDE7FTvEr9v4U0WyFHQwZZTe3gg
	 UhhchL1r8WGRyo1aSDg+1ilyK8RA0FMpv9rDXj5oGsDwWh5pJNnEHYzJwymsjDJTof
	 /vHTI1ennGiDgu6k6dhs6hh0hl0HSeuZzCO+zbvp1gIgWnaL8GSxjTBiOLbzmPKB6U
	 rGYB652S3WOVv5jP+NV8FQxNpAveczC3rVwGqSKdG03DCHsd343HQ0RwWLN7BbpAQR
	 7BUgk+u8ezcQSZxyppM/OrhXk/KFxGRI2oT7Lnit48DuaTe+r/k5QapYSpy4b4FrIv
	 SJaXizkpxTtRKvB6UMgCPyA5LPGj3S+kp3mmxgyZQ4FLuyI+aLg2rSy8JMqyvxymqS
	 yFVomkH2sY5HQ2BtI2/KTViiJIegqJtFZbDJBaTIJAZWjok7Z2ScbWvZs9Iz03OcIZ
	 Cwr74G1SWczFLcLs3+hwc9mI=
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8488ac68185so6841836b3a.2
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 18:11:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786065080; x=1786669880;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eseWD7+QIvTlT0URhL2f19vXeeOZAqjSdrcbsi5dv+Q=;
        b=IYcSCCZvSFTE/EpcintLR/L4+fH1w7xRjSXrdV6GpLBq5VIaYZvG0Q2tjQ3t8PVfwd
         Dp2Fn5Jn3hLM1TlYErrganPr/lmz++zUNBJFwuuAh5ZFSepi5vUZQ/RqbkYHHPDwcSrc
         jKN2qYXBZLzQDU8StxJWLQjHBEQmxWKEMaHgOp3yzZpK62d+Q67AUkou4pz+lzmeexs2
         IQxJyPnTSfjFfX33M270drPeIL6Ysmaxx+y6U3szvOkWqtN2LLWFbfasi9+Io8y+xP1c
         OZf18zOMUc8/mi42ROosVpAZ52Mr6VdiTgquTbuRqc5Y6RXcdT9oG10CYgUCj5jACggn
         Lftw==
X-Forwarded-Encrypted: i=1; AHgh+RqyUARYjoZIg+ddfy1h2wjO61uuTMM2A4Gi2acCI9Qrzql/X6ZxkyxsFI5oABtvmPx12sTi6jY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiOBxEnBgpOgq3Ox160ad0Jxh+YIs9VCx+H/vv3WUAjjr5/PNP
	SxBrEHeaPN9Pj1mq6Qyncyxjz1KUhU5hJvJEOGsOJjw2vNxyh5gnQXNWntR2MMimC8Ci1wDHvZr
	Jl4fXNLd3fe0t8G3kHQ6+X8iLTtn6Auz6Wzu3xQBm6kmY31L0/UtH2FlSF2X+f9MqBt2lPIa1vQ
	==
X-Gm-Gg: AR+sD12umntyF08z70rdFnDyf98DKdrzBV9bxRq5uMzsLfyf0pSwqpcg69tMd8S8/CH
	EKgsXclTQRntPK32YPM0eLLc1So8N5FYQjXWhiKaQx8FbzUHDnQNUMuNZvVrkQKSw8pt0Z6c0Rg
	wEzsdRXUpu348H/AzOpjtRfYGJo6g+tra5cGvFpN+Gw/M/No3LHSx1qnhY4dT+wgRrgm5ezUidO
	N2qh+RBR/wE38PTmdCiXtcJ2817r+K4g7d7L9y26sNdEbFg2oEytD4FPIYAjmXV+QpuvY88ncuU
	1wHKsLJWa0VyPO4mPDt/iywWmweY4Xd/VGH9cTnfhb+t1An8fyVt3EeTAjw7ctna8oVZx5JmPSz
	NVouQDCC8kkm2rb0=
X-Received: by 2002:a05:6a00:32c3:b0:848:47d3:47ec with SMTP id d2e1a72fcca58-84f2e0826afmr23698461b3a.31.1786065080131;
        Thu, 06 Aug 2026 18:11:20 -0700 (PDT)
X-Received: by 2002:a05:6a00:32c3:b0:848:47d3:47ec with SMTP id d2e1a72fcca58-84f2e0826afmr23698395b3a.31.1786065079592;
        Thu, 06 Aug 2026 18:11:19 -0700 (PDT)
Received: from [192.168.192.71] ([50.47.147.90])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-cbe8bb42e01sm76311a12.10.2026.08.06.18.11.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 18:11:19 -0700 (PDT)
Message-ID: <f6cb1659-b5e7-416d-a0a0-e23c9e4281ba@canonical.com>
Date: Thu, 6 Aug 2026 18:11:17 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] apparmor: fix cred UAF caused by
 begin_current_label_crit_section()
To: Jann Horn <jannh@google.com>, John Johansen <john@apparmor.net>,
 Georgia Garcia <georgia.garcia@canonical.com>, apparmor@lists.ubuntu.com,
 Paul Moore <paul@paul-moore.com>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: James Morris <jmorris@namei.org>, Christian Brauner <brauner@kernel.org>,
 Al Viro <viro@zeniv.linux.org.uk>,
 linux-security-module <linux-security-module@vger.kernel.org>,
 kernel list <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
References: <20260806-fix-apparmor-cred-uaf-v2-1-c3bbb9f87a9e@google.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20260806-fix-apparmor-cred-uaf-v2-1-c3bbb9f87a9e@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/6/26 08:55, Jann Horn wrote:
> AppArmor's begin_current_label_crit_section() is a scary function called
> from lots of LSM hooks (in particular VFS/socket-related ones) that checks
> if the label referenced by the current creds is marked FLAG_STALE, and if
> so, attempts to use aa_replace_current_label() to replace the creds with an
> updated version that uses a new label.
> 
> The first problem with this is that it would directly lead to UAF of
> `struct cred` if anything in the kernel takes a pointer to the current
> creds and accesses these past a security hook invocation that replaces
> creds, like so:
> ```
> const struct cred *cred = current_cred();
> alloc_file_pseudo(...);
> uid_t uid = cred->euid;
> ```
> I don't know if anything in the kernel actually does this, but I think it
> is very surprising that this pattern could lead to UAF.
> 
> The second problem is that things go wrong when aa_replace_current_label()
> runs with overridden credentials. aa_replace_current_label() bails out if
> `current_cred() != current_real_cred()` (mirroring the check in
> proc_pid_attr_write()), but this check can't actually reliably detect
> overridden credentials because the overridden creds can be the same as the
> objective creds.
> 
> So in approximately the following scenario, things go wrong:
> 
> 1. task begins with <creds A> (as both objective and subjective creds),
>     with refcount=2
> 2. task grabs an extra reference on <creds A> for overriding
> 3. task calls override_creds(<creds A>), which returns a pointer to the old
>     subjective creds (<creds A>)
> 4. task enters AppArmor LSM hook
> 5. AppArmor checks that objective/subjective creds are equal
> 6. AppArmor replaces both cred pointers with <creds B> and drops 2 refs on
>     <creds A>
> 7. task leaves AppArmor LSM hook
> 8. task calls revert_creds(<creds A>)
> 9. now task->cred is <creds A> while task->real_cred is <creds B>, but the
>     task_struct logically holds two references to <creds B>
> 10. another task drops the extra reference on <creds A> that was used for
>      overriding, refcount drops to 0
> 11. now task->real_cred points to freed creds
> 
> At this point, any access to current_cred() will be UAF.
> 
> I have a test case where I run aa-disable on a profile while a process
> using that profile is blocked on splice() from a FUSE passthrough file into
> a full pipe; after the profile update, the pipe becomes empty, splice()
> resumes, the credentials go out of sync, and a subsequent getuid() syscall
> results in a KASAN UAF splat.
> 
> To fix this, instead of directly replacing creds, do it via task_work that
> will run at the end of the current syscall. (The point in time at which the
> cred replacement happens should have no correctness impact; it is just a
> performance optimization to avoid unnecessarily touching the refcount of
> the new label.)
> 
> Note that AppArmor still performs direct cred replacements in the
> sb_pivotroot LSM hook after this change, and that direct cred replacements
> can still happen in VFS ->write() callbacks via proc_pid_attr_write().
> 
> There are two options for what to do with aa_dup_task_ctx(): Either
> explicitly reset new->label_replacement_pending after the entire
> aa_task_ctx has been copied, or switch to manually copying members over.
> I am switching to manually copying members over because that should make
> bugs more obvious.
> 
> Cc: stable@vger.kernel.org
> Fixes: c75afcd153f6 ("AppArmor: contexts used in attaching policy to system objects")
> Signed-off-by: Jann Horn <jannh@google.com>

lgtm, and I have done some light testing. I have pushed this to apparmor-next
and will kick a more thorough set of testing

Acked-by: John Johansen <john.johansen@canonical.com>



> ---
> Changes in v2:
> - store task work in task security blob to simplify things
> - remove cc to peterz, I'm no longer changing task_work implementation
> - Link to v1: https://patch.msgid.link/20260714-fix-apparmor-cred-uaf-v1-1-be40e8c83b90@google.com
> ---
>   security/apparmor/include/cred.h |  6 +-----
>   security/apparmor/include/task.h | 15 +++++++++++----
>   security/apparmor/task.c         | 27 +++++++++++++++++++++++++++
>   3 files changed, 39 insertions(+), 9 deletions(-)
> 
> diff --git a/security/apparmor/include/cred.h b/security/apparmor/include/cred.h
> index 2b6098149b15..0e8b67159f56 100644
> --- a/security/apparmor/include/cred.h
> +++ b/security/apparmor/include/cred.h
> @@ -222,13 +222,9 @@ static inline struct aa_label *begin_current_label_crit_section(void)
>   {
>   	struct aa_label *label = aa_current_raw_label();
>   
> -	might_sleep();
> -
>   	if (label_is_stale(label)) {
>   		label = aa_get_newest_label(label);
> -		if (aa_replace_current_label(label) == 0)
> -			/* task cred will keep the reference */
> -			aa_put_label(label);
> +		aa_schedule_stale_label_replacement();
>   	}
>   
>   	return label;
> diff --git a/security/apparmor/include/task.h b/security/apparmor/include/task.h
> index b1aaaf60fa8b..6f26758ca10f 100644
> --- a/security/apparmor/include/task.h
> +++ b/security/apparmor/include/task.h
> @@ -21,15 +21,22 @@ static inline struct aa_task_ctx *task_ctx(struct task_struct *task)
>    * @onexec: profile to transition to on next exec  (MAY BE NULL)
>    * @previous: profile the task may return to     (MAY BE NULL)
>    * @token: magic value the task must know for returning to @previous_profile
> + * @label_replacement_tw: for aa_schedule_stale_label_replacement()
> + * @label_replacement_pending: is @label_replacement_tw pending?
> + *
> + * When changing this, check if aa_dup_task_ctx() needs to be updated.
>    */
>   struct aa_task_ctx {
>   	struct aa_label *nnp;
>   	struct aa_label *onexec;
>   	struct aa_label *previous;
>   	u64 token;
> +	struct callback_head label_replacement_tw;
> +	bool label_replacement_pending;
>   };
>   
>   int aa_replace_current_label(struct aa_label *label);
> +void aa_schedule_stale_label_replacement(void);
>   void aa_set_current_onexec(struct aa_label *label, bool stack);
>   int aa_set_current_hat(struct aa_label *label, u64 token);
>   int aa_restore_previous_label(u64 cookie);
> @@ -56,10 +63,10 @@ static inline void aa_free_task_ctx(struct aa_task_ctx *ctx)
>   static inline void aa_dup_task_ctx(struct aa_task_ctx *new,
>   				   const struct aa_task_ctx *old)
>   {
> -	*new = *old;
> -	aa_get_label(new->nnp);
> -	aa_get_label(new->previous);
> -	aa_get_label(new->onexec);
> +	new->nnp = aa_get_label(old->nnp);
> +	new->onexec = aa_get_label(old->onexec);
> +	new->previous = aa_get_label(old->previous);
> +	new->token = old->token;
>   }
>   
>   /**
> diff --git a/security/apparmor/task.c b/security/apparmor/task.c
> index b9fb3738124e..e16ff4130bc2 100644
> --- a/security/apparmor/task.c
> +++ b/security/apparmor/task.c
> @@ -14,6 +14,7 @@
>   
>   #include <linux/gfp.h>
>   #include <linux/ptrace.h>
> +#include <linux/task_work.h>
>   
>   #include "include/path.h"
>   #include "include/audit.h"
> @@ -89,6 +90,32 @@ int aa_replace_current_label(struct aa_label *label)
>   	return 0;
>   }
>   
> +static void aa_replace_stale_label_tw_func(struct callback_head *tw)
> +{
> +	struct aa_task_ctx *ctx = task_ctx(current);
> +	struct aa_label *label;
> +
> +	ctx->label_replacement_pending = false;
> +	label = aa_current_raw_label();
> +	if (!label_is_stale(label))
> +		return;
> +	label = aa_get_newest_label(label);
> +	aa_replace_current_label(label);
> +	aa_put_label(label);
> +}
> +
> +/* replace the current task's stale label on syscall return */
> +void aa_schedule_stale_label_replacement(void)
> +{
> +	struct aa_task_ctx *ctx = task_ctx(current);
> +
> +	if (ctx->label_replacement_pending)
> +		return;
> +	init_task_work(&ctx->label_replacement_tw, aa_replace_stale_label_tw_func);
> +	if (task_work_add(current, &ctx->label_replacement_tw, TWA_RESUME) == 0)
> +		ctx->label_replacement_pending = true;
> +}
> +
>   
>   /**
>    * aa_set_current_onexec - set the tasks change_profile to happen onexec
> 
> ---
> base-commit: 0d839570765118029aa8bf4a95444c6a11aacf85
> change-id: 20260714-fix-apparmor-cred-uaf-cc38ec2b38b7
> 
> Best regards,
> --
> Jann Horn <jannh@google.com>
> 

