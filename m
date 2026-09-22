Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A37556BAF
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089294; cv=none; b=NlnllR/qfIydM1xU7hinSfObDaa/UqTLvkz+wsb03gS7rs0LIgkx5oi4U1xIsQu1wD0+SIqD+dklCiKpQBdqPw/DnnEX0uqF+c8vCo4Pg/6Wa/jCAdx92OtqkhGt0ATb4KJ3MS1Zk/SzJlWQqe3ctRFhAaKLtVd1v2W+LHbQMlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089294; c=relaxed/simple;
	bh=WXXtKunRs9PlwuXX6rnWPRmpl1Gc3yK+6odGmlPkSso=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=ARo9j+3ImLCJ0W9co7G+Qp9rcfAcUVlx6yJHLxSgnm2oIXPQMsylPwD8j951ZGPmuhugDXT/RcRKpyesspHRKDJiduzMLcI9iAXasLxkLYXI9tgodahDeTIdzaSHsRPx8cCZ1iNvCsdmT0BsDrxSh0ziQNFEwDM+5w1FG+eismU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdLjT0SY; arc=none smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdLjT0SY"
Received: by mail-yx2-f43.google.com with SMTP id 00721157ae682-85d43db0c17so691497b3.3
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 08:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790089291; x=1790694091; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SA3R0WIR1hmURqC/sP5IyTdS3yL7U8cZKfY5iZZJBrI=;
        b=fdLjT0SYIcWhGFRP0HRxkBot+NehmAXd+d8k4ZypOyHh7+GQj1LhVmn2L5NtlN1aKt
         2h7sDuE29t6GEBMMMbHnXddU0GuTg84+QY/WF6Jt+qC3SnyYmvW+HHsXCJTQbTvL1L/Z
         KBTPLGomnKgC17/VZqe+PLX/AgdHJciLqD1/K7Vdu5o71jNKCFGXww+RGzHoMebaju1G
         +q3+d+LyCLl4He4gKHyOuOO6hegZni/hwdCsU+nAchtv1hwzFeuZWjoLUH4Uqjuk8dp0
         A+91rmx6N9dpTtuOvxmjOK/IRttbcupoEvxUNXuo3KVmnOSCAqhZ2hSm9fLtfQiEF20t
         9uDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790089291; x=1790694091;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SA3R0WIR1hmURqC/sP5IyTdS3yL7U8cZKfY5iZZJBrI=;
        b=VZLBeDbfYjSlh9Mc2XtB7M5vD7fr7JTzPgcTM9Sw9wpIlx0VkGsTmkk9wSAWQ312Tf
         K9QGjLT9Tyb7Fv/7tGH96qLeqp09GoCFxcAWooXmwuyPObGH3UXreEVLZMvX6jZ2fTHs
         wxld2b+d13hRQvpzg9n+lLqAzm/gWTuJ5QsjcNZGDV+RnM1Htz3jxPm/8DqkJ5ZgHJY9
         b+PQzMtwyzZH2g8krQqonS5eBlYh49cFqtMYV1/3Bblr1qj6osBOxOQ14XKIEhZz/k0j
         RGcg0uSMZhCNQH5qck9JUptj860tzp89tShfFMJS9fZ4A0QQMu7l/Tzwev/SZWtat6oG
         lJTA==
X-Forwarded-Encrypted: i=1; AKwUvBwj3qAF8p3PhDBiJvqYYLJw9hMtgPFGhGVslG0MBfvzY8UC7UzcN7GO4+impr9VJGRuyaJfjGI=@vger.kernel.org
X-Gm-Message-State: AFuF++nRnjupwqIF1nNyFEn9X1dANo1a/NOIWe398SUH9uqAZ7Cui/gy
	NLcV1ROcDzaoY3dtqdifvDnv8LBl3/7HV1MZsdxrHICIhe2zv3BO/TA0lnwrtA==
