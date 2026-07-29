Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B2B44471F
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 09:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785318461; cv=pass; b=nx2Npd1+pibOK0/YRo4xOHj9s5isWIKkFMUdCA0a4wBcURqc6AicIhZbh/2/SghF54rtVa/n2YkuthclEOoGnS7Cp20e1EHg0E0WXc2TpBSSylD4shhmyTvM7BM09CMQ7wx+kStlYw3hzQqo9iqsxdaT2UUpKfGQOHw6hfhnRBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785318461; c=relaxed/simple;
	bh=HZ03q6QMCfUNFk72w9SHszDvgpUzynEt5vA6dxAXJmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LocLU0tEEbVKXi2GnZgpZuQyFdYJwPcjwPgfJUs+KlowkMoKWayxtc/Be2dhdHCAW/L6v6qIsO7pYS6188yu9cifSJBtDhFZ+gHlp4+d7vA/bsvHp6Ad4KHIkQJK3p86YS2Ypt3z///PDnMv7uIqUjDGXXcLnNLW7GFqtr+BOn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=ysCbdpUu; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="ysCbdpUu"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84830c774a0so823696b3a.1
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 02:47:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785318459; cv=none;
        d=google.com; s=arc-20260327;
        b=cQIdiZHCo0NdDZ6IozBTvXSoQjmpsbT9PVhJ35vsKa2d3X/PrsgQXuVmysUOnv7B9M
         5pLJjh4JZrDuzfH/KfuKHJBWKsJh+jFHR9WN/siWKm9iUujAZrUOPiUMsH+3k0bKch3z
         Qqaf0bQfCOpGzDLqNnuFaTQdkJfWpfE/4mkhVE0s0w+9qi4eVR0f3/Uniw+KaUlEg0wE
         EJd0f2cEa9ExusHdMzGQ2IgC7Jkfh9+NYZcUca/s8YP7utjPp7rzyu2jHjXwn3SaksN4
         gqsPVkVVrufXtf/a8AZEW9l+M2z2pE9lJYsz4E5jMNE/DzsT7S+LusHSdFre1mZ8RK2H
         1xbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cq3av97tRL0XyOW5kTofSCvaWPbGaGNP++Wd9lP+f7Q=;
        fh=qGJdg5YwEVW+UOKNhrk3GzYTVJUDZsK/4oYz7YMLbIY=;
        b=m4vB64a6mUtVpiFvrcm2lqhV9GD73aR+AlIih645AuPJ/hU/DCqQcRsfmEsTIY47fm
         p4WqHZ8scdKt5q/01mGrWciPcSE4Hazae0EMaog2pFCukFlzAy+RbLjys326+6quRt2m
         xAtMwKixpiaOKzrJ6/AFmcCQY7c0QjVJRtefi2ZIBcGCtE+rpP+eLgfRhCjuh6uboCbo
         r5Hns5VFihD9hH9D8Z61pT0na4Y/XJVKqgOadiL6jATGV/pI3JgDCi99UeUoDw7PMchQ
         nL+tCkhEM1O/uy4bSKPUHehNmtLiJNK1rS3KA+d4ga1Jh77UR5Omq8S93I00zxJ6/+9f
         cp6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1785318459; x=1785923259; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cq3av97tRL0XyOW5kTofSCvaWPbGaGNP++Wd9lP+f7Q=;
        b=ysCbdpUuqQklTyDRvVm3nrTeFqCX2eA1yvGmNlfn409Z0kC6advfQ7PTe/DJjE9+7f
         kWQEAcUHwGZhDMOZASPw8VyYWnTD5UQGBaX0AK65DrmJNRqMnsnkZ6XJh8WxAwNtxSsp
         D+Jvs0msXPBH0DuPIYj+tYRAJVnj9xiLG9LjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785318459; x=1785923259;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cq3av97tRL0XyOW5kTofSCvaWPbGaGNP++Wd9lP+f7Q=;
        b=lvn5OIfkAHsfAKcDJ0PAivlHB4FRCM/Day/8Y4dT8CeLABisu29vKegWCvZQ2bGIIu
         2LtKLkI4YAuXvjOf8Cy/N22o1jFtOW5+V5NGqEcwbu3PgwJzmXFrSk0O6sZCNrLLTfkk
         8mNnfuGXZvf2d+sO2lI9e4JT9xOA9pVkkDNhO24FuLBNGDhrTb2L/Tu7mYasCLImPxh1
         l4VlBSYEqtBYb24vmIwtPS9XAlqUdumzDE7RhSTBjt1LD5FnVzhxU3v2h1wG+FkVEtBA
         eMInxp1fot1xUw6g7w9IkLMp+V7xTLjMy3smltEUCcQn4j55mvD4jeFdVzUTy06rvzA9
         SUuQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrms0gFvCZOlsl5X5AaYZk2yg2jI9m1A4/VMdKnUPmRfJs376YWRFSnNiM1XEG/dR1if9uFpbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIdtoln3ngJFiteXOSSTC8Ogw+3BBuHjNdBjoHJGyJZM9ZmDn7
	hGCUmTWqOY+dRlCjDlom0W4EiHrfqcQ94kjEIPC1iX8+jJ4uYrpKrQcZlVoxrnnoRPTFghBlgc9
	P6nXxrITYvATuDFsSK/TbC08thwP+QHSYtT/4KQP4
