Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4155537E304
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 09:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789378995; cv=none; b=Y6QuEmfhCDVr4p/+N53iMKYjMDr5/7IGO5B5tgpkxujiGLMxYmOnVmEUKyDc5OU4+I3CD3Woql+ba9nPBzSXehqwthpFMWeP4MA4rQENpWLVexez+N5eo2ho2HP+zEXGYt8+lbJbhjp7J0/OFsuc9HoE1ArNlFSTTPFv3yHGf7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789378995; c=relaxed/simple;
	bh=vzR0Nu5ihNt7ewNW0Ak+kaQx+j6OhLWm0YvHvpWifnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VRkI2GTzkj2BffQYawHMsHya2awCtkaSeQdkasny2sPZCPlZHC39h4O/fv/pT4oTewgV6gr8acwsjVqNQxdiYubb+fx/Zzcomf0qHdLmUV+CLIOvWObQmTjgApaURD++hhcVYyXmd9zvXgf+0eJoQUmg3R4qIgDng92xyx2qmSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbuxahmN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbuxahmN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1031F00898
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 09:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789378991;
	bh=Kv8rqtiGZqyi1hpD7UofsDSzonROv6KDIfnEAf5fFS4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=gbuxahmNQpuV4vHz7voacM4XHxXWQPfYvPaa0ii2ZYcsvBlbLgdDmkgXRQ1ErgAWw
	 unKidD8YVaNPzsHx3MTmTmPvLff4TBWZ8EEasP1Pw3p9rYhtzow8eS4nxNn1cJrXOq
	 ooGci8+SOFAKO+WU2wP38uUzUo4JOpIIJC+gcZ6U9jMnyqs0xWa6thLYzyymKWHNJv
	 OOoIz4k0FSyu8npreAl7bRe8EXfIaQ/AWv7nPCPmrV4Hd+kwqNv0ZV2LpkFO6amlAz
	 +Y8Lz/wp0IXTnjGrNFRCaERHC7soBD3GyXPKssrtB9QumOXZJ5Pnr/w0Wbd4Q3lJyU
	 IUqUagf43k6Ng==
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93910cadeb7so241087485a.0
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 02:43:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBziO66TVvzwYLZnzscUFh+Yc/JeOveTFiosXtdMnpJpwZDxZvrUX6Gc5xoBzkmmvU1UZuGqCsQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nkNpo5WdqHx8nt5t49oWn05SMP/HLNLqJZR9zDdp/lifuqMC5z
	JNLkIXbXfJsZMunYTimXo+hrSxgrRMnGREhWnTjq8wpLD0J1LBwmP9cdTNFU41XdKz1u8jldQrW
	8jpI0UW2XpJZBTZxfNeiOwPea6XL3OZs=
X-Received: by 2002:a05:620a:4888:b0:939:d762:e2d8 with SMTP id
 af79cd13be357-93a299943efmr246987885a.31.1789378991186; Mon, 14 Sep 2026
 02:43:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3fa43eaca792bc0bbde4b82a6c1fcdd3f528b398.1787999152.git.qiwenjie@xiaomi.com>
 <4aba05e1a2c3b61cb337d373eb9b7a8db4ddd822.1788024049.git.qiwenjie@xiaomi.com>
 <20260829111621.41ed2bc9a0e99e3367eb96c3@linux-foundation.org>
 <ef160933595c365f2c47597b260bc7ecd98ed7ce.1788029516.git.qiwenjie@xiaomi.com>
 <076bb01b-6fcf-4691-be8c-0e8507c9fe64@columbia.edu> <CAGsJ_4xMK=rPXCH5OiCOYHKRQp-w+xDJQusJ_ykbuAuLZr+8bA@mail.gmail.com>
 <1e5118a5-6b61-49d0-85e1-825e22059241@columbia.edu> <CAGsJ_4wj6XvPB+QF+_X1BJ_8Y2sZEEFAw6RaJJz-cHaDWLkxaQ@mail.gmail.com>
 <65a2c7df-0d2e-46de-9580-01e9c35a7e32@columbia.edu> <CAGsJ_4zS+UehT4wuTuTVjK3s3mhzp+dku8M-Of9cF=CN82aRow@mail.gmail.com>
 <hbki3yc23dr5fkre5phwx2ev6yjfn3ooodan37uo3at53y3gs2@kjyxyb34s5bi>
