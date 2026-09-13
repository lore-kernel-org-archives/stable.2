Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95684389460
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 22:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789339884; cv=none; b=ZR7jGBlfgLvtfQozbgQna+xOod57KkTdJqAq1D/xcR7thGoE5kcBBFhhC823lATT0Iay5yRG0dlft7L70yPVFtQQzRQdFShRZcOD1gcvQcF2HGm2R4/9VDt17TtpJ8Tp16qWuvV9WUps/d9FJNvI8sCM6fLyUipr8ukZIMtd8jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789339884; c=relaxed/simple;
	bh=taYSUVIEuqqqITUnhw8NBY99cYnhlnAHuJIa+r1ooo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EjUkHlMqYbMZzNJ4g1hxFaQXgelCKAXgsZHq9Fb1ZwM0pEj2HzxBnrlG9vi6+bFIPWSALdIIHKGoOH5vAeVs5fEXu3pqlq2O4tMkxrwhK1ZQzoqPuXu1zceX6ONcNYGhz54191xLNMJ+J0J9jbf7zOhvmRywHoHKmuRYNXYQA3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxVR5iOn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SxVR5iOn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497261F0089D
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 22:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789339883;
	bh=9ZiTG8sjKFTT4w8nPMlVhXaGC0u1YhzWKKam1CGyYWQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=SxVR5iOntlyY/xdBsyV1rMUdC68ospWyz0cg6COeUj8kKgoG8FLcWR4Dg2675UMdW
	 5B992E5VfQ9MMidiiJUqslikjwvNIh4pPWjq2EbzX2N23Mc2icAHyf9N6OBP7XQDIj
	 s7RQzQvBMSk/uHpwhGQ0WK/hIc3j9pdD8FJY95+f+HYws2J0KquXACTXGfp4SNZKPz
	 ItDmfm/Duu/YlpJYaC2n5pqkKzjqfNAlm+VXLXaQTO9pkCJOuDGnKGo9WfUxGWAQ8+
	 4BxBPregV5W/rRMGc/xZVmcWwhX+VgvH0HF3b/p9vWo6pG/i5wpo1A6b1nbAaxrZzR
	 gzGWNUWMfnWuw==
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb766bfd8so19008301cf.3
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 15:51:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy2HLreHUW8FNfwVe8Rd7+Nqn/GmP6R6Nzi03edyexjF6+br0TL5rHMqN35c01KICV5SRO/hEM=@vger.kernel.org
X-Gm-Message-State: AFuF++lt6u8Ay92asSS68cs/NLNQU4cZluSzZUcXtLsuaa2DEhuwTm4Y
	EMD3Bka3/FZ6PkljGFyg3atiNymVLN+AW4SxDp2krAhY7ccY90yJDp+sCzMoK2uSDhdpCQTeW0O
	H55XBNVC+xOXOYRqUjeCKk1vqgVflvL0=
X-Received: by 2002:a05:620a:2702:b0:92e:71bb:d1c0 with SMTP id
 af79cd13be357-93a297ee80cmr26633285a.15.1789339882564; Sun, 13 Sep 2026
 15:51:22 -0700 (PDT)
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
 <1e5118a5-6b61-49d0-85e1-825e22059241@columbia.edu>
In-Reply-To: <1e5118a5-6b61-49d0-85e1-825e22059241@columbia.edu>
From: Barry Song <baohua@kernel.org>
Date: Mon, 14 Sep 2026 06:51:10 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4wj6XvPB+QF+_X1BJ_8Y2sZEEFAw6RaJJz-cHaDWLkxaQ@mail.gmail.com>
X-Gm-Features: AcwNN1WjkmO8uX5Iavm2W9nWdvLG2cwH8oYEJn3mYskY-hmIRTHjLPMkj4xTYTQ
Message-ID: <CAGsJ_4wj6XvPB+QF+_X1BJ_8Y2sZEEFAw6RaJJz-cHaDWLkxaQ@mail.gmail.com>
Subject: Re: [PATCH v4] mm: filemap: retain mapped dropbehind folios
To: Tal Zussman <tz2294@columbia.edu>
Cc: Wenjie Qi <qwjhust@gmail.com>, willy@infradead.org, jack@suse.cz, 
	akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, axboe@kernel.dk, 
	trond.myklebust@hammerspace.com, jaegeuk@kernel.org, chao@kernel.org, 
	qiwenjie@xiaomi.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 6:36=E2=80=AFAM Tal Zussman <tz2294@columbia.edu> wr=