X-Gm-Gg: AR+sD13SRFKGVDR44vsxqBocRw7C7avMtNqFPYZ7sPF+Bn+kxZThdAuYzQKJ3X32f0o
	QTjpwOLRi3NhaVsUOTWW69KcAoiz1ewsCX8ULaf6Boxwghjxt23TujltnOqb9NpujS/evy2sfDc
	ViYkUArM3+aX4jLaNZ2lGKJ4xqpCSbuRI1Y3Qim9qsXXBtDkYTgpB3O5ojpDMlmQLhE+b4WSfAf
	pHULFFX0XXnn2pwswE6QSVa1KkOQOj+3zANnkunNjm8uJ+96sExEClksZsgNthljsUdfaA7OSn8
	zgFZBBAc3pv1y/1lR5BBUN8FPMVxu5Eq17i1eZN/R1UwJg==
X-Received: by 2002:a05:6a00:1706:b0:848:8027:cb6 with SMTP id
 d2e1a72fcca58-84e933eaefcmr6362985b3a.45.1785318459189; Wed, 29 Jul 2026
 02:47:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729094411.46257-1-jhs@mojatatu.com>
In-Reply-To: <20260729094411.46257-1-jhs@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 29 Jul 2026 05:47:27 -0400
X-Gm-Features: AUfX_mwgbQ0U7pv5D3VeUXm1gxszOqY5ZeqR6CSf7Ek3QRtFrUAkKnSTcfb0S0A
Message-ID: <CAM0EoMnv4H5Y0xhq6vpATMzuvoPzAEacAu9wGMP4MyLmdG3Dfg@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: cls_route: fix fastmap use-after-free on filter
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, horms@kernel.org, john.fastabend@gmail.com, 
	jiri@resnulli.us, zdi-disclosures@trendmicro.com, 
	santosh.kalluri129@gmail.com, victor@mojatatu.com, security@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 5:44=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> The route4 classifier maintains a 16-slot fastmap cache that stores raw
> struct route4_filter pointers indexed by (id, iif). The reader
> (route4_classify) populates this cache via route4_set_fastmap() for every
> classified packet that hits a filter. The writer (route4_delete,
> route4_change) clears the cache via route4_reset_fastmap() before
> RCU-deferred kfree of the filter.
>

Sigh. I forgot to add v3 on the subject. I could resend if needed.


cheers,
jamal

