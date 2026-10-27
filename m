Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793115264;
	b=uxqS1r3HxlpzVF4x1Ow/9ls3MnYTf1opTI3kfyy6Ug9PiwUn2jqvKpeHj+G1dWDiQ0VD
	 eiCjhQkGKPrHUYNC1Mt5luP4KhCy1pAvpkCDTO08m+LReFQQ2/R244WjUtVlDJgpN8OKe
	 KJQXQPtEkrj7lUYPMq1JUZ9XKxSHHHWDY/+x6FI+3M2cGWc7+JozYekKD9s+Zl1rBRjNy
	 eIJ0D44MQdpniRw7Jp1l+rwJxwg608Hk7dKrnFjE/wQXPog4tuDiy7rprcqDkdfrbEtc8
	 /gjEPKPvY+5QVZzv3J+anOjCP6qEdEFJb0XAZgcJ9c/13TCippnHMeMJ00aAbp0t6/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793115264;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=3BCqo9DTVlGvGGt63tyjWLqgcTRJp5lddshmK2HXV3Q=;
	b=yJQwhdmY+IWI0Q1pb5NTBpDp9au3QaBhCc71ZWGfLRjExPV+u9r85qD5ng4BRnVXjaNB
	 AVvhIixV4mQZGWPFP38+K1mt2WIaEnjzSkIiPmuXKKwg923lXk+azcpzfqfkTvNzvAa+s
	 GlCxJQxg/I1NXRd5GVer2bcglXJrFYTS77ZJWNlKIbcF1OKG0KUjhqgfXcGY0PxJ/heSB
	 0stucovRXjguqI/4z9cOXMeF+Br/Vq0UCAvMQgSREV7tvoSianA75LeE2oaMxi9cNkzEk
	 XEIGTwRTmYMq0KnC8hkKlycGK1F25fuo7P5YPehIjYmJkByznOblxFUCuFwjl26lcYA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=I2CXkr71;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7FF606A31F
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 15:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B7FF606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=I2CXkr71
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5337c7b9937so380721cf.0
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 08:34:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793115262; cv=none;
        d=google.com; s=arc-20260327;
        b=fyBRY04GXJ2XSGQDV93HPdQ9jJuP0GEpfUBDdY6b01DCWkQOCyoi5UEQEV8ebbKilP
         3cWjG7P4q+KC74i5fo46RltDFO9V+ZO1ou6Vp0UguHH4CWWD85Wu2Qs4Z+Y/7llZYsuo
         yncpMCKtRP3KARESrL6HYjif87JKDx+qpFmrHQxZbXPS06i10EYcB6FVVAasbD3L5VMi
         w1O0njfRcW3XgHaZpcoMWpGHFVTWbnwhV+lzf5mhp91wyPa2B96ShQ1WnDSyt/WzGDTf
         a8gWeelharI3Mgm3koeQHhYpxsA7GaO8uzBZYKhdAQ5Rx6rxQP5V5w2oz4AmTgX8Zy0S
         b+ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3BCqo9DTVlGvGGt63tyjWLqgcTRJp5lddshmK2HXV3Q=;
        fh=FBe0cjH+4Nv8TDEbKhhaJJ8SKqQ41xRri6Al+A4auqY=;
        b=lm1RlXwwLf9L6j7gwD78zDu+evX5BK7Yblewxgk+702G/oMeGpAvfwT8h9NaK9gpUM
         IrQVn51X36sIiQkOSW50ZucAuHzvKWmRV+kICDjX0jLCYSHqQxO+nW0BFuTnqKSOOVBu
         7+Y/IGTpObFQ0uAUHlXcZDeMRvgXmAm81II67dpOj0WQivGv4q648jdLr2YpTEyvknaR
         M/gCxqxeipKhkykqw034UZuMnGwhA/uXpju2BhM076y5n7aJSYg95mRnwrUxQuSCYqex
         r89EF4is3GB28cSFXQ2xXF8CR4VRK+BAAZISwe0Yfbvnybv58Oejfe3SR3oZDqBwSU74
         lBAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793115262; x=1793720062; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3BCqo9DTVlGvGGt63tyjWLqgcTRJp5lddshmK2HXV3Q=;
        b=I2CXkr71eslqj+MzkCc6GenReH55B9jr5dbqHpx5xXwrh5A5nfe28mCtZJLFc93rts
         kzzut8h77lK+HBp+hUYOY/JB8iTND4LYg0o9AoQimbHDYAI+3D57aAXgh+ZC/e/MGGuj
         fa7JcnFzV7NGUmxEPO55U8my+uiduAIt66MkZja5GFG0Aq/0iYlibtrXLvVxHs2wGymj
         L9bIjOnqL33y4JHjuneWUxb85XsIqsyoKKp4BuvfrHC9hgD3YvPCOefOWOU2tERQGbaE
         lQGM6tym4I0WRUaQq3QvWDzQCw8F0vkyJjuEizNzcgub7zA8OHwvq2kZYygY7fFyni3w
         tKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793115262; x=1793720062;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3BCqo9DTVlGvGGt63tyjWLqgcTRJp5lddshmK2HXV3Q=;
        b=vybg54D7cMt6zUIxCIYmxF+xs7rktqhoC6lf9qGcdzwTsdZ5j+IgyG7e2IPzRXWQce
         mKSQsJlgRrEtaIUaBSXWNKi5jEdpScDcaci5PghN21gGqyJNFb9kBX0FxA21Kh5bZLwR
         Mwv03T6ofigMPMcpRhc7xYUpTWTE0RUl3BrxGuCKe5SGJIWWIutrOpSifL6rX4IzDveR
         /7I1lijqxePG3/qdOrQDyIW7dcifEhIwUkbqyY/R89CNt7TJOBpu7RqVJxzy6UKXIYUM
         aoyX+/SSZZ2RGeRL1WZSpsToKmapjAfdgrMmmFSNvr3Iwl61IThc65FUCjPxsEDUuWIC
         fKeg==
