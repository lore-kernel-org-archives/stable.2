Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793094061;
	b=FtFtI73x2383FyzxuPZpQe5WlVN1ifdn00ZfhuFXiGu5RQKGLh18CpnrZQ5NbudP4dLd
	 HOBN5+geD6tNdOL3tfs0gPeFYJ6x5LSSP97aCewnhYqL39WDV35JfFJPRCN09xztbR7iK
	 rQqaO4KTGpJxvNRvg5VIwjo4eLTlnWPIJ7sT+PZ2EuNNsDD8HLpKAMg94xphKC8z6MtpT
	 7mLZDTjeJinsPFns6hIrvrkFj0IhWC2caVia0HEO6jvY32RsalGmuUnCcaJdMVF5Ka/Tp
	 3UJpx2HnQqGvYQ3hMjwbcze72fcKvRhbNMQ8KObJoP7O7NXJXH67ulyGlTNXBtbcdmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793094061;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=JVBSyNaPKEtFoMBnmXCIBXxl7RDB3mGMHMJZz01NkVk=;
	b=pZZtC4JISZXlMcennuMZb+nWCVN8JjfUMMirhHwT1dqPxO7/q28igxHcnPqZZmlQYVZI
	 WAW7Muhub2IRhyOHflvuaWO9u+8FHtq/wQnz+VFaI7ZUjxIHHC0osFgm3iQGSykEAQ/47
	 aFnq/+H3K5uEkO+x2vpz0tPekX/qdLwI41MIGpkWifOJqDIsG/OFbC3n2MHVi5g0hOKYK
	 TIxkErPR7dxfs8bmJsXpkMeNxcoqHq3zM3Xm7/bNulk+m0872zATi+srlaFxHAekNb94a
	 iFdZOR+TnfVO4HxADiYPvkUCAHge72pPbowlrB+IIta5ktjc8o5fzStZ8BLXPnOwyrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Cb3HmVQU;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB0D606A31B
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 09:41:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BB0D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Cb3HmVQU
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so3322266f8f.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 02:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1793094059; x=1793698859; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JVBSyNaPKEtFoMBnmXCIBXxl7RDB3mGMHMJZz01NkVk=;
        b=Cb3HmVQUB4Lk3lJ79uCjsoT4M/qng2XCwVuFJd72c76fT2RpGya+bs94EVQS3lXDmZ
         Cg6Q/94Kp3EhZ+A4j0FZjWN7jGX4D6jypPFwwK0yPUImFmFPBTlpaSeUh2a7bEC1QbUd
         tr+NkkzXvQt6SV1iynM+/8ppGaWS+slHAvSfG53l13e7LLNjulAMqbtEqwtpFqVnOnGW
         JmTaemFR5SrKvLjFC7wFZ54Pxa5aI0vOlssM2QPIltl6RZXoedLpf7CdZLldhKIIu4MS
         bWbXpjrLCpBEtF3JY+6vwFTkIORr9u73Mx3nz3PLfGM63BCnn7/LqxxYIXWVl9C0nZgn
         Klpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793094059; x=1793698859;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JVBSyNaPKEtFoMBnmXCIBXxl7RDB3mGMHMJZz01NkVk=;
        b=VsZSfA1ITELheB5pPT2961tAWKR1wT7TlD1VfPFjxiJh9cHbqRXZoE/AzfetFgLwx4
         GviTQ800swkukH7EBP4tbtfJplCT6nbzG7wQhyqjCiH2B/alod5mneMUdrneK9vtW9Sz
         AErHcy8m5OP98Jag6f1MySpV2v9VJhgwib9YgWVB7krfo+iQ2WxEs3R+pvXA5mfN6EB4
         EMCZembB9unMeeS7EAoffmyi2qN9kxqpbo9cHZZy+Dll5D/JrZYog1f99mbbjcqTi/yv
         zUBEkLp7/EoQHOXhXfawZ+knb/9bMIfH8NuTrCbfXOjIlb1Gbj51UJbqvbnGwrWtwYQJ
         KaNQ==
X-Forwarded-Encrypted: i=1; AKwUvBws5BT6IYjGQPkahez6sv3AyaROmJIhtRyfrnSJ2WLFvrTVnBe/gv3PSM8bOZyfBSTDo9AizaI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJb4LwdT1LaDK7haL1pAsAASbSpVz3ml5UmHdkhwCeqemBIKTof
	mJF8Pz2PJ+2B4eOGeyDWWDgVOJ9aeUy9JTe9JcqXdJ+6/1iOVDecP17Hix8IufmE96I=
