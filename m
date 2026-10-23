Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792767064;
	b=CXTBwxEZQywRAAhJBLzVnQYr2GUwJULIXUd5s+szhE3ej9fyDHSU1poqIB8aK6+KTLV8
	 wQ+YRZDUXu91OfQwxgAuYBsLSESkjhsLgjlLn4I/OBxxB3bhpSEjf4kzsuAxMU1bEiqk+
	 Nn/aTTL4p+Fe/xFJFH97OF0gG97xxf2Z5F4ZpqchSWx1Y11XSTCaUV++PyvlDxsRdN681
	 ZAjVzrSBwDScvcrKlN/MUU0GyfDi8XFj1HOxBkws4VEn2sudjvDn+nhfVGx0FQ2BkPl2H
	 StJWFUrCgxFz6nlXrs5brvvinSOlUlo7+mt3DeIOmiDdd2zcoTVunMiOGSgRt41Stsg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792767064;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=uNpmEP5c8VeQ+q4DNjLNP6E92iAqlUq5JqczOkkWF1A=;
	b=1fUzn1Bnfo6LXPt6fUJucqbs8/Hh8zZDK3TvAZPMC0OwY/OZj993QFyIlsDtGvV1Jx6T
	 K9E9cnqPniaMNqwiKWih0TMCKnL0ioix9W9hGbXSgYCuTUAaLEmjuqp4/SbJfKSgXn/H3
	 ly8bIzeVdNG2JvNCFVL1nAfbKtmqOkV+5bS8U9iWOvTVNnYi/7lx7lT+zSd3dNDda4+mx
	 yFxoi3WupTFEx59yOana8nNzb824mCOhXlcZDUJMcWPkMfTYL1O674NLnRuSjOJUj6+dC
	 Q+AuVQfZs2/DqjuatBV3t1upyZw6Dzr0OrsbOzVsf9nUHgVry5/55DbEzyWqkYo26NA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=GaVKmESF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.47
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1DF606A325
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 14:50:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C1DF606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=GaVKmESF
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-70b875f6f13so592623eaf.0
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 07:50:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792767057; cv=none;
        d=google.com; s=arc-20260327;
        b=T9qxuOueuM/+l/IT35jHHX1yulDKXLtcuxx8Ngi1Z4zh7Mup/IHUS+v/7b8JWfjnpN
         x3R/GBnYlam2iZumrL35say+d7ll2nLz2j4kULEFF4KZZbcnEBjs5RGXoU4IxN4xgEoU
         C3/pCCKk73krt52FL84bRMC9IQeZ+NuhuoN1+qadi1tk/0etEzX9SMY0Rox/h3WNHJBq
         dwbj6o9qR7fykm0o3E5EWKbftuVkh98KdJ1Htkqin6/jWS5aK3NTlzkVkZfzmo1jJMtX
         ASe46L/Bj78YxBf8d/ltczfsZic4m0JMoLQQwoH1QDxmO1kaIdMzabCPHW8IMKm8GV0O
         Oa9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uNpmEP5c8VeQ+q4DNjLNP6E92iAqlUq5JqczOkkWF1A=;
        fh=MWcBJniz1+jXvVHg0jS3lli5mguyZSiomeUmhESjMTQ=;
        b=UPyv62FccAf1aE/tubbpTWPdC9V0sluoA3jMPGH2yUA9FTxvvdk1hi2efK/1k6533d
         YBr9eGxBZ4o7LErZmJeJmM+tQVNj926dG9H7zJLIUK8nJ9Kx+pcQ075qJWkti3UAjWcR
         xXQ055o3VvOtiyP6HcwjhNk4Jk7MTBNVqetKbF8GZPGQ0WOaUj3fn/mjNHvxNR/qHcZj
         TrIkNXIBmykCO5dqI9JUqrijWeSKHK1xDflE1f7UbbTZHSWXkWZ6xZrANauh+xc+IrPT
         xA4bF13gI+U5OkL7e1NW204z3cMb5Vb3YtM/cB0GJU6rH6iY+cjch0zgseWfgTdTv569
         FQ9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1792767057; x=1793371857; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uNpmEP5c8VeQ+q4DNjLNP6E92iAqlUq5JqczOkkWF1A=;
        b=GaVKmESFg5N9j7egEf2IT9a7ovcZ4RM6cg6Qoe9+MBgeCbGMonxypKFNiXl0yBunAg
         yddW8V6Zj5uCkRKYYeqGBALkbbHd4Hrwthd3Jwgv7e6iI/lEuuZPpK9myoToaV3tlVKR
         6dUjmecu0xH1DwNmf9U3PkgM+G75srRhug9rz2wpYVohkrTATIAp09wREw5ZdslshnDb
         WluH/R8/NLBWaHZUi+2n7X+JPSHAonvcLfRn2k/q6REujv7ucqtvzE7s6hlhKVgIoicN
         A0tErFasXb/hBR0O7cqgN8nntcWo/jcHTO+nC1CPzfpbjYzcEMT8V8nMoHpuhz1Fs1xA
         +2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792767057; x=1793371857;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uNpmEP5c8VeQ+q4DNjLNP6E92iAqlUq5JqczOkkWF1A=;
        b=J7gK2k4YjjFRcaLnt6bamQzPfZZ521dcxt4v3CilkN3PMuNunj0HLGchs8FppYlFy0
         HWVf6BiwdEiOQbaRWYY+8LO9o5Q4r24kx5PV5s3fd6oRPsGEPo+8Q5HsZoh4Qh/8/IzO
         hdlM4A/EJLA2X9hPgopDNvlKe7pZ+XvDoM1h2ESyuG3SXryfV4RGkrRZ4oevPNymAPgQ
         TMiWYr9xFM/QejKvj24OtPoY37we//9PcZ2B203shxsx1G1MFvef9OgDdJlAHVPDsonU
         hkySmdVrhdYw5jTNWIQXB2HztTqg+9KZKlcc1N//0pCxRnJPYedZ0XeHqK+MrQ2sNIcX
         Uzyg==
