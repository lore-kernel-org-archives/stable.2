Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793031383;
	b=pidA6s315Mw3Zny0Ci96nYspuq8frSNLD43B+Kjoi4CrkBnEGbOkciW3ViyWDYcA6TAV
	 9sOK+BNfx7PALGAovV1INiu6JsPQOIkdk4VrGmdnujaGIgZhHgOVonJPOOfy2e2oWLeqy
	 hcjcb5sxVh8P8LkOk34mo4TiDtWACbC3/3jOSHGzDdiLzZ52nqhkFyRGJtikNJeuuSwa2
	 eYQ7akXaLnVV2M/BwFtW1Y9aVc1mRS90SUnFSATHfw86PweERDE9NI+b/IvQznPouAguV
	 sAzyMyyZJaMFlzXnh45QoqUvqhFltS6XSgX2DwOCnJk847jcBI+Jfcx+4hNO8q0XcvQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793031383;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=S9cWTqlHZ0AXy66/w1FV4ZcQB4fXYGLMwkkMMKyxuEI=;
	b=vYxB3CDElIj5Vu2WEJTqSGFLz5Ibqpedp/9QsiGJgp06T83S0HGjW3B9IvVfG+NE1kNa
	 LQ29qLFYnmXTCblnfbyxWzkmP1E+XITmKPCeBijTDiQZUaD7rHMfJe0YGvq4uAjDtFAUB
	 zB3qEQb9KqlOlywyxTOMjs8Ol1Pzy4bdWPqnKFtD5eQjeulYEWjDVXN2p69yFTMDkgxjs
	 EZ2B/3lIAnYfrzEPAtfU+T0Gmhkrrjgd+6pJjxM60ZZynwWxI6Auqc+T4C7GDCEwy03ww
	 ydVzbnQew+pka8Zex4AFyyrNwHvKh6HzhN8kloglcLz2I+I7I+kad1D2cBGxBaSfZcg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=qtg+cJgh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A75606A31D
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 16:16:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5A75606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=qtg+cJgh
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5337c7b9937so498841cf.0
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 09:16:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793031381; cv=none;
        d=google.com; s=arc-20260327;
        b=KtMdBAuQ6bvs/F6CIVbE6T+KqWZc1XihjiaONVOpancNI6MU/CkayttUb9KJI4jdeX
         Z0C0Dq5Sa7/MLZOv3Tj1q/hKtYAaQt5U+xZlhzyIbb+iK5EOqXKLeyqNZLkgmpWAG5oq
         25K3InZf9bg5G3T+8yBbCZNd6/aSVrh5FdOISiQG9ED1q+Bf45XrhFxR4aF4aff8qlv8
         3yob0rgEpo6YpJz0rYYiishFhnDgDwohnxkr1m8RmN0xBacVY5JgJdiUvciD2Y+uw/LJ
         NyMF77M6Ssaehll/HrB4m3mgGpGuZu3AKeE6IvM1K9u1ety3HSw8gdvWIL9k6zBgxyUc
         E5fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S9cWTqlHZ0AXy66/w1FV4ZcQB4fXYGLMwkkMMKyxuEI=;
        fh=sHNKHmGPMstA2GfdmAE5ICiEaTKYufSHsYvQEqtmEsk=;
        b=aYU543kTH2rV2eAsf6LVUeXSsatNBubtoY2Y6nDAMhfe32lFbvckUD8EP0tKrFeNTI
         r6xALxtIPg80C3pFlYnqu9TQ5HdX0eLnZ7xXg7WDKJHTT0iSo3AXMvVAcvzoaDHf93QN
         k7S3sORhXEEBO8dWiR2eTOsozNkTvO+madHatrMuCU8GvTg7CuWrRYLNebzj5Xgu+bCg
         +187eH5sRaFH5q/2hN6Vg/ySKoE9Qpth1fll0I2ajxwvCE6ZyNvXLTw3CXzcb6e4vygK
         fsIv0bhRpF0/ACF6eWs5lOBl+h3H/uWnifBquItUdh0luYzBGNWLjB+LiBUKJM0OOjVo
         SmBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793031381; x=1793636181; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S9cWTqlHZ0AXy66/w1FV4ZcQB4fXYGLMwkkMMKyxuEI=;
        b=qtg+cJghAfcI0dPy/ax/2E3mjZwZCJLJrbaFHtZTpl6O3sCDXh1WMwU4xYxio5+DGz
         GfQvou4FjOFGLD//Y6FPw6iz+dxOhfHYP6vDJrIbBbVIOKoUc+6r4wh1vzSvzrJEfBBK
         b1DWD9oYpTEU1GGH5+m3oNpWktMEEZr7h70e55qc2gxbovm0EICTOKyb/iezStAfvNyv
         AXn53Cpbc1UUoG6UgZlztpTFAls+yF/udfx+wEiGyFzm04EFEAJvfsOqTcAT8faat3pu
         HESRqajqAGmHK9IiNn2eaxx6gVt7SoWXaxl4Mm0pgNhU/DOGIE2ddYVeKSeHfPYHghpL
         fRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793031381; x=1793636181;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S9cWTqlHZ0AXy66/w1FV4ZcQB4fXYGLMwkkMMKyxuEI=;
        b=Xn/BIG++ofTPy5srB9zRPowtdrdcnsOb8N/5tVZk/PaEJLdprkqdWTiVlqQW2TtcF8
         CM90gJ9OetYCRpmsxDt1Bw7zfId2OJV9YHYDjZbcysq1zc52K9AChnZSFYStMK6UhG+z
         HyHExX6MsBoR9fDLNPxdFmtqHaW+abw0sgy+Xfnr0mEgxa7BpbY/aRsqSoW03SqDN/AL
         DI2lBLH1jXoM5IkNPw+Ncs1fekrAoqLT3axjIwpv2i7AcrWXf98v0PTF5lT70fsnMS+g
         mXqdzdMGGENS+XX9GUZ8VfWi2zW7sGwV52MhNZ9CwyaPcb9EiZTZLnMqE6z6CnB5RrlQ
         u3UQ==
