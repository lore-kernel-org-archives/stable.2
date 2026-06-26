Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86303749F2
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 12:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782477220; cv=pass; b=OuYs9hTna/SJC+fq8kTBUo8r0GyFifTAcfLBh1cHSCb/C0TvzsVXdWmL462XdACI84cpaD+m29YRMzfGq7zEXYovdGIs7zdmg5f13wmFlTDleN0eW2H+9Wpz1rqP+TeTlLDZVSM8/4Kxp8yBBlOW2jhqXegLGOF2elpLG2GrCtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782477220; c=relaxed/simple;
	bh=Y41+IO+eaKZK+ikeiVajbs+K6G0q11zCVz26+RESpPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VcO/giS0kv4tN1G7LXJ6XysXvSIs5GAIPOhlBIt0221R9mLIMei2094B0icw/WYpDR09uVzrALyuoEt8W4/8oB2xsv02F1G4zXMrgAP31z0KWFoHkNm1F1cbOxRS1FJsQO/LECk1MNyulzkmBkcliXPiXdJzHjXboFj5NyzIrdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rMRBKVGV; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rMRBKVGV"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c821a50615so2021635ad.0
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 05:33:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782477219; cv=none;
        d=google.com; s=arc-20260327;
        b=DOZ9uis14l2xyO5K5vq+xAB3VndLfZjeObG9SM3gNQOWFy9TWB7qEYy6w7O5sC0X9K
         v14qL4WnAtwKmKMFN6ORHM3veyHesCfb5ZCnl3deLj8DRQSS3NLGnHhPwJ0H5Tc2ZiVx
         y2HwfuQuKK2Jdk+eI7rUMJmBOvjByx8eHaeQ7Yz7l+VG9G5ehwFTGzLo7UONo8un21cZ
         dtqDeu9PiKMjgHGwadY9W5Y7xNj/RrnAXbaxqszRtQhFd4YkG+ydcBW0gCspAnj1GahJ
         Pr2paheFdtMpyhoPHTtfiS1fRwx/HktsdZ0iMq6FfPVA6/hZ2aUz3wRLLbuTLumW3qvF
         lzoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QKiii7sRDy26WbbBkMrjLHRLhE58fHpx4qsa98Lw9do=;
        fh=/EG8amGD1d+gr6QppXnIZF3SR4Iiq8qGNn2D1QrGzIY=;
        b=IB9Mj/8pQzUPuNke4poIaLk8S4gcnr2hT86QvVnRRj3kNAoPc+PAK/VCaYISu+zGYS
         J056BrGTPcfylGnXRe19IGk8UqyQ6j3KSVETSviIPcrk5r2jKc/r5HQpsrG63yCzRgJG
         Ay7Oak/5+zuqD1TtCk5Qke8QKH5DLdhH4+cUR2PAnVJfjYPC3KEEt6FLufxLgICs+2PZ
         jbwOEU80f66LKGuV4BxXabhMHLuJvbE1hdxOUVHkhjbKu+yYZaS+cZ3Wz45Bgyv+mItf
         xvo+Y9ykQuoACxy9ejCAJyw5sY+x+0VOxMqfjbWfjcpmW1VucZ47ob1HlvWptvOeDk/c
         dWUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782477219; x=1783082019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QKiii7sRDy26WbbBkMrjLHRLhE58fHpx4qsa98Lw9do=;
        b=rMRBKVGVv/UosuGLh1FiIYgG3JKDZBqfkfqhWqinA9npJNxe1jjlBiJQepJHrePHN8
         3Fd+sHHDAJzhIaLSOGdz1/YABmuqN2fapZn6h2VljdLwNJY8WabbkM80AZDLR5PiHPW9
         qcLxlKYD6fbArE898xjVP8k7KKXXoo1xTjTxwZraTqxtRs4pgCGfBo/h1gsYdph3PC7b
         8xt+lTZjxiEg2TdDcqVWyKv0LZn5jUtZ2YXROeV3CmZz+ubt0+kq9iP2UPalSY4p3u3p
         albUMQdewklduLalORjPUYh5Za30vqQ1BfRltRB1zx5jEJaWXQW7zDicLFQrIMNskitv
         tvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782477219; x=1783082019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QKiii7sRDy26WbbBkMrjLHRLhE58fHpx4qsa98Lw9do=;
        b=UZHv8AugagZU82SKH9Uu9JcmYK0Nti2r6m/uf+G4tu2ryALN3CAC1cNS9BvgDqTzor
         UGtXyHDnOAqBQMwvbmGjUSM1APnN4pP9epuiUltUHHECpWEvIo56HC5pLyqLEyulcfBe
         kOQ/29w6AGRUH1wVJGm2OofXBt189Rau+pbFqDngfHEdk0LnIPU3deGZfHBlR2rs1dOy
         X7d2oc2UEGU8C5/O8er6Yr1jrm05k/DYcqje6sLn/Rf/iRRSr0mckmzNqpWFHVYRXUtb
         +k5l9rTJBV1/rzln76TFfn/cN6vUX73QMU6tFuzJVK5pE2dK4LM0Tw02e59LZSQC9j3X
         WETg==
