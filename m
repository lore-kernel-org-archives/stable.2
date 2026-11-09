Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794200922;
	b=Tnp+M0sPN2Jpdw9c/3yTfAtinpiZHOa2xOgOce7XcfZEurjK4qyDKeTExP/AoP0DNk3i
	 UWyKoTGbjklc63cqDJpfsn8/eTOoJao/vyjedtF8+BuzPcAFTreSqgUeFhJd2wRICx/6e
	 +J+rDDKlW/WAMZORtG6D9frC0COIWRVhiXxhrpkQfW+gObrvk8Ik4y//hjXGOzoygu8+K
	 H5GMNs4PM04tAO5SFYYQmQoiYBduTQ0S/UaKOUU4cfdif2DwHf45lNq/ez4RZ6LpBEAA0
	 MDwtvma+icb6SUvJyr+taagH+VejoRSPxFjTaHGYMXoiMc5fkSzAKsJyAjD5z1a5ktQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794200922;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=1VQUJOWynNq5sMHvJ+1kD7yhDV7CogQ5mFVSZClhbSk=;
	b=Tt+YYzxav1LJrsLWLxsaayJtif6TV3Ru3pbVM9muGafpxeoszGsanRWL5Cyh2Xwf8d0d
	 Q8/Oa3mnI+CCJ/OHC5KcEOaKX2lyTelOHCDoqS7aNgtzyhyIJxIi4CUq0+tdeQiTarHS2
	 KqPInJt59z3OGheg3opNQWfglubKzmdZElPIq0IePgAJh2ibwMIfZN5O20UXJCQvnl9/s
	 LRTCqtgUplPFK8bS7FpHBbbuqS96YOR+wMOgS4OyEcnvbg1mM+u51xtaFuTVyFbEemswE
	 XteiTUy8RL4g+hpHUQKPcyoTZz7S8nIQmOSBgPfRIBsDK4+G00YrTXGcfOM62QV8XzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B6chp+rq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CED7606A323
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 05:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B6chp+rq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 116B31F008AB
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 05:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794200922;
	bh=1VQUJOWynNq5sMHvJ+1kD7yhDV7CogQ5mFVSZClhbSk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=B6chp+rqHjoAzNi3gzpD3o0Xf2rGkthiUXizG9GPRM5qY8CVNFcfT3yzbkITu39LF
	 Dn0g3bjsSnc1HTPQOkjYp+jeSCGOKMSh4Tn5CeyZC69Fn61U4WD5aK4c8inpaLGBYF
	 zkrbKMWqJLuvYPdbJuUueR4Ff160vChqUw4LRxhiQ5r/Sn1RbaTHfu1UzRlBIpukj6
	 yPQg4Mczosdt1CbIZD5jTWo4vIatpSGyako5AjfxDJhbr3WgVAL2zcPEKFuo2hLvyd
	 ACedX2E0IHhV5VjTsEKT5PdorqzRGbR41f/W2NEdV6dOLNLpYqI7A6hvMfuonzDQWT
	 LBOZGrOd9fCJQ==
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93f3c8958d5so53783885a.2
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 21:08:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErF9pr2lxUmx1umvAO0js0ZxKQ4J/um7DXS+IL2tCKpkqnvAdMYOGvH4cqr6qIhBLPo2ie8MZ64=@vger.kernel.org
X-Gm-Message-State: APuU4Z8abgF/XgqbwrjvUyG6iXCedZxir+cQcFj7v1lerjNHdrKd/3cG
	l7kLM9InAF8bX9aqHTr1XHcCK4dLluQY1NL5alnbDQ0dL6s3NEATZ83YsKPUQbkHZNq9Ept0w0o
	UNrO53LQKCYLVWXKx5w0ZV3TU0tNbjG0=
X-Received: by 2002:a05:620a:404c:b0:93f:2ab9:7294 with SMTP id
 af79cd13be357-947841f6ddamr467417785a.29.1794200921126; Sun, 08 Nov 2026
 21:08:41 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109021611.22247-1-hui.zhu@linux.dev> <20261108205148.380c16c42bb21ed0e2c829fe@linux-foundation.org>
