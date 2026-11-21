Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795273636;
	b=ScmUou9Re70B274T3dXBOdtmP6Pzy1gizL8kwMiyEJMLgvllW/p1XLdT+Q7JAP6PKSda
	 Z2EL4Bc6flSUTDj+mSIewKk5wZmQvRtuIK8tqzlLsBPp4Ht2kDnF4WwpyPPSiwclOQET8
	 QILqBsOCHK+MIBeXmxsr0hDc8iysZkyclXZWZvroIwtHNGVHqKIyk4QRiH6KwHdN2gmMm
	 /pglJ8FiFRP6KfQomGir4Z8f7ZDvh0G1D5isZRzZe67apXkwTDr/i2ZPTjb/kUKjEXH/y
	 gS0YOB13nhkhA1m+Rwpcu1FTDyE6ddusR8m/wwlUpFcEQqtzdon4pGMeUai2dn3ZCZg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795273636;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=9P+LQP77QaUXhnPvf9lJxnDJFTqEEgKYM6Pv7OT70pU=;
	b=RtKTD7oTU5H5h7THq7E/40Pbyx8WZEG6dqaAC3xC2SvAhhachaP5YB6xo0k9w1ZDvVLG
	 4fuhMLRUKVkZ8fpy57PhI9iLlhHae+MDMsr5TM1LlX6VHvu3hc7ES/EjbJGL0xu29m657
	 PDQVunobWG5HvzZlZFd/wwVkdyIi1fdBs4Cl9clQDO0y6ZktGer2A+UbNeUXOuBVlX3hC
	 SYqGU9j2+N0bjG+h8F11CxHgO6CjAJ8JXfVU9a0FgxdftFpBVYcHw+QoGDGf6aeWjD4+U
	 W/LkNS8oYQi9vPMnGGDLj8EdLVd2A8dd5+iNYxLIeygu0ybpH/BpESqcQB/XP7OfFbw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jwvgqvAy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DED0606A32A
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 15:07:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DED0606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jwvgqvAy
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2f052ae3c86so7485865ad.1
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 07:07:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795273635; cv=none;
        d=google.com; s=arc-20260327;
        b=Y9EzmtyH9F4NjuHi9cSZzC9D0mOlSdqeSvB1xFl2KdV8ywSmHx2MrRJoFPkcI8fDC5
         mI6K/tmgD4hp+yz6cxYN0YUoTsINbmUOrRxTNPDpT48gEZxr9UQvhK05V0S+K7SqXq2a
         R43IxaKd2nD8MkyF62Tm6WwVZpgPC0pEsXp2JeZl6fxXOoKfPiRnPF5zdoglfRJmpNWj
         h55OijHIcD9nslq01FtSE+UznqjH4Ps+qj/T/mv7hVsXKjB4UATrkxD6HvpO7bTrNyJf
         qXbMxqI2/WDATdXluZaAeYaPAEHr9NYix7jyCT9QXZ+doBz1ZFv92PtXsVWeMvTPCl9c
         IE+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9P+LQP77QaUXhnPvf9lJxnDJFTqEEgKYM6Pv7OT70pU=;
        fh=RKCuWmZUM8c9yfbPRtOzH3UuAyXtObBODQdzIfx9mhc=;
        b=GuS1u+PAzVeDhJW/HBa1pdcXJ9EMez1ap/7x08wCw+9bxv1a0t5LGS2YdtMtbzrq3f
         Pn6z3TBDpDlz7TgD2UEGYgfmFlpqSi/XrknGgLrboLb1YQNIIambj5cCg+VOLVE5ZreF
         qW07BxcJD85iLsbU7yjg+Kl5VprsKsI6nd+LMPlliMUkVKT8/gLVmPg37oS6Sss+vPuB
         f8pA4pGIJ+4twZbfRMuc7FkQgZXA3rLLFEZiZ/5s/FOK1M/NinliUiChPJuvqmCkVrEn
         pZ3oKmSvZWvu6NU9pyO8jBBnhCIshW3cnVN40EeKNiIF/JKJLeD3zK63/4L9o2RXqhuj
         dRhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795273635; x=1795878435; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9P+LQP77QaUXhnPvf9lJxnDJFTqEEgKYM6Pv7OT70pU=;
        b=jwvgqvAy+HFdrbgRBQzm8tLOrQdYmeeaizGotF+jFTM+0VUlB2BKmqMof1+xUo18M4
         h/IUDLO8wR1CvDL/BkNVg7LwITGupGOeMtBR1fg7tOAk0spDl9HDxozPLLLWX08O4vkl
         g3TpSPqoPUH615HHVrbi3eM7eijbHaqr4d5rssbYUSvd5nJ3IcaoVVkyx5dwG4AxhEWo
         UcZeVversl4+LskyFTs13TY8JJZKf2MuUQUHHP4xNOvUVVSLv+ApJEBeOlcmXSqR/kaB
         k25sVwdgzcoFB1eI+TOiyP2uw9rRDswLTyLs/Nqqa2QhdCeNrelikCRBj0clulHO89Q4
         z2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795273635; x=1795878435;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9P+LQP77QaUXhnPvf9lJxnDJFTqEEgKYM6Pv7OT70pU=;
        b=aWaqWmu9sR1ceZH4Nmbs7L5vV/rWsdjZL58Xd4DmXc1uuOeK9R4tuib7Pc4o5Xl80v
         9THGP6yLWqq9gjNykznO2ofJFFd3qKgotmKXanApUrbIIbN8fGOpMP1yBgH4LUQUWLc4
         zJkcztr/EHK3+fOylc0XcijZhcJs2cpAXC8ipVDd6JVGDV5EGPC2ooxunWLHbrYayUbI
         XPjj2DPkA5WoUlxXb3mnPGemZbQwjALKmQkHVZHu8vKuqoHGdKkmtkupH1toWvaFfg6m
         tw656ZzvO88qhP3msRy2PasWn9xdDNFfgtugp8BBipkxmM29RLmI/6i3T8DZWCo1LIvs
         aYvA==