X-Forwarded-Encrypted: i=1; AFNElJ+x3kptflvmcfNMhlAtkHkMlDV3/Wcgzacjml1jvIi18p5CwfoddQH+LyWXxVYyJHZlqxKwGx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjuYEzyDh7WRUb2BwSBB4+dnKo4zjHzctmfRd6XStYE0eGEOJ5
	eeQnc2ktRdgylaSgStDNDZhsepSmY4yDd3fV/JmGU6F7IeZEfMHnLqM+BJ0fgoo52QnPyZyq8EK
	v30ohhUNwoCdQxAEfiFWNyGU1p7arBd7drA==
X-Gm-Gg: AfdE7cmFse/9l6TRP/YKtiYcr5M8SpCVt153pCQ3LpOdbbmtM8shv/M/U+BTR4ie+u7
	luQiVNi9QZ5D9CDOMdj6DraYccr5qFhzEzwLlYaOdpUASJop8p6kWsMJUItuu9DnAXr8gP/ObjK
	DBb4pTgHHip6WL2sY1VFKfciCEt9zrTSLK4FmyP01HpPk+qkUBQ1BABJwKMgy/59gy5OqImowRN
	+9laklexnB0LP102F9K3UEQ6f1UyJktxWS/RYgwuWt5e09x19gvsdfzT7nghzVzTvDykI5R
X-Received: by 2002:a05:6a20:72a2:b0:3bf:6c07:b2ec with SMTP id
 adf61e73a8af0-3bf6c07b6cbmr170450637.47.1782477218795; Fri, 26 Jun 2026
 05:33:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625235336.3641828-1-tristmd@gmail.com>