X-Forwarded-Encrypted: i=1; AKwUvBw0Lj03Ka1lML7T9ZtTYV1NXr9gAOUrl4qFRqHKTzJgSaW+dpZTLz5pTw3u78rVW+WdBoUEfBY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKeLi5FQwDjn/dlTH4Ia/M7vi69TOMACaWM3XbCexD/OxLVSSMG
	6wRqYW6LLpKIEgixOKsDt29LwgOExx9S3HWcRtdK2tIb4/sNBCCgBe/Q/bEJYQjAz+oIqyst8vu
	yw4s0n0D87RYwLyNNn2HZRWvJWgydA70mQICD/gDQ
X-Gm-Gg: AYBFou0MaDfINe+373mLY7ZBnPTJLaFR7isfl0OQ+nhVpqjH8ATr1hnADKuqZIeISM+
	IoUaQNEHFbqCxxYP4bSrzABtzcLkWsV7sumFs5U5aO2BOZRjB926qLcWsFcoY45JS2czx8FwRAY
	x02SZoMS3ZRcdN7x43YS88dpF6WOLNuyDOotsqqCtTtEfFE8/tI2AOS7RbOItjsSiXKEpyT+PjQ
	1NxtRrIdEnVCsFClhBRx4DMw088/JdKuOT8Z+cq4Rhgni/JuYRypG51QyVXeDpGa3YpY15Zigja
	UKisJrWuoqB7TK5pAPlWJ7N7fPfPILcIbgAVtNn/XsuzT5VGTGz7VEn4UkwALnqZtVhebGIOu1N
	CLFGYkvoUcSVUt9sS5bw2q9t8Vt9DqV0/BAw=
X-Received: by 2002:a05:622a:c84:b0:535:84ef:2e26 with SMTP id
 d75a77b69052e-53e23e1bfc3mr3103651cf.7.1793031380612; Mon, 26 Oct 2026
 09:16:20 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261025-per_vma_maps-v1-1-c4eec45b9387@kernel.org> <at8-42OwXk2z6-HB@gremlin>
