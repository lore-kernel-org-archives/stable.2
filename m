Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792940162;
	b=lC3EHmbwZpvNqQKS5LBGfMabubzXMGDkVBVUJb7IVjBsXM2urjoCCRW1cY1oMnRA8cFi
	 SJ3lmIk3VT3zP7moQS35xMTKPoUI4nRSgsB9TUMP8F8JWFXXbod3WMvqlQnAveZXL7Wm9
	 uxRJ0r0dEn/ckd0DxIzF9ZpUzP3HnNFYACvzjsY5enWRdt04UrKIMgduIB3XlwgtNe02X
	 3hrEULT4CeFWL92DoMayfvUWg4q/9TtqlBA3Scx2aplVP8cL7ED38rgnm76/uRZZolPB3
	 UlA49AybeopGCRm83CBg6JB4ri0c0OAUMVItVHLGk6uKlCWL5Cn0f7+eBLDGTKe1Rpg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792940162;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=edJydXO8eM7QbcwRvjK6Scc5idFapwpqQSUYWRShZ90=;
	b=kh3rNS4nZaxf681NFAEkWEQPgwOgVnb74axA8P6qt3BQS0qRGEbFpcGV1ATNTF/VhxdV
	 K5eK7yze+LK26TAnH4a7IeYxi7ASc4JQGP0CkXgjkJPRyX3ueTMd6fo/lbDwJd3NcPqai
	 MntrWKnC97iWgXkrmvT1tHSdZiLKOwCdj9WbJBQT3xfSiDNIbxvVGqqmA4aEFVew9Wsez
	 egsKunV76EftkHnBDXIqSPB8KyM7vsfivUn/l/MdpYxlqUaf61cQonpKu6g6osDb+/IP9
	 +I/0sQ8haPac9TPtmlmOZi4Je3pWjr0U5eFrEVn8826CquKZaJHsIf+/NW0KX9tnrBQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=njUscctr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C69606A31B
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 14:56:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55C69606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=njUscctr
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-535f598d126so184411cf.1
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 07:56:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792940161; cv=none;
        d=google.com; s=arc-20260327;
        b=Irj5MpVoZNQDB3HeHreBm1fLCwEv+VHwVXYV+qa8zsxcLTLe0vLaAKGprMTOlB3D8g
         NJLBBilEqlhI7eOrHvMxUXTSKhY1EVu8ReUT0G1+6dWH5xkptJ3Fy13373H32O6LPI7O
         H9Vnme7+uqlip4HWt9dZAKpugBMEf9PWxj/yEGSZsUFWN4DomgxebdZJ+TdBYcUxC4nd
         VX+06sM8oOKpNotjS/4BldPKI1GXRxdXF8vcJ2wjz3wcAflDjclSuFoGxA6TfsSzNKss
         B+mpHo8YaLz6WsK4Aa0KFEwMjwu4v6JwkTRHGIQ8mraRILyLUlZfrhkNj/J2Oe+TCaHt
         YQYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=edJydXO8eM7QbcwRvjK6Scc5idFapwpqQSUYWRShZ90=;
        fh=ZAGmXvvrSKHG0KjsvebwCb1OKD1U4gAbjwUmf/7GUzU=;
        b=Cr88lWCho2LNZoAbt/3PcFyc5USYhodM5O2hNGPUWwWjGJQKLQ4A1aP3edyUgAz7Kr
         KN/sdwX1LjLaq/J0bGCfCizC3nYvVaia8gkTK+6suPoRRIRAhLJqvaGXcnmE4jdN57EU
         vcI+6hD2a3bV7hReXdFLHVkgiGJl/hF3q2EhwaVwWRYJZiHM+I1c/JhXS7f2r3WmjbdA
         EoX+uYYCsv0y1DFH3y6TpvZCn1BaGxM8Z0hy4mm8Y/z7hsQscfrat8sOl5leCkksdId8
         dOL6sypnQyBR+D5aos7mvO1HwDYXBNnvlZmzDKYWHsWpQ+2TZeH4grtcWeAl1k2XUhF8
         p+ig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792940161; x=1793544961; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=edJydXO8eM7QbcwRvjK6Scc5idFapwpqQSUYWRShZ90=;
        b=njUscctrhC83Mal9QP8A9ajHDyDeTmzxArDx1ofoyb4XrmC/PnAktTXlx8nezve17k
         dso2zG68vVOgLyLqACkpg9ua2K/yH7dZdm3D+COtv0KmcvDcPyfH8o3ASnhShSjmFmQQ
         EmypgsRLy0bGPviRmHMEUAPkY3uHCLjXIUUjO/YihX9bepaQd5fY8DRFeGOoShw3+7iR
         A7NfMU1zWnTD+NGmxE8TGmE9JhLBNG4V16R62KZWVewMw/XuTR5ZDDjcyKS/OnGt1G9k
         3rm/cw12u1pouZyRNjYjIkbZmWebhVOJmQ02ydYIX/kEJRWPiCJFcsfh5Ci+mbAWtmpG
         Vksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792940161; x=1793544961;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=edJydXO8eM7QbcwRvjK6Scc5idFapwpqQSUYWRShZ90=;
        b=wQusKiQruAwv9xwc2MZyFeDtEX8csS96tsk71QFf18TpGF7dJG3lRL+hBrX9Bb8nj+
         4+dkQEzy5UCQbqSuDwjQOKeev2AAw/RfxBqIOUwmQs3tcyMnMfq0sOvKCuhuKm3Y26se
         qeOqZjKc8x9BcPYrMhmzHv5ZwZabXcUaogmQ2xPg62aBfAReyBIKlzUp9AMrcujarBVa
         EJ8kgTWBVouCGqk8b7lgufjTSVTy3DpG2VUGzelZMwhKIdZ/dQ11FcbxjpSGQ87W22mc
         71QopJD9MjMau26UX1x7uW913g2OvqmvRjWVCZOsg7CeypzwIPi2kv+E3z5lMYNCAi+4
         QSzQ==
