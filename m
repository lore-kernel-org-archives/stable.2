Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB71F3D5674
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 12:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782217322; cv=pass; b=oBCkEXei/37Qs0uLEs+m0O6VX60UBZOsEeun8CuVFR9xXz3TQQ+uRlw/AbtBlI5rtYEhrn06bptvt8zMuneEo6CoegayQKXeA4o/65gE3QQzYbWq+NUSRjGZ5nluc8yC2oiteH2UhQDqH6HGvTb4jk1ifLBZxEP2aN2vTxWIDMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782217322; c=relaxed/simple;
	bh=lrbCLEPGJTNUtD3BgZCajTRgrXSGt2/8tpvlmaF5vNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R53MlAKgZAMSf0P4dNvInfPP0dyT/RFYFnzTLOS7vIWAcX3RGIEcsz5/AEJVft4Py6TTENAoUiiNx1K8ZEuczZ4PDANHAVjo9RrLRkB7Zw9eakiYRoQWrpsDgclAvQwmHZWiyej3D8K7J31KjTQHXE6AJ+ZZrkluTISusoQ9PkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ExcaMXp4; arc=pass smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExcaMXp4"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c897468a244so2010626a12.3
        for <stable@vger.kernel.org>; Tue, 23 Jun 2026 05:22:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782217320; cv=none;
        d=google.com; s=arc-20240605;
        b=XRW2loTnGiy6CbP4PfqV2lNqHkmj4mhDJjQiBR+ZlIVfwFQXN6RZKSWOzR+hFG9uO+
         DIOotUzVJn71yuFQhetF5u4I6fOFl3mtKFbyLfTodh+TjKabTXrOYJcvddGuyGEosUqZ
         y1DCYsO0SsmEUDPRe3Y+XS+q5LRHpiYOStZv+tMH4Ku3Jmw1i+FbNqBU5z0zaeb+oWhW
         SPQ4BsnvdY4D6XO191ev1IOLe2PlTZqexqUoEdqpiQ6JLbF3X2oVdPLrNHUNTBg1sH5d
         jaz7PJrGvraBXwg5rOaiUUPQ+S4VHVl/tjLnwwKASfcUY93d8tvuwiONrexLCz+fGTZI
         sbfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uuFR3/6LFoFU0zSu0VzULNjfNKPzwppMVDxzsvPNJ6k=;
        fh=J/zApK3cExnI6ju5WN+M0h8jgJsRgS3n3L+p0cWbqrw=;
        b=bkH1wqpXH1IUIa9gavVY0rnISDeTB4Feo4B+dh+Vpk3CvVaRvX8+/0nwDRB9oK9H0g
         KpGRsEjztx9Y/YHuGyt/LGyn0v317KHwLCCABtr8Njw5Xo3PkMrIX7TBM3Az3Kg5AIrV
         uAh4AGMyJb+2cs+Mk5QEPPHcTmt46RH5x7BC9DU+2BVwp2W1cb2cIsPdThHI7lk9csGL
         sEvz2xIfhulHQp8IkxMI/fWWUpAum1A6LuQsuw3iIDmEjHeVkjAzujIi+A185gGmqDnq
         pzrsN/AahEZXwNFxgskPKoaQFz6hqxI4TfDwjnIch5+9b3vof6kfXOzEb6Xc6/4cwgVp
         FsnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782217320; x=1782822120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uuFR3/6LFoFU0zSu0VzULNjfNKPzwppMVDxzsvPNJ6k=;
        b=ExcaMXp4+0zSEUEtweofoo6ikED9yqzV80OLY11IneyxSJf5EW48TKytDO8AMcVyrO
         o/MKDKi5XEdX4pTyqvQhaBcJQhuV9pv1jOcAV5gCe0khVgcGAOaJXK1f6TioiRQcEAg6
         f016BbvXBqYSEEXfFqjKgl5WevWRicQ5eDIBsBqn85iIn2G2lPZQfClHWoCwqjrofIfe
         xTrWBlcvsHGq/0b9VoAXGlll363S/7/EstbT2XItEwWKUM2O73zs3jWrVeKlGRrGgRcG
         yTu/2dAQzCEpIxR5CIkjCZxKXLpUKzSzW5NqiqgWmiM6viiJkKIscXC+Qd43uBzXQB5s
         kwCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782217320; x=1782822120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uuFR3/6LFoFU0zSu0VzULNjfNKPzwppMVDxzsvPNJ6k=;
        b=cO6rmMJ8axn7Qul92rxkNwjVAKQWK2kNG8PUVBpZtHmUdiEenrbckv074hAaelM9kk
         AssaYCE+VJHE1T2twd96EoBMVSJy31vRzRoUYlgSPayH/eajWhbULmqnQD9k/N1DYzmx
         9f+W+GhUC2narjTai2XbCLkK1mVumgNoNbTafz1koCwAVnEev7PYDbl/xQiDyiXMEX8j
         1U3MEI7TO0X6emkc9reCbN0fHJaeS2F+2psNgzHytoeWxzpHUApT6Gttu4asNnWoW9Io
         pBNuoquQPUDeK0t7HFlLrDAr5lCIyQuU/+WeCR6DeJnBAs1xcpnGyrwL7FjIm3HXlHhy
         XmRg==
