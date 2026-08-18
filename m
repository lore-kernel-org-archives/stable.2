Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E666E47143C
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 12:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787057766; cv=pass; b=YS3GGvozHmwSIQ8q5zFSXpxGx+8RsFnMHISD1cT6P6Egwzyfa1qYpvOTcoB/vj+/UZzlfpmrGMEkLkqKofnfqrJ8arm9knlEtqY4e0yCp6N7hWprCiNypCc5N+XuIy2XGSPX75fF99RuQzeQkdjUXeadaVuWJedvOWPeU1BlOUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787057766; c=relaxed/simple;
	bh=8WZmKtXfDYAxNty2zOXXko3KjoLk2aTZGmS07916+ng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ja7TUtccGWHIJ2sMM0R7ECg8L+5MkQ44ATr+DrFM2kCVEcrXW2wZ+u62p1EEjPsYh4ntx42oQhnVnsvInZSlMPaZhf7RbY5knAVLOyuRGNwqXE6xD+c3+6qHY+ToPJxDNDBE/jEB7rrXo+7U7u94LJG7FFCviijVi6IeXu83wdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N7LExdLw; arc=pass smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N7LExdLw"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92e54f8c051so226920585a.3
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 05:56:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787057761; cv=none;
        d=google.com; s=arc-20260327;
        b=cYnc+o2H3Mbqvm9JIkkuNBrAgZdkBEMmVCbDeqjEG3Pt6eK2i97uUDYA+gfQnReDMV
         a8rtaj1GpETExQ0M9+GjoYlwPLu4QoVVjO1iHUN1amA1EH9HH/MZnJyDC0xnavUq7O/T
         0BgpbHDkHMtIeXwIdcE8oAt4sRXLAzP2zQumjXanxmnKHC6rRfNqhe2vWQYDSk5xubk8
         dvNChvAVjBxGBIUo8GKvTBt2VzrDkwEHcv5d3ZZoWHwpB/8m4C9RttE3BGyH8XmRULTX
         UYsnFqRnEHUh1WgNXPHIpyNGLxvp3YHvOsG2BCfwZ0XHd6WNfFf8Zd40qCGsEd5sezqC
         lIFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hrjz6ZyaESIh/O20y9BH3dNMEr0ZBUI+Z0dX8nupLgw=;
        fh=5PR/BwMS2Ddx3ggd9BRw/0Hp+3Cx/8qlpRRN0H0fyN0=;
        b=VHdDLCMR7ceSw/4ZC0XF1/cN8cjRw+RbweGPlquNUbvj3JEXv0yocpfkZth/OYR/eD
         xDuIDIzoXTsx8KaJMzDZ8n+IP/2gW5VHwJH0faucL5MOSusl0W8+rDlhiD+w95PC0vCN
         NzF8xxRA8YGB3g+01Rr3YeV+pDGt+rrgG7o1yglC4PsJ1LAvzVxP520OetJaOCZGtN06
         pvU2dbaDbkunjxaDIJzxfORuh7uKjB4eREX4To6KEl6P+pqCSrwMARyPMCTd3PBWNwer
         MIfWOYpj8Ihyu/dZcR6+99hF2mXpT+XAXlLm4/kwPNTkYq8XO+o1KZZbEWYP1DohLlGL
         3uSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787057761; x=1787662561; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hrjz6ZyaESIh/O20y9BH3dNMEr0ZBUI+Z0dX8nupLgw=;
        b=N7LExdLwEtAL2n/lnUV3uWStJM0/eIePxM21vrERbsF3TSJhgd2YgruQ4N8gbJn2kE
         qK6/IHqFCB+kzGwr74RUAy8nPkyAMZjXiw92lWcNFYC+eyIYO7S+JcklUYj3lvMJY1z7
         0vKFfwpksTn+lvmLPKivqL94Qfk1Bf/h3xQ188po1L+iFpyUvbUmAjQQ/YMG/oFhRWzT
         Ka9Om7u0Xv9YLSRU1w0s4/WLpIZxknllRQTqOCiJkf2M72c0+8VuSRfLPjCV+0YF8hxP
         aAcwrUM3gF52AjY7rveXSCBhzXWYN/8+W0m0MT1Tzz7cmcHT35eEu+7s8AzTjX6v19Kj
         xDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787057761; x=1787662561;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hrjz6ZyaESIh/O20y9BH3dNMEr0ZBUI+Z0dX8nupLgw=;
        b=HqeKbcC5xavxgK7/MbHhgA4FDYKIxZCYP6MqS6XFqhYH3ha/mj5pd3mq2JmvRFzLg9
         F5Ub7KDsEzIWN2LWmKIJ7cc04rMRYhq0GePMvWw9DR1cPnUx7i5eUfWCviU8ljOHmSst
         97tSZPGbaL22pFJZ82qKw6FKfIOtZPRDBI+jLNXX+1LFa55tn8YTMRRDfvu90AdhAe39
         nyIYsYBlgysV9BnPTgCbTUGVm7GTg8DAkrc7v4JOwM+hZ/uVfsxXi412RhfuGLfCxGrI
         dFEXkovcyfJcOt7L6XbXdY3AmK3O8A0zf9bqzwgAY8d21bMqHRmXjA77U6uXc6wSUU4W
         xCag==
