Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794124057;
	b=5qMh5BwZxAtJ0VkK8zlTPBjSgVmNlng/gG3SLjC335nB2zv7+L2UkQnD3E8Wh8mL2en7
	 Dk/28+cYzWvjgAGXQcz17XPALSSuJ0YBuAhLCT7hGNADxa7NwgaZcisgzyvSIFZDULUxR
	 +ZO+q3mIWWgN5eGdqubr14OnEpobI3Dl5zJmP6RurfOcdTeg78m8a65gwMaUaA9+yslgD
	 FmlDckPaeQLpMxUOEYMeM+d6OodOm7MAEDFCR5QrvLWZfeBj9R4rbnk8GyUstIyqwMgSV
	 64CpTxW575oy3K22I++vRnRuiiwFgD0eveGwB+RASKxV7KMYqLhMaqdZwY/wwoibxhg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794124057;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=+3u+1mXse830YNAARv07fietRfMx8v03rEL53YZE7+Q=;
	b=C06WCKD3CSegMrp0gSrpHJHLuylEQpIE3QAz7mex7MDsgl+3GMK8bK7UDr+dqooj+4aJ
	 GiSdU2h2MsV8y9kG7KS10qL0aPaToWPdxuo4uA0UA3fyX24DTwlUB2jWcHPlpNYMuSOac
	 kC4NSsZ0Uf5Vu478BjXYBfthED6DBrzt+/VZ3xNCicKXrqqwGH9j2owS/vF0Zc4uN1Rjf
	 B39viraJGuUJv1KOvaiu3UYPjb6+wsUaN+QjOUlQVjvkDaTscImMXyFEWrn38rrW7Bos7
	 Zb9xlYIoVZZQtbtBjrhDxhG/F74cBQDJNib1umjdHvXTLw74G+AcxQAkVm/OZ6ck3ng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vTXaTsIV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B04E606A31C
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 07:47:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B04E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vTXaTsIV
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-14394530ec6so256707c88.1
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 23:47:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794124056; cv=none;
        d=google.com; s=arc-20260327;
        b=qFjhCtsDHY4eHCC8XnlQwNVphKCTC0ZZVTGJxHbND0A4rd+XQ124zttPgwpdSxd5fz
         qEiMIm731H+TIFbCnNNc3QVCv03vyCVsuCigLzfUbWFvBVDVCULUkAY5gqlYTiJlHlqO
         dkdrQa1j2uqa+TYX5OJKPtADmduueCALxJTkeL03zDtJJAb3FD5xJ2a94nDDo0a+sy9l
         ykgcpnVDxR5FIyQ9jKz2u39QGRV40Y7xPZsLo6HXAzecR3pZW7KceceiO5PdyqXi/xNG
         5hhzSGUJY8Z6PgAeXGo+EtzhsZN7gvxtRLHZMhnzwVTd2tfA09hMIaUV79DXTlPpMEuq
         pg4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+3u+1mXse830YNAARv07fietRfMx8v03rEL53YZE7+Q=;
        fh=MwgXjp8wAt6e1xMc++NULmS81DjfnpkHdadNBjdkmqU=;
        b=VHSbPUt3a+0IBTK66SwH3gWIL9vJbVmbJsMvlT3+G8WQlOI0ftSG0NcrCYwG6+CYs5
         WyOHvSzMUZa6O0cre+yLV/l8CPV2WgWjvWuxEQG2j4qWAdaJtZEcr0EvLZEjkH6MRhxI
         XwpByw+hd2ZeqiQbwSaflNsx0iq1TpSS1Clxn9WUFb5hs6a5e8e03/iP35RqHtbM3sYU
         DvYOx8MBa7OpExfLw7dkuVPkW9gIPn2xNkgRNEBDIFHOVvRDkhfhm4jG7KzibKlMSRI9
         buS9PJO16avWGysv0pB+ABzCvA+Di+MbMAd1Ok3SFAcKBsvrBBHPZvfxk2LtGoeY/Koz
         WI/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794124056; x=1794728856; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+3u+1mXse830YNAARv07fietRfMx8v03rEL53YZE7+Q=;
        b=vTXaTsIVp2bR/FEn7rIldrR++PsdwOMJyYtmAqqyV/mDS5FYpyTDDA4jvfii+LqwP+
         dXDGNeUJqSzOq720bWED35E6uPf9P2SPF9Hg1pzx6rCH96jgcZz28YaTNp3Z1IGsPr7S
         8hR4qe434K+8/UnJkzs+z5h+oOqwuU7gZK3YuHzm3jLw96AmPSHgohYJz9Jmb/inmh55
         uoNmaG98bBFQGgfoiKF8jfgQ6KgMUzIVoMUbsfll6/oTOIkVz56p5Reyc4wo9x/6JQv1
         f2zYlBegngvN44lct/a46gC51rhYNVnzLgrq/RAw03TtYqDOcYroh+FyJ6Jn8QDYnsSe
         R2OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794124056; x=1794728856;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+3u+1mXse830YNAARv07fietRfMx8v03rEL53YZE7+Q=;
        b=Mq5Dji9+kJnwBBO1k8NKcrm6cM/+1Yqpes1kmQYu2SPLoKh/LC9BTnSnNX5ZegZY1T
         w35Y8IgG8gLDm5IqcQ2gG4dqh5kepT8s0MUufdzntO5pISNc6IOU+MviD5K68+6EMRcZ
         9tLWlQLcex3IrJPSkhKFrd4yUpi52Pam863D5ddfFPmGprGtr+nEKdyt6/5G8LTnTuHz
         YouUHivp0KsxxysjyHjJTf17tYNu9Mi9rVe0n2MkGbus8hqXbzr27PIO8cvNHlUxVhH1
         fEgWz+G2VP1+G3Rlb/I9dRQnv1w90NsxbZVEclgQRj+KqpwRjy5kXyQqHOiQ1q1iB3Bc
         LUzA==
