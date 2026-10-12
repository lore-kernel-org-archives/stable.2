Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF8A3B1014
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 21:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791841448; cv=pass; b=ZyH6xtxTRIGKOEBa3l8GrN+QaiNhSTYV/nPU5Sa56DOmgvh+i9Rp3H6mgQF6UiRQFMQPUwrzzReiHyKEJCni0DHQUbYN1Bm+a4iAyzvJyZ2iU2nsUdshqbMOCW7Dyx9QC23+J9vjKHvHCWL3ilTvDtXCaQPA/f9RqVzr/fIl79g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791841448; c=relaxed/simple;
	bh=4rQCMA0YD118aHw+hhFF9+PsdILXF6N9UmQsk1sUyMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EqgaKh2WVIfHYWiZtJ0KT7Gz1o2rCmuA8RTtdoIHHhJ1We9R2YKVTUitx48D5oQewkxxReklCLII9f1RiFmCzLjkGCH3Zn8vGuUZNdNFKOVf4a/DjbonjZa5PqyTJIekO0jkhRxek5+zVgY59a6ec0oNY3K+CdVSlwYoLl+o364=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVoETAZL; arc=pass smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVoETAZL"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-98c78660542so1033526241.1
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 14:44:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791841446; cv=none;
        d=google.com; s=arc-20260327;
        b=KPAIwNywW6WQoES7lo2JWTFlUx94tqiGwA67jaU7FcAQqdUfusr50KA0YUeEBpqSP8
         FxfXQsfFURPleX9OQpQr4DB1ajuhLigZASmfjBup4kE2KQb+TbCrTyASOllMqG5WyTdD
         VDorbLS6JxnK8yDrKsbF2IeyugfRrTSNWFbeBvv7EK3B4M35ZRwa18MXB4wkRGK/XDZQ
         FFocv+6HaiGVWKsfsO9i7wTvFpS/W50p5fs9A8nxJThF7iRU+ZD+65f1bD1jFGHOkaB9
         yQ2VknnDHofbrojlI5rZr1gIqIHqxleYL+xBOiBwo/J0XMAI3zI5Q7a7ownPRrk3iblB
         rcYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IgcW+mBezfmaVemco2WC7GasvmmjoylpddtvtSsj0OQ=;
        fh=eqKouCUGUlxyqge3GQCB0aoyQUuFDpVkXxiRE1Hg1eA=;
        b=GIrsnuV1uTfWbT7K4H7346E9f32t3qdD/NYdHsC5axO3V8/HXXM7GmIPUDq0rUUl+B
         lR+sGSkiTV3YCUTZZrB6mACkU+WSezEXLuhbI50bn0vXdi1EyAXllJylhLehp5IROlwk
         SZVsGS5647g0b8KTHjDILWXGQv/HBdQLJ4YrU0OjFcFlKD/WEHnWSCO8OrKnd965Xiqi
         f7H9loKyM+z/GbAUoOGZKXwH1Bgmlqd6Dcnm3OLJy5wbcwvMHjyTj2DqumwKPg0/foqZ
         qI5tYmJF9G62ZOZkFO2GXE4Ed/NYi+wQfKQp6RcJcRzUbTMn2fzHaaF7fVreP+7ESq1h
         XgYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791841446; x=1792446246; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IgcW+mBezfmaVemco2WC7GasvmmjoylpddtvtSsj0OQ=;
        b=AVoETAZL7gSCTxtLGecnwJyb3IdeC7SraxprdR3BUyxzyt9spcJBsDt5JLT0dHOkzW
         DnFiaNpT4XSvB0YxXB0ScjDmdDXr23wwVNzSvLQwnD0nsxE+vVm1ZNln5Wggxn9I5QP3
         U9IuWRMQuOZlLBcy8wNhPW2etLpkFm1mrAkivIqf07M0GYrVIKkcs5OwXDMfhbngeZ68
         o8sqIYLMfA3ypYrM15eSRdGZQSFEcTZUp+6ud3JkDxjoDsS0yLi1bWjBqw30dnvvaMLf
         nch/z5dalphBEsKHcs7E0G1RPX/pIyYwyy0EjFfOFyz5u1ROTfOrw9IzIS/RwkFVE0zo
         qsHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791841446; x=1792446246;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IgcW+mBezfmaVemco2WC7GasvmmjoylpddtvtSsj0OQ=;
        b=h3nVkUd5inS0dkDMBYTkDceN0eGvJliKchFoalHeCPNH+lSgbBpVmYUoAdy+ZHLySC
         aJDuP4A168Q7AZhwKTbiOp0yvv5Qy4q9yEXwOjEwvMX9QLPqr0ncZhSuh69d9ewpK5/a
         yxTcjyLXE7gtn5Uf5aJxRPOCWn+cN5ANCPI7WFcZEEOUe3ygPFCpvTorDZHWy2cRPUrR
         BozVn9fTJsAvI2V0aJ6uz27odD9w8IEW9Uxytugu82N+jIVG8CFBnpGvfsu/h93uqECf
         Nq1hekO6lzmtHuyNIQgmsoEHsebKEqfHKpfbSFg6wq7RcVuUOmBIpBEU13ZmY5AdZMUT
         Oktg==
