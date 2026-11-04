Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793796048;
	b=PoNElHJNHdKSTxHXJV8esbZRJccI+2wdGTCKgQ6k8TpaYlme+sk1VCkQ+gGsgD4hhVoe
	 11itwJKIbkTOPB8HhYG/mcCsMSJuf4PngU4TVjh1fv1HI4leYWqIlWadDGybEjejMHcbY
	 q3SsvYkSJCDQ6a5q4dbnHFWxKvPyDRy0ov1jl8PyewmCpGnOznQEEhn8zMzpxaQpr0p+f
	 dcBg43Rh4Hzv7rmEW2NsQ2+HlAKUJ11cj4xeG0yTR3T4n/RL/IlWPATWAKzgrkVSQsW50
	 wYbeXYdAIPpyVhJX3qqwV7WZIFtY0L/BIXZhcsRP5Bbj4fA915XXuk/6QP9JdDspsvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793796048;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=alfWwL6/FuueZbwen1V8hepkvtjYNfPuDnxUgf69IeQ=;
	b=1NMSZKmrnqLRfHpTFOJ+ZTR7+Y6JS1notPELewSn41E6LHKmWaE1K4TGz65GBr6KIUzA
	 f85GZMaZpda0Vrh/egwlr00ymQ3v9gnvzfkJE8K9lvwTvOYX02bqzOTZDEdeBeZxw77mf
	 dAkUhcAjAluMyfE+O5tjD2Oi6jvutH4+eBwGfFZ5HKtmSADbiopMZKHdlKCLEIrp8XW0g
	 5KEkEt6eN4phyVWp5Ho3LsUQWJBi3Hxl7G6Z8HCZ3M4TCFReH9Kf5heaunxH7kLfn0Kdb
	 Bko7tEdtsGa+U7Ye4n+PPLriGhvJsoGPRg+PPy3cHQN2eTcqPEOz5Y470XFSxlgiRag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gySUN7DJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CCA606A33F
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 12:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gySUN7DJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C551F00A28
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 12:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793796048;
	bh=alfWwL6/FuueZbwen1V8hepkvtjYNfPuDnxUgf69IeQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=gySUN7DJaGHHwlysYEGpIJF47dle3J4s3We53JvzRKIDu50gj5a2wkGJPwbEx3KbN
	 IolmNtz1cKv7hu/lS9yd/VIv00HU/99J6FN9TsvQYw+RaR/BtNAWRh7Bk3A/jITpFQ
	 LAhrZAU4d/9wTkkWUQlC+kp0c+J0rfZAE/BbDjZyXfZtUe8qeeCnX4TdGiq47gbBn9
	 kREQQfm2F5xX7pCSvnulapabG89v1ZJqZxwn6RlDM/FE+D42KVOaN8mQtxZm/gFRy/
	 jupooXjF333Ngy3s9Iful/ZC4eLNa/SpQae1jkG5FEhWTY2xARIL7ztxwwWP8Ewoll
	 /ffreyaOzjyhA==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-48e9476e26aso257577fac.3
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 04:40:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzdV3xwIToaG902++N3TdeWHxfgc1OWi5ZsLfM9xC/5b7QgBhhn9HDgLWuK6YN+PgLWi7vUcpI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+KzMN9H9gWtTnpQv2H/cPe9bt1ROoRoIyin3XpPXZYsTuDXHJW
	7a5+tfc9RxlMB7z1fMB3vvCF6GbRzTKx1o6mU4vnFQpSzjb39fqwwDa6+PjQzUZMASJBcpSUg9Z
	xxr0uGP7UdXF4DEhKJxh/w6ZUi0WVJk0=
X-Received: by 2002:a05:6870:d609:b0:49e:d4c:e6f0 with SMTP id
 586e51a60fabf-4a90772c1b0mr10331737fac.46.1793796047403; Wed, 04 Nov 2026
 04:40:47 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <38fa9f2cc476502e9b1c1fef09ebba1df5dd5901.1793795528.git.x-professor@outlook.com>
