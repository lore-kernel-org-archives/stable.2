Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793710587;
	b=JJ5Ob08lMo/zucvEejDUym/6vU8ovKcYIOc+xKFU0DLm9lGgKu6zoHLZjppePC9wiyNf
	 QquF00pMnMM1CTbWjhl3sGG9lGQMD1GtPqYZtr7qemLZ9GrPAlIzS9iMkHPguKBWDxLJI
	 WPfsuLPf5+qp+B/fMX4WeqXkWN3GEUQamJH+HGqyx8SZQRhQoj9Y2Bmzds5+b++aWStwA
	 rEDLbEiyU3VN6Gr6/dgVA0GHLmY00erTeHYihR4GZ3r7x8JUqpFoqb8nMd870ZA9n3Wgx
	 Yhe3xJ6wntENPdIvggvVfJaFyCqj3Nv93ySKco1NAyTq//7fp83czdQhRqH66GOjeww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793710587;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=PswOOpyV0BhQ1v11Jg/71XBVX0JA5DoZtlcqYAPpNGk=;
	b=GxXU4JqBEq9LRX261juNp2znUinFCwomQ2OuXpWdQl1bat6h+tv1Y8rd8FpJLI5LNT7d
	 KTi4s4UsKZNer3qUbhkITWL9x+pkfCN4prSiwsQsCenXGactdY+Yzpkr+pwQd7nvOuK+l
	 sgeIhfhfAiI+s1gKMIcAJrYtN/rME6lqBwhGkCQA1s3Psez3QvGZNPp9CthPm7eQepy1R
	 FbNbQffcUlv1y9NaDZueCR3Eh17fz6f4Un8n/iTagk1rUhQPE9fuk/vDvoub8GeGa2H08
	 S06w3ZvCCF7ql2ivIm0ji7pLSPQKYbeUwtGUvi73+pwQ+eyEAqc1BDll+Y1pQzmRbqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VCxF3RxC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18C9606A334
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 12:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VCxF3RxC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2CA01F0093A
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 12:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793710586;
	bh=PswOOpyV0BhQ1v11Jg/71XBVX0JA5DoZtlcqYAPpNGk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=VCxF3RxC6IiSvXjCENa5T/qPN2tytJofNgtcwVTMKw4mpKuEHm8eHgH9Y9dqaJ2Sb
	 XBo41WdgJR02I5T+eK9lthtdI7ATqNsXDX8vNSsGjoZOQPbzTIOVkka6lbpQ2V7E27
	 ohm+a6/tLNydy4DQwUVZErXlPzZWUZQBVsZ+ytV7KSUb4yWllBLISccfRI0Io+WWaV
	 Jelah77ZtVh1o2BRc/ivqFaatactusmlrIasmEesc+7g3Tdmi+CgWFh6yWArupsHo5
	 z8nVV3v+wZa5bDaOEK8CFPDnqs1buTqmVjTcubhzG00+2tb0DX34URfTvh2XQ3iRMJ
	 V9JPhYDKvkpQQ==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6aa9606ddadso3150382eaf.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 04:56:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwEW/itI3s5KNhyQYjH3sIQg6fzKz7761sIVd1YoeQYM/8qQar4aYAQcG+ouCMkWWmB+pQRy/o=@vger.kernel.org
X-Gm-Message-State: APuU4Z/hqM1GJsFhEk98kLtXfikHPDMTxr4TKsDvj74tVkFFdg8bLHQV
	b3GP0DpTHfghMlZLneAj0gdmyYL5/g0IGGclcVtOQHyUCy685wn9Iqr3otjoaV10p3fc+t6zRf8
	zwf/Bsc5z/pKc/qQ2t0kN2YTR17FnDJg=
X-Received: by 2002:a05:6808:c126:b0:54c:7dc0:649a with SMTP id
 5614622812f47-5640de2e6fcmr8293306b6e.32.1793710585723; Tue, 03 Nov 2026
 04:56:25 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <34f32e63b803f9f7faf0b0a5754219e48a986136.1793616950.git.x-professor@outlook.com>
 <3dd45a687afdd0213ee82685c52777e5b0855e20.1793704772.git.x-professor@outlook.com>
