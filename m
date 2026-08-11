Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D6B404BC8
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 06:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786430285; cv=pass; b=PZbgGbpXqRuhCe+NjQ6GceVVf6HjmA7QzTvFKTsqEA+FHMTq6ZhA60HQMF1tab3cNz81hQsML2YisJ9/KqbNv/p5wQJDZtBBvDAw5dw1unAO6fZH0CzdWgQL9GHfP7EHKqxbqpNd4PVA/xWds1oYcaxohY398VY39o7hkipyJjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786430285; c=relaxed/simple;
	bh=Zh0ReCO8tn7/M+oIdfPoqQstXfdGnrLygh0IoANt7LM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qy+TV6dBnXNViUHixGJ7TH3akT1RYJ4L05mbuyI2zOOyvVLGVKaP3xpohKck800/5T94RWV7dH1PkkgVBdxJGSGVhu4cGQv7/+pvVd3ruprlCM7+nQ3US3hZe+Wb6ZUWPJ45uTtClghwPHz3tzdGFHJlGqNGT5XsjgAa9XerT2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VsT+m5VT; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VsT+m5VT"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-381c51fde6bso3254846a91.2
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 23:37:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786430275; cv=none;
        d=google.com; s=arc-20260327;
        b=a+qV1itYDlzoCnjSyJfDtVPB/EvhsmEADLJSFyQfnA+W51XhoNA/2qLqS7UfrpNZCH
         5Yz4DcgcCyX2/msNPIFj7EN0EEXEbn6ZeiFQbKjxF3HK0/GX+myoUEcuEQWTJkhrZTaF
         B6pK4pyCHM1ZO7MAbmQIzaGtJ9KIb1Orr3RwLOIJBb4GNk2SEoiE7mZHC9wYkdz6t/zK
         /Lv9S80ddfDhouuIehxB0TNCKmWIuZgb6+TfAeerbRn2WlwYMyJ4AgHj80fAIGU/Gw8q
         8rdKKl4Yha4aMvG/P2NpnrD8N0miRyme92K7XohDMCrUrKha6+yYq8NBd6IY9lAsX8G/
         zFrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZB/s4/aRCVLVr2j5qEoUY0hqCjPRYQeiCHNsJ2HNwOA=;
        fh=vkFns2Idf+SIucc0N4mQC+GdILT6SEQSN+MxvLNH+NE=;
        b=gpAXM2yW8MeaL8RXqaVngC8a6vaadSSQ9X7nOYYSAoZtHlwiTH5+oVBFsW2V58UwBI
         JFjdo4bxv8gq+hF2JvgyA2mz1ijvIEvFXSmSwhS+4RdN2WnY6lnuIg3zWthD7BGYWyx2
         J9DY93I5WFyrohH1BivzRNOj7wI18eYh/npQE792SSIDmXATY5GlrZyNdOoD5m1oDrDD
         YaIIXfVjnpvz9TUkiv+tzRVhRAz8Mhrbuv+dIhx/zM352ESDnKW1pj704ILVo90vrBA4
         pBOTeFyNZaXOzZ6dYzRtsh7FJkOLOkGsEL1bzo/p2O0ql7yI9h6Iojgk3Nm9eRitlAEl
         DM1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786430275; x=1787035075; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZB/s4/aRCVLVr2j5qEoUY0hqCjPRYQeiCHNsJ2HNwOA=;
        b=VsT+m5VTYI8ABbCtVNaIbNAcfwTUL5D3/puNGfoqkX1BNxT/KDf3kJh6bG47oO0PaV
         S/CJgAFsHzAJw7hYg5rf0AzFvnYRg1G38c2wWzWUobklqc4w/MxazGlYnpklrYP4MIob
         3Xjdu64i+vOOLLosjGapBkScjaQT/B0pMb02ofCyRZAVhTbZsXGrHjEv0/lNkHNrOo7k
         UdxwgF8ajvy342AJMqtqpFxoNTj/EMwzIj7Axbx1NJXZ6FajWEfX/Hb7vataHyDxPbSL
         aqpQqTuzhlMtXwM3N3Pl0iCb6BoDhP9IJFeE5f0oNcBkzErmdUz/iel5bJJJB/cSDjGw
         DALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786430275; x=1787035075;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZB/s4/aRCVLVr2j5qEoUY0hqCjPRYQeiCHNsJ2HNwOA=;
        b=PJIemKHBqhHNtH2X8BpbJoc8Bbm3nqDHODYcXRx5OodmSCxYvmzITU0cPRLIVvVVJh
         9OoysCS8OPGXx51ToXqO9lBpaNpYz6teu4xYuC1V0hhHo8ekvIEAcp/QjxCbXkI4NzdP
         BCqXmygQcF/LxbD8qydFW2av6Ik6gpimsy1/uDL8UhdzcBKaF/j+UZzXz2bUFd1SPM01
         uobXkGfFdBqWcMhaP/8WV7U0W0scKynq5SS4bMqxKqmKZxLGP+wCoeOazPg8/NwJ2V6n
         oVhVJ5rHrsVr7dM5F/9GA8raVs/VWWOTj+eNQ/dmDV51w4mMTJhAamjIgU48CEuwMQnB
         NueQ==
