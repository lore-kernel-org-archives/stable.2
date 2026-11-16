Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794854065;
	b=wp4ROMF0YO4Waai4NyXF/yRH22v5Ldyi2YTkpDjmORIKq2jtlPUIIa0lLs00g8s/cjdy
	 39oByMoK9rDulWvInwz9096NX3g3GG0PzXuQEIuIFoFGgUdPCNgNBu1+nT6rsvjQOZp75
	 KLx0R+5q1/dt/Mw6KbVYswkkU3XrU5+gMLt+H3mOsw4Lo+utMLPrBz9xEIRJjyiE34BR2
	 YfjnEt5g+EpQoWDwdMlRpQCnt9iorOZpnunmsFq/epeSdMalI1qizk96WvViCU7w0VuWa
	 wN4KDN0lBbCYwn30e9Tkmj+e4fyVV/cmYGDUjXsox2vNIFPGr6dbHXCsfaxAjnUmttQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794854065;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=xE4/pjASkUAynmBsoopUVVAbaBNyN5sM4lhvVCjAw+I=;
	b=EWYTmLAJxjKFjyaYcOB+tnEoDFPhNLwCT4ormDTr8HclEkU7R4Ibs1d4e78VeaSOpRjD
	 85GTOah9WSxzl624+RDBiVO1U0cOGbUwZqP+6+PBxyIwKR1gHPyA9CZDhtemq3KfXYegs
	 AR4vdsO9u22wL2u9r9rjRYu8bsTiRgToPgAragaTdoedfUCUe+pjQoVMqRfjrtiZwGsEK
	 XDFn4RJw2P+sa+GBvrG8Jm825YGeDIf+VPPCYtYqE14BRH0k27pJduQYPK9l0NiIAA/rn
	 vcuu1oGbygH8m/txXJSwxZ8ewOb1hAZwckxsCYVDcM5/1aN+g+K0KCAn3n75eOufOaw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=everpuredata.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=3KhvarpG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.52
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25944606A322
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 18:34:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25944606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=3KhvarpG
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-74ab99038afso3241704137.3
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 10:34:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794854063; cv=none;
        d=google.com; s=arc-20260327;
        b=NeohiYs3OhlBl03r985nsPQLYyqQZkxKznYoxyaBCPGD0cMzYywG7FPUEkLuqhtRbC
         MxNQcj5B+Q6YGyYS7x9p4uUK/UeuWDUA2/+s9wTObLoF6vbFtZrKGZtLIDgkn8GhqjGS
         NZFyAiZeLS8tO/Ejq9p6ke4geEJ/i9UN1jgGGH5fO+k9tpCYZMoWZWMaV9KyIkoCmGzV
         md06wf4mcZKCSYkiSLLRy/fyQV+bPtS4+1dkKt3a0U5/c0hh23TIFRoagvlzTc+Bl6zx
         tfOh44XYBmoo+FPuF3V10QI6t7jCpNgJPh0e76DbyIXZx8NjEKRZ2rncr42b0c/8HjNv
         BCcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xE4/pjASkUAynmBsoopUVVAbaBNyN5sM4lhvVCjAw+I=;
        fh=DpVqJjYDS6uranIjryQsInPs3vtsbcibYMbqtxPZ6Ho=;
        b=ZAFaBAUNRVZLwvdXfiAyRDwDN4ckBmoKTQFih6VFTmPGCvGBgWQt0Hc+MEyJ+8UMSh
         g7APFtZ9gcjLidEF+HpjDAg9CVxe32mmcqVNgEKF/5Zvq4unSECNiPW6UmCQk5GoYXI9
         g+kd/EGTuKoNen+fqiH+LJEBHSJABxO8cB1NIecyR1qCG2NQUaZ43Se7ZHW3czI2Bfhb
         jhgHkzI2Fq6vQYmXyEen4/oQ0jzQr4fiLpxnV7EL4cmB14zr2QRDw5ljpdr2ZwxJ8NG1
         rYLhUwVYfvRDW90bVCBT1x+uoEz9tZkXNETTYZlVIEH/Kx5tcRCXVRGr4PjgD+39ZLJj
         xHdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1794854063; x=1795458863; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xE4/pjASkUAynmBsoopUVVAbaBNyN5sM4lhvVCjAw+I=;
        b=3KhvarpGufVWO7lDXvtAVyMzYD8lYgjB1ajJ0pn8e7lxNUHRnUHTnBlyiV+rZZZu4O
         Vc04NRyR0ygU1ocwItyZwX+dN56Y5ZH9K1xE4a5vx8lOhpMxMiY4zKJMIDl/W4nNfTMQ
         QCx5LDwAwKiR2dQ13xfyhl5JT3GstcLYnPXfwGeyiWDhnUXaUoyKgE878dwBZD9lco1Y
         +V8jXYUkZSrmB6bPdwivKWb8P1Za0p00bD3e2KOIHtdbQqPkFlkH9ateNQZZL5w+vrJc
         J8gs+6aG4ZujQPi0NBtr+7PAClAnjL1s+WH7fz2kwoohIrejV17EuC9vS0Ufxa3Kj9Qa
         /fxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794854063; x=1795458863;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xE4/pjASkUAynmBsoopUVVAbaBNyN5sM4lhvVCjAw+I=;
        b=YZs+PUhsRgOBNPoNZBjHYmGm5xWfSuRlEL3sxk5qKnIUwGUIIn6LoXTXf6KNfGZk59
         tDt8see9eQcyFlS2eNy0HIcK2dJgk02KPTC5OeuUbjxqbOy/FGz859I8QSqamaawG2EL
         UG0gZJRHPO4wrkYw3YJOBT3LEVq97yXPll5XOWK1iBC+0r4NvxItefocLB852KLUSeBp
         IdYlOmi7AbZjXceVDhryyBtnD/OAl5HoSCZME86oR6bJc5DK9yUt8mAn6ciXHLGc1CQb
         R+w4LGn5jkGQEbsyebpfOdX6La2Q4TERZv69PT7nMWlQKYvQ+ztxeakyrUX7NYcz2CGh
         gUKw==
