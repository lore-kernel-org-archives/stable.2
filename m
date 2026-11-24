Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795535177;
	b=iE/muRnZaa53GqYT3JT0CAZxSanX0hP4zU0dc+sgKLfYFAU0Ndd9cdCOae6kjQBGi0w8
	 QcVxZqrKTj3LxKKdxaziyEVuAj1bqv1owpVQ0h8/TklD4ErRP0dCHsd8hAy5RyVFMmKNB
	 WX0BBzfIckP46tizp+wlIungEBv8V7bAXmF2W1oiW1Djq9jqalODR5tBINXTScHR+ZYGa
	 ygTg7CW1LbS4eyMHJCJgQXu6awBzuWefQC+bP+cf65WZM29yoG5KaMStJe5uA9Q59dK5i
	 PbmyNX7jbV2OYCZCWsfJu8kebJ++Tu2CtEebku5X5DHk7G9duEFuOXI1wKkx+fmZITQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795535177;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=SOapY5CEQdlHxqSl9JrLPR3I2czhVi36uOATqS9W/YU=;
	b=wAMg8u3ydtwgxYjeRMxrfR26XEOY04RgR4v7bXlYwhvSx/PJhbQAs/ZvGI8hoI/35riV
	 sQb3WMpfDBhnEHTIfYTunvoUhJNVLp4BVrbdpS0ZQv/cr2QG7nWjbo1WY+B4zEyu+J2N1
	 KLJ62bL9yuCzLsg707jJEL8/JaniP88KSkZ6/p6o8qDyBUIEERWDOCrdTlBNlC7MmhIaY
	 m08sDymBoxtAlYxG1bDKZ19DmrsJgYekvPsp9CyH0RDJ+9br8eYeayg3FJpI4YaAsHi0k
	 CBfYcU99eryK+m/uqJ+hBTvpWV73QGFFI9wEUwUDfIKDUoeAkGSBMWrPGbiYepJAUuA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=esU7yeLt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A020606A323
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:46:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A020606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=esU7yeLt
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-54492d8a988so914961cf.0
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 07:46:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795535176; cv=none;
        d=google.com; s=arc-20260327;
        b=JrEKTACJKfUtOEKTmyjjwu/HgFGZLuA+/KmueA6urxDnw6oo6MbCKwdAnljAwrR3Yg
         HzX8sDTyUKm/lPbJH+ObtPfwrrfZBb2wfPHnd0+0+3cXaE6b0zd48a0JH5EQ3hmQD3e+
         x7H49vD12aVA6Cw7yWDR9Nte18HK6C9ZSa/dLR1NAFkPnN1QYsWW+Uf787W5bg9AXKN+
         HpDj/+nj1VkdX+QkTuuq9OAIQBjOq6u6hXcfzjSxkim9Tf++vtoj0BHlhCi5OhhT3OK7
         uJ4N65yiFhSxRK/JHruUZ3UDTqv1G3mGVSBc6olm+9jAzHhxsoLFE1vpLcnISHm+HE60
         NtCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SOapY5CEQdlHxqSl9JrLPR3I2czhVi36uOATqS9W/YU=;
        fh=gs7q+Vfs3glwSIh6ovQCoZ5XbRs2bU89LwzQkBGcC0g=;
        b=M8Hkk2laqgdF1GK5AqFgIURSxCxeSkcIL2aNHCGQw46MK/lNGudIwl172ExjD4f7As
         9hLuFEc0Uxt7tIbK8gPxCqFbeQnvduoJJ+pHd6ujfWHWqCPo8kPD8r/cKV3EEq/QAHtT
         9K23gD6w6Yf019ZxfC5KLBFifCP6WbHp/JRYUtIEneIPkd7WGcTH8M5Vdyz8rowiK17n
         Lmsp1GuC27/LCtyZWk6y5c/FA2dTTs0BORAacLLoKXV6Akfi3Q2GFjTZITkC9rAVojtB
         3HGKzaMq1FkKD53wwIExoaarBgPjJN0CFotPJWP+loTs5lXOiQ38bRe0RGvxOG2EQm44
         CSQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795535176; x=1796139976; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SOapY5CEQdlHxqSl9JrLPR3I2czhVi36uOATqS9W/YU=;
        b=esU7yeLt0A3qCM3mlu0xOTw9SC/PfBCz4ES1uqtiBgcLCvu8EPdvhhtkENZswX2dBI
         27GCY8pkJKMRd0c5rHWF/Ly2PldBkEJbr2gcWMljLkNqA8b1hmoK+PHKq7XHF+9mhMPB
         H8gh5cDxN/lslmNEGaOlJTY3QXCtheFFH6zeB7MsY+gU7FvozzGXEjtZGdD6/xodTAWt
         vjIBiKTI4wrMjNx8VUdzjJFyi6wV2w/wIRgNaZpMBUH9d/se0fv/7uS8CBIsjfl6MDyl
         qefokasVhLMvvDvqh4fXI/Ucp+TWswTqzpRDvje8XylCUqIC568nsIlArQ+mQXOxJwXK
         gIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795535176; x=1796139976;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SOapY5CEQdlHxqSl9JrLPR3I2czhVi36uOATqS9W/YU=;
        b=GkuTpwJZXEX18vqo+bOB7XzdMbTCXMk6BKVthmGJ5H6yAVmzaxmye1SYAePe/EPoEx
         GA2DE33qJL2iTT84uDsWknEPH5llkF5ZJLzF245hOySCLOoTr692YpGIvm15gyfTHRQL
         Y6u9Lgc3pJ6vdbnryOxD0QVBONwRVmWtpHLhk/cpZB+QP66ksEqfwdq/7SqoddN9JRYx
         PBmkuehM2mSzlf5iQWOdcYLJtAYFTQT8D1MBT42Y9wxGY9+D6IFNMfwlG1nOF38f0pjt
         OD61L4P22TO7i0S8RT/4jDPSmkFSZfzp2Cjy6MLzje9IRq3+5xv3tupc47pKg9buoAW5
         LDrg==
