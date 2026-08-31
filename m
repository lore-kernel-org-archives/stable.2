Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A8C519904
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 13:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788183815; cv=pass; b=aYn+eOUoWV9jJoPPYt33zR2S2S7vaEL9wooNTJ/Unbn17Q5GpVKyPnuRdfTCMk6P6PP8vihvIYLn5Az11UYkSu16ooTh7xZI9xkohwzqPPGwtxT5f0nRG7/nCs26lcx++EfuDlMja1qRu2xDfVFifKwCFNQMT85IzajCn5IttpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788183815; c=relaxed/simple;
	bh=63jl8HUhN6UU5XZEP96vbdTWi8+bDVk7ytaLginym2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LEfK5g1a09pLyzOa/jvNlS/3Q28FfdRsxa8uGqSmkyD7SQajj/nfe+/ulS1F1WYJoVmbwen8OAm0TriexljSc1lJuHYslYY9hhKMUzonVUrNsjtOkWsNdJt1n7gTIn48eZZIs6r2dzVjfG4qsTbstPdlINTPWiarbFPK3RlG+xY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fkBXdIoR; arc=pass smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkBXdIoR"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7f48c750afcso2592811a34.0
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 06:43:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788183811; cv=none;
        d=google.com; s=arc-20260327;
        b=PHCBqR995dR40nu6xeFo0OeQFhRvggjaIG7ieLIJ2cJkm9ejcIgENQP2wZVBsn6ZEm
         yXvic3P2l3L9cNIxmwpTh/tGz9R8X1loVCm3JTAKWyWLoYjiHrkS66uSWs2nr9HlJDB/
         K4vBlnr9Grul2cv5S4Wg0rTNkfsLz9N4NV4YRefEhfY/2resaEtw6Uu+/fpDky2uIYq3
         5WZa9cn62Paxcz0vx9OUzcVxtRVenbhCFZCG7AxAJ0BVmals2cQofUTgC0rGlT//AAb7
         u1lySOYdpa+0GoKbsP47uu6eXwL+dnHXAuYbfBPL/m1DKL6G0OQaKyEH435Qw88iS2D9
         KWtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b0QfUnx4HyE7jo0WaLyW7xEi+bweJvqIwr7CLSzJcWw=;
        fh=LKYN0YsddIk3iLEplxV+h/FakPIkgjLH40Srsis9ZAM=;
        b=TMPMrezCq/ERrihpUx4oTelFdO6EUCOL1fdzI6+2TodaIFNaf4Kk+BIIdHpeSGunHy
         DcthjFiJONxupPMXY+/LIsDtALebARzlUDiM6HyAEeShT5kuK1mHv2LBZoUMUKRlwwNI
         WoTis66u6ZSlvnwC1NiTATLYHrwI8iGR8aGYeUvYZFf24hpIqhQus8UdvGBfwQ85mH7e
         UnBlkgV397S9e+FYY9RLzVYPGdrkEVQDT84Ilt/EM7Wcpyt3W/P8223qWkEuEPnHIDbi
         OfKfUqPm4c+ITcGOcAeb3Zu3ap9DCJcc7QoLbwRmQo59cZ0Fz8z0jjtuRIafeME8P9ms
         5VVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788183811; x=1788788611; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b0QfUnx4HyE7jo0WaLyW7xEi+bweJvqIwr7CLSzJcWw=;
        b=fkBXdIoRuGMOn/UJZu33Wv389cQ1PW0h41SY6HK30Ky1T5nTNs4cV3SyN1qd2ToB+O
         DQBfnuMODWYBMVY3CCiEu39zYZuxPhK+tJwJWOHy8RkNOcjp0J7S0nXaQ9YQBi5h4QjR
         5/tp0sRkPrc3c0f8IHVfwa0kP5cOU+x6im0WpCII9C+ZTBPPAqX1Xsl3AZy2psWLFiRU
         PIIWBfjbzvnyuw6dzo8cm0tUPjCmsRacJT4jZuq+Mwocq5ot590rtBULIbKnCqMpfCfH
         QzOpu/RBOaeOgCkGi2L2FCVlc9qPDDTXayQQjDSlgKuZ96+EJMP7SA2OxV2wdj02Y9dC
         Fv7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788183811; x=1788788611;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b0QfUnx4HyE7jo0WaLyW7xEi+bweJvqIwr7CLSzJcWw=;
        b=Ug02gaHPvQgiWKNJVKAk3fm0pqeOrBfkLE/FsAfZzduvSmpLp2UWYwgnvpTrP7Emf/
         3z7+LQeUhqivVyU6ho5sCEAc/CRi5WU0BDHnFsIHJwP/Ih7XHRqzvGP7kfNxnFEnTTMd
         VxSGEXb3a/YxMnq135pgNbSJA9mmWkyxX8/GYHyjumMEWcTded14O4pDmFt4twFkRs3E
         8Ic1WyF7L99G3115BHFnajCUiQeqXhKeTvyXeYiEINfgQGrWlbLkyo+9r9nw8wEB3Rwf
         ZgPWlWMbL4+FZf1gqK4fi/tBW7Zt/uHe4eLzEChnqsPecxqR66AQk8Y5s9Fw20nRim2M
         vFiQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp98071Z5cALvq0swTTDQG60k4F8NGxbDxs70MDpkqpQXt0XNk/BDzi5gRKqd9Eb6DAPYZxrK8=@vger.kernel.org