X-Gm-Gg: AYBFou1pEv/QwqiAe/OsXcJtjHbcDXAezB+AR05UB5pnXRKChiXDLHQr1xvTxQGU9WT
	cQnu+XVlZvL4l77yxMxIs0mJ9s1mxXGf5Hc5jqGbNdfBXI+wpFHEn6kj8FcPgUJ1EdouZ90b+Td
	b2mf6CcekBm8DalBnjEFC2siyxQ0IXnUSCjsAD3Npz/4azTADauyf0wWlwON0qe14xBG14bdsFM
	h0RBOlqjUJcCxvGlWcHEUdxICuJweixCs9nt3wuRb20pOPa4hfOknUNp3dq4nxYPnWQEOnkGDes
	X/S+bQSNn3fHTQ0bo79CNE3GVIh64r8pJ5lDekfNSkFqltp69Kuq078SJJgKC7QUtuhM51MFBei
	qSgmn7UO3dMRz+84LcYAkaF0oEHGSQ3sRWBQnWy6kyAr8M/sJtHj9xgS3cvErQsT8YSWydSeOQ/
	X/cTQ5Qx54iR8hSVTwlZ9sPTCMixiTIU1xGdG1tqBDf0Mna9PcRhKfileNkNUvWKJH/ug98Wrmf
	bQIR2FuzPg/PPKsglnawqgm6pbZjNakUHmHqtJvN0kHZZ/hUjLM
X-Received: by 2002:a05:690e:4852:20b0:672:99e0:ec01 with SMTP id 956f58d0204a3-67299e0f03cmr2401266d50.153.1790089290971;
        Tue, 22 Sep 2026 08:01:30 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-672c74a2adbsm859465d50.2.2026.09.22.08.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 08:01:29 -0700 (PDT)
Date: Tue, 22 Sep 2026 11:01:29 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev-bot+sashiko@kernel.org, 
 willemdebruijn.kernel@gmail.com
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 andrew+netdev@lunn.ch, 
 willemb@google.com, 
 kleaver@janestreet.com, 
 doebel@amazon.de, 
 stable@vger.kernel.org
Message-ID: <willemdebruijn.kernel.1284d8ebcba4c@gmail.com>
In-Reply-To: <179004896394.2160803.10158228819458028402@kernel.org>
References: <20260919004748.1463985-2-willemdebruijn.kernel@gmail.com>
 <179004896394.2160803.10158228819458028402@kernel.org>
Subject: Re: [PATCH net v2 1/2] virtio_net: copy zerocopy frags in start_xmit
 without NAPI
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

netdev-bot+sashiko@ wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> =

> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0 (1)
> =

> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchw=
ork
> know by including "pw-bot: cr" as a separate line at the end of your re=
ply
> (one such reply per series is enough).
> =

> - [Medium] Commit message mischaracterizes the defect being fixed, whic=
h
>   matters because the patch carries Fixes: 5cd8d46ea156 and Cc: stable.=

> =

> Pre-existing issues:
> - [Low] This problem wasn't introduced by this patch, but after it
>   start_xmit() contains two logically identical drop-and-return-=E2=80=A6=

> =

> --
> =

> virtio_net: copy zerocopy frags in start_xmit without NAPI
> =

> When napi_tx is disabled, start_xmit() now calls skb_orphan_frags() bef=
ore
> transmitting, so zerocopy frags that do not set SKBFL_DONT_ORPHAN are d=
eep
> copied instead of being handed to the virtqueue and then orphaned. On c=
opy
> failure the skb is dropped, counted in tx_dropped, and the new kick_vq =
label
> is used so a pending xmit_more batch is still flushed.
> =

> A couple of questions below.
> =

> > virtio_net: copy zerocopy frags in start_xmit without NAPI
> >
> > Virtio-net without NAPI frees completed skbs lazily on the next
> > start_xmit. Senders waiting for in-flight zerocopy buffers can
> > deadlock if they cannot transmit more packets, as then no
> > completed packets will be freed.
> [ ... ]
> > This fixes the tpacket_snd slot reuse bug on skb_orphan for
> > virtio-net, and prevents PACKET_TX_RING from running out of slots.
> =

> [Severity: Medium]
> Does the leading description match the tree this patch applies to?  The=

> patch carries a Fixes: tag and Cc: stable, so the described failure mod=
e is
> what a backporter will look for.
> =

> In the current tree, tpacket_snd() installs a destructor:
> =

