Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960C13AC0CB
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 16:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780588819; cv=pass; b=sswdCr7OIPcxEfNpDqSTPY+BaAn9ooP+nYmF53osgma0uUFxjVcompKwX4higyYLIpDHtezTKnQAcOTprcVbVXIvgwY8hQ6UGwMcEUlqAFE2b7Y0zmxj32Iwdo6S1UOs6EqJdqBwRnIS53Aob4uF2tMAgD0fqC0abXUHWJ8nk64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780588819; c=relaxed/simple;
	bh=bLe1Y9Of8HNmICgPAiQwdq9YGoPx+pI+2J6qjn08Evs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PU56knB+4BS9Ln4pm/gKI9EuQrIcE458KjI4wiIJhP98u+Ux6gZslXCwpqz7yJctP+N07dBLQzaDCILhmGWIhPpP0thyu8Ods2AiwcscAiQvvVCFZHG65PB322ClCdJ68KNYTI8vh8YwXBCo7O/18+6kmdUbQXgbvpyUduTk4Hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u+W5gTsp; arc=pass smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u+W5gTsp"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8ce9df4732cso8830216d6.1
        for <stable@vger.kernel.org>; Thu, 04 Jun 2026 09:00:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780588818; cv=none;
        d=google.com; s=arc-20240605;
        b=Dd/igMxMvnYbDYytaldvSjXwULF3qaA1OlHvXptAkBDeNfN/Ikr60VU1CF/kS2/wNB
         mEJVQsSe9kqwdyD4fCmXG03ka2Lky+rjPTRllqCdpwuAvzy0cuNVRiTYYEPLH1DtWCvo
         9oL5yxdun5CYtmGEgTkRZpdY7Dq9E22Hor7+mAsHIH85e5my3uw/ayZd2KeqTCjHfJuU
         YQokoHYUD1bpdko5yDckrlL/3BkLQzmLsH1CiXjA5YDuJUvWslJgDYjXLeXnJIxt3Fl7
         ZSjj7vt/Oi8s2HdQEaDRbvsktPTx19ZbFTomcZISFJYas8CpRrKDH0BZ7qm/s50CrMik
         twqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cLg4KQvgwweGiSdYyzi1L3wlPRaBrfee+IZJmKuxAhM=;
        fh=JdTjzB2VDIP9BLPK5yscI4u1re62R+f2YRKM6t055Jo=;
        b=Y37yVZ3qWkbKfrs8stIZuBUlvNB2CAWXQePKGdCVIhL3HYctKforr8xBeFqv7ZzD0R
         zM7c+qSJYwFdTjQLaqDtI7z0eOPzp/sCr+wLlbK0FDTKiHNUB1LiCofVo/zCqMVU7gv6
         fxJh87zaoH9FeD90NKoxjgXMeFS27B33WrB+XUmdwdTkV5gXVSYH/b298SdXR0Xxhrbl
         DoL0qk+ofAFXK1pmXVjNy7ZcSzEg5sk4UXikoLdCq8lvByNHONYUnJ2PYKSnFwS2IcTJ
         sEpiosvyqxUFbEn7ZA/CdXSpiBDb804n0iYmsq/iY+cbr5U0K7jMubS+umpMbK+fDzo3
         8iPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780588818; x=1781193618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLg4KQvgwweGiSdYyzi1L3wlPRaBrfee+IZJmKuxAhM=;
        b=u+W5gTspgU7emHOlGec2XqngThnMxBQIKTmm7vfRDrXp13HcKDwBJjAihc7t3EVcT8
         7PAf76n/MVCgsKKCLlhchuRER60XCV/cXii/0T7dsooZuC1hD7ieY4Aj/zvqVX/xvGN0
         QBDzEz0fciASkL2RhvgytvVNAJKI8T7lIuibo8PmROiBAN7+FOGUmNRjJ6RZiBynNTcI
         k0M63+CNU9VSJujY23LYFOrzISTbMaCdN6d7vL6DriLQ0z3PAC7UWwmV2lndt4uJys+c
         4t+SPr7gsQ2hlPFUNUB53m3Quu6cmb3KiEcx+SDTCgwKymj626Zmwp2Fe7KJ7VBTm6rD
         qRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780588818; x=1781193618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cLg4KQvgwweGiSdYyzi1L3wlPRaBrfee+IZJmKuxAhM=;
        b=qB08Qy4Bfc9Z2oNSwHBT96gBfUbtFMRZYCfShA++tQSSH8D4sAPD5AGVnuhkH6xk7Y
         ohI59EbyJm4Z3wDdZQ7vWfP76iKIEV5SowDaD0Fzh/QTqubgYh0vD9+IVZ6GT7TmJyZe
         kQ4i1SFGY6weswVoArfsuPjaRaQY/uiAAf8QPsm2XuYWFAoFe2/7EPnKUXX9bHPX696Y
         IdR2IaHItjGkkyKbG9Z4DzDtCmLi1k9A4hhYgf6lfptaNrJNK05IRUrAEDmGeflu2xtg
         aLsLcNEaWDvhGooU9h/I42alYIebXA0yQMhbTCRf66BmglQsfb2ejgqwZ6dciTW11avI
         Hx6g==
X-Forwarded-Encrypted: i=1; AFNElJ+qplFRjSYpzNc661Q9ph3YufrL9fpy3JpJnzJ7Y5MEWMvD2q2D/qbl2Gd/n/BC8r5YTsbHoCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD/v09hSXS8AfndT8hSEFeLApNjpV2P8zjQN9odgm3XJUroCB+
	sBKGFjo2CHcgbbFvaXCpKAReWmID5EDlAPHQWz3uUf6V5MELXx4ESi0FGc0QzAg7lCAPvl7FuiK
	og/vF/D0wWFSjdZl2sjBgRBx+87JemNMKkz5buynDeqGKu0rXs44jTLGU