In-Reply-To: <3dd45a687afdd0213ee82685c52777e5b0855e20.1793704772.git.x-professor@outlook.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 3 Nov 2026 13:56:14 +0100
X-Gmail-Original-Message-ID: <CAL4WiioMFz5hLvHdQPLkm1wwPCsBCOTiityzdY4D3V3VLfZ4Jw@mail.gmail.com>
X-Gm-Features: AclHuK-ToAnaoXM-VCmz0_wDzMsVQpjY9hU-ynLspcXZkq_MRAtxGOufgttpNTI
Message-ID: <CAL4WiioMFz5hLvHdQPLkm1wwPCsBCOTiityzdY4D3V3VLfZ4Jw@mail.gmail.com>
Subject: Re: [PATCH net v2] tcp: free saved_syn after an RCU grace period
To: Yingjie Wang <x-professor@outlook.com>
Cc: Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 3 nov. 2026 =C3=A0 12:19, Yingjie Wang <x-professor@outlook.com> a =
=C3=A9crit :
>
> tcp_reqsk_record_syn() allocates saved_syn separately from its request
> socket. bpf_sock_ops_get_syn() can load that pointer while processing a
> retransmitted SYN under RCU.
>
> There are two ownership transfers which can let another CPU reclaim the
> allocation while such a reader is still using it.
>
> First, tcp_move_syn() transfers req->saved_syn to a newly created child
> socket. The child can be closed and tcp_saved_syn_free() can reclaim the
> allocation before a reader of the old request finishes.
>
> Second, inet_reqsk_clone() shallow-copies request_sock during request
> migration. The migrated clone becomes the owner after reqsk_migrate_reset=
()
> clears the old request's pointer, but a reader which already loaded the
> pointer from the old request can still be using it when the clone is
> released.
>
> Mark the request and full-socket saved_syn pointers as RCU protected. Use
> rcu_dereference() in the BPF readers, rcu_assign_pointer() when publishin=
g
> the saved SYN to the child socket, and RCU_INIT_POINTER() at initializati=
on
> and clearing sites. Embed an rcu_head in struct saved_syn and defer
> reclamation in both release paths. Clear a live full-socket pointer befor=
e
> scheduling reclamation, so a new RCU reader cannot acquire it after the
> grace period starts.
>
> This follows commit e3f33b0a1d89 ("ipv4: free inet_opt and ireq_opt
> after an RCU grace period"), which fixed the same ownership-transfer
> pattern for IPv4 options.
>
> The issue was confirmed with KASAN on v7.3-16007-g36aad21d50d1 using
> temporary kernel instrumentation to widen the reader and request-migratio=
n
> window. KASAN reported a slab-use-after-free read in
> bpf_sock_ops_get_syn(), with the allocation freed by __reqsk_free() from
> reqsk_timer_handler(). The same explicit migration test completed without
> a report with deferred reclamation. A patched kernel without the delay
> instrumentation also completed a successful migration and seven saved-SYN
> reads without a KASAN report.
>
> Fixes: 0813a841566f ("bpf: tcp: Allow bpf prog to write and parse TCP hea=
der option")
> Fixes: c905dee62232 ("tcp: Migrate TCP_NEW_SYN_RECV requests at retransmi=
tting SYN+ACKs.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yingjie Wang <x-professor@outlook.com>
> ---
>  include/linux/tcp.h             | 16 +++++++++++-----
>  include/net/request_sock.h      |  4 +++-
>  net/core/filter.c               | 16 +++++++++++-----
>  net/ipv4/inet_connection_sock.c |  6 +++---
>  net/ipv4/tcp.c                  | 14 +++++++++-----
>  net/ipv4/tcp_input.c            |  2 +-
>  6 files changed, 38 insertions(+), 20 deletions(-)
>
> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index d18f7bc1e5d0..5ba4d81e431a 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -536,7 +536,7 @@ struct tcp_sock {
>          * socket. Used to retransmit SYNACKs etc.
>          */
>         struct request_sock __rcu *fastopen_rsk;
> -       struct saved_syn *saved_syn;
> +       struct saved_syn __rcu *saved_syn;

Full sockets do not need RCU protection for tp->saved_syn : all the
accesses (do_tcp_getsockopt(), sol_tcp_sockopt(), bpf_sock_ops_get_syn()
on a full socket, tcp_saved_syn_free()) are done with the socket lock
held. Only the lifetime of the object matters, because a request socket
reader might still use it.

I would only add __rcu to req->saved_syn, and keep tp->saved_syn
a plain pointer. This would avoid the net/ipv4/tcp.c changes.


>  };
>
>  enum tsq_enum {
> @@ -618,14 +618,20 @@ static inline void fastopen_queue_tune(struct sock =
*sk, int backlog)
>  static inline void tcp_move_syn(struct tcp_sock *tp,
>                                 struct request_sock *req)
>  {
> -       tp->saved_syn =3D req->saved_syn;
> -       req->saved_syn =3D NULL;
> +       struct saved_syn *saved_syn;
> +
> +       saved_syn =3D rcu_dereference(req->saved_syn);
> +       rcu_assign_pointer(tp->saved_syn, saved_syn);

The content was already published via the request socket, and the
child is still bh-locked at this point : rcu_assign_pointer() is not
needed.

       RCU_INIT_PONTER(tp->saved_syn, unrcu_pointer(req->saved_syn));

> +       RCU_INIT_POINTER(req->saved_syn, NULL);
>  }
>
>  static inline void tcp_saved_syn_free(struct tcp_sock *tp)
>  {
> -       kfree(tp->saved_syn);
> -       tp->saved_syn =3D NULL;
> +       struct saved_syn *saved_syn;
> +
> +       saved_syn =3D rcu_dereference_protected(tp->saved_syn, 1);
> +       RCU_INIT_POINTER(tp->saved_syn, NULL);
> +       kfree_rcu(saved_syn, rcu);
>  }
>
>  static inline u32 tcp_saved_syn_len(const struct saved_syn *saved_syn)
> diff --git a/include/net/request_sock.h b/include/net/request_sock.h
> index 5a9c826a7092..ddc134f1d15d 100644
> --- a/include/net/request_sock.h
> +++ b/include/net/request_sock.h
> @@ -16,6 +16,7 @@
>  #include <linux/types.h>
>  #include <linux/bug.h>
>  #include <linux/refcount.h>
> +#include <linux/rcupdate.h>
>
>  #include <net/sock.h>
>  #include <net/rstreason.h>
> @@ -39,6 +40,7 @@ struct request_sock_ops {
>  };
>
>  struct saved_syn {
> +       struct rcu_head rcu;
>         u32 mac_hdrlen;
>         u32 network_hdrlen;
>         u32 tcp_hdrlen;
> @@ -68,7 +70,7 @@ struct request_sock {
>         struct timer_list               rsk_timer;
>         const struct request_sock_ops   *rsk_ops;
>         struct sock                     *sk;
> -       struct saved_syn                *saved_syn;
> +       struct saved_syn __rcu          *saved_syn;
>         u32                             secid;
>         u32                             peer_secid;
>         u32                             timeout;
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 09c60a58c82a..38a4b48e1fb0 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5714,12 +5714,18 @@ static int sol_tcp_sockopt(struct sock *sk, int o=
ptname,
>
>         if (getopt) {
>                 if (optname =3D=3D TCP_SAVED_SYN) {
> +                       struct saved_syn *saved_syn;
>                         struct tcp_sock *tp =3D tcp_sk(sk);
>
> -                       if (!tp->saved_syn ||
> -                           *optlen > tcp_saved_syn_len(tp->saved_syn))
> +                       rcu_read_lock();

This rcu_read_lock() seems redundant. I would use
rcu_dereference_protected(tp->saved_syn, lockdep_sock_is_held(sk))

> +                       saved_syn =3D rcu_dereference(tp->saved_syn);
> +                       if (!saved_syn ||
> +                           *optlen > tcp_saved_syn_len(saved_syn)) {
> +                               rcu_read_unlock();
>                                 return -EINVAL;
> -                       memcpy(optval, tp->saved_syn->data, *optlen);
> +                       }
> +                       memcpy(optval, saved_syn->data, *optlen);
> +                       rcu_read_unlock();
>                         /* It cannot free tp->saved_syn here because it
>                          * does not know if the user space still needs it=
.
>                          */
> @@ -6125,9 +6131,9 @@ static int bpf_sock_ops_get_syn(struct bpf_sock_ops=
_kern *bpf_sock,
>                          * not be available.  It has to resort to
>                          * saved_syn (if it is saved).
>                          */
> -                       saved_syn =3D inet_reqsk(sk)->saved_syn;
> +                       saved_syn =3D rcu_dereference(inet_reqsk(sk)->sav=
ed_syn);
>                 else
> -                       saved_syn =3D tcp_sk(sk)->saved_syn;
> +                       saved_syn =3D rcu_dereference(tcp_sk(sk)->saved_s=
yn);
>
>                 if (!saved_syn)
>                         return -ENOENT;
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_s=
ock.c
> index 93b306d91b6d..1d54057a86ef 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -869,7 +869,7 @@ reqsk_alloc_noprof(const struct request_sock_ops *ops=
, struct sock *sk_listener,
>         req_to_sk(req)->sk_prot =3D sk_listener->sk_prot;
>         sk_node_init(&req_to_sk(req)->sk_node);
>         sk_tx_queue_clear(req_to_sk(req));
> -       req->saved_syn =3D NULL;
> +       RCU_INIT_POINTER(req->saved_syn, NULL);
>         req->syncookie =3D 0;
>         req->num_timeout =3D 0;
>         req->num_retrans =3D 0;
> @@ -908,7 +908,7 @@ void __reqsk_free(struct request_sock *req)
>         req->rsk_ops->destructor(req);
>         if (req->rsk_listener)
>                 sock_put(req->rsk_listener);
> -       kfree(req->saved_syn);
> +       kfree_rcu(rcu_dereference_protected(req->saved_syn, 1), rcu);

Or kfree_rcu(unrcu_pointer(req->saved_syn), rcu)

>         kmem_cache_free(req->rsk_ops->slab, req);
>  }
>
> @@ -979,7 +979,7 @@ static void reqsk_queue_migrated(struct request_sock_=
queue *queue,
>
>  static void reqsk_migrate_reset(struct request_sock *req)
>  {
> -       req->saved_syn =3D NULL;
> +       RCU_INIT_POINTER(req->saved_syn, NULL);
>  #if IS_ENABLED(CONFIG_IPV6)
>         inet_rsk(req)->ipv6_opt =3D NULL;
>         inet_rsk(req)->pktopts =3D NULL;
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index b9de7c302ba8..7e8f7c9d5f53 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -4722,13 +4722,17 @@ int do_tcp_getsockopt(struct sock *sk, int level,
>                 val =3D tp->save_syn;
>                 break;
>         case TCP_SAVED_SYN: {
> +               struct saved_syn *saved_syn;
> +
>                 if (copy_from_sockptr(&len, optlen, sizeof(int)))
>                         return -EFAULT;
>
>                 sockopt_lock_sock(sk);
> -               if (tp->saved_syn) {
> -                       if (len < tcp_saved_syn_len(tp->saved_syn)) {
> -                               len =3D tcp_saved_syn_len(tp->saved_syn);
> +               saved_syn =3D rcu_dereference_protected(tp->saved_syn,
> +                                                     lockdep_sock_is_hel=
d(sk));
> +               if (saved_syn) {
> +                       if (len < tcp_saved_syn_len(saved_syn)) {
> +                               len =3D tcp_saved_syn_len(saved_syn);
>                                 if (copy_to_sockptr(optlen, &len, sizeof(=
int))) {
>                                         sockopt_release_sock(sk);
>                                         return -EFAULT;
> @@ -4736,12 +4740,12 @@ int do_tcp_getsockopt(struct sock *sk, int level,
>                                 sockopt_release_sock(sk);
>                                 return -EINVAL;
>                         }
> -                       len =3D tcp_saved_syn_len(tp->saved_syn);
> +                       len =3D tcp_saved_syn_len(saved_syn);
>                         if (copy_to_sockptr(optlen, &len, sizeof(int))) {
>                                 sockopt_release_sock(sk);
>                                 return -EFAULT;
>                         }
> -                       if (copy_to_sockptr(optval, tp->saved_syn->data, =
len)) {
> +                       if (copy_to_sockptr(optval, saved_syn->data, len)=
) {
>                                 sockopt_release_sock(sk);
>                                 return -EFAULT;
>                         }
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index ebd2c12e42d5..5151bb16a8b9 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -7638,7 +7638,7 @@ static void tcp_reqsk_record_syn(const struct sock =
*sk,
>                         saved_syn->network_hdrlen =3D skb_network_header_=
len(skb);
>                         saved_syn->tcp_hdrlen =3D tcp_hdrlen(skb);
>                         memcpy(saved_syn->data, base, len);
> -                       req->saved_syn =3D saved_syn;
> +                       RCU_INIT_POINTER(req->saved_syn, saved_syn);
>                 }
>         }
>  }
>

Also, for the next version:

- Please start a new thread, do not reply to the previous version.
- Add a changelog after the "---" line, with a link to the previous
  version on lore.
- Please answer the question asked by netdev-bot : how was this issue
  discovered ? The changelog says how it was confirmed, not how it was
  found.

Thanks.

pw-bot: cr
