Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793728250;
	b=LFlSXas7nbsiRDzmxvnGoTMkjB71kn9dqzbPfwFyPlGhPMwmvNLq2OC/vv+nMt/jNr/u
	 CNGgX/CHlKyRaUZum1CwSoM3MOD6z1V5d9fE/SmXcMfAPwjtoxiHHK0ucG1rOuXoRNtWe
	 ptUgn9EM3B9H6bGHph7F8vS9q1NbG3lXngmBX1T1l7mioD5l3gYCZoIPHeF2LCNnnJG4y
	 8q6jg5w+5ZNKCC1mxBa9x5B/r5szNYbj1GNVZFvxujX7wVjWOE3vCQeBBxoKvzCe/lsCd
	 pNQfbFVo/y0cqC28bHikuTJpqIX5xFKLW5S53rRluXbv3jU93YOixlGXJPF8gv08i4A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793728250;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=d98sL6dlVlb3fgyLP/grb3l4g2YK6zKiWi4X2zK7GoI=;
	b=qf9b7pjYg/8mS/l9dcZqgGJWtE5ENFrLpGZsfr7XHAW2Ef+iQVy7QK3muWfe5RD0fQ9a
	 zjCZTj3QgjOhAHMIjc7Gs5kPmwEvwEZyM+mT6D0FILT255TBf01j/h43SnPn9ChdSlf17
	 LICGDGLtMi8VvDNzZIz/y34+dbwe7hi6GkQVIBI2zODsjgizUqXAMxqtcutUm4IKqasKV
	 gQD+cGmwsX8zWtJyDuw1mP1+EiaU+I2P6kyjoJhZNAABp2KaTb2sS2AHQT5qWQXFi6C1P
	 ChhD0GdPbNTQsdAtmyn6pa9miWuYOOgtIkb8jYBbvEJBAmOwMily9HtI6k67tjSoe0g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XpQVXOcL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D042D606A328
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 17:50:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D042D606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XpQVXOcL
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a206f0b95bso265e9.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 09:50:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793728248; cv=none;
        d=google.com; s=arc-20260327;
        b=ibb2SdarCQMgxf2Bfdqjv8xaL3J0vXnegOdvfhRzaF0a9mHfshuSn6WRTIzyKMsIDq
         zKeUv+wpHZQgE+8UD3T3c8NvsaKnTLNK+Pw12+wCp2Tp4zrr8np6Zx9VlUYphgkbW2KT
         P4QMS6DFII8Vez2+tcTwfPpnHHt9IaIylb662NcnoAO4lh3wMzhZyJcQRuS57P0h3hyC
         9CuHXuUNBOgZnc6nA5KinpSw+45QwEWaO6jw+G9dPkvQ7eLCsj7uIvxpL1nxgEm/tGp0
         8nBE83geU8epoFGD/hGdVi3rJlGYVmDcrNVhzOn0SEnO+7/PIb64piMnFefBoopFcseC
         7Acg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d98sL6dlVlb3fgyLP/grb3l4g2YK6zKiWi4X2zK7GoI=;
        fh=YyrO5M8JQXxl6bapdl5voFAyTKTlDWSsgGVINBMun0s=;
        b=F4GVR+p7EDltm2wVyNReU/Tk4wshOMNj3C3VDK636d9fWf3Cw4F6FE/n8wvD2479O+
         HvK3Ff/9/TgC3w6zyDQtTTyjQ0DNS2QHgpEFmMRzLcrZH3sX2cTL+DTruvZ+lIm+QLcA
         XvoCJcPItoFAYj7I/pqIaFSv8dgkU0JlTFWzL9GO5+HVaKYaSTMlmpIXNb7WzEFN534y
         RdC7zO5my0+g6xyiwr6ZDAXcg1xCl7mGfCGqdYSU7e+guEiKUCgy9tRiBY66bF4/xLVE
         vq7QBrS9BHIwIFSuUTwzAfY7PznyLgXA47JA0xnh9LWYCcEcDqAtkDTOlF+DtFr6A/no
         EI5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793728248; x=1794333048; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d98sL6dlVlb3fgyLP/grb3l4g2YK6zKiWi4X2zK7GoI=;
        b=XpQVXOcL37Aial4LhGuOfR0x/2gg3577Qp0W5IErzF49hcILsqHfnlZIhWxzc9xddE
         freQ3VDpWxIjTlIvrQZIK9rTKyIs3pSgzCwJncK424hO3iu+wTIS1pN0KkXOYRbkjae+
         uN2qvvkEwNB6GadJf4vicUmTKOlvRyNo9wYkBwkqLSuvU7fhmUNusdz6HtlyGzudE1jF
         fWmIkfyi7T+z1fQHIy0ZYx+yRbCYwOFtipOBOSUxORH8VdGxBZ6q53Q0a+uxdkgtaYoo
         ffVw5+5Cf6ToVF2we5Gg9C2GmtEvwv8C2tOv57C247yyrwT6o0EySsQPcTaZrjPqB2fh
         nhGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793728248; x=1794333048;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d98sL6dlVlb3fgyLP/grb3l4g2YK6zKiWi4X2zK7GoI=;
        b=VPaXHHkThYz6Wc3ZrCTJg3Wo1uKe8yX9mZC8Dl4cm8+EcKgaKz1QnMcVnYhfUC4frN
         JXxgqn0PVTKD8jZI5r9lHX8LJyTeiX11JIDnvIOAUbA/nYW07UNdyewDI5UD56AmJE3c
         OPOOhZm7wIQUC/oyuLS6IgiPWQPZj+HMfalNuFigyC7/m2xEoW9oV3JJkSWybqp3ljWQ
         /gNmWmNpxHekFx5JYbTx+xG7kaimcMkyaG6ZiMaK0eKOpjp5pTgQTi6QRbjP1mULoQJ2
         5k19Y+MMt1g+wJ5kLBdHHMN+r5snNOhd4kcJs6hooPvx6gWoQW9Zp/EwHp9khUQy5D+k
         AbkQ==
