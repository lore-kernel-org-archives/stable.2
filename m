Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792502339;
	b=Y8N5ewOrAgUW3Ue2khVbeev07poqzZTFRWlqcB6CrWYi3D6BqnLSTFTdgTsvYuueukaU
	 pM/CKEWSfJVCWxSjKb61Po0lnE2IdlfNTfXeYsMfnNbNtJDaER23/odZIWuTVAMqgasE0
	 jmif5K6L6soBV2A/OW73/1zWXH6HjUlHKU4Sa9rLkhL2Pjla4Fq0WyVKzOH+CwP1MsXPz
	 EBF29dUO5t0Hetqmp4cU7hez2CfdfXjmS95r/7F1i9KZICywzAyQe3UqYx0AnXhRYxJXp
	 RV8YTB3fLUl5FCAu3WlhPK+4IfDEuD4GjsAaZsX73HQ6cIq1ZPpEOPEqI6CBBLB64gQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792502339;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=i+31L6D/8A8U1mIX096CB/r7t4YtUtlf54h/6tqEmZI=;
	b=CzLD4W9uJnJwWoM39zIuKcP0s38GZG2jgnDa/hyRypgLqkr7Cc2BD0K3nl9EBgK0EDNr
	 0JnTdfR74JyVc+fAy0QQf7/PJZFfyCz85WrQdXmhkfJwoWdhI8HLSfdbtRZ9w5B9tEsC+
	 vJ0hs7Tc6hazt7TfZ9kcVwKvr0qE7fCpq59oLwalq3lYyyo2hd0mcimc5FuDFlN3XPwW/
	 DE44/pe+wOVqktfaSB0ZWK7oarG6qEA/M4dRFnjxho5inZeFRC5ZfCd6k+23xdBDY+YlI
	 JFKEclXC9deMVODnEOwu6+e6VYcvgEeboMAx6cyGk6i5p2GUQoVhaMI+nzy4gVwu9zQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="Tle3hE8/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348B6606A328
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 13:18:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 348B6606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Tle3hE8/
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48b042c0759so2139326f8f.2
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 06:18:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792502337; cv=none;
        d=google.com; s=arc-20260327;
        b=Z10Zcs5h0dsv+Dx2v8yOoiosl1CuMftJalIttX5lSoxur8Rt3oSzPPtLoTQfv3AtRq
         ab1zgzWBa6Jh/0Qim0arblULhrR54GRSjYWMJSSxmmItoVZoYSwoH03R7HKXcxLXf1Ow
         jyqVDXj7aN/4QbW8uGaVwI5xbbwbU/J/8lSUIcnAMl1QSLmpnsu9q26He0YEaAS07HZv
         tHi66URiiOslnqwD4gJBedMuxrwsHQlPDGtbQ6f+aNuZfJoGl/+NI65/ci4zB6ZV04Sa
         o5ZWQOjvaOwKZJZtlIf6Pk9ZSDtXfoSLTgeedpwjBchKMeR2d5n91yoAh+hvgQ3iPJLZ
         WNzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i+31L6D/8A8U1mIX096CB/r7t4YtUtlf54h/6tqEmZI=;
        fh=2P97wShr+O8YVn+ofizQZq0k3aP/pEZd8grOYszKJ4g=;
        b=G1RL93qwkBxA7A/5tpu7FHGhhaxD1shBDVLUhD/qNHCdmahOZ83PLqfjhTdC0p8nj7
         WZNtsGK5egaQ9a5DVse++czkG8PITUge78/JxKg2VHet68MbSP/ITyr4Ed2jjjSMrGyS
         E4HjC5iAhNgBjyH2wGaw8TlpSnpjD+8LiUtWB56TyU0enSR3wOqTshx6Qn/5qgUFGbYM
         lDSDEJDItpW+XsEbSwPtf6dnJbIZVSH5Q6zbkSvrTKQ3ZQhqN6cjG9106U2OOHERI3qK
         u+65Hgv+V6WXVT5ExxL1/A7qY6nZsfOK1FhQbqxj6APWAZxERsyvkT54m0S1AYDzftzK
         +8/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792502337; x=1793107137; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i+31L6D/8A8U1mIX096CB/r7t4YtUtlf54h/6tqEmZI=;
        b=Tle3hE8/ArxDIt0aenu5uX9Q+SHQoxhgy3zhFT9eTi6TK6WeUdgW/TI1ynrttXXXd9
         g4fMjZP5/t7HdUErZdcz9+XeXGV8M5CwDLImcLaaNDYuzhrIhvqUhaPMZNyL2ciWwBZu
         eSUfb7XeloCJ456QC1xYD3kdqguWFkNNf6hbc+P+xVBJXZCJf1thODjdyzopj2zgOOxa
         eUDjOOKXvcVeCwZg8RHiJkSTkVwzzO5wPAJa4Xd11AejaDQYFbt21mq+48j13xiXJkyb
         gn3eJLNrZt4gP4n/PX/NTfoYsKhDFLOGXAQaUCFbmE4na+oFxdBmEPEviIbVZ/uo1kgG
         O6Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792502337; x=1793107137;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i+31L6D/8A8U1mIX096CB/r7t4YtUtlf54h/6tqEmZI=;
        b=N0iHJzZhumdqjzM9o0chNYpQLYELZCpvfvKYaNK6ZQ6RXtW0LhvQlr+ebzJfexqp4a
         +SfKR60MRWWGTxZOORw48X8XZBZMUFzP7Ao/AzPAhMxCgvszThMrJoSvuhlxijqIm9ur
         /Gognike3c0Z5+9ON/br0PjA41k7tNTr0b2mClwmTvB5ioRt3o+cZ12L7XEfBO0gcNqs
         SgMDg/3Q34UN6HB3Q5lw5tIkUOYq5Dg7HKk/r/+ZQWENv65Mf7I8+oFzT1ShzWdJqVun
         BXFOoHOMDhfX7jl25Z3KQeVDLQ+lgoNlDT5zKJ/yKg7rl2nC/JlxKhyK22tMps2YXP+d
         3IiA==
