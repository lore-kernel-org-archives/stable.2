Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792773246;
	b=wXEGai6/jJJAb7HF7uTaqpfHe7OetPfPYW02TUlZM3bF4AmpC2TlUWAolpiTyHfTcqKJ
	 +w+dqduAGpoajjxuFDWSrCr2/9nMkVMBfzFXAGSV3nBjv91tS2uz9NaD7ylddyQhZZ2a8
	 nzGUfFAATspZOX4IYCCoQHZr0+MAps1WwzM+bh8h8X0GbRNugBKTTfjPeKVq5oDPbbC7a
	 aQahGPwEGk5bWOgDGNhB8APU/ueMxX39I0ZELYfvwz/+Ax26OckWZaYk2UcjsCuytrQQM
	 mQsef6JgISdHlGRSnAXgUljnmyej7l+UmYVA/Xgm6VHcJXE6g442gtn0dIV8VCD0TPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792773246;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Bnv/2l/k8MEQplql5Qor6TmFNI8cwuFcJwBFY8k4dLQ=;
	b=t9286mkeXQUIS+YX7S+BUcRflEHuZwKcXH6M2xU3SdKFhiCmXk0swYVTOahtesJdbegv
	 4gH6wmHfdCsNm9pd2ovPlm9dFnIz3myPn92faTnDg7IGsgdNGpo0nV0ZMmEz/Tk4Mtt1K
	 Je3yEsAPFMLc2clngoIH6Jy0TyftQCm3wMVI+6b/GU1wbWP2g1LbIWZU8qdbXSzv2OxQl
	 ujvVA8slhPh+tYkHBbFTN/yhduwOodXQaONkJZfP+cemSKVj2czVeyNFVL/yp2azb1TIY
	 qJ//iLSWIoBnZFZu0Ti7jio5bRHlOW3EXOQV447eOwe5/IaGwVWTXAUo8Tx2Z2dhMDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dLZzOEQK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638F9606A31B
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 16:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dLZzOEQK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF6191F031E5
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 16:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792773246;
	bh=Bnv/2l/k8MEQplql5Qor6TmFNI8cwuFcJwBFY8k4dLQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=dLZzOEQKJaWOtIy9+qkobtNm3lHDY4AhRWumVM3ZcQRWa4Je4jHM1otSuBF0w1qYu
	 BF/xPksTJs3vlxq+nUQ5S3yuLJRCeVvXZoAbZDKViLFJxlCET0MA3Gljq2uZMKocrP
	 HG5zs6MsujdQGIAK/AqNXk1L9ZQWSRajdTGeM8ZQUTVPCQ+NpJbDgPqxXUZQjK7ljy
	 5PQWuKjOn0iy8GsRMaFFb6fz+w52bov2d4fWeZtDl1UjbjWX+Sj7GdE7muqdJKyhu0
	 7m42OB24Js1mUwd1LLHeftws7ffOom4x1/eIJux2DP+ZFTZQcswdisvbVR+cWeBnDE
	 dHxnweDY9LbXw==
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-8256106635eso548867a34.0
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 09:34:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwrMnaGDkYjW3TlGK+i3Rw373Y9QfqvvRZBrq9IDy7PFg+mdZXjrCapgJzU0x0mBVWckMrVmkI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ/qFNNTL2+JzZSgS7JeSAbqX9fbysyDn1L8GShsyKWeFcpPaYm
	g+PwR7BkY92Vz3JkXprbxMPiR0Y0lmzBs+GpUgVjlm9Yhzjrid+DGP+6TVFUCJkRXkg0jpPht5O
	lWEmcAGPfUW0panhXbWjysmMM9u6E7Xw=
X-Received: by 2002:a05:6808:f07:b0:4d6:9232:b3bc with SMTP id
 5614622812f47-55be864aec7mr1855434b6e.51.1792773245233; Fri, 23 Oct 2026
 09:34:05 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023052542.3505250-1-imv4bel@gmail.com> <20261023052542.3505250-3-imv4bel@gmail.com>
