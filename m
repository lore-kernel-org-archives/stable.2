Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E113D3C3459
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 21:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786136743; cv=pass; b=MPGKO/uKxRKQy8hghyforP4hiCJ79ftbcO0O38IDdrdBGrajwp04jD0O/7I593OR13CmuOTe5R9RpWPyguqpsa2mILJWo7iDYT0W3n6TzExSudMZBipDwfZJomKs3c5yAKq+ICmNHmERksxiEp9vjbAqOi1x00BH0Zytp72CwWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786136743; c=relaxed/simple;
	bh=kytDPo8HnX5iyg+/NrxJ2zSt0k/50deKUGEYvcWP0nc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dCU00n/sDEpoDcL12njClQASU8ASSksEzoblEXJuQB7mWNr4Iw8iP27sAqnQQF1cwsRyPWwPDU/vTkAlSfuJ+k4LmUoX5pStxGovlRA86kT3NUgS2NaSungqp3jYTs6rVXLeTVqM3RbMW654p95sur9JGgLcx0G+Yty69SYFtHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JOOqj80a; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JOOqj80a"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-383cb94f742so3797979a91.3
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 14:05:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786136741; cv=none;
        d=google.com; s=arc-20260327;
        b=jN0xxOBNA9bSMIPNsZAGslHNioGYW0aeEpGyLX/C5wVxksei0N8Ba23MOpHX7gxQ7c
         6RtTUYkCACuD1+zHKAK6CEt1FzNyELCMCZYVzcJJMn1oDdaFpQ+fgwwZobjUwNEI721z
         OoUOhICF7aTLD6/UWnKp8BfnGkXZTGOsbqCI7Dqg/DLY0AvOwK7o62VPxjMZVwEStJhP
         ib46xriir8UK0Uv1P0YcaZWDB4aTiwZzRIHbid81ihnAtB1JNbdah6vmEWfLYicT6Epr
         X7aR/ZD5ffGwPcSxfVlr7dL/EomyKD0dj6yFs3tnTsjyFRs5tm5AGuZVFCUHLFNEGF3J
         3fJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ggp29CQNblSswdt0DUUbGA8xSyK4NsLp/d1DHWuTV/U=;
        fh=zpp+UjG4Q3TtvuBtu8pWvsSaamhWLh7bYKYFm+AdmZ0=;
        b=AXvqW3YsWDv3xa7bEJyFkQiwL2NEwqxG8k5Z1Z9PC4EowzOn8pYdcCXObTqTRdI8ZR
         NKNoHzISxjM2q3uIEquy/5Vk+NLoT3X/JZ9v+6gcPOcd4ChVnaB7ZM/hvJq662Kd3We1
         E6eAH1yxBeakiRNnBzLbBtbHvSNcfCrCGxrpPqjzMObnuNHJ+YiAuJ1hwMte31WQQZid
         392XrkNtMpVo+WRiCGlA/T0Shl54Zw2vjaiuXN4yD3yUM9poerCH5GFkRVPy9YOxeIEF
         qmWH0fSFlGTa5H2655S+PoixM3z6UErt+j2CqaTO8BcUNuF0L75OlRPcGGvNLUXwci+r
         nXXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786136741; x=1786741541; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ggp29CQNblSswdt0DUUbGA8xSyK4NsLp/d1DHWuTV/U=;
        b=JOOqj80a32tDzSnhHN7fIHd2DzKKBEr6wtiLSux9LxD8Qlpr4yOTClGLL2sS4UaNh0
         OGe3Qs3bGx+iQWwEgQDKDWjCkm4OIb9wfotQxOtDCmGXhXob1KuaV5lAn4ELbK5jgzgo
         AEg16T8yZifuJbYNPWf/MqzD7/xRfnkmCcwuXKKYWX0g8kYdipy9Ftc+46f81jvNaLgn
         h75E6aBYz1DcpqtGNOPO5rzHMo3Sv9Kgj0oldsVLuA9+6w3+UBLhA6/9CtPZjmGwCu/Q
         TZhYrASFuQW8bi6KJFXup/MnnEJDmLk8A+8W2/asbk1YH97jhGRNyd3JVY4FVXPxB0nN
         e0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786136741; x=1786741541;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ggp29CQNblSswdt0DUUbGA8xSyK4NsLp/d1DHWuTV/U=;
        b=mIPx+xV1zJ0b0mAcJD3efFcQrNddcDFsd5oYekc3tyT3is7uzBpDBqHSGqZa8WHfe+
         b5HFhkKf188ZlHnfJ+KHoG2T9lk2CCjQMejeePAlpVgUQvqshSCF4/pjig0vIM3XudMm
         0jWuWauJBuXOEN3dkMBRWvjcSeIb4KIvUlqjFcs+mGV5YhSgGxbccmpNqiXtXjiD1dZ2
         3UikpU1gv6KPKHc9uBo4QwZAKQsIAj8vbPGWRzL+FJGcy//sWbbiIWeGZT/hcU09Fp09
         VlqAJsN+vulZplaK1i5XDljVRj8n7dTZDhnLlD9XDWGDrtoRr5qHusjYdwZgJvcadWeD
         tZEw==
