Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95ADB441630
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 09:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787132644; cv=pass; b=mnbzOisaIjwAOaMA0l5dzCAQf1iV8uer3E7hZPjZL2CdP2ndNdMjfmqxXWDRbtASA/7tbAkccnzbFimFTbqCgH13P6ep30+WWPWeE5xqLb89mlDiNEDTigQ5ECrlyzKP7DLg98dhv6Zzsj7AEOmzF+gIjfmrocxnMfWvt3AKhOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787132644; c=relaxed/simple;
	bh=IBqOfiZ3jLUgpVgmicU2LGUYs4GkN0rNYwqVg/GkAqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B5iGYirK5Q0YriAaHQMOwsUqDkvHAM9QAvP8NCcBetDuOcrsqa1ySph6+2T8Z8gr5Ynv3cyxSmHQ8UJnfZtjd4s2f25XKKgzwLR1LEuLxFYGO6lt9xnAf+feRa9gu2JGmwHTx6RSLryvDs4p98J33xFuUaQmCQeLgf2Ze01G2V8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=iFMAxUf5; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="iFMAxUf5"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84a2dcede83so1084399b3a.3
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 02:44:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787132642; cv=none;
        d=google.com; s=arc-20260327;
        b=KOxr4ddJ5z/iJ8u9W0GrXUnlgigipK6MIWuS0v4cZ4fR50XWsBJK5Y56Ufq0SMxQ/u
         TG0lHCj8k74D5nxn6TpUK19oXiS6LreozqWP6Vyt0znTi6u9n4mqrA+B648sXZx9f1kL
         GnYTvbA6f3W2TzmLEG9n9n0WIeoMJn8nuWj1AetGG/pgKnXHPoNYdykHwEW6lDJdS3nm
         3+1JFUMVbx2N7r0r485YV/Z9N7DZsW9vHByE+qUbFIUu9IthNQS7f0c3MMtBng7s7U90
         ZvFell5gpM32amjR/sJ4DBWgb7zxkGkm1EDrtaDD2szCMTEGSlwblSMD7WnWDHvsz5RV
         A3+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xXVBUa5CWsVqk1YRNp8DHi5XeenCOLPR6Ijg7K/nYyw=;
        fh=eTjrfF79oa5iBXXI5bGmG7PfI7jDoiwyN2YMVjQr2bA=;
        b=EWqfZEsSJUfC/b3DXrqJzzN+4myqSaKU6eNmJwtQIJgX9fI7rNlTcDgd2CeSJ2lgf4
         g8d42SbDZNk0/sazolmwnwox+ccMchT3VlWfLsjOCqAcWTCIkl8A1yvQ/XNw7i4aD4p/
         XK1OSlfg0eBlDrqYQIM2mvwF6oM05zhzuW+7dHnUuucNmz4GaMiaXdS685wx3efXsZT0
         udbi5UtvNpqlBH+9C26HgG9xDFiB2CeU9HRePtOXenooX+HPqfEumJjHKYL6SdcPvkFE
         eqJPYMNCiEexlQ78BqyZlATuyP4icwpt3jC6iBY0gK99mDR5ZDJ8211j/Pm1cpANfwBG
         AjEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787132642; x=1787737442; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xXVBUa5CWsVqk1YRNp8DHi5XeenCOLPR6Ijg7K/nYyw=;
        b=iFMAxUf5plZ7aZQ7ir+VqK9njA/4IyHh4X6Cko8520KTJWkc5Hj+b4YBfy8rhlo50S
         jf1U4MVtIyh8sBxRf4bBrjL5PNZVSYuzsRlQOqEK7dEySVuR41NvWQqLrhAYIDgxzh5v
         lZ+rwaFlgVR89DCvDtDzi3vTGxvsEYDomzUDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787132642; x=1787737442;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xXVBUa5CWsVqk1YRNp8DHi5XeenCOLPR6Ijg7K/nYyw=;
        b=LUID1nLUWlZaC98EJh8bgSmxql4zlrfQbqx6BDG1j0vSfsnV+hcO/WseFEgpRv7+hn
         UIFumvr4eT22Pi7ndMbHlHT/8v7UQB44p/fjMeM0NLLigTTzSSx9h3fPy2aAIxwK8SBQ
         f9QWGi3ZsDQp3cEy8zl7p+Rz/eMcaIM4vrljvqOtIEgMgcB1cbsPr2RffWBSxjRrTbld
         XRZ8SzzJHBQXzbqUFeVn555/6s7XwBGl3L2XCDXVxoHQLIUWDzNCGpeFg60Y+KrIDO+e
         9ih3DZouHDj+F7lla47jLVebG3ph1wmIhHjD+aWwrSFSuO1vzwfFj/LWP8M5P2I7N2KE
         lejA==
