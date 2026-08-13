Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9766442FAB
	for <stable@vger.kernel.org>; Thu, 13 Aug 2026 08:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786611170; cv=pass; b=Ey0xOyEh1w/m1RhPC3OLgxG0preGKREGVQsFjvC94shXHH4zybzX0Z5KakCTwZyp+PQh6Lr8tKMG22hVDt9t2LtU1DAFRUy6z5XmwwQHaVSnOj6Gc9KPJPSJQytuVdtIseqEcNlXqLCZsaDaX2kEOfls9BhbuvxRmwulHC6CAT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786611170; c=relaxed/simple;
	bh=OuHmCFJxSVJBidCXfFZYNZ0poOvLesgUedmmoEQ/ihE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MbpPcSI/6vqBnAj9QUKpzSPDrHYN4UgNr+1fP05XQH/nLmICeq9UMLasyoJOa7OMziXbF70Orj0GM9InmEWKn4lIZHOTMWyX7bXKVHpVpl9VOcT1n9FIA5TX/d5GBill0dnsj9OU1olIKfyM4DHtFCUvLgxGPljMfp8uI83vY38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=Ix45WXuQ; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="Ix45WXuQ"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84862b0d5f8so1701576b3a.3
        for <stable@vger.kernel.org>; Thu, 13 Aug 2026 01:52:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786611167; cv=none;
        d=google.com; s=arc-20260327;
        b=CW21Z1ATYJ40ToBkMbdru9rbqQ/pv4sNt9Zq9ew2YjJR1esn7BYrJGPb2CZYHjLk0J
         at6KSd9mRyzoReWRImmX+0jbBJfLztDkPtrxbuGvv6+pEvzT8UjQAB5m9lmrdHbTvMSA
         ZCdyIwOtrpLMzTp7PK1KzGqcCpP4wjNOZZlEVjIaZgP3AzrkCRhYYLi9jNzwbfrXHwiW
         b7VuLfjHnbzT74+r9YMMAQwC057jKTrpVWjITGbZda7kfWI/jfmGCEfQxH1RWzZFke3r
         3qQrGGUk1S1K5n7LNtwGoEmQygn7SdtarSrZZbF01S686dzqrnuOOE/mf6jCKcWkyuPK
         BO5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eB8qHCkBqgdg5x5zWmXJ5QxdIBLGKfO7Oht3lf2tkAU=;
        fh=q2D//7CfxJJM6RhNyZe2STe35AIgYQAmg+C1pwy1R2Q=;
        b=YBc1gu4uthb/AKlFh6Zol/UpLCTFESu1bFrUKmU+hiUw0VZiFNSXIFh11PlRDp2iYL
         4vVpUWr2VstSllT+w5KxT4xhxCUQsR8qgPmnNd+3Te6rDREYB7WpKtGnGi6KotSBmtG/
         HyTNfUOiLXCWHcHCw9tOFK75oMR4ucM8BsVPRZwJzgwVN6qurVJVru7K8VONoYLd+nFc
         3UN0BhE29T69UwG0EZH0zzrmFmRK4qmGZLuqZcmDhoomDwVla/oltmS1Zom1cql0OtuH
         telWO/Z5NFoq0CZKou5D+0ZhOdsE1/8wiM5BSRX/eq/Umhw6hYB9tky6DVoN3ifdRzs6
         ntMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1786611167; x=1787215967; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eB8qHCkBqgdg5x5zWmXJ5QxdIBLGKfO7Oht3lf2tkAU=;
        b=Ix45WXuQi1B/KzBzQq6pZrj+eyHx1usm9lNuBiLKjFNvbDFoTV4xcj4TbNeo8S2ZTG
         n+lufhzd4Rw7YfYrFHqdPxqBuRp/bWVJUN2IV2gtv1msTmY3ZNOg4MfAkzmAqjFfnlSE
         WqdoltD0oru+cDYDom9AFu8VNuOCeQrPAXUUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786611167; x=1787215967;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eB8qHCkBqgdg5x5zWmXJ5QxdIBLGKfO7Oht3lf2tkAU=;
        b=awIAVD+rqEDTmZqJU+3n3HF9S5hfz/vdtPDbcVb3v3XcQpj0Om+jI9EHlEhLP796Io
         YhnYklvymD7szaU8kG07XN2Dl3ggmNMXdKnaw6N5a0hHd/GuKS+HllGlrL+s1C4yBOJ2
         UCbz6Ihhi/oaWtVoegef3+FUs5PnMI3hGL+VuQ++PVNaSMALAqqourzR0gU015SXg8j/
         5ktupxiBl2bMloNH3EWPOtySqPX+DQmHKPCPMtKiU91Qsz6tH7VM6UQQCIFHKrQURqPW
         UeX0H3Dea65lTzLhKEDGWUt5S3xPlYjJW2T0uqR76fi338u42s2SFqqL7vxuoHFDsvgi
         dnzQ==
X-Gm-Message-State: AOJu0Yzxs8jCmoJbtHZFzZsQsy1lc9uHnmIZQ7eZ5yv9Lc7OdtMUhdB1
	UspIo1TWyyRYwHLMUlcHe3hQ+vCfDJ77cSjBc0E3XNStTq+uDVLH/DjjuHuhylCODH0RP/gsdKM
	jTj/3t/+IN82t/d4xY95eFcFYYJBfZACjPkeTacXybq3KTJ9bVlYemQ==
