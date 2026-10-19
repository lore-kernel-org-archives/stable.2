Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792442028;
	b=GeIWSAeYL0ucZBqxFCcNeajAA6HXlYKyZl/lLb/U4EMHnzY8odRtAtGWR3dFIyfsZ8vn
	 4xoK2TlaY8rS1937vzSMZXarlPmise/bjlfuPqYvFJCYNBl1W746mw5Gy46DFqGKNXSNj
	 1FvBllEvscf44Crpf+LlZzlaI3y8eC1fq7g142ToUoXJ0BiuPdqE/jLqxfC2GTa/Oz3wL
	 icIykVPn/nxOtXsJCZtMKv8ZnZAQZ41qv48/UUUFYHXB1/0sfuO2YVkRvJREA2AO7hYUf
	 iaXBTxWokvjsQNqyN+UrQsz4Be51SOZH1067E2FvUqjTq8IluxQWB9ovucYNpAQhPDA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792442028;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Y7T5iwCFDP7hg0heh3HDw1oJbqflVFC2TJRQE7Ow7l4=;
	b=0hBHsD7Cu9+KBxeFNoLmkW3dC3kAuKbpRaglqLwuQDR01RtgfsJuqTvs2SGdcvgJopmH
	 fCn00iY85xoySF2mTNyRUdqoZ7U/RQ3dVSmZ1fvmxLxg8DTjZRvJoqlmR0xlgk3rJGypB
	 lTOyIblGAOGedc79zuOUrA+r0D3HTXKNa/oTFh1b7KwKwsClzLF9i9h8bsz+ipl06Hm85
	 ijFxNwxMSSzINZK+ROzuz9sdE+3MTfBNMVMJEsiOmLKvbEHy9gNcDwFwfZrlEZGyEbR2u
	 1xaKpl+qRQWmUweaRCJ9CedndWiesN6vhBxf922JCDpWEqm3Bw5xS9EsQ/ryua+SKHw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WgWTrwn8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.179
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED118606A319
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 20:33:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED118606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WgWTrwn8
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8b056d58f2aso20378567b3.2
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 13:33:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792442027; cv=none;
        d=google.com; s=arc-20260327;
        b=DtemKncxz8OslnpTZHVWM9OUnpFOyN+xU0XgDIP/v+C4NRHKeF3juxt6j8ugvb+5HK
         oFp+If25DsvJISkDVqnK0XBSucyVB79ESMhD/AGu1R4AedDGYcwiYjVpA5EUcO0kP1KW
         MKm+/COmxDqdpsYtWwTO0ZYzOmgmx3M6ojktUbcIXOOmRNT8itt/3IJiafrIZeI98xzm
         RKmMVdEf3jxgap/tRuUsdnPMfGq2UseE3PpgXLGWg2hJORNWuccsNhgEMLvWXe2lm9Qh
         KuRBIJjkLyxZZr7AeWdzddYVaUlXcHKLj8uJf+FJWUpmDXA7pieGw67T1Ija8I3wuGzn
         NSnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y7T5iwCFDP7hg0heh3HDw1oJbqflVFC2TJRQE7Ow7l4=;
        fh=5dBiB7KHUGxsb2JFIC/9bPra8zMYsV6vp/wWD89kVHI=;
        b=fPAvdxCftQZRZBu/EFtOaOrgQYd4Xmmi4INH2FuPkrRRmVaw00FvraACpJ7K56G+7Q
         O8DDClSWTo/78cCxTwRNXS3HGMKWPArpsTQaw9jPQp1apPUncneku2IoZFr5BpIgNbOe
         nVEaLXpFMGgXxPwK6ZvW04fMSsvEohx/3hN4U5ts/DKAZN0IdjZJCErDvp4TINhAsOa1
         FGuMsE9+IzAGypIPz7EOwO0vUGADHEbaDK7BDlmLpLwcV1qXEMdaLWcj9uGjBLyEwOYJ
         +EzbeX3qW355SfZ8trPXmhgOlEjz+qO/cJsMeOHtL4H+2I98Fn3Lv4wGu8hx1Ttk7V5T
         xsWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792442027; x=1793046827; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y7T5iwCFDP7hg0heh3HDw1oJbqflVFC2TJRQE7Ow7l4=;
        b=WgWTrwn8K2+bsQFKs2mSvb25qUO0dNSUdjAG1ns3/fwEJG1v4obvdOXd2y9524Bk7Z
         CkULqNa5b9XA3zD+OK6Z8S3/tJCKxr/+r1LGMJBoObGIvxgNrsKdNvpE882PMX9CCA77
         hi0OG55MWEtZNvfEpEa6+OxO7FAj65Gs7ZF2zkBDKCUbMfw6KT5YF38bVMc4oPea6zOj
         E+zFFKmOdDgARKskI2/7YJbE8FAI8hcVwGxC0fgWDFwc2hbUu5TOJSNdi5M0b9x2RLPR
         pnYPWEbzIloqumcgfYdhM3lzMnc6dvrpOlSlGdlnZ33I+/Zmls6DSKCG9imw6BALnaAw
         Y8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792442027; x=1793046827;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y7T5iwCFDP7hg0heh3HDw1oJbqflVFC2TJRQE7Ow7l4=;
        b=n8FtVTN5Bvp9x5circpuRQusx+gk8g3qxhemB+p3HAo4a8GSXdoR4p8xyD8O7PS/3V
         lVBXvh/tINXNJMS4ZtPkkhbBl+glsE1VxnztR4nyNVSDn6FCI870IcenDVtKOYRlC2dy
         5tLxby8+jSVOqhecuzJ+fIEVsYl4O6CxlusouskFw+tYXiJqO+jDeDAnJ4sT9WOyU4EN
         HFlQEmPMmdl8CHFM99zsSbM7BiaA8Q2bzzA6gj/0qSRfVoFl8AqPbMnEAI2pKYs4klYZ
         9MKC3Ul3ukyBRMRWSGfkjnamdFJ1EabPl1XtZhjygHk2MVXd5k9/e9uJOrk52WqLKMK4
         m3Og==
