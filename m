Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFECE3CFF73
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 17:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785952358; cv=pass; b=nM1DHICWR4CP0XVJMrFjVTzKKHFLRHvqc4omKG8X7R2pR7WV8fQWsMKo+R7iYeq/S1Mpi1gGhT5BlB7S8LSYTDz35iTS5+zJyq7Ow5bwGbdjsAc100QCVV711PCy9zcI08bFgsqOkTppfHwFWg9WDmWr9yliHpSYkCXuDT6LOMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785952358; c=relaxed/simple;
	bh=e2bnPWY93k3ciIefhfr1b5YgN5w/0NJ3BEUrJi7PVO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AIMdHMWpOk5TvDEiHnCNq6vYslmzgrvufrup5nBh/rW35KaioqG0yJuOVhJRSPyPosdW6VlRZAZat20qMALPXvgKY/qe8esk0s9Qrfd6GMWK8NkZ0Vw9hl1CCnsP7wp/7AT3U+kWVnpF+7N97eWEZRAWjF1wgsKRIgxqhQtJZ/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=Oe5Sc147; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="Oe5Sc147"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8453427d3f4so1614753b3a.3
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 10:52:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785952356; cv=none;
        d=google.com; s=arc-20260327;
        b=eROMOWAZ2UnVyZVG8FHRxbVHlz7fzRwLJuXi1Ih2icrH8vYV6oPikuF9gWv1U5KUaz
         wlsBGbd8FXQamcxtwpxs1D8ToAdILaAZfWWyRPgygolVVulFqlsPhxLN6yB9PZQg+5WX
         3pQvAu2ccavh8p7Tg1SfFs9vzU+sN7uUTVrevNHsmK2uDuktFT2CIq4zyq89QpO6FZdC
         mzOd13ym4oHbiu6wyt4Qimb6onSbr2/6g4sKMY0K0gYWSlMN73uMmtyZdZf5T1yQVCtp
         6JHJDAioi8HCXZni9yUodi2zHnLgOkRkMNXDZxMjR77h+qOITnwsTo73p4cah7Xv0ucM
         mKvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lCVzpfkfKQIXBFv6AstqW5VlxzaL5u0+36TYufuC33M=;
        fh=IhNzclDJKle5GUv0icBvF6owgWGe+TVg/AqkHOfgF0w=;
        b=of5a/uXXfjR0lT1BifHRnJ2o80FKRjE1b5NQpp5fqmvG3R11eCY09r1XbUo/oGcGr3
         TapLRXakb8f5ikfVVdCfRLxJQvZY2TnfAgCfVD9ucBdrJCPhEDCynE8gP35seCk9Fors
         ph/yRWOBakXV2C/rZ8WaPFb38A54P6+7ZFYBDwjinjckuEzXFVh8uxxRJMJRbK4g9LB/
         QPv+zqpCWnGu74gzAq8baL3oAwRpXin3RQKX2bRV7sulwDzICuOSbIdwTad7YxJS+W+K
         kZ6yaMNnqM1AO4RT1i25oogibDBvHXZgS6lf5uBbCXOJjI7qlms10IASm5TxhC5ouGcM
         7tTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1785952356; x=1786557156; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lCVzpfkfKQIXBFv6AstqW5VlxzaL5u0+36TYufuC33M=;
        b=Oe5Sc147+JBEKr76hEsjlXkz/+LIF2zjo40oac4IzWO2oIFfZuiccbwNvYh/LLxmWa
         LJYP/ee+59WEvrH1ecBwlr0wKkYD3wFBZXRHy9U+NRgv2TO6cHQYe3sxwX6RTGk6gsyq
         cCViq12zANEAblEWPLIrYaAes6lhELX9NSPyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785952356; x=1786557156;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lCVzpfkfKQIXBFv6AstqW5VlxzaL5u0+36TYufuC33M=;
        b=FnlrbWSE1ibE3Wu36wrfL0lbmzQ0YtYGBLfbowwY3X6ErLHs9ChXh7jPljqWTJQhKz
         CnhjZP5O9A2ym1q1q4aMDwpHRpQvG2TwIwIzBjYP1us/9bk4ngynA2mRk5zlMrr+tiER
         fo8jnFEa9BRsmarczFNQ0+EEkxGKTse5GJ7IR3FL0DWdLGIhigCGfQNfD8Scfi9Ohkpv
         hS5t0BE1fKxr1YAQdhaUjMbGl5ah8DtCqLWvaAEbybg52qWerc0d421J6WpbTyH4+Y2w
         vvQVc2CEMdJLkNEz3CQ/KlgeHTq4yIgBnWdLnstLm2l04LeaYJLweHutSMEY82pwwa93
         QKzA==