X-Gm-Message-State: AFuF++lhVWvj4t/Xbl1MFD4RY6DG2aCGAPJ6Iu9ZetOj443lvIuitBVT
	SwPUiFf2NTdDWyAm4dvhzHSmqgz4gnCEFB6Ri2h1FBZlqwzlT8cARPgWZjP/O55V5JnsiCcINyw
	P6d/DXhUiKCOt0t+QLbC13l7tzqytZ0M=
X-Gm-Gg: AR+sD116624Klslpr/aO/Ik+vP0r96qh3k3f1Z+2vk7nfrupZJGGXMmGz1I2oZXZQSF
	AjbgGXTulAntfpZK6XKKbAYqrBRwdGW3V4+yE+kTJidrkz+6bZG51e2kl0C8UiDcPLYBQllRUwK
	V1mC2yCMP/oi6Z6Sg8vz9xxlt/Ou0ke6EHrnKK4rrkbeBfSu9AJMShxEEueLQcosjpYlajvTvVp
	RCKBLZbHhxM+PtE5qmbF/+JWTE0RYMJOYDpgs5MnR2SaZOcbFupwSlv8Jrc1Vzbe3ckKWQWXWjD
	eLGsxwB9Hyp0gQxPQCb+0vXJT6pHh0ycnf8ZJJSM+RzrkQ==
X-Received: by 2002:a05:6820:4d04:b0:6b1:7289:fc89 with SMTP id
 006d021491bc7-6b1c659cf28mr23023099eaf.8.1788183810774; Mon, 31 Aug 2026
 06:43:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260830201157.2084730-1-tristmd@gmail.com>
In-Reply-To: <20260830201157.2084730-1-tristmd@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 31 Aug 2026 09:43:19 -0400
X-Gm-Features: AcwNN1VfSVhKpPcrG_OTElZpCYiyfwZnm2Zyppu-GmNvyyY3F714BGjKDE1UPxs
Message-ID: <CAEjxPJ4mBLeed9hqf_miommqpLD9a=dDJ+=k0gRBSVT6DyHp-w@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: use socket SID for SCTP ASCONF permission checks
To: Tristan Madani <tristmd@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Richard Haines <richard_c_haines@btinternet.com>, selinux@vger.kernel.org, 
	stable@vger.kernel.org, Tristan Madani <tristan@talencesecurity.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 30, 2026 at 4:12=E2=80=AFPM Tristan Madani <tristmd@gmail.com> =