X-Forwarded-Encrypted: i=1; AKwUvBweUiIjHNQkq3w+YqhNXMLSKj8S97mv90bTRsOSWjqwsIr7LG6eX7BhaqQ/o67SkN7ThnQP3Pk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLXnbOeCkIYXmpNwUkKgxfziCjPVI+Mji/qlwYs8/Wx+4YbjQOQ
	kDa0i2SYDt37/JW82I8GAntRmNbPVXPt4D/nmtk9HJ//w3QNoo/ee1/8gloRF2iJIH4GrbBCGXr
	rRg1AcQ5iPvKwkBCLo4dCUiGGh9VcXYMfkQg8Z2JTeg==
X-Gm-Gg: AYBFou1mtyDNKN/d+bPGozq3A9QkEzd7UzlR5nJhPiIJJ6OlFEMZFlEXJw9odOxM4To
	5Wxxn5+Xm6C/H/5nwc4Jz5OX1yrU7UL4PYeLeLnd9IGrFliXwtSMKgiEoRITGU9Eg7GTmQKyItm
	2i0I4u8NIpQce3FYxgbd4NHkR4yCrDSZoxFcInXIlc6kh67DECV8UL+OaXoJOkCSgkdfUhf7x7q
	Wxqhhye+1gdZKrJ6669zYBN9tKratyBoSGhdcAG5/d0OEmYKQD9NaiOPM5BgsDEy/5Mfdk2t8hv
	+3eT4/Glp+BpsCe2FF+2uazfz+31Ks2AxOUIU/S9kM2TX2Dr5epoajXFxNbYIcV0EvbTenBNxrr
	KZaTn5HoCJKpjH2amVODdGkiURFFvmLc0DoxtAgk=
X-Received: by 2002:a05:6820:8597:20b0:6da:29e4:35b1 with SMTP id
 006d021491bc7-70b88a1cc11mr1189394eaf.31.1792767057470; Fri, 23 Oct 2026
 07:50:57 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022083212.84721-1-cuiyunhui@bytedance.com> <atqL1ScMLUg2bM_E@Tao-Chiu's-Mac>