In-Reply-To: <20261108205148.380c16c42bb21ed0e2c829fe@linux-foundation.org>
From: Barry Song <baohua@kernel.org>
Date: Mon, 9 Nov 2026 13:08:29 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4ybXskWKDLHkeeuVGirGaaZ8TdPEDX+xQXZcYmPMSjS=A@mail.gmail.com>
X-Gm-Features: AclHuK-KqoamP3B_-9VY_9GUttMMzxUHXdmfnhKj_CfyY5ItADfd9JoacLqR554
Message-ID: <CAGsJ_4ybXskWKDLHkeeuVGirGaaZ8TdPEDX+xQXZcYmPMSjS=A@mail.gmail.com>
Subject: Re: [PATCH v3] mm/mglru: fix a no-op lru_gen_clear_refs() call in lru_lazyfree()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Hui Zhu <hui.zhu@linux.dev>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Yu Zhao <yuzhao@google.com>, Kairui Song <kasong@tencent.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Hui Zhu <zhuhui@kylinos.cn>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 12:51=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Mon,  9 Nov 2026 10:16:11 +0800 Hui Zhu <hui.zhu@linux.dev> wrote:
>
> > From: Hui Zhu <zhuhui@kylinos.cn>
> >
> > lru_lazyfree() calls lru_gen_clear_refs() after lruvec_del_folio(), but
> > lru_gen_del_folio() has already cleared LRU_GEN_MASK, so folio_lru_gen(=
)
> > returns -1 and lru_gen_clear_refs() exits at its "gen < 0" check withou=
t
> > clearing the refs or PG_workingset.
> >
> > A MADV_FREE folio therefore keeps the state it had before madvise(2),
> > even though madvise_free_pte_range() has already cleared the accessed a=
nd
> > dirty bits of its PTEs.  lru_gen_folio_seq() places it one generation
> > younger, and PG_workingset puts it in the last tier, so sort_folio()
> > promotes and protects it instead of evicting it and charges it to
> > lrugen->protected[], which read_ctrl_pos() uses to balance anon against
> > file reclaim.  __folio_inc_gen() clears the refs but not PG_workingset,
> > so this repeats every time the folio reaches the oldest generation.  If
> > the folio is redirtied first, ttu_anon_lazyfree_folio() keeps it and
> > lru_gen_eviction() packs the stale state into the shadow entry, so a
> > later refault is promoted to the youngest generation.
> >
> > Call lru_gen_clear_refs() while the folio is still on the generation
> > list, as deactivate_file_folio() and folio_deactivate() already do.  It=
s
> > return value only says whether the folio is in the oldest generation,
> > which lru_lazyfree() does not need because it re-adds the folio below.
> > Keep folio_clear_referenced() unconditional: the classic LRU needs it,
> > and it also covers the folios that lru_gen_clear_refs() skips.
>
> Thanks.
>
> > Fixes: cc8ec7be78ff ("mm/mglru: optimize deactivation")
> > Cc: stable@vger.kernel.org
>
> I'm not really understanding why a cc:stable is proposed.  Seems that
> cc8ec7be78ff's changes can lead to MADV_FREE folios hanging around for
> too long, but what is the runtime-visible effect of this upon our
> users?

For folios in a MADV_FREE VMA, userspace has
explicitly indicated that they are cold and can be
reclaimed without being swapped out, unless they are
re-dirtied before the reclaim path encounters them.

Therefore, these folios should ideally be placed at the
tail of the LRU so that they are reclaimed first when
memory pressure arises.

The problem right now is that they are protected, so
some potentially warmer folios may be reclaimed instead,
which could lead to more refaults.

I once proposed something similar, although more
aggressive:

https://lore.kernel.org/linux-mm/20240914063746.46290-1-21cnbao@gmail.com/

According to Gao Xu, this can have a visible performance
impact:

https://lore.kernel.org/linux-mm/7dcd3446cd8c4da69242e5d6680c1429@honor.com=
/

I would expect Hui's patch to provide a similar
performance benefit by addressing this issue. I believe
commit cc8ec7be78ff introduced a regression for
workloads with MADV_FREE.

However, real-world workload data would be helpful
to demonstrate the actual performance impact and make
the case more convincing.

The patch itself makes a lot of sense in theory, though.

I'll arrange some tests with Android workloads and report
back once the data is available. If Hui already has some
data, it would be great if he could share it as well.

Thanks,
Barry
