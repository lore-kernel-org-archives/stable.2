Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E264B53ED
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 23:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788997679; cv=pass; b=jNuUrJlfcuM1ZKQ8bGWRjlkoVHzhjEhH0J7gnAK8wwNqLeX+pkK6dZCy5vZJNXDnANtzR5ez6pYAVcIF4Mu9FZ6jBlo55mKCxhqHyAYxRig5Yz2mFLBqPsnpGOgs2sSQsNpdEdy5PNQokyEP2kOegL5Jq3hns1l9WPIihgL9Gcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788997679; c=relaxed/simple;
	bh=TzfR92G/ZqsmMpaBNOzQVhWLe/bIn0jQxm+j5XHFKFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j1nNUinIoIhwz4pG91xfwWO/McG2wyaKTUdspDD5fhBg5FA0is7mPui0kJ3NN2loKOnT7IGjmr8mBzgRYmlpji+IaPMiNZy/jSG7ILZqN7Z7oF4D49IKwyU8PsaniQuS2IpzCuwLluPPxXRVUEvKV7PlrocAIuo25PtNd7qkuhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=PpfUetoi; arc=pass smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="PpfUetoi"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-90e92b99ab9so44902826d6.2
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 16:47:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788997676; cv=none;
        d=google.com; s=arc-20260327;
        b=iLxpx9yCbXzChQMTFCVoxUaVcF3/kWRqmRYFo2/PKyMgaHa61mQhZVbQ0T6GMrrYBS
         +ZvdWzXEkKodpuZ3+rqXvQ+wUYW7fCvsQWG+6GbxwEfbi7jy1Xm34YSdwg7297EQaN6a
         BDBmrsdFmCbF/AkZhUtaURGRIGA3+iYnAiVWJYPeFTlMG9kFebUUxJWUFpnsaBZ8rr4i
         ITcfm75jHAf4WzChEknlHRiJ3G09opLo6OkpMqd62dDuO+3Txf5X50kQNppnZ71Es3K6
         81vjPFZYvxWoSgvYJcoolV+sydoQeMaLmjUxvygaOPI/l+bPQss0UPiVqm95lcGT8fdN
         /ryA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xH3VKuOHcGNG5jgcfVxHJohV+smITx5P0xQk745eNs4=;
        fh=nde+78D0JEnZDM296NRZmoWbuiaV75tHN794gSZRa10=;
        b=kCrsv6rhk8YrYdjjACyoQ/e23mgYemW8HPtMy0MH+F5GjkwTpYqwFvOj4kQH98Vxx7
         3ZiZlSF66ndNE1itZaX6HF/3PuyjsBwnPRU4OqBhD8TK1gm6ntQ+kyypuKrViAYzZj5W
         cDUTt2mLu+lQZb6FIGv1iR191Jp6SqJUwRQrK7kHzlrVjVwkTLmTBQ0RnQryUM57xsrM
         Ls/2gq2dInvoIkw+BMOpzJS9un10IeRHDwbciuA5jKG15PzdKFQ7ZpnlcqqR/F33OWdp
         3TpXbaxOrGz8LI9SwkFK7eVRq2vMq1DmKuEBgNPe7CF+FjI6QJrWq1LTGSm/B+Aap0kl
         lXSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1788997676; x=1789602476; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xH3VKuOHcGNG5jgcfVxHJohV+smITx5P0xQk745eNs4=;
        b=PpfUetoiai13AkBLgkCd/bmMnWXja8C8kr+bsOBuUmVr/Exe2BR/E07Pnl6t+sn/+H
         p8TlkumeA+a14yUKlvzKGdwJwW4JYfh0Hhy9tV1O7ZjESfmo/T65LN1wj4aiBtyhCoNi
         5ajowrOHscogHbOKwkaRgQViiO35DWfYnQMMKFctK/gGB4d+ao21vJDKt3iivAiZTP1y
         99nAgt1fQ2t7FIh+e4vI5oxUKhBrNYvL/W/+AflaSk7J4Fr33nS0zILHw7SHVlqK4Jhl
         1X84giZcp9mYu4sjEoqw8EibDP6CLxcwy0W2EPXSKOSTu8wJ5hCT1MkYrPLvk/+ZbSF1
         LyXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788997676; x=1789602476;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xH3VKuOHcGNG5jgcfVxHJohV+smITx5P0xQk745eNs4=;
        b=AKaaMcUnIS32tZVY4CQDOS8R/mwUDWXieoy/6vdBXZGK+iPYeB1+6D3lehonhEiuH2
         Nn5x0tWD+oEW9ylunf3EnHbVM2TGW98+hq7ZIDb9Z/tXOLHllspxZIOKQE2MQxR3B4AX
         GY+un2DYFmEb8s2azRbG23dV8f9uoYLwfLTw/o5ka5jvB0cw38cQt4eodDAIBkhvps3S
         DwdBAO8Q0hdaNWm9vj0vedVOqQBNyc8Bxq4W8Ws4OGUQUHXzfOVD+qwwU4RtHpCDfTPU
         EosKdWo9+BXNoJAoFU7tpU3CoIfYUcyDbiwONK4LjsmeFHU+MDpNmDsoBLGOLdT6AtsA
         U+KA==
