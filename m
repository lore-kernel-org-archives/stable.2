Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793225573;
	b=g8em6quR7XLkXYrpXU9NbOgLvVAEjpcXPggCh8LSDVUMgsnKTvSow9dxFjDTzngy91BS
	 ttBVbD0adukmjcVqqXK+eY2g20nDZe88BtEvUEhdyU/lg0BB1ngmylq5L1LS5WsB//d5q
	 3jjUyE79pu0Gt12DW8exw4d/TW+VZhtj1WJ3+6Xagku1ioicp5pp4QDhwv4KpU6fjAa3j
	 vgRcNDOeBx5D766PiBJ0C1PrqyhvCQ45CRxO5byTxpaZh80Mas5fCAXMCxcewx5SU62Cu
	 l8CbLJhpNXtVcuEM9VpDhwb+vgIV2l/lwREwjUM8EPijWWEcvFHgS6+pU4cuYD8H+aQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793225573;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=E156o5IaTei0VRN5zZ4yWq6/WZqYeNZwAw/ChZTmR7E=;
	b=lr4qRyvm4n4P2hRxSt/pKenEkfBI/BAs0TJnSa0QTTt+IuO8XOWFk7q9p9OwvSuDmRsd
	 F92YABmacqS/mVUaBNpTSDWsbiNmIS/6mnmNg5bAgWWCkeQ36qpI1Pw5nzU8a0bNYRuYi
	 osAD6I6TDJkyMkXbqMjq1E4ZPhG68bCv+nL9JVHvbfzrn1ELN218L7PHuvlzOs9Vh3yQp
	 YhpSW+pZAIVqUA12RWFXlEbEw4eSEXTnbk/j0QTw6Ybwa7KoYOZC04eWFcbap9kJBKnWn
	 S6/QbJI/z8UaBnv+bOgGBRxN/mZgWfobYZsgnNFBRXNBvSy1vCL8NzxBaA6BU2y9Ijg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmpxchg.org;
	spf=pass smtp.mailfrom=cmpxchg.org;
	dkim=pass header.d=cmpxchg.org header.i=@cmpxchg.org header.a=rsa-sha256 header.s=google header.b=AM04A4qO;
	arc=none smtp.remote-ip=209.85.128.182
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1C3606A31A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 22:12:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D1C3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cmpxchg.org header.i=@cmpxchg.org header.a=rsa-sha256 header.s=google header.b=AM04A4qO
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8b0d63f60bcso13692317b3.3
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 15:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1793225570; x=1793830370; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E156o5IaTei0VRN5zZ4yWq6/WZqYeNZwAw/ChZTmR7E=;
        b=AM04A4qOLrlcOVWw3KrK8YFK+PrUB0vtxwZnAtSRPUbk/FywVD1ne/k7xP0AnlzK9a
         JBB6h67eMlNKk5kNvv7S76DvcgzLTJyVBaYr01whGdCUH2yMyrJzg3RAnFAIOe2/6up4
         zOei7YLrH2JDFLrEze6lIJyv/1FystNvMkf+FLihXpBfNwzyqhqDaFQtUgUo1ESK5ozI
         mWZaaBuL/4+9eFl4kGkLf0b+Nnu/zABAcuy/XxGTq8tRVwVliUbY07cLeWIGvaDS3Hla
         Aw9QZN+5yhjK+SDlZ3z0DzUpNZRuizXCpigOginI/ZNnEcKVYDAPPzO2DvhIv1FmOz10
         uXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793225570; x=1793830370;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E156o5IaTei0VRN5zZ4yWq6/WZqYeNZwAw/ChZTmR7E=;
        b=uKgdhO0SPGWIfs5IVb9BvzlVrpww1OO9HR4NUgZ3v7Ge7ltGt6fFGrc8PNqW6l1L51
         wlhqA35fVkewnFBbOi7Wiww84LwdCXb6ktbnI6FSR2zTJKgvbQ4YZhw21ICueQaXOhvA
         mDr1LQ/IQs/1cY66mDsqiRFdYfkpWE2NM+0HU+gsfX+ptOJ4LX5MH1WvivHnlVzHr5qr
         hbsIF4deIOUi5WirkWQLMBwzAtYjyzzQ4ALjWtP9Cc4UulCB4V6tbJYUC/iPY6mpbpye
         Oe8Pg/9TlxBX/CfiXzwX4mWHeL3QNfZlJwhN6Y8svSK6+AK4JIQ96F66FbpEFrM31pmq
         a7Qw==