ote:
>
> On 9/4/26 12:28 AM, Barry Song wrote:
> > On Sun, Aug 30, 2026 at 7:59=E2=80=AFPM Tal Zussman <tz2294@columbia.ed=
u> wrote:
> >>
> >> On 8/30/26 6:25 AM, Wenjie Qi wrote:
> >> > From: Wenjie Qi <qiwenjie@xiaomi.com>
> >> >
> >> > Fault-around can map ready dropbehind folios without going through t=
he
> >> > normal page-cache lookup that clears dropbehind. A mapping represent=
s a
> >> > competing cached user, but writeback completion can currently unmap =
that
> >> > folio. A later mmap access must then fault it back in.
> >> >
> >> > Retain mapped folios instead. For a mapped folio,
> >> > folio_unmap_invalidate() can call unmap_mapping_folio(), which takes
> >> > i_mmap_rwsem and may sleep. Retaining the folio also avoids this pat=
h when
> >> > folio_end_dropbehind() runs in non-preemptible task context.
> >> >
> >> > Unmapped dropbehind folios continue through the existing invalidatio=
n path.
> >> >
> >> > Fixes: fb7d3bc41493 ("mm/filemap: drop streaming/uncached pages when=
 writeback completes")
> >> > Cc: stable@vger.kernel.org
> >> > Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
> >> > Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> >> > Reviewed-by: Tal Zussman <tz2294@columbia.edu>
> >> > ---
> >> > The mapped-plus-dropbehind state was reproduced in QEMU. The patched
> >> > kernel retained the mapped folio and continued to evict the unmapped
> >> > dontcache folio. I did not reproduce the sleeping-in-atomic warning =
and
> >> > am not aware of an existing report.
> >> >
> >>
> >> I was able to trigger the sleeping-while-atomic BUG on current mainlin=
e with
> >> some help from Claude. The reproducer itself is straightforward enough=
, but the
> >> configuration was a little finicky. The atomic context comes from usin=
g
> >> threadirqs so that virtblk_done() completes requests from the irq thre=
ad under
> >> local_bh_disable() and the vq spinlock with irqs off, so in_task() is =
true but
> >> the i_mmap_rwsem down_read() sleeps. It also needed 1 vCPU (so complet=
ion stays
> >> in the irq thread rather than softirq) and ext4 -o dioread_lock (so en=
d_io runs
> >> inline instead of on a workqueue). With v4 applied the bug is gone, so=
:
> >>
> >
> > Thanks, Tal. Then I'm getting quite confused. Since with Wenjie's
> > patch, we are no longer going to sleep for dropbehind in `filemap.c`,
> > do we still need all the complex logic in the block device and file
> > system layers to move dropbehind to a workqueue task context?
> >
>
> Hi Barry,
>
> Let me clarify. Wenjie's patch prevents sleeping in a very specific case.
> The existing in_task() check covered most other cases, in that it just
> doesn't do dropbehind invalidation if we're not executing in task context
> (for example, block device writeback completing in interrupt context).
>
> However, dropping the invalidation defeats the point of dropbehind, as it
> leaves the pages in the page cache. If we get rid of the task-context
> deferral mechanism, we wouldn't sleep, but we also wouldn't invalidate.
> Wenjie's change is largely unrelated to this.

Hi Tal,

Thanks for the clarification. However, I=E2=80=99m still not convinced.

If `unmap_mapping_folio()` is the only place where we might
sleep =E2=80=94 where we might take `mapping->i_mmap_rwsem` through
`i_mmap_lock_read()`, as Wenjian pointed out in [1] =E2=80=94 we have now
prevented that from happening with `if (!folio_mapped(folio))`.

So no mapped folio should call `folio_unmap_invalidate()`:

static void filemap_end_dropbehind(struct folio *folio)
{
        struct address_space *mapping =3D folio->mapping;

        VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);

        if (folio_test_writeback(folio) || folio_test_dirty(folio))
                return;
        if (!folio_test_clear_dropbehind(folio))
                return;
        if (mapping && !folio_mapped(folio))
                folio_unmap_invalidate(mapping, folio, 0);
}

Why do we still need the `in_task()` check in
`folio_end_dropbehind()`?

void folio_end_dropbehind(struct folio *folio)
{
        if (!folio_test_dropbehind(folio))
                return;

        /*
         * Hitting !in_task() should not happen off RWF_DONTCACHE writeback=
,
         * but can happen if normal writeback just happens to find dirty fo=
lios
         * that were created as part of uncached writeback, and that writeb=
ack
         * would otherwise not need non-IRQ handling. Just skip the
         * invalidation in that case.
         */
        if (in_task() && folio_trylock(folio)) {
                filemap_end_dropbehind(folio);
                folio_unlock(folio);
        }
}

Could any other operation in `folio_unmap_invalidate()` sleep for
unmapped folios? Otherwise, it seems we don't need `in_task()` at
all?

[1] https://sashiko.dev/#/message/CAGFpFsRarmDScAQxHpCtSZxK5H4WCg4Y%3Dy0hXQ=
LjGT804ZoWkw%40mail.gmail.com

Best Regards
Barry
