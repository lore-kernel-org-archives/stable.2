Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6200A2F8E99
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 03:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788663960; cv=pass; b=SQBC5omLpq3iiiTFZOSExfQIB8WKtiG0GduzgGF2N+8TmhWS5vyImrP4Z7GiPQ+n3yRiKdEbyHpnIQfw/7SyumLJwBDy+VGmCBoQSVWUbi1jVbVLy1oJU8vA8BEy+titBiIzumfFE/CB2sHXPPBRp+QblSw88ifi7wINuyxvcNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788663960; c=relaxed/simple;
	bh=FBZEovwkP6JkNtewHLJkwCoSl2/H9H6Xv08rDc09dSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jUW657nwXQPw38/YUvrz7eLa4bQQ8eI7MsfevCj97t1KRvSx9Fa3xtNIpMDNmu8uhxj/dzxaULZ1/3VXG5kYR8IHkn7aQu5DM0+FQeui9afbgJkJBuHtBB9YvcD8bdx7rThyvtkUKrpBjMSDpF/JVGotnfuXjBsCH2i3caEX4MY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=T5f0nUyM; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="T5f0nUyM"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d6e954afbdso14676835ad.2
        for <stable@vger.kernel.org>; Sat, 05 Sep 2026 20:05:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788663957; cv=none;
        d=google.com; s=arc-20260327;
        b=PFQQzOAizGky9J40ck7ereHekE2yf4YyLUdhQrFydKrf/50CKWSbMVCqfQjTdgTR5G
         iIPIRRsWvTU+r4uUT/KbgiLLS0Li9q5+irZuQ2G1svdpSroHA8kEFV12UeKuaYsNPZtp
         QTG1deFmaAQuc/M6M74eJn7KdJf9iFiLhNisB+PLMVYjwcnmJp7PXEKCWTqZFC7MMnxo
         oE6OmUWe5BqmaV2LSpHhUkVOB1IJ/JMuWaI31CYqIUCvMHDaPzJQHbeyjIJSEW57V9/T
         p3rIAt94sOLhWqZYY+TFBSytK8vDjI5QS/vDYDUIAvKAuA6ZqbAqKMgsAHytGv+sN3EC
         OIfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dpLrLCFoJjkw2cdWEvFIb5+POiwQgWQC1L+uNJnIswo=;
        fh=QsqPBXyoiX/TZtC/ipp6qh/EbqayH8WAQRvz207uanE=;
        b=p7YUAOyLrX+WhQnXuzVlCxcv7OyI8O11TwLt6c1SnONm2O2rXa5Y/Z1iOiCuLRWQ/e
         YAI7sQtYpFNFXpND+FVFRQMweYDJPNpVFJCyDjxTkKu6B5jntgGAwJAFssxWQAb9LNpy
         veFxFjUdrd78YIYf82bBOhVZrmaMoYC8qlhKv8/MFOKqf803+obUpAg0XuFUbF7JMVXT
         Q9TtcPNy7Ar25jJuX4MD1wAq0tKewS6chEGNZALYuHm5ceSKHNaGatwGf8fD3KGhGSD8
         cMGfVCtvbZzLbqHSuvW0aDHtXknF3i6G8s0BjeDcrB75++sAnfxICPsE+C5TovAb76f5
         lrAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1788663957; x=1789268757; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dpLrLCFoJjkw2cdWEvFIb5+POiwQgWQC1L+uNJnIswo=;
        b=T5f0nUyMSYzE5khzA/Hzuo/5XoyNPyu5wUtXD4Uci1xlIb+j0F0bq+DCvn/91ZzRlh
         WQFqsPGlEU6J3SZMbL8SeQ0sfHQNkRl2UxWEwkx3V/ilVwX8u+jCvQCkLE8LaUUKzmqI
         d9g12kQX10hBDR0B+akrLbEUxQnyc8Cb15jDAfTfi2olx+Gblc31oDMVDz+hoLXGYZde
         dNKNKiDyqgGUBMzsgBuk8l3ZS76TQleRLfbY3ajoUFr4FK2Jh+KHa+6FfTxnY3lr9bMl
         YEqYmG658lj2zD1DthQWIdrctYd/y2e3KzhTNQHYpmInColSfnzzw7Y92LzK/iv8koAq
         BQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788663957; x=1789268757;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dpLrLCFoJjkw2cdWEvFIb5+POiwQgWQC1L+uNJnIswo=;
        b=CTGDc5D7eV2KJwGGAmrf3KYltB8pSyFCNiLvK4RRgIFcz+UzsKztgdDnotT+ZUIr6b
         BzbCfZhT49mNXREkD3ffWBhKXkKI1fmviz0orhyc6CEavXPN+pV0sgr9wm7WLS3EQBsf
         7DEXWdxhl61BW8BgtinW9iW20Kyl3ESBhSHDA4wqZPzdWurDZ+DvlqxSQUDpAWaMhn/S
         yET6bqWGOkbqGm0+JcILqnRmz+Fg0/fAN6SaKIJKbZGGFoIPcNjTgkRXefAw/IJOpPJg
         IJ8C6UrhTwJiizCMWkhTaPIEMW8sv7RwDeLgo0aRdkPuFm47k5l9pvR2zWC2Fu51WBD6
         f3sQ==
