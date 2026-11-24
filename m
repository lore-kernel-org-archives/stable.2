Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795535516;
	b=E/0Qz4UyLEw9ULtybY4QmWqwP4tViyFELF9PetAn6/srkJYQzN4b+oOoEnX8Aw5YNyaH
	 E5KXXUP8/wb7U4OXDsY3L/yhmCnsmnjRrIPhn4n3lcWUjrSZuU3kxyYes79pYBl8za2h+
	 NeWHQL4xQvLJVYecptDxMsyKkp2FJs9yBrMxucFrKq8Kboa69cECLtCIqtrI84+cCL6Ew
	 dilgCVXVl1iXq3ufV0RCr7SutVNxXkdVgnorXgyiKTBjh7sFFGOn9v3ItNvNg5LV/jiBC
	 W4APsWYXa8+51XGODkPmIp9pADqAgygfuWb1EoaSsMddpoDVnFrQ8UnvU2SQmtF/pWw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795535516;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=7151zgqNmppt1FWLTyRdRTu2s96pKFEly/RuS9gjWeY=;
	b=WlfabKsdhJyzGbwECsfg9j8d8GZqIZNS6XM6FiimFgQR5Ihs5QqSikMjGslUbVTEPbbr
	 RXXE/XEiF97Lcfan/CqVnz67xlp9ghK+awC+b/llMCu/vQv6ch+MvNwKLZcn9XkKeiApV
	 Ji4JkNPPq6ruNpYeaI5wDUZY9b49TgDIYndVxnrtzbA0THxfJF+Djp0dYDu9ql7iEoPdu
	 KBJOQ+NLfZTU9Vclt097z3x1itDjrvydzBLE5/sPVx4h6mv1EPuu0ZSiBMcLPNWB6g6DZ
	 Hl6T8xRqoq7qRknMYAAiEx76+BtbAZIQkkgkWU9u8W3Ao1w9Bs7Goyhcyy4QfReJNHg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gYnNBYPL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0832606A33E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:51:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0832606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gYnNBYPL
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-54492d8a988so917551cf.0
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 07:51:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795535515; cv=none;
        d=google.com; s=arc-20260327;
        b=I1NG7+WnVtATL588Lcu00mbUa508yWBkXIrrvStqnjvDbi7cnaPgmADzipxXyAEDGK
         osMpMF6FM+IEvwUpR0kZeKFj1PXu67ezF+pqLwrPz3dwgtuNEe1dFl8gZIsTIEl/tQ/B
         kbFFKmUwZqNbn3zJV2ICggpVA/SP13wuwVRkkG9H3xrMVfPIBrHO2PB7FSlW/O6S3J2e
         7kJLK6pvqTScIHsa2xfOX3yUuH1teln5cJq7MjTgm5lWdV5Z5yR60fX+ojL3aGk11rjN
         EFAe53oloWtpTgl0XfuaC8WacXn0JQV8FcrgwPyVOqKxQMxy3GwscNiSyKXv928lDtay
         IaLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7151zgqNmppt1FWLTyRdRTu2s96pKFEly/RuS9gjWeY=;
        fh=brCTXTgX7LxN6hkVkTHuN6n0kPVc8uxWrsGcxJIUCBE=;
        b=Gmv3jjDlBjqwovBu8Be15eDH+IjEDohcQQXD7lSF3/EuvlH8JPhQFQxTI3OM3KkB/4
         fgihpkCkDYpTCTI21iKTIURGP/MpbrlJKh52nOwL0LLKDQAY0Q2SqWDo1yrY9KnLSSu0
         xaZkfrZhIq+ukB4EE2o/iOhsgXStcfcK7yKxvoXL4AyGDhcLiySMOSEriBYJu4SGNC2s
         oxmgis6e8IFi/E4iR5iWr1gB5lN3rCjA/taFVfYFW1I1NkOkDQpWUWfaDG91lsL3kQ7T
         RQ4oQ+Wzg3I6HpJR2v9GfMkLE1rBbEZMS/KUVIBg7cebAsxF4L6hqHNiYyuTYYSTSLt4
         YSyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795535515; x=1796140315; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7151zgqNmppt1FWLTyRdRTu2s96pKFEly/RuS9gjWeY=;
        b=gYnNBYPL7+Vso9fth4O30mUOQnoyOn3TOxaH9pHwo3lJTeahoBTFFJ5Q4/9eecco3H
         Ei5saRYpH5syTy8Ucfen49s3IrZ6ufTDp7Jou0Th3k2HyFxIJKuquydsppJKH4SGMEjF
         HTZubH7A6s2bHrdMaC4HirlYiCHKQcI902r4H/ZRXJY6fz8xJvDKDtYJePSACZsBHv14
         bMjd8WVjudy7rk63YHILKKkSr7ncJl9G/Xme/p6omTSsGdT9GmVnoeXf25YlOiog8Woe
         rWBB4pd/bzw+HjhbkCcGqhITw0ZbFKeDkdfijEEYca3CYnWtfdJte6D3j1fC27fTgu9B
         zdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795535515; x=1796140315;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7151zgqNmppt1FWLTyRdRTu2s96pKFEly/RuS9gjWeY=;
        b=YvdWpklQYhzZtHtlZ5KxYXwxHe9CbuGDcErIwvmPf62cXnfchRMXkRfvxRs70Ftlb4
         vhMJigF9GHMa6JuwdKAu2RkpZCQohe8ySdoD1HE61lZd75AVvmxvowqYHrPRsWqBzmSq
         JfzoOb5xKVJKDAqAzgJZjGCFwfdLIObc+RJ08InyRkttF3SBWaUy0OjJqQA4i4luIyzK
         VD1w75DBiYyCy6IbnddEgFFqbOmkN6LPevCIneDgGzlbfQbjWt31SGcmofGeC90+FqrY
         CSM/WT2dpibowdFxtgHo9YlWmLydu6sz+3s7UcZIgH9wNiPcroRwQvHZXGhu2xeu68nT
         Msfg==