X-Forwarded-Encrypted: i=1; AKwUvByWknSme9YBxS26MjR3w4f8UYKpmoNII4WTB8o7hiwFDmnvCG5I2eYFaa6mHvj1VqNHld9DBQ0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKbRlcehN0I5zd6lR4Yj3r7KyDysnOZ0g5zFfHN8LBaN3A8y/Oc
	NIzAtMiy7ggY6jKfRK1fAw2u5Dj/7X0TR3RprdCsYVbR2lsQ18/ZvYDm6qOlbUwPxpeKyIqbeih
	OTLjpwLT7EZlpCSvAYLIhsWC7qIn4fVibScwfwLV6
X-Gm-Gg: AYBFou1RxrxgRqMCaCfMsGmfI/YnLGC0puqe7vedOr9hQxhT3dAoQ209QjCFZpSyfQT
	cQR2zcBtow8oxs4y947KNFa7xDM4VcYtNiRIDhhCI9sjDLZ6oLMKsOmlvgemfUlo6tQYfmikQfR
	n8SIY92Qx/u+C47dSmAxnipQVvM983SJ1IA85o86gErMrdQUNwpSl8xvYoLDHV66g7ycot/cFZf
	PjMisVEmqJH3/GEv8+9C3IoKrXAKvNL+Izq5PSIM9QcqG05icraRfTDhGl+r8wFpCtBIBzMaL6Q
	yrhwSwsgv1EtjHottGs++28WzfwIzoyWItv7EuRo0lUwEcgKS79dleKx1WlahSbq8ETGpKh3rm+
	T+m/IuktL1pL6NeqmqIK0/b9wwp5SB6Z3hUc8stiZ0j/DGIBoZz2tF2TO4VubIPBKfg==
X-Received: by 2002:a05:622a:2616:b0:535:9aa3:5ebb with SMTP id
 d75a77b69052e-53e75218a9emr18868671cf.8.1793115261144; Tue, 27 Oct 2026
 08:34:21 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027-fix-proc-pid-maps-missing-vmas-v2-1-2791cc9fc95f@kernel.org>