X-Forwarded-Encrypted: i=1; AL+hErGWKJO0JxT0OyV5EgTp6FJS1W2zSja4496imahLjO18iH06WAlvrCk/OQaAqmwZ3MTbU+uUs8U=@vger.kernel.org
X-Gm-Message-State: APuU4Z9rVmXlsg6EPhaVaZqLbKSdz5K2dlS9jsI2iYnFbmYrfUWyoiA5
	4ZdkDayAcM5cYyHPFkJKhNZ+3/269JDMo53GTFj5LwUfD/8RMUOUHpgQhvAxPccDzqeqYeJPHKK
	U/VnVMPUJl/K0e+rI89gSkX8AgP2t5Gw=
X-Gm-Gg: AYBFou2jHeOi6dEgWHV4igJLJYWiiANrGoTdfiZKqaN9WFn8YIR6PdUFLYYiMUA+Tda
	ZIztM8ZQ44M1rdBBYSZE/176nbkp8qxu8zechzuD4j3p2ydT7/296RHr3V3nFo0ojwN5JZgG3Ju
	6la0zmjCRHmVNlI9Ac6+q7N4z2z52g7aM4i4SAGfzlU5UZI/QyT6yaZOvEYg4Zou1f4mcf01LIR
	6+/VB/lZE/c1Qdf9Agvbxhi38z/FK1twAp8KG1eyISXcnzSK0PiNDrByBE5MVcKM5aTRiZ6FVNi
	QvUXKh9w66BUHXGrDS5pjEXH4vwIPKj4Y2JDI6PKVTxver29maXynyMvZXpCwAZvFnho8mpbEYF
	gKvu+BhSo9RbLWy0TTmsS98+r7jQngYSrJjvrGw4GCY3PjDUJyOhbYAyVqU8DLeNfECc+
X-Received: by 2002:a05:7023:d08:b0:1a4:4194:fc04 with SMTP id
 a92af1059eb24-1b39fee24c3mr1357876c88.28.1794124056106; Sat, 07 Nov 2026
 23:47:36 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261107063726.3388730-1-hj351016@gmail.com> <179412117075.994134.3223982666310946745@kernel.org>
