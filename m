Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792773595;
	b=Oubv59MiqVlO/pzkt9o7OSvRWNrmWTBHPAALVP4IhpIctliufIidQyygswnxq8waTUcs
	 cJufKXcqQ5JX3AK5Wp5SBMZ+4DQ51lXezu9HMbLfi8DvUodL8uqHQHncWtyye3vQ0ZCZ8
	 nNiBiBCIypv8F3QIdTiXgRi31T/7ZMRG2w/jiR7wwFYZl2TM7VAFm4i39R3TSvckgt+kr
	 qJ/yEZ9PHbRTPi2gYfj2+z16EiJVF5ynb2RUXUlAU2LK/buSXOFf9VPxY86yXm20HQnzp
	 4jY4mbMvNoUXpfA+zDoLYRIM4QiTvKfZuQRflfL4TQUqD2rhqg8JyPsELqFxiZeOuGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792773595;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=eLoXF0D1za+hi3iGHkuVmbEpDQaUboIZtZF11tK6egI=;
	b=RcWnsURClIrD7Wa4Nraa5PN+aK2dQSiZQ4pv9IkkjPmIUoobxx992JtkQo6bii+fAgzW
	 ZKBmGmqxta1QkJgLD+GNunwedz4pLGGp75x1uw2ymjHYhIEI0YErLeDxvpPF9/M8+r7Yi
	 jgFazrrbb76sD5GKZcTlsxcKVOpIlEav72Sp/7jcXQ45IcRsELjaY0ivozFeuH/d0+OL+
	 crTAFG42PHyhDgJpFfYpf/LPIyjuvyjJ2cp4N4+y3V3lq/2pXZF1agOFviAlmEDNXouof
	 LvYFB9+GIvUZkxiZnLzLA8yGebvQS2ZGrJaLRVMMNNDwUy+62xrzxL/BvZcjJCENLHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LF1HFsFR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE7A606A31A
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 16:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LF1HFsFR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 120101F01825
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 16:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792773594;
	bh=eLoXF0D1za+hi3iGHkuVmbEpDQaUboIZtZF11tK6egI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=LF1HFsFRgVR247xGn5yUnHwE7uAVqBmIEP0ehd03WjbzyKMHRbR7nUibe7KnT0+0u
	 k6neao6LWEzpGPDlY92HwlAYOZDtR/jo9mXgpkgKFWi8R1zxibvxkEef1R07zndnJI
	 gDEyIyCenitIQR3q7E4jntodUP9Ix/Z3t45+PSN0Lay1HcHh3PcjHrGY3Hz7wJEgzr
	 1pKIwxBz8mlaNBZ6bql63JOLjkuI1CbiUSOEXqsFzFzP3Tu+R9mKtERMmcH64dKvbJ
	 0flHtdX9GhlaldIbj6XQ1aEUcSvXE+IQWxuaPfwD6516jrep/WbuZArZNZff9ltSdh
	 VuSDkUpuAjNEw==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-70b875f6f13so658306eaf.0
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 09:39:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzTaloj6rjqEltbON3gWhJSEP+NvLMqhV+odqJVRTA5j+L0RfoDrTtI44AgugtcXgYG9x5yrME=@vger.kernel.org
X-Gm-Message-State: AFq9FYLsrTIYUSEzNGjGjqJMucYdydxDR3jp6sua9KnUJDUiUiXhnfd9
	0Ix1FOwDTiJsI2xKclw5MbonaZqe18vRXcfdO5OvQFlWAsQK9c2Ryz/kwVGWP/TQc9C9YnOvGvp
	9hn/4XgkMfrcgYU4dNnZAW+iBqlepkhA=
X-Received: by 2002:a05:6820:1612:b0:707:27c7:86d9 with SMTP id
 006d021491bc7-70b88ab80e7mr1916749eaf.48.1792773593385; Fri, 23 Oct 2026
 09:39:53 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023052542.3505250-1-imv4bel@gmail.com> <20261023052542.3505250-2-imv4bel@gmail.com>