In-Reply-To: <atqL1ScMLUg2bM_E@Tao-Chiu's-Mac>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Fri, 23 Oct 2026 22:50:45 +0800
X-Gm-Features: AclHuK-Du3zkiCNN0XfX5mHWLP_GAo3ZNGA4wWa5MNg3SjlqsiC6OFMlcOn_PSQ
Message-ID: <CAEEQ3wkS2niNwzS25jhvT55fSDWF_anYkLW5PZS0MsvUOq2vBQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] riscv: Fix SR_SUM leakage across context switches
To: Andy Chiu <tchiu@tenstorrent.com>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	zong.li@sifive.com, wangruikang@iscas.ac.cn, debug@rivosinc.com, 
	qirui.001@bytedance.com, guoziyi114@gmail.com, samuel.holland@sifive.com, 
	ben.dooks@codethink.co.uk, cyrilbur@tenstorrent.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Fri, Oct 23, 2026 at 6:19=E2=80=AFAM Andy Chiu <tchiu@tenstorrent.com> w=
rote:
>
> Hi Yunhui,
>
> On Thu, Oct 22, 2026 at 04:32:12PM +0800, Yunhui Cui wrote:
> > __switch_to() saves the sstatus value of prev and restores the SR_SUM b=
it
> > of next with csrs. However, csrs only sets bits. If prev has SR_SUM set
> > and next has SR_SUM clear in its saved state, the old SR_SUM bit remain=
s
> > set in sstatus.
> >
> > This lets next run with user memory access enabled even though its save=
d
> > SR_SUM state is clear.
> >
> > Use csrrc to save the sstatus value of prev and clear SR_SUM from the
> > live CSR before restoring the saved SR_SUM state of next. This keeps
> > prev's SR_SUM state intact, while preventing it from leaking to next.
>
> Do you have a way to trigger this bug on existing code or is it the cae
> where the bug could happen but we never experienced it in real life?
>
> If I understand correctly, this can only happen when the user access
> routing volutarily makes a schedule() call mid-flight, or a code fogets
> to turn off SR_SUM right after an user access and has a live SR_SUM when
> calling schedule some time after. Both case should be a bug as SR_SUM
> shouldn't live in the kernel code that is not doing user access.
>
> A trap-introduced context switch would interrupt a code that have SR_SUM
> set. However, since the bit is cleared at every exception entry, the
> context switch code would not see a live SR_SUM. Seeing the bit set in
> this case means something is not turning SR_SUM off properly.
>
> I aggree that this is the better way to handle SR_SUM in a context switch
> but attaching a call trace or stating that "We have not caught this in
> real world due to ..." in the commit message would be appreciated.
>

I don't think we need a "better way" to justify this. This is a bug in
__switch_to(). One possible path to hit it is
user_write_access_begin() ... local_bh_enable().

Thanks=EF=BC=8C
Yunhui

> Cheers,
> Andy
>
> >
> > Fixes: 788aa64c01f1 ("riscv: save the SR_SUM status over switches")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > ---
> >  arch/riscv/kernel/entry.S | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> > index 61b7a77166971..628b85e3915a7 100644
> > --- a/arch/riscv/kernel/entry.S
> > +++ b/arch/riscv/kernel/entry.S
> > @@ -443,15 +443,15 @@ SYM_FUNC_START(__switch_to)
> >       REG_S s10, TASK_THREAD_S10_RA(a3)
> >       REG_S s11, TASK_THREAD_S11_RA(a3)
> >
> > -     /* save the user space access flag */
> > -     csrr  s0, CSR_STATUS
> > +     /* Save and clear the user space access flag. */
> > +     li    s1, SR_SUM
> > +     csrrc s0, CSR_STATUS, s1
> >       REG_S s0, TASK_THREAD_SUM_RA(a3)
> >
> >       /* Save the kernel shadow call stack pointer */
> >       scs_save_current
> >       /* Restore context from next->thread */
> >       REG_L s0,  TASK_THREAD_SUM_RA(a4)
> > -     li    s1,  SR_SUM
> >       and   s0,  s0, s1
> >       csrs  CSR_STATUS, s0
> >       REG_L ra,  TASK_THREAD_RA_RA(a4)
> > --
> > 2.39.5
> >