X-Forwarded-Encrypted: i=1; AKwUvBw1j2hbTHXIpdeVUVLwkXiF7UX+if0pC6W36aQqcuLdRytvwSucphXIjC22J3yTv+a5Kn0kNYM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9M0mPuBVMqmqzMnLsH7LV5YwSNIuDTkVkc3Qt6KjyPt03LmSw/
	eDOi4rCROppaetILdCeNAw9akLcWLZBes3gClR6Nk7VGtCASV6J5hq/F+TT4B9QAvbamEvr+jUU
	MW4rdEUdbX7iXcOgdJVZwpm9OTAyoG2Yl5xfEuWnl
X-Gm-Gg: AYBFou1kYOlbdYZLfnKyZPCyYxByGH8zdsblTNgGBhUqMc+XWLQtYnQ0P7EVmmqDL8L
	GdVCwnIOLWI4iCWL+vmQR/Xun27/ppeioQkxY1MZJmGojMr/3NQ0EZALiQucTgUrAMPzZcB7O9Y
	5cVvG2RE17CMg0OzsjIRGHyu/nzmPCvMjQczNtO4JsncZeAr5TtLBlXckQbCOoASK89WwTm/H33
	ShH0KlBY92P08AfGn8Y0NZGqhMPNvfAcQuCVxboFi6JrmDnsxkTkfJtdnWVMtjo9z4+QNqOuN3i
	KA68XLnQfvGJ5y6TniqKfoelCEsjNa7FUxSWdDv1OwvGYVjMITlAt698jyHKzdzTG42gzsXTfKv
	48d0tkJD/N8yGRnMnmf9Nmqp1BDz1iMmc/vk5dgX2t6XvJpjc87DBr2STkxfHEcclMpicqXmiot
	kCIM10kf+wBf6Jdsc5MH3K8cenn8gkudl5i1ZlxqJ8
