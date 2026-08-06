Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28B719CC14
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 00:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785974576; cv=none; b=Iaj18TZE6Jzy9s2q8n8Lmj+jMPM/vkIKKK6gjXY+xTWmtp+F3Ckovusk2G7wYcsdj9XQcKIz7MiLlAxPg3A7vREifnLveIgQBJVPStY+gVQmAgvGai+df3i/4mPPHEalLlKUpgcGldjKWcMZQhwvEriWulFqb+JLA37VgDS0Eks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785974576; c=relaxed/simple;
	bh=32nR9CD3NsD6bY/SW6+OnpnOjqk8Bk5XtdNO924d7NA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qj0OwXSq4Otqd7lDZNEu2A3gvbqyVH1TRThQASmgXKa9AaeQHEr5q+ko+dOzd0ikTyVuvJB5b8pkrnqX/WS7ck4D/mpgHlbaSEfOwPVJ904ARiL7UCD88TkU/L9TqX1C1NhYEvO47RDc4V3KsCMptLELHI90lmBPqLsUCkBPVco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=CiG+dD51; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="CiG+dD51"
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4F8093FBF7
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 00:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1785974560;
	bh=uV4/trZsrpkGEepaTlfIF0yIo2zjcaruWrpND/CzTIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=CiG+dD51gVY2T+NWx/xcJo7bT+aUARIF0a1343v18my2RRwGQqWnU8N1AKg6DmSXg
	 IQG+QQPRm2RfbxY4NUdD4Xt3omyG1aRlzm9CKatq9QeO2iVP8zh+pWfOXev9UC2Vwa
	 JdOBlVOVkIgIPkdqmwvg66lcCukkyGmZ70lRSWC2yfK9o/88zTY3qL6E0rNY/kqPEb
	 qZJNGFCeVj830z7QkugLE7TS27wkOWTP7i2vLWq6R9XnrCoa3KOQ9LLaF02T48Tpaz
	 S2ifdN1PanGFszEQLaAJsnDnfGTAF6QdZaQCdiP72ccrMpdm6SBQ2QbB7kjVA2pMiX
	 gAbPeAz7TpgOzfbEy0WMgyuyfJaPQtrFNntTwgsUG3SuGMzg9LXsNA9QD4y0H3gfFH
	 YzDBPJcGpcfteKPaNk9XEjwfNLvV4XCtRYlr68dnKd3TONyxbr8jeR1IX3Wy9oVAFZ
	 1or6AcF/YDodvdatT7+//nz+Dw7v/eMJBRdCHN1X4eqKnumQyZuIa1MOT6g6MtaLvv
	 U7zi+PHbm27WvsNabHISoKMiRQ73U+N5nenBjKmPThF5nCD5hbSOs4jhFnDhwCphA7
	 qQvThd6N/qdGTMEbezNh+k83bqwF7uQSxz/ulwuzv8Bt97vMn7xQyHQ8mxpeY8OnBy
	 +6d0n9ZbPYK/ubTUGxcKR7pg=
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb74d5db64eso1679603a12.2
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 17:02:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785974559; x=1786579359;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uV4/trZsrpkGEepaTlfIF0yIo2zjcaruWrpND/CzTIE=;
        b=ari4IkeCPYQSt0uTjbBTXteytxrP+g5HVwhtm4qP/KjRZ46lCeaHDMkB94YVo+AT4z
         wPC8zXKPWgGoIdHhO6YzM20jAZFMyY7Bk7+GJw2epZeOjaHJurD3BuX2rCo2zREnkRJX
         VkTPZtGmrmC8npd3K8/hQk0xf8Z1MC6qvOjWO62lapzrBPjE+lPKXd6efzntCibi2uO9
         WGXPxr4r0lJRe79lWoT/VbowUMrheaio2AW+PN0O8q828jrHWGJNfOMgjvtjvtDhE5X0
         nzGLZsmihcYh2gZH49FIjqdbZir+ry73MKsyUdxzuaIx1iUteT5N293qYo9gD/8f2fJo
         CsvQ==