In-Reply-To: <179412117075.994134.3223982666310946745@kernel.org>
From: khj <hj351016@gmail.com>
Date: Sun, 8 Nov 2026 16:47:23 +0900
X-Gm-Features: AclHuK87SL6WE7SWisw0Zo0rIquffDMZDke6cCWcKrt96_L0Ez15ObIZ4QBMLWU
Message-ID: <CAGr5VtOgm523z1mPuScHLaAYypQjSj=eOZqvn63cKet_sLTC-Q@mail.gmail.com>
Subject: Re: [PATCH net] net: ti: icss-iep: fix deadlock when disabling PPS
To: netdev-bot+sashiko@kernel.org
Cc: danishanwar@ti.com, rogerq@kernel.org, netdev@vger.kernel.org, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, this is a good catch. All three are the same underlying point:
dropping ptp_clk_mutex before the drain lets a work item that was already
queued (or latched by the IRQ just before the compare was disabled) run
icss_iep_cap_cmp_work() after PPS has been turned off, where it re-arms
CMP1 and emits a stale PPS event.

v2 fixes that by guarding the handler: it now returns early, under
ptp_clk_mutex, when neither pps_enabled nor perout_enabled is set, so a
late or stale work does nothing instead of touching the (just-disabled)
compare hardware or emitting an event. That covers the "handler already
blocked on the mutex" case and the "pending work starts between unlock and
cancel" case.

On the concurrent-sysfs window (pps_enable_store / period_store not
serialized against the ioctl path): with the guard, a work cancelled by a
disable that races a fresh enable simply bails if the enable has not yet
set the flag; I don't think this patch can fully close the ptp_sysfs
serialization gap, which predates it.

On the pre-existing perout/teardown issue you flagged (High): you're
right that icss_iep_perout_enable(.., 0) never drains iep->work, and that
icss_iep_exit() clears iep->ptp_clock before the perout disable runs, so a
work queued during perout can still reach ptp_clock_event() on teardown.
The handler guard reduces but does not fully close that, because on the
teardown path perout_enabled can still be set when the work runs. I'd
prefer to fix the perout-disable drain and the exit ordering as a separate
change rather than fold a teardown rework into this deadlock fix =E2=80=94 =
happy to
send it as a follow-up unless you'd rather have it here.

Not tested on real hardware (no TI ICSSG/PRU device); the above is from
code inspection.

pw-bot: cr

