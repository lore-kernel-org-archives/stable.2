Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794577741;
	b=msYThl3QTdUSst3Y3vKKDFWozmyHrNBj9W+9LcxY8XyPoTaIsrY9nQomfsSNJI4qpMoo
	 hCGtXlYVHuoZFLyEzfmXGIW0CaLrX0fX/AlK6kx0uvEPkjuvUBrB0T6W9rfmlfPSR5vaF
	 G98/Hec9hdXdNFg/wI1UGMN0KGYUaNclkuu5qEv41TTVI5YYMHDGdLl4tIFYmh79mULxy
	 AXzMcELqnBxVEg9B47uskAA0TKksKcOvrMqWJ3ZUmE9JMVCoZo1slyIi7wLPdPvFqxK+c
	 f0+8U8dpv5RUT0rj5HKOw+E34ahGuDeRXmmgvj7el4Ce3CLuOA0/bAVivbjKIcElR1A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577741;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=1bhPViXt1pRD/+G0cozJg3X1gM1h4MG3wea7XTuXsrc=;
	b=bPNpA5DlrINt8VMBLXZE1dF2iNPEOI8ygnz+8VYtbq48/ALbsXZpqQmGDTB+zKhQtGdr
	 RxsSQV4jTttS6I9IXEfLiQvWVznVU17ZxL8LKiMptD2ZjCszCqmqWXkePPY3njNhrwXaa
	 pP/xHZYbuA1wQjn/R3ALkxYC7m2F07yPBXk3O4F53+mclolzWJO1wZ0XpnrVDUCF1UzpC
	 d1GbB2oFyRtvjTrX77hy/nlAJ2TZEJjWLvl+4sw7U6UA4e8O8LvYvXp/5nSkq8WGWlsyb
	 Opev37cmNH8A5Di30qa7AFXaM7w9JmnriwCFT1UR8Ux8q8bOXfRV9psOuU9oi2JjHsg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IDaBJi6E;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19185606A8A7
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 13:49:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19185606A8A7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IDaBJi6E
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8a052aff9e9so1449289b3a.0
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 05:49:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794577739; cv=none;
        d=google.com; s=arc-20260327;
        b=EDVS5QJhgomNXELrv5iULLyZJDMxhDnCGAT7bBnq3fQsjVZEE6Ota3y9pADIKx5TS0
         mTstq87ZSGtsBDhjwci9x4HF70lDVvgbnOVdkt4aKbabh9APd6xFms9uvMtWDnImTIVT
         fJxiIOOhHbjcWPP04OX3JdzvCGmDEmPt8aSUP4U62A7ctRhjdbrtYqhjMZpYDhTcHYk5
         Zh1PX1rX7Oqafv3bWwSLSxCCu0y9/Dxsj94pNbbv8oyqqRl81sR+QaS37lFZdosxqdRz
         rkw7Zmn6bkc/qo82lZcbKvLj6nzNm45MsFsDqfU+Rr0qkYZziq9B+nzRuuHUFOw6wTDs
         5jjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1bhPViXt1pRD/+G0cozJg3X1gM1h4MG3wea7XTuXsrc=;
        fh=r1n6UY0midw7gbslIWXPgZ51RHqUCxTgL0+0mrzTDuU=;
        b=BLP9FJHvkH0Yns68Mf+4gd5z7EV6V70kFHAYvHsZZc84HvacvWzs2k0t/t8IpI/XyY
         O5I9BgaOOXn+afiILgSnW5upvmrqaFV/Ms+LbWSOouwk4Cv6GCOp3PtcmqK7qsiz56Nk
         L83bb4XNUWroPcip1Xg/vqgHmJ4vZmo3ggBX0teuEnGaVpCczEtANmYlmC74fLExEjrA
         8Yqo39nYandAhbWGPXWxeKWxd6K6FXPTyfetH6MvaWlWDBP5ngrBBPlrZu7VbG67SpdQ
         CGJ1f+yd+SaIV522rH3gmhzDyy0J0W4gBqpGiAmyiAjpwX0uswlR+NZMNAlex0i9paZS
         Gt9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794577739; x=1795182539; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1bhPViXt1pRD/+G0cozJg3X1gM1h4MG3wea7XTuXsrc=;
        b=IDaBJi6EnzYWBbfLMiIPr0Hr9fUbFucDOD5m0rjktHtv4g65mORdut5ERKbwL3+WdB
         Ebh98AmvbnRMDB5UNnyQWh0hqd6x9Lv/vmnaDNCw0JqxFBUeoDpXKz4lTndlo/XHrvpi
         N/I7ww+bA3R+GVpMMfkFGheCSAaZ/BG1iIfgs8r+xIG0umJ8Q2Mmh1VpTOBS07jjZqTz
         nAJgyVzCIyaklyNxiek0OKHskIrA+FjsbNJgYwzHgxK7+Wl8x/c1WAVZPZpkcAVL+/sS
         xZLCb4uuHJ40hxymUgOM3U1c328PfYaV0Nj9Q5mB0ZEffdzBeJ/uyt01pd2SwV5StXSr
         l6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577739; x=1795182539;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1bhPViXt1pRD/+G0cozJg3X1gM1h4MG3wea7XTuXsrc=;
        b=Z2qTX/RRg1FdaY4hnnfCC3+lzja0tQt3NKq+hQTl+FmDiK499xLFYPP/HpFq4xsIA5
         yNTzPs0GtDsAhsbKp6dAxIf5BEd01vNy/kld+LSbPU3f6MFuYPMLzFYIo53ksKD+YF5l
         lpOLDQsN1up+DjLfywNrpH0/pSh667SIASwqgokJv4z8j8njIY9IqzlV73848z2ppwro
         S8cuZ4CJzTaVJTHQr42a6M2peSwHP8FvB6Cr6lZuXRGmql3uSgacyUWU+ATl1eOqcpT3
         0d8kM+FAFtab6VbsK9RB10qTnv9HGomQpm4SBiDUNaXAmOGgiNl8CYHmFjOSDhDKurT1
         Eu5g==
