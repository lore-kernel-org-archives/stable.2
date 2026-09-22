Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA39F5218A6
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 21:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790112918; cv=pass; b=TM9clKGVB5CQWj7yQoK50ydE7e59EcIPtQB1m6QB2XaDiSBLNWUFgfy+lfs7c1UBpTecKLeix9GJRN9yW+GIUVRWN+uVVnCTUbbzzdn9lU0P9sUFXGoKj0RM5+DEEC0aYrsC61TrBIfT0AvkZcDIz2WZsb4L1GvkqwwceUfoVKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790112918; c=relaxed/simple;
	bh=AykXPbaf6N7N+kbqj1LXLFNG32gUtN0fYqtfCBH03N4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sKilB9wTX3qOupHS7aINRPxqBoJ2bLBgwhbljVCcup4XLVrGZu3hGl2wRq13LKn5lsoA32vnwteorU3efdU9xCyOyu8iH5VFd7E6Q9Eu78z8b6lfjtGxpBn3/VAGmL2E0DxcD3QmUASwePTbbTl/5fGaAGI0tkKFZQL4eJP9ke4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=MeTrHKAQ; arc=pass smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="MeTrHKAQ"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85a4329731cso224347b3a.3
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 14:35:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790112908; cv=none;
        d=google.com; s=arc-20260327;
        b=p39+IIXDPg34wt8i9qNIrNmErVJpZs0GXjrkASxNF/S9KOdmVwwFgoDz74qDGIe7id
         ls4bPqczF6DZmcSHIQ6Th873xDs96xoWYVcVWdRZZt9CwTtvyCaw35jCKjus4V/FTvuq
         O0M/itJF32RGVoaFmDszvbOyfWuSS9n2bYe9nrNSgiYS4qvb/ZqcqhdeONJod6I+6LB5
         bOcoZIklloRq3G1u2B9GzcTK8MrxWKD8YeiWfV19tfjN99kQdvalnAoer1NC3WqYm1t3
         df2rmGBXjk0yEgFMQlEmUOU2Y9QA8Lt2odcRE52/xai1QqArOJkVVrNgBNocJmiQ4vBw
         iZNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zc5vA0MxmvP8ptI7+odGF5wXc/aF6DGcCEAEVujLQo4=;
        fh=WR/20zclxQ8/HC6Str93gXafHSG6R42YISVgJknSc7g=;
        b=MYVoLYw5eXj8gNd7vRZOYLQGd6jMCAl5SKJUCdoATYje6nEky/1zcxwoAXFqV/RS8u
         rGm50wAk9mA6IPJjy4RaKgtMcLhjz0/+yl2lSUN3PGmeZNzbVhcIXiXDRTNSE9kBcxnC
         P1ULM8cLaoFQ4CvY2hD1DTLDKbgEt76GGyaQf+mQTkl0nGi/NNa3LKWJAgzeAl8e5ODR
         Dj3jdtsT47QIMSult+4xyhbehCvJlFoGCN1S7R61jUmNZofoJkTsWTGxmgxcDi9o2MSX
         rUECQL3RdJb+RWBYLPWS1KwN/06ER7j01wD06qM/QbDX/pQw2n9WXJRX0/AQpcK8mqwS
         KN1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1790112908; x=1790717708; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zc5vA0MxmvP8ptI7+odGF5wXc/aF6DGcCEAEVujLQo4=;
        b=MeTrHKAQI6NMQjfsR2pp9/+sl71hZZepCzf+EMXyN0UPkfbmSYsQwKw8OoSJU0BTeV
         3f6EjJow7F+x32a3jchFJTis+cUOWzSBqVcpQX63WHyDYv0L2mszLYLjl0lL1kjhCP//
         J58/xCUSPFx0JybkBQyuz+6pGEau2IfykapMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790112908; x=1790717708;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zc5vA0MxmvP8ptI7+odGF5wXc/aF6DGcCEAEVujLQo4=;
        b=LTWs7X2EfTK1k0K88Jn2I/SEVXH8LEEnaIbU5TXjHzxvuO96XesbsmyqW0qFGoRhiI
         pLNUhfV/jz/EbKg7wAf7QnqTDDviYIxTy4CktTauBw/B2tjhVizUu0dTam0TtSjBtWLF
         2pS3LESZ30TjUw21oHC328vyEPipyvMUSRjqJpUtTNSdfjzXfpNTJIk7wRqpLbEM/c1g
         UtovFIDx0HRnLafOD/C66+FSD+fCp35S9Skw6rUhUmYcoEqNmFH0etNJSFlM5ZpRYZl4
         A8D4/CDYsxvfyOrRkpPtqxj/3d+MwoRxRkhoGccx5ZWIF2M193TBz/pINYlJQOTsA8LY
         7b7w==