X-Forwarded-Encrypted: i=1; AL+hErEemI+ds+WMs0Rh0owFccOmaqU8eO3wCPCir/oSmJoxL+rjue+xNIBKN2yH3Fpry+QLHUQ6/CM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ZU9Kr2TF2TAcPS+1/ZZ5YPDgSYRDJaFk5X/sS7jdjlZSEUFCk
	Mo7KxrGEnheJaAvtC5p1fm4G+RPM2ZV+xzVJWirU5jMkbQrFXdixQQLnb4rRUtdAohUhqzRySHb
	nn6QCccbxJegOTagSuPw1xfIqVbWSJpmyo9NpTVa7
X-Gm-Gg: AZFdTZfsn4LFztFeiaVZ6mCxO5AjihFrGdImdExbCz/h0T0aMZFNcXJyrv3W6Dc1GxH
	0ybZXFnkxNRjtse4vCFBhXhNoneQ4NM1XS2UvqXK55AT/5FsvjUNGyPEbkorGpismQGVE3Pj3Gz
	gQpTDGFpROymYWmvZGGE/NikIHQLDTz0naM38bgo6Uc0VYSrm8kglPvFI4iNL5NH2clGG2wijLO
	Hsj+aSWH5nQ9kD2i/VDlqwbuCjLM+5zR6nhDJenF5JcVl3PJ6BxsrO/gfe1tsGP/GPNd9Fsz81o
	4DKFCXSnmvZXX/iaC72N679GxHjxPlyv9AAQga+jhwynEVljz4c0o1OtnboTnBQkeHjnb7Ilu4I
	RmhamUQZvwPq2aE88s+aEUGGGmLOSI8P14PKlLXF9BTfPAxzq584YHXL0mKofWWp2lwg0LoipCn
	1ekgGE1RiEurDjybPsdLeWGkzmJNU=
X-Received: by 2002:a05:622a:1dc9:b0:536:353e:8d2a with SMTP id
 d75a77b69052e-55d87fe2e61mr49432961cf.1.1795535175538; Tue, 24 Nov 2026
 07:46:15 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261124-vma-read-lock-mmdrop-async-v1-1-257f99f551de@kernel.org> <awWLCZ-jBjSD7V3M@pedro-suse.tail5790ac.ts.net>