X-Forwarded-Encrypted: i=1; AL+hErGeSDbIbx9hiutSEWQwqFDsLw8ubG2Of0V4SnBHgedbEhbaj+55OU4zceBHv1RQtN2POx6M0pM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+L7y4P7ZmzKmWLJrprqBpj6U4MLcBFjGdO41QyXpNL3kaSjUQK
	6Cij7s1ZzQdmSKSzJKIk2vsqepgxxYiz1iN0xCUBleX9egUm2Kpl4sZlaPPCJ5hZFD0fdJBiSY7
	k5vVfUx6RvTHdK+CLbpq3e7O48KeSLj0=
X-Gm-Gg: AYBFou3t+k62ma3TH7weIAMqT0MgL8H/sNLry0yEFB46K5ydWnbbUSfrZvmbG8ihBc7
	eCn/ND74Tw5Utsa3yP9Ezrb2DQEqcGphcfhJqz5dI0sMBF0cU+qAE4mLRvAtYNE6MWMqpzO1aqL
	eZDQX9LgeRPP5WvSaazdmGO9QHp42S5jWQWJqwh4xvqphQCBi5DqYG5ItNvpEMRt0peN1eXqaqt
	UsmXEyNuMqMQ8w23rWy6lx5Pdyqj1MdzTIlLD5d/v2bgyv3Rk6RiCOPJGEQAe8ZQQ4n5Inr+egO
	MQq7Z6qD0DujVDPj/WC4htswxm59VhIhxGR/0Pnt2ruofN0LDi7IPyq09E/TrCUVrQSKnDTsXTr
	HgI+sX7pgUGsxGQI0OCQcUXVh1nljnCVHRLdPVoVsdTljMPRZtMkMvf3dZT+3+JpaazbRzViH9o
	Dr+7m6Bxeh3HF81uVspLl1sbN6yy1jPT/9u7urP46MwlwTXonaaYfNusxS
X-Received: by 2002:a05:6a00:893:b0:8bb:1b05:dd39 with SMTP id
 d2e1a72fcca58-8beb58bcc45mr2934303b3a.11.1794577739414; Fri, 13 Nov 2026
 05:48:59 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112172149.27355-1-yves.bieri@theori.io>
In-Reply-To: <20261112172149.27355-1-yves.bieri@theori.io>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 13 Nov 2026 08:48:47 -0500
X-Gm-Features: AclHuK8PfN4ou0sIEU-hFGhRyxEEh94jLa5NJ3yVhQe-fdSo_K9CA5s6bPZ98fo
Message-ID: <CADvbK_cetnuX7=VDEh9hE4db3BdYWr9es28jVorMXOQsTfrxGQ@mail.gmail.com>
Subject: Re: [PATCH net v2] sctp: do not free a new asoc peeled off while
 sendmsg slept