X-Forwarded-Encrypted: i=1; AHgh+RopjLMmP0xRTqKjJ7ljhGu5eePm9jCZa3lFvTLuAcImewbxXGYF3twWbUdiCA5BPetplTltNPo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6El4vK6m/uh002AFL2hSOaWVDbrVsY0GTM8Uie0wW6F7sjN4C
	3nle60MYO4dk+Pt4RV0jJugtdrAlMHZtlePtxrQrKOyo9sj5vRDVmF/UzDeYUv5XNUsz7g3kDLF
	54jIG4ewSVzkllX8uX39kkHc3U58/w/UwaJV+XrDq
X-Gm-Gg: AR+sD10nZXYTmNQGzHH3wpaAKA3iwr1plWn50TvUqkd6PpoScTJP92EBLnrD2a6eGpv
	5RPD5cwyaQ8jPirt5TFKKc2iVGA/py9MozuYSn+iJs5QSjp1wr8iUcMFGtw8tcVY32UllOARxop
	7nLOklxIjqUtutvzgcVhDPbE52OWhGHYANGszUsb0TIRS+8WgNRL6dOajdtpr09jmN4ylmA1hJR
	EdPy3DCgez4e7yN18Ht+qNSY2AIg1gbJOM2eTsRBdzAFQmOxKa5PX2eYCRwxe1k3KpaIvkSluoM
	sRsatbRrHUfTrb0OIclTznFTL7nm4Xk3bCiPXjAKocTBPcVgOsJwYjkccg==
X-Received: by 2002:a05:6a00:348d:b0:842:706e:ad43 with SMTP id
 d2e1a72fcca58-84f2e0ccba3mr10352497b3a.33.1785952355982; Wed, 05 Aug 2026
 10:52:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805093012.95155-1-henrymei@tencent.com>
In-Reply-To: <20260805093012.95155-1-henrymei@tencent.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 5 Aug 2026 13:52:24 -0400
X-Gm-Features: AUfX_mzwZqW7-itfrTSXTC_surhIBVhCfhDT6bwPIQqR54fbSSGBf_cXDQQD1NA
Message-ID: <CAM0EoMmZGXhHL2v=AyjR9xSs8-s9EfkA9FkpULqtFBEOUxHQQA@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: cls_api: fix tp_created race losing
 existing tcf_proto
