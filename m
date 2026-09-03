Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6151305687
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 11:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788436355; cv=pass; b=lpfUq8y1toD3a6/hyBQMJCFcTR/Wh9iRPynLrt7SVwRWXqFXIX2OziB217SKsBXY9fS+2ciMh5hi7csonSXU87m+iJ0SNn6CTnN9Qm93irZDfbYtqu/1j+MG8Ozd6vn3P5VptLIdKSi+3FgF5HImBnEq0G4952nR4CuR6+yDFLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788436355; c=relaxed/simple;
	bh=cyf8uSSy03fEDTKbXlCyyqKkzhQZsEN4reIazhmhJ/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ReR3NKoe9veuA5uwsYreMPuMU7ON2xObeGWzCc8KMR5vf2RCCEXxq7ikVmYpzlH+5LG5w/7ogdpzm73EF+d+cQboLVY5ONvrQi0BiOILxqfvNZ6G2z88kxz+bwU7ozjx4d2t569BM2qNwk9JVAqsSKhTaYL4n6XbRSBF9oDFuG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EVZWoEWw; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVZWoEWw"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6a615ab11b5so313434a12.0
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 04:52:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788436346; cv=none;
        d=google.com; s=arc-20260327;
        b=heEoNsO8lgBFeGFtAKWZQP47qnEl+i4gx8CjhwD0qmLAZkYhhoUlfryVTyQpMPwNQ+
         ZxTIkGPaE+aPZe9rmkm71F0KZDh9ad4ppdKdWA0o9ljOFlBtt7g+IeUOQUr9unxVzvqd
         eHna4IPOasV2p+w44LV0VnmAPJgc5xelBYakvRpF6lrfKutwg5X1CLT+7uN1Hq9KiyXB
         zulR6b9zKV2Udd9is1y2QIHzEB7opbZGnrcI1TwKgoY/Hzke681vPeG6gKOy5SJS0KBh
         +1VRfqpH0G1u1fygKkD0AsIlpndbjon/Q/mll0CQciZ0Jufju13+MYZqBNH16ZXw0vLA
         mp8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L1MtP6gVUVdXDgg6EZ1a4Wt0frubT3KBn7QT3mEi4Go=;
        fh=UcaxQsmLI2dAMKxAg7aAGuIukezoU/N3vgC3AbeWrgI=;
        b=non2yJdyGO32OQNfuI2PgD6T+AmRMqoNZHTN0+42KJC4BxYTbzaomDz3leSLS+9RSF
         7VvQtRGXs/q8GvyS1+VqdA9/Q++lebtfbX9yKfEYqGdtG3ZjFG+KMmw3R6E/90WmOmno
         V2lLV/2DyNeI+kO3eIESNIbWySRsBzOa4SSYpYwu8Qvp1uvKK6XGmga9lUbtqMVhp2Am
         fsTSev4L6sYh7XuOAOzcPihSjy61bOZTJ6WG/+M02ZXwc1B4c7Xl4gPHJv2Wj0uo68jz
         qp8uIwPmgazH5K+Fgtt5TixlvIKI4lucC/uWTzLUq91hjVVk9cG7JGiry/SZmWh4AoRa
         vj0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788436346; x=1789041146; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L1MtP6gVUVdXDgg6EZ1a4Wt0frubT3KBn7QT3mEi4Go=;
        b=EVZWoEWwnTXpQBVOUPsW3Ira8CqsD41zuMVUQb1bm1sniWBr4MIlTJhkz0r/X8mRkk
         dpRC7zQgKSSWzwLKtvAQIqX3pojVL1B3k6miUlf+Eva9HFr4pL80gC4TujOuqKeDFN0i
         CT5y1hk0cNGhap8HxphQZVVut4RgWeDgd4PSXbliX3QNyhSMXr0pITEJgsWX0OnP938i
         I5vqaNdApme5OQgHRilezCM+5LfldYrE3ns5pBdV3EjSv/a59JXQ3oA4Ku1IT54/714M
         70HS6rszsizZyskJIZeJctdpiS/YKUXfkMkXmZQv3FaegVmbrh06WK5fqybB9OuRfWw7
         gQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788436346; x=1789041146;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L1MtP6gVUVdXDgg6EZ1a4Wt0frubT3KBn7QT3mEi4Go=;
        b=fX3JoaH9aGY5Wk1QKnLfLsQbriP7aISy4z5449jO3o7u2Et3fnAw7tDgCJ1qCuwEKx
         YIzyRNcq+cdGk7ApRF+fxFfjWFD0uQMtZX6ohOjZJb0ygTZeh0TRVUOjg6YBnB/+Miw8
         +pUONGcj6WFP66c1qkI0hvWW2++gCZNqcaZH3KtJ3s3hwKW8Nzx1o034l+h4f0jW8LZ0
         21x5kOVSiMeQlRr0FgEsVCBWJ9qEoRoghlZdFWsd3aclU3oPwBfr887LfhO8gvsqzhMf
         eILFaFv3IPwslxBpKNnxnLCDN1xdYPLjhq/FU/bhBcbJsbnnecq8hpFw/ULmDMrxM0q9
         eu0w==
