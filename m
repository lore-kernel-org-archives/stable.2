Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795693877;
	b=VLcsf//1LVG1VeqXKmWDMqegVymdvLi5SSuR/PqlB4S1abSHlP5ILBryOye89Hyfzsmw
	 F9Sr4WCsonjXG+v9BbWWX3Rg61KpYRKaFtm4l5ZjWxqbgTA18Abw/kE9f9wZpQZq6rZhy
	 Xaz8X60p7vtwUoCj/Ye0vIZhTd0AhA81ShqMV3YDcQrHhMKCsmNxTcrVFAGHp72d6d9kP
	 4o4PzmCKZXuKnDg3QKoOvqzRC8RuBekCaskd2hAIoWdZwWVBdVI5PhqxAqX4wei62Urun
	 KJ/H2ZxBYSZZAcbrhT44oQyMrKf3PFL4gaFkAYVLF35og+9/2iqGO7QNheOfAoDIwzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795693877;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=liE+IJazZ5oAskLl1TgZ0dicfhbRnZKFpT1xxjcaIV4=;
	b=VeaS7IrtVcpIgIpuFNuBdEoAaA60LHr128sm7CksX9cwSwqmGUh91mfihY0s0mYkflPq
	 KoRIg42Qp2SnZqVOBAY3UvoGBJmvFmez1+gLzu/ivEIZHsJ38VqUbCE1L+pM5lQPqfyHG
	 5yUFCcVxNW5K3tyPGIcqAkKJ1AwCOAn/9RPrQ26Vk7MdpI6Dbsx4hPqtVTWjxrS8AxTCz
	 NPdgEq1xHmenSGsM/xaJ/sa08vklIzyM/j41K6aUiT7m+gFJCDLs/hUCN64iN2LEbH2pa
	 ayVOIvAzLvKJoNDnO6Oxz1B1fLeXEg0kH9ggknvFEze8nd/Z5yGg9aILy1dtP+HOA+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HOoX5cdp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F02606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 11:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HOoX5cdp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA241F008B2
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 11:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795693876;
	bh=liE+IJazZ5oAskLl1TgZ0dicfhbRnZKFpT1xxjcaIV4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=HOoX5cdpqas6YaDLda8NQPo9m3BoYqastRShJFtlPinlbdYA/wwwznMIoUGv1Ifof
	 KXU4+LtHUMdigAw3VE9xJKiMDYUdiJZdZ7ddH4z+OQu/2PEUDHBHPZpHPRKpBex+6B
	 zdMYSrrr59RauaqIffrbCUjFZlCbeJxmAYJ1SsHoQBZOFW8zEnDLf0Mn6tyf39vo0p
	 TcyLdkNJrFKIBb0Jd5B6dPS0gOgKvKrwuJglVkkq8+FCWD0HgAgHryW+lPGLnebdgF
	 gpULuv4dSTAkxH8tkaKlWmY1Kv4avapmm4PzR/9/PkW1HmgnhBNaBDhzd8BKUCVfqF
	 9a1z0XRdggkEw==
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-94961b68685so569033385a.3
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 03:51:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFbONYwDpBg6Sl3B/zjXl5pG2DC9k/KfYlK+eqiFC3MoYWyjematugs+TvJi5yfefKEdUWQp7o=@vger.kernel.org
X-Gm-Message-State: APuU4Z8aFUnQjqNdfiX3Y9q/TOzQ7Fr38eYVpQ+N791t+PZe/1mnSshE
	vqj29XtnnUPDqQn9cVvl8WhnmU/fan5j6AvSR4L7M9Nwb3GAKyT3dVZH8y2hzokhwAdIgy6dfFe
	p2w7Q6BfHEOZC/YZwXTk5D9hau8S+H8c=
X-Received: by 2002:a05:620a:29c8:b0:949:7270:b95 with SMTP id
 af79cd13be357-949baa0b256mr3618065185a.32.1795693875794; Thu, 26 Nov 2026
 03:51:15 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261125-fix-mglru-kswapd-age-v2-1-4cc37437af9b@tencent.com>
 <CAGsJ_4z-UdXQg0LYqymEZdoHALPmAZC7eGcXbGad6f0sdjmkcw@mail.gmail.com>
 <awarDrT/DT7tQu+U@lima-default> <CAGsJ_4zf5NabZJanr2_Czr3oVQe6tTTdXmddx+PxowbKBN9M8Q@mail.gmail.com>
 <awgCInIqygIBMRGt@lima-default>
In-Reply-To: <awgCInIqygIBMRGt@lima-default>
From: Barry Song <baohua@kernel.org>
Date: Thu, 26 Nov 2026 19:51:03 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4wBuFz=Nxn=aiwUONerkJVgwKVyp0sbfg0tSa=J=VCo+g@mail.gmail.com>
X-Gm-Features: Aa3M54rmeYOf-N8Nk_jy_G3CeuifqjF8MjvxO4s3hxNTXy0zU7zsvhgvahj5T2Q
Message-ID: <CAGsJ_4wBuFz=Nxn=aiwUONerkJVgwKVyp0sbfg0tSa=J=VCo+g@mail.gmail.com>
Subject: Re: [PATCH v2] mm/mglru: skip oom killing for order != 0 allocs in kswapd
To: Bingfang Guo <bfguo@icloud.com>
Cc: bingfangguo@tencent.com, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@kernel.org>, Michal Hocko <mhocko@kernel.org>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 26, 2026 at 5:56=E2=80=AFPM Bingfang Guo <bfguo@icloud.com> wro=
te:
>
> Hi, Barry!
>
> On Thu, Nov 26, 2026 at 08:40:44AM +0800, Barry Song wrote:
> > On Wed, Nov 25, 2026 at 5:32=E2=80=AFPM Bingfang Guo <bfguo@icloud.com>=
 wrote:
