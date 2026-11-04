Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.222.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793817029;
	b=iTtNn1djG2c+lb+ToRNRtmpzMq7Bfgrq6j8/kDlPEZkqnVpx46tGqQRv9MGt3qDFpIRL
	 fM5f078vx+uxSXDNWylLBwa8abQ2J6XUUzWrDVWoBHLn+Qtj12RQlYWsPFefgCOXQZTCL
	 n/FFQcR+0j7iwkIIdw4zU4JVX5nKZAlNdLZ6ukavVJtmirhO1L/Q69bTQAikMu97c+Ekt
	 2TwJNMR4uqzze/ODY7mknzzXu6O6RYZurHfVo2rr0zhABwHwwFL3+85nWWYjQIK6KqILt
	 IWxSm693IJlVb2R/gg0BtoTOJ7C9trZfcOsMHF0UwXQmfnawmNzhzT5bnasnCEDhIuA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817029;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=6vlBLO9On7q47NyBJ2Rw1NocpmdzrNn/c5hU8D8zRfc=;
	b=KylH65XiURFaWUQDbz3l5BxpJ12xqPx8RoYXo0u+Vus8BTFAvm0DtwyrI8yQOTbXgjVN
	 AQGw+MdE0uczhCQ3fL2ECGlscNPeLSlit+z/t2juSw6ISrNQYe60cYlb+eVlhOokz3g4h
	 Sak1H8NP48pwL59ebL4ExW677+nX+0s6BiVY0sS/t18/zAzjDbLA1iQBtLtdNVejPPplF
	 fJ+qdc+n7/U10otPBPq4yT1YL3lPSSGNBDZAZKj1MrShV528LLANN9sVbhTEaoKJX39Qt
	 ZwnfMvqxMTJ5yRP3hwfyZZ6+sGYmjrz7W6ETsNYeys9AMSBbZ3ilmPvwgvRpnCXGW7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=everpuredata.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=D+vzaXEc;
	arc=fail smtp.remote-ip=209.85.222.44
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B448606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:30:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B448606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=D+vzaXEc
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-990835cec4bso581244241.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:30:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793817023; cv=none;
        d=google.com; s=arc-20260327;
        b=CaJTyLzpBY7rgKC9yFng10y9PBMFnRKpmCU7kEBSbBr47H48f9LQ3Qet25STNtgm5c
         pZDrzXZqY47eOmPgnVWTm7myTA9U0xJwapSB+aeO1O2tlVEESKe4Uf7VwZ3Rux8aH54e
         ACMc7FPx/ENdxOIVy23/domzcC14xM52ms6BOKXPQchudrR25BunL4rRBWmV6cBp/Cuu
         If0Qk3X0wUCwUShKF70DYRBLAHZtsuCnr4gQZ70H1Q3YqlMB6ASf8weSlYirAFmkqWr9
         dhbiPLJqPbn4dJjsAXLlt2/EONny/Phcr+su8w9prZeHLY8k3N+w9KsL+n9xLYaIFCUq
         aEJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6vlBLO9On7q47NyBJ2Rw1NocpmdzrNn/c5hU8D8zRfc=;
        fh=+jjhPaNpEkdEYIkUr2EOFawBu+UahN/raAsyeDFAyFs=;
        b=THcttO3M4nKVmghe+tVq2ZcwJXNTso7jvhqDE9ECBbVDosVCwXLUAgbOmb5p2B4p7Q
         Mm4AHbWnTYz5Br1mFsRV17HTZ/oarjCeZevRKfsyOwWAZ+CtAHhhbfrGMUPhpRvj1cMn
         dJwMeNEVXSTMwLdbWN+0JU+tSob9TSc8SQ5ZYnIuw2QtOCXGXgD1UVkU1Vwa6JdXMVyi
         3TCaBcr5HTGOYBdUj94jWjoQ+3t7ZlJaYOg+9rKsOCwSBUKXan0AZ1oNlw/se+/cota2
         5yOqp7aFFG+YozR4JAOnLMshYzH3QO34yLeIFDXIdTr9qmETInV8Lf9y4501d39OmslN
         n4nA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1793817023; x=1794421823; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6vlBLO9On7q47NyBJ2Rw1NocpmdzrNn/c5hU8D8zRfc=;
        b=D+vzaXEcyQsrqSCPGZFnsmiGvYNBSc4foTiivjqiQoqaMvSxloeeFxaM5RXt6S2Kv6
         V9y2OBTNagImvYAvD10a+ZoSyI9FAmiK/KzEsrd/zYfkRAWLXuO+u9GbM4FBFTl9MbPS
         kRyUIbTsbZSmYQQLaciF+SGH0bpTJ1mFPQdzvRxHRBu1u/Miw3SOCmssLYPYx7bNVYPZ
         EBJMPfwBdPViJ2doX3G+mxxchBNoO8kqnaMhAprre7AkIt/4ny0vrfK4SLSP0Nt2bTTw
         uz/yAV3vprRPcCj3PtI0OiyjmsPECr7nrryw5M7Zb4RMktGqwLoCZwH84JtIQ+5N+CoT
         6k7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817023; x=1794421823;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6vlBLO9On7q47NyBJ2Rw1NocpmdzrNn/c5hU8D8zRfc=;
        b=TJnngQAG7Ldm9ehjTeopvqFwqHz3Vmi5y3CXGAw+tvs79z0S4bpporvV+5U3fA63C0
         AQWcZK7Ql3U2WpA/J7fDozARmBBDP89WC6RC6d7fjAbX6/bbFDTy+rdFYNMLhmF6G3vF
         xpE1rxB6nLIb5N0f8FQlVURH5SavH5AlP/5qLxlBygWK4tzuwKqhKiW0baYDCB6077lU
         yAlU02Cul0h5euFzqMEfRnca3WCjGJLPiHSVm7NIJchJUDWtlRPf/ylAhWywf7UH0rxb
         L889QhZbu7mF2xbfPBo3Nj968gg1avXCzeGvjWM/CcaIoQFHYwZ/K1Il3o4zj+ipiQET
         ccHQ==