In-Reply-To: <hbki3yc23dr5fkre5phwx2ev6yjfn3ooodan37uo3at53y3gs2@kjyxyb34s5bi>
From: Barry Song <baohua@kernel.org>
Date: Mon, 14 Sep 2026 17:42:59 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4xNLEhrCZR-7ZAxBnYV8BDzuQT29yT419mObVRGH71AVg@mail.gmail.com>
X-Gm-Features: AcwNN1VW7ZXNpSPCOSVUlF1vVmj1aC20DEJiwVHJ6AoiSxuUJwZ0j8Znnu0_b2U
Message-ID: <CAGsJ_4xNLEhrCZR-7ZAxBnYV8BDzuQT29yT419mObVRGH71AVg@mail.gmail.com>
Subject: Re: [PATCH v4] mm: filemap: retain mapped dropbehind folios
To: Jan Kara <jack@suse.cz>
Cc: Tal Zussman <tz2294@columbia.edu>, Wenjie Qi <qwjhust@gmail.com>, willy@infradead.org, 
	akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, axboe@kernel.dk, 
	trond.myklebust@hammerspace.com, jaegeuk@kernel.org, chao@kernel.org, 
	qiwenjie@xiaomi.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 5:33=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 14-09-26 09:09:32, Barry Song wrote:
> > On Mon, Sep 14, 2026 at 7:34=E2=80=AFAM Tal Zussman <tz2294@columbia.ed=
u> wrote:
> > >
> > > On 9/13/26 6:51 PM, Barry Song wrote:
> > > > On Fri, Sep 4, 2026 at 6:36=E2=80=AFAM Tal Zussman <tz2294@columbia=
.edu> wrote:
> > > >>
> > > >> On 9/4/26 12:28 AM, Barry Song wrote:
> > > >> > On Sun, Aug 30, 2026 at 7:59=E2=80=AFPM Tal Zussman <tz2294@colu=
mbia.edu> wrote:
> > > >> >>
> > > >> >> On 8/30/26 6:25 AM, Wenjie Qi wrote:
> > > >> >> > From: Wenjie Qi <qiwenjie@xiaomi.com>
> > > >> >> >
> > > >> >> > Fault-around can map ready dropbehind folios without going th=
rough the
> > > >> >> > normal page-cache lookup that clears dropbehind. A mapping re=
presents a
> > > >> >> > competing cached user, but writeback completion can currently=
 unmap that
