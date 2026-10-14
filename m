Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C1353162A;
	Wed, 14 Oct 2026 15:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791991126; cv=none; b=I24IIaaQc17RY+EjNmgM5hdCByvC2KCFHE2wy2zZwh+g47MDXtlpZsVYV+eYjrBd2ma6WbvurpQ8CvDmxoAna+JXc4c/2s8nRZMVROKrymySaU5t2euoVp3TreBPXuc4xL8dhEE6ZJ73X9E8rSNgSvitzmYf0Mt0MV+VIOUjKQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791991126; c=relaxed/simple;
	bh=wZdjWgb2NT+vzgnTlPr7fPSSVUJ3ymSYaIFCWHLM2ZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcjFoBZPrPKQ5dvkqOq8Ks8mCXl5Kcz0CrOn0VdEvremhKm09QXzpqVGcy1XJJ7X3tW+Iwn0xgAzCYLI+hxBIvMXG8EFa9WqcjX0mjm1nQWJUoPE1H2JLRoCNQfAjphBBFASwQDma+hgTSJgYV1DDfmJmO/zAT6rg33Z6wfGF3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gqP11io2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kdapR0i2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gqP11io2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kdapR0i2"
Date: Wed, 14 Oct 2026 17:18:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791991119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3VSLCeFmF65RLXMr+lpZPrtUt8NDrMnmjDiLSUsI+rQ=;
	b=gqP11io2/qEsXWgDGZBxYdXuca8xI8ITMl/bW+oV2F+hzQ348BDGiwjT/SvcsqTJ8vveZL
	4KgXM6m4nTYukmO9uU5cS9JkvPS3z59qGa60iot5Ss3os/M7wagIaC3CmIjXBDQ0ulvMg8
	fK7qWdLtVDZ2bWFQZOh1Q2LfEVkG1+LkapexfuMufvZRmsnwiARcpmBao5KbTn5OjrVFgG
	wmlyX1dieCHSSlvbFAmy0yozlkz3voAHB3NeRmgh/wUR6Jt9ii/FMg72eDbrnPipYq6rgH
	VIPNcPezgDL+XIIRk9gSMZ+5pyfe/iOdLbI6+d/QRHjrZifjXjE66ppQc41Frw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791991119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3VSLCeFmF65RLXMr+lpZPrtUt8NDrMnmjDiLSUsI+rQ=;
	b=kdapR0i2102at6jWmEphHIl/0nk8fmGunszsqpl9TsVv+k61KxT7nF5tJPm4bRMTE6zyo7
	NyeYbz3rgnJo3AAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Xin Xie <xiexinet@gmail.com>
Cc: liuhangbin@gmail.com, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	andrew+netdev@lunn.ch, shuah@kernel.org, kees@kernel.org,
	petr.wozniak@gmail.com, qingfang.deng@linux.dev, fmaurer@redhat.com,
	luka.gejak@linux.dev, xiaoliang.yang_1@nxp.com, skhawaja@google.com,
	stable@vger.kernel.org, sdf.kernel@gmail.com,
	syzbot+fbf74291c3b7e753b481@syzkaller.appspotmail.com
Subject: Re: [PATCH net v7 2/4] net: hsr: preserve submission order without a
 forwarding lock
Message-ID: <20261014151838.6RyMIRVM@linutronix.de>
References: <20261009201324.17-1-xiexinet@gmail.com>
 <20261009201324.17-3-xiexinet@gmail.com>
 <20261014134718.YGcKmfB9@linutronix.de>
 <003d3e2a-3568-44f6-a9cc-3202de60da58@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <003d3e2a-3568-44f6-a9cc-3202de60da58@gmail.com>

On 2026-10-14 16:48:55 [+0200], Xin Xie wrote:
> > What are stacked HSR devices? Looking from the setup in the referenced
> > report this is a bridge device attached to a HSR ring.
> > An announce frame is sent and this goes to hsr_dev_xmit(). This does not
> > look like a normal setup. Is this something you use or is this something
> > the bot came up with?
> It is the setup from the syzbot report, not something we use. In that
> report the slave port of one HSR device is a bridge, and one bridge
> port is a second HSR device. The announce frame of the first device
> holds its seqnr_lock, goes through the bridge, and ends in
> hsr_dev_xmit() of the second device, which takes its own seqnr_lock.
> Lockdep sees the same lock class twice and reports it. With two
> devices this is not a real deadlock. It only becomes one when the
> transmit path comes back to the same device.

Okay. In that case, could you please teach HSR to reject bridge ports at
the very least?

Given that HSR is a ring and PRP faces two networks, I don't think a
bridge setup would make sense here. So rejecting this should be any easy
fix.

=E2=80=A6
> So for v8 I see two simple options:
> (a) Keep seqnr_lock across the submission like today and only break
>     the re-entry: a frame that enters HSR transmit while this CPU is
>     already inside HSR forwarding is dropped and counted. Ordering is
>     kept, but all forwarding of one device stays serialized.
> (b) Narrow the lock to the counter update, as in v6 and in Hangbin's
>     patch [1]. Several CPUs can forward in parallel. A receiver without
>     the bitmap discard can drop a reordered frame, so the patch would
>     carry "Cc: <stable@vger.kernel.org> # aae9d6b616b5: ..." as Simon
>     suggested there, and the TX statistics move to per-CPU counters.
>=20
> I would prefer (b) because of the parallel forwarding, if the old
> receiver limitation is acceptable to you. Otherwise (a).=20
>=20
> Hangbin, Simon, your view is welcome too.
>=20
> Patch 3 works with both: it segments before the lock, and each
> segment is numbered and submitted under the lock.

Or (c) tell HSR to reject bridge ports. This should avoid the case and
the problem.

Sebastian