In-Reply-To: <20261027-fix-proc-pid-maps-missing-vmas-v2-1-2791cc9fc95f@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 27 Oct 2026 08:34:10 -0700
X-Gm-Features: AclHuK_escKhxIfcgdWHS93RIjhc6nNSVRM5pRyb491eVnaMJqYuWsz74l9RKRk
Message-ID: <CAJuCfpELhxhyVQANspX14OBLbghiAqndYcfv1hnmh4Nvo=1vAQ@mail.gmail.com>
Subject: Re: [PATCH v2] fs/proc/task_mmu: fix missed VMAs when reading
 /proc/PID/maps and friends
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Shakeel Butt <shakeel.butt@linux.dev>, SJ Park <sj@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org, 
	"David Hildenbrand (Arm)" <david@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 7:08=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
>
> Reading /proc/PID/maps under per-VMA locks can skip continuously mapped
> address ranges during concurrent VMA splits or merges. This violates the
> guarantee in Documentation/filesystems/proc.rst:
>
> "If there is something at a given vaddr during the entirety of the
> life of the smaps/maps walk, there will be some output for it."
>
> lock_next_vma() reuses a tree iterator across calls under RCU. The iterat=
or
> remembers the range of its last entry. When its node is replaced,
> mas_next_slot() walks the tree again at the last index of that range, the=
n
> advances past the entry containing that index. If VMA boundaries changed,
> this can skip a range that has not been reported:
>
> - A lookup finds [A, C), then mprotect() splits it into [A, B) and [B, C)
>   before vma_start_read() locks the first VMA. The reader reports [A, B),
>   but the iterator still covers [A, C). The next call starts from B yet
>   advances past C, omitting [B, C).
>
> - The reader reports [A, B) and unlocks it. A concurrent mprotect() then
>   merges it with [B, C). On the next call, the iterator resumes at B - 1,
>   which now belongs to [A, C), and advances past C. Again, [B, C) is lost=
.
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
> Tie VMA iterator state with the current mm and the write generation at th=
e
> point of last mm speculation in vma_rcu_iter, whose values we call 'rvmi'=
.
>
> This allows us to neatly abstract the existing priv->iter logic alongside
> query_vma_find_by_addr() which uses its own VMA iterator.
>
> Then, provide helpers that act on the rvmi - vma_rcu_iter_[maybe_changed,
> may_have_skipped]() to determine whether any VMAs may have
> been altered since last mm speculation.
>
> Additionally introduce vma_range_is_empty(), used by
> vma_rcu_iter_may_have_skipped(), to determine conclusively whether VMAs
> exist in a set range, needing to be traversed.
>
> Original fix generated by an LLM and sent by Josef Bacik in private, then
> amended by David Hildenbrand, and Lorenzo Stoakes added additional
> abstraction.
>
> Fixes: 5631da56c9a8 ("fs/proc/task_mmu: read proc/pid/maps under per-vma =
lock")
> Fixes: ea3085dd7a4e ("fs/proc/task_mmu: read proc/pid/{smaps|numa_maps} u=
nder per-vma lock")
> Fixes: 0e985559d72a ("proc/task_mmu: read proc/pid/smaps_rollup under per=
-vma lock")
> Fixes: d9d1c2d81797 ("fs/proc/task_mmu: execute PROCMAP_QUERY ioctl under=
 per-vma locks")
> Cc: stable@vger.kernel.org
> Co-developed-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Overall the code looks correct bit I have a couple of questions below.

> ---
> Note that I decided it's best to defer any VMA iterator stuff to a
> follow-up - with the abstractions added it's clear what's going on and
> easier for backporting.

Ok. But once we get VMA iterator validation routine implemented, we
won't need vma_rcu_iter and its helpers, I think. Are you ok with the
fact that most of this change will have to be removed later?

> ---
> v2:
> * Took over the patch to make David's life easier :)
> * Introduced vma_rcu_iter tying the VMA iterator, mm and sampled mm seqnu=
m
>   together, and update lock_next_vma() + callers to use it.
> * Moved the sequence out of proc_maps_locking_ctx and the "must initially
>   be odd" requirement out of the header into vma_rcu_iter_init().
> * Added vma_rcu_iter_maybe_changed() and vma_rcu_iter_may_have_skipped()
>   to replace the open-coded speculation checks.
> * Converted vma_range_is_empty() to use a VMA iterator to be consistent.
> * Added Fixes: tag for d9d1c2d81797 (PROCMAP_QUERY), as per Jose.
>
> v1:
> https://lore.kernel.org/r/20261025-per_vma_maps-v1-1-c4eec45b9387@kernel.=
org
> ---
>  fs/proc/internal.h        |  1 +
>  fs/proc/task_mmu.c        | 13 +++++-----
>  include/linux/mmap_lock.h | 22 ++++++++++++++---
>  mm/mmap_lock.c            | 61 ++++++++++++++++++++++++++++++++++-------=
------
>  4 files changed, 72 insertions(+), 25 deletions(-)
>
> diff --git a/fs/proc/internal.h b/fs/proc/internal.h
> index 623bb43ede55..1d95ff577a06 100644
> --- a/fs/proc/internal.h
> +++ b/fs/proc/internal.h
> @@ -393,6 +393,7 @@ struct proc_maps_private {
>         struct inode *inode;
>         struct task_struct *task;
>         struct vma_iterator iter;
> +       struct vma_rcu_iter rvmi;
>         loff_t last_pos;
>         struct proc_maps_locking_ctx lock_ctx;
>  #ifdef CONFIG_NUMA
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 74ffa5c99b8e..22361607020d 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -165,7 +165,7 @@ static struct vm_area_struct *get_next_vma(struct pro=
c_maps_private *priv,
>                 return vma_next(&priv->iter);
>
>         unlock_ctx_vma(lock_ctx);
> -       vma =3D lock_next_vma(lock_ctx->mm, &priv->iter, last_pos);
> +       vma =3D lock_next_vma(&priv->rvmi, last_pos);
>         if (!IS_ERR_OR_NULL(vma))
>                 lock_ctx->locked_vma =3D vma;
>
> @@ -270,7 +270,7 @@ static void *m_start(struct seq_file *m, loff_t *ppos=
)
>          */
>         if (last_addr && !addr_is_sentinel(last_addr))
>                 *ppos =3D last_addr =3D priv->last_pos;
> -       vma_iter_init(&priv->iter, mm, (unsigned long)last_addr);
> +       vma_rcu_iter_init(&priv->rvmi, mm, &priv->iter, (unsigned long)la=
st_addr);
>         hold_task_mempolicy(priv);
>         /*
>          * If seq_file had to flush its collected data right after m_next=
() set
> @@ -520,6 +520,7 @@ static struct vm_area_struct *query_vma_find_by_addr(=
struct proc_maps_locking_ct
>         struct mm_struct *mm =3D lock_ctx->mm;
>         struct vm_area_struct *vma;
>         struct vma_iterator vmi;
> +       struct vma_rcu_iter rvmi;
>
>         if (lock_ctx->mmap_locked)
>                 return find_vma(mm, addr);
> @@ -527,8 +528,8 @@ static struct vm_area_struct *query_vma_find_by_addr(=
struct proc_maps_locking_ct
>         /* Unlock previously locked VMA and find the next one under RCU *=
/
>         unlock_ctx_vma(lock_ctx);
>         rcu_read_lock();
> -       vma_iter_init(&vmi, mm, addr);
> -       vma =3D lock_next_vma(mm, &vmi, addr);
> +       vma_rcu_iter_init(&rvmi, mm, &vmi, addr);
> +       vma =3D lock_next_vma(&rvmi, addr);
>         rcu_read_unlock();
>
>         if (!vma)
> @@ -1421,7 +1422,7 @@ static int show_smaps_rollup(struct seq_file *m, vo=
id *v)
>         rcu_read_lock();
>         reset_lock_ctx(lock_ctx);
>
> -       vma_iter_init(&priv->iter, mm, 0);
> +       vma_rcu_iter_init(&priv->rvmi, mm, &priv->iter, 0);
>         vma =3D proc_get_vma(m, &pos);
>         if (unlikely(!vma))
>                 goto empty_set;
> @@ -1470,7 +1471,7 @@ static int show_smaps_rollup(struct seq_file *m, vo=
id *v)
>                         reset_lock_ctx(lock_ctx);
>                         /* Resume from the last position. */
>                         pos =3D last_vma_end;
> -                       vma_iter_init(&priv->iter, mm, pos);
> +                       vma_rcu_iter_init(&priv->rvmi, mm, &priv->iter, p=
os);
>                 }
>                 vma =3D proc_get_vma(m, &pos);
>         }
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index 11b3ffef3966..9ccbbcbd7aca 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -17,6 +17,13 @@ extern int rcuwait_wake_up(struct rcuwait *w);
>  #define MMAP_LOCK_INITIALIZER(name) \
>         .mmap_lock =3D __RWSEM_INITIALIZER((name).mmap_lock),
>
> +/* Tie a VMA iterator to mm write lock state at iterator initialisation.=
 */
> +struct vma_rcu_iter {
> +       struct mm_struct *mm;
> +       struct vma_iterator *vmi;
> +       unsigned int mm_wr_seq;
> +};
> +
>  DECLARE_TRACEPOINT(mmap_lock_start_locking);
>  DECLARE_TRACEPOINT(mmap_lock_acquire_returned);
>  DECLARE_TRACEPOINT(mmap_lock_released);
> @@ -509,6 +516,16 @@ static inline void vma_mark_detached(struct vm_area_=
struct *vma)
>  struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
>                                           unsigned long address);
>
> +static inline void vma_rcu_iter_init(struct vma_rcu_iter *rvmi,
> +               struct mm_struct *mm, struct vma_iterator *vmi,
> +               unsigned long addr)
> +{
> +       vma_iter_init(vmi, mm, addr);
> +       rvmi->mm =3D mm;
> +       rvmi->vmi =3D vmi;
> +       rvmi->mm_wr_seq =3D UINT_MAX; /* Start odd so changed by default.=
 */

Why not initialize mm_wr_seq correctly using
mmap_lock_speculate_try_begin(mm, &rvmi->mm_wr_seq)? That way on the
first call to lock_next_vma() you won't be resetting vmi
unnecessarily.

> +}
> +
>  /*
>   * Locks next vma pointed by the iterator. Confirms the locked vma has n=
ot
>   * been modified and will retry under mmap_lock protection if modificati=
on
> @@ -516,9 +533,8 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_s=
truct *mm,
>   * Returns either a valid locked VMA, NULL if no more VMAs or -EINTR if =
the
>   * process was interrupted.
>   */
> -struct vm_area_struct *lock_next_vma(struct mm_struct *mm,
> -                                    struct vma_iterator *iter,
> -                                    unsigned long address);
> +struct vm_area_struct *lock_next_vma(struct vma_rcu_iter *rvmi,
> +                                    unsigned long from_addr);
>
>  static inline void vma_assert_can_modify(struct vm_area_struct *vma)
>  {
> diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> index 83b7d3ded0dc..834bbf86e004 100644
> --- a/mm/mmap_lock.c
> +++ b/mm/mmap_lock.c
> @@ -13,6 +13,8 @@
>  #include <linux/trace_events.h>
>  #include <linux/local_lock.h>
>
> +#include "internal.h"
> +
>  EXPORT_TRACEPOINT_SYMBOL(mmap_lock_start_locking);
>  EXPORT_TRACEPOINT_SYMBOL(mmap_lock_acquire_returned);
>  EXPORT_TRACEPOINT_SYMBOL(mmap_lock_released);
> @@ -428,21 +430,53 @@ static struct vm_area_struct *lock_next_vma_under_m=
map_lock(struct mm_struct *mm
>         return vma;
>  }
>
> -struct vm_area_struct *lock_next_vma(struct mm_struct *mm,
> -                                    struct vma_iterator *vmi,
> +/* Is there no VMA in [start, last]? */
> +static bool vma_range_is_empty(struct mm_struct *mm, unsigned long start=
,
> +               unsigned long last)
> +{
> +       VMA_ITERATOR(vmi, mm, start);
> +
> +       return !vma_iter_load(&vmi) && vma_iter_end(&vmi) - 1 >=3D last;
> +}
> +
> +/* Might the VMA tree have been modified since last mm speculation? */
> +static bool vma_rcu_iter_maybe_changed(const struct vma_rcu_iter *rvmi)
> +{
> +       return (rvmi->mm_wr_seq & 1) || /* Odd implies write-lock. */
> +              mmap_lock_speculate_retry(rvmi->mm, rvmi->mm_wr_seq);
> +}
> +
> +/* Could the VMA iterator have skipped a VMA due to the tree changing? *=
/
> +static bool vma_rcu_iter_may_have_skipped(const struct vma_rcu_iter *rvm=
i,
> +               unsigned long from, unsigned long to)
> +{
> +       return vma_rcu_iter_maybe_changed(rvmi) &&
> +              !vma_range_is_empty(rvmi->mm, from, to);
> +}
> +
> +struct vm_area_struct *lock_next_vma(struct vma_rcu_iter *rvmi,
>                                      unsigned long from_addr)
>  {
> +       struct mm_struct *mm =3D rvmi->mm;
> +       struct vma_iterator *vmi =3D rvmi->vmi;
>         struct vm_area_struct *vma;
> -       unsigned int mm_wr_seq;
> -       bool mmap_unlocked;
>
>         RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "no rcu read lock held");
>  retry:
> -       /* Start mmap_lock speculation in case we need to verify the vma =
later */
> -       mmap_unlocked =3D mmap_lock_speculate_try_begin(mm, &mm_wr_seq);
> +       /* Only trust the iterator's position if the tree cannot have cha=
nged. */
> +       if (vma_rcu_iter_maybe_changed(rvmi)) {
> +               vma_iter_set(vmi, from_addr);
> +               mmap_lock_speculate_try_begin(mm, &rvmi->mm_wr_seq);
> +       }
>         vma =3D vma_next(vmi);
> -       if (!vma)
> -               return NULL;
> +       if (!vma) {
> +               /* No reason to fallback if nothing left in range. */
> +               if (!vma_rcu_iter_may_have_skipped(rvmi, from_addr, ULONG=
_MAX))
> +                       return NULL;
> +
> +               rcu_read_unlock();
> +               goto fallback;
> +       }
>
>         vma =3D vma_start_read(mm, vma);
>         if (IS_ERR_OR_NULL(vma)) {
> @@ -471,14 +505,9 @@ struct vm_area_struct *lock_next_vma(struct mm_struc=
t *mm,
>          * installed ahead of it. Otherwise we might observe a gap that s=
hould
>          * not be there.
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
> +           vma_rcu_iter_may_have_skipped(rvmi, from_addr, vma->vm_start =
- 1))
> +               goto fallback_unlock;

Before this change we fell back only if the new search yielded a
different VMA (the vma !=3D vma_next(vmi) condition) while now we
fallback unconditionally. Note that the VMA that we are rechecking is
already locked, so it can't change. Was the previous logic invalid?

>
>         return vma;
>
>
> ---
> base-commit: 33dbd62d6ff310b8cce8c70101639a6eddbb1b52
> change-id: 20261027-fix-proc-pid-maps-missing-vmas-c870d14e1ca9
>
> Cheers,
> --
> Lorenzo Stoakes (ARM) <ljs@kernel.org>
>
