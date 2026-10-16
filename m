Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45233CF1F2
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 12:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792152733; cv=pass; b=UURuS5p2cLypULYot5M2WGzleM/32gebonrxZZoLukCmeTHXivyARyBuGZh/MUnoDQcNwd+9XO4f7kkpCTuB7WyN66hCdKTk9mijWG2qqgweJTZjAoBH3YiN3tEmRilN8s2m2ppz4w0YMLFhzOMilFJCojDSreK+R4QIpw9EdIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792152733; c=relaxed/simple;
	bh=6IYjp02uYmxvMluUbWofrgoM9m03JSf8XQivc0rvedw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vy3WJAykDJF+P6W6oxBSZjxWQJQ4HyxIh9xP2GNVscL4+YRRqnaA8HoEfPR4BCgAntyOWb7h8eEpB/aYJUZaNRyum3X+I1oj/gCvjXnmviQXV4oWaoiDno3FAZdeeHivl4F5pyUzR3WXyX/ouJ5GiJTSPv+dcfuvT/q245DD1W0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KsMCenwG; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsMCenwG"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b1aa29e06bso5537771a12.2
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 05:12:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792152729; cv=none;
        d=google.com; s=arc-20260327;
        b=nNojNdyvkcTf6uhk0acehh9KPE4KWveMg2eUB/erusL38E/DL5Cszf29GADR1rj81o
         dRJfqbUIVxNV8asd7QTZwZgtO7nkqa0tiC0Tq0Ro6N/o0/aQJwICbW217QGbuboF0gqz
         17a5hvFGlzvR5lRIUbfHEwvsaVzJHmJ6tt6dtqkx6xy6g40AAwBvsaWmp4aYnXK9O7TC
         1j9DG4nrqhaDD3PzUzKykql7/B7lavAlVKSfue5fkNDG0+l3BajhkZLiCQghknGrWO32
         Yw0bGMn9nJ1hKiduRdp/3EnVstYk+j5IXiLgHXtTCs1SPpeeL0pb8JavXpGWrJ1YVssS
         OdbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6t2J8EE3L3nlE7G0BZMfNQxPefv2h/6dn0nY1OvRibM=;
        fh=tOAiohDckOn7biZfiArvIk5MMOgnA4HUHH9o+wmD1UQ=;
        b=BYb8+cmMkZgHEflf00sBE5FEfqIOpMeckWC/zTteehe+Ou1qiiunTK5Hue2Hwxlq+5
         TbeCX0F/pHU8MsIODkwRZr26tfxBKnxrkQxK05xEjrgt0dmAPxvlTun41k78W2iODUVz
         ptzWeGE6FgDwtnnUGkCAwAjXj3SLs9Zylhe1Zn6ORdfIyHUD9IWN2UHzsXQa5aV1vmLp
         /iNDyK9YfSwzQFPnXg+Ihudkq/HJLuahi2NYipVFWkF8agn2jWCTR6tNvxXfAm+xdwB5
         vXp/DqoRwIWTEp/YKbXO06w4BFV7717XlXGzP4ntIzV6EMfYiKasSjxCmeG8rLEmShIV
         y8uQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792152729; x=1792757529; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6t2J8EE3L3nlE7G0BZMfNQxPefv2h/6dn0nY1OvRibM=;
        b=KsMCenwG4UKWLxxBE6KqU1ddztmwWw4k1EAO0JaJSOVkMOvywgA28VEnyrrKZKZUiw
         K6GuKxuYyH3yiJbJjrrqfXCdu80PO9CvtJ+9ngNS2ngF59q+OpZAbKlB1rcvLh5kiJ5v
         agsC3bVm1aZPz2k1ERTKIuLLjmZQN2k3G6ulezBjR0NOyilLM0vL2ev+O73fyhwm5feH
         Bh5no+EhvL+857OvptDpIvJ0pgIq40xAlGMcLWo+lp37iB80ZDNPtKaHWYuKKMlMyxAx
         SzUN9tx7eAtgrBICXvoa+A4tJ7Y+FC8MGVf4hmwQQoIooOVETYMM7kLJf4Gur47LLDKJ
         QNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792152729; x=1792757529;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6t2J8EE3L3nlE7G0BZMfNQxPefv2h/6dn0nY1OvRibM=;
        b=qaMc8mUiy3mS4xayNu8YKQRTX0xzAPzUBXRcOyYAMAp5DtyBK2/r1oAeC1t6W1WDyU
         q0S2bUBUI0QBigBvE4fzAvuuxX5BrhSe6plK/43RAqQKmihibFeTCo1rFaLezcSnn+qw
         4k6ZBWHDuFFVBqI6iLypu38M3HVx1jmWLQjqPdgz1Mlv3hxeu8KyzkVUfutBdhix7gkN
         z37SCyyG/MReBVqBVA/Jgp1fKTHxmXfismOz2chT86qrpPwfEQsiQ82umTezZbDQalMv
         ZXjIBCeU1hImgFK+jmCKgCOPRmKx9pOn9NmAUZFspKQiqaXAt8lZLTKfCged2c4Nte3u
         cjDQ==