X-Forwarded-Encrypted: i=1; AHgh+Ro5birIKuyk5e5VL/4CzpR/QS6wKveTKA8Ngcv0eKegr2ryErniL/5TNiLEqPq+XMt3EFWax0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK1g1h+BQAAfLe0rHNJ1r4MMvEcJ44K7ngM7507Nm3uotZsHnR
	bt0PxXtbNbYSOub9uzeUWVnsWzNkhnHaoTBaG6O7yDnccyxZrsFT9mi6/ZSYck/nczzJ83W9dDu
	eSAC1HQI2NdJpb1K0BazDMahtX905J+uxPE30RUt2
X-Gm-Gg: AR+sD13/nnUrqUqFC+cuCdCEJlHWUNLfwZ2+EkLIuMFVyGsqzI5AMO+CtJqNFbz1gdP
	ZVwv/5vO6+FiUYZV7TsZzcfZEaUF++uYwyjxJThV/vSzA+6/0WkFOCNrfDoTttuY+s4jKjuGW6v
	KK6voQGZ4h8k73TepK7W+YYIDpWaURUeqqfAzHrTXmKbem6vy1jQ8cdv4CIbtx6G2JhH4MoiZa/
	VGu1WKs2pd5hfgaXdlbc7Xjk/6KP/oL24IP1JrQXOe++7lGehsiFfo2t8BnvnlpJOgzOueSVwy2
	x8N3dAWZmkIHESOj5MMb5Am0SZ4jnlSc7kq9D0vtQTvJaQ==
X-Received: by 2002:a05:6a00:1d8f:b0:82f:50cd:e586 with SMTP id
 d2e1a72fcca58-851d39596d8mr5802650b3a.13.1787132641780; Wed, 19 Aug 2026
 02:44:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818221519.75088-1-meatuni001@gmail.com>
In-Reply-To: <20260818221519.75088-1-meatuni001@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 19 Aug 2026 05:43:50 -0400
X-Gm-Features: AcwNN1UYmATzU7V_c8fMgTpkO2qYWlgH_0hLusIxRjBxAIim51Y7ugm38PEbQRo
Message-ID: <CAM0EoMmz8_Cuk9CirJGN6hqfL=A-ftgtFD1eyz67-i9g3s_61w@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: act_skbmod: Fix headroom COW leading to
 page cache corruption
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 6:15=E2=80=AFPM Muhammad Bilal <meatuni001@gmail.co=
m> wrote:
>
> tcf_skbmod_act() calls skb_ensure_writable(skb, max_edit_len) to ensure
> the modified packet header is writable before rewriting Ethernet addresse=
s
> or setting ECN bits.
>
> However, skb_ensure_writable() only pulls and COWs memory starting from
> skb->data onwards. At ingress or on forwarded packets, the Ethernet
> header (or network header) may reside in the headroom at a negative
> offset (skb_mac_offset(skb) < 0).
>
> Because skb_cow() is omitted for negative offsets, writes via
> ether_addr_copy() or INET_ECN_set_ce() modify shared headroom in-place
> on cloned SKBs (e.g., cloned by tc mirred, bpf_clone_redirect, or
> packet capture sockets). This can result in silent packet corruption
> and page cache corruption.
>
> Fix this by ensuring that if the target header starts at a negative
> offset in the headroom, skb_cow(skb, -offset) is called to unshare the
> headroom before ensuring writability across the header span.
>

