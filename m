Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6292EF66B
	for <stable@vger.kernel.org>; Sat, 25 Jul 2026 09:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784973020; cv=none; b=RGGT6Wnb6IY1qYGjGEeEs+0SdT8wtmqKfiTFkCCtBMPnu2s4pt9sUdcpAlch9/4UvuiAnxt/uuvNU5erT510mksi0qxeFFv8XnnUyAqc3qD+owgDLFaE41cfHyVwIU4Lnu95CRwJlXyIHb3lqkEzDgI7LwCfrE1fFKSTDnalZFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784973020; c=relaxed/simple;
	bh=ZOkMouzKTc6pwJSkP/6wV962hrK3jc/I5BHEdbYv3SE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r5Cgdy3Rk4FJSaNRMAmfKWADfvBkzfD6TGnrx1Qerrcw3AeF67snbqLf6xSbSazlLYnPZXDgGb8oxgghH4WwBrzTqIYgifaopjYdYsVTA6JDigDHuu5sLC0wDJDDfmkxzKMfIwcPBe97tfq7DFetoiMvDbgNrdMfFJSPXt2pUbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Htcz8lcY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Htcz8lcY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB2E1F00AC4
	for <stable@vger.kernel.org>; Sat, 25 Jul 2026 09:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784973018;
	bh=CBulOiBGfBvTnAmiriXvYuXX2dx8xklmA/TrVRfbsP4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Htcz8lcY817CkpGrZHc53Sl5c9ZJmWQyD+uN7Q0Y0udjZREnyHYbbqIoI6ONoY3mY
	 NvEXE2KAmNykCl3GpLNm7iw/n9WA3G6J3fyhV+g3CZgs9zPu0MVvGJweEAaT9UiRHD
	 8zFy6xHekGGroHNxC5hhd7mQz7klcphI3QlT+u0rkg5ESKH7O7AcJzafe5B+0WCEug
	 8f98Wxxy65ECHQ+GysO2BXmD8ghfx7Sa+e6OrsyUqd0VWh5lZgQiMGrIRPedwhTJO2
	 QYuAc9XW7l4YOoO3HJUMaqe04lk+Pygqy7jt5G8IGh3OkASclevUb4+V82XFdAmoyC
	 obBUMzHU9W1zA==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-39c9bb9d2fbso10490321fa.2
        for <stable@vger.kernel.org>; Sat, 25 Jul 2026 02:50:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpTXw5FBl6Ig35K+/KySp3G12UfyDh7UtuCZmfBT7jt7IYBTA1Nu2/ZTsAC42uxUlnMIr0z0XA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+g/5rZ74ba5Kb4ArGUwdJLw4jmi9ctTZZxHoKckj9McRjBe+H
	dxFvQW2y+Ri0Idqk4xrrcFf0Msp8pVc1QeeyQ7bRJc/m74XDy92UbcQFgOOM6b5BhuicJTnxrvZ
	e7qD8SfV6o8uus/ZpaP3S0hihzwVpnA4=
X-Received: by 2002:a05:6512:32c6:b0:5b1:54a3:d133 with SMTP id
 2adb3069b0e04-5b2c1b422f3mr287463e87.44.1784973017667; Sat, 25 Jul 2026
 02:50:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723014129.1129730-1-junjie.cao@intel.com>
In-Reply-To: <20260723014129.1129730-1-junjie.cao@intel.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 25 Jul 2026 11:50:05 +0200
X-Gmail-Original-Message-ID: <CAD++jL=EJyWpqjwCdfosdanjS9GUAwMEJjHFrcvMyBV3iKHZZw@mail.gmail.com>
X-Gm-Features: AUfX_mznnK_vQ59WsYiY7CKXNdlpyrZq5O3JkxdlH-E4-8Q6XPCmriF1pwb-x04
Message-ID: <CAD++jL=EJyWpqjwCdfosdanjS9GUAwMEJjHFrcvMyBV3iKHZZw@mail.gmail.com>
Subject: Re: [PATCH] gpio: pch: use raw_spinlock_t for the register lock
To: Junjie Cao <junjie.cao@intel.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Junjie,

thanks for your patch!

On Thu, Jul 23, 2026 at 3:42=E2=80=AFAM Junjie Cao <junjie.cao@intel.com> w=
rote:

> pch_irq_type() is registered as the irq_chip .irq_set_type callback and
> takes chip->spinlock with spin_lock_irqsave().  This callback is reached
> from __setup_irq() -> __irq_set_trigger() -> chip->irq_set_type() while
> the caller holds desc->lock, a raw_spinlock_t, with hardirqs disabled.
> That context is not sleepable, but on PREEMPT_RT a regular spinlock_t is
> an rtmutex-backed sleeping lock, so acquiring it there is invalid.
>
> This was confirmed on a PREEMPT_RT kernel with lockdep
> (PROVE_RAW_LOCK_NESTING and DEBUG_ATOMIC_SLEEP).  A grounded PoC mirrored
> pch_irq_type()'s locking and drove it through the real genirq carrier
> irq_set_irq_type() -> __irq_set_trigger() -> chip->irq_set_type(), i.e.
> the same __irq_set_trigger() edge that __setup_irq() takes for a
> requested IRQ.  With the original spin_lock_irqsave() edge lockdep
> reported an invalid wait context, immediately followed by:
>
>   BUG: sleeping function called from invalid context at kernel/locking/sp=
inlock_rt.c:48
>   in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 95, name: insmod
>   hardirqs last disabled at (3784): _raw_spin_lock_irqsave+0x4f/0x60
>    rt_spin_lock+0x3a/0x1c0
>    repro_irq_set_type+0x64/0xa0 [pch_repro]
>    __irq_set_trigger+0x69/0x140
>    irq_set_irq_type+0x78/0xd0
>
> Switching the mirrored lock to raw_spinlock_t made both splats go away.
>
> Convert the register lock to raw_spinlock_t.  The same lock also
> serializes the GPIO direction/value callbacks and the suspend/resume
> register save/restore, but all of those critical sections only perform
> MMIO register accesses (ioread32()/iowrite32()) and
> irq_set_handler_locked(); none of them contain sleepable operations.
> Keeping this register lock non-sleeping is therefore appropriate for the
> irqchip callbacks and does not change the GPIO-side locking contract.
>
> This is the same class of issue and fix as recently addressed for other
> GPIO controllers, e.g. commit 286533cb14a3 ("gpio: sch: use raw_spinlock_=
t
> in the irq startup path") and commit 90f0109019e6 ("gpio: eic-sprd: use
> raw_spinlock_t in the irq startup path").
>
> Fixes: 38eb18a6f92d ("gpio-pch: Support interrupt function")
> Cc: stable@vger.kernel.org

Really? Why to stable? Is this a regression of something that used
to work before? Using RT is fringe IMO.

> Signed-off-by: Junjie Cao <junjie.cao@intel.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