X-Forwarded-Encrypted: i=1; AHgh+RojoYWw403d8pEnFZKHq6muPYhxj7Vd1ViRR2+/BkEIfAJkDCdM5FKOeaY7TztCD30SwgcB8pQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOdGtJsMMkWcuZaBKT84HDAk1QFJk42iOcLmfNxYBVnd7WRJjf
	MQoqo3pKZzFDhG9kFowN4BphtO6lbS/Ls4zMzBsqAwc7XddggsXA67nRXfMRodlYnm5BAdOeFcA
	QCPQ+zLOl+uh3jhBEYNTRB/w3/sDZBQAMlPaKSs48
X-Gm-Gg: AR+sD10wg+9IpZ7FFrE8U8N+0MQlubmQ+CRVsbQc1qRJR/lBmaX9zLMVGKbROl39eg6
	3Lt187T2dtNE9PaiJOumIE20j0w5C0vBwTuec/0xNUXe2cUGB5CHxORa6BiiWD+2xBYK29qsAUW
	ciIwZlMoPOuqSkfJPFnLeuyYPSiARSAmLIk3FecaZNffDieNGbLNh171WmI/pqGnSMPtgGNd2EW
	qL9UDLZ6DLqI33e9BchRA9HDqXyKj0BshbxB2ZpQnOYfaMdmlw2iUP2SH6pkwOcc4KGstyqn1sw
	i5cFpkCapsbB93keF/SHS5ULv9YF3x1FEewuwVn6QgdYNGHnLGBZJqkZvrcXr4mYjxBefv9Exrw
	7jxcDH+BAc68m9Rq3ukUBZB72TNL6zkJzubaekHZJXXktSFX8K1XKjUv48zh/wmeErnjN4DG9bX
	TihT/sXmF3nWLcaaq6IIhee6CX
X-Received: by 2002:a17:90a:d2c6:b0:380:7688:fbe9 with SMTP id
 98e67ed59e1d1-392ec50d0eemr1203812a91.8.1786430274675; Mon, 10 Aug 2026
 23:37:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810205642.1611338-1-ast@fiberby.net>
In-Reply-To: <20260810205642.1611338-1-ast@fiberby.net>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 10 Aug 2026 23:37:41 -0700
X-Gm-Features: AUfX_myuORM4_TTay9la_BUP_d63ySucdaQn_4RJibiLt3uKswUtb14idbALtWQ
Message-ID: <CAAVpQUDGPtKhv9XfiKgKg7NOqHGzSb4vs7ApQ=rf-RzbaCDQWA@mail.gmail.com>
Subject: Re: [PATCH net v2] tcp: reset late connection after listening socket close
To: =?UTF-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kristian Nielsen <knielsen@knielsen-hq.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 1:57=E2=80=AFPM Asbj=C3=B8rn Sloth T=C3=B8nnesen <a=
st@fiberby.net> wrote:
>
> In commit c82199061009 ("task_work: remove fifo ordering guarantee")
> Eric removed the ordering guarantee, thereby changing it from a
> guaranteed FIFO to currently LIFO ordering, in an effort to reduce
> jitter.
>
> This significantly increases the probability for a race to occur
> between a TCP handshake and the closing of the listening socket.