> This creates a UAF race:
>  1. Reader walks the RCU-protected bucket chain, finds filter f
>  2. Writer unlinks f, calls route4_reset_fastmap(), then tcf_queue_work()
>  3. Reader calls route4_set_fastmap() and writes f into the cache
>     *after* the writer's reset, caching a pointer about to be freed
>  4. After the RCU grace period, kfree(f) executes
>  5. Next classified packet on the same (id, iif) tuple hits the stale
>     fastmap entry and reads f->res from freed memory
>
> Reproduced with an mdelay(100) accelerator in route4_set_fastmap() and a
> concurrent add/delete stress test (provided by both zdi and Santosh).
> Both triggered KASAN slab-use-after-free reports in the route4 fastmap
> paths.
>
> Fix:
> Introduce a per-filter boolean dying flag to suppress stale fastmap
> republishing by in-flight readers.
>
> Fixes: 1109c00547fc ("net: sched: RCU cls_route")
> Reported-by: zdi-disclosures@trendmicro.com
> Reported-by: Santosh Kalluri <santosh.kalluri129@gmail.com>
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Tested-by: Victor Nogueira <victor@mojatatu.com>
> Tested-by: Santosh Kalluri <santosh.kalluri129@gmail.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
>
> ---
> V1->V2
> 1. Fix based on feedback from the Sashikos
> https://sashiko.dev/#/patchset/20260723105210.817079-1-jhs%40mojatatu.com
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260723105210.817079=
-1-jhs%40mojatatu.com
>
> Restore the "if (tcf_exts_get_net(&f->exts)) route4_queue_work(f);
> else __route4_delete_filter(f);"
> preserving the tcf_exts_get_net() contract for netns teardown.
>
> V2->V3
> Revert earlier suggestion from Santosh's rcu sync to Paolo's suggestion t=
o use
> the dying flag approach.
> ---
>  net/sched/cls_route.c | 35 ++++++++++++++++++++++++++---------
>  1 file changed, 26 insertions(+), 9 deletions(-)
>
> diff --git a/net/sched/cls_route.c b/net/sched/cls_route.c
> index bd6f945bd388..eded7aacd3f7 100644
> --- a/net/sched/cls_route.c
> +++ b/net/sched/cls_route.c
> @@ -52,6 +52,7 @@ struct route4_filter {
>         struct tcf_result       res;
>         struct tcf_exts         exts;
>         u32                     handle;
> +       bool                    dying;
>         struct route4_bucket    *bkt;
>         struct tcf_proto        *tp;
>         struct rcu_work         rwork;
> @@ -66,9 +67,11 @@ static inline int route4_fastmap_hash(u32 id, int iif)
>
>  static DEFINE_SPINLOCK(fastmap_lock);
>  static void
> -route4_reset_fastmap(struct route4_head *head)
> +route4_reset_fastmap(struct route4_head *head, struct route4_filter *f)
>  {
>         spin_lock_bh(&fastmap_lock);
> +       if (f)
> +               f->dying =3D true;
>         memset(head->fastmap, 0, sizeof(head->fastmap));
>         spin_unlock_bh(&fastmap_lock);
>  }
> @@ -81,9 +84,11 @@ route4_set_fastmap(struct route4_head *head, u32 id, i=
nt iif,
>
>         /* fastmap updates must look atomic to aling id, iff, filter */
>         spin_lock_bh(&fastmap_lock);
> -       head->fastmap[h].id =3D id;
> -       head->fastmap[h].iif =3D iif;
> -       head->fastmap[h].filter =3D f;
> +       if (f =3D=3D ROUTE4_FAILURE || !f->dying) {
> +               head->fastmap[h].id =3D id;
> +               head->fastmap[h].iif =3D iif;
> +               head->fastmap[h].filter =3D f;
> +       }
>         spin_unlock_bh(&fastmap_lock);
>  }
>
> @@ -297,6 +302,13 @@ static void route4_destroy(struct tcf_proto *tp, boo=
l rtnl_held,
>                                         next =3D rtnl_dereference(f->next=
);
>                                         RCU_INIT_POINTER(b->ht[h2], next)=
;
>                                         tcf_unbind_filter(tp, &f->res);
> +                                       /* Mark the filter dying under fa=
stmap_lock so
> +                                        * any in-flight reader that stil=
l holds it
> +                                        * will skip the republish in rou=
te4_set_fastmap().
> +                                        */
> +                                       spin_lock_bh(&fastmap_lock);
> +                                       f->dying =3D true;
> +                                       spin_unlock_bh(&fastmap_lock);
>                                         if (tcf_exts_get_net(&f->exts))
>                                                 route4_queue_work(f);
>                                         else
> @@ -307,6 +319,11 @@ static void route4_destroy(struct tcf_proto *tp, boo=
l rtnl_held,
>                         kfree_rcu(b, rcu);
>                 }
>         }
> +
> +       /* All filters are unlinked and marked dying, so no in-flight
> +        * reader can republish a stale entry after this reset.
> +        */
> +       route4_reset_fastmap(head, NULL);
>         kfree_rcu(head, rcu);
>  }
>
> @@ -334,11 +351,11 @@ static int route4_delete(struct tcf_proto *tp, void=
 *arg, bool *last,
>                         /* unlink it */
>                         RCU_INIT_POINTER(*fp, rtnl_dereference(f->next));
>
> -                       /* Remove any fastmap lookups that might ref filt=
er
> -                        * notice we unlink'd the filter so we can't get =
it
> -                        * back in the fastmap.
> +                       /* Clear any fastmap entries that may ref this fi=
lter and
> +                        * mark it dying so in-flight readers can't repub=
lish it
> +                        * after the reset.
>                          */
> -                       route4_reset_fastmap(head);
> +                       route4_reset_fastmap(head, f);
>
>                         /* Delete it */
>                         tcf_unbind_filter(tp, &f->res);
> @@ -558,7 +575,7 @@ static int route4_change(struct net *net, struct sk_b=
uff *in_skb,
>                 }
>         }
>
> -       route4_reset_fastmap(head);
> +       route4_reset_fastmap(head, fold);
>         *arg =3D f;
>         if (fold) {
>                 tcf_unbind_filter(tp, &fold->res);
> --
> 2.34.1
>