X-Forwarded-Encrypted: i=1; AHgh+RrO22hSqn0kw8vJdS7e3UZCiPDwrhcwcuUdbvkzn9MX7+FAVbxjoH7e5ewgaBAXf/6Yy8VFX4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZPIqOzbDhWuMxgOsDfCNp1Ch7RCrdAphgBukR4Kbb/AZ2R/hQ
	nVQCyPqbi6brNeR9SsPhvxOm94/6/fv7sZtRIapOowItus/D+WdQmMZo5jzmaLH6AQs7rq8n2/F
	OlxXiPG0CAAFZuivmEZfUI5eC7yqSl6EA049Mwi8L
X-Gm-Gg: AR+sD11LNYwD+ISWEySZl6xPQ6n7pe08CEhQ/MQZIz+d8NLB7UAJizx3FFCaMw/h8NY
	sAhglMRarJslVocEhcbxTVmqdiJhZAti3Gu6TQCcSuSzybzk4fvuSYTPaLa5Au7Te+Fjm/AWm3N
	uO/8o0eMr5uEFa7AcIB86atj7ynZEvJjENBSFJfxtUPBbn17vw4OLOK8G3K01ihAbOdgolK/kF1
	EHM/mHkYCJtpbJOLaiI9IlW1wRly1kC77nD1e76wrJUQeO3F4hI2FX/9I4HEQNJRTTAZKI8Zvxu
	CAtW8Zq9njCijKXLO0mq+rRVa0aisqkYi4qCAJsD0y4M2ds0zZdSPp7lDkZdXY2LhnhW0DbNghJ
	q3F2Szr9uTsRaKss6DE5yU+3ya/3M0g5PJExZoyX8rRfInHP+gXM9nq8q+zScLbqO/8c31dAf4z
	Wi2egJn3nLlwoyNnx1ROMzVrjm
X-Received: by 2002:a17:90a:ec8c:b0:38d:c74d:29c5 with SMTP id
 98e67ed59e1d1-3903c5c0c92mr27535169a91.19.1786136740640; Fri, 07 Aug 2026
 14:05:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807194513.1263310-1-ast@fiberby.net>
In-Reply-To: <20260807194513.1263310-1-ast@fiberby.net>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 7 Aug 2026 14:05:29 -0700
X-Gm-Features: AUfX_mzQFi-uXERPQ9kt_5_Ty_nEDRctoxhVpqJ1GjuGcBC5FQwLLvt3Ft4_Wys
Message-ID: <CAAVpQUD9RTxs742Ty-UQXJJwTbN2wrnFGQDffKN0eZL4udq3Ng@mail.gmail.com>
Subject: Re: [PATCH net] tcp: reset late connection after listening socket close
To: =?UTF-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kristian Nielsen <knielsen@knielsen-hq.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 12:47=E2=80=AFPM Asbj=C3=B8rn Sloth T=C3=B8nnesen <a=
st@fiberby.net> wrote:
>
> In commit c82199061009 ("task_work: remove fifo ordering guarantee")
> Eric removed the ordering guarantee, thereby changing it from a
> guaranteed FIFO to currently LIFO ordering, in an effort to reduce
> jitter.