X-Gm-Gg: Acq92OHXsaZeA1F+y5II4byQCZ6ixJBVTCTQ/3S2ab+GTKNRBO8Sw4u8oNW0/fO8f/O
	Mg6xs4xQHKZ5t/e2yuovUw0nxmr5wFwWjH0rWIavV4eUjqr7g9ExoPb2IjDcylEYBjVwJwgXfji
	ITIM7lxJaaYAc8irLjhgt8bYb7BnzqAQj3aJ846+thF1T9VeMvYInTKcWJkTyDrTprsNl1WuWbM
	6XO1RWM5Dlfj4kOS+4mDNW3lJB+gnF7RD2+8N9TOBGCed5e4CI3yQMk4/T+diJca/U2UABjrc4z
	SJTlgTuOdCeOfGJ4wVPRoG3PrEGKDtzcf71IgWOGsPPi4G0cdK21DIaPPnw6U9HU7DWmh4XP5HA
	MFnoFJSsQn9JxPTmV153oqx6Kd+mtig==
X-Received: by 2002:a05:6214:3c9f:b0:8ce:a005:3e93 with SMTP id
 6a1803df08f44-8cece02dadamr121809056d6.35.1780588815554; Thu, 04 Jun 2026
 09:00:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603162737.697215-1-rhkrqnwk98@gmail.com> <b5d4d726-c32f-45e4-9ea7-28f7b6a1f8d7@linux.dev>
In-Reply-To: <b5d4d726-c32f-45e4-9ea7-28f7b6a1f8d7@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 4 Jun 2026 09:00:04 -0700
X-Gm-Features: AVHnY4KFeB_7dmL9P1vPP7kjQ_Xqs-Cnp4utG2D6VMV7WmTclo4knkrnYzYYWMU
Message-ID: <CANn89iLhibjsgf-nk5U9be5kRpg3k4FXchKszmerkMbaaK6z6w@mail.gmail.com>
Subject: Re: [PATCH net v2] udp: clear skb->dev before running a sockmap verdict
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Sechang Lim <rhkrqnwk98@gmail.com>, willemdebruijn.kernel@gmail.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, jakub@cloudflare.com, 
	aleksander.lobakin@intel.com, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 6:49=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
>
>
> On 6/4/26 12:27 AM, Sechang Lim wrote:
> > On the UDP receive path skb->dev is repurposed as dev_scratch (the
> > truesize/state cache set by udp_set_dev_scratch()), through the
> > union { struct net_device *dev; unsigned long dev_scratch; } in sk_buff=
.
> >
> > When a UDP socket is in a sockmap, sk_data_ready is
> > sk_psock_verdict_data_ready(), which calls udp_read_skb() -> recv_actor=
()
> > (sk_psock_verdict_recv) to run the attached SK_SKB verdict program in s=
oftirq.
> > If that program calls a socket-lookup helper (bpf_sk_lookup_tcp/udp,
> > bpf_skc_lookup_tcp), bpf_skc_lookup() does:
> >
> >       if (skb->dev)
> >               caller_net =3D dev_net(skb->dev);
> >
> > skb->dev still holds the dev_scratch value (a non-NULL integer), so dev=
_net()
> > dereferences it as a struct net_device * and the kernel takes a general
> > protection fault on a non-canonical address in softirq:
> >
> >    Oops: general protection fault, probably for non-canonical address 0=
x1010000800004a0
> >    CPU: 1 UID: 0 PID: 1406 Comm: syz.2.19 Not tainted 7.1.0-rc6 #1 PREE=
MPT(full)
> >    RIP: 0010:bpf_skc_lookup net/core/filter.c:7033 [inline]
> >    RIP: 0010:bpf_sk_lookup+0x45/0x160 net/core/filter.c:7047
> >    Call Trace:
> >     <IRQ>
> >     bpf_prog_4675cb904b7071f8+0x12e/0x14e
> >     bpf_prog_run_pin_on_cpu+0xc6/0x1f0
> >     sk_psock_verdict_recv+0x1ba/0x350
> >     udp_read_skb+0x31a/0x370
> >     sk_psock_verdict_data_ready+0x2e3/0x600
> >     __udp_enqueue_schedule_skb+0x4c8/0x650
> >     udpv6_queue_rcv_one_skb+0x3ec/0x740
> >     udp6_unicast_rcv_skb+0x11d/0x140
> >     ip6_protocol_deliver_rcu+0x61e/0x950
> >     ip6_input_finish+0xa9/0x150
> >     NF_HOOK+0x286/0x2f0
> >     ip6_input+0x117/0x220
> >     NF_HOOK+0x286/0x2f0
> >     __netif_receive_skb+0x85/0x200
> >     process_backlog+0x374/0x9a0
> >     __napi_poll+0x4f/0x1c0
> >     net_rx_action+0x3b0/0x770
> >     handle_softirqs+0x15a/0x460
> >     do_softirq+0x57/0x80
> >     </IRQ>
> >
> > The rmem charge that dev_scratch accounted for is released by skb_recv_=
udp() on
> > dequeue, just above, so the scratch is dead by the time recv_actor() ru=
ns. Clear
> > skb->dev so bpf_skc_lookup() falls back to sock_net(skb->sk), which
> > skb_set_owner_sk_safe() set just above.
> >
> > Fixes: 965b57b469a5 ("net: Introduce a new proto_ops ->read_skb()")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
>
>
> Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: Eric Dumazet <edumazet@google.com>