X-Forwarded-Encrypted: i=1; AL+hErFq5do4P4cZn+3AAdyFdALuC/AEiQoCaLV+9biqF24VFXA+PekCnEh/ulfDB6qgphaMTxxCROo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8elMijLCWqJngXwRNnlu4PHbmBskKJg2/a2s4reInD2N55rkSm
	UZqcDDBbe9jWcuCVDb/r6/usoMd2FoEi44Fe5aOFA6ntKVUVbog1oj+nFjKfmIICXww8+G3+AXw
	c3oLRHUNdDTKU9sDPI7YUWAh9GRzUS9o=
X-Gm-Gg: AZFdTZfMDE6ot8iqLxas7VrmSpI8Ndtb0pp9IAboCQ8gZOQ/RjH+UoiX9J0z8tigdVn
	ZT5KoqIyNX6qxYAjHVPmFfPUs/DtCcjbfRujur2nLgw+yBqYPJU2J3p55be4x5zkl+Y9kiUdMhT
	gliw7M7YupRoSWm7vipCL1aI/KpmoWuQPUIQcnazNK48Ss/PsF8GUqAzSHxFSdrM9cbWe+3EbdO
	BjSufyGkaZ6EIIy/ysPVXbVg1sLVAEqlFP2zmI5L4WaVN/sJTkrrIMy/IRb8B0McqOZ7C1B5Oh5
	3g213KWUqZUFMHGoUCmcjcssNGZJB+UNQwZvjQdCwd7AyaYIBEHp5sZXmg4+n37O74qfkmsMzU4
	EmV5gIKdKEz7AFD58k0YNL9E6QQHPE7HKXeP6OXoLY46z653nLptJOYQAbHJv/QGEmj1wzOZMN2
	NyKJz+Tda1CVqjax4hQXJW+oZu
X-Received: by 2002:a17:903:2f4d:b0:2ea:9012:649 with SMTP id
 d9443c01a7336-2f03f1ec317mr73144255ad.57.1795273635478; Sat, 21 Nov 2026
 07:07:15 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261121070804.26185-1-alfonsocvu@gmail.com> <sashiko-outbox-226770@kernel.org>
