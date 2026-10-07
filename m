Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E663446073
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 22:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791413380; cv=pass; b=a3PrXgxF0Tf/Xdf6QL6tDeY1IsDyp4LTNETXZ4EOtGNNsuK+m4EQbO9NyaBLwyjoR+oUFJ3jhZTCwcchhCXxUbBcVNZPvQC59hIbsn3tb7X20VnxD1wcLJcIHXnQGWVkYUCTAjFUngS9b1Qz5vL5bKp7VVUiR2ksusiNc8X3rhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791413380; c=relaxed/simple;
	bh=ueCAdNXKfuApdpHhwX8s1J3H4MHF9wnTt+I0E6rVefA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZNK08XK2EvXvaqsCWfp1KeZKTcgqHUo6qPJCUPtHLcW+B3bNEKQY0wJXhcuafah1sm3JLPIEVo6QXvfBv6/4z0adYritFOA3HtWeskbpoXOiJnwmSHgLbw2RaVELC+2SCEih7sWxLsjoCQgaCJjmrhPLnIVO02GmE6j49L0KE90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TJwb2LLC; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TJwb2LLC"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a018493d57so24305e9.0
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 15:49:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791413377; cv=none;
        d=google.com; s=arc-20260327;
        b=gM8h/5iYCm0tDelfFQ4VoNR73EkZ0D9GUG3PsixZjJBKughx/in9HsLOTHf43+3rVm
         WWa2m25YdSgM95gs34yVGezqMVMRI82+vJl1FKqdPHvRnWM2O8UMpSA5WJ3qkW4QWGd3
         DbFZTGq5fSqJNgSE1lxrre+1f/cPrBBTja513/jDJtGUSXpDibutlJcr5tkv4W0B3Pue
         4cvwXRg3N25SSyXTCXg/JSNtEa58E+q2fttX5Cp637kCaxKUBFGeJCjdE519Nn4og6Nj
         EKKCiTzLOdcVH+JF1E4bgADlzj5SgzQp3aqMhWixOAZxI7W3VmmO8aERANJ++6PRMSIa
         F0fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U16op2Ui0JYvgEISwYX/iyuFKgIG9pLc1vhaX2SV2us=;
        fh=No3+lawRzJHMxVPXeVokDCHQACVK9/FT8hPBBB7N1O0=;
        b=CmSn86Ys3nJ+o85g7LgNhxwzvhLR8RkPZlwsv8F1zPyxj/pFpGRU1YrzGG1FL2yXMb
         L5184XAlOIJdjoNvnkby6IyrN4osAf5aZU95Z4cXBOTFvfKSjsOdZXV6tfmPPJMf2lOb
         ZpUcNxsf57+c9cWP5PN9Ws3W5HPbnfkTqBD8ls3uGj3w09dR7e6Nc7dyFHQUjUCSEkel
         QjD7CUveUOPL3vrYB9uw7bTBeJ7A4DtvsPhQbUON8B+EFRPHdCD1tm19m7ou69ltpTP2
         8Es/QnEhqVSA1SnPdB3eD4dLQKxng7QULcMlSY540VA/IfSZ9l5TWDC/UKXGz2GuUodM
         8aCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791413377; x=1792018177; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U16op2Ui0JYvgEISwYX/iyuFKgIG9pLc1vhaX2SV2us=;
        b=TJwb2LLCpCpayGPJIWk69Jbnt6FTIdrcTTjq1SVBhAefZ05nq7NU6FIclCHxoWt0XG
         TTPoV5di/HXCOme+XWgC6+FbwptRbT9uLwNssyOzVyXiEZ3bmFwahdxl/hLITqiS6sBr
         KdfMMTuitA6GO1eCyq3kxqX8Z3vAYg0eyAZ0VHVcJc/xh+v9KOYoipYeFNi+If+7Pqyl
         Wfp1h9+RCkdBDnWKUsQJGLXsnmN3mTSWNuhjW1YQI+yeDeX/Eb8xqNQdhB0TJrD5dPGW
         YHQZk1TBLSBxaxbMUSvA6vLJ5MRXiMAdsHuq1Vk0JZ3Is2VSYCYeIVepg+lRoAqz4bfC
         4pjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791413377; x=1792018177;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U16op2Ui0JYvgEISwYX/iyuFKgIG9pLc1vhaX2SV2us=;
        b=O8kCrmNlalB7OzCSmVZ6vcvX+mR+058YIktponNoNGw73Dcwo943pM/NhWicdAjzyk
         6wo3S+snvaC6lqWMW+1b9sQvWEXWN9piUX/pY97flvQrZd/bUWM+nvyll89G8TVG7NGF
         kWifIsMN7ZNLvdHgdvHRceyvA3AjVoklDLGDNmVls6pSkvcYuBxy0VIoy2GTscRxbV6e
         W2b9Dy8vIaIZgGauq6ZG0Kb9iqqKT7Zj1tnKInF2cXq6bXoSs+v8Cdmt29vtf4HNEFc7
         lKqOu/zm3vgp2yyPrQJ+9jSv/g6g1wBJbQhHZV1p6WfcnD5DGpE0v1zCnYb+0Bv0ATAr
         gEgg==