X-Forwarded-Encrypted: i=1; AKwUvBxsl3vS9K11ab3nolUNVr9rHIKwi48nAFnL23+Zlc2ak8Itm7GcFHp/8d68dXyM4QoihVa2zsM=@vger.kernel.org
X-Gm-Message-State: AFq9FYK4npVpcN6A6EfzFRrSBbwq4P4YIvOzbPfUuDNLclB7si1cdufB
	eYNljyRWZJZIwIoDpmn818hFDuNsWYNhOEKXu475QMrI4vwjz1IFWjWyONneYKi41GnwbNfTClB
	MDR5FdFg83lSDQfI3fLHtudlfhE3bH7I=
X-Gm-Gg: AYBFou2WGR0bVAicjYlIm0LYIOLaRXwXR7Hs7wM3vuE1HMqAWY2Td+re4dBL/s4AnCG
	SFxsWO/FC+AwyJZrTNKR/HDt6NngUbzlNj0rdNjD51kDJH1OtHIQY/aaeqp1hmNPRlgalSFVU8m
	VgHjAjZr+vp+bq34WWV3IfXbKOBjUpAx+0FrtxYPZpnCHMGkLvlVzVq6pyrxagkOJN1Bx1Q3tKr
	bZoSG9nUvYdjQzvJjr8wN6ucPrPhXT0yu4PY3xkaVan7xOGAPWG/jxhbRAxm3J9kRkgzFYuh+NI
	XUNdu+SNyE7ajO/X352REMQwHPnntKRSBeIFdNeeF1nok/hWYCxL5uvGZVKx6De7vZXdlCKQmjp
	ONIiVhrNMtt/PiatMWOqPkTX8+E4/zPUvUmvsElBupV59LimxdFKGM8RdGYWCyfmSvmPuHvwtf0
	WaO/vcTZPvjveo/t809R25/wg=
X-Received: by 2002:a05:690c:f91:b0:8b0:e680:615f with SMTP id
 00721157ae682-8b0f2072ae6mr28736617b3.9.1792442026685; Mon, 19 Oct 2026
 13:33:46 -0700 (PDT)
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
 <20261017050928.128582-2-sidchintamaneni@gmail.com> <CAGsJ_4wGq9oc05=-g4aWptLdCbTwUjMjXk4Rd6KjJ6x=tzMm+g@mail.gmail.com>
