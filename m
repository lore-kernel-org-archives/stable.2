Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87D1134CCF
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 12:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785242259; cv=pass; b=Ydhsh4cuit/u2nyR6M5DLYZImu6FiTZ2aMDylKXpGniy9Ntw4tlk5DE4eIMz81RMsNJMMexl4Brt7Hy4tzGLZm/P1jLnl1Rc+6OeICESrEa6XUH7/QF+6dZ8o5UJpysuTRwMrfKpFbpF4g5NvYM30LoCFArsF3jkYAq3hQyw7+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785242259; c=relaxed/simple;
	bh=d43Rs91brXcPKKEwTzez/dyG57eXDgdPWZAX1vSfvok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HoYyB0zD4F8ZjCdmePKTwghNMEATprgpNCgYP3uQo4n9HgdfcrGzODkHwfMHg66Z0m7c9LfdD/IDaRITcwV8lwR7axWMahiP5S91cmwU8EpFDKqi6pBAO3GTPmsKQNWcb7E393h/YLwR7oKdCJsERdaqOHiVKL5XrfaGxxILG4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=VIl3GPoj; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="VIl3GPoj"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84830c774a0so3923377b3a.1
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 05:37:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785242254; cv=none;
        d=google.com; s=arc-20260327;
        b=Az+kL3TDjiRSDjcnoOCPPSSKDGtUM64jYqppA1mU16SfRlgPid7cKiZPWlpuuoWkOH
         Vco0pkoplkEGnBIb1ZjBz32JVCvkAefv05M1lqhYrgP9qi3H+/X4B0FlRjBLPx9Uhgxa
         T56iTWuwUJwDWtFaHMos8OoZqNZRcvPJEGGWdpHZPHwXHwUYNvYjD1M5xTUpJgjdV6G7
         kBGLGiug7PkG0QvJ6cxz1BXxzI9QZ86aPjAmTZtJVNgCmT/OlcXKlNRJmzgdE9GLoFKB
         zWPMeiwPJQIVohEP/3lFrcBF0GHXkKrP3lvQEfnKWgtk9mqniWFrUc7fporKoHUAwwfp
         lkTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5zDkQnwmftp1VDlQdX+JfOqMyaFgTS/UoZXjrD4O3tM=;
        fh=Ur9elnc8krgFTcQRoUGNjaXzts7kE9CaIZKgSKF/OxY=;
        b=KgJ2FEriGOCC6bLWXkLOVVS5JMc1mylpuCKpTiac/8Qu+lVSAXLOmtWya44GtpOPYO
         FDOBFcrkwLIXrEeDGLgL+lYwJxWihQuPfUcyy4Ht/nVco35dWTM3smiOcn/lcHimYHqa
         ecBcHzuhvwyp7jic+J9LynieGHnX06yOybNyv3af0nZhubiNCjsvXYOhlWW7G6x1Y7Qd
         3nDuzMVWDQEv4WtbrIuRtC9vKHY+aXjP41v4BT3piCfk3LCACcgQLJedv+Y+lro7L05Q
         TXbFUYbTNtgrAei5Oc2NpQBTrWVJ3qfYMGB4MelNuPyZx99RZq9Mt+ZyjlEIzyiOlNdw
         +e/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1785242254; x=1785847054; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5zDkQnwmftp1VDlQdX+JfOqMyaFgTS/UoZXjrD4O3tM=;
        b=VIl3GPojCp5ikx+eauNbr4X1h3FSbo7xDPiSalI8LO5omoFGVeQyoYrmJAkcVxUmdD
         xTRLH+xg9xPZ47OfzB1m1lE+dGrmGdSpxvK2gJdMdQufERQ+JkkLRDy3tu00sNw6H9PP
         9yJolfLf0OCLipSYyILjMu/X2pxSfOU80dTb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785242254; x=1785847054;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5zDkQnwmftp1VDlQdX+JfOqMyaFgTS/UoZXjrD4O3tM=;
        b=f3J9aBDDOP3fFu2KsduI9O0H0HQRSaoNi/Th51ejupx/zvIw4PMlvqkvlUwG651O2T
         OkV6meYnzkuHGx8h62ZM0rbyY4d8M/CNm9O6a5GPWxcXxcCSMUs9c0I8aK9BrD3VkM6h
         045SER089Y0UekUnL1UeNHXU9rdt/X5XtkMNG+06S5sdexn5Q26/4NITSQPUQeQ+M5mC
         jARxHW4GkFFoHp7J4feKk2dwSq3OJR9usjT0U/icekax0lQGCLNhCsZphh3AiGgSZpLg
         4XahNo5VXTAFQJUIYjAbFt0HRfo4XYTBPrlMvBwdtBuvoUdPcKMUe+09sNRUhwFN/0b+
         0maA==
X-Forwarded-Encrypted: i=1; AHgh+RqKReOre+qco9pms7RLQedxfy/RZefP1PsCFoeQZLeXoW7ZNysdf3Kf+TcU8X1uJ8s9mrG36f8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCJcX1xOKjXdaqAemRWqS8bcjNGGEnYHhUGcGMAfOFbBdZrZGt
	ugh8ZvHWrLS/7XmYDzgdh+cWF841aXXmeWL8vZrk7y/tUXXn3msT7kZdXZQ3C1b4ZbLk/D6Ya4E
	/XY+tZLnWTNViD+/UvczwcP2QJZYsKIX3iK3wLHCx