1. You must provide a reproducer. We test everything. Make sure you
have the correct logs for what you reproduced.
If the reproducer is security-sensitive, send it off-list. A standard
tdc test (if possible) is the prefered option.

2. These bugs follow the same exact pattern; no need for 3 patches.
Fold them into 1. Create a helper they all use.

In case wasnt clear: You need a v2.

cheers,
jamal

> Fixes: 86da71b57383 ("net_sched: Introduce skbmod action")
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
> ---
>  net/sched/act_skbmod.c | 37 ++++++++++++++++++++++++-------------
>  1 file changed, 24 insertions(+), 13 deletions(-)
>
> diff --git a/net/sched/act_skbmod.c b/net/sched/act_skbmod.c
> index a8e2b83ebae5..cd2a6e974e6f 100644
> --- a/net/sched/act_skbmod.c
> +++ b/net/sched/act_skbmod.c
> @@ -22,13 +22,24 @@
>
>  static struct tc_action_ops act_skbmod_ops;
>
> +static int skbmod_ensure_writable(struct sk_buff *skb, int offset, int l=
en)
> +{
> +       if (offset < 0) {
> +               if (skb_cow(skb, -offset))
> +                       return -ENOMEM;
> +               if (offset + len > 0)
> +                       return skb_ensure_writable(skb, offset + len);
> +               return 0;
> +       }
> +       return skb_ensure_writable(skb, offset + len);
> +}
> +
>  TC_INDIRECT_SCOPE int tcf_skbmod_act(struct sk_buff *skb,
>                                      const struct tc_action *a,
>                                      struct tcf_result *res)
>  {
>         struct tcf_skbmod *d =3D to_skbmod(a);
>         struct tcf_skbmod_params *p;
> -       int max_edit_len, err;
>         u64 flags;
>
>         tcf_lastuse_update(&d->tcf_tm);
> @@ -38,7 +49,6 @@ TC_INDIRECT_SCOPE int tcf_skbmod_act(struct sk_buff *sk=
b,
>         if (unlikely(p->action =3D=3D TC_ACT_SHOT))
>                 goto drop;
>
> -       max_edit_len =3D skb_mac_header_len(skb);
>         flags =3D p->flags;
>
>         /* tcf_skbmod_init() guarantees "flags" to be one of the followin=
g:
> @@ -52,19 +62,20 @@ TC_INDIRECT_SCOPE int tcf_skbmod_act(struct sk_buff *=
skb,
>                 switch (skb_protocol(skb, true)) {
>                 case cpu_to_be16(ETH_P_IP):
>                 case cpu_to_be16(ETH_P_IPV6):
> -                       max_edit_len +=3D skb_network_header_len(skb);
> +                       if (skbmod_ensure_writable(skb, skb_network_offse=
t(skb),
> +                                                  skb_network_header_len=
(skb)))
> +                               goto drop;
>                         break;
>                 default:
>                         goto out;
>                 }
> -       } else if (!skb->dev || skb->dev->type !=3D ARPHRD_ETHER) {
> -               goto out;
> -       }
> -
> -       err =3D skb_ensure_writable(skb, max_edit_len);
> -       if (unlikely(err)) /* best policy is to drop on the floor */
> -               goto drop;
> +       } else {
> +               if (!skb->dev || skb->dev->type !=3D ARPHRD_ETHER)
> +                       goto out;
>
> +               if (skbmod_ensure_writable(skb, skb_mac_offset(skb), ETH_=
HLEN))
> +                       goto drop;
> +       }
>         if (flags & SKBMOD_F_DMAC)
>                 ether_addr_copy(eth_hdr(skb)->h_dest, p->eth_dst);
>         if (flags & SKBMOD_F_SMAC)
> --
> 2.43.0
