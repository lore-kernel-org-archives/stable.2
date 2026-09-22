Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBB053E313
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 13:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082847; cv=pass; b=BAnsH1RAPbIe5b7T1M+XvkY1A5n6n2tIMsAz7MqXUnzf/lgJie0uaO9F/PzS9J13UkJ7pTKtOhxymPXUgdWZItW81U1nVt4LMxniiR1Q4VhQ/XjYAdNA9sc6B4EHqnB/J1n0wLxPf/qkxbt0/CJNQcVyfDl/RAEYbyT/GLpkp2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082847; c=relaxed/simple;
	bh=H8mYDxezL3zeNOcyBRY8j7tO17JD8uUtMkU+mIQ++QQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OsednojY7YmD8RUt8mHD0BjxMJgNKwvIjO7ZTG421PpiVBuLKi3KaBaHiTjsoA4m+CVyMYpmsq3eiPQChLmiGOrLG4Stv8YFNOqkNbFsp8Yo0EFVYyU0OFYHGvE6g3gqf2XGbwq34TYcBsj/YY6ctAJa/xo3tUGgIlQ8SAjg5ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JZljjMKr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=P+j73cdm; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JZljjMKr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="P+j73cdm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790082844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pwTfpD/qGiXwMKgdLNdLdxigBjWDGioNSbd9xxXMy9o=;
	b=JZljjMKrMTe+3cDyROZPa58X4DNghZmTY7Eq731z+OSn4mRraes5K8c8S2+aCEyCY1Fajd
	ho2hFOR/AaAULznHEe13Qc0SEjlTwco+izLzLXCcNozIda2GymgIZlZBBtOMm48E6YLEuD
	0TftbYzuP9mzTI4i8OlHUhPQtoXjk0w=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-3X9LtC8nO4e0dRY0TuGqrQ-1; Tue, 22 Sep 2026 09:14:02 -0400
X-MC-Unique: 3X9LtC8nO4e0dRY0TuGqrQ-1
X-Mimecast-MFC-AGG-ID: 3X9LtC8nO4e0dRY0TuGqrQ_1790082841
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-3a202ac1011so21930751fa.1
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 06:14:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790082841; cv=none;
        d=google.com; s=arc-20260327;
        b=NDXeeemLNi6ga5NmupmEHvOgJd3WK7BSHY8Ig8oKHlXlXzA2qgkVGZzh52CMjsGtVi
         h79Y/p4NkmnFFBooVZnGc4ZeUNuw9H5jUaCaTOJJReFL9D215bA2ev3D6dIOUSpE/q4r
         sCSxun3rhC/HQYQLdIE7jROEu/+2pPLA4s6zr3CIEnW2COM+x5pVdMH1FhYpq40wHo+Q
         JF0fMeOh8iKU66SLtUngVNzWdE7YL2vPfUZRpfR8nYvATKA6M3I41EtqUC5r/u70cIQa
         xGqh55pF2Tq51NJuVjkMg96bNAKU9DrXcveTwPl9pnh4hzZNBAx5Buyms9FgISRRyxb1
         fWlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pwTfpD/qGiXwMKgdLNdLdxigBjWDGioNSbd9xxXMy9o=;
        fh=eUevozjKGP4a7hG4P6f2W3+uCx91lrm8/8OwISCndkk=;
        b=JJSdKqzuMj54HZYntZSs7M+EEAZ+GKp7+OgFsUercy1shAbdQ99vhWL7FOv+ojYlhg
         xzPbwx8IZXjNWKBOsRV+TB8qC0oB4kDyTcJZP6mQG3jSHhKuaKmN2MfrXb+6rLPXP1cy
         J8T9h7DVMKADvhKyPxJh7OlELAbAl7oBYJZ28by0HJadpzT/hDYQwPtvRyuQC5o8iRMU
         QElN4cvcCYVPN88DHuNDLsKb3C0TeqEm7Y7Trzunu7FwCSjYHZSP9o06NcV60WZXQyOJ
         DIBwpRmxLq9IUGRH2vbFckeHkAqoWQF1GwcW2puXTRg+5nsBIiD3XUhCDHidMuZl7m20
         kBNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790082841; x=1790687641; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pwTfpD/qGiXwMKgdLNdLdxigBjWDGioNSbd9xxXMy9o=;
        b=P+j73cdmbz8jEAkEjFJ2iSf5ORsf0Io+x9Vjl+WICjME11rcXdETXdlkwM3wS4bFyw
         MPlP2nKCF5DOsys1h7XSlSp38ttbB31hTSpHIhMBWs8b94kkqIzLTTf8xtoaHXOH0b6S
         K21vswoOvbEyMkViWtNVveHFB4LZFMUE31kNqAw+poNKiPJx4pQmQWXAiy0rOAt80nE7
         Io6zk0ivNhDPo80oqBsikt4P6UoZtDKT99VQbdl7vUyHMeW4tBGueAEEyFdtrGRuEQf6
         c/dU1wjfBYe4UnNTH/dNA/J4LWZOY8+fZO801D1G7+SRHgpy0lsW8CKS57dNFbxUthBW
         HqyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790082841; x=1790687641;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pwTfpD/qGiXwMKgdLNdLdxigBjWDGioNSbd9xxXMy9o=;
        b=T02GiJdipANzJ4CKeA102mEMXyEBLoeSD1G9uUHR0tNrJxttEzaFj7xcYF6aF206W4
         F15hgWGPQVu67lPME0cDt2uhAe13nQx8AG95DPoMEmhk7YouVFAaO93ETjBV8I4i8QQf
         0hBZd3uQrYQbP9IRFIw3EtyF943X+4AwbDyTy+4hbNxS3bIwPr+W9GOdUU6+Mj6J1LU0
         5uGuUs1+ql/zLmfAnMi1KhqYhAS7G4paDGeL9xoTcEAMhGI+0JgSOtaURoe5nzJL2PkK
         APcL4TjHLZ3Y1m+gwhyopF8zov2gRTEYTRjiCOyoTLv6CMsGeIv0xpw0HdVKts3KK7FC
         WNyA==
