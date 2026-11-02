Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604526;
	b=FQFyQl+sKikK5kfQP4bYczaJA7jjFdC5t6hamzQLIAdjUitb5Gmv1rI4j2P4XURRbgnC
	 aXb9t4xH4A7aeKfGd44dbJ0FNBN1IRa8kyIaZclSk89m76b3Qr7rHmBAH4oj6wwquYhSN
	 BoJ1yYJdwH6zjFoBY4iO4HcwA6AzK+Ip0Zx2w44tmAO38fmVNjsY3MxPqce9AEK8/j8VL
	 6+SYIM1lh0sJy5b17v4dqBY+uE3vIoVW6LViFO5+a8ucnZ2dcImh4cSqRUyWKBRwuq9DN
	 +nMUo6Tz/2WZtXz+KJGRNUfD+WM2Kgc7yV4ihCVrfobpwMhnc5BSmVcB0WkLsj/vIVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604526;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=If3fE+lQ75xX1Vq7CvfUefIfI5ALcUIEaypG/wi/3sA=;
	b=dZt66fxEjTTJvyhJg2yNkt+rfr+OOuiKzDNcwfkS6JqMRQK3gPA7tar6T0yvzc5QJy8x
	 Au/onrxeAxipU+KefVxQ3cUZm5EW980tY2IzoVTuH55yskrfaZm/HKAAXGpPUxO/pGEH6
	 xcIe+oq9zN4SA7VI/F9hWbCQ3QzEGcaEXtS8905ej0A6T5haOrk1rHdwgjufdLRqdJ5DJ
	 obqM1lewiS46B7gnOiuhGWpOfs2eTcaPekfcW+iIXS9/xobZb6ZMGSwmJRHSmnl44Mlzx
	 C5r25OjEWWIvnuMY5lk/wt69tKd3leCUi07CxO+uuxysJht9QEAJrhC+qQmxLxkF39A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ANPfABDF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E20D606A332
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 07:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ANPfABDF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 228031F00A1C
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 07:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793604525;
	bh=If3fE+lQ75xX1Vq7CvfUefIfI5ALcUIEaypG/wi/3sA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ANPfABDFS9h7v/zbtspJG+jpYTY9mf6Dam/W28kcKLm2ElLtClCumMoi7Wt2af5+/
	 dFHPLET3iKdbIwJzB7VPdp7ycb0T0Ajh7Gmm8+KUhbLlfjEzgNqi5eWUYtFCrAPdML
	 RQja44X2DHa0nNp70DsTNsvGWogE5vZKhZ2yOFWg9BI+JWay6Vi9wWh/8qado2DYaZ
	 AouH8S9bo95qcgiW56f8ZpuYHJTmpP3Xwj09585H2XkOi39XFH1/QxaBbJzGE540uR
	 hwsJx289rCqh7nRomwoAXFNMIRZglGFTSBQHqU/+oFjnvDV7mnRIJUKKzFlkR9Whpk
	 JNMeU/PVt2dLQ==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-702dedeb70dso1865725eaf.1
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 23:28:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvByZPNuww0sztsx/heLbId0M4LxZjF7i9Q0iBf3GhWoNsW997p88gwO3V9KZJfsoUeSBPKVR1l8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIz+APsB6azPuPfl/3mr/hOA0lpvijPq0ZtNaSBC9GkppOKd/SQ
	Ot8A/Rjtby2ajACgiILF2HFTU18PDEieJwIPs5YXiQT5b0oeI5FYMJjprqsN9kVb2XuLquOyuIT
	AHp/epYTBnBlth9PtsV8R7nUGZ5QsUjo=
X-Received: by 2002:a05:6820:5709:10b0:70a:df8e:8f64 with SMTP id
 006d021491bc7-714f23f7d98mr3415125eaf.22.1793604524395; Sun, 01 Nov 2026
 23:28:44 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <82c31e4d5043f3dbd11b44177cfba779d335aae3.1793599929.git.x-professor@outlook.com>
 <aug0tMr2QXRxTWuE@google.com>
In-Reply-To: <aug0tMr2QXRxTWuE@google.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Mon, 2 Nov 2026 08:28:32 +0100
X-Gmail-Original-Message-ID: <CAL4WiiqMbiJS07YwNCNKsY6UMLsU+XDoemJMnHvrZz_+ayiOTw@mail.gmail.com>
X-Gm-Features: AclHuK-qkDj2lomKdPUBIYW2cw33-lPnwEAvc_Rj2h8jY0csV8s3qylZZM4N8nA
Message-ID: <CAL4WiiqMbiJS07YwNCNKsY6UMLsU+XDoemJMnHvrZz_+ayiOTw@mail.gmail.com>
Subject: Re: [PATCH net] tcp: ipv6: keep request pktopts alive until request destruction
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Yingjie Wang <x-professor@outlook.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "ncardwell@google.com" <ncardwell@google.com>, 
	"davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "martin.lau@linux.dev" <martin.lau@linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 2 nov. 2026 =C3=A0 08:03, Kuniyuki Iwashima <kuniyu@google.com> a =
