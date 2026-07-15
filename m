Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F21E2F8EA6
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 16:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784132156; cv=pass; b=H7/ip1T93nc82xQ2K8nwvQ3/Q7UAOv3zMHUYgfZ5KGTnbA6WVNriBztCpBPeB8tpKoIUiP6MuzFyOnQ7iB93D8z88VXm/MQ8cQh6pv7pPGwITHIx0cKt4g8Bj6mSk3cm6vfM+8tO7qvZuCuKjpck0wB2a3RiP+3rjiA0wI0Mm2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784132156; c=relaxed/simple;
	bh=FWxiQlTdycZ3hlyFTtfVocuTp0ZAD9+zUnnyMVWM3YA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SM2YM0w51SXk0aS5ZgB6kCDPyAPav/LojAtQFOS+VC+7oKWWwktwCEq62egVmezR5sZ2U8aLy0UK1fuB6JuyA3aS1a114w6s7LUVsQAfYCk6N7OK6PMTzCG3KlkgGzvzxCGsMzqE0sc23LN/Ugl8WNwQu4zPHpeNCqtLqgGigqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJkCsuZ5; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJkCsuZ5"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84830c774a0so1823337b3a.1
        for <stable@vger.kernel.org>; Wed, 15 Jul 2026 09:15:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784132153; cv=none;
        d=google.com; s=arc-20260327;
        b=d8RHeb2jMngmnYmT+Dc77/k/Z2Tdnr2f8kVj0ETBLAYAuVaSjJEhPiL0e15OW4+UAQ
         GxmmcWqH/A0f5hUbhs224L5DNJ19Ozw+F3JeAAKGcHoW+WZklIVtKnEy8IXZ9r5ugmKX
         e86I3aS+gmlyr/844Ar2nF23cUEGHQFljfL3/xqRBsYTvhjii8CAniC85dCV4Kguy3hh
         fREvwngPJ1SjvY4Y7Ds0zD0joviQUB8xQizm9o8sBxgJJWXSm/5hbyiXb5s0510srPBU
         lRshb/fNdTLmZW3swa2HlWOzyrtSz9z5/R7N5Pca3DdNyeCPPOz9pj3bjGalFpmBnBpb
         XAFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=55U5jPSUwP069w7ruvqo1At+jwtU2ebGa6t3Zfz+ez0=;
        fh=n9GKs2oSd0WRxgcLE228UerUk+TzAOfyAKYZEEPC/G4=;
        b=HDcD0+ZqSbVP0S7/MgSp9JzH3I9kqu4OLI8iiu66S5XRLrW+IPuSoYMEyiHQn7wVR1
         fltrBrN0uMiGZqOrao42l2Fe6q0kj84SMHeq1Qhm8o9Mvoz4cGErielIx4ORc7n6thJU
         dIl0KYlBM9SQ6w6TpKZOmRtGPIoRz3JsOgxxvLHrUHT/DiSSUCK/ipwsGlibqjAk2Oua
         nfLjd/vFvjSyaPTbBp8e6A2la1pNEB5WnS04B8aPv82M5OWrQh8h/s4308NA1RH717wg
         5DLuTSbYdRcyQeLwxlXY8LR29Z7TjV5by07eEM9KAntmSDok28wCqr6uuPmPDgihlvDh
         47Ug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784132153; x=1784736953; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=55U5jPSUwP069w7ruvqo1At+jwtU2ebGa6t3Zfz+ez0=;
        b=gJkCsuZ5UQVwFiaMjQHDwxGR11gsOHa8WB+CZdbI5DxcyZUWGLC2oUllK/RAyajXQz
         7Rsn3mRu3MxwEXIzjklOlkPHEuxqYmfKzl7TCp+UHNHSr49OUXtE6UBN7GerfWa5PgCg
         E0PAPA6sqPxbo/lg8ygU6bXyG06906yuoORwfzTpY6bPUc+w59QPRefinlTPCuYc1d+p
         6/2HOwYc6gcixegPEaZLsVUqUyKz6BX+VqP3q4j9wxA+YRSjlQSlwmYXnUZ8VKkXNUq6
         4xAeS7znJdgwoJMr6AA3M+kBktQSktWidp5ohAvUnR131kHyv3vRizpZ8MFUP7Zbk3ac
         pI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784132153; x=1784736953;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=55U5jPSUwP069w7ruvqo1At+jwtU2ebGa6t3Zfz+ez0=;
        b=CfrW5T9r+Gzyv07D6tODfFBHBm/XvbpQJpCLdK05QNmGOfljXFDK//Cu/04ZLIrVLl
         e3zcT8XTA031hq3MUn3MdgOtGDoj5OR6l4n0lTHYfshFJQHt8KdnuOiGF7z+ro9V9lYc
         bAUvGE2aGPOObyX5SJEndvbXxyb+Z0M9PHi2i55N7P731VDrlAYoVtIkTToqA4ENi6OZ
         9IMvlJBLdTioaAQs1b6+duiSNwujS7fDu/i5ZhDG5FsSR1bbm6A3PbwqYHW8n0mnSOuL
         XXo3L4lHFm6cM2L5eGASDBOSwZfU1Eh32/FHxfTdbmbmLqoKjaSeR5xtzTH0GGb3Kn4i
         gEPQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqz+1SMMeblVChL8VpZBjKfHnk+ob0I4CRkXsZI11Wc7mIq31F5MTiPS8P9zDDWm0qv+CQqV8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLTf5SIYJRURW3KMRbYmJUwCK8iQ4CqwRLopYS4QsJMtsGpuod
	KHwm88UhMMOGeeVcZcWSTZNL6Yt9UpKgIb1W83TUAmVqIG8TrmphPHJHMB2DrFYvTdhTd/FOF2I
	N84ZX0fZgB2QWiAi3sjAQIY2PPGu63D4=