X-Forwarded-Encrypted: i=1; AKwUvBziyMY7a7DKlt17rf1AwRg27DWnjQ+wfVkr9m/jss4tD2aWFmCGK5WqmlSI6NIMG/jWCXFucPA=@vger.kernel.org
X-Gm-Message-State: AFuF++kwDpXIgXF0+5JpazRUPqz2tJuBaaDwfzx8pAX3cmDIYYP9aH+Y
	3gxYoKNP+lfvCCIE64e1BvdVf6C+4uE2ypSHdeTvEdiFWRZGFn/sYNslm24/z/yOOnbEfwmP5Kp
	Zc2pGp946k9zSI1JpNmQz/OhVvuhkz7Q=
X-Gm-Gg: AYBFou2iH1xpjd3/hvTWFsAZnuiggB4V7hZyuWdXXmd3u84CPsuOG8Eh7brRX8Io+bn
	il2rj3OGXmeWUKC6c5OKoKTtjreHYPVbS+sscM6gfeucJwtrL+PhaZb0WPi52Hyc5m/TudR2+z7
	ATksPoUq8yjinb8dkg2RBjJS1Al9N7rFXym0/yCha/0qLjqqoZw1fGj5VpGCdXWpdI/8SQ1Wxzj
	gaiPCl1J7uEFwfuwLq+D6xEwYXj7z8bBMXBKSM6BTctuRPUzum5PigcpxDkTXi3RZQwUtW8evYr
	UczZ4Yo+dnU0401IgVEDWa0pp053jFTQDC/XQ1F03gaSncO/RdWAZw3Y/0JwS8VRPTczjEOzJeM
	=
X-Received: by 2002:a05:6402:440b:b0:6a1:d68:338a with SMTP id
 4fb4d7f45d1cf-6a6818d6c95mr4590928a12.0.1788436345485; Thu, 03 Sep 2026
 04:52:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824152057.216329-1-nicoyip.dev@gmail.com> <apkipe4r500gMfwx@secunet.com>
