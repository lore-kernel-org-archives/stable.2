Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACB6331EC7
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 08:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789373315; cv=pass; b=IbTZP6ucY6dmrqKBHUP7xdkShK85q8kfc85PkIVJm97ctYiixi/QVtBlPUcld/z5YzNEIgYJR1cgLUsvv9lZH9jwOv7ZMZfrDV6e+0dHWnqQLkMFUTozTbQwZIQKr5qPKvEehgTb4uhFQR/I9OzBg7i8TBc99P7k091pUrmT00A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789373315; c=relaxed/simple;
	bh=DUAXh/D37ePrGStHIvqH/FD63oPvTaNzwYIYhmyhXtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GygeE3QhKJn2omIUmnDPLqyuuFWxKMbjetz2wfh2H0ZfrMaf+Y2VQOfw1m5utgnAdVIoj2cQs4YqQ1bOnLXAtu/D1sneTeFQUUNLk1Qfa6hzlrGgayd39fAaM7cneVGUTio7N/rc1QOqpHRSqZYUyR9JTS1Sl5rIEt77SjsjJy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIE6Xae9; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIE6Xae9"
Received: by mail-yx2-f13.google.com with SMTP id 00721157ae682-858feccfd06so757597b3.2
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 01:08:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789373312; cv=none;
        d=google.com; s=arc-20260327;
        b=DSQ/9SqJ+5Mw3siSU/B9UFLLvAivPuto3B5UAqYnPTTzx6RDt2fWNsPv3EZCeh3o9J
         Nif1c8P/aJyVtv6KK/PofD1/65kcmZsZIf3oxuvDEONhRvLZQk8Ysr5Y3KaXfD30ADDz
         +Uv9Q/cMUwKtWabJt9BuutPLr62XzQ++r8lwQAzgE/k+lTi4YTb3Oc2EoXYpmMFK+HRl
         wvC6ZoTmpSpxxz1GdmpPrmgldROlfC/24v7/3a6QIvlmsiCZTnb8ctK+7X+F2L7IcU6F
         K/1Xkrc8M01/ZQvJHB390N7I0OC1CGgJ/5SplqATaTB3B9AS1iwBxfhVDTMrQCL7Bu8w
         eGKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ID6c9sfqkpTqIRSRF0HKDo0hSdWLeIijg8HL/+8GapQ=;
        fh=bU5YG4eCIxZW67/NGuB2qDU1vWxehy0+22QWe4fWcac=;
        b=Y0qOaUV5HwTspzaJh+Of0EW/WwiFYYG+sb7bSIBjZbxMTisTAQUWjrxcexHIaStKBc
         dkP4b36x/G3IKAEGm+Eyvd2jY0DPbtpJy8s61THr+lJwBL+jTTKIyXtYDTXQAQS7+SWl
         1vPMuYIo7Z+oecMISUk+Qqxa1CyVuteM0Oi6mAn6ITbHcSrq39XFtzz2++xy5KXs5NqX
         gY6N/CoXjrh5bTlWAwfNaktIQCrnqo4dnC/lhjC1WtNqHe8HKM3VScia3cfFznMw+AvC
         KHcJvWMT83WfLi/zrBvV4P/WLs+4ppRm7jiSrirTG0NyIVbcbNWbEYJf7bcQycZZm/um
         B6iQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789373312; x=1789978112; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ID6c9sfqkpTqIRSRF0HKDo0hSdWLeIijg8HL/+8GapQ=;
        b=nIE6Xae9QnxhFk4ruq/g0N3202mgXuoV2//wh7SyI0cCQGaq2evBg7oaE03/CC9lku
         JEUQhVeKLHxvi6skQbZgoEWWgyCI+D4SEALYBzkrxXeuKRGsbcOvw9aOischc8MpMo5Q
         d7qNDfS9kkMQF9i/aUUpIZVmATPf6aHChegM2iEzl4qd8ucoeK4ABcfDK4g/HeHirjvK
         5IR8WKdacU4aL/bC5nAD0g9M9+Mh9VaE91NpBad+WDE+lL/BvyOhEN9COhPOWJ0oDQ3B
         O3JpUeMiTvNl44Be220vKRnUJx5OMROblrRvLqH6/zziggJ++dgIQQOHgbg3eN8YT3D1
         ITcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789373312; x=1789978112;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ID6c9sfqkpTqIRSRF0HKDo0hSdWLeIijg8HL/+8GapQ=;
        b=WNy7fxNSI4o63w7uLMCNTYW5/8JXIhE24sVlJvehPDwe4H80Dz/TABC0/LpSm6LOxX
         3N2oSPy8c1ByJu+fTEJcQ80eghzGsyti85P2WU6lqzNMyHytPZy1wN3W26de2iptGipE
         5Rf7Z2lo1UAOqtdQ14J7KuYVsJCesZXdjUAsLtojhaQiAN7Yj9xE6UwudS0g4egpowHZ
         0p5ZzZO84yYTczRVvpvc+frXB/kw62J2I9PQgBOC+ciQ36xu2eJBjeb4iOYAkZoiVCfg
         giuMR0z/4QFXuLgihcWrAAUKY2ht+KCRLG8wNuWpW9VYNtzyFctlgV1AqnJ2FlTuhdma
         jGIg==
