Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795551640;
	b=UCXZ2eWi8qonrb3ZGxdwjY9QnDY7fPhrWYwYSzoDZZGbYwsgCzuqYoquHs+vkjWBwt+o
	 RpVvD2NYzpVKnIvfFW4gr59rmZ1cGYpsr7f8mHo7nS99/+PFo8bsVvcFnRfeN71pF7S9k
	 j+0QTcMd9WngAa/AIbcAJPATQS9+L0dyvwEdD0Fm5t0qDyeA5KKihwMbV+rbaRut6ylhD
	 a0OF8c+kdN+HFHhg9nNqKi/XEyhQuCi/3ZvPIBiSOj2WOBBRcK4XsXf+Kv8o/bTzAgunv
	 K5AdXenum3URYyy6iLWBqwhGnQW2BcJETKYXlCnkAddObdtS+xkyPcOTqlfKsbDuP1g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795551640;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=BAMFCwWZ+LNmQB2iLKuB6lCfq14S6w2xy2pfULh+IOM=;
	b=exCPsWYdYcGkQkEI5B/3rWTuV5CVzZ1CjxJrPurrgt1cN2uZ5dk4VTnbgguRkiafhg8X
	 DklSxuOF0Y2QcY07pccSFxyBXM6ZleEe77vdU4A6eYaOb4Zu7nsFKTczOZKNBPxySFGXI
	 9pIJFKefn9tYA+lf6yfoJ6tANuUJc6ufEK+ASuM4vkj6z0ZYF4xppoN1N4rhGg9l+nT7p
	 F5ZYqW+mkJnhFF+Z3sFeNoLgS5A1WKzX0t6q2X25OxfYZSzkSTfGYvdi/EkJo770bjARi
	 3MkrjZtUA3ijXTrCyEA/64CYAhfzcJc+6B6IpK62aMExvBlMa6D/UAkp02DbgvGDuhg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=everpuredata.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=HPHV8plO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.48
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9153B606A323
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 20:20:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9153B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=HPHV8plO
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-980c4258105so2780236241.2
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 12:20:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795551638; cv=none;
        d=google.com; s=arc-20260327;
        b=nXJ1wIWkZ0SbbfkVSX2z1s3XnoNW5HPEh126WRNcZMjKs5qQLwDQOksU4Plk4bc8Bz
         vQb4XoRMPF6tkQwV9zGNtLqmSjqoSS2Ch85ttu9gVTq+l5R5fmitfjO5GvvVpX01mcvh
         G7XlXhZQ8w/i/CYd0e+rOYq0uvblsowQb7rq9ypC5s4eoHNdQhkzZOXkE+doay4F2Mfs
         IahcIXAzWpaWiSrCHd0MBbiIyFBtzPaCO52Ti42oFW7cLaP6tyx0iW+LpXylKp4tGXGf
         PNYJ00uUSzBNYPTcy6rbvesCt08Fn/7v8fRO1/NxM4LQJzQx/lpVoGSRKyDIut6cYRAB
         ERBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BAMFCwWZ+LNmQB2iLKuB6lCfq14S6w2xy2pfULh+IOM=;
        fh=43o1D5nHGVOO9qhk1SveAtP81MZV4bjpGvXZ5b7xUQ0=;
        b=rV87lh0PnqWedBwQ4+hYT2Bn3dUj1Ko54S6iXEtnRtdnPd1ZQLJNQaoEun0gQBeWCD
         gWXR9TFv5uQx86rC3kZwUWbtUota6CgXaVWTLwUWtRjzohpMHkXdTW+A1++GyMbOq9Ot
         4TQazUGpKG0KA47xD15YpTfS5jLVAP4Y7SvnunChrWAp/3gyJbn9oo6Be9aOxMhbtI8L
         wfNw9qzWBG/MFQBvuuo96HRPBhnyw6DqdS2OIv/5XPKw2MrOB11Lvi1YEJmcKZm4xTD0
         9PS/DAdXbLMcGf6P5VEIqYNgqsheRMRTtCj8nZar5nhzk0v6qqZceQG4lm9Ff3yudzNf
         etAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1795551638; x=1796156438; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BAMFCwWZ+LNmQB2iLKuB6lCfq14S6w2xy2pfULh+IOM=;
        b=HPHV8plOHlvgo5A5Z3q0luhqtXip55y5Pe07xXggNmQXeirqiRpynJkOIPk4lH8VAu
         gRsdUOm61sPZoOHlvwvQPFm+ikuHtK/KP6ynrt28sdcOXyf0V9u5gDSxU1zvFQ1M/fsP
         JxyajAynPjgeLaBlA8jjGvHY4UVP5I34dzSkNKbR6UjqxYWemH6uL/WiKuig0kofKgYE
         U8zsuGxKzy+IRMr3xSKqiZW5OtmF7VwajOlanmn7f1gBfe5SYRXJZGW2XaD+C6WITp7K
         tYtZXNnc1lJnWdH7rdKcjdOWNyyWZIt5d3eVRKYQtBKbOq8p9QGPpwBt1jMulw+1NrnW
         LyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795551638; x=1796156438;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BAMFCwWZ+LNmQB2iLKuB6lCfq14S6w2xy2pfULh+IOM=;
        b=y1W70lIYEQpUk3gKaVN8YKBw0h0+uUCo96d8lR2K0hNgVQQy8QR5xwHoUCw6oAfQMx
         WAHo2avoDJLXm0Yl5vhJQvCRAtWcS574YbBFXYMIoC+EcuRCQn+tSL8f6XzfpOMa0aZ/
         j0yMJgJ4VlEr2c3e+yMyQM1XozQA1Sbs9ns9v9UmSOYMWqgRLIyBarRzVFtMC+t8uLJ1
         OQrbpVdPlPbML2TNdknwJLL6HHaaP15E01r0VzeHttiTeThCdAjx8eobPof6i4NJa09u
         Oo3qVcAZa918YLB6HVvHnbNssnxfAHs528Ua3y5MhVkwFgl82Hgdwc8/GJEKp2EOOyEr
         hX2g==