I looked into the repro, and the description above is too specific
to your reproducer working on localhost.

In your repro, a server creates a listening socket, accept()s
some child connections to get multiple file descriptors, and
exit()s the process, which close()s file descriptors from listener
(smaller fd) to child fds.

The last fput() queues each fd to the delayed work, which is
currently executed in LIFO ordering.

The child fd sends RST to the client and later the listener is
TCP_CLOSE'd.

On the client side, it tries to detect the server's exit() by checking
RST on the established connections (child fds on listener), and then
creates a new connection, which creates a reqsk with the alive listener
but the last ACK will hit TCP_CLOSE'd listener.

I checked the last ACK generated by the repro fails at
__inet_inherit_port() OR inet_csk_reqsk_queue_add().

That's why reverting c82199061009 prevents reproduction because
it's too late to create a new connection when the client notices the
listener's exit() via RST of child connections; new connection's SYN
always gets RST with the revert.

So, I would drop the description above and simply explain it like

"When __inet_inherit_port() returns -ENOENT, the new connection
 is dropped silently."


>
> In that case the client sees the connection as ESTABLISHED, however in
> tcp_v{4,6}_syn_recv_sock() the call to __inet_inherit_port() returns
> -ENOENT, and the new connection is dropped silently by put_and_exit.
>
> A client may therefore hang indefinitely on a blocking read() if the
> used data communication protocol is initiated by the server, like SMTP
> and the reporter[1]'s MariaDB protocol both are.
>
> Had the new connection been processed before the listening socket was
> closed, it would have been in the accept queue,

or inet_csk_reqsk_queue_add() should have sent RST.

> and been notified when
> inet_csk_listen_stop() was run, and the client would have got a reset.
>
> The call to __inet_inherit_port() returns -ENOENT because
> inet_csk(sk)->icsk_bind_hash is NULL, after inet_put_port() has been
> called by tcp_set_state(sk, TCP_CLOSE).
>
> This patch adds a check on the return value of the __inet_inherit_port()
> call, and jumps to a new label, where it resets the new connection,
> before proceeding with the put_and_exit label.
>
> The blamed commit was identified by testing on ancient Debian stable

This commit should be more appropriate since __inet_inherit_port()
did not fail (except for OOM) before this commit:

