Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7FE23392D
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 01:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789348185; cv=none; b=TuiL56WHu1YnkuaB3hVxuDoFnK5dQBj3lUlrG7YDlUVAVDYvUpzJvjUjdu+bvyXKe65PR13X4Id8Pmeo05lxF21FM6puA4qbjwL2LFi5Mfl0oQjXAKR2w+tREY0fYSYn7iVl6qeztYTCnmz3Pa33RNhPTv0WRMo4yIQ0uymJBmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789348185; c=relaxed/simple;
	bh=n1xjytiEmtJb2DX0y2NLkgCfVqlqN7ZA1i7C3afS57I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dz5tp0zTNJMxDEgG4a8ByzbX9SB86ZTOsNjtvy49YypKBn8JrgRhaUzieJddPmIbvJHE9H87rDaWoR08py6hz+ErK5GXN5ik8ZiQCN7yAcDFi+RuO0uL893YTrV51aAaJM97jdtVGWH50EoORb0gtOFlHLg5FwinXx+BWg1EUAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCW7fxAz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCW7fxAz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E46C71F0089B
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 01:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789348183;
	bh=4ndSNsr2rSjtlZsOTZb7f4dR7eAAlwrJ58BLG0WJdXg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=TCW7fxAzHNuqev2i1C/rBmI02474P77pm4O27dKtfNyEpY+h+xwSsD+3isGzVVGne
	 v1TnbmFegLg6HSkvEVYpldRPBLzMq+Si+r3RWu7iqusXjyzxKJrpvLY9FUzEIWw0f3
	 o05VLC80aHNb+CnAdERGAdEQ2ZgGNNFrF+UmtiVOUZJxpXbwPnFCWuctKhC+x2Zs1z
	 WaEVQL2qWaJ3WDAXvSVEUZL/xqBtR10jABOzBjgEyOxSJaNc4TIGHDjCQQCfCZZTHN
	 OdB02P372dN8uzJNypD5mAjg3ORVDIF1vSqBJphBaNaqRP24ERNhtCQ71aMl51tERG
	 tDqGLcCa4ujUw==
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93a00298c53so113275885a.1
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 18:09:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwauwbsaSHyOMK2YSOCEB/6e8aa88R7rHgumO6uGOR1V4+PXIIn+CgGM7MIZCWKf30lY+6z5lE=@vger.kernel.org
X-Gm-Message-State: AFuF++nRSO8nRE4J6I4Gn5U7bdd2zUncqVdOD/4TBhQDgMvfH89Tpi+V
	4Be7n2IMfULmPf9J35Y9ArkFL/QmVE6u7wp692QRHilvqkre/KidHBA4jZaHOYaO+5IXvxBYwt4
	Cgn1Ph7NdNPdDzQ5NiwbYkfBrPZvSJ3c=
X-Received: by 2002:a05:620a:2707:b0:939:bd4e:b2fe with SMTP id
 af79cd13be357-93a29a12d15mr69398285a.40.1789348183191; Sun, 13 Sep 2026
 18:09:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820142956.1414337-1-qiwenjie@xiaomi.com> <3fa43eaca792bc0bbde4b82a6c1fcdd3f528b398.1787999152.git.qiwenjie@xiaomi.com>
 <4aba05e1a2c3b61cb337d373eb9b7a8db4ddd822.1788024049.git.qiwenjie@xiaomi.com>
 <20260829111621.41ed2bc9a0e99e3367eb96c3@linux-foundation.org>
 <ef160933595c365f2c47597b260bc7ecd98ed7ce.1788029516.git.qiwenjie@xiaomi.com>
 <076bb01b-6fcf-4691-be8c-0e8507c9fe64@columbia.edu> <CAGsJ_4xMK=rPXCH5OiCOYHKRQp-w+xDJQusJ_ykbuAuLZr+8bA@mail.gmail.com>
 <1e5118a5-6b61-49d0-85e1-825e22059241@columbia.edu> <CAGsJ_4wj6XvPB+QF+_X1BJ_8Y2sZEEFAw6RaJJz-cHaDWLkxaQ@mail.gmail.com>
 <65a2c7df-0d2e-46de-9580-01e9c35a7e32@columbia.edu>