To: Yves Bieri <yves.bieri@theori.io>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 12:21=E2=80=AFPM Yves Bieri <yves.bieri@theori.io> =
wrote:
>
> When sctp_sendmsg() creates a new association and sending on it fails
> with anything but -ESRCH, it frees the association. The send can
> sleep in sctp_wait_for_sndbuf(), which releases the socket lock, and
> meanwhile another thread can peel the new association off to a new
> socket. The wait then returns -EPIPE, and sctp_sendmsg() frees an
> association that now belongs to the peeled-off socket, without holding
> that socket's lock.
>
> If the peeled-off socket frees the association first, e.g. on close(),
> sctp_sendmsg() frees it a second time. Otherwise a syscall running
> concurrently on the peeled-off socket can use it after sctp_sendmsg()
> freed it. Both are reachable by an unprivileged user. The double free
> on net with KASAN:
>
>   BUG: KASAN: double-free in sctp_tsnmap_free+0x5c/0x80
>    sctp_association_free+0x1eb/0x750
>    sctp_sendmsg+0x15ff/0x2020
>   Freed by task 836:
>    sctp_association_free+0x1eb/0x750
>    sctp_primitive_ABORT+0x85/0xe0
>    sctp_close+0x22a/0x8d0
>
> Commit dfcb9f4f99f1 ("sctp: deny peeloff operation on asocs with threads
> sleeping on it") fixed this double free by denying the peeloff.
> Commit cea0cc80a677 ("sctp: use the right sk after waking up from
> wait_buf sleep") replaced that check, and commit a0ff660058b8 ("sctp:
> return error if the asoc has been peeled off in sctp_wait_for_sndbuf")
> reverted it to return -EPIPE, without restoring the check.
>
> Fix this by holding a reference on the new association while sending
> on it, and by freeing it on error only if this socket still owns it.
> asoc->base.sk only changes in sctp_sock_migrate(), which runs with this
> socket locked, so the ownership check is stable. The reference keeps
> the check safe if the new owner frees the association meanwhile.
> Userspace still gets -EPIPE, and the association stays with the socket
> it was peeled off to.
>
> This was found by Xint Code, an AI code review agent, and reproduced as
> an unprivileged user on net with KASAN (trace above), without modifying
> the kernel or using error injection. With this patch the sender gets
> -EPIPE and the association keeps working on the peeled-off socket.
> Without a peeloff, a failed send that created the association (EAGAIN,
> EINTR) still frees it, and a peer ABORT while the sender sleeps still
> frees it exactly once. The SCTP selftest sctp_vrf.sh passes. The
> reproducer is available on request.
>
> Fixes: a0ff660058b8 ("sctp: return error if the asoc has been peeled off =
in sctp_wait_for_sndbuf")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yves Bieri <yves.bieri@theori.io>
> ---
> v2:
>   - move the hold to right after the association is created (Xin Long)
> v1: https://lore.kernel.org/netdev/20261110224233.82977-1-yves.bieri@theo=
ri.io/
>
> Tested on net at b71c101bbb98.
>
> The fix and this message were drafted with Claude, and reviewed and
> tested by me.
>
>  net/sctp/socket.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> index b5a57f6..6ed184e 100644
> --- a/net/sctp/socket.c
> +++ b/net/sctp/socket.c
> @@ -2063,6 +2063,11 @@ static int sctp_sendmsg(struct sock *sk, struct ms=
ghdr *msg, size_t msg_len)
>
>                         asoc =3D transport->asoc;
>                         new =3D true;
> +                       /* sctp_sendmsg_to_asoc() may release the socket =
lock,
> +                        * and the new asoc can be peeled off meanwhile. =
 Hold
> +                        * it, and free it on error only if sk still owns=
 it.
> +                        */
> +                       sctp_association_hold(asoc);
>                 }
>
>                 if (!sctp_style(sk, TCP) && !(sflags & SCTP_ADDR_OVER))
> @@ -2084,8 +2089,11 @@ static int sctp_sendmsg(struct sock *sk, struct ms=
ghdr *msg, size_t msg_len)
>
>         /* Send msg to the asoc */
>         err =3D sctp_sendmsg_to_asoc(asoc, msg, msg_len, transport, sinfo=
);
> -       if (err < 0 && err !=3D -ESRCH && new)
> -               sctp_association_free(asoc);
> +       if (new) {
> +               if (err < 0 && err !=3D -ESRCH && asoc->base.sk =3D=3D sk=
)
> +                       sctp_association_free(asoc);
> +               sctp_association_put(asoc);
> +       }
>
>  out_unlock:
>         release_sock(sk);
>
> base-commit: b71c101bbb9814d163c00234d43c41f0a17907d4
> --
> 2.43.0

Acked-by: Xin Long <lucien.xin@gmail.com>