X-Forwarded-Encrypted: i=1; AKwUvBy5yfJMOcKEA15SBbFLwXzF73TmAy9iYdgTQelHUuynHO3o7SxoGodrATbfiMwCCYOo4A200aY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJaiBvtcvkIMvndrsqB+8AKCWb8GO+L+Cc+HwPlAnkUylowFJo6
	azMNFeOu/l7Uy6+KNS9/q3sUj40pyfnfBJWQGjQsohE5nzUl3ip06FltctV59IjcsxuBJfRkle4
	fErMzV67uG8aOtUTo+IXdRyqNCn6zbyo=
X-Gm-Gg: AYBFou2a5BnjEIQqAI2msklfc//90dmWA7OkkKaJvMO3IBRx/rP003nONfSjwY5tpeP
	MFnY4sbxVkK24i/fJYoDx2M9YUenmCahq0xIzBPo0n/ryaFr7bdOwGPuuy6UCKxDBeviTP1AEiN
	N4flrEWYsKDp++DjTjZ0Sidkqsw1HhssWMo/YJ7FYkHcUFOH1KKgPUU37AQjHTGn/ppqA6CAMTS
	M3PA1eJgk8ehttHwGclPlRkjZ6R4iditCPag33gMg5J7F0k7Ueaqn+E0gM6rl8KB8r8DNXAMM3z
	xc5Tz5a1ZwvAtqq+ypDopiY4AUEoAQyVLrlsKp3jW6oQMN4leTj7GO4ogY7yj0HLVAZewNakPvs
	Bgs+jd4EqkjNXTaz8sQQXnzf8l/k+zaYUaHE103ZbN944G93jsopbPvmYZE6med0WpUkuydRP2Y
	77g5NFedQEiIp69TMkidd5vevL7aH14uVZLzG0TZacnvVokKCzWn6FR2Q=
X-Received: by 2002:a05:6102:5814:b0:79e:2b00:b4da with SMTP id
 ada2fe7eead31-7cb3a0059admr2967326137.6.1791841445569; Mon, 12 Oct 2026
 14:44:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914-submit-sunxi-nand-vendor-oob-layout-v1-v6-0-2fb084fe0751@gmail.com>
 <20260914-submit-sunxi-nand-vendor-oob-layout-v1-v6-1-2fb084fe0751@gmail.com>
 <8733ua23xs.fsf@bootlin.com> <CADvTj4pmtGZ4c04q+5AE3trrfshToD7BPtF-8kPxPRZ25hOTRw@mail.gmail.com>
 <877bjmzqkr.fsf@bootlin.com> <CADvTj4ppQannShF+dkLreST94g_vSAg4QdMqxhNORzkvci3O1A@mail.gmail.com>
 <87pkxey725.fsf@bootlin.com>
In-Reply-To: <87pkxey725.fsf@bootlin.com>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 12 Oct 2026 15:43:54 -0600
X-Gm-Features: AclHuK9S8X-EJbG6Jz0l1nDWbI3paRApUkydjtgW5vHKMROEOTWMTqhZBvuvO68
Message-ID: <CADvTj4p-o=EQMq-6E1q2=NOmQbscAVGMUbwX+Wh4R0v5kbXe_w@mail.gmail.com>
Subject: Re: [PATCH v6 01/18] mtd: rawnand: sunxi: drain interrupts before
 reusing the completion
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Maxime Ripard <mripard@kernel.org>, Richard Genoud <richard.genoud@bootlin.com>, 
	Masahiro Yamada <yamada.masahiro@socionext.com>, Boris Brezillon <bbrezillon@kernel.org>, 
	Brian Norris <computersforpeace@gmail.com>, linux-mtd@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 2:53=E2=80=AFPM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