In-Reply-To: <sashiko-outbox-226770@kernel.org>
From: Alfonso Villalobos <alfonsocvu@gmail.com>
Date: Sat, 21 Nov 2026 09:07:04 -0600
X-Gm-Features: Aa3M54rGHRzfUSOp8ujaJxpTAz5H4ROSkXJLOnO3uUt3NShcUdp4Z92hpWXGRLI
Message-ID: <CAJ=mrFowQNahOjD-NQzcuJCjPE=efvDK85kMpseRUrqYBwX3Sw@mail.gmail.com>
Subject: Re: [PATCH] thunderbolt: Re-add host router DP IN adapters after DPRX failure
To: sashiko-reviews@lists.linux.dev, westeri@kernel.org
Cc: linux-usb@vger.kernel.org, andreas.noever@gmail.com, YehezkelShB@gmail.com, 
	Alfonso Villalobos Ulate <alfonsocvu@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mika, hope you're having a great day.

I'd like to check the direction with you before doing v2. After the
Sashiko review and looking closer at how host router DP IN adapters
are handled, I'm not sure v1 fixes this in the right place.

The DPRX failure happens when the RX 9070 XT feeding 0:10 is in BACO.
With runtime PM disabled for the GPU it always works. After the
failure the host router never sends a hotplug for 0:10, so it stays
unused until something triggers the re-check from v1, here me
replugging the dock at 00:27:26:

  [00:26:36] 0:10 <-> 1:11 (DP): activating
  [00:26:36] 0:11 <-> 1:12 (DP): activating
  [00:26:48] 0:10 <-> 1:11 (DP): not active, tearing down
  [00:26:48] 0:10: DP IN resource unavailable: DPRX negotiation failed
  [00:27:26] 0:10: DP IN resource available
  [00:27:26] 0:11 <-> 1:11 (DP): activating
  [00:27:26] 0:10 <-> 1:12 (DP): activating

The DP OUTs also end up swapped, so the ordering part of v1 doesn't
work as intended either.

The comment in tb_dp_tunnel_active() and the redrive code both seem
to expect a hotplug for host DP IN adapters. Is the ASM4242 supposed
to send one once the GPU starts driving the DP IN? If this is
ASM4242 specific I can limit the fix to it with a quirk.

v1 also only recovers on a new event. The alternative I had in mind
is retrying the DP IN a few times with a delay after DPRX fails, so
it recovers without a replug. Which is better?

I already have fixes for the Sashiko comments (the missing
tb_exit_redrive() and the ordering in tb_dp_resource_available()) and
one to skip DP IN adapters that are already in a tunnel, but I'd like
your opinion before spending more time on it.

Thanks,
Alfonso

