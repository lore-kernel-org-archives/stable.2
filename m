Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795396460;
	b=qIrAfDpYENM4AmBlo1NJ+C8gSco7W3WXayNoeUgX+lfA36OoWnTPy/CtyQ8deam7zPKO
	 bEhMbI9cngKRGyd0n9SWSfKsBoz1y/TqH0Aws4wl7dEVqlqxmpXNCaxKoE71YdrH3e5uP
	 /TpmCqQdX5Fe/SPTyvpVZ8y7u7D/XTJYR4Yo0pzSpshghpdyS0FHHdTo+9C3LCo0Mbj6Q
	 svor3R84eMUaECMdEAXuu+FajrpL0T1xX20NPkCcNFLdd1jM+eMIshHiZHDHpC+UYFxvV
	 b/04Btnr1FsaXxse5Mo4DmgIr4XeYrrS2cMfgqFQzNGcfXPRmdOILUv2i2Ro/35LzaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795396460;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=beRsURI87z7ePC5UgnVhljfRVtiAk+JGSK5Yp7RQ++w=;
	b=xf8WmsnxHrbR2T9oleoui2qWg2EnICpi3CFQh8lB4SiA3WVYXM+9yl+vS3E0AVukIhcb
	 naXZOI9EBeh7r6oVszMM/kPc4zZ+OaTdLwy6/24yrfAZvIjNs6Sdo/u9UFA2jLy0AJ594
	 h24Y7cnVhAFtmjjVdeenxNkfpHzilWhrDE7LjwAS86O35zvlLSodITWZxN+RitDOAhQji
	 QH02IsWTBGx6fiYg9zPJMIbDLWXxCXjcN8yHxZwjCOMdSyEJbesAY2qHwmheCeBKau6pn
	 Y1XuccVjQjApu6aZKwV0e0IheS42p15CxT1+HySJyAYA8rpQs/Pm1tzrKSXXWjv9WIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ys1yFoMi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813F8606A68E
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 01:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ys1yFoMi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1193F1F01568
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 01:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795396460;
	bh=beRsURI87z7ePC5UgnVhljfRVtiAk+JGSK5Yp7RQ++w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Ys1yFoMi3EImki+984yKCe81INtZaQHTXOXdANgrHv9/I07zvlyD2nTpoYX/tGYqd
	 yc6+SySpdaII+pw8XgsrTCpM3A66tynOC/z8F1MdwNB3kNHswhMNS41AJQhEFJWboD
	 kiNSWkHXDArtd5kB8OIQ2CkeuPtd6BJI9R6GnvHBzCI9uDnu81zIxw13OUZ/mEDBWs
	 ZuCk07qi0/QolXdTFeDPWAVBeP5vGK4IVAd16QuexIaRJjVoKX9uD5yUHroorHerxs
	 ih8ab7EmuB5sbtxCgrx7uzM8MHnDn47aasBHwVh/E9KhwdGLxIAV2dlKcpxcdV+/9F
	 FjfZHMSnH4gMw==
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-949664ee41cso316509985a.3
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 17:14:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHH+SpbvHuuV7O+HZSdlbwOj7TGkuAATko2GCcZpUXBEGKPoJ0MTMFs6snC6RvPoiGUGpvOVH8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ogguAuopu4LU3RzXW+xQUaGTi3RUWjG1p/j7lVjxDiI06/6Qg
	xfolD1f1gQv9qQTEoe3NeFESoBqsSTm1e1k2DjW95u2t1aJFrZgqe34JroGIOOjITSvlWTJWyft
	G9DD4QsyOQqIg26K1FPDurpMQyKnFbhU=
X-Received: by 2002:a05:620a:450e:b0:949:5c62:e785 with SMTP id
 af79cd13be357-949ba9b7429mr1776786785a.21.1795396459175; Sun, 22 Nov 2026
 17:14:19 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261122-migrate_reclaim_deadlock-v1-0-83c56185b0fb@kernel.org>
 <20261122-migrate_reclaim_deadlock-v1-1-83c56185b0fb@kernel.org> <179537313704.412063.6683001223228002260.b4-reply@b4>