>
>
> >> >> commit log, I now disagree with the first part of:
> >> >>
> >> >> >The old handler can also complete the new wait or restore an obsol=
ete interrupt mask.
> >> >>
> >> >> "complete the new wait"? I don't see how a stale handler completes =
the
> >> >> next wait given the handler is a hard IRQ and the interrupt enable
> >> >> register is cleared on timeout.
> >> >
> >> > The case I had in mind is an already-running handler on another CPU:
> >> >
> >> > CPU 0: Read st and ien for operation A.
> >> > CPU 1: Time out operation A, mask/acknowledge its interrupts,
> >> >        then eventually reinitialize the completion for operation B.
> >> > CPU 0: Call complete() based on the saved st and ien from operation =
A.
> >>
> >> For this to fire, the hard IRQ handler on CPU0 would have to be stoppe=
d
> >> between reading st/ien and calling complete() long enough to span:
> >> - A's timeout
> >> - A's cleanup
> >> - B's wait being rearmed
> >> On this hardware, how is this reachable?
> >
> > CONFIG_PREEMPT_RT provides a concrete mechanism. The driver requests th=
is
> > IRQ with flags =3D 0, without IRQF_NO_THREAD, so the handler is
> > forced-threaded. A higher-priority task can preempt that IRQ thread
> > after it reads st/ien:
>
> That argument only appears in this reply. It is not in the commit log
> nor in the diff, both of which reason about a hard IRQ, no? I'll happily
> take the PREEMPT_RT case into account: in that configuration the case is
> reachable, but it reads as a justification added after the fact.

Yes, PREEMPT_RT was a later concrete explanation of how the race
could occur. I should have made that distinction explicit.

The original rationale for disable_irq() was to establish a clear
boundary between the old handler and timeout cleanup.

Simply masking the controller interrupts does not stop an already
running handler. A partial-event handler can subsequently restore
an obsolete remaining-event mask. A handler whose saved status
satisfies the wait can instead signal the completion after the
waiter has moved on.

disable_irq() prevents further IRQ dispatch and waits for existing
handling to finish. Cleanup can then mask and acknowledge the controller
events without the old handler modifying that state afterwards. The
register readback flushes those writes before re-enabling the IRQ.

This also keeps the additional synchronization on the timeout path,
without introducing a driver lock into every successful interrupt and
wait setup. The checks at the time established that the caller could
sleep, the handler did not require the NAND controller mutex held by
the caller, and the IRQ was not registered as shared.

Sashiko's report[0] was the starting point and mentioned both
synchronize_irq() and disable_irq(). The ordering above was the
reasoning for the implementation, rather than the suggestion alone.
It was not based on an RT priority-inheritance analysis or a measured
performance comparison with a spinlock.

[0] https://lore.kernel.org/all/20260909085434.C8F201F00A3A@smtp.kernel.org=
/

> Then, I'm curious to know how the AI justifies the use of disable_irq()
> as the RT-appropriate choice: doesn't it block without a timeout on the
> very IRQ thread the scenario relies on being starved (and gives no
> priority inheritance)?

Yes, it waits without a timeout and does not provide priority
inheritance. I would not present it as the better choice for bounded
RT recovery latency.

A spinlock_t-based implementation can provide priority inheritance on
RT, provided the handler holds it from the status/enable reads through
the register updates and complete(), with corresponding protection in
the waiter. That improves recovery under priority inversion, but adds
locking to normal interrupt handling and wait setup/cleanup.

There is a real limitation: if the IRQ thread remains starved, recovery
cannot finish, and other NAND operations can remain blocked behind the
controller lock. So the operation timeout does not bound the entire
cleanup. The argument for this implementation is the straightforward
handler-lifetime boundary and absence of additional normal-path
locking, not that error-path latency can never matter.

>
> Thanks,
> Miqu=C3=A8l