X-Forwarded-Encrypted: i=1; AKwUvBy6Yi6zC7kyiUFOTno8vWh2/eXmDWKytyKND0PNPlMJOTzvQWbR3Z0ac2d4aD9xKRd2FF+L0Ck=@vger.kernel.org
X-Gm-Message-State: AFq9FYILsUEweuOaNtvX2NmeM/NbU+CiCRCWhd74FvQ9GKeZnVWJSDWw
	IsoJzBA9kpP9gqL9LOrrpROzDmMcA9WzAXnU4NvuBTExRA/NBjuiGzmXus4jQKJz1N4=
X-Gm-Gg: AYBFou2oOLEABcsw75uDN46gbdmPdEBL2gZIQPoHBx6EKXgLiv5kZSwF/5n4pSUD6Bx
	bO/PuyDKa5I674SStB1tsBr7xqXu0RKdCo8N8y4RDbKKIsi4EVXdohHJKsq8cvl9LYwkUrMtmKo
	Iy99/zrg0QGLvQPWgrDfA413OE3K2UC9yIOlvrk/Ceymwdr8C86e2d5JDhFeuEbFAbSKhMhZYBC
	fhc2cbmoVY15rOoKd2pAHoHh/6LmrhuLPFu7Crpo0x5b2YZMDB5i7HE9N97eeqUWz6QjpGoE2tN
	G9QjOrKHcfGFY9qKitj/9XgbYWOOgCbMK16q9BUheVtzW7aT+IOrq8W9Bqzstb0/xl0kXTpfPVe
	BqHRhoAjeFC52mhIYCzXwcEmUzmFLzdmPxHjWd03zNAUwiJFVC46OEIpYnUiEaVCv/YrwDaijSf
	r+SnINySg636nDD20J8Y60e4L9IJ3mhI8Ea30fZYW7F8pQWTWo5bsG8DVBscbFXUgE+nHtG3G0P
	U0kg9F7mFp6vCD+EEohATcgB6+V78oKgyORs13ejVDd+b7MGSyn74lFHsYFShiJliFhkVJGmcxi
	YNmiiv/EXJnOGR9KbesnlH3fbE6b
X-Received: by 2002:a05:690c:9e:b0:891:faab:ff1e with SMTP id 00721157ae682-8b1b595b1fdmr25465837b3.4.1793225570125;
        Wed, 28 Oct 2026 15:12:50 -0700 (PDT)