X-Gm-Gg: AfdE7cloEedeFfdvyuHQyjlrE5890VQhfyahDFsmSpEHa0fvO9h+mAKkrQgy7/cu9Uy
	kV51GbDMBuYPZ0/jgqCSmYg8vfPBCVVEdBNjlsTkzEiyp5FOpGHBkCeQgiNO8TZJ9na24kEdhIJ
	otwDCxikycg0T4ZA2AlxsTOx9DOcDpDfTjXt1SWLDqHXiizzRmGQkPAmj7JoHoFRcUGMB/gXxXn
	+s8rL2BQlDDaCciS5ZI+Qpf1OoyY1wdB/Ks8pciJLFQYcgP0/HQvYp914H+1+lgxhJTSZ9vEcgN
	Iiri/f/foJf3CaDgpfEtTAHWLQt8S34nLGea723zAxYWuy656sz7QqgpVolCRzwxOnGsR6LL
X-Received: by 2002:a05:6a00:27a5:b0:847:99bb:b6d0 with SMTP id
 d2e1a72fcca58-848896bf0bbmr16582991b3a.15.1784132153108; Wed, 15 Jul 2026
 09:15:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715033536.64963-1-omeux327@gmail.com>
In-Reply-To: <20260715033536.64963-1-omeux327@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 15 Jul 2026 12:15:40 -0400
X-Gm-Features: AUfX_mxyqRaNfNT_XTqID_5ulkJvqsCBG2mC6ONt8peeaiBkWktmOsu9fvIkJOc
Message-ID: <CADvbK_ew0KJjY5Ya64LTFgWastL34A7LNOBFqFjJUceGS+qHCA@mail.gmail.com>
Subject: Re: [PATCH] sctp: diag: fix uninitialized stack leak via INET_DIAG_LOCALS/PEERS
To: MingXuan <omeux327@gmail.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 11:35=E2=80=AFPM MingXuan <omeux327@gmail.com> wrot=
e:
>
> inet_diag_msg_sctpladdrs_fill() copies sizeof(union sctp_addr) (28 bytes,
> the size of sockaddr_in6) from each sctp_sockaddr_entry.a into the netlin=
k
> INET_DIAG_LOCALS attribute and then only zeroes the bytes from offset 28 =
to
> sizeof(sockaddr_storage).  The same pattern is used by
> inet_diag_msg_sctpaddrs_fill() for INET_DIAG_PEERS.
>
> The IPv4 address-filling helpers sctp_v4_from_addr_param() and
> sctp_v4_from_skb() only initialize the sockaddr_in portion (16 bytes) of =
the
> union sctp_addr; the trailing 12 bytes (offset 16..27, the sockaddr_in6-o=
nly
> region) are left uninitialized.  Those bytes are propagated verbatim thro=
ugh
> sctp_add_bind_addr() (which copies sizeof(union sctp_addr)=3D28 bytes) an=
d then
> copied straight to userspace by the diag fill functions, leaking 12 bytes=
 of
> kernel stack residue per local/peer address to any process that can issue=
 a
> SOCK_DIAG_BY_FAMILY dump for IPPROTO_SCTP.
>
> Fix it by computing the actually-initialized length of the address from i=
ts
> sa_family (struct sockaddr_in for AF_INET, the whole union otherwise) and
> copying only that many bytes into an already-zeroed sockaddr_storage slot=
, so
> the uninitialized tail is never read and never reaches userspace.
>
> Fixes: 8f840e47f190cbe61a96945c13e9551048d42cef ("sctp: add the sctp_diag=
.c file")
> Cc: stable@vger.kernel.org
> Signed-off-by: MingXuan <omeux327@gmail.com>
> ---
>  net/sctp/diag.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/net/sctp/diag.c b/net/sctp/diag.c
> index d758f5c3e06e..12557e924cc2 100644
> --- a/net/sctp/diag.c
> +++ b/net/sctp/diag.c
> @@ -85,8 +85,12 @@ static int inet_diag_msg_sctpladdrs_fill(struct sk_buf=
f *skb,
>         info =3D nla_data(attr);
>         rcu_read_lock();
>         list_for_each_entry_rcu(laddr, address_list, list) {
> -               memcpy(info, &laddr->a, sizeof(laddr->a));
> -               memset(info + sizeof(laddr->a), 0, addrlen - sizeof(laddr=
->a));
> +               size_t addr_len =3D laddr->a.sa.sa_family =3D=3D AF_INET =
?
> +                                 sizeof(struct sockaddr_in) :
> +                                 sizeof(struct sockaddr_in6);
> +
> +               memset(info, 0, addrlen);
> +               memcpy(info, &laddr->a, addr_len);
>                 info +=3D addrlen;
>
>                 if (!--addrcnt)
> @@ -113,9 +117,12 @@ static int inet_diag_msg_sctpaddrs_fill(struct sk_bu=
ff *skb,
>         info =3D nla_data(attr);
>         list_for_each_entry(from, &asoc->peer.transport_addr_list,
>                             transports) {
> -               memcpy(info, &from->ipaddr, sizeof(from->ipaddr));
> -               memset(info + sizeof(from->ipaddr), 0,
> -                      addrlen - sizeof(from->ipaddr));
> +               size_t addr_len =3D from->ipaddr.sa.sa_family =3D=3D AF_I=
NET ?
> +                                 sizeof(struct sockaddr_in) :
> +                                 sizeof(struct sockaddr_in6);
> +
> +               memset(info, 0, addrlen);
> +               memcpy(info, &from->ipaddr, addr_len);
>                 info +=3D addrlen;
>         }
>
> --
> 2.50.1 (Apple Git-155)
>
Acked-by: Xin Long <lucien.xin@gmail.com>