X-Forwarded-Encrypted: i=1; AKwUvBwXKuuYBuLTNlEsXKompWcj2tDIKNujUW2KSJ7VcuCFfuJ5/+3rT8Rp501sIn27vngmgvnzPrU=@vger.kernel.org
X-Gm-Message-State: AFuF++k8hb8SngwrUacMZ8u3GUld91mS606qflFPTIGJ8WQOW6wKJWTg
	/KIFFVpQWjeIgjKiMDUUfwCZxRfvM/RK7bge6LU2pk9ss94P34vyASzOrHsUF4cqMx91wDCXeET
	5zoNnrzf9aX3K7W38gO1N66iyYXaFBy+8Vba+DAfKkRrjXicoXClPJwrzJ5lxPbt7JRJTYIhT2S
	8Z6TnWB8JOsiDygtamEBapXUYHw+ksk6ro6tvosKCf
X-Gm-Gg: AYBFou0+xxGK5gEi2gZhShsr/ktjqRYrWtLxWHGNK4DLBS7JsqZ+BjxMXJA3sCn1qz3
	3QsuwIEeBV/UGhrhBlouTFK2QQSRCYx6anz+UYPS123ngIxV/f8oooetEyyyUpkoB1PBbWyBREb
	QtZ6mTP1CN5UFIo2rAYU5p0ptKtCqqm2OGqHDJlLZ0I3oF+J6x5jbH1Pck
X-Received: by 2002:a05:651c:199f:b0:3a3:7682:49a1 with SMTP id 38308e7fff4ca-3a5fc0a8e42mr30269701fa.22.1790082841042;
        Tue, 22 Sep 2026 06:14:01 -0700 (PDT)
X-Received: by 2002:a05:651c:199f:b0:3a3:7682:49a1 with SMTP id
 38308e7fff4ca-3a5fc0a8e42mr30269581fa.22.1790082840630; Tue, 22 Sep 2026
 06:14:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914164400.2738350-1-edumazet@google.com> <CANn89i+HYuqNO_ifR7XgpZO89r9ZRWk8MOVzezmDff5KfLMp7g@mail.gmail.com>
In-Reply-To: <CANn89i+HYuqNO_ifR7XgpZO89r9ZRWk8MOVzezmDff5KfLMp7g@mail.gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Tue, 22 Sep 2026 09:13:49 -0400
X-Gm-Features: AcwNN1UAobSneypZDRm5AEaXEmdxsqqxBxlScBCWnvk4mCfcbmcf4C0NVj22bjQ
Message-ID: <CAK-6q+hc2+7x1+WuqZtj7e8C9Vx3aL0DOyA7RA1G3ADqpoBJJQ@mail.gmail.com>
Subject: Re: [PATCH] dlm: fix send buffer backpressure handling
To: Eric Dumazet <edumazet@google.com>
Cc: David Teigland <teigland@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, 
	gfs2@lists.linux.dev, Eric Dumazet <eric.dumazet@gmail.com>, netdev@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 21, 2026 at 9:10=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Sep 14, 2026 at 6:44=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > lowcomms.c tests and clears SOCKWQ_ASYNC_NOSPACE in con->sock->flags,
