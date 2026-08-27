Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE462C0F6C
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 07:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787815159; cv=pass; b=ng81J5Lbss9eRctSGe6MZtsMQBz/z9qKuS+muhVhvuTn8HfhHHPtH9jJcvUFhDoDMhkUAEaJuojv5Gr8osuLOk5sVuOBOKYyjQshJ+48gYAJVBklfjFR4TpjCmQ/74asoijSfUwV+33lZECZrAO7DLMANBi30RKYYyCRe424hec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787815159; c=relaxed/simple;
	bh=VUasteM/1eK2m7/PtquDXotFQqnoyDt+RcdvdR9rizo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QGxMEGMXVUvMP2lxIJcWQjoZubxW5LLkBI/VKko3++fizP2h7C9LblHWUQGSmaOgcA51HpmnCkI8S/yEa2mv+U0VdpuslM7y0TCFV7KK8BnKSQY7HKflN0PIAEABMynoGgSwsFnaGXtJA9axwG+qKbo8NiT/IQapGz8BkWTHJOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VlIHKX8D; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VlIHKX8D"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-836c8bde2dcso25904947b3.0
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 00:19:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787815157; cv=none;
        d=google.com; s=arc-20260327;
        b=UMjWHAPTj629b/SdenY9BCpWlxJjKTJxprSCYlv1HS2U1HnDJXgMmPxTL2ndk0opTl
         llrNqao7zQxWgtuHGwWh7lBf96KoFMqNH4qZXdfWF7DWJKDrmbaYrVZc4aYRzo6wgy6k
         iCHvkPcqFPQZDi3o1brdlabNIyG+VGlykHfgsDQknw/hVbrfb7+4r8syvZSoPSCW73mz
         XW8lWqTAV+eb/Ssitl4tSTdY+2z/p6309gH5BhJV2mEmtJ/zwNlLuEgssHZ2gZHYrTxl
         IUU/GfAtJlCUcSke+/vJ7V5rkNa+bheFnjs4X3ww1eaHrneLy/KfZjbn2T33hn697ava
         /7sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IhU91M+LW4kUF2uW8BgolP2/H8Gx1gryC+2FQXRk+lc=;
        fh=4ZScqpivEzTyiQ9mIKRJ4VZugrYillalsqnatS73GP8=;
        b=ToyzpLGnx1iz+1Kidp9SiTbo4cuGxnEiDH+60wZ9+zdG4eJaHYg8r/9EhqJ9Btl6S9
         39gTg9eL/Tzsp1EFTlWw2p+/WDqLb7pIJppT0C5WhkLBXTSQfQe+6JWsU98yDVGFtWvO
         ffQKNVN63BzXxtIU5cqgvxsTvFfydrA8vjx+Id+LywHiQMcg9UPhhz8VjKa0NF0B/QcI
         XMHTedOZ8aG8iI05jBjYOxWFyzk1+FoXNMpIL1ERLBnHsj6OzLsKo5COv/bImB3phlG0
         FVbXidJpUw7KgGFlJ8bfPupgfoVg7U3M7jHFMRHLNfXB3xMSrW5oPaS0toaH1jui1wfg
         qEow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787815157; x=1788419957; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IhU91M+LW4kUF2uW8BgolP2/H8Gx1gryC+2FQXRk+lc=;
        b=VlIHKX8DEBHGagy/cSXdT/tzpQY4qAAQ7ZO6v64a7LsyZj90O9+jB/B26TozOXho4H
         PwRp+kTZmRJRrdZeshTNfmHHlejj0Fmq4tWZQFy1Vi4Yqqi4upSRKpNeWVDLj49HnmFS
         pereMSswrSzIEgOzdg0HiKQbymU4cBiaweYY9GzchcxzeDIhUWlOwcDbOp47dLBOr6XB
         ngtGyVyffRckXuWGZhF4UAjBHOEaMvY8qEYXHeD2MykUxQJSXReIcPSSXs0ICxq3hTvz
         x/LN3sbXaYzCaUSThN8i7+vT96ouzQ0OHxzUEL3V5si2wolI+5nMPmWd11wNCjFZNNEy
         YeuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787815157; x=1788419957;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IhU91M+LW4kUF2uW8BgolP2/H8Gx1gryC+2FQXRk+lc=;
        b=joFAvae69yDAIxsoqq8SR2Q3dUm7hctashYSOp4XXeMNGBZ5tIuazxcQhRZEXdRfjI
         a9vDVkQ8toEgkANyfxqx65nremtBLkK6+t7FgSa409Cp68XAIzUg8dPjY45+fxtU0JA+
         k4leJcDIuQveBPe1DaTqX5jkij/An0S0fw0DYUcM+wd7djAHYbeW/1ima3+efyREIJrt
         ImZVP2RQKVJUc/0jqiLptuOBJaOGYDmOSb27uWX6Fw+SCwHbaNb9++8k8e2fzTh9c4/n
         bmK20LzhJST5zhbWpBCoXeYrxJh8jaLw7yBkPEJvGQRB7KU6pBuArVUJlQxq9aE8bIHz
         fovQ==
X-Forwarded-Encrypted: i=1; AHgh+RqztfdefjMzOXFS5lj7Sh/4bbV+taOuS0p+nWi8mGEiK0P7RS3cd9+5f6KQI9ZhyZaBxwJfccw=@vger.kernel.org
X-Gm-Message-State: AFuF++l96NxLxvt2455JT14nNIK7be0TUDVrVqMKYKFE/9gzadYzGs9b
	9B7x0Ien/c+Id1g/JFuYoDSq2Ec1qVYhxRXFCs3I7DAPE/M7Y8HY/bMvgUN8T+JYEmnR/t928wL
	BybKpGzU6Y2/zFK5JrcYqfF+FCqpydq/3TWddwwuu