In-Reply-To: <65a2c7df-0d2e-46de-9580-01e9c35a7e32@columbia.edu>
From: Barry Song <baohua@kernel.org>
Date: Mon, 14 Sep 2026 09:09:32 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4zS+UehT4wuTuTVjK3s3mhzp+dku8M-Of9cF=CN82aRow@mail.gmail.com>
X-Gm-Features: AcwNN1UFRWFTcqC6hN8ctMIRvI1_rCC0AM5x7mAixBPPm5RLTzvAhNItNpawqdI
Message-ID: <CAGsJ_4zS+UehT4wuTuTVjK3s3mhzp+dku8M-Of9cF=CN82aRow@mail.gmail.com>
Subject: Re: [PATCH v4] mm: filemap: retain mapped dropbehind folios
To: Tal Zussman <tz2294@columbia.edu>
Cc: Wenjie Qi <qwjhust@gmail.com>, willy@infradead.org, jack@suse.cz, 
	akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, axboe@kernel.dk, 
	trond.myklebust@hammerspace.com, jaegeuk@kernel.org, chao@kernel.org, 
	qiwenjie@xiaomi.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 7:34=E2=80=AFAM Tal Zussman <tz2294@columbia.edu> w=
rote:
>
> On 9/13/26 6:51 PM, Barry Song wrote:
> > On Fri, Sep 4, 2026 at 6:36=E2=80=AFAM Tal Zussman <tz2294@columbia.edu=
> wrote:
> >>
> >> On 9/4/26 12:28 AM, Barry Song wrote:
> >> > On Sun, Aug 30, 2026 at 7:59=E2=80=AFPM Tal Zussman <tz2294@columbia=
.edu> wrote:
> >> >>
> >> >> On 8/30/26 6:25 AM, Wenjie Qi wrote:
> >> >> > From: Wenjie Qi <qiwenjie@xiaomi.com>
> >> >> >
> >> >> > Fault-around can map ready dropbehind folios without going throug=
h the
> >> >> > normal page-cache lookup that clears dropbehind. A mapping repres=
ents a
> >> >> > competing cached user, but writeback completion can currently unm=
ap that
> >> >> > folio. A later mmap access must then fault it back in.
> >> >> >
> >> >> > Retain mapped folios instead. For a mapped folio,
> >> >> > folio_unmap_invalidate() can call unmap_mapping_folio(), which ta=
kes
> >> >> > i_mmap_rwsem and may sleep. Retaining the folio also avoids this =
path when
> >> >> > folio_end_dropbehind() runs in non-preemptible task context.
> >> >> >
> >> >> > Unmapped dropbehind folios continue through the existing invalida=
tion path.
> >> >> >
> >> >> > Fixes: fb7d3bc41493 ("mm/filemap: drop streaming/uncached pages w=
hen writeback completes")
> >> >> > Cc: stable@vger.kernel.org
> >> >> > Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
> >> >> > Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> >> >> > Reviewed-by: Tal Zussman <tz2294@columbia.edu>
> >> >> > ---
> >> >> > The mapped-plus-dropbehind state was reproduced in QEMU. The patc=
hed
> >> >> > kernel retained the mapped folio and continued to evict the unmap=
ped
> >> >> > dontcache folio. I did not reproduce the sleeping-in-atomic warni=
ng and
> >> >> > am not aware of an existing report.
> >> >> >
> >> >>
> >> >> I was able to trigger the sleeping-while-atomic BUG on current main=
line with
> >> >> some help from Claude. The reproducer itself is straightforward eno=
ugh, but the
> >> >> configuration was a little finicky. The atomic context comes from u=
sing
> >> >> threadirqs so that virtblk_done() completes requests from the irq t=
hread under
> >> >> local_bh_disable() and the vq spinlock with irqs off, so in_task() =
is true but
> >> >> the i_mmap_rwsem down_read() sleeps. It also needed 1 vCPU (so comp=
letion stays
> >> >> in the irq thread rather than softirq) and ext4 -o dioread_lock (so=
 end_io runs
> >> >> inline instead of on a workqueue). With v4 applied the bug is gone,=
 so:
> >> >>
> >> >
> >> > Thanks, Tal. Then I'm getting quite confused. Since with Wenjie's
> >> > patch, we are no longer going to sleep for dropbehind in `filemap.c`=
,
> >> > do we still need all the complex logic in the block device and file
> >> > system layers to move dropbehind to a workqueue task context?
> >> >
> >>
> >> Hi Barry,
> >>
> >> Let me clarify. Wenjie's patch prevents sleeping in a very specific ca=
se.
> >> The existing in_task() check covered most other cases, in that it just
> >> doesn't do dropbehind invalidation if we're not executing in task cont=
ext
> >> (for example, block device writeback completing in interrupt context).
> >>
> >> However, dropping the invalidation defeats the point of dropbehind, as=
 it
> >> leaves the pages in the page cache. If we get rid of the task-context
> >> deferral mechanism, we wouldn't sleep, but we also wouldn't invalidate=
.
> >> Wenjie's change is largely unrelated to this.
> >
> > Hi Tal,
> >
> > Thanks for the clarification. However, I=E2=80=99m still not convinced.
> >
> > If `unmap_mapping_folio()` is the only place where we might
> > sleep =E2=80=94 where we might take `mapping->i_mmap_rwsem` through
> > `i_mmap_lock_read()`, as Wenjian pointed out in [1] =E2=80=94 we have n=
ow
> > prevented that from happening with `if (!folio_mapped(folio))`.
> >
> > So no mapped folio should call `folio_unmap_invalidate()`:
> >
> > static void filemap_end_dropbehind(struct folio *folio)
> > {
> >          struct address_space *mapping =3D folio->mapping;
> >
> >          VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
> >
> >          if (folio_test_writeback(folio) || folio_test_dirty(folio))
> >                  return;
> >          if (!folio_test_clear_dropbehind(folio))
> >                  return;
> >          if (mapping && !folio_mapped(folio))
> >                  folio_unmap_invalidate(mapping, folio, 0);
> > }
> >
> > Why do we still need the `in_task()` check in
> > `folio_end_dropbehind()`?
> >
> > void folio_end_dropbehind(struct folio *folio)
> > {
> >          if (!folio_test_dropbehind(folio))
> >                  return;
> >
> >          /*
> >           * Hitting !in_task() should not happen off RWF_DONTCACHE writ=
eback,
> >           * but can happen if normal writeback just happens to find dir=
ty folios
> >           * that were created as part of uncached writeback, and that w=
riteback
> >           * would otherwise not need non-IRQ handling. Just skip the
> >           * invalidation in that case.
> >           */
> >          if (in_task() && folio_trylock(folio)) {
> >                  filemap_end_dropbehind(folio);
> >                  folio_unlock(folio);
> >          }
> > }
> >
> > Could any other operation in `folio_unmap_invalidate()` sleep for
> > unmapped folios? Otherwise, it seems we don't need `in_task()` at
> > all?
> >
>
> So I think you're right about the sleeping aspect, but the problem is
> that this still gets called from interrupt context. folio_unmap_invalidat=
e()
> grabs a number of locks in a non-IRQ safe way. Just at a glance, the
> spin_lock(&mapping->host->i_lock) call could lead to a deadlock, since ot=
her
> paths don't call it with interrupts disabled. And xa_unlock_irq() enables
> interrupts unconditionally, which would be incorrect from hardirq I belie=
ve.

That makes sense to me. If that's the case, it seems the
comment above

`if (in_task() && folio_trylock(folio))`

is no longer relevant at all.

BTW, if we use `spin_lock_irqsave(&mapping->host->i_lock)` in
other places and also restore IRQs when unlocking the xarray, then
we shouldn't need the `in_task()` check anymore, should we?

Best Regards
Barry