X-Forwarded-Encrypted: i=1; AKwUvByezDiHv775dE4tIjiA2cfzPI/grU/FMhDaSyZWa+8BJp+0PlLGZ20Akc0RHO653WIqrnQj7Bo=@vger.kernel.org
X-Gm-Message-State: AFuF++lZrjuqgMDeqbAwbdnaS7HJpwgBXtX6o818dh0+IpE3eVxazB60
	MOUn+uTILsEaSlMHZhOfIRuDjjMnxZDaZoc8K3HJ6qHP3XIeLOjJfd0ijEJhGjBNooqkckMXpcB
	X3o3MrXr15O37GdYoudYYCvcaPeEW9XyBlOllwSv8
X-Gm-Gg: AYBFou2/B5wmRWG6Px57QMWdZ2pbDNXtTlDiQw9Cdj0D49KYH/TEHSWA1+BsMqIUioe
	hJZ+k9vj5wRukCYbfp/Mjtol99ljwJl40r1t0I+VHYTQWuwRcuwJMDPuAYHU5F7HD1uNSEOaNp8
	HPehrS7LmepBc0u4wOlJ5p3EJZiSyQrgsh1Q68sGdWXRVS+HCAmONSNzancbyP0X7m2F4Nzl4k+
	TMbXlRtbRY0WRDoR6O3xFaJJ0l7JzSYKvosdTtGbwaQ+ZO4U1a6DDw3eVC+3My+xhBU0uSDsWEu
	GumTCFBJGw942fWrhlJWItseLwLsvr77WI8k5J8SoEGA3JV+e4gCT3qAqexvszlSI0U1dL+5xbQ
	=
X-Received: by 2002:a17:903:2c9:b0:2c9:e846:a57e with SMTP id
 d9443c01a7336-2db12147668mr238548425ad.0.1788663956574; Sat, 05 Sep 2026
 20:05:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904005851.149071-1-xmei5@asu.edu> <2e302fc8-b3ed-4441-bb62-9e509baa3868@linux.dev>
