Received: from mail-dl2-f36.google.com (mail-dl2-f36.google.com [74.125.229.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC91247AF6B
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 21:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790200018; cv=pass; b=hvMY9Aika55moF7Lki1/gjx4mypuyLj26IZrFdcMLzxnxgrW98mRc7GFO008IRlDJFEzqEbiKEkAGN1OzEkWU/01v5JKuT0qvOBaCPukxUOtD8IISm2PbDqxyK2y0zoGE79Buub2/0lAW4Nb4+CA9B8ltsAddIiAvBgUm6wbxWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790200018; c=relaxed/simple;
	bh=yxlLjlxEYje9gyNjL3O9/Z0ckFDrmPMnutRBVnPIg0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EyD3kLLN04MsSXboca64B8SJWCdlVRIned8C6r1T0N8BWd5VYnYE7ZTx6WiIVG5k2qmDdjfg+Wa1j6zOPMmjDJjekghoRijz1hf/CfWlTzvOTC3epz/inIBAo0YLHNj4n9TUgSKNCbDXr3OtBxH3LsrHeef+2KX9xg7weiRO7u0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NRygZBtb; arc=pass smtp.client-ip=74.125.229.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NRygZBtb"
Received: by mail-dl2-f36.google.com with SMTP id a92af1059eb24-14373bcc010so1591618c88.1
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 14:46:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790200012; cv=none;
        d=google.com; s=arc-20260327;
        b=FEd6Ar+CkvvkXDm9dpE0RXNW+E1VKkm0x8R9eT6R5DlTsCRu6MoCNGhB0L820wofnT
         fwCo/DjvKDrNYD19jj/CtrOW/JN15DdJbcUng+toIldDYgp0N5PXK5Ud+lCAp8oXgvlV
         UEmhVFuNW/9Wy5t0Ze50WRqLXxTRsoWa/wVDtZyJTdTxvtdo93XJPED7CA98t5T9dO7E
         RnxXLe/8fSZLgXVSA2EDr1YPPezCiwGjTh1JG1yu13WfScgqCE+e/V88OeKi/mDDfdAQ
         SGmOidAuUFgwcL/tCQdeW0rL0lgsngv0/KDb5oSOsDLzkt9Zq9hPJrMqaMdRyazXGSrp
         A8iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R/JHzgKbPIRgIKe3d1dNX3GOh2sidTHBM5B4emfM1ak=;
        fh=VkxS3D3+UNfUPzan0AjptDyMk7U8Y/Tov6F2a/LtRII=;
        b=Fg3ifF6MIhJvojGVB1lSCwUnDI0hNSE6wZFRlNliCX0g9VKiJZ3PYVXlTqoRsJpQkC
         69ygcaJXRqC+JsBt9680yR5hu00VElYQQuRiw7XXQscpf4qZvWi50tq06Yph1rTUVhMO
         r4jcSqxKRHWj1OBFlbgc2kg1TcU96ejDMijD/rQFxWgY2lGX6fC2IMIwosiVFJED95yy
         2sToRLNQkSoPptOmDi2qjwrohoZXvoss8G5gAFLVgyEIG+NvTRqzxnXBBx3SGG5iBM/9
         6ZVzhT+m4QKv2G1mCf/FEiKCOoxgdPXvwDGXrkjqXsoB6a6Q13nqcvZLO678T0W5TZoT
         TJRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790200012; x=1790804812; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R/JHzgKbPIRgIKe3d1dNX3GOh2sidTHBM5B4emfM1ak=;
        b=NRygZBtbRvqB1gjWiwzFweqOjPd97NVy+ZM7CUqxSbrm3Q7OuUMgsJfDzdVPuLeI9R
         GDdUv+h4I6Ml9sOyts57zO/wbAG5yI9V+DqICLlFcpUmzMdTU5R+WjqXU2/vmLecZYlV
         a3YcWMsIenUMbuzhkiejlVWt8NVDrTs4zTqHnoznEzOJ4x7XRXHf7MLsmuw4T6CTn2ra
         LwxEvqSGQEjPpVsWRxBcNiEwoPyqehrkhQFBg8f0byp6BWoFM3pFcfR7h1YfmyXMredU
         6ZTWGvhxAnN9QrtvyPVaNPzBPsbdYQWA5/hSWVFH6sgbq1mwOmg6O/0z3VTTjzyGAleR
         HBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790200012; x=1790804812;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R/JHzgKbPIRgIKe3d1dNX3GOh2sidTHBM5B4emfM1ak=;
        b=gvFNYs3XZmeNIW/mIIcCgRxwdE5WeYljXn3s0KaWjaNEkvKWaS3fdUm6iOdPUMOPh2
         0CBqKSsrXU5hwuxafnZxAp2dbCFt9kx0lhJY9kwWIYNQdw6RbvcQNBXBczAARg/+OZWP
         f2axXj3XDJIcv1lIW2ip9msYdOv4gcyWFlikKzfshlGzujdbwtPhWUfydKQLgTJp8RwK
         a0Yykx+un2c8Os/uMVkQI+uBihwtqRS4b234CcHwA19B0Cf8rqxVZjXH5FmMtoaVuF2d
         WQ+TYMLEhTV1epkwBzDLSKB8/+UdfT3DSnwOx+kH1nqrOVpERW359lYS5onxIkXJ9cvx
         CrxA==
X-Forwarded-Encrypted: i=1; AKwUvBzOERXeFlOwNLcqqhjlBEjnUXX/q555lnyjaQjafhqQj3OwZLCCVv90VqTjSzVchxFieYUEXFc=@vger.kernel.org
X-Gm-Message-State: AFuF++k5p3m9lcXoF9tklyLgEYDYaOaSKsSIiGGYK4ZyhOAicr6s/gQE
	d/XuXAv3TkQbzN84JulccJkQBClM4LEOAUlH1b2UMJ1V4CpIFHVybxErw1++LC+q7n3VjiipcAI
	uEE5MLLtkQTTAtbj1eZvIRctiw8TN+fR0752qt4P0
X-Gm-Gg: AYBFou0oASB8tAc+asPrcp7wBZpd/7P7eq/0puLxKt52aIrYrna8Gpi6rk3b53gCpgR
	7OhWyAm2YUmLpmnGTB5nP2g9271frVcmAtIi6I8PSvq0vQuMhw4bycAmG5OeLPb6yMvu0b/Hb7D
	nlPKyNQ76CBbGyz32tzZgWhgxRcQ48/1Ix/5DhsRhVhPht0JNCe4WwPm6BZvfxzLd4emDVRfQx1
	KV7wbogBVcIsin/xh0aduSbNj0DyMkxc+T5YjojFGaQSxzUaDe/hKY9vjnxX5Bw6LudgO5/y6KN
	kn2KZZLknMWIGrCKYoGZMxZpKN0LTizZzuwF1je5LIKWcAeJWuqye3NINaHdRhlcHc7fwHTrRPY
	YVUjUOf+QaECYVCeok1SGn9TPnM2kbwPceswYpfw0kTjaDpil3hJiPVlKtKgkWWpQVfZ6SRkks/
	vNjIy5PZZYs8MYhNM4FTHgcA==
X-Received: by 2002:a05:7022:ec84:b0:144:f8a3:2eb8 with SMTP id
 a92af1059eb24-14503f0014fmr479906c88.9.1790200010885; Wed, 23 Sep 2026
 14:46:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922122721.3568295-1-edumazet@google.com> <20260922122721.3568295-2-edumazet@google.com>
In-Reply-To: <20260922122721.3568295-2-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 23 Sep 2026 14:46:39 -0700
X-Gm-Features: AcwNN1WVwgUo-bragsI4MDRSzZd0xxrtae8n4KtGMXLllwPDYR9tuk8b5Jj8gpQ
Message-ID: <CAAVpQUDG9bi1FLL3aNmR1d8c9qT78MocK0dEhnUaxR3BQJKZQQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/9] dlm: fix send buffer backpressure handling
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, stable@vger.kernel.org, 
	Alexander Aring <aahringo@redhat.com>, David Teigland <teigland@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 5:27=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
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
> Cc: Alexander Aring <aahringo@redhat.com>
> Cc: David Teigland <teigland@redhat.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
