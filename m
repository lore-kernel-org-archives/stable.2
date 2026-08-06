Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068E33905E4
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 18:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786041518; cv=pass; b=Q1HFmxbX5MoM4HzqRTfxMfDLuCfBQBtsKS00Zq4BaYq7KPz11vVegDkKbYDASgU3K6WpSVh1hrSBOjnKD9FfITAIFabDfBGlbYPF6nD/N1BMfvb1WJWTLWN46SHPL1aG0xuccRb++FcWTOXSFh6M4cKMFxu6PDy7zr2CkGN+3Fk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786041518; c=relaxed/simple;
	bh=QS8nUk2MQLUFkRJi6/rRGSU1OrivXfXKT078jkhl5co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ol2ifdKPx3ogLXb1JG56k8BOo2lT2sfh6y+OkJoXttDGOuof0p7qbqLgAI0trTxT9Cm1Tu+TPbFfth7LaN85rQrd8T0gM5hy0/HfsF2GEDkBStWFPb3cDIVFb28j7pQksQmmg5xbL/4hLNrPQhiwyIjSYUq/1u3m5cIgqr86ejk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=OFF/lH54; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="OFF/lH54"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84a652535dcso1751769b3a.3
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 11:38:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786041512; cv=none;
        d=google.com; s=arc-20260327;
        b=bDZbZLGWY2qtqqFMv3wvfyQX6UK2QQhzfKNe2kzoZlgfBdxCnD8xG7SPD5ERaGJqdn
         uPLgCE6zTuxmydOq3F9md4YVUk8MCrwVSKvYpg2EdPuM4pW2PNPf+Ji7R1V1bNrCbrI+
         p71kNwpNuY0IzhJKvCTRIkXykbgqETEQCauP5Mlmh4j86aOoYOpUiD1544+m0G39ejMz
         wNTiJEfNfxNNkhhL15x6v+h3oL2E4c0ShyOI1OC3al9ScAGuXl/BpukZAjb0+V7leNP2
         hqiYkXuazNMKEyzaXdRpY7Ryo49znoU6Knlw6P1YNF2Cn8AA/t1RyP2ZdfKxY3hXR/de
         LYdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UzzSQ42c6CqUCkgPR4M9ccrX37Kn1FAe7+/9Junovp0=;
        fh=k6v9yptHHlPFJ21wT1afJ435wXo69pdmEWHXKehj4Hk=;
        b=r/W0s04mrSiKiwEwh22aVP6bSCSf1TGIlxcOA7uzb63ccI05LCIAsIEujVsNsKvKu6
         1eSJYoEjueBv4BV/+DVQlT9JIUYGeilqrp7721dVKqib/FBkAv5WqNHu8giWtS7/2Fod
         oyD9Epn3yD3fmiOpsJApLdyRnkZ1giP+kYycvF+OOoG/BdhrWGqibT3irAyQpPSg4SLW
         3QtqwtMJPxIaFFZo6S9Doh+E2P+rmML1qqqH7a69mJrihgk3gfCnp0+HS314wCwzKJW5
         26nxA/d9w7N3ix00xz9mtYUrQUTENV6tRdQ2L83ojQI/uGkSi1SP/k0VYilDBR7ga2vg
         n+cA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1786041512; x=1786646312; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UzzSQ42c6CqUCkgPR4M9ccrX37Kn1FAe7+/9Junovp0=;
        b=OFF/lH54Dqglld7L3oT8dLouWySG2ob5FU3EErHVtg1Q6id1t41VF1DdKWMpLvUy2r
         Agi/cJUU5mjPaPS6I6pFHb1BLmP966w7y1KQ1pAiaTX52cuUd78psEktS9E0sYzTvJML
         08DvakAf0YFNwe/ULr9168ujMzS6HmBDaeZSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786041512; x=1786646312;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UzzSQ42c6CqUCkgPR4M9ccrX37Kn1FAe7+/9Junovp0=;
        b=qXb7PnmxODNeyZ+HJqFlUfuX4LR9L+JEg2x3tmBOArhG3UDIi/NkWvoCQFJHoqfcJo
         Ta9cw/m9GcHpwDYY8h8MzIHzntBGtudIgmJUFiNBIgrCFO/U0PKFsEbmg2IzcszvTPag
         OpdfUgQ4qgYCSd9sLusdDaEBYDQTpyrz/KP4TTdhl9NM30AgUtmIdtifI+Au4NjSs3cW
         VYnae4R7eAcRTbivPJlWfNzdj4l0QdFFLSe6j2LT6mhDgZSPIKYLkZMxEj2cBj448Dz2
         ULqixtHAKDaQ4I2tB0EKx0wfjyRKZYhubEoGBMJJBwzq7RCoE4W8Cgw+p+yWnw1CJmpw
         8IQA==