> net/packet/af_packet.c:tpacket_snd() {
> 	...
> 	skb->destructor =3D tpacket_destruct_skb;
> 	...
> }
> =

> and that destructor releases the slot, drops the pending count and comp=
letes
> the waiter:
> =

> net/packet/af_packet.c:tpacket_destruct_skb() {
> 	...
> 		__packet_set_status(po, ph, TP_STATUS_AVAILABLE | ts);
> 		packet_dec_pending(&po->tx_ring);
> 		complete(&po->skb_completion);
> 	...
> }
> =

> The pre-existing skb_orphan() in start_xmit() for !use_napi runs that
> destructor within the same start_xmit() call, so the slot is returned
> immediately.  Given that, can a PACKET_TX_RING sender actually run out =
of
> slots or block in wait_for_completion_interruptible_timeout() before th=
is
> series?
> =

> The clause about "the tpacket_snd slot reuse bug on skb_orphan" looks l=
ike
> the defect that exists today, and it is the opposite of exhaustion: bec=
ause
> skb_orphan() runs after xmit_skb() has already linked the ring pages in=
to
> the virtqueue, the slot is marked available to userspace while the devi=
ce may
> still be reading those pages.  That is silent payload corruption rather=
 than
> a stall.
> =

> The deadlock and slot-exhaustion wording appears to apply only after th=
e
> follow-up patch that converts PACKET_TX_RING to ubuf_info completion an=
d
> removes tpacket_destruct_skb().  Could the message lead with the
> data-corruption case for the current tree, and keep the deadlock argume=
nt
> scoped to the follow-up patch?

[Medium] the request is only to change the emphasis of the wording
of the commit message. No code changes suggested:

Focus more on the data corruption bug and less on the deadlock that
can occur when not releasing the slots prematurely (that data
corruption).

See this statement in the commit

  This fixes the tpacket_snd slot reuse bug on skb_orphan for
  virtio-net, and prevents PACKET_TX_RING from running out of slots.

Maybe it should be moved up and say "while preventing".

Seems a bit of a pedantic comment to me, honestly.

I will reword if the other patch requires a respin, but this does not
warrant one on its own imho.

> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index e34c52d059d3..bf82ef9874ab 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -3349,6 +3349,14 @@ static netdev_tx_t start_xmit(struct sk_buff *=
skb, struct net_device *dev)
> >  	else
> >  		virtqueue_disable_cb(sq->vq);
> >  =

> > +	if (!use_napi &&
> > +	    unlikely(skb_orphan_frags(skb, GFP_ATOMIC))) {
> > +		DEV_STATS_INC(dev, tx_dropped);
> > +		dev_kfree_skb_any(skb);
> > +		kick =3D !xmit_more || netif_xmit_stopped(txq);
> > +		goto kick_vq;
> > +	}
> > +
> =

> [Severity: Low]
> This isn't a bug introduced by this patch, but the new drop path and th=
e
> existing xmit_skb() failure drop path in start_xmit() now disagree on t=
he
> kick protocol.  The new path computes kick and goes to kick_vq, while t=
he
> older one returns directly:
> =

> drivers/net/virtio_net.c:start_xmit() {
> 	...
> 	err =3D xmit_skb(sq, skb, !use_napi);
> =

> 	/* This should not happen! */
> 	if (unlikely(err)) {
> 		DEV_STATS_INC(dev, tx_fifo_errors);
> 		...
> 		DEV_STATS_INC(dev, tx_dropped);
> 		dev_kfree_skb_any(skb);
> 		return NETDEV_TX_OK;
> 	}
> 	...
> }
> =

> If xmit_skb() returns an error such as -ENOMEM from the indirect descri=
ptor
> allocation on the last packet of an xmit_more batch, do the descriptors=

> already added by the earlier packets of that batch stay un-notified unt=
il
> some later start_xmit() on the same send queue computes kick =3D true? =
 The
> -ENOSPC case is covered because check_sq_full_and_disable() stops the t=
xq and
> netif_xmit_stopped(txq) then forces a kick.
> =

> Would it make sense to route the xmit_skb() failure path through the ne=
w
> kick_vq label as well, so both drops behave the same?

[Low] but I'll respond: pre-existing issue is out of scope here. But
probably makes sense as a separate fix.=