X-Forwarded-Encrypted: i=1; AKwUvBzy4caVx63At5VlMQOiCv1b4v2GmevK5QQsqexUI2p22xnud+MQF/5FPqRa45bkZozJwxOt2+M=@vger.kernel.org
X-Gm-Message-State: AFuF++nyuMUHFpqFpRwcExcCnceFCeKRdcxJ7m01dzE8spK/oCZDe9xS
	N4CNiskoAoYiIALreeuyDiCCCI8DJIlQhhAMMOIfyi/fiejIHX131aVNoLmW4KEZwLEbHnym/Zz
	DevDI+akARzIdOEKFHH4Xg7jODSTBEGM=
X-Gm-Gg: AYBFou1a1H9rnxDQoYl8UYsXYi7JPCCNtJJr2a6UyK6mVzRW26A4uc+iWm3bmxlCtDY
	FFB1wSoAzitJvsFwzw/s1+QN0KnSmdQO5dDuRDYzDaXldThsqn8k1wPJSc0X98ge0+xVBKOyJzY
	2cT0meFSddIBdnD9BixIxaVMjIKI6OAQ08ytMWoJNlR5wm/VnUZsXlJzXLPDbTau0pzcPQuV8OZ
	PLAB0D+y/HPZrsfsJeudJ0MOteGz2ZvfQkUlJxWYsvMCfFeUhOMoIX2o3TkbrxsZP+lEIr45i7k
	puPO6qcRygI2hwv6Xbu72/Ois1LnGEI1WBBX20baTxA/TgcKPlXDk8hO
X-Received: by 2002:a05:690c:630e:b0:870:48aa:473e with SMTP id
 00721157ae682-88d19058869mr5623377b3.0.1789373312213; Mon, 14 Sep 2026
 01:08:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910184452.895485-1-itai.handler@gmail.com>
 <20260910184452.895485-2-itai.handler@gmail.com> <20260910190139.BF6231F000FF@smtp.kernel.org>
In-Reply-To: <20260910190139.BF6231F000FF@smtp.kernel.org>
From: Itai Handler <itai.handler@gmail.com>
Date: Mon, 14 Sep 2026 11:08:20 +0300
X-Gm-Features: AcwNN1XT_uCY5gQVeYwBYOZOBIgOpq3-Jnpwf4sQfFYZU8aFfdkLrzHjDiS4GQQ
Message-ID: <CAFpOueRqaQ=C3u+br6AsCDPeeFwqVUmCG6JSCu90noowVCfd=Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] mtd: spi-nor: take the flash lock in spi_nor_shutdown()
To: sashiko-reviews@lists.linux.dev
Cc: mwalle@kernel.org, pratyush@kernel.org, linux-kernel@vger.kernel.org, 
	takahiro.kuwano@infineon.com, richard@nod.at, stable@vger.kernel.org, 
	miquel.raynal@bootlin.com, linux-mtd@lists.infradead.org, vigneshr@ti.com
Content-Type: text/plain; charset="UTF-8"

Thanks for the review. Taking the three points in turn: the first is
unreachable, but checking it turned up a real bug next to it that this
series has to fix first; the second cannot arise on the path this patch
serves; and the third is correct and is already stated in the commit
message.

> [Severity: High]
> This is a pre-existing issue, but does spi_nor_prep_and_lock() leak device
> preparation resources if interrupted by a fatal signal?
>
> If a process is killed while waiting on wait_event_killable() inside
> spi_nor_prep_and_lock(), it returns -ERESTARTSYS but fails to invoke
> spi_nor_unprep() to roll back the earlier spi_nor_prep() call.

The asymmetry in the code is real, but the leak is not: the two halves
are mutually exclusive, so there is never anything to roll back.

spi_nor_prep() only does something when the flash has controller_ops:

        static int spi_nor_prep(struct spi_nor *nor)
        {
                int ret = 0;

                if (nor->controller_ops && nor->controller_ops->prepare)
                        ret = nor->controller_ops->prepare(nor);

                return ret;
        }

and the wait_event_killable() is reached only on the parallel-locking
branch, i.e. only when SNOR_F_RWW is set. That flag is set in
spi_nor_late_init_params() (core.c:2981):

        if (flags & SPI_NOR_RWW && nor->params->n_banks > 1 &&
            !nor->controller_ops)
                nor->flags |= SNOR_F_RWW;

Note the !nor->controller_ops. A flash that can reach the killable wait
by definition has no controller_ops, so spi_nor_prep() was a no-op and
spi_nor_unprep() would be one too. RWW and controller_ops cannot coexist.

> Does this
> also apply to the other locking helpers like spi_nor_prep_and_lock_pe() and
> spi_nor_prep_and_lock_rd()?

Those two have the same shape and so the same answer: same
spi_nor_prep(), same wait_event_killable() on the same SNOR_F_RWW
branch, so there is nothing to unprep there either.

One correction as well: on that branch spi_nor_prep_and_lock() does not
take nor->lock at all, so the error return cannot deadlock the mutex in
the way described.

That said, the neighbouring code is not fine, and I would not have
looked without this comment.

spi_nor_rww_start_exclusive() returns with nor->lock held, on both
paths:

        static bool spi_nor_rww_start_exclusive(struct spi_nor *nor)
        {
                struct spi_nor_rww *rww = &nor->rww;

                mutex_lock(&nor->lock);

                if (rww->ongoing_io || rww->ongoing_rd || rww->ongoing_pe)
                        return false;
                ...
                return true;
        }

It is the only one of the ten spi_nor_rww_{start,end}_* helpers that
still uses a bare mutex_lock(); the other nine all use
guard(mutex)(&nor->lock). Commit 03e7bb864d9a ("mtd: spi-nor: use
scope-based mutex cleanup helpers") replaced its "goto busy" with a
plain "return false" and deleted the busy: label that did the
mutex_unlock(), but did not add the guard() that the others got. Before
that commit the function always released the lock.

So on an RWW flash:

 - if the flash is idle, it returns true with nor->lock held, and the
   matching spi_nor_unlock_and_unprep() calls
   spi_nor_rww_end_exclusive(), which does guard(mutex)(&nor->lock) and
   self-deadlocks on a non-recursive mutex;

 - if it is busy, it returns false with nor->lock held and
   wait_event_killable() then sleeps holding it, so nothing can ever
   clear ongoing_*.

That has been the case since v6.15. Nothing hits it today: the only
flash with SPI_NOR_RWW is the MX25UW51245G, which has neither OTP nor
locking ops, so none of the existing spi_nor_prep_and_lock() callers in
otp.c, swp.c and sst.c apply to it. That is exactly what this patch
changes - spi_nor_shutdown() did not take the flash lock before, so an
RWW part never reached the exclusive path, and with my patch every
reboot would. v2 therefore leads with the guard(mutex) fix as patch 1/3
rather than building on top of it.

> [Severity: High]
> If a fatal signal is pending during the reboot process, such as from the OOM
> killer or a manual SIGKILL, wait_event_killable() in spi_nor_prep_and_lock()
> will immediately return -ERESTARTSYS.
>
> Will this early return skip the spi_nor_restore() hardware state reset?

Only on an RWW flash, for the same reason as above: the non-parallel
branch uses mutex_lock(), which is uninterruptible and cannot fail, and
spi_nor_prep() cannot fail on the spi-mem path because controller_ops is
NULL there. So on everything else spi_nor_prep_and_lock() returns 0.

Where it can happen, skipping the restore is exactly what the code does
today when the restore fails, and spi_nor_restore() is best-effort by
design - it ignores the error from spi_nor_set_4byte_addr_mode() and
only logs it, "in the hope that the flash will default to the 3-byte
address mode after the software reset". The patch does not make that
outcome more likely; the unlocked restore it replaces reports success
while leaving the flash in 4-byte mode, which is the failure being
fixed.

> [Severity: Critical]
> This is a pre-existing issue, but could releasing the lock while the MTD
> device remains active expose the flash's modified 3-byte addressing state
> to concurrent operations?

Yes, and this is the right thing to have flagged. It is in the commit
message:

        This narrows the race without closing it. The restore still runs
        while MTD users are attached, so an operation that starts after
        it has completed will address a chip that is now in 3-byte mode
        while nor->addr_nbytes is still 4. Closing that as well would
        mean having MTD stop accepting operations before ->shutdown
        runs, which is a larger change; serialising against the
        operations already in flight is what keeps the restore itself
        from being issued into a busy chip.

The mechanism as described is right: a page program issued in that state
sends four address bytes to a chip expecting three, so the fourth is
consumed as the first data byte and the write lands shifted.

It is not introduced here, and it cannot be fixed here. The window
exists because ->shutdown runs with userspace still running and MTD
still accepting operations; the only real fix is at the MTD layer, and
it is a separate discussion I am happy to have. What this patch removes
is the strictly worse case where the restore is issued into a flash that
is mid-erase and silently discards it.

Thanks,
Itai
