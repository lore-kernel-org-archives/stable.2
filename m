Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792896713;
	b=A2GFbUaDXxmk2XmHwU8UyO4aaKCFP0Ewles7WkazJd2Olix5aQd9B5QJkr/YkCvo0kFX
	 MhGPlCtt+YSV3NMZrgYOf2+WFyWbXMJga5aD61ebDsyYVCJ6DfgFz7FEzoa2iNaNGLaAF
	 rbns6wcMfy6D+thanmXnx9bEiFgn7shJViR5YzJYDfK0hlJV8Sz5u0Qf2euRSrAWOPQ/e
	 8wZayssco7HKvUUNiKbHPahkELmZNbsIcYpAutCCUDVQOUcjysgH1PDnJU/9n1Cbj7QXj
	 LAd2enuHyW9D0jh+6vAxV2FSLep7O6g6HilPlR3GcQnUiF1gBA0ltH1dvVC/bzBYbsw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792896713;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=FU5RTsamiHXtFoFdGVctPWi31ZfViWT4/lAqub7SSi4=;
	b=5iKjJfGt6LmQeiXhB7YhyUcL4lXk2Px+kqcHNfCb2em0mQ8vrXxpSA7CYNMb4REHSAVp
	 lMXwh45UhjpE0ttx/HXrX2a/6mc2LqUujimK+g9XtHOcsodLbAPFSQTstnVCtB6Ccj1pW
	 QHiO8vDdQw7T06QhaKYUPIE4lJPYaqvRHIpZ0+0ZgZwW/qKhehU/Cp4s4ZLzz9OU0awS4
	 Xq21w1ytyJgEJycTSJ07utsvj6oHKy8pFctyWm2sXgA6Qw+kqldPKzeS8F+uccGl3Iqav
	 lmUPXctzGUdlc+9h+SrrmTwfNLvUIfuGdsmqmr45mA05m4dgKCIB6iHUJ8/wZCvHMKg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aTtfRWF7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.44
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D4C606A31D
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 02:51:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35D4C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aTtfRWF7
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5be416e603cso1107816e87.2
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 19:51:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792896711; cv=none;
        d=google.com; s=arc-20260327;
        b=n49WFG8C0RVXKHa0Wl057IVOLB5jAZcEvzcrYl2Mdrd/DOhMal0RFtBlvc+1goLo+m
         Po8kNKGOX/Nhav2NBY+p6nLii31S34ZTVfE8OVTXVf+1Kr3WQctg/AP5DSAfZpIQQrgS
         DYGAyx6AiYmzX5/6s1fVshHNHcPH0elFSo35s1CaFHihYPkQ+q0cpsT5ap1zbSIa3Kpy
         IQkn91edcoC5O3fUNk7P0gad6rk9NHiLuF11a0NxODGkSH8WEe1m1MUUV6EWgG85aKxc
         FD15z42S/b8bpNEuvXv7J0QgPU59niGa0pa+jlSqPvdaYktgfWJggF7eP7idgndV3rDP
         0yKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FU5RTsamiHXtFoFdGVctPWi31ZfViWT4/lAqub7SSi4=;
        fh=mspBVrouOJ8stFmpN41VYaKZr3zoQHMfvA0TGZ87vGU=;
        b=pkb/CKWivJwkwv4tVcaSTSzHnKfi4Y155aSv9UNpHmt32FDKtFP46Yqyo+9hQtATRb
         A6jkZhGNnjtjJgM27SXv3iOSSEZjfla+V3yu2E8VCMpXr+gnSP3J8TqNfrqqJrS1/Bgt
         sNfQHmR3H0E/GznAl98HnMzNvHNp6uBcIiZwtZWL7iXuzW619waXk2AHHg+hnRIeaA37
         PxmylbSYjn2RHzkw9wXlioOmjTC2VOn4v2m3IJZPlM/O86J3WDu5zlfq92ke5s7GJ/21
         aEQolLVHhRyZhSJl7h9y8ylFMZji+vDwMBopM/dvc7Vw7efwWZdqBIKvcpR9GgHc27CD
         a4hg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792896711; x=1793501511; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FU5RTsamiHXtFoFdGVctPWi31ZfViWT4/lAqub7SSi4=;
        b=aTtfRWF7LQ4aK7mY7nYUpzL3kyQ6x7PsBZmvPrbianfoppIvuf0nfUQKIpNnpVKJ1s
         MpAAKClCDQ0ycO8erRcVLScqW7Xnx9gmwbimL69V5ZlKrdetpWfYxJ0tHpHAlB8i4gSO
         8ulg2HkHqkZRnHit0VKY1gmWFyplDc6TZHpAgP5btHf2fYtDBQjsO8ajz00B9Yh8hBT+
         er/+xI/iSMvlfdZrhUF2NLOz3Jno6+jX7o9ZZKLskp/x5q4pUyNJ9eWFwmohXeWDxdzQ
         xWT3yv7UFlCgIazWEP23ahkjiPvGh0HVvXZuLLpookcU4mz6FkGhJlZ4v0U4h+sKgo5+
         P1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792896711; x=1793501511;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FU5RTsamiHXtFoFdGVctPWi31ZfViWT4/lAqub7SSi4=;
        b=TNwsSv5aj7Vc64uFuFaldEedP5jnnSK4tVMwaGiyoC37Oor4klfKco/86/zG8V7Q5H
         yZQhM7H1aJWPkvtzpJAMDV5mUo178gC0Q1AvwyPaiuIZOUDQ+rYT047mz8/Tuaknf7Ve
         HjORailNXKzgWa/uhjGrXxf9T48YLLMxFM8KFcNHfSaprg1OOGMciTfzNombkL4sln6g
         9BrU1RB51xKqSNiFaUD5z4QswpeEgcsTfvSYbcsIDKLoSoYuC1IBnvcWBrDeOKXwcCzn
         +JP1mtKeYb/tuMClKH0XeJptEEONTyr6oLFXHxi4GCQ3vqajdb4cOTNWmRJN65dFSCqK
         PYwA==