X-Forwarded-Encrypted: i=1; AL+hErFPXwBTNlFx2W9RSvI56cjEnpn9X/FcaEiDkE/+nUogRlbP/nDpOKkJE7RoZ2LzczCAU8C0T4g=@vger.kernel.org
X-Gm-Message-State: APuU4Z9EZH4K0xJkd7UJYsrkZR3rTYe/gyfXQjY77KIFZSwIQlqEoMm5
	rvgE5oL15sWqKfu+kgiLz0LAWljGt0nF6FiZ1BUTdlMQTiUEP4tDtfptSmo5AA5UTHtYlJrVSBx
	5eIhb5xubhM6JeWzXmbbX4JRl/PoPt/oeUB6BTlWsnw==
X-Gm-Gg: AYBFou3kFwOnyNpM85rcG91oBRd/4666TR2PJ7ie0r7Lras06RaY1CeFEVtdIiRDwam
	UywV0xopPRJ5d5DVcpaPJRDH4PJpEk8oSR2uIxgQvP5lKfdBPjJq82rCCtQp6tWAERjUrEd1f4W
	GiCDxT5MiQzcRED+LzCIT48ENRs6rLs8pU70fiT9vVlV7Tpb8+xqY/ZdoM5veSI2fhkzHwes7Y3
	nHG+wSHnHbtRfgcHBjJIcIXb06gvJr4V9QQt1NgfGObELrUu0K74iTDmJsgYcLZqSTx1OqcelfZ
	D7wYtbiPmTlfL9/59EndYFogMMixccXwRhCf59vW9q1oXs4Ap2K//aQu+1UUl2fAmjOScu040Df
	eyWoNUtizJnJiTGm1ahhOOIhphmlgsNgZGXOBz23QJuB/meuirYD7AklWuMdHGZ2TgMjkZ6RhiY
	dZWqGjx4BOBkG2/8E6jGMWCxn7nE3eYEq78usvAuoXnzRRQFJAo7pXw5i/wCekbL48inva4JZoR
	BSegsVTkLuXViJFyxw9z9Sx3g==
X-Received: by 2002:a05:6102:80a4:b0:7cc:174b:f7d8 with SMTP id
 ada2fe7eead31-7d64d45c83bmr4289482137.1.1794854063023; Mon, 16 Nov 2026
 10:34:23 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111232930.2532497-1-rjethwani@purestorage.com> <179478734781.3136.1664474557678569331@kernel.org>
In-Reply-To: <179478734781.3136.1664474557678569331@kernel.org>
From: Rishikesh Jethwani <rjethwani@everpuredata.com>
Date: Mon, 16 Nov 2026 10:34:12 -0800
X-Gm-Features: Aa3M54oqwhpZ7DHE24VaOje9VGSeB2V5NDLz8uXzzvFs8A_zY2ZCgA2-4M_xdWU
Message-ID: <CAKaoeS2dxcgTFyQ+A8b4dEskQ_6+Pms4FGPFy9tXEk3cNtHEGg@mail.gmail.com>
Subject: Re: [PATCH net v4 1/2] tls: restrict device-down TX fallback to
 hardware TX sockets
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, john.fastabend@gmail.com, 
	kuba@kernel.org, sd@queasysnail.net, davem@davemloft.net, edumazet@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, tariqt@nvidia.com, 
	alice.kernel@fastmail.im, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 4:02=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] In tls_device_down() (net/tls/tls_device.c), this patch decides
