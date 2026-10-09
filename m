Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45D939B970;
	Fri,  9 Oct 2026 16:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791561620; cv=none; b=oUwmPDknAOfTeMRqnJ7ujDaSGW3muui2rV4pwzeu8uHb7EdqbHJrHFI0kZQBw+uKKD4tSEGcutF27TT66orAO1iEgy8Qv1zECLNXrXrZB6etc6tO9ZXDVMGWB5hLvHkapZIEcgXVxsXEne8LF7Q+52L8VHpXm0nFBOEPtaEWAOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791561620; c=relaxed/simple;
	bh=qaAdILM3CMjzMUnepXGcDG9HL6mZmTo+JdQvryy+9os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+U0bG1ZRCZrjGPdRVLkBCYfBS0SiQynRYe937skoZDx8h5SeZ7suc6a+WMY49lPYnOu9cqtTzULe8FXa9lYGYbwva+EmYzt+l6wuPn8p094Gt+vN1zHcZEXpczSAOLmL9gSP5/HyI7ZjeR17ILitQ/KA6MFZ5E/lH9IUfK9MV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XjTOJBme; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WIvWdH/c; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XjTOJBme";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WIvWdH/c"
Date: Fri, 9 Oct 2026 18:00:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791561617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GHEUoBUYZxg9IObMlPuW6xttti1DW7KdgFxwRUKho9g=;
	b=XjTOJBmelnNySZPZJtHgRBq8T8fd2/wQwKg4e3OmS1xmgCtkXeE8WR1wiBVe1XLaDMs/QZ
	J5uShhdeIjSITCT60/dNDzXtR8Oba0+fBKml4lyEOrRr579peJxUHB+up0k2fOLg4K91zD
	C3Yv8EW13lKDyFvIbofSUZBTWbao09KufhOIa9Vn9c9rpYEsUWoPuiTn9YglGuPRq0KDRQ
	8qUjsLE/VuB2d4zOEUq+IbnfRBEyR9wQiNhX3meAwRWoChKynPo0cN2G8bTWnRAWbz+Hbt
	mVJsHxQI6JmXqeHfFPN82WHr9yCtYa6PeF/PBm423YU3X2OL53iaXEFxKs5QhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791561617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GHEUoBUYZxg9IObMlPuW6xttti1DW7KdgFxwRUKho9g=;
	b=WIvWdH/cHjj533zX6iAsJnCqt6eXTdxUSsvbapXKD9i5t4GFJsSRd08GfxkVaAQuSlTtWf
	kIjciUZdI9dhiOBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: linux-wireless@vger.kernel.org,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] wifi: brcmfmac: avoid sleeping tx locks in netpoll
 contextg
Message-ID: <20261009160015.9YCN8Lt-@linutronix.de>
References: <20260930185417.61865-1-kmehltretter@gmail.com>
 <20261001075755.3MilPS2C@linutronix.de>
 <ar7vLt5kQ2HJoJY9@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ar7vLt5kQ2HJoJY9@gmail.com>

On 2026-10-02 01:41:51 [+0200], Karl Mehltretter wrote:
> On Thu, Oct 01, 2026 at 09:57:55AM +0100, Sebastian Andrzej Siewior wrote:
> > On 2026-09-30 20:54:17 [+0200], Karl Mehltretter wrote:
> > > This fixes the direct SDIO transmit path used by fcmode=3D0. Modes 1 =
and 2
> > > take the FWS lock first and need a separate change.
> >=20
> > Is this the only affected driver?
>=20
> I also reproduced a sleeping-lock warning with 8139cp on PREEMPT_RT
> using QEMU's RTL8139C+ device. Enabling a dynamic netconsole target caused
> the printer thread to enter cp_start_xmit() with hard interrupts disabled:
>=20
>   BUG: sleeping function called from invalid context
>   in_atomic(): 0, irqs_disabled(): 1, pid: 107, name: pr/netcon0
>   hardirqs last disabled at netpoll_send_skb+0x1c8/0x3d0
>   rt_spin_lock
>   cp_start_xmit+0x31/0x8b6 [8139cp]
>   netpoll_start_xmit+0x18e/0x260
>   netpoll_send_skb+0x37a/0x3d0
>   netconsole_write+0x56d/0x820
>=20
> That was one reproduction on the netdev base a7bfaba4823e. I have not
> established how many drivers are affected.
>=20
> Source inspection also identified 8139too and macb as candidates: their
> transmit paths take ordinary spinlock_t locks. I have not reproduced the
> warning with either driver.

I just replied to the netconsole thread where I did suggest to lift the
local_irq_save() part. This would obsolete this.

> The earlier netpoll/NBCON discussion concerns NAPI polling and
> scheduler-lock deadlocks, rather than this driver-lock warning:
>=20
> https://lore.kernel.org/linux-rt-devel/20260618111554.2n0pP_O9@linutronix=
=2Ede/

There was no fan club behind this change and PeterZ hated it so I
dropped it.
But this deadlock should not happen with nbcon or do I mix up things?

> > Do you have maybe a backtrace?
> >=20
>=20
> This is the original Pi 400 report on 7.3-rc3 with PREEMPT_RT. That kernel
> also had unrelated allocation-test patches applied. DEBUG_ATOMIC_SLEEP
> was disabled, so this report is the BH-disable warning:
=E2=80=A6

I don't mind if you have something to optimise the driver. But as far as
the netconsole part goes, I would try to kill it at the upper level so
the driver is not affected.

> Thanks,
> Karl

Sebastian