X-Forwarded-Encrypted: i=1; AKwUvBwFaP35101pmvmb2SsvQVn+WfUUDzOzpOIedna2eKfajxkR32wKWxT4RxieqFK5rjHHW+Y/aCA=@vger.kernel.org
X-Gm-Message-State: AFuF++n6DFuTZ4219HjecjBzLm5rZruzWzpzb7sbPk8jYjjKx+PqeIPH
	zXMXKNEWm/VgRdMBp//plcE3nohGC4f1k02xSK4Sp/tC3u+YUDxWsP+gl3Ml+z4qye8+JrSommN
	WKwS7tI1UJTVNiX0urSAe3F0TDTaTt4gGxdxyTZaj
X-Gm-Gg: AYBFou2U0B4DUrbKB5Gj5USlTi5yuHAz/u4+QD4s5Gnk0X96l+fUm7/5HHcE1JG5Fp5
	GKgjqwsbW7iD8DstSrVUJ8e6I7/BlEfJH3ufueKm1QOQFHUdv2xtymeVB6Cvl8KvvTG6jtosvRY
	+bCV7/sS+o00uOMjjmM4s7h4S8nUkeTldrZfL2B1qUqDNeOQGwbFYwGz4qWXnitKXgTWpYbxIcR
	TeCZO0ly6m0KPOGyHWaqRqYe1AEOvOKaJevSWs5ewI1Wp6Dbr1n6NjRumaNFm9QcOFM+9waIOTn
	kgzP90GuwIp/cbVuzHIzgTHZ9wlmytTHYjXGkwUQdASrKwxs4/hfyl2BJhmdDN/qEzc290YID/W
	so4yTeSGu+g==
X-Received: by 2002:ad4:5de8:0:b0:910:6af9:1d72 with SMTP id
 6a1803df08f44-9106af91da5mr129406966d6.31.1788997676092; Wed, 09 Sep 2026
 16:47:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260906030429.2085375-1-xmei5@asu.edu> <CAJwJo6asOVa21T==+n7qdso1DBvH6Y3rXo24DdieAQS6XeTutw@mail.gmail.com>
