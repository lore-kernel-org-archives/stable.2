Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD533D5244
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 21:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792358695; cv=none; b=InIY76eEN6HPw+y0DVwSGY4bO3Z7rIaPWFkZf07YaPgmPLdiyVRCQoTRVaALeBDCYFZqK0nBWRh1XNpPsBbrDHJUcvpDz3Bcz2PFr+wIsyrH0EK2fzEWtw2I5XMo6CjmDRn72WiMIFGouxTnYNb99D68HXBw93RO+u5FSLJdfk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792358695; c=relaxed/simple;
	bh=zXk7H0VnU/maIBpoOymFdCcXe7bVWVVvJA21WEFTSWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WFcwF+1A6hNvORMojeoVoksqtIpeiapUZeeGJaqf7YQO4KpC+smfsiDiv4EzZM9ah3LqU7f5r4ql4l2BbiY6u8+FilxgYyx6AwW9KeIdLV8ZspxTQQMRMe7oQGPP/Vyr+eDc1aLoKwVNBzrDvD+tO37mT+nS4Qm/PvtCTTifBgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g41ecgsv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g41ecgsv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FEA1F000D0
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 21:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792358694;
	bh=79eD6+NYwrWfAWT17DyFGFcJ6J+jNYO1RY/y6TIzgMY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=g41ecgsvRnrR3Ul1sVBVPp2VWzhqqffwmuhmcbLEa/aRE2vF9ODuN8ZvYvaIGT1OM
	 DZGwcUA+FbDwxYx72wyOViIdT7Zs/1M56/O0Jf3ZJo6sJYiI+8agDxXHlpEhDef1vc
	 lcbN/tEkzDxwkqNZ7ZaoQqUlHls4wjE05T1nMMzY9zjU6EPOtTZuvqWFG5zhSjgjtP
	 rceHWM1PVosJQ3JTMcNfavbkt83l4z10xIhTbRyiclj0yZWlxJ26pCjsdT3EV+i3Mi
	 MJGW+M864p2kh/AencmcuXZMp38yM14Wpd/kY2vYTdqR6HtU3LBNsvz0Ot5cCBRK/G
	 SfFujcOWvanDQ==
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93f2493c28bso132438085a.0
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 14:24:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy02nwliLGO8QQW1MbtaH8PN3rLHKBppi1ZJia3vOLRTeDmtE26UT6lKGGi2C7fl1bmxZQPp8s=@vger.kernel.org
X-Gm-Message-State: AFq9FYIb7Hx0ysZQ8UdpCKwoiTX+6idrzm0LKkFbrJM3ZJlN4BVtFmTf
	bCp/bhMddqaPS6pU8AUFo5hdEwMVxN11VpQ35CLmBhg36neDMpCy2Hqu0dHGZJ3V3QakWPiIZJy
	EQLI4wVs4lnv8d3sv4PH+LUiV3xqJxTA=
X-Received: by 2002:a05:620a:7116:b0:93e:c12c:9b77 with SMTP id
 af79cd13be357-93f29e10b82mr1018147285a.82.1792358693733; Sun, 18 Oct 2026
 14:24:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261017050928.128582-1-sidchintamaneni@gmail.com> <20261017050928.128582-2-sidchintamaneni@gmail.com>
In-Reply-To: <20261017050928.128582-2-sidchintamaneni@gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Mon, 19 Oct 2026 05:24:42 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4wGq9oc05=-g4aWptLdCbTwUjMjXk4Rd6KjJ6x=tzMm+g@mail.gmail.com>
X-Gm-Features: AclHuK-zOvmn4Odh7hUiMWoOb31GxvVA2StuKKJONiQv5GYZwSx9IIrjvvI6xTI
Message-ID: <CAGsJ_4wGq9oc05=-g4aWptLdCbTwUjMjXk4Rd6KjJ6x=tzMm+g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: multi-gen LRU: fix NULL lruvec->pgdat deref in get_lruvec()
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

On Sat, Oct 17, 2026 at 1:09=E2=80=AFPM Siddharth Chintamaneni
<sidchintamaneni@gmail.com> wrote:
>
> Andrew Morton reported that get_lruvec() has the same problem as
> lru_gen_shrink_node(): when memcg is disabled on the command line
> (cgroup_disable=3Dmemory), it returns &pgdat->__lruvec directly and so
> bypasses the initialization of lruvec->pgdat. The MGLRU debugfs
> interface calls get_lruvec(), then dereferences the pgdat pointer in
> lru_gen_seq_show() and other paths, so these can hit the same NULL
> dereference.

So userspace must have booted, since otherwise we couldn't read
debugfs. The reachable case is therefore a memory node with no
LRU folios when debugfs is read? So this could happen on a multi-node
system where folios are landed on other nodes but not on this node?

>
> Fixes: ec1c86b25f4b ("mm: multi-gen LRU: groundwork")
> Cc: stable@vger.kernel.org # 6.2+
> Assisted-by: LLM
> Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
> Signed-off-by: Hardik Garg <hargar@linux.microsoft.com>
> ---
>  mm/vmscan.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 0c57e4f1eb15..99e9f07fa2e1 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2745,20 +2745,9 @@ static struct lruvec *get_lruvec(struct mem_cgroup=
 *memcg, int nid)
>  {
>         struct pglist_data *pgdat =3D NODE_DATA(nid);
>
> -#ifdef CONFIG_MEMCG
> -       if (memcg) {
> -               struct lruvec *lruvec =3D &memcg->nodeinfo[nid]->lruvec;
> -
> -               /* see the comment in mem_cgroup_lruvec() */
> -               if (!lruvec->pgdat)
> -                       lruvec->pgdat =3D pgdat;
> -
> -               return lruvec;
> -       }
> -#endif
> -       VM_WARN_ON_ONCE(!mem_cgroup_disabled());
> +       VM_WARN_ON_ONCE(!memcg && !mem_cgroup_disabled());
>
> -       return &pgdat->__lruvec;
> +       return mem_cgroup_lruvec(memcg, pgdat);
>  }

I've been struggling to understand why MGLRU needs its own
get_lruvec() when mem_cgroup_lruvec() already exists.
With your patch, it feels like we're one step closer to
getting rid of MGLRU's own variant in the future.

>
>  static int get_swappiness(struct lruvec *lruvec, struct scan_control *sc=
)
> --
> 2.45.4

Best Regards
Barry