X-Forwarded-Encrypted: i=1; AL+hErHi2T2ShU4mo+xhEQwEH0Q+D1sgMY1Cg7advSf0Py0vM08mVz8cjQ7Mwd0B/0s4ezYvJJP7v5A=@vger.kernel.org
X-Gm-Message-State: APuU4Z88hCO5luu3OEILUEkrlzKtIFvlRlJksrT48qoy7lEKOdQKbUHP
	FNqklkcLlE4KiosjmslbL4Mlic5dNUjMLHcdsGMxRLsZglpU8jN15csO9S+8gay+o1MAQrRAIo2
	sy+oQTsmpNEKgC/uE9EHRZ9U3OEzJTzVw89hXNkKt
X-Gm-Gg: AZFdTZd+1aAbPEaTn3tBYFhL2otI9oKImVCzYAc5lfXxcg1CNW1nXaIwpP+hsoctS9V
	dUA2qurNxQU99Yj6Cx16qOR66naYZamWWs3giYDvYf9k3Xb1Ber+js1zclgWNsIJwkhAwfcdpDk
	srf6/BWIU1bX2/ctPY3/oRa0bRfT5yk8zhf2EyTWz5a7mfJLyJ7JJyrUScZiJpW+nPYtGzq7+IF
	s0ZS9SL5didiWTzCIeYP7U/fRvR37jW6u7lprGtDwKc99iOai1c3f6kC4b99O3VBrMcAdNzi3wH
	qhUnyow4QBQyt8UxreQYlrVR48pd6RLjFTIiGRlE5kgyr3zAJlr3OzZ48o/WsfwtTWs5KKY+RtK
	BuTkYZrUTkZVAdhZ8Fkm+eqz4KHNRo+eJpGnZtFSIM5k10v9yCJgqk3lwrdLmIgSUn6cgQmTBtB
	Epi32JbtJeW5zejPA9ORnfsKk96M4=
X-Received: by 2002:a05:622a:4819:b0:54b:648d:9ab5 with SMTP id
 d75a77b69052e-55d8903863bmr55786151cf.11.1795535514050; Tue, 24 Nov 2026
 07:51:54 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261124-vma-read-lock-mmdrop-async-v1-1-257f99f551de@kernel.org>
 <awWLCZ-jBjSD7V3M@pedro-suse.tail5790ac.ts.net> <CAJuCfpGk6eYK43Unxo+O4ML5=GM_siZ9owp6oa9fO0ipZXVg-g@mail.gmail.com>
In-Reply-To: <CAJuCfpGk6eYK43Unxo+O4ML5=GM_siZ9owp6oa9fO0ipZXVg-g@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 24 Nov 2026 07:51:42 -0800
X-Gm-Features: Aa3M54qQPEWg8Xv6M1FeAv2Yk0G2ClZoOWgLEIXc3iRWC6ZsNwo9TmRawceulIU
Message-ID: <CAJuCfpEd1rz3P7fB7W_mHkyzbpq9TscRE+QNwvHdYME=WJj6cw@mail.gmail.com>
Subject: Re: [PATCH] mm/vma: drop mm asynchronously in vma_start_read()
To: Pedro Falcato <pfalcato@suse.de>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Kees Cook <kees@kernel.org>, David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Jann Horn <jannh@google.com>, 
	Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Chris Mason <mason@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 7:46=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Tue, Nov 24, 2026 at 5:04=E2=80=AFAM Pedro Falcato <pfalcato@suse.de> =