On Sat, Nov 21, 2026 at 1:25=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [Medium] thunderbolt: missing tb_exit_redrive() in
>   tb_add_dp_resources() leaks RPM ref
> - [Medium] thunderbolt: list_add_tail() in tb_dp_resource_available()
>   breaks DP IN order
> --
>
> commit 4eedd8886dc180b45204d935f18725051dd0e6a0
> Author: Alfonso Villalobos Ulate <alfonsocvu@gmail.com>
>
> thunderbolt: Re-add host router DP IN adapters after DPRX failure
>
> This commit re-checks host router DP IN adapters when a new DP OUT adapte=
r
> becomes available or a device router is scanned, keeping host DP IN
> adapters ordered by adapter number on tcm->dp_resources.
>
> > diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
> > index 418ad0a61a5de..1f3dea836067e 100644
> > --- a/drivers/thunderbolt/tb.c
> > +++ b/drivers/thunderbolt/tb.c
> > @@ -109,6 +109,29 @@ static void tb_queue_hotplug(struct tb *tb, u64 ro=
ute, u8 port, bool unplug)
> >
> >  /* enumeration & hot plug handling */
> >
> > +/*
> > + * Insert a host router DP IN adapter so that host DP IN adapters stay
> > + * in adapter number order. A DP IN that is re-added after it was
> > + * dropped (for example because DPRX negotiation failed) then gets
> > + * paired with the same DP OUT as before, instead of swapping DP OUT
> > + * adapters (and therefore monitors) with the other host DP IN.
> > + */
> > +static void tb_add_host_dp_in(struct tb_cm *tcm, struct tb_port *port)
> > +{
> > +     struct tb_port *p;
> > +
> > +     list_for_each_entry(p, &tcm->dp_resources, list) {
> > +             if (tb_port_is_dpin(p) && !tb_route(p->sw) &&
> > +                 p->port > port->port) {
> > +                     /* Insert before the first higher numbered one */
> > +                     list_add_tail(&port->list, &p->list);
> > +                     return;
> > +             }
> > +     }
> > +
> > +     list_add_tail(&port->list, &tcm->dp_resources);
> > +}
> > +
> >  static void tb_add_dp_resources(struct tb_switch *sw)
> >  {
> >       struct tb_cm *tcm =3D tb_priv(sw->tb);
> > @@ -118,6 +141,9 @@ static void tb_add_dp_resources(struct tb_switch *s=
w)
> >               if (!tb_port_is_dpin(port))
> >                       continue;
> >
> > +             if (!list_empty(&port->list))
> > +                     continue;
> > +
> >               if (!tb_switch_query_dp_resource(sw, port))
> >                       continue;
> >
> > @@ -130,7 +156,7 @@ static void tb_add_dp_resources(struct tb_switch *s=
w)
> >               if (tb_route(sw))
> >                       list_add(&port->list, &tcm->dp_resources);
> >               else
> > -                     list_add_tail(&port->list, &tcm->dp_resources);
> > +                     tb_add_host_dp_in(tcm, port);
> >
> >               tb_port_dbg(port, "DP IN resource available\n");
> >       }
>
> [Severity: Medium]
> Does re-adding a host router DP IN port through tb_add_dp_resources() lea=
k
> the runtime PM reference on sw->dev when the port was in redrive mode?
>
> On host routers with QUIRK_KEEP_POWER_IN_DP_REDRIVE, tb_enter_redrive()
> sets port->redrive and calls pm_runtime_get(&sw->dev).  When
> tb_add_dp_resources(tb->root_switch) now runs at runtime from
> tb_scan_port() or tb_dp_resource_available(), it adds the host DP IN port
> to tcm->dp_resources without calling tb_exit_redrive(port).  Any later
> tb_dp_resource_available() call for that DP IN port then returns early
> because the port is already on tcm->dp_resources (or already enabled by
> tb_tunnel_dp()), leaving port->redrive set and preventing the host router
> from suspending.
>
> [ ... ]
>
> > @@ -2234,6 +2272,14 @@ static void tb_dp_resource_available(struct tb *=
tb, struct tb_port *port)
> >       list_add_tail(&port->list, &tcm->dp_resources);
> >       tb_exit_redrive(port);
> >
> > +     /*
> > +      * Host router DP IN adapters removed because DPRX negotiation
> > +      * failed never get a hotplug event of their own. Give them
> > +      * another chance now that a DP OUT became available.
> > +      */
> > +     if (tb_port_is_dpout(port))
> > +             tb_add_dp_resources(tb->root_switch);
> > +
> >       /* Look for suitable DP IN <-> DP OUT pairs now */
> >       tb_tunnel_dp(tb);
> >  }
>
> [Severity: Medium]
> Should tb_dp_resource_available() also use tb_add_host_dp_in() when addin=
g
> a host router DP IN port?
>
> When a lower-numbered host DP IN port becomes available via hotplug in
> tb_dp_resource_available() (such as when exiting redrive mode or after
> resume) while a higher-numbered host DP IN port is already on
> tcm->dp_resources, list_add_tail() places the lower-numbered port after
> the higher-numbered one, breaking the adapter ordering that
> tb_add_host_dp_in() maintains.
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121070804.26=
185-1-alfonsocvu@gmail.com?part=3D1