In-Reply-To: <38fa9f2cc476502e9b1c1fef09ebba1df5dd5901.1793795528.git.x-professor@outlook.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Wed, 4 Nov 2026 13:40:35 +0100
X-Gmail-Original-Message-ID: <CAL4Wiiqen5n7i2Wa_YxJLYOr32aj4dgknPnjbVpi-xPOcMAd7Q@mail.gmail.com>
X-Gm-Features: AclHuK8GZXD43O-lNJEKnJiywNAx6AQFktc6lK1CpovXsWvfdozbKRYapn5LGpk
Message-ID: <CAL4Wiiqen5n7i2Wa_YxJLYOr32aj4dgknPnjbVpi-xPOcMAd7Q@mail.gmail.com>
Subject: Re: [PATCH net v3] tcp: free saved_syn after an RCU grace period
To: Yingjie Wang <x-professor@outlook.com>
Cc: Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mer. 4 nov. 2026 =C3=A0 13:32, Yingjie Wang <x-professor@outlook.com> a =
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
> migration. After reqsk_migrate_reset() clears the old request pointer, th=
e
> migrated clone owns it. However, a reader which already loaded the pointe=
r
> from the old request can still be using it when the clone is released.
>
> I found this through LLM-assisted concurrency fuzzing.
>
> Mark the request-socket saved_syn pointer as RCU protected and use RCU
> accessors for its reads and updates. Keep the full-socket pointer plain
> because all of its accesses hold the socket lock. Embed an rcu_head in
> struct saved_syn and use kfree_rcu() in both teardown paths. This lets a
> request-side reader which loaded the object before an ownership transfer
> finish.
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
> Changes in v3:
> - Keep tcp_sock::saved_syn under the socket lock and apply RCU protection
>   only to request_sock::saved_syn, as suggested by Eric Dumazet.
> - Use unrcu_pointer() when transferring or reclaiming the request-side
>   pointer.
> - Describe the discovery as LLM-assisted concurrency fuzzing.
> - Rebase onto net/main commit 241dec6f9ab7.
>
> v2: https://lore.kernel.org/r/3dd45a687afdd0213ee82685c52777e5b0855e20.17=
93704772.git.x-professor@outlook.com
> - Add RCU annotations and accessors following Kuniyuki Iwashima's review.
>
> v1: https://lore.kernel.org/r/34f32e63b803f9f7faf0b0a5754219e48a986136.17=
93616950.git.x-professor@outlook.com
>
>  include/linux/tcp.h             | 6 +++---
>  include/net/request_sock.h      | 4 +++-
>  net/core/filter.c               | 2 +-
>  net/ipv4/inet_connection_sock.c | 6 +++---
>  net/ipv4/tcp_input.c            | 2 +-
>  5 files changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index d18f7bc1e5d0..3ae57ae65ec4 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -618,13 +618,13 @@ static inline void fastopen_queue_tune(struct sock =
*sk, int backlog)
>  static inline void tcp_move_syn(struct tcp_sock *tp,
>                                 struct request_sock *req)
>  {
> -       tp->saved_syn =3D req->saved_syn;
> -       req->saved_syn =3D NULL;
> +       tp->saved_syn =3D unrcu_pointer(req->saved_syn);
> +       RCU_INIT_POINTER(req->saved_syn, NULL);
>  }
>
>  static inline void tcp_saved_syn_free(struct tcp_sock *tp)
>  {
> -       kfree(tp->saved_syn);
> +       kfree_rcu(tp->saved_syn, rcu);
>         tp->saved_syn =3D NULL;
>  }
>
> diff --git a/include/net/request_sock.h b/include/net/request_sock.h
> index 5a9c826a7092..ddc134f1d15d 100644
> --- a/include/net/request_sock.h
> +++ b/include/net/request_sock.h
> @@ -16,6 +16,7 @@
>  #include <linux/types.h>
>  #include <linux/bug.h>
>  #include <linux/refcount.h>
> +#include <linux/rcupdate.h>

nit: this include is not needed.

Not worth a new version though.

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
