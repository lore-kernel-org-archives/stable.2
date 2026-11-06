Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793967170;
	b=Tw5F+l7CITLd9CljhIfCaUkCKFh/6IPrNZsMCzJkXSFfLbwRR+rBHZKp8CC6IjoICPay
	 +r//A3X5ZQsM6ManhZQaLkkSrmYybjPfLL8kALH7NoontUQ+vAdYVc9lUAlNPGDGodiRM
	 pE28WCvrMey8WzKkTy5Ev45/8xfOSsCLpDx+AX34glJG1cP993Y2u3e42ATQKEsfT/bt9
	 5KNsjyaeCMNleemP+75AAypXcQDagf1phmibLpPa6TU4m2nuWtkoFFpuUrl/3RKaRipI1
	 EvpAaHgpqNsKffA7JrS7ezRo0X+FS/k15ZzEW/OLwZcr4av7nsFf9dXIBVxBZD7dyCg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793967170;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=x1/cuWPUTv0vs8CRRmZ6/x/mFtko9mxhwsi/tFyavW0=;
	b=o+VQAVnDlaptmnZQpOhS05O4oWhttMWS8XjTQyetcVktZ+sQqL1DVPWZdt7s9GsYiylN
	 hnU6yMai+t8tzy/1+9J1KZ1grSA8JVCH86El5pg+yAJgPo02p3NllQkVGQvF3j+54SCHR
	 uKmcagWkZVKBKENQmZur0tP5TNPHNtXQ8ac46x3HSmgm1v7wc5eQFT2ztg+1kC4VKfufp
	 Vi0EgMwAO7S0BEiKCNrmHCpAyQGqT5q8xtpqPXTyYb0efZbvDnoOpDmWxBFLa/zsmCr9h
	 dCAY+3zF+ofRRkRkYSN0fzg3FyaWyHgEr3qDohH3SURs4DCqe817R5/V8BjQzk4JN4w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xDYrVneH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2B8606A333
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 12:12:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B2B8606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xDYrVneH
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b6e7a05225so511038a12.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 04:12:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793967169; cv=none;
        d=google.com; s=arc-20260327;
        b=QrfGHepKtDQeImzaLnaMoQDTIMQDGr7XIKFQK9K82gB06Jtp4pdkiNTW5agXQuIU6S
         oUlPkF5qqkxqYpkMf6XcYZpRlPPv4LhvqShaiJVotRcKWgLjFEpi27Wwwdo+K3Vf5phJ
         CJD7GU4jMUuWlJbbBANfprrjGr6N+DmEvOb1AMX4qKsSFlcdIKdIcfw0CoqY1C99PAxa
         vinx7YsKSVtu8CbG4pm0/Pz8kBzoE5ucHQLU0YkgmTLVdISC7rot26+/pUvu+cDb1EyG
         WWjDkmxvkCf1nYaRITipwy+htZ3xSZ2NwMk6AkH5i40JBNRxuTESK3oUhHBhtCXZNizX
         BtGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x1/cuWPUTv0vs8CRRmZ6/x/mFtko9mxhwsi/tFyavW0=;
        fh=KVBiR/4iS3BzN1kvf0JG2j9AYl6TduvqBzx0Zrybr9E=;
        b=V47kLbzhe/i7ljT0k9P8qInUe/8aEeKAiOgvFuzLn2zuiuZQaWHzhlLYFV2HU7uZW6
         68waKz71HtVQmCrAcu2WaxbvKmhrIPFlVI67WebCuMu6Sa9nyI9tn1m9eF/VX9Qtap06
         7qR9hYC0bpHayinv9yxk1pTN3beFCYqJG6CcEf+xa88HdindWkHiLUUlq7MvS80V0K67
         dKnVXM2PDln4oBHYg+8TVvs8I5GtpywSYFnqkEWKo+kA0Rnbfhw3f/R53H2yR4epA7gx
         J8ogS3bSmUzMoo/BJL23/ib1xAEBp1WagGrt8hru1/iAii77zXQg8LMuCapMBMrvPbc0
         KE2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793967169; x=1794571969; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x1/cuWPUTv0vs8CRRmZ6/x/mFtko9mxhwsi/tFyavW0=;
        b=xDYrVneHd9NtSZJg0aPJWE2CrXqH1XhMoEBmuZu1Aq20xV6zyQmbDXClWwhR5sMHH1
         RifzHNcrt9zUYGkUN0udrQlRIcs28wCcQZt8AY3ZsXmNAG0m1KfOViGsnbgKseghiwis
         OEoziMx0kBGsIQWK/5GDVyMw6GnwIKEBEQhZ0m4L5moDCZUpWRoHJNOg+xxtJEDD2VB3
         UK1PBd+qffmb0RXq92LwXbuXDPw8lios74hyBidrpWWaeOsqVwEIpaCKo2sLUtO5OQxo
         1zL0DGnTQcMTY6sYyHvCqLGEe0kev4324IiqG1ZzM7ttp2pJK1cr86cPsszoMSCf4Z75
         cG8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793967169; x=1794571969;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x1/cuWPUTv0vs8CRRmZ6/x/mFtko9mxhwsi/tFyavW0=;
        b=oObGfFIEvMzq/uRXw8WnSFt0TSpT+25d7R+PUH3GKPLRZf4gJ0D65ArSCuRTyTbJKP
         B3kclef+WyiVRP/KmLM2MoNZy3FHzcFf9595W4uAeUU28oc7qSHyAO15jfH92HNHhGU3
         La0KML7q44g064hCBX6xJ1Wa5BC9HaOqCjXipEbLqXyfywjGADcPZSXAC8r2oxbeJlge
         /aXM787zmAEgYxT45HYTPWjSA4+oG0xgRLU0ncPl/Du7eoZPm+7yDKk1D/fUcDA90kE1
         ozWlGTaEKZ7IvYnKE8PvbLZcnSQpb43okp6mJuknu4WwxrmMlqvl/rr7WAH4Hb64xiI1
         ihaw==
