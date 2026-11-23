Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795393760;
	b=MX4KN3dRhcxAh7e5KLYgiBMU/ZcoTyCVw7ZJaMoD8dJVpJ7qTMvyCTuhaSChw5hfF8vi
	 DeML03GySrR3uNdu0+5IgWuSQgf1mlhYF1r5ANDOiVSHq77YuyvwyBjJKJ6GJ7SnI8+/a
	 DLtHxZ8cdN1wrplATjrlOWca0e+J5Lzm4VFuR3BhLF1YNm83evwctE8paJ3A1dBXJJQsg
	 lr7BDnRN8iyAX3fqhMaZUFXs8A2ChViU3gHBzUhB2stEt0pwgrCuOr0RhSy1IQ3bdn+Yr
	 CuF4R6+TsL2XDGSqMBrKsZOVWe5d66j/0ROHTk0ti1509CKXreqscT0ZPI3leBB5A5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795393760;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=8qFkofrD90yASDKy5S4kDZ5KpDQOlPHLhwNCJy671mM=;
	b=RBNIG0pllKUe0NLIEAJISB2tLkb4F0gcqg839Z0KrEktttbbhxVUfByP//spRWHlhA1A
	 yeqUWQ1pzqlZkldMX/X7GpKGHKqRRQmHmNCWFabD/Ok4NevAF/25rcP9HdRYSQmMvIhsy
	 iVgCBd0R0GSybzu22M7MoSBBHSoes4aH64v48JassktrC3eLmqHmgc7HKw4+CdZ5mBOOm
	 y5h4E3HHgKVaQpjhbU2LAsyfUTyVLOv8PaqSf0u5bdvaZGZQFkdF0roOGyJXFOwtvJUIJ
	 AjPQNxfR84bFshlUNzfvvHL/a9384X9V6BfTe4hGyBCsIsqzvC49Q3mTIa5sxdJGFIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DLap424D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF20606A32A
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 00:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DLap424D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D591F000CF
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 00:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795393759;
	bh=8qFkofrD90yASDKy5S4kDZ5KpDQOlPHLhwNCJy671mM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=DLap424DGHliLRM4qmstNWwoWrM+SMO1GCJ3rDJOEeFhneczrWwCAdU0UjMw5Av7k
	 4BISFt7YtGgXIYfxypp07ZxRnVVxnXC4h9xDLVudllRlLeRYG3Qf0nlU9sQuBGaeHd
	 fhGjCW37H+VBucqnccXHOS+oKbDPGIm55GVeoLPCsWD1Bo5Qq0BOV8anp1cRbp20H6
	 rPUCsDyeONmYlgjjshLUQgaDcuEvE/GV7LpoPwNxjG8znTR6IbO+gKn8lgOpVEx+7B
	 HSPumwPqj3kP81ie4hOU9rRZ0Uyc4PkmhqvAl7W1uZn2ixuXWzNdqZ1fagTk8f8V0Z
	 ZCwwRYwJ7npKw==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5be3d5927ceso4023401e87.3
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 16:29:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFFPyLZAc1aRnfigfG9jqfJvFehiulQPASHc96MJW3RV07O9MVnfyF9rj7+p0LeWMcjq5l4Ed8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9wPmqO2XP7/bFaPf9dgHJaROGb9z135m76PAIMDN4gnsE+gnPO
	UWoelv3t+84K/SDIqOR7g0FLKqZM1Rtnot0l5qk2m180qWRj8MDg5e4x3M9kNxwDeK7QeVTFydl
	6oHwAxB+Xx1WNcp7HPa6ti1d9i2Db/Ko=
X-Received: by 2002:a05:6512:b9a:b0:5c1:acda:6dc3 with SMTP id
 2adb3069b0e04-5c1bc6f6c92mr2640619e87.3.1795393758361; Sun, 22 Nov 2026
 16:29:18 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027-mali-c55-irq-supend-resume-v2-1-759b3f5b2cfd@kernel.org> <avMP-y1B9K0cp4M8@zed>
