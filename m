Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E4D25B090
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 02:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782180970; cv=none; b=mE6p8K83ZME2/LjXCyfGeJW3oGF99sfe4Gs+3EbJfX79Zy1J0VmrHLs6es/gFgZpx1zmVkqc3F+DiZhkK8TRY5jUm1KSJPHGQvmsChZmZxih2Csk8+We9q45qz4ZD/FjVeoq9sofsrl4e9Hga59wnInvnkE6m31eJFlPbdDdUrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782180970; c=relaxed/simple;
	bh=eLXPRQKDOIayJgd/Muv5lk2mozROgecGOZJ2U9v31ZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZPx9jU6kFMgP74klDWTJmvfyC1KAQZSMn6CxIq7F8lN54HZirtD1886x6g6Omn3E6LxOV5ljwwPvxGvlg8FXsMQ84opFvFgaRx/5lPjbKB77AbeXIPXOm9Fo+egYp/FVsNOw/Y4YJAbovxzhy2uPxJFGaj7pM2c2+cjbhoZZ1Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XP9pTHwD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XP9pTHwD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EAF91F00A3D
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 02:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782180969;
	bh=ORG1110TKZO9YaLb3hwjWsJ78jK9FF5h+lt0diWED9Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=XP9pTHwD5gI1rie9x1qke3VNK/muvum94K8NNGS2ZMK54STe2BUBuLXVUXfRjPH73
	 4Hlj5UP7dXLZf36+X++F/7Y5ao0IedlvQWGMOQzD1OKXrRoDv6UBmohd+pLVhtamhg
	 G/+SUxjqqhvaDubmB7A/u0did3yllQW3yIZ+Nr1Jz6pQYyTxld5U3N6aujTl4UVMHp
	 9ZU7Bq8wouzCdVUUezp/WMhyqRzfS/3g57JUSe71KT/n/tAyokKKJBjslwUFinf+a6
	 jocINOArtkObwpQ6R91w0PLxa0l0Z7D/aWt2RG4oe6BOSa8oLA/4mTm43iWE9/qLdM
	 Z5LuGHy89V1MQ==
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-91587626ae1so599456885a.3
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 19:16:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/5gH10YSCACf3yAGMj4/qAd1HAs4tF6PEKBUZlM/UN+DMyVq1+Fb3zHPjD4RlipGXnX8v1hqo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Py+C9BG3p+1ttTYvzbZLck2ZmwXEFMmv4jCgxFbnTqbSbm41
	6m2w74tEqCoTbHud1PkRqhOk3NrNZijvkreU3oyOw3zWVyhB5V0AmJ1hiJasumwu+YpGMNHws8C
	HLd2OdWwJRStc6/UsHBEwExLHDHHQGog=
X-Received: by 2002:a05:620a:4455:b0:91f:12a7:beae with SMTP id
 af79cd13be357-920900fa471mr2990686585a.24.1782180968833; Mon, 22 Jun 2026
 19:16:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5A9E929D82717101+12fcf643-efb8-4b9a-a53a-1e28cc894f0b@smail.nju.edu.cn>
 <20260622073703.79258-1-qi.zheng@linux.dev> <CAGsJ_4z34ZRu_RKkaZ7EgTWMOxptUjZ90WJyNoJrXGNjzutxnA@mail.gmail.com>
 <19710ee5-8e1c-4b13-812b-4b03ca34260d@linux.dev>
In-Reply-To: <19710ee5-8e1c-4b13-812b-4b03ca34260d@linux.dev>
From: Barry Song <baohua@kernel.org>
Date: Tue, 23 Jun 2026 10:15:57 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4zC8jMNk0twWQd+oRWCzZTm523K-KgzDQ6TkjbzPq4MTw@mail.gmail.com>
X-Gm-Features: AVVi8CcgxGHg4osYX-YWIWEqreagag-ELHwB1D_7PjRMnGTDlB9P1uVVdJMh8og
Message-ID: <CAGsJ_4zC8jMNk0twWQd+oRWCzZTm523K-KgzDQ6TkjbzPq4MTw@mail.gmail.com>
Subject: Re: [PATCH] mm: mglru: fix stale batch updates after memcg reparenting
To: Qi Zheng <qi.zheng@linux.dev>
Cc: akpm@linux-foundation.org, david@kernel.org, kasong@tencent.com, 
	shakeel.butt@linux.dev, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, hannes@cmpxchg.org, harry@kernel.org, 
	muchun.song@linux.dev, peiyang_he@smail.nju.edu.cn, mhocko@kernel.org, 
	roman.gushchin@linux.dev, ljs@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 9:58=E2=80=AFAM Qi Zheng <qi.zheng@linux.dev> wrote=
:
>
> Hi Barry,
>
> On 6/23/26 6:52 AM, Barry Song wrote:
> > On Mon, Jun 22, 2026 at 3:38=E2=80=AFPM Qi Zheng <qi.zheng@linux.dev> w=
rote:
> >>
> >> From: Qi Zheng <zhengqi.arch@bytedance.com>
> >>
> >> The mglru page table walker batches per-generation size deltas in
> >> walk->nr_pages while walking page tables without holding the lruvec lo=
ck.
> >> The reset_batch_size() later folds those deltas into walk->lruvec unde=
r
> >> the lruvec lock.
> >>
> >> The page table walker can run concurrently with the memcg reparenting =
path
> >> as follows:
> >>
> >> CPU0                           CPU1
> >> =3D=3D=3D=3D                           =3D=3D=3D=3D
> >>
> >> walk_mm
> >> --> walk_page_range
> >>      --> update_batch_size
> >>          --> walk->nr_pages +=3D delta
> >>
> >>                                mem_cgroup_css_offline
> >>                                --> memcg_reparent_objcgs
> >>                                    --> lock lruvec
> >>                                        lru_gen_reparent_memcg
> >>                                        --> reparent child folios to pa=
rent
> >>                                        unlock lruvec
> >>
> >>      lock lruvec
> >>      reset_batch_size
> >>      --> child lrugen->nr_pages +=3D delta
> >>
> >> This can trigger the following warning:
> >>
> >> WARNING: mm/vmscan.c:5867 at lru_gen_exit_memcg+0x26f/0x300
> >> RIP: 0010:lru_gen_exit_memcg+0x26f/0x300 mm/vmscan.c:5867
> >
> > I can't find 5867; instead, I can find 5828:
> >
> > VM_WARN_ON_ONCE(memchr_inv(lruvec->lrugen.nr_pages, 0,
> >    sizeof(lruvec->lrugen.nr_pages)));
> >
> > Is this the warning?
>
> Yes, I just copy-pasted the warning log from Peiyang's report.
>
> Maybe the description should be changed to:
>
> This will trigger the following warning in lru_gen_exit_memcg():
>
>         VM_WARN_ON_ONCE(memchr_inv(lruvec->lrugen.nr_pages, 0,
>                                            sizeof(lruvec->lrugen.nr_pages=
)));
>
> >

Yep. Can we update the v2 changelog accordingly?

Best Regards
Barry
