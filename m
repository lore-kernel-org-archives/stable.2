Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57AE5218AE
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 21:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790112966; cv=pass; b=QtZ2OwBCnkmp9yqrMyr11tIp/ZZSPC3k3iWAqFc4FzEiSLPqo3LmUX5LNdL2rw/Ze2fmRDebNlm/3tdWssXnmI5mKPpJuJquA5uFS94eyxsH4CMIci13NGFNulThuqMAHmQvmUykz8WdCzq+df9YKufkj5VModKzJdX/N+94SVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790112966; c=relaxed/simple;
	bh=EvbVhKnw8RPUu8cuHWn+MNXVd2g9HdJedBQyZE6JTgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ecw7HRxzPsPJmJ/Pj9qt0wwAdNmlF6OTdYqUM1ZAbTUzfXeulGDQ4ci5rch6+7j2nUh+CiLPujTFNEiDL43jNPzzd+cWtg0SOXxZ6pdM2RpC0oFumyONkMEe9Y77MWV7wkdSIkAWl8lbd1wc4jb/mkSFVVe7bQ2KK5zp9kNRU04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=ebwMKZtX; arc=pass smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="ebwMKZtX"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469a3490bso328284b3a.3
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 14:35:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790112945; cv=none;
        d=google.com; s=arc-20260327;
        b=AVDPT5THhYdKhLyXgrUyNJRXdeThrWt8qazDDDl6CQaOJxIHeWy977y5qV1XU83q1G
         +lb3deehcjMs3hO6BfAfR8pLhD1zbRl3sTw4/zlTKWHieogTl22LylGlBus717bUTeex
         uEcD4mXhOzHlBNVht6Y+7wbJmGEW7zf1LE4GkF6KlrQ6ChUxOGGZ5t+AGHmDDn9lxPKN
         m5AWofUdIx5XNPt8eu8ejdG3YzAR6PfkjUd/YOHQYd8IzOELkaZfA6SI53vBjDG9mIGf
         aCvqQhLlpjzRdrvX5Uk4yG0t5rJuIJidu0t1QnO/Uc2PDL6DbY3PDyVGIiMy46Jjeo+K
         LeSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kdPzg2Ix4c1W2P1TMypn/Rnc27FR3sHCxu3cYUG6UQg=;
        fh=WOn8eyBYbO/nvYPoVy24sv+td93jEvOI9xISNneoQzY=;
        b=WcF9e2wgiiOi2NwfweHXr0h3f0PvvnAjxKBPy8jCasMk5FcQQElQIg7KiJgXbeUWxs
         W08ablxYpXAWYKNZuCEDo6EW6SZ7+GegHWNEvAgsoO7Cka+lGp6G22wZsV8Y17hJwfo6
         sIQ9DxJvcqk70npFfluaqOQTJG5Hi+bVwybWIleWpI87IRj7ilXyU8w6hdcj3sFoaVhx
         x8bx4oY492KrRNcbf7YoqxL5p4TsEKxwTvSCUnmbYhnAwtRzD6I5ePnrDDZ7/DpcTAfx
         rU2bK6rRodiTJfIVfrEb5seEb0RfRBIBjjoiCBu64n8SigXZula2TcPYWyp+BOb+FSYR
         sOWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1790112945; x=1790717745; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kdPzg2Ix4c1W2P1TMypn/Rnc27FR3sHCxu3cYUG6UQg=;
        b=ebwMKZtXQoXr3R9QTAZaITAjdkRxXnvNB4hA0ksEIQWNDChemNo1KmbtHdlTL7uvjg
         rnVEKZIeoG95s+Xj0juBpBCTFT0OKt+3XJClWr/pWt5ksopTlbsg1tlf1eLE2UG71bI2
         BbUHovLiCWjiy9ExQWHHWuC6qWeLGMUcvWzRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790112945; x=1790717745;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kdPzg2Ix4c1W2P1TMypn/Rnc27FR3sHCxu3cYUG6UQg=;
        b=HlpAUFHARnhCiAuBTbSxef7Gp7hgWzNsq472AUaqtoUO+EEtv3qzoLamQV4pB9rYct
         RaJwFZG76t/D1OYP7a7zQVC4LLJQdmAA6hu8ffAx+Hk72P0FcAsu0+jSkkz/FI4YNvaV
         g5bEIc9D+1CcwSiqKW38BrMleHzf7fXzvbjWHazgU9OI1+L/Nzbidu7GK2YyskrLvodO
         jW4dRSXbXOLyfVudHrl1KE3UE4dV6KVO+13LoFE1iKpeEBWNCWhpi9hKNzzcYgKfiusM
         JuTKAU4rENw61rCKBRsHs4W1vlUy2TGDZucpH9rC1Gu2z5+FScsuvowrnhVIjLCMS47M
         gtGg==