X-Forwarded-Encrypted: i=1; AKwUvBwOPF3God7FkiuG3wA37FD67C87l0513bC4cEIz3Ge4OC+lth+GDVeB1Kt7EuMLZ2WUF5UgxAI=@vger.kernel.org
X-Gm-Message-State: AFq9FYI/f6XYr7hc2Vf8i7EI6hECM4ZmQHtQlKPNlPFYBGJ9DIlConHm
	MKtOEFZyAe74I5Psl6OJ1VbLQxWZteoFyQJ6X+09k84Sw8G8hzyqy0a8Q+Inyhidvclfdoo9IL/
	H1ImeTKrUA7ShqQhQMdCpnwi4kGEms1A=
X-Gm-Gg: AYBFou0cHf6NRBoOmntm2lMAthO7u0wXqmM9YwrQ89QoUx+mH0fiAU/s9lP6WOSKm3y
	3gpiVQxdXbX3gHjLiFHF5rZi84EKyx9gLkNHAiMOj8cw/Lpc/hTDv+Kn/OgaYhWTuftAnRJTg1e
	TQiyhGSg39KBfhtP1oBSG03GxUF4hqrDAGQUuJD0D2Skii2h7EQgNgIKnR7xYi4roF3OexfyMyL
	36jLs7IneJjKNEqgn11ygEOIt5RufOFJVEEhwvwKI17UpVJ7VTqmsnR69pD4g5MBqL7yioP4QDt
	LnOXZUPuTmJLDSOiL4SE2iy33uJ34iAgamvlQw37JOk2Toyar7aqdPwAny6b8x/bfGvTsY8cDpp
	cBz03orlR7n2n
X-Received: by 2002:a17:906:ba90:b0:c41:1e13:4ba9 with SMTP id
 a640c23a62f3a-c411e1365e0mr83342566b.6.1792152728681; Fri, 16 Oct 2026
 05:12:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261016-mglru-fg-v4-0-2106750c0bfa@tencent.com>
 <20261016084256.12955-1-baohua@kernel.org> <CAMgjq7AtuK22FsuqvGRLVZ2eWrp-N4qQ_MHoXsXDkVBprekdDA@mail.gmail.com>
In-Reply-To: <CAMgjq7AtuK22FsuqvGRLVZ2eWrp-N4qQ_MHoXsXDkVBprekdDA@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 16 Oct 2026 20:11:32 +0800
X-Gm-Features: AclHuK-z6qzMGmKAbzLQtij7nv772LAigQWhuT7JqlQxVqOPHcB0PjAQdUtEGDA
Message-ID: <CAMgjq7Ao-1q5r7KtwV-UyvuP3hSazkfr3BbmKL+fv=dSDaU2Cg@mail.gmail.com>
Subject: Re: [PATCH v4 00/17] mm/mglru: frequency guided promotion (MGLRU-FG)
 and flag cleanup
To: "Barry Song (Xiaomi)" <baohua@kernel.org>
Cc: devnull+kasong.tencent.com@kernel.org, akpm@linux-foundation.org, 
	axelrasmussen@google.com, baolin.wang@linux.alibaba.com, baoquan.he@linux.dev, 
	cgroups@vger.kernel.org, chenridong@xiaomi.com, chrisl@kernel.org, 
	damon@lists.linux.dev, david@kernel.org, dev.jain@arm.com, 
	ehab.ababneh@intel.com, gourry@gourry.net, hannes@cmpxchg.org, 
	hughd@google.com, kunwu.chan@gmail.com, lance.yang@linux.dev, 
	liam@infradead.org, lianux.mm@gmail.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, liuxiang.277@bytedance.com, ljs@kernel.org, 
	mhocko@kernel.org, muchun.song@linux.dev, nico.pache@linux.dev, 
	nphamcs@gmail.com, qi.zheng@linux.dev, rientjes@google.com, 
	roman.gushchin@linux.dev, ryan.roberts@arm.com, shakeel.butt@linux.dev, 
	shikemeng@huaweicloud.com, sj@kernel.org, surenb@google.com, 
	tz2294@columbia.edu, usama.arif@linux.dev, vbabka@kernel.org, 
	vernon2gm@gmail.com, wangzicheng@honor.com, weixugc@google.com, 
	willy@infradead.org, ying.huang@linux.alibaba.com, youngjun.park@lge.com, 
	yuanchu@google.com, yuzhao@google.com, zhaozhengzhuo@uniontech.com, 
	ziy@nvidia.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 7:43=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Fri, Oct 16, 2026 at 4:43=E2=80=AFPM Barry Song (Xiaomi) <baohua@kerne=