X-Received: by 2002:a05:600d:848e:10b0:4a1:eb02:37c with SMTP id
 5b1f17b1804b1-4b2c55b2b1fmr867185e9.6.1793728247764; Tue, 03 Nov 2026
 09:50:47 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102234813.1069156-1-wvw@google.com> <aunKa8uBZJTCzVjd@willie-the-truck>
 <auoCjmMnzRE8c1cN@arm.com>
In-Reply-To: <auoCjmMnzRE8c1cN@arm.com>
From: Wei Wang <wvw@google.com>
Date: Tue, 3 Nov 2026 09:50:34 -0800
X-Gm-Features: AclHuK9_lwqQICSBvCDQ12EV2wMp0iVdU4Jo-z-GyS8-J8k5xR21p5bgCHg2xk4
Message-ID: <CAGXk5yq0Abvr3LvJLTaRoBFJSE+45LznsMGge3n3fU6hB3MiGw@mail.gmail.com>
Subject: Re: [PATCH] arm64: suspend: Save and restore TPIDR2_EL0 across CPU suspend
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	wei.vince.wang@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 7:49=E2=80=AFAM Catalin Marinas <catalin.marinas@arm=
.com> wrote:
>
> On Tue, Nov 03, 2026 at 11:50:03AM +0000, Will Deacon wrote:
> > On Mon, Nov 02, 2026 at 11:48:13PM +0000, Wei Wang wrote:
> > > On systems with FEAT_SME, TPIDR2_EL0 is part of userspace thread stat=
e:
> > > the AAPCS64 SME ABI uses it as the ZA lazy-save pointer, and the kern=
el
> > > context-switches it eagerly in tls_thread_switch(). While a task is
> > > running, the live register is the only copy of its value.
>
> [...]
>
> > There's a lot of unnecessary (AI-generated?) detail in here. Please can
> > you trim this down a bit? I don't think we care about the firmware part=
,
> > the stuff about idle or the bionic crash. The bottom line is that we're
> > not saving/restoring a live EL0 register across suspend/resume.
>
> I should get an LLM to trim it down when applying ;).
>

Fair point, I'll send a v2 with a trimmed commit message.

> > > diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> > > index 7afbece885a3..c7b7fa6491c3 100644
> > > --- a/arch/arm64/mm/proc.S
> > > +++ b/arch/arm64/mm/proc.S
> > > @@ -103,6 +103,10 @@ SYM_FUNC_START(cpu_do_suspend)
> > >  alternative_if ARM64_HAS_TCR2
> > >     mrs     x2, REG_TCR2_EL1
> > >     str     x2, [x0, #104]
> > > +alternative_else_nop_endif
> > > +alternative_if ARM64_SME
> > > +   mrs_s   x2, SYS_TPIDR2_EL0
> > > +   str     x2, [x0, #112]
> > >  alternative_else_nop_endif
> > >     ret
> > >  SYM_FUNC_END(cpu_do_suspend)
> > > @@ -142,6 +146,10 @@ alternative_if ARM64_HAS_TCR2
> > >     ldr     x2, [x0, #104]
> > >     msr     REG_TCR2_EL1, x2
> > >  alternative_else_nop_endif
> > > +alternative_if ARM64_SME
> > > +   ldr     x2, [x0, #112]
> > > +   msr_s   SYS_TPIDR2_EL0, x2
> > > +alternative_else_nop_endif
> >
> > nit: We use msr and REG_* for TCR2, so it would be more consistent to d=
o
> > the same for TPIDR2_EL0 if the assembler is happy with it.
>
> TPIDR2 is not defined in arch/arm64/tools/sysreg yet (for some reason,
> only TPIDR_EL1 is). Since this is a cc stable, I think we can leave it
> as is and do a TPIDR* cleanup going forward.
>
> --
> Catalin
