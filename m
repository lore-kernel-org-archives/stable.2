Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793142698;
	b=yJ9fcwBkKtCitvPIgTXcauepiw7ayhFG5tOia8rjIONnss2PV2SmLIp9hPkE3LQvkRqw
	 dEEa62b1tCEpX8faTwpPlsW4JcIYR+Uv2tZC28FvgeU83xS0b0E9d27SBjS64Ml8JtzUt
	 MA6FgoNGQsSPPWFe1jrRwvf8+QXibVAKkR7ftfAM49teN6B9omXvTCkqYeSaOOqV94FS2
	 RjDuBG3kt1fXhJy3GM0+CkgR2eZZGHTAQj+QcYk/M6XeLR4lSunEVNEZg2MYpgaDTOqZb
	 GFZV8hnqI3zgap1VovgNFssVhUqxkViTMDEv9wpHqiyZIUhAduQn4DAOeHa/3npWM6Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793142698;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=rhl2geudcbOZICdrGNLpkxL+lbiX8RJZUOCOaZhyCBY=;
	b=YBZnLd0U5nvueH6+tGN+cwqFW2qmM8ImuzYi99byeJePs869iogzEwaIDsjMTQSqnbm3
	 v4yuv3q3WKxk97S0c2xdkWj9x+cgHA0zXV6JfZ2elW7T4yZnB4arawwTxh26708yZbEDG
	 Arn8TRBO1dcKJBU2PubJCkVQuRpuSn1GTcAsluB8YCIQT5IUm05j8vVlFSbUQIdW5Oj+O
	 qBlhO6ktJ/Js5eKzDe59YBSiHAyr2MlAM3CLjs06nqxI0BBmIx0BS22xi/w/if+g6+R9/
	 cmMFIuz/KIfOglMnxhwUOJ0h632RyZtqRldwAU6BYnyy3S3celWBczoJKtIqpAu86yg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="V/KUhNH8";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE63E606A31D
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 23:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE63E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=V/KUhNH8
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a018493d57so30255e9.0
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 16:11:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793142696; cv=none;
        d=google.com; s=arc-20260327;
        b=DKItIIA2UJnNqMx5cduYKuJcJTec24PmvSygrSOHZWhChKcSv0cUq4vMsjg/rXMKB+
         DHzZbC2bCq3Wm9b1KE8u16F294T60HxW8QKpiKm99oW0pm2CEHDTa+k1iW23cAw5kWMD
         i8CpvFr432GxLBd28EWb9+0dxDRSlh8JKQTi0DO/6sv44iomcd2CDK2yb89SlQ5jEXgb
         m9qk8WxRGS8NhWs/9ZB6eLPPgnPq/tUplkDUmP3UBi0jithq+rZInF9sss+AoHS4PLE3
         8abPgAOPc+I3XI/jLilJZr+a1rr0LXyeBLC/hofiCIvFkgDJoEEwUXqlsttB73Q+vfxT
         A9lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rhl2geudcbOZICdrGNLpkxL+lbiX8RJZUOCOaZhyCBY=;
        fh=78XxdCbB6KBqjLgra8OAG1UJmsJgyIdDrSsTnL1pdhw=;
        b=AAidKypteEr2wTJ81cI2J9CFJws3/7Lo/TBSkyVA21cOD0atQbCjjCwP8Zjgk1U/dT
         KxIxc2oklhidpDB6ukieVshAg9ysLEVjh0DtW4RB3kPNVrBwbmp6e36kD65ie6nxf6v5
         gtvyWT2hQ/56R/UtpJHPq7lublOzM0gD6WtJyqSULHdb8N6gkUgDOZU9H6gkGvGRjMOU
         YXF/jMBkXFOm3BRWM2v5mXY0mRYOVKIpIxsjxQ2dK4nRPvhwOH4hpUs4u6gsBX4EJnI6
         ou+4fvAWd0hOFOAjLHL4eGTNsRfJKvnXJJ0M8LDt/cJm2Qk0thjruLM57BzHmEHDs33o
         rVKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793142696; x=1793747496; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rhl2geudcbOZICdrGNLpkxL+lbiX8RJZUOCOaZhyCBY=;
        b=V/KUhNH8lmp4ZeEhXIbNWPEuOggqT1b/wg/aPuhHdtm+4T44SfhGggjTgcgxOabpp4
         yBDX8qJ4pYYEeQvEfHhBg9mU93fWD2L1TLETyv6tPbumOn8+H+K2fbscFmpm+Gw7aHsW
         NMZjSt5FQ6hC1bduvDY6NAkIbtj/cvIxb4Dsj1bwb0nP1TwNsCL5ohMPBH6tUi8G2YDk
         QfF0h+EhZ/aFNWxbm4IdDJ5ss5Y3QwDq3Dl0F+lWembf1W2nB0/BaO+PRosrPmTxJJET
         dL6GZ+Y7N4VV/+oyoRSRnZ8nfFdV0jWaRhwFis4soGHTQAKH7aqpDD1uEhbFRxJ9onf3
         laiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793142696; x=1793747496;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rhl2geudcbOZICdrGNLpkxL+lbiX8RJZUOCOaZhyCBY=;
        b=uDtSQaZarWEOIbxjH+kIRLREYyLfm559jwNvobQtpKYOV1pgcLTeVPJwxxCReo1bjj
         31ZEqDdotjMl9/gVWxJ6t+Zx1kSTzyWRYvfXr1qnhR31en9d1BRiCVb5MUxmUn/8fMZd
         wX496vB2WDlQzTStdIhH/0wii/DISf27pI8aVX8Z3mKTkEq1doeMPOr45cduYe280VZw
         TRYE/xMD6i1HFWUTZYaikq1jDFnmDjbm8v4Cx/6+BFjP6MLjcmThX/1r8fwnT0UfW+rq
         SsOOP4E4IQUwVVDwMppn1kowCtXWS2GX7Z9q4UyUN+V9wMU8DJnKhBigPfqxP5LBPbo6
         S60A==