In-Reply-To: <CAJwJo6asOVa21T==+n7qdso1DBvH6Y3rXo24DdieAQS6XeTutw@mail.gmail.com>
From: Xiang Mei <xmei5@asu.edu>
Date: Wed, 9 Sep 2026 16:47:42 -0700
X-Gm-Features: AcwNN1UiBh3NJcCSX8E1wX6USEz_oxNP1zRPwzTndRpXXXtiZQRYVGEbvfFQdLc
Message-ID: <CAPpSM+TEU=d9CCtkPYdD4h4m8WGbwa8SDV3s2Hf_v6C9GWAztA@mail.gmail.com>
Subject: Re: [PATCH net v2] net/tcp-ao: don't dereference NULL current_key/rnext_key
To: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Salam Noureddine <noureddine@arista.com>, David Ahern <dsahern@kernel.org>, co+2c72469dbbec34af@bugs.sh, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 9:32=E2=80=AFPM Dmitry Safonov <0x7f454c46@gmail.com=
> wrote:
>
> Hi Xiang,
>
> Thanks for your report and the proposed fix.
> I remember I wanted to write tests for re-connect() on the same
> socket, but never found time for this, as it's not really used in BGP,
> as far as I'm aware.
>
> On Sun, 6 Sept 2026 at 04:04, Xiang Mei <xmei5@asu.edu> wrote:
> >
> > TCP_AO_DEL_KEY with del_async=3D1 is accepted in TCP_LISTEN and NULLs
> > current_key and rnext_key; tcp_ao_connect_init() clears them on a
> > reconnect.  Five readers dereference them without a check.
> >
> > tcp_ao_time_wait() leaves tp->ao_info pointing at the tcp_ao_info it
> > hands the TIME_WAIT socket, and tcp_done() skips inet_csk_destroy_sock(=
)
> > on the tcp_fin() FIN_WAIT2 path, so the full socket stays in TCP_CLOSE
> > with its fd open, sharing that object.  An unprivileged
> > connect(AF_UNSPEC) + listen() then clears rnext_key while the TIME_WAIT
> > socket reads it from softirq, and tcp_v4_timewait_ack() dereferences it=
.
> > The segment need not be authenticated: tcp_v4_rcv()'s do_time_wait: pat=
h
> > skips tcp_inbound_hash().
> >
> > Check both fields and drop the segment when the key is gone; without on=
e
> > no valid signature can be produced.  In tcp_inbound_ao_hash() this must
> > be a drop rather than a fallthrough to the keyid lookup, which would le=
t
> > the peer pick the verification key that rnext_key pins.
> >
> > This removes the dereferences only; the two sockets still share one
> > mutable tcp_ao_info, leaving snd_sne, lisn and sk_omem_alloc racy.  The
> > first Fixes: is where the unchecked read came from, not the sharing.
> >
> >   Oops: general protection fault, probably for non-canonical address
> >     0xdffffc0000000010: 0000 [#1] SMP KASAN NOPTI
> >   KASAN: null-ptr-deref in range [0x0000000000000080-0x0000000000000087=
]
> >   RIP: 0010:tcp_v4_rcv (net/ipv4/tcp_ipv4.c:1055 net/ipv4/tcp_ipv4.c:23=
33)
> >   Call Trace:
> >    <IRQ>
> >    ip_protocol_deliver_rcu (net/ipv4/ip_input.c:207)
> >    ip_local_deliver (net/ipv4/ip_input.c:262)
> >    ip_rcv (net/ipv4/ip_input.c:612)
> >    __netif_receive_skb_one_core (net/core/dev.c:6264)
> >    process_backlog (net/core/dev.c:6728)
> >    net_rx_action (net/core/dev.c:8007)
> >    handle_softirqs (kernel/softirq.c:645)
> >    </IRQ>
> >   Kernel panic - not syncing: Fatal exception in interrupt
> >
> > Fixes: decde2586b34 ("net/tcp: Add TCP-AO sign to twsk")
> > Fixes: 0a3a809089eb ("net/tcp: Verify inbound TCP-AO signed segments")
> > Cc: stable@vger.kernel.org
> > Reported-by: co+2c72469dbbec34af@bugs.sh
> > Closes: https://lore.kernel.org/all/YG9s0PiBKJZcXAKld3MToa1IVRJOUoKiaA5=
7%40bugs.sh/
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > ---
> > v2: drop the incomplete v1 fix; adding missing checks to avoid null-der=
ef
> >
> >  net/ipv4/tcp_ao.c   | 6 ++++++
> >  net/ipv4/tcp_ipv4.c | 4 ++++
> >  net/ipv6/tcp_ipv6.c | 2 ++
> >  3 files changed, 12 insertions(+)
> >
> > diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
> > index bb7bbc20ba3f..9c2e5c8c8fe3 100644
> > --- a/net/ipv4/tcp_ao.c
> > +++ b/net/ipv4/tcp_ao.c
> > @@ -857,6 +857,8 @@ int tcp_ao_prepare_reset(const struct sock *sk, str=
uct sk_buff *skb,
> >                         return -ENOENT;
> >                 *traffic_key =3D snd_other_key(*key);
> >                 rnext_key =3D READ_ONCE(ao_info->rnext_key);
> > +               if (!rnext_key)
> > +                       return -ENOENT;
>
> I think this is quite a big hammer to fix the re-connect() issue.
> In theory, we could even restrict connect()/listen() after TCP_CLOSE,
> but I think I have an idea how to address it "properly".
>
> I have a draft of a patch; I'll test it today and send it for review.
>

Thanks, Dmitry. I'll wait for your patch, and I would like to test your pat=
ch.

Xiang

> >                 *keyid =3D rnext_key->rcvid;
> >                 *sne =3D tcp_ao_compute_sne(READ_ONCE(ao_info->snd_sne)=
,
> >                                           snd_basis, seq);
> > @@ -1026,6 +1028,8 @@ tcp_inbound_ao_hash(struct sock *sk, const struct=
 sk_buff *skb,
> >                  * matching the rcvid in the mkt.
> >                  */
> >                 key =3D READ_ONCE(info->rnext_key);
> > +               if (!key)
> > +                       goto key_not_found;
> >                 if (key->rcvid !=3D aoh->keyid) {
> >                         key =3D tcp_ao_established_key(sk, info, -1, ao=
h->keyid);
> >                         if (!key)
> > @@ -1045,6 +1049,8 @@ tcp_inbound_ao_hash(struct sock *sk, const struct=
 sk_buff *skb,
> >                 if (err)
> >                         return err;
> >                 current_key =3D READ_ONCE(info->current_key);
> > +               if (!current_key)
> > +                       return SKB_DROP_REASON_TCP_AOFAILURE;
> >                 /* Key rotation: the peer asks us to use new key (RNext=
) */
> >                 if (unlikely(aoh->rnext_keyid !=3D current_key->sndid))=
 {
> >                         trace_tcp_ao_rnext_request(sk, skb, current_key=
->sndid,
> > diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> > index 9f053eb8b46e..93e073065b1b 100644
> > --- a/net/ipv4/tcp_ipv4.c
> > +++ b/net/ipv4/tcp_ipv4.c
> > @@ -1052,6 +1052,10 @@ static void tcp_v4_timewait_ack(struct sock *sk,=
 struct sk_buff *skb,
> >                 key.traffic_key =3D snd_other_key(key.ao_key);
> >                 key.sne =3D READ_ONCE(ao_info->snd_sne);
> >                 rnext_key =3D READ_ONCE(ao_info->rnext_key);
> > +               if (!rnext_key) {
> > +                       inet_twsk_put(tw);
> > +                       return;
> > +               }
> >                 key.rcv_next =3D rnext_key->rcvid;
> >                 key.type =3D TCP_KEY_AO;
> >  #else
> > diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> > index df9c29eb5c1f..0fb75d139430 100644
> > --- a/net/ipv6/tcp_ipv6.c
> > +++ b/net/ipv6/tcp_ipv6.c
> > @@ -1182,6 +1182,8 @@ static void tcp_v6_timewait_ack(struct sock *sk, =
struct sk_buff *skb,
> >                 key.traffic_key =3D snd_other_key(key.ao_key);
> >                 /* rcv_next switches to our rcv_next */
> >                 rnext_key =3D READ_ONCE(ao_info->rnext_key);
> > +               if (!rnext_key)
> > +                       goto out;
> >                 key.rcv_next =3D rnext_key->rcvid;
> >                 key.sne =3D READ_ONCE(ao_info->snd_sne);
> >                 key.type =3D TCP_KEY_AO;
> > --
> > 2.43.0
> >
>
> Thanks again,
>              Dmitry