Fixes: c2f34a65a61c ("tcp/dccp: fix potential NULL deref in
__inet_inherit_port()")


> releases to get a rough scope of where to look, then identifying in
> which release between v3.16 and v4.19 it broke, and finally bisecting
> v4.2..v4.3 on a fresh Debian then-stable (jessie) VM with tooling from
> that era, and confirmed by reverting it from v4.3, v5.10.y and net.
>
> Additionally the race can be reproduced back to v3.6, by backporting
> the blamed commit. Beyond v3.6 there are too many conflicts.
>
> Reproducer:
>   https://files.fiberby.net/ast/2026/kernel/socket_teardown_test.c
>
> Reported-by: Kristian Nielsen <knielsen@knielsen-hq.org>
> Link: https://lore.kernel.org/87sf0ldk41.fsf@urd.knielsen-hq.org # [1]
> Fixes: c82199061009 ("task_work: remove fifo ordering guarantee")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>
> ---
>
> While the blamed commit properly only made the race observable, then
> the commit that made the race possible is less realistic to track down,
> and I don't think is worth the time to continue to the search for it
> somewhere before v3.6.
>
> I'm not submitting a selftest at this time, as I have only found an
> efficient way to often detect the issue, not disprove it, and I would
> need more test data from different systems, before I can reliably
> disprove it with a low runtime budget, without getting false negatives.
>
> Changelog:
> v2:
>   - Use return from __inet_inherit_port() to trigger send_reply()
>   - Use req->rsk_ops->send_reset.
>   - Clarity commit message, and update to reflect the changes.
>   (Thanks Kuniyuki)
> v1: https://lore.kernel.org/20260807194513.1263310-1-ast@fiberby.net
>
>  net/ipv4/tcp_ipv4.c | 8 +++++++-
>  net/ipv6/tcp_ipv6.c | 8 +++++++-
>  2 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index b8887cdd66c5..e0fba4579a57 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -1690,6 +1690,7 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock=
 *sk, struct sk_buff *skb,
>         int l3index;
>  #endif
>         struct ip_options_rcu *inet_opt;
> +       int ret;
>
>         if (sk_acceptq_is_full(sk))
>                 goto exit_overflow;
> @@ -1756,7 +1757,10 @@ struct sock *tcp_v4_syn_recv_sock(const struct soc=
k *sk, struct sk_buff *skb,
>                 goto put_and_exit; /* OOM, release back memory */
>  #endif
>
> -       if (__inet_inherit_port(sk, newsk) < 0)
> +       ret =3D __inet_inherit_port(sk, newsk);
> +       if (ret =3D=3D -ENOENT)
> +               goto send_reset_and_exit;
> +       else if (ret < 0)
>                 goto put_and_exit;

nit: Please move the -ENOENT branch inside (ret < 0)

if (unlikely(ret < 0) {
        if (ret =3D=3D -ENOENT)
                goto send_reset_and_exit;
        goto put_and_exit;
}


>         *own_req =3D inet_ehash_nolisten(newsk, req_to_sk(req_unhash),
>                                        &found_dup_sk);
> @@ -1784,6 +1788,8 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock=
 *sk, struct sk_buff *skb,
>  exit:
>         tcp_listendrop(sk);
>         return NULL;
> +send_reset_and_exit:
> +       req->rsk_ops->send_reset(newsk, skb, SK_RST_REASON_TCP_STATE);

Sorry, I think this can be direct call, tcp_v4_send_reset().

Also please pass the listener instead of newsk, it's more
like a call in tcp_check_req().

Same remarks for IPv6.

Thanks

>  put_and_exit:
>         newinet->inet_opt =3D NULL;
>         inet_csk_prepare_forced_close(newsk);
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index 9e9155b1b3aa..021c93de2273 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -1400,6 +1400,7 @@ static struct sock *tcp_v6_syn_recv_sock(const stru=
ct sock *sk, struct sk_buff *
>         int l3index;
>  #endif
>         struct flowi6 fl6;
> +       int ret;
>
>         if (skb->protocol =3D=3D htons(ETH_P_IP))
>                 return tcp_v4_syn_recv_sock(sk, skb, req, dst,
> @@ -1512,7 +1513,10 @@ static struct sock *tcp_v6_syn_recv_sock(const str=
uct sock *sk, struct sk_buff *
>                 goto put_and_exit; /* OOM */
>  #endif
>
> -       if (__inet_inherit_port(sk, newsk) < 0)
> +       ret =3D __inet_inherit_port(sk, newsk);
> +       if (ret =3D=3D -ENOENT)
> +               goto send_reset_and_exit;
> +       else if (ret < 0)
>                 goto put_and_exit;
>         *own_req =3D inet_ehash_nolisten(newsk, req_to_sk(req_unhash),
>                                        &found_dup_sk);
> @@ -1547,6 +1551,8 @@ static struct sock *tcp_v6_syn_recv_sock(const stru=
ct sock *sk, struct sk_buff *
>  exit:
>         tcp_listendrop(sk);
>         return NULL;
> +send_reset_and_exit:
> +       req->rsk_ops->send_reset(newsk, skb, SK_RST_REASON_TCP_STATE);
>  put_and_exit:
>         inet_csk_prepare_forced_close(newsk);
>         tcp_done(newsk);
>
> base-commit: dd057113ac7ba5bdd2aed3d9405305911152f911
> --
> 2.55.0
>
