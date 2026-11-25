Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795594997;
	b=tquEVpPuV4WHqb7BKo92CQdq+DbFVO20b2fswlWtcz3OdEfLYxwdMFyV/tAMc/BBFgAQ
	 HzRD0MeY/AWniM1tpXzCGlUPYuu9t9dTCNOJaqY47ZVXtlyoH0IJkBlx/S8+z2qgLe4yQ
	 yw83/g5LTIh2/8+WFvPFpHHJpSIPMjYf8hpSxTSBfQphkdUl+opO3MrPZpBOVBtCtc80K
	 Ym0ZsvCL1EcEFkbtFusL2yS+lLZpCKtKdnLgHERRbcGwwO8XQsAnZ0vApbMmc+rvxNl6F
	 kSbH8bwUM8WsPON7T9lsirYxppjnOXSwvr51Owns+5RBvwWQWibXxyspDah8uk6acSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795594997;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=hsT7zBmMHOA0tSmt3vFfihAtL6RUpoMsSd3RGk73F2s=;
	b=A+1gflXwYXWdCjSShW9mL6M/cM58cAtOMea7CF95VQgshierO4DThf4brMQVg+A0ikiZ
	 2125XHRwZ2v43zwxJgT3h+zm/RfWFAwewhVBXylUMmL0UfjYTLFmBFVVzp4DM/n3xoOpY
	 0We3ymQB/K8jJATPBmGPypf8OGQkrkxNW5QjfNTJzsnByr0+YeFmTcl7ZB4tN/Vr+Kak8
	 qGZ5rmie4ToCufd1JKmYt+q9T7RyZEP2pBD0tyaZYvW0IYmWV1pGL3+kmIynVQ7vQLjxp
	 eiyA8xdIuLg7o+RcP1Gn0iG25ZJdCW66MB95Mx365gRt/eay4F2Tczfaiw0vrCnbX4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YZloInuI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D4B606A32D
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 08:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YZloInuI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B028A1F000ED
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 08:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795594996;
	bh=hsT7zBmMHOA0tSmt3vFfihAtL6RUpoMsSd3RGk73F2s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=YZloInuILkJ9lmMUSqL/V1E8ZE2MR7DT1FHtU5vmr1pynf0SQxxjVeQeMdQmCVdOU
	 yI5vYa/MpHD51913RjFTE0cfACo+wFIrf/YlA2+0n2ByuZEuHOIiFSIN2MxoTdxOq6
	 YQdPQHNk2d43l8aIC62EUfQ5OpRhtdKq3RVYmk61kUu7I3Wo83lhI1Bihi6LX3J1Gs
	 xPyd1O68e+0uA3TiIzPNRDmP1QZvMcU27ndaND5Yx03x0lDJYvF3ZXDwQ82WcwthQc
	 lnTas0aZN4TvJdDeJhA60y3x4W7yMTozdz0arecRmKxYV/HG+m5OCSjgLGKDVl7ITw
	 ZyXG2yI59pwdg==
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-949b0d32315so461139485a.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 00:23:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFyM0A6lrIr0c5IBdbYtaOHECHBFABbNDNeTTKG7A8SvcBEiM9SXpb8M+ybP1I9jYBDGYGx/D0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8whxXpm3a2Jk1IdP8zZq8v26yY4GwMDuH++x4MSSRQmQCZxfPW
	hFSmtc6LSSAOyvBEH2F7vCCYwnNvZCrMEeQtPj/WKOOhI5pNtwGufvoX0rveSwfjkodwjlTGFRJ
	0zJJs8WAh4seu1xr8FxxnOqD91Z9dQ8o=
X-Received: by 2002:a05:620a:6c18:b0:949:664e:e3e8 with SMTP id
 af79cd13be357-949ba997635mr2899642585a.34.1795594995906; Wed, 25 Nov 2026
 00:23:15 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261125073931.1171242-1-hui.zhu@linux.dev>
In-Reply-To: <20261125073931.1171242-1-hui.zhu@linux.dev>
From: Barry Song <baohua@kernel.org>
Date: Wed, 25 Nov 2026 16:23:02 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4zvaxT+TD2P0ephTRsjAeVo+9NdavmmxLnuoj6d7P5UuQ@mail.gmail.com>
X-Gm-Features: Aa3M54oYpLZLgx5RRSzL4wpUVCax0NId0FybUVL-U-z7-jqsoujZkX4qgzA3cgU
Message-ID: <CAGsJ_4zvaxT+TD2P0ephTRsjAeVo+9NdavmmxLnuoj6d7P5UuQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: mglru: reset the mm iteration cursor in try_to_inc_max_seq_nowalk()
To: Hui Zhu <hui.zhu@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kairui Song <kasong@tencent.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@kernel.org>, Michal Hocko <mhocko@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Harry Yoo <harry@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Hui Zhu <zhuhui@kylinos.cn>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 3:39=E2=80=AFPM Hui Zhu <hui.zhu@linux.dev> wrote:
>
> From: Hui Zhu <zhuhui@kylinos.cn>
>
> try_to_inc_max_seq_nowalk() advances mm_state->seq without walking the
> mm_list, but unlike iterate_mm_list_nowalk() it leaves head and tail
> alone. If it races with an ongoing page table walk, the cursor is left in
> the middle of the fifo.
>
> The next walker reads that as "this generation already started": it skips
> reset_bloom_filter() and resumes after the cursor. The mm it visits are
> the ones the aborted walk never reached, so they have no bits in the
> filter being read and walk_pmd_range() descends into none of their PMDs.
> try_to_shrink_lruvec() ignores the failed try_to_inc_max_seq() and keeps
> evicting, so those hot folios are not promoted and refault in the parent
> memcg, until head wraps around a generation later.

I'm not sure I follow this part. Even if the page table walk misses
those hot folios, we can still detect references through rmap during
eviction, can't we?

We also have lru_gen_look_around() on the rmap path.

So missing those folios during aging doesn't necessarily mean they
will be reclaimed and subsequently refault.

>
> Reset head and tail with the seq increment, as iterate_mm_list_nowalk()
> does. It is safe: get_next_mm() holds an mmgrab() reference and a
> concurrent walker bails out at "walk->seq <=3D mm_state->seq" before
> touching head again.
>
> Only reachable from memcg_reparent_objcgs() -> max_lru_gen_memcg(); not a
> memory safety issue, since lru_gen_del_mm() repoints head and tail under
> mm_list->lock.
>
> Fixes: f304652609ea ("mm: vmscan: prepare for reparenting MGLRU folios")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
> Reviewed-by: Baoquan He <baoquan.he@linux.dev>

I'm fine with the fix, but I'm not entirely convinced that everything
in the changelog is accurate. :-)

> ---
> Changelog:
> v2:
> Drop the helper and keep the fix open-coded (Baoquan He).
>
>  mm/vmscan.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 6a1af9b92349..3601e58f2a69 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4694,6 +4694,8 @@ static void try_to_inc_max_seq_nowalk(struct mem_cg=
roup *memcg,
>                 spin_lock(&mm_list->lock);
>                 VM_WARN_ON_ONCE(mm_state->seq + 1 < max_seq);
>                 if (max_seq > mm_state->seq) {
> +                       mm_state->head =3D NULL;
> +                       mm_state->tail =3D NULL;
>                         WRITE_ONCE(mm_state->seq, mm_state->seq + 1);
>                         success =3D true;
>                 }
> --
> 2.53.0
>
>

Thanks,
Barry