In-Reply-To: <2e302fc8-b3ed-4441-bb62-9e509baa3868@linux.dev>
From: Xiang Mei <xmei5@asu.edu>
Date: Sat, 5 Sep 2026 20:05:45 -0700
X-Gm-Features: AcwNN1VFoFtuDv4tYe4WWTHJvbblPxXaPT1j7sQieNggDfBwibyDktQMBHr_Pl4
Message-ID: <CAPpSM+SjREtY52VFQ+9G6HUpz2G=xqObaa-7y=Gz6H9xsWbdkg@mail.gmail.com>
Subject: Re: [PATCH net] net/tcp-ao: transfer tcp_ao_info to the TIME_WAIT socket
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dmitry Safonov <0x7f454c46@gmail.com>, Salam Noureddine <noureddine@arista.com>, 
	Francesco Ruggeri <fruggeri@arista.com>, David Ahern <dsahern@kernel.org>, co+2c72469dbbec34af@bugs.sh, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 7:42=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
>
>
> on 9/4/26 8:58 AM, Xiang Mei wrote:
> > tcp_ao_time_wait() gives the TIME_WAIT socket a reference to the full
> > socket's tcp_ao_info but leaves tp->ao_info pointing at the same object=
.
> > That is only safe if the full socket is going away. On the tcp_fin()
> > FIN_WAIT2 path (and TCP_CLOSING in tcp_rcv_state_process()) tcp_done()
> > skips inet_csk_destroy_sock(), so the socket lives on in TCP_CLOSE with
> > its fd open while the hashed TIME_WAIT socket reads the same tcp_ao_inf=
o
> > from softirq, serialised against nothing.
> >
> > An unprivileged user can turn that into a NULL deref: tcp_disconnect()
> > does not clear ao_info, so connect(AF_UNSPEC) + listen() reaches
> > TCP_LISTEN where TCP_AO_DEL_KEY accepts del_async=3D1 and NULLs
> > ao_info->rnext_key, which tcp_v4_timewait_ack() then dereferences
> > unchecked. The triggering segment need not be authenticated, as
> > tcp_v4_rcv()'s do_time_wait: path skips tcp_inbound_hash().
> >
> > The refcount keeps the object allocated for both sockets, but nothing
> > keeps its contents coherent: the setsockopt writers hold the full
> > socket's lock while the TIME_WAIT reader runs in softirq, and no lock
> > spans the two. Make the transition a handover, as the sk_omem_alloc
> > charge moved here already implies: clear tp->ao_info instead of taking =
a
> > second reference, leaving the TIME_WAIT socket as sole owner. Such a
> > socket no longer exposes TCP-AO state (TCP_AO_INFO and TCP_AO_DEL_KEY
> > return -ENOENT); that state describes the finished connection and
> > belongs to the TIME_WAIT socket that keeps updating it.
> >
> >    Oops: general protection fault, probably for non-canonical address
> >      0xdffffc0000000010: 0000 [#1] SMP KASAN NOPTI
> >    KASAN: null-ptr-deref in range [0x0000000000000080-0x000000000000008=
7]
> >    RIP: 0010:tcp_v4_rcv (net/ipv4/tcp_ipv4.c:1055 net/ipv4/tcp_ipv4.c:2=
333)
> >    Call Trace:
> >     <IRQ>
> >     ip_protocol_deliver_rcu (net/ipv4/ip_input.c:207)
> >     ip_local_deliver_finish (net/ipv4/ip_input.c:241)
> >     ip_local_deliver (net/ipv4/ip_input.c:262)
> >     ip_rcv (net/ipv4/ip_input.c:612)
> >     __netif_receive_skb_one_core (net/core/dev.c:6264)
> >     process_backlog (net/core/dev.c:6728)
> >     __napi_poll (net/core/dev.c:7787)
> >     net_rx_action (net/core/dev.c:8007)
> >     handle_softirqs (kernel/softirq.c:645)
> >     do_softirq.part.0 (kernel/softirq.c:546)
> >     </IRQ>
> >     <TASK>
> >     __local_bh_enable_ip (kernel/softirq.c:473)
> >     __dev_queue_xmit (net/core/dev.c:4961)
> >     ip_finish_output2 (net/ipv4/ip_output.c:236)
> >     ip_output (net/ipv4/ip_output.c:437)
> >     __ip_queue_xmit (net/ipv4/ip_output.c:533)
> >     __tcp_transmit_skb (net/ipv4/tcp_output.c:1716)
> >     tcp_connect (net/ipv4/tcp_output.c:4383)
> >     tcp_v4_connect (net/ipv4/tcp_ipv4.c:345)
> >     __inet_stream_connect (net/ipv4/af_inet.c:684)
> >     inet_stream_connect (net/ipv4/af_inet.c:755)
> >     __sys_connect (net/socket.c:2183)
> >     __x64_sys_connect (net/socket.c:2189)
> >     do_syscall_64 (arch/x86/entry/syscall_64.c:84)
> >     entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
> >     </TASK>
> >    Kernel panic - not syncing: Fatal exception in interrupt
> >
> > Fixes: decde2586b34 ("net/tcp: Add TCP-AO sign to twsk")
> > Cc: stable@vger.kernel.org
> > Reported-by: co+2c72469dbbec34af@bugs.sh
> > Closes: https://lore.kernel.org/all/YG9s0PiBKJZcXAKld3MToa1IVRJOUoKiaA5=
7%40bugs.sh/
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > ---
> >   net/ipv4/tcp_ao.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
> > index bb7bbc20ba3f..27525f90398b 100644
> > --- a/net/ipv4/tcp_ao.c
> > +++ b/net/ipv4/tcp_ao.c
> > @@ -428,7 +428,7 @@ void tcp_ao_time_wait(struct tcp_timewait_sock *tcp=
tw, struct tcp_sock *tp)
> >                       omem +=3D tcp_ao_sizeof_key(key);
> >               }
> >
> > -             refcount_inc(&ao_info->refcnt);
> > +             rcu_assign_pointer(tp->ao_info, NULL);
> >               atomic_sub(omem, &(((struct sock *)tp)->sk_omem_alloc));
> >               rcu_assign_pointer(tcptw->ao_info, ao_info);
> >       } else {
>
>
> This looks like the simplest fix.
>
> But this fix moves ownership of ao_info. Before, when a socket reconnects=
,
> we didn't need to add new ao_key info =E2=80=94 we could just reuse it. N=
ow
> after this
> fix, we have to re-add it on reconnect. I'm not sure if that case really
> exists.

You are right, the case exists.  I tested it: after tcp_time_wait() with th=
e
fd still open, connect(AF_UNSPEC) + connect() succeeds on mainline
without re-adding a key, and fails with this patch.  tcp_ao_connect_init()
is built for that reuse, so v1 breaks a working path.

Checking that also turned up a second way to reach the NULL:
tcp_ao_connect_init() clears current_key/rnext_key on a reconnect, on the
same object the TIME_WAIT socket reads from softirq. And the same two field=
s
are dereferenced unchecked in four more places: tcp_v6_timewait_ack(),
tcp_ao_prepare_reset() and two spots in tcp_inbound_ao_hash().

v2 has been proposed on:
https://lore.kernel.org/netdev/20260906030429.2085375-1-xmei5@asu.edu/T/#u

v2 covers all five and drops the segment when the key is gone, with no
key there is no valid signature to send.  In tcp_inbound_ao_hash() it has
to be a drop rather than a fallthrough to the keyid lookup, which would
otherwise let the peer choose the verification key that rnext_key pins.

I also prototyped the ownership fix, copying the state into the TIME_WAIT
socket the way tcp_time_wait_init() does for MD5.  It works and keeps the
reconnect, but it turns a refcount_inc() into a GFP_ATOMIC allocation per
TIME_WAIT socket in softirq that nothing accounts to a socket, so I'd
rather settle the direction first.  The sharing is still there after v2 and
snd_sne, lisn and sk_omem_alloc remain racy.

I may need your oppinion for the direction:

Deep-copy into the TIME_WAIT socket, or keep sharing and stop the writers
touching an in-use key?

Thanks,
Xiang
>