In-Reply-To: <20260625235336.3641828-1-tristmd@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 26 Jun 2026 08:33:27 -0400
X-Gm-Features: AVVi8Ccp1iuAyE48UTPXyK784Xo-U5147VxNhSAxuBmnkYfUtw53ymAHJ6hbU2g
Message-ID: <CAEjxPJ6pneeDyPT6-OL+0S6J4SZwM4XQzSn2zK8JwmNnwNqjCA@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: avoid sk_socket dereference in selinux_sctp_bind_connect()
To: Tristan Madani <tristmd@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Richard Haines <richard_c_haines@btinternet.com>, selinux@vger.kernel.org, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tristan@talencesecurity.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 7:53=E2=80=AFPM Tristan Madani <tristmd@gmail.com> =
wrote:
>
> From: Tristan Madani <tristan@talencesecurity.com>
>
> selinux_sctp_bind_connect() dereferences sk->sk_socket to pass a
> struct socket * to selinux_socket_bind() and
> selinux_socket_connect_helper().  However, when the hook is invoked
> from the ASCONF softirq path (sctp_process_asconf), there is no file
> reference guaranteeing that sk->sk_socket is non-NULL.  The setsockopt
> callers (bindx, connectx, set_primary, sendmsg connect) hold a file
> reference and are not affected.
>
> Both selinux_socket_bind() and selinux_socket_connect_helper()
> immediately resolve sock->sk, never using the struct socket * for
> anything else.  Refactor the inner logic into helpers that take a
> struct sock * directly so that selinux_sctp_bind_connect() never needs
> to touch sk->sk_socket at all.
>
> Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Fixes: d452930fd3b9 ("selinux: Add SCTP support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
> Changes in v3:
>   - Keep comment describing IPv4/IPv6 address processing loop
>     (Stephen Smalley).
>
> Changes in v2:
>   - Refactor selinux_socket_bind() and selinux_socket_connect_helper()
>     into sk-based inner helpers instead of adding a NULL check on
>     sk->sk_socket (Stephen Smalley).
>
>  security/selinux/hooks.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index fc926d3..1f202f6 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4689,9 +4689,8 @@ static int selinux_socket_socketpair(struct socket =
*socka,
>     Need to determine whether we should perform a name_bind
>     permission check between the socket and the port number. */
>
> -static int selinux_socket_bind(struct socket *sock, struct sockaddr *add=
ress, int addrlen)
> +static int __selinux_socket_bind(struct sock *sk, struct sockaddr *addre=
ss, int addrlen)
>  {
> -       struct sock *sk =3D sock->sk;
>         struct sk_security_struct *sksec =3D selinux_sock(sk);
>         u16 family;
>         int err;
> @@ -4825,13 +4824,17 @@ err_af:
>         return -EAFNOSUPPORT;
>  }
>
> +static int selinux_socket_bind(struct socket *sock, struct sockaddr *add=
ress, int addrlen)
> +{
> +       return __selinux_socket_bind(sock->sk, address, addrlen);
> +}
> +
>  /* This supports connect(2) and SCTP connect services such as sctp_conne=
ctx(3)
>   * and sctp_sendmsg(3) as described in Documentation/security/SCTP.rst
>   */
> -static int selinux_socket_connect_helper(struct socket *sock,
> +static int selinux_socket_connect_helper(struct sock *sk,
>                                          struct sockaddr *address, int ad=
drlen)
>  {
> -       struct sock *sk =3D sock->sk;
>         struct sk_security_struct *sksec =3D selinux_sock(sk);
>         int err;
>
> @@ -4924,7 +4927,7 @@ static int selinux_socket_connect(struct socket *so=
ck,
>         int err;
>         struct sock *sk =3D sock->sk;
>
> -       err =3D selinux_socket_connect_helper(sock, address, addrlen);
> +       err =3D selinux_socket_connect_helper(sk, address, addrlen);
>         if (err)
>                 return err;
>
> @@ -5409,13 +5412,11 @@ static int selinux_sctp_bind_connect(struct sock =
*sk, int optname,
>         int len, err =3D 0, walk_size =3D 0;
>         void *addr_buf;
>         struct sockaddr *addr;
> -       struct socket *sock;
>
>         if (!selinux_policycap_extsockclass())
>                 return 0;
>
>         /* Process one or more addresses that may be IPv4 or IPv6 */
> -       sock =3D sk->sk_socket;
>         addr_buf =3D address;
>
>         while (walk_size < addrlen) {
> @@ -5444,14 +5445,14 @@ static int selinux_sctp_bind_connect(struct sock =
*sk, int optname,
>                 case SCTP_PRIMARY_ADDR:
>                 case SCTP_SET_PEER_PRIMARY_ADDR:
>                 case SCTP_SOCKOPT_BINDX_ADD:
> -                       err =3D selinux_socket_bind(sock, addr, len);
> +                       err =3D __selinux_socket_bind(sk, addr, len);
>                         break;
>                 /* Connect checks */
>                 case SCTP_SOCKOPT_CONNECTX:
>                 case SCTP_PARAM_SET_PRIMARY:
>                 case SCTP_PARAM_ADD_IP:
>                 case SCTP_SENDMSG_CONNECT:
> -                       err =3D selinux_socket_connect_helper(sock, addr,=
 len);
> +                       err =3D selinux_socket_connect_helper(sk, addr, l=
en);
>                         if (err)
>                                 return err;
>
> --
> 2.47.3
>