X-Forwarded-Encrypted: i=1; AKwUvBzSm3SSPAHGBLAQ8tUg72epGiBMNTXKsHp32A5mIKHx06s/2wT3Tufo3DUFVM0vREsG/Up04No=@vger.kernel.org
X-Gm-Message-State: AFq9FYJML3+pD+LgEM74XDj5Xh+yi1ns+62lJ7EcAc3oAiffzhwLGi30
	yOpwtWdWjebBIDEFqslZ/wtTHEuxpHPKr9izm8xN64pfIkc985zUWUQTYY+cl9vX5nmIj7BWCW0
	N5tfJRNeWnBlDj9bUqvWx8c0M++Jzvtk=
X-Gm-Gg: AYBFou3GRn65Gr8Hbc1hTNzsShToZ4gkB+D51+qe+g2R2IlNyk8xgot3misgtK/Ktth
	/TT82jWypaWUH7Fl5XKL2GApl+BQT9UXb12+6u6lFDpvIbowwOoKipttfad/e32qoGCIp/55DF2
	WmLT0q5n9+oOvqpduh8oU4/SjCTU97Wau9A7Bpw95tklXGHY42/CpQX2MYnLeuZkRz8xNohZZcR
	AokCrYFDDEt5/3z3UAftbxN94pqNtDFWHcgasWn0E13FGTaApLaiGE+lYBDF+uoXXeL3YdNPBd5
	KaqR5IQ/fRtwO57hR7eKoc8UDFWs0YouQvRxFjV6025xAFoTXurIKo93cxSoDVSVCQtvuYn73gk
	pH3B1p1GQC6q2pknx9xPfqd1X+92SQaavdhY6fRdD7Wnp6KsE2E0a4EbrDsq69uzhamSN7HfNw/
	TPYEZoPVDUzm6tH43aDZC795DXWinaKoDT4qPXxoj9aqWZGOuXA0z8