In-Reply-To: <179537313704.412063.6683001223228002260.b4-reply@b4>
From: Barry Song <baohua@kernel.org>
Date: Mon, 23 Nov 2026 09:14:06 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4yEeORJw8dQEH0U-JjWih3+3ZVx=1Va5F_9qsVbPzCLvQ@mail.gmail.com>
X-Gm-Features: Aa3M54qG1iauJEScw2ktzAtei45vPodUuwGuthkS3X5FKVC_OPLT-7KU2cnzR8g
Message-ID: <CAGsJ_4yEeORJw8dQEH0U-JjWih3+3ZVx=1Va5F_9qsVbPzCLvQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/huge_memory: use NOFS when allocating while
 splitting folios
To: "Gregory Price (Meta)" <gourry@gourry.net>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, William Kucharski <william.kucharski@oracle.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>, 
	Joanne Koong <joannelkoong@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, 
	Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 2:46=E2=80=AFAM Gregory Price (Meta) <gourry@gourry=
.net> wrote:
>
> On 2026-11-22 13:42 +0100, David Hildenbrand (Arm) wrote:
> > Various callers (migration, memory-failure, s390_wiggle_split_folio) sp=
lit
> > locked folios without holding a reference on the folio's inode.
> >
> > Splitting a file folio might allocate memory for the xarray and call
> > filemap_release_folio(). If either ends up in direct reclaim with
> > __GFP_FS, reclaim can evict the inode through the dcache shrinker, and
> > wait in truncate_inode_pages_final() for the folio that we hold locked:
> >
> >     try_split_folio()
> >       folio_lock(A)
> >       split_folio_to_list(A)
> >         xas_split_alloc()
> >           try_to_free_pages()
> >             super_cache_scan()
> >               prune_dcache_sb()
> >                 iput_final()
> >                   evict()
> >                     truncate_inode_pages_final()
> >                       folio_lock(A)
> >
> > This requires that nothing else holds a reference on the inode, and can
> > be triggered most easily with FUSE, which evicts inodes on the last
> > reference.
> >
> > Further, xas_split_alloc() charges the XArray nodes to the memcg, and o=
n
> > cgroup v1, memcg reclaim waits for file folios under writeback if
> > __GFP_FS is set. That can deadlock if writeback waits for a folio lock
> > that we hold, for example with ext4.
> >
> > Let's fix it by splitting folios in a NOFS scope, so callers don't have
> > to care. A NOFS scope also covers allocations that filesystems make wit=
h
> > their own gfp flags, for example in filemap_release_folio().
> >
> > On NFS, splitting folios with pending writes or ongoing writes to
> > fscache might now fail slightly more often, until these writes have
> > completed. On netfs, only folios that are being written to fscache are
> > affected. All fairly irrelevant.
> >
> > This has medium urgency.
> >
> > Fixes: 6b24ca4a1a8d ("mm: Use multi-index entries in the page cache")
> > Fixes: eef88fe45ac9 ("s390/uv: Split large folios in gmap_make_secure()=
")
> > Fixes: 789763523fb4 ("xarray: honor XA_FLAGS_ACCOUNT in xas_split_alloc=
()")
> > Cc: stable@vger.kernel.org
> > Reported-by: Chris Mason <mason@kernel.org>
> > Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>
> Reproduced the hang determnistically.
> Base deadlocked.
> With patch 1: -ENOMEM (safe)

Hi Gregory,

Just curious how those -ENOMEM failures occur. With GFP_NOFS, we
should still be able to reclaim anonymous folios (except in
SWAP_OPS_F_REQUIRE_NOFS cases) and clean page cache folios, right?


> With patch 2: split succeeds
>
> Tested-by: Gregory Price (Meta) <gourry@gourry.net>
> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
>

+1 for the patch itself.

Reviewed-by: Barry Song <baohua@kernel.org>

Thanks,
Barry