Could you elaborate a bit more on how c82199061009 introduced the issue?

I didn't quite see the connection between the first and second paragraphs.

The listener's state could change at any time on SMP.

>
> This allows for a TCP handshake to complete, after the listening socket
> has been closed, and after inet_csk_listen_stop() has been run.
>
> In that case the client sees the connection as ESTABLISHED, however in
> tcp_v{4,6}_syn_recv_sock() the call to __inet_inherit_port() returns
> -ENOENT, and the new connection is dropped silently by put_and_exit.

Note that if __inet_inherit_port() passes, inet_csk_reqsk_queue_add()
calls inet_child_forget().


>
> A client may therefore hang indefinitely on a blocking read() if the
> used data communication protocol is initiated by the server, like SMTP
> and the reporter[1]'s MariaDB protocol both are.
>
> Had the new connection been processed before the listening socket was
> closed, it would have been in the accept queue, and been notified when
> inet_csk_listen_stop() was run, and the client would have got a reset.
>
> This patch adds a check on the state of the listening socket, and
> resets the new connection, before discarding it with put_and_exit.
> The check is placed just before it would fail in __inet_inherit_port(),
> and just after TCP MD5 and AO options have been copied to newsk.
>
> The blamed commit was identified by testing on ancient Debian stable
> releases to get a rough scope of where to look, then identifying in
> which release between v3.16 and v4.19 it broke, and finally bisecting
> v4.2..v4.3 on a fresh Debian then-stable (jessie) VM with tooling from
> that era, and confirmed by reverting it from v4.3, v5.10.y and net.
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
> I'm not submitting a selftest at this time, as I have only found an
> efficient way to often detect the issue, not disprove it, and I would
> need more test data from different systems, before I can reliably
> disprove it with a low runtime budget, without getting false negatives.
>
> The check could also be "sk->sk_state !=3D TCP_LISTEN".  I have only
> seen TCP_LISTEN and TCP_CLOSE at this location during my testing.
>
> IMHO socket migration is out of scope for this patch, see commit
> 54b92e841937 ("tcp: Migrate TCP_ESTABLISHED/TCP_SYN_RECV sockets in
> accept queues."), as it would complicate backporting to stable.
>
> I have not yet tested that MD5/AO works, I guess that would involve
> extending my reproducer to place client and server in distinct netns.
>
>  net/ipv4/tcp_ipv4.c | 5 +++++
>  net/ipv6/tcp_ipv6.c | 5 +++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index b8887cdd66c57..45d9a7e40e951 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -1756,6 +1756,11 @@ struct sock *tcp_v4_syn_recv_sock(const struct soc=
k *sk, struct sk_buff *skb,
>                 goto put_and_exit; /* OOM, release back memory */
>  #endif
>
> +       if (sk->sk_state =3D=3D TCP_CLOSE) {
> +               tcp_v4_send_reset(newsk, skb, SK_RST_REASON_TCP_STATE);
> +               goto put_and_exit;
> +       }

What happens if the state changes here ?


> +
>         if (__inet_inherit_port(sk, newsk) < 0)
>                 goto put_and_exit;

-ENOENT should be checked to jump to a new label and
call req->rsk_ops->send_reset() there.


>         *own_req =3D inet_ehash_nolisten(newsk, req_to_sk(req_unhash),
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index 9e9155b1b3aa7..c7aa3c6b1c314 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -1512,6 +1512,11 @@ static struct sock *tcp_v6_syn_recv_sock(const str=
uct sock *sk, struct sk_buff *
>                 goto put_and_exit; /* OOM */
>  #endif
>
> +       if (sk->sk_state =3D=3D TCP_CLOSE) {
> +               tcp_v6_send_reset(newsk, skb, SK_RST_REASON_TCP_STATE);
> +               goto put_and_exit;
> +       }
> +
>         if (__inet_inherit_port(sk, newsk) < 0)
>                 goto put_and_exit;
>         *own_req =3D inet_ehash_nolisten(newsk, req_to_sk(req_unhash),
>
> base-commit: 594d905195024b228c962627ae5ae7c17bd582a4
> --
> 2.53.0
>
