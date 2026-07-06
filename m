Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BC53ED136
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 20:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783370716; cv=pass; b=KXC5ulKKGfOuzGxwn0tCRsiBeCBTNEUK5ksl/69wq6pV8EHPj4tX6Cskt+smAn1Jxcfe/AmFHiYl+6WyQ4rvJU/c6j7q1SqIlfBavlq7mrtEUCiOsDUvf2EP1kO/KFV/NlqTUT8CtRlsa0qsjF7/NG8e1fzV3pQe3PykyYBg9tk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783370716; c=relaxed/simple;
	bh=phi6SQmy+4cONU1PL1vQPLQEFyLKyQT86aaovfKBpOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YMLM04VVYf6Z8uMFTGQ85R+eCodNNpLucJDaayq094wDDVxz+0I00qsbDpNmNkylG5imKIYQx49/7HFlTN4D4948RqMUrl4wVBUK/Qz/06Da1NX7f4QbaQ1l9jjZUM4Kq9RFfnraKapDl3WEQapbGRXf8/ga/cEYoYr89+jdEZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qomqa6f1; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qomqa6f1"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-698b6c87884so6059239a12.2
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 13:45:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783370713; cv=none;
        d=google.com; s=arc-20260327;
        b=l4RSZCnCMgJLL/HmajA2OlSLeAcQim0cSw8HUsER+5ZZy6g/9SCeTIZ2TVgimsXVcJ
         bWuWWEwWdpWaFQp0e4Bqvb8Ili5+zzmEzl+Hqp7pUA1JedEYTvwT+h1c9XKqtTID/T5T
         FMShzLmF1QJSgGI5oK6eYQ7SlwQ6jyLJfwjb1ov9bMgCOEWJyT0UjrpdJom+QMp8AFDe
         Z/blHOI71PMuG/hafA2s/cT4wSC5/w1muwjMC1QyEHIUYPyX2cZusMY3EZsme+BJvbgm
         S2l+dCRe8Rr0uYzEEig4x9HwzAPRxm4roZEiAEMwWGQMD+XZKsVbCyu6rc2FVfuOUW1N
         azeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5mn0WIFY0QbIYXoHQHCik87iyafQr85dBmRqdJZRASE=;
        fh=PkBYYF1EKGyaG9bLllvikWVxPA57K16av6IX8HpPiYo=;
        b=dh983kVjsGLAo4mg4jVP9Z1b2W+3cX0tK7fp8k93f5/QTP1lmTGdZqGH5CGM9S6wq4
         km1NlLOwmvZ2iw7ObyB1CmIml7yb5U7ZKB6gDSGdRz38K9u2y5SES9/c/OYZhyTB0miX
         hK0AAt/qMQJrfbXEB2c/vpONlonolmPDL9zCKVsMBLLPeT2BGUfHQvTAbPXPc/InFudi
         00Sgyk94qMjNMHtbRxwTM8RW7VZod+CKepwuJ6xmf0GlY4pmeQYE5xg1kzaHtx7DIRkK
         zMi50bp0sXP1TP2UuDokIl12ueUaQiU9B9GY5IorWtRGKnobp7VRR55OB12M05yU+6Ik
         foXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783370713; x=1783975513; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5mn0WIFY0QbIYXoHQHCik87iyafQr85dBmRqdJZRASE=;
        b=Qomqa6f1aE+5m1kWkNQT0C8Uziy/I+Z6fdFXgvPXWM5TA76yu/9wUgo97e+QmEhaXO
         mnZksb9fHB/C7oTQBRpPFjA559rBvH0Aq6XiQtuTR9EzJNWJmBH2sLIVkh+pDXw0T9uh
         3GRX7pRJRrId9NefK5MEGRdZ7brSc5TMOkpqK+AOQbZjS1BsnYhkVwAO4k8wUZqznv2e
         SWpls4mnJvnn8hdzU9ZrCCvzUEbJoMZDHpSO1w8SUdSE+mAoaS+eOdvY+Vj+QH3ZgR8a
         rl+t9tKUL/PWON97p4wKMUgeGUl8slEgmB81B23BzVGEMr+U7Pw9k+U820A7Nz+n2wB3
         2wYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783370713; x=1783975513;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5mn0WIFY0QbIYXoHQHCik87iyafQr85dBmRqdJZRASE=;
        b=PZ7UeZCfkjEelIYEzjW+4W4u+NKSE10739EhlwduJLJncv2gvPyVAMweSUwUUe/JYU
         qC/MP81EydMSuWz7Vr8t3kliaNDO4uMG6c+CX7cugTZoXKOdTiPhdUYHJ7v3L3by2clT
         9HinBq3VtVttuBZ3sfTHCHad5Z1du3v+Fs6vbplMkrijnTbLThKLg75qE4thJcATBLLP
         JWlSkcpVBBgk4qTH4tw89ym/Q0AiUSgkoE9kQ/Q0TBJ679+G0Vqu49O/PWlzUsz3ZfbB
         5u+LI+9RWUq7c63PAX0ww3nmJxqi7Gv2rySae2P3Hl5RFo7Wo0pVNa7O0Q9usinB3DQI
         RIoA==
