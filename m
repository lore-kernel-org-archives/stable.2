Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4193D9DCB;
	Wed, 10 Jun 2026 09:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781084609; cv=none; b=kR0697XlKguU6g9VTbrPSZYVXQWOG8hJFCooiEAud6Sb+LrKH2y3nRULAXnj1z6Lb9QWU3lI6eaUOH9m0zzagRuq6dkDCqFaT04eKaYmInqHGXon/IvtmFiW5mmU3X7YF10UDxovuiYSGs/zC3RtUvYR1acL2KRdt/2lXD4GJq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781084609; c=relaxed/simple;
	bh=IJBwPmQY5Ds80ge09B85RTW8y7eglgINAmM6/+V5aSo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=P+IPEbLXhNn1RCd/kO9D/CGOC/WbS9dnVogNtBE4bWCA/YyheOZQymV9WbHAQ6IE//FO6Ml1OtGyHFFCVM57DVE3kUxZ1iUSOObXH11Y7V5OjM4kurM0gYY0MLYXQqMsZvVAJ8QOspEeuS1qMhrMW91eho4q/AqfwsEwOL68d6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEqH8LJK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEqH8LJK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B254F1F00893;
	Wed, 10 Jun 2026 09:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781084608;
	bh=PY9S597pltiIS4DOesWSWpeMRyCq6V7eq4ymyDsyJCI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=cEqH8LJKd8OXnuiqYSvjfucD79mc8KdvhQnGzmNP54iE+sDGP5/76szASZUHQ6PLW
	 Iw+QyPyYmQ4FjdoEOA8F6qOp3tIYidVb5+pFquUFA9FD5IHiNbyMtOLVCiFgqI87Ns
	 yLKEyzXCLQByQAtgek+GaPTZRsIj05eoi/ecwi/UqMYP76SPjwLEaaLuCYK6Wtbeeg
	 oGdTs7mxP9wx6b+DN1qC4Peb+nG6FD+uBPI4qoF8jXfSOuUzyUZKFBmHzAEGFQARa1
	 I+1CAloIDdlKp9T0MicPWvfJwUH+LGfM82z0lXUkLmt9/z+qr9+gnDntG+JxOqEEFr
	 OC7BkzfsuRNEA==
Content-Type: multipart/mixed; boundary="===============5374219254305281125=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b45a6ddc670d998b1459004df9d6a03ef6754cf963417bfa764ca0bbc4716321@mail.kernel.org>
In-Reply-To: <20260610090431.32427-1-gmonaco@redhat.com>
References: <20260610090431.32427-1-gmonaco@redhat.com>
Subject: Re: [PATCH bpf-next] rqspinlock: Fix order in raw_res_spin_(un)lock_irq to allow schedule
From: bot+bpf-ci@kernel.org
To: gmonaco@redhat.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,arnd@arndb.de,bpf@vger.kernel.org,linux-arch@vger.kernel.org,linux-kernel@vger.kernel.org
Cc: gmonaco@redhat.com,stable@vger.kernel.org,longman@redhat.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 10 Jun 2026 09:43:27 +0000 (UTC)

--===============5374219254305281125==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqspinlock.h
> index 151d267a496b..4d46643f46cb 100644
> --- a/include/asm-generic/rqspinlock.h
> +++ b/include/asm-generic/rqspinlock.h
> @@ -243,12 +243,20 @@ static __always_inline void res_spin_unlock(rqspinlock_t *lock)
>  	({                                        \
>  		int __ret;                        \
>  		local_irq_save(flags);            \
> -		__ret = raw_res_spin_lock(lock);  \
> -		if (__ret)                        \
> +		preempt_disable();                \
> +		__ret = res_spin_lock(lock);      \
> +		if (__ret) {                      \
>  			local_irq_restore(flags); \
> +			preempt_enable();         \
> +		}                                 \
>  		__ret;                            \
>  	})
>
> -#define raw_res_spin_unlock_irqrestore(lock, flags) ({ raw_res_spin_unlock(lock); local_irq_restore(flags); })
> +#define raw_res_spin_unlock_irqrestore(lock, flags) \
> +	({                                          \
> +		res_spin_unlock(lock);              \
> +		local_irq_restore(flags);           \
> +		preempt_enable();                   \
> +	})
>
>  #endif /* __ASM_GENERIC_RQSPINLOCK_H */

Related issue in kernel/locking/locktorture.c

During the v2 review discussion, the Sashiko AI bot identified a
pre-existing bug in the locktorture module where return values from
raw_res_spin_lock() and raw_res_spin_lock_irqsave() are ignored in
torture_raw_res_spin_write_lock():

    static int torture_raw_res_spin_write_lock(int tid __maybe_unused)
    {
        raw_res_spin_lock(&rqspinlock);
        return 0;
    }

Since these functions can fail with -EDEADLK or -ETIMEDOUT, ignoring
the return value allows the caller to proceed into the critical section
without holding the lock. When the torture thread later calls
raw_res_spin_unlock(), it will cause an unbalanced preempt_enable()
because the failed lock acquisition path already restored preemption.

Furthermore, forcibly clearing the lock state could unlock a lock
legitimately held by another thread, potentially causing lock state
corruption.

The same issue exists in torture_raw_res_spin_write_lock_irq() which
also ignores the return value from raw_res_spin_lock_irqsave().

Should these torture functions check the return values and handle lock
acquisition failures appropriately?

Reference: https://lore.kernel.org/all/20260610091602.318C01F00893@smtp.kernel.org/


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27265934925
--===============5374219254305281125==--
