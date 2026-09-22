Received: from mail-qk2-f41.google.com (mail-qk2-f41.google.com [74.125.230.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396CD34388F
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 01:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039443; cv=pass; b=mgTHfo3LeYfRSq/+32HyrqrKpJhNzaK4M9g+R7/I9zUg6D1CVaND1GT2/+iizwpAiLohhJ0yzdTuHddNIg6RcfopqncyHpM2p3WXHDSlY3j6I1567PsNGfp7ADrv02vz7IlXVqlGfiJsQOG6lJC711NODUWh6WlXxHRRKUaVFco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039443; c=relaxed/simple;
	bh=rDphcxVK0cLwUUna1tpHZp2v6qK6oFhLgiPUmxWlUKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m0lLfGGE0BHRVRMpiAysvadCturrbwwWSLlHR3EtIsfZfmNPnuUoaAnY6ZxCtW6jM2aOmSg6m10aNV5xf8PzQpKYARsUPJ1Q9VvROiS93wcXgnmNvuVk1xZDkMSYhqE584Fj2iHYT9Yt0zd4AVEyJ1eLaSF3wr2TRRKVIB6QF9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pwdcy2NN; arc=pass smtp.client-ip=74.125.230.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pwdcy2NN"
Received: by mail-qk2-f41.google.com with SMTP id d75a77b69052e-532d63f434fso11765891cf.2
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 18:10:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790039440; cv=none;
        d=google.com; s=arc-20260327;
        b=s5Qi8TMvq04hX9MC4LxyZJDkc8kPC7bKbF3J4LbagFgYVmbKUkUKrYEe4ndPhvMlLW
         x5qes+IArSQ6ILDsz+pB82VBC7TKpAeWI0eiOEpuAia+o/1+9jcY6olMZl8sHpI+m51p
         YzMQQ1LI4WZBBkvFThuzS6dMdRx7ZWwIzVgZM/XmA9/IxXBnVIezWrmbjTJbzAgj9TMB
         3i0xPRCQiZTEuCQQXq1WwcL3BVKA4R9VJ/gX1W7Cy2Z690ccjuqx7cZ1z8HOkQh+v56g
         SdeO0SYz9v5kryKSfJ3i6NnRJYpCEa+gxL+TyokmI4EsRHkSlEWVddXY37Ohf/msNATQ
         x8hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u6Z2U4vAuJb/VjzAk0+RtK9FDIXwMhOB79JAT2yh+ek=;
        fh=KtkKLB2D+YQItuQ6oBOY1dw4VzkBxBB4V4M2FA0O5y0=;
        b=Qw4x2HhhfxMxI4Nuz+L6qhSlOX6cJbdSfsR+/wT+oWhHj+HK2Cnwo+HS2nt7ViB4b7
         k7rTZie0tyeCFARXavDlxtP0h7gwAUT09qgblP7j7+zb/KkhskHBP1dUjtaaiW/9hkPN
         DfmYw4JRDJs/avwiryt/9+iVY7YvTMGZVAMmW/h7cQrglHAaMUGkf3JOWLWZi2E9kFFq
         6qVTmmjBSw7/uxHgE2Nb/gg5IrnOjP0GqhT0z2PcMtgj+7IOoNbqFQY0iQEeviBUgTWB
         7sPAvfKDw7aqYkgV1L+FZprbFRjHEeVUBGVGTlGo04g5m5heHGQRRYGF3txKzsxaTB7X
         Nuzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790039440; x=1790644240; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u6Z2U4vAuJb/VjzAk0+RtK9FDIXwMhOB79JAT2yh+ek=;
        b=Pwdcy2NNDsW68Ziqg7g4ty/PdMAiuuHbk/aIZAm6lGfMCPaFAtMh+U0mlB1CLqDdRV
         W6MgrQYDcRCm+uvFXHNVE5iXZbLUzUkQQITRAeu+ZromRa9bO2Cu5+jPqGmIMc3fs9cV
         f3f0vr6CPkQeFtlnyhKRUjDzg/TPdffJo8NMCAeRoYd/bXMBqh6NXjg9ShOkiZS9Iyb2
         LFDaKICi8PC5x6qK90BcIUstjzncpvf/P6Jm1Rbdh8IWwlDL5HoCTmDfTUy3FA33XPvd
         oT9K6jAIJpz3hF6049rnJUNLS1gGDoByMrLue2SYByZzHwXU60k0jcnEZjovkUCq2Mki
         WjyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790039440; x=1790644240;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u6Z2U4vAuJb/VjzAk0+RtK9FDIXwMhOB79JAT2yh+ek=;
        b=WXNC/eR9OMsTYnhstiYbWU9hSFrCl7i864JI/wbFvakoYfjio/knNkdP965qL5nrz1
         IDGDVOG5A20VmbTPdbENxRzcNGj9jVrOMmHjx9sBjWyb323M0flUKoyG3P/LqNhiD3Z3
         wynC5MIvYxnoQxqa1z5pLTkTodPX16d3IrjcQVI+5qI4ZoTO6NMGgE+eFgEkqKAD4uc2
         1aN1OiP6Dk6HDw6i8hDyMTtgfFnZfuqUqnhCAjlJLn9HVAwogJT6Oxw8eCb08C2cywJj
         Z4r9RsMUPBIdt5zpBr2NvvFq+es+cKiSgnV83leXe80GP1q7Hr5dZaEX1/Ye5mGnoxFR
         pJEQ==
X-Forwarded-Encrypted: i=1; AKwUvBwudJCh1m5guUR4+M9uo2Coc0Qjhjm8aJJSSc+KfyVFeYLphkBaUSaDD6GBEULZCGX+Xm4GWR0=@vger.kernel.org
X-Gm-Message-State: AFuF++kTWrFVypmYf6nw7lJ1rWkW1LVXdro7VSUaUlU+qGWoQFqdE/M1
	S8jbILKF/7O7dnx1073oneLrXR8/oYkcmM2x1FR7A2XHzxRiyh+L2+845XcUhOu1JiaF6tuF3GL
	wPRuVuTatq9G8nJNoJ6l7GbEDdm8XXEnG28eN2DMx
X-Gm-Gg: AYBFou0Xu4AgXI5Ko8/hkh3zORHLdxMoOQLPYd2zlA5NFE7cvaUQr9oZI1R3Td2XTkC
	6gWFS7jyysV6NpSzeRz72iZiFy5MRJbwhRClGlgi84WSkdom423h0gB2zDIRB/JtbhDS6TpH1Z3
	wwRHdoX4EL3S0KWWLhNoV+Oj7LrvTB+keUSwDxF7eshAisJJSBFgnhAHVqVIKjFBtd8BtlZsXJZ
	GCoPZovuP7xvxWmAkFPvqXqoYFu32P6dXC89uIdKc09b1mHKS34xILw1cRCUBhbcKSxpTe0ujvX
	waZfGm35Ev0x8hOdAlBNZl1CbJZlcDSJB5rNyiqsSybRyjzwBzBSg6JeVMSep53uFSMUat+9KfN
	BT+9ZnFZe5OIHnyce+SvaLseXocgBHMwitBuCim3L4oWwM+EaLJhAKdFm4fy4XMVQKoAniA==
X-Received: by 2002:a05:622a:2287:b0:52e:8ef:5960 with SMTP id
 d75a77b69052e-532d8e32ebfmr30057471cf.33.1790039439462; Mon, 21 Sep 2026
 18:10:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914164400.2738350-1-edumazet@google.com>
In-Reply-To: <20260914164400.2738350-1-edumazet@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Sep 2026 03:10:27 +0200
X-Gm-Features: AcwNN1XENI3C6DJEuWKSVfu123kER72zrEHAvPUuiU4gn9CTQlz-0sfrY4BfkQw
Message-ID: <CANn89i+HYuqNO_ifR7XgpZO89r9ZRWk8MOVzezmDff5KfLMp7g@mail.gmail.com>
Subject: Re: [PATCH] dlm: fix send buffer backpressure handling
To: Alexander Aring <aahringo@redhat.com>, David Teigland <teigland@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, gfs2@lists.linux.dev, 
	Eric Dumazet <eric.dumazet@gmail.com>, netdev@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 6:44=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> lowcomms.c tests and clears SOCKWQ_ASYNC_NOSPACE in con->sock->flags,
> but this bit has not been stored there for ten years.
>
> Commit 9cd3e072b0be ("net: rename SOCK_ASYNC_NOSPACE and
> SOCK_ASYNC_WAITDATA") mechanically renamed the two dlm users, then
> commit ceb5d58b2170 ("net: fix sock_wake_async() rcu protection") moved
> the bit from socket->flags to the RCU protected socket_wq->flags, where
> it is reachable only through sk_set_bit() and sk_clear_bit(), and is
> only maintained for sockets having SOCK_FASYNC set.  dlm uses kernel
> sockets, which never have SOCK_FASYNC set, and never sets the bit
> itself, so the test in send_to_sock() has been false ever since.
>
> The consequence is that when sock_sendmsg() returns -EAGAIN because the
> socket send buffer is full, dlm no longer sets CF_APP_LIMITED, does not
> increment sk_write_pending, and does not return DLM_IO_END to wait for
> lowcomms_write_space().  It returns DLM_IO_RESCHED instead, and
> process_send_sockets() immediately requeues the send work.  A connection
> to a peer that is slow to drain thus keeps cycling through
> sock_sendmsg() and -EAGAIN, burning CPU, instead of sleeping until TCP
> reports that space is available again.
>
> Test SOCK_NOSPACE instead.  This is the bit that lives in socket->flags,
> that TCP sets whenever sendmsg() returns -EAGAIN for lack of send buffer
> space (tcp_sendmsg_locked() and sk_stream_wait_memory()), and that
> lowcomms_write_space() already clears.  This restores the semantics dlm
> had before the bit moved.
>
> Also remove the clear_bit() of SOCKWQ_ASYNC_NOSPACE from
> lowcomms_write_space(), for the same reason.
>
> SCTP connections are deliberately left as they are.  SCTP does not set
> SOCK_NOSPACE, and it never calls sk->sk_write_space(): sctp_wfree() ends
> up in sctp_wake_up_waiters(), which calls sctp_write_space() directly.
> lowcomms_write_space() is thus never invoked for an SCTP connection, and
> the test added here stays false, so send_to_sock() keeps returning
> DLM_IO_RESCHED as it does today.  This is the only safe behavior, as
> returning DLM_IO_END would wait for a callback that never comes.
>
> Fixes: ceb5d58b2170 ("net: fix sock_wake_async() rcu protection")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  fs/dlm/lowcomms.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
> index 2aff1c7c17de..abe9ae4c643f 100644
> --- a/fs/dlm/lowcomms.c
> +++ b/fs/dlm/lowcomms.c
> @@ -522,10 +522,8 @@ static void lowcomms_write_space(struct sock *sk)
>         clear_bit(SOCK_NOSPACE, &con->sock->flags);
>
>         spin_lock_bh(&con->writequeue_lock);
> -       if (test_and_clear_bit(CF_APP_LIMITED, &con->flags)) {
> +       if (test_and_clear_bit(CF_APP_LIMITED, &con->flags))
>                 con->sock->sk->sk_write_pending--;
> -               clear_bit(SOCKWQ_ASYNC_NOSPACE, &con->sock->flags);
> -       }
>
>         lowcomms_queue_swork(con);
>         spin_unlock_bh(&con->writequeue_lock);
> @@ -1391,7 +1389,7 @@ static int send_to_sock(struct connection *con)
>         if (ret =3D=3D -EAGAIN || ret =3D=3D 0) {
>                 lock_sock(con->sock->sk);
>                 spin_lock_bh(&con->writequeue_lock);
> -               if (test_bit(SOCKWQ_ASYNC_NOSPACE, &con->sock->flags) &&
> +               if (test_bit(SOCK_NOSPACE, &con->sock->flags) &&
>                     !test_and_set_bit(CF_APP_LIMITED, &con->flags)) {
>                         /* Notify TCP that we're limited by the
>                          * application window size.
> --
> 2.55.0.1007.g17ff1f9808-goog
>

Gentle ping ?

I have an ongoing series for net-next removing one cache line miss in
TCP sendmsg() and ACK processing,
blocked by this patch.

If you prefer, I can insert this patch into my net-next series.

Thanks.