> > > >> >> > folio. A later mmap access must then fault it back in.
> > > >> >> >
> > > >> >> > Retain mapped folios instead. For a mapped folio,
> > > >> >> > folio_unmap_invalidate() can call unmap_mapping_folio(), whic=
h takes
> > > >> >> > i_mmap_rwsem and may sleep. Retaining the folio also avoids t=
his path when
> > > >> >> > folio_end_dropbehind() runs in non-preemptible task context.
> > > >> >> >
> > > >> >> > Unmapped dropbehind folios continue through the existing inva=
lidation path.
> > > >> >> >
> > > >> >> > Fixes: fb7d3bc41493 ("mm/filemap: drop streaming/uncached pag=
es when writeback completes")
> > > >> >> > Cc: stable@vger.kernel.org
> > > >> >> > Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
> > > >> >> > Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > >> >> > Reviewed-by: Tal Zussman <tz2294@columbia.edu>
> > > >> >> > ---
> > > >> >> > The mapped-plus-dropbehind state was reproduced in QEMU. The =
patched
> > > >> >> > kernel retained the mapped folio and continued to evict the u=
nmapped
> > > >> >> > dontcache folio. I did not reproduce the sleeping-in-atomic w=
arning and
> > > >> >> > am not aware of an existing report.
> > > >> >> >
> > > >> >>
> > > >> >> I was able to trigger the sleeping-while-atomic BUG on current =
mainline with
> > > >> >> some help from Claude. The reproducer itself is straightforward=
 enough, but the
> > > >> >> configuration was a little finicky. The atomic context comes fr=
om using
> > > >> >> threadirqs so that virtblk_done() completes requests from the i=
rq thread under
> > > >> >> local_bh_disable() and the vq spinlock with irqs off, so in_tas=
k() is true but
> > > >> >> the i_mmap_rwsem down_read() sleeps. It also needed 1 vCPU (so =
completion stays
> > > >> >> in the irq thread rather than softirq) and ext4 -o dioread_lock=
 (so end_io runs
> > > >> >> inline instead of on a workqueue). With v4 applied the bug is g=
one, so:
> > > >> >>
> > > >> >
> > > >> > Thanks, Tal. Then I'm getting quite confused. Since with Wenjie'=
s
> > > >> > patch, we are no longer going to sleep for dropbehind in `filema=
p.c`,
> > > >> > do we still need all the complex logic in the block device and f=
ile
> > > >> > system layers to move dropbehind to a workqueue task context?
> > > >> >
> > > >>
> > > >> Hi Barry,
> > > >>
> > > >> Let me clarify. Wenjie's patch prevents sleeping in a very specifi=
c case.
> > > >> The existing in_task() check covered most other cases, in that it =
just
> > > >> doesn't do dropbehind invalidation if we're not executing in task =
context
> > > >> (for example, block device writeback completing in interrupt conte=
xt).
> > > >>
> > > >> However, dropping the invalidation defeats the point of dropbehind=
, as it
> > > >> leaves the pages in the page cache. If we get rid of the task-cont=
ext
> > > >> deferral mechanism, we wouldn't sleep, but we also wouldn't invali=
date.
> > > >> Wenjie's change is largely unrelated to this.
> > > >
> > > > Hi Tal,
> > > >
> > > > Thanks for the clarification. However, I=E2=80=99m still not convin=
ced.
> > > >
> > > > If `unmap_mapping_folio()` is the only place where we might
> > > > sleep =E2=80=94 where we might take `mapping->i_mmap_rwsem` through
> > > > `i_mmap_lock_read()`, as Wenjian pointed out in [1] =E2=80=94 we ha=
ve now
> > > > prevented that from happening with `if (!folio_mapped(folio))`.
> > > >
> > > > So no mapped folio should call `folio_unmap_invalidate()`:
> > > >
> > > > static void filemap_end_dropbehind(struct folio *folio)
> > > > {
> > > >          struct address_space *mapping =3D folio->mapping;
> > > >
> > > >          VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
> > > >
> > > >          if (folio_test_writeback(folio) || folio_test_dirty(folio)=
)
> > > >                  return;
> > > >          if (!folio_test_clear_dropbehind(folio))
> > > >                  return;
> > > >          if (mapping && !folio_mapped(folio))
> > > >                  folio_unmap_invalidate(mapping, folio, 0);
> > > > }
> > > >
> > > > Why do we still need the `in_task()` check in
> > > > `folio_end_dropbehind()`?
> > > >
> > > > void folio_end_dropbehind(struct folio *folio)
> > > > {
> > > >          if (!folio_test_dropbehind(folio))
> > > >                  return;
> > > >
> > > >          /*
> > > >           * Hitting !in_task() should not happen off RWF_DONTCACHE =
writeback,
> > > >           * but can happen if normal writeback just happens to find=
 dirty folios
> > > >           * that were created as part of uncached writeback, and th=
at writeback
> > > >           * would otherwise not need non-IRQ handling. Just skip th=
e
> > > >           * invalidation in that case.
> > > >           */
> > > >          if (in_task() && folio_trylock(folio)) {
> > > >                  filemap_end_dropbehind(folio);
> > > >                  folio_unlock(folio);
> > > >          }
> > > > }
> > > >
> > > > Could any other operation in `folio_unmap_invalidate()` sleep for
> > > > unmapped folios? Otherwise, it seems we don't need `in_task()` at
> > > > all?
>
> We do need it. folio_unmap_invalidate() calls filemap_release_folio() whi=
ch
> calls into ->release_folio() handler and generally filesystems are allowe=
d
> to sleep in this handler. Now usually they don't actually sleep there but
> they definitely grab a lot of irq unsafe locks there as Tal writes below.

Hi Jan,

Thanks very much for your explanation. That makes a lot of
sense to me.

Then, based on the above, I am getting into another confusion and
have another question. If `release_folio()` is actually allowed
to sleep, and some filesystem might sleep there in the future,
wouldn't Wenjie's patch [1] make sense in that case, as it
guarantees that `->release_folio()` is always called in a
sleepable context, while `in_task()` does not provide such a
guarantee?

https://lore.kernel.org/linux-mm/20260820142956.1414337-1-qiwenjie@xiaomi.c=
om/

Best Regards
Barry