X-Gm-Gg: AR+sD10rLknPt2AGqSC/A2dMHYwauex1HvHw+XNNQIee5og8Lbmoe1oqpD1l1hJG/5W
	97ICNTpzcLjwd9ZKxi+Wc2KpygCOuSXZ3EJbFhplTr/NcfMiFdfa1HrxdS05/QAthOXBHRoTuwO
	GKoy99x3UyBXc+ZZVsY1zl+7Sg2iWpXbT81wH6JykvwyABCi3I569Endo0WfiO5brrzbCnZc8eh
	nmIWjO6R97EdvZurNhhQjvzdJ7PkUanbTxEuWs5pwXNq8hPESSmPs5rFf5ILqA=
X-Received: by 2002:a05:6a00:2e03:b0:848:2f74:d8cf with SMTP id
 d2e1a72fcca58-84e93445ee1mr2166050b3a.64.1785242254167; Tue, 28 Jul 2026
 05:37:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723105210.817079-1-jhs@mojatatu.com> <3914dd5c-77c8-4f96-8bfc-986f0a00f722@redhat.com>
In-Reply-To: <3914dd5c-77c8-4f96-8bfc-986f0a00f722@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 28 Jul 2026 08:37:21 -0400
X-Gm-Features: AUfX_mylgxC0y7x_aj1ruC33cP9uACCxOajMz9vbM3akA79JRsunZkadgEPd2MQ
Message-ID: <CAM0EoMn6sLJ_OMXY8-B4RE3r9XunFB=OkHbYJ-c-VBpADyO29Q@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net/sched: cls_route: fix fastmap use-after-free
 on filter
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, horms@kernel.org, john.fastabend@gmail.com, 
	jiri@resnulli.us, zdi-disclosures@trendmicro.com, sh.kalluri129@gmail.com, 
	victor@mojatatu.com, security@kernel.org, stable@vger.kernel.org, 
	Santosh Kalluri <santosh.kalluri129@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 6:34=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 7/23/26 12:52 PM, Jamal Hadi Salim wrote:
> > diff --git a/net/sched/cls_route.c b/net/sched/cls_route.c
> > index bd6f945bd388..700f878fc3cd 100644
> > --- a/net/sched/cls_route.c
> > +++ b/net/sched/cls_route.c
> > @@ -297,16 +297,29 @@ static void route4_destroy(struct tcf_proto *tp, =
bool rtnl_held,
> >                                       next =3D rtnl_dereference(f->next=
);
> >                                       RCU_INIT_POINTER(b->ht[h2], next)=
;
> >                                       tcf_unbind_filter(tp, &f->res);
> > -                                     if (tcf_exts_get_net(&f->exts))
> > -                                             route4_queue_work(f);
> > -                                     else
> > -                                             __route4_delete_filter(f)=
;
> > +                                     /* Always defer the free.  The di=
rect
> > +                                      * __route4_delete_filter() path =
has no
> > +                                      * grace period and races with re=
aders
> > +                                      * that cached f in the fastmap.
> > +                                      */
> > +                                     tcf_exts_get_net(&f->exts);
> > +                                     route4_queue_work(f);
>
> Sashiko fears the above would be race prone:
>
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260723105210.817079=
-1-jhs%40mojatatu.com
>

That was fixed in v2. Is there something i can do next time (message
patchwork?) to not waste your time looking at an older version?

>
>
> >                               }
> >                       }
> >                       RCU_INIT_POINTER(head->table[h1], NULL);
> >                       kfree_rcu(b, rcu);
> >               }
> >       }
> > +
> > +     /* All filters are unlinked; no new reader can find them on the
> > +      * chain.  Wait for in-flight readers that may still hold a filte=
r
> > +      * pointer and have published it into the fastmap after we unlink=
ed.
> > +      * Then flush the stale entries while head is still valid under
> > +      * RTNL, matching the route4_delete() pattern.
> > +      */
> > +     synchronize_rcu();
> > +     route4_reset_fastmap(head);
>
> This really looks like quite a big hammer.

It is.
I viewed  it as bug fix to original intent of 1109c00547fc - that
commit even though had the intent of protecting the fast map as as
well (based on the wording of comment i saw).
If performance is a big concern: another approach that maybe worth
considering is to totally remove the fastpath. It maybe more
performant than imposing the rcus.

>Since there is already a
> synchronization point for both reader and write while acquiring the
> fastmap_lock, I'm wondering if something alike the following could work ?=
!?
> (completely untested!!!):
>

Your approach has some holes, example misses the most dangerous part -
destroy(), etc
I will mull over it and see if it can be fixed to handle all the
issues. I think it's possible i just need to put time to
validate/test.

cheers,
jamal

> ---
> diff --git a/net/sched/cls_route.c b/net/sched/cls_route.c
> index bd6f945bd388..8cecc945dcde 100644
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
> +       if (!f->dying) {
> +               head->fastmap[h].id =3D id;
> +               head->fastmap[h].iif =3D iif;
> +               head->fastmap[h].filter =3D f;
> +       }
>         spin_unlock_bh(&fastmap_lock);
>  }
>
> @@ -338,7 +343,7 @@ static int route4_delete(struct tcf_proto *tp, void *=
arg, bool *last,
>                          * notice we unlink'd the filter so we can't get =
it
>                          * back in the fastmap.
>                          */
> -                       route4_reset_fastmap(head);
> +                       route4_reset_fastmap(head, f);
>
>                         /* Delete it */
>                         tcf_unbind_filter(tp, &f->res);
> @@ -558,7 +563,7 @@ static int route4_change(struct net *net, struct sk_b=
uff *in_skb,
>                 }
>         }
>
> -       route4_reset_fastmap(head);
> +       route4_reset_fastmap(head, fold);
>         *arg =3D f;
>         if (fold) {
>                 tcf_unbind_filter(tp, &fold->res);
>