X-Forwarded-Encrypted: i=1; AKwUvBy0NZZAbDVEzkO9hrMdvfmYvjibEclgdkU1Hx4CAB14nGR7RdVVhexft7eRFDPpL0+vaHdfLss=@vger.kernel.org
X-Gm-Message-State: APuU4Z+wSXF+USGOXiAEVj4regUFcQyTHv4KmxWFmqIZnO26y2JlWDUf
	Tm2e6nwBjaU5VxS0b/PXH3/Xq/x8cAaf+LNgDC70hmi0EbqGl0duEyf9xvTFvzr/dU/2WoVxn2x
	Hp0CHs2TvhRigiJTmahc31UH4Us2VHAI+HhaDVEFCHw==
X-Gm-Gg: AYBFou0VuyQyIiiuEo9UCHCkPsYt4sFK0MT1Af89ZAWqDO+VUB6HNOdxPwS4UBtnTab
	bo7PEmmQ3jvF2nuUfQ9batiY9rMRM9yT4MDXJJM8cRH3hG2ULJFhj7ubrEwUhkOig2ZRhsBiE4V
	NlTdwvPCA3tk5yNW/E/+6jX9V3NDUFR23QfyXM63437w3TokUk6WwSv5C7XHl+nBvLbOr/HDhUT
	LkbiXrhWsiHYTJ2FyYW8ObaEPeGl1rRXV2rNbvN9gRDUq0Yi4r0W02Ae5Z5+NHKs5Xirwd7QSWS
	JhKgJ09tMYdwx2mn2+s/UaOBn9mJ7EfDYzC2Qa6ZPf8kKA/Mv5zHihsfEXOqEori1vl1Dnxyz0B
	7+pjdOiI+aWfeSCcTjvu0NHKVFgf1hE7mD7jEGdUj84tBpjqAw0rnk+T6aPBzO4Rv8YCyKXIDEx
	aT89BFO2rcs+pmcGJ7dHxY7BFdTDOYm333gn4WSFsEjHwMzDDsYSGMePuv+E4psMt9jd4Umj2dy
	cRuqTh5IMgtjsgok0vMvKyb
X-Received: by 2002:a05:6102:3e8e:b0:7cb:bb33:8413 with SMTP id
 ada2fe7eead31-7d072bb37c6mr7312101137.9.1793817022500; Wed, 04 Nov 2026
 10:30:22 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102220310.12649-1-rjethwani@purestorage.com> <179374354756.488856.17787079121679404910@kernel.org>