In-Reply-To: <apkipe4r500gMfwx@secunet.com>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Thu, 3 Sep 2026 19:52:13 +0800
X-Gm-Features: AcwNN1Uqyd2MMrjp6WqTlC7sD8-7Ze3YLOesPy3SU4_qPzuRaxEIC0IFeXGBbKg
Message-ID: <CAAo+4rUt4FBGF=CFCriuMctiKQ=bRjpH45u4pNmyDLugCV6gFA@mail.gmail.com>
Subject: Re: [PATCH net] xfrm: retry inexact policy lookup after node reinsertion
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 3:32=E2=80=AFPM Steffen Klassert
<steffen.klassert@secunet.com> wrote:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> --- Patch [1]: [PATCH net] xfrm: retry inexact policy lookup after node r=
einsertion ---
> commit 55045c9b49d306c47b0ee8e568d224e0bca94a3c
> Author: Chengfeng Ye <nicoyip.dev@gmail.com>
>
> xfrm: retry inexact policy lookup after node reinsertion
>
> This adds a snapshot of the per-bin sequence counter around inexact
> candidate discovery and evaluation in xfrm_policy_lookup_bytype(), and
> retries the whole lookup if the counter changed.  The stated goal is to
> reject lookups that overlap the bydst hlist hop done during node merge an=
d
> reinsertion.
>
> No Link: tags are present in the commit header.
>
> > During concurrent policy insertion and route lookup, KCSAN reported:
> >
> >   BUG: KCSAN: data-race in __xfrm_policy_link / xfrm_lookup_with_ifid
> >   write to ... by task 92 on cpu 0:
> >     __xfrm_policy_link
> >     xfrm_policy_insert
> >     xfrm_add_policy
> >   read to ... by task 91 on cpu 1:
> >     xfrm_lookup_with_ifid
> >     xfrm_lookup_route
> >     ip_route_output_flow
>
> Discovered by: opus-5 =C2=B7 Missed by: sonnet-5, gpt-5-6-sol, sashiko-ge=
mini =C2=B7 Confirmed by: gpt-5-6-sol
> Can this KCSAN report come from the code the patch changes?
>
> __xfrm_policy_link() in net/xfrm/xfrm_policy.c only does this:
>
>         switch (dir) {
>         case XFRM_POLICY_IN:
>         case XFRM_POLICY_FWD:
>         case XFRM_POLICY_OUT:
>                 pol->pos =3D xfrm_gen_pos(net);
>                 break;
>         }
>
>         list_add(&pol->walk.all, &net->xfrm.policy_all);
>         WRITE_ONCE(net->xfrm.policy_count[dir], net->xfrm.policy_count[di=
r] + 1);
>         xfrm_pol_hold(pol);
>
> The only one of those locations that xfrm_lookup_with_ifid() touches is
> policy_count, and it reads it marked:
>
>         if (!if_id && ((dst_orig->flags & DST_NOXFRM) ||
>                        !READ_ONCE(net->xfrm.policy_count[XFRM_POLICY_OUT]=
)))
>                 goto nopol;
>
> Documentation/dev-tools/kcsan.rst states that if all concurrent accesses =
to
> a variable are properly marked, KCSAN will never trigger a watchpoint and
> therefore never report the accesses.  Both sides here are marked, so how
> was this pair reported?
>
> The write side the changelog describes in prose is a different one: the
> bydst hop in xfrm_policy_inexact_node_merge():
>
>         hlist_for_each_entry(tmp, &v->hhead, bydst) {
>                 tmp->bydst_reinsert =3D true;
>                 hlist_del_rcu(&tmp->bydst);
>         }
>
>         xfrm_policy_inexact_list_reinsert(net, n, family);
>
> That path is reached via xfrm_policy_inexact_insert_node(), not via
> __xfrm_policy_link(), and it also uses only marked writes
> (hlist_del_rcu(), hlist_add_head_rcu(), hlist_add_behind_rcu()) against a
> reader using hlist_for_each_entry_rcu().  So that pair would not be
> reported by KCSAN either, which suggests the hazard being fixed is a
> logical list-hop ordering problem between correctly marked RCU accesses
> rather than a data race.
>
> Could the changelog be reworded to describe the ordering problem directly=
,
> and either drop the KCSAN splat or replace it with a report that actually
> corresponds to the accesses this patch guards?  With Cc: stable in place,
> the quoted evidence is what backporters will use to judge the fix.
>
> > diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
> > index 932a313b9460a..5d4e863863dfe 100644
> > --- a/net/xfrm/xfrm_policy.c
> > +++ b/net/xfrm/xfrm_policy.c
>
> [ ... ]
>
> > @@ -2191,12 +2192,18 @@ static struct xfrm_policy *xfrm_policy_lookup_b=
ytype(struct net *net, u8 type,
> >               goto skip_inexact;
> >
> >       bin =3D xfrm_policy_inexact_lookup_rcu(net, type, family, dir, if=
_id);
> > -     if (!bin || !xfrm_policy_find_inexact_candidates(&cand, bin, sadd=
r,
> > -                                                      daddr))
> > +     if (!bin)
> > +             goto skip_inexact;
> > +
> > +     inexact_sequence =3D read_seqcount_begin(&bin->count);
> > +     if (!xfrm_policy_find_inexact_candidates(&cand, bin, saddr, daddr=
))
> >               goto skip_inexact;
> >
> >       pol =3D xfrm_policy_eval_candidates(&cand, ret, fl, type,
> >                                         family, if_id);
> > +     if (read_seqcount_retry(&bin->count, inexact_sequence))
> > +             goto retry;
> > +
>
> Discovered by: opus-5 =C2=B7 Missed by: sonnet-5, gpt-5-6-sol, sashiko-ge=
mini =C2=B7 Confirmed by: gpt-5-6-sol
> Related to the above: this retry can only observe mutations that are
> bracketed by write_seqcount_begin(&bin->count).  The chain updates done b=
y
> xfrm_policy_insert_list() and __xfrm_policy_unlink(), and the counter
> update in __xfrm_policy_link() named in the quoted splat, do not run insi=
de
> any bin->count write section.
>
> So even taken at face value, would this new read_seqcount_retry() have an=
y
> effect on the __xfrm_policy_link() versus xfrm_lookup_with_ifid() pair
> quoted in the changelog?


Hi Steffen,

The review is correct. While generating the changelog I mistakenly
pointed the agent to the KCSAN report triggered for the data race
already fixed by 66817a979426, and I'm sorry for the mistake. I will
send a v2 to correct the changelog.

Best regards,
Chengfeng