X-Gm-Gg: AR+sD133oJGyeg+6g2PjgO/ExXa3rsD63W/lVAvcjLLDEXZMWQi6NTpbECN2T3dr76O
	kG7V11CUiLj/nvQnJP8ia0ucGHBc8OJWswTbMHXTgQNXXCsZFozltpKQ324YIg0AhGEaeTkRmTy
	iY0cnlt4nZnm6noTdqYGKjagjBjS/IOuvNLN77xwfKTpw3Gw0AnhoZfpLwL/HnSznqicqyF4A43
	u2+x3nORdZR+kSwDGEugUPanvpVmw5Cql0zN6JJQXaC9vz6KxvX7xAY3rIIINdDidDWsSQZCtR3
	YKjp6h75vH8Pb/ZGfEdamLpUEPDDobsuQxlY0AlfeBEsmXEYIxYN9Nb4s9HI5CGv1uxNnVbwlDX
	KNToBii97fPgiojGfB30wTnutIIfw3z05UwImm0FDUIRcpbf20hRU2srIS+Pt
X-Received: by 2002:a05:690c:e288:20b0:855:f387:98c0 with SMTP id
 00721157ae682-85740497376mr45849787b3.29.1787815155156; Thu, 27 Aug 2026
 00:19:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260823142620.126424-1-shlomojune6@gmail.com> <CANn89i+5o16tSTk9MpLE24nCAn+SkMeZvHv0W=MqxnXGZDBBiQ@mail.gmail.com>
In-Reply-To: <CANn89i+5o16tSTk9MpLE24nCAn+SkMeZvHv0W=MqxnXGZDBBiQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 27 Aug 2026 09:19:03 +0200
X-Gm-Features: AcwNN1Uv5avHkko0YacIDMfyYRxac66XxxBIaWUGZOqnwIzkejhBZ_2TAAKhfiE
Message-ID: <CANn89iKck9W0KB8Sp7OFDQ+OTFJnBpy=jsmQbZ+VYhrm8yOUgw@mail.gmail.com>
Subject: Re: [PATCH net] net: skbuff: reject invalid pull bounds
To: Shihuang Liu <shlomojune6@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 23, 2026 at 4:51=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Sun, Aug 23, 2026 at 4:26=E2=80=AFPM Shihuang Liu <shlomojune6@gmail.c=
om> wrote:
> >
> > skb_maybe_pull_tail() subtracts skb_headlen(skb) from the unsigned max
> > argument and passes the result to __pskb_pull_tail() as a signed int.  =
The
> > function does not ensure that max is at least skb_headlen(skb).
> >
> > This can happen while parsing IPv6 extension headers when an skb alread=
y
> > has a linear area larger than MAX_IPV6_HDR_LEN.  Once the parser needs =
data
> > beyond the linear area, max - skb_headlen(skb) wraps and is converted t=
o a
> > negative delta.  __pskb_pull_tail() then passes that negative length to
> > skb_copy_bits(), where it can become a very large copy length.
> >
> > Reject this inconsistent bound before doing the subtraction.  In this c=
ase
> > pulling up to max cannot satisfy len because the initial check establis=
hed
> > that skb_headlen(skb) is smaller than len.
> >
> > Fixes: 1431fb31ecba ("xen-netback: fix fragment detection in checksum s=
etup")
> > Cc: stable@vger.kernel.org
> > Assisted-by: LLM
>
> > Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
> > ---
> >  net/core/skbuff.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index c82a147..33022f7 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -5838,6 +5838,9 @@ static int skb_maybe_pull_tail(struct sk_buff *sk=
b, unsigned int len,
> >         if (max > skb->len)
> >                 max =3D skb->len;
> >
> > +       if (max < skb_headlen(skb))
> > +               return -EPROTO;
> > +
>
> pw-bot: rejected
>
> Please ask your LLM not to slow down the fast path, and find a better
> fix in skb_checksum_setup_ipv6().
>
> Note how skb_checksum_setup_ip() is fine.
>
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index d4382b68d56e0b3b247868b4d29ab383cfcf7440..f77d7480594ca6a1dcce2fea7=
37e421d5ea2d38d
> 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5974,7 +5974,8 @@ static int skb_checksum_setup_ipv6(struct
> sk_buff *skb, bool recalculate)
>                         err =3D skb_maybe_pull_tail(skb,
>                                                   off +
>                                                   sizeof(struct ipv6_opt_=
hdr),
> -                                                 MAX_IPV6_HDR_LEN);
> +                                                 off +
> +                                                 sizeof(struct ipv6_opt_=
hdr));
>                         if (err < 0)
>                                 goto out;
>
> @@ -5989,7 +5990,8 @@ static int skb_checksum_setup_ipv6(struct
> sk_buff *skb, bool recalculate)
>                         err =3D skb_maybe_pull_tail(skb,
>                                                   off +
>                                                   sizeof(struct ip_auth_h=
dr),
> -                                                 MAX_IPV6_HDR_LEN);
> +                                                 off +
> +                                                 sizeof(struct ip_auth_h=
dr));
>                         if (err < 0)
>                                 goto out;
>
> @@ -6004,7 +6006,8 @@ static int skb_checksum_setup_ipv6(struct
> sk_buff *skb, bool recalculate)
>                         err =3D skb_maybe_pull_tail(skb,
>                                                   off +
>                                                   sizeof(struct frag_hdr)=
,
> -                                                 MAX_IPV6_HDR_LEN);
> +                                                 off +
> +                                                 sizeof(struct frag_hdr)=
);
>                         if (err < 0)
>                                 goto out;


Following up on this, are you planning to send a V2?

Thanks.