X-Forwarded-Encrypted: i=1; AFNElJ8flFuJ8MD38cLiMFRZDtfZwRImyiyCHMxkaGeAXANcqc9ugl4uyDt69I4W/vcnsuyuOlg8goc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcO0vkbfJbXpluqZSIir/LcaXrUO2cPI6lvPNJYouUC/99QHDQ
	LXU0bjrJWKWw4WJJ1S8SuBusDXKhvKH5YWooK1gNcU+L9xvWir5zW23RJukg2hl3Q2wOtarUtW7
	d71i+1Jw9IZV0DqpmvAyPTbc6vbQGv38=
X-Gm-Gg: AfdE7clA7pa9nhk6Su7vO5S7NeBlPszrjbvF/G8gLsHph0VI+aSkILSqW/Roa6yhhd1
	l0mwALhpq1mPDtP6xOfgbc6TeD6j+SVBksrpSZOQXtR7xaoA7uNwUjjE8RMyKZs6yDdibtpL18o
	do1uzA8AOfSLPCwPadV01vkY9k/+LE+2MnLs03fj9LiBWgOn/RHlwWWNUdbH7OMyZxeFZ1bbJ0Y
	9Yvip3Si0KwCOG0jrWjHGCi9AshxfvqrA7ML5tnp4CoQmR9/JoI6OBqymtb1ZluZn4845uP
X-Received: by 2002:a05:6a20:3946:b0:3b4:6a31:6d0f with SMTP id
 adf61e73a8af0-3bb34e72975mr20752819637.41.1782217319845; Tue, 23 Jun 2026
 05:21:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618232149.1780219-1-tristmd@gmail.com> <20260622210330.3187099-1-tristmd@gmail.com>
In-Reply-To: <20260622210330.3187099-1-tristmd@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 23 Jun 2026 08:21:48 -0400
X-Gm-Features: AVVi8CeIpvPNGZ0JTtt7DlppUyHKoB5i9DPzflCT466N-OeyDpTPwPP0r_SGGf0
Message-ID: <CAEjxPJ5pFjTvS5n4DMqL=bjdCKoTfSSUKRhZcHuR+99XaoGKAA@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: avoid sk_socket dereference in selinux_sctp_bind_connect()
To: Tristan Madani <tristmd@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Richard Haines <richard_c_haines@btinternet.com>, selinux@vger.kernel.org, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tristan@talencesecurity.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 5:03=E2=80=AFPM Tristan Madani <tristmd@gmail.com> =
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
> ---
> Changes in v2:
> - Refactor selinux_socket_bind() and selinux_socket_connect_helper()
>   into sk-based inner helpers instead of adding a NULL check on
>   sk->sk_socket (Stephen Smalley)
>
>  security/selinux/hooks.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 1a713d96206f..aa58a17da219 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4994,9 +4994,8 @@ static int selinux_socket_socketpair(struct socket =
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
> @@ -5126,13 +5125,17 @@ static int selinux_socket_bind(struct socket *soc=
k, struct sockaddr *address, in
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
> @@ -5221,7 +5224,7 @@ static int selinux_socket_connect(struct socket *so=
ck,
>         int err;
>         struct sock *sk =3D sock->sk;
>
> -       err =3D selinux_socket_connect_helper(sock, address, addrlen);
> +       err =3D selinux_socket_connect_helper(sk, address, addrlen);
>         if (err)
>                 return err;
>
> @@ -5706,13 +5709,10 @@ static int selinux_sctp_bind_connect(struct sock =
*sk, int optname,
>         int len, err =3D 0, walk_size =3D 0;
>         void *addr_buf;
>         struct sockaddr *addr;
> -       struct socket *sock;
>
>         if (!selinux_policycap_extsockclass())
>                 return 0;
>
> -       /* Process one or more addresses that may be IPv4 or IPv6 */
> -       sock =3D sk->sk_socket;

The comment should remain since it wasn't specific to the line of code
you are removing.

>         addr_buf =3D address;
>
>         while (walk_size < addrlen) {
> @@ -5741,14 +5741,14 @@ static int selinux_sctp_bind_connect(struct sock =
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