In-Reply-To: <179374354756.488856.17787079121679404910@kernel.org>
From: Rishikesh Jethwani <rjethwani@everpuredata.com>
Date: Wed, 4 Nov 2026 10:30:11 -0800
X-Gm-Features: AclHuK9IwD1rDZTP-2krUHCIqiisxEe3xHzAbLlTex379jxu1nU7vOHg_omGLSc
Message-ID: <CAKaoeS1koPSPtjzj3sFYnZoO5XkYaDcWnodHR+KsGNfz2CYrgA@mail.gmail.com>
Subject: Re: [PATCH net v5] kcm: reject attaching sockets with a ULP, and TLS
 on KCM sockets
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, jiayuan.chen@linux.dev, 
	syzbot@syzkaller.appspotmail.com, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, hare@suse.de, 
	sagi@grimberg.me, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 2:05=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 2
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The commit message understates one user-visible regression.
> - [Low] The commit message says 'rmmod kcm waits until such sockets are
>   destroyed'.
> - [Low] Documentation/networking/kcm.rst ('Attach transport sockets' /
>   'Unattach transport sockets', lines 144-190) is not updated for the=E2=
=80=A6
>
> --
>
> kcm: reject attaching sockets with a ULP, and TLS on KCM sockets
>
> With this commit, kcm_attach() refuses TCP sockets that already have a
> ULP, and it now refuses raw IPPROTO_TCP sockets too. Attached sockets get
> an unregistered dummy kcm_ulp_ops, so tcp_set_ulp() refuses kTLS on them
> afterwards. The marker stays until the socket is destroyed, and it pins
> the kcm module.
>
> Link: https://lore.kernel.org/netdev/3108e934-ec00-458b-8720-450554b35b55=
@linux.dev/
>
> > Holding a ULP also has visible side effects: getsockopt(TCP_ULP) and
> > inet_diag report "kcm" on a socket that was ever attached,
> > sk_has_decrypt_user() is true so PSP RX association is refused after th=
e
> > attach, and adding an attached socket to a sockmap fails with -EINVAL
> > rather than -EBUSY.
>
> [Severity: Medium]
>
> Is the sockmap effect really limited to attached sockets?
> SIOCKCMUNATTACH does not remove the kcm_ulp_ops marker, because
> kcm_unattach() only clears sk_user_data:
>
> net/kcm/kcmsock.c:kcm_unattach() {
>     ...
>         write_lock_bh(&csk->sk_callback_lock);
>         csk->sk_user_data =3D NULL;
>         WRITE_ONCE(csk->sk_data_ready, psock->save_data_ready);
>     ...
> }
>
> sk_psock_init() checks for a ULP before it looks at sk_user_data:
>
> net/core/skmsg.c:sk_psock_init() {
>     ...
>         if (sk_is_inet(sk) && inet_csk_has_ulp(sk)) {
>                 psock =3D ERR_PTR(-EINVAL);
>                 goto out;
>         }
>     ...
> }
>
> Before this patch, this sequence succeeded:
>
>   SIOCKCMATTACH -> SIOCKCMUNATTACH -> BPF_MAP_UPDATE_ELEM on a sockmap
>
> With this patch, the map update fails with -EINVAL for the rest of the
> socket's life.
>
> Could the stable-facing paragraph that lists the user-visible changes als=
o
> say that a socket that was ever attached can no longer be added to a
> sockmap or sockhash?

Good catch, I'll list the sockmap case in the stable paragraph,
and I'll fix the earlier paragraph that said the -EINVAL only applied to
attached sockets.

> > listen() after a disconnect fails with -EINVAL, as
> > the dummy has no .clone, and rmmod kcm waits until such sockets are
> > destroyed.
>
> [Severity: Low]
>
> Is "waits" accurate here? Unloading does not block on a non-zero module
> refcount:
>
> kernel/module/main.c:try_stop_module() {
>         /* If it's not unused, quit unless we're forcing. */
>         if (try_release_module_ref(mod) !=3D 0) {
>                 *forced =3D try_force_unload(flags);
>                 if (!(*forced))
>                         return -EWOULDBLOCK;
>         }
>     ...
> }
>
> The reference taken by __module_get() in kcm_attach() is only dropped by
> tcp_cleanup_ulp() when the TCP socket is destroyed. As long as any TCP
> socket that was once attached still exists, rmmod kcm fails at once with
> "Module kcm is in use". This holds even after every KCM socket is closed
> and every socket has been unattached.

Right, rmmod fails immediately rather than waiting. I'll reword it to say
it fails while any once-attached socket exists.

> > diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
> > index a7f94d42036fb..1f8bcbb8b9c3b 100644
> > --- a/net/kcm/kcmsock.c
> > +++ b/net/kcm/kcmsock.c
> > @@ -30,11 +30,26 @@
>
> [ ... ]
>
> > +/* Not registered, so TCP_ULP can't select it. It only holds
> > + * icsk_ulp_ops so tcp_set_ulp() refuses other ULPs like kTLS. Like an=
y
> > + * ULP it stays until the socket is destroyed, pinning this module, an=
d
> > + * tcp_cleanup_ulp() releases it. Clearing it on a live socket would r=
ace
> > + * with lockless readers such as do_tcp_getsockopt() and tcp_diag.
> > + *
> > + * No .clone: children copy icsk_ulp_ops without a module reference, s=
o
> > + * a socket that was once attached must not listen().
> > + */
> > +static const struct tcp_ulp_ops kcm_ulp_ops =3D {
> > +     .name =3D "kcm",
> > +     .owner =3D THIS_MODULE,
> > +};
>
> [Severity: Low]
>
> This isn't a bug, but should Documentation/networking/kcm.rst be updated
> as well? The "Attach transport sockets" section only says:
>
>   - fd: file descriptor for TCP socket being attached
>
> The "Unattach transport sockets" section says unattaching "is
> straightforward".
>
> After this patch, SIOCKCMATTACH refuses raw IPPROTO_TCP sockets and
> sockets that already have a ULP, both with -EOPNOTSUPP.
>
> The kcm marker also stays after SIOCKCMUNATTACH. For the rest of the
> socket's life:
>
>   - setting TCP_ULP fails with -EEXIST
>   - getsockopt(TCP_ULP) and inet_diag report "kcm"
>   - listen() fails with -EINVAL
>   - sockmap insertion fails with -EINVAL
>   - PSP RX association is refused

Yes. The next version updates kcm.rst.

> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261102220310.12649-1-rjethwani%40purestorage.com

pw-bot: cr