In-Reply-To: <20261023052542.3505250-3-imv4bel@gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Fri, 23 Oct 2026 18:33:53 +0200
X-Gmail-Original-Message-ID: <CAL4WiipDcvmNMeeC1znRmtykFg1uwb5XOZVOoi9y0dVECXtHVw@mail.gmail.com>
X-Gm-Features: AclHuK8j0OJIInTADjUijSZdrh-TBvCvPPjm2eN4Lb9vOWvudAiLyfVYeTUust4
Message-ID: <CAL4WiipDcvmNMeeC1znRmtykFg1uwb5XOZVOoi9y0dVECXtHVw@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] inet: restore refcount ordering for
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
> When commit 3ab5aee7fe84 ("net: Convert TCP & DCCP hash tables to use
> RCU / hlist_nulls") was written, atomic_inc_not_zero() provided full
> memory ordering. Even after commit 41c6d650f653 ("net: convert
> sock.sk_refcnt from atomic_t to refcount_t"), default builds used
> atomic_add_unless() and retained that ordering.
>
> Commit fb041bb7c0a9 ("locking/refcount: Consolidate implementations
> of refcount_t") consolidated the refcount_t implementations in v5.5.
> On weakly ordered architectures, this removed the ordering required
> by validation after a successful reference acquisition.
>
> Use refcount_inc_not_zero_acquire() in the IPv4 and IPv6 established
> lookups. Use refcount_set_release() when setting initial refcounts in
> sk_clone(), SYN cookie, and request migration paths. In the TCP Fast
> Open path, move the refcount update after the required initialization
> and use release ordering.
>
> The TIME_WAIT path already has an smp_wmb() between refcount_set() and
> hash publication, so leave it unchanged.

This is not accurate. The smp_wmb() in inet_twsk_hashdance_schedule()
orders the tw_refcnt store against the ehash publication, not the tw
identity stores done in inet_twsk_alloc() against the tw_refcnt store.

The latter is what a lookup holding a stale pointer needs. Today we get it
more or less by accident from the bhash spin_unlock() followed by
spin_lock() of the ehash lock.

Please either reword this paragraph, or simply use
refcount_set_release(&tw->tw_refcnt, 3) there; it is free under the lock
and makes the pairing explicit.


>
> Fixes: fb041bb7c0a9 ("locking/refcount: Consolidate implementations of re=
fcount_t")

refcount_inc_not_zero_acquire() and refcount_set_release() were only
added in 7f8ceea0c580 ("refcount: provide ops for cases when object's
memory can be reused"), in v6.15.


> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> ---
>  net/core/sock.c                 | 3 +--
>  net/ipv4/inet_connection_sock.c | 6 +++---
>  net/ipv4/inet_hashtables.c      | 2 +-
>  net/ipv4/syncookies.c           | 2 +-
>  net/ipv4/tcp_fastopen.c         | 3 +--
>  net/ipv6/inet6_hashtables.c     | 2 +-
>  6 files changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 3c25d66ba31a..f3ef9601ab73 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2622,8 +2622,7 @@ struct sock *sk_clone(const struct sock *sk, const =
gfp_t priority,
>         /* Before updating sk_refcnt, we must commit prior changes to mem=
ory
>          * (Documentation/RCU/rculist_nulls.rst for details)
>          */
> -       smp_wmb();
> -       refcount_set(&newsk->sk_refcnt, 2);
> +       refcount_set_release(&newsk->sk_refcnt, 2);

This part is not a fix: the writer side only needs store->store ordering,
which smp_wmb() already provides.

I do not mind the conversion, but then reqsk_queue_hash_req() (which has
the same smp_wmb() + refcount_set() pattern) should be converted as well
for consistency. Otherwise please drop this hunk to keep the stable
backport minimal.


>
>         sk_set_socket(newsk, NULL);
>         sk_tx_queue_clear(newsk);
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_s=
ock.c
> index cff02f4c5ac8..2d8e54d3a31b 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -1056,8 +1056,8 @@ static void reqsk_timer_handler(struct timer_list *=
t)
>                  * hold another count to prevent use-after-free and
>                  * call reqsk_put() just before return.
>                  */
> -               refcount_set(&nreq->rsk_refcnt, 2 + 1);
>                 timer_setup(&nreq->rsk_timer, reqsk_timer_handler, TIMER_=
PINNED);
> +               refcount_set_release(&nreq->rsk_refcnt, 2 + 1);
>                 reqsk_queue_migrated(&inet_csk(nsk)->icsk_accept_queue, r=
eq);
>
>                 req =3D nreq;
> @@ -1441,7 +1441,7 @@ struct sock *inet_csk_complete_hashdance(struct soc=
k *sk, struct sock *child,
>                                 goto child_put;
>                         }
>
> -                       refcount_set(&nreq->rsk_refcnt, 1);
> +                       refcount_set_release(&nreq->rsk_refcnt, 1);
>                         if (inet_csk_reqsk_queue_add(sk, nreq, child)) {
>                                 __NET_INC_STATS(sock_net(sk), LINUX_MIB_T=
CPMIGRATEREQSUCCESS);
>                                 reqsk_migrate_reset(req);
> @@ -1494,7 +1494,7 @@ void inet_csk_listen_stop(struct sock *sk)
>                 if (nsk) {
>                         nreq =3D inet_reqsk_clone(req, nsk);
>                         if (nreq) {
> -                               refcount_set(&nreq->rsk_refcnt, 1);
> +                               refcount_set_release(&nreq->rsk_refcnt, 1=
);
>
>                                 rcu_read_lock();
>                                 if (inet_csk_reqsk_queue_add(nsk, nreq, c=
hild)) {
> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index 58d54965036a..7ffa9171d6de 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -550,7 +550,7 @@ struct sock *__inet_lookup_established(const struct n=
et *net,
>                 if (sk->sk_hash !=3D hash)
>                         continue;
>                 if (likely(inet_match(net, sk, acookie, ports, dif, sdif)=
)) {
> -                       if (unlikely(!refcount_inc_not_zero(&sk->sk_refcn=
t)))
> +                       if (unlikely(!refcount_inc_not_zero_acquire(&sk->=
sk_refcnt)))
>                                 goto out;
>                         if (unlikely(hlist_nulls_unhashed_lockless(&sk->s=
k_nulls_node) ||
>                                      !inet_match(net, sk, acookie, ports,=
 dif,
> diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> index 644030561537..4b2d2713653b 100644
> --- a/net/ipv4/syncookies.c
> +++ b/net/ipv4/syncookies.c
> @@ -205,7 +205,7 @@ struct sock *tcp_get_cookie_sock(struct sock *sk, str=
uct sk_buff *skb,
>         child =3D icsk->icsk_af_ops->syn_recv_sock(sk, skb, req, dst,
>                                                  NULL, &own_req, NULL);
>         if (child) {
> -               refcount_set(&req->rsk_refcnt, 1);
> +               refcount_set_release(&req->rsk_refcnt, 1);
>                 sock_rps_save_rxhash(child, skb);
>
>                 if (rsk_drop_req(req)) {
> diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
> index 471c78be5513..2506f415f410 100644
> --- a/net/ipv4/tcp_fastopen.c
> +++ b/net/ipv4/tcp_fastopen.c
> @@ -364,8 +364,6 @@ static struct sock *tcp_fastopen_create_child(struct =
sock *sk,
>         tcp_reset_xmit_timer(child, ICSK_TIME_RETRANS,
>                              req->timeout, false);
>
> -       refcount_set(&req->rsk_refcnt, 2);
> -
>         sk_mark_napi_id_set(child, skb);
>
>         /* Now finish processing the fastopen child socket. */
> @@ -378,6 +376,7 @@ static struct sock *tcp_fastopen_create_child(struct =
sock *sk,
>         tcp_rsk(req)->rcv_nxt =3D tp->rcv_nxt;
>         tp->rcv_wup =3D tp->rcv_nxt;
>         tp->rcv_mwnd_seq =3D tp->rcv_wup + tp->rcv_wnd;
> +       refcount_set_release(&req->rsk_refcnt, 2);
>         /* tcp_conn_request() is sending the SYNACK,

Moving this is harmless, but not needed. The lookup never looks at
rcv_nxt, and this req is never hashed, so after patch 1/2 a stale lookup
will reject it anyway. A plain conversion in place would be enough.

Let's keep code churn minimal, to lower risk of merge conflicts.

>          * and queues the child into listener accept queue.
>          */
> diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
> index aa5fa1dd062f..1eea584d80df 100644
> --- a/net/ipv6/inet6_hashtables.c
> +++ b/net/ipv6/inet6_hashtables.c
> @@ -105,7 +105,7 @@ struct sock *__inet6_lookup_established(const struct =
net *net,
>                         continue;
>                 if (!inet6_match(net, sk, saddr, daddr, ports, dif, sdif)=
)
>                         continue;
> -               if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
> +               if (unlikely(!refcount_inc_not_zero_acquire(&sk->sk_refcn=
t)))
>                         goto out;
>
>                 if (unlikely(hlist_nulls_unhashed_lockless(&sk->sk_nulls_=
node) ||
> --
> 2.43.0
>
