Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794324709;
	b=JEN86uOKQimOyIa0eYhOiy3wffS2bSznviYKYGf5Dqi59qFYlZZQpoS306B04+fZAkdd
	 SROhXrdRjDMIswobDqsi3of3P9tmszR5kn1ucHggtKjXBWxindo8NJzdq9W5q7bcHLRuz
	 DPHH0RH0UTfDTmkXyhIbbnk2Y1wL0HYM7rOsOd4P+AiigrKEnT86p0fGhhXXzUgWpdDya
	 EKH/wmb5ERou336gHP0bwe7+CoLmz0xd8SQeM65KGpZlVBtxk/xEsnIhzzxXcfqz455to
	 jCzGb6LrECobInZEGTjfAzuYZaMvI5x1BMz6TrWAwfMK2Nlv9GWfgW2RW0rLollh8Ig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794324709;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=K1/d2NyIuCP6NUn/LZuS44tPxEN2bj+/f16ojUcHMk4=;
	b=IX/gbf+pReu6QwX+4YOinkHUMdsLQrqJSdI/t6QAIjVPQA0EhoITwj031nxTd7lK2uf6
	 IU1QJrQNhorN0mw9fEqk2etRHfoQYSXQKFnJSSpiJNUD9sKp36lH3SjqgZ6S5OssZfNe0
	 kg0WBMp7tP4Yve4LO5vV6aq/hQk3sv1jVsSgJwq0ENGm6p7uL19GFFU5z3WoSdkXzOd+P
	 F3A55T3evX5gClzvZhsBMmxOd+2sksi02+oGkX5+kRfwayhaDCVA7iX7aKnuIhTf42R8N
	 Iy2lCUkY3Gvo2Tvap4FFqVnKHQuLmYF7C0tfS6zG2si6WtvByCD/fwa4ikago7nO2vw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sOnALV4R;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.44
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D7960A261C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2D7960A261C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sOnALV4R
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-7d2dc9a7b52so1173805137.3
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 07:31:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794324708; cv=none;
        d=google.com; s=arc-20260327;
        b=MLGPNcmghtOV63bSUILxnQbyuFNFqZ9OeTdvyb6W7PLmHBazw+nkWgYdHHtiuAVdAa
         BgcsD4c+axwuYi2l8UgUPKar+BVYIby9sIAtP3gwuVKaGM9c6BB5xv7B1h5uD8VmRRuo
         je/JSM5k4e6zG5+icyt8aZfEozHgaatr6HP2THW6dWT6FNl9+oWeSCRVwQQm5azwjYgh
         K9ok3Km/X2mTn2eHY/zUxlvMrbUKzNfU9hYZI2gmze5zWYk/pfDZ/PP+UPgDtbLsGvaJ
         5fXF7LgM/OZIYYpIoTWUARY9UEo1QAfl68LhBSTg+RtPqSldh2O96Kx2y6tiMSi74mDn
         L+Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K1/d2NyIuCP6NUn/LZuS44tPxEN2bj+/f16ojUcHMk4=;
        fh=FdeKNnpxuzfT04hGzrVKNkqlDuaYecxBqsFizejV2m8=;
        b=Md6/VpwxKsRI8aTzns0nQwBEr15k9a2h/47q6wgsSUo78gjzdin9RUZWAPQBWhBU9Y
         Bz/sGzN78JWX/VgifVR6v/IhrsaB4/SqFEInecPNhBFx0x0HQdpkforYYs6X/9ipnMni
         +mxIpf3necuKHVxKaRUnnLxj5WK9GehZ9t130UABvMzTqTDe6S1vG5WOE6h4Tp6hBAhK
         IBqN68NAsTVuMXOpOnSzycfY6+A5LlcC5hDRq7eZaMjewAF99V82GJ9CE4fvXPA0P0wq
         uDJZjI3iZOeUlNYr03flc7LR7nkksoXT0XusSY2PrTpfaEYMUS2XeiWqmq8RLrMJY4wQ
         x8FQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794324708; x=1794929508; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K1/d2NyIuCP6NUn/LZuS44tPxEN2bj+/f16ojUcHMk4=;
        b=sOnALV4RabTW7TXx7rjmDTNsf5tHHAYmUXJwgfUDq5UM5W3BHjN5iBQXvAvIlZdHDT
         RunsTaxFGOmPsBVI/UWUQRUU61lGTeSOTV7Ls4oDevMfljfbDaejNb2p5o/je/oUzQVN
         ODiTECjiawd9dA5ApJKl1GPG+snrlUdzTJMDx8+vzHyuEIH8h5PdZF+FRvrol+Yj/3gJ
         vRHo4q1oHwQ11AsQGydfRlFpUdIMf33G3Tui7lBp/+FbxkDoWkLiGS2AisC+jeSvVL+J
         uMeijdhrcOXb3WUOVkGaNpFRye90vYvFGNsOPsPzp+zSZMQDurT6HH2hkHYZo/OmfCgj
         omvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794324708; x=1794929508;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K1/d2NyIuCP6NUn/LZuS44tPxEN2bj+/f16ojUcHMk4=;
        b=nG4L7HL7/ThnMU/m9w5bhvuKr092fNLSS2aYGfYik9YhUAqyv075CQNhGIpFCVLXvQ
         rXFlXPLSh8CQGj5x7v/VWsVQpxxTigyc4fV+1qEJsZ7OAGE/EQqsh2o+YX9UoWNjv5gh
         BQybG2OmPWNhyyck6CS29+8uS9h80bY0MUvIATfVBgMHjB7Rh7HyxFW7YGUvUw+dtxRx
         wiXqtCfhN8nSABgfHeqPxB9SPV/f8/KmaFOx+8XCdKsC8UgjLUKMGoEFi6Ph2Dwnxo5s
         2zUa9llZq79XqlfItw0kFKkKKRu6wByUP5ffKGdldlH7kJFgnNce/5zQiAAgFOj7Tqxn
         QNjQ==