In-Reply-To: <avMP-y1B9K0cp4M8@zed>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 23 Nov 2026 01:29:05 +0100
X-Gmail-Original-Message-ID: <CAD++jLnuS9ZE8mRwkCizsqo3f40s5etqOJAUqLJNsCtE5eEkDg@mail.gmail.com>
X-Gm-Features: Aa3M54oKQ7-pXJhxkVQ6DYf9Srp3nFTxNtaA3h-2YMgZtE6S4BXYHBwJQq80Cf0
Message-ID: <CAD++jLnuS9ZE8mRwkCizsqo3f40s5etqOJAUqLJNsCtE5eEkDg@mail.gmail.com>
Subject: Re: [PATCH v2] media: mali-c55: Keep IRQ requested during suspend
To: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc: Li Youhong <dayou5941@163.com>, Daniel Scally <dan.scally@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil+cisco@kernel.org>, 
	Nayden Kanchev <nayden.kanchev@arm.com>, linux-media@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jacopo,

On Tue, Nov 10, 2026 at 1:51=E2=80=AFPM Jacopo Mondi
<jacopo.mondi@ideasonboard.com> wrote:

> >  static const struct dev_pm_ops mali_c55_pm_ops =3D {
> > @@ -825,27 +813,42 @@ static int mali_c55_probe(struct platform_device =
*pdev)
> >       pm_runtime_set_autosuspend_delay(&pdev->dev, 2000);
> >       pm_runtime_use_autosuspend(&pdev->dev);
> >       pm_runtime_set_active(&pdev->dev);
> > +     pm_runtime_get_noresume(dev);
>
> Why is it relevant to hold a PM reference during the installation of
> the IRQ handler ?

Probe enables runtime PM before registering the media devices.
Once those devices are visible, a streaming path can take and drop a
PM reference. The probe reference keeps the ISP active until the IRQ is
installed, so runtime suspend cannot call disable_irq() on an IRQ we
haven=E2=80=99t requested yet. I=E2=80=99ll add a comment.

> > +     /*
> > +      * The driver needs to transfer large amounts of register setting=
s to
> > +      * the ISP each frame, using either a DMA transfer or memcpy. We =
use a
> > +      * threaded IRQ to avoid disabling interrupts the entire time tha=
t's
> > +      * happening.
>
> Does this comment still apply in your opinion ? I mean, thread_irq are
> pretty regular stuff, do we need to justify its usage ?

Nah I'll drop it.

> > +     pm_runtime_disable(&pdev->dev);
>
> It amazes me how, after so many years, I still can't find a clear, firm
> indication of what is the intended call order for pm_runtime_disable()
> and the other pm_runtime calls is during a driver's remove.
>
> Media drivers seem to do different things with some disabling pm
> before setting the state to suspended, other doing the other way
> around.
>
> In the end, I think this doesn't make any difference, but in this
> specific occurance:
>
> 1) Is this re-ordering required to support the new interrupt handling?
> or
> 2) Is it a change that is worth doing anyway ? (and I should say "should
> go in a different patch on its own")
>
> > +     free_irq(mali_c55->irqnum, &pdev->dev);
> >       mali_c55_media_frameworks_deinit(mali_c55);
> > -     if (!pm_runtime_suspended(&pdev->dev)) {
> > +     if (!pm_runtime_status_suspended(&pdev->dev)) {
>
> I guess this is required because you moved pm_runtime_disable() up

The remove ordering is part of the IRQ lifetime change. Both runtime
PM callbacks now assume the IRQ is installed, so we need to drain
them befor free_irq(). Then free_irq() waits for the threaded handler
before we unregister the media entities it uses.

That=E2=80=99s also why I switched to pm_runtime_status_suspended().
It reports the actual status after pm_runtime_disable(), so we only
power off the ISP if it=E2=80=99s still active.

I'll resend a touched-up version.

Yours,
Linus Walleij