In-Reply-To: <20261023052542.3505250-2-imv4bel@gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Fri, 23 Oct 2026 18:39:41 +0200
X-Gmail-Original-Message-ID: <CAL4Wiio_6_a3-w9RqtC3Qpe=NXqtgBwqmSiKVbfbuPK60kSN5g@mail.gmail.com>
X-Gm-Features: AclHuK8_oAEk4nDhnB9KV9J3Amo3OdhyF8APHYjDQSj_Ehe4KSD5B3ictQTU8Vs
Message-ID: <CAL4Wiio_6_a3-w9RqtC3Qpe=NXqtgBwqmSiKVbfbuPK60kSN5g@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] inet: reject unhashed sockets during
 established lookups
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: ncardwell@google.com, kuniyu@google.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, martin.lau@linux.dev, 
	john.fastabend@gmail.com, weiwan@google.com, sd@queasysnail.net, 
	jiayuan.chen@linux.dev, netdev@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 23 oct. 2026 =C3=A0 07:26, Hyunwoo Kim <imv4bel@gmail.com> a =C3=A9=
crit :
>
> TCP established ehash lookups are lockless. The socket caches involved
> use SLAB_TYPESAFE_BY_RCU, so memory can be reused before an RCU reader
> that retained its old address has finished.
>
> After a tuple match, __inet_lookup_established() and
> __inet6_lookup_established() acquire a reference and repeat the tuple
> check. They do not check whether the new object is hashed. If the
> address is reused for a socket with the same tuple, the lookup can
> acquire a reference to the new object and return it while its nulls node
> is unhashed.
>
> A PoC that drives reuse with a SYN cookie request socket reproduced the
> crash. The new request socket is unhashed and has a NULL rsk_listener.
> A lookup that had loaded the address of the old request socket acquired
> the reference published by tcp_get_cookie_sock() and returned the new
> object. tcp_v4_rcv() then read sk_state through the NULL listener.
>
> The resulting crash was:
>
>   BUG: kernel NULL pointer dereference, address: 0000000000000012
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   ...
>   Oops: Oops: 0000 [#1] SMP NOPTI
>   CPU: 4 UID: 0 PID: 0 Comm: swapper/4 Not tainted 7.3.0-00591-g0e135910d=
eec #1 PREEMPT(lazy)
>   ...
>   RIP: 0010:tcp_v4_rcv+0x44e/0x1280
>   ...
>   R10: 0000000000000001 R11: 00000000024ca8c0 R12: 0000000000000000
>   ...
>   CR2: 0000000000000012 CR3: 0000000103d50004 CR4: 0000000000770ef0
>   ...
>   Call Trace:
>    <IRQ>
>    ? raw_local_deliver+0xae/0x240
>    ip_protocol_deliver_rcu+0x2d/0x180
>    ip_local_deliver_finish+0x84/0x100
>    ip_sublist_rcv_finish+0x5f/0x70
>    ip_sublist_rcv+0x12a/0x1d0
>    ip_list_rcv+0xfd/0x130
>    __netif_receive_skb_list_core+0x223/0x250
>    netif_receive_skb_list_internal+0x1d2/0x2c0
>    ? try_fill_recv+0x39/0x7b0
>    napi_complete_done+0x74/0x170
>    virtnet_poll+0x445/0x600
>    __napi_poll+0x27/0x1e0
>    net_rx_action+0x2fe/0x3b0
>    handle_softirqs+0xc2/0x2c0
>    __irq_exit_rcu+0x74/0xd0
>    common_interrupt+0x7f/0x90
>    </IRQ>
>   ...
>   Kernel panic - not syncing: Fatal exception in interrupt
>
> After taking a reference, check whether the nulls node is unhashed in
> both IPv4 and IPv6 established lookups. If it is unhashed or the tuple
> no longer matches, drop the reference and restart the lookup.
>
> Lookups racing with the TIME_WAIT hashdance, or with a request being
> replaced by its child, now restart and find the new socket instead of
> returning the old one.
>
> Request sockets that were never inserted into ehash can have a nonzero
> refcount, and a stale lookup can hold a transient reference. Therefore,
> when SYN cookie, Fast Open, and request migration paths fail after
> setting a nonzero refcount, release the references held by those paths
> with reqsk_put() instead of freeing the request directly.
>
> Fixes: 079096f103fa ("tcp/dccp: install syn_recv requests into ehash tabl=
e")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> ---
>  net/ipv4/inet_connection_sock.c | 10 +++++++---
>  net/ipv4/inet_hashtables.c      |  5 +++--
>  net/ipv4/syncookies.c           |  2 ++
>  net/ipv4/tcp_input.c            |  4 +++-
>  net/ipv6/inet6_hashtables.c     |  4 +++-
>  5 files changed, 18 insertions(+), 7 deletions(-)
>
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_s=
ock.c
> index 6a30f1138454..cff02f4c5ac8 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -1136,10 +1136,14 @@ static void reqsk_timer_handler(struct timer_list=
 *t)
>          */
>         if (nreq) {
>                 __NET_INC_STATS(net, LINUX_MIB_TCPMIGRATEREQFAILURE);
> +               /* The timer was not armed, drop its reference here. */
> +               reqsk_put(nreq);
>  no_ownership:
>                 reqsk_migrate_reset(nreq);
>                 reqsk_queue_removed(queue, nreq);
> -               __reqsk_free(nreq);
> +               /* Drop the ehash and temporary references. */

Lets change this comment to :
/* Drop the temporary reference and the one reserved for ehash. */

Reviewed-by: Eric Dumazet <edumazet@kernel.org>

> +               reqsk_put(nreq);
> +               reqsk_put(nreq);
>         }
>
>  drop:
> @@ -1447,7 +1451,7 @@ struct sock *inet_csk_complete_hashdance(struct soc=
k *sk, struct sock *child,
>
>                         __NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMIGRAT=
EREQFAILURE);
>                         reqsk_migrate_reset(nreq);
> -                       __reqsk_free(nreq);
> +                       reqsk_put(nreq);
>                 } else if (inet_csk_reqsk_queue_add(sk, req, child)) {
>                         return child;
>                 }
> @@ -1502,7 +1506,7 @@ void inet_csk_listen_stop(struct sock *sk)
>                                         __NET_INC_STATS(sock_net(nsk),
>                                                         LINUX_MIB_TCPMIGR=
ATEREQFAILURE);
>                                         reqsk_migrate_reset(nreq);
> -                                       __reqsk_free(nreq);
> +                                       reqsk_put(nreq);
>                                 }
>                                 rcu_read_unlock();
>
> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index ba0faa9ae2bb..58d54965036a 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -552,8 +552,9 @@ struct sock *__inet_lookup_established(const struct n=
et *net,
>                 if (likely(inet_match(net, sk, acookie, ports, dif, sdif)=
)) {
>                         if (unlikely(!refcount_inc_not_zero(&sk->sk_refcn=
t)))
>                                 goto out;
> -                       if (unlikely(!inet_match(net, sk, acookie,
> -                                                ports, dif, sdif))) {
> +                       if (unlikely(hlist_nulls_unhashed_lockless(&sk->s=
k_nulls_node) ||
> +                                    !inet_match(net, sk, acookie, ports,=
 dif,
> +                                                sdif))) {
>                                 sock_gen_put(sk);
>                                 goto begin;
>                         }
> diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> index 73e129768184..644030561537 100644
> --- a/net/ipv4/syncookies.c
> +++ b/net/ipv4/syncookies.c
> @@ -218,6 +218,8 @@ struct sock *tcp_get_cookie_sock(struct sock *sk, str=
uct sk_buff *skb,
>
>                 bh_unlock_sock(child);
>                 sock_put(child);
> +               reqsk_put(req);
> +               return NULL;
>         }
>         __reqsk_free(req);
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 99baf14afdfd..3583867487d7 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -7777,7 +7777,9 @@ int tcp_conn_request(struct request_sock_ops *rsk_o=
ps,
>                 if (!inet_csk_reqsk_queue_add(sk, req, fastopen_sk)) {
>                         bh_unlock_sock(fastopen_sk);
>                         sock_put(fastopen_sk);
> -                       goto drop_and_free;
> +                       /* tcp_disconnect() already dropped one reqsk ref=
. */
> +                       reqsk_put(req);
> +                       goto drop;
>                 }
>                 READ_ONCE(sk->sk_data_ready)(sk);
>                 bh_unlock_sock(fastopen_sk);
> diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
> index b111b51d69fc..aa5fa1dd062f 100644
> --- a/net/ipv6/inet6_hashtables.c
> +++ b/net/ipv6/inet6_hashtables.c
> @@ -108,7 +108,9 @@ struct sock *__inet6_lookup_established(const struct =
net *net,
>                 if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
>                         goto out;
>
> -               if (unlikely(!inet6_match(net, sk, saddr, daddr, ports, d=
if, sdif))) {
> +               if (unlikely(hlist_nulls_unhashed_lockless(&sk->sk_nulls_=
node) ||
> +                            !inet6_match(net, sk, saddr, daddr, ports, d=
if,
> +                                         sdif))) {
>                         sock_gen_put(sk);
>                         goto begin;
>                 }
> --
> 2.43.0
>