X-Forwarded-Encrypted: i=1; AL+hErHon9W7haBVDUl9XciF4qUUqrIUZj5Mqm12AMcH06CCFUldL49Fu2z5J6G8Xe5MNibendMv0S8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+2ZfwUDEBXq0qiV7VeFSW3XQTF/lXoIzLMt1qXcuA4S4VXZs2N
	RPeZb7WsAKDvoVnZX7xOBnR1MdhWlmp9HUB6TEI8W29T8xYBVxLA5DA6JWPCChkVQwZz3LB8s5I
	v3MHveu6SeKHIlP8ipIAS6SkTErhS1uiX/CVHzyE8cQ==
X-Gm-Gg: AZFdTZcwDeBTuURmvRCnaIL82KOMEXJdevN5GZzMyu5QNjBiY8A/dPhHl6fvLBHXQB8
	d7waM5tweV0wgmgdCYGPMBjJuTRs1N8EtHcJvTbXyo6Mg9gnKL5US7GsFrZkKEZB095oclqzlbb
	UD5hzlcqkQhH/6bnQhXFwDVcgcKp4kyJQYC5NCrp2OLrpjrxxuq4f6lCtmY1zI0DYo/iDhaZTv5
	hBDkt1mGSjw8OeqlrthCH4BXb2tKxQI83GYiFiaw5UJId16FVhhNiUTOQBF1Bo1J7f/U8ESWCpt
	gFLvBAVU1Q83E+AaGKRsS9+t/DMP69ir8ER225A2otOaij4HJ+kg1NsgcImEzcxpEzqd7fhQDYo
	l6FW81dZ0u6160uuv2pcHCmqr2qRR3nIl2g8op1iHekeiSTTK0aHPc92yn0AGEiKwBevHw2jg3c
	k9VjDnJXW5xvcLAvPtaCW17PJpcSDNomhaY/G9VJg79cZ/kvfz9yU9OzYgaJfP5gGZTEoXqk6FC
	VfjAmI/QGrI3PDJ1AHSHBk=
X-Received: by 2002:a67:e115:0:b0:7c3:a1c6:7a13 with SMTP id
 ada2fe7eead31-7d73944fe61mr7714304137.16.1795551638363; Tue, 24 Nov 2026
 12:20:38 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119191341.4089157-1-rjethwani@purestorage.com> <179546636707.3135.15103841065368039377@kernel.org>
In-Reply-To: <179546636707.3135.15103841065368039377@kernel.org>
From: Rishikesh Jethwani <rjethwani@everpuredata.com>
Date: Tue, 24 Nov 2026 12:20:27 -0800
X-Gm-Features: Aa3M54oYqbR2Q2cktDl7oBtx6Tcb6ny20yWkG2NZFuKI9QlMVMpfWnJZWPkUvdw
Message-ID: <CAKaoeS0QG4kLUnJiCi3hyvgQ28Ty-akydwGqHHaTcAVnCGnDAw@mail.gmail.com>
Subject: Re: [PATCH net v2 1/3] tls: device: keep tls_sw_fallback() from
 encrypting its own output
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, john.fastabend@gmail.com, 
	kuba@kernel.org, sd@queasysnail.net, davem@davemloft.net, edumazet@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, tariqt@nvidia.com, 
	alice.kernel@fastmail.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 12:39=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wr=