X-Forwarded-Encrypted: i=1; AL+hErHbDnSZiDpgX+uAl63AGR9L4t+vOfdC7w3hf786cEwi+Umh9NmffL8gtitj9Yw9D/BjnWwas5M=@vger.kernel.org
X-Gm-Message-State: APuU4Z/vFUgFhfvXQYQ+hykg9BlgThsJjNaY2yy+SByfrNTFKAx1jVKz
	6WzTo70JPa9RL0pitUflE4fm+pVFGpgAX/RieKt1SAQ3wQkfYnwj8wJF482jwE4oG07+ECsBtWM
	wte46+A0ZGBUkaI9MPQ3xI90oWLWMxKM=
X-Gm-Gg: AYBFou3lX+6XHB1h0ZQj78zcqepk9/cw1D7DyrrSnOTbsL5taVC+GjnKo3G8j6+R2do
	421Ca7zuC7OsZc5d0Bzgjz8MwdG8nCo8L0hTCUCaWWwukdtvCq0FotRUnidC5w1I3grWVwFYsEg
	mHOlOGzSeCHb+vSgfPojBRck8R/28wZQw3dU+LVkM7/zby+9WIeWtFcE98xokqHfWnPjOfEAcIl
	IP8jP4CBDMk5k1fBF6CrcsEql+T4odJxO39bDREaVCPZna6342wMVF71HA+ybATQeQbxlXxh6KD
	pfnVtVZWuURL0eNsz3wdlXJw+SS/QRYjZXuitqf8wFBKgS8MJv770oMHj8hpniWGzk4TnteIwMd
	/ff57GOw7mIwblRyT/RIu3wyjX3JiP89CKyOKJU3cM8G6RS74RzFDecxvexZd1H/znOeZmtvW6d
	Iob4cWT7XuiZL4SSjMDLYigiB4p1lJVgZi8dUR8Q==
X-Received: by 2002:a05:6102:1629:b0:7a7:19aa:8a88 with SMTP id
 ada2fe7eead31-7d301c1ac50mr1147212137.35.1794324707817; Tue, 10 Nov 2026
 07:31:47 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108161149.2774119-1-bestswngs@gmail.com>
In-Reply-To: <20261108161149.2774119-1-bestswngs@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 10 Nov 2026 10:31:35 -0500
X-Gm-Features: AclHuK9iYVUMVhjgMP1YORbw_EmIVcS02-pRhlLXyvezE7vMUFhkCvMgT7r-RmU
Message-ID: <CADvbK_fGfv2k5rB1Q4Q-OwzJicXbKzs1ofW48F2prx6Z15CQZg@mail.gmail.com>
Subject: Re: [PATCH net] sctp: reset stored flag for each association
To: Weiming Shi <bestswngs@gmail.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Wei Yongjun <yjwei@cn.fujitsu.com>, 
	Michio Honda <micchie@sfc.wide.ad.jp>, YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>, 
	Xiang Mei <xmei5@asu.edu>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 8, 2026 at 11:12=E2=80=AFAM Weiming Shi <bestswngs@gmail.com> w=
rote:
>
> sctp_send_asconf_del_ip() walks every association on an endpoint. The
> stored flag records that the current association took the single-homed
> deferral path and therefore did not allocate an ASCONF chunk. It is
> currently scoped to the whole function. Once one association sets it,
> later eligible multihomed associations allocate chunks but skip
> sctp_send_asconf(), leaking each chunk and its skb.
>
> Reset stored for every association so only an association taking the
> deferral path skips transmission. In an A/B kmemleak test, the
> vulnerable kernel reported 210 leaked objects from this call path and the
> fixed kernel reported none.
>
> Cc: stable@vger.kernel.org
> Fixes: 8a07eb0a50ae ("sctp: Add ASCONF operation on the single-homed host=
")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
>  net/sctp/socket.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> index c7b9e325ec1c..ed91ceff45a9 100644
> --- a/net/sctp/socket.c
> +++ b/net/sctp/socket.c
> @@ -771,7 +771,6 @@ static int sctp_send_asconf_del_ip(struct sock       =
       *sk,
>         struct sctp_sockaddr_entry *saddr;
>         int                     i;
>         int                     retval =3D 0;
> -       int                     stored =3D 0;
>
>         chunk =3D NULL;
>         sp =3D sctp_sk(sk);
> @@ -784,6 +783,7 @@ static int sctp_send_asconf_del_ip(struct sock       =
       *sk,
>                  __func__, sk, addrs, addrcnt);
>
>         list_for_each_entry(asoc, &ep->asocs, asocs) {
> +               int stored =3D 0;
>
>                 if (!asoc->peer.asconf_capable)
>                         continue;
> --
> 2.56.0
>

Acked-by: Xin Long <lucien.xin@gmail.com>