wrote:
> >
> > On Tue, Nov 24, 2026 at 12:26:19PM +0000, Lorenzo Stoakes (ARM) wrote:
> > > Commit bee9ef4a40a2 ("bpf: switch task_vma iterator from mmap_lock to
> > > per-VMA locks") open-codes a lock_next_vma() implementation that does
> > > roughly the same thing in bpf_iter_task_vma_find_next(), only without
> > > fallback to an mmap_lock.
> > >
> > > This is because bpf_iter_task_vma_find_next() can be called from
> > > non-sleepable contexts.
> > >
> > > However, lock_vma_under_rcu() gave no guarantee as to which contexts =
it is
> > > safe to be called from, and indeed it turns out this assumption is un=
safe.
> > >
> > > Since commit 9bbffee67ffd ("mm: fix a UAF when vma->mm is freed after
> > > vma->vm_refcnt got dropped"), this call chain is possible on x86:
> > >
> > > lock_vma_under_rcu()
> > >   -> vma_start_read()
> > >     -> mmdrop()
> > >       -> __mmdrop()
> > >         -> mm_free_pgd()
> > >           -> pgd_free()
> > >             -> pgd_dtor()
> > >               -> spin_lock(&pgd_lock)
> > >
> > > Thus, a plain spin_lock() can occur when lock_vma_under_rcu() is
> > > called. Since bpf_iter_task_vma_find_next() can be called in softirq
> > > context, this can deadlock, for example:
> > >
> > > pgd_alloc()
> > >   -> spin_lock(&pgd_lock)
> > >     <softirq>
> > >     bpf_iter_task_vma_next()
> > >       -> lock_vma_under_rcu()
> > >         ...
> > >         -> spin_lock(&pgd_lock) [ DEADLOCK ]
> > >
> > > Alexei Starovoitov also pointed out that a BPF program attached to
> > > trace_contention_end() can similarly cause a deadlock:
> > >
> > >   pgd_alloc()
> > >     spin_lock(&pgd_lock)
> > >       queued_spin_lock_slowpath()
> > >         trace_contention_end()          <- pgd_lock is held
> > >           tp_btf/contention_end prog
> > >             bpf_iter_task_vma_next()
> > >               lock_vma_under_rcu()
> > >                 vma_start_read()
> > >                   mmdrop(other_mm)      <- last put takes pgd_lock ag=
ain
> > >
> > > Resolve the issue by having vma_start_read() use mmdrop_async() inste=
ad of
> > > mmdrop() so the work is deferred to a work queue.
> > >
> > > Make mmdrop_async() an internal mm function, defined in mm/internal.h=
, to
> > > avoid abuse elsewhere (kernel/fork.c includes this header, so still r=
etains
> > > access).
> > >
> > > Commit 0b16f8bed19c ("mm: change vma_start_read() to drop RCU lock on
> > > failure") accounted for the fact that the RCU lock had to be dropped =
for
> > > this operation, which is no longer applicable.
> > >
> > > For the sake of a backported fix, retain this behaviour, however drop=
 the
> > > RCU lock last and remove the now irrelevant comment.
> >
> > Is there any particular reason for unlocking the RCU comment last? afte=
r the mmdrop_async().
>
> Yeah, I think moving the RCU unlocking was unnecessary (unlock as soon
> as possible is in general advisable) and we could just remove the
> comment. Both versions however seem correct to me.

Actually, VMAs are allocated from a SLAB_TYPESAFE_BY_RCU slub. With
that RCU unlocking move you don't need other_mm copy and the comment
that comes with it. VMA won't be freed until RCU lock is dropped.

>
> >
> > >
> > > Reported-by: Chris Mason <mason@kernel.org>
> > > Fixes: bee9ef4a40a2 ("bpf: switch task_vma iterator from mmap_lock to=
 per-VMA locks")
> > > Cc: stable@vger.kernel.org
> > > Link: https://lore.kernel.org/all/DN267JUKDRNS.2VMV07CQ58R4X@gmail.co=
m/
> > > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> >
> > Acked-by: Pedro Falcato <pfalcato@suse.de>
>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
>
> >
> > --
> > Pedro