In-Reply-To: <CAGsJ_4wGq9oc05=-g4aWptLdCbTwUjMjXk4Rd6KjJ6x=tzMm+g@mail.gmail.com>
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Date: Mon, 19 Oct 2026 13:33:35 -0700
X-Gm-Features: AclHuK_VFblb2-qRhJWRPlqaC_e3NKRbx_LiB-tHmq77IBIhW4V1ck4pMMbCmjE
Message-ID: <CAE5sdEhGFtGF6LC4xNkMwGj3vTxLOW=GNBXnk3-JmsgjntXx0Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: multi-gen LRU: fix NULL lruvec->pgdat deref in get_lruvec()
To: Barry Song <baohua@kernel.org>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, david@kernel.org, 
	mhocko@kernel.org, qi.zheng@linux.dev, shakeel.butt@linux.dev, ljs@kernel.org, 
	kasong@tencent.com, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, baoquan.he@linux.dev, baolin.wang@linux.alibaba.com, 
	yuzhao@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	apais@microsoft.com, rlmenge@gmail.com, stable@vger.kernel.org, 
	Hardik Garg <hargar@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 18 Oct 2026 at 14:24, Barry Song <baohua@kernel.org> wrote:
>
> On Sat, Oct 17, 2026 at 1:09=E2=80=AFPM Siddharth Chintamaneni
> <sidchintamaneni@gmail.com> wrote:
> >
> > Andrew Morton reported that get_lruvec() has the same problem as
> > lru_gen_shrink_node(): when memcg is disabled on the command line
> > (cgroup_disable=3Dmemory), it returns &pgdat->__lruvec directly and so
> > bypasses the initialization of lruvec->pgdat. The MGLRU debugfs
> > interface calls get_lruvec(), then dereferences the pgdat pointer in
> > lru_gen_seq_show() and other paths, so these can hit the same NULL
> > dereference.
>
> So userspace must have booted, since otherwise we couldn't read
> debugfs. The reachable case is therefore a memory node with no
> LRU folios when debugfs is read? So this could happen on a multi-node
> system where folios are landed on other nodes but not on this node?
>

That is my high level understanding. I'll let Andrew to comment if I
am missing something,

> >
> > Fixes: ec1c86b25f4b ("mm: multi-gen LRU: groundwork")
> > Cc: stable@vger.kernel.org # 6.2+
> > Assisted-by: LLM
> > Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
> > Signed-off-by: Hardik Garg <hargar@linux.microsoft.com>
> > ---
> >  mm/vmscan.c | 15 ++-------------
> >  1 file changed, 2 insertions(+), 13 deletions(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 0c57e4f1eb15..99e9f07fa2e1 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -2745,20 +2745,9 @@ static struct lruvec *get_lruvec(struct mem_cgro=
up *memcg, int nid)
> >  {
> >         struct pglist_data *pgdat =3D NODE_DATA(nid);
> >
> > -#ifdef CONFIG_MEMCG
> > -       if (memcg) {
> > -               struct lruvec *lruvec =3D &memcg->nodeinfo[nid]->lruvec=
;
> > -
> > -               /* see the comment in mem_cgroup_lruvec() */
> > -               if (!lruvec->pgdat)
> > -                       lruvec->pgdat =3D pgdat;
> > -
> > -               return lruvec;
> > -       }
> > -#endif
> > -       VM_WARN_ON_ONCE(!mem_cgroup_disabled());
> > +       VM_WARN_ON_ONCE(!memcg && !mem_cgroup_disabled());
> >
> > -       return &pgdat->__lruvec;
> > +       return mem_cgroup_lruvec(memcg, pgdat);
> >  }
>
> I've been struggling to understand why MGLRU needs its own
> get_lruvec() when mem_cgroup_lruvec() already exists.
> With your patch, it feels like we're one step closer to
> getting rid of MGLRU's own variant in the future.
>

I agree with that! I'm happy to send a follow-up cleanup patch to
remove get_lruvec if that makes sense. Not sure how it will affect
stable backports.

> >
> >  static int get_swappiness(struct lruvec *lruvec, struct scan_control *=
sc)
> > --
> > 2.45.4
>
> Best Regards
> Barry