X-Forwarded-Encrypted: i=1; AKwUvBwDmPcIWFsE25W5xH4kYuTmCeQfWdB9HqTdtINbc8qBEBPeDlS4S3WS15cZaFeA5xTx+ZuAOmU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIqNwOF282RzjqegvENiidYxchrSNEF6ybkbjFaAWuVAr9saO7k
	kX6SsdtqeApOk1+J3KvH53Q8kpXSoSqjEeb1T5YbrKU8R9sS8N9ITW3QmAaOqKABiUOv6ZQPJA8
	Lop8XGEgA6zMMZo+yBF9ElqY5qHkWadg=
X-Gm-Gg: AYBFou3FYUgq/IIL/jEQP93oQdSyBcD6L4pHmhYZjpFambV4RKVn3aDRi/QuA56P8Js
	vNmqONIlji7h7iakgn+h4eikZAwyZrx8UbYC36lwe41AzjxaUgi/S5ikYUc1Nk0HZGi5csq53Ix
	JU01RmnADRhOlmLjGu3c4fvnhhWzoBBEw2MGvCrnxcuIrgah0j5wFFJcfi4QdNn/aCudaCiGRMm
	s/0EoZKLY/U0ttR9WjstUsHPrE6j2h8lPYbxFSxxICfkkszvC+BI5Qd0+T329SHPp0pTrx25pPx
	AmNh6aBRsI8GBaf5oL4EN24ozYQqYipbu6B4K02Q5xASpFJTGjbM7YHSSLX6S26iJ8zIQPoVoxZ
	9/eUW6TdxIuewYKDXMQEoLY1V6EztqLsXxSeOFhoOZamGz+vpXZWeRypB5n2W6u4xtWktvz0=
X-Received: by 2002:a05:600c:870b:b0:4a1:d487:2dc8 with SMTP id
 5b1f17b1804b1-4a1d760518amr230058635e9.18.1792502337460; Tue, 20 Oct 2026
 06:18:57 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019160615.2348500-1-nphamcs@gmail.com> <atcRLYvKavedT6Hs@yjaykim-PowerEdge-T330>
 <CAKEwX=MRvzzd0Fn=UX+LcRo+K9wuqCWSB42NNn7rvZkZukRRrg@mail.gmail.com>