X-Forwarded-Encrypted: i=1; AKwUvBy4pkjostr7MX3Og9wAiiaTFDftR8qOWITUIh6U/eNWeh/TWZjEiPTFkP49VA31Ds3oJjeD7Zg=@vger.kernel.org
X-Gm-Message-State: AFuF++llZDnCIQ5ceGEBR7cUN41PIxthHAv72uw8kI5qE/6McBA/fyN9
	o6jvrGYroEbOikMXY0zcE08UELo+l5SVnYlD24GfaZCfLiYd7zkwVMovZLHygBvsiVdE1p8fnsb
	Qr14VTI8N4zHM5Or4V/ZzK29bN75MVguRsXvcdLXP
X-Gm-Gg: AYBFou28kKVGuva4Q553BM8v6TjNiRX2Vjb8tB9Dwjb+BKlnHe82gyFMMnAujb/tbEB
	pDXfJ/fe8yyWg2/Y3ZRswp3ds3ki+ATfexfUuF97urnJ+DaaPeSnh05Rf/eSLF7e+48RDzzt7vL
	+bIDYzHr3TfOwh+MrX52083VyMwk/w5vlEkgm/4CPtggS2ckKLaVfV9PONWYqno0Y0XcIe4/t6U
	2U0EgnfUDn79X4orWFpEUnpvxWs5Th40uQbxBtDrNQ8m4q8eP44jnc7Lk7NVH9OtVFmX7r6X1Xq
	ugYCieRigljVkOW+/X5bcdSjlH1VcxGNpSjXmaDcCiqrufwgJQqk4fF+CR/dB74cAK+DbJdQw+G
	IUQU3RRkKR4LTqQo2cjWF/8IOBApBHnFlXu28ZwvbLRQK
X-Received: by 2002:a05:6a00:44c5:b0:874:708d:b62b with SMTP id
 d2e1a72fcca58-87d1b8a15admr654286b3a.32.1790112945505; Tue, 22 Sep 2026
 14:35:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921145655.3167436-1-i.maximets@ovn.org> <20260921145655.3167436-6-i.maximets@ovn.org>
In-Reply-To: <20260921145655.3167436-6-i.maximets@ovn.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 22 Sep 2026 17:35:32 -0400
X-Gm-Features: AcwNN1WPL-vgVShl6hqSyik6C8tmu3eMWMaigjhCeY6OG6KGXvvi-22yq5biirU
Message-ID: <CAM0EoMk96wo2-kupgidntihfxij_zffq2v=ddH-mGUNUH0q7Wg@mail.gmail.com>
Subject: Re: [PATCH net 5/6] net/sched: act_ct: remove 'add_helper' dead code
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Aaron Conole <aconole@redhat.com>, 
	Eelco Chaudron <echaudro@redhat.com>, Jiri Pirko <jiri@resnulli.us>, Xin Long <lucien.xin@gmail.com>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, linux-kernel@vger.kernel.org, dev@openvswitch.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 10:57=E2=80=AFAM Ilya Maximets <i.maximets@ovn.org>=
 wrote:
>
> This variable can only become 'true' when the connection is not
> confirmed, but it is only checked when it is confirmed.  So, it can be
> treated as being always false and just removed.
>
> Fixes: a21b06e73191 ("net: sched: add helper support in act_ct")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal
> ---
>  net/sched/act_ct.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
> index e72143d36b119..f62051ec9d57d 100644
> --- a/net/sched/act_ct.c
> +++ b/net/sched/act_ct.c
> @@ -986,7 +986,6 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb,=
 const struct tc_action *a,
>         struct nf_hook_state state;
>         int nh_ofs, err, retval;
>         struct tcf_ct_params *p;
> -       bool add_helper =3D false;
>         bool skb_is_ours =3D false;
>         bool skip_add =3D false;
>         bool defrag =3D false;
> @@ -1096,14 +1095,14 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *=
skb, const struct tc_action *a,
>                 err =3D __nf_ct_try_assign_helper(ct, p->tmpl, GFP_ATOMIC=
);
>                 if (err)
>                         goto drop;
> -               add_helper =3D true;
> +
>                 if (nat && !nfct_seqadj(ct)) {
>                         if (!nfct_seqadj_ext_add(ct))
>                                 goto drop;
>                 }
>         }
>
> -       if (nf_ct_is_confirmed(ct) ? ((!cached && !skip_add) || add_helpe=
r) : commit) {
> +       if (nf_ct_is_confirmed(ct) ? (!cached && !skip_add) : commit) {
>                 err =3D nf_ct_helper(skb, ct, ctinfo, family);
>                 if (err !=3D NF_ACCEPT)
>                         goto nf_error;
> --
> 2.55.0
>