l.org> wrote:
> >
> > On Fri, Oct 16, 2026 at 2:15=E2=80=AFAM Kairui Song via B4 Relay <devnu=
ll+kasong.tencent.com@kernel.org> wrote:
> > [...]
> > >
> > > LevelDB Scan/Get
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > I also retested the LevelDB benchmark from the cache_ext paper [5].
> > > Interestingly, mainline MGLRU already beats CLRU on this one after a
> > > recent change in lru_gen_folio_seq that bumps new folios with refs =
=3D=3D 1
> > > to the second-oldest generation as discussed. That change accidentall=
y
> > > gave random reads a higher hotness level while making sequential read=
s
> > > much colder as described before [14]. However it's unreliable and
> > > incorrect because it depends on LRU drain timing, and hurts some work=
loads
> > > as reported, or where the sequential part is actually hotter (any wor=
kload
> > > involving hotter large file and many small cold files will be affecte=
d)
> > > which is reproduced below.
> > >
> > > This series improves it while covering ordinary workloads too and sho=
uld
> > > fix regressions:
> > >
> > > LevelDB Scan / Get, Throughput Total:
> > > CLRU:         4708.3 ops/s
> > > MGLRU:        5026.9 ops/s (faster than CLRU, but hurts other workloa=
ds)
> > > MGLRU After:  5179.2 ops/s (even better in all cases, and no regressi=
on)
> > >
> > > The hot-sequential and cold-random workload can be easily reproduced =
with
> > > SQLite and grep. SQLite continuously scans and looks up a small hot
> > > portion of a DB file, while grep iterates over a set of small files m=
uch
> > > larger than RAM [6]:
> > >
> > >          SQLite scan & lookup time:       Grep iterate time:
> > > CLRU:                       14.51ms               13281.37ms
> > > MGLRU mainline:            567.05ms               13694.47ms
> > > MGLRU After this series:    10.58ms               12930.43ms
> > >
> >
> > Thanks, Kairui. I'll do a thorough review of the whole patchset over
> > the next two weeks.
> >
> > BTW, do you think we need a quick fix patch like the one below
> > for the above problem before this patchset, so that it can be
> > backported to stable? I assume your patchset is too large to
> > backport?
>
> Hi Barry,
>
> Good question, I think we can patch it first.
>
> > From f9683205d2ab6e3b185022d7d5af3496dfe5f35f Mon Sep 17 00:00:00 2001
> > From: "Barry Song (Xiaomi)" <baohua@kernel.org>
> > Date: Fri, 16 Oct 2026 11:48:06 +0800
> > Subject: [PATCH] mm/mglru: fix using folio_mark_accessed to replace
> >  folio_set_active
> >
> > Commit 6cbdd9726fb5 ("mm/mglru: use folio_mark_accessed to
> > replace folio_set_active") tried to avoid over-protecting
> > fault-around read-ahead file folios by placing them in the
> > second-oldest generation instead of the youngest generations.
> >
> > However, it abuses `PG_referenced` on read-ahead file folios
> > for this purpose, potentially coupling their handling with
> > normal syscall-based file accesses that also use
> > `PG_referenced`.
> >
> > This could regress some workloads, as reported by Kairui Song[1]
> > and Ehab Ababneh[2]. Many thanks to both for reporting these
> > issues!
> >
> > The long-term fix is Kairui's MGLRU-FG, but in the meantime,
> > we also need a quick fix that can be backported to stable.
> >
> > This patch reverts all of the original commit's behavior that
> > abuses `PG_referenced`, while preserving the semantics of
> > avoiding over-protection of fault-around read-ahead file
> > folios by adjusting only `lru_gen_folio_seq()`.
> > Specifically, fault-around read-ahead file folios with
> > `PG_active` set but `PG_workingset` clear are placed in the
> > second-oldest generation.
> > Activated file folios and refaulted workingset file folios
> > are still placed in the youngest generations.
> >
> > Build kernel cases in a memcg shows it not only perserve
> > the benefit of original patch, but also even improve
> > performance further.
> >
> > w/o fix:
> >
> > real    1m49.094s
> > user    25m31.484s
> > sys     3m40.959s
> > pswpin: 662112
> > pswpout: 2504415
> > pgpgin: 4424336
> > pgpgout: 10355273
> > refault_file: 359626
> > refault_anon: 670724
> >
> > w/ fix:
> >
> > real    1m48.913s
> > user    25m31.639s
> > sys     3m30.875s
> > pswpin: 689815
> > pswpout: 2689894
> > pgpgin: 4422659
> > pgpgout: 11043464
> > refault_file: 326566
> > refault_anon: 697138
> >
> > Revert original patch:
> >
> > real    1m50.044s
> > user    25m37.137s
> > sys     4m4.493s
> > pswpin: 1349087
> > pswpout: 4317933
> > pgpgin: 7083597
> > pgpgout: 17602735
> > refault_file: 337676
> > refault_anon: 1368542
> >
> > [1] https://lore.kernel.org/linux-mm/20261003-mglru-fg-v3-0-cbd4546a5bd=
9@tencent.com/
> > [2] https://lore.kernel.org/linux-mm/20260901180704.168106-1-ehab.ababn=
eh@intel.com/
> > Fixes: 6cbdd9726fb5 ("mm/mglru: use folio_mark_accessed to replace foli=
o_set_active")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Barry Song (Xiaomi) <baohua@kernel.org>
> > ---
> >  include/linux/mm_inline.h |  8 +++++---
> >  mm/folio.c                | 16 +++-------------
> >  mm/vmscan.c               |  9 ++-------
> >  mm/workingset.c           | 10 ++++------
> >  4 files changed, 14 insertions(+), 29 deletions(-)
> >
> > diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> > index ab69b9930893..7aaff4e06e80 100644
> > --- a/include/linux/mm_inline.h
> > +++ b/include/linux/mm_inline.h
> > @@ -311,7 +311,8 @@ static inline unsigned long lru_gen_folio_seq(const=
 struct lruvec *lruvec,
> >          * | Accessed through page tables and  | Accessed through file =
descriptors |
> >          * | promoted by folio_update_gen()    | and protected by folio=
_inc_gen()  |
> >          * +-----------------------------------+-----------------------=
------------+
> > -        * | PG_active (set while isolated)    |                       =
            |
> > +        * | PG_active (set while isolated)    | PG_active (files|     =
            |
> > +        * |                                   | fault-readahead)|     =
            |
>
> This comment is not correct I think, faulting file folios are not
> access through fd, we may just better leave it uncommented.
>
> >          * +-----------------+-----------------+-----------------+-----=
------------+
> >          * |  PG_workingset  |  PG_referenced  |  PG_workingset  |  LRU=
_REFS_FLAGS |
> >          * +-----------------------------------+-----------------------=
------------+
> > @@ -319,7 +320,8 @@ static inline unsigned long lru_gen_folio_seq(const=
 struct lruvec *lruvec,
> >          * |<---------------------------- MAX_NR_GENS -----------------=
----------->|
> >          */
> >         if (folio_test_active(folio))
> > -               gen =3D MIN_NR_GENS - folio_test_workingset(folio);
> > +               gen =3D MIN_NR_GENS - folio_test_workingset(folio) +
> > +                     (type ? !folio_test_workingset(folio) : 0);
>
> This looks a bit hard to follow. Does it mean that for active but
> non-workingset files, they are put into the third newest generation?
> It creates more divergence of file / anon but if it work for now, I'm
> fine with it.
>
> >         else if (reclaiming)
> >                 gen =3D MAX_NR_GENS;
> >         else if ((!folio_is_file_lru(folio) && !folio_test_swapcache(fo=
lio)) ||
> > @@ -327,7 +329,7 @@ static inline unsigned long lru_gen_folio_seq(const=
 struct lruvec *lruvec,
> >                   (folio_test_dirty(folio) || folio_test_writeback(foli=
o))))
> >                 gen =3D MIN_NR_GENS;
> >         else
> > -               gen =3D MAX_NR_GENS - (folio_test_workingset(folio) || =
folio_test_referenced(folio));
> > +               gen =3D MAX_NR_GENS - folio_test_workingset(folio);
>
> This is a nice change, but meanwhile the LevelDB and cerain workload
> gain are gone too, we will again have a ~40% regression for similiar
> workloads, I just double checked it. But that's fine, though, it was
> never meant to be optimized that way, and the long-term fix can be
> done later.

Here I mean the "optimization" of 6cbdd9726fb5 is more like a side
effect, and not reliable, that is simply not the goal of 6cbdd9726fb5.
So I think it stands well as a fixes for 6cbdd9726fb5.