X-Gm-Message-State: APuU4Z9wJWMDQtsGZMKYPAxiKs2frrmXyxEOG+fHfFYLcFD08ARikHd6
	DuosgdzJdAW+mvN4PL5yBgBMR/zNuorkkLXXXm4D9m1Hnn2ZJAEsNp6CbSqtIhDJJAritgiKNW6
	u07Fbu+8GD7UM73FSlonFJqI+3l1HosI=
X-Gm-Gg: AYBFou3btagjW4oUWwIYFZWp75FsEfem9zcy0O2jfa3m+iAn3KvvKoF1BXkb5bu2FQo
	wXoy0kanHkKOB3S20GaqttXXtpqfc2b6Avgcy1pH66QSMgsxJ9xGGNEXcbTDx+xdmVMkd5yqtwI
	OU/CUquOe6nf4Xod7hYjjLQ3IxwKkdZBaZ3Fca/sjKvHtMgvLKibn1fGomyAmgf51C5CK0ewRDI
	/PcldVoAnvUfqtArI4wmpjPvsPxw8yiMpQAHC6EDVhrJkOE+S36qNemmbiaNoIIByFV4vVunoPv
	VL7Yugxuqf5YZQ+MesS7eabtxuBgtzJ357/fcaTuIjoYpNehF+oYJPa6u14Vh8je222+6PKdCKj
	bBVLokRUIn9WQ22V9+5sVEFv0+4Z5EvEs1G7SG4+rrQnThN0GVepVJXSG8r2Oo84iKLdFh1cHLY
	pYwhF2uylTd2SGEdyiXbg6Lg==
X-Received: by 2002:a05:6402:2708:b0:6b5:96e9:ae95 with SMTP id
 4fb4d7f45d1cf-6b5977c05b4mr1611439a12.10.1793967168580; Fri, 06 Nov 2026
 04:12:48 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105-alpha-force-success-fix-v1-1-8c26d60c5fff@gmail.com>
In-Reply-To: <20261105-alpha-force-success-fix-v1-1-8c26d60c5fff@gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Fri, 6 Nov 2026 13:12:36 +0100
X-Gm-Features: AclHuK-imma2RB3IIgOI8b1RYP__FJLRZ_l9IgLeNTSprdfcIZVW6dvD-NI_UWw
Message-ID: <CA+=Fv5RXzRvCwmzJ8FY8=fxmHCF1X6XAj=LtfbVD5gVJJxi1mQ@mail.gmail.com>
Subject: Re: [PATCH 7.1.y 7.2.y 7.3.y] alpha: honor force_successful_syscall_return()
 again
To: Matt Turner <mattst88@gmail.com>
Cc: stable@vger.kernel.org, Richard Henderson <richard.henderson@linaro.org>, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

