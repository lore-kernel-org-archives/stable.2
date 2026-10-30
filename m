Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793377889;
	b=s9KTB5+fGpY81H9fnyjZLMs+LU+J2U4/Qwl79s/b9bIzC7CpfWYPZF1AluVm5ehoFkCs
	 0mRvcdzf0bNMS3C/XZoO5v8g3UDXWX4xejFfnCpH0Phl2GVOR0NtccprkgqOoCmgsVnko
	 OwcHQrAUxjxH2qAZiU/inu88+VMSm5q0qLiGiuyT+uWmBTveMLb4DNzU2pAT4eNc67507
	 2DHOLb+5tcbQKhAfOxQ439FykhSRV9BEl0Tt5wu+lH+n5nM5W0UmnvWCKeo61oDdfo2KY
	 74a61kX8lOVd+WbSYBrmKMbA0ZzUeGO2DTkKPxUXfrJ/QTEIiOARvVqpy+j76/anSXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793377889;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=trsHnVMI6YDWj7rsoQPF0JN2z6GWW+nTgXWERqdG0yk=;
	b=G+QAe8naeJ6YJ3VfSulSVWRSKSg1zCJbu7R/0gQV19hTB8UoK+hfbNAAgxgQHqCiKaXZ
	 9/pXS0Kz/jtNftr2U49FUY2OkR+ZGZV+8Vod4Dhk/eGeKpzuV909XIgzvkj0dZXmBpjR0
	 npbOWWrUKnrXR5JI9qujl2Z+xiyfnEtfgqDH0U4AIELUACsvhuod6V+PN2UzkKExFW0F8
	 i8lL6g5vRJXJ+tixMxLX5oqP6mme1gJ2hvH2fyhQO2qzQsArB/PE078gIqtLfFE9qYWZe
	 4U0kOPa1ZUFTFla7j3pcdx5s2EKPWFSpNFmVfcGEUgA1raOOZdO20dKKiKQcy+jHNAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=GEHo4ZEB;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36DB606A329
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 16:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E36DB606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=GEHo4ZEB
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48e6eb21a8fso405174f8f.1
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 09:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1793377887; x=1793982687; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=trsHnVMI6YDWj7rsoQPF0JN2z6GWW+nTgXWERqdG0yk=;
        b=GEHo4ZEBbPgIqvKH/esYl4bKEwIgrqYul6cG5ju2hvDLzsBHXTbzLIiQof86MeshRT
         0ccaU+Crjup3egqCgGqPwbBMF/SS5dnC+03U0HRLqdK8p6QCiKO7dEQFBlnPlS0xfXZj
         SbBbAE9WGm2wyHttP9/9yCtzN9YFhBUPOdvJIRMwxZgFLqcwzm8jmeYRExcBIGXaXWwk
         uB6rnPnnxrsmdrLUEg7DRr9LI7bOjPuFmI3t7aMuh6GeX/gg0Fy+aG4w8iHa64aeeDb4
         3y1LRVwrhxbt2pHJ0H8U9bIWcLF8FU3QjUR3HvgyEZMQuQS9JcJoYOOZ7s6gXaykSEdc
         yZvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793377887; x=1793982687;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=trsHnVMI6YDWj7rsoQPF0JN2z6GWW+nTgXWERqdG0yk=;
        b=CKSAgDr1YtE3CDgrGTpGFGp+FZNwP2Bi54j+xl71/cx0q/QR3TkPDVu/Jt+7cB2AxR
         OHq0z3ZUo6v8qOclGi2wrPsxa1/XJ9aIDSpWUqW0IHNtv9M6nIkpSiFlSN2QUrK4mZNJ
         x6wOH+4+GFMS/dGMGPaDV9+2JPG29qHvC0vDntEgniTvRYQS8k8taMJ22cecVXS8mQ98
         dUkxsmsc+kEEayRtjhZmIz3Bh+Gzo6qwaOx7KLa/PIK/ylGtUO63g18egtjLzU5lMvEf
         1i3TAZTz17q7HBhN4hWhumpEq49oNWJXsLB5335kDOrQkO25fxopD9DQPtvB9v8qKEMN
         c5fg==
X-Forwarded-Encrypted: i=1; AKwUvBwIDCh6iC3wGy5H1ojfeGDss2srjmEM8FZWNBCL6OfX2nw68FZ5xS+rXIdi1YBI1MEO07OAUP4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKyPKxJNE2NPRppYpm2FqoqWr3KNNi6lzCR30EzPvLm1AjqBeax
	I/EG9Dn2/RITk81X+ZivJO9ddcVeme70zxqlfZL/QBx6Emmnte6tfcxNtqK5M+3mmOI=