X-Forwarded-Encrypted: i=1; AHgh+RpX2d9qri/gnAQXQFtJEKGcj4BqJK/szjP2AVVfkCyo4JWo2XJ7pFXA9N6hSSKjUCPZ5CWJ8tI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbSm15tBPIVv72qngcH7iyat/jEoOkja4AHWZ7zO1cVHUjdeqh
	E4vI3Ykp/BR0vL4dMnMCoeM95yH38IHhs7FocQkVLw5jgq35ognuReXfJGdfS4kmG8gCtxS/s+L
	jBrizVZ7XgWlQop19GJ5SP++a7scE761YrHGn6asKfCThhAqymHvRzYSlowJM42HkwxK1yyb+mA
	==
X-Gm-Gg: AR+sD13lu765Wfvxds9xRv1YWyPEPbaQ9rCyU974TRl/sHySY+SaVDhjt797q+v9xgp
	sVG89U3mp01H2k890eYZC5pxOeh7pNOJBxw++JcSCWQFBhJtE65kjugPqHsJkz8Psbs7XhM2bml
	EdC9phLB2HSOUHceu+whmJzCmcAK4eV8U+mA0SXlVyOrEAIkzcTmAa4+76AttB4GoyKh0xcGx5j
	JLN6ClSgMTT6SyEhue4zV9CUpNeY5BGWIxcM0p+8kBiHG2mCfV9yGXcTmGcVBBO11dYDESH9vPr
	fEc97pJPABOVBqB3XcclXawGyDSdJOpzVyZIt/jvwprxi9vyvTS2PazEHhiABuf/FN5qTTTPU+v
	a85r3wyamive16WY=
X-Received: by 2002:a17:90b:4c45:b0:38f:dec8:f7e9 with SMTP id 98e67ed59e1d1-3903c5a79f7mr11062688a91.12.1785974558470;
        Wed, 05 Aug 2026 17:02:38 -0700 (PDT)
X-Received: by 2002:a17:90b:4c45:b0:38f:dec8:f7e9 with SMTP id 98e67ed59e1d1-3903c5a79f7mr11062651a91.12.1785974557977;
        Wed, 05 Aug 2026 17:02:37 -0700 (PDT)
Received: from [192.168.192.71] ([50.47.147.90])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-39085dbf82csm362966a91.1.2026.08.05.17.02.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2026 17:02:37 -0700 (PDT)
Message-ID: <f13d94b4-2bd3-4737-b25f-bd5371189e62@canonical.com>
Date: Wed, 5 Aug 2026 17:02:36 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] apparmor: fix cred UAF caused by
 begin_current_label_crit_section()
To: Jann Horn <jannh@google.com>, John Johansen <john@apparmor.net>,
 Georgia Garcia <georgia.garcia@canonical.com>, apparmor@lists.ubuntu.com,
 Paul Moore <paul@paul-moore.com>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: James Morris <jmorris@namei.org>, Christian Brauner <brauner@kernel.org>,
 Al Viro <viro@zeniv.linux.org.uk>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 linux-security-module <linux-security-module@vger.kernel.org>,
 kernel list <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
References: <20260714-fix-apparmor-cred-uaf-v1-1-be40e8c83b90@google.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20260714-fix-apparmor-cred-uaf-v1-1-be40e8c83b90@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/14/26 08:38, Jann Horn wrote:
> AppArmor's begin_current_label_crit_section() is a scary function called

yep

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

right, we could even be a little looser in the update timing as we don't
make guarantees around the update timing.> 
> Note that AppArmor still performs direct cred replacements in the
> sb_pivotroot LSM hook after this change, and that direct cred replacements
> can still happen in VFS ->write() callbacks via proc_pid_attr_write().
> 
yep, I can take a stab at those

> Cc: stable@vger.kernel.org
> Fixes: c75afcd153f6 ("AppArmor: contexts used in attaching policy to system objects")
> Signed-off-by: Jann Horn <jannh@google.com>

this looks good to me, compiles, and has passed an abbreviated round of
testing.