X-Forwarded-Encrypted: i=1; AHgh+Rp+5Na28xTKp6thzj4PUVTZAFpHmU3dET4iP9O9OYQE4AqpmBncVc5Q6LwctwcCmH7cLFT/5wc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQfSPUmr+t6t6E7Lxl8s9Dzsl2c5DjG5CmMnb4ezqQ/jB9SPux
	1UVwxtmLDW+al/7txtjZbXzyODbrryJav1SYh4L9nYxka+XL7D8RnNXnhdFIHZX8Cg61en187Qp
	C/RgrqNvDJ11Ru/j6I19lm1hQ/uOi/fVmGm1JjBs8
X-Gm-Gg: AR+sD11vyrGZr2OEMMUVQl0v1a1Oe/SaVy3uSJ4hdmkKecQktry/8eGCJqBZd+PMHSI
	mic1HWuVytd/oU7MNnE9mOLgpWMQEuhcMpoDCsrL4hqVzDJE6IXjcug86Wq4YT4rADGaSHHFiE+
	91Ow5jcm1rz0OFFo7wNzMparhIxxhsEd9llj0fom+Y1QkEQxvkyn+n2fOrOf7c2CblIPXUNRtpI
	hmy5G3E17Mdljmv3jKs44R8G32WSV0tKhLkS5d4Ps6WWqi0nHw+geKGDSDu2LJuEVgHmrjatmTg
	1PR1tjuXUj9yK1d8xpvihNKlkFc4NnYk553zLhU3TPVWfh1lOego2GLfL3yZqhX17IQEq6nW4iv
	TIDEeyMHBcY7ieLAFj+XG4LpexNZcD9mrRS76M/gu+Gkt7ZIDnGxr2Hfn3BmRaWZhkEdqjcw3db
	O4jqu7UQkSRcLNWjFNzWrLmnhWJQ==
X-Received: by 2002:a05:620a:2b98:b0:936:c04c:27b7 with SMTP id
 af79cd13be357-93704b159cemr825658585a.19.1787057759870; Tue, 18 Aug 2026
 05:55:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818101130.16203-1-jhs@mojatatu.com>