X-Forwarded-Encrypted: i=1; AHgh+Rrj+FxYgoVBrOx4tcKt0gNWUrF9bVjqxe0/DgnswzWsNssd9sq979SWavFDhiiSUQ83eRJZVmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuwXozjtXeXrmewhI+FZ2GcjPr04NzL5LNMx1KLH5Y+Lf47X+X
	12AE4EmGF1TM1x9GFcpupxSm718fMx6HuEqpqVMSYZCtDhvsVPj+G0NxfTZE+I6sikywNVmNQ16
	k/FbGzzRO9+3o3c6Il4mOSFWz4yfoFSE1jrlfMkkH
X-Gm-Gg: AR+sD11Ch92eFEyvCfcFZfI/Y/YGqu4mQn1acOLIoHoYvcOy5VUqGHuVjX4TYqrUboV
	AzevPgXil1Yrq8MBb8tDXZH8LcZPBjB4VZ8tNwOuCixVAzO6klh862248TVNAwt4T7bNW8sbGcS
	YjNP1GCQf1ikOZJ7tkUNYTBKRpKuCxd5eTjR/KYqh87X6cjseQ0GBKIUWcaqUSyWNxjY8zVTnvG
	YD9VJZ70d3y4/UxSFq3z1QMg5K94DBofF0LgANraMg4yhSE+7MACc8sZgfxTdzdVctYtELE5cNz
	JxcK5FKu2s0FxaYFr9pfBcnRi2bNr1BY1uAyPiC0EdwTfkD2UagO/foy
X-Received: by 2002:a05:6a00:450b:b0:848:76af:db37 with SMTP id
 d2e1a72fcca58-84f2e0147e9mr19156359b3a.7.1786041512054; Thu, 06 Aug 2026
 11:38:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805093012.95155-1-henrymei@tencent.com> <CAM0EoMmZGXhHL2v=AyjR9xSs8-s9EfkA9FkpULqtFBEOUxHQQA@mail.gmail.com>
 <aabdf499-20ad-4667-b289-626c09a56c0a@gmail.com>
In-Reply-To: <aabdf499-20ad-4667-b289-626c09a56c0a@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 6 Aug 2026 14:38:19 -0400
X-Gm-Features: AUfX_mz_-gI0Cyrp0J2uVmWaq9VzcXirckg30k-UyZYmHUgTiUNFzySpc73NRsA
Message-ID: <CAM0EoMmM-7cphQGmfZa+H3p5HjQ71gJ=8J6-HhhRwzAv--74AA@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: cls_api: fix tp_created race losing
 existing tcf_proto
To: Aohan Mei <ljp1205831794@gmail.com>
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	corvus@tencent.com, henrymei@tencent.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 11:28=E2=80=AFPM Aohan Mei <ljp1205831794@gmail.com>=
 wrote:
>
>
>
> =E5=9C=A8 2026/8/6 01:52, Jamal Hadi Salim =E5=86=99=E9=81=93:
> > On Wed, Aug 5, 2026 at 5:30=E2=80=AFAM Aohan Mei <ljp1205831794@gmail.c=
om> wrote:
> >>
> >> tc_new_tfilter() attaches a filter to a chain. When no
> >> tcf_proto (tp) exists for the given (protocol, prio), it creates one
> >> with tcf_proto_create(), marks tp_created so the error path can clean
> >> it up, and inserts it with tcf_chain_tp_insert_unique().
> >>
> >> However, tcf_proto_create() can sleep, opening a race window in which =
a
> >> concurrent thread may insert a tp with the same (protocol, prio). In
> >> that case tcf_chain_tp_insert_unique() destroys tp_new and returns the
> >> *existing* tp, but tp_created is never reset. If the request then fail=
s
> >> (e.g. kind mismatch), the errout path calls
> >> tcf_chain_tp_delete_empty() on a tp this thread never created. For
> >> classifiers without a delete_empty callback (all but cls_flower),
> >> tcf_proto_check_delete() removes the tp unconditionally: a live tp and
> >> all its filters are silently lost while the owner's change() still
> >> reports success. The race is reachable because cls_flower on
> >> ingress/clsact qdiscs runs without rtnl_lock and can interleave with
> >> rtnl_lock-holding classifiers such as u32.
> >>
> >> Fix this by making tcf_chain_tp_insert_unique() report through a new
> >> "inserted" out-parameter whether tp_new was actually inserted, and
> >> gate the errout delete_empty call on it instead of tp_created.
> >> tp_created itself must stay set on this path: the chain reference was
> >> consumed by the destroyed tp_new, and errout_tp relies on tp_created
> >> to decide whether to tcf_chain_put(), so resetting it would underflow
> >> the chain refcount.
> >>
> >> Fixes: 8b64678e0af8 ("net: sched: refactor tp insert/delete for concur=
rent execution")
> >> Cc: stable@vger.kernel.org
> >> Reported-by: TencentOS Corvus AI <corvus@tencent.com>
> >> Signed-off-by: Aohan Mei <henrymei@tencent.com>
> >
> > This is the same issue Sashiko found. A patch is here:
> >
> > https://lore.kernel.org/netdev/20260805134049.927864-1-victor@mojatatu.=
com/
> >
> > Also, please add assisted-by: tags going forward if this was ai generat=
ed.
> >
> > cheers,
> > jamal
> >
> >> ---
> >>   net/sched/cls_api.c | 21 ++++++++++++++++++---
> >>   1 file changed, 18 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> >> index fee4524ad..9ceb2b538 100644
> >> --- a/net/sched/cls_api.c
> >> +++ b/net/sched/cls_api.c
> >> @@ -1937,7 +1937,8 @@ static struct tcf_proto *tcf_chain_tp_find(struc=
t tcf_chain *chain,
> >>   static struct tcf_proto *tcf_chain_tp_insert_unique(struct tcf_chain=
 *chain,
> >>                                                      struct tcf_proto =
*tp_new,
> >>                                                      u32 protocol, u32=
 prio,
> >> -                                                   bool rtnl_held)
> >> +                                                   bool rtnl_held,
> >> +                                                   bool *inserted)
> >>   {
> >>          struct tcf_chain_info chain_info;
> >>          struct tcf_proto *tp;
> >> @@ -1948,6 +1949,7 @@ static struct tcf_proto *tcf_chain_tp_insert_uni=
que(struct tcf_chain *chain,
> >>          if (tcf_proto_exists_destroying(chain, tp_new)) {
> >>                  mutex_unlock(&chain->filter_chain_lock);
> >>                  tcf_proto_destroy(tp_new, rtnl_held, false, NULL);
> >> +               *inserted =3D false;
> >>                  return ERR_PTR(-EAGAIN);
> >>          }
> >>
> >> @@ -1964,6 +1966,11 @@ static struct tcf_proto *tcf_chain_tp_insert_un=
ique(struct tcf_chain *chain,
> >>                  tp_new =3D ERR_PTR(err);
> >>          }
> >>
> >> +       /* Tell the caller whether tp_new was actually inserted, or an
> >> +        * already existing tp is being returned instead.
> >> +        */
> >> +       *inserted =3D !tp && !err;
> >> +
> >>          return tp_new;
> >>   }
> >>
> >> @@ -2254,11 +2261,13 @@ static int tc_new_tfilter(struct sk_buff *skb,=
 struct nlmsghdr *n,
> >>          void *fh;
> >>          int err;
> >>          int tp_created;
> >> +       bool tp_inserted;
> >>          bool rtnl_held =3D false;
> >>          u32 flags;
> >>
> >>   replay:
> >>          tp_created =3D 0;
> >> +       tp_inserted =3D false;
> >>
> >>          err =3D nlmsg_parse_deprecated(n, sizeof(*t), tca, TCA_MAX,
> >>                                       rtm_tca_policy, extack);
> >> @@ -2382,7 +2391,7 @@ static int tc_new_tfilter(struct sk_buff *skb, s=
truct nlmsghdr *n,
> >>
> >>                  tp_created =3D 1;
> >>                  tp =3D tcf_chain_tp_insert_unique(chain, tp_new, prot=
ocol, prio,
> >> -                                               rtnl_held);
> >> +                                               rtnl_held, &tp_inserte=
d);
> >>                  if (IS_ERR(tp)) {
> >>                          err =3D PTR_ERR(tp);
> >>                          goto errout_tp;
> >> @@ -2440,7 +2449,13 @@ static int tc_new_tfilter(struct sk_buff *skb, =
struct nlmsghdr *n,
> >>          }
> >>
> >>   errout:
> >> -       if (err && tp_created)
> >> +       /* Only delete a tp that we actually inserted ourselves. When
> >> +        * tcf_chain_tp_insert_unique() raced with a concurrent insert=
ion
> >> +        * it returns the existing tp; tp_created must stay set then (=
the
> >> +        * chain reference was consumed by the destroyed tp_new), but =
the
> >> +        * existing tp must not be deleted.
> >> +        */
> >> +       if (err && tp_inserted)
> >>                  tcf_chain_tp_delete_empty(chain, tp, rtnl_held, NULL)=
;
> >>   errout_tp:
> >>          if (chain) {
> >> --
> >> 2.50.1 (Apple Git-155)
> >>
>
> Thanks for the pointer. We tested Victor's patch locally and confirm it
> is an equivalent fix for the same issue, happy to defer to his version.
>

Thanks. Please respond to that patch and add a tested-by tag

> BTW, "TencentOS Corvus AI" found this bug; and the patch was mannualy

Also add a reported-by tag to the patch response

> written and validated, so no `assisted-by` tag here. Noted for future
> submissions.

It does look like there was some human touch to it (other than the
verbose comment) - and is a reasonable patch except you missed one
spot.
I am wondering how you tested it. We had to craft printks to see the issue.

I was kind of suprised how quickly you found the issue. Victor had
something already based on what Sashiko said but i said to wait until
the first patch made it in.
Does Corvus AI watch what Sashiko comments on?

cheers,
jamal
> Thanks,
> Aohan Mei