ote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] The patch makes skb->decrypted the marker for 'still needs TLS
>   encryption': tls_sw_fallback() now skips skbs with=E2=80=A6
> - [Low] The new early return in tls_sw_fallback()
>   (net/tls/tls_device_fallback.c:377-379, '/* Already encrypted, e.g. by=
=E2=80=A6
>
> --
>
> tls: device: keep tls_sw_fallback() from encrypting its own output
>
> This patch makes tls_sw_fallback() pass through skbs that do not have the
> decrypted bit set, and clears that bit on the output of complete_skb(). T=
he
> aim is to keep a second software fallback pass (for example at the bond
> master and then again at the slave) from re-encrypting ciphertext with th=
e
> same rcd_sn and IV.
>
> > diff --git a/net/tls/tls_device_fallback.c b/net/tls/tls_device_fallbac=
k.c
> > index b547027cc879f..57d8f6b50e4dd 100644
> > --- a/net/tls/tls_device_fallback.c
> > +++ b/net/tls/tls_device_fallback.c
> > @@ -192,6 +192,9 @@ static void complete_skb(struct sk_buff *nskb, stru=
ct sk_buff *skb, int headln)
> >       skb->destructor =3D NULL;
> >       skb->sk =3D NULL;
> >
> > +     /* nskb is encrypted now */
> > +     nskb->decrypted =3D 0;
> > +
>
> [Severity: High]
> Does this also cover the hardware offload path?
>
> complete_skb() keeps nskb->sk =3D sk. The driver side check for hardware
> encryption does not look at skb->decrypted:
>
> include/net/tls.h:tls_is_skb_tx_device_offloaded() {
>         ...
>         return sk && sk_fullsock(sk) &&
>                (smp_load_acquire(&sk->sk_validate_xmit_skb) =3D=3D
>                &tls_validate_xmit_skb);
> }
>
> So drivers still treat software fallback ciphertext as offloaded.
>
> Take a TLS_HW socket offloaded on mlx5 eth0 whose route later moves to
> vlan@eth0:
>
> vlan@eth0:
>   tls_validate_xmit_skb()
>     dev !=3D netdev, not a bond master
>     tls_sw_fallback()->complete_skb()    /* ciphertext, decrypted =3D 0 *=
/
>   vlan_dev_hard_start_xmit()
>     dev_queue_xmit(eth0)
>
> eth0:
>   tls_validate_xmit_skb()
>     dev =3D=3D netdev, skb returned unchanged
>   mlx5e_accel_tx_begin()
>     tls_is_skb_tx_device_offloaded() returns true
>     mlx5e_ktls_handle_tx_skb()
>       state->tls_tisn =3D priv_tx->tisn;   /* in-order seq */
>
> In that case, would the NIC encrypt the software ciphertext a second time
> with the same record keystream and put plaintext on the wire?
>
> mlx5e_ktls_handle_tx_skb() only checks skb->decrypted in the
> MLX5E_KTLS_SYNC_SKIP_NO_DATA branch. nfp_net_tls_tx() also decides only
> through tls_is_skb_tx_device_offloaded(), and it attaches ntls->fw_handle
> when ntls->next_seq =3D=3D seq.
>
> This path existed before this patch. However, the commit message says the
> bit is cleared "so its output is not encrypted again", and that doesn't
> seem to hold for the hardware path.
>
> Should tls_is_skb_tx_device_offloaded() also require skb_is_decrypted(skb=
)
> so that it follows the same rule?
>
> [ ... ]
>
> > @@ -371,6 +374,10 @@ static struct sk_buff *tls_sw_fallback(struct sock=
 *sk, struct sk_buff *skb)
> >       s32 sync_size =3D 0;
> >       u64 rcd_sn;
> >
> > +     /* Already encrypted, e.g. by the bond master */
> > +     if (!skb_is_decrypted(skb))
> > +             return skb;
> > +
>
> [Severity: Low]
> This isn't a bug, but is this comment accurate for every skb that takes
> this return?
>
> Data written before setsockopt(TLS_TX) also has decrypted =3D 0, because
> tcp_sendmsg_locked() does:
>
>         skb->decrypted =3D !!(flags & MSG_SENDPAGE_DECRYPTED);
>
> Only tls_push_data() and tls_device_write_space() pass that flag, so that
> data was never encrypted by kTLS.
>
> Also, the existing bypass further down in tls_sw_fallback() no longer
> seems reachable for the packets it describes:
>
>         if (fill_sg_in(sg_in, skb, ctx, &rcd_sn, &sync_size, &resync_sgs)=
) {
>                 /* bypass packets before kernel TLS socket option was set=
 */
>                 if (sync_size < 0 && payload_len <=3D -sync_size)
>                         nskb =3D skb_get(skb);
>                 goto put_sg;
>         }
>
> Three things make it unreachable for those packets:
>
> - Only decrypted =3D 1 skbs reach fill_sg_in() now.
> - Those skbs are created after the start marker set in
>   tls_set_device_offload().
> - tcp_skb_can_collapse() refuses merges across a decrypted mismatch.
>
> Should the new comment also mention pre-offload plaintext? And should the
> start marker bypass, along with the matching start marker handling in
> fill_sg_in(), be updated or removed?
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261119191341.4089157-1-rjethwani%40purestorage.com

pw-bot: cr