X-Forwarded-Encrypted: i=1; AKwUvBygH/nbdI44tPtRDkTZAGTzxSauSgPk8I63jd6A6TzbXnLBLlc3vzxxBUYfIewCD2Kzgfw+DBs=@vger.kernel.org
X-Gm-Message-State: AFq9FYK8RVP32n6+quczUJVDB/FjW/RNSSyoMFEaj5Wze0MFrK9vlNJy
	+1ZzC2ZUdip08S3jvn0GB/QLsEEX721+CwGqX/ZWRa1tXI9A90KlB0hN5Jvl8Z/5cfpgaR+Eh6L
	WYmTYn9uRuD5lR8blJpnYeQdedY+B0pAqOaRZWBxE
X-Gm-Gg: AYBFou2hgyUMbAKhaLBlBREE2apJEK+wC10DCyawejP3Zhq+LiC30WLof0R0RwSbWF/
	WQZmrMWJCXt4Q9mFPnbcS+bPvLmzMnHK14Mal7jbIIndZQWqnk6QdJifuoz4uZR95LGq9O56gvA
	bHPI1biAwf2zmKQsZxv2cIVqT53BJH2763S4bWTzANTSxbFnaWmgNWZIvaff4wCubh83LR17JYa
	X/NI8FI1XGmi4r9/IlPI96mKxv/GxYovJSURgHEfyrs/TfGz9OzIJojfFSuN1o5JPIzX8zhv8D7
	Zbxklrt+jvf+OhKkMqA9n9486a3lvCDsYY60IdsIK5h3xiLd9ksR+Ea2rrvWaHRPYLGi5zm9An/
	vLdM3sfRPN/wRe2/dos8ioWbacl/Kd+Uh3NNhWy2KriZD6jGwB4LVuNESKAR0kLP2zaLEO62JJ2
	E/ZFb8yTukZiUS/IqYkECfyHuZN18/ibvxxn6UHf4HpMGb
