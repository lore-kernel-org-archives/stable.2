Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBF1306776
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 03:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780286344; cv=pass; b=VIZhFVNlf8hJxnPDlCsfjyVgOACLqUGJQANBwn9X+htam/dDtaiTSsHr1OmWegmu2kAI2QXrLdstTESQRkB5HCPHJgW0+s+rAUIKAKLVM9mwJNDsQNnqvBnMDwMTtTlumEZIWymkl53nNefkHwdN6rnA5kEmw/zso86i36VY0HM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780286344; c=relaxed/simple;
	bh=R2gda0sh3Y9ZKjnqeBHRoWIg5TBSqprzO9+faDr6yYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NOxe36jvRr8h7l0rvzsqpQyEPmhsJGP8D6Bac643lwTrEURLVBughPXTLHPsAXEmplPUO6sg+AsKZvCa40FN5+YciH3hZnYLphwwo2a1iwqCJLZC4fDygvzKJ/7V7trhFpRQ4+IjnTnM+cqy2EVQxLjruMMzQuZbp1MtX8vyVTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fgqc1Gu/; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fgqc1Gu/"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-45ef372c58aso1234834f8f.0
        for <stable@vger.kernel.org>; Sun, 31 May 2026 20:59:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780286341; cv=none;
        d=google.com; s=arc-20240605;
        b=WUcPqtDpg4a4Qt7Sj81bDig0kFl775KuC1xM6Sk1pU7EsalxiG84t0mjHcuYMOfDDA
         LJ1N35GMlODyj930xPokUnNUWUneL4LWhqJ+D3pQLypUqMg6NUdJjX4eArKQnLWhvcYR
         UTDL7/DFMOaXCcX8UX7edW0imYZM8RJHjBuicbPzoAdjo2X64ComyFRD8K21xvSFlkdW
         tJlkmd9iMV9EJmtl6N0A8xrI7Jqvy8KYkjk3It5tYEH6foNyrAdoxDiBjTQLykHPxRyc
         NjoPe+q4QO4k4S9wH/7BgEUJBiEKYsQHVPNSGLxK56Hg4t/ODYUBTJkG7U04vH7rb5At
         stiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jNudWB04Wpw+ZJC/nF3aN5jO9/6RuxUwPuu638+/KJo=;
        fh=uwHJwcM0u7Cas0qNGb1gTHW/KqKCs+FOfugS8C/hlS0=;
        b=TaPg3oLjbYfy1Hik4UBG9DL0mLHGGsWk7uXEWWk+8U4nDZwFTsD4EKu7Fm1+DH44Kq
         SiNPUx9p1KGiCz1cXeLo+JAXw6Zwz6EudVc5j3ZcAZjDFqDzuKAS72VmQ2P0E7KSsL7y
         SBzxl30gipVDFg2Dh5jsZzXsqVPjGqs5yJ6ssioOxU7L/Yk8YjEkxdB4VZnGqBxIXP9F
         WpYrlzoOBZ21lsF5o6QZN0v9sdt61KZcSATbnG+ukjxxcyhVu6jeRuPZ9WTnLzgFOlGa
         xe6aeVUsZ17idQgDHofUwvUcTuyN5M1AGB+x/IPdeECnDXwi+H8p8oupPLXByZU2nHa+
         Z4PA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780286341; x=1780891141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jNudWB04Wpw+ZJC/nF3aN5jO9/6RuxUwPuu638+/KJo=;
        b=Fgqc1Gu/Xkd5+sMJsaLzfKOZjEHXvGArgaq/+X1LKPNno+gEfoWhSrTTHoUE1uodah
         I20jX+LU4P6h8rnN/oU7jfVjVeBsRu6jx2Bu1B91SvQfPUPf8HTuQh7/KlmGR69/GEVj
         FV4f9fQdbH5FLsZn+E6oEHu5nWVyLRQVhMJlUByS91aMMxqTOtspdEbRMQlqw+DVpxP3
         2JzR/jEW39qD/bm9nvPsfKBsW8eFSMh8AEbWKB0hfPYYI/MWghSv4j/iZvreV9RBg/2+
         tQ95HFqEKdFG7WjdaidMpS+tS1UMulSPd3GswQJIbVS9vbQ3CRk2zb3S+xpkTHRiEnNv
         WCDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780286341; x=1780891141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jNudWB04Wpw+ZJC/nF3aN5jO9/6RuxUwPuu638+/KJo=;
        b=sYUKyB0YqlQ3Qcf4x8NZd+BnomgXDW9+CcBm9+4As0oVUqCb4oNeK1dR0oFJ21gyjT
         bixFNMxb1KqVKX9PD3RTJRJfmaAlrqnGPR+2DFDFtv1uh7II54DF9M+knoZKLdhV4K1A
         In7eMwyASvDO+5ZCnNkcPBRjVtKK71eQwZdTGqpsRxPhKrblT1RNTJeNKcFdPBiicnlN
         y33uV1ms/B3R3ET8ZLkxxyRHhQGWgjoyw2Kk/QXcWnLF2q6qtm0LN6KfVZSIgirluugR
         +Dcgh4gp6O7p6yMhcNnWmkf2pMAJ2s01jyiP/55BTrP4qvA52rUe+RJjsi2rJ/J7zT3X
         G4ZQ==