X-Gm-Gg: AYBFou2SGd9AT31VThRMQBw4z+B+11kR/ODKGLmoIvdSXZexxVvxShp54eVElsp/n91
	xJ877BMG7cXBbu7IjgmJthViygPUp1/PYViKaqnClZBD91jpBIX0UPkBD5m5oHClgBu5NbZ9kD6
	0FuNQyRnKZEWuXmh3QepqzZBwsuZdV5Z6bJmgDLn46z6DdcW7MXOpurHpSJj1Lky00AAqouFezn
	vkVdsqbQ0j2/9PgEkHl/jhyHwV3tzhSVKplmdsCBAVBtHEIDC7MS292SABWeymCUcJckKwpH6oT
	bhMgaOFfOimcW6VBb0cqe/s7Xja4i19ejZTLgMvTckkYDJXm01RTFAdQn6F4L4olcpu8U0AV3JO
	dJRlxG+5cyYptzcb52UzdH5B9uau8KRzxWR0KIFoPJREyR7XrfAPo+u+3l6IAOCckBv0DwzEMbH
	UQdax8yiEUrLQM8nIiV1um6RQ75fa+DL3eHa0ij6AAJbmU4dzjwjHK+7Xgj9Yc2uCATCV2m8J9v
	+vc69lofUYLAUpWWZ05fw0qBwYFH4iz1UDn4u1uh6azT3S5Vgv/KWunSySmMTsh5V0N+Q==
X-Received: by 2002:a05:6000:2989:10b0:48d:fbdd:4132 with SMTP id ffacd0b85a97d-48e3eb78141mr13538157f8f.18.1793094058994;
        Tue, 27 Oct 2026 02:40:58 -0700 (PDT)
Received: from localhost (109-81-20-177.rct.o2.cz. [109.81.20.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd4bc5sm21909641f8f.34.2026.10.27.02.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 02:40:58 -0700 (PDT)
Date: Tue, 27 Oct 2026 10:40:57 +0100
From: Michal Hocko <mhocko@suse.com>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: hannes@cmpxchg.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, zhengqi.arch@bytedance.com,
	akpm@linux-foundation.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol: fix NULL pointer deref in
 high_work_func() on dying memcg
Message-ID: <auBxqU34FQYauoQr@tiehlicka>
References: <20261023222313.3979455-1-tjmercier@google.com>
 <at9U2HvyUP-iYOCt@tiehlicka>
 <CABdmKX1mLKEJNiecW+meJ=LB_Kb8-ieeWdZDd4T6rNR9gKuq_A@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABdmKX1mLKEJNiecW+meJ=LB_Kb8-ieeWdZDd4T6rNR9gKuq_A@mail.gmail.com>

On Mon 26-10-26 11:01:51, T.J. Mercier wrote:
> On Mon, Oct 26, 2026 at 6:25 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Fri 23-10-26 15:23:13, T.J. Mercier wrote:
> > [...]
> > > ---
> > >  mm/memcontrol.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index a05d9a8baa1b..84f4a8fd4d16 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -2457,7 +2457,10 @@ static void high_work_func(struct work_struct *work)
> > >       struct mem_cgroup *memcg;
> > >
> > >       memcg = container_of(work, struct mem_cgroup, high_work);
> > > +     if (!css_tryget_online(&memcg->css))
> > > +             return;
> > >       reclaim_high(memcg, MEMCG_CHARGE_BATCH, GFP_KERNEL);
> > > +     css_put(&memcg->css);
> > >  }
> >
> > OK.
> >
> > >  static void high_irq_work_func(struct irq_work *work)
> > > @@ -4463,6 +4466,8 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
> > >
> > >       page_counter_set_min(&memcg->memory, 0);
> > >       page_counter_set_low(&memcg->memory, 0);
> > > +     page_counter_set_high(&memcg->memory, PAGE_COUNTER_MAX);
> > > +     page_counter_set_high(&memcg->swap, PAGE_COUNTER_MAX);
> > >
> > >       zswap_memcg_offline_cleanup(memcg);
> >
> > Should we simply disable_work_sync when the memcg is going to be
> > released instead (mem_cgroup_css_released)? That should both prevent
> > the run reclaim_high during the memcg shut down and and also avoid
> > plaing with limits to work around.
> 
> Hi Michal,
> 
> Unfortunately that won't work for shrink_many() ->
> !mem_cgroup_tryget() -> lru_gen_release_memcg() which can occur before
> mem_cgroup_css_released() runs. (mem_cgroup_css_released() happens
> through the cgroup_release_wq.)

I do not follow. Could you explain why please?

> The high limit reset is also needed for targeting live ancestors above
> the offlined child in try_charge_memcg(). Without the resets,
> high_work is never attempted on them since it gets dropped when
> attempted on the offlined child due to the first hunk, and
> try_charge_memcg() breaks out of the loop.

I must be missing something really obvious here because I really do not
follow you here too. So we are offlining a memcg. We need to coordinate
memory reclaim with the memcg tear down, right? For the high reclaim we
can achieve this synchronization through disable_work_sync in
mem_cgroup_css_offline. For a synchronous high memory reclaim we do not
have such means but we are keeping a memcg reference which makes the
lifetime well defined. If you reset counter you might help to bail out
early(ier) but that shouldn't be necessary from a correctness POV as it
doesn't provide any explicit synchronization.

> Shakeel's remote charging patch
> (https://lore.kernel.org/all/20261010210957.1350874-4-shakeel.butt@linux.dev/)
> sends remote charges through high_work too, so without the resets
> those would lose ancestor reclaim the same way. Before that patch not
> performing the resets means reclaim_high() runs unnecesarily against
> current's memcg (not the remote memcg above memory.high).

-- 
Michal Hocko
SUSE Labs