To: Aohan Mei <ljp1205831794@gmail.com>
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	corvus@tencent.com, henrymei@tencent.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 5:30=E2=80=AFAM Aohan Mei <ljp1205831794@gmail.com> =
wrote:
>
> tc_new_tfilter() attaches a filter to a chain. When no
> tcf_proto (tp) exists for the given (protocol, prio), it creates one
> with tcf_proto_create(), marks tp_created so the error path can clean
> it up, and inserts it with tcf_chain_tp_insert_unique().
>
> However, tcf_proto_create() can sleep, opening a race window in which a
> concurrent thread may insert a tp with the same (protocol, prio). In
> that case tcf_chain_tp_insert_unique() destroys tp_new and returns the
> *existing* tp, but tp_created is never reset. If the request then fails
> (e.g. kind mismatch), the errout path calls
> tcf_chain_tp_delete_empty() on a tp this thread never created. For
> classifiers without a delete_empty callback (all but cls_flower),
> tcf_proto_check_delete() removes the tp unconditionally: a live tp and
> all its filters are silently lost while the owner's change() still
> reports success. The race is reachable because cls_flower on
> ingress/clsact qdiscs runs without rtnl_lock and can interleave with
> rtnl_lock-holding classifiers such as u32.
>
> Fix this by making tcf_chain_tp_insert_unique() report through a new
> "inserted" out-parameter whether tp_new was actually inserted, and
> gate the errout delete_empty call on it instead of tp_created.
> tp_created itself must stay set on this path: the chain reference was
> consumed by the destroyed tp_new, and errout_tp relies on tp_created
> to decide whether to tcf_chain_put(), so resetting it would underflow
> the chain refcount.
>
> Fixes: 8b64678e0af8 ("net: sched: refactor tp insert/delete for concurren=
t execution")
> Cc: stable@vger.kernel.org
> Reported-by: TencentOS Corvus AI <corvus@tencent.com>
> Signed-off-by: Aohan Mei <henrymei@tencent.com>

This is the same issue Sashiko found. A patch is here:

https://lore.kernel.org/netdev/20260805134049.927864-1-victor@mojatatu.com/

Also, please add assisted-by: tags going forward if this was ai generated.

cheers,
jamal

> ---
>  net/sched/cls_api.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> index fee4524ad..9ceb2b538 100644
> --- a/net/sched/cls_api.c
> +++ b/net/sched/cls_api.c
> @@ -1937,7 +1937,8 @@ static struct tcf_proto *tcf_chain_tp_find(struct t=
cf_chain *chain,
>  static struct tcf_proto *tcf_chain_tp_insert_unique(struct tcf_chain *ch=
ain,
>                                                     struct tcf_proto *tp_=
new,
>                                                     u32 protocol, u32 pri=
o,
> -                                                   bool rtnl_held)
> +                                                   bool rtnl_held,
> +                                                   bool *inserted)
>  {
>         struct tcf_chain_info chain_info;
>         struct tcf_proto *tp;
> @@ -1948,6 +1949,7 @@ static struct tcf_proto *tcf_chain_tp_insert_unique=
(struct tcf_chain *chain,
>         if (tcf_proto_exists_destroying(chain, tp_new)) {
>                 mutex_unlock(&chain->filter_chain_lock);
>                 tcf_proto_destroy(tp_new, rtnl_held, false, NULL);
> +               *inserted =3D false;
>                 return ERR_PTR(-EAGAIN);
>         }
>
> @@ -1964,6 +1966,11 @@ static struct tcf_proto *tcf_chain_tp_insert_uniqu=
e(struct tcf_chain *chain,
>                 tp_new =3D ERR_PTR(err);
>         }
>
> +       /* Tell the caller whether tp_new was actually inserted, or an
> +        * already existing tp is being returned instead.
> +        */
> +       *inserted =3D !tp && !err;
> +
>         return tp_new;
>  }
>
> @@ -2254,11 +2261,13 @@ static int tc_new_tfilter(struct sk_buff *skb, st=
ruct nlmsghdr *n,
>         void *fh;
>         int err;
>         int tp_created;
> +       bool tp_inserted;
>         bool rtnl_held =3D false;
>         u32 flags;
>
>  replay:
>         tp_created =3D 0;
> +       tp_inserted =3D false;
>
>         err =3D nlmsg_parse_deprecated(n, sizeof(*t), tca, TCA_MAX,
>                                      rtm_tca_policy, extack);
> @@ -2382,7 +2391,7 @@ static int tc_new_tfilter(struct sk_buff *skb, stru=
ct nlmsghdr *n,
>
>                 tp_created =3D 1;
>                 tp =3D tcf_chain_tp_insert_unique(chain, tp_new, protocol=
, prio,
> -                                               rtnl_held);
> +                                               rtnl_held, &tp_inserted);
>                 if (IS_ERR(tp)) {
>                         err =3D PTR_ERR(tp);
>                         goto errout_tp;
> @@ -2440,7 +2449,13 @@ static int tc_new_tfilter(struct sk_buff *skb, str=
uct nlmsghdr *n,
>         }
>
>  errout:
> -       if (err && tp_created)
> +       /* Only delete a tp that we actually inserted ourselves. When
> +        * tcf_chain_tp_insert_unique() raced with a concurrent insertion
> +        * it returns the existing tp; tp_created must stay set then (the
> +        * chain reference was consumed by the destroyed tp_new), but the
> +        * existing tp must not be deleted.
> +        */
> +       if (err && tp_inserted)
>                 tcf_chain_tp_delete_empty(chain, tp, rtnl_held, NULL);
>  errout_tp:
>         if (chain) {
> --
> 2.50.1 (Apple Git-155)
>