In-Reply-To: <at8-42OwXk2z6-HB@gremlin>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 26 Oct 2026 09:16:08 -0700
X-Gm-Features: AclHuK-CXE-6CGVLQD9ykuQkf9j4lmUBURpnlf3ELNWcvGLrSOzQd5BnzAWf8SU
Message-ID: <CAJuCfpFaxo06yHdVKsEEmFf9qoOYS0DbMvUuAZEhNfDe7dcwJA@mail.gmail.com>
Subject: Re: [PATCH] fs/proc/task_mmu: fix missed VMAs when reading
 /proc/PID/maps and friends
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Shakeel Butt <shakeel.butt@linux.dev>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 6:35=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
>
> Another note about this - we need to update the tests to actually add
> something that can catch this. The selftests only check the last line of
> one page and first of next, and latter always implies vma_iter_init() in
> m_start() so it never tests the iterator actually being cached.
>
> Obviously something for a follow-up.

Yeah, I'll look into it. David, you mentioned you were able to
reproduce the issue. Could you please share the reproducer? That would
help me cover this case in our selftests.

>
> On Sun, Oct 25, 2026 at 11:43:15AM +0100, David Hildenbrand (Arm) wrote:
> > Reading /proc/PID/maps under per-VMA locks can skip continuously mapped
> > address ranges during concurrent VMA splits or merges. This violates th=
e
> > guarantee in Documentation/filesystems/proc.rst:
> >
> >   "If there is something at a given vaddr during the entirety of the
> >    life of the smaps/maps walk, there will be some output for it."
>
> Right.
>
> >
> > lock_next_vma() reuses a tree iterator across calls under RCU. The iter=
ator
> > remembers the range of its last entry. When its node is replaced,
> > mas_next_slot() walks the tree again at the last index of that range, t=
hen
> > advances past the entry containing that index. If VMA boundaries change=
d,
> > this can skip a range that has not been reported:
> >
> >  - A lookup finds [A, C), then mprotect() splits it into [A, B) and [B,=
 C)
> >    before vma_start_read() locks the first VMA. The reader reports [A, =
B),
> >    but the iterator still covers [A, C). The next call starts from B ye=
t
> >    advances past C, omitting [B, C).
> >
> >  - The reader reports [A, B) and unlocks it. A concurrent mprotect() th=
en
> >    merges it with [B, C). On the next call, the iterator resumes at B -=
 1,
> >    which now belongs to [A, C), and advances past C. Again, [B, C) is l=
ost.
>
> OK so the key thing here is that the _iterator_ is the issue.
>
> Essentially what 'next' means changes depending on the state of the
> tree. All very subtle.

Right. Subtle details of how iterators work...

>
> I wonder whether we shouldn't have a vma_iter_next_after() or something
> where you can specify the position you are at in terms of an address rath=
er
> than a node.
>
> But that's one for a follow-up.

That would be nice. I'll discuss this with Liam. That would make this
fix very trivial.

