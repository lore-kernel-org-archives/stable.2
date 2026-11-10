Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272148;
	b=zwqq/CpWf0/dlgNesTXJD1rthfwxEHKz0nZEVIh+J7RLdJhoffy48eLaPea/pnoyt+hv
	 nZsiwOKTko5eSshKnlrzHhn3sGezNvse0q+wdnWmZR/tMzWJOJckkZ0qPH4uW6XvGoUVT
	 G7KupjYtfeMc0O2H+zwmP6EDElwWQRaI4EFXOQyjDEsfWzes3ZphEtCr6C1cuA6eRqTj9
	 9Lv1fRmiCcx7q92J4puUMq36k4E8/oaBc8lhcc0nRWlecYR02NghpgVUo6HoJo6jZQFUL
	 V2BCqskhKnT86PYqi/bpFX5I8kAyAE7HiNGuWgrQXfLNz38TpZYHcdqrjuAcDdtZ6Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272148;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=tCP/BC0jUaw6Y5fj0yPnd1o00wgvXnuPjFl02415l9k=;
	b=RwITu3n6ja+6w1bbDkIPBFp4+b3XPcOH2ySoyKdsoDIUsTX5GwKdijOwFT3RZrqLYYm6
	 ojAEfz71sApbfzLvzzNdj0i102jtrtSUBGD7Qkt5ase4WjQB+hJObjsGgRX+75UiwWWfb
	 UfKPM6Ekywbiiqingzm8OQXQUheUHmKQJj810IuUbyEvXZQUjmG1BgtSDvnKtCkDNDe/U
	 cOHAEjgVqLTYVIZ1sZdZk1R5arDHrxcBuYMaXb3JhgHt02uYnmA/OB5Nw2sRfynSk1hmY
	 K+jBCcyk+kcyMsgIYB0nd/+2WAKwyRjsZZDDnYFEsyJXCQGYNvdTR6mIIlUt8inyh+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XNiuUceq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70038606A31C;
	Tue, 10 Nov 2026 00:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XNiuUceq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6181F1F0089F;
	Tue, 10 Nov 2026 00:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272148;
	bh=tCP/BC0jUaw6Y5fj0yPnd1o00wgvXnuPjFl02415l9k=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=XNiuUceqk3L2p2KPKQklGQdAjkJTVzA6TAqtL4PcxVJ4vR8kt0jwE4o08ziwbC+Zr
	 11axFoSob/OPEzGeMnjHePbwlBYdEq4pQuQ3KdTzNlvWSQoCRfaOyPYFmozwgiwtUB
	 tyU0vacGeKJ3Vy1ooOxIU531K599yBCXxRtcf4lY+chsmQ/uAeClwAO6KwSF+4yYhc
	 /U31QxkSgno7L5T8B1M3kyov2f/ek3uf/X30QbZ+JD4xjXY/xcB1SnLknHKXN47bpu
	 /dG66PiinK5FHFOnCUbK4p97Gkmgzx8ekdZhKnLubFpjEGw+vaEEeyT1od9COSrWrd
	 xSNI3b0zGXkQQ==
Date: Mon, 9 Nov 2026 16:55:45 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
cc: jgross@suse.com, sstabellini@kernel.org, oleksandr_tyshchenko@epam.com, 
    boris.ostrovsky@oracle.com, xen-devel@lists.xenproject.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] xen/pvcalls: unwind pvcalls_new_active_socket() step
 by step