Received: from localhost ([2605:8600:200:14e3:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b19e5b40e0sm36335447b3.26.2026.10.28.15.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 15:12:49 -0700 (PDT)
Date: Wed, 28 Oct 2026 18:12:45 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, zhengqi.arch@bytedance.com,
	akpm@linux-foundation.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] mm: memcontrol: fix NULL pointer deref from
 high_work_func() on dying memcg
Message-ID: <auJzXV3nnPZA5GSr@cmpxchg.org>
References: <20261028183537.605854-1-tjmercier@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028183537.605854-1-tjmercier@google.com>

On Wed, Oct 28, 2026 at 11:35:37AM -0700, T.J. Mercier wrote:
> When memory.high is exceeded in non-task context, try_charge_memcg()
> schedules memcg->high_work without taking a reference on the memcg, and
> high_work_func() invokes reclaim_high() without pinning the memcg.
> 
> cancel_work_sync(&memcg->high_work) only runs at the end of teardown in
> mem_cgroup_css_free(), so high_work_func() can start or still be running
> reclaim_high() after mem_cgroup_css_released() or shrink_many() has
> called lru_gen_release_memcg() and unhashed lruvec->lrugen.list. If
> reclaim tries to rotate the memcg, lru_gen_rotate_memcg() dereferences a
> NULL pprev pointer.
> 
> With obj_cgroup reparenting, introduced in commit bf4f059954dc ("mm:
> memcg/slab: obj_cgroup API"), objects charged to a child memcg are
> reparented to its parent in mem_cgroup_css_offline() instead of holding
> a reference on the child until uncharged. Subsequent uncharges of those
> objects go to the parent, which can leave the child's memory use
> permanently above its high limit, so any later charge on the offlined
> memcg in non-task context schedules high_work.
> 
> This problem was first exposed when commit e4dde56cd208 ("mm: multi-gen
> LRU: per-node lru_gen_folio lists") introduced the memcg LRU, and was
> later widened from kernel memory to LRU folios when
> commit f1cf8d2f36dc ("mm: memcontrol: eliminate the problem of dying
> memory cgroup for LRU folios") converted LRU folios to use obj_cgroup
> reparenting.
> 
> Fix this by acquiring a reference with css_tryget_online() in
> high_work_func() before calling reclaim_high(), and by resetting
> memory.high and swap.high to PAGE_COUNTER_MAX in
> mem_cgroup_css_offline() so that charges via references on an offlined
> memcg do not trigger high_work on the dead child or skip checking live
> ancestors in try_charge_memcg().
> 
> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN NOPTI
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> CPU: 1 UID: 0 PID: 27 Comm: kworker/1:0 Tainted: G    B   W           7.3.0-rc5-g2bba28e98578 #284 PREEMPT(full)
> Tainted: [B]=BAD_PAGE, [W]=WARN <- Taint from lru_gen_rotate_memcg() VM_WARN_ON_ONCE
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
> Workqueue: events high_work_func
> RIP: 0010:lru_gen_rotate_memcg+0x1a3/0xe90
> Call Trace:
>  <TASK>
>  ? read_ctrl_pos+0x22f/0x3f0
>  shrink_lruvec+0x16cb/0x1b80
>  ? ret_from_fork_asm+0x1a/0x30
>  ? lapic_next_event+0x15/0x20
>  ? clockevents_program_event+0x2bb/0x6f0
>  ? lapic_next_event+0x15/0x20
>  ? __pfx_shrink_lruvec+0x10/0x10
>  ? __pfx_clockevents_program_event+0x10/0x10
>  ? _raw_spin_lock+0x84/0xe0
>  ? __pfx__raw_spin_lock+0x10/0x10
>  ? kasan_save_stack+0x30/0x50
>  ? psi_group_change+0x381/0x740
>  ? __pfx_sched_clock_cpu+0x10/0x10
>  ? save_fpregs_to_fpstate+0xc4/0x2c0
>  ? finish_task_switch.isra.0+0x1de/0xac0
>  ? __schedule+0xf62/0x42c0
>  ? __pfx___schedule+0x10/0x10
>  ? __pfx___irq_work_queue_local+0x10/0x10
>  ? shrink_node+0x626/0x31e0
>  shrink_node+0x626/0x31e0
>  ? ring_buffer_unlock_commit+0x11d/0x5c0
>  ? kswapd_clear_hopeless+0xa0/0x150
>  ? __pfx_shrink_node+0x10/0x10
>  ? 0xffffffffc0000095
>  do_try_to_free_pages+0x255/0x13b0
>  ? ring_buffer_unlock_commit+0x11d/0x5c0
>  ? reclaim_high+0x10a/0x1b0
>  try_to_free_mem_cgroup_pages+0x1f9/0x5a0
>  ? __pfx_try_to_free_mem_cgroup_pages+0x10/0x10
>  ? irqentry_exit+0xc6/0x670
>  reclaim_high+0x10a/0x1b0
>  ? __pfx_reclaim_high+0x10/0x10
>  ? process_one_work+0x5ff/0x1030
>  ? __pfx_high_work_func+0x10/0x10
>  process_one_work+0x6e2/0x1030
>  ? __pfx___schedule+0x10/0x10
>  ? __pfx_process_one_work+0x10/0x10
>  worker_thread+0x422/0xbb0
>  ? __pfx_worker_thread+0x10/0x10
>  kthread+0x2cd/0x3a0
>  ? recalc_sigpending+0x15c/0x200
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork+0x368/0x590
>  ? __pfx_ret_from_fork+0x10/0x10
>  ? __switch_to+0x588/0xf50
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork_asm+0x1a/0x30
>  </TASK>
> 
> Fixes: e4dde56cd208 ("mm: multi-gen LRU: per-node lru_gen_folio lists")
> Cc: stable@vger.kernel.org
> Signed-off-by: T.J. Mercier <tjmercier@google.com>

Hrm, yes I suppose the work itself keeps the memcg allocated, but not
from going deep into the destruction sequence. I was briefly wondering
whether mglru shouldn't move its callback from css_released into
css_free, but I think your fix is more robust after all: don't send a
barely allocated memcg down the reclaim stack.

The _online variant of the tryget seems somewhat unnecessary. There is
no real harm in reclaiming an offline group - and it was the standard
way, before reparenting, to garbage collect an offline group with
lingering pages. With the updated Fixes, this would look odd in
backports to kernels without reparenting. The PAGE_COUNTER_MAX reset
would also cause reclaim_high to bail.

So I wonder if css_tryget() would be simpler and just as correct. But
no strong feelings either way:

Reviewed-by: Johannes Weiner <hannes@cmpxchg.org>