> > [...]
> > > You are right. Maybe we can start from skipping aging in reclaim path=
 if the
> > > youngest gen is still too young? And maybe for this path, min_ttl can=
 have a
> > > default value? Is that a good idea?
> > >
> > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > index d891ae46baf49..7f9b14b772d14 100644
> > > --- a/mm/vmscan.c
> > > +++ b/mm/vmscan.c
> > > @@ -5136,8 +5136,11 @@ static bool should_run_aging(struct lruvec *lr=
uvec, unsigned long max_seq,
> > >                 return false;
> > >
> > > +       /* avoid excessive aging for huge allocations */
> > > +        if (unlikely(sc->order)) {
> > > +               int gen =3D lru_gen_from_seq(max_seq);
> > > +               unsigned long birth =3D READ_ONCE(lruvec->lrugen.time=
stamps[gen]);
> > > +               return !time_is_before_jiffies(birth + min_ttl);
> > > +        }
> >
> > I'm not convinced that we need to couple the aging decision with
> > min_ttl protection.
> >
> > This has been a long-standing problem: high-order allocations can
> > trigger excessive reclaim and still fail to obtain contiguous
> > memory.
> >
> > I've tried to address this twice, but haven't found a satisfactory
> > solution yet:
> >
> > https://lore.kernel.org/linux-mm/20260422021842.78495-1-baohua@kernel.o=
rg/
> >
> > Johannes shared some thoughts on this here:
> >
> > https://lore.kernel.org/linux-mm/aejtfpBUu7gNV6Tk@cmpxchg.org/
> >
> > Do you have any traces showing how many pages kswapd scans and
> > reclaims while kcompactd makes little progress toward satisfying
> > order-9 allocations?
>
> We encountered this problem when running a stability test on a 6G
> VM with 2 nodes. It populates the system with hwpoisoned pages
> per 511 pages so order-9 migrations should mostly fail. Then it
> tries to allocate order-9 pages. So the results might not quite
> reflect real scenarios, but I think that applies to unmigratable
> pages such as slab as well.
>
> When the system OOMs and kills all the processes, we have about
> 4.8 GiB memory free and:
>
> PGSCAN_KSWAPD                 : 162,406,932
> PGSTEAL_KSWAPD                : 91,233,588
> COMPACTMIGRATE_SCANNED        : 6,542,604,811  (kcompactd: 4,041,105,566,=
 61.8%)
> COMPACTFREE_SCANNED           : 541,265,798    (kcompactd: 348,448,520, 6=
4.4%)
> COMPACTISOLATED               : 174,688,832    (2.67% of migrated)
> PGMIGRATE_SUCCESS             : 100,824,439
> PGMIGRATE_FAIL                : 2,022,069
>
> So seems in this case, compaction fail rate is quite high and we
> have really many scanned pages compared to the actually used size
> (about 1G).
>
> >
> > Basically, I think we need some form of throttling to prevent
> > kswapd from freeing more and more memory when there is already
> > plenty of free memory, yet compaction is making little progress
> > toward satisfying order-9 allocations.
> >
>
> Yes! And I've read your and Johannes's previous discussions. It
> also seems weird to me to keep reclaiming even if there are
> plenty of pages available there. And it's quite tricky to balance
> between that and concurrency...
>
> Looking into shrink path in kswapd,
>
>         sc->nr_to_reclaim +=3D max(high_wmark_pages(z: zone), SWAP_CLUSTE=
R_MAX);
>
> I think this is too much, for this case. So I think maybe we can
> still reclaim for scalability, but reduce its target. At least we
> should take reclaimable memory size and free memory size into
> consideration, and rescale nr_to_reclaim.

So, conceptually, is this along the lines of what we have in mind?
I'd also be interested in hearing Johannes's thoughts on this.

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 81797b71228f..0144fe4be738 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -7450,17 +7450,31 @@ static bool prepare_kswapd_sleep(pg_data_t
*pgdat, int order,
  * This is used to determine if the scanning priority needs to be raised.
  */
 static bool kswapd_shrink_node(pg_data_t *pgdat,
-                              struct scan_control *sc)
+                              struct scan_control *sc,
+                              int highest_zoneidx)
 {
        struct zone *zone;
        int z;
        unsigned long nr_reclaimed =3D sc->nr_reclaimed;
+       bool can_compact =3D sc->order > 0;

        /* Reclaim a number of pages proportional to the number of zones */
        sc->nr_to_reclaim =3D 0;
+
        for_each_managed_zone_pgdat(zone, pgdat, z, sc->reclaim_idx) {
+               unsigned long mark =3D high_wmark_pages(zone);
+
+               if (can_compact && !compaction_suitable(zone,
sc->order, mark, highest_zoneidx))
+                       can_compact =3D false;
                sc->nr_to_reclaim +=3D max(high_wmark_pages(zone),
SWAP_CLUSTER_MAX);
        }
+       /*
+        * If all eligible zones are already suitable for compaction,
+        * limit further reclaim to avoid over-reclaiming due to
+        * fragmentation.
+        */
+       if (can_compact)
+               sc->nr_to_reclaim =3D min(sc->nr_to_reclaim,
compact_gap(sc->order));

        /*
         * Historically care was taken to put equal pressure on all zones b=
ut
@@ -7637,7 +7651,7 @@ static int balance_pgdat(pg_data_t *pgdat, int
order, int highest_zoneidx)
                 * enough pages are already being scanned that the high
                 * watermark would be met at 100% efficiency.
                 */
-               if (kswapd_shrink_node(pgdat, &sc))
+               if (kswapd_shrink_node(pgdat, &sc, highest_zoneidx))
                        raise_priority =3D false;

                /*

Thanks,
Barry