2026=EB=85=84 11=EC=9B=94 8=EC=9D=BC (=EC=9D=BC) =EC=98=A4=ED=9B=84 3:59, <=
netdev-bot+sashiko@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 (1) =C2=B7 Medium: 3 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The patch moves cancel_work_sync(&iep->work) out of the
>   ptp_clk_mutex critical section in icss_iep_pps_enable()=E2=80=A6
> - [Medium] After the patch, an icss_iep_cap_cmp_work() instance can run
>   after icss_iep_pps_enable(0) has disabled and cleared the compare=E2=80=
=A6
> - [Medium] The commit message says that because the compare is disabled
>   before the drain, 'no new work can be scheduled once the mutex is=E2=80=
=A6
>
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but the shared
>   iep->work is never drained when periodic output (perout) is disabled,=
=E2=80=A6
>
> --
>
> net: ti: icss-iep: fix deadlock when disabling PPS
>
> This commit moves cancel_work_sync(&iep->work) in icss_iep_pps_enable()
> out of the ptp_clk_mutex critical section. The PPS disable path then no
> longer waits for icss_iep_cap_cmp_work() while it holds the mutex that th=
e
> work handler needs.
>
> > diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.c b/drivers/net/eth=
ernet/ti/icssg/icss_iep.c
> > index ec085897edf09..6264061a4eab3 100644
> > --- a/drivers/net/ethernet/ti/icssg/icss_iep.c
> > +++ b/drivers/net/ethernet/ti/icssg/icss_iep.c
>
> [ ... ]
>
> > @@ -607,7 +608,7 @@ static int icss_iep_pps_enable(struct icss_iep *iep=
, int on)
> >       } else {
> >               ret =3D icss_iep_perout_enable_hw(iep, &rq.perout, on);
> >               if (iep->cap_cmp_irq)
> > -                     cancel_work_sync(&iep->work);
> > +                     drain_work =3D true;
> >       }
> >
> >       if (!ret)
> > @@ -616,6 +617,15 @@ static int icss_iep_pps_enable(struct icss_iep *ie=
p, int on)
> >  exit:
> >       mutex_unlock(&iep->ptp_clk_mutex);
>
> [Severity: Medium]
> Once the mutex is dropped here, can icss_iep_cap_cmp_work() run against
> compare hardware that has just been disabled and cleared?
>
> There seem to be two ways for this to happen:
>
>   - A handler already blocked in mutex_lock(&iep->ptp_clk_mutex) now
>     continues. This is the case the patch fixes.
>
>   - A work item that was pending but not yet started begins running
>     between mutex_unlock() and cancel_work_sync(). In that case
>     cancel_work_sync() only waits for it to finish.
>
> The handler doesn't check pps_enabled or perout_enabled after it takes th=
e
> mutex:
>
> icss_iep_cap_cmp_work() {
>         mutex_lock(&iep->ptp_clk_mutex);
>
>         ns =3D readl(iep->base + reg_offs[ICSS_IEP_CMP1_REG0]);
>         ...
>         ns_next =3D ns + iep->period;
>         writel(lower_32_bits(ns_next),
>                iep->base + reg_offs[ICSS_IEP_CMP1_REG0]);
>         ...
>         pevent.pps_times.ts_real =3D ns_to_timespec64(ns);
>         pevent.type =3D PTP_CLOCK_PPSUSR;
>         pevent.index =3D 0;
>         ptp_clock_event(iep->ptp_clock, &pevent);
>         ...
> }
>
> icss_iep_perout_enable_hw(on=3D0) has just written 0 to CMP1_REG0/REG1. T=
he
> late handler would then set CMP1 to 0 + iep->period, which undoes the
> "clear CMP regs" step. It would also send a PTP_CLOCK_PPSUSR event with a
> zero (1970) timestamp.
>
> pps_event() doesn't check whether PPS is enabled. It records the assert,
> increments assert_sequence, wakes /dev/ppsN readers and calls
> pps_kc_event(), all after userspace has turned PPS off.
>
> Before this patch, the blocked case deadlocked and the pending case was
> cancelled under the mutex, so this behaviour is new.
>
> Should icss_iep_cap_cmp_work() return early under the mutex when neither
> pps_enabled nor perout_enabled is set?
>
> >
> > +     /*
> > +      * Drain the capture-compare work only after dropping ptp_clk_mut=
ex.
> > +      * icss_iep_cap_cmp_work() acquires ptp_clk_mutex itself, so call=
ing
> > +      * cancel_work_sync() while the mutex is held deadlocks when a ha=
ndler
> > +      * instance is already running and waiting for that same mutex.
> > +      */
> > +     if (drain_work)
> > +             cancel_work_sync(&iep->work);
>
> [Severity: Medium]
> The drain now runs outside ptp_clk_mutex and doesn't re-check
> pps_enabled or perout_enabled. Could it cancel work that belongs to a
> later enable?
>
> pps_enable_store() and period_store() in drivers/ptp/ptp_sysfs.c call
> ops->enable() without ptp->pincfg_mux. That means they aren't serialized
> against the PTP_ENABLE_PPS ioctl path or against each other.
>
> One possible sequence:
>
> CPU0 (disable)                       CPU1 (sysfs enable)
> icss_iep_pps_enable(iep, 0)
>   pps_enabled =3D false
>   mutex_unlock()
>                                      icss_iep_pps_enable(iep, 1)
>                                        program CMP1, set CMP_EN
>                                        pps_enabled =3D true
>                                      first CMP1 hit:
>                                      icss_iep_cap_cmp_irq()
>                                        schedule_work(&iep->work)
>   cancel_work_sync(&iep->work)
>     removes the new session's work
>
> icss_iep_cap_cmp_work() is the only code that moves CMP1 forward. Once
> its work is cancelled, no further compare events or PPS pulses are
> produced, while the driver still reports pps_enabled =3D=3D true.
>
> The other order is possible as well. Suppose an old-session work instance
> is blocked in mutex_lock() and gets the mutex after CPU1's enable. It
> would read the new boundary B from CMP1, write B + period and send a
> PPSUSR event stamped B before time B arrives. The first real edge of the
> new session would be skipped.
>
> Before this patch the cancel ran under ptp_clk_mutex, so a concurrent
> enable had to wait for it.
>
> [Severity: Medium]
> The commit message says:
>
>     The hardware compare is
>     already disabled by icss_iep_perout_enable_hw() before the drain, so =
no new
>     work can be scheduled once the mutex is released.
>
> Is that guaranteed? icss_iep_cap_cmp_irq() reads pps_enabled with no lock
> and no ordering against this path. Nothing calls
> synchronize_irq(iep->cap_cmp_irq) before the drain:
>
> icss_iep_cap_cmp_irq() {
>         val =3D readl(iep->base + reg_offs[ICSS_IEP_CMP_STAT_REG]);
>         if (val & BIT(1)) {
>                 writel(BIT(1), iep->base + reg_offs[ICSS_IEP_CMP_STAT_REG=
]);
>                 if (iep->pps_enabled || iep->perout_enabled)
>                         schedule_work(&iep->work);
>         ...
> }
>
> Suppose a CMP1 hit was latched just before CMP_EN was cleared, and its
> handler on CPU1 has already read pps_enabled =3D=3D true.
>
> CPU0 can then set pps_enabled =3D false, drop the mutex and call
> cancel_work_sync(). That call returns immediately because nothing is
> pending.
>
> CPU1 then calls schedule_work(), and the work runs after PPS has been
> disabled.
>
> On teardown, ptp_clock_unregister() -> ptp_disable_all_events() ->
> icss_iep_pps_enable(0) runs first. After that the pps source and
> ptp_clock are released, and icss_iep_exit() sets iep->ptp_clock to NULL.
> A work item queued this late could call ptp_clock_event() on a freed or
> NULL ptp_clock.
>
> On PREEMPT_RT the handler is force-threaded and can be preempted between
> the flag read and schedule_work(), so the window is wider there.
>
> The old code had the same race with a larger window. However, the commit
> message's argument depends on this window being closed.
>
> Would a synchronize_irq() after clearing pps_enabled, together with a
> state check in the work handler, close it?
>
> > +
> >       return ret;
> >  }
> >
>
> [Severity: High]
> This isn't a bug introduced by this patch, but the perout disable path ha=
s
> a related problem. icss_iep_cap_cmp_irq() also queues iep->work when
> perout_enabled is set, but icss_iep_perout_enable(..., 0) never drains it=
:
>
> icss_iep_perout_enable() {
>         ...
>         ret =3D icss_iep_perout_enable_hw(iep, req, on);
>         if (!ret)
>                 iep->perout_enabled =3D !!on;
>
> exit:
>         mutex_unlock(&iep->ptp_clk_mutex);
>
>         return ret;
> }
>
> On teardown, icss_iep_exit() unregisters the clock and sets it to NULL
> before perout is turned off:
>
> icss_iep_exit() {
>         if (iep->ptp_clock) {
>                 ptp_clock_unregister(iep->ptp_clock);
>                 iep->ptp_clock =3D NULL;
>         }
>         icss_iep_disable(iep);
>
>         if (iep->pps_enabled)
>                 icss_iep_pps_enable(iep, false);
>         else if (iep->perout_enabled)
>                 icss_iep_perout_enable(iep, NULL, false);
>         ...
> }
>
> The ptp_disable_all_events() call inside ptp_clock_unregister() only
> disables EXTTS and PPS. The PPS disable returns -EBUSY while perout is
> enabled, so the work isn't drained there either.
>
> Can a work item queued while perout is active run icss_iep_cap_cmp_work()
> after this point? It could be queued before teardown, or by an IRQ that
> arrives before CMP_EN is cleared. If it runs, ptp_clock_event() would use
> a NULL or freed iep->ptp_clock and pps_device.
>
> This can be reached from ndo_stop via prueth_emac_common_stop(), or from
> prueth_remove(). It needs an IEP with an iep_cap_cmp interrupt and the
> icssg_prueth clockops, which set n_per_out =3D 1.
>
> Also, iep->ptp_clock =3D NULL is assigned without holding ptp_clk_mutex.
>
> Should icss_iep_perout_enable() also call cancel_work_sync() on disable?
> And should icss_iep_exit() drain iep->work before it unregisters the
> clock?
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261107063726.3388730-1-hj351016%40gmail.com
