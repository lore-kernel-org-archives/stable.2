Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792450756;
	b=LFGFrUYlDNOVjP5u3LAswym7Ik1izgyPcl7FK9hpH+Px8Oz01cFOTtBxAxlaYZnPj6ju
	 QOx48uK+Dpb3WG04oIpV5ihnFKxyohYYONh/f0hvAuGo+9GO8m3K8iZNTay6Qe8vV0mUL
	 M3mdgb1Rom8Xd9pGzEvBqochF4AGNyvx/AvAEGV+uZQV3Zef7ceS114ZVDgJpMuM3+1tS
	 kQoHjAh4mKSR/UBYu9ZePOZzgXV3eh9bZ7nI7LPXcopfrFKMOifeoqxqX0l42UNRrc7Xx
	 uxqp7nF/TqVUh4lasdTHx0ysCpCebcLcCt4wClRYtGOod/71XU1hElmAv2V+pqSNrwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792450756;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=NP+3b+jU6Pt4iOuSZnbpymTlb8HWqG2TQ0sFosc2A5w=;
	b=gDuXxBtmtgmr/zLSzu+gGnj/EC6p56Py2H74y7+Qj7PMTRiu52s8mVqzVohrgrNgAvWj
	 lCWSNsX1sxVRkmETuN8jrh5dXRRaSfrWkmjEtdcqC1IxYncVxjKYy0fUhj88+Tv2rWqM9
	 hZuMZIsaQ4JHqPE6z3lmqr8BQxNG28aJ05+1lpHm8KteTgRazCN81STLcAMF5rIwSuW8s
	 Hln5+HgQtsXxYDC3zTIiMOpAsn4D/rpAr+TWsHtJ5/qF/cJUSmihPihlRl85FLLFXjZVk
	 jIS8wRoP0Qh2ibKFlAFmb96ix8RUUiiDHEIKTdrd2yeXrFXlDXOpO46nB3/iqnzrI8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MNJjoBHi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54879606A31B
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 22:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MNJjoBHi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 316FD1F000C4
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 22:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792450756;
	bh=NP+3b+jU6Pt4iOuSZnbpymTlb8HWqG2TQ0sFosc2A5w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=MNJjoBHimcx20jKOW/IMI37c/TKoKlswb79hTiw2MdNfLWw6RtMo/Kc7JRdCJTzqB
	 fJn7w1UREkj6XcT6297vv9bdYz1XAvGUVOu3ymMNNlSBkpwuxCASqvPE4CmpZ4Ydki
	 JaaE9aHmuOJo4O5tB5sjJ6sngJ5LvXvu/sM42xnsg44Z65+npkpPPU6h888UegA+0F
	 mnzt5c7t+N00nhn0meFBWPa1fsL0tgUwc5EzK4+/HihprhMZDkpxamkTI5ARZH3Z4K
	 CZasiwVMSXAiHBSUhU4g6OCC9lk4I9O5tP12zDOiI1swu0nwgZojFeyx3NOMkNgHR6
	 dY8pL3gyiQFpw==
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-91b8306b9f8so40189016d6.3
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 15:59:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy1D+ht1D2xuKFmlwhVA8bUlb9shP1qim/QuuzfVpzqgpKEEzFku1RPr8MC17mOZDTurnIaa2Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYIU3CUxUQJd+3gz6bs0q8V2EeH2d2McOV+lIOpgj3wX4EkBria3
	OCLN6o6RcxstKm0nJ9TqFqr1vH2VHfoG6uLfwquO3it/It9EkQ2bq1bvPNLfZ8fjBqDwVkiDVhn
	6ypkzlyRmykcRelKR4VRhBumlJkFsres=
X-Received: by 2002:a05:620a:40d2:b0:93c:6507:a6e2 with SMTP id
 af79cd13be357-93f29dcbfc2mr1496702685a.65.1792450755627; Mon, 19 Oct 2026
 15:59:15 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261017050928.128582-1-sidchintamaneni@gmail.com>
 <CAGsJ_4whqGRQ4JY5rLLJZU=f8u5T75qHkJYQFDoqZSx5c6EBHQ@mail.gmail.com> <CAE5sdEgR3C30xMayXJkWOECQTfADHgNE8Qf9=wjB5eGimjwLYg@mail.gmail.com>
In-Reply-To: <CAE5sdEgR3C30xMayXJkWOECQTfADHgNE8Qf9=wjB5eGimjwLYg@mail.gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Tue, 20 Oct 2026 06:59:04 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4w2ZSe+jot17v1SUqeWsFaj+DJmckZA=js3FQhUt66Fjw@mail.gmail.com>
X-Gm-Features: AclHuK84pjR_fzDL7jQ8QK-VnmwljGUwwh_bnpTXVDshBNZKrTLHqRnrEMTBSJY
Message-ID: <CAGsJ_4w2ZSe+jot17v1SUqeWsFaj+DJmckZA=js3FQhUt66Fjw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm: multi-gen LRU: fix NULL lruvec->pgdat deref
 with memcg disabled on cmdline
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, david@kernel.org, 
	mhocko@kernel.org, qi.zheng@linux.dev, shakeel.butt@linux.dev, ljs@kernel.org, 
	kasong@tencent.com, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, baoquan.he@linux.dev, baolin.wang@linux.alibaba.com, 
	yuzhao@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	apais@microsoft.com, rlmenge@gmail.com, stable@vger.kernel.org, 
	Hardik Garg <hargar@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 4:37=E2=80=AFAM Siddharth Chintamaneni
<sidchintamaneni@gmail.com> wrote:
[...]
> >
> > So this happens before any folios are added to the LRU and before
> > the userspace init process starts?
> >
>
> Yes!
>

Thanks for confirming.

> > > Fixes: e4dde56cd208 ("mm: multi-gen LRU: per-node lru_gen_folio lists=
")
> > > Cc: stable@vger.kernel.org # 6.3+
> > > Assisted-by: LLM
> > > Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
> > > Signed-off-by: Hardik Garg <hargar@linux.microsoft.com>
> > > ---
> > >  mm/vmscan.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > index f11491ee9ed5..0c57e4f1eb15 100644
> > > --- a/mm/vmscan.c
> > > +++ b/mm/vmscan.c
> > > @@ -5253,7 +5253,7 @@ static void lru_gen_shrink_node(struct pglist_d=
ata *pgdat, struct scan_control *
> > >                 sc->nr_reclaimed =3D 0;
> > >
> > >         if (mem_cgroup_disabled())
> > > -               shrink_one(&pgdat->__lruvec, sc);
> > > +               shrink_one(mem_cgroup_lruvec(NULL, pgdat), sc);
> >
> > What's a bit weird is that even if we fix this here, with an empty
> > lruvec, we still won't be able to reclaim a single page. But it's
> > hard to see where we could break out early, right?
> >
>
> I am not really sure about simple bailout logic. Please let me know if
> anyone have any thoughts.

No idea. I also feel it might not be worth doing, as this
only affects very uncommon scenarios. Some unnecessary
reclaiming is unlikely to hurt real-world workloads, so
there's no need to escalate this into a fix.

For the patch,

Reviewed-by: Barry Song <baohua@kernel.org>