X-Forwarded-Encrypted: i=1; AFNElJ9J49J7UWKAn+Xtf9adYsNzj2ZxiBJhvQeN9Xbbh2mRxOP05z62mRZp/oce4EqQ3A95qkHgMIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqRAqVCadCDK/mL3ma6s/eZj2cVpCKomrxpEFp45pAIJ1cQhdU
	woIMeGpyiwVa95jcMc8rjnY0LUXjixf972XWTofWEdrBqdJndqsvHtEz3K3hpbieoK684xnwSYS
	3tO6in8cmi8OYzKXHyuAB+JCpkPhmmRs=
X-Gm-Gg: Acq92OHaqRR6wfHlkgtQlPkG+yag8p50LSrIwoyTozoy7W6EwuC8hOGpP4xsM+udDyL
	902iIIOJkfgXLb3nKejy8+8sZeve3+q1u1ylc+HDtAb6kV4z0S0PPLtia0FOq6t0f49OLnBToWp
	D33Kfy0gZRYsl/UbsPi0ZxrxRtEg+4W5LNaUdWjiDsiUjFv0KN/1aRSRR8Kk6BWrigpH7NexBK1
	vJ8c0fXTGU78/xYiOwkh7AZVGvGNpex6aeuJE/7bfq56Ka+habKxGoxvi63m5B4FR4jjkaxOR3i
	VSlNZqbBpv1zVA4w+TEWUqnWyzD60C8jHxnC2psBYzrm6qBbgvsnfsO88OK58Poigrn2wjfdt+e
	K7Q==
X-Received: by 2002:adf:f78d:0:b0:45e:ed7e:f8f8 with SMTP id
 ffacd0b85a97d-45ef6b0231bmr12455650f8f.8.1780286340409; Sun, 31 May 2026
 20:59:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601030649.2513937-1-hushijia1@uniontech.com>
In-Reply-To: <20260601030649.2513937-1-hushijia1@uniontech.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 31 May 2026 20:58:49 -0700
X-Gm-Features: AVHnY4K4C1soJyFxmMVHHhTiOD884427RYesf2FVX6XxkT8y6UJ_fmjeCZLuc_U
Message-ID: <CAADnVQ+=-UM-JC4eM=vqvgK2tLt6PwmDjOcrrDG9kz8BV6n49Q@mail.gmail.com>
Subject: Re: [PATCH] fork: Ensure copy_process() returns a valid error pointer
 on failure
To: Shijia Hu <hushijia1@uniontech.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "David Hildenbrand (Arm)" <david@kernel.org>, 
	Kees Cook <kees@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, LKML <linux-kernel@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, LSM List <linux-security-module@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, stable <stable@vger.kernel.org>, kernel@uniontech.com, 
	Quan Sun <2022090917019@std.uestc.edu.cn>, Yinhao Hu <dddddd@hust.edu.cn>, 
	Kaiyan Mei <M202472210@hust.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 31, 2026 at 8:08=E2=80=AFPM Shijia Hu <hushijia1@uniontech.com>=
 wrote:
>
> copy_process() returns ERR_PTR(retval) from its error path, so retval
> must be a negative errno in the range [-MAX_ERRNO, -1]. Values outside
> that range produce a pointer which is not caught by IS_ERR() in
> kernel_clone().
>
> This can be triggered by attaching a BPF_MODIFY_RETURN program to
> security_task_alloc() and returning an invalid value. copy_process()
> treats the non-zero return as a failure, but ERR_PTR(1) or
> ERR_PTR(-MAX_ERRNO - 1) does not produce an error pointer recognized by
> IS_ERR(). kernel_clone() may then dereference the returned pointer.
>
> Normalize unexpected values before returning ERR_PTR() from the
> copy_process() error path. This keeps the fix local to the fork error
> handling contract and does not change BPF_MODIFY_RETURN verifier behavior=
.
>
> Fixes: 6ba43b761c41 ("bpf: Attachment verification for BPF_MODIFY_RETURN"=
)
> Reported-by: Quan Sun <2022090917019@std.uestc.edu.cn>
> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Closes: https://lore.kernel.org/bpf/973a1b7b-8ee7-407a-890a-11455d9cc5bf@=
std.uestc.edu.cn/
> Link: https://lore.kernel.org/all/20260411163556.8567-1-yangfeng59949@163=
.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Shijia Hu <hushijia1@uniontech.com>
> ---
>  kernel/fork.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 8ac38beae360..40bfbdfffbdc 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2599,6 +2599,13 @@ __latent_entropy struct task_struct *copy_process(
>         spin_lock_irq(&current->sighand->siglock);
>         hlist_del_init(&delayed.node);
>         spin_unlock_irq(&current->sighand->siglock);
> +       /*
> +        * The error path returns ERR_PTR(retval), which requires retval =
to be a
> +        * negative errno in the range [-MAX_ERRNO, -1]. Normalize unexpe=
cted
> +        * values to avoid returning non-error pointers to callers.
> +        */
> +       if (unlikely(retval >=3D 0 || retval < -MAX_ERRNO))
> +               retval =3D -EINVAL;

This was reported earlier and there is a fix in the works.
This approach is incorrect.
You have to fix the root cause, not the symptom.

pw-bot: cr