X-Received: by 2002:a05:600c:3227:b0:4a1:eb11:489d with SMTP id
 5b1f17b1804b1-4a96036cebemr122195e9.16.1793142695725; Tue, 27 Oct 2026
 16:11:35 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023222313.3979455-1-tjmercier@google.com>
 <DF7DBE4B-E0BA-423B-BDA7-DB07D1C9E564@linux.dev> <CABdmKX3-XKWXwZe5f=VwZeSuKH6xM0dsK7TvY7u9B1hgaPOm4g@mail.gmail.com>
In-Reply-To: <CABdmKX3-XKWXwZe5f=VwZeSuKH6xM0dsK7TvY7u9B1hgaPOm4g@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 27 Oct 2026 16:11:23 -0700
X-Gm-Features: AclHuK84iU4LGcBkObjk5TD5SSpvHPSR8JadqDMoPlQEagyX_MXN3xEU-MBo_ZY
Message-ID: <CABdmKX3DEDwgO_wj3JDYvx15FYPKGCav8HKvHC-u_EHdGhWwLg@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: fix NULL pointer deref in
 high_work_func() on dying memcg
To: Muchun Song <muchun.song@linux.dev>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, zhengqi.arch@bytedance.com, akpm@linux-foundation.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 10:42=E2=80=AFAM T.J. Mercier <tjmercier@google.com=
> wrote:
>
> On Mon, Oct 26, 2026 at 7:42=E2=80=AFPM Muchun Song <muchun.song@linux.de=
v> wrote:
> >
> >
> >
> > > On Oct 24, 2026, at 06:23, T.J. Mercier <tjmercier@google.com> wrote:
> > >
> > > When memory.high is exceeded in non-task context, try_charge_memcg()
> > > schedules memcg->high_work without taking a CSS reference on the memc=
g,
> > > and high_work_func() invokes reclaim_high() without pinning the memcg=
.
> > >
> > > Before commit f1cf8d2f36dc ("mm: memcontrol: eliminate the problem of
> > > dying memory cgroup for LRU folios"), memory usage above memory.high
> > > kept the memcg's refcount non-zero. With reparenting, folios and objc=
gs
> > > charged to a child memcg are reparented to its parent in
> > > mem_cgroup_css_offline(), leaving the offlined child's memory usage
> > > permanently above its memory.high even after its last reference is
> > > dropped.
> > >
> > > cancel_work_sync(&memcg->high_work) only runs at the end of teardown =
in
> > > mem_cgroup_css_free(), so high_work_func() can start or still be runn=
ing
> > > reclaim_high() after mem_cgroup_css_released() or shrink_many() has
> > > called lru_gen_release_memcg() and unhashed lruvec->lrugen.list. This
> > > causes lru_gen_rotate_memcg() to dereference a NULL pprev pointer.
> > >
> > > Fix this by acquiring a reference with css_tryget_online() in
> > > high_work_func() before calling reclaim_high(), and by resetting
> > > memory.high and swap.high to PAGE_COUNTER_MAX in
> > > mem_cgroup_css_offline() so that charges via references on an offline=
d
> > > memcg do not trigger high_work on the dead child or skip checking liv=
e
> > > ancestors in try_charge_memcg().
> > >
> > > Oops: general protection fault, probably for non-canonical address 0x=
dffffc0000000000: 0000 [#1] SMP KASAN NOPTI
> > > KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007=
]
> > > CPU: 1 UID: 0 PID: 27 Comm: kworker/1:0 Tainted: G    B   W          =
 7.3.0-rc5-g2bba28e98578 #284 PREEMPT(full) <- Taint from lru_gen_rotate_me=
mcg() VM_WARN_ON_ONCE
> > > Tainted: [B]=3DBAD_PAGE, [W]=3DWARN
> > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-de=
bian-1.17.0-1 04/01/2014
> > > Workqueue: events high_work_func
> > > RIP: 0010:lru_gen_rotate_memcg+0x1a3/0xe90
> > > Code: fd 7f 09 45 84 ed 0f 85 64 0c 00 00 48 89 cf c6 83 6a 07 00 00 =
00 48 c1 ef 03 88 83 69 07 00 00 48 b8 00 00 00 00 00 fc ff df <80> 3c 07 0=
0 0f 85 ec 0b 00 00 48 89 31 40 f6 c6 01 0f 85 4e 00
> > > RSP: 0018:ffa00000001ef4c8 EFLAGS: 00010046
> > > RAX: dffffc0000000000 RBX: ff1100000779e440 RCX: 0000000000000000
> > > RDX: 0000000000000001 RSI: ff1100000779b9b0 RDI: 0000000000000000
> > > RBP: ff110000bffd8e40 R08: 0000000000000000 R09: ff1100000779ebb8
> > > R10: ff1100000779ebb0 R11: 0000000000000246 R12: 0000000000000000
> > > R13: 0000000000000000 R14: ffa00000001efb30 R15: 0000000000000002
> > > FS:  0000000000000000(0000) GS:ff1100011c0e7000(0000) knlGS:000000000=
0000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 000000000251ac88 CR3: 0000000009d6c000 CR4: 0000000000751ef0
> > > PKRU: 55555554
> > > Call Trace:
> > > <TASK>
> > > ? read_ctrl_pos+0x22f/0x3f0
> > > shrink_lruvec+0x16cb/0x1b80
> > > ? ret_from_fork_asm+0x1a/0x30
> > > ? lapic_next_event+0x15/0x20
> > > ? clockevents_program_event+0x2bb/0x6f0
> > > ? lapic_next_event+0x15/0x20
> > > ? __pfx_shrink_lruvec+0x10/0x10
> > > ? __pfx_clockevents_program_event+0x10/0x10
> > > ? _raw_spin_lock+0x84/0xe0
> > > ? __pfx__raw_spin_lock+0x10/0x10
> > > ? kasan_save_stack+0x30/0x50
> > > ? psi_group_change+0x381/0x740
> > > ? __pfx_sched_clock_cpu+0x10/0x10
> > > ? save_fpregs_to_fpstate+0xc4/0x2c0
> > > ? finish_task_switch.isra.0+0x1de/0xac0
> > > ? __schedule+0xf62/0x42c0
> > > ? __pfx___schedule+0x10/0x10
> > > ? __pfx___irq_work_queue_local+0x10/0x10
> > > ? shrink_node+0x626/0x31e0
> > > shrink_node+0x626/0x31e0
> > > ? ring_buffer_unlock_commit+0x11d/0x5c0
> > > ? kswapd_clear_hopeless+0xa0/0x150
> > > ? __pfx_shrink_node+0x10/0x10
> > > ? 0xffffffffc0000095
> > > do_try_to_free_pages+0x255/0x13b0
> > > ? ring_buffer_unlock_commit+0x11d/0x5c0
> > > ? reclaim_high+0x10a/0x1b0
> > > try_to_free_mem_cgroup_pages+0x1f9/0x5a0
> > > ? __pfx_try_to_free_mem_cgroup_pages+0x10/0x10
> > > ? irqentry_exit+0xc6/0x670
> > > reclaim_high+0x10a/0x1b0
> > > ? __pfx_reclaim_high+0x10/0x10
> > > ? process_one_work+0x5ff/0x1030
> > > ? __pfx_high_work_func+0x10/0x10
> > > process_one_work+0x6e2/0x1030
> > > ? __pfx___schedule+0x10/0x10
> > > ? __pfx_process_one_work+0x10/0x10
> > > worker_thread+0x422/0xbb0
> > > ? __pfx_worker_thread+0x10/0x10
> > > kthread+0x2cd/0x3a0
> > > ? recalc_sigpending+0x15c/0x200
> > > ? __pfx_kthread+0x10/0x10
> > > ret_from_fork+0x368/0x590
> > > ? __pfx_ret_from_fork+0x10/0x10
> > > ? __switch_to+0x588/0xf50
> > > ? __pfx_kthread+0x10/0x10
> > > ret_from_fork_asm+0x1a/0x30
> > > </TASK>
> > >
> > > Fixes: f1cf8d2f36dc ("mm: memcontrol: eliminate the problem of dying =
memory cgroup for LRU folios")
> >
> > Hi T.J.,
> >
> > Thanks for fixing this.
> >
> > I have one question about the Fixes tag.
> >
> > The changelog says that, before f1cf8d2f36dc, memory usage above
> > memory.high kept the memcg reference count non-zero. This is true for
> > LRU folios: before that commit, each charged LRU folio held a CSS
> > reference until it was uncharged.
> >
> > However, I wonder whether objcg-based kmem already provided a reachable
> > path before f1cf8d2f36dc.
> >
> > In particular, BPF alloc_bulk() mostly runs from irq_work. It obtains a
> > temporary memcg reference from a persistent objcg, uses set_active_memc=
g()
> > while performing __GFP_ACCOUNT allocations, and drops the temporary
> > reference after the allocation. The charge can therefore queue
> > memcg->high_work in non-task context without transferring a CSS
> > reference to the work item.
> >
> > If this races with memcg offlining, objcg reparenting can redirect the
> > objcg to the parent while the old child's page-counter usage remains
> > above memory.high. Once the temporary CSS reference is dropped,
> > mem_cgroup_css_released() can call lru_gen_release_memcg() before the
> > queued high_work runs. The worker can then enter reclaim_high() and
> > rotate an already removed lrugen.list.
> >
> > This path appears to have all the required pieces after:
> >
> >   e4dde56cd208 ("mm: multi-gen LRU: per-node lru_gen_folio lists")
> >
> > Commit 6867c7a33206 later changed the release operation to
> > hlist_nulls_del_init_rcu(), which explains the exact NULL pprev seen in
> > the reported crash. Before that, the same invalid second deletion would
> > instead encounter LIST_POISON2.
> >
> > So f1cf8d2f36dc clearly broadens the problem to ordinary LRU folios, bu=
t
> > I am not very sure it is the first commit after which the underlying ra=
ce is
> > reachable.
> >
> > Is there an additional lifetime guarantee that prevents the pre-f1cf
> > objcg/kmem path above? If no, would the following be more appropriate?
> >
> > Fixes: e4dde56cd208 ("mm: multi-gen LRU: per-node lru_gen_folio lists")
> >
> > Thanks,
> > Muchun
>
> Hi Muchun,
>
> Everything you said sounds correct to me. I don't think there's
> anything preventing kmem from keeping the memcg above high while the
> refcount hits 0, and hitting the same problem in
> lru_gen_rotate_memcg() from lru_gen_shrink_lruvec().
>
> So using Fixes: e4dde56cd208 ("mm: multi-gen LRU: per-node
> lru_gen_folio lists") sounds good to me.
>
> Thanks,
> T.J.

I was able to get a reproduction on e4dde56cd208. Fortunately this
patch applies cleanly on e4dde56cd208, so I expect the stable
backports to be straightforward.

general protection fault, probably for non-canonical address
0xfbd59c0000000024: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: maybe wild-memory-access in range [0xdead000000000120-0xdead00000000=
0127]
CPU: 1 PID: 37 Comm: kworker/1:1 Not tainted 6.2.0-rc4-00108-ge4dde56cd208 =
#1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.17.0-debian-1.17.0-1 04/01/2014
Workqueue: events high_work_func
RIP: 0010:lru_gen_rotate_memcg+0x147/0xef0
Code: 49 c1 ea 03 41 80 3c 3a 00 0f 85 a5 09 00 00 48 89 f7 4c 8b 93
08 07 00 00 48 c1 ef 03 48 89 fa 48 bf 00 00 00 00 00 fc ff df <80> 3c
3a 00 0f 85 2a 07 00 00 4c 89 16 41 f6 c2 01 0f 85 72 00
RSP: 0018:ffa00000002a75e0 EFLAGS: 00010206
RAX: ff11000008d46701 RBX: ff11000008d46000 RCX: 0000000000000000
RDX: 1bd5a00000000024 RSI: dead000000000122 RDI: dffffc0000000000
RBP: ff110000bfe54000 R08: ff11000008d46708 R09: ff11000008d46710
R10: ff11000009a5a708 R11: 0000000000000000 R12: 0000000000000006
R13: 0000000000000004 R14: 1ff4000000054ee4 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ff110000a3480000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000007d5c000 CR4: 0000000000751ee0
PKRU: 55555554
Call Trace:
 <TASK>
 ? reset_ctrl_pos+0x10f/0x460
 shrink_lruvec+0x19e0/0x2000
 ? kasan_set_track+0x25/0x30
 ? __kasan_slab_alloc+0x66/0x80
 ? kmem_cache_alloc+0x165/0x310
 ? __kernfs_new_node+0xd3/0x590
 ? __kernfs_create_file+0x2d/0x280
 ? sysfs_add_file_mode_ns+0x12b/0x3a0
 ? internal_create_group+0x286/0x940
 ? internal_create_groups+0x84/0x110
 ? really_probe+0x223/0x690
 ? unwind_next_frame+0xa9a/0x2040
 ? arch_stack_walk+0x7a/0x110
 ? unwind_next_frame+0xa9a/0x2040
 ? arch_stack_walk+0x7a/0x110
 ? __pfx_shrink_lruvec+0x10/0x10
 ? preempt_count_add+0x83/0x180
 ? unwind_next_frame+0xb2/0x2040
 ? unwind_next_frame+0x212/0x2040
 ? ret_from_fork+0x2c/0x50
 ? __pfx_stack_trace_consume_entry+0x10/0x10
 ? arch_stack_walk+0xa2/0x110
 ? sched_clock_local+0x132/0x210
 ? __pfx_sched_clock_local+0x10/0x10
 ? unwind_next_frame+0x212/0x2040
 ? __pfx_shrink_slab+0x10/0x10
 ? sched_clock_cpu+0x232/0x2c0
 ? __pfx_sched_clock_local+0x10/0x10
 ? __pfx_sched_clock_cpu+0x10/0x10
 ? mem_cgroup_iter+0x269/0x600
 ? vmpressure+0x30/0x3b0
 shrink_node+0xb39/0x26a0
 ? __pfx_shrink_node+0x10/0x10
 ? kasan_save_stack+0x42/0x60
 ? ring_buffer_lock_reserve+0x2fb/0xe30
 do_try_to_free_pages+0x31a/0x1880
 ? __pfx_do_try_to_free_pages+0x10/0x10
 try_to_free_mem_cgroup_pages+0x282/0x5f0
 ? try_to_free_mem_cgroup_pages+0x4/0x5f0
 ? reclaim_high.constprop.0+0x191/0x250
 ? __pfx_try_to_free_mem_cgroup_pages+0x10/0x10
 ? try_to_free_mem_cgroup_pages+0x9/0x5f0
 reclaim_high.constprop.0+0x191/0x250
 ? __pfx_reclaim_high.constprop.0+0x10/0x10
 ? __pfx_high_work_func+0x10/0x10
 process_one_work+0x641/0x1010
 worker_thread+0x424/0xec0
 ? __kthread_parkme+0x89/0x160
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x26c/0x300
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x2c/0x50
 </TASK>