X-Forwarded-Encrypted: i=1; AKwUvBxFlZuLpPOVEaF9Wd5qqQzxxBvTYqymD+NS/IFVjER5vMOeYvAceT6dHgiyBoTiOB5HMaMxnb8=@vger.kernel.org
X-Gm-Message-State: AFuF++lTSRH+yDPY8wxQJdSO7qiRNIbqdABSoEdbXzmTI5scvUh5PQx4
	fMUplex/2N77JteZfhfHa3lGlyJVsSmrotNZy3+1BVrM/ebnc5903+OSERK7K08bXpglCKCUgxQ
	2FmTjMA6HamjenYzZBtMw7G+uJVG470GhhQDPimYR
X-Gm-Gg: AYBFou1E/NEtGRSbueX3k4qgkcVp0L0CYnVk0KDTJ2826f9CZzmn5vfDIRFQPaqwI2l
	RkQ0RgH/Pcj+6aCevmBY7ZnIBIeOW8WvTcqqmeLnp0rmgrJE8Q2I8vhX9LgeuvNp9FHEyx6ayhe
	buFE6BLsish2M/hjwagN8f4oCOXmfHkIOKGt1XxMbQE0KyU545iqCxDSFo5/v74tvKAIsa3HRvI
	b07EyUoERFpvmEuzET8W1oa0q+7NOlcYEWMm8gNJ2elgda/pnl4RQvhtc6ZPb1SKp2SXrat9Ujk
	C7XP/giObDiBfe7LgOzL4BLmRhWxUtuGdNuowCXlwsV4v/eUrx4IAs4847NnH6wrm/9Eva0SOBY
	/9f4MFbvncX6+zAA7BafyYqW8Dl1rExU4ULkmt4pTrbQh
X-Received: by 2002:a05:6a00:2345:b0:848:30c3:45dd with SMTP id
 d2e1a72fcca58-87d1a7ab57amr763293b3a.11.1790112907764; Tue, 22 Sep 2026
 14:35:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921145655.3167436-1-i.maximets@ovn.org> <20260921145655.3167436-5-i.maximets@ovn.org>
In-Reply-To: <20260921145655.3167436-5-i.maximets@ovn.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 22 Sep 2026 17:34:56 -0400
X-Gm-Features: AcwNN1WrLC44FI1bW09mtnu1BxHzgYsw3RKPzqP-LVQgllRxZFMO1YG1oq2WJAM
Message-ID: <CAM0EoMmKkJ-8snBUMdHqPza3j22zo3bxiL7F79nc8rYhUXE4kA@mail.gmail.com>
Subject: Re: [PATCH net 4/6] net/sched: act_ct: avoid modifying shared
 unconfirmed ct entry
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Aaron Conole <aconole@redhat.com>, 
	Eelco Chaudron <echaudro@redhat.com>, Jiri Pirko <jiri@resnulli.us>, Xin Long <lucien.xin@gmail.com>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, linux-kernel@vger.kernel.org, dev@openvswitch.org, 
	stable@vger.kernel.org, Axel Mierczuk <axel.mierczuk@1password.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 10:57=E2=80=AFAM Ilya Maximets <i.maximets@ovn.org>=
 wrote:
>
> In a case where skb with an unconfirmed ct entry gets cloned, we may
> end up processing both again but with different sets of extensions.
>
> The series of events:
>
>  1. The first clone wants to commit and runs the helpers wiring up
>     the extension pointer into the expectation list.
>  2. Then it looses the confirmation keeping the entry unconfirmed.
>  3. Second clone now wants to commit labels or run NAT and adds the
>     new extension for that breaking the pointer in the expectation
>     list causing UAF on the destruction path later.
>
> While this is possible to trigger, there should be no practical
> network pipeline where we need to process both clones without
> modifications in the same zone.  So, let's just reset the entry in
> case for some reason we got an skb with a shared one.  This doesn't
> affect any known use cases, but avoids any potential problems with
> sharing and modification of the unconfirmed ct entry.
>
> Unlike openvswitch module, act_ct allows for NAT without commit.
> Changing that would be a uAPI break.  So, act_ct needs to reset on NAT
> regardless of the commit flag to avoid reallocation of the extension
> space.  This, however, doesn't really change the picture for sensible
> networking cases as there should be no need to run the same packet
> twice (before and after the clone) through conntrack without packet
> header or zone changes and without commit.
>
> The fixes tag points to the introduction of helpers, since that's the
> main UAF trigger for the sharing.
>
> Fixes: a21b06e73191 ("net: sched: add helper support in act_ct")
> Cc: stable@vger.kernel.org
> Reported-by: Axel Mierczuk <axel.mierczuk@1password.com>
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> ---
>  net/sched/act_ct.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
> index 55f3521edb4c9..e72143d36b119 100644
> --- a/net/sched/act_ct.c
> +++ b/net/sched/act_ct.c
> @@ -979,11 +979,11 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *sk=
b, const struct tc_action *a,
>                                  struct tcf_result *res)
>  {
>         struct net *net =3D dev_net(skb->dev);
> +       bool cached, commit, clear, nat;
>         enum ip_conntrack_info ctinfo;
>         struct tcf_ct *c =3D to_ct(a);
>         struct nf_conn *tmpl =3D NULL;
>         struct nf_hook_state state;
> -       bool cached, commit, clear;
>         int nh_ofs, err, retval;
>         struct tcf_ct_params *p;
>         bool add_helper =3D false;
> @@ -998,6 +998,7 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb,=
 const struct tc_action *a,
>         retval =3D p->action;
>         commit =3D p->ct_action & TCA_CT_ACT_COMMIT;
>         clear =3D p->ct_action & TCA_CT_ACT_CLEAR;
> +       nat =3D p->ct_action & TCA_CT_ACT_NAT;
>         tmpl =3D p->tmpl;
>
>         tcf_lastuse_update(&c->tcf_tm);
> @@ -1046,6 +1047,19 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *s=
kb, const struct tc_action *a,
>          * different zone.
>          */
>         cached =3D tcf_ct_skb_nfct_cached(net, skb, p);
> +
> +       /* If the ct entry is not confirmed and shared with some other sk=
b,
> +        * e.g., a cloned one, we can't just modify it with a commit or n=
at
> +        * as we must not modify the extension set.  Reset.
> +        */
> +       if (cached && (commit || nat)) {
> +               ct =3D nf_ct_get(skb, &ctinfo);
> +               if (ct && !nf_ct_is_confirmed(ct) && nf_ct_shared(ct)) {
> +                       nf_reset_ct(skb);
> +                       cached =3D false;
> +               }
> +       }
> +
>         if (!cached) {
>                 if (tcf_ct_flow_table_lookup(p, skb, family)) {
>                         skip_add =3D true;
> @@ -1083,7 +1097,7 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *sk=
b, const struct tc_action *a,
>                 if (err)
>                         goto drop;
>                 add_helper =3D true;
> -               if (p->ct_action & TCA_CT_ACT_NAT && !nfct_seqadj(ct)) {
> +               if (nat && !nfct_seqadj(ct)) {
>                         if (!nfct_seqadj_ext_add(ct))
>                                 goto drop;
>                 }
> --
> 2.55.0
>