X-Forwarded-Encrypted: i=1; AHgh+RpDxr/ebhQJFw2czmRdMRQPI6UBqsG7imLkOSgUw+hL2LAFPXqeMLu9P2pYniHP7XQP9ZEbdRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdLws/rtzrt7S2DBNimpRXkQR5vO/6z0aQzV7rDuzl7EaixkES
	eT1RARtlNU4+B1d1AmCl4Hj3qTVf3DFl7PZK3tFCl5AGneHc5/lFEQO6u1m2GSCbdQuwZUARyEK
	Zng/ZmdV1KL5pmhZD/7XL1O6cNjdW+kH1VveE8Dw=
X-Gm-Gg: AfdE7ckKBJ3frl7CrY82mnO5lLsVl1Rhaew1s3SfrAObmhKodzeG7ixPI8H8yudTHn1
	mqRxy3aJZKz/z+YtLDdLFYdpCppJg3rfRcuaX1goq/sSCZDWM/9o87krMJfHhNi0UkKoKgqH68f
	UW/G25W3hANVxs3uJdvcBu8NJM8mYzwd7pcr8ONXzpCA9Houv7QVV9Mqgeg6bZCIvXt6rrOjOMM
	6XtSYjC9o69vJ8/1b5JvL/4CkgMnnos/JTPBLKah8NK9gTRLknTCx3QpwOfubGzI+xzZPiDVE1j
	23AsWuwvhG6hEVqW4Pobos7zwVTbhiE=
X-Received: by 2002:a05:6402:24a1:b0:69a:4372:72ed with SMTP id
 4fb4d7f45d1cf-69a85bd4a3cmr1152947a12.13.1783370713265; Mon, 06 Jul 2026
 13:45:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706-procfs-ns-eacces-fix-v1-1-a69ab14c02e6@google.com>
In-Reply-To: <20260706-procfs-ns-eacces-fix-v1-1-a69ab14c02e6@google.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Mon, 6 Jul 2026 22:45:01 +0200
X-Gm-Features: AVVi8CcP74r82J481LtHNQ1kGkYmJsU-XepWM118pq-iMPREWKQZMjoT--4KfpM
Message-ID: <CA+=Fv5Q1nhB4cWZvNVaA66FFkovpOe9DZu=k6fxrSyvNose5Vg@mail.gmail.com>
Subject: Re: [PATCH] proc: Fix broken error paths for namespace links
To: Jann Horn <jannh@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	"Christian Brauner (Amutable)" <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 8:22=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> Don't return the return value of down_read_killable() (0) when a ptrace
> access check fails, return -EACCES as intended.
>
> Reported-by: Magnus Lindholm <linmag7@gmail.com>
> Closes: https://lore.kernel.org/r/20260706170735.2941493-1-linmag7@gmail.=
com
> Fixes: 6650527444da ("proc: protect ptrace_may_access() with exec_update_=
lock (part 1)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  fs/proc/namespaces.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/proc/namespaces.c b/fs/proc/namespaces.c
> index 2f46f1396744..ea6ec61a0430 100644
> --- a/fs/proc/namespaces.c
> +++ b/fs/proc/namespaces.c
> @@ -46,7 +46,7 @@ static const char *proc_ns_get_link(struct dentry *dent=
ry,
>         const struct proc_ns_operations *ns_ops =3D PROC_I(inode)->ns_ops=
;
>         struct task_struct *task;
>         struct path ns_path;
> -       int error =3D -EACCES;
> +       int error;
>
>         if (!dentry)
>                 return ERR_PTR(-ECHILD);
> @@ -59,6 +59,7 @@ static const char *proc_ns_get_link(struct dentry *dent=
ry,
>         if (error)
>                 goto out_put_task;
>
> +       error =3D -EACCES;
>         if (!ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS))
>                 goto out;
>
> @@ -90,6 +91,7 @@ static int proc_ns_readlink(struct dentry *dentry, char=
 __user *buffer, int bufl
>         if (res)
>                 goto out_put_task;
>
> +       res =3D -EACCES;
>         if (ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS)) {
>                 res =3D ns_get_name(name, sizeof(name), task, ns_ops);
>                 if (res >=3D 0)
>
> ---
> base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
> change-id: 20260706-procfs-ns-eacces-fix-3abd8e307936
>
> Best regards,
> --
> Jann Horn <jannh@google.com>
>

Hi Jann,

Thanks for the quick fix. I applied this on top of v7.2-rc1 together with
my Alpha generic-entry series, and the strace testsuite is back to the
expected state. In particular, the --pidns-translation tests that previousl=
y
failed due to strace seeing ENOTTY from the namespace fd now pass again.

Tested-by: Magnus Lindholm linmag7@gmail.com

Thanks,
Magnus