In-Reply-To: <20260818101130.16203-1-jhs@mojatatu.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 18 Aug 2026 14:55:47 +0200
X-Gm-Features: AcwNN1XZLSx0-wKpDGGXkSHHqqvRkuUqUcFLUb_eZuGC9qhicoAFIq1yJEZzSEo
Message-ID: <CANn89iKGuPE0qEp-ucnWfvr+Vo_Ynv7zxuTDaxtTWr3d_YiYLA@mail.gmail.com>
Subject: Re: [PATCH net] net: sched: fix quantum/backlog overflow in fq,
 fq_codel, hhf, sfq
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, vega@nebusec.ai, 
	Victor Nogueira <victor@mojatatu.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 12:11=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
>
> Several qdiscs derive their per-flow quantum or backlog from psched_mtu()
> or accumulate qdisc_pkt_len() into a u32/int counter without an overflow
> or zero clamp, which can drive the dequeue/credit-refill loop into a soft
> lockup or a NULL deref.
> vega@nebusec.ai provided reports and PoCs which illustrated the following=
:
>
> - sch_fq: fq_dequeue() credit-refill loop with a small quantum spins ~1B
>   iterations under the qdisc lock (soft lockup); fq_init() computes
>   quantum =3D 2 * psched_mtu() with no overflow check.
> - sch_fq_codel: fq_codel_enqueue() accumulates qdisc_pkt_len() into a u32
>   per-flow backlog; a crafted TCA_STAB inflates pkt_len to 1 GiB so a few
>   packets wrap the counter to 0, and fq_codel_drop() then picks an empty
>   flow and derefs NULL.
> - sch_hhf: hhf_init() sets quantum =3D psched_mtu() with no overflow chec=
k;
>   a huge MTU makes it 0x80000000, and hhf_dequeue()'s deficit +=3D weight=
 *
>   quantum loops forever.
> - sch_sfq: sfq_init() sets quantum =3D psched_mtu() (unsigned); a huge MT=
U
>   makes allot =3D INT_MIN, and INT_MIN + INT_MIN is UB that toggles betwe=
en
>   INT_MIN and 0 forever.
>
> Clamp the quantum to a sane minimum and promote the backlog/credit sums t=
o
> avoid the wrap, so the dequeue loops terminate and the drop path never
> selects an empty flow.
>
> Reported-by: vega@nebusec.ai
> Tested-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
>  net/sched/sch_fq.c       |  9 ++++++---
>  net/sched/sch_fq_codel.c | 14 +++++++++++++-
>  net/sched/sch_hhf.c      | 12 +++++++++++
>  net/sched/sch_sfq.c      |  7 +++++++
>  4 files changed, 38 insertions(+), 4 deletions(-)
>
> diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
> index 7cae082a9847..66e9c6e530d8 100644
> --- a/net/sched/sch_fq.c
> +++ b/net/sched/sch_fq.c
> @@ -750,7 +750,10 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
>         f =3D head->first;
>         retry =3D 0;
>         if (f->credit <=3D 0) {
> -               f->credit +=3D q->quantum;
> +               if (f->credit + (int)q->quantum > 0)
> +                       f->credit +=3D q->quantum;
> +               else
> +                       f->credit =3D q->quantum;

Lets not add cost in FQ fast path just because of a configuration issue?

>                 head->first =3D f->next;
>                 fq_flow_add_tail(q, f, OLD_FLOW);
>                 goto begin;
> @@ -1226,8 +1229,8 @@ static int fq_init(struct Qdisc *sch, struct nlattr=
 *opt,
>
>         sch->limit              =3D 10000;
>         q->flow_plimit          =3D 100;
> -       q->quantum              =3D 2 * psched_mtu(qdisc_dev(sch));
> -       q->initial_quantum      =3D 10 * psched_mtu(qdisc_dev(sch));
> +       q->quantum              =3D max_t(u32, 2 * psched_mtu(qdisc_dev(s=
ch)), 256);
> +       q->initial_quantum      =3D max_t(u32, 10 * psched_mtu(qdisc_dev(=
sch)), 256);

We instead can make sure quantum and initial_quantum are in an acceptable r=
ange.

[256, 16M] would probably make sense.