X-Forwarded-Encrypted: i=1; AKwUvByuREeZlOEZL9Ya9nuq6BihK+V2QrRVn5orsXriGf/4dwXwaPcAz5fbfXRwr2ywRCHwCQFELus=@vger.kernel.org
X-Gm-Message-State: AFq9FYKpLbsAlYbQUoAlpZQwxTTHGNEzOKWPte583F21XXe+PPqTFFQ9
	UBm6czxVO1dwRsSGJgdf66wG7t/60Ln1dj4tpCCVIRUq2HcUbz+0ylPz2Dkqs47C4Ox+RTTg8LS
	gZypaYkhX6pkrQokYMf0748Vi/q6KjVFRmP0sNVOI
X-Gm-Gg: AYBFou22brROEuRvHSebrb8218UL+H+MS96XXoM60nCQ6wmm7ItPsc2K+xrNhki8XKN
	UyLmJ+9mNP/0jjb/7GLELpAnffHGdsMmIxUhE7/MEJKRzDUuto4F5C0nAPx5bCKqMaL8s4/1iCQ
	5kTHjLmg4/VvSQ93DJXwmh6lDJdeqPhGof1gNluhzCZ/xWe/iziLQL3aZNkS7NdD7+KrpJuoGQ1
	Uqc+EtW1lrOsKnShX42Mx9C4zrGYrxehuE+O8GpsjqC0zeq9ApjxcC1nP0g85TXWcjAnJTI7th3
	vzB4uU8thoDF8dFmyqFFkgSTiEgqTpBdlaD3zns4PI6jxy4YcALfABPrJFqdonCWczIQxA7aCDa
	2WXNJteweKVKP1QcTDBBrqHoNOi4JusLYcYA=
X-Received: by 2002:a05:622a:1f12:b0:535:30a:76c7 with SMTP id
 d75a77b69052e-5383b47236amr21034181cf.3.1792940160515; Sun, 25 Oct 2026
 07:56:00 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261025-per_vma_maps-v1-1-c4eec45b9387@kernel.org>