=C3=A9crit :
>
> On Mon, 02 Nov 2026 06:12:18 +0000, Yingjie Wang wrote:
> > When IPv6 flow label reflection is enabled, tcp_v6_send_synack() reads
> > ireq->pktopts to copy the flow label from the initial SYN.
> >
> > Request sockets can be processed without the listener lock. A
> > retransmitted SYN can therefore run tcp_v6_send_synack() while a
> > concurrent final ACK creates the child in tcp_v6_syn_recv_sock(). The
> > latter clones ireq->pktopts for the child and immediately consumes the
> > request's reference. This can free the skb while the retransmit path is
> > still reading its IPv6 header, causing a use-after-free.
> >
> > Request migration has the same ownership problem. inet_reqsk_clone()
> > copies pktopts without taking an skb reference, and reqsk_migrate_reset=
()
> > then clears the old request's pointer. A CPU holding the old request ca=
n
> > still be sending a SYNACK when the cloned request releases the only skb
> > reference.
> >
> > Do not consume pktopts while creating the child. Give each cloned reque=
st
> > its own skb reference and let every request release its reference from
> > tcp_v6_reqsk_destructor().
> >
> > I found this while testing IPv6 TCP request-socket lifetime handling. T=
he
> > reproducer required no source changes, artificial delay, or fault
> > injection beyond enabling KASAN. It triggered the use-after-free before
> > this change. With this change, a 2000-round run completed without a KAS=
AN
> > report. A separate 10-round test recorded four successful request
> > migrations and no KASAN report. Networking selftests were not run becau=
se
> > none directly exercises this race.
> >
> > Fixes: e994b2f0fb92 ("tcp: do not lock listener to process SYN packets"=
)
> > Fixes: 079096f103fa ("tcp/dccp: install syn_recv requests into ehash ta=
ble")
> > Fixes: c905dee62232 ("tcp: Migrate TCP_NEW_SYN_RECV requests at retrans=
mitting SYN+ACKs.")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Yingjie Wang <x-professor@outlook.com>
> > ---
> >  net/ipv4/inet_connection_sock.c | 6 +++++-
> >  net/ipv6/tcp_ipv6.c             | 7 ++++---
> >  2 files changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection=
_sock.c
> > index 93b306d91b6d..66f8ce25aa38 100644
> > --- a/net/ipv4/inet_connection_sock.c
> > +++ b/net/ipv4/inet_connection_sock.c
> > @@ -936,6 +936,11 @@ static struct request_sock *inet_reqsk_clone(struc=
t request_sock *req,
> >                     req->rsk_ops->obj_size - offsetof(struct sock, sk_d=
ontcopy_end),
> >                     /* alloc is larger than struct, see above */);
> >
> > +#if IS_ENABLED(CONFIG_IPV6)
> > +     if (inet_rsk(nreq)->pktopts)
> > +             skb_get(inet_rsk(nreq)->pktopts);
> > +#endif
> > +
> >       sk_node_init(&nreq_sk->sk_node);
> >       nreq_sk->sk_tx_queue_mapping =3D req_sk->sk_tx_queue_mapping;
> >  #ifdef CONFIG_SOCK_RX_QUEUE_MAPPING
> > @@ -982,7 +987,6 @@ static void reqsk_migrate_reset(struct request_sock=
 *req)
> >       req->saved_syn =3D NULL;
> >  #if IS_ENABLED(CONFIG_IPV6)
> >       inet_rsk(req)->ipv6_opt =3D NULL;
> > -     inet_rsk(req)->pktopts =3D NULL;
> >  #else
> >       inet_rsk(req)->ireq_opt =3D NULL;
> >  #endif
> > diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> > index e006a30360ea..0b51cb4ad960 100644
> > --- a/net/ipv6/tcp_ipv6.c
> > +++ b/net/ipv6/tcp_ipv6.c
> > @@ -1522,11 +1522,12 @@ static struct sock *tcp_v6_syn_recv_sock(const =
struct sock *sk, struct sk_buff *
> >       if (*own_req) {
> >               tcp_move_syn(newtp, req);
> >
> > -             /* Clone pktoptions received with SYN, if we own the req =
*/
> > +             /* Clone pktoptions received with SYN. Keep the request's
> > +              * reference until the request is destroyed, as a concurr=
ent
> > +              * SYN retransmit may still read it.
> > +              */
> >               if (ireq->pktopts) {
> >                       newnp->pktoptions =3D skb_clone_and_charge_r(ireq=
->pktopts, newsk);
> > -                     consume_skb(ireq->pktopts);
> > -                     ireq->pktopts =3D NULL;
>
> This is reported from another person in security@ mailing list
> yesterday and Eric has a better fix.
>
> pw-bot: rejected

Indeed, I will add another 'Reported-by: Yingjie Wang
<x-professor@outlook.com>' tag.

Thanks.