Q. What do you think about making the callback_head part of the apparmor
security task blob. It would increase its size, but allow us to drop
the alloc/free. Generally profile is generally something that is relatively
rare, but when it does happen, its is quite common to have all the profiles
being updated, so a thunder herd type problem.

Unless someone else has a reason to carry this, I will pull it into
apparmor-next today, so we can get some testing in linux-next

Acked-by: John Johansen <john.johansen@canonical.com>

> ---
>   include/linux/task_work.h        |  1 +
>   kernel/task_work.c               | 14 ++++++++++++++
>   security/apparmor/include/cred.h |  6 +-----
>   security/apparmor/include/task.h |  1 +
>   security/apparmor/task.c         | 29 +++++++++++++++++++++++++++++
>   5 files changed, 46 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/task_work.h b/include/linux/task_work.h
> index 0646804860ff..ce19fc14060c 100644
> --- a/include/linux/task_work.h
> +++ b/include/linux/task_work.h
> @@ -33,6 +33,7 @@ struct callback_head *task_work_cancel_match(struct task_struct *task,
>   	bool (*match)(struct callback_head *, void *data), void *data);
>   struct callback_head *task_work_cancel_func(struct task_struct *, task_work_func_t);
>   bool task_work_cancel(struct task_struct *task, struct callback_head *cb);
> +bool task_work_has_func(struct task_struct *task, task_work_func_t func);
>   void task_work_run(void);
>   
>   static inline void exit_task_work(struct task_struct *task)
> diff --git a/kernel/task_work.c b/kernel/task_work.c
> index 0f7519f8e7c9..f83d1528e0bc 100644
> --- a/kernel/task_work.c
> +++ b/kernel/task_work.c
> @@ -189,6 +189,20 @@ bool task_work_cancel(struct task_struct *task, struct callback_head *cb)
>   	return ret == cb;
>   }
>   
> +bool task_work_has_func(struct task_struct *task, task_work_func_t func)
> +{
> +	struct callback_head *work;
> +
> +	if (!task_work_pending(task))
> +		return false;
> +	guard(raw_spinlock_irqsave)(&task->pi_lock);
> +	for (work = READ_ONCE(task->task_works); work; work = READ_ONCE(work->next)) {
> +		if (work->func == func)
> +			return true;
> +	}
> +	return false;
> +}
> +
>   /**
>    * task_work_run - execute the works added by task_work_add()
>    *
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
> index b1aaaf60fa8b..4e49a4142777 100644
> --- a/security/apparmor/include/task.h
> +++ b/security/apparmor/include/task.h
> @@ -30,6 +30,7 @@ struct aa_task_ctx {
>   };
>   
>   int aa_replace_current_label(struct aa_label *label);
> +void aa_schedule_stale_label_replacement(void);
>   void aa_set_current_onexec(struct aa_label *label, bool stack);
>   int aa_set_current_hat(struct aa_label *label, u64 token);
>   int aa_restore_previous_label(u64 cookie);
> diff --git a/security/apparmor/task.c b/security/apparmor/task.c
> index b9fb3738124e..8e368f6278f5 100644
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
> @@ -89,6 +90,34 @@ int aa_replace_current_label(struct aa_label *label)
>   	return 0;
>   }
>   
> +static void aa_replace_stale_label_tw_func(struct callback_head *tw)
> +{
> +	struct aa_label *label;
> +
> +	kfree(tw);
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
> +	struct callback_head *tw;
> +
> +	if (task_work_has_func(current, aa_replace_stale_label_tw_func))
> +		return;
> +	tw = kmalloc_obj(struct callback_head);
> +	if (!tw)
> +		return;
> +	init_task_work(tw, aa_replace_stale_label_tw_func);
> +	if (task_work_add(current, tw, TWA_RESUME))
> +		kfree(tw);
> +}
> +
>   
>   /**
>    * aa_set_current_onexec - set the tasks change_profile to happen onexec
> 
> ---
> base-commit: 3b029c035b34bbc693405ddf759f0e9b920c27f1
> change-id: 20260714-fix-apparmor-cred-uaf-cc38ec2b38b7
> 
> Best regards,
> --
> Jann Horn <jannh@google.com>
> 