In-Reply-To: <awWLCZ-jBjSD7V3M@pedro-suse.tail5790ac.ts.net>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 24 Nov 2026 07:46:04 -0800
X-Gm-Features: Aa3M54rJps960eQ4ANiw2FEhSY-XIlXfbwKX87yDblku-U5-CQ5DzHJjVlODTLI
Message-ID: <CAJuCfpGk6eYK43Unxo+O4ML5=GM_siZ9owp6oa9fO0ipZXVg-g@mail.gmail.com>
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

On Tue, Nov 24, 2026 at 5:04=E2=80=AFAM Pedro Falcato <pfalcato@suse.de> wr=
ote:
>
> On Tue, Nov 24, 2026 at 12:26:19PM +0000, Lorenzo Stoakes (ARM) wrote:
> > Commit bee9ef4a40a2 ("bpf: switch task_vma iterator from mmap_lock to
> > per-VMA locks") open-codes a lock_next_vma() implementation that does
> > roughly the same thing in bpf_iter_task_vma_find_next(), only without
> > fallback to an mmap_lock.
> >
> > This is because bpf_iter_task_vma_find_next() can be called from
> > non-sleepable contexts.
> >
> > However, lock_vma_under_rcu() gave no guarantee as to which contexts it=
 is
> > safe to be called from, and indeed it turns out this assumption is unsa=
fe.
> >
> > Since commit 9bbffee67ffd ("mm: fix a UAF when vma->mm is freed after
> > vma->vm_refcnt got dropped"), this call chain is possible on x86:
> >
> > lock_vma_under_rcu()
> >   -> vma_start_read()
> >     -> mmdrop()
> >       -> __mmdrop()
> >         -> mm_free_pgd()
> >           -> pgd_free()
> >             -> pgd_dtor()
> >               -> spin_lock(&pgd_lock)
> >
> > Thus, a plain spin_lock() can occur when lock_vma_under_rcu() is
> > called. Since bpf_iter_task_vma_find_next() can be called in softirq
> > context, this can deadlock, for example:
> >
> > pgd_alloc()
> >   -> spin_lock(&pgd_lock)
> >     <softirq>
> >     bpf_iter_task_vma_next()
> >       -> lock_vma_under_rcu()
> >         ...
> >         -> spin_lock(&pgd_lock) [ DEADLOCK ]
> >
> > Alexei Starovoitov also pointed out that a BPF program attached to
> > trace_contention_end() can similarly cause a deadlock:
> >
> >   pgd_alloc()
> >     spin_lock(&pgd_lock)
> >       queued_spin_lock_slowpath()
> >         trace_contention_end()          <- pgd_lock is held
> >           tp_btf/contention_end prog
> >             bpf_iter_task_vma_next()
> >               lock_vma_under_rcu()
> >                 vma_start_read()
> >                   mmdrop(other_mm)      <- last put takes pgd_lock agai=
n
> >
> > Resolve the issue by having vma_start_read() use mmdrop_async() instead=
 of
> > mmdrop() so the work is deferred to a work queue.
> >
> > Make mmdrop_async() an internal mm function, defined in mm/internal.h, =
to
> > avoid abuse elsewhere (kernel/fork.c includes this header, so still ret=
ains
> > access).
> >
> > Commit 0b16f8bed19c ("mm: change vma_start_read() to drop RCU lock on
> > failure") accounted for the fact that the RCU lock had to be dropped fo=
r
> > this operation, which is no longer applicable.
> >
> > For the sake of a backported fix, retain this behaviour, however drop t=
he
> > RCU lock last and remove the now irrelevant comment.
>
> Is there any particular reason for unlocking the RCU comment last? after =
the mmdrop_async().

Yeah, I think moving the RCU unlocking was unnecessary (unlock as soon
as possible is in general advisable) and we could just remove the
comment. Both versions however seem correct to me.

>
> >
> > Reported-by: Chris Mason <mason@kernel.org>
> > Fixes: bee9ef4a40a2 ("bpf: switch task_vma iterator from mmap_lock to p=
er-VMA locks")
> > Cc: stable@vger.kernel.org
> > Link: https://lore.kernel.org/all/DN267JUKDRNS.2VMV07CQ58R4X@gmail.com/
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>
> Acked-by: Pedro Falcato <pfalcato@suse.de>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>
> --
> Pedro
