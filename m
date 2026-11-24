Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795536783;
	b=0gQKUrjRpoezEtco5Dz7wa4SK+EAWpL0dw5UhVq1arZ7yHX4xn/EJEkgLSmSA6TMAI/r
	 gQSii4lB1MFuA2BOfgHleS4SZ9H4Hn5EEqoU0NUJAlPFVlnIVx5HFo5+vmMjxrGdhlqpv
	 2X+XD7AgaEjAr54F2rZV+5lttifWakqKe9k10YnbTTOhJqEIHB7i2dAXpxtmW6jYEGlIO
	 dP9doS1OhGqniL/XSJQ0XCt3hdj/aABNCZ+K7YCu7eaJrL9/qNNM89LwUD2zcl30FFptk
	 WyqO/isWu1Fr+CHdT+QPF/o+3c4LqVsJB3HEekx0OEwgRD4HNDNfZahrbi4N1jQaY5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795536783;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=6ABt+1NP35P44bJHQ15Q5p7RXKaacPi/rMPqE9NPrfA=;
	b=VQtapqg8IRJ31ko7hvzYcV/n6riA5t7lNMaTOvFHFcm7AOx9XzG3eYjW+5d2w2Tgtq0m
	 KWEflPYxTo+8bIJZSMkcyQUGSRBcM+L/0nArSba4TEithkTaGpEu+HyUsnrLygUVMKSck
	 mZYHRnDmcdhUCebkplt2uRidiyQ01LFgtSYZdAeR2dRe17UKK7ZtZjwtS1s/rAgi7LTtL
	 Oeg7XwAokhYUxFG/HzmguK/ysczPU9ESTgZOscpKMnzvkRToXpbUnw/iLFo5OHbhRTjMg
	 8VW+89M6tt/EnNZOtK+uzKZjsa0nnjRK/hbIzlXP8oS2Nng3mk1X9VV4mtAkwCPiQWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=fNMFu2nt;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=LYdg5Av8;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D596606A31E;
	Tue, 24 Nov 2026 16:13:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D596606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=fNMFu2nt;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=LYdg5Av8
Date: Tue, 24 Nov 2026 17:12:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795536781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ABt+1NP35P44bJHQ15Q5p7RXKaacPi/rMPqE9NPrfA=;
	b=fNMFu2ntSulqEHYe4h7y6ycct4JNoq2GqIx9OqKd+TwHIkXyOaclXzrzHbhQ1/KSX+PboM
	Cj5y/vps7iirji8LNFhnM1SN5anzPczdVVSiDLkTaiSTlwZV/39mKyGHrzUkWwa83YiOyW
	fQR6zwJocsmNpVO2cr/QX8kM3Hc+j7FChur6nLWjPySNulksxAZR5LPBt9SsRuN03WUDn0
	HW2W5JlwBRIPAbkm1wLmiACFDnS2TfLn/QO7jxsG1W5X+jpKrlLTM1jyUYIn9o8jicgjCM
	fRhG5culoSAX/H8Wr3Oh5J3jeUmlFhSdgUqaNj49/THudvaiwlIZqHDKkG0tjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795536781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ABt+1NP35P44bJHQ15Q5p7RXKaacPi/rMPqE9NPrfA=;
	b=LYdg5Av84vm0RSHLB3wLnsa7EGqxCm8Ba2Uxc+EHN1WxpbQlAmkT255y4hbIfnLw6px0PA
	jTRjqg8K8ChobHBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev,
	Victor Nogueira <victor@mojatatu.com>, Po Liu <Po.Liu@nxp.com>,
	stable@vger.kernel.org, sashiko-bot@kernel.org
Subject: Re: [PATCH net v4 2/3] net/sched: act_gate: refuse schedule entries
 shorter than 10 us
Message-ID: <20261124161258.vLyrm8Y4@linutronix.de>
References: <ACT-WEXM.v4.r0.20261124074514@mojatatu.com>
 <ACT-WEXM.v4.r0.20261124074514-2@mojatatu.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ACT-WEXM.v4.r0.20261124074514-2@mojatatu.com>

On 2026-11-24 09:12:09 [-0500], Jamal Hadi Salim wrote:
> This is a followup of commit a51c328df310 ("net: qos: introduce a gate
> control flow action") as reported by Sashiko.
>=20
> The issue:
> fill_gate_entry() only rejects an interval of zero, but that interval is
> the period gate_timer_func() re-arms the hrtimer at, and a few
> nanoseconds is below the cost of servicing one expiry: the next is due
> before the current one finishes, so the action holds a CPU in the timer
> softirq for as long as it exists.

The timer is programmed in the past, fires immediately and hogs the
CPU.

> On a 2-vCPU guest, entries of 1 us and below hold 86% to 90% of a core,
> 2 us holds 61%, and 3 us holds 22%; from 3.5 us on the cost falls to a
> few percent and it reaches zero by 100 us.
>=20
> The Fix:
> Require at least 10 us per entry.  An act_gate schedule is not tied to a
> device, so unlike taprio there is no frame time to derive a bound from;
> the bound has to come from the cost of servicing one expiry, with room
> for a kernel that services it slower.

The 10us sound sane. With enough debug (say kasan, lockdep, =E2=80=A6) this
might become tight again.

=E2=80=A6
>=20
> Fixes: a51c328df310 ("net: qos: introduce a gate control flow action")
> Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>

There is no syzbot report for this?

> Closes: https://sashiko.dev/#/patchset/tencent_4ED9536B0375C96183B2244CF7=
709768C605@qq.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

> --- a/net/sched/act_gate.c
> +++ b/net/sched/act_gate.c
> @@ -25,6 +25,11 @@ static struct tc_action_ops act_gate_ops;
>   */
>  #define GATE_ENTRIES_MAX	1024U
> =20
> +/* An entry shorter than this lets the next expiry land before the softi=
rq
> + * servicing the current one can finish, so the timer stays permanently =
behind.
> + */

No strong opinion. I leave this here.

| With a too small interval the next timer will be programmed in the past
| and will fire immediately.

> +#define GATE_MIN_INTERVAL_NSEC	10000U
> +
>  static ktime_t gate_get_time(struct tcf_gate *gact)
>  {
>  	ktime_t mono =3D ktime_get();

Sebastian