wrote:
>
> From: Tristan Madani <tristan@talencesecurity.com>
>
> __selinux_socket_bind() and selinux_socket_connect_helper() call
> sock_has_perm() which uses current_sid() as the AVC subject.  When
> selinux_sctp_bind_connect() is invoked from the ASCONF processing
> path (sctp_process_asconf), current refers to whichever task was
> interrupted, so the permission check evaluates an unrelated subject.
>
> Fix by extracting the sock_has_perm() call out of
> __selinux_socket_bind() and selinux_socket_connect_helper() into
> their callers.  The process-context wrappers (selinux_socket_bind,
> selinux_socket_connect) call sock_has_perm() directly.
>
> For selinux_sctp_bind_connect(), determine the caller SID based on
> the optname: SCTP_PARAM_SET_PRIMARY and SCTP_PARAM_ADD_IP are ASCONF
> chunk parameter types only passed from the softirq processing path,
> so use the socket own SID (sksec->sid), consistent with other
> softirq-context hooks such as selinux_socket_sock_rcv_skb() and
> selinux_sctp_assoc_request().  All other optnames originate from
> process-context syscalls and use current_sid().
>
> Factor out __sock_has_perm() with an explicit subject SID parameter
> so that sock_has_perm() remains unchanged for all other callers.
>
> Fixes: d452930fd3b9 ("selinux: Add SCTP support")
> Cc: stable@vger.kernel.org
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
> Changes in v2:
>   - Do not use sksec->sid unconditionally; determine the caller SID
>     based on the optname so that process-context callers (bind, connect,
>     connectx, sendmsg) still use current_sid()  [Paul Moore, Sashiko]
>   - Factor out __sock_has_perm() with an explicit SID parameter and keep
>     sock_has_perm() as a thin wrapper for all other callers
>   - Move the sock_has_perm() call out of __selinux_socket_bind() and
>     selinux_socket_connect_helper() into their respective callers
>     (selinux_socket_bind, selinux_socket_connect, selinux_sctp_bind_conne=
ct)
>  security/selinux/hooks.c | 47 ++++++++++++++++++++++++++++++----------
>  1 file changed, 35 insertions(+), 12 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 035aaf113d1da..ab9653ae06fc8 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4918,7 +4918,7 @@ static bool sock_skip_has_perm(u32 sid)
>  }
>
>
> -static int sock_has_perm(struct sock *sk, u32 perms)
> +static int __sock_has_perm(struct sock *sk, u32 sid, u32 perms)
>  {
>         struct sk_security_struct *sksec =3D selinux_sock(sk);
>         struct common_audit_data ad;
> @@ -4929,10 +4929,15 @@ static int sock_has_perm(struct sock *sk, u32 per=
ms)
>
>         ad_net_init_from_sk(&ad, &net, sk);
>
> -       return avc_has_perm(current_sid(), sksec->sid, sksec->sclass, per=
ms,
> +       return avc_has_perm(sid, sksec->sid, sksec->sclass, perms,
>                             &ad);
>  }
>
> +static int sock_has_perm(struct sock *sk, u32 perms)
> +{
> +       return __sock_has_perm(sk, current_sid(), perms);
> +}
> +
>  static int selinux_socket_create(int family, int type,
>                                  int protocol, int kern)
>  {
> @@ -5006,11 +5011,7 @@ static int __selinux_socket_bind(struct sock *sk, =
struct sockaddr *address, int
>  {
>         struct sk_security_struct *sksec =3D selinux_sock(sk);
>         u16 family;
> -       int err;
> -
> -       err =3D sock_has_perm(sk, SOCKET__BIND);
> -       if (err)
> -               goto out;
> +       int err =3D 0;
>
>         /* If PF_INET or PF_INET6, check name_bind permission for the por=
t. */
>         family =3D sk->sk_family;
> @@ -5135,6 +5136,11 @@ static int __selinux_socket_bind(struct sock *sk, =
struct sockaddr *address, int
>
>  static int selinux_socket_bind(struct socket *sock, struct sockaddr *add=
ress, int addrlen)
>  {
> +       int err;
> +
> +       err =3D sock_has_perm(sock->sk, SOCKET__BIND);
> +       if (err)
> +               return err;
>         return __selinux_socket_bind(sock->sk, address, addrlen);
>  }
>
> @@ -5145,11 +5151,8 @@ static int selinux_socket_connect_helper(struct so=
ck *sk,
>                                          struct sockaddr *address, int ad=
drlen)
>  {
>         struct sk_security_struct *sksec =3D selinux_sock(sk);
> -       int err;
> +       int err =3D 0;
>
> -       err =3D sock_has_perm(sk, SOCKET__CONNECT);
> -       if (err)
> -               return err;
>         if (addrlen < offsetofend(struct sockaddr, sa_family))
>                 return -EINVAL;
>
> @@ -5232,6 +5235,9 @@ static int selinux_socket_connect(struct socket *so=
ck,
>         int err;
>         struct sock *sk =3D sock->sk;
>
> +       err =3D sock_has_perm(sk, SOCKET__CONNECT);
> +       if (err)
> +               return err;
>         err =3D selinux_socket_connect_helper(sk, address, addrlen);
>         if (err)
>                 return err;
> @@ -5731,13 +5737,25 @@ static int selinux_sctp_bind_connect(struct sock =
*sk, int optname,
>                                      struct sockaddr *address,
>                                      int addrlen)
>  {
> +       struct sk_security_struct *sksec =3D selinux_sock(sk);
>         int len, err =3D 0, walk_size =3D 0;
>         void *addr_buf;
>         struct sockaddr *addr;
> +       u32 caller_sid;
>
>         if (!selinux_policycap_extsockclass())
>                 return 0;
>
> +       /* SCTP_PARAM_SET_PRIMARY and SCTP_PARAM_ADD_IP are ASCONF chunk
> +        * parameter types passed from sctp_process_asconf() in softirq
> +        * context where current is not meaningful. Use the socket own
> +        * SID for permission checks in that case; all other optnames
> +        * originate from process-context syscalls.
> +        */
> +       caller_sid =3D (optname =3D=3D SCTP_PARAM_SET_PRIMARY ||
> +                     optname =3D=3D SCTP_PARAM_ADD_IP) ?
> +                    sksec->sid : current_sid();
> +
>         /* Process one or more addresses that may be IPv4 or IPv6 */
>         addr_buf =3D address;
>
> @@ -5767,13 +5785,18 @@ static int selinux_sctp_bind_connect(struct sock =
*sk, int optname,
>                 case SCTP_PRIMARY_ADDR:
>                 case SCTP_SET_PEER_PRIMARY_ADDR:
>                 case SCTP_SOCKOPT_BINDX_ADD:
> -                       err =3D __selinux_socket_bind(sk, addr, len);
> +                       err =3D __sock_has_perm(sk, caller_sid, SOCKET__B=
IND);
> +                       if (!err)
> +                               err =3D __selinux_socket_bind(sk, addr, l=
en);
>                         break;
>                 /* Connect checks */
>                 case SCTP_SOCKOPT_CONNECTX:
>                 case SCTP_PARAM_SET_PRIMARY:
>                 case SCTP_PARAM_ADD_IP:
>                 case SCTP_SENDMSG_CONNECT:
> +                       err =3D __sock_has_perm(sk, caller_sid, SOCKET__C=
ONNECT);
> +                       if (err)
> +                               return err;
>                         err =3D selinux_socket_connect_helper(sk, addr, l=
en);
>                         if (err)
>                                 return err;
> --
> 2.47.3
>