X-Forwarded-Encrypted: i=1; AKwUvByHl0V/oxDCVE8TJj2osLuAE1MdQb2J12ba0TwJTmxF5cUjCdHPz4bCejDQUrgeUPO3/giIjzU=@vger.kernel.org
X-Gm-Message-State: AFuF++nQu3fwyGJLJfSLIrqctO+UINM9FtBtGHf5M/8zUodlOB2Fx9oS
	CK4XTulKXaK2VSB7suf9MjGrComNZdcFzq2pvBT0gteYEm+tSFfEIe4GFC7E+6sZM77Xv81tDQh
	S3FdaAs99iuyCm/YSvcU4Rdh8s+qznuBqggefu2yv
X-Gm-Gg: AYBFou0QENWjx+qyolPwJYp44xYn62EGBlA6M8HjaeBruzKVewDFY5lyfVe1BZbh8RB
	gFJEpYmktTUj+DFJKBtmkc/qg37FyrzIZlXO6KtmPH422+adOFgv6Vm997qSYtrL+A+mCZyqWJ3
	0ALgo0ZCTHstl9f8JQ1Lei5KHhHpJwg7EwAcVDoSw4Wdu3xX0Sx1iMfjmZWGCjxX9Vb+RqkEnpU
	C9VSVcFYeupGf4I0oCfSOBSthWi4rxZsT9yTY82n/8E2nqvEBjslCLYD7auiCujUGyMow9Sz77O
	PFgWayciIzcL9R/8I5g1LJTijkdLNZLNHmHBmmhQ4mYoFdfts2wT
X-Received: by 2002:a05:600c:2154:b0:49c:ff18:79bd with SMTP id
 5b1f17b1804b1-4a18591a665mr105865e9.9.1791413376953; Wed, 07 Oct 2026
 15:49:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001135711.934152-1-guoziyi114@gmail.com>
In-Reply-To: <20261001135711.934152-1-guoziyi114@gmail.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Wed, 7 Oct 2026 15:48:59 -0700
X-Gm-Features: AclHuK-OHjmAc40mDjPz8eYhHrh9Q8RxrfmmtdzMZsmdMbZL56s7kGmmUzZWIM8
Message-ID: <CABCJKuf=ExB_=Qwowtx-jtiKG_ZXyqPkxK09maGjReUZs6EP_w@mail.gmail.com>
Subject: Re: [PATCH] riscv: entry: gate shadow call stack reload on
 sstatus.SPP, not tp
To: Ziyi Guo <guoziyi114@gmail.com>
Cc: palmer@dabbelt.com, pjw@kernel.org, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	wangruikang@iscas.ac.cn, debug@rivosinc.com, conor.dooley@microchip.com, 
	namcao@linutronix.de, zong.li@sifive.com, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 6:57=E2=80=AFAM Ziyi Guo <guoziyi114@gmail.com> wrot=
e:
>
> Under CONFIG_SHADOW_CALL_STACK, handle_exception() reloads the kernel
> shadow call stack pointer (gp) only when the trap came from userspace.
> It made that decision with scs_load_current_if_task_changed, which
> compares the trap-time tp (read back from sscratch into s5) against the
> current tp:
>
>         beq     \prev, tp, _skip_scs
>         scs_load_current
> _skip_scs:
>
> tp is a user-writable register.  A user task that sets tp to the
> linear-map address of its own task_struct (&current) before trapping
> makes the comparison succeed (can achieve by brute force with KASLR
> enable under our test), so the kernel skips scs_load_current and
> keeps running with the gp that userspace left in place.  Under
> CONFIG_SHADOW_CALL_STACK gp is the shadow call stack pointer and
> load_global_pointer is a no-op, so the compiler-emitted
> "sd ra, -8(gp)" / "ld ra, -8(gp)" in every non-leaf function then write
> to, and return through, an attacker-controlled address -- an
> unprivileged kernel arbitrary-write and control-flow-hijack primitive.
> The poisoned gp is saved to task_struct.scs_sp on return, so the reload
> is skipped on every subsequent entry as well.
>
> Decide "came from userspace" from the hardware sstatus.SPP bit (already
> in s1 at this point) instead of from tp, mirroring the check that
> ret_from_exception already uses a few instructions later.  SPP is
> written by hardware on trap entry and cannot be forged from U-mode.
> Legitimate behaviour is unchanged: user entries (SPP=3D0) reload the task
> shadow call stack, nested kernel entries (SPP=3D1) skip it.
>
> Fixes: d1584d791a29 ("riscv: Implement Shadow Call Stack")
> Signed-off-by: Ziyi Guo <guoziyi114@gmail.com>

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami
