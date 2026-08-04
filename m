Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1F3429818
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 07:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785829333; cv=none; b=DAv4Of2F/5YGU6YUc2t8F+ciVbJa2xBw4S2/4YN2Ep30XBZh+BA23nX8Q1gJ2P+alNwebkrJ4SXWqlJvitYvta2lk/B4+lcWqEgs3cUkqIhppiIFm4lnyMs/u+bAjWPzUIhtip7/QIwuxcKl4QM1lYc5rlxAknjxKXDbrkGXERM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785829333; c=relaxed/simple;
	bh=+24tJxmTNGsbjfwGGtdlYvjVz7uY6owvK0gfMvh1x4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZMMmOJh7ciMtyJpBQ0FNL1+jSPQoEYBlW+ElVlsCVUVqH22wzEggK49gRv8U2mjm45y0xZEmlQ8eNTRorJobWqbUyuDMKznXIVUpnlWTvQ+7KWEBB9YQ0jj6lrEj5Jx6TXFnozZRRTwlcYyMztAhM2ys6VD4hlTjyf0n5tCAE+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cIRWlw1i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cIRWlw1i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0945D1F00A3D
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 07:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785829332;
	bh=Z/iyYkMo3J3MpY+sBFfuLCphuanoP24xAaUBOU7OBHg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=cIRWlw1i48pKecN1ACparvW4LPLECs9JHMgI3rubS75Z5uvTkZzttg7s9+Dcrfc4o
	 W/R0cGyNBc+9Zh3xhPxNfLeMhTP/1FvFh7spy2/q6YlR8hobyVCCmZZC2prTbM9hzh
	 a7IothsPBRn8jj+Wt23ZR9UgcrGQf3ZnfXd6qe53rV7fnau0I2lae+Idq16so0k6tv
	 ZescojDv4ErbAGZ9wm+HWopFnY9WoKYbc/cmQN2FDzcmWvJBsVy5iK1Us0ohCiP3Ru
	 Hgc/TRqR41Gq49YasX8K9OJRb4NLfLE0YPqznt4QPwiqD8Xm0B9U/f8LuZpjHcLOGx
	 4fiKs+eeekV4w==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5b15dcaca31so4066637e87.0
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 00:42:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqMZ/1yMLkDecKugj1w9T6SY2miKgGFOGiFNIcgLyc708Y5G106EiAkdU+4c3n8913qARWr/z8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgBdS5zSOhMyxPEjgsKbL1pthkdGVy7OYe7RPSn5NfPFT23BcU
	WDeUx27YSH5ffbEE1Bdryb82JQ8jzdpv3LdvtGBnWLN1fPJwfNF/mpqZrY5qa2cF5bDHeE8x+zH
	9dMLhoasg7B0sECnRmIUC6Lk9zygXp0U=
X-Received: by 2002:a05:6512:3da8:b0:5ae:a81f:c1db with SMTP id
 2adb3069b0e04-5b2e4f1afa6mr2972872e87.13.1785829330830; Tue, 04 Aug 2026
 00:42:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731032747.2987292-1-junjie.cao@intel.com>
In-Reply-To: <20260731032747.2987292-1-junjie.cao@intel.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 4 Aug 2026 09:41:58 +0200
X-Gmail-Original-Message-ID: <CAD++jLkAjQG7hFsdX+dy8wZUoKKDCaOzMD0EJ0nn3gYmaEOJDw@mail.gmail.com>
X-Gm-Features: AUfX_mxshjhXPBoVr7O5EjGs8xJzPlqOSJ7vXDCmceSjj8EKGV2yiAL6JAI4HKA
Message-ID: <CAD++jLkAjQG7hFsdX+dy8wZUoKKDCaOzMD0EJ0nn3gYmaEOJDw@mail.gmail.com>
Subject: Re: [PATCH] gpio: ml-ioh: use raw_spinlock_t for the register lock
To: Junjie Cao <junjie.cao@intel.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 5:30=E2=80=AFAM Junjie Cao <junjie.cao@intel.com> w=
rote:

> ioh_irq_type() is registered as the irq_chip .irq_set_type callback and
> takes chip->spinlock with spin_lock_irqsave().  This callback is reached
> from __setup_irq() -> __irq_set_trigger() -> chip->irq_set_type() while
> the caller holds desc->lock, a raw_spinlock_t, with hardirqs disabled.
> That context is not sleepable, but on PREEMPT_RT a regular spinlock_t is
> an rtmutex-backed sleeping lock, so acquiring it there is invalid.
> ioh_irq_enable() and ioh_irq_disable() take the same lock from the
> .irq_enable/.irq_disable callbacks, which are likewise invoked with
> desc->lock held.
>
> Convert the register lock to raw_spinlock_t.  The same lock also
> serializes the GPIO direction/value callbacks and the suspend/resume
> register save/restore, and those critical sections only perform short
> sequences of MMIO register accesses (ioread32()/iowrite32()); the
> .irq_set_type callback additionally emits a dev_warn() on an unsupported
> type.  None of these are sleepable operations, so keeping this register
> lock non-sleeping is appropriate for the irqchip callbacks and does not
> change the GPIO-side locking contract.
>
> This is the same fix as commit a02b8950d619 ("gpio: pch: use
> raw_spinlock_t for the register lock"); this driver shares the same
> structure as gpio-pch.
>
> Fixes: 54be566317b6 ("gpio-ml-ioh: Support interrupt function")
> Cc: stable@vger.kernel.org
> Signed-off-by: Junjie Cao <junjie.cao@intel.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

If you have time, look into the issue reported by sashiko about suspend/res=
ume
ignoring the spinlock.

Thanks!
Linus Walleij