X-Gm-Gg: AYBFou0c+U4gh5U/+s8AChiEfteYHm64lqqvLxSWb91D+K2ybE9hy63JJFLnGsmVYon
	cvZiQeB8/92d+pNM7cQGLELcgA6vTPw0DM0B6Qz+FkupToxPmbap2mpF7htDxfeNoZYw9xwdeLQ
	ZJ0TavRe0Y+i2olPG2+rJzO+pQWDfcNrZRtNWnk3kZtgHWmhiWrDFqYpCz+QsyTt2g7ovvSH7Lv
	svYPe7qce3AImwwj7YokK22cAQ5F6Kcte09JsztGUpPRAss6OZCI0su3iXduV4xI5p/7OQrUGBJ
	ZsT4y8MHlHwigg4Q5C+dwnbgcpebxQQKYc99Men5PyvbXrHS81pdFp1yL37VM9yIrBpQOX10JAX
	RPpUdBnxFJBu+Uxt/y5pn2avqK4WXlkIehfTHxKM7lkSPt+L3eEvOXM4NxispYHClc3FWbohlFr
	0ax22Hs/zSpsXYcBBZCCgdZBSZOykZQRDhJU5rhQ6Mko+qNVkrGOtoI1WSjGXe5qpErU60eIjdq
	mx1e9MOVPpJ9dfdktGppUX2KEJmFK38bFPbwUAGpEBRqnt8elpgq2MAsP20jjwDJst8B+r+AkV5
	I6i+Wi1fapQ1gPcmbuRzyaH0n8L4spCD31NNXxC5dUJ2DtFVjjlci8K/CgODXyxK
X-Received: by 2002:a05:6000:2282:b0:48d:f14a:9188 with SMTP id ffacd0b85a97d-48e73851611mr3804299f8f.17.1793377887133;
        Fri, 30 Oct 2026 09:31:27 -0700 (PDT)
Received: from localhost (109-81-92-234.rct.o2.cz. [109.81.92.234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b728ddsm4025629f8f.9.2026.10.30.09.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 09:31:26 -0700 (PDT)
Date: Fri, 30 Oct 2026 17:31:25 +0100
From: Michal Hocko <mhocko@suse.com>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: hannes@cmpxchg.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, zhengqi.arch@bytedance.com,
	jp.kobryn@linux.dev, akpm@linux-foundation.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] mm: memcontrol: fix NULL pointer deref and UAF from
 high_work_func() on dying memcg
Message-ID: <auTGXWh2uGK_slxF@tiehlicka>
References: <20261029201858.2932905-1-tjmercier@google.com>
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
In-Reply-To: <20261029201858.2932905-1-tjmercier@google.com>

On Thu 29-10-26 13:18:58, T.J. Mercier wrote:
> When memory.high is exceeded in non-task context, try_charge_memcg()
> schedules memcg->high_work without taking a reference on the memcg, and
> high_work_func() invokes reclaim_high() without pinning the memcg.
> 
> With obj_cgroup reparenting, introduced in commit bf4f059954dc ("mm:
> memcg/slab: obj_cgroup API"), objects charged to a child memcg are
> reparented to its parent in mem_cgroup_css_offline() instead of holding
> a reference on the child until uncharged. Subsequent uncharges of those
> objects go to the parent, which can leave the child's memory use
> permanently above its high limit, so any later charge on the offlined
> memcg in non-task context schedules high_work. This was later widened
> from kernel memory to LRU folios when commit f1cf8d2f36dc ("mm:
> memcontrol: eliminate the problem of dying memory cgroup for LRU
> folios") converted LRU folios to use obj_cgroup reparenting.
> 
> cancel_work_sync(&memcg->high_work) only runs at the end of teardown in
> mem_cgroup_css_free(), so high_work_func() can start or still be running
> reclaim_high() after mem_cgroup_css_released() or shrink_many() has
> called lru_gen_release_memcg() and unhashed lruvec->lrugen.list. If
> reclaim tries to rotate the memcg, lru_gen_rotate_memcg() dereferences a
> NULL pprev pointer. This issue is specific to MGLRU and was introduced
> with the memcg LRU in commit e4dde56cd208 ("mm: multi-gen LRU: per-node
> lru_gen_folio lists").
> 
> With either traditional LRU or MGLRU, css_free_rwork_fn() calls
> css_rstat_exit() which frees per-CPU rstat data before calling
> mem_cgroup_css_free(). If reclaim_high() is still running, rstat updates
> via mod_lruvec_state() -> __css_rstat_updated() cause a use-after-free
> on the per-CPU rstat data. This was introduced when commit 5da3bfa029d6
> ("cgroup: use separate rstat trees for each subsystem") moved
> css_rstat_exit() ahead of ss->css_free().
> 
> Fix both problems by acquiring a reference with css_tryget_online() in
> high_work_func() before calling reclaim_high(), and by resetting
> memory.high and swap.high to PAGE_COUNTER_MAX in
> mem_cgroup_css_offline() so that charges via references on an offlined
> memcg do not trigger high_work on the dead child and skip checking live
> ancestors in try_charge_memcg().
> 
> Acquiring the reference in high_work_func() rather than before
> scheduling high_work is safe because mem_cgroup_css_free() calls
> irq_work_sync() and cancel_work_sync() which cancels pending work and
> waits for an already running high_work_func() to complete before
> mem_cgroup_free() frees the memcg. css_tryget_online() uses
> percpu_ref_tryget_live() and is safe to call after percpu_ref_exit()
> before the cgroup is freed unlike css_tryget().
> 
> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN NOPTI
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> CPU: 1 UID: 0 PID: 27 Comm: kworker/1:0 Tainted: G    B   W           7.3.0-rc5-g2bba28e98578 #284 PREEMPT(full)
> Tainted: [B]=BAD_PAGE, [W]=WARN  <-- Taint from lru_gen_rotate_memcg() VM_WARN_ON_ONCE
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
> Fixes: 5da3bfa029d6 ("cgroup: use separate rstat trees for each subsystem")
> Cc: stable@vger.kernel.org
> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> Reviewed-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Muchun Song <muchun.song@linux.dev>

Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!

-- 
Michal Hocko
SUSE Labs