X-Received: by 2002:a05:6512:2345:b0:5be:4386:8072 with SMTP id
 2adb3069b0e04-5bfb71efc33mr1010116e87.56.1792896711058; Sat, 24 Oct 2026
 19:51:51 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024091256.17918-1-testwrzwrz@gmail.com> <20261024141157.59301-1-testwrzwrz@gmail.com>
 <20261024141157.59301-2-testwrzwrz@gmail.com>
In-Reply-To: <20261024141157.59301-2-testwrzwrz@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 25 Oct 2026 10:51:12 +0800
X-Gm-Features: AclHuK8kPBK2Oi4nOLhCm4MhUs2zF2fhZ4bu5005K1BW9G6XUx9rptsm45CJV3A
Message-ID: <CAL+tcoBQHudeQC+B0J0mwqbh1CH82XQWfQrtyXqVMF3ybopr3w@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] xsk: defer software checksum until the skb is complete
To: Rongzheng Wang <testwrzwrz@gmail.com>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, stable@vger.kernel.org, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 24, 2026 at 10:12=E2=80=AFPM Rongzheng Wang <testwrzwrz@gmail.c=
om> wrote:
>
> When XDP_UMEM_TX_SW_CSUM is used with multi-buffer TX, xsk_skb_metadata()
> calls skb_checksum_help() while only the first descriptor has been added =
to
> the skb. The checksum therefore covers just the first fragment, and
> skb_checksum_help() sets ip_summed to CHECKSUM_NONE, so the remaining
> fragments are never included in the checksum.
>
> Move the software checksum calculation to the point where the last
> descriptor has been added to the skb.
>
> On a checksum failure the packet is now dropped instead of being returned
> to the application for a retry. This path is not reachable with the
> existing metadata validation, but the behavior change is intentional.
>
> Fixes: 11614723af26 ("xsk: Add option to calculate TX checksum in SW")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rongzheng Wang <testwrzwrz@gmail.com>

Please do not post patches within 24 hours; we need more time for
other maintainers to give feedback, especially for weekend.

Do not reply to the old version patch if you're trying to submit a new one.

You didn't respond to my questions. At least, discussions there are
obviously welcome and needed.

Thanks,
Jason

> ---
>  net/xdp/xsk.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 33475b180ea6..65be2a368325 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -1011,14 +1011,6 @@ static int xsk_skb_metadata(struct sk_buff *skb, v=
oid *buffer,
>                 skb->csum_start =3D hr + csum_start;
>                 skb->csum_offset =3D csum_offset;
>                 skb->ip_summed =3D CHECKSUM_PARTIAL;
> -
> -               if (unlikely(pool->tx_sw_csum)) {
> -                       int err;
> -
> -                       err =3D skb_checksum_help(skb);
> -                       if (err)
> -                               return err;
> -               }
>         }
>
>         if (flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
> @@ -1030,6 +1022,14 @@ static int xsk_skb_metadata(struct sk_buff *skb, v=
oid *buffer,
>         return 0;
>  }
>
> +static int xsk_skb_sw_csum(struct sk_buff *skb, struct xsk_buff_pool *po=
ol)
> +{
> +       if (!pool->tx_sw_csum || skb->ip_summed !=3D CHECKSUM_PARTIAL)
> +               return 0;
> +
> +       return skb_checksum_help(skb);
> +}
> +
>  static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
>                                               struct xdp_desc *desc)
>  {
> @@ -1275,6 +1275,12 @@ static int __xsk_generic_xmit(struct sock *sk)
>                 if (xp_mb_desc(&desc)) {
>                         xs->skb =3D skb;
>                         continue;
> +               } else {
> +                       err =3D xsk_skb_sw_csum(skb, xs->pool);
> +                       if (unlikely(err)) {
> +                               xsk_drop_skb(skb);
> +                               goto out;
> +                       }
>                 }
>
>                 err =3D __dev_direct_xmit(skb, xs->queue_id);
> --
> 2.39.5 (Apple Git-154)
>