On Fri, Nov 6, 2026 at 12:39=E2=80=AFAM Matt Turner <mattst88@gmail.com> wr=
ote:
>
> This fix is for 7.1.y, 7.2.y and 7.3.y only.  Mainline is not affected
> since commit 83bd31c2840b ("alpha: enable GENERIC_ENTRY") in v7.4-rc1,
> which replaced the saved-r0 check with a flag in thread_info.  That
> conversion is far too large for stable, so this patch fixes the old
> entry code instead.
>
> Syscalls that return data rather than a status, such as PTRACE_PEEKUSR,
> PTRACE_PEEKTEXT/PEEKDATA, osf_sigprocmask and shmat, call
> force_successful_syscall_return() so that a result with the top bit set
> is not mistaken for an error.  On alpha that clears the saved r0, and
> $syscall_error and $strace_error used to check for this and take the
> success path.
>
> Commit 55b22075f784 ("alpha: add support for SECCOMP and
> SECCOMP_FILTER") moved the restart syscall number to r2 and dropped both
> checks, so any negative result now comes back to userspace as an
> error with a3 set.  PTRACE_PEEKUSR of a register holding -1 fails with
> EPERM, which makes sandbox abort when it traces static binaries during
> Gentoo package builds, and PTRACE_PEEKUSR of a register holding
> 0xffffffffffffe000 fails with errno 8192, which breaks unwinding of a
> ptrace-stopped thread in elfutils (run-backtrace-native.sh).
>
> Restore the checks on both exit paths.  On the traced path the success
> path also has to stop falling through into
> SYSCALL_SKIP_RETURN_RESTART_GATE, which is meant for skipped syscalls
> and would turn a forced-success result of -1 into ENOSYS.
>
> Link: https://bugs.gentoo.org/985765
> Fixes: 55b22075f784 ("alpha: add support for SECCOMP and SECCOMP_FILTER")
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
> This is a stable-only fix for 7.1.y, 7.2.y and 7.3.y; it applies to all
> three (with a 16-line offset on 7.1.y and 7.2.y).  Mainline fixed the
> same problem differently by switching alpha to GENERIC_ENTRY in v7.4-rc1,
> which is too large to backport.
> ---
>  arch/alpha/kernel/entry.S | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/arch/alpha/kernel/entry.S b/arch/alpha/kernel/entry.S
> index 9f2608de2544..fe88cd598492 100644
> --- a/arch/alpha/kernel/entry.S
> +++ b/arch/alpha/kernel/entry.S
> @@ -603,6 +603,14 @@ ret_to_kernel:
>
>         .align 3
>  $syscall_error:
> +       /*
> +        * force_successful_syscall_return() zeroes the saved r0 (the
> +        * syscall number): the negative return value is data, not an
> +        * error number.
> +        */
> +       ldq     $18, 0($sp)
> +       beq     $18, $ret_success
> +
>          /* Restart syscall nr comes from saved r2 (preserved even if r0 =
overwritten). */
>         ldq     $18, 16($sp)    /* old syscall nr for restart */
>
> @@ -700,9 +708,11 @@ ret_from_straced:
>  $strace_success:
>         stq     $31, 72($sp)            /* a3=3D0 =3D> no error */
>         stq     $0, 0($sp)              /* save return value */
> +       br      $strace_leave
>
>  $strace_skip_call:
>         SYSCALL_SKIP_RETURN_RESTART_GATE
> +$strace_leave:
>         DO_SWITCH_STACK
>         jsr     $26, syscall_trace_leave
>         UNDO_SWITCH_STACK
> @@ -710,6 +720,10 @@ $strace_skip_call:
>
>         .align  3
>  $strace_error:
> +       /* See $syscall_error. */
> +       ldq     $18, 0($sp)
> +       beq     $18, $strace_success
> +
>         ldq     $18, 16($sp)    /* restart syscall nr */
>         ldq     $19, 72($sp)    /* .. and this a3 */
>
>
> ---
> base-commit: f2c53ea949c5048f96b3dbb5a5ee7131ce4ff2de
> change-id: 20261105-alpha-force-success-fix-6df76c50033a
>
> Best regards,
> --
> Matt Turner <mattst88@gmail.com>
>

Built and boot-tested on v7.1, v7.2 and v7.3 using Alpha QEMU
with stock Clipper PALcode, with one and four CPUs.

All 56 raw r0/a3 checks passed with the patch, covering traced
and untraced ptrace PEEK returns, including -1 and -8192,
other forced-success returns, and normal success/error cases.
Unpatched controls reproduced 32 failures on each release.

Tested-by: Magnus Lindholm <linmag7@gmail.com>