>
> >
> > Checking the mmap_lock sequence only within the next call misses writer=
s
> > that completed before that call began. Also, a NULL result is currently
> > accepted without validation, so a race can terminate the walk early.
>
> Ugh.
>
> >
> > Even a fresh lookup can skip a mapping. Suppose it finds a gap before
> > [B, C). A writer inserts an adjacent VMA at the end of that gap, then
> > merges it into [B, C), replacing the node. The lookup resumes at the ol=
d
> > gap's last index, now inside the merged VMA, and steps past it. The
> > original [B, C) remains mapped throughout. Repeating the forward lookup
> > is insufficient: another merge can make it skip the same mapping again,
> > returning the same later VMA or NULL.
> >
> > The fresh-lookup race also affects /proc/PID/smaps, numa_maps and
> > smaps_rollup. Resetting the iterator after gathering each VMA's statist=
ics
> > does not prevent a merge during the next lookup. Fixing lock_next_vma()
> > also prevents omitted entries and incomplete rollup statistics.
> >
> > Keep a saved sequence in the proc maps locking context and validate it
> > before each lookup with mmap_lock_speculate_retry(). If it is even (no
> > pending writer) and still matches, reuse both the iterator and the save=
d
> > sequence. Otherwise, restart at from_addr and sample the current sequen=
ce
> > before looking up the VMA. Only refresh the sample when resetting the
> > iterator, so a writer between validation and the lookup cannot go
> > undetected.
>
> I think this bit is unnecessary, see below.
>
> >
> > The smp_rmb() in mmap_lock_speculate_retry() orders the previous lookup
> > before rereading the sequence. It pairs with smp_wmb() in
> > do_raw_write_seqcount_begin(), which separates the sequence increment i=
n
> > mmap_write_lock() from subsequent tree updates.
>
> I'm glad this is at least abstracted :)
>
> >
> > Validate detected gaps (from_addr < vma->vm_start) and NULL from
> > vma_next() against the sequence. If there were concurrent writes, use
> > mas_walk() to check if the writer could have interfered with the range
> > of interest. If the range is not empty, something interfered concurrent=
ly
> > so we retry under mmap_lock. Checking for empty ranges avoids taking th=
e
> > mmap_lock just because an unrelated writer changed the sequence.
> >
> > Original fix generated by an LLM and sent by Josef Bacik in private.
> >
> > Fixes: 5631da56c9a8 ("fs/proc/task_mmu: read proc/pid/maps under per-vm=
a lock")
> > Fixes: ea3085dd7a4e ("fs/proc/task_mmu: read proc/pid/{smaps|numa_maps}=
 under per-vma lock")
> > Fixes: 0e985559d72a ("proc/task_mmu: read proc/pid/smaps_rollup under p=
er-vma lock")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> > ---
> > I neither understood nor liked the original LLM generated fix that was
> > provided to me, and I (and codex) think it was incomplete. So I tried t=
o
> > come up with a better fix that avoids additional fallbacks to the mmap_=
lock
> > while trying to keep it simple.
> >
> > I won't claim that I am now an expert on the code, or that this is the
> > most elegant fix. It is quite complicated what we built ... too
> > complicated. So if this goes into the wrong direction I'll be happy
>
> Yep, I do think the VMA locking implementation is too complicated in gene=
ral. I
> did work to simplify the structure of the implementation at least so it w=
as more
> intelligible.
>
> Hopefully with this and other fixes we get somewhere better.
>
> I think we could do work to simplify the VMA iterators also.
>
> > if someone else wants to take over ;)

I'll gladly do that.

>
> I think we can make this a bit smaller. Patch attached.
>
> But that incurs a perf penalty, so if not that, I also suggest some small
> wrappers that de-duplicate and make things much clearer.
>
> >
> > I reproduced the races with /proc/PID/maps, and with this patch they ar=
e
> > resolved. I did not manage to reproduce the races with the new
> > smaps/smaps_rollup, but the races are slightly different and harder to
> > trigger.
> >
> > There is the issue with seqcount overflows that Lorenzo is tackling. It
> > probably interacts here as well? Likely, but that's an independent issu=
e
> > to resolve.
>
> That impacts VMA seqcount, and this logic only touches mm seqcount so all
> good (claude agrees...)
>
> > ---
> >  fs/proc/internal.h        |  1 +
> >  fs/proc/task_mmu.c        |  6 +++--
> >  include/linux/mmap_lock.h |  5 ++--
> >  mm/mmap_lock.c            | 58 +++++++++++++++++++++++++++++++++++----=
--------
> >  4 files changed, 51 insertions(+), 19 deletions(-)
> >
> > diff --git a/fs/proc/internal.h b/fs/proc/internal.h
> > index df873df9afc56..f3e846b574d79 100644
> > --- a/fs/proc/internal.h
> > +++ b/fs/proc/internal.h
> > @@ -386,6 +386,7 @@ struct mem_size_stats;
> >  struct proc_maps_locking_ctx {
> >       struct mm_struct *mm;
> >       bool mmap_locked;
> > +     unsigned int mm_wr_seq;
> >       struct vm_area_struct *locked_vma;
> >  };
> >
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index ee9fc2fd2b2fe..dc3adcffb6d9c 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -148,6 +148,7 @@ static void reset_lock_ctx(struct proc_maps_locking=
_ctx *lock_ctx)
> >  {
> >       lock_ctx->locked_vma =3D NULL;
> >       lock_ctx->mmap_locked =3D false;
> > +     lock_ctx->mm_wr_seq =3D UINT_MAX;
>
> Kinda horrible to just have to know this needs to be odd etc.

Well, this interface was never meant to be used directly like this. If
we indeed go with this we should introduce an abstraction.

>
> >  }
> >
> >  static struct vm_area_struct *get_next_vma(struct proc_maps_private *p=
riv,
> > @@ -160,7 +161,8 @@ static struct vm_area_struct *get_next_vma(struct p=
roc_maps_private *priv,
> >               return vma_next(&priv->iter);
> >
> >       unlock_ctx_vma(lock_ctx);
> > -     vma =3D lock_next_vma(lock_ctx->mm, &priv->iter, last_pos);
> > +     vma =3D lock_next_vma(lock_ctx->mm, &priv->iter, last_pos,
> > +                         &lock_ctx->mm_wr_seq);
> >       if (!IS_ERR_OR_NULL(vma))
> >               lock_ctx->locked_vma =3D vma;
> >
> > @@ -523,7 +525,7 @@ static struct vm_area_struct *query_vma_find_by_add=
r(struct proc_maps_locking_ct
> >       unlock_ctx_vma(lock_ctx);
> >       rcu_read_lock();
> >       vma_iter_init(&vmi, mm, addr);
> > -     vma =3D lock_next_vma(mm, &vmi, addr);
> > +     vma =3D lock_next_vma(mm, &vmi, addr, &lock_ctx->mm_wr_seq);
>
> I think this is challenging to reason about.
>
> But with the suggestion simplification we can avoid it.
>
> Otherwise, it should probably be tied to the iterator to which it belongs=
, like:
>
>         struct vma_rcu_iter {
>                 struct vma_iterator vmi;
>                 unsigned int mm_wr_seq;
>         };

Agree.

>
> And pass that around instead, e.g. change the signature to:
>
> struct vm_area_struct *lock_next_vma(struct mm_struct *mm,
>                 struct vma_rcu_iter *rvmi, unsigned long from_addr)
>
> And have something like:
>
>         static void vma_rcu_iter_init(struct vma_rcu_iter *rvmi,
>                         struct mm_struct *mm, unsigned long from_addr)
>         {
>                 vma_iter_init(&rvmi->vmi, mm, from_addr);
>                 /* Set write-locked so initially treated as maybe changed=
. */
>                 rvmi->mm_wr_seq =3D UINT_MAX;
>         }

Right.

>
> >       rcu_read_unlock();
> >
> >       if (!vma)
> > diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> > index 28e3696ce9ff3..e33d15ce6a876 100644
> > --- a/include/linux/mmap_lock.h
> > +++ b/include/linux/mmap_lock.h
> > @@ -511,12 +511,13 @@ struct vm_area_struct *lock_vma_under_rcu(struct =
mm_struct *mm,
> >   * Locks next vma pointed by the iterator. Confirms the locked vma has=
 not
> >   * been modified and will retry under mmap_lock protection if modifica=
tion
> >   * was detected. Should be called from read RCU section.
> > + * *last_seq must initially be odd and is kept across calls.
>
> It's quite odd to have callers need to know about this, feels like a leak=
ed
> abstraction.

Yes it is. We should not expose these details directly.

>
> >   * Returns either a valid locked VMA, NULL if no more VMAs or -EINTR i=
f the
> >   * process was interrupted.
> >   */
> >  struct vm_area_struct *lock_next_vma(struct mm_struct *mm,
> > -                                  struct vma_iterator *iter,
> > -                                  unsigned long address);
> > +             struct vma_iterator *vmi, unsigned long from_addr,
> > +             unsigned int *last_seq);
> >
> >  static inline void vma_assert_can_modify(struct vm_area_struct *vma)
> >  {
> > diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> > index 2f94ee0fdee2a..0f3a4e0c5520d 100644
> > --- a/mm/mmap_lock.c
> > +++ b/mm/mmap_lock.c
> > @@ -400,21 +400,50 @@ static struct vm_area_struct *lock_next_vma_under=
_mmap_lock(struct mm_struct *mm
> >       return vma;
> >  }
> >
> > +static bool vma_range_is_empty(struct mm_struct *mm, unsigned long sta=
rt,
> > +             unsigned long last)
>
> Be good to add an RCU assert (lockdep only). Yes, lock_next_vma() holds
> the RCU lock over this but it also releases it at certain points and it
> makes things clearer and zero cost.
>
> > +{
> > +     MA_STATE(mas, &mm->mm_mt, start, start);
> > +
> > +     return !mas_walk(&mas) && mas.last >=3D last;
> > +}
> > +
> >  struct vm_area_struct *lock_next_vma(struct mm_struct *mm,
> > -                                  struct vma_iterator *vmi,
> > -                                  unsigned long from_addr)
> > +             struct vma_iterator *vmi, unsigned long from_addr,
> > +             unsigned int *last_seq)
> >  {
> >       struct vm_area_struct *vma;
> > -     unsigned int mm_wr_seq;
> >       bool mmap_unlocked;
> >
> >       RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "no rcu read lock held");
> >  retry:
> > -     /* Start mmap_lock speculation in case we need to verify the vma =
later */
> > -     mmap_unlocked =3D mmap_lock_speculate_try_begin(mm, &mm_wr_seq);
> > +     /*
> > +      * Restart by address if a writer could have changed the cached r=
ange.
> > +      * The retry check's smp_rmb() orders the previous lookup before =
reading
> > +      * the sequence and pairs with smp_wmb() in do_raw_write_seqcount=
_begin().
> > +      *
> > +      * The vma_range_is_empty() checks below avoid unnecessary mmap_l=
ock
> > +      * fallbacks.
> > +      */
> > +     mmap_unlocked =3D !(*last_seq & 1);
>
> If we keep this logic, this really has to be abstracted out, e.g.:
>
> static bool mm_seq_is_write_locked(unsigned int mm_seq)
> {
>         /* By convention, odd means locked, even means unlocked. */
>         return mm_seq & 1;
> }
>
> > +     if (!mmap_unlocked || mmap_lock_speculate_retry(mm, *last_seq)) {
>
> This is pretty subtle, and the VMA lock code is confusing enough as it is=
.
>
> So abstracting the speculate/retry bit would be helpful I think.
>
> Maybe something like:
>
> static bool vma_tree_maybe_changed(struct mm_struct *mm, unsigned int las=
t_seq)
> {
>         /*
>          * Write lock held when sampled (VMA can change), or write lock a=
cquired
>          *  + dropped since.
>          */
>         return mm_seq_is_write_locked(last_seq) ||
>                 mmap_lock_speculate_retry(mm, last_seq);
> }

If we follow your suggestion and introduce vma_rcu_iter then this can
be abstracted as an operation over vma_rcu_iter:

static bool is_vma_rcu_iter_valid(struct mm_struct *mm, struct
vma_rcu_iter *rvmi)
 {
         /*
          * Write lock held when sampled (VMA can change), or write
lock acquired
          *  + dropped since.
          */
         return mm_seq_is_write_locked(rvmi->mm_wr_seq) ||
                 mmap_lock_speculate_retry(mm, rvmi->mm_wr_seq);
}

>
> /* Returns true if mmap write unlocked. */
> static bool reset_walk_if_mmap_lock_dropped(struct vma_iterator *vmi,
>                 struct mm_struct *mm, unsigned long from_addr,
>                 unsigned int *last_seq)
> {
>         if (vma_tree_maybe_changed(mm, *last_seq)) {
>                 /* Reset walk and re-speculate. */
>                 vma_iter_set(vmi, from_addr);
>                 return mmap_lock_speculate_try_begin(mm, last_seq);
>         }
>
>         return true;
> }
>
> (Can return true at the end because the write lock can't be held at the
> point of being sampled.)
>
> Then this becomes the self-documenting:
>
>         mmap_unlocked =3D reset_walk_if_mmap_lock_dropped(vmi, mm, from_a=
ddr, last_seq);
>
> > +             vma_iter_set(vmi, from_addr);
> > +             mmap_unlocked =3D mmap_lock_speculate_try_begin(mm, last_=
seq);
> > +     }
> > +
>
> This seems like a bit of an over-optimisation for a fix, we can always
> reintroduce it later.
>
> Simpler I think to just keep the mmap_lock_speculate_try_begin() and
> unconditionally perform the vma_iter_set().
>
> Also easier to reason about. Better to reason that the vma iterator might=
 be in
> a questionable state, so just reset it.
>
> Also eliminates adding last_seq + all the churn in the fix.
>
> Patch suggestion attached below.
>
>
> >       vma =3D vma_next(vmi);
> > -     if (!vma)
> > -             return NULL;
> > +     if (!vma) {
> > +             /*
> > +              * There is no reason to fallback if there really isn't a=
nything
> > +              * in the remaining range.
> > +              */
> > +             if ((mmap_unlocked && !mmap_lock_speculate_retry(mm, *las=
t_seq)) ||
> > +                 vma_range_is_empty(mm, from_addr, ULONG_MAX))
>
> Quite a lot packed into this single expression.
>
> If the write lock is not held (VMA can't change) and it wasn't acquired a=
nd
> dropped since last we checked, or, if when explicitly checking the range =
to
> see if anything is left, stop.
>
> It seems to amount to me to 'can we trust that vma_next() didn't just ski=
p
> us over stuff?'
>
> With the vma_tree_maybe_changed() helper could be:
>
>         if (!vma_tree_maybe_changed(mm, *last_seq) ||
>             vma_range_is_empty(mm, from_addr, ULONG_MAX))
>                 return NULL;
>
> Which self-documents this.
>
> Actually given the logic below you could have:
>
> static bool should_traverse_range(struct mm_struct *mm,
>                 unsigned int last_seq, unsigned long from, unsigned long =
to)
> {
>         return vma_tree_maybe_changed(mm, last_seq) &&
>                 !vma_range_is_empty(mm, from, to);
> }
>
> Then this would simply be:
>
>         if (!should_traverse_range(mm, *last_seq, from_addr, ULONG_MAX))
>                 return NULL;
>

Right. Refactoring definitely makes sense.

> > +                     return NULL;
> > +
> > +             rcu_read_unlock();
> > +             goto fallback;
> > +     }
> >       vma =3D vma_start_read(mm, vma);
> >       if (IS_ERR_OR_NULL(vma)) {
> > @@ -442,15 +471,14 @@ struct vm_area_struct *lock_next_vma(struct mm_st=
ruct *mm,
> >        * it was not shrunk after we found it and another vma has not be=
en
> >        * installed ahead of it. Otherwise we might observe a gap that s=
hould
> >        * not be there.
> > +      *
> > +      * If speculation fails, avoid taking the mmap_lock when a direct=
 lookup
> > +      * confirms that the gap is empty.
> >        */
> > -     if (from_addr < vma->vm_start) {
> > -             /* Verify only if the address space might have changed si=
nce vma lookup. */
> > -             if (!mmap_unlocked || mmap_lock_speculate_retry(mm, mm_wr=
_seq)) {
> > -                     vma_iter_set(vmi, from_addr);
> > -                     if (vma !=3D vma_next(vmi))
> > -                             goto fallback_unlock;
> > -             }
> > -     }
> > +     if (from_addr < vma->vm_start &&
> > +         (!mmap_unlocked || mmap_lock_speculate_retry(mm, *last_seq)) =
&&
> > +         !vma_range_is_empty(mm, from_addr, vma->vm_start - 1))
> > +             goto fallback_unlock;
>
> Again a lot of stuff on the same line, and a lot of duplication.
>
> With above could be:
>
>         if (from_addr < vma->vm_start &&
>             should_traverse_range(mm, *last_seq, from_addr, vma->vm_start=
 - 1))
>             goto fallback_unlock;
>
> Which also self-documents.
>
> So if the perf penalty for simplification is too much, this stuff can mak=
e
> this a lot more understandable and avoid code duplication.
>
> >
> >       return vma;
> >
> >
> > ---
> >
> > base-commit: 21a7f44fd0765fcc5194130b28767786eba1d1e7
> >
> > change-id: 20261025-per_vma_maps-ceab0eb860d5
> >
> > --
> >
> > Cheers,
> >
> > David
> >
>
> The simplification eats the cost of a new tree traversal each time from
> root (ugh).  It makes the fix a LOT simpler, but incurs (claude says)
> 13-17ns/VMA cost i.e. 10-25% of the per-line cost of reading
> /proc/$pid/maps.
>
> I think we care more about lock contention than raw /proc/$pid/maps
> traversal time, however, so I'm not sure this matters.
>
> In any case, an optimisation can be introduced with appropriate abstracti=
on
> as a follow-up, I think better to do the simpler-to-reason-about version =
as
> the fix.
>
> But if we are bothered about this, then it needs abstracting as suggested=
.
>
> ----8<----
> From 2c87f4865b415b90b6b833b51323f2267d1a4f1f Mon Sep 17 00:00:00 2001
> From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
> Date: Mon, 26 Oct 2026 12:11:21 +0000
> Subject: [PATCH] simplification
>
> ---
>  mm/mmap_lock.c | 47 +++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 37 insertions(+), 10 deletions(-)
>
> diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> index 83b7d3ded0dc..6568dda0aba4 100644
> --- a/mm/mmap_lock.c
> +++ b/mm/mmap_lock.c
> @@ -428,6 +428,16 @@ static struct vm_area_struct *lock_next_vma_under_mm=
ap_lock(struct mm_struct *mm
>         return vma;
>  }
>
> +static bool vma_range_is_empty(struct mm_struct *mm, unsigned long start=
,
> +               unsigned long last)
> +{
> +       MA_STATE(mas, &mm->mm_mt, start, start);
> +
> +       RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "no rcu lock held");
> +
> +       return !mas_walk(&mas) && mas.last >=3D last;
> +}
> +
>  struct vm_area_struct *lock_next_vma(struct mm_struct *mm,
>                                      struct vma_iterator *vmi,
>                                      unsigned long from_addr)
> @@ -438,11 +448,29 @@ struct vm_area_struct *lock_next_vma(struct mm_stru=
ct *mm,
>
>         RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "no rcu read lock held");
>  retry:
> +       /*
> +        * No lock was held since the last call, so the iterator's cached=
 range
> +        * may no longer be valid. Always restart by address.
> +        *
> +        * The vma_range_is_empty() checks below avoid unnecessary mmap_l=
ock
> +        * fallbacks.
> +        */
> +       vma_iter_set(vmi, from_addr);

This is clearly simpler but this unconditional vmi reset is not ideal.
At this point we could make vmi just a local variable of this function
because we don't use the stored state anyway. I guess we can use this
as a quick temporary fix.

For the long-term fix I want to check with Liam about feasibility of
adding vma_iter_next_after(), in which case this issue can be fixes
easily and vmi reset can be removed.
Otherwise I can refactor David's patch to hide some of the details in
abstractions like Lorenzo suggested and post that.

>         /* Start mmap_lock speculation in case we need to verify the vma =
later */
>         mmap_unlocked =3D mmap_lock_speculate_try_begin(mm, &mm_wr_seq);
>         vma =3D vma_next(vmi);
> -       if (!vma)
> -               return NULL;
> +       if (!vma) {
> +               /*
> +                * There is no reason to fallback if there really isn't a=
nything
> +                * in the remaining range.
> +                */
> +               if ((mmap_unlocked && !mmap_lock_speculate_retry(mm, mm_w=
r_seq)) ||
> +                   vma_range_is_empty(mm, from_addr, ULONG_MAX))
> +                       return NULL;
> +
> +               rcu_read_unlock();
> +               goto fallback;
> +       }
>
>         vma =3D vma_start_read(mm, vma);
>         if (IS_ERR_OR_NULL(vma)) {
> @@ -470,15 +498,14 @@ struct vm_area_struct *lock_next_vma(struct mm_stru=
ct *mm,
>          * it was not shrunk after we found it and another vma has not be=
en
>          * installed ahead of it. Otherwise we might observe a gap that s=
hould
>          * not be there.
> +        *
> +        * If speculation fails, avoid taking the mmap_lock when a direct=
 lookup
> +        * confirms that the gap is empty.
>          */
> -       if (from_addr < vma->vm_start) {
> -               /* Verify only if the address space might have changed si=
nce vma lookup. */
> -               if (!mmap_unlocked || mmap_lock_speculate_retry(mm, mm_wr=
_seq)) {
> -                       vma_iter_set(vmi, from_addr);
> -                       if (vma !=3D vma_next(vmi))
> -                               goto fallback_unlock;
> -               }
> -       }
> +       if (from_addr < vma->vm_start &&
> +           (!mmap_unlocked || mmap_lock_speculate_retry(mm, mm_wr_seq)) =
&&
> +           !vma_range_is_empty(mm, from_addr, vma->vm_start - 1))
> +               goto fallback_unlock;
>
>         return vma;
>
> --
> 2.56.0
