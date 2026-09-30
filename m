Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com [74.125.228.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C892D415B6C
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 20:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790800232; cv=pass; b=SaGp0VJSyuIF9vK9IP+APctiu+jUJs8GJ79HNalRls2l8QeSdOwnlwh75RsjiSVhb2nrERfD6qtPLpqutFzQ9C2uo7S9KZn267mGvfUHkft7AiGwCCS0kPbXJ7TzPYxzhKrDv03ORxYsHUo05jZADS7WqK6vpSf9VMrMFI2JEGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790800232; c=relaxed/simple;
	bh=G8k5XV1SWWAdy+RGfAj3dXa4DNUX8KUBtzKy/T8o1zs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jtZnDZmAlzcP7RXTJr3O6r70SijGP58G5m4NhcbaNASI88Wy0ZmQq7AHhSszcwnixWLLWEeHefkafkB0IldF4SDO4blaKyoV1XnDgQUebr/wAOV7THzca6sYmxtXGvv+UzigDPEpbUOtbdfP3QsgFs7nIH15C0zbBEFooQQHvmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H18oGY2r; arc=pass smtp.client-ip=74.125.228.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H18oGY2r"
Received: by mail-pz2-f37.google.com with SMTP id d2e1a72fcca58-888148d08d3so120413b3a.0
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 13:30:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790800230; cv=none;
        d=google.com; s=arc-20260327;
        b=VgeoLOyXZIS5Kvb0J/KKDRr5HIg6bU4ccTQFFZA/W1AcBHSVkF65fsx2jPU5StA1kn
         hVfQvGBC59psAuZoaWSHBmuCfCv5jIynZYBwZcg32aUForR1RJinOzHiD/eKb76qa2TW
         S6PMpFIf+VGNS1gGHpKhzN1F0zeSQIIjBgGV/UQF0y5WscjYrMA4RnDBStCltM89i217
         uYgwQDBtQRmZkm8/tUsbKav+ZjPbPur+8wEXYQsAtDoar/Kc8mRDwf3yB1UhHYWFP4Tt
         xgGQabIf9HYEd8MkNYkUoVWF9C/43pW6IgtRQvLWEOaAXEJYHMA5Yo0AuNo1q1FwkmLt
         WYQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CjbSFyqOnw6JPYqmCBCI/LQ67eLhGfYCrMua/TXCkJg=;
        fh=EGRQX4DIYrK3j69KKUL0a34TCaCAKg8cjEQH1TcaHyk=;
        b=YW6EbJTCCzcevM5cewM5fteKNmiNaNUgz2MCkT22xC/FOK2iADah7rEu9JGQBZBlQm
         XSNSy+K9JsKiYAzd9o82cWkCvLOqO9gl2ddI0+NR/oIwvHARvdw5iHPNBeje2HQ+rBFI
         TlQU3ZhTp/jB0WHkNfn0QNBjYP5e1/Day/2nA5XorRnkuQaf2AN6v9/2hnBaud/KDWQx
         zmJFk6jbkkvtGStKIE30+WA2PmyuRgS0l9beoRP3z6+z2kWJErASwR/dqLfo9gF+Tpg6
         DKnBY4dx0hlMywlV9iIDv9MsDj/IeL88HzY9bo1jQmFkjSxbz4YjBLJpkLdsk1muLIPW
         Bjwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790800230; x=1791405030; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CjbSFyqOnw6JPYqmCBCI/LQ67eLhGfYCrMua/TXCkJg=;
        b=H18oGY2rxPaodBLCo9ETzXF3R2XFiNFXK98UaHZfb0IKrJYX1zkxKMjVHJbQg+emd6
         0YJf442E3GigFVZMI3MT5D34zVNRRsUpWo9B7KNi017F2dYP1e/QnKfWiG9AGLeYf8sZ
         zIIGb6CfQ5FsYiXdPCy1K0JLK9rsZWrx3t0sPE7Tyc7Bjps3I7aSCjBaYhyMCMMQs58f
         j/xST5BdqXp5kghHqS9xwPZp8V5CsUD7lJzq3mzA7xK1oQ+FpVmo326jqhgCMeyWpprM
         ErgnI81MOLSaiZ/OvEI0hg6TrLLK1jG+3dlb/XQJiz6pzyvRnLrk6kl5wUNukTyApxkP
         r5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790800230; x=1791405030;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CjbSFyqOnw6JPYqmCBCI/LQ67eLhGfYCrMua/TXCkJg=;
        b=RqecXw+iXlgY2y/EI1PxASAf5+Yegc55fbJJ/gVKuWyrZdmlKeHQcm66lS2yxZJRO9
         W02LuRdBRof4nqLApF6PQyYlN6zJwvcVmsfRcj9oMWfVPv5bMtbkPboFjc+Jpu0bhxH8
         pfQmsvpEihlIpl1Bq9GuUkGPkWov5q0ckd+Js0faWvUT0sRUW56yBceaLeHKK+3jePaf
         1MHqKkHJUfRpWFRZNZhLO/rFeHtgxoyS7+ooK4G9e5GRKkx7hShqY3AwvZQDxWscPGk5
         LisA5empAL92nx88/GJ6H0kmYsXbfKdoyjQ+sdWHdlqLbwThCaeI/PGGwbIQA+BfFbe/
         1oMg==
X-Forwarded-Encrypted: i=1; AKwUvBzPqHdq2ks7Zxo6vJ0BbWzhPWIgWNbt6wbiVYFAnnxYqM1mp+0rt0qTAyziofOl7iY+4wwIiec=@vger.kernel.org
X-Gm-Message-State: AFuF++lsBXtzWqEioecHmBtooA28rXUt2SZ6hs6rbasXwAwHI0kzpD1E
	dU2PXtWnQJ8zk4zU8Cto1RBtYB9dY+9tuUmC3NrEz+hj2DWpaKPUhjefjVQ7EiBdmmv7LwzdbOS
	QT6/7dAHuRMkOhTVVuBmePZAoiWAUMrw=
X-Gm-Gg: AYBFou2pBX/wmXgQ48r1biJ3Tf8MU+dEgazHRM7ZkA6tCjR+TvSNM3oqmwcJ7Xz1i1L
	heYYCwyMLCGlSNeCC0Vq4CQMvYSS59wmo5VTJTYglmKpDddej6oOZztV0v6K3+bEp9GJMWGuhPY
	vs0Hh0SRb250jlbOUXW7fu/7ICg7JMrZLJzS7Un1lbBbH9M1CYWrQpty5pXV6Gs9GDD24dhUIbs
	hzBH9LySbaCFqx71BNH8ogTh0fW+s7dg2smZOCSTfmHMpnjLI9vTOm1F2twHzCG6Gd0gts0cXR8
	bcivNN1aQs7UaMF3WTmTTNNkus95sL9VgBn2WAhPvPIPJHF4sDRhV4g7Y3hIsMk6j96Q/upWcQE
	/zyCc/or3Qspo8vXFGh39g/wpLQka+CakRiS4cStbNrLhdLYOO61r1F5qV3M0ntWb
X-Received: by 2002:a05:6a00:14c2:b0:880:8fe8:a3ea with SMTP id
 d2e1a72fcca58-8874be0d724mr2061194b3a.45.1790800230179; Wed, 30 Sep 2026
 13:30:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260926095606.68601-1-juny24602@gmail.com>
In-Reply-To: <20260926095606.68601-1-juny24602@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 30 Sep 2026 16:30:18 -0400
X-Gm-Features: AclHuK_OSjgLkfBVMNxA26PGQ3HWO34j9O67roB4yluK7AQb7eV-UK8ZIUS6bCo
Message-ID: <CADvbK_fU6+=ea87yFXk5HxT4-MQLuejH38Bq4wruP+2KfqY-vw@mail.gmail.com>
Subject: Re: [PATCH net v3] sctp: check RCV_SHUTDOWN after the sendmsg connect wait
To: Jun Yang <juny24602@gmail.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	Jun Yang <junvyyang@tencent.com>, stable@vger.kernel.org, 
	TencentOS Corvus AI <corvus@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 26, 2026 at 5:56=E2=80=AFAM Jun Yang <juny24602@gmail.com> wrot=
e:
>
> From: Jun Yang <junvyyang@tencent.com>
>
> sctp_wait_for_connect() drops the socket lock while it sleeps. An
> out-of-the-blue ABORT can then be processed from the socket backlog and
> unlink the association. If a concurrent shutdown(fd, SHUT_RD) sets
> RCV_SHUTDOWN, the waiter breaks with err =3D=3D 0 before checking
> asoc->base.dead. Its final sctp_association_put() can then free the
> association, leaving sctp_sendmsg_to_asoc() to continue with a dangling
> pointer.
>
> Check RCV_SHUTDOWN along with the wait error in sctp_sendmsg_to_asoc()
> before using the association again. The check only accesses the socket,
> so it needs no additional association reference. Return the existing
> -ESRCH so that sctp_sendmsg() skips freeing a new association that may
> already have been destroyed.
>
> Keep sctp_wait_for_connect() unchanged to preserve its behavior for the
> connect() caller.
>
> Fixes: 668c9beb9020 ("sctp: implement assign_number for sctp_stream_inter=
leave")
> Cc: stable@vger.kernel.org
> Reported-by: TencentOS Corvus AI <corvus@tencent.com>
> Assisted-by: tencentos-corvus-ai:hy4-preview
> Signed-off-by: Jun Yang <junvyyang@tencent.com>
> ---
> v3:
> - Check RCV_SHUTDOWN after the sendmsg connect wait, as suggested by
>   Xin Long, instead of taking an extra association reference and checking
>   asoc->base.dead.
> - Keep the shared wait helper unchanged and retain the -ESRCH error path.
> - Link to v2: https://lore.kernel.org/all/20260911090039.75646-1-juny2460=
2@gmail.com/
> - Review: https://lore.kernel.org/all/CADvbK_f=3DS-2waid_92PbOCh-LWjU5oiZ=
T+__xWfttVeTHEPQTg@mail.gmail.com/
>
> v2:
> - Leave sctp_wait_for_connect() unchanged to preserve connect() semantics=
.
> - Hold and validate the association in the sendmsg-only caller.
>
>  net/sctp/socket.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> index c7b9e325ec1c..4652fd90d9a6 100644
> --- a/net/sctp/socket.c
> +++ b/net/sctp/socket.c
> @@ -1844,7 +1844,7 @@ static int sctp_sendmsg_to_asoc(struct sctp_associa=
tion *asoc,
>                 if (asoc->ep->intl_enable) {
>                         timeo =3D sock_sndtimeo(sk, 0);
>                         err =3D sctp_wait_for_connect(asoc, &timeo);
> -                       if (err) {
> +                       if (err || sk->sk_shutdown & RCV_SHUTDOWN) {
>                                 err =3D -ESRCH;
>                                 goto err;
>                         }
> --
> 2.54.0 (Apple Git-157)

Acked-by: Xin Long <lucien.xin@gmail.com>