> > but this bit has not been stored there for ten years.
> >
> > Commit 9cd3e072b0be ("net: rename SOCK_ASYNC_NOSPACE and
> > SOCK_ASYNC_WAITDATA") mechanically renamed the two dlm users, then
> > commit ceb5d58b2170 ("net: fix sock_wake_async() rcu protection") moved
> > the bit from socket->flags to the RCU protected socket_wq->flags, where
> > it is reachable only through sk_set_bit() and sk_clear_bit(), and is
> > only maintained for sockets having SOCK_FASYNC set.  dlm uses kernel
> > sockets, which never have SOCK_FASYNC set, and never sets the bit
> > itself, so the test in send_to_sock() has been false ever since.
> >
> > The consequence is that when sock_sendmsg() returns -EAGAIN because the
> > socket send buffer is full, dlm no longer sets CF_APP_LIMITED, does not
> > increment sk_write_pending, and does not return DLM_IO_END to wait for
> > lowcomms_write_space().  It returns DLM_IO_RESCHED instead, and
> > process_send_sockets() immediately requeues the send work.  A connectio=
n
> > to a peer that is slow to drain thus keeps cycling through
> > sock_sendmsg() and -EAGAIN, burning CPU, instead of sleeping until TCP
> > reports that space is available again.
> >
> > Test SOCK_NOSPACE instead.  This is the bit that lives in socket->flags=
,
> > that TCP sets whenever sendmsg() returns -EAGAIN for lack of send buffe=
r
> > space (tcp_sendmsg_locked() and sk_stream_wait_memory()), and that
> > lowcomms_write_space() already clears.  This restores the semantics dlm
> > had before the bit moved.
> >
> > Also remove the clear_bit() of SOCKWQ_ASYNC_NOSPACE from
> > lowcomms_write_space(), for the same reason.
> >
> > SCTP connections are deliberately left as they are.  SCTP does not set
> > SOCK_NOSPACE, and it never calls sk->sk_write_space(): sctp_wfree() end=
s
> > up in sctp_wake_up_waiters(), which calls sctp_write_space() directly.
> > lowcomms_write_space() is thus never invoked for an SCTP connection, an=
d
> > the test added here stays false, so send_to_sock() keeps returning
> > DLM_IO_RESCHED as it does today.  This is the only safe behavior, as
> > returning DLM_IO_END would wait for a callback that never comes.
> >
> > Fixes: ceb5d58b2170 ("net: fix sock_wake_async() rcu protection")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  fs/dlm/lowcomms.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
> > index 2aff1c7c17de..abe9ae4c643f 100644
> > --- a/fs/dlm/lowcomms.c
> > +++ b/fs/dlm/lowcomms.c
> > @@ -522,10 +522,8 @@ static void lowcomms_write_space(struct sock *sk)
> >         clear_bit(SOCK_NOSPACE, &con->sock->flags);
> >
> >         spin_lock_bh(&con->writequeue_lock);
> > -       if (test_and_clear_bit(CF_APP_LIMITED, &con->flags)) {
> > +       if (test_and_clear_bit(CF_APP_LIMITED, &con->flags))
> >                 con->sock->sk->sk_write_pending--;
> > -               clear_bit(SOCKWQ_ASYNC_NOSPACE, &con->sock->flags);
> > -       }
> >
> >         lowcomms_queue_swork(con);
> >         spin_unlock_bh(&con->writequeue_lock);
> > @@ -1391,7 +1389,7 @@ static int send_to_sock(struct connection *con)
> >         if (ret =3D=3D -EAGAIN || ret =3D=3D 0) {
> >                 lock_sock(con->sock->sk);
> >                 spin_lock_bh(&con->writequeue_lock);
> > -               if (test_bit(SOCKWQ_ASYNC_NOSPACE, &con->sock->flags) &=
&
> > +               if (test_bit(SOCK_NOSPACE, &con->sock->flags) &&
> >                     !test_and_set_bit(CF_APP_LIMITED, &con->flags)) {
> >                         /* Notify TCP that we're limited by the
> >                          * application window size.
> > --
> > 2.55.0.1007.g17ff1f9808-goog
> >
>
> Gentle ping ?
>
> I have an ongoing series for net-next removing one cache line miss in
> TCP sendmsg() and ACK processing,
> blocked by this patch.
>
> If you prefer, I can insert this patch into my net-next series.

I acked the patch in your patch series.

Again thanks for looking into that!

- Alex