X-Gm-Gg: AR+sD103KExOnKCxaLhHUomp5WMNtRZzaFOkTiVwx+o8/0UluW1+Y22WE0JdHhkhFyx
	C+rztMW7AINVWdJ+1l1kXoTy5MqDJVreBXR2eZ3ibYJsOb2wO9h2vAY18iPYhLrU+zkP9IO0/Xh
	sTignAJ+zD6W6CzLspWsgJptGKsGlYOFGo0IkxO7gnVgR/GI/9Svekny6+v499XnJtXpN5aQAYJ
	gBLErnfWY1N5i3c05ehd18We4+C1BBpOKdxgOhAMKGHx4qaGNXp78dzCGs8kL51MVr79IlOslfq
	jhf9qR0L4mxpfpBqGWK5oPlN8JoLzHdYmR4wohB/4A==
X-Received: by 2002:a05:6a00:1891:b0:845:c6fc:2821 with SMTP id
 d2e1a72fcca58-84fc6e04476mr4296840b3a.22.1786611166640; Thu, 13 Aug 2026
 01:52:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809094418.901607-1-jhs@mojatatu.com>
In-Reply-To: <20260809094418.901607-1-jhs@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 13 Aug 2026 04:52:35 -0400
X-Gm-Features: AUfX_mzYJSHQ81nk6K5CQtHRiM8w99otSWYBW2UKmO4T55DkFo0ZHPMcwhj5DCs
Message-ID: <CAM0EoMm0xj=R4c+3yoBJyEDgNAmsaCospYT9jxVTTihJzSnvPg@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: cls_bpf: reject dev-bound programs bound
 to a different device
To: netdev@vger.kernel.org
Cc: stable@vger.kernel.org, vega@nebusec.ai, 
	Victor Nogueira <victor@mojatatu.com>, Jakub Kicinski <kuba@kernel.org>, Quentin Monnet <qmo@kernel.org>, 
	Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 9, 2026 at 5:44=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com> =
wrote:
>
> cls_bpf_prog_from_efd() obtained a SCHED_CLS program via
> bpf_prog_get_type_dev() but never verified that a device-bound (offloaded=
)
> program's bound netdev matches the TC netdev the classifier is being
> attached to. This let a program loaded with prog_ifindex for device A be
> attached via cls_bpf + skip_sw to device B; deleting device A then
> destroyed the program's offload state while it was still attached to
> device B, triggering a netdevsim WARN (panic with panic_on_warn=3D1).
>
> Mirror the XDP attach path (net/core/dev.c) and reject the attach with
> -EINVAL when a dev-bound program's bound device does not match the
> target device.
>
> Fixes: 6c8dfe21c435 ("cls_bpf: allow attaching programs loaded for specif=
ic device")

Fixes: 2b3486bc2d23 ("bpf: Introduce device-bound XDP programs")

cheers,
jamal

> Reported-by: vega@nebusec.ai
> Tested-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
>  net/sched/cls_bpf.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/net/sched/cls_bpf.c b/net/sched/cls_bpf.c
> index 001d8c4ebfed..6d19155becc8 100644
> --- a/net/sched/cls_bpf.c
> +++ b/net/sched/cls_bpf.c
> @@ -374,7 +374,8 @@ static int cls_bpf_prog_from_ops(struct nlattr **tb, =
struct cls_bpf_prog *prog)
>  }
>
>  static int cls_bpf_prog_from_efd(struct nlattr **tb, struct cls_bpf_prog=
 *prog,
> -                                u32 gen_flags, const struct tcf_proto *t=
p)
> +                                u32 gen_flags, const struct tcf_proto *t=
p,
> +                                struct netlink_ext_ack *extack)
>  {
>         struct bpf_prog *fp;
>         char *name =3D NULL;
> @@ -388,6 +389,19 @@ static int cls_bpf_prog_from_efd(struct nlattr **tb,=
 struct cls_bpf_prog *prog,
>         if (IS_ERR(fp))
>                 return PTR_ERR(fp);
>
> +       if (bpf_prog_is_dev_bound(fp->aux)) {
> +               struct tcf_block *block =3D tp->chain->block;
> +               struct net_device *dev;
> +
> +               dev =3D block->q ? qdisc_dev(block->q) : NULL;
> +               if (!dev || !bpf_offload_dev_match(fp, dev)) {
> +                       NL_SET_ERR_MSG(extack,
> +                                      "Program is bound to a different d=
evice");
> +                       bpf_prog_put(fp);
> +                       return -EINVAL;
> +               }
> +       }
> +
>         if (tb[TCA_BPF_NAME]) {
>                 name =3D nla_memdup(tb[TCA_BPF_NAME], GFP_KERNEL);
>                 if (!name) {
> @@ -492,7 +506,7 @@ static int cls_bpf_change(struct net *net, struct sk_=
buff *in_skb,
>         prog->gen_flags =3D gen_flags;
>
>         ret =3D is_bpf ? cls_bpf_prog_from_ops(tb, prog) :
> -               cls_bpf_prog_from_efd(tb, prog, gen_flags, tp);
> +               cls_bpf_prog_from_efd(tb, prog, gen_flags, tp, extack);
>         if (ret < 0)
>                 goto errout_idr;
>
> --
> 2.34.1
>