>   whether to call tls_dev_del(TX) from the result of=E2=80=A6
>
> --
>
> tls: restrict device-down TX fallback to hardware TX sockets
>
> This commit changes tls_device_down() so the TX validator is switched to
> the software fallback only for sockets that use hardware TX. The cmpxchg
> result now decides whether the driver TX state is deleted. RX driver
> state is tracked with TLS_RX_DEV_CLOSED, which is set at context
> creation and cleared after a successful RX tls_dev_add().
>
> > diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
> > index 4cdfbb57ecff0..a42cbc89db2bb 100644
> > --- a/net/tls/tls_device.c
> > +++ b/net/tls/tls_device.c
>
> [ ... ]
>
> > @@ -1350,10 +1350,14 @@ static int tls_device_down(struct net_device *n=
etdev)
> >       spin_unlock_irqrestore(&tls_device_lock, flags);
> >
> >       list_for_each_entry_safe(ctx, tmp, &list, list) {
> > +             bool tx_hw;
> > +
> >               /* Stop offloaded TX and switch to the fallback.
> >                * tls_is_skb_tx_device_offloaded will return false.
> >                */
> > -             WRITE_ONCE(ctx->sk->sk_validate_xmit_skb, tls_validate_xm=
it_skb_sw);
> > +             tx_hw =3D cmpxchg(&ctx->sk->sk_validate_xmit_skb,
> > +                             tls_validate_xmit_skb,
> > +                             tls_validate_xmit_skb_sw) =3D=3D tls_vali=
date_xmit_skb;
>
> [Severity: High]
> Is ctx->sk still guaranteed to be allocated when this cmpxchg runs?
>
> The cmpxchg is in the second loop, after tls_device_lock has been
> dropped. The refcount_inc_not_zero() in the first loop pins only the
> tls_context, not the socket.
>
> The final reference on a hardware TX socket can be dropped from skb
> freeing, and that path does not take device_offload_lock. The socket
> destructor then sees the extra ctx reference held by tls_device_down()
> and returns early:
>
> __sk_destruct()
>   tls_device_sk_destruct()
>     tls_device_queue_ctx_destruction()
>         spin_lock_irqsave(&tls_device_lock, flags);
>         if (unlikely(!refcount_dec_and_test(&ctx->refcount))) {
>             spin_unlock_irqrestore(&tls_device_lock, flags);
>             return;
>         }
>
> The ctx survives, but the sock is freed. ctx->sk is left dangling. Each
> earlier context in the list adds a synchronize_net() before this one is
> reached, so the window can be fairly wide.
>
> If that happens, can the cmpxchg read and write freed or reused socket
> memory? There seem to be two bad outcomes:
>
> If the compare fails, tx_hw is false and tls_dev_del() is never called
> for TLS_OFFLOAD_CTX_DIR_TX. ctx->netdev has already been set to NULL,
> and the final refcount_dec_and_test() in tls_device_down() goes to
> tls_device_free_ctx(), which never calls tls_dev_del(). Would this leak
> the driver TX offload state?
>
> If the memory has been reused by another TLS socket whose validator is
> tls_validate_xmit_skb, the cmpxchg would switch that unrelated socket to
> the software fallback.
>
> The unconditional WRITE_ONCE() through ctx->sk in the second loop was
> already a use-after-free before this patch, so that part is pre-existing.
> What this patch adds is that driver TX teardown now depends on that
> unprotected access, where before it used the pinned ctx->tx_conf.
>
> The next patch in this series, "tls: fix socket use-after-free during
> device-down", seems to address this. It moves the cmpxchg into the first
> loop under tls_device_lock, records the result in TLS_TX_DEV_DOWN, and
> tests that flag in the second loop. Would it make sense to fold that fix
> into this patch, or reorder the two? Then this commit would not add the
> dependency on its own, which matters since it is marked for stable.

Thanks, agreed. I'll fix in v5 by reordering instead of folding: the UAF fi=
x
now comes first and moves the validator switch under tls_device_lock.
The restrict patch then turns it into the cmpxchg under that same lock,
with TLS_TX_DEV_DOWN recording the result. No commit dereferences ctx->sk
outside the lock. I'll keep them as two patches because the fixes have
different Fixes tags and backport prerequisites. The final code will be
unchanged from v4.

pw-bot: cr

> >
> >               /* Stop the RX and TX resync.
> >                * tls_dev_resync must not be called after tls_dev_del.
> > @@ -1370,13 +1374,14 @@ static int tls_device_down(struct net_device *n=
etdev)
> >               synchronize_net();
> >
> >               /* Release the offload context on the driver side. */
> > -             if (ctx->tx_conf =3D=3D TLS_HW)
> > +             if (tx_hw)
> >                       netdev->tlsdev_ops->tls_dev_del(netdev, ctx,
> >                                                       TLS_OFFLOAD_CTX_D=
IR_TX);
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261111232930.2532497-1-rjethwani%40purestorage.com