In-Reply-To: <20261025-per_vma_maps-v1-1-c4eec45b9387@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 25 Oct 2026 07:55:48 -0700
X-Gm-Features: AclHuK8uFqepEAvLNHa3DmgUKJrQNAsjl4cEFXBDYXl8QDdPza9TmJXOwbUbspw
Message-ID: <CAJuCfpEk6H-wJvNqxSXTwj2NCjEMEzYr6MyHjRNRZjPC2AV2wA@mail.gmail.com>
Subject: Re: [PATCH] fs/proc/task_mmu: fix missed VMAs when reading
 /proc/PID/maps and friends
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Shakeel Butt <shakeel.butt@linux.dev>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 25, 2026 at 3:43=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> Reading /proc/PID/maps under per-VMA locks can skip continuously mapped
> address ranges during concurrent VMA splits or merges. This violates the
> guarantee in Documentation/filesystems/proc.rst:
>
>   "If there is something at a given vaddr during the entirety of the
>    life of the smaps/maps walk, there will be some output for it."
>
> lock_next_vma() reuses a tree iterator across calls under RCU. The iterat=
or
> remembers the range of its last entry. When its node is replaced,
> mas_next_slot() walks the tree again at the last index of that range, the=
n
> advances past the entry containing that index. If VMA boundaries changed,
> this can skip a range that has not been reported:
>
>  - A lookup finds [A, C), then mprotect() splits it into [A, B) and [B, C=
)
>    before vma_start_read() locks the first VMA. The reader reports [A, B)=
,
>    but the iterator still covers [A, C). The next call starts from B yet
>    advances past C, omitting [B, C).
>
>  - The reader reports [A, B) and unlocks it. A concurrent mprotect() then
>    merges it with [B, C). On the next call, the iterator resumes at B - 1=
,
>    which now belongs to [A, C), and advances past C. Again, [B, C) is los=
t.
>
> Checking the mmap_lock sequence only within the next call misses writers
> that completed before that call began. Also, a NULL result is currently
> accepted without validation, so a race can terminate the walk early.
>
> Even a fresh lookup can skip a mapping. Suppose it finds a gap before
> [B, C). A writer inserts an adjacent VMA at the end of that gap, then
> merges it into [B, C), replacing the node. The lookup resumes at the old
> gap's last index, now inside the merged VMA, and steps past it. The
> original [B, C) remains mapped throughout. Repeating the forward lookup
> is insufficient: another merge can make it skip the same mapping again,
> returning the same later VMA or NULL.
>
> The fresh-lookup race also affects /proc/PID/smaps, numa_maps and
> smaps_rollup. Resetting the iterator after gathering each VMA's statistic=
s
> does not prevent a merge during the next lookup. Fixing lock_next_vma()
> also prevents omitted entries and incomplete rollup statistics.
>
> Keep a saved sequence in the proc maps locking context and validate it
> before each lookup with mmap_lock_speculate_retry(). If it is even (no
> pending writer) and still matches, reuse both the iterator and the saved
> sequence. Otherwise, restart at from_addr and sample the current sequence
> before looking up the VMA. Only refresh the sample when resetting the
> iterator, so a writer between validation and the lookup cannot go
> undetected.
>
> The smp_rmb() in mmap_lock_speculate_retry() orders the previous lookup
> before rereading the sequence. It pairs with smp_wmb() in
> do_raw_write_seqcount_begin(), which separates the sequence increment in
> mmap_write_lock() from subsequent tree updates.
>
> Validate detected gaps (from_addr < vma->vm_start) and NULL from
> vma_next() against the sequence. If there were concurrent writes, use
> mas_walk() to check if the writer could have interfered with the range
> of interest. If the range is not empty, something interfered concurrently
> so we retry under mmap_lock. Checking for empty ranges avoids taking the
> mmap_lock just because an unrelated writer changed the sequence.
>
> Original fix generated by an LLM and sent by Josef Bacik in private.
>
> Fixes: 5631da56c9a8 ("fs/proc/task_mmu: read proc/pid/maps under per-vma =
lock")
> Fixes: ea3085dd7a4e ("fs/proc/task_mmu: read proc/pid/{smaps|numa_maps} u=
nder per-vma lock")
> Fixes: 0e985559d72a ("proc/task_mmu: read proc/pid/smaps_rollup under per=
-vma lock")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Thanks for the report and the fix! Let me take a closer look. I took
extra care to ensure we do not skip any VMA but maybe I missed
something here.

> ---
> I neither understood nor liked the original LLM generated fix that was
> provided to me, and I (and codex) think it was incomplete. So I tried to
> come up with a better fix that avoids additional fallbacks to the mmap_lo=
ck
> while trying to keep it simple.
>
> I won't claim that I am now an expert on the code, or that this is the
> most elegant fix. It is quite complicated what we built ... too
> complicated. So if this goes into the wrong direction I'll be happy
> if someone else wants to take over ;)
>
> I reproduced the races with /proc/PID/maps, and with this patch they are
> resolved. I did not manage to reproduce the races with the new
> smaps/smaps_rollup, but the races are slightly different and harder to
> trigger.
>
> There is the issue with seqcount overflows that Lorenzo is tackling. It
> probably interacts here as well? Likely, but that's an independent issue
> to resolve.
> ---
>  fs/proc/internal.h        |  1 +
>  fs/proc/task_mmu.c        |  6 +++--
>  include/linux/mmap_lock.h |  5 ++--
>  mm/mmap_lock.c            | 58 +++++++++++++++++++++++++++++++++++------=
------
>  4 files changed, 51 insertions(+), 19 deletions(-)
>
> diff --git a/fs/proc/internal.h b/fs/proc/internal.h
> index df873df9afc56..f3e846b574d79 100644
> --- a/fs/proc/internal.h
> +++ b/fs/proc/internal.h
> @@ -386,6 +386,7 @@ struct mem_size_stats;
>  struct proc_maps_locking_ctx {
>         struct mm_struct *mm;
>         bool mmap_locked;
> +       unsigned int mm_wr_seq;
>         struct vm_area_struct *locked_vma;
>  };
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index ee9fc2fd2b2fe..dc3adcffb6d9c 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -148,6 +148,7 @@ static void reset_lock_ctx(struct proc_maps_locking_c=
tx *lock_ctx)
>  {
>         lock_ctx->locked_vma =3D NULL;
>         lock_ctx->mmap_locked =3D false;
> +       lock_ctx->mm_wr_seq =3D UINT_MAX;
>  }
>
>  static struct vm_area_struct *get_next_vma(struct proc_maps_private *pri=
v,
> @@ -160,7 +161,8 @@ static struct vm_area_struct *get_next_vma(struct pro=
c_maps_private *priv,
>                 return vma_next(&priv->iter);
>
>         unlock_ctx_vma(lock_ctx);
> -       vma =3D lock_next_vma(lock_ctx->mm, &priv->iter, last_pos);
> +       vma =3D lock_next_vma(lock_ctx->mm, &priv->iter, last_pos,
> +                           &lock_ctx->mm_wr_seq);
>         if (!IS_ERR_OR_NULL(vma))
>                 lock_ctx->locked_vma =3D vma;
>
> @@ -523,7 +525,7 @@ static struct vm_area_struct *query_vma_find_by_addr(=
struct proc_maps_locking_ct
>         unlock_ctx_vma(lock_ctx);
>         rcu_read_lock();
>         vma_iter_init(&vmi, mm, addr);
> -       vma =3D lock_next_vma(mm, &vmi, addr);
> +       vma =3D lock_next_vma(mm, &vmi, addr, &lock_ctx->mm_wr_seq);
>         rcu_read_unlock();
>
>         if (!vma)
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index 28e3696ce9ff3..e33d15ce6a876 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -511,12 +511,13 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm=
_struct *mm,
>   * Locks next vma pointed by the iterator. Confirms the locked vma has n=
ot
>   * been modified and will retry under mmap_lock protection if modificati=
on
>   * was detected. Should be called from read RCU section.
> + * *last_seq must initially be odd and is kept across calls.
>   * Returns either a valid locked VMA, NULL if no more VMAs or -EINTR if =
the
>   * process was interrupted.
>   */
>  struct vm_area_struct *lock_next_vma(struct mm_struct *mm,
> -                                    struct vma_iterator *iter,
> -                                    unsigned long address);
> +               struct vma_iterator *vmi, unsigned long from_addr,
> +               unsigned int *last_seq);
>
>  static inline void vma_assert_can_modify(struct vm_area_struct *vma)
>  {
> diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> index 2f94ee0fdee2a..0f3a4e0c5520d 100644
> --- a/mm/mmap_lock.c
> +++ b/mm/mmap_lock.c
> @@ -400,21 +400,50 @@ static struct vm_area_struct *lock_next_vma_under_m=
map_lock(struct mm_struct *mm
>         return vma;
>  }
>
> +static bool vma_range_is_empty(struct mm_struct *mm, unsigned long start=
,
> +               unsigned long last)
> +{
> +       MA_STATE(mas, &mm->mm_mt, start, start);
> +
> +       return !mas_walk(&mas) && mas.last >=3D last;
> +}
> +
>  struct vm_area_struct *lock_next_vma(struct mm_struct *mm,
> -                                    struct vma_iterator *vmi,
> -                                    unsigned long from_addr)
> +               struct vma_iterator *vmi, unsigned long from_addr,
> +               unsigned int *last_seq)
>  {
>         struct vm_area_struct *vma;
> -       unsigned int mm_wr_seq;
>         bool mmap_unlocked;
>
>         RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "no rcu read lock held");
>  retry:
> -       /* Start mmap_lock speculation in case we need to verify the vma =
later */
> -       mmap_unlocked =3D mmap_lock_speculate_try_begin(mm, &mm_wr_seq);
> +       /*
> +        * Restart by address if a writer could have changed the cached r=
ange.
> +        * The retry check's smp_rmb() orders the previous lookup before =
reading
> +        * the sequence and pairs with smp_wmb() in do_raw_write_seqcount=
_begin().
> +        *
> +        * The vma_range_is_empty() checks below avoid unnecessary mmap_l=
ock
> +        * fallbacks.
> +        */
> +       mmap_unlocked =3D !(*last_seq & 1);
> +       if (!mmap_unlocked || mmap_lock_speculate_retry(mm, *last_seq)) {
> +               vma_iter_set(vmi, from_addr);
> +               mmap_unlocked =3D mmap_lock_speculate_try_begin(mm, last_=
seq);
> +       }
> +
>         vma =3D vma_next(vmi);
> -       if (!vma)
> -               return NULL;
> +       if (!vma) {
> +               /*
> +                * There is no reason to fallback if there really isn't a=
nything
> +                * in the remaining range.
> +                */
> +               if ((mmap_unlocked && !mmap_lock_speculate_retry(mm, *las=
t_seq)) ||
> +                   vma_range_is_empty(mm, from_addr, ULONG_MAX))
> +                       return NULL;
> +
> +               rcu_read_unlock();
> +               goto fallback;
> +       }
>
>         vma =3D vma_start_read(mm, vma);
>         if (IS_ERR_OR_NULL(vma)) {
> @@ -442,15 +471,14 @@ struct vm_area_struct *lock_next_vma(struct mm_stru=
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
> +           (!mmap_unlocked || mmap_lock_speculate_retry(mm, *last_seq)) =
&&
> +           !vma_range_is_empty(mm, from_addr, vma->vm_start - 1))
> +               goto fallback_unlock;
>
>         return vma;
>
>
> ---
>
> base-commit: 21a7f44fd0765fcc5194130b28767786eba1d1e7
>
> change-id: 20261025-per_vma_maps-ceab0eb860d5
>
> --
>
> Cheers,
>
> David
>