In-Reply-To: <20261109122324.30134-2-yhlee@isslab.korea.ac.kr>
Message-ID: <ce00c906-e984-4363-a2cf-447d21339a67@kernel.org>
References: <20261109122324.30134-1-yhlee@isslab.korea.ac.kr> <20261109122324.30134-2-yhlee@isslab.korea.ac.kr>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 9 Nov 2026, Yehyeong Lee wrote:
> Every error path in pvcalls_new_active_socket() jumps to one shared label
> that does list_del(&map->list) and then hands map to
> pvcalls_back_release_active().  But map comes from kzalloc() and its
> list_head is only published at the very end of the function, after the last
> of those jumps:
> 
> 	down(&fedata->socket_lock);
> 	list_add_tail(&map->list, &fedata->socket_mappings);
> 	up(&fedata->socket_lock);
> 
> so on the error path map->list is still {NULL, NULL} and __list_del()
> writes through a NULL pointer.
> 
> A frontend gets there with one value it owns: the ring_order field of the
> page it granted.  Anything above MAX_RING_ORDER takes the second goto, and
> nothing else in the function has run by then.
> 
> The result is an oops in whichever context handled the request - the
> pvcalls-back threaded IRQ handler for PVCALLS_CONNECT, mappass->wq for
> PVCALLS_ACCEPT - and because it happens after down(&fedata->socket_lock)
> that semaphore is never released, so every later operation on the frontend
> blocks on it and the backend never completes backend_disconnect().  (With
> CONFIG_DEBUG_LIST the list_del() only reports and returns, and
> pvcalls_back_release_active() then runs on a map whose irq is still 0 and
> whose bytes, ioworker.wq and saved_data_ready are all NULL.)
> 
> A frontend asking for ring_order 5, on a dom0 built with KASAN
> (the request was issued by a test-only change to the frontend):
> 
> [  133.728877] pvcalls_new_active_socket frontend requested ring_order 5, which is > MAX (4)
> [  133.732868] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] SMP KASAN NOPTI
> [  133.737910] KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
> [  133.741666] CPU: 0 UID: 0 PID: 133 Comm: irq/39-pvcalls- Not tainted 7.3.0-kCTLblk2-15482-g21a7f44fd076-dirty #1 PREEMPT(full)
> [  133.746986] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [  133.751512] RIP: 0010:pvcalls_new_active_socket+0x821/0xb90
> [  133.754237] Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 f6 01 00 00 48 8d 79 08 4c 8b 6b 08 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 14 02 00 00 4c 89 ea 4c 89 69 08 48 b8 00 00 00
> [  133.763126] RSP: 0018:ffffc900004afb38 EFLAGS: 00010202
> [  133.765861] RAX: dffffc0000000000 RBX: ffff88810886c900 RCX: 0000000000000000
> [  133.769348] RDX: 0000000000000001 RSI: 0000000000000246 RDI: 0000000000000008
> [  133.772787] RBP: 1ffff92000095f6b R08: 0000000000000001 R09: fffff52000095f58
> [  133.776260] R10: 0000000000000003 R11: ffff888100077320 R12: ffff88810858b410
> [  133.779823] R13: 0000000000000000 R14: ffff88810858b460 R15: ffff88810858b400
> [  133.783382] FS:  0000000000000000(0000) GS:ffff8881b034c000(0000) knlGS:0000000000000000
> [  133.787351] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  133.790308] CR2: 00000000006042c0 CR3: 0000000108400001 CR4: 0000000000770ef0
> [  133.793822] PKRU: 55555554
> [  133.795347] Call Trace:
> [  133.796778]  <TASK>
> [  133.798082]  ? __pfx_pvcalls_new_active_socket+0x10/0x10
> [  133.800801]  ? security_socket_post_create+0x4d/0x60
> [  133.803275]  ? release_sock+0x1a/0x1d0
> [  133.805182]  pvcalls_back_event+0x1b09/0x23e0
> [  133.807431]  ? __pfx_pvcalls_back_event+0x10/0x10
> [  133.809814]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
> [  133.812251]  ? __pfx_pvcalls_back_event+0x10/0x10
> [  133.814554]  irq_thread_fn+0x86/0x150
> [  133.816468]  irq_thread+0x2da/0x580
> [  133.818363]  ? __pfx_irq_thread_fn+0x10/0x10
> [  133.820586]  ? __pfx_irq_thread+0x10/0x10
> [  133.822670]  ? __kthread_parkme+0x88/0x170
> [  133.824803]  ? __pfx_irq_thread+0x10/0x10
> [  133.827153]  ? __pfx_irq_thread+0x10/0x10
> [  133.829304]  kthread+0x2c8/0x3b0
> [  133.831176]  ? recalc_sigpending+0x15c/0x1e0
> [  133.833570]  ? __pfx_kthread+0x10/0x10
> [  133.835572]  ret_from_fork+0x373/0x5b0
> [  133.837581]  ? __pfx_ret_from_fork+0x10/0x10
> [  133.839978]  ? __switch_to+0x3c4/0xb40
> [  133.841984]  ? __pfx_kthread+0x10/0x10
> [  133.843970]  ret_from_fork_asm+0x1a/0x30
> [  133.846031]  </TASK>
> [  133.847420] Modules linked in:
> [  133.849240] ---[ end trace 0000000000000000 ]---
> 
> Give each failure its own label, so that only resources that were actually
> acquired are released and the list the map was never added to is left
> alone.  The map is not published anywhere at that point, so the error path
> needs no socket_lock at all.  sock_release() stays in the callee on every
> error path, the way
> commit 8fafac202d18 ("xen/pvcalls-back: fix double frees with pvcalls_new_active_socket()")
> arranged it.
> 
> Fixes: 5db4d286a8ef ("xen/pvcalls: implement connect command")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>