In-Reply-To: <CAKEwX=MRvzzd0Fn=UX+LcRo+K9wuqCWSB42NNn7rvZkZukRRrg@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 20 Oct 2026 06:18:46 -0700
X-Gm-Features: AclHuK9yxutAL1VqPHvSn75b4RZFEVufpPDBhsYXxR7jl8qX4EzLhrwQ7rZCnpg
Message-ID: <CAKEwX=OwzpxUfdANEXoCeZPBqch+91C4gKwhrcikm6Gj_LBPKw@mail.gmail.com>
Subject: Re: [PATCH] mm, swap: revalidate populated clusters before scanning
To: Youngjun Park <youngjun.park@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 6:12=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Mon, Oct 19, 2026 at 11:58=E2=80=AFPM Youngjun Park <youngjun.park@lge=
.com> wrote:
> >
> > On Mon, Oct 19, 2026 at 09:06:15AM -0700, Nhat Pham wrote:
> > > swap_cluster_populate() can publish a cluster's table with the cluste=
r
> > > lock dropped. A cached allocator can use and empty it before the
> > > populating allocator reacquires the lock. The resumed scan can then
> > > dereference a NULL table.
> > >
> > > For example, CPU1 can retain a cached cluster offset on an SSD with
> > > per-page discard disabled:
> > >
> > >     CPU0                          CPU1
> > >     ----                          ----
> > >     swap_cluster_populate()
> > >       swap_cluster_alloc_table() fails
> > >       spin_unlock(&ci->lock)
> > >       local_unlock(&percpu_swap_cluster.lock)
> > >       swap_cluster_alloc_table()
> > >         rcu_assign_pointer(ci->table, table)
> > >                                   swap_alloc_fast()
> > >                                   local_unlock(&percpu_swap_cluster.l=
ock)
> > >                                   mem_cgroup_try_charge_swap() fails
> > >                                   swap_cache_del_folio()
> > >                                     __swap_cluster_free_entries()
> > >                                       free_cluster()
> > >                                         __free_cluster()
> > >                                           swap_cluster_free_table()
> > >                                             rcu_assign_pointer(..., N=
ULL)
> > >       local_lock(&percpu_swap_cluster.lock)
> > >       spin_lock(&ci->lock)
> > >       return ci
> > >     alloc_swap_scan_cluster()
> > >       cluster_scan_range()
> > >         __swap_table_get()
> >
> > Hello Nhat.
> >
> > Good catch!
> >
> > > Reject an unusable cluster under its lock before scanning it. Relocat=
e
> > > it only while its table is present.
> > >
> > > Fixes: cdd77f84d966 ("mm, swap: consolidate cluster allocation helper=
s")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> > > ---
> > >  mm/swapfile.c | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > > index c3288910b3e3..988b7316e0a1 100644
> > > --- a/mm/swapfile.c
> > > +++ b/mm/swapfile.c
> > > @@ -981,7 +981,11 @@ static unsigned int alloc_swap_scan_cluster(stru=
ct swap_info_struct *si,
> > >       bool need_reclaim, ret, usable;
> > >
> > >       lockdep_assert_held(&ci->lock);
> > > -     VM_WARN_ON(!cluster_is_usable(ci, order));
> > > +     if (!cluster_is_usable(ci, order)) {
> > > +             if (cluster_table_is_alloced(ci))
> > > +                     relocate_cluster(si, ci);
> > > +             goto out_unlock;
> > > +     }
> >
> > If this patch is applied as bloew, does it prevent the issue described =
here?
> >
> > https://lore.kernel.org/linux-mm/20260720071342.50742-2-shikemeng@huawe=
icloud.com/
> > (This patch publishes cluster table after lock acquired.)
> >
> > This patch is chagned the way I suggested during review... :(
>
> Ah I missed that patch series and your review! What happened to it?
> Did we just never land it?
>
> Looks like we are still doing neither Keming's approach (table
> copying) nor your approach (publishing at the end of
> swap_cluster_alloc_table()).

Ah nope, I saw that Kemeng implemented your approach:

https://lore.kernel.org/linux-mm/20260907091356.53026-2-shikemeng@huaweiclo=
ud.com/

My bad! But yeah I think we still need this small fix (or Kemeng's
original proposal?), unless I missed something...?
